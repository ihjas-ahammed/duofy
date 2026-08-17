# Duofy Reusable Lesson Format: CMIP6 Shared Socioeconomic Pathways (SSP Scenarios)

**Target Topic:** `02_Physical_and_Life_Sciences / 07_Ecology_and_Environmental_Science / Climate_Change_and_Global_Systems / Greenhouse_Effect_and_Climate_Modeling`  
**Lesson Format Type:** `cmip6_shared_socioeconomic_pathways_ssp_scenarios`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid climatological, Earth-system modeling, and international climate policy mastery of the 6th Coupled Model Intercomparison Project (CMIP6) and Shared Socioeconomic Pathways (SSPs) (Brian O'Neill 2017; Keywan Riahi 2017; IPCC AR6 2021): master the SSP matrix architecture combining **Socioeconomic Narratives (SSP1 Sustainability, SSP2 Middle of the Road, SSP3 Regional Rivalry, SSP4 Inequality, SSP5 Fossil-Fueled Development)** with **2100 Radiative Forcing Targets ($+1.9, +2.6, +4.5, +7.0, +8.5\text{ W/m}^2$)**, evaluate the 5 canonical CMIP6 benchmark scenarios (**SSP1-1.9 [Paris $1.5^\circ\text{C}$ Target]**, **SSP1-2.6 [Well Below $2.0^\circ\text{C}$]**, **SSP2-4.5 [Current Policy Trajectory $\sim 2.7^\circ\text{C}$]**, **SSP3-7.0 [High Emissions $\sim 3.6^\circ\text{C}$]**, and **SSP5-8.5 [Extreme High-End Baseline $\sim 4.4^\circ\text{C}$]**), and interact with live CMIP6 emission pathway and warming simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CMIP6 SSP Matrix Architecture & Paris Targets Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | CMIP6 SSP Scenario & 2100 Radiative Forcing / Warming Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Global Warming Projection for Middle-of-the-Road SSP2-4.5 Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Year 2100 Radiative Forcing Target in Watts/m^2 for SSP1-1.9 Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive CMIP6 SSP Socioeconomic Pathway Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cmip6_shared_socioeconomic_pathways_ssp_scenarios",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is CMIP6 and how do the Shared Socioeconomic Pathways (SSPs) combine society with radiative forcing?",
      "blankAnswer": "Global climate modeling and policy scenarios (O'Neill 2017; Riahi 2017; IPCC AR6 2021): (1) CMIP6 (Coupled Model Intercomparison Project Phase 6): A coordinated framework of over 100 Earth System Models run by dozens of international research centers (e.g. NCAR, GFDL, UK Met Office, Max Planck Institute) to project future climate change under standardized forcing scenarios. (2) THE SSP MATRIX: Combines 5 Socioeconomic Development Storylines (SSP1 to SSP5) with specific 2100 Radiative Forcing Targets (1.9 to 8.5 W/m²): (a) SSP1-1.9: Sustainable development with rapid decarbonization reaching Net-Zero CO2 around 2050; limits 2100 warming to ~1.4°C (the Paris 1.5°C target). (b) SSP1-2.6: Strong climate mitigation reaching Net-Zero around 2075; holds warming to ~1.8°C (the 'Well Below 2.0°C' target). (c) SSP2-4.5: 'Middle of the Road' scenario with current national pledges and gradual decarbonization; leads to ~2.7°C warming by 2100. (d) SSP3-7.0: 'Regional Rivalry' with high fragmentation, national security focus, and heavy coal/fossil use; leads to ~3.6°C warming. (e) SSP5-8.5: 'Fossil-Fueled Development' high-end worst-case baseline with extreme fossil exploitation; leads to ~4.4°C warming!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each CMIP6 SSP climate scenario to its projected 2100 outcome.",
      "matchPairs": [
        { "left": "SSP1-1.9", "right": "Rapid green transition reaching net-zero by 2050 limiting 2100 warming to ~1.4°C (Paris 1.5°C target)" },
        { "left": "SSP1-2.6", "right": "Aggressive mitigation reaching net-zero by 2075 holding warming to ~1.8°C (Paris 2.0°C target)" },
        { "left": "SSP2-4.5", "right": "Middle of the road trajectory aligning with current global policies resulting in ~2.7°C warming by 2100" },
        { "left": "SSP5-8.5", "right": "Fossil-intensive development worst-case high-end baseline projecting ~4.4°C warming by 2100" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Under the IPCC Sixth Assessment Report (AR6), which CMIP6 Shared Socioeconomic Pathway most closely reflects the projected 2100 global warming trajectory (~2.5°C to 2.7°C) under current enacted national policies and Nationally Determined Contributions (NDCs)?",
      "options": [
        { "text": "SSP2-4.5 ('Middle of the Road'); reflecting moderate socioeconomic development, gradual technological adoption, and carbon emissions that peak around 2040 before slowly declining, leading to a radiative forcing of +4.5 W/m² and a projected 2100 warming of ~2.7°C", "isCorrect": true, "explanation": "Correct! In climate policy assessments (such as the UNEP Emissions Gap Report and IPCC AR6), scenarios are benchmarked against current world trajectories. SSP1-1.9 and SSP1-2.6 represent ambitious transformation pathways that require immediate, steep global emission cuts. SSP5-8.5 represents a pessimistic, high-emissions fossil-expansion scenario used primarily as an unmitigated stress-test. The SSP2-4.5 scenario ('Middle of the Road') is the benchmark that best matches current real-world policies and existing Paris Agreement Nationally Determined Contributions (NDCs). In SSP2-4.5, global CO2 emissions remain near current levels (~40 GtCO2/yr) for the next decade, peak around mid-century (2040-2050), and then gradually decline without reaching net-zero before 2100. This generates an end-of-century radiative forcing of +4.5 W/m² and a best-estimate global surface warming of approximately +2.7°C (likely range 2.1°C to 3.5°C) above pre-industrial levels." },
        { "text": "SSP1-1.9 because all countries have already stopped using fossil fuels", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "SSP5-8.5 because global coal consumption is increasing by 1,000% per year", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "None of the SSPs because climate models do not make projections for 2100", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the CMIP6 scenario designation 'SSP1-1.9', the numeric suffix '1.9' denotes the target radiative forcing of ___ watts per square meter in the year 2100.",
      "blankAnswer": "1.9",
      "blankDistractors": ["15.0", "0.5", "100.0"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive CMIP6 Shared Socioeconomic Pathway Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>CMIP6 Shared Socioeconomic Pathway Engine</h3><p>Select CMIP6 Future Climate Scenario:</p><button id=\"ssp1Btn\" style=\"padding:8px 14px; margin:3px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">SSP1-1.9 (Paris 1.5°C)</button><button id=\"ssp2Btn\" style=\"padding:8px 14px; margin:3px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer;\">SSP2-4.5 (Current Policies ~2.7°C)</button><button id=\"ssp5Btn\" style=\"padding:8px 14px; margin:3px; background:#ef4444; color:white; border:none; border-radius:4px; cursor:pointer;\">SSP5-8.5 (Fossil Fuel Baseline ~4.4°C)</button><div id=\"sspOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Select an SSP scenario above...</div><script>document.getElementById('ssp1Btn').onclick=()=>{document.getElementById('sspOut').innerText='SSP1-1.9: Radiative Forcing = +1.9 W/m² | Net-Zero CO2 by 2050 | Peak Warming: 1.5°C -> 2100 Warming: 1.4°C (PARIS 1.5 TARGET MET)!';}; document.getElementById('ssp2Btn').onclick=()=>{document.getElementById('sspOut').innerText='SSP2-4.5: Radiative Forcing = +4.5 W/m² | Emissions peak ~2040 | 2100 Warming: ~2.7°C (Severe heatwaves, coral reef loss)!';}; document.getElementById('ssp5Btn').onclick=()=>{document.getElementById('sspOut').innerText='SSP5-8.5: Radiative Forcing = +8.5 W/m² | Coal expansion | 2100 Warming: ~4.4°C (CATASTROPHIC MULTI-METER SEA LEVEL RISE)!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
