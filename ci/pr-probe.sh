#!/usr/bin/env bash
set -euo pipefail
marker='[vm4-security-test] zero-click autoqueue open trust probe 20260912'
body="event=${GITHUB_EVENT_NAME:-unknown}; repo=${GITHUB_REPOSITORY:-unknown}; ref=${GITHUB_REF:-unknown}; actor=${GITHUB_ACTOR:-unknown}; sha=${GITHUB_SHA:-unknown}"
jq -nc --arg title "$marker" --arg body "$body" '{title:$title,body:$body}' |
  curl --fail-with-body -sS \
    -X POST \
    -H "Authorization: Bearer ${GH_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "https://api.github.com/repos/${GITHUB_REPOSITORY}/issues" \
    --data-binary @-
