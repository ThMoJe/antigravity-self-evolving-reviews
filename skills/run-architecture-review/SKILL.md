---
name: run-architecture-review
description: Perform a full-spectrum architectural audit of the system architecture, dependencies, and patterns.
---

# Run Architecture Review Skill

Performs a comprehensive architectural audit of the workspace using live MCP data and the workspace-tailored architecture review prompt. Produces a timestamped Architecture Vibe Report.

## Step 1: Read the Architecture Review Prompt

Review the detailed, workspace-specific instructions in `docs/prompts/architecture-review.md`.

> [!NOTE]
> If the file contains only a placeholder/disclaimer (i.e., `/generate-review-prompts` has not been run yet), stop and instruct the user to run `/generate-review-prompts` first to generate the workspace-specific prompt.

## Step 2: Execute Phase 1 — Live Data Gathering

Before any analysis, execute all MCP queries defined in the prompt's **Phase 1** section. The prompt specifies exactly which MCP tools to use based on the detected workspace configuration (database, queue, issue tracker, etc.). Collect and record all raw data before proceeding.

> [!NOTE]
> Only execute the MCP queries listed in the generated prompt's Phase 1 section. Do not assume any MCP tool is available — the prompt reflects the actual configured MCP servers for this workspace.

As a baseline, also run:
- **Commit velocity**: `git log --oneline --since="30 days ago"` in the terminal

Collect and record all raw data before proceeding.

## Step 3: Execute Phase 2 — Architectural Analysis

Work through each architectural dimension defined in the prompt using the Phase 1 evidence as grounding data. Cross-reference relevant documentation and patterns identified in the codebase.

## Step 4: Generate the Report

Save the full audit output to a new timestamped file:

```
docs/reports/architecture-review/architecture-review-report-{YYYY-MM-DD}.md
```

- Use today's date in the filename.
- If a report for today already exists, append time: `architecture-review-report-{YYYY-MM-DD}-{HH-MM}.md`.

## Step 5: Apply Retention Policy

Keep only the **3 most recent** reports in `docs/reports/architecture-review/`.

- Sort all existing files by date (newest first).
- Move any reports beyond the 3 most recent to `docs/reports/archive/`.

## Step 6: Report Completion

Summarize the following to the user:
- **Architecture Vibe Rating** (overall score)
- **Critical 3**: The three most urgent architectural issues
- Report file path
