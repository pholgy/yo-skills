#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
source_root="$repo_root/skills"
install_home="${HOME}"
requested_targets=()
include_claude_hook=false

usage() {
  cat <<'EOF'
Usage: ./verify.sh [--target auto|all|codex|claude|agents] [--home PATH] [--include-claude-hook]

Repeat --target to verify more than one explicit host.
--include-claude-hook compares both installed optional hook files with the
repository. It requires claude to be one of the selected targets.
Default: --target auto
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      [[ $# -ge 2 ]] || { echo "Missing value for --target" >&2; exit 2; }
      requested_targets+=("$2")
      shift 2
      ;;
    --home)
      [[ $# -ge 2 ]] || { echo "Missing value for --home" >&2; exit 2; }
      install_home="$2"
      shift 2
      ;;
    --include-claude-hook)
      include_claude_hook=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if [[ ${#requested_targets[@]} -eq 0 ]]; then
  requested_targets=(auto)
fi
[[ -d "$install_home" ]] || { echo "Install home does not exist: $install_home" >&2; exit 1; }
install_home="$(cd "$install_home" && pwd -P)"

skill_names=()
for skill_dir in "$source_root"/yo-*; do
  [[ -d "$skill_dir" ]] || continue
  skill_names+=("$(basename "$skill_dir")")
done
[[ ${#skill_names[@]} -eq 19 ]] || { echo "Expected 19 source skills." >&2; exit 1; }

selected_targets=()
add_target() {
  local candidate="$1"
  local existing
  for existing in "${selected_targets[@]:-}"; do
    [[ "$existing" == "$candidate" ]] && return
  done
  selected_targets+=("$candidate")
}

has_auto=false
has_all=false
for target in "${requested_targets[@]}"; do
  target="$(printf '%s' "$target" | tr '[:upper:]' '[:lower:]')"
  case "$target" in
    auto) has_auto=true ;;
    all) has_all=true ;;
    codex|claude|agents) add_target "$target" ;;
    *) echo "Unknown target: $target" >&2; exit 2 ;;
  esac
done

if [[ "$has_auto" == true && ${#requested_targets[@]} -gt 1 ]]; then
  echo "'auto' cannot be combined with explicit targets." >&2
  exit 2
fi
if [[ "$has_all" == true && ${#requested_targets[@]} -gt 1 ]]; then
  echo "'all' cannot be combined with other targets." >&2
  exit 2
fi

if [[ "$has_all" == true ]]; then
  selected_targets=()
  add_target codex
  add_target claude
  add_target agents
elif [[ "$has_auto" == true ]]; then
  selected_targets=()
  [[ -d "$install_home/.codex/skills" ]] && add_target codex
  [[ -d "$install_home/.claude/skills" ]] && add_target claude
  [[ -d "$install_home/.agents/skills" ]] && add_target agents
fi

[[ ${#selected_targets[@]} -gt 0 ]] || { echo "No installed target was detected." >&2; exit 1; }

if [[ "$include_claude_hook" == true ]]; then
  claude_selected=false
  for target in "${selected_targets[@]}"; do
    [[ "$target" == claude ]] && claude_selected=true
  done
  if [[ "$claude_selected" == false ]]; then
    echo "--include-claude-hook requires claude to be one of the selected targets." >&2
    exit 2
  fi
fi

target_path() {
  case "$1" in
    codex) printf '%s\n' "$install_home/.codex/skills" ;;
    claude) printf '%s\n' "$install_home/.claude/skills" ;;
    agents) printf '%s\n' "$install_home/.agents/skills" ;;
  esac
}

verify_tree() {
  local expected="$1"
  local actual="$2"
  local expected_count=0
  local actual_count
  local file relative

  [[ -d "$actual" ]] || return 1
  while IFS= read -r -d '' file; do
    relative="${file#"$expected"/}"
    [[ -f "$actual/$relative" ]] || return 1
    cmp -s "$file" "$actual/$relative" || return 1
    expected_count=$((expected_count + 1))
  done < <(find "$expected" -type f -print0)
  actual_count="$(find "$actual" -type f | wc -l | tr -d '[:space:]')"
  [[ "$expected_count" -eq "$actual_count" ]]
}

failed=false
printf 'Verifying Yo Skills\n'
for host in "${selected_targets[@]}"; do
  target_root="$(target_path "$host")"
  matching=0
  mismatches=()
  for name in "${skill_names[@]}"; do
    if verify_tree "$source_root/$name" "$target_root/$name"; then
      matching=$((matching + 1))
    else
      mismatches+=("$name")
      failed=true
    fi
  done
  printf '  %-7s  %s/19 matching  %s\n' "$host" "$matching" "$target_root"
  if [[ ${#mismatches[@]} -gt 0 ]]; then
    printf '           mismatches: %s\n' "${mismatches[*]}"
  fi
done

if [[ "$include_claude_hook" == true ]]; then
  hook_target_root="$install_home/.claude/hooks"
  hook_names=(yo-claude-baseline.ps1 yo-claude-baseline.sh)
  matching_hooks=0
  hook_mismatches=()
  for name in "${hook_names[@]}"; do
    if [[ -f "$hook_target_root/$name" && ! -L "$hook_target_root/$name" ]] &&
       cmp -s "$repo_root/hooks/$name" "$hook_target_root/$name"; then
      matching_hooks=$((matching_hooks + 1))
    else
      hook_mismatches+=("$name")
      failed=true
    fi
  done
  printf '  %-7s  %s/%s matching  %s\n' hooks "$matching_hooks" "${#hook_names[@]}" "$hook_target_root"
  if [[ ${#hook_mismatches[@]} -gt 0 ]]; then
    printf '           mismatches: %s\n' "${hook_mismatches[*]}"
  fi
fi

if [[ "$failed" == true ]]; then
  echo 'Yo Skills verification failed.' >&2
  exit 1
fi

echo 'Yo Skills verification passed.'
