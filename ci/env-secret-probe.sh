#!/usr/bin/env bash
set -euo pipefail
if [[ -n "${VM4_ENV_SECRET_CANARY:-}" ]]; then present=true; else present=false; fi
printf "VM4_ENV_SECRET_PRESENT=%s event=%s repo=%s ref=%s head_repo=%s\n" "$present" "${GITHUB_EVENT_NAME:-unknown}" "${GITHUB_REPOSITORY:-unknown}" "${GITHUB_REF:-unknown}" "${PR_HEAD_REPO:-unknown}"
