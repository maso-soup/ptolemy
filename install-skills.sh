#!/usr/bin/env bash
#
# install-skills.sh — build .claude/skills/ from the authored source in ptolemy-skills/
#
# The git repo only ever stores the authored source (ptolemy-skills/<family>/<skill>/SKILL.md).
# This script flattens it into the layout the Claude Code / Agent SDK skill loader expects:
#   .claude/skills/<name>/SKILL.md          (<name> = the frontmatter `name:`, globally unique)
# It copies the WHOLE skill directory, so any future reference/asset files travel with the skill.
#
# Safe & idempotent: it records what it installed in a manifest and, on re-run, only ever
# refreshes/prunes skills IT installed — it never touches unrelated skills you added by hand.
#
# Usage:
#   ./install-skills.sh [options] [TARGET_DIR]
#
# Options:
#   --target DIR   Where to install (default: <cwd>/.claude/skills)
#   --source DIR   Authored source (default: <script dir>/ptolemy-skills)
#   --link         Symlink each skill to the source instead of copying (edits reflect live)
#   --copy         Copy each skill (default)
#   --dry-run      Print what would happen, change nothing
#   --force        Overwrite an existing skill dir even if this installer didn't create it
#   --uninstall    Remove only the skills this installer previously created, then exit
#   -h, --help     Show this help
#
# Compatible with bash 3.2 (stock macOS) and newer.
#
set -euo pipefail

