# Role
You are an **Expert AI Prompt Engineer and Technical Architect**. Your goal is to analyze the current VSCode workspace and generate a highly specific, context-aware **Code Review Prompt** for an AI agent.

# Context
You are currently running inside a VSCode workspace. The user wants a code review prompt that is tailored *specifically* to this project's architecture, conventions, and rules.

# Instructions
1.  **Analyze the Workspace**: Silently scan the workspace to identify:
    *   **Project Name & Description**: Check `package.json`, `README.md`, or the root folder name. Use the version from `package.json` if present, otherwise check `pyproject.toml`, `go.mod`, `Cargo.toml`, or equivalent.
    *   **Architecture**: Is it a Monorepo? Client/Server? Microservices? Standalone? Identify the main directories.
    *   **Tech Stack**: Identify frameworks, languages, and databases present.
        *   **Version Discovery**: Read **ALL `package.json` files** (or equivalent manifest files: `pyproject.toml`, `Cargo.toml`, `go.mod`) across all workspaces. For each significant framework and library, extract the **major version number**. Always include the major version when referencing a technology (e.g., "React 19", "Express 5" — never just "React", "Express").
        *   **Configuration Scanning**: Scan configuration files (`eslint.config.js`, `vite.config.ts`, `tsconfig.json`, CI/CD workflows, Dockerfiles, `docker-compose.yml`, etc.) to detect tools and infrastructure not visible in manifest files alone.
        *   **Pattern & Methodology Detection**: Identify architectural patterns in active use (service layer, middleware chains, ORM, migration system, etc.) and coding methodologies from the project rules file.
    *   **Dead Code Tooling**: Check for a `knip.jsonc` (or `knip.json` / `.knip.jsonc`) config file and a `knip` npm script in `package.json`. If found, Knip is the project's **primary dead code analyzer** — use `{DEAD_CODE_TOOL}` placeholder for the tool name and `{KNIP_CONFIG}` for the config file path. Otherwise, check for alternative dead-code tools (e.g., `vulture` for Python, `cargo-udeps` for Rust) and use those. If none exist, use manual analysis for orphaned files.
    *   **Logging**: Check for structured logging libraries (e.g., Pino, Winston, Loguru, Zap) and any linting rules enforcing logging standards. Note the specific library found.
    *   **Job Queue / Background Processing**: Check for queue/task systems (e.g., BullMQ+Redis, Celery+Redis, Sidekiq, Temporal, AWS SQS, Hangfire). If found, note the library and backend.
    *   **Database / ORM**: Check for any database layer (e.g., PostgreSQL+Sequelize, MySQL+Prisma, MongoDB+Mongoose, SQLite, DynamoDB). Note the specific database engine and ORM/ODM.
    *   **Authentication / Identity**: Check for auth libraries or providers (e.g., Clerk, Auth0, Supabase Auth, Passport.js, NextAuth, Django auth, Firebase Auth). Note the specific provider found.
    *   **Mobile / Hybrid App**: Check for mobile frameworks (e.g., Capacitor, React Native, Expo, Flutter). Note the specific framework and platforms targeted.
    *   **Deployment**: Check for deployment scripts, reverse proxy configs (Caddy, nginx, Traefik), CI/CD pipelines, Dockerfiles.
    *   **Project Rules**: Look for the primary rules file `GEMINI.md`. Note specific coding philosophies (e.g., "Vibe Coding", "10-Second Rule").
    *   **Key Files**: Identify important config files or documentation (e.g., `docs/project/roadmap.md`, `CHANGELOG.md`).
    *   **Linting**: Check for linter configs (e.g., `eslint.config.js`, `.pylintrc`, `clippy.toml`) and identify enforced rules relevant to code quality.
    *   **Skills Detection**: Scan the `.agent/skills/` or `skills/` directory (if present). Parse each modular skill (`SKILL.md`). The generated prompt MUST protect their boilerplate code, scripts, and resources, instructing the reviewing agent to consult them during evaluations and NEVER flag them as dead code, duplicates, or console logging violations.
    *   **MCP Servers**: Parse the Antigravity MCP config (typically `~/.gemini/antigravity-ide/mcp_config.json`). Record **exactly which servers are configured**. The generated prompt must only reference MCP tools that are confirmed present — never assume a specific tool exists.
    *   **Known Patterns**: Check if `docs/prompts/known-patterns.md` exists and contains documented intentional patterns. If so, the generated prompt MUST instruct the reviewing agent to consult this file before flagging suspicious patterns as bugs.

2.  **Historical Report Awareness**: The generated code review prompt MUST instruct the reviewing agent to read all previous code review reports in `docs/reports/code-review/` before starting its analysis. Issues that appear in previous reports as **resolved (strikethrough)**, **deferred to backlog**, **marked as false positive**, or **disregarded/not-an-issue** MUST NOT be re-flagged in the new report. The generated prompt should include a dedicated instruction section for this, placed before the review begins.

