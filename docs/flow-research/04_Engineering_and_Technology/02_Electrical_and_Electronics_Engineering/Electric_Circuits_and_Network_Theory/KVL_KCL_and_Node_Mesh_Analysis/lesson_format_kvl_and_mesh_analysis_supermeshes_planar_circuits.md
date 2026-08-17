# Duofy Reusable Lesson Format: Mesh Analysis (KVL, Supermeshes, & Planar Networks)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Electric_Circuits_and_Network_Theory / KVL_KCL_and_Node_Mesh_Analysis`  
**Lesson Format Type:** `kvl_and_mesh_analysis_supermeshes_planar_circuits`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through planar circuit graph topology, mesh current assignments, Kirchhoff's Voltage Law (KVL $\sum v_k = 0$, conservation of energy in closed electrical paths), resistance matrix formulations, and shared current source supermeshes in network theory (Charles K. Alexander & Matthew N.O. Sadiku *Fundamentals of Electric Circuits* Chapter 3; William H. Hayt & Jack E. Kemmerly *Engineering Circuit Analysis* Chapter 4): formulate the **Standard Mesh Resistance Matrix**:
$$\mathbf{\begin{bmatrix} R_{11} & -R_{12} \\ -R_{21} & R_{22} \end{bmatrix} \begin{bmatrix} i_1 \\ i_2 \end{bmatrix} = \begin{bmatrix} v_1 \\ v_2 \end{bmatrix} \quad \left(R_{kk} = \sum \text{Resistances in mesh } k, \ R_{jk} = \text{Mutual Shared Resistance}\right)}$$
master the **Planar Mesh Count Invariant ($M = B - N + 1$)**; and master the **Supermesh Technique**: when an ideal current source is shared between two adjacent meshes $i_1$ and $i_2$, bypass the current source branch by creating a **Supermesh** loop encompassing both meshes, write a single KVL loop equation around the outer perimeter:
$$\mathbf{\sum_{\text{perimeter}} v_k = 0}$$
and couple it with the **Supermesh Current Source Constraint Equation**:
$$\mathbf{i_2 - i_1 = I_{\text{source}}}$$
(proving how the supermesh circumvents the unknown voltage drop across ideal current sources).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | KVL ($\sum v = 0$), Mesh Resistance Matrix ($[R][I] = [V]$) & Supermesh Constraint Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Solve Mesh Currents Using Supermesh Formulation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Mesh Analysis Construct / Circuit Topology Entity & Technical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Kirchhoff's Voltage Law (KVL) Is the Direct Electrical Embodiment of the Fundamental Law of Conservation of ___ (Energy) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Electric Network Analysis Problem: Calculating Mesh Currents in a Circuit Containing a Shared Current Source Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Mesh Analysis & Supermeshes (Alexander & Sadiku 2021; Hayt 2019):
   - **KVL & Resistance Matrix Formulations:**
     $$\mathbf{\sum_{k=1}^M v_k = 0 \quad \Big| \quad [R][I] = [V] \quad \Big| \quad M = B - N + 1}$$
   - **Supermesh Method Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Source Configuration} & \textbf{Mesh Handling Procedure} & \textbf{Governing Equations Formed} \\
     \hline
     \mathbf{\text{Current Source on Boundary}} & \text{Sets mesh current directly: } i_1 = I_s & \text{Eliminates } 1 \text{ unknown mesh current} \\
     \mathbf{\text{Shared Current Source}} & \mathbf{\text{Bypass branch to form Supermesh Loop}} & \mathbf{1 \text{ KVL on perimeter} + (i_2 - i_1 = I_s)} \\
     \mathbf{\text{Independent Voltage Source}} & \text{Directly add/subtract to right-hand } [V] \text{ vector} & \text{Standard diagonal contribution} \\
     \hline
     \end{array}$$
   - **The Planar Invariant:** Mesh analysis is **STRICTLY applicable to planar circuits** (circuits that can be drawn on a 2D plane with zero crossing wires without bridging)!
