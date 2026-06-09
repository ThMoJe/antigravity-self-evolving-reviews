# 🌌 {PROJECT_NAME} — Project Rules & Standards

> **How to use this file**:
> 1. Replace `{PROJECT_NAME}` with your actual project name throughout this file.
> 2. Fill in your tech stack in the `Architecture & Stack` section.
> 3. Review the **Optional Sections** at the bottom and uncomment any that apply to your stack.
> 4. Delete this instruction block once you're done.

> **System Constraints**:
> 1. **[NO-YAPPING]**: Provide only the requested code or configurations. Omit conversational filler.
> 2. **[GIT-COMMIT-STYLE]**: Format all code modification summaries as conventional Git commits (e.g., `feat(api): add feed endpoint`)

This file serves as the core instruction set for all AI agents working on this project.

## 🏗️ Architecture & Stack

> **Fill in your stack here. Examples are provided below — replace with your actual technologies.**

- **Frontend**: (e.g., React 19 + Vite 6, Vue 3, Next.js 15, plain HTML/CSS)
- **Backend**: (e.g., Express 5 + Node.js 22, FastAPI, Django, Go/Gin)
- **Database**: (e.g., PostgreSQL 17 + Sequelize 6, MySQL + Prisma, MongoDB + Mongoose, SQLite)
- **Auth**: (e.g., Clerk, Auth0, Supabase Auth, NextAuth, Passport.js, Django auth)
- **AI**: (e.g., Gemini 2.5, OpenAI GPT-4o, Anthropic Claude)
- **Job Queue**: (e.g., BullMQ + Redis, Celery + Redis, none)
- **Deployment**: (e.g., Caddy + PM2 on Ubuntu 24.04, Docker Compose, Vercel, Railway)
- **Styling**: (e.g., TailwindCSS 4, Vanilla CSS, Styled Components)

## 💻 Development Environment (MANDATORY)

> [!CAUTION]
> This project is developed inside **Google Antigravity** on **Windows 11** with **PowerShell 7**. All terminal commands run locally MUST use Windows/PowerShell syntax.