# --- resolve this script's own directory (follow symlinks) ---
_src="${BASH_SOURCE[0]}"
while [ -h "$_src" ]; do
  _dir="$(cd -P "$(dirname "$_src")" && pwd)"
  _src="$(readlink "$_src")"
  case "$_src" in /*) : ;; *) _src="$_dir/$_src";; esac
done
SCRIPT_DIR="$(cd -P "$(dirname "$_src")" && pwd)"

SRC="$SCRIPT_DIR/ptolemy-skills"
TARGET="$PWD/.claude/skills"
MODE="copy"
DRY=0
FORCE=0
ACTION="install"
MANIFEST_NAME=".ptolemy-skills-manifest"

usage() {
  # print the leading comment block (from line 2 until the first non-# line), stripping "# "
  awk 'NR==1{next} /^#/{sub(/^# ?/,""); print; next} {exit}' "$0"
  exit "${1:-0}"
}

# --- parse args ---
while [ $# -gt 0 ]; do
  case "$1" in
    --target) TARGET="${2:?--target needs a dir}"; shift 2;;
    --source) SRC="${2:?--source needs a dir}"; shift 2;;
    --link)   MODE="link"; shift;;
    --copy)   MODE="copy"; shift;;
    --dry-run|-n) DRY=1; shift;;
    --force)  FORCE=1; shift;;
    --uninstall) ACTION="uninstall"; shift;;
    -h|--help) usage 0;;
    -*) echo "unknown option: $1" >&2; usage 1;;
    *)  TARGET="$1"; shift;;
  esac
done

# absolutize paths (no side effects)
case "$TARGET" in /*) : ;; *) TARGET="$PWD/$TARGET";; esac
case "$SRC"    in /*) : ;; *) SRC="$PWD/$SRC";; esac
MANIFEST="$TARGET/$MANIFEST_NAME"

say() { printf '%s\n' "$*"; }
run() { if [ "$DRY" -eq 1 ]; then say "  [dry-run] $*"; else eval "$*"; fi; }
read_name() { awk -F': ' '/^name:/{sub(/[[:space:]]+$/,"",$2); print $2; exit}' "$1"; }

TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
OLDF="$TMP/old"; NAMES="$TMP/names.tsv"; SRC_NAMES="$TMP/src_names"; NEWF="$TMP/new"
: > "$OLDF"; : > "$NAMES"; : > "$NEWF"
[ -f "$MANIFEST" ] && grep -v '^#' "$MANIFEST" | sed '/^$/d' > "$OLDF" || true

# ---------------- uninstall ----------------
if [ "$ACTION" = "uninstall" ]; then
  say "Uninstalling skills previously installed by this tool from: $TARGET"
  n=0
  while IFS= read -r name; do
    [ -n "$name" ] || continue
    if [ -e "$TARGET/$name" ] || [ -L "$TARGET/$name" ]; then
      run "rm -rf \"$TARGET/$name\""; n=$((n+1))
    fi
  done < "$OLDF"
  run "rm -f \"$MANIFEST\""
  say "Removed $n skill(s). Unmanaged skills were left untouched."
  exit 0
fi

# ---------------- install ----------------
[ -d "$SRC" ] || { echo "ERROR: source not found: $SRC" >&2; exit 1; }

# build "name<TAB>dir" for every skill (excluding the template)
find "$SRC" -name SKILL.md -not -path '*/_TEMPLATE/*' | sort | while IFS= read -r f; do
  printf '%s\t%s\n' "$(read_name "$f")" "$(dirname "$f")"
done > "$NAMES"

[ -s "$NAMES" ] || { echo "ERROR: no SKILL.md files under $SRC" >&2; exit 1; }

# validate: no empty/placeholder names
if awk -F'\t' '$1=="" || $1=="skill-name-kebab"{print "  bad name in: " $2 "/SKILL.md"}' "$NAMES" | grep .; then
  echo "ERROR: skill(s) with missing/placeholder name (above)." >&2; exit 1
fi
# validate: no duplicate names (flattening must be collision-free)
dups="$(cut -f1 "$NAMES" | sort | uniq -d)"
if [ -n "$dups" ]; then
  echo "ERROR: duplicate skill name(s):" >&2
  printf '%s\n' "$dups" | while IFS= read -r d; do
    echo "  $d:" >&2; awk -F'\t' -v d="$d" '$1==d{print "    " $2 "/SKILL.md"}' "$NAMES" >&2
  done
  exit 1
fi

cut -f1 "$NAMES" | sort -u > "$SRC_NAMES"
in_source()  { grep -qxF "$1" "$SRC_NAMES"; }
is_tracked() { grep -qxF "$1" "$OLDF"; }

total="$(wc -l < "$NAMES" | tr -d ' ')"
say "Source : $SRC"
say "Target : $TARGET"
say "Mode   : $MODE$( [ "$DRY" -eq 1 ] && echo '  (dry-run)')"
say "Skills : $total"
say ""
run "mkdir -p \"$TARGET\""

installed=0; skipped=0
# install loop in the current shell (process substitution keeps counters)
while IFS="$(printf '\t')" read -r name dir; do
  [ -n "$name" ] || continue
  dest="$TARGET/$name"
  if { [ -e "$dest" ] || [ -L "$dest" ]; } && ! is_tracked "$name" && [ "$FORCE" -eq 0 ]; then
    say "SKIP (exists, not managed by installer; use --force): $name"
    skipped=$((skipped+1)); continue
  fi
  run "rm -rf \"$dest\""
  if [ "$MODE" = "link" ]; then
    run "ln -s \"$dir\" \"$dest\""
  else
    run "mkdir -p \"$dest\" && cp -R \"$dir/.\" \"$dest/\""
  fi
  printf '%s\n' "$name" >> "$NEWF"
  installed=$((installed+1))
done < <(sort -t"$(printf '\t')" -k1,1 "$NAMES")

# prune: skills we installed before that are gone from source
pruned=0
while IFS= read -r name; do
  [ -n "$name" ] || continue
  if ! in_source "$name" && { [ -e "$TARGET/$name" ] || [ -L "$TARGET/$name" ]; }; then
    say "PRUNE (removed from source): $name"
    run "rm -rf \"$TARGET/$name\""; pruned=$((pruned+1))
  fi
done < "$OLDF"

# write manifest
if [ "$DRY" -eq 0 ]; then
  { echo "# skills installed by install-skills.sh — do not edit; regenerate by re-running"
    echo "# $(date -u +%Y-%m-%dT%H:%M:%SZ)  mode=$MODE  source=$SRC"
    sort -u "$NEWF"
  } > "$MANIFEST"
fi

say ""
say "Done. installed=$installed skipped=$skipped pruned=$pruned"
say "Manifest: $MANIFEST"
[ "$MODE" = "link" ] && say "Note: symlinked — edits to $SRC are reflected live." || true
