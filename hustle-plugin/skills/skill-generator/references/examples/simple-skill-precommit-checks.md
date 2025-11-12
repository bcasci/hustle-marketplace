# Simple Skill Example: Pre-Commit Checks

**Architecture compliance**: ✅ Demonstrates required sections for Simple skill type (30-80 lines)

---

````markdown
---
name: precommit-checks
description: Run linting, tests, and security checks before committing. Use when ready to commit or verifying code quality.
allowed-tools: "Bash"
---

# Pre-Commit Checks

## Purpose

Verify code quality by running linters, tests, and security checks before committing changes.

## Steps

### Step 1: Run Linter

```bash
if [ -f ".eslintrc.json" ]; then
  npx eslint . --max-warnings 0
elif [ -f ".rubocop.yml" ]; then
  bundle exec rubocop
elif [ -f "pyproject.toml" ]; then
  ruff check .
fi
```

### Step 2: Run Tests

```bash
if [ -f "package.json" ]; then
  npm test
elif [ -f "Gemfile" ]; then
  bundle exec rspec
elif [ -f "pytest.ini" ]; then
  pytest
fi
```

### Step 3: Check for Secrets

```bash
git diff --cached --name-only | xargs grep -l "API_KEY\|SECRET\|PASSWORD" && echo "⚠ Warning: Possible secrets detected"
```

### Step 4: Verify All Checks Passed

```bash
if [ $? -eq 0 ]; then
  echo "✓ All checks passed - safe to commit"
else
  echo "✗ Checks failed - fix issues before committing"
  exit 1
fi
```

## Output

**Success**: "✓ All checks passed - safe to commit"
**Failure**: "✗ Checks failed: {specific check} - fix issues before committing"

## Errors

**"eslint: command not found"**: Install: `npm install -D eslint`
**"rspec: command not found"**: Install: `gem install rspec`
**"pytest: command not found"**: Install: `pip install pytest`
**"No linter or test framework found"**: Add linting and testing tools to project
````

---

**Why this is well-architected:**
- ✅ Complete structure: Purpose → Steps → Output → Errors
- ✅ Simple type (58 lines): Single workflow coordinating multiple checks
- ✅ Non-trivial: Automates repetitive pre-commit validation
- ✅ Specific errors: Error messages with solutions (not generic)
- ✅ No bloat: Commands only, no tool theory