3.  **Analyze the prompt template** to identify:
    *   **Review topics**: With your knowledge gained from analysing the workspace, identify the main topics that should be covered in the code review and add to the template to ensure the code review is as comprehensive as possible.
    *   **Key Topics**: Ensure that the new generated code review prompt not only covers all topics of the template but also addresses the specificities of the project and give extra attention to the most important topics. Key topics should also get enhanced in the report that the new code review prompt generates.

4.  **Conditional Section Rules** (MANDATORY — read before filling the template):
    > [!IMPORTANT]
    > Each section in the template marked with `[CONDITIONAL: check X]` MUST be evaluated before inclusion:
    > - **Include the section** if the relevant technology was detected in Step 1.
    > - **Omit the section entirely** if the technology is NOT present in the workspace.
    > - **Adapt the section** to match the exact library/framework found (e.g., if the queue library is Celery, replace BullMQ-specific rules with equivalent Celery concepts).
    > This is the core mechanism that makes the generated prompt workspace-specific.

5.  **Source of Truth**:
    > [!WARNING]
    > The output prompt must reflect the **current codebase state exclusively**. Do NOT carry forward technology names, version numbers, or architectural descriptions from the existing output file. The existing prompt file provides the template structure and section layout — every factual claim (tech stack, versions, patterns, directory names, file counts) must come from your fresh workspace analysis. If a technology was previously mentioned in the output file but is no longer present in any manifest or config file, **omit it**. If a technology has been added since the last run, **include it**.

6.  **Generate the Prompt**: Fill in the **Template** below by replacing all `{PLACEHOLDERS}` with the actual details you found in the workspace.
    *   *Example*: Replace `{PROJECT_NAME}` with "MyApp".
    *   *Example*: Replace `{CLIENT_DIR}` with "frontend/".
    *   *Example*: Replace `{CODING_PHILOSOPHY}` with "Vibe Coding" (if found).

7.  **Verify Accuracy**: Before saving the output, confirm:
    *   Every technology and tool mentioned exists in the project's manifest files or config files.
    *   Every version number matches the major version declared in the manifest.
    *   No stale references from a previous version of the output prompt were carried forward without verification.
    *   Newly added technologies and dependencies are included.
    *   Removed technologies and dependencies are no longer mentioned.
    *   Every conditional section was correctly included or omitted based on actual detection.

8.  **Strict Output**: Output **ONLY** the final, filled-in Markdown prompt to the file `docs/prompts/code-review-prompt.md`. If file exists, replace it.

9.  **NO SPECULATION RULE (MANDATORY)**: The generated prompt MUST instruct the reviewing agent that **every finding must be a present-tense, concrete problem that exists right now in the codebase**. The following are strictly forbidden in the generated review report:
    - Any sentence containing "if someone adds", "if X is introduced", "if this grows", "in the future", "consider adding", "might be worth", "could be an issue if", "should be added when", or any other conditional framing about a hypothetical future state.
    - Recommendations to add infrastructure, tooling, or configuration for features that do not yet exist.
    - "Monitor this" items with no current violation (if nothing is wrong right now, say nothing).
    - **Rule of thumb**: If the recommendation would be rendered pointless by a "this doesn't exist yet" reply, it must NOT appear in the report. Find real bugs. Fix real debt. Ship.

---

# [TEMPLATE START]

# AI Code Review Prompt: {PROJECT_NAME} Workspace

> **Workflow**: This prompt implements the code review workflow for the {PROJECT_NAME} workspace.
> **Last Optimized**: {TODAY_DATE}

You are an expert {CODING_PHILOSOPHY} Architect, Security Analyst, and {DATABASE_ROLE_IF_DB_DETECTED_ELSE_OMIT} Engineer. Perform a comprehensive code review of the **entire {PROJECT_NAME} workspace** ({ARCHITECTURE_TYPE}). This prompt is optimized for **{CODING_PHILOSOPHY}** practices—ensuring the codebase is AI-ready, maintainable, and free of technical debt.

---

## 1. Project Context

**Project**: {PROJECT_NAME} ({VERSION}) — {PROJECT_DESCRIPTION}

