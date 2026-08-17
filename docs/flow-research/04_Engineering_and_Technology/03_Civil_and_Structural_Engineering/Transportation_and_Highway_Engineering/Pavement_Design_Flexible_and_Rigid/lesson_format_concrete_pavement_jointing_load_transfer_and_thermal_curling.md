# Duofy Reusable Lesson Format: Concrete Joints (Dowel Load Transfer & Thermal Curling)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Transportation_and_Highway_Engineering / Pavement_Design_Flexible_and_Rigid`  
**Lesson Format Type:** `concrete_pavement_jointing_load_transfer_and_thermal_curling`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the design of **Jointed Plain Concrete Pavements (JPCP)**, contraction joint spacing criteria ($L \le 4.5\text{ m} \approx 15\text{ ft}$ or $L/\ell \le 4.5$ to prevent uncontrolled thermal warping cracking), smooth steel dowel bar load transfer efficiency ($\text{LTE} = \frac{2 d_{\text{unloaded}}}{d_{\text{loaded}} + d_{\text{unloaded}}} \ge 70\%-80\%$), deformed tie bars along longitudinal hinge joints, and **Thermal Curling / Warping Stresses** caused by diurnal temperature gradients ($\Delta T = T_{\text{top}} - T_{\text{bottom}}$) (Yang H. Huang *Pavement Analysis and Design* Chapters 4 & 5; E. J. Yoder *Principles of Pavement Design*): formulate the **Westergaard-Bradbury Daytime Thermal Curling Stress Formulation**:
$$\mathbf{\sigma_t = \frac{C_x \cdot E \cdot \alpha_t \cdot \Delta T}{2} \quad \left(\alpha_t = \text{Coefficient of Thermal Expansion} \approx 1.0 \times 10^{-5} /^\circ\text{C}\right)}$$
where:
1. **$C_x$:** Bradbury curling stress coefficient dependent on joint spacing ratio $L / \ell$;
2. **$\Delta T = T_{\text{top}} - T_{\text{bottom}} > 0$ (Daytime Condition):** Top of slab expands while bottom stays cool, creating upward convex curling with **tensile stresses at the bottom of the slab** that directly add to bottom wheel load tensile stresses;
3. **$\Delta T < 0$ (Nighttime Condition):** Top contracts, creating concave upward curling with tensile stresses at the top surface;
formulate the **Combined Critical Fatigue Stress**:
$$\mathbf{\sigma_{\text{total}} = \sigma_{\text{wheel,edge}} + \sigma_{t,\text{day}} \le f_r \quad (\text{Governs Transverse Mid-Panel Fatigue Cracking})}$$
derive the **Joint Spacing Sizing Rule**:
$$\mathbf{L \le 4.5 \cdot \ell \quad \text{and} \quad L \le 24 \cdot h \quad (\text{Rule of Thumb: } 15\text{ ft / } 4.5\text{ m Max})}$$
and interact with live AASHTO structural number calculator, Traffic ESAL 4th-power estimator, Westergaard corner/edge stress evaluator, and Concrete slab thermal curling & dowel bar simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Thermal Curling ($\sigma_t = \frac{C_x E \alpha_t \Delta T}{2}$), Dowel LTE & Joint Spacing ($L/\ell \le 4.5$) Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Combined Wheel and Daytime Curling Stresses in a JPCP Slab Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Concrete Joint Entity / Thermal Mechanism & Technical Structural Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | During Sunny Daytime Conditions When $T_{\text{top}} > T_{\text{bottom}}$, Thermal Curling Produces Critical Flexural Tensile Stresses at the ___ of the Concrete Slab (Bottom / Bottom Surface) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Transportation Pavement Studio: Flexible SN, ESALs, Westergaard Stresses & Thermal Curling Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concrete_pavement_jointing_load_transfer_and_thermal_curling",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What causes thermal curling in concrete pavements, and how do dowel bars and joint spacing prevent pavement distress?",
      "blankAnswer": "Concrete Pavement Joints & Curling (Yang H. Huang): (1) THERMAL CURLING: Temperature gradient \u0394T = T_top - T_bottom curls the slab. Daytime (T_top > T_bottom) causes downward convex bending \u2192 bottom tensile stress \u03c3t = 0.5*Cx*E*\u03b1t*\u0394T, which ADDS to edge wheel load tension! (2) COMBINED STRESS: \u03c3_total = \u03c3_wheel + \u03c3_curling \u2264 fr. (3) DOWEL BARS: Smooth steel dowels transfer \u2265 80% shear across transverse joints without restraining horizontal thermal expansion. (4) JOINT SPACING RULE: Spacing L \u2264 4.5*\u2113 (typically \u2264 4.5m / 15ft) limits curling stresses and prevents uncontrolled mid-panel transverse cracking!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to evaluate combined wheel load and thermal curling stresses in a Jointed Plain Concrete Pavement slab.",
      "orderItems": [
        "Calculate the radius of relative stiffness \u2113 = [ (E * h^3) / (12*(1 - \u03bd^2)*k) ]^(1/4)",
        "Determine the joint spacing ratio L / \u2113 and look up the Bradbury curling stress coefficient Cx",
        "Calculate the daytime thermal curling tensile stress at the bottom of the slab: \u03c3t = 0.5 * Cx * E * \u03b1t * \u0394T",
        "Compute the critical edge wheel load tensile stress: \u03c3_edge using Westergaard edge loading equations",
        "Sum total combined bottom tensile stress: \u03c3_total = \u03c3_edge + \u03c3t and verify fatigue safety against modulus of rupture: \u03c3_total \u2264 fr"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Rigid Pavement Joint Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Dowel Bars", "right": "Smooth steel bars providing shear load transfer across transverse contraction joints while allowing free longitudinal expansion" },
        { "left": "Tie Bars", "right": "Deformed rebar dowels holding longitudinal joints tightly closed against lane separation" },
        { "left": "Daytime Curling Stress", "right": "\u03c3t = 0.5*Cx*E*\u03b1t*\u0394T, bottom tensile stress caused by warmer top surface expanding over cooler bottom" },
        { "left": "Joint Spacing Limit (L \u2264 4.5\u2113)", "right": "Geometric rule preventing thermal curling stresses from exceeding 50% of concrete flexural tensile strength" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "During sunny daytime conditions when T_top > T_bottom, thermal curling produces critical flexural tensile stresses at the ___ of the concrete slab.",
      "blankAnswer": "bottom",
      "blankDistractors": ["top", "corner", "center"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Transportation Pavement Engineering Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Pavement Engineering & Design Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">AASHTO SN, 4th-Power ESALs, Westergaard & Thermal Curling</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnSn\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Flexible SN (D1=4\", D2=12.5\")</button><button id=\"btnEsal\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. 4th-Power ESALs (W18 = 12.5M)</button><button id=\"btnWest\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Westergaard (\u03c3c=1.42MPa) & Curling</button></div><div id=\"paveLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate AASHTO Structural Number...</div><script>document.getElementById('btnSn').onclick=()=>{document.getElementById('paveLog').innerHTML='<b>1. AASHTO FLEXIBLE STRUCTURAL NUMBER:</b><br>• SN = a1*D1 + a2*D2*m2 + a3*D3*m3<br>• Surface: D1* = 4.0 in (a1=0.44 &rarr; SN1=1.76)<br>• Crushed Base: D2* = 12.5 in (a2=0.14 &rarr; SN2=1.75)<br>• <b style=\"color:#10b981;\">Total Provided SN* = 3.51 &ge; 3.50 Required!</b>';}; document.getElementById('btnEsal').onclick=()=>{document.getElementById('paveLog').innerHTML='<b>2. TRAFFIC ESAL 4TH-POWER LAW:</b><br>• LEF = (Axle Load / 18 kips)^4<br>• 20-Yr Growth Factor: Gr,20 = 26.87 (g=3%)<br>• <b style=\"color:#38bdf8;\">Design Lane Cumulative W18 = 12.50 Million ESALs!</b>';}; document.getElementById('btnWest').onclick=()=>{document.getElementById('paveLog').innerHTML='<b>3. WESTERGAARD \\& THERMAL CURLING:</b><br>• Relative Stiffness: \\u2113 = [Eh\u00b3/(12(1-\\u03bd\u00b2)k)]^(1/4) = <b style=\"color:#10b981;\">0.945 m</b><br>• Corner Stress: \\u03c3c = (3P/h\u00b2)*[1 - (a\\u221a2/\\u2113)^0.6] = <b style=\"color:#10b981;\">1.42 MPa!</b><br>• Daytime Curling: \\u03c3t = 0.5*Cx*E*\\u03b1t*\\u0394T (Bottom tension)<br>• Joint Spacing: L &le; 4.5*\\u2113 &le; 4.5m (15 ft)<br>🏆 <b style=\"color:#10b981;\">Pavement_Design_Flexible_and_Rigid 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
