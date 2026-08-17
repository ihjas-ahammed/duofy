# Duofy Reusable Lesson Format: Pile Groups (Efficiency, Block Failure & Settlement)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Geotechnical_Engineering_and_Soil_Mechanics / Shallow_and_Deep_Foundations`  
**Lesson Format Type:** `pile_group_efficiency_block_failure_and_settlement`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the behavior of pile groups embedded in cohesive and cohesionless soils, pile group spacing criteria ($s \ge 2.5D - 3.5D$), group efficiency factor ($\eta$), the **Converse-Labarre Formula**, the dual failure modes of pile groups in clay ((1) individual pile failure $n \cdot Q_{\text{single}}$ vs (2) **Block Shear Failure of the Entire Soil-Pile Monolith $Q_{ug}$**), and group settlement prediction via the Equivalent Raft Method founded at $2/3 D$ embedment depth (Braja M. Das *Principles of Foundation Engineering* 9th ed. Chapter 11; Joseph E. Bowles *Foundation Analysis and Design* Chapter 18): formulate the **Converse-Labarre Pile Group Efficiency Equation**:
$$\mathbf{\eta = 1 - \theta \left[ \frac{(n-1)m + (m-1)n}{90 \cdot m \cdot n} \right] \quad \left(\theta = \arctan\left(\frac{D}{s}\right) \text{ in degrees}\right)}$$
where $m$ is the number of rows and $n$ is the number of columns of piles in the group;
derive the **Block Failure Capacity in Cohesive Clay ($Q_{ug}$)**:
- Treating the pile group as an equivalent solid block of dimensions $B_g \times L_g \times D$:
  $$\mathbf{Q_{ug} = Q_{p,\text{block}} + Q_{s,\text{block}} = \left( 9 c_u \right) \left( B_g \cdot L_g \right) + \sum 2 \left( B_g + L_g \right) c_u \cdot D}$$
