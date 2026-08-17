# Duofy Reusable Lesson Format: Thermal Stress & Indeterminacy (Mechanics of Materials)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Engineering_Mechanics_and_SOM / Stress_Strain_and_Hookes_Law`  
**Lesson Format Type:** `thermal_stresses_and_statically_indeterminate_axial_bars`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify thermal expansion mechanics, displacement compatibility equations, and statically indeterminate structural analysis in solid mechanics (Ferdinand P. Beer, E. Russell Johnston Jr. et al. *Mechanics of Materials* Chapter 2; James M. Gere & Barry J. Goodno *Mechanics of Materials* Chapter 2): master **Thermal Strain and Free Expansion ($\mathbf{\delta_T = \alpha \Delta T L}$)** (where $\alpha$ is the Linear Coefficient of Thermal Expansion $\text{K}^{-1}$ or $^{\circ}\text{C}^{-1}$), analyze why an unconstrained free bar experiences **zero internal thermal stress ($\sigma_T = 0$)** despite expanding geometrically, master **Statically Indeterminate Systems with Rigid Constrained Boundaries** (formulating the kinematic compatibility equation $\mathbf{\delta_{\text{total}} = \delta_T - \delta_P = 0 \implies \alpha \Delta T L - \frac{P L}{A E} = 0}$), prove that the resulting **Thermal Compressive Stress ($\mathbf{\sigma_T = E \alpha \Delta T}$)** is independent of the length $L$ of the bar, analyze expansion gaps ($\delta_{\text{gap}}$), and interact with live Stress-Strain curve analyzer, Elastic Constants ($E, G, K, \nu$) calculator, and Constrained Thermal Stress simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Thermal Expansion & Kinematic Compatibility Formula ($\delta_{\text{total}} = 0 \implies \sigma_T = E \alpha \Delta T$) Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Thermal Stress / Statically Indeterminate Construct & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Completely Unconstrained Free Thermal Expansion Generates Zero Internal Stress Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | In Solid Mechanics, the Material Property Representing Fractional Expansion per Degree Temperature Rise Is the Coefficient of Thermal ___ (Expansion) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Mechanics of Materials Studio: Stress-Strain Curve, Elastic Constants & Thermal Stress Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "thermal_stresses_and_statically_indeterminate_axial_bars",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What causes Thermal Stress, and how do you calculate the stress developed in a bar fixed between two rigid walls?",
      "blankAnswer": "Thermal Stress & Compatibility (Beer & Johnston; Gere & Goodno): (1) FREE THERMAL EXPANSION: When an unconstrained bar is heated by delta T, it expands by delta_T = alpha * delta T * L. Because it expands freely without external resistance, internal stress is EXACTLY ZERO (\u03c3_T = 0)! (2) CONSTRAINED RIGID WALLS (Indeterminate): When fixed between two rigid unyielding walls, the walls push back with compressive force P to prevent expansion. (3) COMPATIBILITY EQUATION: delta_total = delta_T - delta_P = 0 -> alpha * delta T * L - (P * L) / (A * E) = 0. Solving for stress gives: \u03c3_T = P / A = E * alpha * delta T (Compressive). Notice that thermal stress is INDEPENDENT of bar length L!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Thermal / Solid Mechanics Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Coefficient of Thermal Expansion (\u03b1)", "right": "Fractional change in length per degree temperature variation (\u03b4_T / (L * \u0394T))" },
        { "left": "Constrained Thermal Stress Formula", "right": "\u03c3_T = E * \u03b1 * \u0394T, representing compressive stress developed between rigid fixed supports" },
        { "left": "Kinematic Compatibility Equation", "right": "Geometric displacement relationship (\u03b4_total = 0) used to solve statically indeterminate systems" },
        { "left": "Expansion Gap (\u03b4_gap)", "right": "Physical clearance allowing free expansion before compressive restraint forces initiate" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "A uniform steel railroad rail of length L = 20 m lies unbolted and completely unconstrained on a flat table. The ambient temperature rises by \u0394T = +50 \u00b0C. What is the magnitude of the internal thermal stress developed inside the steel rail?",
      "options": [
        { "text": "\u03c3 = 0 MPa (Zero thermal stress develops because the rail is completely free to expand without external mechanical constraint or boundary resistance)", "isCorrect": true, "explanation": "Correct! This is one of the most fundamental conceptual principles in solid mechanics (Beer & Johnston *Mechanics of Materials* Chapter 2; Gere & Goodno). 1. **The Difference Between Thermal Strain and Thermal Stress:** - When heated by $\\Delta T = 50^\\circ\\text{C}$, the steel rail undergoes a real physical thermal expansion: $$\\delta_T = \\alpha \\Delta T L = (12 \\times 10^{-6}\\text{ /}^\\circ\\text{C})(50^\\circ\\text{C})(20\\text{ m}) = 0.012\\text{ m} = \\mathbf{12\\text{ mm}}$$ - The thermal strain is $\\epsilon_T = \\alpha \\Delta T = 600\\times 10^{-6}$. 2. **Why Stress is Zero:** - Stress in a material is the *intensity of internal resisting forces* generated when deformation is restrained or opposed! - Because the rail lies on a frictionless table with NO walls or end clamps, the atomic lattice expands freely without resistance. - Since there are NO external reaction forces ($P = 0$), the internal normal stress is: $$\\mathbf{\\sigma = \\frac{P}{A} = \\frac{0}{A} = 0\\text{ MPa}!}$$ 3. **The Core Rule:** Temperature changes produce thermal strain. **Thermal stress ONLY develops when thermal expansion or contraction is mechanically restrained by external boundaries or neighboring dissimilar materials!**" },
        { "text": "\u03c3 = 120 MPa (Compressive)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c3 = 240 MPa (Tensile)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c3 = 10,000 MPa (Hydrostatic)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The material property representing fractional change in length per degree of temperature change is the coefficient of thermal ___.",
      "blankAnswer": "expansion",
      "blankDistractors": ["conduction", "resistance", "modulus"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Solid Mechanics Studio: Stress-Strain, E-G-K & Thermal",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Strength of Materials & Elasticity Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Hooke's Law, Elastic Constants & Thermal Stress</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnHooke\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Axial Delta = PL/AE</button><button id=\"btnEgk\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Elastic Constants (E, G, K, \u03bd)</button><button id=\"btnTherm\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Constrained Thermal Stress</button></div><div id=\"somLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to compute axial deformation...</div><script>document.getElementById('btnHooke').onclick=()=>{document.getElementById('somLog').innerHTML='<b>1. AXIAL HOOKE\\'S LAW DEFORMATION:</b><br>• P = 50 kN, L = 1.0 m, A = 500 mm^2, E = 200 GPa<br>• delta = PL / (AE) = <b style=\"color:#10b981;\">0.50 mm (Elastic Tensile Elongation!)</b>';}; document.getElementById('btnEgk').onclick=()=>{document.getElementById('somLog').innerHTML='<b>2. ELASTIC CONSTANTS (Titanium Alloy):</b><br>• Input: E = 120 GPa, \u03bd = 0.25<br>• G = E / [2(1+\u03bd)] = <b style=\"color:#38bdf8;\">48.0 GPa (Shear Modulus)</b><br>• K = E / [3(1-2\u03bd)] = <b style=\"color:#10b981;\">80.0 GPa (Bulk Modulus)</b>';}; document.getElementById('btnTherm').onclick=()=>{document.getElementById('somLog').innerHTML='<b>3. THERMAL COMPATIBILITY \\& STRESS:</b><br>• delta T = +50 \u00b0C between rigid walls<br>• delta_total = delta_T - delta_P = 0<br>• \u03c3_T = E * \u03b1 * delta T = <b style=\"color:#f59e0b;\">120.0 MPa (Compressive Stress!)</b><br>🏆 <b style=\"color:#10b981;\">Stress, Strain & Hooke\\'s Law verified!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
