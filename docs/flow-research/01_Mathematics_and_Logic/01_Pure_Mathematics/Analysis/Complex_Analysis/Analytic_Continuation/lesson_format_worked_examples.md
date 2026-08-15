# Duofy Reusable Lesson Format: Analytic Continuation - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis / Analytic_Continuation`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly continue power series along paths in the complex plane, compute monodromy phase shifts around branch points for multi-valued functions like $\ln z$ and $z^{1/2}$, and extend functions across boundaries using Schwarz reflection.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Monodromy Branch Point Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Logarithm Path Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Phase Shift Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Phase Accumulation Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Lacunary Natural Boundary Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the continuation of $\ln z$ along the circular path $\gamma(t) = e^{i t}$ for $t \in [0, 2\pi]$ starting with $\ln(1) = 0$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps of parameterizing the circle, updating the imaginary component $\text{Im}(\ln z) = \arg(z)$, and ending at $\ln(1) = 2\pi i$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that encircling $z=0$ once counterclockwise adds $2\pi i$ to the complex logarithm. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to calculate the value of $\sqrt{z}$ after 1 complete counterclockwise loop around 0, starting from $+1$ (result: $-1$, so numeric answer $-1.0$).
5. **Slide 5 (`quiz`):** Quiz testing the natural boundary of the lacunary series $f(z) = \sum_{n=0}^\infty z^{2^n}$.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Monodromy of the Complex Logarithm**\nLet $f_0(z) = \\sum_{n=1}^\\infty \\frac{(-1)^{n-1}}{n}(z-1)^n$ define $\\ln(z)$ near $z_0 = 1$ with $\\ln(1) = 0$.\nContinue $f_0$ along the unit circle $\\gamma(t) = e^{it}$ from $t=0$ to $t=2\\pi$:\n$$\n\\ln(\\gamma(t)) = \\ln|e^{it}| + i \\arg(e^{it}) = 0 + it\n$$\nAt $t=2\\pi$, $\\gamma(2\\pi) = 1$, but the continued value is:\n$$\nf_{2\\pi}(1) = 0 + 2\\pi i \\ne f_0(1)\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Starting Element):** At $t=0$, $z=1$, $\\ln(1) = 0$ (principal branch).\n• **Step 2 (Path Subdivision):** Cover the path with 4 overlapping disks centered at $1, i, -1, -i$.\n• **Step 3 (Continuous Argument Tracking):** The argument $\\theta(t) = t$ increases smoothly from $0 \\to \\pi/2 \\to \\pi \\to 3\\pi/2 \\to 2\\pi$.\n• **Step 4 (Branch Shift):** Upon returning to $z=1$, the function has crossed onto the next sheet of the Riemann surface, giving value $2\\pi i$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "Analytically continuing the complex square root function sqrt(z) once counterclockwise around z = 0 transforms the initial value +1 into ___.",
      "blankAnswer": "-1",
      "blankDistractors": ["+1", "+i", "-i"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Starting with f(1) = 1 for the function f(z) = sqrt(z), what is the real part of the value obtained after 1 complete counterclockwise loop around the origin?",
      "numericAnswer": -1.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the lacunary power series f(z) = sum_{k=0}^infty z^{2^k} have the unit circle |z| = 1 as a natural boundary?",
      "options": [
        { "text": "The 2^n-th roots of unity are dense on the unit circle, and f(z) blows up to infinity as z approaches every root of unity", "isCorrect": true, "explanation": "Correct! Since singular points are dense on |z|=1, no analytic continuation can cross the unit circle anywhere." },
        { "text": "Because the radius of convergence is infinite", "isCorrect": false, "explanation": "Incorrect: The radius of convergence is exactly 1." },
        { "text": "Because f(z) is identically zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because f(z) is a polynomial", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
