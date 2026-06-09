---
name: setup-reviews
description: Initializes the workspace with self-evolving reviews configurations, templates, prompts, and report directories.
---

# Setup Reviews Skill

This skill bootstraps a new workspace with the self-evolving reviews system. It copies sample prompt/report scaffolds and example configuration templates from the plugin directory, then prints step-by-step merge instructions.

> [!IMPORTANT]
> This skill **never** overwrites existing files in the workspace. All configuration templates are copied with an `_example.` prefix, requiring a manual merge step by the developer.

## Step 1: Locate the Plugin Directory

Determine the installed plugin path. The plugin is installed at one of these standard locations:

- **Windows (typical):** `C:\Users\<Username>\.gemini\config\plugins\antigravity-self-evolving-reviews\`
- **Windows (alt):** `%APPDATA%\antigravity\config\plugins\antigravity-self-evolving-reviews\`

Resolve the actual path by checking if the `plugin.json` file exists at each location. Use the first valid path found.

## Step 2: Copy the `docs/` Folder to the Workspace

Recursively copy the entire `docs/` directory from the plugin directory into the **active workspace root**:

```powershell
# Example — adjust paths as needed
$pluginDir = "$env:USERPROFILE\.gemini\config\plugins\antigravity-self-evolving-reviews"
$workspaceRoot = "<ACTIVE_WORKSPACE_ROOT>"

Copy-Item -Path "$pluginDir\docs" -Destination "$workspaceRoot\docs" -Recurse -Force
```

> [!NOTE]
> The `docs/` folder contains sample prompt and report files with **disclaimer banners** indicating they are placeholders. They will be overwritten on the first actual run of `/generate-review-prompts` (for prompts) or the respective review workflows (for reports).

## Step 3: Copy Template Files to Workspace Root

Copy all files from the plugin's `templates/` directory into the **active workspace root** (they already have the `_example.` prefix):

```powershell
Get-ChildItem -Path "$pluginDir\templates" -File | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination "$workspaceRoot\$($_.Name)" -Force
}
```

This will place the following files in the workspace root:
- `_example.GEMINI.md`
- `_example.package.json`
- `_example.knip.jsonc`
- `_example.gitignore`
- `_example.CHANGELOG.md`

## Step 4: Display Manual Merge Instructions

After copying, display the following instructions to the user:

---

✅ **Setup Complete!** The following files have been copied to your workspace root:

| Template File | Merge Target |
|:-------------|:-------------|
| `_example.GEMINI.md` | `GEMINI.md` (create if missing, or merge relevant sections) |
| `_example.package.json` | `package.json` (merge scripts, dependencies, name/version) |
| `_example.knip.jsonc` | `knip.jsonc` (merge workspace entries for your monorepo structure) |
| `_example.gitignore` | `.gitignore` (append or merge entries you don't already have) |
| `_example.CHANGELOG.md` | `CHANGELOG.md` (create if missing; do not overwrite an existing one) |

> [!TIP]
> **Feature Planning**: Use `/run-feature-plan` to generate implementation plans for new features. This skill conducts pre-flight reconnaissance and produces a structured plan ready for dual-model review.

**Next Steps:**

1. Open each `_example.*` file and compare it to the existing file (if any) in your workspace root.
2. Manually merge or adopt the configurations you need.
3. Delete the `_example.*` files once you have merged their content.
4. Run `/generate-review-prompts` to generate workspace-tailored review prompts from the meta-prompts in `docs/prompts/_meta/`.

> [!TIP]
> A future release may introduce an automated merge helper. For now, manual merging ensures you don't accidentally overwrite project-critical configurations.

---
