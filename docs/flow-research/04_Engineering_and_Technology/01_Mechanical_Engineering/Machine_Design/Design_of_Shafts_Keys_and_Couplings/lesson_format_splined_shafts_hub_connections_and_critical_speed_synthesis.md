# Duofy Reusable Lesson Format: Splines & Shaft Synthesis (Hub Connections & Critical Speed)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Machine_Design / Design_of_Shafts_Keys_and_Couplings`  
**Lesson Format Type:** `splined_shafts_hub_connections_and_critical_speed_synthesis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify multi-splined shaft torque capacity, axial sliding hub connections, and dynamic shaft whirling critical speeds in high-performance mechanical powertrains (Richard G. Budynas & J. Keith Nisbett *Shigley's Mechanical Engineering Design* Chapter 7 & 13; Robert L. Norton *Machine Design: An Integrated Approach* Chapter 9 & 10; SAE / ANSI B92.1 Involute Splines Standard): contrast **Straight-Sided Splines** (SAE 4, 6, 10, 16 splines) vs **Involute Splines** (typically $30^\circ, 37.5^\circ,$ or $45^\circ$ pressure angles, providing greater tooth root strength, self-centering centering action, and lower manufacturing cost using standard gear hobbing); master the **Torque Capacity Equation for Splined Shafts**:
$$\mathbf{T = p_{\text{allow}} \cdot N \cdot L \cdot h \cdot r_m \cdot k_w}$$
where $p_{\text{allow}}$ is allowable compressive bearing pressure ($p \approx 7\text{ to } 20\text{ MPa}$ for sliding splines), $N$ is number of teeth, $L$ is engaged axial length, $h$ is active tooth depth, $r_m = \frac{D + d}{4}$ is mean radius, and $k_w \approx 0.75$ is the tooth engagement load distribution factor; master the **Rayleigh-Dunkerley First Critical Whirling Speed of Multi-Stepped Shafts**:
$$\mathbf{\frac{1}{\omega_{\text{cr}}^2} = \frac{1}{\omega_1^2} + \frac{1}{\omega_2^2} + \dots = \sum \frac{m_i y_i^2}{g \sum m_i y_i}}$$
and interact with live DE-Goodman shaft fatigue optimizer, Sunk key shear/crushing calculator, Flanged coupling bolt shear designer, and Involute spline capacity solver widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Involute Splined Shaft Formula ($T = p \cdot N \cdot L \cdot h \cdot r_m \cdot k_w$) & Dunkerley Whirling Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Powertrain Component / Spline Characteristic & Mechanical Advantage Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Involute Splines Are Structurally Superior to Single Sunk Keys for High-Torque Transmissions Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Machine Element Consisting of Multiple Integral Axial Keys Machined Directly on a Shaft Surface Is a ___ (Spline / Splines) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Machine Shafts & Couplings Studio: Fatigue Sizing, Keys, Flanged Couplings & Splines Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "splined_shafts_hub_connections_and_critical_speed_synthesis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are Involute Splines, how is their torque capacity calculated, and how does Dunkerley's Method predict critical shaft speed?",
      "blankAnswer": "Splines & Shaft Synthesis (Shigley; Norton): (1) INVOLUTE SPLINES: Multiple integral teeth machined directly onto shaft circumference with stub involute profiles (30\u00b0 or 45\u00b0 pressure angle). Eliminates stress concentrations of single keyways and provides automatic self-centering. (2) TORQUE CAPACITY: T = p_allow * N * L * h * r_m * k_w where N = tooth count, L = length, h = tooth depth, r_m = mean radius, and k_w ~ 0.75 is tooth sharing factor. (3) AXIAL SLIDING: Allows smooth sliding under load in gearboxes and vehicle drive shafts. (4) DUNKERLEY'S FORMULA: SDOF critical whirling speed approximation for multi-mass shafts: 1 / \u03c9_cr^2 = 1 / \u03c9_1^2 + 1 / \u03c9_2^2 + ... Ensures operating speed avoids shaft resonant whipping!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Shaft Connection Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Involute Splines", "right": "High-torque integral tooth connection featuring stub 30°/45° teeth that self-center under load" },
        { "left": "Straight-Sided Splines", "right": "SAE standard parallel-sided multiple keys used for sliding gear shifting in manual transmissions" },
        { "left": "Dunkerley's Method", "right": "1 / \u03c9_cr^2 = sum(1 / \u03c9_i^2), estimating lowest critical whirling speed of a shaft carrying multiple masses" },
        { "left": "Tooth Sharing Factor (kw)", "right": "Empirical derating factor (kw \u2248 0.75) accounting for manufacturing pitch variations across teeth" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In automotive drivetrains and aircraft turbine shafts transmitting massive fluctuating torques, why are Involute Splines universally preferred over standard single sunk keys?",
      "options": [
        { "text": "Cutting a standard single keyway into a shaft creates a severe stress concentration factor (Kf \u2248 2.0 to 3.0) and removes significant load-bearing cross-sectional area, reducing torsional fatigue capacity by up to 40%; in contrast, an involute spline distributes the torque equally across 10 to 30 integral teeth, eliminating localized stress concentrations, increasing torque capacity by over 300%, providing automatic dynamic self-centering under torque load, and permitting smooth axial sliding under heavy load (such as in telescoping driveshafts)", "isCorrect": true, "explanation": "Correct! This is Robert Norton and Richard Budynas's central mechanical design justification for involute splines (*Machine Design: An Integrated Approach* Chapter 10; *Shigley's Mechanical Engineering Design* Chapter 7). 1. **The Single Keyway Weakness:** - Cutting a keyway creates sharp internal corners ($K_t \\approx 3.0$). - It weakens the shaft cross-section drastically under cyclic torsion and reversed bending. - All torque is concentrated across a single key, risking key shear or keyway wall crushing. 2. **The Involute Spline Superiority:** - An involute spline incorporates $N = 12$ to $36$ stubby teeth with generous root fillets ($K_t < 1.3$). - Torque is distributed across multiple contact flanks simultaneously ($T = p \\cdot N \\cdot L \\cdot h \\cdot r_m \\cdot k_w$). - The $30^\\circ$ or $45^\\circ$ involute pressure angle generates radial centering forces that **automatically center the hub on the shaft**, eliminating wobble and runout at high speeds! - Splines allow frictionless axial sliding while under full engine torque, enabling **telescoping prop shafts in commercial trucks and 4WD vehicles**!" },
        { "text": "Because splines are made from liquid titanium that never wears out", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because single keys are illegal in aerospace engineering", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because splines rotate at twice the speed of the engine", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The machine element consisting of multiple integral axial teeth machined directly onto a shaft circumference is a ___.",
      "blankAnswer": "spline",
      "blankDistractors": ["pin", "flange", "muff"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Shafts, Keys & Couplings Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Shafts, Keys & Couplings Design Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">DE-Goodman Fatigue, Sunk Keys, Flanged Couplings & Splines</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnShaft\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Shaft Fatigue (Te = 500 N\u00b7m)</button><button id=\"btnKey\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Square Sunk Key (L = 66.7mm)</button><button id=\"btnCoup\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Flanged Coupling & Splines</button></div><div id=\"shLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to size transmission shaft...</div><script>document.getElementById('btnShaft').onclick=()=>{document.getElementById('shLog').innerHTML='<b>1. DE-GOODMAN SHAFT FATIGUE SIZING:</b><br>• M = 300 N\\u00b7m (Reversed), T = 400 N\\u00b7m (Steady)<br>• Te = sqrt(M^2 + T^2) = 500 N\\u00b7m<br>• <b style=\"color:#10b981;\">Required diameter: d = 37.1 mm &rarr; Specify Standard d = 40 mm!</b>';}; document.getElementById('btnKey').onclick=()=>{document.getElementById('shLog').innerHTML='<b>2. SQUARE SUNK KEY SIZING:</b><br>• T = 1000 N\\u00b7m, d = 50 mm, Key: 12x12 mm<br>• L_shear = 55.6 mm | L_crushing = 66.7 mm<br>• <b style=\"color:#38bdf8;\">Design Length: L = max(55.6, 66.7) = 66.7 mm (Specify L = 70 mm)!</b>';}; document.getElementById('btnCoup').onclick=()=>{document.getElementById('shLog').innerHTML='<b>3. FLANGED COUPLING \\& INVOLUTE SPLINES:</b><br>• Coupling: Nb=4 bolts on Dc=150mm &rarr; db = 12.6 mm (M14 bolts)<br>• Involute Splines: Distributes torque across N=16 stub teeth<br>• Eliminates single keyway stress notch, +300% torque capacity!<br>🏆 <b style=\"color:#10b981;\">Design of Shafts, Keys, and Couplings 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
