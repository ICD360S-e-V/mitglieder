#!/usr/bin/env bash
# Shared helper: emits per-platform version_mitglieder_*.json files used by
# the in-app updater. Sourced by both release-priority and release-secondary
# so each adds only the platform manifests it has assets for, on the same
# GitHub Release tag.
#
# Usage:
#   source .github/workflows/lib/write-manifest.sh
#   init_manifest_vars
#   write_manifest version_mitglieder_android.json icd360sev-universal.apk

init_manifest_vars() {
  TAG="${GITHUB_REF_NAME}"          # e.g. v1.10.10
  VERSION="${TAG#v}"                 # 1.10.10
  IFS=. read -r MAJ MIN PAT <<< "$VERSION"
  BUILD=$((MAJ * 10000 + MIN * 100 + PAT))
  RELEASE_DATE=$(date -u +%F)
  REPO_URL="https://github.com/${GITHUB_REPOSITORY}"

  # Previous release tag is the closest fallback URL for users who decline
  # the update. `gh api` requires GH_TOKEN to be in the environment.
  FALLBACK_TAG=$(gh api "repos/${GITHUB_REPOSITORY}/releases" \
    --jq '[.[] | select(.tag_name | test("^v[0-9]"))] | map(.tag_name) | .[1] // ""')
  FALLBACK_VERSION="${FALLBACK_TAG#v}"
  BASE_DL="${REPO_URL}/releases/download/${TAG}"
  BASE_FB="${REPO_URL}/releases/download/${FALLBACK_TAG}"

  CHANGELOG="Version ${VERSION}\\n\\nSee full changelog at ${REPO_URL}/releases/tag/${TAG}"

  export TAG VERSION BUILD RELEASE_DATE REPO_URL FALLBACK_VERSION BASE_DL BASE_FB CHANGELOG
}

write_manifest() {
  local out=$1 file=$2
  local sha mb size
  sha=$(sha256sum "release/$file" | awk '{print $1}')
  size=$(stat -c%s "release/$file")
  mb=$(( (size + 524288) / 1048576 ))
  cat > "release/$out" <<JSON
{
    "version": "${VERSION}",
    "build_number": ${BUILD},
    "download_url": "${BASE_DL}/${file}",
    "fallback_url": "${BASE_FB}/${file}",
    "fallback_version": "${FALLBACK_VERSION}",
    "changelog": "${CHANGELOG}",
    "min_version": null,
    "force_update": false,
    "release_date": "${RELEASE_DATE}",
    "file_size": "${mb} MB",
    "sha256": "${sha}"
}
JSON
}
