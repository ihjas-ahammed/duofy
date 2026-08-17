# Duofy Reusable Lesson Format: Primary Productivity (GPP, NPP) and Energy Pyramids

**Target Topic:** `02_Physical_and_Life_Sciences / 07_Ecology_and_Environmental_Science / Ecosystem_Dynamics_and_Conservation / Food_Webs_Energy_Flow_Biogeochemical_Cycles`  
**Lesson Format Type:** `primary_productivity_gpp_npp_and_energy_pyramids`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid ecosystem-metabolism, primary production accounting, and ecological pyramid mastery across terrestrial and marine biomes (Eugene P. Odum 1953; Robert H. Whittaker 1975; John J. Teal): master **Gross Primary Productivity (GPP)**, **Autotrophic Respiration ($R_a$)**, **Net Primary Productivity ($\text{NPP} = \text{GPP} - R_a$)**, and **Net Ecosystem Productivity ($\text{NEP} = \text{NPP} - R_h$)**, evaluate global biomes ranked by total and per-unit-area NPP (Tropical Rainforests and Coral Reefs $\sim 2000\text{ g/m}^2/\text{yr}$ vs Open Oceans with low per-area NPP but highest global total due to massive surface area), compare the 3 types of **Ecological Pyramids (Energy, Biomass, Numbers)**, analyze why **Marine Open-Ocean Biomass Pyramids are Inverted** (microscopic phytoplankton with ultra-high turnover rates supporting larger standing crops of long-lived zooplankton and fish), and interact with live primary productivity and ecological pyramid simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | GPP vs NPP Formulas & Inverted Marine Biomass Pyramids Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Primary Productivity Metric / Biome & Ecological Trait Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Physical Mechanism Driving Inverted Marine Biomass Pyramids Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Formula Subtracting Autotrophic Respiration from GPP to Yield NPP Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Primary Productivity & Ecological Pyramid Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "primary_productivity_gpp_npp_and_energy_pyramids",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the mathematical difference between GPP, NPP, and NEP, and why can Biomass Pyramids be inverted in oceans?",
      "blankAnswer": "Ecosystem energetics and primary productivity (Eugene Odum 1953; Robert Whittaker 1975): (1) PRODUCTIVITY BUDGETS: (a) GPP (Gross Primary Productivity): Total rate at which autotrophs capture solar radiant energy via photosynthesis per unit area per unit time (g C/m²/yr or kcal/m²/yr). (b) NPP (Net Primary Productivity): The actual energy/biomass remaining after plants consume energy for their own cellular respiration (R_a): NPP = GPP - R_a. NPP represents the biomass available to herbivores and decomposers! (c) NEP (Net Ecosystem Productivity): Net rate of carbon accumulation by the entire ecosystem after accounting for both autotrophic (R_a) and heterotrophic (R_h) respiration: NEP = GPP - (R_a + R_h) = NPP - R_h. (2) ECOLOGICAL PYRAMIDS: (a) Energy Pyramids: ALWAYS strictly upright in all ecosystems due to the 2nd Law of Thermodynamics (energy is lost at each level). (b) Biomass Pyramids: Upright on land (trees weigh vastly more than deer), but INVERTED IN OPEN OCEANS! Inverted biomass occurs because microscopic phytoplankton have tiny standing biomass but extremely rapid turnover/reproduction rates (days), producing enough energy flux to sustain a larger standing biomass of long-lived zooplankton and fish!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each ecological productivity metric to its precise definition.",
      "matchPairs": [
        { "left": "Gross Primary Productivity (GPP)", "right": "Total solar radiant energy converted into organic chemical bond energy by producers per unit area" },
        { "left": "Net Primary Productivity (NPP)", "right": "Rate of organic matter accumulation available to primary consumers after subtracting plant respiration (GPP - Ra)" },
        { "left": "Net Ecosystem Productivity (NEP)", "right": "Net carbon storage rate of an entire ecosystem subtracting both plant and microbial respiration" },
        { "left": "Tropical Rainforest Biome", "right": "Terrestrial ecosystem with the highest average annual Net Primary Productivity (~2,000 g/m²/yr)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the Pyramid of Biomass in open-ocean pelagic marine ecosystems 'inverted' (where the standing biomass of primary consumers/zooplankton is larger than the standing biomass of primary producers/phytoplankton), while the Pyramid of Energy is always strictly upright?",
      "options": [
        { "text": "Phytoplankton have an extremely high turnover rate and rapid cellular division time (hours to days), allowing a very small standing biomass to generate a massive flux of new organic energy over time, which supports a larger standing biomass of slower-growing, long-lived zooplankton and fish; while the energy flux pyramid remains upright because total energy production decreases at each step", "isCorrect": true, "explanation": "Correct! Biomass measures 'standing crop'—the snapshot mass of living organic tissue present at a single instant in time (g/m²). In open oceans, the primary producers are single-celled phytoplankton (diatoms, dinoflagellates). Because phytoplankton reproduce and divide in less than 24 hours, their individual life cycle is extremely brief. They are consumed by zooplankton almost as fast as they are born. Consequently, their snapshot standing biomass is very low (e.g. 4 g/m²), while the standing biomass of longer-lived, larger zooplankton feeding on them is higher (e.g. 21 g/m²), creating an 'inverted' pyramid of biomass. However, if you measure the rate of energy flow over an entire year (Pyramid of Energy in kcal/m²/year), the phytoplankton produce far more total energy than the zooplankton consume. The Energy Pyramid is governed by the Second Law of Thermodynamics and can never be inverted under any circumstances in any ecosystem on Earth." },
        { "text": "Because ocean water has zero gravity that allows zooplankton to grow without eating", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because phytoplankton do not contain carbon atoms", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because fish eat rocks instead of plankton", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In ecological energetics, Net Primary Productivity is calculated as Gross Primary Productivity minus autotrophic ___ (NPP = GPP - Ra).",
      "blankAnswer": "respiration",
      "blankDistractors": ["photosynthesis", "transpiration", "evaporation"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Primary Productivity & Ecological Pyramid Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Primary Productivity & Ecological Pyramid Engine</h3><p>Select Biome Environment:</p><button id=\"terrBtn\" style=\"padding:8px 16px; margin:4px; background:#10b981; color:white; border:none; border-radius:6px; cursor:pointer;\">Terrestrial Forest (Upright Biomass)</button><button id=\"marBtn\" style=\"padding:8px 16px; margin:4px; background:#0891b2; color:white; border:none; border-radius:6px; cursor:pointer;\">Open Ocean (Inverted Biomass)</button><div id=\"pyrOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Select an ecosystem above...</div><script>document.getElementById('terrBtn').onclick=()=>{document.getElementById('pyrOut').innerText='Terrestrial Forest: Trees (10,000 g/m²) -> Deer (100 g/m²) -> Wolves (1 g/m²). UPRIGHT Biomass Pyramid! High standing crop, slow turnover!';}; document.getElementById('marBtn').onclick=()=>{document.getElementById('pyrOut').innerText='Open Ocean: Phytoplankton (4 g/m²) -> Zooplankton (21 g/m²). INVERTED Biomass Pyramid! Microscopic producers turn over in 24 hours, fueling large standing consumer mass!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
