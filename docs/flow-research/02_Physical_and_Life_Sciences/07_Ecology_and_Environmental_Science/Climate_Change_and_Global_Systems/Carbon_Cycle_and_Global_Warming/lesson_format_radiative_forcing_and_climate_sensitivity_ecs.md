# Duofy Reusable Lesson Format: Radiative Forcing and Equilibrium Climate Sensitivity (ECS)

**Target Topic:** `02_Physical_and_Life_Sciences / 07_Ecology_and_Environmental_Science / Climate_Change_and_Global_Systems / Carbon_Cycle_and_Global_Warming`  
**Lesson Format Type:** `radiative_forcing_and_climate_sensitivity_ecs`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the radiative transfer physics, spectral absorption band saturation, and planetary energy balance equations of greenhouse warming (Svante Arrhenius 1896; Guy Stewart Callendar 1938; Syukuro Manabe & Richard T. Wetherald 1967): formulate the **Logarithmic Radiative Forcing Equation for $\text{CO}_2$ ($\Delta F = 5.35 \ln(C / C_0)\text{ W/m}^2$)**, calculate the radiative forcing for a doubling of carbon dioxide ($\Delta F_{2\times\text{CO}_2} = 5.35 \ln 2 \approx 3.71\text{ W/m}^2$), derive the **No-Feedback Planck Climate Response ($\Delta T_0 = \Delta F / \lambda_0 \approx 1.2^\circ\text{C}$)**, formulate **Equilibrium Climate Sensitivity ($\text{ECS} = \frac{\Delta F_{2\times\text{CO}_2}}{\lambda_{\text{net}}} \approx 2.5-4.0^\circ\text{C}$)** accounting for climate feedback amplification, and contrast with the **Transient Climate Response (TCR)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Radiative Forcing Physics & ECS Equilibrium Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Spectral CO2 Infrared Absorption to Thermal Equilibrium Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Climate Sensitivity Metric & Thermodynamic Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Radiative Forcing of Doubled CO2 in Watts per Square Meter Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Physical Reason for the Logarithmic Scaling of CO2 Forcing Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Radiative Forcing & Equilibrium Climate Sensitivity (Manabe 1967; IPCC AR6):
   - **Logarithmic Radiative Forcing of $\text{CO}_2$:**
     $$\mathbf{\Delta F = 5.35 \ln\left(\frac{C}{C_0}\right) \text{ W/m}^2}$$
     - For $2 \times \text{CO}_2$ ($C/C_0 = 2$, e.g. $280 \to 560\text{ ppm}$):
       $$\mathbf{\Delta F_{2\times\text{CO}_2} = 5.35 \ln(2) \approx 3.71\text{ W/m}^2}$$
   - **The Planetary Climate Sensitivity Equation:**
     $$\mathbf{\Delta T_{\text{eq}} = \frac{\Delta F}{\lambda_{\text{net}}} = \frac{\Delta F}{-\lambda_0 - \sum \lambda_i}}$$
     - **Bare Planck Response (No Feedbacks):** $\lambda_0 = 4\sigma T_e^3 \approx 3.2\text{ W}\cdot\text{m}^{-2}\text{K}^{-1} \implies \mathbf{\Delta T_0 = \frac{3.71}{3.2} \approx 1.2^\circ\text{C}}$.
     - **Equilibrium Climate Sensitivity ($\text{ECS}$ with Feedbacks):**
       $$\mathbf{\text{ECS} \approx 2.5^\circ\text{C} - 4.0^\circ\text{C} \qquad (\text{IPCC AR6 Best Estimate: } \mathbf{3.0^\circ\text{C}})}$$
   - **Transient Climate Response ($\text{TCR}$):** Temperature change at the exact moment $\text{CO}_2$ doubles under a $1\%/\text{year}$ increase ($\text{TCR} \approx 1.4-2.2^\circ\text{C}$, damped by ocean thermal inertia).
