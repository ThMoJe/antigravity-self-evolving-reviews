# Meta-Prompt: Optimize Feature Complete Workflow

You are an expert AI development assistant in Antigravity 2. Your task is to analyze the current codebase and generate a highly customized "Feature Complete" workflow (to be saved as `docs/prompts/feature-complete.md`).

This workflow is executed when a user completes a feature. It must be perfectly tailored to the specific tools, project management artifacts, tech stack, and deployment processes of THIS exact workspace.

## Instructions

### 1. Analyze the Workspace Context
Before generating the workflow, actively scan the repository to understand the project's structure:
*   **Tracking**: How are tasks and plans tracked? (e.g., `task.md`, `implementation_plan.md`, `docs/todo.md`).
*   **Documentation**: Where is the high-level roadmap and backlog stored? (e.g., `docs/project/backlog.md`, `docs/roadmap.md`).
*   **Rules & Skills**: Where are global AI rules and modular skills stored? (e.g., `GEMINI.md`, `.agent/skills/`).
*   **Database**: Is a database used? How are schema changes tracked? (e.g., Sequelize models in `server/models`, Prisma schemas, SQL files, Mermaid ER diagrams in `docs/architecture/`).
*   **Versioning**: What is the versioning strategy? (e.g., `CHANGELOG.md`, `package.json` workspaces, `build.gradle`, custom versioning scripts).
*   **Verification**: What are the commands to run type-checks, tests, or builds? (e.g., `npm run type-check`, `pytest`, `cargo test`).

### 2. Generate the Workflow
Create a detailed Markdown document instructing an AI agent on how to execute the Feature Complete process. The generated workflow MUST include the following numbered sections, customized using the findings from Step 1:

**1. Identify the Completed Feature**
Provide instructions on how the AI should parse recent conversation history or task files to understand what was built.

**2. Update Project Management Artifacts**
List the specific files (like `task.md` or `implementation_plan.md`) the AI must check off or mark as complete.

**3. Update Project Documentation**
Provide exact paths to backlog or roadmap files and explain how the AI should move items to "Completed".

**4. Update Project Rules & Modular Skills**
Instruct the AI to update `GEMINI.md` or the `.agent/skills/` directory if the feature introduced new architectural patterns, dependencies, or reusable capabilities.

**5. Update Knowledge Base & Other Docs**
General instructions to ensure no existing documentation contradicts the new reality of the codebase.

**6. Update Database Schema/ER Diagram (Conditional)**
*Include this section ONLY if you detected a database in Step 1.*
Provide specific instructions on how to parse the project's models/migrations and update the relevant Mermaid diagram or schema doc. Provide exact commands (like MCP SQL queries) to verify the diagram against the live DB if applicable.

**7. Create User Guide**
Provide instructions on creating a user-facing guide (if the feature has user-visible impact) and specify the correct directory (e.g., `docs/guides/`).

**8. Update CHANGELOG & Versioning**
Give exact steps to read `git log` and `git diff` to formulate an objective changelog entry. Include specific instructions on how to bump versions based on the project's actual structure (e.g., running `npm version`, updating specific workspace files, or invoking custom version scripts). Outline rules for PATCH vs MINOR/MAJOR bumps.

**9. Final Verification**
List the exact, project-specific terminal commands the AI must run to verify types, tests, and build stability before finishing.

**10. Commit, Tag & Push (USER ACTION)**
Provide the explicit Git commands for the USER to run to commit, tag, and push the release. Include a prominent `> [!IMPORTANT]` alert reminding the AI that Git remote/commit commands are USER-ONLY actions and must not be run autonomously.

### 3. Formatting Constraints
*   Use clear headings, bullet points, and code blocks for readability.
*   Emphasize the **"Source of Truth Principle"**: The executing AI must verify all documentation updates against the *actual codebase*, not its memory.
*   The final output should read as a direct set of instructions to another AI agent executing the workflow.

Generate the optimized `feature-complete.md` workflow based on these instructions. Save the output to `docs/prompts/feature-complete.md`.
