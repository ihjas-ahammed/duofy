# Duofy Reusable Lesson Format: Network Solvers (Cramer's Rule & Bridge Circuits)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Electric_Circuits_and_Network_Theory / KVL_KCL_and_Node_Mesh_Analysis`  
**Lesson Format Type:** `cramers_rule_matrix_solvers_and_bridge_circuit_synthesis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify systematic matrix solvers, Cramer's determinant rule, Wheatstone/bridge network analysis, and circuit topology invariants in multi-loop multi-node networks (Gabriel Cramer 1750; Charles K. Alexander & Matthew N.O. Sadiku *Fundamentals of Electric Circuits* Chapters 2 & 3; James W. Nilsson Chapters 3 & 4): master **Cramer's Determinant Rule for Simultaneous Linear Circuit Equations**:
$$\mathbf{x_k = \frac{\det(\mathbf{A}_k)}{\det(\mathbf{A})} \quad \Big| \quad \Delta = \det(\mathbf{A}) \ne 0}$$
where $\mathbf{A}_k$ is formed by replacing the $k$-th column of coefficient matrix $\mathbf{A}$ with the source vector $\mathbf{B}$; master **Unbalanced Wheatstone Bridge Analysis** (evaluating galvanometer detector current $I_g$ using $3 \times 3$ mesh analysis where $\det(\mathbf{R})$ governs bridge sensitivity); master the **Balanced Bridge Condition ($\mathbf{\frac{R_1}{R_2} = \frac{R_3}{R_4} \implies V_{\text{detector}} = 0, \ I_g = 0}$)**, and interact with live KCL supernode solver, KVL supermesh simulator, Dependent source amplifier designer, and Wheatstone bridge matrix calculator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cramer's Matrix Rule ($x_k = \frac{\Delta_k}{\Delta}$) & Balanced Bridge ($\frac{R_1}{R_2} = \frac{R_3}{R_4}$) Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Circuit Analysis Method / Matrix Structure & Technical Operational Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Nodal Analysis Is Mathematically Preferred Over Mesh Analysis in Non-Planar 3D Integrated Circuits Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Determinant Method Used to Solve Simultaneous Linear Circuit Matrices [A][X] = [B] Is ___ Rule (Cramer's / Cramer) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Circuit Analysis Studio: KCL Supernode, KVL Supermesh, Dependent Sources & Bridge Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cramers_rule_matrix_solvers_and_bridge_circuit_synthesis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How does Cramer's Rule solve circuit matrices, and what is the Balanced Wheatstone Bridge condition?",
      "blankAnswer": "Network Solvers & Bridges (Alexander & Sadiku): (1) CRAMER'S RULE: For matrix [A][X] = [B], unknown x_k = \u0394_k / \u0394 where \u0394 = det(A) and \u0394_k is the determinant formed by replacing column k with vector B. Requires \u0394 != 0. (2) WHEATSTONE BRIDGE: 5-resistor bridge network with central detector. (3) BALANCED BRIDGE CONDITION: R1 / R2 = R3 / R4 \u2192 Detector voltage V_g = 0 V and detector current I_g = 0 A! Allows central resistor to be treated as an open or short circuit. (4) TOPOLOGY INVARIANT: Nodal Analysis works on ALL circuit graphs (planar and non-planar), whereas Mesh Analysis is strictly limited to 2D planar circuits!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Circuit Solver / Topology Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Cramer's Rule", "right": "xk = det(Ak) / det(A), analytical determinant ratio formula for exact solutions of linear systems" },
        { "left": "Balanced Bridge (R1/R2 = R3/R4)", "right": "Zero-deflection condition where bridge detector carries zero current (Ig = 0) and zero voltage drop" },
        { "left": "Non-Planar Graph Invariant", "right": "Circuit topologies with crossing branches that cannot be analyzed by Mesh Analysis (requiring Nodal Analysis)" },
        { "left": "Fundamental Cutset Matrix", "right": "Graph-theoretic matrix representation of Kirchhoff's Current Law across arbitrary network cuts" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In advanced integrated circuit (IC) design and multi-layer printed circuit boards (PCBs) containing complex 3D wire crossings, why is Nodal Analysis universally implemented in SPICE simulation software instead of Mesh Analysis?",
      "options": [
        { "text": "Mesh analysis relies on the topological concept of mesh loops ('window panes'), which are strictly defined only for two-dimensional planar circuits; when an IC or multi-layer PCB contains crossing non-connecting traces, the circuit graph becomes non-planar, causing mesh analysis to completely fail; in contrast, Nodal Analysis (KCL) depends solely on the conservation of charge at individual nodes, making it universally applicable to any arbitrary network geometry regardless of planarity or spatial dimensions", "isCorrect": true, "explanation": "Correct! This is Charles Alexander and Matthew Sadiku's fundamental graph-theoretic comparison (*Fundamentals of Electric Circuits* Chapter 3). 1. **Planar vs Non-Planar Graphs:** - A **planar circuit** can be drawn on a 2D plane with zero crossing branches. Mesh analysis defines mesh currents for each 'window pane'. - A **non-planar circuit** (e.g. 3D ICs, multi-layer PCBs, or complete graphs $K_5$) has crossing wires that cannot be untangled into flat window panes. - In non-planar networks, **mesh analysis cannot be formulated**! 2. **The Universality of Nodal Analysis:** - Nodal analysis applies KCL to node boundaries ($\\sum i = 0$). - It does not care how branches are physically routed in space. - Whether a node connects to 3 planar resistors or 50 multi-layer vias, $\\sum i_k = 0$ holds with mathematical perfection! 3. **Industry Standard:** This is why all modern industrial circuit simulators (SPICE, Cadence Spectre, Keysight ADS) use **Modified Nodal Analysis (MNA)** as their core numerical engine!" },
        { "text": "Because mesh analysis only works with DC battery circuits", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because resistors do not follow Ohm's law in mesh analysis", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because computers cannot calculate matrix determinants", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The determinant-based matrix method used to solve simultaneous linear circuit equations [A][X] = [B] is ___ rule.",
      "blankAnswer": "Cramer's",
      "blankDistractors": ["Newton's", "Taylor's", "Fourier's"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Circuit Analysis Studio: KCL, KVL, Supernodes & Bridges",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Circuit Analysis & Network Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">KCL Supernodes, KVL Supermeshes & Dependent Sources</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnNode\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Supernode (v1=11.33V)</button><button id=\"btnMesh\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Supermesh (i1=1.2A)</button><button id=\"btnActive\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. VCCS Active & Bridge Synthesis</button></div><div id=\"circLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to solve supernode circuit...</div><script>document.getElementById('btnNode').onclick=()=>{document.getElementById('circLog').innerHTML='<b>1. KCL SUPERNODE WITH FLOATING VOLTAGE SOURCE:</b><br>• Floating 10V source between nodes 1 & 2: v1 - v2 = 10V<br>• Supernode KCL: v1/2 + v2/4 = 6A &rarr; 2*v1 + v2 = 24<br>• <b style=\"color:#10b981;\">Node Voltages: v1 = 11.33 V (34/3 V), v2 = 1.33 V (4/3 V)!</b>';}; document.getElementById('btnMesh').onclick=()=>{document.getElementById('circLog').innerHTML='<b>2. KVL SUPERMESH WITH SHARED CURRENT SOURCE:</b><br>• Shared 2A source: i2 - i1 = 2A<br>• Supermesh KVL: -20 + 6*i1 + 4*i2 = 0 &rarr; 10*i1 = 12<br>• <b style=\"color:#38bdf8;\">Mesh Currents: i1 = 1.20 A, i2 = 3.20 A!</b>';}; document.getElementById('btnActive').onclick=()=>{document.getElementById('circLog').innerHTML='<b>3. ACTIVE VCCS \\& BRIDGE SOLVERS:</b><br>• VCCS: id = 2*v1 &rarr; v1 = 2.29 V, v2 = -4.57 V<br>• Balanced Bridge: R1/R2 = R3/R4 &rarr; Ig = 0 A, Vg = 0 V!<br>• Cramer\\\'s Rule: Solves [G][V] = [I] for any N-node network!<br>🏆 <b style=\"color:#10b981;\">KVL, KCL, and Node/Mesh Analysis 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
