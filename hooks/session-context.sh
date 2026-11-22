#!/bin/bash
# AI security — SessionStart hook.
# Prints the security engineer's memory for this project: date, company stage, open high and
# critical risks, overdue/upcoming obligations, last journal entries, pending learnings, inbox,
# latest digest. Never prints file contents that could hold secrets.
# Silent when the project has no ai-team/security workspace.
set -u
# Find the nearest workspace: ai-team/security in the project folder or any parent folder
# (a company folder can hold ai-team/ next to projects/<product>/).
dir="${CLAUDE_PROJECT_DIR:-$PWD}"
WS=""
while [ -n "$dir" ] && [ "$dir" != "/" ]; do
  if [ -d "$dir/ai-team/security" ]; then WS="$dir/ai-team"; break; fi
  dir=$(dirname "$dir")
done
[ -n "$WS" ] || exit 0
ME="$WS/security"
cd "$ME" || exit 0

version=$(grep -m1 '"version"' "${CLAUDE_PLUGIN_ROOT:-.}/.claude-plugin/plugin.json" 2>/dev/null | sed 's/.*"version": *"\([^"]*\)".*/\1/')
today=$(date +%F)
soon=$(date -v+30d +%F 2>/dev/null || date -d '+30 days' +%F)

echo "=== AI SECURITY ${version:+v$version }— session context (${today}) ==="
echo "Rules: ${CLAUDE_PLUGIN_ROOT:-<plugin>}/RULES.md (agent ai-security:security). Company-owned assets only (assets.md). Never print secrets. Report vulnerabilities privately. Log every job (log-job)."
echo "Workspace: $WS  (every ai-team/... path in the rules and skills means this folder)"

stage=$(grep -m1 '^- \*\*Stage:\*\*' "$WS/company/profile.md" 2>/dev/null | sed 's/^- \*\*Stage:\*\* *//')
assets=$(grep -c '^| A-[0-9]' assets.md 2>/dev/null || true)
echo "Company stage: ${stage:-unknown} · Assets in scope: ${assets:-0}"
echo

echo "--- Open high / critical security risks ---"
if [ -f history/risks.md ]; then
  awk -F'|' '
    /^\| RK-/ {
      id=$2; asset=$4; risk=$5; rating=$9; status=$11; review=$12
      gsub(/^ +| +$/, "", id); gsub(/^ +| +$/, "", asset); gsub(/^ +| +$/, "", risk)
      gsub(/^ +| +$/, "", rating); gsub(/^ +| +$/, "", status); gsub(/^ +| +$/, "", review)
      r=tolower(rating); s=tolower(status)
      if ((r == "critical" || r == "high") && (s == "open" || s == "mitigating")) {
        printf "%s  [%s, %s] %s — %s (review by %s)\n", id, toupper(r), s, asset, risk, review; n++
      }
      if (s == "open" || s == "mitigating") all++
    }
    END { if (n == 0) print "(none)"; if (all > n) printf "(+ %d open medium/low risks)\n", all - n }' history/risks.md
fi
echo

echo "--- Security obligations: overdue or due by ${soon} ---"
if [ -f history/obligations.md ]; then
  awk -F'|' -v today="$today" -v soon="$soon" '
    /^\| O-/ {
      id=$2; due=$3; type=$4; what=$5; status=$7
      gsub(/^ +| +$/, "", id); gsub(/^ +| +$/, "", due); gsub(/^ +| +$/, "", type)
      gsub(/^ +| +$/, "", what); gsub(/^ +| +$/, "", status)
      if (status == "open" && due ~ /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/ && due <= soon) {
        flag = (due < today) ? "OVERDUE " : ""
        printf "%s%s  %s  [%s] %s\n", flag, id, due, type, what; n++
      }
      if (status == "open" && due == "—") u++
    }
    END { if (n == 0) print "(none)"; if (u > 0) printf "(+ %d open items without a date)\n", u }' history/obligations.md
fi
echo

echo "--- Last journal entries ---"
j=$(grep '^## J-' history/journal.md 2>/dev/null | tail -n 6)
echo "${j:-(none)}"
echo

pending=$(grep -c '^| L-[0-9]* .*| general .*| pending' learnings.md 2>/dev/null || true)
inbox=$(find inbox -type f ! -name 'README.md' ! -name '.*' 2>/dev/null | wc -l | tr -d ' ')
latest=$(ls -1 digests/20*.md 2>/dev/null | tail -n 1)
echo "Inbox: ${inbox:-0} file(s) · Pending general learnings: ${pending:-0}$( [ "${pending:-0}" -ge 3 ] && echo ' → suggest ai-security:improve') · Latest digest: ${latest:-none yet}"
exit 0
