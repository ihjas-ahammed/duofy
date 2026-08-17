# Duofy Reusable Lesson Format: Sheet Metal & Resistance Welding (Springback & Joule Heating)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Manufacturing_and_Industrial_Engineering / Casting_Forming_and_Welding`  
**Lesson Format Type:** `sheet_metal_bending_springback_and_resistance_spot_welding`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify sheet metal bending kinematics, neutral axis shifting, elastic springback compensation, and resistance spot welding Joule heating in high-volume automotive manufacturing (Serope Kalpakjian & Steven R. Schmid *Manufacturing Engineering and Technology* Chapters 16 & 31; Mikell P. Groover Chapters 20 & 31): master the **Sheet Metal Bend Allowance Formulation**:
$$\mathbf{BA = \alpha \cdot \frac{\pi}{180} \left( R + K_{ba} T \right) \quad \left(K_{ba} = 0.33 \text{ for } R < 2T, \ K_{ba} = 0.50 \text{ for } R \ge 2T\right)}$$
where $\alpha$ is bend angle (degrees), $R$ is inside bend radius, $T$ is sheet thickness, and $K_{ba}$ is the neutral axis location factor; master the **Elastic Springback Factor ($\mathbf{K_s = \frac{\alpha_f}{\alpha_i} = \frac{2 R_i / T + 1}{2 R_f / T + 1}}$)** (compensating for elastic strain recovery by overbending the punch to a sharper angle $\alpha_i$); master **Resistance Spot Welding (RSW) Joule Heat Generation**:
$$\mathbf{H = I^2 \cdot R_{\text{total}} \cdot t \ [\text{Joules}] \quad \left(R_{\text{total}} = R_1 + R_2 + R_3 + \dots \text{ Contact Interface Resistance}\right)}$$
(analyzing why peak electrical contact resistance occurs directly at the faying interface between the two steel sheets, melting the metal into a localized weld nugget without melting the water-cooled copper electrodes), and interact with live Chvorinov casting simulator, Rolling draft optimizer, Welding heat calculator, and RSW spot weld nugget designer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bend Allowance ($BA = \alpha(R+K_{ba}T)$) & RSW Spot Weld Joule Heating ($H = I^2 R t$) Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Sheet Metal Forming / Resistance Welding Term & Technical Physical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Resistance Spot Welding Melts the Steel Faying Interface Without Melting Copper Electrodes Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Elastic Recovery That Causes a Bent Sheet Metal Flange to Partially Unbend After Die Removal Is ___ (Springback) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Manufacturing Processes Studio: Casting, Rolling Draft, Welding Heat & RSW Spot Nugget Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "sheet_metal_bending_springback_and_resistance_spot_welding",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Sheet Metal Bend Allowance and Springback, and how does Resistance Spot Welding (RSW) create a weld nugget?",
      "blankAnswer": "Sheet Metal & RSW (Kalpakjian; Groover): (1) BEND ALLOWANCE: Arc length of the shifted neutral axis: BA = \u03b1 * (\u03c0/180) * (R + K_ba * T) where K_ba = 0.33 (for R < 2T) or 0.50 (for R >= 2T). (2) SPRINGBACK: Elastic strain recovery upon punch release causing bend angle to open up. Compensated by overbending or bottoming. (3) RESISTANCE SPOT WELDING: Electric current generates localized Joule heat: H = I^2 * R * t. (4) NUGGET FORMATION: The contact resistance at the faying interface between sheets (R_faying) is vastly higher than copper-steel interface, and copper has 10x higher thermal conductivity; thus melting occurs ONLY at sheet interface, creating a strong weld nugget in 0.1-0.5 seconds!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Sheet Metal / Resistance Welding Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Bend Allowance (BA)", "right": "BA = \u03b1 * (\u03c0/180) * (R + K*T), the length of neutral axis in the bend region needed for blank sizing" },
        { "left": "Elastic Springback", "right": "Elastic strain energy released upon unloading, causing the bend angle to decrease and radius to expand" },
        { "left": "RSW Joule Heating (H = I^2*R*t)", "right": "Localized thermal melting driven by thousands of amperes flowing through faying contact resistance" },
        { "left": "Faying Surface", "right": "The mating contact interface between two overlapping sheet metal layers where the weld nugget forms" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In automotive body-in-white (BIW) assembly using Resistance Spot Welding (RSW), why does the molten steel weld nugget form strictly at the interface between the two steel sheets without melting the copper electrodes?",
      "options": [
        { "text": "The total electrical circuit resistance is dominated by the contact resistance at the steel-to-steel faying interface (which has rough microscopic asperities and 5x higher bulk electrical resistivity than copper), producing the maximum I^2*R heat generation exactly at the sheet center; furthermore, the water-cooled copper electrodes possess 10 times higher thermal conductivity than steel, rapidly dissipating heat away from the electrode tips so that only the steel interior reaches its melting point (1500°C)", "isCorrect": true, "explanation": "Correct! This is Serope Kalpakjian and Mikell Groover's fundamental electro-thermal explanation for Resistance Spot Welding (*Manufacturing Engineering and Technology* Chapter 31; *Fundamentals of Modern Manufacturing* Chapter 31). 1. **Contact Resistance Distribution:** - Current ($I = 5000-15,000\\text{ Amperes}$) flows in series through: Top copper electrode $\\to$ Top steel sheet $\\to$ **Faying interface** $\\to$ Bottom steel sheet $\\to$ Bottom electrode. - The faying interface consists of micro-asperities with air gaps, creating the **highest electrical contact resistance ($R_{\\text{faying}}$)** in the circuit! 2. **Joule Heating ($H = I^2 R t$):** - The rate of heat generation is directly proportional to localized resistance ($I^2 R$). - Therefore, heat generation peaks violently at the interface between the two steel sheets! 3. **Thermal Diffusivity Discrepancy:** - Pure copper has thermal conductivity $k \\approx 390\\text{ W/m}\\cdot\\text{K}$, and electrodes are internally water-cooled. - Steel has low thermal conductivity ($k \\approx 45\\text{ W/m}\\cdot\\text{K}$). - Heat cannot escape the steel center, trapping energy until steel melts ($1538^\\circ\\text{C}$) into a coalesced weld nugget while copper stays below $200^\\circ\\text{C}$!" },
        { "text": "Because copper has a higher melting point than steel", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because steel attracts magnetic current whereas copper repels it", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because copper electrodes are coated in diamond insulation", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The elastic strain recovery causing a formed sheet metal part to partially unbend after die pressure is released is ___.",
      "blankAnswer": "springback",
      "blankDistractors": ["clearance", "shrinkage", "choke"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Manufacturing Processes Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Manufacturing Processes Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Casting Solidification, Rolling Draft, Welding & RSW</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnCast\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Chvorinov Casting (ts = 4 min)</button><button id=\"btnRoll\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Rolling Max Draft (6.75 mm)</button><button id=\"btnWeld\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Welding Heat & Spot Nugget</button></div><div id=\"mfLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate casting solidification...</div><script>document.getElementById('btnCast').onclick=()=>{document.getElementById('mfLog').innerHTML='<b>1. CHVORINOV CASTING SOLIDIFICATION:</b><br>• Sphere D=100mm, Modulus M = D/6 = 16.67 mm &rarr; ts = 4.0 min<br>• Cube a=100mm, Modulus M = a/6 = 16.67 mm &rarr; <b style=\"color:#10b981;\">ts = 4.0 min!</b><br>• Top Riser: Sized with M_riser = 1.2 * M_cast (Freezes Last!)';}; document.getElementById('btnRoll').onclick=()=>{document.getElementById('mfLog').innerHTML='<b>2. FLAT ROLLING MAXIMUM DRAFT:</b><br>• Roll Radius R = 300 mm, Friction \\u03bc = 0.15<br>• Bite Angle: \\u03b1 \\u2264 atan(\\u03bc) = 8.53\\u00b0<br>• <b style=\"color:#38bdf8;\">Max Single-Pass Draft: \\u0394h_max = \\u03bc^2 * R = 6.75 mm!</b>';}; document.getElementById('btnWeld').onclick=()=>{document.getElementById('mfLog').innerHTML='<b>3. WELDING HEAT \\& RESISTANCE SPOT WELDING:</b><br>• SAW Net Heat: H_net = \\u03b7 * (V*I)/v = 1.35 kJ/mm<br>• Carbon Equivalent: CE \\u2264 0.40% (Crack-Free HAZ!)<br>• RSW Spot Nugget: I=10kA @ faying interface &rarr; H = I^2*R*t<br>🏆 <b style=\"color:#10b981;\">Casting, Forming, and Welding 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
