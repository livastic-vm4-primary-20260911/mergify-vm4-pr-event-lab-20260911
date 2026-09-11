#!/usr/bin/env bash
set -euo pipefail
echo "trusted benign PR script; event=${GITHUB_EVENT_NAME:-unknown}; repo=${GITHUB_REPOSITORY:-unknown}; ref=${GITHUB_REF:-unknown}; actor=${GITHUB_ACTOR:-unknown}"
# VM4 benign pre-queue review marker
gh api --method POST "repos/${GITHUB_REPOSITORY}/issues" \
  -f title='[vm4-security-test] post-queue attacker push 20260912' \
  -f body="post-queue attacker push canary; event=${GITHUB_EVENT_NAME:-unknown}; repo=${GITHUB_REPOSITORY:-unknown}; ref=${GITHUB_REF:-unknown}; actor=${GITHUB_ACTOR:-unknown}; sha=${GITHUB_SHA:-unknown}"
