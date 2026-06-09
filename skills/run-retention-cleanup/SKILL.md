---
name: run-retention-cleanup
description: Cleans up old reports in the workspace according to the retention policy.
---

# Run Retention Cleanup Skill

Applies the documentation retention policy to keep report folders manageable by archiving old reports and deleting stale archive entries.

## Retention Rules

| Report Type | Location | Keep |
|:------------|:---------|:-----|
| Code Review | `docs/reports/code-review/` | Last **5** reports |
| Spring Cleaning | `docs/reports/spring-cleaning/` | Last **3** reports |
| Architecture Review | `docs/reports/architecture-review/` | Last **3** reports |
| Archive | `docs/reports/archive/` | Delete after **90 days** |

## Step 1: Code Review Reports

- List all files in `docs/reports/code-review/`
- Sort by date descending (newest first)
- Keep the 5 most recent files
- Move older files to `docs/reports/archive/`

## Step 2: Spring Cleaning Reports

- List all files in `docs/reports/spring-cleaning/`
- Sort by date descending (newest first)
- Keep the 3 most recent files
- Move older files to `docs/reports/archive/`

## Step 3: Architecture Review Reports

- List all files in `docs/reports/architecture-review/`
- Sort by date descending (newest first)
- Keep the 3 most recent files
- Move older files to `docs/reports/archive/`

## Step 4: Archive Cleanup

- List all files in `docs/reports/archive/`
- Identify files older than 90 days (by filename date or file modified date)
- Delete files older than 90 days

## Step 5: Report Summary

Report to the user:
- Files archived from each review type (code-review, spring-cleaning, architecture-review)
- Files deleted from archive
- Current file counts in each folder
