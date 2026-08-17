# Duofy Reusable Lesson Format: Non-Inertial Frames and Coriolis Acceleration

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Classical_Mechanics / Kinematics_and_Newtonian_Dynamics`  
**Lesson Format Type:** `non_inertial_frames_and_coriolis_acceleration`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to analyze mechanics in **Non-Inertial (Rotating & Accelerating) Reference Frames**: derive the full equation of motion with all 4 fictitious forces (**Translational**, **Euler $\mathbf{F}_{\text{Euler}} = -m\dot{\boldsymbol{\omega}}\times\mathbf{r}$**, **Coriolis $\mathbf{F}_{\text{Cor}} = -2m\boldsymbol{\omega}\times\mathbf{v}_{\text{rot}}$**, and **Centrifugal $\mathbf{F}_{\text{Cent}} = -m\boldsymbol{\omega}\times(\boldsymbol{\omega}\times\mathbf{r})$**), calculate eastward deflection of falling objects, and analyze the **Foucault Pendulum Precession**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Non-Inertial Frames & Fictitious Forces Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Operator (d/dt)_{inertial} Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Fictitious Pseudo-Force & Mathematical Form Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Coriolis Northern Hemisphere Deflection Direction Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Foucault Pendulum Precession Rate with Latitude Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the transformation between an inertial frame $S_0$ and a rotating frame $S$ with angular velocity $\boldsymbol{\omega}$:
   $$\left(\frac{d\mathbf{A}}{dt}\right)_{\text{in}} = \left(\frac{d\mathbf{A}}{dt}\right)_{\text{rot}} + \boldsymbol{\omega} \times \mathbf{A}$$
   State Newton's Second Law in the Rotating Frame:
   $$m \mathbf{a}_{\text{rot}} = \mathbf{F}_{\text{real}} + \mathbf{F}_{\text{trans}} + \mathbf{F}_{\text{Euler}} + \mathbf{F}_{\text{Cor}} + \mathbf{F}_{\text{Cent}}$$
   - **Translational Force:** $\mathbf{F}_{\text{trans}} = -m \mathbf{A}_0$.
   - **Euler Force:** $\mathbf{F}_{\text{Euler}} = -m (\dot{\boldsymbol{\omega}} \times \mathbf{r})$ (due to angular acceleration).
   - **Coriolis Force:** $\mathbf{F}_{\text{Cor}} = -2m (\boldsymbol{\omega} \times \mathbf{v}_{\text{rot}})$ (acts on moving objects).
   - **Centrifugal Force:** $\mathbf{F}_{\text{Cent}} = -m \boldsymbol{\omega} \times (\boldsymbol{\omega} \times \mathbf{r}) = m \omega^2 r_\perp \hat{\mathbf{r}}_\perp$ (outward radial force).
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the acceleration transformation: (1) relate velocities: $\mathbf{v}_{\text{in}} = \mathbf{v}_{\text{rot}} + \boldsymbol{\omega} \times \mathbf{r}$, (2) apply the time derivative operator $\frac{d}{dt}_{\text{in}} = \frac{d}{dt}_{\text{rot}} + \boldsymbol{\omega} \times$, (3) express acceleration: $\mathbf{a}_{\text{in}} = \left(\frac{d}{dt}_{\text{rot}} + \boldsymbol{\omega}\times\right)(\mathbf{v}_{\text{rot}} + \boldsymbol{\omega}\times\mathbf{r})$, (4) expand all 4 terms: $\mathbf{a}_{\text{rot}} + \dot{\boldsymbol{\omega}}\times\mathbf{r} + \boldsymbol{\omega}\times\mathbf{v}_{\text{rot}} + \boldsymbol{\omega}\times\mathbf{v}_{\text{rot}} + \boldsymbol{\omega}\times(\boldsymbol{\omega}\times\mathbf{r})$, (5) group terms and isolate $m\mathbf{a}_{\text{rot}} = m\mathbf{a}_{\text{in}} - m\dot{\boldsymbol{\omega}}\times\mathbf{r} - 2m(\boldsymbol{\omega}\times\mathbf{v}_{\text{rot}}) - m\boldsymbol{\omega}\times(\boldsymbol{\omega}\times\mathbf{r})$!
3. **Slide 3 (`matching`):** Pair 4 pseudo-forces (Coriolis, Centrifugal, Euler, Linear Inertial) with their physical triggers.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in the Northern Hemisphere, the Coriolis force deflects horizontally moving air and projectiles to the right. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the Foucault Pendulum (Léon Foucault, 1851): What is the 24-hour precession rate $\Omega_P$ of a Foucault pendulum at latitude $\lambda$? ($\Omega_P = \omega_{\text{Earth}} \sin\lambda$; at the North Pole ($\lambda = 90^\circ$), it completes a full $360^\circ$ clockwise rotation in 24 hours ($\sin 90^\circ = 1$), while at the Equator ($\lambda = 0^\circ$), $\sin 0^\circ = 0$ so it does not precess at all).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "non_inertial_frames_and_coriolis_acceleration",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Non-Inertial Frames and Fictitious Forces**\n• **Derivative Operator Relation:** For any vector $\\mathbf{A}$ in a frame rotating with $\\boldsymbol{\\omega}$:\n$$\n\\left(\\frac{d\\mathbf{A}}{dt}\\right)_{\\text{in}} = \\left(\\frac{d\\mathbf{A}}{dt}\\right)_{\\text{rot}} + \\boldsymbol{\\omega} \\times \\mathbf{A}\n$$\n• **Equation of Motion in Rotating Frame:**\n$$\nm \\mathbf{a}_{\\text{rot}} = \\mathbf{F}_{\\text{real}} + \\mathbf{F}_{\\text{Euler}} + \\mathbf{F}_{\\text{Cor}} + \\mathbf{F}_{\\text{Cent}}\n$$\n• **The 4 Fictitious Pseudo-Forces:**\n  - **Euler Force:** $\\mathbf{F}_{\\text{Euler}} = -m (\\dot{\\boldsymbol{\\omega}} \\times \\mathbf{r})$.\n  - **Coriolis Force:** $\\mathbf{F}_{\\text{Cor}} = -2m (\\boldsymbol{\\omega} \\times \\mathbf{v}_{\\text{rot}})$.\n  - **Centrifugal Force:** $\\mathbf{F}_{\\text{Cent}} = -m \\boldsymbol{\\omega} \\times (\\boldsymbol{\\omega} \\times \\mathbf{r}) = m \\omega^2 \\mathbf{r}_\\perp$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the vector operator steps deriving the Coriolis and Centrifugal accelerations.",
      "orderItems": [
        "Express inertial velocity in terms of rotating velocity: v_in = v_rot + omega x r",
        "Apply the time transformation operator d/dt_in = d/dt_rot + omega x to velocity v_in",
        "Expand operator application: a_in = (d/dt_rot + omega x)(v_rot + omega x r)",
        "Distribute terms: a_in = a_rot + omega_dot x r + 2 (omega x v_rot) + omega x (omega x r)",
        "Rearrange to solve for effective acceleration in rotating frame: a_rot = a_in - omega_dot x r - 2(omega x v_rot) - omega x (omega x r)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each fictitious force to its physical trigger.",
      "matchPairs": [
        { "left": "Coriolis Force -2m(omega x v_rot)", "right": "Acts on objects MOVING with velocity v_rot in rotating frame; causes cyclone spin" },
        { "left": "Centrifugal Force -m omega x (omega x r)", "right": "Outward radial force depending only on distance r_perp from rotation axis" },
        { "left": "Euler Force -m(omega_dot x r)", "right": "Arises when the angular speed of the frame accelerates (omega_dot != 0)" },
        { "left": "Translational Pseudo-Force -m A_0", "right": "Arises in linearly accelerating frames (e.g. feeling pushed back in accelerating car)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Due to the Coriolis force, a horizontally moving projectile in the Northern Hemisphere is deflected to the ___ of its direction of motion.",
      "blankAnswer": "right",
      "blankDistractors": ["left", "up", "down"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the daily rotation rate of a Foucault Pendulum's plane of oscillation at latitude lambda on Earth?",
      "options": [
        { "text": "Omega_P = omega_Earth * sin(lambda) = 360°/day * sin(lambda); it completes a full 360° rotation in 24 hours at the North Pole (sin 90° = 1) and does NOT precess at the Equator (sin 0° = 0)", "isCorrect": true, "explanation": "Correct! The vertical component of Earth's angular velocity vector is omega_z = omega_Earth * sin(lambda). The horizontal Coriolis force causes the pendulum's oscillation plane to precess clockwise in the Northern hemisphere at rate omega_Earth * sin(lambda)." },
        { "text": "Omega_P = omega_Earth * cos(lambda)", "isCorrect": false, "explanation": "Incorrect: The horizontal plane couples to sin(lambda)." },
        { "text": "It rotates 360° per hour at all latitudes", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It never rotates because gravity is vertical", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
