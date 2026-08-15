# Duofy Reusable Lesson Format: Inner Product Spaces - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Linear_Algebra_and_Matrix_Theory / Inner_Product_Spaces`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to execute the Gram-Schmidt Orthogonalization process, compute orthogonal projections $P_W \mathbf{v}$, and evaluate continuous function inner products $\int_a^b f(x)g(x) dx$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Gram-Schmidt Algorithm Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Gram-Schmidt Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Projection Subtraction Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Inner Product / Integral Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Orthogonal Projection Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Gram-Schmidt Orthogonalization Process**\nGiven linearly independent vectors $\\{\\mathbf{v}_1, \\mathbf{v}_2, \\dots, \\mathbf{v}_k\\}$, construct an orthogonal basis $\\{\\mathbf{u}_1, \\mathbf{u}_2, \\dots, \\mathbf{u}_k\\}$:\n$$\n\\mathbf{u}_1 = \\mathbf{v}_1, \\quad \\mathbf{u}_2 = \\mathbf{v}_2 - \\frac{\\langle \\mathbf{v}_2, \\mathbf{u}_1 \\rangle}{\\|\\mathbf{u}_1\\|^2} \\mathbf{u}_1\n$$\nIn general, $\\mathbf{u}_k = \\mathbf{v}_k - \\sum_{j=1}^{k-1} \\frac{\\langle \\mathbf{v}_k, \\mathbf{u}_j \\rangle}{\\|\\mathbf{u}_j\\|^2} \\mathbf{u}_j$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Let $\\mathbf{v}_1 = (1, 1, 0), \\mathbf{v}_2 = (1, 0, 1)$. Set $\\mathbf{u}_1 = (1, 1, 0)$.\n• **Step 2:** Compute $\\|\\mathbf{u}_1\\|^2 = 1^2 + 1^2 + 0^2 = 2$.\n• **Step 3:** Compute inner product $\\langle \\mathbf{v}_2, \\mathbf{u}_1 \\rangle = (1)(1) + (0)(1) + (1)(0) = 1$.\n• **Step 4:** $\\mathbf{u}_2 = (1, 0, 1) - \\frac{1}{2}(1, 1, 0) = (1/2, -1/2, 1)$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In Gram-Schmidt, to make u_2 orthogonal to u_1, we subtract the orthogonal ___ of v_2 onto u_1.",
      "blankAnswer": "projection",
      "blankDistractors": ["addition", "determinant", "transpose"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the inner product $\\langle f, g \\rangle = \\int_0^1 x \\cdot x^2 \\, dx$ in $L^2[0, 1]$.",
      "numericAnswer": 0.25,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the orthogonal projection $P_W \\mathbf{v}$ of a vector $\\mathbf{v}$ onto a subspace $W$ when $\\mathbf{v} \\in W$ already?",
      "options": [
        { "text": "P_W v = v (itself)", "isCorrect": true, "explanation": "Correct! If v is already in W, its projection onto W is v itself." },
        { "text": "P_W v = 0", "isCorrect": false, "explanation": "Incorrect: That only happens if v is in W^⊥." },
        { "text": "P_W v = ||v||", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "P_W v is undefined", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
