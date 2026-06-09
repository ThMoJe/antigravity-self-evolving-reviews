---
name: generate-review-prompts
description: Analyzes the codebase context to regenerate all workspace-specific review prompts using meta-prompts.
---

# Generate Review Prompts Skill

This skill reads all meta-prompt files from `docs/prompts/_meta/` and executes each one to regenerate the corresponding workspace-tailored review prompt. Run this after setting up a new workspace or after making changes to the meta-prompts themselves.

## Step 1: Identify All Meta-Prompts

List all markdown files in `docs/prompts/_meta/`. Verify the following meta-prompts are present:

| Meta Prompt File | Target Output File |
|:----------------|:------------------|
| `optimize-code-review.md` | `docs/prompts/code-review-prompt.md` |
| `optimize-spring-cleaning.md` | `docs/prompts/spring-cleaning-prompt.md` |
| `optimize-readme.md` | `docs/prompts/readme-generation-prompt.md` |
| `optimize-architecture-review.md` | `docs/prompts/architecture-review.md` |
| `optimize-feature-complete.md` | `docs/prompts/feature-complete.md` |
| `optimize-feature-plan.md` | `docs/prompts/feature-plan-prompt.md` |

If any meta-prompt is missing, warn the user and skip only that target.

## Step 2: Execute Each Meta-Prompt

For each meta-prompt file found:

1. **Read** the content of the meta-prompt file.
2. **Execute** the instructions within the meta-prompt **strictly**:
   - Each meta-prompt instructs you to analyze the current workspace (structure, tech stack, patterns, dependencies) and then rewrite a target prompt file to be codebase-aware.
   - Identify the correct target output file as specified in the meta-prompt content.
3. **Write** the generated, workspace-tailored prompt to the specified target file, **overwriting** the existing scaffold/placeholder content.

> [!NOTE]
> The meta-prompts are independent of each other. Parallelizing their execution is encouraged for efficiency when possible.

## Step 3: Verify Output

After executing all meta-prompts:

1. Confirm each target output file listed in Step 1 has been regenerated with workspace-specific content (not just the generic scaffold placeholder).
2. Verify the new prompts are saved correctly by reading the first few lines of each target file.

## Step 4: Confirm Completion

Report to the user:
- ✅ List all successfully regenerated prompt files
- ⚠️ List any meta-prompts that were skipped or failed, with the reason
