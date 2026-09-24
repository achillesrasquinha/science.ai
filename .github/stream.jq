if .type == "stream_event" then
  (.event |
    if .type == "content_block_delta" then
      (.delta.text // .delta.thinking // "")
    elif .type == "content_block_start" and .content_block.type == "tool_use" then
      "\n[tool: \(.content_block.name)]\n"
    elif .type == "message_stop" then "\n"
    else "" end)
elif .type == "system" and .subtype == "init" then
  "[model: \(.model)] [mcp: \([.mcp_servers[]? | "\(.name)=\(.status)"] | join(", "))]\n"
elif .type == "result" then
  "\n[result: \(.subtype), \(.duration_ms)ms, \(.num_turns) turns]\n"
else "" end
