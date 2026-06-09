---
name: run-spring-cleaning
description: Run a Spring Cleaning analysis to find dead code, unused dependencies, and outdated logic, generating a timestamped report.
---

# Run Spring Cleaning Skill

Performs a comprehensive Spring Cleaning analysis of the workspace, identifying dead code, orphaned files, unused dependencies, and stale patterns. Generates a timestamped report and applies the retention policy.

## Step 1: Read the Spring Cleaning Prompt

Review the workspace-tailored instructions in `docs/prompts/spring-cleaning-prompt.md`.

> [!NOTE]
> If the file contains only a placeholder/disclaimer (i.e., `/generate-review-prompts` has not been run yet), stop and instruct the user to run `/generate-review-prompts` first to generate the workspace-specific prompt.

## Step 2: Execute the Analysis

Execute the instructions found in `docs/prompts/spring-cleaning-prompt.md` in full. Adhere to the following constraints:

- **Protect global skills**: Never delete or flag any files inside the plugin's `skills/` directory as dead code.
- **Git-based staleness**: Use standard PowerShell terminal commands for Git log/blame staleness verification:
  ```powershell
  git log --oneline -n 10 -- <filepath>
  git log --since="6 months ago" --oneline -- <filepath>
  ```
- **Stick to analysis**: Do not make any file deletions during this step. The report is an advisory document.

## Step 3: Generate the Report

Save the full analysis output to a new timestamped file:

```
docs/reports/spring-cleaning/spring-cleaning-report-{YYYY-MM-DD}.md
```

- Use today's date in the filename.
- If a report for today already exists, append time: `spring-cleaning-report-{YYYY-MM-DD}-{HH-MM}.md`.

## Step 4: Apply Retention Policy

Keep only the **3 most recent** reports in `docs/reports/spring-cleaning/`.

- Sort all existing files by date (newest first).
- Move any reports beyond the 3 most recent to `docs/reports/archive/`.

## Step 5: Report Completion

Summarize key findings and confirm the report location to the user. Include:
- Top 3 highest-priority cleanup items found
- Total count of flagged files or dependencies
- Report file path