**Architecture**:
{ARCHITECTURE_DETAILS_LIST}
{DATABASE_LINE_IF_DETECTED: *   **Database**: {DATABASE_TYPE} with {ORM_LIBRARY}.}
{LOGGING_LINE_IF_DETECTED: *   **Logging**: {LOGGING_LIBRARY} structured logging{LOGGING_HTTP_MIDDLEWARE_IF_DETECTED: with {LOGGING_HTTP_MIDDLEWARE} for HTTP request context}. {LINTER_LOGGING_RULE_IF_DETECTED: {LINTER} `{CONSOLE_LOG_RULE}` enforcement.}}
{QUEUE_LINE_IF_DETECTED: *   **Job Queue**: {QUEUE_LIBRARY} with {QUEUE_BACKEND} for persistent background job processing.}
{DEPLOYMENT_LINE_IF_DETECTED: *   **Deployment**: {DEPLOYMENT_DETAILS} (reverse proxy, automated scripts, environment matrix).}
{DESIGN_SYSTEM_LINE_IF_DETECTED: *   **Design System**: {DESIGN_SYSTEM_NAME} ({THEME_DETAILS}).}

**Reference Files**:
- `GEMINI.md` - Project rules and standards (if present)
- {ACTIVE_SKILLS_LIST_IF_DETECTED: `{ACTIVE_SKILLS_LIST}` - Active procedural skills covering specific domains. When reviewing code in these domains, you MUST adhere to the gotchas inside their respective `SKILL.md`.}
- {ROADMAP_IF_DETECTED: `docs/project/roadmap.md` - Feature roadmap}
- {FEATURE_STATUS_IF_DETECTED: `docs/project/feature-status.md` - Completed features list}
- {BACKLOG_IF_DETECTED: `docs/project/backlog.md` - Known issues. Make sure to identify issues that you find that are also in the backlog, and make a note about it.}
- {CHANGELOG_IF_DETECTED: `CHANGELOG.md` - Version history}
{KNOWN_PATTERNS_IF_DETECTED: - `docs/prompts/known-patterns.md` - Intentional code patterns that must NOT be flagged as bugs (consult before flagging suspicious patterns)}

---

## 2. Historical Report Awareness

Before starting your analysis, read **all previous code review reports** in `docs/reports/code-review/`. For each issue found in prior reports, check its current status:

- **Resolved (strikethrough `~~...~~`)**: The issue was fixed. Do NOT re-flag it.
- **Deferred to backlog**: The issue was acknowledged and intentionally deferred. Reference the backlog item but do NOT re-flag it as a new finding.
- **False positive / Not an issue**: The finding was investigated and determined to be incorrect or normal behavior. Do NOT re-flag it.
- **Disregarded**: The team reviewed and chose not to act. Do NOT re-flag it.

Only flag issues that are **genuinely new** or represent **regressions** of previously fixed items. If a prior report marked something as resolved but it has regressed, flag it as a **regression** with a reference to the prior report.

{KNOWN_PATTERNS_SECTION_IF_DETECTED:
### Known Patterns Awareness

Before flagging suspicious code patterns as bugs, consult `docs/prompts/known-patterns.md`. This file documents intentional design decisions that may appear incorrect during automated analysis (e.g., `as any` casts for ORM type limitations, unconventional middleware patterns, intentional type widening). If a finding matches a documented known pattern, **do not flag it** — instead, note it as "intentional design pattern" in the report. Only flag a known pattern if you have evidence it has **regressed** or the documented justification no longer applies.
}

---

## 3. {CODING_PHILOSOPHY} Principles (PRIORITY)

Before diving into technical details, verify these core {CODING_PHILOSOPHY} principles:

### 🎯 {COMPLEXITY_RULE_NAME}
If it takes more than 10 seconds to explain a file's purpose to an AI, the file is too complex.

| Check | Target | Status |
|:------|:-------|:-------|
| No file exceeds 500 lines (God Component — hard limit) | All Source Files | ✅/❌ |
| No file exceeds 475 lines (RED — imminent God Component) | All Source Files | ✅/❌ |
| Component has single responsibility | {FRONTEND_FRAMEWORK_IF_DETECTED: {FRONTEND_FRAMEWORK} components} | ✅/❌ |
| Service has clear domain boundary | {BACKEND_LOGIC_DIR} | ✅/❌ |

**File Size Zone Reference** (replace {MAX_LINES} with 500 in all generated output):

| Lines | Zone | Action |
|------:|:-----|:-------|
| < 450 | ✅ Safe | No action needed |
| 450–474 | 🟡 Monitor | Note it; do not add features |
| 475–499 | 🔴 RED | Provide decomposition plan now |
| 500+ | 💀 God Component | Must decompose before next feature |

### 🧹 {CLEANUP_RULE_NAME}

{DEAD_CODE_TOOL_SECTION:
Run {DEAD_CODE_TOOL} and capture the **full, untruncated output** to a file called `knip-output.txt`. Terminal output is often truncated for large projects, so always redirect to a file. {DEAD_CODE_TOOL} returns **exit code 1 when it finds issues** — this is expected behavior, not an error.

Use the appropriate shell syntax for the user's operating system to run `npm run knip` and redirect both stdout and stderr to `knip-output.txt`.

Then read `knip-output.txt` for the full results. Configuration: `{KNIP_CONFIG}`.
}

