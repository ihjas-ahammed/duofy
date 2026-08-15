# Duofy Reusable Lesson Format: Fluid Dynamics - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Fluid_Dynamics_and_Continuum_Mechanics`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to solve exact viscous flow profiles (Poiseuille pipe flow $u(r) = U_{max}(1 - r^2/R^2)$, Couette flow), evaluate Bernoulli pressure drops, and compute potential flow velocity fields.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Poiseuille Pipe Flow Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Velocity Integration Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Boundary Condition Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Bernoulli Velocity Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | No-Slip Wall Condition Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Hagen-Poiseuille Pipe Flow**\nFor steady, fully-developed laminar flow in a circular pipe of radius $R$ driven by pressure gradient $dp/dx$:\n$$\n\\mu \\frac{1}{r} \\frac{d}{dr}\\left( r \\frac{du}{dr} \\right) = \\frac{dp}{dx} = -G\n$$\nParabolic velocity profile: $u(r) = \\frac{G}{4\\mu} (R^2 - r^2)$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Integrate ODE once: $r \\frac{du}{dr} = -\\frac{G r^2}{2\\mu} + C_1 \\implies \\frac{du}{dr} = -\\frac{G r}{2\\mu} + \\frac{C_1}{r}$.\n• **Step 2:** Regularity at pipe centerline $r=0 \\implies C_1 = 0$.\n• **Step 3:** Integrate again: $u(r) = -\\frac{G r^2}{4\\mu} + C_2$.\n• **Step 4:** No-slip condition at wall $u(R) = 0 \\implies C_2 = \\frac{G R^2}{4\\mu}$. Profile: $u(r) = \\frac{G R^2}{4\\mu} \\left(1 - \\frac{r^2}{R^2}\\right)$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The boundary condition at a solid wall requiring fluid velocity to match the wall velocity is called the no-___ condition.",
      "blankAnswer": "slip",
      "blankDistractors": ["flow", "friction", "shear"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Using Bernoulli's equation $p_1 + \\frac{1}{2}\\rho u_1^2 = p_2 + \\frac{1}{2}\\rho u_2^2$, calculate exit velocity $u_2$ for water ($\\rho=1000$ kg/m³) flowing from high pressure $p_1 = 200,000$ Pa to $p_2 = 100,000$ Pa starting from rest ($u_1 = 0$).",
      "numericAnswer": 14.142,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the relationship between maximum velocity $U_{max}$ at centerline and average flow velocity $U_{avg}$ in Hagen-Poiseuille laminar pipe flow?",
      "options": [
        { "text": "U_avg = (1/2) U_max", "isCorrect": true, "explanation": "Correct! Integrating parabolic profile over circular cross-section yields U_avg = U_max / 2." },
        { "text": "U_avg = U_max", "isCorrect": false, "explanation": "Incorrect: That describes uniform plug flow." },
        { "text": "U_avg = (2/3) U_max", "isCorrect": false, "explanation": "Incorrect: That describes 2D channel flow between flat plates." },
        { "text": "U_avg = 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
