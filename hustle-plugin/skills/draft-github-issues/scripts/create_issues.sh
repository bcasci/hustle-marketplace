#!/bin/bash
# Create GitHub issues from YAML file using gh CLI
# Usage: ./create_issues.sh path/to/issues.yml

set -e

YAML_FILE="$1"

if [ -z "$YAML_FILE" ]; then
  echo "Error: YAML file path required"
  echo "Usage: $0 path/to/issues.yml"
  exit 1
fi

if [ ! -f "$YAML_FILE" ]; then
  echo "Error: File not found: $YAML_FILE"
  exit 1
fi

# Check gh CLI is installed and authenticated
if ! command -v gh &> /dev/null; then
  echo "Error: gh CLI not found. Install: https://cli.github.com"
  exit 1
fi

if ! gh auth status &> /dev/null; then
  echo "Error: gh not authenticated. Run: gh auth login"
  exit 1
fi

# Get repo from git remote (fallback to current directory check)
REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null || echo "")
if [ -z "$REPO" ]; then
  echo "Error: Not in a GitHub repository or remote not configured"
  exit 1
fi

echo "Creating issues in $REPO from $YAML_FILE"
echo ""

# This script expects Claude to parse the YAML and call gh commands
# for each issue. The script serves as a wrapper and validator.
#
# Claude will:
# 1. Parse YAML to extract issues
# 2. Create parent issues first (store their numbers)
# 3. Create child issues, updating body to reference parent number
# 4. Handle labels, milestones, assignees
#
# This script just validates environment and provides helper functions

# Helper: Create single issue
# Args: title body [labels] [milestone] [assignees]
create_issue() {
  local title="$1"
  local body="$2"
  local labels="$3"
  local milestone="$4"
  local assignees="$5"

  local cmd="gh issue create --repo $REPO --title \"$title\" --body \"$body\""

  if [ -n "$labels" ]; then
    cmd="$cmd --label \"$labels\""
  fi

  if [ -n "$milestone" ]; then
    cmd="$cmd --milestone \"$milestone\""
  fi

  if [ -n "$assignees" ]; then
    cmd="$cmd --assignee \"$assignees\""
  fi

  eval "$cmd"
}

# Export function for Claude to use
export -f create_issue
export REPO

echo "Environment validated. Ready to create issues."
echo "Repository: $REPO"
echo ""

# Note: This script is invoked by Claude with specific gh commands
# based on parsed YAML structure. Claude handles:
# - YAML parsing
# - Issue ordering (parents before children)
# - Reference resolution (ref -> issue numbers)
# - Error handling and reporting