| Check | Location | Status |
|:------|:---------|:-------|
{DEAD_CODE_TOOL_ROW_IF_DETECTED: | {DEAD_CODE_TOOL} reports zero findings | `knip-output.txt` | ✅/❌ |}
| No unused imports | All files | ✅/❌ |
| No commented-out code blocks | All files | ✅/❌ |
| No orphaned files (never imported) | Source directories | ✅/❌ |
| No unused dependencies | Package files | ✅/❌ |

### 📝 AI Context Readiness
| Check | Standard | Status |
|:------|:---------|:-------|
| JSDoc/{DOCSTRING_FORMAT} on complex functions | `@param`, `@returns` | ✅/❌ |
| Meaningful variable names | Self-documenting | ✅/❌ |
| Type annotations (no `any`/{WEAK_TYPE_EQUIVALENT}) | Strict {LANGUAGE} | ✅/❌ |
| Module separation | Logic in services, endpoints in routes | ✅/❌ |

---

## 4. Review Priorities (Ordered)

Analyze findings in this priority order:

| Priority | Focus Area | Description |
|:---------|:-----------|:------------|
| 🔴 **1** | **{CODING_PHILOSOPHY} Compliance** | {COMPLEXITY_RULE_NAME}, {CLEANUP_RULE_NAME}, AI-readiness |
| 🔴 **2** | **Correctness & Critical Bugs** | Logic errors, race conditions, broken flows |
| 🔴 **3** | **Security** | Auth middleware, input validation, injection risks, secrets exposure |
| 🔴 **4** | **Error Handling** | try/catch coverage, error boundaries, graceful degradation, global handler |
| 🟡 **5** | **Performance** | N+1 queries, bundle size, unnecessary re-renders, large payloads |
{LOGGING_PRIORITY_ROW_IF_DETECTED: | 🟡 **6** | **Logging & Observability** | Structured logging compliance, linter enforcement, log level hygiene |}
{QUEUE_PRIORITY_ROW_IF_DETECTED: | 🟡 **7** | **Job Queue & Background Processing** | Queue patterns, deduplication, retry logic, backend health |}
{DATABASE_PRIORITY_ROW_IF_DETECTED: | 🟡 **8** | **Database & Integrity** | Schema design, index usage, query efficiency |}
| 🟡 **9** | **Dead Code & Bloat** | Unused files/deps, legacy code |
| 🟢 **10** | **Testing & Test Quality** | Test coverage, orphaned tests, skipped tests |
| 🟢 **11** | **Accessibility** | ARIA, keyboard nav, semantic HTML, color contrast |
| 🟢 **12** | **API Design** | REST/GraphQL conventions, error response format, pagination, rate limiting |
| 🟢 **13** | **Deployment & Infrastructure** | Environment parity, script correctness, reverse proxy alignment |
| 🟢 **14** | **Maintainability** | Naming conventions, modularity |
| 🟢 **15** | **Documentation** | Roadmap sync, feature accuracy, stale references |

---

## 5. Environment Constraints

- **Language**: {LANGUAGE} (Strict Mode)
- **Runtime**: {RUNTIME_ENV}
- **Frameworks**: {FRAMEWORKS_LIST}
{DATABASE_ENV_LINE_IF_DETECTED: - **Database**: {DATABASE_TYPE}}
{LOGGING_ENV_LINE_IF_DETECTED: - **Logging**: {LOGGING_LIBRARY}}
{QUEUE_ENV_LINE_IF_DETECTED: - **Job Queue**: {QUEUE_LIBRARY} + {QUEUE_BACKEND}}
{LINTER_ENV_LINE_IF_DETECTED: - **Linting**: {LINTER_TOOL} with {KEY_LINTING_RULES}}
- **Apps**: {APP_LIST}

**Rules** (from `{RULES_FILE}` and active skills):
- Keep files under {MAX_LINES} lines.
- Prefer functional/idiomatic patterns.
- Logic belongs in `{BACKEND_LOGIC_DIR}`, UI in `{FRONTEND_COMPONENTS_DIR_IF_DETECTED}`.
{NAMING_CONVENTION_RULE_IF_DETECTED: - Use `{NAMING_CONVENTION}` for specific ID or Flag naming.}
- **Consult Skills**: Before reviewing complex logic, always consult the relevant `{ACTIVE_SKILLS_LIST_IF_DETECTED}` to ensure compliance with project-specific procedures.

---

## 6. Required Output Sections

