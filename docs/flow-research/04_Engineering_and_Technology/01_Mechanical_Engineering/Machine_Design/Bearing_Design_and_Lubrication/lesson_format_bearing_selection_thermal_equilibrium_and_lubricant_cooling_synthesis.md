# Duofy Reusable Lesson Format: Bearing Synthesis (Selection, Thermal Equilibrium, & Tribology)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Machine_Design / Bearing_Design_and_Lubrication`  
**Lesson Format Type:** `bearing_selection_thermal_equilibrium_and_lubricant_cooling_synthesis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify comprehensive bearing selection, rolling-element vs hydrodynamic trade-offs, thermal equilibrium oil energy balances, and lubricant cooling system sizing in industrial rotating machinery (Richard G. Budynas & J. Keith Nisbett *Shigley's Mechanical Engineering Design* Chapters 11 & 12; Robert L. Norton Chapters 14 & 15; V.B. Bhandari *Design of Machine Elements* Chapters 15 & 16): contrast **Rolling-Contact Bearings** (low starting friction, standard catalog replacements, limited high-speed life due to fatigue, noisy under shock) vs **Hydrodynamic Journal Bearings** (theoretically infinite life with zero solid contact under continuous rotation, high damping capacity, silent operation, but requires pressurized oil lubrication and exhibits higher starting friction during boundary startup); master **Thermal Equilibrium Analysis in Journal Bearings**:
$$\mathbf{H_{\text{generated}} = \mu W V_{\text{journal}} = H_{\text{dissipated}} = C_{\text{oil}} \cdot h_{\text{housing}} A_{\text{case}} (T_{\text{oil}} - T_{\text{ambient}}) + \dot{m}_{\text{oil}} c_p (T_{\text{out}} - T_{\text{in}})}$$
(solving iteratively until assumed lubricant viscosity matches steady-state operating temperature), and interact with live $L_{10}$ rolling life calculator, Sommerfeld hydrodynamic film thickness predictor, Stribeck curve mapper, and Thermal equilibrium heat balance widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bearing Selection Matrix (Rolling vs Hydrodynamic) & Thermal Equilibrium ($H_{\text{gen}} = H_{\text{diss}}$) Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Bearing Architecture / Tribological Property & Operational Advantage Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Hydrodynamic Journal Bearings Are Chosen for High-Speed Steam Turbines Over Ball Bearings Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The State Where Rate of Frictional Heat Generation Equals Rate of Heat Dissipation in a Bearing Is Thermal ___ (Equilibrium / Balance) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Machine Bearing Design Studio: L10 Life, Sommerfeld Hydrodynamics, Stribeck & Thermal Heat Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "bearing_selection_thermal_equilibrium_and_lubricant_cooling_synthesis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do engineers choose between Rolling-Element and Hydrodynamic Bearings, and how is Thermal Equilibrium evaluated?",
      "blankAnswer": "Bearing Selection & Thermal Balance (Shigley; Norton): (1) ROLLING BEARINGS (Ball/Roller): Low starting friction, standardized catalog replacement, grease lubricated. Best for moderate speeds, start-stop cycles, and where axial space is tight. Limited by fatigue life (L10 = (C/P)^p). (2) HYDRODYNAMIC JOURNAL BEARINGS: Fluid film separates surfaces (h0 > 5Ra). Infinite operating fatigue life, enormous shock damping, silent operation. Best for heavy loads, high continuous speeds (steam turbines, engine crankshafts). (3) THERMAL EQUILIBRIUM: Frictional heat generated H_gen = \u03bc * W * V must equal heat dissipated H_diss = h*A*(T_oil - T_amb) + m_dot*cp*\u0394T. If H_gen > H_diss, oil temperature escalates, viscosity collapses, and catastrophic metal seizure occurs!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Bearing Architecture to its primary Engineering Advantage.",
      "matchPairs": [
        { "left": "Deep-Groove Ball Bearing", "right": "Versatile anti-friction bearing accommodating high rotational speeds and moderate combined loads" },
        { "left": "Hydrodynamic Journal Bearing", "right": "Heavy-duty sliding bearing with infinite fatigue life and exceptional fluid-film shock damping" },
        { "left": "Tapered Roller Bearing", "right": "Rigid rolling bearing capable of carrying massive simultaneous radial and unidirectional thrust loads" },
        { "left": "Thermal Equilibrium Balance", "right": "Iterative state where frictional heat generation exactly equals cooling dissipation rate" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In multi-megawatt electric power generation steam turbines and large multi-cylinder marine diesel engines, why are Hydrodynamic Journal Bearings universally selected instead of rolling-element ball or roller bearings?",
      "options": [
        { "text": "Rolling-element bearings suffer from finite contact fatigue life under millions of stress cycles (L10 = (C/P)^p), cannot be split for assembly around continuous crankshaft journals, and possess negligible vibration damping; in contrast, hydrodynamic journal bearings operate with complete fluid film separation, providing theoretically infinite fatigue life, superior acoustic and vibration damping through viscous squeeze-films, the ability to be manufactured as split-half shells for easy assembly, and the capacity to support massive multi-ton dynamic loads without fatigue", "isCorrect": true, "explanation": "Correct! This is Richard Budynas and Robert Norton's fundamental machinery design comparison (*Shigley's Mechanical Engineering Design* Chapter 11 & 12; *Machine Design: An Integrated Approach* Chapter 14 & 15). 1. **Infinite Fatigue Life:** - Rolling bearings experience cyclic subsurface shear stress, guaranteeing eventual fatigue flaking ($L_{10}$). - In full hydrodynamic lubrication, **solid surfaces never touch ($h_0 > 0$)**, giving **zero wear and unlimited operational life**! 2. **Assembly Around Multi-Throw Crankshafts:** - A journal bearing consists of **two split half-shells (babbitt-lined)** that can be bolted around complex crankshaft throws. - Standard rolling bearings cannot be installed over crank webs without complex split races! 3. **Viscous Damping of Shock Loads:** - Combustion firing spikes in diesel engines generate explosive peak pressures. - The thick viscous oil film acts as a hydraulic damper (squeeze-film damping), cushioning shock waves and protecting shafts! 4. **Load Capacity:** At high speeds ($3600\\text{ RPM}$), journal bearings support dozens of tons of turbine rotor weight silently and reliably for decades!" },
        { "text": "Because ball bearings cannot rotate faster than 100 RPM", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because steam turbines do not use lubricating oil", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because rolling bearings are destroyed by magnetic fields", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The operating state where the rate of frictional heat generation matches the rate of heat dissipation in a bearing is thermal ___.",
      "blankAnswer": "equilibrium",
      "blankDistractors": ["cavitation", "resonance", "viscosity"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Bearing Design & Tribology Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Bearing Design & Lubrication Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">L10 Rolling Life, Sommerfeld Hydrodynamics & Stribeck</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnL10\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Ball L10 Life (711 hrs)</button><button id=\"btnSomm\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Hydrodynamic Sommerfeld (S=0.6)</button><button id=\"btnStrib\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Stribeck Curve & Thermal Balance</button></div><div id=\"brLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate ball bearing L10 life...</div><script>document.getElementById('btnL10').onclick=()=>{document.getElementById('brLog').innerHTML='<b>1. ROLLING BEARING L10 FATIGUE LIFE:</b><br>• C = 24 kN, P = 6 kN &rarr; L10 = (C/P)^3 = 64 Million Revs<br>• At 1500 RPM &rarr; <b style=\"color:#10b981;\">L10h = 711.1 Operating Hours!</b><br>• 90% survival reliability before initial subsurface fatigue!';}; document.getElementById('btnSomm').onclick=()=>{document.getElementById('brLog').innerHTML='<b>2. HYDRODYNAMIC JOURNAL BEARING:</b><br>• R=50mm, L=100mm, c=0.05mm, N=1800 RPM &rarr; P = 1.0 MPa<br>• <b style=\"color:#38bdf8;\">Sommerfeld Number: S = (R/c)^2 * (\u03bcN\'/P) = 0.60!</b><br>• Minimum film h0 = 12.5 \\u03bcm &rarr; Zero metal-to-metal wear!';}; document.getElementById('btnStrib').onclick=()=>{document.getElementById('brLog').innerHTML='<b>3. STRIBECK CURVE \\& THERMAL EQUILIBRIUM:</b><br>• Zone III Full Fluid Film: \\u03bc_friction \\u2248 0.002<br>• Petroff torque: Tf = 1.90 N\\u00b7m | Heat Gen: H_gen = 297.7 W<br>• <b style=\"color:#10b981;\">H_gen = H_diss @ 65 \\u00b0C (Stable Thermal Equilibrium)!</b><br>🏆 <b style=\"color:#10b981;\">Machine Design 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
