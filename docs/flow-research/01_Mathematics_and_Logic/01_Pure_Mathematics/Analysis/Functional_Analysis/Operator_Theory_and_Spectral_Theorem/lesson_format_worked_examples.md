# Duofy Reusable Lesson Format: Operator Theory and Spectral Theorem - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Functional_Analysis / Operator_Theory_and_Spectral_Theorem`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute the spectrum $\sigma(T)$ and continuous functional calculus for multiplication operators $M_x f(t) = t f(t)$ on $L^2[0, 1]$, calculate the spectral radius $r(T)$, and diagonalize compact integral operators $K f(x) = \int_0^1 \min(x, y) f(y) dy$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Position Multiplication Operator Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Spectrum & Invertibility Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Point Spectrum Emptiness Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Operator Norm Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Continuous Functional Calculus Square Root Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the problem: Let $T: L^2[0, 1] \to L^2[0, 1]$ be the multiplication operator $T f(t) = t f(t)$. Determine the adjoint $T^*$, the operator norm $\|T\|$, and the spectrum $\sigma(T)$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) adjoint: $\langle Tf, g \rangle = \int_0^1 t f(t) \overline{g(t)} dt = \int_0^1 f(t) \overline{t g(t)} dt = \langle f, Tg \rangle \implies T^* = T$ (self-adjoint), (2) operator norm: $\|T\| = \operatorname{ess\,sup}_{t \in [0, 1]} |t| = 1$, (3) point spectrum: $(T - \lambda I)f = (t - \lambda)f(t) = 0$ almost everywhere; since $t - \lambda \ne 0$ a.e., $f(t) = 0$ in $L^2$, so $\sigma_p(T) = \emptyset$ (no eigenvalues), (4) full spectrum: for $\lambda \in [0, 1]$, $(T - \lambda I)^{-1} = \frac{1}{t - \lambda} \notin L^\infty$, so the inverse is unbounded; for $\lambda \notin [0, 1]$, $\frac{1}{t - \lambda}$ is bounded; thus $\sigma(T) = [0, 1]$ (pure continuous spectrum).
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the point spectrum (eigenvalues) of the continuous multiplication operator $T f(t) = t f(t)$ on $L^2[0, 1]$ is empty. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the operator norm $\|T\|$ for $T f(t) = t f(t)$ on $L^2[0, 1]$ ($\|T\| = 1.0$).
5. **Slide 5 (`quiz`):** Quiz asking: Using the continuous functional calculus for $T f(t) = t f(t)$, what is the operator $\sqrt{T}$? ($\sqrt{T} f(t) = \sqrt{t} f(t)$, multiplication by the square root function $\sqrt{t}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Analyzing the Multiplication Operator on $L^2[0, 1]$**\nLet $T \\in \\mathcal{B}(L^2[0, 1])$ be defined by $(Tf)(t) = t f(t)$ for $t \\in [0, 1]$.\n• $T$ is **self-adjoint**: $\\langle Tf, g \\rangle = \\int_0^1 t f(t) \\overline{g(t)} dt = \\langle f, Tg \\rangle$.\n• We will compute its operator norm $\\|T\\|$, point spectrum $\\sigma_p(T)$, and full spectrum $\\sigma(T)$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Operator Norm):** $\\|T\\| = \\sup_{\\|f\\|=1} \\|tf(t)\\|_2 = \\|t\\|_\\infty = 1$.\n• **Step 2 (Point Spectrum $\\sigma_p(T)$):** If $(T - \\lambda I)f = 0$, then $(t - \\lambda)f(t) = 0$ almost everywhere. Since $t - \\lambda = 0$ on at most a single point (measure zero), $f(t) = 0$ almost everywhere, proving $\\sigma_p(T) = \\emptyset$ (no eigenvalues!).\n• **Step 3 (Continuous Spectrum):** For $\\lambda \\in [0, 1]$, $(T - \\lambda I)^{-1}$ is multiplication by $\\frac{1}{t - \\lambda}$, which is unbounded near $t = \\lambda$, so $(T - \\lambda I)$ is not invertible.\n• **Step 4 (Resolvent Set):** For $\\lambda \\notin [0, 1]$, $\\frac{1}{|t - \\lambda|} \\le \\frac{1}{\\operatorname{dist}(\\lambda, [0, 1])} < \\infty$, so $(T - \\lambda I)^{-1}$ is bounded, proving $\\sigma(T) = [0, 1]$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The position multiplication operator (Tf)(t) = t f(t) on L^2[0, 1] has a continuous spectrum of [0, 1], but its point spectrum of eigenvalues is strictly ___.",
      "blankAnswer": "empty",
      "blankDistractors": ["infinite", "compact", "discrete"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "What is the exact operator norm ||T|| of the multiplication operator (Tf)(t) = t f(t) on L^2[0, 1]?",
      "numericAnswer": 1.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Applying the Continuous Functional Calculus to the self-adjoint operator (Tf)(t) = t f(t) on L^2[0, 1], what is the square root operator sqrt(T)?",
      "options": [
        { "text": "(sqrt(T) f)(t) = sqrt(t) f(t) (multiplication by sqrt(t))", "isCorrect": true, "explanation": "Correct! Continuous functional calculus maps any continuous function g(lambda) on sigma(T) to the multiplication operator (g(T)f)(t) = g(t)f(t)." },
        { "text": "d/dt f(t)", "isCorrect": false, "explanation": "Incorrect: Differentiation is unbounded." },
        { "text": "int_0^t f(s) ds", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "sqrt(1) * f(t)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
