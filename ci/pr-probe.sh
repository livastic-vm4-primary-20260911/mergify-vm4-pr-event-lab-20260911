#!/usr/bin/env bash
set -euo pipefail
marker="VM4_MP_OFF_ZERO_CLICK_TRUST_CHAIN_MARKER"
echo "probe event=${GITHUB_EVENT_NAME:-unknown} repo=${GITHUB_REPOSITORY:-unknown} ref=${GITHUB_REF:-unknown} actor=${GITHUB_ACTOR:-unknown}"
body="event=${GITHUB_EVENT_NAME:-unknown}; repo=${GITHUB_REPOSITORY:-unknown}; ref=${GITHUB_REF:-unknown}; actor=${GITHUB_ACTOR:-unknown}; head=${GITHUB_SHA:-unknown}"
gh api --method POST "repos/${GITHUB_REPOSITORY}/issues" -f title="$marker" -f body="$body"
