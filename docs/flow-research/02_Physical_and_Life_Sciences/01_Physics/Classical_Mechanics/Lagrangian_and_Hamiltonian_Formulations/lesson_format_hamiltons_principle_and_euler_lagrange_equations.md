# Duofy Reusable Lesson Format: Hamilton's Principle and Euler-Lagrange Equations

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Classical_Mechanics / Lagrangian_and_Hamiltonian_Formulations`  
**Lesson Format Type:** `hamiltons_principle_and_euler_lagrange_equations`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce **Lagrangian Mechanics (Joseph-Louis Lagrange, 1788)**: formulate **Hamilton's Principle of Least / Stationary Action** ($\delta S = 0$ for $S = \int L \, dt$), derive the **Euler-Lagrange Equations** ($\frac{d}{dt}\frac{\partial L}{\partial \dot{q}_j} - \frac{\partial L}{\partial q_j} = 0$) using the calculus of variations, choose generalized coordinates to automatically satisfy holonomic constraints, and construct equations of motion for complex systems (simple and double pendulums, bead on rotating wire).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hamilton's Principle & Euler-Lagrange Equations Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Calculus of Variations Action Minimization Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Mechanical System & Lagrangian Expression Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Lagrangian Kinetic Minus Potential Difference Term Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Advantage of Generalized Coordinates over Newton Vectors Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Hamilton's Principle of Stationary Action: The actual physical path $q(t)$ taken by a dynamic system between fixed endpoints $(t_1, q_1)$ and $(t_2, q_2)$ is a stationary point ($\delta S = 0$) of the action functional:
   $$S[q] \equiv \int_{t_1}^{t_2} L(q_j, \dot{q}_j, t) \, dt$$
   where the **Lagrangian** is $L = T - V$ ($T$ is kinetic energy, $V$ is potential energy).
   - **Euler-Lagrange Equations of Motion ($n$ degrees of freedom):**
     $$\frac{d}{dt}\left(\frac{\partial L}{\partial \dot{q}_j}\right) - \frac{\partial L}{\partial q_j} = 0 \qquad (j = 1, \dots, n)$$
   - **Holonomic Constraints:** Generalized coordinates $q_1, \dots, q_n$ automatically embed constraints, eliminating constraint forces (normal forces, tension) from calculations!
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the Euler-Lagrange equations via calculus of variations: (1) consider perturbed path $q_j(t, \alpha) = q_j(t, 0) + \alpha \eta_j(t)$ with fixed boundary variations $\eta_j(t_1) = \eta_j(t_2) = 0$, (2) differentiate action with respect to parameter $\alpha$: $\frac{dS}{d\alpha} = \int_{t_1}^{t_2} \sum_j \left(\frac{\partial L}{\partial q_j} \frac{\partial q_j}{\partial \alpha} + \frac{\partial L}{\partial \dot{q}_j} \frac{\partial \dot{q}_j}{\partial \alpha}\right) dt$, (3) substitute variations $\frac{\partial q_j}{\partial \alpha} = \eta_j$ and $\frac{\partial \dot{q}_j}{\partial \alpha} = \dot{\eta}_j$, (4) integrate the velocity term by parts: $\int_{t_1}^{t_2} \frac{\partial L}{\partial \dot{q}_j} \dot{\eta}_j dt = \left[\frac{\partial L}{\partial \dot{q}_j} \eta_j\right]_{t_1}^{t_2} - \int_{t_1}^{t_2} \frac{d}{dt}\left(\frac{\partial L}{\partial \dot{q}_j}\right) \eta_j dt$, (5) boundary term vanishes ($\eta_j = 0$), leaving $\int_{t_1}^{t_2} \sum_j \left(\frac{\partial L}{\partial q_j} - \frac{d}{dt}\frac{\partial L}{\partial \dot{q}_j}\right) \eta_j dt = 0 \implies \frac{d}{dt}\frac{\partial L}{\partial \dot{q}_j} - \frac{\partial L}{\partial q_j} = 0$ by Fundamental Lemma of Calculus of Variations!
3. **Slide 3 (`matching`):** Pair 4 mechanical systems (Simple Pendulum (length $\ell$), 1D Harmonic Oscillator, 2D Free Particle in Polar, Bead on Rotating Wire $y = \omega x$) with their Lagrangian $L = T - V$.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the classical Lagrangian is defined as kinetic energy minus potential energy ($L = T - V$). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the primary computational advantage of Lagrangian mechanics over Newtonian vector mechanics: (Lagrangian mechanics uses scalar energies ($T$ and $V$) expressed in generalized coordinates, which automatically ELIMINATES unknown constraint forces (such as rod tensions and normal contact forces) without setting up complex vector free-body diagrams).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hamiltons_principle_and_euler_lagrange_equations",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Hamilton's Principle and the Euler-Lagrange Equations**\n• **Hamilton's Principle of Stationary Action (1833):**\n  The physical trajectory of a system between times $t_1$ and $t_2$ makes the action stationary ($\\delta S = 0$):\n$$\nS[q] = \\int_{t_1}^{t_2} L(q_j, \\dot{q}_j, t) \\, dt, \\qquad L \\equiv T - V\n$$\n• **The Euler-Lagrange Equations (Joseph-Louis Lagrange, 1788):**\n$$\n\\frac{d}{dt}\\left(\\frac{\\partial L}{\\partial \\dot{q}_j}\\right) - \\frac{\\partial L}{\\partial q_j} = 0 \\qquad (j = 1, \\dots, n)\n$$\n• **Generalized Coordinates $q_j$:** Minimal set of independent coordinates that automatically satisfy all holonomic geometric constraints, completely eliminating constraint forces!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the calculus of variations steps deriving the Euler-Lagrange equations from delta S = 0.",
      "orderItems": [
        "Parameterize family of virtual paths q_j(t, alpha) = q_j(t) + alpha * eta_j(t) with fixed endpoints eta_j(t_1) = eta_j(t_2) = 0",
        "Differentiate action integral with respect to variation parameter: dS/dalpha = int [ (dL/dq_j) * eta_j + (dL/dq_dot_j) * eta_dot_j ] dt",
        "Apply integration by parts to the velocity term: int (dL/dq_dot_j) * eta_dot_j dt = [(dL/dq_dot_j) * eta_j] - int d/dt(dL/dq_dot_j) * eta_j dt",
        "Eliminate the boundary term since variations vanish at endpoints: eta_j(t_1) = eta_j(t_2) = 0",
        "Apply the Fundamental Lemma of Calculus of Variations to obtain d/dt(dL/dq_dot_j) - dL/dq_j = 0 for arbitrary eta_j"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each physical system to its exact Lagrangian L = T - V.",
      "matchPairs": [
        { "left": "Simple Pendulum (angle theta)", "right": "L = (1/2) m l^2 theta_dot^2 + m g l cos(theta)" },
        { "left": "1D Harmonic Oscillator", "right": "L = (1/2) m x_dot^2 - (1/2) k x^2" },
        { "left": "Free Particle in Polar Coordinates", "right": "L = (1/2) m (r_dot^2 + r^2 theta_dot^2)" },
        { "left": "Bead on Vertical Rotating Hoop (radius R)", "right": "L = (1/2) m R^2 (theta_dot^2 + omega^2 sin^2(theta)) + m g R cos(theta)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In classical Lagrangian mechanics, the Lagrangian L is defined as kinetic energy T ___ potential energy V.",
      "blankAnswer": "minus",
      "blankDistractors": ["plus", "times", "divided"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the Lagrangian formulation significantly easier and more powerful than Newtonian vector mechanics for constrained systems like a double pendulum?",
      "options": [
        { "text": "Lagrangian mechanics uses SCALAR ENERGIES (T and V) in generalized coordinates, which automatically ELIMINATES unknown constraint forces (such as rod tensions) without needing free-body diagrams", "isCorrect": true, "explanation": "Correct! In Newtonian mechanics, constraint forces like tension must be explicitly calculated as vector unknowns. Generalized coordinates in Lagrangian mechanics naturally incorporate the constraints, reducing the problem to scalar calculus." },
        { "text": "Because it ignores gravity completely", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because it only applies to objects at rest", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because energy is not conserved in Newton's laws", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
