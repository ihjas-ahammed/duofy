# Duofy Reusable Lesson Format: Algebraic & Differential Topology - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Algebraic_and_Differential_Topology`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute fundamental groups $\pi_1(X)$ via Van Kampen's Theorem, evaluate simplicial/singular homology groups $H_k(X)$, and compute Betti numbers $b_k$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Simplicial Complex Homology Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Boundary Matrix Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Boundary Operator Kernel Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Betti Number Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Van Kampen Free Product Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Computing Homology of 2-Sphere $S^2$**\nUsing a simple 2-simplex triangulation (boundary of a tetrahedron with 4 vertices $V$, 6 edges $E$, 4 faces $F$):\n$$\nC_2 \\xrightarrow{\\partial_2} C_1 \\xrightarrow{\\partial_1} C_0 \\xrightarrow{\\partial_0} 0\n$$\n$\\text{Rank}(\\text{Ker } \\partial_1) = 3$, $\\text{Rank}(\\text{Im } \\partial_2) = 3 \\implies H_1(S^2) = 0$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** $C_0 \\cong \\mathbb{Z}^4$ (vertices $v_0, v_1, v_2, v_3$). $C_1 \\cong \\mathbb{Z}^6$ (edges). $C_2 \\cong \\mathbb{Z}^4$ (faces).\n• **Step 2:** $\\partial_1([v_i, v_j]) = v_j - v_i$. $\\text{Rank}(\\text{Im } \\partial_1) = 4 - 1 = 3$.\n• **Step 3:** $\\text{Dim}(\\text{Ker } \\partial_1) = 6 - 3 = 3$.\n• **Step 4:** $\\text{Rank}(\\text{Im } \\partial_2) = 3$. Thus $H_1(S^2) = 3/3 = 0$. $H_2(S^2) = 4 - 3 = 1 (\\mathbb{Z})$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In calculating homology groups H_k = Ker(∂_k) / Im(∂_{k+1}), elements in Ker(∂_k) are called k-___.",
      "blankAnswer": "cycles",
      "blankDistractors": ["boundaries", "chains", "simplices"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "What is the first Betti number $b_1$ of the Figure-Eight space ($S^1 \\vee S^1$)?",
      "numericAnswer": 2.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the fundamental group $\\pi_1(\\mathbb{R P}^2)$ of the Real Projective Plane?",
      "options": [
        { "text": "Cyclic group Z₂ of order 2", "isCorrect": true, "explanation": "Correct! Non-orientable RP² has π₁ ≅ Z₂, where a loop around the boundary antipodal identification is order 2." },
        { "text": "Z", "isCorrect": false, "explanation": "Incorrect: That describes S¹." },
        { "text": "{0}", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Z × Z", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
