# Duofy Reusable Lesson Format: Radiative-Convective Equilibrium and the Manabe Model

**Target Topic:** `02_Physical_and_Life_Sciences / 07_Ecology_and_Environmental_Science / Climate_Change_and_Global_Systems / Greenhouse_Effect_and_Climate_Modeling`  
**Lesson Format Type:** `radiative_convective_equilibrium_and_manabe_model`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the breakthrough atmospheric physics of Radiative-Convective Equilibrium (RCE) and the landmark 1967 Manabe-Wetherald climate model that earned the 2021 Nobel Prize in Physics (Syukuro Manabe & Richard T. Wetherald 1967; Kerry Emanuel): analyze pure **Radiative Equilibrium** (showing that greenhouse gases alone without convection produce an unphysically steep super-adiabatic surface temperature of $\sim 330\text{ K}$ and an unstable lapse rate), formulate **Convective Adjustment** (limiting the tropospheric lapse rate to the critical threshold $\Gamma_c \approx 6.5\text{ K/km}$ via turbulent sensible and latent heat upward transport), analyze the **Manabe-Wetherald 1967 Result** (establishing the first quantitatively robust Equilibrium Climate Sensitivity calculation: doubling $\text{CO}_2$ from $300 \to 600\text{ ppm}$ yields $\Delta T_{\text{surface}} \approx +2.3^\circ\text{C}$ with tropospheric warming and simultaneous **stratospheric cooling**), and evaluate the stratospheric cooling "fingerprint" of greenhouse warming.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Radiative-Convective Equilibrium & Manabe's Nobel Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step RCE Numerical Convergence from Pure Radiation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | RCE Model Component / Feature & Physical Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Critical Convective Adjustment Lapse Rate in K per Km Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Stratospheric Cooling as the Definitive Fingerprint of Greenhouse Warming Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Radiative-Convective Equilibrium & The Manabe Model (Manabe & Wetherald 1967; 2021 Nobel Prize in Physics):
   - **The Flaw of Pure Radiative Equilibrium:**
     - If the atmosphere is governed purely by radiative transfer (infrared absorption and emission), the surface heats up to an extreme $\approx 330\text{ K} \ (+57^\circ\text{C})$ with a wildly super-adiabatic lapse rate ($>15\text{ K/km}$), which is statically unstable!
   - **The 1D Radiative-Convective Equilibrium (RCE) Solution:**
     $$\mathbf{\frac{\partial T(z)}{\partial t} = \underbrace{\left(\frac{\partial T}{\partial t}\right)_{\text{radiation}}}_{\text{Shortwave + Longwave Fluxes}} + \underbrace{\left(\frac{\partial T}{\partial t}\right)_{\text{convection}}}_{\text{Convective Adjustment}}}$$
     - **Convective Adjustment:** Whenever the radiative temperature gradient exceeds the critical moist adiabatic threshold:
       $$\mathbf{-\frac{\partial T}{\partial z} > \Gamma_c \approx 6.5\text{ K/km} \ (6.5^\circ\text{C/km})}$$
       atmospheric overturning immediately mixes heat upward, resetting the tropospheric lapse rate to $6.5\text{ K/km}$ and cooling the surface to a realistic $288\text{ K} \ (+15^\circ\text{C})$!
   - **The Landmark 1967 Manabe-Wetherald Findings:**
     - **Doubling $\text{CO}_2$ ($300 \to 600\text{ ppm}$):** Predicted surface warming of $\mathbf{\approx +2.3^\circ\text{C}}$ with fixed relative humidity.
     - **The Vertical Greenhouse Fingerprint:** Showed that increasing $\text{CO}_2$ warms the **Troposphere** while simultaneously **cooling the Stratosphere** (enhanced longwave emission to space from low-density stratospheric $\text{CO}_2$), definitively distinguishing greenhouse warming from solar brightening (which would warm all layers)!
