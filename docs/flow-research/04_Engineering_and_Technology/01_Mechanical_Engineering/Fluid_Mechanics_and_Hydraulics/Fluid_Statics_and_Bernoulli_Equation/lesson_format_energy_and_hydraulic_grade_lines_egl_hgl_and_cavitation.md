# Duofy Reusable Lesson Format: Grade Lines & Cavitation (EGL, HGL, & Vapor Pressure)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Fluid_Mechanics_and_Hydraulics / Fluid_Statics_and_Bernoulli_Equation`  
**Lesson Format Type:** `energy_and_hydraulic_grade_lines_egl_hgl_and_cavitation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify energy line mapping, piezometric heads, siphon pipe limits, and catastrophic cavitation physics in hydraulic piping networks (Frank M. White *Fluid Mechanics* Chapter 3; Bruce R. Munson et al. *Fundamentals of Fluid Mechanics* Chapter 3): master the **Energy Grade Line ($\mathbf{\text{EGL} = \frac{P}{\gamma} + \frac{V^2}{2g} + z}$)** (representing the total mechanical energy head of the flowing liquid) and the **Hydraulic Grade Line ($\mathbf{\text{HGL} = \frac{P}{\gamma} + z}$)** (representing the piezometric head to which liquid would rise in a vertical tap column), prove that the vertical distance between the EGL and HGL is **ALWAYS the dynamic velocity head ($\mathbf{\text{EGL} - \text{HGL} = \frac{V^2}{2g}}$)**, analyze sub-atmospheric siphon pipe summits (where if the pipe centerline rises above the HGL, static pressure becomes negative/sub-atmospheric $\mathbf{P < P_{\text{atm}}}$), and master the **Cavitation Threshold Criterion** (if absolute static pressure drops to the liquid's saturation vapor pressure, $\mathbf{P_{\text{abs}} \le P_{\text{vapor}}(T)}$, the liquid boils spontaneously at room temperature, forming vapor bubbles that implode upon reaching higher pressure zones, generating violent shockwaves $>1000\text{ MPa}$ that pit and destroy pipe walls and pump impellers).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Energy Grade Line (EGL), Hydraulic Grade Line (HGL) Diagram & Cavitation ($P \le P_v$) Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Hydraulic Line Feature / Piping Component & Technical Thermodynamic Effect Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Cavitation Occurs at Siphon Summits and Venturi Throats Under High Velocity Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Vertical Distance Separating the Energy Grade Line (EGL) from the Hydraulic Grade Line (HGL) Is the ___ Head (Velocity) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Fluid Statics & Bernoulli Studio: Hydrostatic Gate, Metacenter, Venturi & EGL Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "energy_and_hydraulic_grade_lines_egl_hgl_and_cavitation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are the Energy Grade Line (EGL) and Hydraulic Grade Line (HGL), and what physical conditions trigger Cavitation?",
      "blankAnswer": "EGL, HGL, & Cavitation (Frank M. White; Munson): (1) ENERGY GRADE LINE (EGL): Total mechanical head EGL = P/\u03b3 + V^2/(2g) + z. In ideal frictionless flow, EGL is horizontal; in real flow, it slopes downward due to friction head loss h_f. (2) HYDRAULIC GRADE LINE (HGL): Piezometric head HGL = P/\u03b3 + z. Shows height water rises in a piezometer tube. (3) DISTANCE BETWEEN EGL & HGL: EGL - HGL = V^2 / (2g) (Velocity Head). (4) SUB-ATMOSPHERIC PRESSURE: If pipe centerline rises ABOVE the HGL, static pressure is negative (gage) / sub-atmospheric (P_abs < P_atm). (5) CAVITATION: If local absolute static pressure drops to or below the liquid's saturation vapor pressure (P_abs <= P_v(T) ~ 2.34 kPa for water at 20 \u00b0C), the liquid spontaneously boils and forms vapor cavities; these bubbles travel into higher pressure regions and violently implode, generating destructive microjets and shockwaves!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Hydraulic Grade Line / Cavitation Term to its exact Physical Implementation.",
      "matchPairs": [
        { "left": "Energy Grade Line (EGL)", "right": "EGL = P/\u03b3 + V^2/(2g) + z, representing the total mechanical energy head of the fluid" },
        { "left": "Hydraulic Grade Line (HGL)", "right": "HGL = P/\u03b3 + z, representing the static pressure head plus elevation head" },
        { "left": "Velocity Head (V^2 / 2g)", "right": "The exact vertical gap separating the Energy Grade Line from the Hydraulic Grade Line" },
        { "left": "Cavitation Damage", "right": "Severe pitting erosion caused by the violent collapse of microscopic vapor bubbles" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In hydraulic piping and pump suction design, what is the primary physical cause of Cavitation occurring at pipe siphon summits or constricting Venturi throats?",
      "options": [
        { "text": "When fluid accelerates to high velocities at constrictions (increasing velocity head V^2/2g) or rises to high elevations (increasing z), Bernoulli energy conservation forces the local static pressure P to drop; if local absolute static pressure falls to or below the liquid's saturation vapor pressure at the prevailing temperature (P_abs <= P_vapor), the liquid boils spontaneously at room temperature, forming vapor cavities that subsequently collapse violently upon entering higher-pressure downstream regions, producing localized shockwaves that erode metal walls", "isCorrect": true, "explanation": "Correct! This is Frank M. White and Bruce Munson's core definition of cavitation (*Fluid Mechanics* Chapter 3). 1. **The Bernoulli Pressure Drop:** - Bernoulli equation: $\\frac{P}{\\gamma} + \\frac{V^2}{2g} + z = \\text{Constant}$. - If velocity $V$ becomes very large (throat constriction) OR elevation $z$ becomes very high (siphon summit): - The static pressure head $\\frac{P}{\\gamma}$ must drop dramatically to balance the equation! 2. **The Boiling Boundary ($P \\le P_v$):** - For water at $20^\\circ\\text{C}$, the saturation vapor pressure is $P_v = 2.34\\text{ kPa (absolute)}$. - Atmospheric pressure is $P_{\\text{atm}} = 101.3\\text{ kPa}$. - If static pressure drops below $2.34\\text{ kPa}$, **liquid water physically boils at room temperature ($20^\\circ\\text{C}$)**! 3. **The Catastrophic Bubble Implosion:** - Microscopic steam/vapor bubbles form in the low-pressure throat. - As fluid flows into the wider downstream pipe, velocity drops $\\implies$ pressure rises back above $P_v$. - The vapor bubbles violently collapse (implode) in nanoseconds, sending **concentrated micro-jets with local impact pressures exceeding $1000\\text{ MPa}$** into the pipe metal, creating deep pitting craters and destroying impellers!" },
        { "text": "Because high flow velocities freeze water into ice crystals", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because pipes run out of electrical grounding at high elevations", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because siphon summits attract cosmic radiation that ionizes the fluid", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The vertical distance separating the Energy Grade Line from the Hydraulic Grade Line is the ___ head.",
      "blankAnswer": "velocity",
      "blankDistractors": ["pressure", "elevation", "friction"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Fluid Statics & Dynamics Studio: Gate, Venturi & EGL",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Fluid Statics & Bernoulli Dynamics Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Center of Pressure, GM Stability & Bernoulli EGL/HGL</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnGate\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Submerged Gate (y_p)</button><button id=\"btnGm\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Ship Metacenter (GM)</button><button id=\"btnEgl\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Venturi EGL, HGL & Cavitation</button></div><div id=\"flLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate center of pressure...</div><script>document.getElementById('btnGate').onclick=()=>{document.getElementById('flLog').innerHTML='<b>1. HYDROSTATIC CENTER OF PRESSURE:</b><br>• Gate: b = 2m, h = 3m, flush with surface (yc = 1.5m)<br>• F_R = \\u03c1*g*hc*A = (1000)(9.81)(1.5)(6) = 88.29 kN<br>• <b style=\"color:#10b981;\">y_p = yc + I_xx/(yc*A) = 2.0 m (Below Centroid!)</b>';}; document.getElementById('btnGm').onclick=()=>{document.getElementById('flLog').innerHTML='<b>2. METACENTRIC ROLLING STABILITY:</b><br>• Barge: L=10m, b=4m, Draft d=1.0m (zB=0.5m, zG=1.5m)<br>• MB = I/V_disp = 1.333m | BG = 1.0m<br>• <b style=\"color:#38bdf8;\">GM = MB - BG = +0.333 m (100% STABLE!)</b>';}; document.getElementById('btnEgl').onclick=()=>{document.getElementById('flLog').innerHTML='<b>3. BERNOULLI EGL, HGL \\& CAVITATION:</b><br>• Venturi Throat: High velocity &rarr; Velocity head V^2/2g spikes<br>• EGL - HGL = V^2/2g | HGL drops to throat static pressure<br>• <b style=\"color:#f59e0b;\">Cavitation check: P_throat > P_vapor (Safe from boiling!)</b><br>🏆 <b style=\"color:#10b981;\">Fluid Statics & Bernoulli Equation 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
