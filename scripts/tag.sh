#!/bin/bash
set -euo pipefail

# Extract Keycloak version from Containerfile
KC_VERSION="$(grep -oP '(?<=FROM quay.io/keycloak/keycloak:)(\d+\.\d+\.\d+)(?=\W)' Containerfile | head -1)"
if [ -z "${KC_VERSION}" ]; then
  echo "Failed to extract Keycloak version" >&2
  exit 1
fi

echo >&2 "Keycloak version: ${KC_VERSION}"

# Get the latest commit hash
COMMIT_HASH=$(git rev-parse HEAD)
echo >&2 "Commit hash: ${COMMIT_HASH}"

# Fetch data from the GitHub API
REPO_FULLNAME=$(echo "${GITHUB_REPOSITORY}")
API_URL="https://api.github.com/repos/${REPO_FULLNAME}"
AUTH_HEADER="Authorization: Bearer ${GITHUB_TOKEN}"
ACCEPT_HEADER="Accept: application/vnd.github+json"
VERSION_HEADER="X-GitHub-Api-Version: 2022-11-28"

LAST_BUILD="$(curl -sS -H "${AUTH_HEADER}" -H "${ACCEPT_HEADER}" -H "${VERSION_HEADER}" "${API_URL}/tags" | \
  jq -r --arg prefix "v${KC_VERSION}-" '[.[]|select(.name|startswith($prefix)).name|split("-")[1]] | max // 0')"

BUILD_NUM=$((LAST_BUILD + 1))

echo "name=v${KC_VERSION}-${BUILD_NUM}" >> "$GITHUB_OUTPUT"
