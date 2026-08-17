# Duofy Reusable Lesson Format: Lorentz Transformations and Minkowski Spacetime

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Astrophysics_and_Relativity / Special_and_General_Relativity`  
**Lesson Format Type:** `lorentz_transformations_and_minkowski_spacetime`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce **Special Relativity (Albert Einstein, 1905)**: formulate the two postulates, derive the **Lorentz Boost Transformations** along the $x$-axis, compute the **Lorentz Factor $\gamma = 1/\sqrt{1 - v^2/c^2}$**, evaluate **Time Dilation ($\Delta t = \gamma \Delta t_0$)** and **Length Contraction ($L = L_0/\gamma$)**, and prove the invariance of the **Minkowski Spacetime Interval $ds^2 = -c^2 dt^2 + dx^2 + dy^2 + dz^2$**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Special Relativity Postulates & Lorentz Boosts Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Spacetime Invariant Interval Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Spacetime Separation Type & Causal Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical Relativistic Gamma Factor at 0.6c Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Relativity of Simultaneity and Twin Paradox Resolution Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Einstein's Two Postulates of Special Relativity (1905): (1) The laws of physics are invariant across all inertial reference frames; (2) The speed of light in vacuum $c$ is identical for all observers regardless of motion. State the Lorentz Transformations for a boost with relative velocity $v$ along the $x$-axis:
   $$ct' = \gamma \left(ct - \frac{v}{c} x\right), \qquad x' = \gamma (x - vt), \qquad y' = y, \qquad z' = z$$
   where the Lorentz factor is $\gamma = \frac{1}{\sqrt{1 - \beta^2}} = \frac{1}{\sqrt{1 - v^2/c^2}} \ge 1$. State Consequences:
   - **Time Dilation:** $\Delta t = \gamma \Delta t_0$ (moving clocks run slow).
   - **Length Contraction:** $L = \frac{L_0}{\gamma}$ (moving objects contract along the direction of motion).
   - **Minkowski Invariant Interval:** $\Delta s^2 = -c^2 \Delta t^2 + \Delta x^2 + \Delta y^2 + \Delta z^2 = \text{invariant}$.
2. **Slide 2 (`ordering`):** Provide 5 steps proving $\Delta s'^2 = \Delta s^2$ under a Lorentz boost: (1) write primed spacetime interval: $\Delta s'^2 = -(c\Delta t')^2 + (\Delta x')^2$, (2) substitute Lorentz boost expressions: $\Delta s'^2 = -[\gamma(c\Delta t - \beta \Delta x)]^2 + [\gamma(\Delta x - \beta c\Delta t)]^2$, (3) expand the squares: $\gamma^2 [ -(c\Delta t)^2 + 2\beta c \Delta t \Delta x - \beta^2 (\Delta x)^2 + (\Delta x)^2 - 2\beta c \Delta t \Delta x + \beta^2 (c\Delta t)^2 ]$, (4) cancel cross terms $2\beta c \Delta t \Delta x$ and group like terms: $\gamma^2 [ -(1 - \beta^2)(c\Delta t)^2 + (1 - \beta^2)(\Delta x)^2 ]$, (5) substitute $\gamma^2(1 - \beta^2) = 1$ to obtain $\Delta s'^2 = -(c\Delta t)^2 + (\Delta x)^2 = \Delta s^2$, proving invariance!
3. **Slide 3 (`matching`):** Pair 4 spacetime separation intervals ($\Delta s^2 < 0$ Timelike, $\Delta s^2 = 0$ Lightlike/Null, $\Delta s^2 > 0$ Spacelike, Proper Time $d\tau = \sqrt{-ds^2}/c$) with their physical causal characteristics.
4. **Slide 4 (`numerical`):** Ask student: For an object traveling at $v = 0.6c$ ($\beta = 0.6$), calculate the exact Lorentz factor $\gamma = \frac{1}{\sqrt{1 - 0.6^2}} = \frac{1}{\sqrt{1 - 0.36}} = \frac{1}{\sqrt{0.64}} = \frac{1}{0.8} = 1.25$ (numeric answer: 1.25).
5. **Slide 5 (`quiz`):** Quiz on resolving the Twin Paradox: Why does the traveling twin return strictly YOUNGER than the Earth twin? (Because the traveling twin undergoes NON-INERTIAL ACCELERATION when turning around, breaking the symmetry between the reference frames; the Earth twin remains in a single inertial frame throughout).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "lorentz_transformations_and_minkowski_spacetime",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Lorentz Transformations and Minkowski Spacetime**\n• **Einstein's Postulates (1905):**\n  1. Principle of Relativity: Physical laws are identical in all inertial frames.\n  2. Invariance of $c$: Light travels at $c = 299,792,458\\text{ m/s}$ in all frames.\n• **The Lorentz Boost Transformations ($x$-axis boost at speed $v$):**\n$$\nct' = \\gamma \\left(ct - \\frac{v}{c} x\\right), \\qquad x' = \\gamma (x - vt), \\qquad y' = y, \\qquad z' = z\n$$\nwhere $\\gamma = \\frac{1}{\\sqrt{1 - v^2/c^2}} \\ge 1$ is the **Lorentz Factor**.\n• **Kinematic Consequences:**\n  - **Time Dilation:** $\\Delta t = \\gamma \\Delta t_0$ (moving clocks run slow).\n  - **Length Contraction:** $L = L_0 / \\gamma$ (contracts along motion axis).\n• **Minkowski Invariant Interval:** $ds^2 = -c^2 dt^2 + dx^2 + dy^2 + dz^2 = \\text{invariant}$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the algebraic proof steps establishing that the spacetime interval ds^2 is invariant under Lorentz boosts.",
      "orderItems": [
        "Write the primed spacetime interval in 1D space: Delta s'^2 = -(c Delta t')^2 + (Delta x')^2",
        "Substitute the Lorentz boost formulas for c Delta t' and Delta x'",
        "Expand both squared terms and cancel the cross product terms +/- 2 beta c Delta t Delta x",
        "Group the terms as gamma^2 * (1 - beta^2) * [-(c Delta t)^2 + (Delta x)^2]",
        "Apply the identity gamma^2 * (1 - beta^2) = 1, concluding Delta s'^2 = Delta s^2"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each spacetime separation type to its causal physical property.",
      "matchPairs": [
        { "left": "Timelike (ds^2 < 0)", "right": "Causally connectable by massive particles (proper time dtau > 0 exists)" },
        { "left": "Lightlike / Null (ds^2 = 0)", "right": "Traversed by photons and massless particles at speed c" },
        { "left": "Spacelike (ds^2 > 0)", "right": "Causally disconnected; no physical signal can travel between the events" },
        { "left": "Proper Time dtau", "right": "Time measured by a clock attached to the moving particle: dtau = dt / gamma" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the relativistic Lorentz factor gamma for a spacecraft traveling at speed v = 0.6c (where beta = 0.6): gamma = 1 / sqrt(1 - 0.6^2).",
      "numericAnswer": 1.25,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How is the famous Twin Paradox resolved in Special Relativity?",
      "options": [
        { "text": "The symmetry is BROKEN because the traveling twin must DECELERATE, REVERSE, and ACCELERATE to return to Earth, meaning the traveling twin does NOT remain in a single inertial frame", "isCorrect": true, "explanation": "Correct! The traveling twin changes inertial frames during turnaround, experiencing physical acceleration. The Earth twin remains in an unaccelerated inertial frame, correctly finding the traveling twin to be younger upon reunion." },
        { "text": "Special Relativity fails for biological aging", "isCorrect": false, "explanation": "Incorrect: Atomic clocks on aircraft confirm the time dilation." },
        { "text": "Both twins age at the exact same rate", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The Earth twin is always younger", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
