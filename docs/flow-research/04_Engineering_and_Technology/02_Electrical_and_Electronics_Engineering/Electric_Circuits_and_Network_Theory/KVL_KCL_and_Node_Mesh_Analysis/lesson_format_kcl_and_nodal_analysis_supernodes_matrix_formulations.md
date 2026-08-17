# Duofy Reusable Lesson Format: Nodal Analysis (KCL, Supernodes, & Conductance Matrices)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Electric_Circuits_and_Network_Theory / KVL_KCL_and_Node_Mesh_Analysis`  
**Lesson Format Type:** `kcl_and_nodal_analysis_supernodes_matrix_formulations`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through circuit topology, essential node identification, Kirchhoff's Current Law (KCL $\sum i_k = 0$, conservation of electric charge), matrix conductance formulations, and floating voltage source supernodes in linear electric network theory (Gustav Kirchhoff 1845; Charles K. Alexander & Matthew N.O. Sadiku *Fundamentals of Electric Circuits* Chapter 3; James W. Nilsson & Susan A. Riedel *Electric Circuits* Chapter 4): formulate the **Standard Nodal Matrix System**:
$$\mathbf{\begin{bmatrix} G_{11} & -G_{12} \\ -G_{21} & G_{22} \end{bmatrix} \begin{bmatrix} v_1 \\ v_2 \end{bmatrix} = \begin{bmatrix} i_1 \\ i_2 \end{bmatrix} \quad \left(G_{kk} = \sum \text{Conductances connected to node } k, \ G_{jk} = \text{Mutual Conductance}\right)}$$
master the **Supernode Technique**: when an ideal independent or dependent voltage source is connected between two non-reference nodes $v_a$ and $v_b$, bypass the indeterminate current flowing through the voltage source by enclosing the source and its two bounding nodes into a **Supernode**, write a single combined KCL equation summing all currents leaving the supernode boundary:
$$\mathbf{\sum_{\text{leaving}} i_k = 0}$$
and couple it with the **Supernode Voltage Source Constraint Equation**:
$$\mathbf{v_a - v_b = V_{\text{source}}}$$

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | KCL ($\sum i = 0$), Nodal Conductance Matrix ($[G][V] = [I]$) & Supernode Constraint Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Solve Node Voltages Using Supernode Formulation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Nodal Analysis Construct / Circuit Topology Entity & Technical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Kirchhoff's Current Law (KCL) Is the Direct Electrical Embodiment of the Fundamental Law of Conservation of Electric ___ (Charge) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Electric Circuit Analysis Problem: Calculating Node Voltages in a Circuit Containing a Floating Voltage Source Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Nodal Analysis & Supernodes (Alexander & Sadiku 2021; Nilsson 2020):
   - **KCL & Conductance Matrix Formulations:**
     $$\mathbf{\sum_{k=1}^N i_k = 0 \quad \Big| \quad [G][V] = [I] \quad \Big| \quad \frac{v_a - v_b}{R} = G (v_a - v_b)}$$
   - **Supernode Method Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Source Configuration} & \textbf{Nodal Handling Procedure} & \textbf{Governing Equations Formed} \\
     \hline
     \mathbf{\text{Current Source at Node}} & \text{Directly add/subtract to right-hand } [I] \text{ vector} & 1 \text{ KCL equation at node} \\
     \mathbf{\text{Voltage Source to Ground}} & \text{Sets node voltage immediately: } v_1 = V_s & \text{Eliminates } 1 \text{ unknown node voltage} \\
     \mathbf{\text{Floating Voltage Source}} & \mathbf{\text{Enclose in Supernode bypassing source current}} & \mathbf{1 \text{ KCL on boundary} + (v_1 - v_2 = V_s)} \\
     \hline
     \end{array}$$
   - **The Supernode Invariant:** A supernode has **NO voltage of its own**; it is an analytical boundary enclosing two nodes whose voltage difference is fixed by a voltage source!
