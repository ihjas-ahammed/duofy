# Duofy Reusable Lesson Format: Hierarchy of Climate Models (EBM to ESM)

**Target Topic:** `02_Physical_and_Life_Sciences / 07_Ecology_and_Environmental_Science / Climate_Change_and_Global_Systems / Greenhouse_Effect_and_Climate_Modeling`  
**Lesson Format Type:** `hierarchy_of_climate_models_ebm_to_esm`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mathematical complexity, dimensional scaling, and physical parameterizations of the climate modeling hierarchy (Mikhail Budyko 1969; William D. Sellers 1969; Syukuro Manabe 1967; Kirk Bryan 1969): classify models across the 4 primary tiers (**Tier 1: Zero-D & 1D Energy Balance Models [EBMs]** [Budyko-Sellers latitudinal diffusive models; ice-albedo bistability and Snowball Earth bifurcation], **Tier 2: 1D Radiative-Convective Equilibrium [RCE] Models** [Manabe-Wetherald 1967; vertical column radiation coupled to convective adjustment], **Tier 3: 3D General Circulation Models [GCMs]** [discretized primitive hydrodynamic equations on 3D atmosphere-ocean spherical meshes], and **Tier 4: Coupled Earth System Models [ESMs]** [GCMs integrated with dynamic vegetation, terrestrial carbon cycling, ocean biogeochemistry, and ice sheets]), and analyze model discretization grids.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The 4 Tiers of the Climate Model Hierarchy Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Evolution from 0D Energy Balance to Coupled Earth System Model Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Climate Model Class & Dimensionality / Primary Capability Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Most Advanced Coupled Climate Model Class Acronym Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Snowball Earth Hysteresis in Simple Budyko-Sellers EBMs Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State The Climate Model Hierarchy (Budyko 1969; Manabe 1967; Bryan 1969):
   - **The 4 Tiers of Numerical Climate Simulation:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Tier} & \textbf{Model Class} & \textbf{Spatial Dimension} & \textbf{Core Physical Mechanics} \\
     \hline
     \mathbf{1} & \textbf{EBMs (Energy Balance)} & \text{0D (Global) / 1D (Latitude } \phi\text{)} & C \frac{\partial T}{\partial t} = \frac{S_0}{4}(1 - \alpha(T)) - (A + BT) + D\nabla^2 T \\
     \mathbf{2} & \textbf{RCE Models} & \text{1D (Vertical Column } z\text{)} & \text{Radiative transfer + Convective adjustment } (\Gamma \le 6.5\text{ K/km}) \\
     \mathbf{3} & \textbf{AOGCMs (General Circulation)} & \text{3D Grid } (\lambda, \phi, z) & \text{3D Navier-Stokes primitive fluid equations (Atmosphere + Ocean)} \\
     \mathbf{4} & \textbf{ESMs (Earth System Models)} & \text{Coupled Earth System} & \text{AOGCM + Carbon Cycle, Biogeochemistry, Dynamic Ice Sheets} \\
     \hline
     \end{array}$$
   - **The Budyko-Sellers Ice-Albedo Hysteresis (1969):**
     - Simple 1D EBMs discovered **bistable equilibria**: if global ice sheets advance past a critical latitude ($\approx 30^\circ\text{N/S}$), positive ice-albedo feedback triggers runaway glaciation into a **Snowball Earth**!
   - **Earth System Models (ESMs):** The gold standard for IPCC projections (e.g. CESM, GFDL-ESM, UKESM).
