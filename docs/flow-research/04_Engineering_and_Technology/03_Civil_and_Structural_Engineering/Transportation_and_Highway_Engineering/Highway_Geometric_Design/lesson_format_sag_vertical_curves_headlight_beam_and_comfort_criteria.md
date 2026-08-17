# Duofy Reusable Lesson Format: Sag Vertical Curves (Headlight Beams & Rider Comfort)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Transportation_and_Highway_Engineering / Highway_Geometric_Design`  
**Lesson Format Type:** `sag_vertical_curves_headlight_beam_and_comfort_criteria`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the design of **Sag Vertical Curves** where a downgrade transitions into an upgrade ($G_1 < G_2$ or dip valley), analyzing the four distinct engineering design criteria ((1) **Nighttime Headlight Sight Distance** with headlight height $h_h = 0.60\text{ m}$ and upward divergence angle $\alpha = 1.0^\circ$, (2) **Rider Vertical Comfort / Centrifugal Acceleration** $a_v \le 0.30\text{ m/s}^2 \approx 1.0\text{ ft/s}^2$, (3) **Underpass Overhead Clearance / Sight Distance**, and (4) **General Drainage Requirements** $K \le 51$), the design curve length equations for $S \le L$, and sag $K$-values ($K_{\text{sag}} = L / A$) (AASHTO Green Book 7th ed. Chapter 3; Fred L. Mannering *Principles of Highway Engineering and Traffic Analysis* Chapter 3): formulate the **AASHTO Sag Curve Headlight Sight Distance Formulation ($S \le L$)**:
$$\mathbf{L = \frac{A \cdot S^2}{200 \left( h_h + S \tan\alpha \right)} = \frac{A \cdot S^2}{200 \left( 0.60 + S \tan(1.0^\circ) \right)} = \mathbf{\frac{A \cdot S^2}{120 + 3.5 S}}}$$
where:
1. **$L$:** Length of the sag vertical curve in meters;
2. **$A = |G_2 - G_1|$:** Algebraic difference in grades in percent;
3. **$S$:** Required Stopping Sight Distance ($d_{\text{SSD}}$) in meters;
4. **$K_{\text{sag}}$:** Design rate of vertical curvature for sag curves:
   $$\mathbf{K_{\text{sag}} = \frac{S^2}{120 + 3.5 S} \implies \mathbf{L = K_{\text{sag}} \cdot A}}$$
