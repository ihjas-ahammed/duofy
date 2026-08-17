# Duofy Reusable Lesson Format: Euler's Equations of Motion and Torque-Free Rotation

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Classical_Mechanics / Rigid_Body_Dynamics`  
**Lesson Format Type:** `eulers_equations_of_motion_and_torque_free_rotation`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through rotational dynamics in rotating body-fixed frames: derive **Euler's Equations of Motion (Leonhard Euler, 1758)** ($I_1 \dot{\omega}_1 - (I_2 - I_3)\omega_2 \omega_3 = N_1$), solve for **Torque-Free Precession of Symmetric Tops** ($I_1 = I_2 \ne I_3 \implies \dot{\omega}_3 = 0$), compute the body precession frequency $\Omega_b = \frac{I_1 - I_3}{I_1} \omega_3$, and analyze the **Chandler Wobble** of rotating Earth.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Euler's Equations & Torque-Free Rotation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Torque-Free Symmetric Top Solution Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Angular Velocity Component & Dynamic Behavior Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Constant Spin Component in Torque-Free Symmetric Top Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Free Precession Direction in Oblate vs Prolate Top Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Newton's rotational law in the space-fixed inertial frame: $\left(\frac{d\mathbf{L}}{dt}\right)_{\text{space}} = \mathbf{N}$. Transform to the rotating body-fixed frame (where $\mathbf{I} = \operatorname{diag}(I_1, I_2, I_3)$ is constant):
   $$\left(\frac{d\mathbf{L}}{dt}\right)_{\text{space}} = \left(\frac{d\mathbf{L}}{dt}\right)_{\text{body}} + \boldsymbol{\omega} \times \mathbf{L} = \mathbf{N}$$
   - **Euler's Equations of Motion:**
     $$I_1 \dot{\omega}_1 - (I_2 - I_3)\omega_2 \omega_3 = N_1$$
     $$I_2 \dot{\omega}_2 - (I_3 - I_1)\omega_3 \omega_1 = N_2$$
     $$I_3 \dot{\omega}_3 - (I_1 - I_2)\omega_1 \omega_2 = N_3$$
   - **Torque-Free Symmetric Top ($\mathbf{N} = \mathbf{0}, I_1 = I_2 \ne I_3$):** $\dot{\omega}_3 = 0 \implies \omega_3 = \text{const}$. Transverse components undergo harmonic precession at **Body Precession Frequency**:
     $$\Omega_b = \frac{I_1 - I_3}{I_1} \omega_3$$
2. **Slide 2 (`ordering`):** Provide 5 steps solving the torque-free symmetric top: (1) set torques $N_1 = N_2 = N_3 = 0$ and $I_1 = I_2$, (2) observe 3rd Euler equation: $I_3 \dot{\omega}_3 - (I_1 - I_1)\omega_1 \omega_2 = 0 \implies \dot{\omega}_3 = 0 \implies \omega_3 = \text{const}$, (3) write coupled equations for $\omega_1, \omega_2$: $\dot{\omega}_1 = -\left(\frac{I_3 - I_1}{I_1}\omega_3\right)\omega_2 = -\Omega_b \omega_2$ and $\dot{\omega}_2 = \Omega_b \omega_1$, (4) differentiate $\dot{\omega}_1$: $\ddot{\omega}_1 = -\Omega_b \dot{\omega}_2 = -\Omega_b^2 \omega_1$, (5) solve harmonic oscillator to obtain circular precession: $\omega_1(t) = \omega_\perp \cos(\Omega_b t)$ and $\omega_2(t) = \omega_\perp \sin(\Omega_b t)$!
3. **Slide 3 (`matching`):** Pair 4 rotational quantities ($\omega_3$, $\Omega_b$, $\mathbf{L}_{\text{space}}$, $T_{\text{rot}}$) with their conservation/precession behaviors.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in torque-free rotation of a symmetric top ($I_1 = I_2$), the spin component $\omega_3$ along the symmetry axis is constant in time. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the Earth's Chandler Wobble: Earth is an oblate spheroid ($I_3 > I_1 = I_2$). For torque-free rotation, what is the sign and period of Earth's free wobble? (Because $I_3 > I_1$, the precession frequency $\Omega_b = \frac{I_1 - I_3}{I_1} \omega_3$ is NEGATIVE (precesses in the opposite direction of daily rotation); for rigid Earth $\frac{I_3 - I_1}{I_1} \approx \frac{1}{300}$, predicting a period of $\sim 300\text{ days}$, observed as the $433\text{-day}$ **Chandler Wobble** due to Earth's elastic deformation and oceans).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "eulers_equations_of_motion_and_torque_free_rotation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Euler's Equations and Torque-Free Precession**\n• **Frame Transformation of Angular Momentum:**\n$$\n\\left(\\frac{d\\mathbf{L}}{dt}\\right)_{\\text{space}} = \\left(\\frac{d\\mathbf{L}}{dt}\\right)_{\\text{body}} + \\boldsymbol{\\omega} \\times \\mathbf{L} = \\mathbf{N}\n$$\n• **Euler's Equations of Motion (in Principal Axis Body Frame):**\n$$\nI_1 \\dot{\\omega}_1 - (I_2 - I_3)\\omega_2 \\omega_3 = N_1\n$$\n$$\nI_2 \\dot{\\omega}_2 - (I_3 - I_1)\\omega_3 \\omega_1 = N_2\n$$\n$$\nI_3 \\dot{\\omega}_3 - (I_1 - I_2)\\omega_1 \\omega_2 = N_3\n$$\n• **Torque-Free Symmetric Top ($I_1 = I_2 \\ne I_3, \\, \\mathbf{N} = \\mathbf{0}$):**\n  - $\\omega_3 = \\text{const}$ (spin along symmetry axis is strictly constant!).\n  - $\\boldsymbol{\\omega}_\\perp = (\\omega_1, \\omega_2)$ precesses at **Body Precession Frequency**:\n$$\n\\Omega_b = \\frac{I_1 - I_3}{I_1} \\omega_3\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the algebraic steps solving the torque-free rotation of a symmetric top (I_1 = I_2).",
      "orderItems": [
        "Set external torques N_1 = N_2 = N_3 = 0 and principal moments I_1 = I_2",
        "From the 3rd Euler equation I_3 omega_dot_3 = 0, deduce that omega_3 is a constant of motion",
        "Define body precession rate Omega_b = (I_1 - I_3)/I_1 * omega_3 to obtain coupled ODEs: omega_dot_1 = -Omega_b * omega_2 and omega_dot_2 = Omega_b * omega_1",
        "Differentiate omega_dot_1 to uncouple: omega_ddot_1 = -Omega_b * omega_dot_2 = -Omega_b^2 * omega_1",
        "Solve standard harmonic oscillator equation: omega_1(t) = omega_perp * cos(Omega_b * t) and omega_2(t) = omega_perp * sin(Omega_b * t)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each rotational quantity to its torque-free symmetric top behavior.",
      "matchPairs": [
        { "left": "Symmetry Axis Spin omega_3", "right": "Strictly constant in time (omega_dot_3 = 0)" },
        { "left": "Transverse Vector (omega_1, omega_2)", "right": "Traces a circular cone around the body symmetry axis at rate Omega_b" },
        { "left": "Space Angular Momentum L_space", "right": "Strictly constant in magnitude and direction in inertial space" },
        { "left": "Rotational Kinetic Energy T_rot", "right": "Strictly conserved: T = (1/2)(I_1 omega_perp^2 + I_3 omega_3^2) = const" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In torque-free rotation of a symmetric top with I_1 = I_2, the angular velocity component omega_3 along the symmetry axis is ___ in time.",
      "blankAnswer": "constant",
      "blankDistractors": ["oscillating", "growing", "zero"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does Earth's rotation axis undergo the famous Chandler Wobble with a period of approximately 433 days?",
      "options": [
        { "text": "Because Earth is an OBLATE spheroid (I_3 > I_1 = I_2), Euler's equations predict a torque-free free precession of the geographic pole around the rotation axis with period T_b = 2pi / Omega_b ≈ 305 days for a rigid body (lengthened to 433 days by elasticity and ocean fluid dynamics)", "isCorrect": true, "explanation": "Correct! As an oblate top (flattened at the poles, I_3 > I_1), Earth's figure axis naturally precesses around its angular momentum vector in the absence of external torque, discovered by Seth Carlo Chandler in 1891." },
        { "text": "Because the Moon's gravity turns off once a year", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Earth is a perfect sphere (I_1 = I_2 = I_3)", "isCorrect": false, "explanation": "Incorrect: A sphere has Omega_b = 0 and does not wobble." },
        { "text": "Because Earth's core has zero mass", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
