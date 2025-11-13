---
name: publish-github-issues
description: Publishes GitHub issues from YAML files using gh CLI. Use when publishing draft issues to GitHub or user provides YAML file path in tmp/issues/. Needs YAML file with valid issue definitions and gh CLI authenticated. Trigger with phrases like 'publish issues [file-path]', 'create github issues from [file-path]', 'publish to github'.
allowed-tools: "Read, Bash(gh:*), AskUserQuestion"
---

Base directory for this skill: {baseDir}

## Workflow

1. Get YAML file path (ask if not provided)
2. Read and validate YAML structure
3. Create issues in GitHub (parents before children)
4. Link child issues to parents using parent_ref
5. Add issues to project (if specified)
6. Ask user to archive YAML to processed/

<yaml_validation>

## YAML Structure

**Required fields:**

- `repository` (format: `owner/repo`)
- `issues` (array with at least one)
- Each issue: `ref`, `title`, `body`

**Optional fields:**

- Top-level: `project` (integer), `defaults` (labels/milestone)
- Per-issue: `parent_ref`, `milestone`, `labels` (array)

</yaml_validation>

<issue_creation>

## Creating Issues

**Order:** Create parent issues first, store their numbers, then create children.

**For each issue:**

```bash
gh issue create \
  --repo {repository} \
  --title "{title}" \
  --body "{body}" \
  [--milestone "{milestone}"] \
  [--label "label1,label2"]
```

**Parent-child linking:**
When issue has `parent_ref`, look up parent issue number and add to body:

```
Depends on: #{parent_number}
```

**Output:** Report each created issue: `✓ #{number}: {title}`

</issue_creation>

<project_assignment>

## Adding to Project (Optional)

If YAML has `project` field (project number), add each created issue:

```bash
gh project item-add {project_number} \
  --owner {org} \
  --url {issue_url}
```

</project_assignment>

<archiving>

## Archive YAML

**Important:** Only archive if ALL issues created successfully.

1. Ask user: "Move YAML to processed/? (Y/n)"
2. If yes: Create `tmp/issues/processed/` if needed, move file
3. On partial failure: Keep file in tmp/issues/ for retry

</archiving>

<error_handling>

## Error Handling

**gh not found:** `which gh` fails → Install gh CLI
**Not authenticated:** `gh auth status` fails → Run `gh auth login`
**API rate limit:** Wait ~1 hour, check `gh api rate_limit`
**Partial failure:** Report succeeded/failed issues, do not archive
**YAML parse error:** Report line number and field

</error_handling>

## Example Output

```
Creating 3 issues in owner/repo...

✓ #188: Implement manual trial subscription management
✓ #189: Integrate Paddle billing system (child of #188)
✓ #190: Migrate manual trial tenants to Paddle (child of #188, #189)

All issues created successfully.
Added 3 issues to project "My Project".

Move YAML to processed/? (Y/n)
```
