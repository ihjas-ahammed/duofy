# Duofy Reusable Lesson Format: Structural Assembly (Code Numbering & Member Force Recovery)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Structural_Analysis_and_Mechanics / Matrix_Stiffness_Methods`  
**Lesson Format Type:** `structural_matrix_assembly_boundary_conditions_and_member_forces`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the direct assembly of the global structural stiffness matrix ($\mathbf{K}$) using the member code numbering vector, enforcement of kinematic boundary constraints, solution of unknown nodal displacements via Gaussian elimination / matrix inversion ($\mathbf{D}_u = \mathbf{K}_{11}^{-1} \mathbf{P}_k$), and the post-processing transformation of global joint displacements back into local internal member forces ($\mathbf{q} = \mathbf{k}' \mathbf{T} \mathbf{d} + \mathbf{F}_{\text{fixed}}$) for automated structural FEA solvers (William Weaver Jr. & James M. Gere *Matrix Analysis of Framed Structures* 3rd ed. Chapters 2 & 3; Aslam Kassimali *Matrix Analysis of Structures* 2nd ed. Chapter 4): formulate the **Member Code Numbering & Direct Stamping Assembly**:
$$\mathbf{\text{Member Code Vector: } \mathbf{C}_{\text{elem}} = \left[ c_1, c_2, c_3, c_4 \right]^T \implies \mathbf{K}(c_i, c_j) = \mathbf{K}(c_i, c_j) + k_{\text{elem}}(i, j)}$$
(where $c_i = 0$ indicates a fully restrained rigid support boundary that is skipped during assembly of the unconstrained $\mathbf{K}_{11}$ matrix);
master the **Internal Member Force Recovery Protocol**:
1. Extract global displacement vector $\mathbf{d}$ for element Near and Far nodes from solved structural displacement vector $\mathbf{D}_u$;
2. Transform global displacements to local element axis: $\mathbf{d}' = \mathbf{T} \mathbf{d}$;
3. Compute local internal axial forces, shears, and bending moments:
   $$\mathbf{\mathbf{q}_{\text{local}} = \mathbf{k}' \cdot \mathbf{T} \cdot \mathbf{d} + \mathbf{F}_{\text{fixed}}}$$
(proving that the direct stiffness method provides an end-to-end algorithmic pipeline from CAD coordinates to design-ready axial forces and moment diagrams); and interact with live Direct Stiffness matrix partitioner, 2D Truss element transformer, Beam flexural stiffness calculator, and Global matrix assembly & member force explorer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Code Numbering Stamping, Assembly ($\mathbf{K}(c_i, c_j) \mathrel{+}= k_{ij}$) & Force Recovery ($\mathbf{q} = \mathbf{k}'\mathbf{T}\mathbf{d}+\mathbf{F}$) Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Assemble the Global Matrix K and Recover Member Forces for a 2-Bar Truss Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Computational Matrix Entity / Assembly Step & Technical Algorithmic Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Matrix Structural Analysis, the Method of Stamping Element Matrices Directly into the Global Stiffness Matrix Using Degree of Freedom Indices Is ___ Assembly (Direct / Direct Stiffness) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Computational Structural Mechanics Studio: Direct Stiffness, Truss Transformations, Beam Matrices & Assembly Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "structural_matrix_assembly_boundary_conditions_and_member_forces",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Direct Stamping Assembly method, and how are local internal member forces recovered in the Direct Stiffness Method?",
      "blankAnswer": "Matrix Structural Assembly & Force Recovery (Weaver & Gere): (1) CODE NUMBERING ASSEMBLY: Assign each member a 4-entry code vector [c1, c2, c3, c4] matching its global DOF indices. Stamp element entries directly into global matrix: K(ci, cj) += k_elem(i, j). (2) BOUNDARY CONDITIONS: Prescribed zero DOFs (supports) are filtered out to form reduced invertible matrix K11. (3) DISPLACEMENT SOLUTION: D_u = K11^(-1) * P_k. (4) MEMBER FORCE RECOVERY: For each element, extract global displacements d, transform to local d' = T*d, and compute internal member forces: q = k' * T * d + F_fixed!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the complete automated Direct Stiffness Analysis algorithm.",
      "orderItems": [
        "Assign global degree-of-freedom code numbers to all nodes, numbering unconstrained active DOFs before support restraints",
        "Compute element stiffness matrices in global coordinates (k = T^T * k' * T) for every structural member",
        "Assemble the global structure stiffness matrix K by direct stamping using element code numbers: K(ci, cj) += k(i, j)",
        "Formulate the global load vector P_k (including equivalent loads) and solve for unknown displacements: D_u = K11^(-1) * P_k",
        "Recover local internal member forces for each element using the post-processing equation: q = k' * T * d + F_fixed"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Matrix Assembly Operation to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Member Code Vector [c1..c4]", "right": "Ordered list of global degree-of-freedom indices assigned to the Near and Far nodes of an element" },
        { "left": "Direct Matrix Stamping", "right": "K(ci, cj) += k_elem(i, j), accumulating overlapping stiffness contributions at shared physical joints" },
        { "left": "Member Force Equation", "right": "q = k'*T*d + F_fixed, extracting local axial forces, shears, and moments from solved nodal displacements" },
        { "left": "Boundary Filtering", "right": "Zeroing out restrained support rows and columns to yield the non-singular positive-definite K11 matrix" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In matrix structural analysis, the method of stamping element matrices directly into the global stiffness matrix using degree-of-freedom indices is ___ assembly.",
      "blankAnswer": "direct",
      "blankDistractors": ["indirect", "virtual", "harmonic"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Computational Structural Mechanics Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Computational Structural Analysis Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Direct Stiffness, 2D Truss \u03bb-Transforms, Beam Matrices & Assembly</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnPart\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Partitioned Direct Stiffness (D1=200mm)</button><button id=\"btnTruss\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. 2D Truss \u03bb-Matrix (k11=500kN/m)</button><button id=\"btnBeam\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Beam Matrix (4EI/L) & Force Recovery</button></div><div id=\"femLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate direct stiffness partitioning...</div><script>document.getElementById('btnPart').onclick=()=>{document.getElementById('femLog').innerHTML='<b>1. DIRECT STIFFNESS PARTITIONING:</b><br>• System: [Pk; Pu] = [K11 K12; K21 K22] * [Du; Dk]<br>• <b style=\"color:#10b981;\">Displacements: Du = K11^-1 * Pk = 0.200 m (200 mm)!</b><br>• Support Reactions: Pu = K21 * Du = -40.0 kN!';}; document.getElementById('btnTruss').onclick=()=>{document.getElementById('femLog').innerHTML='<b>2. 2D TRUSS COORDINATE TRANSFORMATION:</b><br>• Direction Cosines: \\u03bbx = \\u03bby = 1/\\u221a2 = 0.7071 (45\u00b0 diagonal)<br>• <b style=\"color:#38bdf8;\">Global Stiffness: k11 = (AE/L)*\\u03bbx^2 = 500.0 kN/m!</b><br>• Symmetric dyadic block structure k = T^T * k\\\' * T';}; document.getElementById('btnBeam').onclick=()=>{document.getElementById('femLog').innerHTML='<b>3. BEAM MATRIX \\& MEMBER FORCE RECOVERY:</b><br>• Beam Matrix: k22\\\' = 4EI/L = 24000 kNm/rad, k11\\\' = 12EI/L^3 = 2000 kN/m<br>• Equivalent Loads: P_equiv = -F_fixed (Reversed FEMs)<br>• <b style=\"color:#10b981;\">Internal Forces: q = k\\\' * T * d + F_fixed!</b><br>🏆 <b style=\"color:#10b981;\">Structural_Analysis_and_Mechanics (ALL 3 LEAF DIRS) 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
