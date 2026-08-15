# Duofy Reusable Lesson Format: Existence and Uniqueness Theorems - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Differential_Equations_ODEs_and_PDEs / Existence_and_Uniqueness_Theorems`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute successive Picard iterates $y_0, y_1, y_2, y_3$ for initial value problems (e.g. $y' = 2t(y+1), y(0)=0$), verify their convergence to Taylor series of the exact analytical solution, and test Lipschitz constants.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Picard Iteration Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Iteration Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Convergence Limit Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Iterate Evaluation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Lipschitz Constant Calculation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the recurrence: $y_0(t) = y_0$, $y_{n+1}(t) = y_0 + \int_{t_0}^t f(s, y_n(s))ds$ for $y' = 2t(1+y), y(0) = 0$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 iterations: $y_0 = 0$, $y_1 = \int_0^t 2s(1+0)ds = t^2$, $y_2 = \int_0^t 2s(1+s^2)ds = t^2 + \frac{t^4}{2}$, $y_3 = t^2 + \frac{t^4}{2} + \frac{t^6}{6}$ (converging to $e^{t^2} - 1$).
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the sequence of Picard iterates converges uniformly to the exact solution. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the value of $y_2(1)$ where $y_2(t) = t^2 + \frac{t^4}{2}$ ($y_2(1) = 1 + 0.5 = 1.5$).
5. **Slide 5 (`quiz`):** Quiz asking for the Lipschitz constant $L = \sup |\partial f/\partial y|$ of $f(t, y) = t^2 \sin(y) + y$ on $[-2, 2] \times [-5, 5]$ ($L = \sup |t^2 \cos(y) + 1| = 2^2(1) + 1 = 5$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Picard Iteration for $y' = 2t(y + 1), \\; y(0) = 0$**\nThe integral equation is:\n$$\ny(t) = \\int_0^t 2s(y(s) + 1)\\,ds\n$$\nThe Picard iterates are defined recursively by $y_0(t) = 0$ and:\n$$\ny_{n+1}(t) = \\int_0^t 2s(y_n(s) + 1)\\,ds\n$$\nThese polynomials form the Taylor series of the exact analytical solution $y(t) = e^{t^2} - 1$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Iterate 0:** $y_0(t) = 0$.\n• **Iterate 1:** $y_1(t) = \\int_0^t 2s(0 + 1)\\,ds = [s^2]_0^t = t^2$.\n• **Iterate 2:** $y_2(t) = \\int_0^t 2s(s^2 + 1)\\,ds = \\int_0^t (2s^3 + 2s)\\,ds = t^2 + \\frac{t^4}{2}$.\n• **Iterate 3:** $y_3(t) = \\int_0^t 2s(s^2 + \\frac{s^4}{2} + 1)\\,ds = t^2 + \\frac{t^4}{2} + \\frac{t^6}{6}$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "Under the Lipschitz condition, the sequence of Picard approximations converges ___ on a small closed interval to the unique solution.",
      "blankAnswer": "uniformly",
      "blankDistractors": ["pointwise", "divergently", "weakly"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "For the IVP y' = 2t(y+1), y(0) = 0, evaluate the second Picard iterate y_2(t) = t^2 + t^4 / 2 at t = 1.0.",
      "numericAnswer": 1.5,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the optimal Lipschitz constant L for f(t, y) = t^2 sin(y) + y on the domain [-2, 2] x [-5, 5]?",
      "options": [
        { "text": "L = 5 (since |df/dy| = |t^2 cos(y) + 1| <= 2^2 * 1 + 1 = 5)", "isCorrect": true, "explanation": "Correct! By the Mean Value Theorem, L = max |df/dy| = max |t^2 cos(y) + 1| = 4(1) + 1 = 5." },
        { "text": "L = 4", "isCorrect": false, "explanation": "Incorrect: Forgot the derivative of +y which is +1." },
        { "text": "L = 1", "isCorrect": false, "explanation": "Incorrect: Does not account for t^2." },
        { "text": "L = 25", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