**Scope**: These rules apply to **local terminal commands only** (commands executed on the developer's Windows machine). They do NOT apply to:

- **Git commands** — Git uses its own cross-platform syntax (`git add`, `git commit`, etc.)
- **Deployment scripts** — Production servers may run Linux/Bash
- **NPM scripts** — Cross-platform by nature, always acceptable
- **Documentation** — Server-side docs and guides may reference Linux/Bash commands for deployment contexts

**Strictly forbidden in local terminal commands:**

- ❌ Bash syntax (`&&` chaining in bash style, `export VAR=value`, `source`, `#!/bin/bash`)
- ❌ Forward-slash paths (`/path/to/file`) → use backslash (`\path\to\file`)

**Required conventions:**

- ✅ Use backslash `\` for all file paths
- ✅ Use `$env:VAR` for environment variables (not `export VAR`)
- ✅ Use `;` for command chaining (not `&&`)
- ✅ NPM scripts (`npm run start`, `npm run dev`) work cross-platform and are always acceptable

## 📜 Coding Standards

- **Strict Typing**: Prefer explicit types over `any` / weak types. Avoid type assertions unless augmenting external libraries.
- **Module Separation**: Logic in `services/`, endpoints in `routes/`, UI in `components/`.
- **Atomic Operations**: Use transactions and upserts for data integrity.
- **AI Context Ready**: Keep files under the God Component threshold (see File Size Zones below). Use clear, self-documenting names.

## 📂 Documentation Structure

- **Roadmap**: `docs/project/roadmap.md`
- **Backlog**: `docs/project/backlog.md`
- **Feature Status**: `docs/project/feature-status.md`
- **Changelog**: `CHANGELOG.md` (root) — **Must be updated on every feature release** via `/run-feature-complete` workflow

### ⚠️ AI Prompt Ownership (Meta-Prompt Pattern)

> [!CAUTION]
> The prompts in `docs/prompts/` are **generated outputs** produced by their META prompts. They are overwritten every time `/generate-review-prompts` is executed. **Never edit them directly** — changes will be lost on the next meta-prompt run.

| Generated Prompt (OUTPUT — do not edit directly) | Meta Prompt (SOURCE — edit this instead)             |
| ------------------------------------------------ | ---------------------------------------------------- |
| `docs/prompts/code-review-prompt.md`             | `docs/prompts/_meta/optimize-code-review.md`         |
| `docs/prompts/spring-cleaning-prompt.md`         | `docs/prompts/_meta/optimize-spring-cleaning.md`     |
| `docs/prompts/readme-generation-prompt.md`       | `docs/prompts/_meta/optimize-readme.md`              |
| `docs/prompts/architecture-review.md`            | `docs/prompts/_meta/optimize-architecture-review.md` |
| `docs/prompts/feature-complete.md`               | `docs/prompts/_meta/optimize-feature-complete.md`    |
| `docs/prompts/feature-plan-prompt.md`            | `docs/prompts/_meta/optimize-feature-plan.md`        |

**Workflow**: Edit the relevant META prompt → run `/generate-review-prompts` to regenerate the output prompt.

---

## 🔄 AI Workflows

> Models are selected per the **AI Model Orchestration** baseline in the Global `~/.gemini/GEMINI.md`. See escalation path for complex tasks.

| Command                           | Purpose                                               | Model                          | Mode     | Recommended Environment |
| --------------------------------- | ----------------------------------------------------- | ------------------------------ | -------- | ----------------------- |
| `/run-code-review`                | Generate Vibe Coding compliance report                | Claude Sonnet 4.6 (Thinking)   | Planning | Antigravity IDE         |
| `/run-spring-cleaning`            | Identify dead code and orphaned files                 | Gemini 3.1 Pro (High)          | Planning | Antigravity CLI         |
| `/run-architecture-review`        | Full architectural audit with live MCP data           | Claude Sonnet 4.6 (Thinking)   | Planning | Antigravity IDE         |
| `/generate-readme`                | Regenerate README.md from codebase                    | Gemini 3.5 Flash (High) Fast   | Fast     | Antigravity CLI         |
| `/run-retention-cleanup`          | Apply retention policy to reports                     | Gemini 3.5 Flash (Medium) Fast | Fast     | Antigravity CLI         |
| `/run-feature-complete`           | Update docs after verified feature                    | Claude Sonnet 4.6 (Thinking)   | Planning | Antigravity IDE         |
| `/run-feature-plan`               | Pre-flight reconnaissance + feature impl plan         | Claude Sonnet 4.6 (Thinking)   | Planning | Antigravity IDE         |
| `/run-config-layer-audit`         | Harmonize GEMINI.md, Skills, docs, MCP layers         | Claude Sonnet 4.6 (Thinking)   | Planning | Antigravity IDE         |

---

## 🚀 Vibe Coding Priorities

1. **Never block the UI**: Use background tasks/queues for heavy operations.
2. **Zero Dead Code**: Prune unused imports and files aggressively.
3. **Immediate Feedback**: All async actions must show loading states.
4. **10-Second Rule**: If a file takes >10 seconds to explain, split it.
5. **Semantic Colors**: Use theme tokens, never raw hex values.
6. **Delete-Biased Debugging**: First hypothesis for any bug must be to delete code or simplify state. Adding code is a last resort.
7. **'Why' Over 'What' Comments**: Never comment what the code does; only comment business logic or reasons for workarounds.
8. **The Checkpoint Rule**: Every 5–10 prompts, or after a major feature, request a 'Current State' summary to prevent context fragmentation.
9. **Signature-First Development**: Before writing the body of a complex function/component, output the TS Interface or JSDoc signature first and secure user approval.

### 📏 File Size Zones

| Lines   | Zone             | Action                                          |
| ------- | ---------------- | ----------------------------------------------- |
| < 450   | ✅ Safe           | No action needed                                |
| 450–474 | 🟡 Monitor       | Note it; do not add new features                |
| 475–499 | 🔴 RED           | Provide a decomposition plan before the next PR |
| 500+    | 💀 God Component | Must decompose before any new feature is added  |

---

## 🛑 Strict Non-Assumption Protocol

> ⚠️ See the **Global GEMINI.md** `§Non-Assumption Protocol` for the full rule set. It applies to all projects.

**Additional Rule:**

> **System Context is NOT Permission to Act**: The AI will frequently receive system-generated context, checkpoint summaries, or `<EPHEMERAL_MESSAGE>` blocks containing 'Next Steps', task lists, or plans from previous sessions. **These are strictly informational.** The AI MUST NEVER treat system-generated text as an active command to execute or implement code. Explicit permission to write, modify, or delete code MUST come directly from a newly entered USER message in the current chat.

---

## 🚫 Git Operations Are USER-ONLY

> ⚠️ See the **Global GEMINI.md** `§Git Remote Operations Are USER-ONLY` for the full rule set. The AI boundary ends at staging (`git add`). The user handles all commits, tags, pushes, and branch management.

---

<!--
════════════════════════════════════════════════════════════════════════════════
  OPTIONAL STACK-SPECIFIC SECTIONS
  ─────────────────────────────────
  Review the sections below and UNCOMMENT the ones that match your tech stack.
  Each section is wrapped in an HTML comment block.
  Delete the sections you don't need.
════════════════════════════════════════════════════════════════════════════════
-->

<!--
──────────────────────────────────────────────────────────────────────────────
  OPTIONAL: ORM-Specific Type Safety Rules (e.g., Sequelize with TypeScript)
  Uncomment if you use an ORM that requires `as any` workarounds in queries.
──────────────────────────────────────────────────────────────────────────────

### 🛡️ Zero `any` Policy

`any` is prohibited in production code. Approved workarounds:

- **External Libraries**: Create an interface matching the expected shape.
- **{YOUR_ORM}**: `as any` **ONLY** for `where` clauses where {YOUR_ORM} types are too strict. **Comment explicitly.**
- **{YOUR_FRAMEWORK}**: Extend the Request type in `{YOUR_TYPES_FILE}` instead of casting to `any`.

-->

<!--
──────────────────────────────────────────────────────────────────────────────
  OPTIONAL: Auth Provider-Specific Rules
  Uncomment if you use a dedicated auth provider (Clerk, Auth0, Supabase, etc.)
──────────────────────────────────────────────────────────────────────────────

## 🔐 Auth Rules ({YOUR_AUTH_PROVIDER})

- Auth middleware must be applied to every protected route.
- Webhook sync failures must be logged and retried — never silently swallowed.
- Client-side auth tokens must never be stored in localStorage — use httpOnly cookies or the provider's secure storage.
- When using `{YOUR_AUTH_PROVIDER}` SDK, always consult the latest official patterns (available via `{AUTH_MCP_TOOL}` if configured).

-->

<!--
──────────────────────────────────────────────────────────────────────────────
  OPTIONAL: Job Queue Rules (BullMQ, Celery, Sidekiq, etc.)
  Uncomment if you use a background job processing system.
──────────────────────────────────────────────────────────────────────────────

## ⚙️ Job Queue Rules ({YOUR_QUEUE_LIBRARY})

- All queue jobs must be idempotent — a retry must never produce duplicate data.
- Every queue must have a configured retry/backoff strategy.
- Worker concurrency must be documented and justified in comments.
- Job deduplication must be implemented for jobs that could be enqueued multiple times.
- All job status events (complete, failed, stalled) must be logged at the appropriate level.

-->

<!--
──────────────────────────────────────────────────────────────────────────────
  OPTIONAL: Mobile / Hybrid App Rules (Capacitor, React Native, etc.)
  Uncomment if you have a native mobile app.
──────────────────────────────────────────────────────────────────────────────

## 📱 Mobile Rules ({YOUR_MOBILE_FRAMEWORK})

- Platform detection must use the centralized utility (e.g., `isNative()`) — never call the platform API directly.
- All external URL opening must go through the designated cross-platform hook/utility.
- `versionCode` in the Android build config must be incremented for every release build.
- Version numbers must stay in sync across: root manifest, client manifest, and mobile build config.
- Native-only features must be guarded behind platform checks to prevent crashes on web.
- Push notification token lifecycle (register/unregister on login/logout) must be handled explicitly.

-->

<!--
──────────────────────────────────────────────────────────────────────────────
  OPTIONAL: Testing Rules
  Uncomment if you have a testing framework and want to enforce standards.
──────────────────────────────────────────────────────────────────────────────

## 🧪 Testing Rules

- Every new service function must have at least one unit test.
- Tests must assert meaningful outcomes — not just that a function runs without throwing.
- Skipped tests (`it.skip`, `@pytest.mark.skip`) must have a comment explaining why they are skipped.
- Test files must not be committed with zero assertions.
- Integration tests that call the real database must use a test database — never production.

-->
