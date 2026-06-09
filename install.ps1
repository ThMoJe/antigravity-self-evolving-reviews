# Antigravity Self-Evolving Reviews - Local Workspace Installer
# This script installs the plugin locally inside the current workspace's .agent/skills/ and docs/ folders.

$ErrorActionPreference = "Stop"

Write-Host "🌌 Starting Antigravity Self-Evolving Reviews Installer..." -ForegroundColor Cyan

# 1. Verify Git is installed
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "Git is not installed or not in PATH. Please install Git and try again."
    exit 1
}

# 2. Setup paths
$workspaceRoot = Get-Location
$tempDir = Join-Path $workspaceRoot ".self-evolving-reviews-temp-$pid"

Write-Host "📂 Target Workspace: $workspaceRoot" -ForegroundColor Gray
Write-Host "📥 Cloning repository..." -ForegroundColor Gray

# 3. Clone the repo to temp folder
try {
    git clone --depth 1 "https://github.com/ThMoJe/antigravity-self-evolving-reviews.git" $tempDir
} catch {
    Write-Error "Failed to clone repository. Please check your internet connection."
    exit 1
}

# 4. Create local directories if they don't exist
$skillsDir = Join-Path $workspaceRoot ".agent\skills"
$docsDir = Join-Path $workspaceRoot "docs"
$oldSkillsDir = Join-Path $workspaceRoot ".skills"

# Clean up deprecated .skills directory if it exists
if (Test-Path $oldSkillsDir) {
    Write-Host "🧹 Removing deprecated .skills directory..." -ForegroundColor Gray
    Remove-Item -Path $oldSkillsDir -Recurse -Force
}

if (-not (Test-Path $skillsDir)) {
    Write-Host "📁 Creating .agent/skills directory..." -ForegroundColor Gray
    New-Item -ItemType Directory -Path $skillsDir -Force | Out-Null
}
if (-not (Test-Path $docsDir)) {
    Write-Host "📁 Creating docs directory..." -ForegroundColor Gray
    New-Item -ItemType Directory -Path $docsDir | Out-Null
}

# 5. Copy skills (overwrite to ensure latest code)
Write-Host "⚙️  Installing skills into .agent/skills/ ..." -ForegroundColor Gray
Copy-Item -Path "$tempDir\skills\*" -Destination $skillsDir -Recurse -Force

# 6. Copy docs (safely, overwrite only _meta, keep others)
Write-Host "📄 Installing prompt templates and report directories..." -ForegroundColor Gray

Get-ChildItem -Path "$tempDir\docs" -Recurse | ForEach-Object {
    $relPath = $_.FullName.Substring("$tempDir\docs".Length)
    $destPath = Join-Path $docsDir $relPath
    
    if ($_.PsIsContainer) {
        if (-not (Test-Path $destPath)) {
            New-Item -ItemType Directory -Path $destPath | Out-Null
        }
    } else {
        # Always overwrite _meta files
        if ($_.FullName -like "*_meta*") {
            Copy-Item -Path $_.FullName -Destination $destPath -Force
        } elseif (-not (Test-Path $destPath)) {
            # Only copy non-meta files (scaffolds, known patterns) if they don't already exist
            Copy-Item -Path $_.FullName -Destination $destPath
        }
    }
}

# 7. Copy template files to workspace root
Write-Host "📋 Copying configuration templates..." -ForegroundColor Gray
Get-ChildItem -Path "$tempDir\templates" -File | ForEach-Object {
    $destFile = Join-Path $workspaceRoot $_.Name
    Copy-Item -Path $_.FullName -Destination $destFile -Force
}

# 8. Clean up
Write-Host "🧹 Cleaning up temporary files..." -ForegroundColor Gray
if (Test-Path $tempDir) {
    Remove-Item -Path $tempDir -Recurse -Force
}

Write-Host "`n✅ Local installation complete!" -ForegroundColor Green
Write-Host "────────────────────────────────────────────────────────" -ForegroundColor Green
Write-Host "The following configuration templates are in your workspace root:" -ForegroundColor Gray
Write-Host "  - _example.GEMINI.md" -ForegroundColor Gray
Write-Host "  - _example.package.json" -ForegroundColor Gray
Write-Host "  - _example.knip.jsonc" -ForegroundColor Gray
Write-Host "  - _example.gitignore" -ForegroundColor Gray
Write-Host "  - _example.CHANGELOG.md" -ForegroundColor Gray
Write-Host ""
Write-Host "👉 Next Steps:" -ForegroundColor Cyan
Write-Host "  1. Manually merge the _example.* files into your workspace configs." -ForegroundColor Gray
Write-Host "  2. Delete the _example.* files after merging." -ForegroundColor Gray
Write-Host "  3. Run /generate-review-prompts in your chat to adapt the review prompts to your project." -ForegroundColor Gray
Write-Host "────────────────────────────────────────────────────────" -ForegroundColor Green
