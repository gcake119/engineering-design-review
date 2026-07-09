#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skill_name="engineering-design-review"
source_dir="${repo_root}/skills/${skill_name}"
target_root="${CODEX_HOME:-${HOME}/.codex}/skills"
target_dir="${target_root}/${skill_name}"

if [[ ! -d "${source_dir}" ]]; then
  echo "Skill source not found: ${source_dir}" >&2
  exit 1
fi

mkdir -p "${target_root}"

if [[ -e "${target_dir}" ]]; then
  timestamp="$(date +%Y%m%d-%H%M%S)"
  backup_dir="${target_dir}.backup.${timestamp}"
  mv "${target_dir}" "${backup_dir}"
  echo "Backed up existing skill to ${backup_dir}"
fi

cp -R "${source_dir}" "${target_dir}"
echo "Installed ${skill_name} to ${target_dir}"
echo "Restart Codex to load the skill."