{DEAD_CODE_TOOL_SECTION_IF_DETECTED:
### 🔬 {DEAD_CODE_TOOL} Analysis Results

Include the full output from `knip-output.txt` (generated in section 3). Summarize the counts:

| Category | Count |
|:---------|------:|
| Unused files | 0 |
| Unlisted dependencies | 0 |
| Unused dependencies | 0 |
| Unused exports | 0 |
| Unused types | 0 |
| Duplicate exports | 0 |

> If {DEAD_CODE_TOOL} reports zero findings, state: **"{DEAD_CODE_TOOL}: Clean ✅"**
> After report is complete, delete the `knip-output.txt` file.
}

### 🎯 {CODING_PHILOSOPHY} Compliance Report
*   **God Components** (> 500 lines): List and mandate decomposition. **RED Zone** (475–499 lines): List and provide decomposition plan. **Monitor** (450–474 lines): List with line count.
*   **Dead Code**: Unused imports, commented blocks, orphaned files{DEAD_CODE_TOOL_CROSS_REF_IF_DETECTED: (cross-reference with {DEAD_CODE_TOOL} output above)}.
*   **Type Safety**: List `any`/{WEAK_TYPE_EQUIVALENT} usage or weak typing.

### 🧹 Cleanup Report
*   **Files to Delete**: Safe-to-remove files{DEAD_CODE_TOOL_SOURCE_IF_DETECTED: (use {DEAD_CODE_TOOL} findings as primary source)}.
*   **Unused Dependencies**: Packages in manifest not used in code{DEAD_CODE_TOOL_DETECTS_IF_DETECTED: ({DEAD_CODE_TOOL} detects these automatically)}.
*   **Phantom Dependencies**: Packages imported in code but not declared in the corresponding manifest.
*   **Duplication**: Code repeated across {APP_LIST}.

{LOGGING_SECTION_IF_DETECTED:
### 📊 Logging & Observability Review
*   **{LINTER_CONSOLE_RULE_IF_DETECTED: {LINTER} `{CONSOLE_LOG_RULE}` Enforcement}**: Verify the {CONSOLE_LOG_RULE} rule is configured. Check for any lint-disable bypass comments that may circumvent enforcement.
*   **Structured Logging Compliance**: Verify all server/backend code uses {LOGGING_LIBRARY} logger (not raw `console.log`/`print`). {HTTP_MIDDLEWARE_PATTERN_IF_DETECTED: Route handlers should use `req.log` (from {LOGGING_HTTP_MIDDLEWARE}), services should use `createChildLogger`.}
{PINO_SPECIFIC_IF_DETECTED:*   **{LOGGING_LIBRARY} Call Signatures**: Verify object-first pattern: `logger.info({ context }, 'message')`, NOT `logger.info('message', context)`.}
*   **Log Level Hygiene**: Check that `LOG_LEVEL` env var is respected and debug-level logging is not left in production code paths.
*   **Logger Import Paths**: Verify correct import paths, especially in nested directories.
}

{QUEUE_SECTION_IF_DETECTED:
### ⚙️ Job Queue & Background Processing Review
*   **Queue Patterns**: Verify job deduplication, retry/backoff configuration, and rate limiting.
*   **{QUEUE_BACKEND} Connection**: Check for proper connection handling, error recovery, and graceful shutdown.
*   **Job Registration**: Verify all queue processors are registered and no orphaned job types exist.
*   **Telemetry**: Check that job status events are properly emitted for monitoring.
*   **Concurrency**: Verify worker concurrency settings are appropriate for the workload.
{REDIS_MCP_QUEUE_IF_DETECTED:*   **Live Queue State** (if `{QUEUE_MCP_TOOL}` available): Run `{QUEUE_MCP_TOOL}` with pattern `{QUEUE_KEY_PATTERN}` to check for stalled or failed jobs, and report queue depth.}

{BULLMQ_SPECIFIC_IF_DETECTED:
> **BullMQ Repeat Job Analysis Rule**:
> BullMQ stores each scheduled/completed instance of a repeat job as a separate Redis key (e.g., `bull:queue-name:repeat:hash:timestamp`). Hundreds of these keys is **normal behavior** for any long-running repeat queue — it is NOT a memory leak. Do NOT flag the count of repeat job keys as an anomaly. Only flag repeat job issues if:
> 1. A repeat job has no matching worker processor (orphaned queue)
> 2. The `failed` set contains a large number of entries relative to `completed` (indicating systematic failures)
> 3. A repeat job is registered but the worker file does not exist
}
}

### 🔍 Deep Clean Analysis

Perform an intensive scan for technical debt and garbage code:

