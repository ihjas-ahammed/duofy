# Duofy Reusable Lesson Format: Subgradients and Non-Smooth Convex Analysis

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Convex_Optimization / Convex_Sets_and_Functions`  
**Lesson Format Type:** `subgradients_and_non_smooth_convex_analysis`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute **Subgradients and Subdifferentials** $\partial f(x) = \{g \mid f(y) \ge f(x) + g^T(y - x)\}$, analyze non-smooth convex objectives (e.g. $\ell_1$ norm $\|x\|_1$, hinge loss, max function $\max(f_1, f_2)$), and apply **Fermat's Subgradient Optimality Condition** ($0 \in \partial f(x^*)$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Subgradient & Subdifferential Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Subdifferential of Absolute Value Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Convex Function & Subdifferential at Origin Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Unconstrained Global Minimum Zero Inclusion Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Pointwise Maximum Danskin Subdifferential Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of a Subgradient: A vector $g \in \mathbb{R}^n$ is a subgradient of convex function $f: \mathbb{R}^n \to \mathbb{R}$ at $x$ if $f(y) \ge f(x) + g^T(y - x)$ for all $y \in \mathbb{R}^n$. The set of all subgradients at $x$ is the **Subdifferential** $\partial f(x)$. State properties: $\partial f(x)$ is non-empty, compact, and convex for all $x \in \operatorname{int}\operatorname{dom} f$. If $f$ is differentiable at $x$, $\partial f(x) = \{\nabla f(x)\}$. State Fermat's Rule: $x^*$ is a global minimizer of $f \iff 0 \in \partial f(x^*)$.
2. **Slide 2 (`concept_pieces`):** Deconstruct computing the subdifferential of the 1D absolute value function $f(x) = |x|$: (1) for $x > 0$, $f$ is differentiable with unique slope $g = +1$, so $\partial |x| = \{+1\}$, (2) for $x < 0$, $f$ is differentiable with unique slope $g = -1$, so $\partial |x| = \{-1\}$, (3) at $x = 0$, any line $y = g x$ satisfying $|y| \ge 0 + g(y - 0)$ requires $|y| \ge g y \implies -1 \le g \le 1$, (4) thus $\partial |0| = [-1, 1]$, an interval of supporting slopes!
3. **Slide 3 (`matching`):** Pair 4 non-smooth convex functions ($f(x) = |x|$, $f(x) = \|x\|_2$, $f(x) = \max(x_1, x_2)$, $f(x) = \operatorname{ReLU}(x) = \max(0, x)$) with their subdifferentials at $x = 0$.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that $x^*$ minimizes a convex function $f$ if and only if zero belongs to the subdifferential $\partial f(x^*)$. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Danskin's Theorem / Subdifferential of pointwise maximum $f(x) = \max_{i=1,\dots,m} f_i(x)$: What is $\partial f(x)$ when $f_i$ are convex and differentiable? ($\partial f(x) = \operatorname{conv}\{\nabla f_i(x) \mid i \in I(x)\}$ where $I(x) = \{i \mid f_i(x) = f(x)\}$ is the set of active indices).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "subgradients_and_non_smooth_convex_analysis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Subgradients and the Subdifferential**\n• Let $f: \\mathbb{R}^n \\to \\mathbb{R}$ be a convex function.\n• A vector $\\mathbf{g} \\in \\mathbb{R}^n$ is a **subgradient** of $f$ at $\\mathbf{x}$ if:\n$$\nf(\\mathbf{y}) \\ge f(\\mathbf{x}) + \\mathbf{g}^T (\\mathbf{y} - \\mathbf{x}) \\quad \\forall \\mathbf{y} \\in \\operatorname{dom} f\n$$\n• The **Subdifferential** $\\partial f(\\mathbf{x})$ is the set of all subgradients at $\\mathbf{x}$ (always non-empty, convex, and compact on $\\operatorname{int}\\operatorname{dom} f$).\n• If $f$ is differentiable at $\\mathbf{x}$, $\\partial f(\\mathbf{x}) = \\{\\nabla f(\\mathbf{x})\\}$ (singleton).\n• **Fermat's Subgradient Optimality Rule:**\n$$\n\\mathbf{x}^* \\text{ is a global minimizer of } f \\iff \\mathbf{0} \\in \\partial f(\\mathbf{x}^*)\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Subdifferential of $f(x) = |x|$ in $\\mathbb{R}$:**\n• **Case 1 ($x > 0$):** Slope is strictly $+1 \\implies \\partial |x| = \\{+1\\}$.\n• **Case 2 ($x < 0$):** Slope is strictly $-1 \\implies \\partial |x| = \\{-1\\}$.\n• **Case 3 ($x = 0$ at the sharp kink):**\n  We require $|y| \\ge 0 + g(y - 0) = gy$ for all $y \\in \\mathbb{R}$.\n  - For $y > 0$: $y \\ge gy \\implies g \\le 1$.\n  - For $y < 0$: $-y \\ge gy \\implies g \\ge -1$.\n• **Result:** $\\partial |0| = [-1, 1]$. Since $0 \\in [-1, 1]$, $x^* = 0$ is the unique global minimum!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each non-smooth convex function to its subdifferential at x = 0.",
      "matchPairs": [
        { "left": "Absolute Value f(x) = |x| at x = 0", "right": "[-1, 1] (closed 1D interval of supporting slopes)" },
        { "left": "Euclidean Norm f(x) = ||x||_2 at x = 0", "right": "{g in R^n | ||g||_2 <= 1} (closed unit ball B_2(0, 1))" },
        { "left": "L1 Norm f(x) = ||x||_1 at x = 0", "right": "[-1, 1]^n (unit hypercube [-1, 1]^n)" },
        { "left": "ReLU f(x) = max(0, x) at x = 0", "right": "[0, 1] (interval between 0 and 1)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "By Fermat's subgradient optimality rule, a point x* is a global minimizer of a convex function f if and only if ___ belongs to the subdifferential partial f(x*).",
      "blankAnswer": "zero",
      "blankDistractors": ["one", "infinity", "gradient"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "For a pointwise maximum of smooth convex functions f(x) = max_{i=1,...,m} f_i(x), what is the exact subdifferential partial f(x)?",
      "options": [
        { "text": "The CONVEX HULL of the gradients of all active functions: partial f(x) = conv { grad f_i(x) | f_i(x) = f(x) }", "isCorrect": true, "explanation": "Correct! By Danskin's theorem / Dubovitskii-Milyutin, the subdifferential is the convex combination of the gradients of all functions achieving the maximum at point x." },
        { "text": "The sum of all gradients", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The zero vector always", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The minimum gradient", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
