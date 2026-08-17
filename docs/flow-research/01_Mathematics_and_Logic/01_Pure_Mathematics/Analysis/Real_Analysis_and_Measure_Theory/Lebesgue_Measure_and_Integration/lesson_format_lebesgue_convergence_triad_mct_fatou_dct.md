# Duofy Reusable Lesson Format: The Lebesgue Convergence Triad (MCT, Fatou, and DCT)

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Real_Analysis_and_Measure_Theory / Lebesgue_Measure_and_Integration`  
**Lesson Format Type:** `lebesgue_convergence_triad_mct_fatou_dct`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proofs and interplay of the **Lebesgue Convergence Triad**: Monotone Convergence Theorem (MCT), Fatou's Lemma, and the **Dominated Convergence Theorem (DCT)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Dominated Convergence Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Fatou Application & DCT Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Strict Inequality in Fatou's Lemma Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Monotone Convergence Approximation Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Limiting Integral Inequality Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Dominated Convergence Theorem (Lebesgue): Let $\{f_n\}$ be a sequence of measurable functions converging pointwise almost everywhere to $f$. If there exists an integrable function $g \in L^1(\mu)$ such that $|f_n(x)| \le g(x)$ for all $n$ and almost all $x$, then $f \in L^1(\mu)$ and $\lim_{n \to \infty} \int |f_n - f| d\mu = 0 \implies \lim_{n \to \infty} \int f_n d\mu = \int f d\mu$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof of DCT via Fatou's Lemma: (1) observe that $|f(x)| \le g(x)$ almost everywhere, so $f \in L^1$, (2) consider the non-negative sequences $g + f_n \ge 0$ and $g - f_n \ge 0$, (3) apply Fatou's Lemma to $g + f_n$: $\int (g + f) \le \liminf \int (g + f_n) = \int g + \liminf \int f_n \implies \int f \le \liminf \int f_n$, (4) apply Fatou's Lemma to $g - f_n$: $\int (g - f) \le \liminf \int (g - f_n) = \int g - \limsup \int f_n \implies \limsup \int f_n \le \int f$, (5) combine inequalities: $\limsup \int f_n \le \int f \le \liminf \int f_n$, proving $\lim_{n \to \infty} \int f_n = \int f$.
3. **Slide 3 (`quiz`):** Test why Fatou's Lemma can have a strict inequality $\int \liminf f_n < \liminf \int f_n$ (e.g. escaping mass $f_n(x) = n \mathbf{1}_{(0, 1/n)}(x)$ where $\int f_n = 1$ but $f_n \to 0$ pointwise).
4. **Slide 4 (`proof`):** Interactive derivation showing that any non-negative measurable function $f \ge 0$ is the pointwise monotone limit of simple functions $\phi_n = \sum_{k=0}^{n 2^n - 1} \frac{k}{2^n} \mathbf{1}_{f^{-1}([k/2^n, (k+1)/2^n))} + n \mathbf{1}_{f^{-1}([n, \infty))}$.
5. **Slide 5 (`one_word`):** Plain-text recall of the surname of the French mathematician who formulated the liminf integral inequality (Fatou).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "lebesgue_convergence_triad_mct_fatou_dct",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Dominated Convergence Theorem (DCT)**\nLet $(X, \\mathcal{M}, \\mu)$ be a measure space, and let $\\{f_n\\}$ be measurable functions with $f_n(x) \\to f(x)$ pointwise a.e.\nIf there exists an **integrable dominating envelope** $g \\in L^1(\\mu)$ such that:\n$$\n|f_n(x)| \\le g(x) \\quad \\text{for all } n \\ge 1 \\text{ and a.e. } x \\in X\n$$\nThen $f \\in L^1(\\mu)$ and the limit commutes with the integral:\n$$\n\\lim_{n \\to \\infty} \\int_X f_n \\, d\\mu = \\int_X \\left( \\lim_{n \\to \\infty} f_n \\right) d\\mu = \\int_X f \\, d\\mu\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps of the Dominated Convergence Theorem using Fatou's Lemma.",
      "orderItems": [
        "Observe that |f(x)| <= g(x) a.e., guaranteeing that the pointwise limit f is in L^1(mu)",
        "Construct two sequences of non-negative functions: (g + f_n) >= 0 and (g - f_n) >= 0",
        "Apply Fatou's Lemma to (g + f_n): int (g + f) <= liminf int (g + f_n) = int g + liminf int f_n, which simplifies to int f <= liminf int f_n",
        "Apply Fatou's Lemma to (g - f_n): int (g - f) <= liminf int (g - f_n) = int g - limsup int f_n, which simplifies to limsup int f_n <= int f",
        "Combine the two inequalities: limsup int f_n <= int f <= liminf int f_n, proving the limit exists and equals int f"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "For the sequence f_n(x) = n * 1_{(0, 1/n)}(x) on [0, 1], what are the values of int (liminf f_n) and liminf (int f_n)?",
      "options": [
        { "text": "int (liminf f_n) = 0, but liminf (int f_n) = 1 (strict inequality in Fatou's lemma due to escaping mass)", "isCorrect": true, "explanation": "Correct! Pointwise f_n(x) -> 0 for every x > 0, so liminf f_n = 0 and int 0 = 0. However, int_0^1 f_n dx = n * (1/n) = 1 for all n, so liminf int f_n = 1." },
        { "text": "Both values are 1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Both values are 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The integrals diverge to infinity", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Monotone Approximation of Measurable Functions by Simple Functions",
      "interactiveSteps": [
        {
          "stepText": "Let f >= 0 be a non-negative measurable function on X. For each integer n >= 1, divide [0, n) into intervals of width 1/2^n."
        },
        {
          "prompt": "Define phi_n = sum_{k=0}^{n 2^n - 1} (k / 2^n) * 1_{f^{-1}([k/2^n, (k+1)/2^n))} + n * 1_{f^{-1}([n, infty))}. What is the relationship between phi_n and f?",
          "options": [
            { "text": "0 <= phi_1 <= phi_2 <= ... <= f, with phi_n(x) -> f(x) monotonically for every x in X", "isCorrect": true },
            { "text": "phi_n is strictly decreasing", "isCorrect": false },
            { "text": "phi_n does not converge to f", "isCorrect": false },
            { "text": "phi_n is unbounded", "isCorrect": false }
          ]
        },
        {
          "stepText": "By the Monotone Convergence Theorem (MCT), int f dm = lim_{n -> infty} int phi_n dm, establishing the foundation of the Lebesgue integral."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the surname of the French mathematician who proved that int (liminf f_n) <= liminf int f_n for non-negative functions?",
      "blankAnswer": "fatou"
    }
  ]
}
```