#### Debug Noise
| File | Line(s) | Type | Code Snippet |
|:-----|:--------|:-----|:-------------|
| `path` | 42 | lint-disable | `// eslint-disable-next-line no-console` |
| `path` | 100 | debugger | `debugger;` |
| `path` | 50-75 | Commented Code | Large legacy block |

**What to find**:
{LINT_DISABLE_IF_DETECTED: - Lint-disable bypass comments in server/backend code (indicates linter circumvention)}
- `console.log`/`print` statements in code where a structured logger should be used
- `debugger` statements
- Large blocks of commented-out code (old logic)

{SCRIPTS_EXCEPTION_IF_DETECTED:**Exceptions**: Files in `{SCRIPTS_DIR}` directories (standalone CLI tools using console.log correctly).}

#### Obsolete Artifacts
| Type | Path | Reason |
|:-----|:-----|:-------|
| Directory | `path/temp/` | Name suggests temporary |
| File | `path/file.bak` | Backup extension |

**Patterns to detect**: `temp`, `tmp`, `backup`, `bak`, `old`, `archive`, `v1`, `v2`, `test_junk`, `deprecated`, `*.bak`, `*.old`

#### Orphaned Source Files
| File | Last Modified | Notes |
|:-----|:--------------|:------|
| `path/orphan.ts` | 2025-01-01 | Never imported, not an entry point |

**Criteria**: Source files not imported anywhere and not listed as entry points.

{DATABASE_SECTION_IF_DETECTED:
### 🗄️ Database Review
*   **Schema Integrity**: Model/schema definitions vs actual usage.
*   **Index Optimization**: Missing indexes for common query patterns.
*   **{DATABASE_TYPE} Issues**: Specific gotchas for this database engine (e.g., connection pooling, JSON encoding, transaction isolation).
{DATABASE_MCP_SECTION_IF_DETECTED:
*   **Live Schema Verification** (if `{DB_MCP_TOOL}` available):
    - Run `{SCHEMA_QUERY}` and compare against model files in `{MODELS_DIRECTORY}`.
    - Run the following query to get full index details:
      ```sql
      {INDEX_DETAIL_QUERY}
      ```
    - Flag any tables present in the database but absent from the models directory (orphaned tables).
    - **Index Analysis Rules** (MANDATORY — apply to every index finding):
        1. **Never flag a PRIMARY KEY column as "missing" an index** — most databases automatically create an index to enforce every PK constraint. Do not propose a duplicate index for any PK column.
        2. **Only flag "duplicate" indexes if the index definition is functionally identical** (same columns, same uniqueness, same type). Never infer duplicates from name similarity alone.
        3. **Flag a "missing" index only if** the column appears in a `WHERE` clause in application code AND no existing index already covers that column.
        4. **Do not assume ORM auto-generated indexes and migration-created indexes are redundant** — compare their full definitions before drawing any conclusion.
}
}

### 🔌 MCP Live Verification

> Only include this section if MCP servers were detected in workspace analysis.
> List only the MCP tools that are actually configured in this workspace.

{MCP_VERIFICATION_TABLE:
Run each applicable check and record the result:

| Tool / Command | Query / Pattern | Result | Finding |
|:-----|:----------------|:-------|:--------|
{DB_MCP_ROW_IF_DETECTED: | `{DB_MCP_TOOL}` | `{SCHEMA_TABLE_QUERY}` | _(result)_ | Models vs DB parity |}
{DB_MCP_INDEX_ROW_IF_DETECTED: | `{DB_MCP_TOOL}` | Full index details query (see `🗄️ Database Review` section) | _(result)_ | Index coverage — apply Index Analysis Rules |}
{CACHE_MCP_ROW_IF_DETECTED: | `{CACHE_MCP_TOOL}` | `{QUEUE_KEY_PATTERN}` | _(result)_ | Queue health |}
| `git log -n 10` (terminal) | Last 10 commits | _(result)_ | High-churn areas |
{GITHUB_MCP_ROW_IF_DETECTED: | `call_mcp_tool` (github-mcp-server) | `list_issues` (state: open) | _(result)_ | Known issues linked to findings |}
{GITHUB_MCP_PR_ROW_IF_DETECTED: | `call_mcp_tool` (github-mcp-server) | `search_pull_requests` (state: open) | _(result)_ | Pending PRs that overlap with analysis |}
{AUTH_MCP_ROW_IF_DETECTED: | `call_mcp_tool` ({AUTH_MCP_SERVER}) | `{AUTH_MCP_SDK_QUERY}` | _(result)_ | Latest official SDK patterns |}
}

