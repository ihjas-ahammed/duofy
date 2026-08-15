# Duofy Reusable Lesson Format: Dimension Theory - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Commutative_Algebra / Dimension_Theory`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train learners to compute the Krull dimension and heights of prime ideals for coordinate rings of affine varieties, quotient rings $k[x_1, \dots, x_n]/I$, and localized polynomial rings using transcendence degree and prime chain calculations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Dimension Calculation Strategy Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Dimension Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Height / Transcendence Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Krull Dimension Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Non-Integral / Reducible Variety Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the formula for the dimension of an affine domain over a field $k$: $\dim(k[x_1, \dots, x_n]/\mathfrak{p}) = \text{tr.deg}_k(\text{Frac}(R)) = n - \text{ht}(\mathfrak{p})$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4-step process for computing the dimension of $R = k[x, y, z] / (xy - z^2)$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing the connection between Krull dimension of an affine domain and transcendence degree. Plain text only.
4. **Slide 4 (`numerical`):** Ask the student to compute the exact integer Krull dimension of a concrete coordinate ring (e.g., $k[w, x, y, z] / (w x - y z)$).
5. **Slide 5 (`quiz`):** Multi-component variety edge case: computing the dimension of $k[x, y, z]/(xy, xz)$ as the maximum of dimensions of its irreducible components.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Computing Dimension of Affine Domains**\nFor an affine domain $R = k[x_1, \\dots, x_n] / \\mathfrak{p}$ over a field $k$:\n$$\n\\dim R = \\text{tr.deg}_k(\\text{Frac}(R)) = n - \\text{ht}(\\mathfrak{p})\n$$\nIf $\\mathfrak{p} = (f)$ is a non-zero principal prime ideal, then $\\text{ht}(\\mathfrak{p}) = 1$ and $\\dim R = n - 1$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Check Irreducibility):** Verify if $I = (f)$ is prime (irreducible polynomial in UFD $k[x_1, \\dots, x_n]$).\n• **Step 2 (Determine Ambient Dimension):** The ambient polynomial ring $k[x, y, z]$ has $\\dim = 3$.\n• **Step 3 (Apply Height Theorem):** Since $f$ is irreducible and non-zero, $\\text{ht}((f)) = 1$.\n• **Step 4 (Calculate Dimension):** Compute $\\dim(k[x, y, z]/(f)) = 3 - 1 = 2$ (a surface in 3D affine space)."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "For any integral domain R finitely generated over a field k, the Krull dimension of R equals the ___ degree of its field of fractions over k.",
      "blankAnswer": "transcendence",
      "blankDistractors": ["algebraic", "differential", "topological"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Compute the Krull dimension of the coordinate ring R = C[x, y, z, w] / (x^2 + y^2 + z^2 + w^2 - 1).",
      "numericAnswer": 3.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the Krull dimension of the ring R = k[x, y, z] / (xy, xz)?",
      "options": [
        { "text": "2", "isCorrect": true, "explanation": "Correct! (xy, xz) = (x) ∩ (y, z). The components have dimensions dim(k[x,y,z]/(x)) = 2 (the yz-plane) and dim(k[x,y,z]/(y,z)) = 1 (the x-axis). The dimension of R is max(2, 1) = 2." },
        { "text": "1", "isCorrect": false, "explanation": "Incorrect: 1 is the dimension of the smaller component (the x-axis), but Krull dimension is the supremum over all components." },
        { "text": "3", "isCorrect": false, "explanation": "Incorrect: Both components are proper subvarieties of 3D space." },
        { "text": "0", "isCorrect": false, "explanation": "Incorrect: The variety contains positive-dimensional components." }
      ]
    }
  ]
}
```
