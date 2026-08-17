# Duofy Reusable Lesson Format: Secondary Clarifiers (Solids Flux & SVI Settleability)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Environmental_and_Wastewater_Engineering / Wastewater_Treatment_and_Sewage`  
**Lesson Format Type:** `biological_secondary_clarifier_solids_flux_and_svi`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the final unit operation of the activated sludge process: secondary biological clarification, Type 3 zone/hindered settling of biological flocs, Return Activated Sludge (RAS) recycling ratio ($R = Q_r / Q = \frac{X}{X_r - X}$), **Solids Volume Index (SVI)** settling quality classification ($\text{SVI} = \frac{V_{30} \times 1000}{X}$ in $\text{mL/g}$), Total **Solids Flux Theory ($G_T = G_g + G_u = X \cdot v_i + X \cdot u$)**, Limiting Solids Flux ($G_L$), and secondary clarifier surface area sizing based on hydraulic overflow vs solids flux limits (Metcalf & Eddy *Wastewater Engineering* 5th ed. Chapters 7 & 8; Mackenzie L. Davis *Water and Wastewater Engineering* Chapter 12): formulate the **Sludge Volume Index (SVI) Equation**:
$$\mathbf{\text{SVI} = \frac{V_{30} \cdot 1000}{X} \quad \left[\frac{\text{mL}}{\text{g}}\right]}$$
where:
1. **$V_{30}$:** Settled sludge volume in a $1.0\text{-L}$ graduated cylinder after $30\text{ minutes}$ ($\text{mL/L}$);
2. **$X = \text{MLSS}$:** Mixed liquor suspended solids concentration in $\text{mg/L}$;
master the **SVI Settleability Diagnostics Matrix**:
- **$\text{SVI} < 80\text{ mL/g}$:** Pin-point floc (fast settling, cloudy turbid supernatant);
- **$80 \le \text{SVI} \le 120\text{ mL/g}$:** **Ideal Good Settling Sludge** (clear supernatant, rapid compaction);
- **$\text{SVI} > 150\text{ mL/g}$:** **Filamentous Sludge Bulking** (slow settling, massive solids carryover over effluent weirs);
formulate the **RAS Recycle Mass Balance Ratio ($R$)**:
$$\mathbf{Q \cdot X + Q_r \cdot X = \left( Q + Q_r \right) X = Q_r \cdot X_r \implies \mathbf{R = \frac{Q_r}{Q} = \frac{X}{X_r - X}}}$$
formulate the **Total Solids Loading Rate / Flux ($G_T$)**:
$$\mathbf{G_T = \frac{(Q + Q_r) X}{A_{\text{clarifier}}} \le G_{\text{limiting}} \quad \left[\frac{\text{kg}}{\text{m}^2\cdot\text{day}}\right]}$$
and interact with live First-order BOD kinetic simulator, Streeter-Phelps DO sag curve plotter, Activated sludge aeration tank sizer, and Secondary clarifier solids flux & SVI analyzer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | SVI Equation ($\text{SVI} = \frac{V_{30} \cdot 1000}{X}$), RAS Ratio ($R = \frac{X}{X_r - X}$) & Solids Flux ($G_T$) Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate SVI, RAS Recycle Ratio, and Settleability Classification Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Secondary Clarifier Metric / Operational State & Technical Environmental Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | An Activated Sludge with a Sludge Volume Index Exceeding 150 mL/g Suffers from a Severe Operational Condition Known as Filamentous Sludge ___ (Bulking / Sludge Bulking) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Wastewater Engineering Studio: BOD Kinetics, Streeter-Phelps DO Sag, Aeration Sizing & SVI Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "biological_secondary_clarifier_solids_flux_and_svi",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Sludge Volume Index (SVI), and how is the Return Activated Sludge (RAS) recycle ratio calculated?",
      "blankAnswer": "Secondary Clarification & SVI Mechanics (Metcalf & Eddy): (1) SVI FORMULATION: SVI = (V30 * 1000) / MLSS [mL/g], measuring compaction volume after 30 min settling in a 1L cylinder. (2) SVI CLASSIFICATION: SVI < 80 mL/g = Pin-point floc; 80-120 mL/g = Ideal good settling; SVI > 150 mL/g = Filamentous Bulking (sludge washout disaster!). (3) RAS RECYCLE RATIO: R = Qr / Q = X / (Xr - X), returning concentrated biomass Xr from the clarifier floor back to the aerator. (4) SOLIDS FLUX: Total solids loading G_T = [(Q + Qr)*X] / A_clarifier \u2264 G_limit (\u2248 100-150 kg/m\u00b2\u00b7day) prevents clarifier failure!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to evaluate biological sludge settleability, compute SVI, and determine required RAS recycle flow.",
      "orderItems": [
        "Perform a 30-minute settling test in a 1.0-L settleometer to measure settled sludge volume V30 (in mL/L)",
        "Measure the Mixed Liquor Suspended Solids (MLSS = X in mg/L) of the aeration tank mixed liquor",
        "Calculate the Sludge Volume Index: SVI = (V30 * 1000) / X and classify settleability (e.g. good settling vs bulking)",
        "Measure the secondary clarifier underflow RAS solids concentration Xr (\u2248 10^6 / SVI)",
        "Calculate the required RAS recycle ratio: R = Qr / Q = X / (Xr - X) and set return pump flow rate Qr = R * Q"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Secondary Clarification Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Ideal SVI (80 - 120 mL/g)", "right": "Optimal bio-floc settleability with clear supernatant and dense sludge blanket compaction" },
        { "left": "Filamentous Bulking (SVI > 150)", "right": "Excessive growth of long filamentous bacteria bridging flocs and preventing gravity settling" },
        { "left": "RAS Recycle Ratio (R = X/(Xr-X))", "right": "Fraction of forward wastewater flow returned as concentrated underflow to sustain aeration MLSS" },
        { "left": "Limiting Solids Flux (GL)", "right": "Maximum rate of total solids mass per unit area that can reach the clarifier bottom without blanket rise" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "An activated sludge with a Sludge Volume Index exceeding 150 mL/g suffers from a severe operational settling failure known as filamentous sludge ___.",
      "blankAnswer": "bulking",
      "blankDistractors": ["settling", "foaming", "clarification"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Wastewater Treatment & Sewage Engineering Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Wastewater Engineering & Biological Treatment Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">BOD Kinetics, Streeter-Phelps DO Sag, Activated Sludge & SVI</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnBod\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. BOD Decay (L0 = 292.7mg/L)</button><button id=\"btnSag\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. DO Sag (tc=2.63d, DO_min=3.09)</button><button id=\"btnAs\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Activated Sludge (V=2000m\u00b3) & SVI</button></div><div id=\"wwLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate first-order BOD kinetics...</div><script>document.getElementById('btnBod').onclick=()=>{document.getElementById('wwLog').innerHTML='<b>1. FIRST-ORDER BOD KINETICS:</b><br>• BOD_t = L0*(1 - e^-kt)<br>• BOD5 = 200 mg/L (k = 0.23 day\u207b\u00b9) &rarr; <b style=\"color:#10b981;\">Ultimate L0 = 292.7 mg/L!</b><br>• Exerted BOD10 = 263.3 mg/L';}; document.getElementById('btnSag').onclick=()=>{document.getElementById('wwLog').innerHTML='<b>2. STREETER-PHELPS DO SAG CURVE:</b><br>• Balance: kd*L(tc) = kr*Dc (Critical rate equality)<br>• Critical Time: tc = <b style=\"color:#10b981;\">2.63 days!</b><br>• <b style=\"color:#ef4444;\">Minimum DO = DO_sat - Dc = 3.09 mg/L (Fish kill warning)!</b>';}; document.getElementById('btnAs').onclick=()=>{document.getElementById('wwLog').innerHTML='<b>3. ACTIVATED SLUDGE \\& SVI SETTLEABILITY:</b><br>• Aeration Volume: V = Q*S0 / [X*(F/M)] = <b style=\"color:#10b981;\">2000 m\u00b3!</b><br>• Sludge Wasting: Qw = 60 m\u00b3/d (\\u03b8c = 10 days)<br>• SVI = (V30*1000)/X = 100 mL/g &rarr; <b style=\"color:#38bdf8;\">Ideal Settling!</b><br>• RAS Ratio: R = X / (Xr - X) = 3000 / (10000 - 3000) = 0.43<br>🏆 <b style=\"color:#10b981;\">Wastewater_Treatment_and_Sewage 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
