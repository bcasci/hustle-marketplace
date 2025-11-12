# Skills

Agent skills that can be invoked autonomously based on task context.

## Creating Skills

Each skill is a directory with a `SKILL.md` file:

```
skills/
└── my-skill/
    ├── SKILL.md          # Skill definition (required)
    ├── scripts/          # Helper scripts (optional)
    └── templates/        # Template files (optional)
```

**Example: `skills/example-skill/SKILL.md`**
```markdown
---
name: example-skill
description: Does something useful
---

# Instructions

[Skill implementation details]
```

## Reference

See: https://code.claude.com/docs/en/skills
