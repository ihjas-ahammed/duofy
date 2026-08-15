# Duofy Reusable Lesson Format: Real Analysis & Measure Theory - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Real_Analysis_and_Measure_Theory`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through foundational real analysis proofs: Dominated Convergence Theorem (DCT), Monotone Convergence Theorem (MCT), Fatou's Lemma, and Heine-Borel Theorem.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Theorem Statement & Dominating Function | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Proof Strategy & Order Steps | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Convergence Hypotheses Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Derivation Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Interchanging Limit Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Lebesgue's Dominated Convergence Theorem (DCT)**\nLet $(f_n)$ be a sequence of measurable functions converging pointwise a.e. to $f$.\nIf there exists an integrable dominating function $g \\in L^1$ such that $|f_n(x)| \\le g(x)$ for all $n$ a.e., then $f \\in L^1$ and:\n$$\n\\lim_{n \\to \\infty} \\int f_n \\, dm = \\int \\lim_{n \\to \\infty} f_n \\, dm = \\int f \\, dm\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove DCT using Fatou's Lemma.",
      "orderItems": [
        "Consider non-negative functions g + f_n >= 0 and g - f_n >= 0.",
        "Apply Fatou's Lemma to non-negative sequence g + f_n: ∫ liminf (g + f_n) <= liminf ∫ (g + f_n).",
        "Simplify using linearity of integral: ∫ g + ∫ f <= ∫ g + liminf ∫ f_n, yielding ∫ f <= liminf ∫ f_n.",
        "Apply Fatou's Lemma to non-negative sequence g - f_n to obtain limsup ∫ f_n <= ∫ f.",
        "Combine limsup ∫ f_n <= ∫ f <= liminf ∫ f_n to conclude lim ∫ f_n = ∫ f."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does the Monotone Convergence Theorem (MCT) require non-negative functions $0 \\le f_1 \\le f_2 \\le \\dots$?",
      "options": [
        { "text": "Non-negativity and monotonicity guarantee integral sequence ∫ f_n is increasing in [0, ∞]", "isCorrect": true, "explanation": "Correct! Monotonicity ensures limit of integrals exists in [0, ∞]." },
        { "text": "Because negative functions are not measurable", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because measure must be finite", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because domain must be compact", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: Bounded Sequence Limit",
      "interactiveSteps": [
        { "stepText": "Let $f_n(x) = \\frac{\\sin(n x)}{n x^2 + 1}$ on $[0, 1]$." },
        {
          "prompt": "What is an integrable dominating function $g(x)$ for $|f_n(x)|$ on $[0, 1]$?",
          "options": [
            { "text": "g(x) = 1 (constant function integrable on [0, 1])", "isCorrect": true },
            { "text": "g(x) = 1 / x²", "isCorrect": false },
            { "text": "g(x) = x", "isCorrect": false },
            { "text": "g(x) = 1 / x", "isCorrect": false }
          ]
        },
        { "stepText": "Since $|f_n(x)| \\le 1$ and $\\lim f_n(x) = 0$, DCT implies $\\lim_{n \\to \\infty} \\int_0^1 f_n(x) dx = \\int_0^1 0 dx = 0$." }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What lemma states that the integral of the lower limit is less than or equal to the lower limit of integrals (∫ liminf <= liminf ∫)?",
      "blankAnswer": "fatou"
    }
  ]
}
```
