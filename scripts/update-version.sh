#!/usr/bin/env bash
set -euo pipefail

if [[ $# -eq 1 && ( "$1" == "--help" || "$1" == "-h" ) ]]; then
  echo "Usage: $0 <major|minor|patch>"
  exit 0
fi

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <major|minor|patch>" >&2
  exit 1
fi

case "$1" in
  major|minor|patch) ;;
  *) echo "Usage: $0 <major|minor|patch>" >&2; exit 1 ;;
esac

repo_root="$(cd -- "${BASH_SOURCE[0]%/*}/.." && pwd)"
files=(package.json .claude-plugin/plugin.json .codex-plugin/plugin.json)
contents=()
fields=()
current_version=''
version_field='("version"[[:space:]]*:[[:space:]]*")([^"]*)(")'
version_pattern='^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$'

for file in "${files[@]}"; do
  target="$repo_root/$file"
  if [[ ! -f "$target" || ! -r "$target" || ! -w "$target" ]]; then
    echo "Error: $file must exist and be readable and writable." >&2
    exit 1
  fi

  content=$(<"$target")
  if [[ ! $content =~ $version_field ]]; then
    echo "Error: Missing version in $file." >&2
    exit 1
  fi

  field=${BASH_REMATCH[0]}
  version=${BASH_REMATCH[2]}
  remaining=${content#*"$field"}
  if [[ $remaining =~ $version_field || ! $version =~ $version_pattern ]]; then
    echo "Error: $file must contain exactly one version in major.minor.patch format." >&2
    exit 1
  fi

  if [[ -n $current_version && $version != "$current_version" ]]; then
    echo "Error: Versions differ between manifests. Align them before bumping." >&2
    exit 1
  fi

  current_version=$version
  contents+=("$content")
  fields+=("$field")
done

[[ $current_version =~ $version_pattern ]]
major=${BASH_REMATCH[1]}
minor=${BASH_REMATCH[2]}
patch=${BASH_REMATCH[3]}

case "$1" in
  major) major=$((major + 1)); minor=0; patch=0 ;;
  minor) minor=$((minor + 1)); patch=0 ;;
  patch) patch=$((patch + 1)) ;;
esac
next_version="$major.$minor.$patch"

for index in "${!files[@]}"; do
  content=${contents[$index]}
  field=${fields[$index]}
  replacement=${field/"$current_version"/"$next_version"}
  updated=${content/"$field"/$replacement}
  printf '%s\n' "$updated" > "$repo_root/${files[$index]}"
  printf '%s: %s -> %s\n' "${files[$index]}" "$current_version" "$next_version"
done