### 🔐 Security & Auth Review
*   **Auth Middleware**: Verify authentication middleware is applied to every protected route. Check for any route registered after the auth guard that should be before it.
{AUTH_PROVIDER_SDK_CHECK_IF_DETECTED:
*   **{AUTH_PROVIDER} SDK Patterns** (if `{AUTH_MCP_TOOL}` available): Retrieve the latest official {AUTH_PROVIDER} SDK patterns. Cross-reference the workspace's Auth middleware and frontend components against these current patterns to detect usage of deprecated APIs.
}
*   **Input Validation**: Confirm all user-facing endpoints validate incoming parameters. Flag any endpoint that passes unsanitized input to the database or AI model.
*   **Injection Prevention**: Verify all database queries use parameterized queries or ORM methods. Flag raw queries with string interpolation.
*   **XSS Prevention**: Check for output encoding on user-generated content. Verify CSP headers are set{REVERSE_PROXY_IF_DETECTED: in the reverse proxy config}. Flag any `dangerouslySetInnerHTML`/equivalent usage.
*   **Sensitive Data Exposure**: Scan for hardcoded secrets, API keys, or passwords in source files. Check `.gitignore` covers `.env` files. Verify client-side bundles do not include server secrets.
*   **CORS Configuration**: Verify CORS origin whitelist matches actual deployment domains and is not set to `*` in production.
*   **External Service Failures**: Verify graceful degradation when {EXTERNAL_SERVICES_LIST_IF_DETECTED} or any critical external service is unavailable. Check for timeout handling and fallback behaviour.

### ⚠️ Error Handling Review
*   **Async Coverage**: Verify all `async` functions and Promise chains have `try/catch` blocks or `.catch()` handlers. Flag unhandled rejections.
{FRONTEND_FRAMEWORK_ERROR_BOUNDARIES_IF_DETECTED:*   **Error Boundaries**: Check that top-level routes and data-fetching components are wrapped with error boundaries. Flag components that crash silently.}
*   **User-Facing Messages**: Confirm error responses to the client never expose raw stack traces, internal model IDs, or database error messages.
{GLOBAL_ERROR_HANDLER_IF_DETECTED:*   **Global Handler**: Verify a global error-handling middleware is registered and catches unhandled errors from all routes.}

### ⚡ Performance Review
*   **{DATABASE_QUERY_PATTERN_IF_DETECTED: N+1 Query Detection}: Scan {ORM_NAME_IF_DETECTED} query patterns for unbounded joins or missing pagination.}**
*   **Bundle Size**: Check for large imports, barrel files, or heavy libraries. Flag tree-shaking blockers.
{FRONTEND_FRAMEWORK_RENDER_IF_DETECTED:*   **Unnecessary Re-renders**: Check {FRONTEND_FRAMEWORK} components for missing memoization on expensive computations or list renders.}
*   **Large Payload Handling**: Check API endpoints that return collections for pagination. Flag any endpoint returning unbounded arrays to the client.

### 🧪 Testing & Test Quality
*   **Test Coverage Assessment**: Check if a testing framework is present. If not, note the absence and flag as technical debt.
*   **Orphaned Tests**: Check for test files that reference source files that no longer exist.
*   **Skipped/Disabled Tests**: Scan for skipped or disabled tests. Flag each with a reason it may have been skipped.
*   **Empty Test Files**: Identify test files that contain no assertions — skeleton files that were never filled in.
*   **Test Quality**: For tests that exist, verify they assert meaningful outcomes (not just that a function runs without throwing).

{FRONTEND_FRAMEWORK_ACCESSIBILITY_IF_DETECTED:
### ♿ Accessibility Review
*   **Semantic HTML**: Check that interactive elements use the correct HTML element. Verify headings follow a logical hierarchy.
*   **ARIA Attributes**: Verify that modals, dialogs, and dynamic content regions have appropriate ARIA roles and labels.
*   **Keyboard Navigation**: Check that all interactive elements are reachable and operable via keyboard. Flag any `tabIndex=-1` that removes elements from tab order without justification.
*   **Color Contrast**: Flag any hardcoded color values (raw hex outside the theme system). Theme semantic tokens should be used exclusively to ensure contrast compliance.
}

### 🌐 API Design Review
*   **REST/{GRAPHQL_IF_DETECTED: GraphQL} Conventions**: Verify endpoints follow consistent conventions. Flag inconsistencies in HTTP method usage.
*   **Error Response Format**: Verify all error responses return a consistent JSON shape. Flag endpoints that return plain strings or HTML on error.
*   **Pagination**: Check that collection endpoints support pagination. Flag endpoints returning unbounded lists.
*   **Rate Limiting**: Verify rate limiting middleware is applied to public or high-cost endpoints. Flag any high-cost endpoint without a rate limit.

