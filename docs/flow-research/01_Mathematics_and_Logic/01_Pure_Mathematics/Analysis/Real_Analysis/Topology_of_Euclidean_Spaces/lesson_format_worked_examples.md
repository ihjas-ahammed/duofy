# Duofy Reusable Lesson Format: Topology of Euclidean Spaces - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Real_Analysis / Topology_of_Euclidean_Spaces`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute the interior $\text{int}(E)$, closure $\bar{E}$, boundary $\partial E$, and set of limit points $E'$ for composite Euclidean subsets (e.g. $E = (0, 1] \cup \{2\} \cup (\mathbb{Q} \cap [3, 4])$ in $\mathbb{R}$), and verify compactness.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Composite Set Anatomy Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Topological Decomposition Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Boundary Set Intersection Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Isolated Point Count | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Non-Compact Closure Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the worked set: Let $E = (0, 1] \cup \{2\}$ in $\mathbb{R}$. Determine its interior, closure, boundary, and isolated points.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) Interior $\text{int}(E) = (0, 1)$ (points with open neighborhoods inside $E$), (2) Closure $\bar{E} = [0, 1] \cup \{2\}$ (set plus limit points), (3) Boundary $\partial E = \bar{E} \setminus \text{int}(E) = \{0, 1, 2\}$, (4) Isolated points: $x = 2$ is an isolated point since $(1.5, 2.5) \cap E = \{2\}$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the boundary of a set equals the closure minus the interior. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to count the number of isolated points in $S = (0, 1) \cup \{3\} \cup \{5\} \cup \{7\}$ (isolated point count = 3.0).
5. **Slide 5 (`quiz`):** Quiz asking: Is the set $E = (0, 1] \cup \{2\}$ compact in $\mathbb{R}$? (No, because it is not closed: $0$ is a limit point of $E$ but $0 \notin E$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Anatomy of a Subset $E = (0, 1] \\cup \\{2\\} \\subset \\mathbb{R}$**\n• **Interior $\\text{int}(E)$:** The set of points possessing an open neighborhood completely contained in $E$.\n• **Closure $\\bar{E}$:** The union of $E$ and all its limit points ($E \\cup E'$).\n• **Boundary $\\partial E$:** $\\partial E = \\bar{E} \\setminus \\text{int}(E) = \\bar{E} \\cap \\overline{\\mathbb{R} \\setminus E}$.\n• **Isolated Points:** Points $x \\in E$ for which there exists $\\epsilon > 0$ such that $(x-\\epsilon, x+\\epsilon) \\cap E = \\{x\\}$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Find Interior):** Open balls around points in $(0, 1)$ stay in $E$. Neither $1$ nor $2$ has a two-sided ball in $E$. Thus $\\text{int}(E) = (0, 1)$.\n• **Step 2 (Find Closure):** Limit points of $(0, 1]$ form $[0, 1]$. Point $2$ is isolated. Thus $\\bar{E} = [0, 1] \\cup \\{2\\}$.\n• **Step 3 (Find Boundary):** $\\partial E = ([0, 1] \\cup \\{2\\}) \\setminus (0, 1) = \\{0, 1, 2\\}$.\n• **Step 4 (Isolated Points):** The point $x = 2$ is isolated; $x = 1$ is a limit point."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In any topological space, the boundary of a subset E is formally defined as the set difference between the closure and the ___.",
      "blankAnswer": "interior",
      "blankDistractors": ["complement", "domain", "subspace"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "How many isolated points are contained in the set S = (0, 1) union {3} union {5} union {7}?",
      "numericAnswer": 3.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Is the set E = (0, 1] union {2} compact in the Euclidean metric space R?",
      "options": [
        { "text": "No, because E is bounded but not closed (the limit point 0 is not in E)", "isCorrect": true, "explanation": "Correct! Since 0 in E' but 0 not in E, E is not closed, so by Heine-Borel it fails to be compact." },
        { "text": "Yes, because E is bounded", "isCorrect": false, "explanation": "Incorrect: Being bounded is not sufficient; the set must also be closed." },
        { "text": "Yes, because {2} is compact", "isCorrect": false, "explanation": "Incorrect: The entire set E must be closed." },
        { "text": "No, because E is unbounded", "isCorrect": false, "explanation": "Incorrect: E is bounded inside [-1, 3]." }
      ]
    }
  ]
}
```
