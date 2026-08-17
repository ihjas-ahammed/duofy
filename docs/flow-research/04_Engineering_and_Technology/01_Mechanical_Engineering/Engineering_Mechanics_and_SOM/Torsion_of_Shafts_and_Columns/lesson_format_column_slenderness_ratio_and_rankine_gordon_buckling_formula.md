# Duofy Reusable Lesson Format: Slenderness & Rankine (Inelastic Buckling and Synthesis)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Engineering_Mechanics_and_SOM / Torsion_of_Shafts_and_Columns`  
**Lesson Format Type:** `column_slenderness_ratio_and_rankine_gordon_buckling_formula`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify column classification boundaries, radius of gyration, inelastic buckling limits, and unified structural stability formulas (Ferdinand P. Beer, E. Russell Johnston Jr. et al. *Mechanics of Materials* Chapter 10; William J.M. Rankine 1858; Russell C. Hibbeler): master the **Radius of Gyration ($\mathbf{r = \sqrt{\frac{I}{A}}}$)**, master the **Slenderness Ratio ($\mathbf{\lambda = \frac{L_e}{r_{\text{min}}}}$)** and the **Euler Critical Stress Formula ($\mathbf{\sigma_{\text{cr}} = \frac{P_{\text{cr}}}{A} = \frac{\pi^2 E}{\lambda^2}}$)**, analyze the **Euler Validity Limit** (determining the transition slenderness ratio $\mathbf{\lambda_{\text{transition}} = \sqrt{\frac{\pi^2 E}{\sigma_y}}}$, proving that for short/intermediate columns with $\lambda < \lambda_{\text{transition}}$, the Euler equation predicts impossible stresses exceeding yield strength $\sigma_{\text{cr}} > \sigma_y$), master **Rankine's Empirical Formula**:
$$\mathbf{\frac{1}{P_R} = \frac{1}{P_c} + \frac{1}{P_E} \implies \mathbf{P_R = \frac{\sigma_c A}{1 + a \lambda^2}} \quad \left(a = \frac{\sigma_c}{\pi^2 E}\right)}$$
(unifying pure compressive crushing $P_c = \sigma_c A$ for short columns with elastic buckling $P_E$ for long columns), and interact with live Shaft Torsion / Polar Moment calculator, Euler Buckling boundary condition simulator, and Slenderness-Rankine transition curve widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Slenderness Ratio ($\lambda = L_e/r$) & Rankine-Gordon Formula ($P_R = \frac{\sigma_c A}{1 + a\lambda^2}$) Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Column Stability / Slenderness Primitive & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Euler's Buckling Formula Fails to Predict Failure in Short Stocky Columns Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Geometric Ratio of a Column's Effective Length to Its Minimum Radius of Gyration Is the ___ Ratio (Slenderness) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Torsion & Column Stability Studio: Shaft Torsion, Euler & Rankine Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "column_slenderness_ratio_and_rankine_gordon_buckling_formula",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Slenderness Ratio, and how does Rankine's Formula bridge short and long columns?",
      "blankAnswer": "Slenderness & Rankine (Beer & Johnston; Rankine 1858): (1) RADIUS OF GYRATION: r = sqrt(I_min / A), representing the effective distance from the bending axis. (2) SLENDERNESS RATIO: \u03bb = L_e / r_min. Critical Euler stress is \u03c3_cr = \u03c0^2 * E / \u03bb^2. (3) EULER LIMIT: Valid ONLY for long slender columns where \u03bb >= \u03bb_crit = sqrt(\u03c0^2 * E / \u03c3_y) (~89 for structural steel). (4) RANKINE'S FORMULA: For short and intermediate columns that fail by combined crushing and inelastic buckling: 1/P_R = 1/P_c + 1/P_E -> P_R = (\u03c3_c * A) / (1 + a * \u03bb^2) where a = \u03c3_c / (\u03c0^2 * E). For very small \u03bb -> P_R \u2248 P_c (Pure crushing); for very large \u03bb -> P_R \u2248 P_E (Pure Euler buckling)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Column Stability Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Radius of Gyration (r)", "right": "r = sqrt(I / A), measuring cross-sectional distribution of material about the neutral axis" },
        { "left": "Slenderness Ratio (\u03bb)", "right": "\u03bb = L_e / r_min, non-dimensional index determining vulnerability to elastic buckling" },
        { "left": "Rankine's Constant (a)", "right": "a = \u03c3_c / (\u03c0^2 * E), empirical coefficient reconciling crushing and elastic buckling" },
        { "left": "Critical Transition Slenderness", "right": "\u03bb_crit = sqrt(\u03c0^2 * E / \u03c3_y), dividing short inelastic columns from long elastic Euler columns" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is Euler's column buckling formula (P_cr = \u03c0^2*E*I / L_e^2) completely invalid for predicting the failure load of short, stocky columns?",
      "options": [
        { "text": "Euler's derivation assumes perfectly linear elastic behavior (Hooke's Law) and fails by geometric lateral instability; for short, stocky columns with low slenderness ratios (\u03bb < \u03bb_crit), the Euler formula predicts an impossibly high theoretical critical stress that far exceeds the material's compressive yield strength (\u03c3_cr > \u03c3_y); in reality, short columns fail by material yielding and plastic compressive crushing (P_c = \u03c3_c * A) long before the theoretical elastic Euler buckling load can ever be reached", "isCorrect": true, "explanation": "Correct! This is Ferdinand Beer and Russell Johnston's fundamental limitation on Euler column theory (*Mechanics of Materials* Chapter 10). 1. **Euler's Mathematical Assumption:** - Euler's equation assumes the column material remains **100% linear elastic** ($\sigma = E \epsilon$) during the onset of buckling. 2. **What Happens as Length $L \to 0$ (Short Column):** - Critical stress: $\\sigma_{\\text{cr}} = \\frac{\\pi^2 E}{\\lambda^2}$. - If a steel column ($\sigma_y = 250\\text{ MPa}$, $E = 200\\text{ GPa}$) has a low slenderness ratio $\\lambda = 20$: $$\\sigma_{\\text{cr}} = \\frac{\\pi^2 (200,000\\text{ MPa})}{20^2} = \\frac{1,973,920}{400} = \\mathbf{4,934\\text{ MPa}!}$$ - This predicts the column will support nearly $5,000\\text{ MPa}$, which is **20 times higher than the yield strength of steel**! 3. **The Real Physical Reality:** - The steel column will permanently yield, crush, and squish plastically as soon as stress hits $\\sigma_y = 250\\text{ MPa}$! - Therefore, Euler is ONLY valid for $\\lambda \\ge \\sqrt{\\frac{\\pi^2 E}{\\sigma_y}} \\approx 89$! For $\\lambda < 89$, engineers use **Rankine-Gordon, Johnson parabolic, or AISC inelastic column equations**!" },
        { "text": "Because short columns do not experience gravity forces", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Leonhard Euler forgot to include the radius in his notes", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because short columns can only buckle at absolute zero temperature", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The dimensionless ratio of a column's effective length to its minimum radius of gyration is the ___ ratio.",
      "blankAnswer": "slenderness",
      "blankDistractors": ["poisson", "aspect", "torsion"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Torsion & Column Stability Studio: Shafts & Euler",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Torsion & Column Stability Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Shaft Torsion, Euler Buckling & Rankine Synthesis</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnTor\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Shaft Torsion & Power</button><button id=\"btnEul\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Euler Column Buckling</button><button id=\"btnRan\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Slenderness & Rankine Curve</button></div><div id=\"tcLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to compute shaft torsion...</div><script>document.getElementById('btnTor').onclick=()=>{document.getElementById('tcLog').innerHTML='<b>1. CIRCULAR SHAFT TORSION:</b><br>• Power P = 31.4 kW @ 600 RPM &rarr; <b style=\"color:#10b981;\">Torque T = 500 N\\u00b7m</b><br>• Polar J = \\u03c0*d^4/32 | Angle of twist: \\u03b8 = TL/(GJ)<br>• Hollow shaft: 70% higher torque for equal metal mass!';}; document.getElementById('btnEul').onclick=()=>{document.getElementById('tcLog').innerHTML='<b>2. EULER COLUMN BUCKLING:</b><br>• Fixed-Pinned: K = 0.7 &rarr; Le = 2.8m (L = 4.0m)<br>• Weak Axis: I_min = 1.042x10^-6 m^4<br>• <b style=\"color:#38bdf8;\">P_cr = \\u03c0^2*E*I_min / Le^2 = 262.3 kN!</b>';}; document.getElementById('btnRan').onclick=()=>{document.getElementById('tcLog').innerHTML='<b>3. SLENDERNESS \\& RANKINE SYNTHESIS:</b><br>• \\u03bb = Le / r_min = 96.5 (> \\u03bb_crit = 89 &rarr; Elastic Euler)<br>• Short column: P_R &rarr; \\u03c3_c * A (Pure Crushing)<br>• Rankine formula unified 100% across all lengths!<br>🏆 <b style=\"color:#10b981;\">Engineering Mechanics & SOM 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
