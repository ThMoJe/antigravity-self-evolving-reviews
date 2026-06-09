#!/usr/bin/env bash

# Antigravity Self-Evolving Reviews - Local Workspace Installer
# This script installs the plugin locally inside the current workspace's .agent/skills/ and docs/ folders.

set -e

# Colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
GRAY='\033[0;90m'
RED='\033[0;31m'
NC='\033[0;37m' # No Color

echo -e "${CYAN}🌌 Starting Antigravity Self-Evolving Reviews Installer...${NC}"

# 1. Verify Git is installed
if ! command -v git >/dev/null 2>&1; then
    echo -e "${RED}Error: Git is not installed or not in PATH. Please install Git and try again.${NC}" >&2
    exit 1
fi

# 2. Setup paths
WORKSPACE_ROOT=$(pwd)
TEMP_DIR="$WORKSPACE_ROOT/.self-evolving-reviews-temp-$$"

echo -e "${GRAY}📂 Target Workspace: $WORKSPACE_ROOT${NC}"
echo -e "${GRAY}📥 Cloning repository...${NC}"

# 3. Clone the repo to temp folder
if ! git clone --depth 1 "https://github.com/ThMoJe/antigravity-self-evolving-reviews.git" "$TEMP_DIR" 2>/dev/null; then
    echo -e "${RED}Error: Failed to clone repository. Please check your internet connection.${NC}" >&2
    exit 1
fi

# 4. Create local directories if they don't exist
SKILLS_DIR="$WORKSPACE_ROOT/.agent/skills"
DOCS_DIR="$WORKSPACE_ROOT/docs"
OLD_SKILLS_DIR="$WORKSPACE_ROOT/.skills"

# Clean up deprecated .skills directory if it exists
if [ -d "$OLD_SKILLS_DIR" ]; then
    echo -e "${GRAY}🧹 Removing deprecated .skills directory...${NC}"
    rm -rf "$OLD_SKILLS_DIR"
fi

mkdir -p "$SKILLS_DIR"
mkdir -p "$DOCS_DIR"

# 5. Copy skills (overwrite to ensure latest code)
echo -e "${GRAY}⚙️  Installing skills into .agent/skills/ ...${NC}"
cp -R "$TEMP_DIR/skills/"* "$SKILLS_DIR/"

# 6. Copy docs (safely, overwrite only _meta, keep others)
echo -e "${GRAY}📄 Installing prompt templates and report directories...${NC}"

# Always overwrite _meta files
mkdir -p "$DOCS_DIR/prompts/_meta"
cp -R "$TEMP_DIR/docs/prompts/_meta/"* "$DOCS_DIR/prompts/_meta/"

# Recursively copy other files only if they do not exist
cd "$TEMP_DIR/docs"
find . -type f | while read -r file; do
    # Skip _meta files as we already copied them
    if [[ "$file" == *"_meta"* ]]; then
        continue
    fi
    dest_file="$DOCS_DIR/$file"
    if [ ! -f "$dest_file" ]; then
        mkdir -p "$(dirname "$dest_file")"
        cp "$file" "$dest_file"
    fi
done
cd "$WORKSPACE_ROOT"

# 7. Copy template files to workspace root
echo -e "${GRAY}📋 Copying configuration templates...${NC}"
cp -R "$TEMP_DIR/templates/"* "$WORKSPACE_ROOT/"

# 8. Clean up
echo -e "${GRAY}🧹 Cleaning up temporary files...${NC}"
rm -rf "$TEMP_DIR"

echo -e "\n${GREEN}✅ Local installation complete!${NC}"
echo -e "${GREEN}────────────────────────────────────────────────────────${NC}"
echo -e "${GRAY}The following configuration templates are in your workspace root:${NC}"
echo -e "${GRAY}  - _example.GEMINI.md${NC}"
echo -e "${GRAY}  - _example.package.json${NC}"
echo -e "${GRAY}  - _example.knip.jsonc${NC}"
echo -e "${GRAY}  - _example.gitignore${NC}"
echo -e "${GRAY}  - _example.CHANGELOG.md${NC}"
echo -e ""
echo -e "${CYAN}👉 Next Steps:${NC}"
echo -e "${GRAY}  1. Manually merge the _example.* files into your workspace configs.${NC}"
echo -e "${GRAY}  2. Delete the _example.* files after merging.${NC}"
echo -e "${GRAY}  3. Run /generate-review-prompts in your chat to adapt the review prompts to your project.${NC}"
echo -e "${GREEN}────────────────────────────────────────────────────────${NC}"
