# Duofy Reusable Lesson Format: Direct Stiffness (Matrix Partitioning & Nodal Equilibrium)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Structural_Analysis_and_Mechanics / Matrix_Stiffness_Methods`  
**Lesson Format Type:** `direct_stiffness_method_and_global_equilibrium_matrices`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mathematical foundations of the **Direct Stiffness Method (Matrix Structural Analysis)**, the global structural equilibrium equation ($\mathbf{P} = \mathbf{K} \mathbf{D}$), degree of freedom ($\text{DOF}$) classification, submatrix partitioning into unconstrained active degrees of freedom ($\mathbf{D}_u$) versus restrained support boundaries ($\mathbf{D}_k = \mathbf{0}$), and the two-stage solution sequence for unknown displacements and support reactions (William Weaver Jr. & James M. Gere *Matrix Analysis of Framed Structures* 3rd ed. Chapter 2; Russell C. Hibbeler *Structural Analysis* 10th ed. Chapter 14): formulate the **Master Partitioned Stiffness System**:
$$\mathbf{\begin{bmatrix} \mathbf{P}_k \\ \mathbf{P}_u \end{bmatrix} = \begin{bmatrix} \mathbf{K}_{11} & \mathbf{K}_{12} \\ \mathbf{K}_{21} & \mathbf{K}_{22} \end{bmatrix} \begin{bmatrix} \mathbf{D}_u \\ \mathbf{D}_k \end{bmatrix}}$$
where:
1. **$\mathbf{P}_k$:** Vector of known external nodal forces and moments applied at unconstrained DOFs;
2. **$\mathbf{P}_u$:** Vector of unknown support reaction forces to be determined;
3. **$\mathbf{D}_u$:** Vector of unknown joint displacements and rotations;
4. **$\mathbf{D}_k$:** Vector of known prescribed boundary support displacements (typically $\mathbf{D}_k = \mathbf{0}$ for unyielding supports);
derive the **Two-Stage Direct Stiffness Solution Sequence**:
$$\mathbf{\text{Stage 1 (Solve Unknown Displacements): } \mathbf{D}_u = \mathbf{K}_{11}^{-1} \left( \mathbf{P}_k - \mathbf{K}_{12} \mathbf{D}_k \right) = \mathbf{K}_{11}^{-1} \mathbf{P}_k \quad (\text{When } \mathbf{D}_k = \mathbf{0})}$$
$$\mathbf{\text{Stage 2 (Recover Support Reactions): } \mathbf{P}_u = \mathbf{K}_{21} \mathbf{D}_u + \mathbf{K}_{22} \mathbf{D}_k = \mathbf{K}_{21} \mathbf{D}_u}$$
(proving how matrix partitioning decouples the structural solution into a small, invertible displacement subproblem without carrying redundant fixed-boundary zeros).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Direct Stiffness ($\mathbf{P} = \mathbf{K}\mathbf{D}$), Submatrix Partitioning ($\mathbf{K}_{11}, \mathbf{K}_{21}$) & Support Reactions Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Partition and Solve a 2-DOF Structural System for Displacements and Reactions Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Matrix Structural Analysis Variable / Submatrix & Technical Mathematical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Direct Stiffness Method with Unyielding Supports, the Submatrix Inverted to Solve for Unknown Displacements Is ___ (K11) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Computational Mechanics Problem: Inverting K_11 to Solve Nodal Displacement and Support Reaction for an Axial Spring System Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Direct Stiffness & Matrix Partitioning (Weaver & Gere 1990; Hibbeler 2018):
   - **Stiffness System & Partitioning Formulations:**
     $$\mathbf{\mathbf{P} = \mathbf{K} \mathbf{D} \quad \Big| \quad \begin{bmatrix} \mathbf{P}_k \\ \mathbf{P}_u \end{bmatrix} = \begin{bmatrix} \mathbf{K}_{11} & \mathbf{K}_{12} \\ \mathbf{K}_{21} & \mathbf{K}_{22} \end{bmatrix} \begin{bmatrix} \mathbf{D}_u \\ \mathbf{D}_k \end{bmatrix} \quad \Big| \quad \mathbf{D}_u = \mathbf{K}_{11}^{-1} \mathbf{P}_k \quad \Big| \quad \mathbf{P}_u = \mathbf{K}_{21} \mathbf{D}_u}$$
   - **DOF Classification Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Partition Block} & \textbf{Physical Meaning} & \textbf{Force Vector Status} & \textbf{Displacement Vector Status} \\
     \hline
     \mathbf{\text{Unconstrained DOFs } (u)} & \text{Free moving joints } (1 \dots N_u) & \mathbf{\text{Known Applied Loads } (\mathbf{P}_k)} & \mathbf{\text{Unknown Displacements } (\mathbf{D}_u)} \\
     \mathbf{\text{Constrained DOFs } (k)} & \text{Rigid support boundaries} & \mathbf{\text{Unknown Reactions } (\mathbf{P}_u)} & \mathbf{\text{Known Zero Prescribed } (\mathbf{D}_k = \mathbf{0})} \\
     \hline
     \end{array}$$
   - **The Symmetry & Positive Definiteness Invariant:** The reduced structure stiffness matrix $\mathbf{K}_{11}$ is **strictly symmetric ($\mathbf{K}_{11} = \mathbf{K}_{11}^T$) and positive definite**, guaranteeing a unique, non-singular displacement solution $\mathbf{D}_u$ for any physically stable structure!
