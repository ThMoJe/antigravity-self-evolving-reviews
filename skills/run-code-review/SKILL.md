---
name: run-code-review
description: Perform a high-fidelity code review of the workspace or staged changes based on generated instructions.
---

# Run Code Review Skill

Performs a high-fidelity code review of the workspace based on the workspace-tailored review prompt. Produces a graded report with actionable recommendations.

## Step 1: Read the Code Review Prompt

Review the detailed, workspace-specific instructions in `docs/prompts/code-review-prompt.md`.

> [!NOTE]
> If the file contains only a placeholder/disclaimer (i.e., `/generate-review-prompts` has not been run yet), stop and instruct the user to run `/generate-review-prompts` first to generate the workspace-specific prompt.

## Step 2: Analyze the Codebase

Execute the instructions in `docs/prompts/code-review-prompt.md`. Focus on:

- **Correctness**: Logical bugs or edge cases
- **Security**: Authentication guards and input validation
- **AI Context Readiness**: JSDoc coverage, file size (< 500 lines), naming clarity
- **Dead Code**: Unused imports or orphaned files

## Step 3: Check Vibe Coding Compliance

- Identify "God Components" (files > 500 lines) and provide a decomposition plan
- Check for `as any` type assertions and suggest proper type augmentations
- Verify module separation (logic in services, endpoints in routes)

## Step 4: Generate the Report

Save the full review output to a new timestamped file:

```
docs/reports/code-review/code-review-report-{YYYY-MM-DD}.md
```

- Use today's date in the filename.
- If a report for today already exists, append time: `code-review-report-{YYYY-MM-DD}-{HH-MM}.md`.

## Step 5: Apply Retention Policy

Keep only the **5 most recent** reports in `docs/reports/code-review/`.

- Sort all existing files by date (newest first).
- Move any reports beyond the 5 most recent to `docs/reports/archive/`.

## Step 6: Produce the Vibe Report & Recommended Actions

Include a grading matrix (1–10) for:
- Security
- Stability
- Maintainability
- **Overall Vibe Score**

For each item in the Recommended Actions table, specify the optimal **Execution Environment** (IDE vs. Application vs. CLI) according to the Antigravity 2.0 decision matrix.
