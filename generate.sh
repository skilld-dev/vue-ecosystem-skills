#!/usr/bin/env bash
set -euo pipefail

MODEL="${SKILLD_MODEL:-haiku}"
EJECT_DIR="${SKILLD_OUT:-./skills}"
SKILLD="${SKILLD_BIN:-npx -y skilld@latest}"
BATCH_SIZE="${SKILLD_BATCH:-6}"
STALE_DAYS="${SKILLD_STALE_DAYS:-30}"
REFS_ONLY=false
REFS_AND_REGEN=false
CHECK_ONLY=false

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
      REFS_ONLY=true
      ;;
    --check)
      CHECK_ONLY=true
      REFS_ONLY=true
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

# Fetch latest version from npm registry (handles @scope and dist-tags like vue@beta)
npm_latest_version() {
  local pkg="$1"
  # If pkg has a dist-tag suffix (e.g. vue@beta, vuetify@next), use it
  local name tag
  if [[ "$pkg" =~ ^(@[^/]+/[^@]+|[^@]+)@([^/]+)$ ]]; then
    name="${BASH_REMATCH[1]}"
    tag="${BASH_REMATCH[2]}"
  else
    name="$pkg"
    tag="latest"
  fi
  npm view "$name@$tag" version 2>/dev/null || echo ""
}

# Extract references_synced_at from SKILL.md frontmatter
extract_synced_at() {
  sed -n '/^---$/,/^---$/{ s/^  references_synced_at: *//p; }' "$1"
}

