# Duofy Reusable Lesson Format: Taylor Series Stencils and Local Truncation Error

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing / Numerical_Solutions_of_Differential_Equations / Finite_Difference_Methods`  
**Lesson Format Type:** `taylor_stencils_and_truncation_error`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the derivation of finite difference grid stencils via Taylor series expansions, compute Local Truncation Error $\tau_j = \mathcal{O}(\Delta x^p)$, and compare 1st-order forward/backward differences against 2nd-order central differences.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Taylor Derivative Stencils & Truncation Error Formal Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Central Cancellation & High-Order Symmetry Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Differential Stencil & Accuracy Order Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Central Difference Cancellation Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | 2nd-Derivative Leading Error Coefficient Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Taylor expansions $u(x \pm h) = u(x) \pm h u'(x) + \frac{h^2}{2} u''(x) \pm \frac{h^3}{6} u'''(x) + \frac{h^4}{24} u^{(4)}(x) + \mathcal{O}(h^5)$, the central difference $\frac{u(x+h) - u(x-h)}{2h} = u'(x) + \frac{h^2}{6} u'''(x) + \dots$, and the 2nd derivative stencil $\frac{u(x+h) - 2u(x) + u(x-h)}{h^2} = u''(x) + \frac{h^2}{12} u^{(4)}(x) + \dots$.
2. **Slide 2 (`concept_pieces`):** Deconstruct symmetric cancellation of odd-power error terms, forward/backward 1st-order asymmetric errors $\frac{h}{2} u''(x)$, 5-point 2D Laplacian stencil $\frac{u_{i+1, j} + u_{i-1, j} + u_{i, j+1} + u_{i, j-1} - 4u_{i, j}}{h^2} = \nabla^2 u + \mathcal{O}(h^2)$, and grid convergence rates.
3. **Slide 3 (`matching`):** Pair 4 difference stencils (Forward Difference $\delta^+$, Central 1st Difference $\delta^0$, 3-Point 2nd Difference $\delta^2$, 5-Point 4th-Order Central) with their exact orders of accuracy $\mathcal{O}(h)$ vs $\mathcal{O}(h^2)$ vs $\mathcal{O}(h^4)$.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that central differences achieve 2nd-order accuracy because all odd powers of h cancel out symmetrically. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking for the exact leading truncation error term of the 3-point second derivative stencil ($\frac{h^2}{12} u^{(4)}(x)$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "taylor_stencils_and_truncation_error",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Finite Difference Stencils and Local Truncation Error**\nLet $u(x) \\in C^4(\\mathbb{R})$ and $h = \\Delta x$. Taylor expanding about $x$:\n$$\nu(x \\pm h) = u(x) \\pm h u'(x) + \\frac{h^2}{2} u''(x) \\pm \\frac{h^3}{6} u'''(x) + \\frac{h^4}{24} u^{(4)}(x) + \\mathcal{O}(h^5)\n$$\n• **Central First Derivative (Order 2):**\n$$\n\\frac{u(x+h) - u(x-h)}{2h} = u'(x) + \\frac{h^2}{6} u'''(x) + \\mathcal{O}(h^4)\n$$\n• **Three-Point Second Derivative (Order 2):**\n$$\n\\frac{u(x+h) - 2u(x) + u(x-h)}{h^2} = u''(x) + \\frac{h^2}{12} u^{(4)}(x) + \\mathcal{O}(h^4)\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Symmetric Cancellation:** Subtracting $u(x-h)$ from $u(x+h)$ completely eliminates all even powers of $h$, boosting accuracy from $\\mathcal{O}(h)$ to $\\mathcal{O}(h^2)$ with no extra evaluations!\n• **Forward/Backward Asymmetry:** One-sided differences retain the $\\frac{h}{2} u''(x)$ term, leaving them strictly first-order $\\mathcal{O}(h)$.\n• **2D Five-Point Laplacian Stencil:**\n  $$\\nabla_h^2 u_{i, j} = \\frac{u_{i+1, j} + u_{i-1, j} + u_{i, j+1} + u_{i, j-1} - 4u_{i, j}}{h^2} = \\nabla^2 u + \\mathcal{O}(h^2)$$\n• **Grid Refinement Test:** Halving the grid spacing $h \\to h/2$ in a 2nd-order method reduces numerical error by a factor of $2^2 = 4$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each finite difference stencil to its exact asymptotic truncation error order.",
      "matchPairs": [
        { "left": "Forward Difference (u_{j+1} - u_j) / h", "right": "O(h) First-Order (error proportional to h u''(x) / 2)" },
        { "left": "Central Difference (u_{j+1} - u_{j-1}) / (2h)", "right": "O(h^2) Second-Order (error proportional to h^2 u'''(x) / 6)" },
        { "left": "3-Point Second Difference (u_{j+1} - 2u_j + u_{j-1}) / h^2", "right": "O(h^2) Second-Order (error proportional to h^2 u^{(4)}(x) / 12)" },
        { "left": "5-Point Central 1st Derivative (-u_{j+2} + 8u_{j+1} - 8u_{j-1} + u_{j-2}) / (12h)", "right": "O(h^4) Fourth-Order" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Central finite difference stencils achieve second-order accuracy because all ___ powers of the grid spacing h cancel out symmetrically.",
      "blankAnswer": "odd",
      "blankDistractors": ["even", "fractional", "positive"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the exact leading coefficient in the local truncation error of the standard 3-point central difference approximation to the second derivative u''(x)?",
      "options": [
        { "text": "(h^2 / 12) * u^{(4)}(x)", "isCorrect": true, "explanation": "Correct! Taylor expanding u(x+h) + u(x-h) - 2u(x) leaves 2*(h^4/24) u^{(4)}(x) = (h^4/12) u^{(4)}(x); dividing by h^2 gives (h^2/12) u^{(4)}(x)." },
        { "text": "(h^2 / 6) * u'''(x)", "isCorrect": false, "explanation": "Incorrect: h^2/6 belongs to the central first derivative." },
        { "text": "(h / 2) * u''(x)", "isCorrect": false, "explanation": "Incorrect: h/2 belongs to one-sided forward differences." },
        { "text": "h^2 * u^{(4)}(x)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
