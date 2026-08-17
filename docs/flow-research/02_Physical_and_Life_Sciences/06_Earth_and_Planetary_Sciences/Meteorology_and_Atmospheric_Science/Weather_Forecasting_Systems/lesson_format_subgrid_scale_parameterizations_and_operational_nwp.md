# Duofy Reusable Lesson Format: Subgrid-Scale Parameterizations and Operational NWP

**Target Topic:** `02_Physical_and_Life_Sciences / 06_Earth_and_Planetary_Sciences / Meteorology_and_Atmospheric_Science / Weather_Forecasting_Systems`  
**Lesson Format Type:** `subgrid_scale_parameterizations_and_operational_nwp`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid physical, numerical, and operational mastery of subgrid-scale physics representations in global and regional numerical weather prediction models (Akio Arakawa & Wayne Schubert 1974; Joseph Smagorinsky): contrast resolvable grid-scale dynamics ($\Delta x \ge 9-13\text{ km}$) with un-resolvable subgrid processes requiring **Semi-Empirical Physical Parameterizations** (**1. Cumulus Convection Schemes** [Arakawa-Schubert mass-flux, Kain-Fritsch, Betts-Miller adjustment representing unresolved convective updrafts/downdrafts and latent heating], **2. Cloud Microphysics Schemes** [single-moment vs double-moment predicting mixing ratios and number concentrations for cloud water, rain, pristine ice, snow, and graupel], **3. Planetary Boundary Layer [PBL] Turbulence & Surface Fluxes** [Mellor-Yamada, YSU 1.5-order closure modeling turbulent heat/momentum exchange with land/ocean], and **4. Radiative Transfer Schemes** [RRTMG longwave and shortwave radiation]), and interact with live NWP convective parameterization and grid resolution simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Resolvable Dynamics vs Subgrid Parameterizations Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Subgrid Parameterization Scheme & Physical Process Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Convection-Allowing Model (CAM) vs Cumulus Parameterization Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Maximum Spatial Grid Resolution for Convection-Allowing Models Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive NWP Grid Resolution & Parameterization Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "subgrid_scale_parameterizations_and_operational_nwp",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "Why are subgrid-scale physical parameterizations necessary in NWP models, and what are the 4 core physics suites?",
      "blankAnswer": "Numerical Weather Prediction divides the atmosphere into discrete 3D grid cells (e.g. 9 km in ECMWF IFS, 13 km in NOAA GFS, 3 km in HRRR). Any atmospheric process occurring on spatial scales smaller than the grid mesh (subgrid scales) cannot be explicitly resolved by Navier-Stokes equations and must be statistically formulated through PHYSICAL PARAMETERIZATIONS: (1) CUMULUS CONVECTION PARAMETERIZATION (e.g. Arakawa-Schubert, Kain-Fritsch): In coarse global models (grid spacing > 5 km), individual thunderstorm updrafts (~1-2 km wide) cannot be resolved. Cumulus schemes compute the net vertical heat, moisture, and momentum transport of subgrid convective clouds to release latent heat and stabilize the column. (2) CLOUD MICROPHYSICS (e.g. Thompson, Morrison): Tracks the phase changes and mass/number concentrations of 6 hydrometeor categories: water vapor, cloud droplets, rain, ice crystals, snow, and graupel/hail. (3) PLANETARY BOUNDARY LAYER (PBL) & TURBULENCE (e.g. Mellor-Yamada, YSU): Models 3D turbulent eddy diffusion, surface drag, friction, and sensible/latent heat fluxes in the lowest 1-2 km of the atmosphere. (4) RADIATIVE TRANSFER (e.g. RRTMG): Computes longwave terrestrial emission and shortwave solar absorption/scattering across ozone, greenhouse gases, water vapor, and aerosols!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each NWP physical parameterization scheme to its targeted atmospheric process.",
      "matchPairs": [
        { "left": "Cumulus Parameterization (Kain-Fritsch)", "right": "Represents subgrid thunderstorm updrafts, downdrafts, and latent heating in coarse global models" },
        { "left": "Cloud Microphysics (Thompson Scheme)", "right": "Computes explicit phase transitions between cloud water, rain, pristine ice, snow, and graupel" },
        { "left": "PBL Turbulence (YSU Scheme)", "right": "Models turbulent vertical mixing of momentum, heat, and moisture within the planetary boundary layer" },
        { "left": "Radiative Transfer (RRTMG)", "right": "Calculates solar shortwave absorption and terrestrial longwave infrared emission through atmospheric gases" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why do high-resolution regional weather models with grid spacing of 3 km or finer (such as the High-Resolution Rapid Refresh, HRRR) deliberately turn OFF their cumulus convection parameterization schemes?",
      "options": [
        { "text": "At grid spacings of 3 km or less (Convection-Allowing Models, CAMs), the model grid is fine enough to explicitly resolve individual thunderstorm updrafts, downdrafts, and squall line mesoscale dynamics directly using primitive vertical momentum equations, making parameterized cumulus schemes redundant and physically detrimental", "isCorrect": true, "explanation": "Correct! Individual thunderstorm updrafts and convective cells typically have horizontal diameters of 2 to 5 km. In a coarse global model (like the 13-km GFS), a single grid box covers over 150 square kilometers, which is far too large to 'see' an individual thunderstorm; therefore, the GFS must use a cumulus parameterization scheme (like Simplified Arakawa-Schubert) to estimate the statistical heating and rain from un-resolvable clouds. However, when grid resolution is sharpened to 3 km or finer (as in NOAA's HRRR or NAM Nest), the model enters the 'Convection-Allowing' regime. The primitive non-hydrostatic equations can now explicitly resolve the physical 3D vertical ascent, cold pool gust fronts, and mesocyclone rotation of real thunderstorms. Leaving a cumulus scheme turned on in a 3-km model would result in 'double counting' of convective heating and unphysical storm artifacts." },
        { "text": "Because thunderstorms only happen in coarse models", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because HRRR models are only used in winter when there is zero convection", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because supercomputers overheat if cumulus schemes are activated", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In numerical weather prediction, regional models with horizontal grid spacing finer than or equal to ___ kilometers are classified as Convection-Allowing Models (CAMs).",
      "blankAnswer": "3",
      "blankDistractors": ["13", "50", "100"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive NWP Grid Resolution & Parameterization Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>NWP Physics & Resolution Engine</h3><p>Select Model Grid Resolution:</p><button id=\"gfsBtn\" style=\"padding:8px 16px; margin:4px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Global Model (13 km Grid - NOAA GFS)</button><button id=\"hrrrBtn\" style=\"padding:8px 16px; margin:4px; background:#10b981; color:white; border:none; border-radius:6px; cursor:pointer;\">Convection-Allowing (3 km Grid - NOAA HRRR)</button><div id=\"nwpOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Select a model resolution above...</div><script>document.getElementById('gfsBtn').onclick=()=>{document.getElementById('nwpOut').innerText='13 km Global Model: Subgrid Thunderstorms (~2 km) UNRESOLVED! -> Cumulus Scheme ACTIVATED (Arakawa-Schubert) -> Parameterizes convective heating & rainfall across grid box!';}; document.getElementById('hrrrBtn').onclick=()=>{document.getElementById('nwpOut').innerText='3 km Convection-Allowing Model (CAM): Cumulus Scheme DEACTIVATED -> Explicit non-hydrostatic vertical velocity (w) -> Directly resolves supercells, hook echoes, and bow echoes!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