formulate the **Passenger Comfort Criterion Formulation**:
$$\mathbf{L_{\text{comfort}} = \frac{A \cdot V^2}{395} \quad \left(a_{\text{centrifugal}} = \frac{v^2}{R} \le 0.30\text{ m/s}^2\right)}$$
formulate the **Low Point Station Equation ($\frac{dy}{dx} = 0$)**:
$$\mathbf{x_{\text{low}} = \frac{|G_1| \cdot L}{A} = \mathbf{K \cdot |G_1|} \quad (\text{Station for Catch Basin / Storm Drain Placement})}$$
and interact with live Stopping sight distance calculator, Superelevation & spiral radius optimizer, Crest curve sightline tracer, and Sag curve headlight beam & comfort inspector widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Sag Curve Headlight Equation ($L = \frac{A S^2}{120 + 3.5S}$), Comfort ($L = \frac{A V^2}{395}$) & Low Point Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Size a Sag Vertical Curve for Headlight Sight Distance and Locate Low Point Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Sag Curve Design Criterion / Geometric Property & Technical Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In AASHTO Sag Vertical Curve Design, Headlights Are Modeled with a Centerline Height of 0.60 m and an Upward Beam Divergence Angle of Exactly ___ Degree (1 / 1.0 / One) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Highway Geometric Alignment Studio: SSD, Superelevation, Crest & Sag Curves Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "sag_vertical_curves_headlight_beam_and_comfort_criteria",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How are Sag Vertical Curves designed, and what is the Headlight Sight Distance formula?",
      "blankAnswer": "Sag Vertical Curves (AASHTO Green Book): (1) HEADLIGHT SIGHT DISTANCE (S \u2264 L): L = (A * S^2) / (120 + 3.5*S), derived from headlight height hh = 0.60m and 1.0\u00b0 upward beam spread angle \u03b1. (2) RATE OF CURVATURE: K_sag = S^2 / (120 + 3.5*S). (3) COMFORT CRITERION: L_comfort = (A * V^2) / 395, limiting vertical centrifugal acceleration to \u2264 0.30 m/s^2. (4) LOW POINT: x_low = K * |G1|, pinpointing the exact station where storm sewer catch basins must be installed!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design a sag vertical curve and determine the catch basin drainage location.",
      "orderItems": [
        "Determine highway design speed V and required Stopping Sight Distance S (d_SSD)",
        "Calculate the algebraic grade difference: A = |G2 - G1| where G1 is downgrade and G2 is upgrade",
        "Calculate the required sag K-value: K_sag = S^2 / (120 + 3.5*S)",
        "Compute the minimum curve length: L = K_sag * A and verify that L \u2265 S",
        "Locate the low point station from the PVC: x_low = K_sag * |G1| to position roadway storm drainage inlets"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Sag Vertical Curve Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Headlight Sight Criterion", "right": "L = A*S^2 / (120 + 3.5S), governing nighttime sight distance when upper terrain does not illuminate roadway" },
        { "left": "Rider Comfort Criterion", "right": "L = A*V^2 / 395, preventing excessive downward g-forces during valley curve transitions" },
        { "left": "Upward Beam Divergence (1.0\u00b0)", "right": "AASHTO standard spreading angle of vehicle headlight illumination cone above horizontal" },
        { "left": "Sag Low Point (x = K*|G1|)", "right": "Lowest elevation point on the sag parabola where gutter water ponds and storm inlets are installed" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In AASHTO sag vertical curve design, headlights are modeled with a centerline height of 0.60 m and an upward beam divergence angle of exactly ___ degree.",
      "blankAnswer": "1.0",
      "blankDistractors": ["2.0", "0.5", "5.0"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Highway Geometric Alignment Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Highway Geometric Alignment Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Stopping Sight Distance, Superelevation, Crest & Sag Curves</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnSsd\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. AASHTO SSD (100km/h: 192.5m)</button><button id=\"btnSuper\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Superelevation (R_min = 560.4m)</button><button id=\"btnVert\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Crest (L=260m) & Sag Curves (K=45)</button></div><div id=\"geomLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate Stopping Sight Distance...</div><script>document.getElementById('btnSsd').onclick=()=>{document.getElementById('geomLog').innerHTML='<b>1. AASHTO STOPPING SIGHT DISTANCE:</b><br>• d_SSD = 0.278*V*tr + V\u00b2 / [254*(a/g \u00b1 G)]<br>• V = 100 km/h on -3% downgrade &rarr; dr = 69.5m, db = 123.0m<br>• <b style=\"color:#10b981;\">Total d_SSD = 192.5 m (AASHTO standard: 195 m)!</b>';}; document.getElementById('btnSuper').onclick=()=>{document.getElementById('geomLog').innerHTML='<b>2. HORIZONTAL CURVE SUPERELEVATION:</b><br>• e + fs = V\u00b2 / (127 * R)<br>• V = 110 km/h, e_max = 0.06, fs_max = 0.110<br>• <b style=\"color:#38bdf8;\">Minimum Radius: R_min = 12100 / (127*0.17) = 560.4 m!</b>';}; document.getElementById('btnVert').onclick=()=>{document.getElementById('geomLog').innerHTML='<b>3. CREST \\& SAG VERTICAL CURVES:</b><br>• Crest (V=100, S=185m): K = 185\u00b2 / 658 = 52.01 &rarr; <b style=\"color:#10b981;\">L = 260.1 m!</b><br>• Summit Point: x_summit = K * G1 = 156.0 m<br>• Sag Headlight: L = A*S\u00b2 / (120 + 3.5*S), Low Point: x_low = K*|G1|<br>🏆 <b style=\"color:#10b981;\">Highway_Geometric_Design 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
