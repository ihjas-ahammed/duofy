# Duofy Reusable Lesson Format: Structural Welds (Fillet Throat & Electrode Strength)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Reinforced_Concrete_and_Steel_Design / Steel_Connections_Beams_and_Columns`  
**Lesson Format Type:** `structural_fillet_weld_design_and_effective_throat_mechanics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the design and mechanics of structural steel welded connections per AISC 360-16 Chapter J, focusing on equal-leg fillet welds, the geometry of the $45^\circ$ **Effective Throat Thickness ($t_e = w \cos(45^\circ) = 0.707 w$)**, the shear strength of weld filler metal ($F_{nw} = 0.60 F_{EXX}$ for E70XX electrodes), minimum and maximum weld sizes based on plate thicknesses ($w_{\text{min}}$ and $w_{\text{max}} = t_{\text{plate}} - 1.5\text{ mm}$), and the design shear capacity of longitudinal and transverse fillet weld groups (William T. Segui *Steel Design* 6th ed. Chapter 8; AISC 360-16 Section J2): formulate the **Effective Throat Thickness Formulation**:
$$\mathbf{t_e = w \cdot \cos(45^\circ) = \frac{\sqrt{2}}{2} w \approx \mathbf{0.707 \cdot w} \quad (w = \text{Nominal Fillet Weld Leg Size})}$$
derive the **Design Fillet Weld Shear Capacity per Unit Length ($q_{\text{weld}}$)**:
$$\mathbf{\phi R_n = \phi \cdot F_{nw} \cdot A_{we} = \phi \left( 0.60 \cdot F_{EXX} \right) \left( 0.707 \cdot w \cdot L_{\text{weld}} \right) \quad (\text{Resistance Factor } \phi = 0.75)}$$
$$\mathbf{\text{For E70XX Electrode } (F_{EXX} = 70\text{ ksi} \approx 482.6\text{ MPa}):}$$
$$\mathbf{q_{\text{weld}} = \frac{\phi R_n}{L} = 0.75 \times (0.60 \times 482.6\text{ MPa}) \times (0.707 \cdot w) = \mathbf{153.5 \cdot w \ [\text{N/mm per mm of weld leg}]}}$$
$$\mathbf{q_{\text{weld,US}} = 0.75 \times (0.60 \times 70\text{ ksi}) \times \left(0.707 \cdot \frac{1}{16}\right) = \mathbf{1.392\text{ kips/in per sixteenth-inch leg}}}$$
(proving that because fillet welds always fail in shear along the narrowest $45^\circ$ throat plane regardless of the direction of applied tension or compression, weld design is universally governed by pure shear mechanics); and interact with live AISC column buckling calculator, Steel beam LTB evaluator, High-strength bolt capacity checker, and Fillet weld throat sizing widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fillet Throat ($t_e = 0.707 w$), Weld Shear ($0.60 F_{EXX}$) & Unit Capacity ($1.392\text{ kips/in/16th}$) Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Size Fillet Weld Leg w and Total Length L for a Tension Lap Splice Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Welded Connection Parameter / Term & Technical Structural Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Effective Throat Thickness $t_e$ of an Equal-Leg Fillet Weld of Leg Size $w$ Equals Exactly ___ Times $w$ (0.707 / Point Seven Zero Seven) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Structural Steel Mechanics Studio: AISC Columns, Beam LTB, Bolts & Fillet Welds Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "structural_fillet_weld_design_and_effective_throat_mechanics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Effective Throat Thickness of a fillet weld, and how is its design shear capacity calculated per AISC 360-16?",
      "blankAnswer": "Fillet Weld Design (William Segui; AISC 360-16): (1) EFFECTIVE THROAT: te = 0.707 * w (the shortest distance from root to theoretical weld face along 45\u00b0 plane). (2) WELD SHEAR STRENGTH: Fnw = 0.60 * FEXX (60% of electrode tensile rating; e.g. 0.60*70 = 42 ksi for E70). (3) DESIGN CAPACITY: \u03c6Rn = \u03c6 * Fnw * te * L = 0.75 * (0.60*FEXX) * (0.707*w*L). (4) UNIT STRENGTH: E70 provides 1.392 kips/in per 1/16-inch leg (or 153.5 N/mm per mm leg)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design an equal-leg fillet weld group connecting a steel tension plate.",
      "orderItems": [
        "Determine the minimum weld size (w_min based on thicker plate) and maximum weld size (w_max = t_plate - 1.5 mm for edges \u2265 6mm)",
        "Select a nominal fillet weld leg size w within the valid range (w_min \u2264 w \u2264 w_max)",
        "Compute the effective throat thickness: te = 0.707 * w across the 45\u00b0 shear failure plane",
        "Calculate the design shear strength per unit length: q_weld = \u03c6 * 0.60 * FEXX * 0.707 * w (\u03c6 = 0.75)",
        "Divide the total factored tensile load Pu by q_weld to determine the total required length of longitudinal fillet weld: L = Pu / q_weld"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Fillet Weld Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Effective Throat (0.707*w)", "right": "Shortest distance from root of joint to hypotenuse face forming the critical shear failure plane" },
        { "left": "Electrode Strength (0.60*FEXX)", "right": "Nominal shear capacity of deposited weld metal taken as 60% of specified tensile strength" },
        { "left": "Maximum Weld Size Rule", "right": "w_max = t - 1.5 mm (1/16 in) for plate edges \u2265 6 mm to preserve the top edge corner for inspection" },
        { "left": "Weld Resistance Factor (\u03c6 = 0.75)", "right": "AISC safety reduction factor applied to weld metal shear limit states" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The effective throat thickness of an equal-leg 45-degree fillet weld of leg size w equals exactly ___ times w.",
      "blankAnswer": "0.707",
      "blankDistractors": ["0.866", "0.500", "1.000"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Structural Steel Design Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Structural Steel Design Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">AISC Columns, Beam LTB, Bolts & Fillet Welds</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnCol\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. AISC Column Buckling (\u03c6cPn = 2190kN)</button><button id=\"btnLtb\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Beam Inelastic LTB (\u03c6bMn = 306ft-kips)</button><button id=\"btnConn\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Bolts (87.7kN) & Welds (0.707w)</button></div><div id=\"steelLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate AISC column buckling...</div><script>document.getElementById('btnCol').onclick=()=>{document.getElementById('steelLog').innerHTML='<b>1. AISC COLUMN BUCKLING (INELASTIC):</b><br>• KL/r = 70 &le; 112.6 &rarr; Inelastic Buckling!<br>• Fcr = [0.658^(Fy/Fe)] * Fy = 243.4 MPa<br>• <b style=\"color:#10b981;\">Design Compressive Capacity: \\u03c6cPn = 2190.3 kN!</b>';}; document.getElementById('btnLtb').onclick=()=>{document.getElementById('steelLog').innerHTML='<b>2. STEEL BEAM LATERAL-TORSIONAL BUCKLING:</b><br>• Zone 2 (Lp < Lb &le; Lr) &rarr; Inelastic LTB<br>• Mn = Cb*[Mp - (Mp-0.7FySx)*((Lb-Lp)/(Lr-Lp))] = 340.1 ft-kips<br>• <b style=\"color:#38bdf8;\">Design Flexural Strength: \\u03c6bMn = 306.1 ft-kips!</b>';}; document.getElementById('btnConn').onclick=()=>{document.getElementById('steelLog').innerHTML='<b>3. BOLTS \\& FILLET WELDS:</b><br>• Bolt Shear: \\u03c6Rn = 0.75*Fnv*Ab = <b style=\"color:#10b981;\">87.7 kN!</b><br>• Fillet Throat: te = 0.707*w (45\u00b0 shear plane)<br>• Weld Capacity: \\u03c6Rn = 0.75*(0.60*FEXX)*(0.707*w*L)<br>🏆 <b style=\"color:#10b981;\">Reinforced_Concrete_and_Steel_Design 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
