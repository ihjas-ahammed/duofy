# Duofy Reusable Lesson Format: Slope-Deflection (Continuous Beams & Joint Rotations)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Structural_Analysis_and_Mechanics / Slope_Deflection_and_Moment_Distribution`  
**Lesson Format Type:** `slope_deflection_equations_and_continuous_beam_moments`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through George A. Maney's classical **Slope-Deflection Method** for continuous statically indeterminate beams, the formulation of Fixed-End Moments ($\text{FEM}$), internal end moment equations as functions of joint rotations ($\theta_A, \theta_B$) and chord settlement rotations ($\psi = \Delta/L$), joint moment equilibrium equations ($\sum M_{\text{joint } B} = 0$), and back-substitution to plot final Bending Moment Diagrams (BMDs) (Russell C. Hibbeler *Structural Analysis* 10th ed. Chapter 11; Aslam Kassimali *Structural Analysis* 6th ed. Chapter 14): formulate the **General Slope-Deflection Equations (Clockwise Positive)**:
$$\mathbf{M_{AB} = \text{FEM}_{AB} + \frac{2 E I}{L} \left( 2 \theta_A + \theta_B - 3 \psi \right) \quad \Big| \quad \mathbf{M_{BA} = \text{FEM}_{BA} + \frac{2 E I}{L} \left( 2 \theta_B + \theta_A - 3 \psi \right)}}$$
where $\psi = \frac{\Delta}{L}$ is the chord rotation angle resulting from support settlement;
master the **Standard Fixed-End Moment Library**:
1. **Uniformly Distributed Load ($w$ over span $L$):**
   $$\mathbf{\text{FEM}_{AB} = -\frac{w L^2}{12} \quad \text{and} \quad \text{FEM}_{BA} = +\frac{w L^2}{12}}$$
2. **Center Point Load ($P$ at $L/2$):**
   $$\mathbf{\text{FEM}_{AB} = -\frac{P L}{8} \quad \text{and} \quad \text{FEM}_{BA} = +\frac{P L}{8}}$$
derive the **Joint Equilibrium Condition**:
$$\mathbf{\sum M_{\text{joint } B} = 0 \implies M_{BA} + M_{BC} = 0}$$
(proving how slope-deflection converts indeterminate flexural analysis into a deterministic system of linear algebraic equations where the unknown variables are physical joint rotations $\theta$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Slope-Deflection Equations ($M_{AB} = \text{FEM} + \frac{2EI}{L}(2\theta_A+\theta_B-3\psi)$), FEM Library & Equilibrium Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Solve a 2-Span Indeterminate Beam Using Slope-Deflection Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Slope-Deflection Variable / Support Condition & Technical Mathematical Value Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Slope-Deflection Method for a Fully Fixed Support A, the Boundary Condition Enforces That Rotation $\theta_A$ Equals Exactly ___ (Zero / 0) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Civil Structural Problem: Calculating Intermediate Support Moment M_BA for a 2-Span Continuous Beam Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Slope-Deflection Equations (Maney 1915; Hibbeler 2018):
   - **Slope-Deflection Formulations:**
     $$\mathbf{M_{AB} = \text{FEM}_{AB} + \frac{2 E I}{L} (2\theta_A + \theta_B - 3\psi) \quad \Big| \quad \text{Fixed Support: } \theta = 0 \quad \Big| \quad \text{Equilibrium: } \sum M_B = M_{BA} + M_{BC} = 0}$$
   - **Fixed-End Moment Comparison Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Loading Configuration} & \textbf{Span Parameter} & \textbf{Left End FEM } M_{AB} & \textbf{Right End FEM } M_{BA} \\
     \hline
     \mathbf{\text{Uniform Load } (w)} & \text{Full Span } L & \mathbf{-\frac{w L^2}{12} \ (\text{Counter-Clockwise})} & \mathbf{+\frac{w L^2}{12} \ (\text{Clockwise})} \\
     \mathbf{\text{Center Point Load } (P)} & \text{Midpoint } L/2 & \mathbf{-\frac{P L}{8}} & \mathbf{+\frac{P L}{8}} \\
     \mathbf{\text{Point Load at } a, b} & \text{Offset } a + b = L & -\frac{P a b^2}{L^2} & +\frac{P a^2 b}{L^2} \\
     \hline
     \end{array}$$
   - **The Sign Convention Invariant:** All moments and joint rotations acting **Clockwise are POSITIVE ($+$)**, while those acting **Counter-Clockwise are NEGATIVE ($-$)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of slope-deflection beam analysis: (1) identify kinematically unknown joint rotations (e.g. $\theta_B$), setting fixed boundary rotations to zero ($\theta_A = 0$), (2) compute Fixed-End Moments ($\text{FEM}$) for each loaded span, (3) write slope-deflection equations for every span end moment ($M_{AB}, M_{BA}, M_{BC}, M_{CB}$), (4) apply joint moment equilibrium: $\sum M_B = M_{BA} + M_{BC} = 0$ to solve for joint rotation $\theta_B$, (5) back-substitute $\theta_B$ into the slope-deflection equations to compute final support bending moments!
