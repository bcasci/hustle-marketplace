---
name: publish-github-issues
description: |
  Publish GitHub issues from YAML files using gh CLI. Use this skill when:
  - User says "publish issues to github", "create issues on github"
  - User provides a YAML file path in tmp/issues/
  - Ready to batch-create GitHub issues from approved YAML
allowed-tools: "Read, Bash(gh:*), AskUserQuestion"
---

# Publish GitHub Issues

Base directory for this skill: {baseDir}

## Purpose

Read YAML files containing GitHub issue definitions and create them in GitHub using the gh CLI. This skill handles the final step of the issue creation workflow after drafting and review.

## Prerequisites

- `gh` CLI installed and authenticated
- YAML file in `tmp/issues/` directory with valid issue definitions
- Git repository with GitHub remote configured

## Workflow Overview

1. Read and validate YAML file
2. Verify gh CLI authentication
3. Create issues in GitHub (parents before children)
4. Link child issues to parents
5. Add issues to project (if specified)
6. Archive YAML to processed/ directory

---

## Step-by-Step Instructions

### Step 1: Get YAML File Path

**Input:** Path to YAML file (typically `tmp/issues/{name}.yml`)

**Actions:**

1. If no file path provided:
   - Check if `tmp/issues/` directory exists and contains YAML files (exclude `processed/` subdirectory)
   - If no files found: "No draft issues found. Create draft issues first using draft-github-issues skill."
   - If files exist: Ask user "Which YAML file do you want to publish? (provide path)"
2. Once file path obtained, proceed to validation

### Step 2: Validate YAML Structure

**Actions:**

1. Read YAML file
2. Parse and validate structure:

**Required fields:**
   - `repository` (string, format: `owner/repo`)
   - `issues` (array, at least one issue)
   - Each issue must have: `ref`, `title`, `body`

**Optional fields:**
   - Top-level: `project` (integer), `defaults` (object with labels/milestone)
   - Per-issue: `parent_ref` (string), `milestone` (string), `labels` (array)

3. Exit with error if invalid

**Errors:**

- No YAML files found in tmp/issues/ → "No draft issues found. Use draft-github-issues skill first."
- File not found → Report path and exit
- Invalid YAML → Report parse error with line number
- Missing required fields → Report which fields are missing

### Step 3: Verify GitHub CLI

**Actions:**

1. Check `gh` command is available
2. Verify authentication status

**Commands:**

```bash
# Check gh installed
which gh

# Verify authenticated
gh auth status
```

**Errors:**

- `gh: command not found` → "Install gh CLI: https://cli.github.com"
- Not authenticated → "Run: gh auth login"

### Step 4: Create Issues in Order

**Actions:**

1. Count total issues to create
2. Report: "Creating {count} issues in {repo}..."
3. Create parent issues first, store their issue numbers
4. Create child issues, linking to parent numbers
5. Report each created issue: "✓ #{number}: {title}"

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

- When issue has `parent_ref`, look up parent issue number
- Add to body: "Depends on: #{parent_number}"
- GitHub will auto-link issues

**Errors:**

- API rate limit → Report error, list succeeded/failed, do not archive
- Partial failure → Report which succeeded/failed, do not archive
- Authentication expired → Report error, do not archive

### Step 5: Add to Project (if specified)

**Actions:**

1. Check if YAML has `project` field (project number)
2. For each created issue, add to project:

```bash
gh project item-add {project_number} \
  --owner {org} \
  --url {issue_url}
```

**Note:** This step is optional. Skip if no `project` field in YAML.

### Step 6: Archive YAML File

**Actions:**

1. Ask user: "Move YAML to processed/? (Y/n)"
2. If yes (or no response):
   - Create `tmp/issues/processed/` if needed
   - Move YAML file: `mv tmp/issues/{file}.yml tmp/issues/processed/`
3. Report: "Moved to tmp/issues/processed/"

**Important:** Only archive if ALL issues created successfully. On partial failure, keep file in tmp/issues/ for retry.

---

## Output Format

### Success Output

```
Creating 3 issues in owner/repo...

✓ #123: Enable feature X (parent)
✓ #124: Implement data layer (child of #123)
✓ #125: Add UI components (child of #123)

All issues created successfully.
Added 3 issues to project "My Project".

Move YAML to processed/? (Y/n)
```

### Partial Failure Output

```
Creating 3 issues in owner/repo...

✓ #123: Enable feature X
✗ #124: Failed - API rate limit exceeded
✗ #125: Not attempted (parent failed)

Partial failure. 1 of 3 issues created.
YAML file NOT archived. Fix errors and retry.
```

---

## Error Handling

### Common Issues

**"File not found"**

- Check path is correct
- Ensure file is in `tmp/issues/`
- Verify filename (case-sensitive)

**"gh: command not found"**

- Install: `brew install gh` or https://cli.github.com
- Verify: `which gh`

**"gh: authentication required"**

- Run: `gh auth login`
- Follow prompts to authenticate

**"YAML parse error"**

- Check indentation (use spaces, not tabs)
- Verify colons have spaces after them
- Use YAML validator if needed

**"API rate limit exceeded"**

- Wait ~1 hour for limit reset
- Check status: `gh api rate_limit`
- Use authenticated token (increases limit)

**"Repository not found"**

- Verify repository format: `owner/repo`
- Check you have access to repository
- Confirm repository exists on GitHub

---

## Examples

### Example Workflow

**User:** "Publish issues tmp/issues/paddle-trial-20251105.yml"

**Skill:**
```
Reading tmp/issues/paddle-trial-20251105.yml...
✓ Valid YAML structure
✓ Repository: teamboswell/boswell-app
✓ 3 issues to create

Creating 3 issues in teamboswell/boswell-app...
✓ #188: Implement manual trial subscription management
✓ #189: Integrate Paddle billing system (child of #188)
✓ #190: Migrate manual trial tenants to Paddle (child of #188, #189)

All issues created successfully.
Added 3 issues to project "boswell-app".

Move YAML to processed/? (Y/n)
```

---

## Best Practices

1. **Review YAML before publishing** - Once created, issues are public
2. **Test with small batches** - Create 1-2 issues first to verify
3. **Use milestones/labels** - Makes issues easier to organize
4. **Link related issues** - Use parent_ref for dependencies
5. **Archive processed files** - Keeps tmp/issues/ clean

## Resources

- GitHub CLI docs: https://cli.github.com/manual/gh_issue_create
- GitHub API rate limits: https://docs.github.com/en/rest/overview/resources-in-the-rest-api#rate-limiting
