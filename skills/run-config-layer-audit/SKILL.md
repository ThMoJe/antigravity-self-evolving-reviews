---
name: run-config-layer-audit
description: Audits and harmonizes all configuration layers (GEMINI.md, Skills, docs, MCP servers) to resolve inconsistencies.
---

# Run Config Layer Audit Skill

Performs a comprehensive audit of all configuration surfaces to ensure information is in the right layer, cross-references are correct, and no duplication exists across GEMINI.md, Skills, docs/, and the Knowledge Base.

## Prerequisites

Before running this audit, ensure access to:
- `~/.gemini/GEMINI.md` (Global Rules)
- `GEMINI.md` (Project Root — Local Rules)
- All Skills in `skills/*/SKILL.md` (global plugin skills)
- The `docs/` directory tree
- The Antigravity Knowledge base at `~/.gemini/antigravity/knowledge`

---

## Phase 1: Inventory (PLANNING mode)

1. **Catalog All Configuration Surfaces**:
   - Read `~/.gemini/GEMINI.md` and list all sections with line counts.
   - Read `GEMINI.md` (workspace root) and list all sections with line counts.
   - Read every `SKILL.md` in `skills/*/` and list their `name` + `description`.
   - List all files in `docs/guides/`, `docs/architecture/`, `docs/prompts/`, and `docs/project/`.
   - List all knowledge items in `~/.gemini/antigravity/knowledge`.
   - List all MCP servers and their capabilities.

2. **Build the Overlap Matrix**:
   Create a markdown table showing which topics appear in more than one layer:

   | Topic | Global GEMINI | Local GEMINI | Skill | docs/ | KI |
   |:------|:-------------|:-------------|:------|:------|:---|
   | (fill in) | ✅/❌ | ✅/❌ | which? | which file? | which KI? |

---

## Phase 2: Apply the Decision Matrix (PLANNING mode)

For each piece of content found in Phase 1, classify it using this decision tree:

| Question | If Yes → |
|:---------|:---------|
| Does the AI need this in **every** conversation? | → **GEMINI.md** (global or local) |
| Is this a step-by-step **procedure** for a specific domain? | → **Skill** |
| Is this a slash-command multi-step **process**? | → **Skill** |
| Is this explaining a feature for **human onboarding**? | → **`docs/guides/`** |
| Is this tracking **project status** or backlog? | → **`docs/project/`** |
| Is this a **design rationale** or architecture decision? | → **`docs/architecture/`** |
| Is this **live data** to query at runtime? | → **MCP Server** |
| Is this a **recurring issue/solution** or persistent context? | → **Knowledge Base** |

Flag any content that is in the wrong layer or duplicated across layers.

---

## Phase 3: Duplication Removal (EXECUTION mode)

For each duplication found in Phase 2:
1. Identify the **canonical location** (where the content should live per the Decision Matrix).
2. In the **non-canonical location**, replace the content with a 1-2 line pointer:
   - Example: `⚠️ For database schema changes, follow the project-migrations skill.`
   - Example: `See docs/guides/clerk-webhooks.md for full webhook architecture.`
3. Ensure the canonical source is complete and up-to-date.

**Key principle:** GEMINI.md should contain only rules and constants. Procedures belong in Skills. Explanations belong in docs.

---

## Phase 4: Cross-Reference Harmony (EXECUTION mode)

Verify that Skills and `docs/guides/` cross-reference each other correctly:

1. For each **Skill**, verify its instructions reference the correct workspace `docs/` files.
2. For each **`docs/guides/` file** that has a matching Skill, add a note:
   > 🤖 **AI agents**: Follow the `[skill-name]` skill when performing this task.
3. Verify no `docs/guides/` file contains step-by-step procedures that should be in a Skill instead.

---

## Phase 5: Staleness Check (VERIFICATION mode)

1. Check that GEMINI.md sections reference correct:
   - Stack versions (React, Vite, Node, etc.)
   - File paths that still exist
   - Naming conventions that match actual codebase patterns

2. Verify MCP server table in GEMINI.md lists all currently configured servers.

3. **Knowledge Base Audit**: Review all items in the Antigravity Knowledge base:
   - Identify and remove any obsolete or outdated information
   - Ensure remaining information is up-to-date with the current project state

---

## Phase 6: Report (VERIFICATION mode)

Generate a summary report saved as an artifact in the conversation brain directory with:

1. **Changes Made**: Table of what was moved, removed, or updated.
2. **Cross-References Added**: List of docs ↔ skill links created.
3. **Stale Items Found**: Items flagged for manual review.
4. **Token Impact**: Estimated token savings from GEMINI.md deduplication.
5. **Knowledge Base Updates**: List of knowledge items removed or updated.
6. **Recommendations**: Any new Skills or docs suggested based on uncovered gaps.

---

## Maintenance Checklist (run after every `/run-feature-complete`)

- [ ] Update affected Skills with new procedures or gotchas
- [ ] Verify GEMINI.md pointers still reference correct skill names
- [ ] Check if any `docs/guides/` need a cross-reference update
- [ ] Verify no file path references in any layer point to deleted files
- [ ] Ensure Antigravity Knowledge base is up to date and obsolete items are removed
