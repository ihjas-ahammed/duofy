# Duofy Reusable Lesson Format: Marine Carbonate System and Ocean Acidification

**Target Topic:** `02_Physical_and_Life_Sciences / 06_Earth_and_Planetary_Sciences / Oceanography_and_Hydrology / Physical_and_Chemical_Oceanography`  
**Lesson Format Type:** `marine_carbonate_system_and_ocean_acidification`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid biogeochemical, chemical-equilibrium, and ecological mastery of marine carbon chemistry and ocean acidification (Alfred Redfield 1934; Wallace Broecker; Richard Feely 2004): master the **Marine Carbonate Equilibrium Cascade** ($\text{CO}_2(\text{aq}) + \text{H}_2\text{O} \rightleftharpoons \text{H}_2\text{CO}_3 \rightleftharpoons \text{HCO}_3^- + \text{H}^+ \rightleftharpoons \text{CO}_3^{2-} + 2\text{H}^+$), define **Dissolved Inorganic Carbon ($\text{DIC} = [\text{CO}_2^*] + [\text{HCO}_3^-] + [\text{CO}_3^{2-}]$)** and **Total Alkalinity ($\text{TA}$)**, evaluate the chemical mechanism of **Anthropogenic Ocean Acidification** ($\uparrow \text{CO}_2 \to \uparrow [\text{H}^+] \to \downarrow \text{pH} \to \text{consumption of carbonate ions } \text{CO}_2 + \text{H}_2\text{O} + \mathbf{\text{CO}_3^{2-}} \to 2\text{HCO}_3^- \implies \mathbf{\downarrow \Omega_{\text{aragonite/calcite}}}$), analyze the **Carbonate Compensation Depth (CCD)** and **Redfield Ratio ($\text{C}:\text{N}:\text{P} = 106:16:1$)**, and interact with live marine carbonate equilibrium simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Marine Carbonate Equilibrium & Ocean Acidification Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Carbonate Equilibrium Species / Parameter & Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Impact of Ocean Acidification on Marine Calcifiers (Aragonite Saturation) Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Classical Stoichiometric Redfield Ratio Carbon Proportion Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Marine Carbonate System & Aragonite Saturation Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "marine_carbonate_system_and_ocean_acidification",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Marine Carbonate System and how does Anthropogenic CO2 uptake cause Ocean Acidification?",
      "blankAnswer": "Marine inorganic carbon chemistry and ocean acidification (Alfred Redfield 1934; Richard Feely 2004): (1) THE CARBONATE EQUILIBRIUM CASCADE: CO2(aq) + H2O <-> H2CO3 <-> HCO3⁻ + H⁺ <-> CO3²⁻ + 2H⁺. In modern surface seawater (pH ≈ 8.1): ~90% of Dissolved Inorganic Carbon (DIC) exists as Bicarbonate (HCO3⁻), ~9% as Carbonate (CO3²⁻), and <1% as aqueous CO2/H2CO3. (2) OCEAN ACIDIFICATION MECHANISM: As the ocean absorbs atmospheric CO2, it forms carbonic acid, which dissociates to release H⁺ ions, dropping ocean pH (from 8.25 to 8.14 since the industrial revolution, a 30% increase in [H⁺]!). The excess H⁺ ions react with existing carbonate ions: CO2 + H2O + CO3²⁻ -> 2HCO3⁻. This consumes and severely depletes the pool of free Carbonate ions (CO3²⁻). (3) ARAGONITE/CALCITE SATURATION STATE (Omega): Omega = ([Ca²⁺][CO3²⁻]) / K'_sp. When Omega > 1, water is supersaturated and shells form easily. When Omega < 1 (undersaturation), seawater becomes corrosive, directly dissolving the calcium carbonate shells of pteropods, coccolithophores, and coral reef skeletons! (4) THE REDFIELD RATIO: C:N:P = 106:16:1 (stoichiometric ratio of marine organic matter)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each chemical oceanography parameter to its exact geochemical definition.",
      "matchPairs": [
        { "left": "Bicarbonate Ion (HCO3⁻)", "right": "Dominant dissolved inorganic carbon species in seawater representing approximately 90% of total DIC" },
        { "left": "Carbonate Ion (CO3²⁻)", "right": "Crucial building block for marine shell calcification that is actively consumed by ocean acidification" },
        { "left": "Aragonite Saturation State (Omega)", "right": "Thermodynamic measure of seawater corrosiveness to calcium carbonate coral skeletons and pteropod shells" },
        { "left": "Redfield Ratio (106:16:1)", "right": "Universal stoichiometric molar ratio of Carbon to Nitrogen to Phosphorus in marine phytoplankton" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the depletion of dissolved carbonate ions (CO3²⁻) by ocean acidification so dangerous to marine calcifying organisms like corals, pteropods, and shellfish, even though overall Dissolved Inorganic Carbon (DIC) is actually increasing?",
      "options": [
        { "text": "Marine calcifiers require free carbonate ions (CO3²⁻) to precipitate calcium carbonate shells (Ca²⁺ + CO3²⁻ -> CaCO3); dissolving extra CO2 reacts with and consumes CO3²⁻ to make bicarbonate (CO2 + H2O + CO3²⁻ -> 2HCO3⁻), lowering the saturation state (Omega < 1) and causing shells to spontaneously dissolve in corrosive seawater", "isCorrect": true, "explanation": "Correct! When atmospheric CO2 dissolves into surface seawater, total Dissolved Inorganic Carbon (DIC) indeed increases, but the chemical speciation shifts dramatically. The newly formed carbonic acid releases hydrogen ions (H⁺), which immediately react with available carbonate ions: CO2 + H2O + CO3²⁻ -> 2HCO3⁻. This reaction converts useful carbonate ions (CO3²⁻) into unusable bicarbonate ions (HCO3⁻). Marine organisms (corals, pteropods, clams, oysters, and coccolithophores) cannot easily use bicarbonate to build their shells; they rely on free carbonate ions. As [CO3²⁻] plunges, the mineral saturation state Omega = ([Ca²⁺][CO3²⁻]) / K'_sp drops below 1.0. When Omega < 1.0, surface seawater becomes undersaturated and chemically corrosive, literally dissolving the outer protective shells of living organisms while they are still alive." },
        { "text": "Because bicarbonate turns the ocean into carbonated soda water that suffocates fish", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because calcium ions are destroyed by solar radiation", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because acid makes the ocean water too heavy for corals to float", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Alfred Redfield's famous 1934 oceanographic stoichiometric ratio (C:N:P = ___:16:1), the relative molar proportion of Carbon is 106.",
      "blankAnswer": "106",
      "blankDistractors": ["50", "12", "500"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Marine Carbonate System & Ocean Acidification Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Marine Carbonate & Ocean Acidification Engine</h3><p>Pre-Industrial: $\\text{CO}_2 = 280\\text{ ppm}$ | $\\text{pH} = 8.25$ | $\\Omega_{\\text{arag}} = 4.2$ (Super-saturated)</p><button id=\"co2Btn\" style=\"padding:8px 16px; margin:4px; background:#ef4444; color:white; border:none; border-radius:6px; cursor:pointer;\">Pump Anthropogenic CO2 (800 ppm Scenario)</button><button id=\"resBtn\" style=\"padding:8px 16px; margin:4px; background:#10b981; color:white; border:none; border-radius:6px; cursor:pointer;\">Restore Pre-Industrial Carbonate Equilibrium</button><div id=\"carbOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Carbonate Engine Ready...</div><script>document.getElementById('co2Btn').onclick=()=>{document.getElementById('carbOut').innerText='Acidification Triggered: CO2 + H2O + CO3(2-) -> 2HCO3- | pH drops to 7.80 (+150% [H+]) -> [CO3(2-)] drops by 50% -> Omega_arag < 1.0 (CORROSIVE)! Pteropod shells & coral skeletons dissolve!';}; document.getElementById('resBtn').onclick=()=>{document.getElementById('carbOut').innerText='Equilibrium Restored: pH = 8.25 | [CO3(2-)] abundant -> Omega_arag = 4.2 -> Vigorous coral reef calcification!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
