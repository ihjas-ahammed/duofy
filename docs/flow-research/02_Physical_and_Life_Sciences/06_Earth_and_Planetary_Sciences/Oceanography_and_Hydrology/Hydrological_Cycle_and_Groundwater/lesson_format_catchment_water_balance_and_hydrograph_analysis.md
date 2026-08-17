# Duofy Reusable Lesson Format: Catchment Water Balance and Hydrograph Analysis

**Target Topic:** `02_Physical_and_Life_Sciences / 06_Earth_and_Planetary_Sciences / Oceanography_and_Hydrology / Hydrological_Cycle_and_Groundwater`  
**Lesson Format Type:** `catchment_water_balance_and_hydrograph_analysis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid hydrological, catchment-scale, and flood-engineering mastery of basin water budgets and streamflow hydrographs (Robert E. Horton 1933; LeRoy K. Sherman 1932; Thomas Dunne): formulate the **Catchment Water Balance Equation ($P = ET + Q + \Delta S$)**, contrast **Hortonian Infiltration-Excess Overland Flow** (rainfall intensity exceeding soil infiltration capacity $i > f_p$) with **Dunne Saturation-Excess Overland Flow** (rising water table saturating soil column from below), master **Stream Hydrograph Deconstruction** (**Baseflow** [sustained groundwater seepage] vs **Direct Storm Runoff / Quickflow**, **Rising Limb, Peak Discharge [$Q_p$], Lag Time [$t_L$], and Recession Limb**), and interact with live catchment water budget and unit hydrograph flood simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Water Balance & Flood Hydrograph Deconstruction Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Hydrograph Component / Runoff Mechanism & Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Urbanization Impact on Peak Discharge and Lag Time Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Sustained Groundwater Contribution to Stream Discharge Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Catchment Water Balance & Storm Hydrograph Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "catchment_water_balance_and_hydrograph_analysis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Catchment Water Balance Equation and how is a storm Hydrograph decomposed?",
      "blankAnswer": "Catchment hydrology combines conservation of mass with drainage basin dynamics (Horton 1933; Sherman 1932): (1) THE CATCHMENT WATER BALANCE EQUATION: P = ET + Q + Delta S (Precipitation = Evapotranspiration + Stream Runoff Discharge + Change in Storage [soil moisture and groundwater]). Over multi-year timescales, Delta S ≈ 0. (2) RUNOFF GENERATION MECHANISMS: (a) Hortonian Infiltration-Excess: When rainfall rate exceeds soil infiltration capacity (i > f_p), common in arid soils and urban pavement. (b) Dunne Saturation-Excess: When the water table rises to intercept the ground surface, common in humid valley bottoms. (3) HYDROGRAPH DECONSTRUCTION: A plot of stream discharge Q (m³/s) vs time t: (a) Baseflow: Sustained, slow drainage of groundwater into the river channel. (b) Rising Limb: Rapid influx of direct surface runoff. (c) Peak Discharge (Q_p): Maximum storm flow rate. (d) Lag Time (t_L): Time interval between peak rainfall intensity and peak river discharge. (e) Recession Limb: Slow logarithmic drainage of bank storage and delayed subsurface flow!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each catchment hydrograph term to its exact hydrological definition.",
      "matchPairs": [
        { "left": "Baseflow", "right": "Sustained dry-weather stream discharge supplied exclusively by slow groundwater seepage" },
        { "left": "Peak Discharge (Q_p)", "right": "Maximum instantaneous volume flow rate of water passing a river gauging station during a flood" },
        { "left": "Lag Time (t_L)", "right": "Time delay between the center of mass of rainfall hyetograph and peak streamflow discharge" },
        { "left": "Hortonian Overland Flow", "right": "Surface runoff occurring when rainfall precipitation intensity exceeds soil infiltration capacity" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "When a natural forested drainage basin is converted into a paved suburban city (urbanization with 50% impermeable asphalt and concrete), how does the storm hydrograph change for the same heavy 2-inch rainfall event?",
      "options": [
        { "text": "The Peak Discharge (Q_p) increases dramatically (often 2 to 5 times higher) and the Lag Time (t_L) shortens significantly, producing an aggressive 'flashy' flood hydrograph due to loss of soil infiltration and rapid routing through storm sewers", "isCorrect": true, "explanation": "Correct! In a natural forested catchment, dense vegetation intercepts rainfall, deep organic soils provide high infiltration capacity (f_p > i), and water travels slowly as subsurface interflow or groundwater recharge. This dampens the storm hydrograph, producing a low, broad peak discharge with a long lag time (t_L of many hours or days). Urbanization replaces permeable soils with impermeable asphalt, roofs, and concrete. Infiltration drops to near zero, forcing almost 100% of the rainfall into immediate Hortonian surface overland flow. Furthermore, artificial storm sewer networks and concrete culverts transport water frictionlessly into rivers. Consequently, the urban hydrograph becomes extremely 'flashy'—the lag time shrinks dramatically, and the peak discharge spikes to catastrophic heights in minutes, generating severe flash floods." },
        { "text": "The river discharge drops to zero because asphalt absorbs all water", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Lag time increases to several months", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The river turns into an underground glacier", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The sustained, long-term portion of stream discharge supplied continuously by subterranean groundwater seepage during dry weather is called ___.",
      "blankAnswer": "baseflow",
      "blankDistractors": ["quickflow", "evapotranspiration", "overland"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Catchment Water Balance & Hydrograph Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Catchment Water Budget & Storm Hydrograph Engine</h3><p>Storm: $50\\text{ mm}$ Rain in 2 Hours | Basin Area: $100\\text{ km}^2$</p><button id=\"forBtn\" style=\"padding:8px 16px; margin:4px; background:#10b981; color:white; border:none; border-radius:6px; cursor:pointer;\">Forested Catchment (Natural Soil)</button><button id=\"urbBtn\" style=\"padding:8px 16px; margin:4px; background:#ef4444; color:white; border:none; border-radius:6px; cursor:pointer;\">Urbanized Catchment (50% Impervious)</button><div id=\"hydOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Select basin land cover above...</div><script>document.getElementById('forBtn').onclick=()=>{document.getElementById('hydOut').innerText='Forested Basin: Infiltration = 80% -> High Baseflow -> Peak Discharge Q_p = 45 m3/s -> Lag Time = 8.5 Hours! Smooth, attenuated hydrograph!';}; document.getElementById('urbBtn').onclick=()=>{document.getElementById('hydOut').innerText='Urbanized Basin: Infiltration = 10% -> 90% Surface Runoff -> Peak Discharge Q_p = 190 m3/s (4.2x higher!) -> Lag Time = 1.5 Hours! FLASH FLOOD HAZARD!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
