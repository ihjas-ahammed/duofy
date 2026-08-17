# Duofy Reusable Lesson Format: Two-Body Reduction and Effective Potential

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Classical_Mechanics / Central_Force_Motion_and_Planetary_Orbits`  
**Lesson Format Type:** `two_body_reduction_and_effective_potential`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the reduction of the 6-degree-of-freedom **Two-Body Problem** to an equivalent 1-body particle with **Reduced Mass $\mu = \frac{m_1 m_2}{m_1 + m_2}$**, prove that central forces conserve angular momentum $\mathbf{L} = \mathbf{r} \times \mathbf{p}$ (confining motion to a 2D plane), formulate the **Effective Potential $V_{\text{eff}}(r) = V(r) + \frac{L^2}{2\mu r^2}$**, and determine radial turning points.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Reduced Mass & Effective Potential Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Radial Energy Equation Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Orbit Energy Level & Orbit Topology Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Centrifugal Barrier Potential Denominator Power Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Circular Orbit Stability from Second Derivative Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Two-Body Problem Reduction: The Lagrangian of two interacting bodies $m_1, m_2$ under central potential $V(|\mathbf{r}_1 - \mathbf{r}_2|)$ separates into Center of Mass motion $\mathbf{R} = \frac{m_1 \mathbf{r}_1 + m_2 \mathbf{r}_2}{m_1 + m_2}$ (free particle) and relative motion $\mathbf{r} = \mathbf{r}_1 - \mathbf{r}_2$ with **Reduced Mass**:
   $$\mu = \frac{m_1 m_2}{m_1 + m_2}$$
   State Conservation of Angular Momentum: $\boldsymbol{\tau} = \mathbf{r} \times \mathbf{F}(r) = \mathbf{0} \implies \mathbf{L} = \mu r^2 \dot{\theta} \hat{\mathbf{z}} = \text{const}$. State the 1D Radial Energy Equation:
   $$E = \frac{1}{2}\mu \dot{r}^2 + V_{\text{eff}}(r), \qquad V_{\text{eff}}(r) = V(r) + \frac{L^2}{2\mu r^2}$$
   where $\frac{L^2}{2\mu r^2}$ is the repulsive **Centrifugal Potential Barrier**.
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the radial equation of motion: (1) write total mechanical energy in polar coordinates: $E = \frac{1}{2}\mu(\dot{r}^2 + r^2 \dot{\theta}^2) + V(r)$, (2) express angular velocity in terms of conserved angular momentum: $\dot{\theta} = \frac{L}{\mu r^2}$, (3) substitute $\dot{\theta}$ into kinetic energy: $\frac{1}{2}\mu r^2 \left(\frac{L}{\mu r^2}\right)^2 = \frac{L^2}{2\mu r^2}$, (4) group effective potential terms: $E = \frac{1}{2}\mu \dot{r}^2 + \left(V(r) + \frac{L^2}{2\mu r^2}\right) = \frac{1}{2}\mu \dot{r}^2 + V_{\text{eff}}(r)$, (5) differentiate with respect to time to get radial equation $\mu \ddot{r} = -\frac{dV_{\text{eff}}}{dr} = -\frac{dV}{dr} + \frac{L^2}{\mu r^3}$.
3. **Slide 3 (`matching`):** Pair 4 energy levels in gravitational potential $V(r) = -k/r$ ($E < V_{\text{eff, min}}$, $E = V_{\text{eff, min}}$, $V_{\text{eff, min}} < E < 0$, $E \ge 0$) with their physical orbital types (Physically Forbidden, Stable Circular Orbit, Bound Elliptical Orbit between periapsis and apoapsis, Unbound Escape / Hyperbolic Orbit).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the centrifugal potential barrier scales as $L^2 / (2\mu r^2)$ where distance $r$ is squared in the denominator. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on circular orbit stability: What mathematical condition on the effective potential $V_{\text{eff}}(r)$ determines whether a circular orbit at radius $r_0$ is STABLE against small radial perturbations? ($V_{\text{eff}}'(r_0) = 0$ (equilibrium) and $V_{\text{eff}}''(r_0) > 0$ (local minimum / positive curvature)).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "two_body_reduction_and_effective_potential",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Two-Body Reduction and Effective Potential**\n• **Two-Body Problem Reduction:** Two particles $m_1, m_2$ reduce to an equivalent single particle of **Reduced Mass** $\\mu$ in relative coordinates $\\mathbf{r} = \\mathbf{r}_1 - \\mathbf{r}_2$:\n$$\n\\mu = \\frac{m_1 m_2}{m_1 + m_2}\n$$\n• **Angular Momentum Conservation:** $\\boldsymbol{\\tau} = \\mathbf{r} \\times \\mathbf{F}(r) = \\mathbf{0} \\implies \\mathbf{L} = \\mu r^2 \\dot{\\theta} = \\text{const}$.\n• **1D Radial Energy Equation:**\n$$\nE = \\frac{1}{2}\\mu \\dot{r}^2 + V_{\\text{eff}}(r)\n$$\n• **The Effective Potential $V_{\\text{eff}}(r)$:**\n$$\nV_{\\text{eff}}(r) = V(r) + \\frac{L^2}{2\\mu r^2}\n$$\n  *(The $+L^2 / (2\\mu r^2)$ term acts as a repulsive **Centrifugal Barrier**!).*"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the algebraic derivation steps establishing the 1D effective potential energy equation.",
      "orderItems": [
        "Write total mechanical energy in polar coordinates: E = (1/2) mu (r_dot^2 + r^2 theta_dot^2) + V(r)",
        "Express angular velocity in terms of conserved angular momentum: theta_dot = L / (mu * r^2)",
        "Substitute theta_dot into tangential kinetic energy: (1/2) mu r^2 * (L / (mu r^2))^2 = L^2 / (2 mu r^2)",
        "Group the angular kinetic term with the potential: E = (1/2) mu r_dot^2 + [V(r) + L^2 / (2 mu r^2)]",
        "Define V_eff(r) = V(r) + L^2 / (2 mu r^2) and differentiate with respect to time to obtain mu * r_ddot = -dV_eff/dr"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each energy condition in gravitational potential V(r) = -k/r to its orbital motion.",
      "matchPairs": [
        { "left": "E = V_{eff, min} < 0", "right": "Stable Circular Orbit (r = r_0 is fixed, r_dot = 0)" },
        { "left": "V_{eff, min} < E < 0", "right": "Bound Elliptical Orbit oscillating between periapsis r_min and apoapsis r_max" },
        { "left": "E = 0", "right": "Parabolic Escape Orbit (unbound, velocity approaches 0 at infinity)" },
        { "left": "E > 0", "right": "Hyperbolic Flyby Orbit (unbound, non-zero excess velocity at infinity)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The repulsive centrifugal potential term L^2 / (2 mu r^2) scales inversely with the ___ of radial distance r.",
      "blankAnswer": "square",
      "blankDistractors": ["cube", "root", "linear"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "For an arbitrary central potential V(r), what condition guarantees that a circular orbit at radius r_0 is STABLE against small radial oscillations?",
      "options": [
        { "text": "The effective potential must have a LOCAL MINIMUM at r_0: dV_eff/dr(r_0) = 0 and d^2V_eff/dr^2(r_0) > 0", "isCorrect": true, "explanation": "Correct! A stable orbit requires an equilibrium point (first derivative zero) situated in a potential energy well with positive curvature (second derivative strictly positive)." },
        { "text": "dV_eff/dr(r_0) < 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The angular momentum must be zero", "isCorrect": false, "explanation": "Incorrect: L = 0 yields head-on radial collision." },
        { "text": "The energy must be positive", "isCorrect": false, "explanation": "Incorrect: Positive energy yields unbound motion." }
      ]
    }
  ]
}
```