2. **Slide 2 (`ordering`):** Provide 5 steps of mesh analysis: (1) verify planarity and assign clockwise mesh currents $i_1, i_2, \dots, i_m$ to each window, (2) identify current sources shared between adjacent meshes and form supermesh loops, (3) write KVL around each standard mesh and supermesh perimeter using Ohmic drops $R(i_{\text{self}} - i_{\text{adjacent}})$, (4) write the current source constraint equation $i_{\text{aligned}} - i_{\text{opposed}} = I_s$ for each supermesh, (5) solve the resulting linear system $[R][I] = [V]$ for all unknown mesh currents!
3. **Slide 3 (`matching`):** Pair 4 concepts (Kirchhoff's Voltage Law KVL, Planar Circuit, Supermesh, Mutual Resistance $R_{jk}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Energy. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating mesh currents: A two-mesh planar circuit contains a $V_s = 20\text{ V}$ independent voltage source in mesh $1$, resistor $R_1 = 6\,\Omega$ in mesh $1$, resistor $R_2 = 4\,\Omega$ in mesh $2$, and an independent current source $I_s = 2\text{ A}$ shared on the common branch between mesh $1$ and mesh $2$ directed upward (such that $i_2 - i_1 = 2\text{ A}$). What are the mesh currents $i_1$ and $i_2$? (Form supermesh encompassing mesh $1$ and $2$: KVL around supermesh perimeter: $-20 + 6 i_1 + 4 i_2 = 0 \implies 6 i_1 + 4 i_2 = 20$; Supermesh constraint: $i_2 - i_1 = 2 \implies i_2 = i_1 + 2$; Substitute: $6 i_1 + 4(i_1 + 2) = 20 \implies 10 i_1 + 8 = 20 \implies 10 i_1 = 12 \implies \mathbf{i_1 = 1.2\text{ A}}$; $i_2 = i_1 + 2 = 1.2 + 2 = \mathbf{3.2\text{ A}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "kvl_and_mesh_analysis_supermeshes_planar_circuits",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Mesh Circuit Analysis \\& Supermesh Systems (Alexander \\& Sadiku)**\n• **Kirchhoff's Voltage Law (KVL) Formulation:**\n$$\n\\mathbf{\\sum_{k=1}^M v_k = 0 \\quad (\\text{Conservation of Energy around Closed Electrical Loops})}\n$$\n• **Systematic Mesh Resistance Matrix Formulation:**\n$$\n\\mathbf{\\begin{bmatrix} R_{11} & -R_{12} \\\\ -R_{21} & R_{22} \\end{bmatrix} \\begin{bmatrix} i_1 \\\\ i_2 \\end{bmatrix} = \\begin{bmatrix} v_1 \\\\ v_2 \\end{bmatrix} \\quad \\left(R_{kk} = \\sum \\text{Resistances in mesh } k, \\ M = B - N + 1\\right)}\n$$\n• **The Supermesh Method for Shared Current Sources:**\n  - An ideal current source shared between two meshes has unknown terminal voltage;\n  - **Solution:** Remove the current source branch to create a **Supermesh Loop**, write KVL around the outer perimeter:\n$$\n\\mathbf{\\sum_{\\text{perimeter}} v_k = 0 \\quad \\Longleftrightarrow \\quad -V_s + R_1 i_1 + R_2 i_2 = 0}\n$$\n  - Pair with the **Branch Current Constraint:** $\\mathbf{i_2 - i_1 = I_{\\text{source}}}$!\n• **The Planarity Invariant:** Mesh analysis is **STRICTLY applicable to planar networks** (circuits drawable in 2D with zero crossing non-connecting branches)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to solve an electrical circuit containing a shared independent current source using Mesh Analysis.",
      "orderItems": [
        "Verify circuit planarity and assign clockwise mesh currents (i1, i2, ..., im) to all individual windows",
        "Identify any ideal current source shared between adjacent meshes and bypass the branch to form a Supermesh",
        "Formulate Kirchhoff's Voltage Law (KVL) equations around all standard meshes and around the outer supermesh perimeter",
        "Formulate the current source constraint equation: i_aligned - i_opposing = I_source",
        "Construct the linear system of equations [R][I] = [V] and solve for unknown mesh currents using Cramer's Rule"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Mesh Analysis Term to its exact Technical Definition.",
      "matchPairs": [
        { "left": "Kirchhoff's Voltage Law (KVL)", "right": "\u2211 v = 0, stating that algebraic sum of all potential drops and gains around a closed loop is zero" },
        { "left": "Supermesh", "right": "Loop formed by merging two adjacent meshes when an ideal current source is shared between them" },
        { "left": "Mutual Resistance (Rjk)", "right": "Resistance shared between mesh j and mesh k, entering as off-diagonal negative terms -Rjk" },
        { "left": "Planar Circuit", "right": "Circuit geometry that can be drawn on a two-dimensional plane without any crossing branches" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Kirchhoff's Voltage Law (KVL) is the direct electrical manifestation of the fundamental law of conservation of ___.",
      "blankAnswer": "energy",
      "blankDistractors": ["charge", "power", "mass"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A planar two-mesh circuit has a 20 V voltage source and R1 = 6 \u03a9 in mesh 1, and R2 = 4 \u03a9 in mesh 2. An ideal current source Is = 2 A is shared on the common branch between mesh 1 and mesh 2 directed such that i2 - i1 = 2 A. What are the mesh currents i1 and i2?",
      "options": [
        { "text": "i1 = 1.20 A and i2 = 3.20 A (Supermesh KVL: -20 + 6*i1 + 4*i2 = 0 \u2192 6*i1 + 4*(i1 + 2) = 20 \u2192 10*i1 = 12 \u2192 i1 = 1.2 A, i2 = 3.2 A)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Supermesh technique (Charles Alexander & Matthew Sadiku *Fundamentals of Electric Circuits* Chapter 3). 1. **Identify the Supermesh:** - The $2\\text{ A}$ current source is shared between mesh $1$ and mesh $2$. - Constraint Equation: $$i_2 - i_1 = 2\\text{ A} \\implies i_2 = i_1 + 2$$ 2. **Apply KVL Around the Supermesh Perimeter (Bypassing Current Branch):** $$-20\\text{ V} + R_1 i_1 + R_2 i_2 = 0$$ $$-20 + 6 i_1 + 4 i_2 = 0 \\implies 6 i_1 + 4 i_2 = 20$$ 3. **Substitute $i_2 = i_1 + 2$:** $$6 i_1 + 4(i_1 + 2) = 20$$ $$6 i_1 + 4 i_1 + 8 = 20$$ $$10 i_1 = 12 \\implies \\mathbf{i_1 = 1.20\\text{ A}}$$ 4. **Calculate $i_2$:** $$i_2 = i_1 + 2 = 1.20 + 2 = \\mathbf{3.20\\text{ A}}$$ Flawless supermesh solution!" },
        { "text": "i1 = 2.00 A and i2 = 4.00 A", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "i1 = 0.50 A and i2 = 2.50 A", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "i1 = 3.33 A and i2 = 5.33 A", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
