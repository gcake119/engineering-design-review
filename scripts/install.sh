#!/usr/bin/env bash
set -euo pipefail

script_source="${BASH_SOURCE:-}"
if [[ -n "${script_source}" ]]; then
  repo_root="$(cd "$(dirname "${script_source}")/.." && pwd)"
else
  repo_root="$(pwd)"
fi
skill_name="engineering-design-review"
source_dir="${repo_root}/skills/${skill_name}"
target_root="${CODEX_HOME:-${HOME}/.codex}/skills"
target_dir="${target_root}/${skill_name}"
repo_url="https://github.com/gcake119/engineering-design-review"
archive_url="${repo_url}/archive/refs/heads/main.tar.gz"
tmp_dir=""

if [[ ! -d "${source_dir}" ]]; then
  if ! command -v curl >/dev/null 2>&1; then
    echo "curl is required for remote installation." >&2
    exit 1
  fi

  if ! command -v tar >/dev/null 2>&1; then
    echo "tar is required for remote installation." >&2
    exit 1
  fi

  tmp_dir="$(mktemp -d)"
  trap '[[ -n "${tmp_dir}" ]] && rm -rf "${tmp_dir}"' EXIT

  echo "Downloading ${repo_url}..."
  curl -fsSL "${archive_url}" | tar -xz -C "${tmp_dir}"
  source_dir="${tmp_dir}/engineering-design-review-main/skills/${skill_name}"

  if [[ ! -d "${source_dir}" ]]; then
    echo "Skill source not found after download: ${source_dir}" >&2
    exit 1
  fi
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
