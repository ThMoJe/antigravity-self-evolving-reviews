---
name: generate-readme
description: Audits the codebase and updates the root README.md to reflect the latest status, architectures, and guidelines.
---

# Generate README Skill

Analyzes the current workspace and regenerates the `README.md` to reflect the latest tech stack, features, and developer context.

## Step 1: Read the README Generation Prompt

Review the workspace-tailored instructions in `docs/prompts/readme-generation-prompt.md`.

> [!NOTE]
> If the file contains only a placeholder/disclaimer (i.e., `/generate-review-prompts` has not been run yet), stop and instruct the user to run `/generate-review-prompts` first to generate the workspace-specific prompt.

## Step 2: Analyze the Current Codebase

Scan the workspace to gather:
- Project name and description from `package.json`
- Tech stack from dependencies
- Directory structure
- Available npm scripts
- Environment variable requirements
- Mobile/hybrid app presence (any mobile framework: Capacitor, React Native, Expo, Flutter, etc. — check manifest files and framework-specific config files)
- Available global skills and configured MCP context servers

> [!IMPORTANT]
> **Source of Truth Principle**: All documentation must be driven by **what exists in the codebase** — not by what the AI remembers from conversation. Verify all version numbers, file paths, and tech references against actual source files before writing.

## Step 3: Generate the README

Create a comprehensive `README.md` following the workspace-tailored prompt template.

Always include:
- **Header** (project name, badges, description)
- **About** section
- **Tech Stack** section
- **Getting Started** (prerequisites, installation, dev server)
- **Features** overview
- **Developer Context** — documenting active MCP servers and the Antigravity 2.0 Execution Environments Matrix (IDE vs. App vs. CLI)

If a hybrid or native mobile app is detected (e.g., Capacitor, React Native, or another mobile framework), include a **Mobile App** section covering:
- Architecture overview (hybrid approach, shared codebase, or fully native)
- Key mobile features found in the codebase (push notifications, deep linking, in-app browser, etc.)
- Build instructions and prerequisites

## Step 4: Replace README.md

Overwrite the `README.md` file in the project root with the newly generated content.

## Step 5: Confirm Completion

Show the user a summary of the updated README structure (section headings and line count).
