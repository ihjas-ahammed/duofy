# Duofy Reusable Lesson Format: Poynting Vector and Radiation Pressure

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Electromagnetism_and_Electrodynamics / Maxwell_Equations_and_Electromagnetic_Waves`  
**Lesson Format Type:** `poynting_vector_and_radiation_pressure`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through electromagnetic energy and momentum conservation: derive **Poynting's Theorem ($\frac{\partial u_{\text{EM}}}{\partial t} + \nabla \cdot \mathbf{S} = -\mathbf{J}\cdot\mathbf{E}$)** from Maxwell's equations, formulate the **Poynting Vector $\mathbf{S} \equiv \frac{1}{\mu_0}(\mathbf{E}\times\mathbf{B})$** representing energy flux density [$\text{W/m}^2$], compute time-averaged **Wave Intensity $I = \langle S \rangle = \frac{1}{2} c \epsilon_0 E_0^2$**, derive electromagnetic **Momentum Density $\mathbf{g} = \mu_0\epsilon_0\mathbf{S} = \frac{\mathbf{S}}{c^2}$**, and calculate **Radiation Pressure** for absorbing ($P = I/c$) vs reflecting ($P = 2I/c$) surfaces.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Poynting Vector & Energy Conservation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Poynting's Theorem Energy Flow Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Radiative Energy/Momentum Quantity & Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Perfect Reflector Radiation Pressure Doubling Factor Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Solar Sail Radiation Pressure Calculation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Poynting's Theorem (John Henry Poynting, 1884):
   - **EM Energy Density:** $u_{\text{EM}} = \frac{1}{2}\left(\epsilon_0 E^2 + \frac{1}{\mu_0} B^2\right)$.
   - **The Poynting Vector:** $\mathbf{S} \equiv \frac{1}{\mu_0} (\mathbf{E} \times \mathbf{B})$ (Power per unit area in $\text{Watts/m}^2$).
   - **Poynting's Continuity Equation:**
     $$\frac{\partial u_{\text{EM}}}{\partial t} + \nabla \cdot \mathbf{S} = -\mathbf{J} \cdot \mathbf{E}$$
     where $-\mathbf{J}\cdot\mathbf{E}$ represents the rate of work done by the field on charges.
   - **Time-Averaged Intensity:** $I \equiv \langle S \rangle = \frac{1}{2} c \epsilon_0 E_0^2 = \frac{E_0^2}{2 \mu_0 c}$.
   - **EM Momentum Density:** $\mathbf{g} = \mu_0 \epsilon_0 \mathbf{S} = \frac{\mathbf{S}}{c^2}$.
   - **Radiation Pressure:**
     $$P_{\text{rad}} = \frac{I}{c} \quad (\text{Perfect Absorber}), \qquad P_{\text{rad}} = \frac{2I}{c} \quad (\text{Perfect Reflector})$$
2. **Slide 2 (`ordering`):** Provide 5 steps deriving Poynting's Theorem: (1) express rate of work done on charges per unit volume: $\frac{dW}{dt} = \mathbf{J} \cdot \mathbf{E}$, (2) substitute Ampère-Maxwell law $\mathbf{J} = \frac{1}{\mu_0}\nabla\times\mathbf{B} - \epsilon_0 \frac{\partial\mathbf{E}}{\partial t}$: $\mathbf{E} \cdot \mathbf{J} = \frac{1}{\mu_0}\mathbf{E} \cdot (\nabla \times \mathbf{B}) - \epsilon_0 \mathbf{E} \cdot \frac{\partial\mathbf{E}}{\partial t}$, (3) apply vector identity $\nabla \cdot (\mathbf{E} \times \mathbf{B}) = \mathbf{B} \cdot (\nabla \times \mathbf{E}) - \mathbf{E} \cdot (\nabla \times \mathbf{B})$, (4) substitute Faraday's law $\nabla \times \mathbf{E} = -\frac{\partial\mathbf{B}}{\partial t}$ into identity: $\mathbf{E} \cdot (\nabla \times \mathbf{B}) = -\mathbf{B} \cdot \frac{\partial\mathbf{B}}{\partial t} - \nabla \cdot (\mathbf{E} \times \mathbf{B})$, (5) group terms and recognize $u_{\text{EM}}$ to obtain $\frac{\partial}{\partial t}\left[\frac{1}{2}\epsilon_0 E^2 + \frac{B^2}{2\mu_0}\right] + \nabla \cdot \left(\frac{1}{\mu_0}\mathbf{E}\times\mathbf{B}\right) = -\mathbf{J}\cdot\mathbf{E}$!
3. **Slide 3 (`matching`):** Pair 4 radiative quantities ($\mathbf{S}$, $u_{\text{EM}}$, $\mathbf{g}$, $P_{\text{rad}}$) with their physical units and formulas.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that for a perfectly reflecting surface, radiation pressure is double the pressure of a perfect absorber ($P = 2I/c$). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating solar radiation pressure: The solar constant at Earth orbit is $I = 1360\text{ W/m}^2$. What is the radiation pressure exerted on a reflective solar sail? ($P_{\text{rad}} = \frac{2I}{c} = \frac{2(1360)}{3.0 \times 10^8} \approx 9.07 \times 10^{-6}\text{ N/m}^2 = 9.07\ \mu\text{Pa}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "poynting_vector_and_radiation_pressure",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Poynting Vector and Radiation Pressure**\n• **The Poynting Vector $\\mathbf{S}$ (Energy Flux Density):**\n$$\n\\mathbf{S} \\equiv \\frac{1}{\\mu_0} (\\mathbf{E} \\times \\mathbf{B}) \\qquad [\\text{Watts/m}^2]\n$$\n• **Poynting's Theorem (Conservation of EM Energy):**\n$$\n\\frac{\\partial u_{\\text{EM}}}{\\partial t} + \\nabla \\cdot \\mathbf{S} = -\\mathbf{J} \\cdot \\mathbf{E}, \\qquad u_{\\text{EM}} = \\frac{1}{2}\\left(\\epsilon_0 E^2 + \\frac{B^2}{\\mu_0}\\right)\n$$\n• **Wave Intensity:** $I = \\langle S \\rangle = \\frac{1}{2} c \\epsilon_0 E_0^2 = \\frac{E_0^2}{2\\mu_0 c}$.\n• **Radiation Pressure:**\n  - **Total Absorption:** $P_{\\text{rad}} = \\frac{I}{c}$.\n  - **Total Reflection:** $P_{\\text{rad}} = \\frac{2I}{c}$ (momentum reversal doubles pressure!)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the vector calculus steps proving Poynting's Theorem from Maxwell's Equations.",
      "orderItems": [
        "Write work rate on charges: dW/dt = int (J . E) dV",
        "Substitute Ampère-Maxwell Law for current density: J = (1/mu_0) curl(B) - eps_0 dE/dt",
        "Take dot product with electric field: E . J = (1/mu_0) E . curl(B) - eps_0 E . (dE/dt)",
        "Apply vector identity: div(E x B) = B . curl(E) - E . curl(B) and substitute Faraday's Law curl(E) = -dB/dt",
        "Reorganize derivatives into total time rate of energy density: d/dt [ (1/2) eps_0 E^2 + (1/2 mu_0) B^2 ] + div[ (1/mu_0) (E x B) ] = -J . E"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each electromagnetic energy/momentum property to its formula.",
      "matchPairs": [
        { "left": "Poynting Energy Flux Vector S", "right": "S = (1 / mu_0) * (E x B) [W/m^2]" },
        { "left": "Electromagnetic Momentum Density g", "right": "g = mu_0 * eps_0 * S = S / c^2 [kg / (m^2 s)]" },
        { "left": "Time-Averaged Wave Intensity I", "right": "I = (1/2) * c * eps_0 * E_0^2" },
        { "left": "Radiation Pressure on Mirror", "right": "P = 2 * I / c [Pascals = N/m^2]" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "For a perfectly reflecting mirror, the radiation pressure P = 2*I/c is ___ the pressure on a perfectly absorbing black surface.",
      "blankAnswer": "double",
      "blankDistractors": ["half", "equal", "triple"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A reflective space solar sail is illuminated by sunlight with intensity I = 1360 W/m². What is the radiation pressure exerted on the sail?",
      "options": [
        { "text": "P = 2 * I / c = 2 * 1360 / (3.0 × 10^8) ≈ 9.07 × 10^-6 N/m² (9.07 microPascals)", "isCorrect": true, "explanation": "Correct! Because the sail is reflective, photons bounce back with momentum transfer Delta p = 2 p, doubling the radiation pressure: P = 2I / c = 2720 / 3e8 = 9.07 x 10^-6 Pa." },
        { "text": "P = I / c ≈ 4.53 × 10^-6 N/m²", "isCorrect": false, "explanation": "Incorrect: That is for a pure absorber, but a sail is reflective." },
        { "text": "P = 1360 N/m²", "isCorrect": false, "explanation": "Incorrect: Radiation pressure is divided by c." },
        { "text": "P = 0 N/m²", "isCorrect": false, "explanation": "Incorrect: Photons carry non-zero momentum." }
      ]
    }
  ]
}
```
