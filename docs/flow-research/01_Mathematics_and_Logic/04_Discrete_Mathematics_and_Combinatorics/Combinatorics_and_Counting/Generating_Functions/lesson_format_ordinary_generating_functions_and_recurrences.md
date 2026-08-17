# Duofy Reusable Lesson Format: Ordinary Generating Functions and Linear Recurrences

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Combinatorics_and_Counting / Generating_Functions`  
**Lesson Format Type:** `ordinary_generating_functions_and_recurrences`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the **Ordinary Generating Function (OGF)** $A(x) = \sum_{n=0}^\infty a_n x^n$, master Wilf's 4-step algorithm for solving linear recurrence relations, apply the shifting property ($[x^n]\frac{A(x) - a_0}{x} = a_{n+1}$), derive the closed-form generating function for the **Fibonacci Sequence** ($F(x) = \frac{x}{1 - x - x^2}$), and extract coefficients via partial fraction expansion.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | OGF Definition & Convolution Algebra Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Fibonacci OGF F(x) = x / (1 - x - x^2) Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Discrete Operation & Generating Function Transformation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Partial Fraction Coefficient Extraction Binet Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Formal Power Series Coefficient Notation Extraction Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of the Ordinary Generating Function (OGF): For a sequence $\{a_n\}_{n=0}^\infty$, $A(x) = \sum_{n=0}^\infty a_n x^n = a_0 + a_1 x + a_2 x^2 + \dots$. Crucial operations: (1) Right Shift: $x A(x) = \sum_{n=1}^\infty a_{n-1} x^n$, (2) Left Shift: $\frac{A(x) - a_0}{x} = \sum_{n=0}^\infty a_{n+1} x^n$, (3) Differentiation: $A'(x) = \sum_{n=0}^\infty (n+1) a_{n+1} x^n \implies x A'(x) = \sum_{n=0}^\infty n a_n x^n$, (4) Cauchy Product (Convolution): $A(x) B(x) = \sum_{n=0}^\infty \left(\sum_{k=0}^n a_k b_{n-k}\right) x^n$.
2. **Slide 2 (`ordering`):** Provide 5 steps deriving $F(x) = \frac{x}{1 - x - x^2}$ for Fibonacci recurrence $F_{n+2} = F_{n+1} + F_n$ with $F_0 = 0, F_1 = 1$: (1) multiply recurrence by $x^n$ and sum over $n \ge 0$: $\sum_{n=0}^\infty F_{n+2} x^n = \sum_{n=0}^\infty F_{n+1} x^n + \sum_{n=0}^\infty F_n x^n$, (2) express left-shifted terms using $F(x)$: $\frac{F(x) - F_0 - F_1 x}{x^2} = \frac{F(x) - F_0}{x} + F(x)$, (3) plug in initial values $F_0 = 0, F_1 = 1$: $\frac{F(x) - x}{x^2} = \frac{F(x)}{x} + F(x)$, (4) multiply through by $x^2$: $F(x) - x = x F(x) + x^2 F(x)$, (5) collect $F(x)$ on the LHS: $F(x)(1 - x - x^2) = x \implies F(x) = \frac{x}{1 - x - x^2}$.
3. **Slide 3 (`matching`):** Pair 4 sequence operations ($n a_n$, $a_{n-1}$, $\sum_{k=0}^n a_k$, $\sum_{k=0}^n a_k b_{n-k}$) with their generating function representations ($x A'(x)$, $x A(x)$, $\frac{A(x)}{1-x}$, $A(x) B(x)$).
4. **Slide 4 (`proof`):** Interactive derivation showing that partial fraction expansion of $\frac{1}{(1 - \phi x)(1 - \psi x)}$ produces Binet's formula $F_n = \frac{\phi^n - \psi^n}{\sqrt{5}}$ where $\phi = \frac{1+\sqrt{5}}{2}$ and $\psi = \frac{1-\sqrt{5}}{2}$.
5. **Slide 5 (`one_word`):** Plain-text recall of the mathematical term for the series $A(x) = \sum a_n x^n$ considered without regard to analytic convergence on real/complex domains (formal power series / formal).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ordinary_generating_functions_and_recurrences",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Ordinary Generating Functions (OGFs)**\n• For a sequence $\\{a_n\\}_{n=0}^\\infty$, the **Ordinary Generating Function** is:\n$$\nA(x) = \\sum_{n=0}^\\infty a_n x^n = a_0 + a_1 x + a_2 x^2 + \\dots\n$$\n• **The Coefficient Extraction Operator:** $[x^n] A(x) = a_n$.\n• **Fundamental Algebraic Properties:**\n  - **Right Shift:** $x^k A(x) = \\sum_{n=k}^\\infty a_{n-k} x^n$.\n  - **Left Shift:** $\\frac{A(x) - a_0 - a_1 x - \\dots - a_{k-1} x^{k-1}}{x^k} = \\sum_{n=0}^\\infty a_{n+k} x^n$.\n  - **Multiplication by $n$:** $x \\frac{d}{dx} A(x) = \\sum_{n=0}^\\infty n a_n x^n$.\n  - **Cauchy Convolution:** $A(x) B(x) = \\sum_{n=0}^\\infty \\left( \\sum_{k=0}^n a_k b_{n-k} \\right) x^n$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical steps deriving the OGF F(x) = x / (1 - x - x^2) for the Fibonacci sequence (F_0 = 0, F_1 = 1).",
      "orderItems": [
        "Multiply the linear recurrence F_{n+2} = F_{n+1} + F_n by x^n and sum over all n >= 0",
        "Substitute left-shift formulas: (F(x) - F_0 - F_1 * x) / x^2 = (F(x) - F_0) / x + F(x)",
        "Insert the initial boundary conditions F_0 = 0 and F_1 = 1 to get (F(x) - x) / x^2 = F(x) / x + F(x)",
        "Clear denominators by multiplying the entire equation by x^2: F(x) - x = x * F(x) + x^2 * F(x)",
        "Factor out F(x) and isolate: F(x) * (1 - x - x^2) = x => F(x) = x / (1 - x - x^2)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each sequence operation to its generating function transformation.",
      "matchPairs": [
        { "left": "Index Multiplication n * a_n", "right": "x * A'(x) (derivative scaled by x)" },
        { "left": "Prefix Sums s_n = sum_{k=0}^n a_k", "right": "A(x) / (1 - x) (convolution with sequence of all 1s)" },
        { "left": "Cauchy Convolution c_n = sum a_k b_{n-k}", "right": "A(x) * B(x)" },
        { "left": "Left Shift a_{n+1}", "right": "(A(x) - a_0) / x" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Binet's Closed Formula via Partial Fractions on F(x)",
      "interactiveSteps": [
        {
          "stepText": "Factor the denominator 1 - x - x^2 = (1 - phi x)(1 - psi x) where phi = (1 + sqrt(5))/2 and psi = (1 - sqrt(5))/2."
        },
        {
          "prompt": "What is the partial fraction decomposition of F(x) = x / ((1 - phi x)(1 - psi x))?",
          "options": [
            { "text": "F(x) = (1 / sqrt(5)) * [ 1/(1 - phi x) - 1/(1 - psi x) ]", "isCorrect": true },
            { "text": "F(x) = 1/(1 - phi x) + 1/(1 - psi x)", "isCorrect": false },
            { "text": "F(x) = x / (1 - phi x)", "isCorrect": false },
            { "text": "F(x) = sqrt(5) / (1 - x^2)", "isCorrect": false }
          ]
        },
        {
          "stepText": "Expanding each geometric series 1/(1 - r x) = sum (r x)^n extracts [x^n] F(x) = F_n = (phi^n - psi^n) / sqrt(5), proving Binet's formula!"
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What adjective describes the algebraic power series A(x) = sum a_n x^n when studied purely by coefficient manipulation without requiring analytic convergence?",
      "blankAnswer": "formal"
    }
  ]
}
```
