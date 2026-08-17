# Duofy Reusable Lesson Format: Continuous Integration (Trunk-Based Development and Automated Gates)

**Target Topic:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Software_Testing_and_Quality_Assurance / CI_CD_Pipelines`  
**Lesson Format Type:** `continuous_integration_trunk_based_development_and_automated_gates`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the version control discipline, automated validation gates, and artifact promotion mechanics of Continuous Integration (Martin Fowler 2006 *Continuous Integration*; Jez Humble & David Farley 2010 *Continuous Delivery* Chapter 3; Nicole Forsgren et al. *Accelerate*): analyze why GitFlow with long-lived feature branches causes catastrophic "Merge Hell" integration bottlenecks, master **Trunk-Based Development** (merging small, frequent commits into the mainline `main` branch multiple times daily), trace the **Automated CI Quality Gate Pipeline** (**1. Lint & Formatting $\to$ 2. Incremental Build/Compile $\to$ 3. Fast Unit Test Suite [$<2\text{ min}$] $\to$ 4. Static Application Security Testing SAST & SonarQube Quality Gates $\to$ 5. Dependency Vulnerability Scanning [Trivy/Snyk] $\to$ 6. Immutable OCI Docker Image Build with SHA-256 Digest**), and enforce the **10-Minute Pipeline Feedback Invariant**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Trunk-Based CI Pipeline Flow Diagram, 6 Automated Quality Gates Reference Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Chronological Execution of an Automated CI Pipeline from Git Push to Artifact Push Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | CI Pipeline Stage / Security Gate & Engineering Failure Detection Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Development Practice Where Engineers Merge Code into Mainline Multiple Times Daily Is ___-Based Development (Trunk) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why Trunk-Based Development with Short-Lived Branches Outperforms Long-Lived GitFlow Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Continuous Integration (Fowler 2006; Humble & Farley Ch 3):
   - **The Automated CI Quality Gate Flow:**
     $$\mathbf{\text{Git Push (Trunk)}} \xrightarrow{\text{Gate 1}} \mathbf{\text{Lint/Format}} \xrightarrow{\text{Gate 2}} \mathbf{\text{Compile}} \xrightarrow{\text{Gate 3}} \mathbf{\text{Unit Tests}} \xrightarrow{\text{Gate 4}} \mathbf{\text{SAST/Sonar}} \xrightarrow{\text{Gate 5}} \mathbf{\text{Sec Scan}} \xrightarrow{\text{Gate 6}} \mathbf{\text{Docker OCI Image (SHA)}}$$
   - **The 3 Rules of Continuous Integration (Martin Fowler):**
     1. Maintain a single source repository (Trunk-Based).
     2. Automate the build and every commit runs all tests on an integration machine.
     3. Keep the build fast: Feedback delivered in **$<10\text{ minutes}$**!
   - **Immutable Artifact Rule:** Build the Docker image **EXACTLY ONCE** in CI; promote the exact same SHA-256 digest to test, staging, and production!
2. **Slide 2 (`ordering`):** Provide 5 steps of CI pipeline execution: (1) developer merges short-lived branch into main, triggering GitHub Actions / GitLab CI webhook, (2) runner checks out code, checks linting/formatting, and compiles source code, (3) runner executes in-memory unit test suite asserting 100% pass rate, (4) static analysis security scanner (SAST) and SonarQube quality gate evaluate code coverage and vulnerabilities, (5) runner builds immutable Docker container image tagged with commit SHA and pushes to secure container registry!
3. **Slide 3 (`matching`):** Pair 4 concepts (Trunk-Based Development, Static Application Security Testing SAST, Immutable Artifact Principle, SonarQube Quality Gate) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Trunk-based development. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Trunk-Based Development vs GitFlow: Why did empirical DevOps research across thousands of engineering teams (*Accelerate* / DORA) reveal that Trunk-Based Development significantly outperforms complex branching models like GitFlow in both delivery speed and system stability? (GitFlow encourages long-lived feature branches that diverge from the main codebase for weeks or months, creating massive merge conflicts, hidden integration regressions, and delayed feedback; **Trunk-Based Development mandates that developers merge small code increments into `main` at least once per day, ensuring that merge conflicts are tiny and resolved immediately within minutes, integration regressions are detected instantly by automated CI gates**, and software is continuously releasable).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "continuous_integration_trunk_based_development_and_automated_gates",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Continuous Integration \\& Automated Quality Gates (Fowler 2006; Humble 2010)**\n• **The 6-Stage Automated CI Verification Pipeline:**\n$$\n\\mathbf{\\text{Commit}} \\to \\mathbf{\\text{1. Lint/Format}} \\to \\mathbf{\\text{2. Compile}} \\to \\mathbf{\\text{3. Unit Tests}} \\to \\mathbf{\\text{4. SAST/Sonar}} \\to \\mathbf{\\text{5. CVE Scan}} \\to \\mathbf{\\text{6. Immutable OCI Image}}\n$$\n• **Trunk-Based Development Invariant (Forsgren et al. *Accelerate*):**\n  - Developers merge small, short-lived branches into $\\mathbf{\\texttt{main}}$ **multiple times daily**.\n  - Eliminates 'Merge Hell' by keeping codebase divergence bounded to hours rather than months!\n• **The Immutable Artifact Rule:** Build the binary / Docker container **EXACTLY ONCE** in CI; promote the **exact same SHA-256 image digest across all staging and production environments**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential verification stages executed by an automated CI pipeline upon a git push to the main branch.",
      "orderItems": [
        "Git webhook triggers ephemeral CI runner agent which checks out source code and validates syntax and formatting linters",
        "Runner compiles source code dependencies into executable bytecode and runs all fast, in-memory Unit Tests",
        "Static Application Security Testing (SAST) and SonarQube quality gates evaluate cyclomatic complexity and code coverage thresholds",
        "Container security scanner (e.g. Trivy/Snyk) scans third-party library dependencies for known CVE vulnerabilities",
        "Runner builds the immutable Docker container image, tags it with the immutable Git commit SHA-256 digest, and pushes to OCI Registry"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each CI Pipeline Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Trunk-Based Development", "right": "Version control practice of merging small, frequent code updates directly into mainline trunk" },
        { "left": "SAST (Static Security Testing)", "right": "Automated source code analysis scanning for security flaws (e.g. SQL injection, hardcoded secrets)" },
        { "left": "Immutable Artifact Principle", "right": "Building and signing a container image once with SHA digest to guarantee identical bits across environments" },
        { "left": "SonarQube Quality Gate", "right": "Automated blocker halting pipeline if test coverage drops or new critical bugs are introduced" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The version control practice where developers merge small code increments into main multiple times daily is ___-based development.",
      "blankAnswer": "Trunk",
      "blankDistractors": ["Feature", "Release", "Branch"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why did extensive empirical DevOps research across thousands of companies (Forsgren et al. *Accelerate*) prove that Trunk-Based Development significantly outperforms traditional GitFlow branching in both delivery throughput and production stability?",
      "options": [
        { "text": "GitFlow encourages developers to maintain long-lived feature branches that diverge from the main codebase for weeks or months, creating massive, painful merge conflicts, delayed integration testing, and hidden cross-team regressions; Trunk-Based Development requires engineers to merge small, localized increments into the shared main branch at least once per day, ensuring merge conflicts are tiny and resolved immediately in minutes, integration bugs are caught instantly by automated CI pipelines, and the mainline codebase remains continuously releasable at all times", "isCorrect": true, "explanation": "Correct! This is one of the most significant empirical findings in modern software engineering (Nicole Forsgren, Jez Humble, Gene Kim *Accelerate: The Science of Lean Software and DevOps* Chapter 4). 1. **The GitFlow Failure Mode (Long-Lived Branches):** - 5 developers create separate feature branches. They work in isolation for 6 weeks. - In week 7, Developer 1 merges $\\implies$ Easy. - Developer 2 merges $\\implies$ 40 merge conflicts. - Developer 5 merges $\\implies$ **3,000 merge conflicts, broken builds, and 2 weeks of 'merge stabilization' hell!** - While branches were isolated, nobody knew the system was broken. 2. **Trunk-Based Development (Daily Integration):** - Every developer creates short-lived branches lasting **$<1\\text{ day}$** and merges back to `main`. - Feature incomplete? Use **Feature Flags (Toggles)** to hide unfinished code in production! - Merge conflicts are trivial (1 or 2 lines). - Automated CI runs 10 times a day on `main`, guaranteeing that regressions are detected within 5 minutes of being introduced. 3. **The Data:** Teams using Trunk-Based Development achieve **$200\\times$ more frequent deployments and $3\\times$ lower change failure rates**!" },
        { "text": "Because GitFlow can only be used with Subversion and not Git", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Trunk-Based Development eliminates the need to write unit tests", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Git branches require purchasing additional hardware licenses", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
