# Duofy Reusable Lesson Format: Legendre Transform and Hamilton's Equations

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Classical_Mechanics / Lagrangian_and_Hamiltonian_Formulations`  
**Lesson Format Type:** `legendre_transform_and_hamiltons_equations`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the transition to **Hamiltonian Mechanics (William Rowan Hamilton, 1833)**: execute the **Legendre Transformation** from configuration space $(q, \dot{q})$ to phase space $(q, p)$, define the **Hamiltonian $H(q, p, t) = \sum p_j \dot{q}_j - L$**, derive **Hamilton's Canonical Equations of Motion** ($\dot{q}_j = \frac{\partial H}{\partial p_j}, \dot{p}_j = -\frac{\partial H}{\partial q_j}$), and analyze phase space trajectories.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Legendre Transform & Hamilton's Equations Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Hamilton's Canonical Equations Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Physical Observable & Hamiltonian Operator/Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Phase Space Canonical Momentum Derivative Negative Sign Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Liouville's Theorem Phase Space Volume Incompressibility Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Legendre Transformation from Lagrangian $L(q, \dot{q}, t)$ to Hamiltonian $H(q, p, t)$:
   - **Conjugate Momentum:** $p_j \equiv \frac{\partial L}{\partial \dot{q}_j}$.
   - **The Hamiltonian Function:**
     $$H(q_1, \dots, q_n, p_1, \dots, p_n, t) \equiv \sum_{j=1}^n p_j \dot{q}_j - L(q_j, \dot{q}_j, t)$$
   - **Hamilton's Canonical Equations of Motion ($2n$ First-Order ODEs):**
     $$\dot{q}_j = +\frac{\partial H}{\partial p_j}, \qquad \dot{p}_j = -\frac{\partial H}{\partial q_j}, \qquad \frac{\partial H}{\partial t} = -\frac{\partial L}{\partial t}$$
   - For standard natural systems with time-independent coordinate transformations, $H = T + V = E_{\text{total}}$.
2. **Slide 2 (`ordering`):** Provide 5 steps deriving Hamilton's equations by taking total differential $dH$: (1) write differential of definition $H = \sum p_j \dot{q}_j - L$: $dH = \sum (p_j d\dot{q}_j + \dot{q}_j dp_j) - dL$, (2) expand differential of Lagrangian $dL = \sum \left(\frac{\partial L}{\partial q_j} dq_j + \frac{\partial L}{\partial \dot{q}_j} d\dot{q}_j\right) + \frac{\partial L}{\partial t} dt$, (3) substitute $p_j = \frac{\partial L}{\partial \dot{q}_j}$ to cancel the $p_j d\dot{q}_j$ terms: $dH = \sum \left(\dot{q}_j dp_j - \frac{\partial L}{\partial q_j} dq_j\right) - \frac{\partial L}{\partial t} dt$, (4) compare with multivariable differential of $H(q, p, t)$: $dH = \sum \left(\frac{\partial H}{\partial q_j} dq_j + \frac{\partial H}{\partial p_j} dp_j\right) + \frac{\partial H}{\partial t} dt$, (5) equate matching coefficients and apply Euler-Lagrange $\dot{p}_j = \frac{\partial L}{\partial q_j}$ to find $\dot{q}_j = \frac{\partial H}{\partial p_j}$ and $\dot{p}_j = -\frac{\partial H}{\partial q_j}$!
3. **Slide 3 (`matching`):** Pair 4 systems (1D Harmonic Oscillator, Free Particle $m$, Relativistic Free Particle, Planar Central Force) with their Hamiltonian $H(q, p)$.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the equation for momentum rate $\dot{p}_j = -\frac{\partial H}{\partial q_j}$ contains a critical negative sign. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Liouville's Theorem in phase space: What does Liouville's Theorem state about an ensemble of systems flowing through $2n$-dimensional phase space $(q, p)$? (The phase space density $\rho(q, p, t)$ along any system's trajectory is constant in time ($\frac{d\rho}{dt} = 0$), meaning phase space volume is strictly INCOMPRESSIBLE under Hamiltonian time evolution: $\nabla \cdot \mathbf{v}_{\text{phase}} = \sum (\frac{\partial \dot{q}_i}{\partial q_i} + \frac{\partial \dot{p}_i}{\partial p_i}) = \sum (\frac{\partial^2 H}{\partial q_i \partial p_i} - \frac{\partial^2 H}{\partial p_i \partial q_i}) = 0$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "legendre_transform_and_hamiltons_equations",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Legendre Transform and Hamilton's Equations**\n• **Legendre Transformation from $(q, \\dot{q})$ to $(q, p)$:**\n$$\np_j \\equiv \\frac{\\partial L}{\\partial \\dot{q}_j}, \\qquad H(q, p, t) \\equiv \\sum_{j=1}^n p_j \\dot{q}_j - L(q, \\dot{q}, t)\n$$\n• **Hamilton's Canonical Equations of Motion ($2n$ 1st-order ODEs):**\n$$\n\\dot{q}_j = +\\frac{\\partial H}{\\partial p_j}, \\qquad \\dot{p}_j = -\\frac{\\partial H}{\\partial q_j}, \\qquad \\frac{\\partial H}{\\partial t} = -\\frac{\\partial L}{\\partial t}\n$$\n• **Physical Meaning:** For scleronomic (time-independent) systems, the Hamiltonian equals the **total mechanical energy** $H = T + V = E$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the differential steps deriving Hamilton's equations from the total differential dH.",
      "orderItems": [
        "Take total differential of H definition: dH = sum (p_j d(q_dot_j) + q_dot_j dp_j) - dL",
        "Expand the differential of Lagrangian: dL = sum ( (dL/dq_j) dq_j + (dL/dq_dot_j) d(q_dot_j) ) + (dL/dt) dt",
        "Substitute definition of canonical momentum p_j = dL/dq_dot_j to cancel all d(q_dot_j) terms",
        "Compare with total multivariable differential of H(q, p, t): dH = sum ( (dH/dq_j) dq_j + (dH/dp_j) dp_j ) + (dH/dt) dt",
        "Equate corresponding differential coefficients and apply Euler-Lagrange p_dot_j = dL/dq_j to yield q_dot_j = dH/dp_j and p_dot_j = -dH/dq_j"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each physical system to its Hamiltonian function H(q, p).",
      "matchPairs": [
        { "left": "1D Harmonic Oscillator", "right": "H = p^2 / (2m) + (1/2) k q^2" },
        { "left": "Free Particle (mass m)", "right": "H = (p_x^2 + p_y^2 + p_z^2) / (2m)" },
        { "left": "Relativistic Free Particle", "right": "H = sqrt(p^2 c^2 + m_0^2 c^4)" },
        { "left": "Planar Central Force (polar r, theta)", "right": "H = p_r^2 / (2m) + p_theta^2 / (2m r^2) + V(r)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Hamilton's canonical equations, the rate of change of momentum p_dot_j equals ___ dH/dq_j.",
      "blankAnswer": "-1",
      "blankDistractors": ["+1", "0", "+2"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the key statement and mathematical proof of Liouville's Theorem in Hamiltonian Phase Space?",
      "options": [
        { "text": "Phase space volume is INCOMPRESSIBLE along system trajectories (d rho / dt = 0) because the phase space velocity divergence div(v) = sum [ d/dq_j(dH/dp_j) + d/dp_j(-dH/dq_j) ] vanishes identically by equality of mixed partial derivatives", "isCorrect": true, "explanation": "Correct! Because d(q_dot_j)/dq_j + d(p_dot_j)/dp_j = d^2H/(dq_j dp_j) - d^2H/(dp_j dq_j) = 0, the velocity field in 2n-dimensional phase space is divergence-free, meaning phase space volume is strictly conserved (Liouville's theorem)." },
        { "text": "Phase space volume always collapses to zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Energy is not conserved in phase space", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Momentum can never change", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
