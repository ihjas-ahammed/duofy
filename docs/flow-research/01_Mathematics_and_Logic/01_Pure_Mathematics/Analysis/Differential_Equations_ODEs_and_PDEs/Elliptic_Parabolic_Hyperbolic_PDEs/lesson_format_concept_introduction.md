# Duofy Reusable Lesson Format: Elliptic, Parabolic, and Hyperbolic PDEs - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Differential_Equations_ODEs_and_PDEs / Elliptic_Parabolic_Hyperbolic_PDEs`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the classification of second-order linear PDEs $A u_{xx} + B u_{xy} + C u_{yy} + \dots = 0$ via the discriminant $\Delta = B^2 - 4AC$, connecting each category (Elliptic, Parabolic, Hyperbolic) to physical phenomena (Equilibrium, Diffusion, Wave propagation).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | PDE Discriminant & Classification Table | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Information Propagation Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Prototype Equation & PDE Type Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Discriminant Sign Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Variable Coefficient Classification Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the general second-order PDE $A u_{xx} + B u_{xy} + C u_{yy} + \dots = 0$ and discriminant $\Delta = B^2 - 4AC$: Hyperbolic ($\Delta > 0$), Parabolic ($\Delta = 0$), Elliptic ($\Delta < 0$).
2. **Slide 2 (`concept_pieces`):** Deconstruct Laplace (equilibrium, no real characteristics), Heat (dissipation, infinite speed smoothing), Wave (finite speed, characteristic lines $x \pm ct$).
3. **Slide 3 (`matching`):** Pair 4 PDEs (Laplace, Heat, Wave, Tricomi) with their exact classification categories.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that a PDE is elliptic when $B^2 - 4AC < 0$. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking to classify the Tricomi equation $y u_{xx} + u_{yy} = 0$ in the upper half-plane ($y > 0$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Classification of Second-Order Linear PDEs**\nFor $A(x,y) u_{xx} + B(x,y) u_{xy} + C(x,y) u_{yy} + D u_x + E u_y + F u = G$, the **discriminant** is:\n$$\n\\Delta(x, y) = B^2 - 4AC\n$$\n• **Hyperbolic** ($\\Delta > 0$): Models wave motion and vibrations (e.g. Wave equation $u_{tt} - c^2 u_{xx} = 0$).\n• **Parabolic** ($\\Delta = 0$): Models diffusion and heat conduction (e.g. Heat equation $u_t - k u_{xx} = 0$).\n• **Elliptic** ($\\Delta < 0$): Models steady-state equilibrium (e.g. Laplace equation $u_{xx} + u_{yy} = 0$)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Elliptic ($B^2 - 4AC < 0$):** No real characteristic directions. Information diffuses omnidirectionally. Well-posed for boundary value problems on closed domains.\n• **Parabolic ($B^2 - 4AC = 0$):** Exactly one family of real characteristics. Time-irreversible smoothing of initial data.\n• **Hyperbolic ($B^2 - 4AC > 0$):** Two distinct families of real characteristics. Information propagates at finite speed $c$ along characteristic lines $x \\pm ct = \\text{const}$.\n• **Regularity Differences:** Elliptic and parabolic equations smooth out rough data, while hyperbolic equations propagate discontinuities (wavefronts/shocks)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each physical partial differential equation to its mathematical type.",
      "matchPairs": [
        { "left": "u_{xx} + u_{yy} = 0 (Laplace Equation)", "right": "Elliptic (B^2 - 4AC = -4 < 0)" },
        { "left": "u_t - k u_{xx} = 0 (Heat Equation)", "right": "Parabolic (B^2 - 4AC = 0)" },
        { "left": "u_{tt} - c^2 u_{xx} = 0 (Wave Equation)", "right": "Hyperbolic (B^2 - 4AC = 4c^2 > 0)" },
        { "left": "u_{xx} - y u_{yy} = 0 for y > 0", "right": "Hyperbolic (B^2 - 4AC = 4y > 0)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A second-order partial differential equation is elliptic if and only if the discriminant B^2 - 4AC is strictly ___ than zero.",
      "blankAnswer": "less",
      "blankDistractors": ["greater", "equal", "constant"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the classification of the Tricomi equation y u_{xx} + u_{yy} = 0 in the upper half-plane y > 0?",
      "options": [
        { "text": "Elliptic, because A = y, B = 0, C = 1 => B^2 - 4AC = -4y < 0", "isCorrect": true, "explanation": "Correct! When y > 0, the discriminant is strictly negative (-4y < 0), making the equation elliptic." },
        { "text": "Hyperbolic", "isCorrect": false, "explanation": "Incorrect: It is hyperbolic in the lower half-plane y < 0, where -4y > 0." },
        { "text": "Parabolic", "isCorrect": false, "explanation": "Incorrect: It is parabolic only on the line y = 0." },
        { "text": "Non-linear", "isCorrect": false, "explanation": "Incorrect: The Tricomi equation is linear." }
      ]
    }
  ]
}
```
