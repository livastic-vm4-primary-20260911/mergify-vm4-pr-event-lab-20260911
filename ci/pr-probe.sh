#!/usr/bin/env bash
set -euo pipefail
TITLE="[vm4-security-test] queue canary presence 20260911"
echo "canary presence probe; event=${GITHUB_EVENT_NAME}; repo=${GITHUB_REPOSITORY}; ref=${GITHUB_REF}; actor=${GITHUB_ACTOR}; sha=${GITHUB_SHA}"
if [ -z "${VM4_QUEUE_CANARY:-}" ]; then
  echo "canary_present=false"
  exit 0
fi
echo "canary_present=true"
existing="$(gh api "repos/${GITHUB_REPOSITORY}/issues?state=all&per_page=100" --jq '.[] | select(.title == env.TITLE) | .number' | head -n1)"
if [ -n "$existing" ]; then
  echo "existing=$existing"
  exit 0
fi
gh api --method POST "repos/${GITHUB_REPOSITORY}/issues" \
  -f title="$TITLE" \
  -f body="canary_present=true; event=${GITHUB_EVENT_NAME}; repo=${GITHUB_REPOSITORY}; ref=${GITHUB_REF}; actor=${GITHUB_ACTOR}; sha=${GITHUB_SHA}" \
  --jq '.number'
