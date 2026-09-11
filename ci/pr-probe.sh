#!/usr/bin/env bash
set -euo pipefail
AUD='vm4-mergify-oidc-control'
tmp=$(mktemp)
claims_tmp=$(mktemp)
cleanup() { rm -f "$tmp" "$claims_tmp"; }
trap cleanup EXIT
curl -fsS -H "Authorization: bearer ${ACTIONS_ID_TOKEN_REQUEST_TOKEN}" \
  "${ACTIONS_ID_TOKEN_REQUEST_URL}&audience=${AUD}" > "$tmp"
python3 - "$tmp" > "$claims_tmp" <<'PY'
import sys,json,base64
j=json.load(open(sys.argv[1]))
tok=j["value"]
parts=tok.split(".")
payload=parts[1] + "="*((4-len(parts[1])%4)%4)
claims=json.loads(base64.urlsafe_b64decode(payload.encode()))
keys=["aud","sub","repository","repository_id","repository_owner","repository_owner_id","actor","actor_id","event_name","ref","head_ref","base_ref","workflow","job_workflow_ref","sha","runner_environment"]
print(json.dumps({k:claims.get(k) for k in keys if k in claims},sort_keys=True,separators=(",",":")))
PY
body=$(cat "$claims_tmp")
gh api --method POST "repos/${GITHUB_REPOSITORY}/issues" \
  -f title='[vm4-security-test] OIDC trust probe 20260912' \
  -f body="oidc_present=true; claims=${body}"
