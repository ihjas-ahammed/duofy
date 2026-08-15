# Duofy Reusable Lesson Format: Banach and Hilbert Spaces - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Functional_Analysis / Banach_and_Hilbert_Spaces`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute orthogonal projections of functions onto closed subspaces in $L^2([0, 1])$ (e.g. projecting onto linear polynomials $\mathbb{P}_1$ via Gram-Schmidt orthonormalization), evaluate operator norms of linear functionals, and verify the Riesz representation vector.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | $L^2$ Best Approximation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Gram-Schmidt Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Orthogonality Condition Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Functional Norm Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Non-Complete Normed Space Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Orthogonal Projection formula in Hilbert space $H$: $P_M(x) = \sum_{k=1}^n \langle x, e_k \rangle e_k$ for an orthonormal basis $\{e_k\}$ of subspace $M$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps of projecting $f(t) = t^2$ onto $M = \text{span}\{1, t\}$ in $L^2([0, 1])$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the projection minimizes the distance $\|x - y\|$ over all $y \in M$. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the operator norm of the functional $\phi(f) = \int_0^1 f(t) dt$ on $L^2([0, 1])$ ($\|\phi\| = \|1\|_{L^2} = \sqrt{\int_0^1 1^2 dt} = 1.0$).
5. **Slide 5 (`quiz`):** Quiz testing why the space of polynomials $P([0, 1])$ with $L^2$ norm fails to be a Hilbert space (it is not complete; its completion is $L^2([0, 1])$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Best Approximation in Hilbert Space $L^2([0, 1])$**\nFor a closed subspace $M \\subset H$ with orthonormal basis $\{e_1, \\dots, e_n\}$, the unique **orthogonal projection** minimizing $\\|f - g\\|_{L^2}$ for $g \\in M$ is:\n$$\nP_M(f) = \\sum_{k=1}^n \\langle f, e_k \\rangle e_k\n$$\nInner product: $\\langle f, g \\rangle = \\int_0^1 f(t) \\overline{g(t)}\\,dt$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Orthonormalize Basis):** In $L^2([0, 1])$ for $M = \\text{span}\\{1, t\\}$, $e_1 = 1$, and $e_2 = \\sqrt{3}(2t - 1)$ since $\\int_0^1 3(2t-1)^2 dt = 1$ and $\\langle e_1, e_2 \\rangle = 0$.\n• **Step 3 (Compute Projections):** For $f(t) = t^2$:\n  $\\langle f, e_1 \\rangle = \\int_0^1 t^2 dt = \\frac{1}{3}$.\n  $\\langle f, e_2 \\rangle = \\sqrt{3} \\int_0^1 t^2(2t - 1) dt = \\sqrt{3}(\\frac{2}{4} - \\frac{1}{3}) = \\frac{\\sqrt{3}}{6}$.\n• **Step 4 (Assemble Projection):** $P_M(f) = \\frac{1}{3}(1) + \\frac{\\sqrt{3}}{6}(\\sqrt{3}(2t - 1)) = t - \\frac{1}{6}$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In a Hilbert space H, the orthogonal projection P_M(x) onto a closed subspace M is the unique point in M that ___ the distance ||x - y||.",
      "blankAnswer": "minimizes",
      "blankDistractors": ["maximizes", "normalizes", "inverts"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Compute the operator norm ||phi|| of the continuous linear functional phi(f) = int_0^1 f(t) dt on the Hilbert space L^2([0, 1]).",
      "numericAnswer": 1.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the space of all polynomials P([0, 1]) equipped with the inner product <f, g> = int_0^1 f(t)g(t) dt NOT a Hilbert space?",
      "options": [
        { "text": "It is not complete: Cauchy sequences of polynomials (like Taylor polynomials of e^t) converge to non-polynomial functions in L^2([0, 1])", "isCorrect": true, "explanation": "Correct! Completeness fails because infinite series of polynomials leave the polynomial space." },
        { "text": "It fails the Parallelogram Law", "isCorrect": false, "explanation": "Incorrect: The L^2 inner product always satisfies the Parallelogram Law." },
        { "text": "The norm can be negative", "isCorrect": false, "explanation": "Incorrect: Norms are non-negative." },
        { "text": "It is not a vector space", "isCorrect": false, "explanation": "Incorrect: P([0, 1]) is a valid vector space." }
      ]
    }
  ]
}
```
