# Sample Spring Cleaning Report

> [!WARNING]
> **This is a sample placeholder file.** It will be **replaced** by an actual report the first time you run `/run-spring-cleaning`.
> The real report will be saved as `docs/reports/spring-cleaning/spring-cleaning-report-{YYYY-MM-DD}.md`.

---

## What a Real Spring Cleaning Report Looks Like

### Summary Statistics

| Category | Count | Estimated Cleanup Effort |
|:---------|:------|:------------------------|
| Dead Code Files | — | — |
| Unused Dependencies | — | — |
| Stale Files (>6 months) | — | — |
| Orphaned Imports | — | — |

---

### High Priority Items

#### 🔴 [File or Dependency Name]
- **Location**: `path/to/file.ts` or `package.json`
- **Reason**: Not imported anywhere / Last commit 9 months ago
- **Action**: Safe to delete / Update to vX.Y.Z

---

### Medium Priority Items

- ...

---

### Low Priority Items

- ...

---

### Files Protected from Cleanup

The following are intentionally protected from spring cleaning:
- `skills/` — Global plugin skill files (procedural runbooks)
- `docs/prompts/_meta/` — Meta-prompt source files
- `docs/reports/` — Historical audit trail

---

**To generate a real report**: Run `/run-spring-cleaning` in your workspace.
