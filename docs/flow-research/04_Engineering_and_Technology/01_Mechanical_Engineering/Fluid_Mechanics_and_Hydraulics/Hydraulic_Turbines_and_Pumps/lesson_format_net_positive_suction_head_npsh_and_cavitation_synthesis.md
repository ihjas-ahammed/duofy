# Duofy Reusable Lesson Format: NPSH & Cavitation (Pump Suction Engineering & Synthesis)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Fluid_Mechanics_and_Hydraulics / Hydraulic_Turbines_and_Pumps`  
**Lesson Format Type:** `net_positive_suction_head_npsh_and_cavitation_synthesis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify pump suction line design, vapor pressure margins, Thoma cavitation parameters, and cavitation damage mitigation in hydraulic systems (Frank M. White *Fluid Mechanics* Chapter 11; Bruce R. Munson et al. *Fundamentals of Fluid Mechanics* Chapter 12; Igor J. Karassik *Pump Handbook*): master the fundamental difference between **$\mathbf{\text{NPSH}_{\text{required}}}$ (NPSHR)** (an intrinsic pump property determined experimentally by the manufacturer representing the minimum total suction head above vapor pressure needed at the impeller eye to prevent $>3\%$ head drop) vs **$\mathbf{\text{NPSH}_{\text{available}}}$ (NPSHA)** (the actual net suction head provided by the physical piping system):
$$\mathbf{\text{NPSH}_{\text{available}} = \frac{P_{\text{suction,total}} - P_{\text{vapor}}}{\rho g} = \frac{P_{\text{atm}}}{\rho g} - z_{\text{suction}} - h_{f,\text{suction}} - \frac{P_{\text{vapor}}}{\rho g}}$$
prove that to prevent destructive cavitation, the system **MUST satisfy the safety inequality $\mathbf{\text{NPSH}_A \ge \text{NPSH}_R + \text{Margin}}$** (typically $+0.6\text{ to } 1.0\text{ m}$), evaluate the **Maximum Allowable Suction Lift Height ($\mathbf{z_{s,\text{max}}}$)**, analyze **Thoma's Cavitation Factor ($\mathbf{\sigma = \frac{\text{NPSH}_c}{H}}$)** in Francis/Kaplan turbines, and interact with live Euler velocity triangle builder, Pump affinity scaler, Turbine specific speed selector, and NPSH suction calculator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | NPSH Formula ($\text{NPSH}_A = \frac{P_{\text{atm}}-P_v}{\rho g} - z_s - h_{fs}$) & Cavitation Invariant ($\text{NPSH}_A > \text{NPSH}_R$) Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Turbomachinery Cavitation Term / Installation Variable & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Elevating a Pump Above the Water Reservoir (Suction Lift) Increases Cavitation Risk Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | To Prevent Cavitation, the Net Positive Suction Head Available (NPSHA) Must Strictly Exceed the Net Positive Suction Head ___ (Required / NPSHR) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Fluid Machinery Studio: Euler Velocity Triangles, Affinity Scaling & NPSH Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "net_positive_suction_head_npsh_and_cavitation_synthesis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Net Positive Suction Head (NPSH), and how is it used to prevent pump cavitation?",
      "blankAnswer": "NPSH & Cavitation (Frank M. White; Igor Karassik): (1) NPSH-R (Required): The minimum total head above vapor pressure needed at the pump suction eye to prevent cavitation (supplied by pump manufacturer). (2) NPSH-A (Available): The actual net suction head provided by the piping system: NPSH_A = P_atm / (\u03c1*g) - z_suction - h_f_suction - P_vapor / (\u03c1*g). (3) CAVITATION PREVENTION RULE: To prevent cavitation, the system MUST guarantee NPSH_A > NPSH_R (with a recommended safety margin of +0.5 to 1.0 m). (4) MAXIMUM SUCTION LIFT: As suction lift height z_s increases or suction pipe friction h_fs increases, NPSH_A drops. If NPSH_A < NPSH_R, water boils at the impeller eye, forming vapor bubbles that implode violently, causing severe vibration, pitting erosion, and loss of pump prime!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Turbomachinery Cavitation Term to its exact Engineering Function.",
      "matchPairs": [
        { "left": "NPSH Available (NPSHA)", "right": "Total suction head above vapor pressure provided by the upstream piping and reservoir geometry" },
        { "left": "NPSH Required (NPSHR)", "right": "Minimum suction head above vapor pressure needed by the pump to prevent a 3% head drop" },
        { "left": "Suction Lift (z_s)", "right": "Vertical elevation of the pump centerline above the free surface of the supply reservoir" },
        { "left": "Thoma Cavitation Parameter (\u03c3)", "right": "\u03c3 = NPSH_critical / H_turbine, defining the cavitation inception boundary for hydraulic turbines" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In designing a centrifugal pump water intake station, why does installing the pump at a higher elevation above the reservoir water surface (increasing suction lift z_s) dramatically increase the risk of destructive impeller cavitation?",
      "options": [
        { "text": "As the pump elevation z_s increases, atmospheric pressure must lift the water column against gravity before it reaches the impeller eye; this elevation head requirement, combined with suction pipe friction losses, subtracts directly from atmospheric pressure head (P_atm / \u03c1*g - z_s - h_fs), significantly reducing the Net Positive Suction Head Available (NPSHA); if NPSHA falls below the manufacturer's required threshold (NPSHA < NPSHR), the absolute static pressure at the lowest-pressure zone of the impeller eye drops below the liquid's saturation vapor pressure, causing spontaneous boiling and violent bubble implosion cavitation", "isCorrect": true, "explanation": "Correct! This is Igor Karassik and Frank M. White's fundamental explanation of pump suction limitations (*Pump Handbook*; *Fluid Mechanics* Chapter 11). 1. **The NPSH Available Equation:** $$\\text{NPSH}_A = \\frac{P_{\\text{atm}}}{\\rho g} - z_s - h_{f,\\text{suction}} - \\frac{P_v}{\\rho g}$$ 2. **What Happens as Elevation $z_s$ Increases:** - Atmospheric pressure at sea level provides $\\frac{P_{\\text{atm}}}{\\rho g} \\approx 10.33\\text{ m}$ of water head. - Vapor pressure of water at $20^\\circ\\text{C}$ is $\\frac{P_v}{\\rho g} \\approx 0.24\\text{ m}$. - If suction lift is $z_s = 6.0\\text{ m}$ and pipe friction is $h_{fs} = 1.5\\text{ m}$: - $\\text{NPSH}_A = 10.33 - 6.0 - 1.5 - 0.24 = \\mathbf{2.59\\text{ m}}$. - If the pump requires $\\text{NPSH}_R = 3.5\\text{ m}$: - $\\text{NPSH}_A = 2.59\\text{ m} < \\text{NPSH}_R = 3.5\\text{ m} \\implies$ **SEVERE CAVITATION OCCURS!** 3. **The Engineering Remedy:** Lower the pump closer to the water level ($z_s \\downarrow$), increase suction pipe diameter ($h_{fs} \\downarrow$), or submerge the pump below the reservoir (flooded suction, $z_s < 0$)!" },
        { "text": "Because water becomes heavier at higher elevations", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because high elevations weaken the electromagnetic field of the pump motor", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because pumps are prohibited from running above ground level by building codes", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "To prevent pump cavitation, the Net Positive Suction Head Available (NPSHA) must strictly exceed the Net Positive Suction Head ___ (NPSHR).",
      "blankAnswer": "required",
      "blankDistractors": ["displaced", "atmospheric", "reheat"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Turbomachinery Studio: Euler, Pumps & NPSH",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Hydraulic Turbines & Pumps Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Euler Equation, Affinity Laws, Turbines & NPSH</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnEul\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Euler Head (u2*Vt2/g)</button><button id=\"btnAff\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Pump Affinity (1.5x Speed)</button><button id=\"btnNpsh\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. NPSH & Cavitation Margin</button></div><div id=\"tmLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to compute Euler turbomachine head...</div><script>document.getElementById('btnEul').onclick=()=>{document.getElementById('tmLog').innerHTML='<b>1. EULER TURBOMACHINE HEAD:</b><br>• D2 = 0.30m @ 1800 RPM &rarr; u2 = 28.27 m/s<br>• Radial entry (Vt1=0), Exit Vt2 = 20.0 m/s<br>• <b style=\"color:#10b981;\">H_euler = u2 * Vt2 / g = 57.64 m!</b>';}; document.getElementById('btnAff').onclick=()=>{document.getElementById('tmLog').innerHTML='<b>2. PUMP AFFINITY SCALING LAWS:</b><br>• Speed increased by 1.5x (1200 &rarr; 1800 RPM)<br>• Flow: Q2 = 1.5 * Q1 | Head: H2 = 2.25 * H1<br>• <b style=\"color:#38bdf8;\">Power: P2 = (1.5)^3 * P1 = 3.375 * P1 (40.5 kW)!</b>';}; document.getElementById('btnNpsh').onclick=()=>{document.getElementById('tmLog').innerHTML='<b>3. NPSH \\& CAVITATION ASSESSMENT:</b><br>• NPSH_A = P_atm/\\u03c1g - z_s - h_fs - P_v/\\u03c1g = 4.8 m<br>• NPSH_R = 3.5 m &rarr; Margin: +1.3 m<br>• <b style=\"color:#10b981;\">NPSH_A > NPSH_R &rarr; PUMP IS 100% CAVITATION-FREE!</b><br>🏆 <b style=\"color:#10b981;\">Fluid Mechanics & Hydraulics 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
