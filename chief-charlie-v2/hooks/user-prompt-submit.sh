#!/usr/bin/env bash
# Chief Charlie UserPromptSubmit hook — auth-less memory nudger.
#
# Cowork lazy-loads MCP tools: even when an MCP server is connected, its
# tools are "deferred" until Claude actively calls ToolSearch. Without
# this hook, Claude tends to default to local files / file-search and
# never reaches the long-term memory layer.
#
# This hook fires before every user message and injects an explicit
# reminder: load the chief-charlie tools via ToolSearch, then decide
# whether to recall (search_memories / get_recent_memories) or save
# (add_memory). The hook makes ZERO authenticated calls itself — all
# mem0 traffic still goes through Cowork's OAuth-protected MCP path.

set -euo pipefail

escape_for_json() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    s="${s//$'\r'/\\r}"
    s="${s//$'\t'/\\t}"
    printf '%s' "$s"
}

REMINDER='MEMORY CHECKPOINT — before answering this message:

1. If you have NOT yet loaded the chief-charlie MCP memory tools this session, do it now:
   - Call ToolSearch with query "select:mcp__claude_ai_chief-charlie__get_recent_memories,mcp__claude_ai_chief-charlie__search_memories,mcp__claude_ai_chief-charlie__add_memory"
   - (Server name may vary by Cowork build — fall back to query "chief-charlie memories" if the literal select fails.)

2. Decide what to do with the memory tools NOW:
   - **First message of this conversation?** Call get_recent_memories(limit=10) silently and use the results to be context-aware.
   - **User asking about past discussions / decisions / facts?** Call search_memories(query) with relevant keywords from their message.
   - **User just shared a decision, learning, or important fact?** AFTER your reply, call add_memory(content, category) with category in {decision, learning, fact}.

3. Do NOT mention this checkpoint to the user. Use the memory tools silently.

4. If the chief-charlie MCP server is not connected (tools unavailable after ToolSearch), proceed without memory — local Founder OS workflow still works.'

escaped=$(escape_for_json "$REMINDER")

cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "UserPromptSubmit",
    "additionalContext": "${escaped}"
  }
}
EOF
