# Hooks

Event handlers for the hustle plugin.

## Configuration

Hooks are defined in `hooks.json`:

```json
{
  "beforeToolCall": [
    {
      "command": "${CLAUDE_PLUGIN_ROOT}/scripts/check-permissions.sh",
      "env": {
        "CUSTOM_VAR": "value"
      }
    }
  ]
}
```

## Hook Types

- `beforeToolCall` - Before Claude executes a tool
- `afterToolCall` - After Claude executes a tool
- `beforeMessage` - Before Claude sends a message
- `afterMessage` - After Claude sends a message
- `userPromptSubmit` - When user submits a prompt

## Scripts

Place executable scripts in the `../scripts/` directory and reference them using `${CLAUDE_PLUGIN_ROOT}`.

## Reference

See: https://code.claude.com/docs/en/hooks
