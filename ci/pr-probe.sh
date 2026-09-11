#!/usr/bin/env bash
set -euo pipefail
echo "trusted benign PR script; event=${GITHUB_EVENT_NAME:-unknown}; repo=${GITHUB_REPOSITORY:-unknown}; ref=${GITHUB_REF:-unknown}; actor=${GITHUB_ACTOR:-unknown}"
# VM4 benign pre-queue review marker
