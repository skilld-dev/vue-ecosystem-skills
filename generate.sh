#!/usr/bin/env bash
set -euo pipefail

MODEL="sonnet"
EJECT_DIR="./skills"
SKILLD="npx -y skilld@latest"
REFS_ONLY=false
REFS_AND_REGEN=false

PACKAGES=(
  # Core
  vue@beta
  vue-router
  pinia

#  # Build & Test
  "@vue/test-utils"
#
#  # State & Data
  "@tanstack/vue-query"
  "@tanstack/vue-table"
  "@tanstack/vue-form"
  "@tanstack/vue-router"
  "@tanstack/vue-virtual"
  "@tanstack/vue-store"
  "@tanstack/ai-vue"
  "@pinia/colada"
#
#  # Utilities
  @unhead/vue
  vue-i18n
#
#  # UI
  reka-ui
  primevue
  vuetify@next
  motion-v
  shadcn-vue
  quasar
#
#  # Forms
  vee-validate
  "@formkit/core"
#
#  # Presentations & Docs
  "@slidev/cli"
  vitepress
#
#  # 3D
  "@tresjs/core"
#
#  # VueUse
  "@vueuse/core"
  "@vueuse/shared"
  "@vueuse/components"
  "@vueuse/integrations"
  "@vueuse/math"
  "@vueuse/motion"

  # charts
  @unovis/ts
  @unovis/vue
  vue-data-ui
  @floating-ui/vue
)

# Parse flags
POSITIONAL=()
for arg in "$@"; do
  case "$arg" in
    --refs-only)
      REFS_ONLY=true
      ;;
    --refs-and-regen)
      REFS_AND_REGEN=true
      REFS_ONLY=true  # refs-and-regen implies refs-only behavior as baseline
      ;;
    *)
      POSITIONAL+=("$arg")
      ;;
  esac
done

# Explicit packages mode: ./generate.sh @vueuse/math @tanstack/vue-query quasar
EXPLICIT=false
if [ ${#POSITIONAL[@]} -gt 0 ]; then
  PACKAGES=("${POSITIONAL[@]}")
  EXPLICIT=true
fi

# Compute skill dir name matching skilld's computeSkillDirName()
skill_dir_name() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9._]/-/g; s/^[.\-]*//; s/[.\-]*$//' | head -c 255
}

# Stamp references_synced_at in SKILL.md frontmatter
stamp_synced_at() {
  local skill_md="$1"
  local sync_date
  sync_date=$(date -u +%Y-%m-%d)

  if grep -q "references_synced_at:" "$skill_md"; then
    sed -i "s/references_synced_at: .*/references_synced_at: $sync_date/" "$skill_md"
  else
    sed -i "/generated_at:/a\\  references_synced_at: $sync_date" "$skill_md"
  fi
}

# Extract version from SKILL.md frontmatter
extract_version() {
  sed -n '/^---$/,/^---$/{ s/^  version: *//p; }' "$1"
}

# Extract body from ## API Changes onward
extract_body() {
  sed -n '/^## API Changes/,$p' "$1"
}

# Compare semver: returns major, minor, patch, or none
semver_change() {
  local old="$1" new="$2"
  [ "$old" = "$new" ] && echo "none" && return

  local old_major old_minor old_patch new_major new_minor new_patch
  # Strip leading v, strip prerelease suffixes for comparison
  old_major=$(echo "$old" | sed 's/^v//' | cut -d. -f1)
  old_minor=$(echo "$old" | sed 's/^v//' | cut -d. -f2)
  old_patch=$(echo "$old" | sed 's/^v//' | cut -d. -f3 | sed 's/[^0-9].*//')
  new_major=$(echo "$new" | sed 's/^v//' | cut -d. -f1)
  new_minor=$(echo "$new" | sed 's/^v//' | cut -d. -f2)
  new_patch=$(echo "$new" | sed 's/^v//' | cut -d. -f3 | sed 's/[^0-9].*//')

  if [ "$old_major" != "$new_major" ]; then
    echo "major"
  elif [ "$old_minor" != "$new_minor" ]; then
    echo "minor"
  elif [ "$old_patch" != "$new_patch" ]; then
    echo "patch"
  else
    echo "none"
  fi
}

# Merge new header (everything before ## API Changes) with old body
merge_skill_md() {
  local new_file="$1" old_body="$2"
  local header
  # Extract everything before ## API Changes from the new file
  header=$(sed '/^## API Changes/,$d' "$new_file")
  printf '%s\n%s\n' "$header" "$old_body" > "$new_file"
}

