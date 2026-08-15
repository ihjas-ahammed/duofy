# Duofy Reusable Lesson Format: Algebraic Combinatorics - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Algebraic_Combinatorics`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## Continental Blueprint & Objective
Train students to calculate hook length product formula counts $f^\lambda = \frac{n!}{\prod h(i,j)}$, execute RSK row insertions, and check Matroid rank function properties $r(A \cup B) + r(A \cap B) \le r(A) + r(B)$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hook Length Formula Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Hook Calculation Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Partition Diagram Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative SYT Count Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | RSK Evacuation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Hook Length Calculation for Partition $\\lambda = (3, 2) \\vdash 5$**\nFerrers diagram for $(3, 2)$ has 5 boxes:\nRow 1: (1,1), (1,2), (1,3)\nRow 2: (2,1), (2,2)\nHook length formula: $f^{(3,2)} = \\frac{5!}{\\prod h(i,j)}$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Calculate hook lengths for Row 1:\n  $h(1,1) = 4$ (cells right: 2, below: 1, self: 1),\n  $h(1,2) = 3$ (cells right: 1, below: 1, self: 1),\n  $h(1,3) = 1$.\n• **Step 2:** Calculate hook lengths for Row 2:\n  $h(2,1) = 2$ (cells right: 1, below: 0, self: 1),\n  $h(2,2) = 1$.\n• **Step 3:** Hook product: $4 \\times 3 \\times 1 \\times 2 \\times 1 = 24$.\n• **Step 4:** $f^{(3,2)} = \\frac{5!}{24} = \\frac{120}{24} = 5$ SYTs."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "Visual grid representation of an integer partition lambda into rows of dots or boxes is called a ___ diagram.",
      "blankAnswer": "ferrers",
      "blankDistractors": ["young", "dynkin", "voronoi"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the number of standard Young tableaux $f^{(2,2)} = \\frac{4!}{\\prod h(i,j)}$ for square shape $\\lambda = (2,2) \\vdash 4$ (hook lengths: 3,2 in row 1; 2,1 in row 2).",
      "numericAnswer": 2.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In RSK correspondence, if permutation $\\sigma = (2, 1, 3)$ maps to insertion tableau $P$, what is the shape of $P$?",
      "options": [
        { "text": "Partition λ = (2, 1) ⊢ 3", "isCorrect": true, "explanation": "Correct! Insert 2 -> [2]. Insert 1 bumps 2 -> row 1: [1], row 2: [2]. Insert 3 -> row 1: [1, 3], row 2: [2]. Shape is (2, 1)." },
        { "text": "Partition λ = (3) ⊢ 3", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Partition λ = (1, 1, 1) ⊢ 3", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Partition λ = (2, 2)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
