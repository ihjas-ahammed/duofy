# Duofy Reusable Lesson Format: Field Compaction (Relative Compaction & Rollers)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Geotechnical_Engineering_and_Soil_Mechanics / Soil_Classification_and_Compaction`  
**Lesson Format Type:** `field_compaction_relative_compaction_and_roller_mechanics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify field geotechnical compaction methods, equipment selection based on soil grain size and cohesion (Smooth Drum Rollers, Pneumatic Rubber-Tired Rollers, Sheepsfoot / Tamping Foot Rollers, and Vibratory Compactors), in-situ density verification methods (Sand Cone Method ASTM D1556, Rubber Balloon ASTM D2167, and Nuclear Density Gauge ASTM D6938), and quality control enforcement via **Relative Compaction ($RC$)** specifications (Braja M. Das *Principles of Geotechnical Engineering* 9th ed. Chapter 6; Karl Terzaghi *Soil Mechanics in Engineering Practice* Chapter 6): formulate the **Relative Compaction Specification Equation ($RC$)**:
$$\mathbf{RC = \frac{\gamma_{d,\text{field}}}{\gamma_{d,\text{max,lab}}} \times 100\% \ge 95\% \quad (\text{Typically } 90\% - 98\% \text{ per project specs})}$$
master the **Field Equipment Selection Matrix**:
1. **Sheepsfoot / Tamping Foot Rollers:** Kneading action under high contact pressure ($1400 - 7000\text{ kPa}$), ideal for cohesive **Clays ($CL, CH$)** and plastic silts;
2. **Smooth Drum Vibratory Rollers:** Dynamic excitation liquefies pore contacts, ideal for granular cohesionless **Sands ($SW, SP$) and Gravels ($GW, GP$)**;
3. **Pneumatic Rubber-Tired Rollers:** Both kneading and pressure action, versatile for base courses and mixed soils;
master the **Sand Cone Method Formulation**:
$$\mathbf{V_{\text{hole}} = \frac{W_{\text{sand,used}} - W_{\text{cone}}}{\gamma_{\text{sand}}} \implies \mathbf{\gamma_{\text{field}} = \frac{W_{\text{soil,excavated}}}{V_{\text{hole}}}} \implies \mathbf{\gamma_{d,\text{field}} = \frac{\gamma_{\text{field}}}{1 + w}}}$$
and interact with live Soil phase relationships calculator, USCS gradation and Casagrande chart classifier, Proctor compaction & ZAV curve generator, and Field relative compaction explorer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Relative Compaction ($RC = \frac{\gamma_{d,\text{field}}}{\gamma_{d,\text{lab}}} \times 100 \ge 95\%$), Roller Types & Sand Cone Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Perform a Sand Cone Test and Verify Field Relative Compaction Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Compactor Roller Type / Testing Instrument & Technical Geotechnical Application Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Ratio of the Field In-Situ Dry Unit Weight to the Maximum Laboratory Dry Density Expressed as a Percentage Is Called Relative ___ (Compaction) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Geotechnical Mechanics Studio: Phase Relationships, USCS, Proctor & Field Compaction Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "field_compaction_relative_compaction_and_roller_mechanics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Relative Compaction (RC), and which compaction equipment is best suited for clay soils versus sandy soils?",
      "blankAnswer": "Field Compaction & QA (Braja M. Das): (1) RELATIVE COMPACTION: RC = (\u03b3d,field / \u03b3d,max,lab) * 100% (specifications typically mandate RC \u2265 95% within \u00b12% of OMC). (2) SHEEPSFOOT ROLLER: Best for cohesive CLAYS (kneading compaction under protruding lugs). (3) VIBRATORY ROLLER: Best for non-cohesive SANDS & GRAVELS (vibration rearranges granular particles into dense packing). (4) SAND CONE TEST: Measures test hole volume: V_hole = W_sand / \u03b3sand \u2192 \u03b3d,field = [W_soil / V_hole] / (1 + w)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine field in-situ dry density and verify relative compaction using the Sand Cone Method.",
      "orderItems": [
        "Excavate a small test hole in the compacted fill layer and collect all moist excavated soil into an airtight container",
        "Weigh the moist excavated soil and determine its field moisture content w via rapid moisture meter or laboratory oven",
        "Invert the sand cone apparatus filled with calibrated Ottawa sand over the hole and open the valve to fill the cavity",
        "Weigh remaining sand to compute hole volume: V_hole = (W_sand,used - W_cone) / \u03b3sand and field wet density: \u03b3 = W_soil / V_hole",
        "Compute field dry density: \u03b3d,field = \u03b3 / (1 + w) and verify Relative Compaction: RC = (\u03b3d,field / \u03b3d,max,lab) * 100% \u2265 95%"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Field Compaction Device to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Sheepsfoot / Tamping Roller", "right": "Kneading compaction mechanism with projecting steel feet designed for cohesive clay soils" },
        { "left": "Vibratory Smooth Drum", "right": "Dynamic vibratory impact compactor ideal for densifying clean sands, gravels, and rockfills" },
        { "left": "Sand Cone Apparatus", "right": "Direct displacement test using uniform Ottawa sand to measure excavated in-situ hole volume" },
        { "left": "Nuclear Density Gauge", "right": "Gamma ray transmission device providing rapid non-destructive in-situ density and moisture readings" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The ratio of field in-situ dry unit weight to maximum laboratory dry density expressed as a percentage is called relative ___.",
      "blankAnswer": "compaction",
      "blankDistractors": ["density", "saturation", "porosity"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Geotechnical Mechanics & Compaction Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Geotechnical Mechanics & Compaction Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Phase Relations, USCS, Proctor Curves & Field RC</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnPhase\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Soil Phase (S*e=w*Gs, \u03b3d=16.0kN/m\u00b3)</button><button id=\"btnUscs\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. USCS Casagrande (CH Clay)</button><button id=\"btnComp\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Proctor ZAV & Field RC (RC \u2265 95%)</button></div><div id=\"geoLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate soil phase relationships...</div><script>document.getElementById('btnPhase').onclick=()=>{document.getElementById('geoLog').innerHTML='<b>1. SOIL PHASE RELATIONSHIPS:</b><br>• Master Identity: S*e = w*Gs<br>• \\u03b3d = \\u03b3 / (1+w) = 19.20 / 1.20 = <b style=\"color:#10b981;\">16.00 kN/m\u00b3!</b><br>• Void ratio: e = (Gs*\\u03b3w/\\u03b3d) - 1 = <b style=\"color:#38bdf8;\">0.655!</b><br>• Saturated: \\u03b3sat = 19.88 kN/m\u00b3!';}; document.getElementById('btnUscs').onclick=()=>{document.getElementById('geoLog').innerHTML='<b>2. USCS \\& CASAGRANDE PLASTICITY:</b><br>• LL = 55%, PL = 22% &rarr; PI = 33%<br>• A-Line: PI_A-Line = 0.73*(55 - 20) = 25.55%<br>• <b style=\"color:#10b981;\">Since PI=33% > 25.55% & LL &ge; 50% &rarr; CH (Fat Clay)!</b>';}; document.getElementById('btnComp').onclick=()=>{document.getElementById('geoLog').innerHTML='<b>3. PROCTOR COMPACTION \\& FIELD QC:</b><br>• ZAV Curve: \\u03b3zav = Gs*\\u03b3w / (1 + w*Gs) = <b style=\"color:#10b981;\">18.75 kN/m\u00b3</b><br>• Modified Proctor: Energy 4.55x &rarr; MDD&uarr;, OMC&darr;<br>• Sheepsfoot (Clays) vs Vibratory (Sands)<br>• Quality Control: <b style=\"color:#38bdf8;\">RC = (\\u03b3d,field / \\u03b3d,lab)*100% &ge; 95%!</b><br>🏆 <b style=\"color:#10b981;\">Soil_Classification_and_Compaction 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