# Check if synced_at date is older than STALE_DAYS
is_stale() {
  local synced_at="$1"
  if [ -z "$synced_at" ]; then
    echo "true"
    return
  fi
  local synced_epoch now_epoch diff_days
  synced_epoch=$(date -d "$synced_at" +%s 2>/dev/null || echo 0)
  now_epoch=$(date -u +%s)
  diff_days=$(( (now_epoch - synced_epoch) / 86400 ))
  if [ "$diff_days" -ge "$STALE_DAYS" ]; then
    echo "true"
  else
    echo "false"
  fi
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
failed=()
regenerated=()

echo "Skill Version: $($SKILLD --version)"
if [ "$CHECK_ONLY" = true ]; then
  echo "Checking $total skills for version bumps (dry run, batch=$BATCH_SIZE)"
elif [ "$REFS_AND_REGEN" = true ]; then
  echo "Syncing references for $total skills (LLM regen on minor/major bumps, batch=$BATCH_SIZE)"
elif [ "$REFS_ONLY" = true ]; then
  echo "Syncing references for $total skills (no LLM, SKILL.md body preserved, batch=$BATCH_SIZE)"
else
  echo "Generating $total skills with model=$MODEL (batch=$BATCH_SIZE)"
fi
echo "Output: $EJECT_DIR"
echo "---"

# Delete old output for explicit packages so we get a clean regeneration (skip in refs-only mode)
if [ "$EXPLICIT" = true ] && [ "$REFS_ONLY" = false ]; then
  for pkg in "${PACKAGES[@]}"; do
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

# --- Per-package worker for refs-only/refs-and-regen (pass 1: sync refs, no LLM) ---
sync_refs_worker() {
  local pkg="$1" idx="$2"
  local bare dir_name skill_path skill_md old_ver old_body new_ver change synced_at stale

  bare=$(echo "$pkg" | sed 's/@[^/]*$//')
  dir_name="$(skill_dir_name "$bare")-skilld"
  skill_path="$EJECT_DIR/$dir_name"
  skill_md="$skill_path/SKILL.md"

  if [ ! -d "$skill_path" ]; then
    echo "[$idx/$total] $pkg (skipped, no existing skill)"
    return 0
  fi

  old_ver=$(extract_version "$skill_md")
  synced_at=$(extract_synced_at "$skill_md")
  stale=$(is_stale "$synced_at")

  # Quick check: compare npm registry version against current SKILL.md version
  new_ver=$(npm_latest_version "$pkg")
  if [ -z "$new_ver" ]; then
    echo "[$idx/$total] ✗ $pkg (npm lookup failed)"
    echo "$pkg" >> "$EJECT_DIR/.failed"
    return 0
  fi

  change=$(semver_change "$old_ver" "$new_ver")

  # Skip skilld eject if version unchanged and docs are fresh
  if [ "$change" = "none" ] && [ "$stale" = "false" ]; then
    echo "[$idx/$total] = $pkg $old_ver (up to date, synced $synced_at)"
    return 0
  fi

  # Determine if we actually need to run skilld eject
  local needs_eject=false
  if [ "$change" = "major" ] || [ "$change" = "minor" ] || [ "$change" = "patch" ]; then
    needs_eject=true
  elif [ "$stale" = "true" ]; then
    needs_eject=true
  fi

  if [ "$CHECK_ONLY" = true ]; then
    # Dry run: just report, no eject needed
    if [ "$change" = "major" ] || [ "$change" = "minor" ]; then
      echo "[$idx/$total] ↑ $pkg $old_ver → $new_ver ($change) — needs regen"
      echo "$pkg|$old_ver|$new_ver|$change" >> "$EJECT_DIR/.regen_queue"
    elif [ "$change" = "patch" ]; then
      echo "[$idx/$total] ~ $pkg $old_ver → $new_ver (patch)"
    elif [ "$stale" = "true" ]; then
      echo "[$idx/$total] ⧖ $pkg $old_ver (stale, last synced $synced_at)"
    fi
    return 0
  fi

  # Run skilld eject to sync refs
  if [ "$needs_eject" = true ]; then
    old_body=$(extract_body "$skill_md")
    cp "$skill_md" "$skill_md.bak"

    if ! $SKILLD author eject "$pkg" --out "$EJECT_DIR" --yes --model "$MODEL" --debug --no-search 2>&1; then
      echo "[$idx/$total] ✗ $pkg (ref sync failed)"
      mv "$skill_md.bak" "$skill_md"
      echo "$pkg" >> "$EJECT_DIR/.failed"
      return 0
    fi

    if [ "$REFS_AND_REGEN" = true ] && { [ "$change" = "major" ] || [ "$change" = "minor" ]; }; then
      echo "[$idx/$total] ↑ $pkg $old_ver → $new_ver ($change) — queued for LLM regen"
      echo "$pkg|$old_ver|$new_ver" >> "$EJECT_DIR/.regen_queue"
      rm -f "$skill_md.bak"
    else
      if [ -n "$old_body" ]; then
        merge_skill_md "$skill_md" "$old_body"
        if [ "$stale" = "true" ] && [ "$change" = "none" ]; then
          echo "[$idx/$total] ✓ $pkg $old_ver (refs refreshed, was stale)"
        else
          echo "[$idx/$total] ✓ $pkg (refs updated, body preserved)"
        fi
      else
        echo "[$idx/$total] ✓ $pkg (refs updated)"
      fi
      stamp_synced_at "$skill_md"
      rm -f "$skill_md.bak"
    fi
  fi
}

# --- Per-package worker for full generation ---
generate_worker() {
  local pkg="$1" idx="$2"
  local bare dir_name skill_path

  bare=$(echo "$pkg" | sed 's/@[^/]*$//')
  dir_name="$(skill_dir_name "$bare")-skilld"
  skill_path="$EJECT_DIR/$dir_name"

  if [ "$EXPLICIT" = false ] && [ -d "$skill_path" ]; then
    echo "[$idx/$total] $pkg (skipped, already exists)"
    return 0
  fi

  if $SKILLD author eject "$pkg" --out "$EJECT_DIR" --yes --force --model "$MODEL" --debug --no-search 2>&1; then
    echo "[$idx/$total] ✓ $pkg"
  else
    echo "[$idx/$total] ✗ $pkg (failed)"
    echo "$pkg" >> "$EJECT_DIR/.failed"
  fi
}

export -f skill_dir_name stamp_synced_at extract_version extract_body extract_synced_at semver_change merge_skill_md npm_latest_version is_stale
export -f sync_refs_worker generate_worker
export SKILLD EJECT_DIR MODEL REFS_AND_REGEN REFS_ONLY CHECK_ONLY EXPLICIT STALE_DAYS total

# Clean up temp files
rm -f "$EJECT_DIR/.failed" "$EJECT_DIR/.regen_queue"

# --- Batch execution ---
run_batched() {
  local worker="$1"
  local batch=()
  local idx=0

  for pkg in "${PACKAGES[@]}"; do
    idx=$((idx + 1))
    batch+=("$pkg" "$idx")

    if [ ${#batch[@]} -ge $((BATCH_SIZE * 2)) ] || [ "$idx" -eq "$total" ]; then
      # Launch batch in parallel
      local pids=()
      local i=0
      while [ $i -lt ${#batch[@]} ]; do
        "$worker" "${batch[$i]}" "${batch[$((i + 1))]}" &
        pids+=($!)
        i=$((i + 2))
      done
      # Wait for all in batch
      for pid in "${pids[@]}"; do
        wait "$pid" 2>/dev/null || true
      done
      batch=()
    fi
  done
}

if [ "$CHECK_ONLY" = true ]; then
  echo "Checking versions (parallel, batch=$BATCH_SIZE)..."
  echo "---"
  run_batched sync_refs_worker
elif [ "$REFS_ONLY" = true ]; then
  echo "Pass 1: syncing refs (parallel, batch=$BATCH_SIZE)..."
  echo "---"
  run_batched sync_refs_worker

  # Pass 2: LLM regen for major/minor bumps (sequential)
  if [ "$REFS_AND_REGEN" = true ] && [ -f "$EJECT_DIR/.regen_queue" ]; then
    echo ""
    echo "Pass 2: LLM regen for version bumps..."
    echo "---"
    while IFS='|' read -r pkg old_ver new_ver; do
      echo "Regenerating $pkg ($old_ver → $new_ver) with model=$MODEL"
      if $SKILLD author eject "$pkg" --out "$EJECT_DIR" --yes --force --model "$MODEL" --debug --no-search; then
        regenerated+=("$pkg ($old_ver → $new_ver)")
        echo "  ✓ $pkg (regenerated)"
      else
        echo "  ✗ $pkg (LLM regen failed)"
        failed+=("$pkg")
      fi
      echo ""
    done < "$EJECT_DIR/.regen_queue"
  fi
else
  run_batched generate_worker
fi

# Collect failures from parallel workers
if [ -f "$EJECT_DIR/.failed" ]; then
  while IFS= read -r pkg; do
    failed+=("$pkg")
  done < "$EJECT_DIR/.failed"
fi

echo "=== Done ==="
if [ "$CHECK_ONLY" = true ]; then
  echo "Checked: $((total - ${#failed[@]}))/$total"
  if [ -f "$EJECT_DIR/.regen_queue" ]; then
    count=$(wc -l < "$EJECT_DIR/.regen_queue")
    echo ""
    echo "Skills needing regen ($count):"
    while IFS='|' read -r pkg old_ver new_ver change; do
      echo "  $pkg  $old_ver → $new_ver  ($change)"
    done < "$EJECT_DIR/.regen_queue"
  else
    echo "All skills up to date, no regen needed."
  fi
elif [ "$REFS_ONLY" = true ]; then
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

# Clean up temp files
rm -f "$EJECT_DIR/.failed" "$EJECT_DIR/.regen_queue"

if [ ${#failed[@]} -gt 0 ]; then
  echo "Failed:"
  for pkg in "${failed[@]}"; do
    echo "  - $pkg"
  done
  exit 1
fi