total=${#PACKAGES[@]}
current=0
failed=()
regenerated=()

echo "Skill Version: $($SKILLD --version)"
if [ "$REFS_AND_REGEN" = true ]; then
  echo "Syncing references for $total skills (LLM regen on minor/major bumps)"
elif [ "$REFS_ONLY" = true ]; then
  echo "Syncing references for $total skills (no LLM, SKILL.md body preserved)"
else
  echo "Generating $total skills with model=$MODEL"
fi
echo "Output: $EJECT_DIR"
echo "---"

# Delete old output for explicit packages so we get a clean regeneration (skip in refs-only mode)
if [ "$EXPLICIT" = true ] && [ "$REFS_ONLY" = false ]; then
  for pkg in "${PACKAGES[@]}"; do
    # Strip version suffix (e.g. vue@beta -> vue, vuetify@next -> vuetify)
    bare=$(echo "$pkg" | sed 's/@[^/]*$//')
    dir_name="$(skill_dir_name "$bare")-skilld"
    target="$EJECT_DIR/$dir_name"
    if [ -d "$target" ]; then
      echo "Removing $target"
      rm -rf "$target"
    fi
  done
  echo "---"
fi

for pkg in "${PACKAGES[@]}"; do
  current=$((current + 1))

  bare=$(echo "$pkg" | sed 's/@[^/]*$//')
  dir_name="$(skill_dir_name "$bare")-skilld"
  skill_path="$EJECT_DIR/$dir_name"
  skill_md="$skill_path/SKILL.md"

  # Skip pre-generated skills in default full-generation mode
  if [ "$EXPLICIT" = false ] && [ "$REFS_ONLY" = false ]; then
    if [ -d "$skill_path" ]; then
      echo "[$current/$total] $pkg (skipped — already exists)"
      echo ""
      continue
    fi
  fi

  # In refs-only mode, skip packages that don't have an existing skill dir
  if [ "$REFS_ONLY" = true ] && [ ! -d "$skill_path" ]; then
    echo "[$current/$total] $pkg (skipped — no existing skill)"
    echo ""
    continue
  fi

  echo "[$current/$total] $pkg"

  if [ "$REFS_ONLY" = true ]; then
    # --- refs-only / refs-and-regen path ---
    # 1. Backup SKILL.md
    cp "$skill_md" "$skill_md.bak"
    old_ver=$(extract_version "$skill_md.bak")
    old_body=$(extract_body "$skill_md.bak")

    # 2. Run skilld eject without --model (syncs refs + header)
    eject_args=("$pkg" --out "$EJECT_DIR" --yes --debug --no-search)
    if ! $SKILLD eject "${eject_args[@]}"; then
      echo "  ✗ $pkg (failed)"
      # Restore backup on failure
      mv "$skill_md.bak" "$skill_md"
      failed+=("$pkg")
      echo ""
      continue
    fi

    new_ver=$(extract_version "$skill_md")
    change=$(semver_change "$old_ver" "$new_ver")

    # 3. Decide: LLM regen or merge
    if [ "$REFS_AND_REGEN" = true ] && { [ "$change" = "major" ] || [ "$change" = "minor" ]; }; then
      echo "  ↑ $old_ver → $new_ver ($change bump) — regenerating with LLM"
      if $SKILLD eject "$pkg" --out "$EJECT_DIR" --yes --force --model "$MODEL" --debug --no-search; then
        regenerated+=("$pkg ($old_ver → $new_ver)")
        echo "  ✓ $pkg (regenerated)"
      else
        echo "  ✗ $pkg (LLM regen failed, restoring backup)"
        mv "$skill_md.bak" "$skill_md"
        failed+=("$pkg")
        echo ""
        continue
      fi
    else
      # Merge: new header + old body
      if [ -n "$old_body" ]; then
        merge_skill_md "$skill_md" "$old_body"
        echo "  ✓ $pkg (refs updated, body preserved)"
      else
        echo "  ✓ $pkg (refs updated, no body to preserve)"
      fi
    fi

    stamp_synced_at "$skill_md"
    rm -f "$skill_md.bak"
  else
    # --- full generation path ---
    eject_args=("$pkg" --out "$EJECT_DIR" --yes --force --model "$MODEL" --debug --no-search)
    if $SKILLD eject "${eject_args[@]}"; then
      echo "  ✓ $pkg"
    else
      echo "  ✗ $pkg (failed)"
      failed+=("$pkg")
    fi
  fi

  echo ""
done

echo "=== Done ==="
if [ "$REFS_ONLY" = true ]; then
  echo "Synced: $((total - ${#failed[@]}))/$total"
else
  echo "Generated: $((total - ${#failed[@]}))/$total"
fi

if [ ${#regenerated[@]} -gt 0 ]; then
  echo "Regenerated (LLM):"
  for item in "${regenerated[@]}"; do
    echo "  - $item"
  done
fi

if [ ${#failed[@]} -gt 0 ]; then
  echo "Failed:"
  for pkg in "${failed[@]}"; do
    echo "  - $pkg"
  done
  exit 1
fi
