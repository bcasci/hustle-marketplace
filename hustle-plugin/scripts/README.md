# Scripts

Executable scripts used by hooks and other plugin components.

## Usage

Reference scripts from hooks using the `${CLAUDE_PLUGIN_ROOT}` variable:

```json
{
  "beforeToolCall": [
    {
      "command": "${CLAUDE_PLUGIN_ROOT}/scripts/validate.sh"
    }
  ]
}
```

## Examples

- `validate.sh` - Validation scripts
- `setup.py` - Setup automation
- `check-permissions.sh` - Permission checks

Make sure scripts are executable:
```bash
chmod +x scripts/your-script.sh
```