2. **Slide 2 (`ordering`):** Provide 5 steps of direct stiffness solution: (1) number unconstrained degrees of freedom ($1 \dots N_u$) before restrained support DOFs, (2) assemble global stiffness matrix $\mathbf{K}$ and formulate global load vector $\mathbf{P}$, (3) partition into submatrices $\mathbf{K}_{11}, \mathbf{K}_{12}, \mathbf{K}_{21}, \mathbf{K}_{22}$, (4) compute inverse $\mathbf{K}_{11}^{-1}$ and solve unknown displacements $\mathbf{D}_u = \mathbf{K}_{11}^{-1} \mathbf{P}_k$, (5) calculate unknown support reactions $\mathbf{P}_u = \mathbf{K}_{21} \mathbf{D}_u$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Submatrix $\mathbf{K}_{11}$, Submatrix $\mathbf{K}_{21}$, Known Load Vector $\mathbf{P}_k$, Prescribed Displacement $\mathbf{D}_k = \mathbf{0}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of K11. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on solving partitioned 2-DOF spring/bar system: A 2-DOF axial system has unconstrained DOF 1 and fixed support at DOF 2. The partitioned global stiffness matrix is:
   $$\mathbf{K} = \begin{bmatrix} K_{11} & K_{12} \\ K_{21} & K_{22} \end{bmatrix} = \begin{bmatrix} 500\text{ kN/m} & -200\text{ kN/m} \\ -200\text{ kN/m} & 200\text{ kN/m} \end{bmatrix}$$
   A horizontal force $P_1 = +100\text{ kN}$ is applied at DOF 1 ($D_2 = 0$). What is the nodal displacement $D_1$ and the support reaction $P_2$ at DOF 2? ($D_1 = K_{11}^{-1} P_1 = \frac{100\text{ kN}}{500\text{ kN/m}} = \mathbf{0.20\text{ m} = 200\text{ mm}}$; $P_2 = K_{21} D_1 = (-200\text{ kN/m}) \times (0.20\text{ m}) = \mathbf{-40.0\text{ kN}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "direct_stiffness_method_and_global_equilibrium_matrices",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Direct Stiffness Method \\& Matrix Partitioning (Weaver \\& Gere)**\n• **Global Structural Equilibrium System:**\n$$\n\\mathbf{\\mathbf{P} = \\mathbf{K} \\cdot \\mathbf{D} \\Longleftrightarrow \\begin{bmatrix} \\mathbf{P}_k \\\\ \\mathbf{P}_u \\end{bmatrix} = \\begin{bmatrix} \\mathbf{K}_{11} & \\mathbf{K}_{12} \\\\ \\mathbf{K}_{21} & \\mathbf{K}_{22} \\end{bmatrix} \\begin{bmatrix} \\mathbf{D}_u \\\\ \\mathbf{D}_k \\end{bmatrix}}\n$$\n  - **$\\mathbf{P}_k$:** Known external nodal load vector applied at unconstrained DOFs;\n  - **$\\mathbf{P}_u$:** Unknown support reaction force vector;\n  - **$\\mathbf{D}_u$:** Unknown unconstrained nodal displacement vector;\n  - **$\\mathbf{D}_k$:** Known prescribed boundary displacement vector (typically $\\mathbf{D}_k = \\mathbf{0}$);\n• **Two-Stage Analytical Solution Protocol:**\n$$\n\\mathbf{\\text{Stage 1 (Displacements): } \\mathbf{D}_u = \\mathbf{K}_{11}^{-1} \\mathbf{P}_k \\quad \\Big| \\quad \\text{Stage 2 (Reactions): } \\mathbf{P}_u = \\mathbf{K}_{21} \\mathbf{D}_u}\n$$\n• **The Positive Definiteness Invariant:** Submatrix $\\mathbf{K}_{11}$ is **strictly symmetric ($\\mathbf{K}_{11} = \\mathbf{K}_{11}^T$) and positive-definite**, guaranteeing that stable civil structures have non-zero determinants with unique mathematical solutions!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to solve an indeterminate structural system using the partitioned Direct Stiffness Method.",
      "orderItems": [
        "Number all unconstrained active degrees of freedom (1 to Nu) first, followed by restrained support boundary DOFs",
        "Assemble the global structure stiffness matrix K and establish the known external nodal load vector P_k",
        "Partition the global system into submatrices: K11 (unconstrained-unconstrained) and K21 (support-unconstrained)",
        "Invert submatrix K11 and solve for unknown structural joint displacements: D_u = K11^(-1) * P_k",
        "Multiply submatrix K21 by solved displacements D_u to recover the unknown support reaction forces: P_u = K21 * D_u"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Matrix Stiffness Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Submatrix K11", "right": "Symmetric, positive-definite stiffness submatrix relating known applied loads to unknown joint displacements" },
        { "left": "Submatrix K21", "right": "Coupling stiffness submatrix used to calculate unknown support reactions from solved displacements" },
        { "left": "Displacement Vector Du", "right": "Unknown nodal translations and rotations solved via matrix inversion: Du = K11^(-1) * Pk" },
        { "left": "Prescribed Vector Dk", "right": "Known boundary displacement vector enforced by physical supports (Dk = 0 for rigid foundations)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Direct Stiffness Method with unyielding supports, the submatrix inverted to solve for unknown displacements is ___.",
      "blankAnswer": "K11",
      "blankDistractors": ["K22", "K12", "K21"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 2-DOF axial system has unconstrained DOF 1 and a fixed support at DOF 2 (D2 = 0). The partitioned stiffness matrix is:\n\n[K11  K12] = [ 500 kN/m  -200 kN/m]\n[K21  K22]   [-200 kN/m   200 kN/m]\n\nA horizontal force P1 = +100 kN is applied at DOF 1. What is the nodal displacement D1 and the support reaction P2 at DOF 2?",
      "options": [
        { "text": "D1 = 0.20 m (200 mm) and P2 = -40.0 kN (D1 = K11^(-1) * P1 = 100 / 500 = 0.20 m; P2 = K21 * D1 = -200 * 0.20 = -40.0 kN, providing equilibrium against the applied load)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the partitioned Direct Stiffness Method (William Weaver Jr. & James M. Gere *Matrix Analysis of Framed Structures* Chapter 2). 1. **Identify the Partitioned System Equations:** $$\\begin{bmatrix} P_1 \\\\ P_2 \\end{bmatrix} = \\begin{bmatrix} K_{11} & K_{12} \\\\ K_{21} & K_{22} \\end{bmatrix} \\begin{bmatrix} D_1 \\\\ D_2 \\end{bmatrix}$$ - Known applied force: $P_1 = +100.0\\text{ kN}$. - Known support boundary displacement: $D_2 = 0\\text{ m}$. - Unknowns: Displacement $D_1$ and reaction force $P_2$. 2. **Stage 1: Solve for Unknown Displacement ($D_1$):** - Expanding row 1: $$P_1 = K_{11} D_1 + K_{12} D_2 = K_{11} D_1 + 0$$ $$100.0\\text{ kN} = (500.0\\text{ kN/m}) \\times D_1$$ $$D_1 = \\frac{100.0\\text{ kN}}{500.0\\text{ kN/m}} = \\mathbf{0.200\\text{ m} = 200.0\\text{ mm}}$$ 3. **Stage 2: Recover Unknown Support Reaction ($P_2$):** - Expanding row 2: $$P_2 = K_{21} D_1 + K_{22} D_2 = K_{21} D_1 + 0$$ $$P_2 = (-200.0\\text{ kN/m}) \\times (0.200\\text{ m}) = \\mathbf{-40.0\\text{ kN}}$$ 4. **Physical Interpretation:** A $+100\\text{ kN}$ load applied at node 1 causes node 1 to deflect by $200\\text{ mm}$, transferring a compression reaction of $-40\\text{ kN}$ into the fixed boundary at node 2! Flawless direct stiffness solution!" },
        { "text": "D1 = 0.50 m and P2 = -100.0 kN", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "D1 = 0.20 m and P2 = +40.0 kN (Wrong sign on reaction)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "D1 = 0.10 m and P2 = -20.0 kN", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
