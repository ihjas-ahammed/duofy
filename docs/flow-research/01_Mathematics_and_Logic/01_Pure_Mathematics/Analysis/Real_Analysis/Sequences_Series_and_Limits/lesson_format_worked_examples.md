# Duofy Reusable Lesson Format: Sequences, Series, and Limits - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Real_Analysis / Sequences_Series_and_Limits`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute supremum errors $\|f_n - f\|_\infty = \sup |f_n(x) - f(x)|$ to determine uniform convergence on specific domains (e.g. $f_n(x) = \frac{x}{1 + n x^2}$ on $\mathbb{R}$), construct rigorous $\epsilon$-$N$ limit bounds, and apply the Weierstrass M-test.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Supremum Error Analysis Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Calculus Optimization Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Uniform Supremum Decay Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Supremum Error Evaluation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Derivative Failure under Uniform Limit Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the worked problem: Test whether $f_n(x) = \frac{x}{1 + n x^2}$ converges uniformly on $\mathbb{R}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) pointwise limit: for any $x$, $f_n(x) \to 0$ as $n \to \infty$, so $f(x) = 0$, (2) find critical points of $|f_n(x) - 0|$: $f_n'(x) = \frac{1 - n x^2}{(1 + n x^2)^2} = 0 \implies x = \pm 1/\sqrt{n}$, (3) compute maximum value: $\sup_{x \in \mathbb{R}} |f_n(x)| = f_n(1/\sqrt{n}) = \frac{1/\sqrt{n}}{1 + 1} = \frac{1}{2\sqrt{n}}$, (4) take limit as $n \to \infty$: $\lim_{n\to\infty} \frac{1}{2\sqrt{n}} = 0 \implies f_n \to 0$ **uniformly** on all of $\mathbb{R}$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that if the supremum error approaches zero, the convergence is uniform. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to evaluate the maximum error $\sup_{x \in \mathbb{R}} |f_n(x)| = \frac{1}{2\sqrt{n}}$ for $n = 100$ ($1/(2 \times 10) = 0.05$).
5. **Slide 5 (`quiz`):** Quiz asking: For $f_n(x) = \frac{x}{1 + n x^2}$, what is $\lim_{n \to \infty} f_n'(0)$ compared to $f'(0)$? ($f_n'(0) = 1$ for all $n \implies \lim f_n'(0) = 1 \ne 0 = f'(0)$, showing uniform convergence of functions does not imply convergence of derivatives without uniform convergence of $f_n'$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Testing Uniform Convergence of $f_n(x) = \\frac{x}{1 + n x^2}$ on $\\mathbb{R}$**\n• **Pointwise Limit:** For any fixed $x \\in \\mathbb{R}$:\n$$\nf(x) = \\lim_{n \\to \\infty} \\frac{x}{1 + n x^2} = 0\n$$\n• **Supremum Error Criterion:** $f_n \\to 0$ uniformly on $\\mathbb{R}$ if and only if:\n$$\nM_n = \\sup_{x \\in \\mathbb{R}} |f_n(x) - f(x)| = \\sup_{x \\in \\mathbb{R}} \\left| \\frac{x}{1 + n x^2} \\right| \\to 0 \\quad \\text{as } n \\to \\infty\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Find Critical Points):** Differentiate $f_n(x)$:\n  $$f_n'(x) = \\frac{(1 + n x^2)(1) - x(2nx)}{(1 + n x^2)^2} = \\frac{1 - n x^2}{(1 + n x^2)^2} = 0 \\implies x = \\pm \\frac{1}{\\sqrt{n}}$$\n• **Step 2 (Evaluate at Critical Point):**\n  $$f_n\\left(\\frac{1}{\\sqrt{n}}\\right) = \\frac{1/\\sqrt{n}}{1 + n(1/n)} = \\frac{1/\\sqrt{n}}{2} = \\frac{1}{2\\sqrt{n}}$$\n• **Step 3 (Supremum Value):** $M_n = \\sup_{x \\in \\mathbb{R}} |f_n(x)| = \\frac{1}{2\\sqrt{n}}$.\n• **Step 4 (Conclusion):** Since $\\lim_{n \\to \\infty} M_n = \\lim_{n \\to \\infty} \\frac{1}{2\\sqrt{n}} = 0$, $f_n(x)$ converges **uniformly** to $0$ on the entire real line $\\mathbb{R}$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "A sequence of functions converges uniformly to f if and only if the supremum of |f_n(x) - f(x)| over the domain approaches ___ as n approaches infinity.",
      "blankAnswer": "zero",
      "blankDistractors": ["one", "infinity", "constant"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "For f_n(x) = x / (1 + n x^2), what is the exact maximum error M_n = sup_{x in R} |f_n(x)| when n = 100?",
      "numericAnswer": 0.05,
      "numericTolerance": 0.001
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "For f_n(x) = x / (1 + n x^2), f_n -> 0 uniformly on R. Why is lim_{n -> infty} f_n'(0) != f'(0)?",
      "options": [
        { "text": "f_n'(0) = 1 for all n (so lim f_n'(0) = 1), whereas f'(0) = 0, because the sequence of derivatives f_n' does not converge uniformly near 0", "isCorrect": true, "explanation": "Correct! Differentiating a limit requires uniform convergence of the derivatives f_n', which fails at x = 0." },
        { "text": "Because f is discontinuous at 0", "isCorrect": false, "explanation": "Incorrect: The zero function is smooth everywhere." },
        { "text": "Because f_n is not differentiable", "isCorrect": false, "explanation": "Incorrect: f_n is infinitely differentiable." },
        { "text": "Because 1 = 0 in real analysis", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