2. **Slide 2 (`ordering`):** Provide 5 steps in the historical and complexity evolution of climate modeling: (1) calculate zero-dimensional global mean planetary energy balance using Stefan-Boltzmann radiation equations, (2) develop 1D Energy Balance Models (Budyko-Sellers) incorporating latitudinal diffusive heat transport and temperature-dependent ice albedo, (3) formulate 1D Radiative-Convective Equilibrium models (Manabe-Wetherald) coupling vertical radiative transfer with convective tropospheric adjustment, (4) build 3D General Circulation Models (GCMs) solving primitive hydrodynamic Navier-Stokes equations on global 3D atmosphere-ocean grids, (5) couple full biogeochemical cycles, dynamic vegetation, marine carbon chemistry, and interactive ice sheets into comprehensive Earth System Models (ESMs)!
3. **Slide 3 (`matching`):** Pair 4 climate model classes (0D/1D Energy Balance Model EBM, 1D Radiative-Convective Model RCE, 3D Atmospheric-Ocean General Circulation Model AOGCM, Earth System Model ESM) with their defining capabilities.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the most advanced coupled numerical climate models simulating both physical fluid dynamics and biogeochemical carbon cycles are called ESMs. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the discovery of the Snowball Earth bifurcation in early Budyko-Sellers Energy Balance Models: In 1969, Mikhail Budyko and William Sellers independently published simple 1D latitudinal Energy Balance Models. What surprising, non-linear planetary climate phenomenon did their equations discover? (The equations revealed **ice-albedo runaway instability and bistable climate hysteresis**; if global cooling causes ice sheets to expand equatorward past approximately $30^\circ$ latitude, the runaway reflection of sunlight triggers a catastrophic, unstoppable transition into a completely frozen **Snowball Earth**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hierarchy_of_climate_models_ebm_to_esm",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Climate Model Hierarchy (1967--Present)**\n• **The 4 Tiers of Climate Simulation:**\n$$\n\\begin{array}{|c|l|l|l|}\n\\hline\n\\textbf{Tier} & \\textbf{Model Type} & \\textbf{Dimensions} & \\textbf{Physical Focus} \\\\\n\\hline\n\\mathbf{1} & \\textbf{EBM} & \\text{0D / 1D (Latitude)} & \\text{Energy budget + Ice-albedo hysteresis} \\\\\n\\mathbf{2} & \\textbf{RCE} & \\text{1D (Vertical)} & \\text{Radiative transfer + Convective adjustment} \\\\\n\\mathbf{3} & \\textbf{GCM} & \\text{3D Grid } (x,y,z) & \\text{3D Navier-Stokes fluid dynamics (Air + Sea)} \\\\\n\\mathbf{4} & \\textbf{ESM} & \\textbf{Full Earth System} & \\mathbf{\\text{GCM + Carbon Cycles, Vegetation, Ice Sheets!}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Budyko-Sellers Hysteresis (1969):** 1D EBMs proved ice expansion past $30^\\circ$ latitude triggers a runaway **Snowball Earth**!\n• **Modern ESMs:** Integrate chemical, biological, and physical spheres into a unified global simulation (CESM, GFDL)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the historical and architectural evolution of climate models from simplest to most comprehensive.",
      "orderItems": [
        "Formulate zero-dimensional planetary blackbody energy balance equations balancing solar influx against thermal radiation",
        "Construct 1D latitudinal Energy Balance Models (Budyko-Sellers) incorporating poleward heat diffusion and ice albedo",
        "Develop 1D vertical Radiative-Convective models (Manabe-Wetherald) coupling radiative transfer with convective mixing",
        "Discretize 3D primitive hydrodynamic Navier-Stokes equations on global spherical grids (General Circulation Models, GCMs)",
        "Couple atmospheric/oceanic GCMs with dynamic vegetation, terrestrial/marine carbon cycles, and ice sheets (Earth System Models, ESMs)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each tier of the climate modeling hierarchy to its defining scientific capability.",
      "matchPairs": [
        { "left": "Energy Balance Model (EBM)", "right": "0D or 1D latitudinal model capturing bulk global energy budgets and ice-albedo bifurcation" },
        { "left": "Radiative-Convective Model (RCE)", "right": "1D vertical column model calculating atmospheric greenhouse gas profiles with convective adjustment" },
        { "left": "General Circulation Model (GCM)", "right": "3D numerical model explicitly resolving atmospheric and oceanic fluid dynamical circulation" },
        { "left": "Earth System Model (ESM)", "right": "Comprehensive coupled model simulating physical fluid dynamics alongside interactive global carbon biogeochemistry" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The most comprehensive tier of modern climate simulation, coupling physical ocean-atmosphere GCMs with interactive biogeochemical carbon cycles, is the ___ class of models.",
      "blankAnswer": "esm",
      "blankDistractors": ["ebm", "rce", "nwp"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In 1969, Mikhail Budyko and William Sellers constructed the world's first 1D latitudinal Energy Balance Models (EBMs). What fundamental, non-linear planetary climate behavior did their simple models discover?",
      "options": [
        { "text": "Bistable climate hysteresis and runaway ice-albedo instability; if external cooling forces polar ice sheets to expand equatorward past a critical tipping threshold (~30° latitude), the dramatic increase in reflected solar radiation overwhelms the energy budget, plunging the entire planet into an ice-covered 'Snowball Earth'", "isCorrect": true, "explanation": "Correct! In 1969, Mikhail Budyko in the USSR and William Sellers in the USA independently created simple 1D mathematical Energy Balance Models (EBMs) that calculated Earth's surface temperature as a function of latitude, incorporating incoming solar radiation, poleward diffusive heat transport, outgoing infrared radiation, and temperature-dependent ice-albedo feedback. When they lowered the solar constant slightly, they discovered that climate equilibrium is non-linear and exhibits 'bistability' (hysteresis). Above a critical threshold, Earth maintains a stable temperate climate with ice only at the poles. However, if cooling pushes the ice edge equatorward beyond roughly 30° latitude, the surface area of high-albedo ice becomes so large that the planet reflects more solar energy than it can retain. This triggers a runaway positive ice-albedo feedback that rapidly freezes the entire globe down to the equator—a state known as 'Snowball Earth'. Once in the Snowball state, the planet is locked in ice and requires an immense greenhouse gas buildup (e.g. from volcanic outgassing) to melt back out." },
        { "text": "They discovered that Earth's climate never changes and has always been 20°C", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "They discovered that the atmosphere has no effect on planetary temperature", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "They proved that oceans evaporate into space every 1,000 years", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