derive the **Governing Design Group Capacity ($Q_{\text{design,group}}$)**:
$$\mathbf{Q_{u,\text{governing}} = \min\left( \sum_{i=1}^{m \cdot n} Q_{u,\text{single}}, \ Q_{ug} \right) \implies \mathbf{Q_{\text{all,group}} = \frac{Q_{u,\text{governing}}}{FS} \quad (FS = 2.5 - 3.0)}}$$
(proving that closely spaced piles in soft clays act as a solid block that triggers perimeter punching shear rather than individual skin friction failure); and interact with live Terzaghi bearing capacity calculator, Meyerhof general footing simulator, Single pile alpha/beta evaluator, and Pile group block capacity optimizer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Group Efficiency ($\eta$), Block Failure ($Q_{ug} = 9 c_u B_g L_g + 2(B_g+L_g)c_u D$) & $\min$ Rule Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Check Individual vs Block Capacity for a 3x3 Pile Group in Clay Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Pile Group Interaction Parameter / Failure Mode & Technical Geotechnical Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Cohesive Soils, When the Center-to-Center Pile Spacing Is Small, the Entire Pile-Soil Mass Tends to Fail Together as a Solid Single Block via ___ Failure (Block / Block Shear) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Foundation Engineering Studio: Terzaghi, Meyerhof, Deep Piles & Pile Group Block Action Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "pile_group_efficiency_block_failure_and_settlement",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Pile Group Block Failure in cohesive clay, and how is the governing capacity of a pile group determined?",
      "blankAnswer": "Pile Group Block Mechanics (Braja M. Das): (1) BLOCK SHEAR FAILURE: For closely spaced piles (s < 3D) in soft clay, the soil between piles locks together, causing the entire block (Bg x Lg x D) to punch into the subsoil. (2) BLOCK CAPACITY: Q_ug = (9*cu)*(Bg*Lg) + 2*(Bg + Lg)*cu*D. (3) INDIVIDUAL SUM: Q_ind = n * Q_single. (4) GOVERNING CAPACITY: Qu,group = min(n * Q_single, Q_ug). (5) CONVERSE-LABARRE EFFICIENCY: \u03b7 = 1 - \u03b8*[(n-1)m + (m-1)n] / (90*m*n), where \u03b8 = arctan(D/s) in degrees!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to evaluate the governing ultimate axial capacity of a 3x3 pile group in cohesive clay.",
      "orderItems": [
        "Calculate the single pile ultimate capacity: Qu,single = 9*cu*Ap + \u03b1*cu*\u03c0*D*L and find individual sum: \u2211Qu = N_piles * Qu,single",
        "Determine the overall plan dimensions of the pile group block: Bg = (n-1)*s + D and Lg = (m-1)*s + D",
        "Calculate the base end-bearing resistance of the equivalent solid block: Qp,block = 9 * cu * (Bg * Lg)",
        "Calculate the shaft skin resistance along the 4 outer vertical faces of the block: Qs,block = 2 * (Bg + Lg) * cu * L",
        "Sum block capacity: Q_ug = Qp,block + Qs,block and select the governing capacity: Qu = min(\u2211Qu, Q_ug)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Pile Group Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Block Shear Failure (Q_ug)", "right": "Monolithic failure of the entire soil-pile perimeter block governing closely spaced piles in soft clay" },
        { "left": "Individual Failure Sum (n*Qu)", "right": "Total capacity obtained by summing isolated single pile resistances without group overlap" },
        { "left": "Converse-Labarre Efficiency (\u03b7)", "right": "Empirical reduction factor based on pile spacing s, diameter D, and grid layout (m x n)" },
        { "left": "Equivalent Raft Settlement", "right": "Settlement analysis method placing a fictitious mat footing at 2/3 of the pile embedment depth" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In cohesive soils with closely spaced piles, the entire pile-soil mass tends to fail together as a solid single unit via ___ failure.",
      "blankAnswer": "block",
      "blankDistractors": ["punching", "tensile", "elastic"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Geotechnical Foundation Engineering Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Foundation Engineering & Geotechnics Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Terzaghi, Meyerhof General, Deep Piles & Pile Groups</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnTerz\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Terzaghi Shallow (Q_all = 1271kN)</button><button id=\"btnMey\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Meyerhof General (qu = 994.3kPa)</button><button id=\"btnPile\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Deep Piles (622kN) & Group Block</button></div><div id=\"foundLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate shallow Terzaghi bearing...</div><script>document.getElementById('btnTerz').onclick=()=>{document.getElementById('foundLog').innerHTML='<b>1. TERZAGHI SHALLOW BEARING CAPACITY:</b><br>• Square Footing: qu = 1.3*c\\\'*Nc + q*Nq + 0.4*\\u03b3*B*N\\u03b3<br>• qu = 490.0 + 343.4 + 120.1 = <b style=\"color:#10b981;\">953.6 kPa!</b><br>• <b style=\"color:#38bdf8;\">Allowable Column Load: Q_all = (953.6/3) * 4.0 = 1271.4 kN!</b>';}; document.getElementById('btnMey').onclick=()=>{document.getElementById('foundLog').innerHTML='<b>2. MEYERHOF GENERAL BEARING CAPACITY:</b><br>• Incorporates Shape (s), Depth (d), and Inclination (i) factors<br>• Rectangular Sand: qu = q*Nq*sq*dq + 0.5*\\u03b3*B*N\\u03b3*s\\u03b3*d\\u03b3<br>• <b style=\"color:#10b981;\">qu = 825.0 + 169.2 = 994.3 kPa!</b>';}; document.getElementById('btnPile').onclick=()=>{document.getElementById('foundLog').innerHTML='<b>3. DEEP PILES \\& PILE GROUP BLOCK ACTION:</b><br>• Single Pile (\\u03b1-method): Qu = 9*cu*Ap + \\u03b1*cu*p*L = <b style=\"color:#10b981;\">622.1 kN!</b><br>• Pile Group Block: Q_ug = (9*cu)*Bg*Lg + 2*(Bg+Lg)*cu*L<br>• Governing: Qu,group = min(n*Qu,single, Q_ug)<br>🏆 <b style=\"color:#10b981;\">Geotechnical_Engineering_and_Soil_Mechanics (ALL 3 LEAF DIRS) 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
