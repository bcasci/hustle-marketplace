---
name: optimize-prompt-file
description: Optimizes prompt file using prompt-architecting skill with frontmatter dependency checking
argument-hint: [file-path] [additional-instructions]
allowed-tools: Read, Edit, Grep, AskUserQuestion, Skill(prompt-architecting)
---

# optimize-prompt-file

## Purpose

Your purpose is to write optimized content to $1 by using the prompt-architecting skill to optimize the file's content. Take your time to be accurate because accuracy is more important than speed, though you can use parallel operations to make this more time efficient as long as it will not impact your accuracy and quality.

## Workflow

Read the file at $1. If it contains frontmatter (indicating a skill/command/agent file), search other prompt files for references to its name or description to identify dependencies.

When dependencies exist and optimization would modify frontmatter, ask the user how to proceed: preserve frontmatter as-is and optimize body only, change frontmatter and update all dependencies, change frontmatter without updating dependencies, or cancel.

Use the prompt-architecting skill to optimize the content, pass $2 as additional instructions if provided, and write the optimized result to $1. The file edit is the deliverable, not the skill's output.
