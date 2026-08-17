# Duofy Reusable Lesson Format: Advanced Hardy Cross (Modified Stiffness & Sidesway)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Structural_Analysis_and_Mechanics / Slope_Deflection_and_Moment_Distribution`  
**Lesson Format Type:** `moment_distribution_with_sidesway_and_modified_stiffness`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify advanced applications of the Moment Distribution Method: utilizing **Modified Flexural Stiffness ($K = \frac{3EI}{L}$)** for end spans terminating in simple pins/rollers to eliminate endless carry-over cycles, analyzing symmetrical/antisymmetrical continuous structures, and solving multi-story unbraced frames subjected to **Sidesway ($\Delta$)** via the Superposition of No-Sway ($M_{\text{no-sway}}$) and Unit Sway ($M_{\text{sway}}$) distribution passes calibrated by Story Shear Equilibrium ($\sum F_x = 0$) (Russell C. Hibbeler *Structural Analysis* 10th ed. Chapter 12; Aslam Kassimali *Structural Analysis* 6th ed. Chapter 15): formulate the **Modified Stiffness for Pinned/Roller Far Ends**:
$$\mathbf{K_{\text{modified}} = \frac{3 E I}{L} = \frac{3}{4} K_{\text{standard}} \quad \Big| \quad \mathbf{\text{Modified FEM: } \text{FEM}_{AB,\text{mod}} = \text{FEM}_{AB} - \frac{\text{FEM}_{BA}}{2}} \quad \Big| \quad \mathbf{\text{COF} \to 0}}$$
(proving that setting $K = \frac{3EI}{L}$ locks the pinned end at $M = 0$ permanently, reducing total calculation steps by $50\%$);
master the **Two-Stage Sidesway Superposition Protocol for Unbraced Frames**:
1. **Stage 1 (No-Sway Analysis):** Prevent sidesway by applying an artificial horizontal restraint at the top story $\to$ Run standard moment distribution to find non-sway moments $M_0$ and calculate artificial holding force $R_0 = \sum V_{\text{cols}}$;
2. **Stage 2 (Unit Sway Analysis):** Remove all external loads $\to$ Impose an arbitrary lateral sway $\Delta' \to$ Compute initial sway fixed-end moments $\text{FEM}_{\text{sway}} = -\frac{6 E I \Delta'}{h^2} \to$ Run moment distribution to find sway moments $M' \to$ Calculate sway shear force $R' = \sum V_{\text{cols}}'$;
3. **Superposition Scaling Factor ($k$):**
   $$\mathbf{R_0 + k \cdot R' = 0 \implies \mathbf{k = - \frac{R_0}{R'}}} \implies \mathbf{M_{\text{final}} = M_0 + k \cdot M'}$$
and interact with live Continuous beam slope-deflection solver, Frame sidesway simulator, Hardy Cross iteration animator, and Advanced modified stiffness / 2-stage sidesway optimizer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Modified Stiffness ($K = \frac{3EI}{L}$), Zero Carry-Over & 2-Stage Sway ($M = M_0 + k M'$) Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution of the Two-Stage Sidesway Moment Distribution Protocol for a Portal Frame Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Advanced Moment Distribution Technique / Property & Technical Engineering Benefit Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Modified Rotational Stiffness of a Beam Member Whose Far End Terminates in a Frictionless Pin or Roller Is Equal to ___ Times EI/L (3 / Three) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Indeterminate Structural Mechanics Studio: Slope-Deflection, Story Shear & Hardy Cross Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "moment_distribution_with_sidesway_and_modified_stiffness",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Modified Stiffness in the Hardy Cross method, and how does the Two-Stage Sidesway Superposition process work?",
      "blankAnswer": "Advanced Moment Distribution (Russell Hibbeler): (1) MODIFIED STIFFNESS: For an end span with a pinned far end, use K = 3EI/L and modified FEM = FEM_near - 0.5*FEM_far. This permanently sets COF = 0 to the pin, cutting iterations in half! (2) SIDESWAY SUPERPOSITION: Stage 1: Add artificial lateral restraint to prevent sway \u2192 compute no-sway moments M0 and holding force R0. Stage 2: Impose arbitrary sway \u0394' \u2192 distribute sway moments M' and compute sway shear R'. Stage 3: Superposition scale factor k = -R0/R' \u2192 M_final = M0 + k*M'!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the Two-Stage Moment Distribution Sidesway Analysis for an unbraced building frame.",
      "orderItems": [
        "Add an artificial horizontal support at the roof level to completely prevent frame sidesway (\u0394 = 0)",
        "Perform standard moment distribution on the restrained frame under real external loads to find non-sway moments (M0)",
        "Compute the artificial horizontal reaction force R0 required to prevent sidesway from column shear equilibrium",
        "Apply an arbitrary lateral sway \u0394' with initial column FEM = -6EI\u0394'/h^2 and distribute to find sway moments (M') and shear (R')",
        "Calculate the correction factor k = -R0 / R' and superimpose final frame moments: M_final = M0 + k * M'"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Advanced Moment Distribution Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Modified Stiffness (K = 3EI/L)", "right": "Reduced flexural stiffness for members with pinned/roller far ends that sets carry-over factor to zero" },
        { "left": "Modified Fixed-End Moment", "right": "FEM_mod = FEM_near - (FEM_far / 2), accounting for released pin moment prior to distribution" },
        { "left": "Stage 1 No-Sway Restraint", "right": "Artificial fictitious roller preventing lateral story drift to isolate pure gravity loading moments M0" },
        { "left": "Superposition Scale Factor (k)", "right": "k = -R0 / R', scaling arbitrary sway deflection so net artificial restraint force equals zero" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The modified rotational stiffness of a beam member whose far end terminates in a frictionless pin or roller equals ___ times EI/L.",
      "blankAnswer": "3",
      "blankDistractors": ["4", "2", "6"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Indeterminate Structural Analysis Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Indeterminate Frame & Beam Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Slope-Deflection, Story Shear, Hardy Cross & Modified K</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnSd\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Slope-Deflection (M_BA = +18.0 kNm)</button><button id=\"btnHc\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Hardy Cross Distribution (DF=0.60)</button><button id=\"btnSway\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Frame Sway & Modified K (3EI/L)</button></div><div id=\"sdLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate slope-deflection...</div><script>document.getElementById('btnSd').onclick=()=>{document.getElementById('sdLog').innerHTML='<b>1. SLOPE-DEFLECTION METHOD:</b><br>• Equations: M_ij = FEM + (2EI/L)*(2\\u03b8_i + \\u03b8_j - 3\\u03c8)<br>• Joint Equilibrium: \\u2211M_B = 0 &rarr; \\u03b8_B = -27/EI<br>• <b style=\"color:#10b981;\">Support Moment: M_BA = +18.0 kNm!</b>';}; document.getElementById('btnHc').onclick=()=>{document.getElementById('sdLog').innerHTML='<b>2. HARDY CROSS MOMENT DISTRIBUTION:</b><br>• K = 4EI/L, DF = K / \\u2211K &rarr; DF_BA = 0.60, DF_BC = 0.40<br>• Balancing: M_dist = -DF*(\\u2211M_unbal) = <b style=\"color:#38bdf8;\">-36.0 kNm!</b><br>• Carry-Over: +0.50 * M_dist to far fixed ends!';}; document.getElementById('btnSway').onclick=()=>{document.getElementById('sdLog').innerHTML='<b>3. ADVANCED SIDESWAY \\& MODIFIED STIFFNESS:</b><br>• Pinned Far End: <b style=\"color:#10b981;\">K_mod = 3EI/L (COF = 0 permanent!)</b><br>• Frame Sidesway: Story Shear \\u2211Fx = 0 isolates \\u0394<br>• 2-Stage Superposition: M_final = M0 + (-R0/R\\\')*M\\\'<br>🏆 <b style=\"color:#10b981;\">Slope_Deflection_and_Moment_Distribution 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
