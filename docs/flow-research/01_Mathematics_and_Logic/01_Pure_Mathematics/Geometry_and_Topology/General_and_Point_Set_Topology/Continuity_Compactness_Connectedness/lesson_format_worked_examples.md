# Duofy Reusable Lesson Format: Continuity, Compactness, and Connectedness - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / General_and_Point_Set_Topology / Continuity_Compactness_Connectedness`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly evaluate topological continuity via preimages in non-standard topologies (e.g. Cofinite topology vs Standard topology on $\mathbb{R}$), analyze connectedness vs path-connectedness in the **Topologist's Sine Curve**, and verify the Finite Intersection Property (FIP).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cofinite Topology Continuity Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Preimage Analysis Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Constant Map Triviality Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Connected Component Count | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Topologist's Sine Curve Non-Path-Connected Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the worked problem: Let $f: (\mathbb{R}, \mathcal{T}_{\text{std}}) \to (\mathbb{R}, \mathcal{T}_{\text{cofinite}})$ where open sets in $\mathcal{T}_{\text{cofinite}}$ have finite complements. Which functions $f(x)$ are continuous?
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) let $U \in \mathcal{T}_{\text{cofinite}}$, so $U^c = \{y_1, \dots, y_k\}$ is finite, (2) $f^{-1}(U)^c = f^{-1}(U^c) = \bigcup_{i=1}^k f^{-1}(\{y_i\})$, (3) for $f^{-1}(U)$ to be open in standard $\mathbb{R}$, its complement $\bigcup f^{-1}(\{y_i\})$ must be closed in standard $\mathbb{R}$, (4) since singletons $\{y_i\}$ are closed in $\mathbb{R}_{\text{std}}$, *every* standard continuous function $f(x)$ is continuous from $\mathbb{R}_{\text{std}}$ to $\mathbb{R}_{\text{cofinite}}$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that in any topological space, every constant function is continuous. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the number of connected components in the disconnected topological space $X = (0, 1) \cup (2, 3) \cup (4, 5)$ in $\mathbb{R}_{\text{std}}$ (component count = 3.0).
5. **Slide 5 (`quiz`):** Quiz asking why the Topologist's Sine Curve $S = \{(x, \sin(1/x)) \mid x \in (0, 1]\} \cup \{(0, y) \mid y \in [-1, 1]\}$ is connected but NOT path-connected (any path from the curve to the vertical axis segment requires infinite oscillations, violating continuity at $t_0$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Continuity into the Cofinite Topology**\nLet $f: (\\mathbb{R}, \\mathcal{T}_{\\text{std}}) \\to (\\mathbb{R}, \\mathcal{T}_{\\text{cofinite}})$ be a map from standard real line to the cofinite real line.\n• In $\\mathcal{T}_{\\text{cofinite}}$, a set $U$ is open $\\iff U^c$ is finite (or $U = \\emptyset$).\n• $f$ is continuous $\\iff f^{-1}(U)$ is open in $\\mathcal{T}_{\\text{std}}$ for every cofinite open set $U$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Preimage of Complement):** Let $U \\in \\mathcal{T}_{\\text{cofinite}}$ with $U^c = \\{y_1, \\dots, y_k\\}$ finite. Then $f^{-1}(U)^c = f^{-1}(U^c) = \\bigcup_{i=1}^k f^{-1}(\\{y_i\\})$.\n• **Step 2 (Closed Preimages):** $f^{-1}(U)$ is open in standard $\\mathbb{R} \\iff f^{-1}(U)^c$ is closed in standard $\\mathbb{R}$.\n• **Step 3 (Standard Continuous Functions):** If $f$ is continuous in the standard sense, the preimage of each closed singleton $\\{y_i\\}$ is closed in $\\mathbb{R}_{\\text{std}}$.\n• **Step 4 (Conclusion):** The finite union of closed sets is closed, so **every standard continuous function** $f(x)$ (e.g. polynomials, exponentials) is continuous into the cofinite topology!"
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "Between any two topological spaces X and Y, every function that maps every point of X to a single fixed point in Y is strictly ___.",
      "blankAnswer": "continuous",
      "blankDistractors": ["open", "closed", "homeomorphic"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "How many connected components make up the subspace X = (0, 1) union (2, 3) union (4, 5) of the real line?",
      "numericAnswer": 3.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the Topologist's Sine Curve T = {(x, sin(1/x)) | x in (0, 1]} union ({0} x [-1, 1]) NOT path-connected?",
      "options": [
        { "text": "Any continuous path gamma: [0, 1] -> T starting on the vertical segment {0} x [-1, 1] and reaching the curve must oscillate infinitely fast as x -> 0+, which violates continuity of the path at the boundary", "isCorrect": true, "explanation": "Correct! Because sin(1/x) oscillates infinitely many times near x = 0, no continuous path can bridge the vertical line to the curve." },
        { "text": "Because the space is not connected", "isCorrect": false, "explanation": "Incorrect: It is connected because it is the closure of a connected graph." },
        { "text": "Because the space is unbounded", "isCorrect": false, "explanation": "Incorrect: It is bounded inside [0, 1] x [-1, 1]." },
        { "text": "Because the vertical line is open", "isCorrect": false, "explanation": "Incorrect: The vertical line is closed." }
      ]
    }
  ]
}
```
