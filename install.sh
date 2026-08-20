#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
source_root="$repo_root/skills"
install_home="${HOME}"
requested_targets=()
install_claude_hook=false

usage() {
  cat <<'EOF'
Usage: ./install.sh [--target auto|all|codex|claude|agents] [--home PATH] [--install-claude-hook]

Repeat --target to install into more than one explicit host.
--install-claude-hook installs both canonical optional hook files after backing
up existing copies. It requires claude to be one of the selected targets and
does not edit ~/.claude/settings.json.
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
    --install-claude-hook)
      install_claude_hook=true
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

mkdir -p "$install_home"
install_home="$(cd "$install_home" && pwd -P)"

skill_names=()
for skill_dir in "$source_root"/yo-*; do
  [[ -d "$skill_dir" ]] || continue
  skill_names+=("$(basename "$skill_dir")")
done
if [[ ${#skill_names[@]} -ne 20 ]]; then
  echo "Expected 20 source skills, found ${#skill_names[@]}." >&2
  exit 1
fi

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
  if [[ -d "$install_home/.codex" ]] || command -v codex >/dev/null 2>&1; then
    add_target codex
  fi
  if [[ -d "$install_home/.claude" ]] || command -v claude >/dev/null 2>&1; then
    add_target claude
  fi
  if [[ -d "$install_home/.agents" ]]; then
    add_target agents
  fi
fi

if [[ ${#selected_targets[@]} -eq 0 ]]; then
  echo "No supported host was detected. Use --target codex, --target claude, or --target all." >&2
  exit 1
fi

if [[ "$install_claude_hook" == true ]]; then
  claude_selected=false
  for target in "${selected_targets[@]}"; do
    [[ "$target" == claude ]] && claude_selected=true
  done
  if [[ "$claude_selected" == false ]]; then
    echo "--install-claude-hook requires claude to be one of the selected targets." >&2
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

stamp="$(date +%Y%m%d-%H%M%S)-$$"
backup_root="$install_home/.yo-skills-backups/$stamp"
staged_root="$backup_root/staged-source"
mkdir -p "$staged_root"

for name in "${skill_names[@]}"; do
  cp -R "$source_root/$name" "$staged_root/$name"
  verify_tree "$source_root/$name" "$staged_root/$name" || {
    echo "Staging verification failed for $name." >&2
    exit 1
  }
done

hook_names=(yo-claude-baseline.ps1 yo-claude-baseline.sh)
staged_hook_root="$backup_root/staged-hooks"
if [[ "$install_claude_hook" == true ]]; then
  mkdir -p "$staged_hook_root"
  for name in "${hook_names[@]}"; do
    [[ -f "$repo_root/hooks/$name" ]] || {
      echo "Missing hook source: $repo_root/hooks/$name" >&2
      exit 1
    }
    cp -p "$repo_root/hooks/$name" "$staged_hook_root/$name"
    cmp -s "$repo_root/hooks/$name" "$staged_hook_root/$name" || {
      echo "Hook staging verification failed for $name." >&2
      exit 1
    }
  done
fi

rollback_target() {
  local host="$1"
  local target_root="$2"
  local old_root="$3"
  local failed_root="$backup_root/failed-$host-install"
  local name

  mkdir -p "$failed_root"
  for name in "${touched_skills[@]}"; do
    if [[ -e "$target_root/$name" ]]; then
      mv "$target_root/$name" "$failed_root/$name"
    fi
    if [[ -e "$old_root/$name" ]]; then
      mv "$old_root/$name" "$target_root/$name"
    fi
  done
}

printf '\nInstalling Yo Skills\n'
for host in "${selected_targets[@]}"; do
  target_root="$(target_path "$host")"
  mkdir -p "$target_root"
  target_root="$(cd "$target_root" && pwd -P)"
  case "$target_root/" in
    "$install_home"/*) ;;
    *) echo "Refusing to install outside the selected home: $target_root" >&2; exit 1 ;;
  esac

  old_root="$backup_root/old-$host-skills"
  mkdir -p "$old_root"
  replaced=0
  install_failed=false
  hook_files=0
  hooks_replaced=0
  hook_target_root="$install_home/.claude/hooks"
  old_hook_root="$backup_root/old-claude-hooks"
  failed_hook_root="$backup_root/failed-claude-hooks"
  touched_skills=()
  touched_hooks=()

  for name in "${skill_names[@]}"; do
    if [[ -e "$target_root/$name" ]]; then
      if ! mv "$target_root/$name" "$old_root/$name"; then
        install_failed=true
        break
      fi
      touched_skills+=("$name")
      replaced=$((replaced + 1))
    else
      touched_skills+=("$name")
    fi
    if ! cp -R "$staged_root/$name" "$target_root/$name"; then
      install_failed=true
      break
    fi
  done

  if [[ "$install_failed" == false ]]; then
    for name in "${skill_names[@]}"; do
      if ! verify_tree "$source_root/$name" "$target_root/$name"; then
        install_failed=true
        break
      fi
    done
  fi

  if [[ "$install_failed" == false && "$install_claude_hook" == true && "$host" == claude ]]; then
    if ! mkdir -p "$hook_target_root" "$old_hook_root"; then
      install_failed=true
    else
      hook_target_root="$(cd "$hook_target_root" && pwd -P)"
      case "$hook_target_root/" in
        "$install_home"/*) ;;
        *) echo "Refusing to install hooks outside the selected home: $hook_target_root" >&2; install_failed=true ;;
      esac
    fi

    if [[ "$install_failed" == false ]]; then
      for name in "${hook_names[@]}"; do
        if [[ -e "$hook_target_root/$name" || -L "$hook_target_root/$name" ]]; then
          # Move the directory entry itself so a user-managed symlink is backed
          # up without following it or writing through it outside install_home.
          if ! mv "$hook_target_root/$name" "$old_hook_root/$name"; then
            install_failed=true
            break
          fi
          hooks_replaced=$((hooks_replaced + 1))
        fi
        touched_hooks+=("$name")
        if ! cp -p "$staged_hook_root/$name" "$hook_target_root/$name"; then
          install_failed=true
          break
        fi
      done
    fi

    if [[ "$install_failed" == false ]]; then
      for name in "${hook_names[@]}"; do
        if ! cmp -s "$repo_root/hooks/$name" "$hook_target_root/$name"; then
          install_failed=true
          break
        fi
      done
    fi

    if [[ "$install_failed" == false ]]; then
      if ! chmod +x "$hook_target_root/yo-claude-baseline.sh"; then
        install_failed=true
      else
        hook_files=${#hook_names[@]}
      fi
    fi
  fi

  if [[ "$install_failed" == true ]]; then
    if [[ ${#touched_hooks[@]} -gt 0 ]]; then
      mkdir -p "$failed_hook_root"
      for name in "${touched_hooks[@]}"; do
        if [[ -e "$hook_target_root/$name" || -L "$hook_target_root/$name" ]]; then
          mv "$hook_target_root/$name" "$failed_hook_root/$name"
        fi
        if [[ -e "$old_hook_root/$name" || -L "$old_hook_root/$name" ]]; then
          mv "$old_hook_root/$name" "$hook_target_root/$name"
        fi
      done
    fi
    rollback_target "$host" "$target_root" "$old_root"
    echo "Installation failed for $host; previous skills and touched hooks were restored." >&2
    exit 1
  fi

  printf '  %-7s  20 installed, %s replaced; %s hooks installed, %s replaced  %s\n' \
    "$host" "$replaced" "$hook_files" "$hooks_replaced" "$target_root"
done

printf '\nBackup: %s\n' "$backup_root"
printf 'Yo Skills installed and verified. Start a fresh host session.\n'