2. **Slide 2 (`ordering`):** Provide 5 steps of the greenhouse warming cascade following a doubling of atmospheric CO2: (1) industrial emissions double the atmospheric CO2 concentration from 280 ppm to 560 ppm, (2) additional CO2 molecules absorb outgoing longwave infrared radiation in the 15-micrometer absorption band, reducing top-of-atmosphere outgoing thermal flux by 3.71 W/m^2, (3) an instantaneous planetary energy imbalance establishes where incoming solar absorbed exceeds outgoing infrared emission, (4) the troposphere and upper ocean warm, triggering positive water vapor, cloud, and ice-albedo feedbacks that amplify the initial perturbation, (5) the global mean surface temperature rises until enhanced blackbody radiation (Planck feedback) restores top-of-atmosphere radiative equilibrium at a new ECS temperature (+3.0°C)!
3. **Slide 3 (`matching`):** Pair 4 climate sensitivity concepts (Radiative Forcing Delta F, Planck Response Delta T0, Equilibrium Climate Sensitivity ECS, Transient Climate Response TCR) with their physical formulations.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the radiative forcing resulting from a complete doubling of atmospheric CO2 is approximately 3.71 watts per square meter. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the physics behind the logarithmic scaling of carbon dioxide radiative forcing: Why does the radiative forcing of $\text{CO}_2$ scale logarithmically ($\Delta F \propto \ln(C/C_0)$) rather than linearly with atmospheric concentration? (Because the **core of the $15\text{-}\mu\text{m}$ infrared absorption band of $\text{CO}_2$ is already optically saturated**; adding more $\text{CO}_2$ molecules only absorbs infrared radiation in the **weakly absorbing Lorentzian/Doppler outer wings of the spectral band**, requiring exponentially more molecules to achieve the same additional absorption).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "radiative_forcing_and_climate_sensitivity_ecs",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Radiative Forcing & Climate Sensitivity (1967/2021)**\n• **Logarithmic Radiative Forcing Formula:**\n$$\n\\mathbf{\\Delta F = 5.35 \\ln\\left(\\frac{C}{C_0}\\right) \\text{ W/m}^2 \\implies \\Delta F_{2\\times\\text{CO}_2} = 5.35 \\ln(2) \\approx 3.71\\text{ W/m}^2}\n$$\n• **The Climate Sensitivity Spectrum:**\n$$\n\\begin{array}{|l|l|c|}\n\\hline\n\\textbf{Metric} & \\textbf{Physical Definition} & \\textbf{Value} \\\\\n\\hline\n\\textbf{Planck Response ($\\Delta T_0$)} & \\text{Warming with zero feedbacks (pure blackbody)} & \\mathbf{\\approx 1.2^\\circ\\text{C}} \\\\\n\\textbf{Equilibrium Sensitivity (ECS)} & \\text{Full equilibrium warming including all feedbacks} & \\mathbf{2.5\\text{--}4.0^\\circ\\text{C}} \\ (\\text{Best: } 3.0^\\circ\\text{C}) \\\\\n\\textbf{Transient Response (TCR)} & \\text{Warming at moment of doubling (1\\%/yr ramp)} & \\mathbf{1.4\\text{--}2.2^\\circ\\text{C}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Law of Doublings:** Going from $280 \\to 560\\text{ ppm}$ adds $+3.71\\text{ W/m}^2$; going from $560 \\to 1120\\text{ ppm}$ adds the exact same $+3.71\\text{ W/m}^2$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential physical steps of Earth's climate response to a doubling of atmospheric CO2.",
      "orderItems": [
        "Atmospheric carbon dioxide concentration doubles from pre-industrial 280 ppm to 560 ppm",
        "CO2 molecules absorb outgoing 15-micrometer infrared radiation, imposing an instantaneous top-of-atmosphere radiative forcing of +3.71 W/m²",
        "A positive planetary energy imbalance develops, trapping excess heat in the climate system",
        "Warming air activates positive feedbacks: atmospheric water vapor increases by ~7%/°C and polar sea ice melts",
        "Planetary surface temperature rises by ~3.0°C (ECS) until enhanced Planck blackbody radiation restores global energy equilibrium"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each climate metric to its exact thermodynamic definition.",
      "matchPairs": [
        { "left": "Radiative Forcing (Delta F)", "right": "Net change in Earth's energy irradiance balance at top-of-atmosphere measured in W/m²" },
        { "left": "Equilibrium Climate Sensitivity (ECS)", "right": "Ultimate long-term global mean surface warming resulting from sustained CO2 doubling after full ocean equilibration" },
        { "left": "Transient Climate Response (TCR)", "right": "Surface temperature rise at the exact year CO2 doubles under a transient 1% per year compounding increase" },
        { "left": "Planck Blackbody Feedback (lambda_0)", "right": "Fundamental thermodynamic damping response (-3.2 W/m²K) radiating thermal energy to space via sigma*T⁴" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The radiative forcing imposed at the top of the atmosphere by a complete doubling of carbon dioxide is approximately ___ watts per square meter.",
      "blankAnswer": "3.71",
      "blankDistractors": ["100.0", "0.5", "50.0"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the radiative forcing of carbon dioxide follow a logarithmic relationship (Delta F = 5.35 * ln(C/C0)) rather than increasing linearly with every ton of CO2 added to the atmosphere?",
      "options": [
        { "text": "The central wavelengths of the 15-micrometer CO2 infrared absorption band are already completely optically saturated; newly added CO2 molecules can only absorb infrared photons in the weakly absorbing outer wings (Lorentzian line edges) of the spectral band, requiring an exponentially larger increase in concentration to produce an equal increment of radiative forcing", "isCorrect": true, "explanation": "Correct! Greenhouse gases absorb longwave infrared radiation at specific quantum molecular vibrational-rotational transition bands. For CO2, the primary absorption band is centered at a wavelength of 15 micrometers (where Earth's thermal emission peaks). Even at pre-industrial concentrations of 280 ppm, there were already enough CO2 molecules in the air that the atmosphere was essentially opaque ('black') at the very center of the 15-micrometer band—virtually 100% of photons emitted from the surface at those core wavelengths were already being absorbed within a few hundred meters of the ground. When additional CO2 is emitted, it cannot absorb more at the saturated center; instead, absorption expands outward into the weakly absorbing edges or 'wings' of the absorption band (governed by collisional pressure broadening described by the Lorentz line profile). Because absorption in the wings grows with the logarithm of optical depth, each doubling of CO2 concentration (e.g. 100 to 200 ppm, 280 to 560 ppm, or 560 to 1120 ppm) produces the exact same increment of radiative forcing (~3.71 W/m²)." },
        { "text": "Because greenhouse gases turn into liquids at high altitudes", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the sun dims whenever CO2 increases", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because logarithmic math was arbitrarily chosen by meteorologists to make calculations easier", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
