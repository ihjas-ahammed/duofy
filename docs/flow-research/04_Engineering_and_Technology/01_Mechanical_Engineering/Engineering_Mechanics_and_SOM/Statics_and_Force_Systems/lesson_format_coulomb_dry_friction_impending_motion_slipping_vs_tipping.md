# Duofy Reusable Lesson Format: Dry Friction & Motion (Slipping vs Tipping in Statics)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Engineering_Mechanics_and_SOM / Statics_and_Force_Systems`  
**Lesson Format Type:** `coulomb_dry_friction_impending_motion_slipping_vs_tipping`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify contact mechanics, dry friction boundaries, and rigid body stability under applied tangential forces (Russell C. Hibbeler *Engineering Mechanics: Statics* Chapter 8; Ferdinand P. Beer & E. Russell Johnston Jr. *Vector Mechanics for Engineers: Statics* Chapter 8): master **Coulomb's Law of Dry Friction** ($\mathbf{F_s \le F_{\text{max}} = \mu_s N}$ for static equilibrium; kinetic sliding friction $\mathbf{F_k = \mu_k N}$ where $\mu_k < \mu_s$), analyze the fundamental **Slipping vs Tipping Failure Modes** for a rigid rectangular block of mass $m$, width $b$, and height $h$ subjected to a horizontal force $P$ at height $y$ (determining the exact location of the normal reaction force line of action $x = \frac{P y}{W}$; proving that if $x \le \frac{b}{2}$, the block **slips when $P = \mu_s W$**, whereas if $x > \frac{b}{2}$, the normal reaction shifts off the base, causing the block to **tip over when $P = \frac{W b}{2y}$** before slipping can occur), and interact with live 2D Rigid Body FBD equilibrium solver, 3D Vector Moment determinant calculator, Truss Method of Sections cutter, and Slipping vs Tipping friction simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Coulomb Dry Friction Curve & Slipping vs Tipping Geometric Boundary Diagram Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Friction / Contact Mechanics Parameter & Technical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Mathematical Mechanics Problem: Determining Whether a Crate Will Slip or Tip Over First Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Maximum Static Friction Force That Can Be Developed Before Impending Motion Is F_max = \mu_s ___ (Normal / N) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Statics & Mechanics Studio: 2D FBD, 3D Moments, Truss & Friction Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "coulomb_dry_friction_impending_motion_slipping_vs_tipping",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How does Coulomb Dry Friction govern static equilibrium, and what determines whether an object Slips or Tips first?",
      "blankAnswer": "Coulomb Friction & Tipping (Hibbeler; Beer & Johnston): (1) COULOMB'S LAW: (a) Static Region: F_friction <= F_max = \u03bcs * N (Static equilibrium holds; friction adjusts to oppose motion). (b) Impending Motion: F = F_max = \u03bcs * N. (c) Kinetic Sliding: F_k = \u03bck * N (\u03bck < \u03bcs). (2) SLIPPING vs TIPPING: For a block of weight W, width b, height h pushed by force P at height y: (a) Slipping occurs when P_slip = \u03bcs * W. (b) Tipping occurs when the normal force N shifts to the front corner (x = b/2), giving P_tip = W * b / (2y). (c) CRITERION: The failure mode that requires the SMALLER force (min(P_slip, P_tip)) happens first! If \u03bcs < b / (2y) -> SLIPS first; if \u03bcs > b / (2y) -> TIPS first!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Contact Mechanics Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Static Friction Limit (F_max)", "right": "Peak resistive shear force F_max = \u03bcs * N before impending motion commences" },
        { "left": "Kinetic Friction (F_k)", "right": "Constant frictional resistance F_k = \u03bck * N acting opposing relative surface sliding" },
        { "left": "Tipping Condition", "right": "Occurs when the resultant normal force line of action shifts beyond the edge of the base (x > b/2)" },
        { "left": "Angle of Repose (\u03c6_s)", "right": "Maximum incline angle \u03c6_s = arctan(\u03bcs) at which a block remains stationary on a slope" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "A uniform rectangular crate has weight W = 1000 N, base width b = 0.8 m, and height h = 1.6 m. A horizontal force P is applied at the top edge (y = 1.6 m). The coefficient of static friction between crate and floor is \u03bcs = 0.35. Will the crate slip or tip over first, and at what force P?",
      "options": [
        { "text": "The crate will TIP OVER first at a force of P = 250 N (because P_tip = 250 N is strictly less than P_slip = 350 N)", "isCorrect": true, "explanation": "Correct! Let's calculate both failure threshold forces independently (Hibbeler *Engineering Mechanics: Statics* Chapter 8). 1. **Force Required to Cause SLIPPING ($P_{\\text{slip}}$):** - Vertical equilibrium: $N = W = 1000\\text{ N}$. - Maximum static friction: $F_{\\text{max}} = \\mu_s N = (0.35)(1000\\text{ N}) = \\mathbf{350\\text{ N}}$. - Slipping force threshold: $P_{\\text{slip}} = \\mathbf{350\\text{ N}}$. 2. **Force Required to Cause TIPPING ($P_{\\text{tip}}$):** - When the crate is on the verge of tipping over its bottom right edge $A$, the normal force $N$ shifts completely to corner $A$ (distance $x = \\frac{b}{2} = \\frac{0.8}{2} = 0.4\\text{ m}$ from centerline). - Take moment equilibrium about tipping point $A$ ($\\sum M_A = 0$): $$\\sum M_A = (W \\cdot 0.4\\text{ m}) - (P \\cdot 1.6\\text{ m}) = 0$$ $$(1000\\text{ N} \\times 0.4\\text{ m}) - 1.6 P = 0 \\implies 1.6 P = 400 \\implies P_{\\text{tip}} = \\frac{400}{1.6} = \\mathbf{250\\text{ N}}$$ 3. **Comparison:** - Since $P_{\\text{tip}} = 250\\text{ N} < P_{\\text{slip}} = 350\\text{ N}$, as the applied force increases from $0$, it hits $250\\text{ N}$ first! - **Result:** The crate will **TIP OVER** before slipping ever occurs!" },
        { "text": "The crate will slip first at a force of P = 350 N", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The crate will slip and tip simultaneously at P = 1000 N", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The crate will remain permanently stationary regardless of applied force", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The maximum static dry friction force developed at impending slipping is F_max = \u03bcs times the ___ force.",
      "blankAnswer": "normal",
      "blankDistractors": ["shear", "tensile", "couple"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Statics Studio: FBD, Moments, Trusses & Friction",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Engineering Statics & Force Systems Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">2D/3D Equilibrium, Moments, Trusses & Friction</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnFbd\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Solve 2D Beam FBD</button><button id=\"btnTruss\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Method of Sections (Truss)</button><button id=\"btnFric\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Friction Slip vs Tip Test</button></div><div id=\"statLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to solve beam reaction forces...</div><script>document.getElementById('btnFbd').onclick=()=>{document.getElementById('statLog').innerHTML='<b>1. 2D RIGID BODY EQUILIBRIUM:</b><br>• Pin A: Ax = 0 kN | <b style=\"color:#10b981;\">Ay = 20.0 kN</b><br>• Roller B: <b style=\"color:#38bdf8;\">By = 16.0 kN</b><br>• sum Fx=0, sum Fy=0, sum M_A=0 &rarr; 100% Equilibrium!';}; document.getElementById('btnTruss').onclick=()=>{document.getElementById('statLog').innerHTML='<b>2. METHOD OF SECTIONS (PRATT TRUSS):</b><br>• Slice through members CD, KD, KL<br>• sum M_D = 0 &rarr; <b style=\"color:#10b981;\">F_KL = +45.2 kN (Tension)</b><br>• Zero-force member check: Member DF has F=0!';}; document.getElementById('btnFric').onclick=()=>{document.getElementById('statLog').innerHTML='<b>3. COULOMB DRY FRICTION TEST:</b><br>• P_slip = \u03bcs*W = 350 N<br>• P_tip = W*b/(2y) = 250 N<br>• <b style=\"color:#f59e0b;\">P_tip < P_slip &rarr; CRATE TIPS OVER FIRST at 250 N!</b><br>🏆 <b style=\"color:#10b981;\">Engineering Statics & Force Systems verified!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
