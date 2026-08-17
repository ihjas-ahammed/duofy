# Duofy Reusable Lesson Format: Indeterminate Trusses (Consistent Deformations & Force Method)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Structural_Analysis_and_Mechanics / Determinate_and_Indeterminate_Trusses`  
**Lesson Format Type:** `indeterminate_trusses_consistent_deformations_and_force_method`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the analysis of statically indeterminate planar trusses (internally redundant diagonals or externally redundant extra support reactions) using the classical **Method of Consistent Deformations (Force Method)**, primary determinate releases, primary deflections ($\Delta_{10}$), flexibility coefficients ($\delta_{11}$), geometric compatibility equations, and superposition of member forces (Russell C. Hibbeler *Structural Analysis* 10th ed. Chapter 10; Aslam Kassimali *Structural Analysis* 6th ed. Chapter 13): formulate the **Compatibility Equation for 1st-Degree Indeterminate Trusses**:
$$\mathbf{\Delta_{10} + X_1 \cdot \delta_{11} = 0 \implies \mathbf{X_1 = - \frac{\Delta_{10}}{\delta_{11}}}}$$
where:
1. **$X_1$:** Unknown redundant force (internal tie bar tension $F_{\text{redundant}}$ or external support reaction $R_{\text{redundant}}$);
2. **Primary Deflection ($\Delta_{10}$):** Relative displacement between the cut ends of the redundant member on the primary determinate truss subjected to actual external loads:
   $$\mathbf{\Delta_{10} = \sum_{k=1}^M \frac{n_{1,k} \cdot N_{0,k} \cdot L_k}{A_k E_k}}$$
3. **Flexibility Coefficient ($\delta_{11}$):** Relative displacement between the cut ends caused by a pair of unit internal forces ($X_1 = 1.0\text{ kN}$) applied to the primary structure:
   $$\mathbf{\delta_{11} = \sum_{k=1}^M \frac{n_{1,k}^2 \cdot L_k}{A_k E_k} + \frac{L_1}{A_1 E_1} \quad (\text{Including deformation of the redundant bar itself!})}$$
