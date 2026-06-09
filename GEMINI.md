# 🌌 Antigravity Self-Evolving Reviews — Plugin Developer Rules

> **Scope**: This file governs AI agents working **on this plugin itself** — adding features, fixing bugs, improving skills, and maintaining the meta-prompt pipeline. It is **not** the workspace template shipped to end users (that lives in `templates/_example.GEMINI.md`).
>
> This file is in `.gitignore` and is never committed to the repository.

---

## 🎯 What This Plugin Is and Why It Exists

**Antigravity Self-Evolving Reviews** solves a fundamental problem with AI code reviews: generic prompts produce generic results.

A prompt that tells an AI to "check for security issues" does not know that this workspace uses Clerk for auth, Sequelize with a custom `as any` policy, or a specific naming convention for background jobs. A generic prompt misses what matters and flags what doesn't.

This plugin's solution is the **meta-prompt pipeline**:

1. **Meta-prompts** are high-level instructions that tell an AI to *analyze a target workspace* — its stack, file structure, patterns, MCP servers, and team conventions — and then *write* a context-aware review prompt specifically for that workspace.
2. **Generated prompts** are the output of that analysis. They live in `docs/prompts/` and are deeply specific to the workspace they were generated for.
3. **Skills** are the slash commands that execute those generated prompts to run the actual review, produce a report, and apply retention policy.

The result: workflows that understand *your* project. And because the meta-prompts can be re-run at any time, the prompts **self-evolve** as the codebase changes.

