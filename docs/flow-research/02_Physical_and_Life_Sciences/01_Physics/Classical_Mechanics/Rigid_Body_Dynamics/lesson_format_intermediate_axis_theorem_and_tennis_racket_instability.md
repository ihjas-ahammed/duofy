# Duofy Reusable Lesson Format: Intermediate Axis Theorem and Tennis Racket Instability

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Classical_Mechanics / Rigid_Body_Dynamics`  
**Lesson Format Type:** `intermediate_axis_theorem_and_tennis_racket_instability`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the non-linear stability of 3D rigid bodies: formulate the **Intermediate Axis Theorem (Tennis Racket Theorem / Dzhanibekov Effect)** for asymmetric tops ($I_1 < I_2 < I_3$), linearize Euler's equations around principal rotations, prove stability around $I_1$ (minor axis) and $I_3$ (major axis), prove exponential instability around $I_2$ (intermediate axis), and analyze Poinsot ellipsoid phase trajectories.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Intermediate Axis Theorem & Perturbation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Linearized Stability Analysis Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Principal Axis of Rotation & Dynamic Stability Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Unstable Principal Axis Identifier Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Poinsot Ellipsoid Separatrix Phase Trajectory Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the **Intermediate Axis Theorem (Tennis Racket Theorem)** for an asymmetric rigid body with distinct principal moments:
   $$I_1 < I_2 < I_3$$
   - **Rotation about Major Axis ($I_3$):** **STABLE** (perturbations oscillate sinusoidally with real frequency $\Omega = \omega_3 \sqrt{\frac{(I_3 - I_1)(I_3 - I_2)}{I_1 I_2}}$).
   - **Rotation about Minor Axis ($I_1$):** **STABLE** (perturbations oscillate sinusoidally with real frequency $\Omega = \omega_1 \sqrt{\frac{(I_2 - I_1)(I_3 - I_1)}{I_2 I_3}}$).
   - **Rotation about Intermediate Axis ($I_2$):** **UNSTABLE** (linearized perturbation gives $\ddot{\eta} = +\lambda^2 \eta$ with real eigenvalue $\lambda = \omega_2 \sqrt{\frac{(I_2 - I_1)(I_3 - I_2)}{I_1 I_3}} > 0 \implies$ exponential divergence $e^{\lambda t}$, causing the body to periodically flip $180^\circ$ (Dzhanibekov Effect)!).
2. **Slide 2 (`ordering`):** Provide 5 steps proving the instability of rotation around the intermediate axis $I_2$: (1) set base rotation $\boldsymbol{\omega} = (\eta_1, \omega_2 + \eta_2, \eta_3)$ where $\eta_1, \eta_2, \eta_3 \ll \omega_2$ are small perturbations, (2) substitute into Euler's equations and drop second-order small terms: $I_1 \dot{\eta}_1 = (I_2 - I_3)\omega_2 \eta_3$ and $I_3 \dot{\eta}_3 = (I_1 - I_2)\omega_2 \eta_1$, (3) differentiate the first perturbation equation: $\ddot{\eta}_1 = \frac{I_2 - I_3}{I_1} \omega_2 \dot{\eta}_3$, (4) substitute $\dot{\eta}_3$: $\ddot{\eta}_1 = \frac{I_2 - I_3}{I_1} \omega_2 \left(\frac{I_1 - I_2}{I_3} \omega_2 \eta_1\right) = \frac{(I_2 - I_3)(I_1 - I_2)}{I_1 I_3} \omega_2^2 \eta_1$, (5) since $I_1 < I_2 < I_3$, both $(I_2 - I_3) < 0$ and $(I_1 - I_2) < 0$, so their product is POSITIVE: $\ddot{\eta}_1 = +\lambda^2 \eta_1 \implies \eta_1(t) \sim e^{+\lambda t}$ (exponential instability!).
3. **Slide 3 (`matching`):** Pair 4 rotational states (Rotation around Axis 1 ($I_1$), Rotation around Axis 2 ($I_2$), Rotation around Axis 3 ($I_3$), Separatrix Trajectory) with their phase space geometries (Stable Elliptic Fixed Point, Unstable Hyperbolic Saddle Point, Stable Elliptic Fixed Point, Heteroclinic Orbit connecting saddle points).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that rotation is unstable around the intermediate moment of inertia axis. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the physical manifestation of the Intermediate Axis Theorem (such as flipping a tennis racket or smartphone in the air): What happens when a tennis racket is spun around its intermediate handle-in-plane axis? (It cannot maintain pure rotation around that axis; small imperceptible perturbations grow exponentially, forcing the racket to execute a dramatic $180^\circ$ twist / flip before returning).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "intermediate_axis_theorem_and_tennis_racket_instability",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Intermediate Axis Theorem (Tennis Racket Theorem)**\n• **Principal Moments Order:** $I_1 < I_2 < I_3$ (Minor, Intermediate, Major axes).\n• **Stability Classification for Torque-Free Rotation:**\n  - **Axis 1 (Smallest Moment $I_1$):** **STABLE** (perturbations oscillate at real frequency $\\Omega_1$).\n  - **Axis 3 (Largest Moment $I_3$):** **STABLE** (perturbations oscillate at real frequency $\\Omega_3$).\n  - **Axis 2 (Intermediate Moment $I_2$):** **EXPONENTIALLY UNSTABLE!**\n• **Mathematical Criterion:** Perturbations around Axis 2 satisfy:\n$$\n\\ddot{\\eta}_1 = +\\lambda^2 \\eta_1, \\qquad \\lambda = \\omega_2 \\sqrt{\\frac{(I_2 - I_1)(I_3 - I_2)}{I_1 I_3}} > 0\n$$\n  *(Yields exponentially growing solutions $\\eta_1(t) \\propto e^{+\\lambda t}$, causing periodic $180^\\circ$ flips known as the **Dzhanibekov Effect**!).*"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the perturbation steps proving exponential instability around the intermediate axis I_2.",
      "orderItems": [
        "Express perturbed angular velocity around axis 2: omega = (eta_1, omega_2 + eta_2, eta_3) with eta_i << omega_2",
        "Substitute into Euler's equations and linearize: I_1 eta_dot_1 = (I_2 - I_3) omega_2 eta_3 and I_3 eta_dot_3 = (I_1 - I_2) omega_2 eta_1",
        "Differentiate the first perturbation equation with respect to time: eta_ddot_1 = (I_2 - I_3)/I_1 * omega_2 * eta_dot_3",
        "Substitute eta_dot_3: eta_ddot_1 = [ (I_2 - I_3)(I_1 - I_2) / (I_1 I_3) ] * omega_2^2 * eta_1",
        "Observe that for I_1 < I_2 < I_3, both factors (I_2 - I_3) < 0 and (I_1 - I_2) < 0 are negative, making their product STRICTLY POSITIVE (+lambda^2), yielding exponential growth e^{lambda t}"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each principal axis of rotation to its phase space stability classification.",
      "matchPairs": [
        { "left": "Smallest Moment Axis I_1", "right": "Stable Elliptic Center (small perturbations execute bounded harmonic orbits)" },
        { "left": "Intermediate Moment Axis I_2", "right": "Unstable Hyperbolic Saddle Point (perturbations diverge along unstable manifold)" },
        { "left": "Largest Moment Axis I_3", "right": "Stable Elliptic Center (small perturbations execute bounded harmonic orbits)" },
        { "left": "Separatrix Curve", "right": "Heteroclinic orbit connecting the two unstable saddle points across the energy ellipsoid" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "According to the Tennis Racket Theorem, rotation of an asymmetric body is unstable around the ___ moment of inertia axis.",
      "blankAnswer": "intermediate",
      "blankDistractors": ["largest", "smallest", "symmetry"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does a tennis racket or smartphone tossed in the air with spin around its intermediate axis inevitably execute a 180° twist in mid-air?",
      "options": [
        { "text": "Because rotation around the intermediate axis I_2 is a HYPERBOLIC SADDLE POINT in phase space; infinitesimal initial perturbations grow exponentially, forcing the angular velocity vector to swing along the separatrix to the opposite pole before returning", "isCorrect": true, "explanation": "Correct! Conserving both total energy T_rot and angular momentum squared L^2 restricts the angular velocity vector to polhode curves. Around I_2, these curves are open separatrices, causing the body to perform a complete 180° flip (Dzhanibekov effect)." },
        { "text": "Because air resistance always flips rotating objects", "isCorrect": false, "explanation": "Incorrect: The Dzhanibekov effect occurs in vacuum (tested on the ISS)." },
        { "text": "Because gravity pulls harder on the handle", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because angular momentum is not conserved in air", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
