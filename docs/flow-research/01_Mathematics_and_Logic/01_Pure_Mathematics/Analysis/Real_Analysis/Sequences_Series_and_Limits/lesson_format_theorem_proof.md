# Duofy Reusable Lesson Format: Sequences, Series, and Limits - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Real_Analysis / Sequences_Series_and_Limits`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof of the **Uniform Limit Theorem** (the uniform limit of continuous functions is continuous) via an $\epsilon/3$ argument, and prove the **Bolzano-Weierstrass Theorem** via interval bisections.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Uniform Limit Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | $\epsilon/3$ Continuity Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Triangle Inequality Partitioning Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Bolzano-Weierstrass Bisection Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Sequence Convergence Property Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Uniform Limit Theorem: Let $(f_n)$ be a sequence of continuous functions on $E \subseteq \mathbb{R}$. If $f_n \to f$ uniformly on $E$, then $f$ is continuous on $E$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof: (1) choose $\epsilon > 0$ and target point $x_0 \in E$, (2) by uniform convergence, choose $N$ such that $|f_N(x) - f(x)| < \epsilon/3$ for all $x \in E$, (3) by continuity of $f_N$ at $x_0$, choose $\delta > 0$ such that $|x - x_0| < \delta \implies |f_N(x) - f_N(x_0)| < \epsilon/3$, (4) apply triangle inequality: $|f(x) - f(x_0)| \le |f(x) - f_N(x)| + |f_N(x) - f_N(x_0)| + |f_N(x_0) - f(x_0)|$, (5) sum the three terms: $\epsilon/3 + \epsilon/3 + \epsilon/3 = \epsilon$, concluding continuity of $f$.
3. **Slide 3 (`quiz`):** Test why the $\epsilon/3$ proof fails under mere pointwise convergence (because $N$ would depend on $x$, so no single $f_N$ can be used).
4. **Slide 4 (`proof`):** Interactive derivation of Bolzano-Weierstrass theorem using nested intervals $I_0 \supset I_1 \supset I_2 \dots$ containing infinitely many terms.
5. **Slide 5 (`one_word`):** Plain-text recall of the internal convergence criterion without finding the limit (Cauchy).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Uniform Limit Theorem**\nLet $E \\subseteq \\mathbb{R}$, and let $(f_n)$ be a sequence of functions continuous on $E$.\nIf $f_n \\to f$ **uniformly** on $E$, then the limit function $f$ is **continuous** on $E$.\n$$\n\\lim_{x \\to x_0} \\left( \\lim_{n \\to \\infty} f_n(x) \\right) = \\lim_{n \\to \\infty} \\left( \\lim_{x \\to x_0} f_n(x) \\right) = f(x_0)\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps of the eps/3 proof of the Uniform Limit Theorem.",
      "orderItems": [
        "Fix x_0 in E and let eps > 0 be arbitrary",
        "By uniform convergence, choose index N such that |f_N(x) - f(x)| < eps/3 for all x in E simultaneously",
        "By continuity of f_N at x_0, choose delta > 0 such that |x - x_0| < delta implies |f_N(x) - f_N(x_0)| < eps/3",
        "Decompose |f(x) - f(x_0)| <= |f(x) - f_N(x)| + |f_N(x) - f_N(x_0)| + |f_N(x_0) - f(x_0)| using the triangle inequality",
        "Bound each of the three terms by eps/3, yielding |f(x) - f(x_0)| < eps/3 + eps/3 + eps/3 = eps for all |x - x_0| < delta"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does the eps/3 continuity proof FAIL if the sequence (f_n) converges only pointwise rather than uniformly?",
      "options": [
        { "text": "Under pointwise convergence, the index N depends on x, so we cannot pick a single function f_N that is simultaneously close to f(x) for all x in a neighborhood of x_0", "isCorrect": true, "explanation": "Correct! Without uniform convergence, N(eps/3, x) varies from point to point, so no fixed f_N works over the entire delta-ball." },
        { "text": "Because continuous functions cannot converge pointwise", "isCorrect": false, "explanation": "Incorrect: Continuous functions often converge pointwise." },
        { "text": "Because delta becomes infinite", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the triangle inequality fails for real numbers", "isCorrect": false, "explanation": "Incorrect: The triangle inequality always holds in R." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Bolzano-Weierstrass Subsequence Existence",
      "interactiveSteps": [
        {
          "stepText": "Let (x_n) be a bounded sequence contained in interval I_0 = [a, b]."
        },
        {
          "prompt": "Bisect I_0 into two halves. By the Pigeonhole Principle, what must be true for at least one half?",
          "options": [
            { "text": "At least one half contains infinitely many terms of the sequence (x_n)", "isCorrect": true },
            { "text": "Both halves must be empty", "isCorrect": false },
            { "text": "The sequence must be strictly increasing", "isCorrect": false },
            { "text": "The length of the interval becomes zero immediately", "isCorrect": false }
          ]
        },
        {
          "stepText": "Iterating this bisection produces nested intervals I_0 supset I_1 supset I_2 ... whose unique intersection point x* is the limit of the chosen subsequence."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the surname of the French mathematician who formulated the internal convergence criterion for sequences?",
      "blankAnswer": "cauchy"
    }
  ]
}
```