> [!NOTE]
> **Not every skill uses a generated prompt.** Three skills in this plugin are intentionally *static* — they are workspace-agnostic by design and do not participate in the meta-prompt pipeline. See the [Skill Taxonomy](#skill-taxonomy) section for the rationale.

---

## 🧠 The Core Architecture — Understand This Completely

There are **three distinct layers** in this plugin. Confusing them is the most common source of mistakes.

### Layer 1: Skills (`skills/*/SKILL.md`)
The **executable interface**. These are the slash commands the end user invokes (`/run-code-review`, `/run-spring-cleaning`, etc.).

Skills come in two tiers:
- **Meta-prompt-backed**: Read from a generated, workspace-specific prompt file. These are workspace-agnostic at the skill level but context-rich at execution time because the generated prompt is tailored to the workspace.
- **Static**: Fully generic instructions baked into the `SKILL.md`. These do not use a generated prompt. See [Skill Taxonomy](#skill-taxonomy).

A meta-prompt-backed skill's job is to: **read the generated prompt → execute it → write the report → apply retention**.
A static skill's job is to: **execute its fixed, workspace-agnostic instructions directly**.

### Layer 2: Meta-Prompts (`docs/prompts/_meta/optimize-*.md`)
The **source of truth for review logic**. These are the files you edit to improve how reviews work.

- Each meta-prompt is an instruction set for an AI to analyze a target workspace and *write* a tailored version of its corresponding generated prompt.
- Editing a meta-prompt does not immediately change anything. The user must run `/generate-review-prompts` to regenerate the output.
- The meta-prompts live in this plugin's `docs/prompts/_meta/` directory and are **shipped as part of the plugin**.

### Layer 3: Generated Prompts (`docs/prompts/*.md`)
The **workspace-specific review instructions**. These are produced by the meta-prompts.

- In this repository, the generated prompt files are **scaffold placeholders** with `[!WARNING]` disclaimers. This is correct — they are replaced with real content after the user runs `/generate-review-prompts` in their own workspace.
- **These files must never be treated as content to improve directly.** To improve a review prompt, edit the corresponding meta-prompt in `_meta/`.

### The Pipeline

```
Meta-Prompt (EDIT THIS)         →  /generate-review-prompts  →  Generated Prompt (never edit)
                                                                    ↓
                                                          Skill reads it and runs the review
```

---

## 📋 Plugin Structure Reference

```
antigravity-self-evolving-reviews/
├── plugin.json                          ← Plugin manifest (name, version, author, keywords)
├── skills/*/SKILL.md                    ← 12 global slash commands (see Skill Taxonomy below)
├── templates/_example.*                 ← Config templates copied to user workspace by /setup-reviews
└── docs/
    ├── prompts/_meta/optimize-*.md      ← SOURCE OF TRUTH — edit these to improve reviews
    ├── prompts/*.md                     ← Scaffold placeholders (overwritten by /generate-review-prompts)
    └── reports/*/sample-*.md           ← Scaffold placeholders (overwritten by first review run)
```

---

## ✅ Rules for Working on This Plugin

### When Improving a Review Workflow
1. **Always edit the meta-prompt first**: `docs/prompts/_meta/optimize-<name>.md`
2. The meta-prompt change is the deliverable. Do not also try to write the generated prompt.
3. Document what you changed in the meta-prompt and why.
4. Update the corresponding skill in `skills/<name>/SKILL.md` only if the *execution steps* change (e.g., a new retention rule, a new report path).

### When Adding a New Meta-Prompt-Backed Skill
1. Create the meta-prompt first: `docs/prompts/_meta/optimize-<new-name>.md`
2. Create a scaffold placeholder: `docs/prompts/<new-name>.md` (with `[!WARNING]` disclaimer)
3. Create the skill: `skills/<new-name>/SKILL.md` (with YAML frontmatter, generic execution steps that read the generated prompt)
4. Update `skills/generate-review-prompts/SKILL.md` to include the new meta-prompt in its mapping table
5. Update `plugin.json` version (PATCH bump for new features)
6. Update `README.md` to document the new slash command under the Meta-Prompt-Backed Skills section

### When Adding a Static Skill
Only add a static skill if the skill's instructions are **intentionally workspace-agnostic** by design — i.e., the skill performs live discovery at runtime, or its review criteria apply universally regardless of tech stack. See the Skill Taxonomy section in `README.md` for the decision criteria.

1. Create the skill: `skills/<new-name>/SKILL.md` (with YAML frontmatter)
2. Update `plugin.json` version (PATCH bump)
3. Update `README.md` to document the skill under the Static Skills section **with a clear rationale** for why it is static
4. Do NOT create a meta-prompt or scaffold placeholder for static skills

### When Modifying Skills
- **Meta-prompt-backed skills** must remain workspace-agnostic. Never hardcode stack names, file paths specific to a project, or technology assumptions into a skill.
- Meta-prompt-backed skills must always check if the generated prompt is a scaffold placeholder and, if so, instruct the user to run `/generate-review-prompts` first.
- Meta-prompt-backed skills must always reference the generated prompt by its `docs/prompts/` path, not embed the review logic directly.
- **Static skills** may contain workspace-agnostic review logic directly in the `SKILL.md`. Ensure the logic remains universally applicable.

### When Modifying `setup-reviews`
- The skill must **never** overwrite existing files in the target workspace.
- All config templates must be copied with the `_example.` prefix.
- The manual merge instructions must be clear and complete.

---

## 🚫 Things Never to Do

### ❌ Never Edit Generated Prompt Scaffolds to Add Review Logic
The files in `docs/prompts/*.md` (excluding `_meta/`) are **intentionally empty scaffolds**. If you add review content to them directly, it will be overwritten the next time `/generate-review-prompts` runs in any user's workspace. All review logic belongs in the meta-prompts.

### ❌ Never Make a Skill Project-Specific
Skills must work universally. A skill must not assume the target workspace uses TypeScript, Node.js, Postgres, or any other technology. The generated prompt (produced by the meta-prompt after analyzing the workspace) handles all specificity.

### ❌ Never Combine the Meta-Prompt and Generated Prompt into One File
The two-file design is intentional. It separates the "how to generate a review" (meta-prompt, stable, in the plugin) from the "review instructions for this workspace" (generated prompt, volatile, in the user's workspace). Merging them would break the self-evolving capability.

### ❌ Never Remove the `[!WARNING]` Disclaimers from Scaffold Files
The disclaimer banners in `docs/prompts/*.md` and `docs/reports/*/sample-*.md` are how users know these files are placeholders and what to do next. They must stay intact in the plugin repository.

### ❌ Never Commit `GEMINI.md`
This file is in `.gitignore` for a reason. It is a local developer aid. The plugin ships `templates/_example.GEMINI.md` as the workspace template for end users. These two files serve different audiences and must remain separate.

### ❌ Never Hardcode Report File Paths in Skills
Report paths use date-based filenames (e.g., `code-review-report-{YYYY-MM-DD}.md`). Skills must always construct these dynamically using today's date. Never reference a specific dated report filename.

### ❌ Never Add Project-Tracking Docs to This Repository
Files like `docs/project/roadmap.md`, `docs/project/backlog.md`, and `docs/guides/` were intentionally deleted. This plugin does not track a product roadmap — it provides skills and meta-prompts. Project tracking belongs in the workspace where the plugin is installed.

### ❌ Never Add a Meta-Prompt for a Static Skill Without Justification
The three static skills (`run-config-layer-audit`, `run-implementation-plan-review-1`, `run-implementation-plan-review-2`) are static by deliberate design decision, documented in `README.md`. Do not add meta-prompts for them without first revisiting that rationale and updating the README to reflect the change in design.

---

## 🔄 The Self-Evolving Contract

The most important invariant to maintain is: **the end user should never need to manually write or edit a review prompt**.

Every improvement to review quality must flow through the meta-prompt → `/generate-review-prompts` → generated prompt pipeline. If you find yourself wanting to write a better code review prompt, the correct action is to improve `docs/prompts/_meta/optimize-code-review.md` — not to write a prompt directly.

This is what makes the system "self-evolving": as meta-prompts get smarter, any user can regenerate their workspace prompts and immediately benefit from the improvement.

---

## 🛑 Non-Assumption Protocol

> These rules apply to all work on this plugin without exception.

1. **Stop after answering**: Answer questions first. Do not proceed to implementation without explicit user confirmation.
2. **No ghost edits**: Never modify files based on an implied request during a Q&A exchange.
3. **Know or Ask**: If you don't know how the Antigravity plugin system works, ask — never infer.
4. **System Context is NOT Permission to Act**: Checkpoint summaries, task lists, or `<EPHEMERAL_MESSAGE>` blocks are informational. Explicit permission to write, modify, or delete code must come from a new user message.

---

## 🚫 Git Operations Are USER-ONLY

The AI boundary ends at staging (`git add`). The user handles all commits, tags, pushes, and branch management.
