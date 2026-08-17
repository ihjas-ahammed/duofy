# Duofy Reusable Lesson Format: Contraflexure & Beams (Overhangs and Composite Sections)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Engineering_Mechanics_and_SOM / Bending_Moments_and_Shear_Force`  
**Lesson Format Type:** `composite_beams_and_points_of_contraflexure_in_overhanging_beams`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify overhanging beam mechanics, curvature inflection points, and transformed-section analysis in composite multi-material beams (Ferdinand P. Beer, E. Russell Johnston Jr. et al. *Mechanics of Materials* Chapter 4 & 5; James M. Gere & Barry J. Goodno *Mechanics of Materials*): master the **Point of Contraflexure (Point of Inflection)** (the exact longitudinal beam cross-section where the internal bending moment is zero, $\mathbf{M(x) = 0}$, and where the beam's elastic curvature reverses sign between positive sagging $[+]$ and negative hogging $[-]$), master the **Transformed-Section Method for Composite Beams** (e.g. wood flitched with steel plates; using modular ratio $\mathbf{n = \frac{E_{\text{steel}}}{E_{\text{wood}}}}$ to transform steel area into equivalent wooden width $\mathbf{b_{\text{eq}} = n \cdot b_{\text{steel}}}$ while preserving depth $h$), and interact with live SFD/BMD generator, Euler-Bernoulli flexure calculator, Transverse shear parabola plotter, and Point of Contraflexure locator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Point of Contraflexure Geometry & Composite Transformed-Section Modular Ratio ($n = E_1/E_2$) Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Composite Beam / Beam Inflection Primitive & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why the Elastic Curvature Flips at the Point of Contraflexure in Overhanging Beams Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Point in a Beam Where Bending Moment Is Zero and Curvature Changes Sign Is the Point of ___ (Contraflexure / Inflection) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Beam Mechanics Studio: SFD, BMD, Flexure, Transverse Shear & Contraflexure Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "composite_beams_and_points_of_contraflexure_in_overhanging_beams",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Point of Contraflexure, and how does the Transformed-Section Method analyze composite beams?",
      "blankAnswer": "Contraflexure & Composite Beams (Beer & Johnston; Gere & Goodno): (1) POINT OF CONTRAFLEXURE (Inflection Point): The longitudinal position along a beam where the Bending Moment is ZERO (M(x) = 0) and changes algebraic sign (e.g. transitions between positive sagging tension-at-bottom and negative hogging tension-at-top). Elastic curvature satisfies d^2y/dx^2 = 0. (2) COMPOSITE BEAMS (e.g. Wood reinforced with Steel): Strain is linear across the joint, but stresses jump due to different Young's moduli. (3) TRANSFORMED-SECTION METHOD: Transform Material 1 into equivalent Material 2 using Modular Ratio n = E1 / E2. Multiply the width of Material 1 by n (b_eq = n * b) while keeping depth unchanged. Then apply standard flexure formula \u03c3 = M*y / I_transformed, scaling stress in Material 1 by n (\u03c3_1 = n * \u03c3_transformed)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Advanced Beam Mechanics Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Point of Contraflexure", "right": "Cross-section where internal bending moment M(x) = 0 and curvature reverses from sagging to hogging" },
        { "left": "Modular Ratio (n)", "right": "Stiffness ratio n = E_strong / E_weak used to scale width in transformed-section analysis" },
        { "left": "Sagging Bending Moment (+M)", "right": "Curvature producing compression in top fibers and tension in bottom fibers" },
        { "left": "Hogging Bending Moment (-M)", "right": "Curvature producing tension in top fibers and compression in bottom fibers over supports" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In an overhanging beam subjected to downward gravity loads, why does the physical curvature of the beam flip from concave-upward (sagging) to concave-downward (hogging) precisely at the Point of Contraflexure?",
      "options": [
        { "text": "The differential equation of the elastic deflection curve is d^2v/dx^2 = M(x) / (E*I); at the Point of Contraflexure, the internal bending moment passes through zero (M = 0), which mathematically forces the second spatial derivative of deflection (the physical curvature 1/\u03c1) to equal zero; on the midspan side where M > 0, the beam curves concave-upward with tension at the bottom (sagging), whereas over the overhanging support where M < 0, the beam curves concave-downward with tension at the top (hogging), making the Point of Contraflexure the exact transition boundary between opposite curvature regimes", "isCorrect": true, "explanation": "Correct! This is Ferdinand Beer and Russell Johnston's mathematical explanation of overhanging beam deformation (*Mechanics of Materials* Chapter 5). 1. **The Curvature Equation:** - Euler-Bernoulli elastic curve: $$\\frac{d^2 v}{dx^2} = \\frac{M(x)}{E I} = \\frac{1}{\\rho}$$ 2. **Physical Curvature Regimes:** - **Sagging ($M > 0$):** $\\frac{d^2v}{dx^2} > 0 \\implies$ Concave upward (like a smile). Top fiber is in **Compression**, bottom fiber in **Tension**. - **Hogging ($M < 0$):** $\\frac{d^2v}{dx^2} < 0 \\implies$ Concave downward (like a frown). Top fiber is in **Tension**, bottom fiber in **Compression**. 3. **The Zero-Crossing ($M = 0$):** - At $M(x) = 0$: $\\frac{d^2v}{dx^2} = 0$. The beam has **zero curvature (locally straight)**! - **Result:** This is the **Point of Contraflexure (Inflection Point)**. Civil engineers place hinges or reinforcement splices near contraflexure points because bending stress is zero!" },
        { "text": "Because overhanging beams melt under heavy bending moments", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the shear force becomes infinite at the point of contraflexure", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because contraflexure only occurs on magnetic levitation trains", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The point along a loaded beam where the bending moment is zero and the curvature changes sign is the point of ___.",
      "blankAnswer": "contraflexure",
      "blankDistractors": ["maximum", "shear", "buckling"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Beam Mechanics Studio: SFD, BMD, Flexure & Shear",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Beam Mechanics & Stress Analysis Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">SFD/BMD, Euler-Bernoulli Flexure & Transverse Shear</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnSfd\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Plot SFD & BMD</button><button id=\"btnFlex\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Euler-Bernoulli \\u03c3 = My/I</button><button id=\"btnShear\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Transverse Shear (Jourawski)</button></div><div id=\"bmLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to generate SFD & BMD...</div><script>document.getElementById('btnSfd').onclick=()=>{document.getElementById('bmLog').innerHTML='<b>1. SHEAR FORCE \\& BENDING MOMENT DIAGRAMS:</b><br>• Span L = 8m, UDL w = 5 kN/m &rarr; Ay = By = 20 kN<br>• Zero shear at x = 4.0m &rarr; <b style=\"color:#10b981;\">M_max = 40.0 kN\\u00b7m!</b><br>• Overhanging beam: Contraflexure located at M(x) = 0!';}; document.getElementById('btnFlex').onclick=()=>{document.getElementById('bmLog').innerHTML='<b>2. EULER-BERNOULLI FLEXURAL STRESS:</b><br>• Section: b = 100mm, h = 200mm (Z = 0.000667 m^3)<br>• Moment M = 16 kN\\u00b7m &rarr; <b style=\"color:#38bdf8;\">\\u03c3_max = 24.0 MPa</b><br>• Top: -24 MPa (Comp) | NA: 0 MPa | Bottom: +24 MPa (Tens)';}; document.getElementById('btnShear').onclick=()=>{document.getElementById('bmLog').innerHTML='<b>3. TRANSVERSE SHEAR (JOURAWSKI):</b><br>• V = 30 kN, A = 0.030 m^2 &rarr; \\u03c4_avg = 1.0 MPa<br>• Rectangular Parabola: \\u03c4_max = 1.5 * \\u03c4_avg = <b style=\"color:#10b981;\">1.50 MPa at NA!</b><br>🏆 <b style=\"color:#10b981;\">Bending Moments & Shear Force verified!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
