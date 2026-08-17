# Duofy Reusable Lesson Format: Water Surface Profiles (GVF Differential Equation & Controls)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Hydraulics_and_Water_Resources_Engineering / Open_Channel_Flow_and_Hydraulic_Jump`  
**Lesson Format Type:** `gradually_varied_flow_water_surface_profiles_and_controls`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the theory and numerical integration of **Gradually Varied Flow (GVF)** in non-prismatic and prismatic open channels, the dynamic differential equation for water surface slope ($\frac{dy}{dx}$), the classification of channel bed slopes (Mild $M$, Steep $S$, Critical $C$, Horizontal $H$, Adverse $A$), water surface profile zones (Zone 1 $y > y_n, y_c$; Zone 2 between $y_n$ and $y_c$; Zone 3 $y < y_n, y_c$), hydraulic controls (upstream vs downstream controls), and standard step method computation of backwater curves ($M_1$) behind dams and drawdown curves ($M_2$) approaching free overfalls (Ven Te Chow *Open-Channel Hydraulics* Chapters 8 & 9; Terry W. Sturm *Open Channel Hydraulics* Chapter 5): formulate the **Gradually Varied Flow (GVF) Dynamic Differential Equation**:
$$\mathbf{\frac{dy}{dx} = \frac{S_0 - S_f}{1 - \text{Fr}^2} = \frac{S_0 - \frac{n^2 V^2}{R_h^{4/3}}}{1 - \frac{V^2 T}{g A}}}$$
where:
1. **$S_0$:** Channel bed slope;
2. **$S_f = \frac{n^2 V^2}{R_h^{4/3}} = \frac{n^2 Q^2}{A^2 R_h^{4/3}}$:** Friction slope from Manning's equation;
3. **$\text{Fr}^2 = \frac{V^2}{g D_h} = \frac{Q^2 T}{g A^3}$:** Square of the Froude number;
derive the **Water Surface Profile Slope Rules**:
- **Zone 1 ($\mathbf{y > y_n, y > y_c}$):** $S_0 > S_f$ and $\text{Fr} < 1 \implies \mathbf{\frac{dy}{dx} > 0 \ (\text{Backwater / Rising Curve } M_1, S_1)}$;
- **Zone 2 ($\mathbf{y_c < y < y_n}$ on Mild):** $S_0 < S_f$ and $\text{Fr} < 1 \implies \mathbf{\frac{dy}{dx} < 0 \ (\text{Drawdown / Falling Curve } M_2)}$;
- **Zone 3 ($\mathbf{y < y_c < y_n}$ on Mild):** $S_0 < S_f$ and $\text{Fr} > 1 \implies \mathbf{\frac{dy}{dx} > 0 \ (\text{Rising Hydraulic Jump Precursor } M_3)}$;
and interact with live Manning uniform flow calculator, Specific energy $E-y$ curve plotter, Bélanger hydraulic jump simulator, and GVF water surface profile tracer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | GVF Equation ($\frac{dy}{dx} = \frac{S_0 - S_f}{1 - \text{Fr}^2}$), Slope Classes ($M, S, C, H, A$) & Zones (1, 2, 3) Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Classify Channel Slope and Sketch the Resulting GVF Profile Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | GVF Water Surface Profile / Control Type & Technical Hydraulic Phenomenon Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Gradually Varied Flow, the Famous Backwater Curve Created Upstream of a Dam on a Mild Channel Is Designated as the ___ Profile (M1 / M-1) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Open Channel Hydraulics Studio: Manning, Critical Energy, Hydraulic Jumps & GVF Profiles Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "gradually_varied_flow_water_surface_profiles_and_controls",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Gradually Varied Flow (GVF) equation, and how are water surface profiles (M1, M2, M3) classified?",
      "blankAnswer": "GVF Profiles & Hydraulic Controls (Ven Te Chow): (1) GVF EQUATION: dy/dx = (S0 - Sf) / (1 - Fr^2), where Sf = (n^2*V^2) / Rh^(4/3) is friction slope and Fr is Froude number. (2) MILD SLOPE (yn > yc): M1 profile (y > yn > yc, dy/dx > 0) = Backwater curve behind a dam; M2 profile (yn > y > yc, dy/dx < 0) = Drawdown curve approaching an overfall; M3 profile (yn > yc > y, dy/dx > 0) = Supercritical flow exiting a sluice gate rising toward a hydraulic jump. (3) CONTROLS: Subcritical flow is controlled from DOWNSTREAM; Supercritical flow is controlled from UPSTREAM!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine and sketch the Gradually Varied Flow water surface profile in an open channel.",
      "orderItems": [
        "Calculate the normal depth yn using Manning's equation and the critical depth yc using the critical flow equation",
        "Compare normal and critical depths to classify the channel bed slope: Mild (yn > yc), Steep (yn < yc), or Critical (yn = yc)",
        "Identify hydraulic control points: downstream controls for subcritical flow (e.g. dam spillway, lake) or upstream controls for supercritical (e.g. sluice)",
        "Determine the active profile zone based on actual water depth y relative to yn and yc (Zone 1: y > yn, yc; Zone 2: middle; Zone 3: below both)",
        "Evaluate the sign of dy/dx = (S0 - Sf) / (1 - Fr^2) to plot rising (dy/dx > 0) or drawdown (dy/dx < 0) water surface profile curves"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each GVF Profile to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "M1 Profile (Backwater)", "right": "Mild slope Zone 1 (y > yn > yc, dy/dx > 0), asymptotic to normal depth upstream and horizontal at dam" },
        { "left": "M2 Profile (Drawdown)", "right": "Mild slope Zone 2 (yn > y > yc, dy/dx < 0), accelerating water surface dropping toward critical depth at a fall" },
        { "left": "M3 Profile (Supercritical)", "right": "Mild slope Zone 3 (y < yc < yn, dy/dx > 0), rapid flow expanding from under a sluice gate terminating in a jump" },
        { "left": "Downstream Control", "right": "Boundary condition for subcritical flow where downstream water levels govern upstream depths" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In gradually varied flow, the famous backwater curve created upstream of a reservoir dam on a mild channel is designated as the ___ profile.",
      "blankAnswer": "M1",
      "blankDistractors": ["M2", "M3", "S1"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Open Channel Hydraulics Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Open Channel Hydraulics Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Manning Flow, Critical Energy, Bélanger Jumps & GVF</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnMann\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Manning Optimal (Q = 21.3m\u00b3/s)</button><button id=\"btnCrit\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Critical State (yc = 1.18m, Fr=1.78)</button><button id=\"btnJump\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Bélanger Jump (y2=2.59m) & GVF</button></div><div id=\"hydLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate Manning uniform flow...</div><script>document.getElementById('btnMann').onclick=()=>{document.getElementById('hydLog').innerHTML='<b>1. MANNING OPTIMAL CHANNEL FLOW:</b><br>• Condition: b = 2y = 4.0m, Rh = y/2 = 1.0m<br>• Velocity: V = (1/n)*Rh^(2/3)*\\u221aS0 = <b style=\"color:#10b981;\">2.67 m/s</b><br>• <b style=\"color:#38bdf8;\">Total Discharge: Q = A * V = 21.33 m\u00b3/s!</b>';}; document.getElementById('btnCrit').onclick=()=>{document.getElementById('hydLog').innerHTML='<b>2. SPECIFIC ENERGY \\& CRITICAL FLOW:</b><br>• Unit Flow: q = Q/b = 4.0 m\u00b2/s<br>• Critical Depth: yc = (q\u00b2/g)^(1/3) = <b style=\"color:#10b981;\">1.18 m (E_min = 1.77m)</b><br>• Observed: y = 0.80 m &rarr; Fr = 1.78 > 1.0 (Supercritical!)';}; document.getElementById('btnJump').onclick=()=>{document.getElementById('hydLog').innerHTML='<b>3. B\u00c9LANGER JUMP \\& GVF PROFILES:</b><br>• Fr1 = 4.0 &rarr; y2 = (y1/2)*(\\u221a(1+8*Fr1\u00b2)-1) = <b style=\"color:#10b981;\">2.59 m!</b><br>• Head Loss: \\u0394E = (y2-y1)\u00b3 / (4*y1*y2) = 1.76 m (P = 518 kW)<br>• GVF Equation: dy/dx = (S0 - Sf) / (1 - Fr\u00b2)<br>• <b style=\"color:#38bdf8;\">M1 Backwater, M2 Drawdown & M3 Jump Approach!</b><br>🏆 <b style=\"color:#10b981;\">Open_Channel_Flow_and_Hydraulic_Jump 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
