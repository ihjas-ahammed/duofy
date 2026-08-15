# Duofy Reusable Lesson Format: Operator Algebras and Spectral Theory - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Functional_Analysis / Operator_Algebras_and_Spectral_Theory`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute the spectrum $\sigma(T)$ (point spectrum $\sigma_p$, continuous spectrum $\sigma_c$, and residual spectrum $\sigma_r$) for shift operators on $\ell^2(\mathbb{N})$ and multiplication operators on $L^2([0, 1])$, and evaluate continuous functional calculus operators like $\sqrt{T}$ and $\exp(iT)$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Unilateral Right Shift Spectrum Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Shift Operator Analysis Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Spectral Radius Formula Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Operator Norm Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Multiplication Operator Spectrum Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Unilateral Right Shift operator $S: \ell^2 \to \ell^2$ defined by $S(x_1, x_2, \dots) = (0, x_1, x_2, \dots)$ and its adjoint Left Shift $S^*(x_1, x_2, x_3, \dots) = (x_2, x_3, \dots)$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) $\|S\| = 1 \implies \sigma(S) \subseteq \{|\lambda| \le 1\}$, (2) $S x = \lambda x \implies x_1 = 0, x_2 = 0 \dots \implies \sigma_p(S) = \emptyset$, (3) for $|\lambda| < 1$, $S^*(1, \lambda, \lambda^2, \dots) = \lambda (1, \lambda, \lambda^2, \dots) \implies \lambda \in \sigma_p(S^*) \implies \lambda \in \sigma_r(S)$, (4) conclude $\sigma(S) = \{|\lambda| \le 1\}$ (closed unit disk).
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the spectral radius $r(T)$ equals the limit of $\|T^n\|^{1/n}$. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to evaluate the spectral radius $r(S)$ of the right shift operator ($\|S\| = 1 \implies r(S) = 1.0$).
5. **Slide 5 (`quiz`):** Quiz asking for the spectrum of the multiplication operator $M_x f(x) = x f(x)$ on $L^2([0, 1])$ ($\sigma(M_x) = [0, 1]$ with no eigenvalues).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Spectrum of the Unilateral Right Shift Operator**\nLet $S: \\ell^2(\\mathbb{N}) \\to \\ell^2(\\mathbb{N})$ be the right shift $S(x_1, x_2, \\dots) = (0, x_1, x_2, \\dots)$.\nIts adjoint is the left shift $S^*(x_1, x_2, x_3, \\dots) = (x_2, x_3, \\dots)$.\nBecause $\\|S\\| = 1$, the spectrum is contained in the unit disk:\n$$\n\\sigma(S) \\subseteq \\{\\lambda \\in \\mathbb{C} \\mid |\\lambda| \\le 1\\}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Point Spectrum $\\sigma_p(S)$):** $Sx = \\lambda x \\implies (0, x_1, x_2, \\dots) = (\\lambda x_1, \\lambda x_2, \\dots) \\implies x_1 = 0 \\implies x_k = 0 \\forall k$. Thus $\\sigma_p(S) = \\emptyset$.\n• **Step 2 (Eigenvalues of $S^*$):** For $|\\lambda| < 1$, the geometric vector $v = (1, \\lambda, \\lambda^2, \\dots) \\in \\ell^2$ satisfies $S^* v = \\lambda v$. Thus $\\sigma_p(S^*) = \\{|\\lambda| < 1\\}$.\n• **Step 3 (Residual Spectrum):** Since $\\text{Range}(S - \\lambda I)^\\perp = \\ker(S^* - \\bar{\\lambda}I) \\ne \\{0\\}$, all $|\\lambda| < 1$ belong to the residual spectrum $\\sigma_r(S)$.\n• **Step 4 (Conclusion):** Since the spectrum is closed, $\\sigma(S) = \\{|\\lambda| \\le 1\\}$ (the entire closed unit disk)."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "By Gelfand's spectral radius formula, the spectral radius of an operator T equals the limit as n approaches infinity of ||T^n|| to the power of 1 over ___.",
      "blankAnswer": "n",
      "blankDistractors": ["2", "k", "infinity"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "What is the spectral radius r(S) of the isometric unilateral right shift operator S on ell^2?",
      "numericAnswer": 1.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the spectrum of the position/multiplication operator (M_x f)(x) = x f(x) on L^2([0, 1])?",
      "options": [
        { "text": "sigma(M_x) = [0, 1], consisting entirely of continuous spectrum with no eigenvalues", "isCorrect": true, "explanation": "Correct! (x - lambda)f(x) = 0 requires f = 0 a.e. (no eigenvalues), but 1/(x - lambda) is unbounded in L^2 for lambda in [0, 1]." },
        { "text": "sigma(M_x) = {0, 1}", "isCorrect": false, "explanation": "Incorrect: All intermediate values in [0, 1] make M_x - lambda I non-invertible." },
        { "text": "sigma(M_x) is the empty set", "isCorrect": false, "explanation": "Incorrect: Bounded operators on non-trivial Banach spaces always have non-empty spectrum." },
        { "text": "sigma(M_x) = C", "isCorrect": false, "explanation": "Incorrect: ||M_x|| = 1, so spectrum is bounded." }
      ]
    }
  ]
}
```