2. **Slide 2 (`ordering`):** Provide 5 steps of nodal analysis: (1) count essential nodes $N$, select one reference ground node ($0\text{ V}$), and label remaining $(N-1)$ node voltages $v_1, v_2, \dots$, (2) identify floating voltage sources and enclose them in supernodes, (3) write KCL equations at all standard non-reference nodes and supernodes in terms of node voltages $\frac{v_a - v_b}{R}$, (4) write auxiliary constraint equations $v_a - v_b = V_s$ for each supernode, (5) assemble into linear matrix system $[G][V] = [I]$ and solve using Cramer's Rule or Gaussian elimination!
3. **Slide 3 (`matching`):** Pair 4 concepts (Kirchhoff's Current Law KCL, Reference Ground Node, Supernode, Conductance Matrix $[G]$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Charge. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating node voltages: In a planar circuit with ground reference ($v_0 = 0\text{ V}$), node $1$ and node $2$ are connected by an ideal floating independent voltage source of $V_s = 10\text{ V}$ such that $v_1 - v_2 = 10\text{ V}$. Node $1$ connects to ground through resistor $R_1 = 2\,\Omega$, node $2$ connects to ground through $R_2 = 4\,\Omega$, and an independent current source injects $I_{\text{in}} = 6\text{ A}$ into node $1$. What is the node voltage $v_1$ and $v_2$? (Form supernode at $1-2$: KCL on supernode: $\frac{v_1 - 0}{2} + \frac{v_2 - 0}{4} = 6 \implies 2 v_1 + v_2 = 24$; Supernode constraint: $v_1 - v_2 = 10 \implies v_2 = v_1 - 10$; Substitute: $2 v_1 + (v_1 - 10) = 24 \implies 3 v_1 = 34 \implies v_1 = \frac{34}{3} \approx \mathbf{11.33\text{ V}}$; $v_2 = v_1 - 10 = \frac{34}{3} - 10 = \frac{4}{3} \approx \mathbf{1.33\text{ V}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "kcl_and_nodal_analysis_supernodes_matrix_formulations",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Nodal Circuit Analysis \\& Supernode Systems (Alexander \\& Sadiku)**\n• **Kirchhoff's Current Law (KCL) Formulation:**\n$$\n\\mathbf{\\sum_{k=1}^N i_k = 0 \\quad (\\text{Conservation of Electric Charge at Essential Nodes})}\n$$\n• **Systematic Conductance Matrix Formulation:**\n$$\n\\mathbf{\\begin{bmatrix} G_{11} & -G_{12} \\\\ -G_{21} & G_{22} \\end{bmatrix} \\begin{bmatrix} v_1 \\\\ v_2 \\end{bmatrix} = \\begin{bmatrix} i_1 \\\\ i_2 \\end{bmatrix} \\quad \\left(G_{kk} = \\sum \\text{Conductances connected to node } k\\right)}\n$$\n• **The Supernode Method for Floating Voltage Sources:**\n  - An ideal voltage source between two non-reference nodes has indeterminate internal current;\n  - **Solution:** Enclose source in a **Supernode**, apply KCL to the combined outer boundary:\n$$\n\\mathbf{\\sum_{\\text{leaving}} i = 0 \\quad \\Longleftrightarrow \\quad \\frac{v_1 - v_{\\text{ref}}}{R_1} + \\frac{v_2 - v_{\\text{ref}}}{R_2} = I_{\\text{inject}}}\n$$\n  - Pair with the **Constitutive Constraint:** $\\mathbf{v_1 - v_2 = V_{\\text{source}}}$!\n• **The Reference Invariant:** Setting the ground datum $v_{\\text{ref}} = 0\\text{ V}$ reduces an $N$-node network to exactly **$(N-1)$ linearly independent equations**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to solve an electrical circuit containing a floating independent voltage source using Nodal Analysis.",
      "orderItems": [
        "Identify all essential nodes N, select one common ground reference datum (v_ref = 0 V), and label remaining node voltages",
        "Enclose any floating voltage sources connected between two non-reference nodes into a single Supernode",
        "Formulate Kirchhoff's Current Law (KCL) equations at all standard nodes and across the outer supernode boundary",
        "Formulate the auxiliary constraint equation defined by the voltage source: v_high - v_low = V_source",
        "Construct the linear system of equations [G][V] = [I] and solve for unknown node voltages using Cramer's Rule"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Nodal Analysis Entity to its exact Technical Definition.",
      "matchPairs": [
        { "left": "Kirchhoff's Current Law (KCL)", "right": "\u2211 i = 0, stating that algebraic sum of currents entering and leaving an electrical node is zero" },
        { "left": "Supernode", "right": "Analytical boundary enclosing a floating voltage source and its adjacent nodes to bypass unknown source current" },
        { "left": "Self-Conductance (Gkk)", "right": "Sum of all branch conductances (1/R) directly connected to node k, forming matrix diagonal terms" },
        { "left": "Constraint Equation", "right": "v_a - v_b = V_s, the constitutive relation relating the potential difference between supernode terminals" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Kirchhoff's Current Law (KCL) is the direct electrical manifestation of the physical law of conservation of electric ___.",
      "blankAnswer": "charge",
      "blankDistractors": ["energy", "momentum", "flux"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a nodal circuit with ground reference (v0 = 0 V), nodes 1 and 2 are connected by an ideal 10 V voltage source such that v1 - v2 = 10 V. Node 1 connects to ground via R1 = 2 \u03a9, node 2 connects to ground via R2 = 4 \u03a9, and a current source injects 6 A into node 1. What are the node voltages v1 and v2?",
      "options": [
        { "text": "v1 = 11.33 V (34/3 V) and v2 = 1.33 V (4/3 V) (Supernode KCL: v1/2 + v2/4 = 6 \u2192 2*v1 + v2 = 24; with v2 = v1 - 10 \u2192 3*v1 = 34 \u2192 v1 = 11.33 V)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Supernode technique (Charles Alexander & Matthew Sadiku *Fundamentals of Electric Circuits* Chapter 3). 1. **Identify the Supernode:** - Nodes $1$ and $2$ are connected by the floating $10\\text{ V}$ source. - Constraint Equation: $$v_1 - v_2 = 10\\text{ V} \\implies v_2 = v_1 - 10$$ 2. **Apply KCL to Supernode 1-2:** - Sum of currents leaving supernode to ground = Current injected from external source: $$\\frac{v_1 - 0}{R_1} + \\frac{v_2 - 0}{R_2} = 6\\text{ A}$$ $$\\frac{v_1}{2} + \\frac{v_2}{4} = 6$$ 3. **Clear Fractions (Multiply by 4):** $$2 v_1 + v_2 = 24$$ 4. **Substitute $v_2 = v_1 - 10$:** $$2 v_1 + (v_1 - 10) = 24$$ $$3 v_1 - 10 = 24 \\implies 3 v_1 = 34 \\implies \\mathbf{v_1 = \\frac{34}{3}\\text{ V} \\approx 11.33\\text{ V}}$$ 5. **Solve for $v_2$:** $$v_2 = v_1 - 10 = \\frac{34}{3} - 10 = \\frac{4}{3}\\text{ V} \\approx \\mathbf{1.33\\text{ V}}$$ Flawless supernode solution!" },
        { "text": "v1 = 10.00 V and v2 = 0.00 V", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "v1 = 8.00 V and v2 = -2.00 V", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "v1 = 16.00 V and v2 = 6.00 V", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
