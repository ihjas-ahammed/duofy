# Duofy Reusable Lesson Format: Gaussian Beams and Optical Resonators

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Optics_and_Photonics / Lasers_Fiber_Optics_and_Nonlinear_Optics`  
**Lesson Format Type:** `gaussian_beams_and_optical_resonators`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the paraxial propagation and cavity dynamics of laser modes: formulate the **Fundamental $\text{TEM}_{00}$ Gaussian Beam**, define the **Beam Waist $w_0$**, derive the **Rayleigh Range ($z_R \equiv \frac{\pi w_0^2}{\lambda}$)**, compute beam radius $w(z) = w_0 \sqrt{1 + (z/z_R)^2}$, wave-front curvature $R(z) = z \left[1 + (z_R/z)^2\right]$, and far-field divergence angle $\theta = \frac{\lambda}{\pi w_0}$, evaluate the **Gouy Phase Shift $\zeta(z) = \arctan(z/z_R)$**, and apply the **$g$-Parameter Cavity Stability Criterion ($0 \le g_1 g_2 \le 1$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Gaussian Beam Profile & Resonator Stability Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Rayleigh Range & Far-Field Divergence Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Beam/Resonator Parameter & Physical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Rayleigh Range Spot Area Doubling Factor Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Optical Resonator g-Parameter Stability Criterion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Gaussian Beam Propagation Physics (Anthony E. Siegman, 1986):
   - **Paraxial Wave Equation Solution (TEM$_{00}$ Mode):**
     $$E(r, z) = E_0 \frac{w_0}{w(z)} \exp\left( -\frac{r^2}{w(z)^2} \right) \exp\left( -i\left[kz - \zeta(z) + \frac{k r^2}{2 R(z)}\right] \right)$$
   - **Key Parameters (Wavelength $\lambda$, Waist Radius $w_0$):**
     - **Rayleigh Range:** $z_R \equiv \frac{\pi w_0^2}{\lambda}$ (Distance where beam cross-sectional area doubles, $w(z_R) = \sqrt{2} w_0$).
     - **Beam Radius:** $w(z) = w_0 \sqrt{1 + \left(\frac{z}{z_R}\right)^2}$.
     - **Far-Field Divergence Half-Angle ($z \gg z_R$):** $\theta \approx \frac{w(z)}{z} = \frac{\lambda}{\pi w_0}$.
     - **Wavefront Curvature:** $R(z) = z \left[1 + \left(\frac{z_R}{z}\right)^2\right]$ (Flat at waist $R(0)=\infty$, planar at infinity).
     - **Gouy Phase Shift:** $\zeta(z) = \arctan(z/z_R)$ (Total shift of $\pi$ from $-\infty$ to $+\infty$).
   - **Laser Cavity Stability Condition (Mirror radii $R_1, R_2$, length $L$):**
     $$g_1 \equiv 1 - \frac{L}{R_1}, \qquad g_2 \equiv 1 - \frac{L}{R_2} \implies 0 \le g_1 g_2 \le 1$$
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the Rayleigh range and divergence angle: (1) start with paraxial Helmholtz wave equation: $\nabla_\perp^2 u - 2 i k \frac{\partial u}{\partial z} = 0$, (2) assume complex beam parameter ansatz: $\frac{1}{q(z)} = \frac{1}{R(z)} - i \frac{\lambda}{\pi w(z)^2}$, (3) integrate differential equation for $q(z)$ to obtain linear law: $q(z) = z + i z_R$, (4) equate real and imaginary parts of $\frac{1}{q(z)} = \frac{1}{z + i z_R} = \frac{z - i z_R}{z^2 + z_R^2}$, (5) identify $w(z) = w_0 \sqrt{1 + (z/z_R)^2}$ and evaluate asymptotic limit $z \to \infty$ to find divergence angle $\theta = \frac{\lambda}{\pi w_0}$!
3. **Slide 3 (`matching`):** Pair 4 laser beam / cavity parameters ($z_R$, $\theta$, $\zeta(z)$, $g_1 g_2$) with their mathematical formulas.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that at distance $z = z_R$ from the waist, the beam radius expands to $\sqrt{2} w_0$, so the beam cross-sectional area doubles (increases by a factor of 2). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on resonator stability: What happens to a symmetric confocal laser resonator ($R_1 = R_2 = L$) and why is it unconditionally stable? ($g_1 = 1 - L/L = 0, g_2 = 1 - L/L = 0 \implies g_1 g_2 = 0$; since $0 \le 0 \le 1$, the confocal resonator satisfies the stability condition, focusing rays back into the cavity without geometric walk-off losses).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "gaussian_beams_and_optical_resonators",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Gaussian Laser Beams and Cavity Stability**\n• **The TEM$_{00}$ Fundamental Gaussian Beam:**\n  - **Beam Radius / Spot Size:** $w(z) = w_0 \\sqrt{1 + (z / z_R)^2}$.\n  - **Rayleigh Range (Depth of Focus):** $z_R \\equiv \\frac{\\pi w_0^2}{\\lambda}$ (Distance where spot area doubles, $w(z_R) = \\sqrt{2} w_0$).\n  - **Far-Field Divergence Half-Angle:** $\\theta = \\frac{\\lambda}{\\pi w_0}$.\n  - **Radius of Curvature:** $R(z) = z \\left[ 1 + (z_R / z)^2 \\right]$.\n  - **Gouy Phase Shift:** $\\zeta(z) = \\arctan(z / z_R)$ (Total shift $\\Delta\\zeta = \\pi$).\n• **Two-Mirror Cavity Stability Criterion:**\n$$\ng_1 \\equiv 1 - \\frac{L}{R_1}, \\qquad g_2 \\equiv 1 - \\frac{L}{R_2} \\implies 0 \\le g_1 g_2 \\le 1\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the paraxial wave equation steps deriving the Gaussian beam width w(z) and divergence angle theta.",
      "orderItems": [
        "Formulate the paraxial Helmholtz equation: Laplacian_perp(u) - 2 i k * du/dz = 0",
        "Introduce the complex beam parameter q(z) defined by 1/q(z) = 1/R(z) - i * lambda / [pi * w(z)^2]",
        "Integrate the paraxial equation to discover the simple linear propagation law: q(z) = z + i * z_R",
        "Invert q(z) by algebraic conjugation: 1/q(z) = (z - i z_R) / (z^2 + z_R^2)",
        "Equate imaginary parts to solve for spot size w(z) = w_0 * sqrt(1 + [z/z_R]^2) and asymptotic divergence theta = lambda / (pi * w_0)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Gaussian beam / cavity property to its formula.",
      "matchPairs": [
        { "left": "Rayleigh Range z_R", "right": "z_R = pi * w_0^2 / lambda (depth of focus around waist)" },
        { "left": "Divergence Half-Angle theta", "right": "theta = lambda / (pi * w_0) (diffraction angular spread)" },
        { "left": "Gouy Phase Shift zeta(z)", "right": "zeta(z) = arctan(z / z_R) (extra phase advance of focused wave)" },
        { "left": "Resonator Stability Condition", "right": "0 <= (1 - L/R_1) * (1 - L/R_2) <= 1" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "At a distance of one Rayleigh range (z = z_R) from the laser beam waist, the cross-sectional area of the beam increases by a factor of ___.",
      "blankAnswer": "2",
      "blankDistractors": ["4", "1.414", "pi"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is a symmetric confocal optical resonator (where mirror radii of curvature equal cavity length, R_1 = R_2 = L) stable?",
      "options": [
        { "text": "Its g-parameters evaluate to g_1 = 1 - L/L = 0 and g_2 = 1 - L/L = 0, giving g_1 * g_2 = 0, which STRICTLY SATISFIES the stability criterion 0 <= g_1 * g_2 <= 1, preventing ray escape", "isCorrect": true, "explanation": "Correct! For a confocal cavity, g1 = g2 = 0, so g1*g2 = 0. This sits well within the stable bounds [0, 1]. In this configuration, the focal points of both mirrors coincide at the cavity center, refocusing reflected rays into closed periodic trajectories." },
        { "text": "Because light cannot reflect off curved mirrors", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because its length is zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because it has g_1 * g_2 > 1", "isCorrect": false, "explanation": "Incorrect: That would be unstable." }
      ]
    }
  ]
}
```