derive the **Superposition of Final Internal Member Forces**:
$$\mathbf{N_{\text{final},k} = N_{0,k} + X_1 \cdot n_{1,k}}$$
(proving that indeterminate trusses are intrinsically stiffer and distribute load across redundant load paths, preventing catastrophic collapse upon single-bar damage); and interact with live Truss determinacy checker, Method of Joints calculator, Virtual Work deflection integrator, and Consistent Deformations redundant force optimizer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Force Method Compatibility ($\Delta_{10} + X_1 \delta_{11} = 0$), Flexibility ($\delta_{11}$) & Superposition Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Solve an Internally Indeterminate X-Braced Truss Using Consistent Deformations Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Force Method Parameter / Intermediate Value & Technical Physical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Method of Consistent Deformations, the Equation Enforcing Displacement Compatibility at the Released Redundant Is $\Delta_{10} + X_1 \delta_{11} = $ ___ (Zero / 0) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Truss Mechanics Studio: Determinacy, Method of Joints, Virtual Work & Force Method Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "indeterminate_trusses_consistent_deformations_and_force_method",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How does the Method of Consistent Deformations (Force Method) solve statically indeterminate trusses?",
      "blankAnswer": "Force Method for Indeterminate Trusses (Russell Hibbeler): (1) RELEASE REDUNDANT: Cut the redundant member (or remove extra reaction) to form a primary determinate structure. (2) PRIMARY DEFLECTION: Compute unwanted displacement \u039410 = \u2211 (n1 * N0 * L / AE) under real external loads. (3) FLEXIBILITY COEFFICIENT: Compute displacement \u03b411 = \u2211 (n1^2 * L / AE) + (L1 / A1*E1) caused by unit redundant force X1 = 1. (4) COMPATIBILITY: Set \u039410 + X1 * \u03b411 = 0 \u2192 X1 = -\u039410 / \u03b411. (5) SUPERPOSITION: Final forces: N_final = N0 + X1 * n1!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to solve a statically indeterminate truss using the Method of Consistent Deformations.",
      "orderItems": [
        "Determine the degree of static indeterminacy DSI = b + r - 2j and select redundant force(s) X1",
        "Cut the redundant member to establish a stable, statically determinate primary structure",
        "Analyze the primary structure under real external service loads to find primary axial forces (N0) and deflection \u039410 = \u2211 (n1*N0*L / AE)",
        "Apply a unit redundant force X1 = 1.0 to the primary structure to compute virtual forces (n1) and flexibility coefficient \u03b411 = \u2211 (n1^2*L / AE)",
        "Solve the compatibility equation \u039410 + X1*\u03b411 = 0 for X1 = -\u039410/\u03b411 and superimpose final member forces: N = N0 + X1*n1"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Force Method Term to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Primary Deflection (\u039410)", "right": "Relative displacement between cut ends of redundant bar under external loads: \u039410 = \u2211 (n1*N0*L / AE)" },
        { "left": "Flexibility Coefficient (\u03b411)", "right": "Relative displacement caused by applying a pair of unit internal forces X1 = 1.0 to the cut ends" },
        { "left": "Compatibility Equation", "right": "\u039410 + X1*\u03b411 = 0, enforcing physical continuity by requiring net relative deformation to equal zero" },
        { "left": "Superposition Formula", "right": "N_final = N0 + X1*n1, combining primary determinate forces with scaled redundant forces" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Method of Consistent Deformations, the compatibility equation enforcing displacement continuity at the cut redundant is \u039410 + X1 * \u03b411 = ___.",
      "blankAnswer": "0",
      "blankDistractors": ["1", "infinity", "AE"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Truss Mechanics & Structural Analysis Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Truss Mechanics & Analysis Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Determinacy, Joints/Sections, Virtual Work & Force Method</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnDet\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Determinacy & Sections (F_BD = -120kN)</button><button id=\"btnVirt\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Virtual Work Deflection (\u0394 = 6.72mm)</button><button id=\"btnIndet\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Indeterminate Force Method (X1 = -\u039410/\u03b411)</button></div><div id=\"trussLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate truss statics...</div><script>document.getElementById('btnDet').onclick=()=>{document.getElementById('trussLog').innerHTML='<b>1. TRUSS STATICS \\& METHOD OF SECTIONS:</b><br>• Determinacy: DSI = b + r - 2j = 0 (Determinate!)<br>• Method of Sections: \\u2211M_C = 0 &rarr; <b style=\"color:#10b981;\">F_BD = -120.0 kN (Compression)!</b><br>• Zero-Force Rules: Unloaded 2-member & 3-member joints!';}; document.getElementById('btnVirt').onclick=()=>{document.getElementById('trussLog').innerHTML='<b>2. VIRTUAL WORK (UNIT LOAD METHOD):</b><br>• Mechanical: \\u0394_mech = \\u2211(n*N*L)/AE = 6.00 mm<br>• Thermal: \\u0394_temp = n*\\u03b1*\\u0394T*L = 0.72 mm (+30\u00b0C)<br>• <b style=\"color:#38bdf8;\">Total Center Deflection: \\u0394_C = 6.72 mm!</b>';}; document.getElementById('btnIndet').onclick=()=>{document.getElementById('trussLog').innerHTML='<b>3. INDETERMINATE FORCE METHOD:</b><br>• Release redundant &rarr; Solve primary N0 & \\u039410<br>• Unit redundant X1=1 &rarr; Solve n1 & \\u03b411<br>• Compatibility: <b style=\"color:#10b981;\">\\u039410 + X1*\\u03b411 = 0 &rarr; X1 = -\\u039410/\\u03b411</b><br>• Final member forces: N = N0 + X1*n1<br>🏆 <b style=\"color:#10b981;\">Determinate_and_Indeterminate_Trusses 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
