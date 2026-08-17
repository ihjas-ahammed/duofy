# Duofy Reusable Lesson Format: Real Columns (Murphree Tray Efficiency & Actual Stages)

**Target Topic:** `04_Engineering_and_Technology / 04_Chemical_Engineering / Heat_and_Mass_Transfer_Operations / Distillation_Columns_McCabe_Thiele`  
**Lesson Format Type:** `murphree_tray_efficiency_and_actual_stage_counting`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the transition from idealized equilibrium stages to real industrial distillation trays, E. V. Murphree's 1925 **Murphree Vapor Tray Efficiency ($E_{MV}$)**, overall column efficiency ($E_o = N_{\text{theoretical}} / N_{\text{actual}} \approx 0.60 - 0.85$), pseudo-equilibrium curve construction for graphical step-offs, vapor weeping, flooding, entrainment constraints, and sizing actual physical column height ($H_{\text{column}} = (N_{\text{actual}} - 1) \cdot S_{\text{tray}} + H_{\text{sump}} + H_{\text{disengaging}}$) (Warren L. McCabe *Unit Operations of Chemical Engineering* Chapter 21; Robert E. Treybal *Mass-Transfer Operations* Chapter 9; E. V. Murphree 1925): formulate the **Murphree Vapor Tray Efficiency ($E_{MV}$) Master Formulation**:
$$\mathbf{E_{MV} = \frac{y_n - y_{n+1}}{y_n^* - y_{n+1}} = \frac{\text{Actual Vapor Enrichment on Tray } n}{\text{Ideal Thermodynamic Vapor Enrichment}}}$$
where:
1. **$y_n$:** Actual mole fraction of vapor leaving tray $n$;
2. **$y_{n+1}$:** Actual mole fraction of vapor entering tray $n$ from the tray below;
3. **$y_n^*$:** Theoretical equilibrium vapor composition in equilibrium with liquid leaving tray $n$ ($x_n$);
derive the **Actual Vapor Composition Leaving Tray $n$**:
$$\mathbf{y_n = y_{n+1} + E_{MV} \left( y_n^* - y_{n+1} \right)}$$
formulate the **Overall Column Efficiency ($E_o$) & Physical Height ($H_{\text{column}}$)**:
$$\mathbf{N_{\text{actual}} = \frac{N_{\text{theoretical}}}{E_o} \quad \Big| \quad \mathbf{H_{\text{column}} = \left( N_{\text{actual}} - 1 \right) \cdot S_{\text{tray}} + H_{\text{headspace}}}}$$
(where standard tray spacing $S_{\text{tray}} \approx 0.45 - 0.60\text{ m} \ (18 - 24\text{ inches})$), and interact with live McCabe-Thiele operating line plotter, Fenske minimum stages calculator, Minimum reflux pinch solver, and Murphree tray efficiency step-off studio widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Murphree Efficiency ($E_{MV} = \frac{y_n - y_{n+1}}{y_n^* - y_{n+1}}$), $E_o = \frac{N_{\text{theo}}}{N_{\text{act}}}$ & Tray Spacing Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Construct Pseudo-Equilibrium Curves and Determine Actual Column Trays Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Distillation Efficiency Parameter / Column Geometry & Technical Physical Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Murphree Vapor Tray Efficiency $E_{MV}$ Is Defined as the Actual Vapor Concentration Change $(y_n - y_{n+1})$ Divided by $(y_n^* - \text{___})$ (y_{n+1} / Entering Vapor y_n+1) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Chemical Distillation Studio: McCabe-Thiele Lines, Fenske Stages, Pinch Points & Murphree Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "murphree_tray_efficiency_and_actual_stage_counting",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Murphree tray efficiency (EMV), and how does it determine the actual number of trays in a distillation column?",
      "blankAnswer": "Murphree Tray Efficiency Mechanics (E. V. Murphree 1925): (1) EMV FORMULATION: EMV = (yn - yn+1) / (yn* - yn+1), ratio of actual vapor phase enrichment on tray n to theoretical maximum equilibrium enrichment. (2) ACTUAL LEAVING VAPOR: yn = yn+1 + EMV*(yn* - yn+1). (3) OVERALL EFFICIENCY: Eo = N_theoretical / N_actual (\u2248 0.60 - 0.85 for sieve/valve trays). (4) ACTUAL COLUMN HEIGHT: H_column = (N_actual - 1)*S_tray + H_sump, where standard tray spacing S_tray = 0.45 - 0.60 m (18-24 in) ensures vapor disengagement without liquid entrainment!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to step off actual trays on a McCabe-Thiele diagram using a Murphree vapor tray efficiency.",
      "orderItems": [
        "Construct the standard ROL, SOL, and q-line operating lines on the McCabe-Thiele diagram",
        "Plot the pseudo-equilibrium curve by adjusting the vertical distance from the operating line to the VLE curve by factor EMV",
        "Step off actual stages starting from (xD, xD) using the pseudo-equilibrium curve instead of the ideal VLE line",
        "Count the total number of actual stages N_actual and identify the actual feed tray location",
        "Subtract 1 stage for a partial reboiler and multiply remaining trays by tray spacing S_tray to calculate column shell height"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Distillation Efficiency Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Murphree Vapor Efficiency (EMV)", "right": "EMV = (yn - yn+1)/(yn* - yn+1), fractional approach of vapor to true thermodynamic equilibrium on a single tray" },
        { "left": "Overall Column Efficiency (Eo)", "right": "Eo = N_theoretical / N_actual, empirical ratio of ideal stages to actual physical trays installed in shell" },
        { "left": "Pseudo-Equilibrium Curve", "right": "Modified curve constructed at fractional height EMV between operating line and true VLE curve for stepping" },
        { "left": "Tray Spacing (S_tray \u2248 0.5m)", "right": "Physical vertical distance between successive perforated trays preventing froth entrainment into upper stages" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Murphree vapor tray efficiency EMV is defined as the actual vapor concentration change (yn - yn+1) divided by (yn* - ___).",
      "blankAnswer": "y_{n+1}",
      "blankDistractors": ["x_n", "y_n", "x_D"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Chemical Distillation Engineering Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Distillation Columns & McCabe-Thiele Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">McCabe-Thiele Lines, Fenske Stages, Rmin Pinch & Murphree Trays</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnMc\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. McCabe-Thiele (ROL y=0.67x+0.30)</button><button id=\"btnFen\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Fenske Equation (N_min = 6.43)</button><button id=\"btnPin\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Pinch Rmin=1.0 & Murphree EMV</button></div><div id=\"distLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate McCabe-Thiele operating lines...</div><script>document.getElementById('btnMc').onclick=()=>{document.getElementById('distLog').innerHTML='<b>1. MCCABE-THIELE OPERATING LINES:</b><br>• ROL: y = [R/(R+1)]*x + xD/(R+1) = <b style=\"color:#10b981;\">0.667*x + 0.300!</b><br>• Saturated Liquid Feed (q = 1.0) &rarr; Vertical line at x = 0.40<br>• <b style=\"color:#38bdf8;\">Intersection Point: (xi, yi) = (0.400, 0.567)!</b>';}; document.getElementById('btnFen').onclick=()=>{document.getElementById('distLog').innerHTML='<b>2. FENSKE TOTAL REFLUX MINIMUM STAGES:</b><br>• S = [xD/(1-xD)] * [(1-xB)/xB] = 19.0 * 19.0 = 361.0<br>• N_min = ln(361.0) / ln(2.50) = <b style=\"color:#10b981;\">6.43 Theoretical Stages!</b><br>• Minimum Trays: N_trays = 6.43 - 1 = 5.43 trays';}; document.getElementById('btnPin').onclick=()=>{document.getElementById('distLog').innerHTML='<b>3. PINCH POINT \\& MURPHREE EFFICIENCY:</b><br>• Pinch (xp=0.40, yp=0.65) &rarr; <b style=\"color:#10b981;\">Rmin = (xD-yp)/(yp-xp) = 1.000!</b><br>• Design Reflux: R = 1.30 * Rmin = 1.300<br>• Murphree: EMV = (yn - yn+1)/(yn* - yn+1) = 0.75 &rarr; <b style=\"color:#38bdf8;\">Actual Trays = N_theo / 0.75!</b><br>🏆 <b style=\"color:#10b981;\">Heat_and_Mass_Transfer_Operations 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