3. **Slide 3 (`matching`):** Pair 4 concepts (Fixed Support Rotation $\theta=0$, Joint Equilibrium $M_{BA}+M_{BC}=0$, UDL FEM $-wL^2/12$, Chord Rotation $\psi=\Delta/L$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Zero (or 0). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on solving continuous beam: A 2-span continuous beam $ABC$ has fixed supports at $A$ and $C$, and a roller support at $B$. Span $AB$ ($L_1 = 6.0\text{ m}, \ EI$) carries a uniform load $w = 12.0\text{ kN/m}$. Span $BC$ ($L_2 = 6.0\text{ m}, \ EI$) carries no load. Boundaries: $\theta_A = 0, \ \theta_C = 0, \ \Delta = 0$. What is the Fixed-End Moment $\text{FEM}_{BA}$, the joint rotation $\theta_B$, and the final intermediate support moment $M_{BA}$? ($\text{FEM}_{AB} = -\frac{12(6^2)}{12} = -36.0\text{ kNm}, \ \text{FEM}_{BA} = +36.0\text{ kNm}$; $\text{FEM}_{BC} = \text{FEM}_{CB} = 0$; $M_{BA} = 36 + \frac{2EI}{6}(2\theta_B) = 36 + \frac{2}{3}EI\theta_B$; $M_{BC} = 0 + \frac{2EI}{6}(2\theta_B) = \frac{2}{3}EI\theta_B$; $\sum M_B = M_{BA} + M_{BC} = 0 \implies 36 + \frac{4}{3}EI\theta_B = 0 \implies \theta_B = -\frac{36 \times 3}{4EI} = -\frac{27}{EI}$; $M_{BA} = 36 + \frac{2}{3}EI(-\frac{27}{EI}) = 36 - 18 = \mathbf{+18.0\text{ kNm}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "slope_deflection_equations_and_continuous_beam_moments",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Slope-Deflection Method for Beams (George Maney)**\n• **General Slope-Deflection Equations (Clockwise Positive):**\n$$\n\\mathbf{M_{AB} = \\text{FEM}_{AB} + \\frac{2 E I}{L} \\left( 2 \\theta_A + \\theta_B - 3 \\psi \\right) \\quad \\Big| \\quad \\mathbf{M_{BA} = \\text{FEM}_{BA} + \\frac{2 E I}{L} \\left( 2 \\theta_B + \\theta_A - 3 \\psi \\right)}}\n$$\n  - **$\\theta_A, \\theta_B$:** Physical joint rotations (radians);\n  - **$\\psi = \\Delta / L$:** Chord rotation angle caused by support settlement;\n  - **$\\text{FEM}$:** Fixed-End Moments from external span loading;\n• **Standard Fixed-End Moments:**\n$$\n\\mathbf{\\text{Uniform Load } (w): \\ \\text{FEM} = \\mp \\frac{w L^2}{12} \\quad \\Big| \\quad \\text{Center Point Load } (P): \\ \\text{FEM} = \\mp \\frac{P L}{8}}\n$$\n• **Joint Moment Equilibrium:**\n$$\n\\mathbf{\\sum M_{\\text{joint } B} = 0 \\implies M_{BA} + M_{BC} = 0}\n$$\n• **The Sign Convention Invariant:** All moments and rotations acting **Clockwise are strictly POSITIVE ($+$)**, while **Counter-Clockwise actions are NEGATIVE ($-$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to solve an indeterminate continuous beam using the Slope-Deflection Method.",
      "orderItems": [
        "Identify unknown degrees of freedom (joint rotations \u03b8) and enforce boundary conditions (e.g. \u03b8_fixed = 0)",
        "Calculate the Fixed-End Moments (FEM) for each loaded span using standard loading formulas",
        "Formulate the slope-deflection equations expressing end moments M_ij in terms of joint rotations \u03b8_i and \u03b8_j",
        "Apply joint moment equilibrium equations: \u2211M_joint = 0 (e.g. M_BA + M_BC = 0) and solve the linear system for all unknown \u03b8",
        "Back-substitute solved joint rotations into the slope-deflection equations to determine final internal support bending moments"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Slope-Deflection Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Fixed Support Boundary", "right": "\u03b8 = 0, zero rotational slope enforced by rigid fixed clamping" },
        { "left": "Joint Moment Equilibrium", "right": "M_BA + M_BC = 0, sum of internal member end moments at any continuous joint must balance to zero" },
        { "left": "Uniform Load FEM", "right": "FEM_left = -wL^2 / 12 and FEM_right = +wL^2 / 12" },
        { "left": "Chord Settlement Rotation (\u03c8)", "right": "\u03c8 = \u0394 / L, angular rotation of the member axis caused by unequal support settlement" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Slope-Deflection Method for a fully fixed support A, the boundary condition enforces that rotation \u03b8_A equals exactly ___.",
      "blankAnswer": "0",
      "blankDistractors": ["1", "infinity", "FEM"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 2-span continuous beam ABC has fixed supports at A and C, and roller at B. Span AB (L = 6.0 m, EI) carries uniform load w = 12.0 kN/m. Span BC (L = 6.0 m, EI) carries no load. Supports do not settle (\u03c8 = 0, \u03b8_A = \u03b8_C = 0). What is the Fixed-End Moment FEM_BA, the joint rotation \u03b8_B, and the final intermediate support moment M_BA?",
      "options": [
        { "text": "FEM_BA = +36.0 kNm, \u03b8_B = -27/(EI), and M_BA = +18.0 kNm (FEM_BA = +12*(6^2)/12 = +36 kNm; M_BA = 36 + (2EI/6)(2\u03b8_B); M_BC = (2EI/6)(2\u03b8_B); M_BA + M_BC = 0 \u2192 36 + (4/3)EI\u03b8_B = 0 \u2192 \u03b8_B = -27/(EI); M_BA = 36 + (2/3)EI(-27/EI) = +18.0 kNm)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Slope-Deflection Method (Russell C. Hibbeler *Structural Analysis* Chapter 11). 1. **Identify Boundary Conditions \\& Degrees of Freedom:** - Fixed support at $A \\implies \\theta_A = 0$. - Fixed support at $C \\implies \\theta_C = 0$. - No settlement $\\implies \\psi_{AB} = \\psi_{BC} = 0$. - Sole unknown kinematic degree of freedom: **Joint rotation $\\theta_B$**. 2. **Calculate Fixed-End Moments (FEM):** - Span $AB$ ($L_1 = 6.0\\text{ m}, w = 12.0\\text{ kN/m}$): $$\\text{FEM}_{AB} = -\\frac{w L^2}{12} = -\\frac{12.0 \\times (6.0)^2}{12} = -36.0\\text{ kN}\\cdot\\text{m}$$ $$\\text{FEM}_{BA} = +\\frac{w L^2}{12} = +\\frac{12.0 \\times (6.0)^2}{12} = \\mathbf{+36.0\\text{ kN}\\cdot\\text{m}}$$ - Span $BC$ ($L_2 = 6.0\\text{ m}$, unloaded): $$\\text{FEM}_{BC} = 0, \\quad \\text{FEM}_{CB} = 0$$ 3. **Formulate Slope-Deflection Equations:** $$M_{BA} = \\text{FEM}_{BA} + \\frac{2 E I}{L_1} (2\\theta_B + \\theta_A) = 36.0 + \\frac{2 E I}{6.0} (2\\theta_B + 0) = 36.0 + \\frac{2}{3} E I \\theta_B$$ $$M_{BC} = \\text{FEM}_{BC} + \\frac{2 E I}{L_2} (2\\theta_B + \\theta_C) = 0 + \\frac{2 E I}{6.0} (2\\theta_B + 0) = \\frac{2}{3} E I \\theta_B$$ 4. **Enforce Joint $B$ Moment Equilibrium:** $$\\sum M_B = 0 \\implies M_{BA} + M_{BC} = 0$$ $$\\left(36.0 + \\frac{2}{3} E I \\theta_B\\right) + \\left(\\frac{2}{3} E I \\theta_B\\right) = 0$$ $$36.0 + \\frac{4}{3} E I \\theta_B = 0 \\implies \\frac{4}{3} E I \\theta_B = -36.0$$ $$\\theta_B = -\\frac{36.0 \\times 3}{4 E I} = \\mathbf{-\\frac{27.0}{E I}\\text{ radians}}$$ 5. **Calculate Final Member End Moment $M_{BA}$:** $$M_{BA} = 36.0 + \\frac{2}{3} E I \\left(-\\frac{27.0}{E I}\\right) = 36.0 - 18.0 = \\mathbf{+18.0\\text{ kN}\\cdot\\text{m}}$$ $$M_{BC} = \\frac{2}{3} E I \\left(-\\frac{27.0}{E I}\\right) = \\mathbf{-18.0\\text{ kN}\\cdot\\text{m}} \\quad (M_{BA} + M_{BC} = 18 - 18 = 0\\text{ !})$$ Flawless continuous beam slope-deflection derivation!" },
        { "text": "FEM_BA = +36.0 kNm, \u03b8_B = 0, and M_BA = +36.0 kNm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "FEM_BA = +72.0 kNm, \u03b8_B = -54/(EI), and M_BA = +36.0 kNm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "FEM_BA = +36.0 kNm, \u03b8_B = +27/(EI), and M_BA = +54.0 kNm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
