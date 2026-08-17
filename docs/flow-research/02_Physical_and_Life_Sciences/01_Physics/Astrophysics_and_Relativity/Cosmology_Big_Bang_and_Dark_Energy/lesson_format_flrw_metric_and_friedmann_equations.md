# Duofy Reusable Lesson Format: FLRW Metric and the Friedmann Equations

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Astrophysics_and_Relativity / Cosmology_Big_Bang_and_Dark_Energy`  
**Lesson Format Type:** `flrw_metric_and_friedmann_equations`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the geometric and dynamical foundation of relativistic cosmology: formulate the **Cosmological Principle** (homogeneity and isotropy), define the **FLRW Metric** with scale factor $a(t)$ and spatial curvature $k \in \{-1, 0, +1\}$, derive the **First and Second Friedmann Equations** from Einstein's Field Equations $G_{\mu\nu} = \frac{8\pi G}{c^4} T_{\mu\nu}$, define the **Critical Density $\rho_c$**, and solve single-component cosmological models.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | FLRW Metric & Friedmann Equations Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Fluid Continuity Equation Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Cosmological Component & Scale-Factor Scaling Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Spatial Curvature Zero Geometry Word Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Cosmological Redshift and Scale Factor Relation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Cosmological Principle: On large scales ($\ge 100\text{ Mpc}$), the universe is **homogeneous** and **isotropic**. The unique spacetime metric satisfying this is the **FLRW Metric (Friedmann-Lemaître-Robertson-Walker)**:
   $$ds^2 = -c^2 dt^2 + a(t)^2 \left[ \frac{dr^2}{1 - kr^2} + r^2 (d\theta^2 + \sin^2\theta \, d\phi^2) \right]$$
   where $k = +1$ (Closed/Spherical), $k = 0$ (Flat/Euclidean), $k = -1$ (Open/Hyperbolic). State the Friedmann Equations:
   - **First Friedmann Equation (Expansion Rate):** $H^2 \equiv \left(\frac{\dot{a}}{a}\right)^2 = \frac{8\pi G}{3}\rho - \frac{kc^2}{a^2} + \frac{\Lambda c^2}{3}$.
   - **Second Friedmann / Acceleration Equation:** $\frac{\ddot{a}}{a} = -\frac{4\pi G}{3}\left(\rho + \frac{3p}{c^2}\right) + \frac{\Lambda c^2}{3}$.
   - **Critical Density:** $\rho_c = \frac{3H_0^2}{8\pi G}$.
2. **Slide 2 (`ordering`):** Provide 5 steps proving the fluid conservation equation $\dot{\rho} + 3 H (\rho + p/c^2) = 0$ from the first law of thermodynamics $dE = -p dV$: (1) consider a comoving volume of the expanding universe $V(t) \propto a(t)^3$, (2) express the total internal mass-energy within volume $V$ as $E = \rho c^2 V \propto \rho c^2 a^3$, (3) differentiate internal energy with respect to cosmic time: $\frac{dE}{dt} = c^2 (\dot{\rho} a^3 + 3 \rho a^2 \dot{a})$, (4) equate to rate of work done by cosmic pressure: $\frac{dE}{dt} = -p \frac{dV}{dt} = -p (3 a^2 \dot{a})$, (5) divide throughout by $c^2 a^3$ and factor $H = \dot{a}/a$ to obtain $\dot{\rho} + 3\frac{\dot{a}}{a}\left(\rho + \frac{p}{c^2}\right) = 0$!
3. **Slide 3 (`matching`):** Pair 4 cosmic components (Non-Relativistic Matter $p=0$, Relativistic Radiation $p=\rho c^2/3$, Cosmological Constant / Dark Energy $p=-\rho c^2$, Spatial Curvature $k$) with their scale-factor energy density dependencies ($\rho_m \propto a^{-3}$, $\rho_r \propto a^{-4}$, $\rho_\Lambda = \text{const} \propto a^0$, $\rho_k \propto a^{-2}$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that when spatial curvature parameter $k = 0$, the spatial geometry of the universe is Euclidean or flat. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the exact relation between cosmological redshift $z$, emitted wavelength $\lambda_{\text{emit}}$, observed wavelength $\lambda_{\text{obs}}$, and the scale factor $a(t)$: (Redshift is caused by the expansion of space stretching photons: $1 + z = \frac{\lambda_{\text{obs}}}{\lambda_{\text{emit}}} = \frac{a(t_0)}{a(t_{\text{emit}})}$; a galaxy at $z = 1$ emitted light when the universe was exactly half its current size, $a = 0.5 a_0$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "flrw_metric_and_friedmann_equations",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The FLRW Metric and Friedmann Equations**\n• **The FLRW Metric (Cosmological Principle):** Spacetime for a homogeneous, isotropic expanding universe:\n$$\nds^2 = -c^2 dt^2 + a(t)^2 \\left[ \\frac{dr^2}{1 - kr^2} + r^2 (d\\theta^2 + \\sin^2\\theta \\, d\\phi^2) \\right]\n$$\n  - $a(t)$: Dimensionless **Scale Factor** ($a_0 = 1$ today).\n  - $k \\in \\{+1, 0, -1\\}$: Spatial curvature (Closed, Flat, Open).\n• **The First Friedmann Equation (Hubble Expansion):**\n$$\nH^2 \\equiv \\left(\\frac{\\dot{a}}{a}\\right)^2 = \\frac{8\\pi G}{3}\\rho - \\frac{kc^2}{a^2} + \\frac{\\Lambda c^2}{3}\n$$\n• **The Second Friedmann Equation (Cosmic Acceleration):**\n$$\n\\frac{\\ddot{a}}{a} = -\\frac{4\\pi G}{3}\\left(\\rho + \\frac{3p}{c^2}\\right) + \\frac{\\Lambda c^2}{3}\n$$\n• **Critical Density:** $\\rho_c = \\frac{3H^2}{8\\pi G}$ (Density required for flat $k = 0$ geometry)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical derivation steps establishing the cosmological fluid continuity equation from dE = -p dV.",
      "orderItems": [
        "Express the expanding comoving volume as V(t) proportional to a(t)^3",
        "Write total relativistic energy in volume V as E = rho * c^2 * a(t)^3",
        "Differentiate energy with respect to cosmic time t: dE/dt = c^2 * [d(rho)/dt * a^3 + 3 * rho * a^2 * da/dt]",
        "Equate energy change to mechanical work: dE/dt = -p * dV/dt = -3 * p * a^2 * da/dt",
        "Divide across by c^2 * a^3 to obtain the continuity equation: d(rho)/dt + 3 * (da/dt / a) * (rho + p/c^2) = 0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each cosmological component to its energy density scale factor evolution.",
      "matchPairs": [
        { "left": "Non-Relativistic Matter (p = 0)", "right": "rho_m proportional to a^{-3} (dilutes strictly with 3D volume)" },
        { "left": "Radiation & Photons (p = rho c^2 / 3)", "right": "rho_r proportional to a^{-4} (volume dilution a^{-3} plus wavelength stretching a^{-1})" },
        { "left": "Dark Energy / Cosmological Constant", "right": "rho_Lambda = constant proportional to a^0 (vacuum energy density never dilutes!)" },
        { "left": "Spatial Curvature Term", "right": "rho_k proportional to a^{-2} (geometric scaling)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "When the spatial curvature index k equals 0 in the FLRW metric, the geometry of 3D cosmic space is Euclidean or ___.",
      "blankAnswer": "flat",
      "blankDistractors": ["spherical", "hyperbolic", "closed"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the exact physical meaning of observing a distant quasar at cosmological redshift z = 3.0?",
      "options": [
        { "text": "The light was emitted when the universe was 1/(1+z) = 1/4 of its current size (scale factor a = 0.25 a_0), and cosmic expansion stretched the photon wavelengths by a factor of 4 during transit", "isCorrect": true, "explanation": "Correct! Cosmological redshift is defined by 1 + z = lambda_obs / lambda_emit = a(t_today) / a(t_emit). A redshift of z = 3 means the scale factor was exactly a = a_0 / 4 when emitted." },
        { "text": "The quasar is moving through stationary space at 3 times the speed of light", "isCorrect": false, "explanation": "Incorrect: Redshift is caused by expansion of space, not kinematic Doppler velocity." },
        { "text": "The quasar is 3 light years away", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The photons lost energy by colliding with dust", "isCorrect": false, "explanation": "Incorrect: Tired light hypothesis is disproven." }
      ]
    }
  ]
}
```