{MOBILE_SECTION_IF_DETECTED:
### 📱 {MOBILE_FRAMEWORK} App Review
*   **Platform Detection**: Verify platform detection utility usage is centralized and consistent. Check for missing platform guards on web-only features.
{CAPACITOR_SPECIFIC_IF_DETECTED:
*   **Service Worker Guard**: Confirm SW registration is disabled on native platform. Check for PWA caching that could conflict with Capacitor webview.
*   **URL Opening**: Verify all external URL opening uses the designated hook/utility (not `window.open` directly). Check `@capacitor/browser` integration.
*   **Deep Linking**: Verify intent filter in `AndroidManifest.xml` matches auth provider Dashboard configuration. Check deep link listener in the app entry point.
*   **Push Notifications**: Verify FCM/APNs token registration/unregistration lifecycle. Check notification permission handling and token rotation.
*   **Build Configuration**: Verify `capacitor.config.ts` settings (appId, webDir, plugins). Check `build.gradle` versioning (versionCode must increment for each release).
*   **CI/CD Pipeline**: Verify the mobile build workflow references correct paths, secrets, and build steps.
*   **Version Sync**: Verify version numbers are consistent across all manifest files and mobile build configs.
}
{REACT_NATIVE_SPECIFIC_IF_DETECTED:
*   **Native Module Linking**: Verify all native modules are properly linked and no manual linking steps are required that might be missing.
*   **Metro Bundler Config**: Check for any custom Metro configuration that may cause issues.
*   **Platform-specific files**: Verify `.ios.ts` / `.android.ts` files are paired correctly with their generic counterparts.
}
}

### 📛 Naming Conventions
{NAMING_CONVENTION_DETAILS_IF_DETECTED:
*   **Database**: Column naming ({NAMING_CONVENTION}).
}
*   **Code**: Variable/Function naming styles — verify consistency across the codebase.
*   **UI Terms**: Consistency in user-facing terminology.

### 📚 Documentation Review
*   **Stale References**: Check documentation files for references to deleted components, renamed files, or deprecated features.
*   **CHANGELOG Accuracy**: Verify the most recent `CHANGELOG.md` version entry matches the version in the manifest. Flag if they are out of sync.

### 🚀 Deployment & Infrastructure Review
*   **Environment Matrix**: Verify dev/test/prod configs are consistent and documented.
*   **Deployment Scripts**: Check that automated deployment scripts match current architecture.
{REVERSE_PROXY_REVIEW_IF_DETECTED:*   **Reverse Proxy**: Verify proxy config aligns with app routing (API paths, subdomain routing).}
{PROCESS_MANAGER_REVIEW_IF_DETECTED:*   **Process Manager**: Check {PROCESS_MANAGER} config for cluster mode and restart policies.}

### 🔍 Issues & Improvements
Group by **Severity** (🔴 Critical, 🟡 Important, 🟢 Minor).
For each issue, provide: **Title**, **Location**, **Why**, and **Fix**.

### 🚀 Refactor Plan ("Vibe Check")
Identify the **single messiest file**. Provide a step-by-step plan to refactor it to meet {CODING_PHILOSOPHY} standards.

### ✅ Grading Section
Score (1-10) on: {CODING_PHILOSOPHY} Compliance, Security, Error Handling, Performance, {LOGGING_GRADE_IF_DETECTED: Logging & Observability,} {DATABASE_GRADE_IF_DETECTED: Database,} Testing, {ACCESSIBILITY_GRADE_IF_DETECTED: Accessibility,} Maintainability, and Overall.

---

## 7. Action Plan
Prioritized list of steps to resolve the findings with recommended AI model and Antigravity mode.

{GITHUB_MCP_ACTION_PLAN_IF_DETECTED:Before building the action plan, use `mcp_github-mcp-server_search_issues` to check if any findings already have open GitHub issues. If a finding maps to an existing issue, reference it in the "Files Affected" column (e.g., `#42`).}

| Priority | Action | Effort | Files Affected | Recommended Model | Mode |
|:---------|:-------|:------:|:---------------|:------------------|:----:|
| 🔴 High | *action description* | Low/Med/High | *file list or #issue* | *model name* | Fast/Planning |
| 🟡 Medium | *action description* | Low/Med/High | *file list or #issue* | *model name* | Fast/Planning |
| 🟢 Low | *action description* | Low/Med/High | *file list or #issue* | *model name* | Fast/Planning |

### Model Selection Rationale

For the model recommendations in the Action Plan table, use the **AI Model Orchestration** section from the agent's global rules (GEMINI.md). This includes the full model roster, recommended Antigravity modes (Fast/Planning), and the escalation path.

Match actions to models based on complexity:
- Simple mechanical fixes → fastest available model (Fast mode)
- Precision type/security work → mid-tier reasoning model (Planning mode)
- Complex architectural refactoring → deep reasoning model (Planning mode)

---

# [TEMPLATE END]
