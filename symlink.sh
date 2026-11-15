#!/usr/bin/env bash
# Link this repository into a home directory without overwriting user files.
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
dest_dir="${1:-$HOME}"
mkdir -p "$dest_dir/.config"

link_if_absent() {
  local source_path="$1" target_path="$2"
  if [[ -L "$target_path" ]]; then
    if [[ "$(readlink "$target_path")" == "$source_path" ]]; then
      return 0
    fi
  fi
  if [[ -e "$target_path" || -L "$target_path" ]]; then
    printf 'Keeping existing path: %s\n' "$target_path" >&2
    return 0
  fi
  ln -s "$source_path" "$target_path"
  printf 'Linked %s -> %s\n' "$target_path" "$source_path"
}

shopt -s dotglob nullglob
for source_path in "$repo_dir"/*; do
  name="${source_path##*/}"
  case "$name" in
    .config|.git|.gitignore|symlink.sh|README.md) continue ;;
  esac
  link_if_absent "$source_path" "$dest_dir/$name"
done
for source_path in "$repo_dir"/.config/*; do
  link_if_absent "$source_path" "$dest_dir/.config/${source_path##*/}"
done
