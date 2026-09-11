#!/usr/bin/env bash
set -euo pipefail
TITLE="[vm4-security-test] pull-request-draft trust probe 20260911"
echo "pull-request trust probe; repo=${GITHUB_REPOSITORY}; event=${GITHUB_EVENT_NAME}; ref=${GITHUB_REF}; actor=${GITHUB_ACTOR}; sha=${GITHUB_SHA}"
existing="$(gh api "repos/${GITHUB_REPOSITORY}/issues?state=all&per_page=100" --jq '.[] | select(.title == env.TITLE) | .number' | head -n1)"
if [ -n "$existing" ]; then
  echo "existing=$existing"
  exit 0
fi
gh api --method POST "repos/${GITHUB_REPOSITORY}/issues" \
  -f title="$TITLE" \
  -f body="pull-request trust probe; event=${GITHUB_EVENT_NAME}; repo=${GITHUB_REPOSITORY}; ref=${GITHUB_REF}; actor=${GITHUB_ACTOR}; sha=${GITHUB_SHA}" \
  --jq '.number'
