# Hustle Plugin

A Claude Code plugin for hustle workflows.

## Installation

Add this plugin to your Claude Code marketplace configuration or install it directly.

## Structure

```
hustle-plugin/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest (required)
├── commands/                 # Slash commands
├── agents/                   # Custom agents
├── skills/                   # Agent skills
├── hooks/                    # Event handlers
│   └── hooks.json
├── scripts/                  # Hook scripts
└── mcp-config.json          # MCP server configuration
```

## Components

- **Commands**: Custom slash commands for quick tasks
- **Agents**: Specialized AI agents for specific workflows
- **Skills**: Reusable capabilities that agents can invoke
- **Hooks**: Event-driven automation
- **MCP Servers**: Integration with external tools

## Development

Edit the components in their respective directories. The plugin manifest in `.claude-plugin/plugin.json` defines which components are loaded.

## License

MIT
