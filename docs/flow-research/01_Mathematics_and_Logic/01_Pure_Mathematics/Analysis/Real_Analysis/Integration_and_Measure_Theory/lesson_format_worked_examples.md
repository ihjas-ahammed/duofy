# Duofy Reusable Lesson Format: Integration and Measure Theory - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Real_Analysis / Integration_and_Measure_Theory`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to evaluate limits of integrals like $\lim_{n \to \infty} \int_0^\infty \frac{n \sin(x/n)}{x(1 + x^2)} dx$ by finding dominant integrable bounds $g \in L^1$ to apply the Dominated Convergence Theorem, and construct counterexamples where domination fails (escape to vertical/horizontal infinity).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | DCT Limit Evaluation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Dominated Limit Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Dominator Integrability Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Integral Evaluation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Escape to Vertical Infinity Counterexample Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the worked problem: Evaluate $\lim_{n \to \infty} \int_0^\infty \frac{n \sin(x/n)}{x(1 + x^2)} dx$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) pointwise limit: since $\lim_{n\to\infty} \frac{\sin(x/n)}{x/n} = 1$, $f_n(x) \to \frac{1}{1+x^2}$ for all $x > 0$, (2) find dominating function: using $|\sin u| \le |u|$ for $u = x/n$, we have $|f_n(x)| = \frac{n |\sin(x/n)|}{x(1+x^2)} \le \frac{n (x/n)}{x(1+x^2)} = \frac{1}{1+x^2} = g(x)$, (3) check integrability: $\int_0^\infty \frac{1}{1+x^2} dx = [\arctan x]_0^\infty = \frac{\pi}{2} < \infty$, so $g \in L^1$, (4) apply DCT: $\lim \int_0^\infty f_n dx = \int_0^\infty \frac{1}{1+x^2} dx = \frac{\pi}{2}$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the dominating bound $g(x) = \frac{1}{1+x^2}$ is integrable over the positive real line. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to calculate the exact limit $\frac{\pi}{2} \approx 1.57079$.
5. **Slide 5 (`quiz`):** Quiz testing the classic non-dominated spike sequence $f_n(x) = n \mathbf{1}_{(0, 1/n)}(x)$ on $[0, 1]$, where $f_n \to 0$ a.e. but $\lim \int f_n dx = 1 \ne 0$.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Evaluating $\\lim_{n \\to \\infty} \\int_0^\\infty \\frac{n \\sin(x/n)}{x(1 + x^2)}\\,dx$ via DCT**\nLet $f_n(x) = \\frac{n \\sin(x/n)}{x(1 + x^2)}$ on $(0, \\infty)$.\n• **Pointwise Limit:** For any fixed $x > 0$, as $n \\to \\infty$:\n$$\n\\lim_{n \\to \\infty} f_n(x) = \\lim_{n \\to \\infty} \\left( \\frac{\\sin(x/n)}{x/n} \\right) \\frac{1}{1 + x^2} = (1) \\cdot \\frac{1}{1 + x^2} = \\frac{1}{1 + x^2}\n$$\nWe now find an integrable bound $g(x) \\in L^1((0, \\infty))$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Trigonometric Inequality):** For all $u \\ge 0$, $\\sin(u) \\le u$. Setting $u = x/n$ gives $\\sin(x/n) \\le x/n$.\n• **Step 2 (Dominating Function):** $|f_n(x)| \\le \\frac{n(x/n)}{x(1 + x^2)} = \\frac{1}{1 + x^2} = g(x)$.\n• **Step 3 (Verify $g \\in L^1$):** $\\int_0^\\infty g(x)\\,dx = \\int_0^\\infty \\frac{1}{1 + x^2}\\,dx = [\\arctan(x)]_0^\\infty = \\frac{\\pi}{2} < \\infty$.\n• **Step 4 (Interchange Limit & Integral):** By DCT, $\\lim_{n \\to \\infty} \\int_0^\\infty f_n(x)\\,dx = \\int_0^\\infty \\frac{1}{1 + x^2}\\,dx = \\frac{\\pi}{2}$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The Dominated Convergence Theorem requires the dominating function g(x) to be Lebesgue ___ over the domain of integration.",
      "blankAnswer": "integrable",
      "blankDistractors": ["differentiable", "constant", "continuous"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Evaluate the limit lim_{n -> infty} int_0^infty [n sin(x/n)] / [x(1 + x^2)] dx = pi / 2 to two decimal places.",
      "numericAnswer": 1.57,
      "numericTolerance": 0.02
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "For the sequence f_n(x) = n * 1_{(0, 1/n)}(x) on [0, 1], f_n(x) -> 0 a.e., but int_0^1 f_n(x) dx = 1 for all n. Why does DCT fail to apply?",
      "options": [
        { "text": "No integrable dominating function exists (sup_n f_n(x) = 1/x, and int_0^1 1/x dx = infinity)", "isCorrect": true, "explanation": "Correct! The spike escapes to vertical infinity, so the minimal dominating function 1/x is not in L^1, preventing DCT from applying." },
        { "text": "Because f_n is not measurable", "isCorrect": false, "explanation": "Incorrect: Step functions are measurable." },
        { "text": "Because the interval [0, 1] is bounded", "isCorrect": false, "explanation": "Incorrect: Bounded domains often satisfy DCT if domination holds." },
        { "text": "Because 0 != 1", "isCorrect": false, "explanation": "Incorrect: That is the consequence, not the reason why DCT hypothesis fails." }
      ]
    }
  ]
}
```
