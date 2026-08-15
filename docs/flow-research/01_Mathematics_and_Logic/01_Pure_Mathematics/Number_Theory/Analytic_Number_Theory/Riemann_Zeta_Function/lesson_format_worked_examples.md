# Duofy Reusable Lesson Format: Riemann Zeta Function - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Analytic_Number_Theory / Riemann_Zeta_Function`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly evaluate the analytically continued values $\zeta(0) = -1/2$ and $\zeta(-1) = -1/12$ via the reflection functional equation, compute Euler's Basel problem value $\zeta(2) = \frac{\pi^2}{6}$, and evaluate the pole residue $\operatorname{Res}_{s=1} \zeta(s) = 1$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Analytic Continuation $\zeta(-1)$ Evaluation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Functional Equation Calculation Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Simple Pole Residue Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Special Value Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Non-Trivial Zero Critical Line Verification Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the functional equation: $\zeta(1-s) = 2^{1-s} \pi^{-s} \cos\left(\frac{\pi s}{2}\right) \Gamma(s) \zeta(s)$. For $s = 2$, this allows evaluating $\zeta(-1)$ using $\zeta(2) = \frac{\pi^2}{6}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) set $s = 2$ in the formula: $\zeta(-1) = 2^{-1} \pi^{-2} \cos(\pi) \Gamma(2) \zeta(2)$, (2) evaluate each component: $2^{-1} = 1/2$, $\cos(\pi) = -1$, $\Gamma(2) = 1! = 1$, (3) substitute $\zeta(2) = \pi^2 / 6$: $\zeta(-1) = \left(\frac{1}{2}\right) \left(\frac{1}{\pi^2}\right) (-1) (1) \left(\frac{\pi^2}{6}\right)$, (4) simplify: the $\pi^2$ terms cancel out completely: $\zeta(-1) = -\frac{1}{12}$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the residue of $\zeta(s)$ at its simple pole $s=1$ is strictly equal to one. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute $\zeta(2) = \pi^2 / 6 \approx 1.64493$ (numeric answer 1.64).
5. **Slide 5 (`quiz`):** Quiz calculating the first non-trivial zero $\rho_1 \approx 1/2 + 14.1347 i$: What is the real part of $\rho_1$? ($1/2 = 0.5$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Computing $\\zeta(-1) = -\\frac{1}{12}$ via the Functional Equation**\nThe reflection formula for the Riemann Zeta Function is:\n$$\n\\zeta(1 - s) = 2^{1-s} \\pi^{-s} \\cos\\left(\\frac{\\pi s}{2}\\right) \\Gamma(s) \\zeta(s)\n$$\nSetting $s = 2$, we can evaluate $\\zeta(1 - 2) = \\zeta(-1)$ using Euler's known value $\\zeta(2) = \\frac{\\pi^2}{6}$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Substitute $s = 2$):**\n  $$\\zeta(-1) = 2^{1-2} \\pi^{-2} \\cos\\left(\\frac{2\\pi}{2}\\right) \\Gamma(2) \\zeta(2)$$\n• **Step 2 (Evaluate Individual Terms):**\n  $$2^{-1} = \\frac{1}{2}, \\quad \\cos(\\pi) = -1, \\quad \\Gamma(2) = 1! = 1, \\quad \\zeta(2) = \\frac{\\pi^2}{6}$$\n• **Step 3 (Assemble Product):**\n  $$\\zeta(-1) = \\left(\\frac{1}{2}\\right) \\left(\\frac{1}{\\pi^2}\\right) (-1) (1) \\left(\\frac{\\pi^2}{6}\\right)$$\n• **Step 4 (Cancel Factors):** The transcendental factors $\\pi^2$ cancel identically: $\\zeta(-1) = -\\frac{1}{2 \\times 6} = -\\frac{1}{12}$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The Riemann zeta function zeta(s) has a unique simple pole at s = 1 whose complex residue is strictly ___.",
      "blankAnswer": "one",
      "blankDistractors": ["zero", "pi", "two"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the value of Euler's Basel series zeta(2) = pi^2 / 6 to two decimal places.",
      "numericAnswer": 1.64,
      "numericTolerance": 0.02
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "The first non-trivial zero of the Riemann zeta function is rho_1 approx 0.5 + 14.1347 i. What is its real part Re(rho_1)?",
      "options": [
        { "text": "0.5 (1/2, lying exactly on the critical line)", "isCorrect": true, "explanation": "Correct! As conjectured by Riemann, the zero lies on the critical line Re(s) = 1/2 with imaginary height gamma_1 approx 14.1347." },
        { "text": "1.0", "isCorrect": false, "explanation": "Incorrect: Re(s) = 1 is the boundary of the critical strip." },
        { "text": "0.0", "isCorrect": false, "explanation": "Incorrect: Re(s) = 0 is the left boundary." },
        { "text": "14.1347", "isCorrect": false, "explanation": "Incorrect: 14.1347 is the imaginary part Im(rho_1)." }
      ]
    }
  ]
}
```