2. **Slide 2 (`ordering`):** Provide 5 steps of the RCE calculation loop: (1) initialize a 1D vertical atmospheric column with an isothermal temperature profile, (2) compute vertical shortwave solar absorption and longwave infrared emission across all vertical layers, (3) check the resulting temperature profile; notice that lower layers become violently super-adiabatic (lapse rate exceeding 6.5 K/km), (4) apply convective adjustment to mix heat upward, redistributing energy until the tropospheric lapse rate equals exactly 6.5 K/km while conserving total column energy, (5) iterate the combined radiative and convective time steps until the entire atmospheric column reaches a stable steady state (Radiative-Convective Equilibrium)!
3. **Slide 3 (`matching`):** Pair 4 RCE concepts (Pure Radiative Equilibrium, Convective Adjustment, 6.5 K/km Lapse Rate, Stratospheric Cooling) with their physical roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the standard critical tropospheric lapse rate used in Manabe's convective adjustment is 6.5 Kelvin per kilometer. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the physical cause of stratospheric cooling under increasing greenhouse gases: Why does adding $\text{CO}_2$ to the atmosphere cause the troposphere to warm while simultaneously causing the stratosphere to cool? (Because in the rarefied, optically thin stratosphere, **higher $\text{CO}_2$ concentration allows the gas to radiate infrared photons directly into outer space more efficiently**, which enhances radiative cooling; meanwhile, in the dense, optically thick troposphere, **$\text{CO}_2$ acts as an insulating blanket that traps heat near the ground**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "radiative_convective_equilibrium_and_manabe_model",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Radiative-Convective Equilibrium (Manabe 1967)**\n• **Pure Radiative Equilibrium Failure:** Radiation alone yields an unstable surface ($T_s \\approx 330\\text{ K}$) and super-adiabatic lapse rate ($>15\\text{ K/km}$).\n• **The Convective Adjustment Fix (Nobel Prize in Physics 2021):**\n$$\n\\mathbf{-\\frac{\\partial T}{\\partial z} > \\Gamma_c \\approx 6.5\\text{ K/km} \\implies \\text{Instantaneous Convective Upward Heat Flux!}}\n$$\n  - Resets troposphere to realistic $288\\text{ K}$ ($+15^\\circ\\text{C}$).\n• **The 1967 Climate Sensitivity Breakthrough ($2\\times\\text{CO}_2$):**\n  - Manabe \\& Wetherald calculated **$\\Delta T_s = +2.3^\\circ\\text{C}$** with fixed relative humidity.\n• **The Greenhouse Fingerprint:**\n  - $\\text{CO}_2$ increases $\\implies$ **Tropospheric Warming** $+$ **Stratospheric COOLING** (proves warming is GHG-driven, not solar)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of Manabe's numerical Radiative-Convective Equilibrium calculation loop.",
      "orderItems": [
        "Initialize a 1D vertical atmospheric column with an initial temperature and moisture profile",
        "Compute vertical fluxes of absorbed solar shortwave and emitted longwave infrared radiation across all atmospheric levels",
        "Observe that pure radiative heating creates an unstable, super-adiabatic temperature gradient near the ground",
        "Apply convective adjustment to mix sensible heat vertically, enforcing a neutral lapse rate of 6.5 K/km while conserving total column energy",
        "Iterate the radiative-convective time integration until top-of-atmosphere and surface energy fluxes achieve steady-state equilibrium"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Radiative-Convective Equilibrium concept to its exact physical meaning.",
      "matchPairs": [
        { "left": "Pure Radiative Equilibrium", "right": "Unphysical state where radiation alone overheats the surface to ~330 K with violent static instability" },
        { "left": "Convective Adjustment", "right": "Algorithm resetting unstable lapse rates to a realistic moist adiabat (6.5 K/km) via turbulent vertical mixing" },
        { "left": "Stratospheric Cooling", "right": "Definitive vertical fingerprint of greenhouse gas warming caused by enhanced infrared emission to space at high altitudes" },
        { "left": "Fixed Relative Humidity (Manabe 1967)", "right": "Climatological assumption that water vapor content scales with temperature according to Clausius-Clapeyron" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Syukuro Manabe's landmark 1967 climate model, the critical tropospheric lapse rate enforced by convective adjustment was ___ Kelvin per kilometer.",
      "blankAnswer": "6.5",
      "blankDistractors": ["9.8", "2.0", "15.0"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the observed simultaneous 'warming of the troposphere and cooling of the stratosphere' considered by climate physicists to be the definitive 'smoking gun' proving that global warming is caused by greenhouse gases rather than an increase in solar irradiance?",
      "options": [
        { "text": "If solar irradiance were increasing, both the troposphere and the stratosphere would warm simultaneously; but because CO2 traps heat in the lower atmosphere while accelerating radiative infrared emission to space in the thin, optically transparent stratosphere, rising greenhouse gas concentrations uniquely produce tropospheric warming paired with stratospheric cooling", "isCorrect": true, "explanation": "Correct! When testing whether global warming is driven by changes in solar output versus anthropogenic greenhouse gases, the vertical profile of atmospheric temperature changes provides an unequivocal physical fingerprint. If the Sun's total solar irradiance had increased over the past century, incoming solar energy would heat the entire depth of the atmosphere, causing both the troposphere and the stratosphere to warm in tandem. In contrast, greenhouse gases operate as a selective radiative blanket. In the dense, optically thick troposphere, adding CO2 traps outgoing longwave radiation, keeping heat trapped near the surface and warming the lower atmosphere. But in the rarefied, optically thin stratosphere (above 15-20 km), longwave radiation from CO2 molecules escapes directly into space without being re-absorbed. Increasing stratospheric CO2 concentration therefore accelerates the rate at which the stratosphere radiates heat to space, causing the stratosphere to dramatically cool. Satellite and weather balloon soundings have recorded decades of strong stratospheric cooling coinciding with tropospheric warming, providing irrefutable empirical proof of the greenhouse mechanism." },
        { "text": "Because the stratosphere is heated by ocean tides", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because greenhouse gases block sunlight from reaching the stratosphere", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because airplanes air-condition the stratosphere", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
