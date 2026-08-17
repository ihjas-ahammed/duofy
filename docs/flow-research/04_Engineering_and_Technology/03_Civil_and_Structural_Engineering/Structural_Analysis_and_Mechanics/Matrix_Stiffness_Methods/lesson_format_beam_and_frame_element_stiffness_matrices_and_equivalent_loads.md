# Duofy Reusable Lesson Format: Beams & Frames (Euler-Bernoulli Matrices & Equivalent Loads)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Structural_Analysis_and_Mechanics / Matrix_Stiffness_Methods`  
**Lesson Format Type:** `beam_and_frame_element_stiffness_matrices_and_equivalent_loads`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the derivation of the $4\times 4$ Euler-Bernoulli beam element flexural stiffness matrix from cubic Hermite shape functions, the $6\times 6$ 2D planar frame element matrix (combining axial $AE/L$ and flexural $EI/L^3$ terms), and the transformation of intermediate span distributed loads into Equivalent Nodal Joint Loads ($\mathbf{P}_{\text{equiv}} = \mathbf{P}_{\text{joint}} - \mathbf{F}_{\text{fixed}}$) via reversed Fixed-End Actions (William Weaver Jr. & James M. Gere *Matrix Analysis of Framed Structures* 3rd ed. Chapters 4 & 5; Russell C. Hibbeler *Structural Analysis* 10th ed. Chapter 15): formulate the **$4\times 4$ Euler-Bernoulli Beam Element Stiffness Matrix ($\mathbf{k}'$)**:
$$\mathbf{\mathbf{k}' = \begin{bmatrix} \frac{12 E I}{L^3} & \frac{6 E I}{L^2} & -\frac{12 E I}{L^3} & \frac{6 E I}{L^2} \\ \frac{6 E I}{L^2} & \frac{4 E I}{L} & -\frac{6 E I}{L^2} & \frac{2 E I}{L} \\ -\frac{12 E I}{L^3} & -\frac{6 E I}{L^2} & \frac{12 E I}{L^3} & -\frac{6 E I}{L^2} \\ \frac{6 E I}{L^2} & \frac{2 E I}{L} & -\frac{6 E I}{L^2} & \frac{4 E I}{L} \end{bmatrix}}$$
where degrees of freedom are ordered $[\text{Shear}_N, \text{Moment}_N, \text{Shear}_F, \text{Moment}_F]^T$;
master the **Equivalent Nodal Load Vector Transformation**:
- When loads act along the interior of a beam member (not directly at joints):
  1. Clamp both ends to compute **Fixed-End Force Vector ($\mathbf{F}_{\text{fixed}}$)**:
     $$\mathbf{\mathbf{F}_{\text{fixed,UDL}} = \begin{bmatrix} \text{Shear}_N \\ \text{Moment}_N \\ \text{Shear}_F \\ \text{Moment}_F \end{bmatrix} = \begin{bmatrix} \frac{w L}{2} \\ +\frac{w L^2}{12} \\ \frac{w L}{2} \\ -\frac{w L^2}{12} \end{bmatrix}}$$
  2. Compute **Equivalent Joint Load Vector**: $\mathbf{P}_{\text{equiv}} = - \mathbf{F}_{\text{fixed}}$;
  3. Formulate total nodal load: $\mathbf{P}_{\text{total}} = \mathbf{P}_{\text{joint}} + \mathbf{P}_{\text{equiv}} = \mathbf{P}_{\text{joint}} - \mathbf{F}_{\text{fixed}}$!

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Beam Matrix ($12EI/L^3, 6EI/L^2, 4EI/L$), Hermite Functions & Equivalent Nodal Loads Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Convert a Span UDL into an Equivalent Nodal Load Vector Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Beam Matrix Coefficient / Load Entity & Technical Structural Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the $4\times 4$ Beam Stiffness Matrix, the Moment Required to Produce a Unit Rotation at the Near End with Far End Clamped Is ___ Times EI/L (4 / Four) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Matrix Structural Problem: Computing the Flexural Beam Stiffness Matrix Entries for a 6m Span Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Beam Stiffness & Equivalent Loads (Weaver & Gere 1990; Hibbeler 2018):
   - **Beam Matrix & Equivalent Load Formulations:**
     $$\mathbf{\mathbf{k}' = \begin{bmatrix} \frac{12EI}{L^3} & \frac{6EI}{L^2} & -\frac{12EI}{L^3} & \frac{6EI}{L^2} \\ \frac{6EI}{L^2} & \frac{4EI}{L} & -\frac{6EI}{L^2} & \frac{2EI}{L} \\ -\frac{12EI}{L^3} & -\frac{6EI}{L^2} & \frac{12EI}{L^3} & -\frac{6EI}{L^2} \\ \frac{6EI}{L^2} & \frac{2EI}{L} & -\frac{6EI}{L^2} & \frac{4EI}{L} \end{bmatrix} \quad \Big| \quad \mathbf{P}_{\text{equiv}} = -\mathbf{F}_{\text{fixed}}}$$
   - **Coefficient Physical Interpretation Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Matrix Entry} & \textbf{Formula} & \textbf{Physical Meaning} \\
     \hline
     \mathbf{k_{11}'} & \mathbf{12EI / L^3} & \text{Shear force required for unit transverse displacement with zero rotation} \\
     \mathbf{k_{22}'} & \mathbf{4EI / L} & \mathbf{\text{Moment required for unit near-end rotation with zero translation}} \\
     \mathbf{k_{42}'} & \mathbf{2EI / L} & \mathbf{\text{Carry-over moment induced at far clamped end }} (\text{COF} = 2/4 = +0.50!) \\
     \mathbf{k_{12}'} & \mathbf{6EI / L^2} & \text{Shear force induced by unit near-end rotation} \\
     \hline
     \end{array}$$
   - **The Carry-Over Connection Invariant:** The ratio $k_{42}' / k_{22}' = \frac{2EI/L}{4EI/L} = \mathbf{+0.50}$, directly proving why the Hardy Cross Carry-Over Factor is mathematically $+1/2$ from Euler-Bernoulli beam theory!
2. **Slide 2 (`ordering`):** Provide 5 steps of equivalent load transformation: (1) clamp both nodes of the loaded member to create a fully fixed beam, (2) compute Fixed-End Forces and Moments: $\mathbf{F}_{\text{fixed}} = [wL/2, +wL^2/12, wL/2, -wL^2/12]^T$, (3) invert the signs of the fixed-end actions to get equivalent nodal loads: $\mathbf{P}_{\text{equiv}} = -\mathbf{F}_{\text{fixed}}$, (4) stamp equivalent loads into the global load vector at the corresponding unconstrained DOFs: $\mathbf{P}_k = \mathbf{P}_{\text{joint}} - \mathbf{F}_{\text{fixed}}$, (5) solve displacements and back-calculate final member end forces by adding $\mathbf{q} = \mathbf{k}' \mathbf{d} + \mathbf{F}_{\text{fixed}}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Rotational Stiffness $4EI/L$, Cross-Moment $2EI/L$, Transverse Shear $12EI/L^3$, Equivalent Joint Load $-\mathbf{F}_{\text{fixed}}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 4 (or Four). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on computing beam matrix entries: A reinforced concrete beam has length $L = 6.0\text{ m}$ and flexural rigidity $E I = 36,000\text{ kN}\cdot\text{m}^2$. What are the values of diagonal rotational stiffness $k_{22}'$ and diagonal shear stiffness $k_{11}'$? ($k_{22}' = \frac{4 E I}{L} = \frac{4 \times 36,000\text{ kN}\cdot\text{m}^2}{6.0\text{ m}} = \frac{144,000}{6.0} = \mathbf{24,000\text{ kN}\cdot\text{m/rad}}$; $k_{11}' = \frac{12 E I}{L^3} = \frac{12 \times 36,000\text{ kN}\cdot\text{m}^2}{(6.0\text{ m})^3} = \frac{432,000}{216} = \mathbf{2000.0\text{ kN/m}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "beam_and_frame_element_stiffness_matrices_and_equivalent_loads",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Euler-Bernoulli Beam Stiffness \\& Equivalent Loads (Weaver \\& Gere)**\n• **$4\\times 4$ Local Flexural Beam Stiffness Matrix (DOFs: $[v_N, \\theta_N, v_F, \\theta_F]^T$):**\n$$\n\\mathbf{\\mathbf{k}' = \\begin{bmatrix} \\frac{12 E I}{L^3} & \\frac{6 E I}{L^2} & -\\frac{12 E I}{L^3} & \\frac{6 E I}{L^2} \\\\ \\frac{6 E I}{L^2} & \\frac{4 E I}{L} & -\\frac{6 E I}{L^2} & \\frac{2 E I}{L} \\\\ -\\frac{12 E I}{L^3} & -\\frac{6 E I}{L^2} & \\frac{12 E I}{L^3} & -\\frac{6 E I}{L^2} \\\\ \\frac{6 E I}{L^2} & \\frac{2 E I}{L} & -\\frac{6 E I}{L^2} & \\frac{4 E I}{L} \\end{bmatrix}}\n$$\n• **Equivalent Nodal Joint Load Transformation:**\n$$\n\\mathbf{\\mathbf{P}_{\\text{equiv}} = - \\mathbf{F}_{\\text{fixed}} \\implies \\mathbf{P}_{\\text{total}} = \\mathbf{P}_{\\text{joint}} - \\mathbf{F}_{\\text{fixed}}}\n$$\n  - For a full uniform load $w$: $\\mathbf{F}_{\\text{fixed}} = \\left[ \\frac{w L}{2}, \\ +\\frac{w L^2}{12}, \\ \\frac{w L}{2}, \\ -\\frac{w L^2}{12} \\right]^T$;\n• **The Direct Stiffness Internal Force Recovery Formula:**\n$$\n\\mathbf{\\mathbf{q}_{\\text{member}} = \\mathbf{k}' \\cdot \\mathbf{d}_{\\text{local}} + \\mathbf{F}_{\\text{fixed}}}\n$$\n• **The Carry-Over Ratio Invariant:** Entry $k_{42}' / k_{22}' = \\frac{2EI/L}{4EI/L} = \\mathbf{+0.50}$, demonstrating that the Hardy Cross carry-over factor of $+1/2$ is an exact analytical consequence of Euler-Bernoulli beam theory!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to transform span-distributed loads into equivalent nodal joint loads in matrix structural analysis.",
      "orderItems": [
        "Clamp both the Near and Far nodes of the loaded member to create a temporary fixed-fixed beam",
        "Compute the Fixed-End Force and Moment vector: F_fixed = [wL/2, +wL^2/12, wL/2, -wL^2/12]^T",
        "Invert the signs of the fixed-end forces to obtain the equivalent nodal load vector: P_equiv = -F_fixed",
        "Add equivalent loads into the global load vector at unconstrained degrees of freedom: P_k = P_joint - F_fixed",
        "Solve for nodal displacements and recover final member end forces using: q = k' * d + F_fixed"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Beam Matrix Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Diagonal Moment Term (4EI/L)", "right": "Moment required at Near node to produce unit rotation while maintaining zero translation and zero Far rotation" },
        { "left": "Cross-Moment Term (2EI/L)", "right": "Moment carried over to Far clamped node when Near node undergoes a unit rotation (COF = 2/4 = +0.50)" },
        { "left": "Shear Stiffness Term (12EI/L^3)", "right": "Transverse force required to produce unit lateral translation without allowing any end rotation" },
        { "left": "Equivalent Joint Load Vector", "right": "Reversed fixed-end force vector P_equiv = -F_fixed applied to nodes to represent distributed span loading" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the 4x4 beam stiffness matrix, the moment required to produce a unit rotation at the near end with the far end clamped is ___ times EI/L.",
      "blankAnswer": "4",
      "blankDistractors": ["2", "6", "12"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A reinforced concrete beam element has span length L = 6.0 m and flexural rigidity EI = 36,000 kNm^2. What are the values of the diagonal rotational stiffness entry k22' and diagonal shear stiffness entry k11' in its 4x4 flexural stiffness matrix?",
      "options": [
        { "text": "k22' = 24,000 kNm/rad and k11' = 2,000 kN/m (k22' = 4EI/L = 4 * 36000 / 6.0 = 24,000 kNm/rad; k11' = 12EI/L^3 = 12 * 36000 / 6^3 = 432000 / 216 = 2,000 kN/m)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Euler-Bernoulli beam element stiffness formulas (William Weaver Jr. & James M. Gere *Matrix Analysis of Framed Structures* Chapter 4). 1. **Calculate Rotational Stiffness Entry ($k_{22}'$):** - Rotational stiffness relates applied moment to unit angular rotation at the near node: $$k_{22}' = \\frac{4 E I}{L} = \\frac{4 \\times 36,000\\text{ kN}\\cdot\\text{m}^2}{6.0\\text{ m}} = \\frac{144,000}{6.0} = \\mathbf{24,000.0\\text{ kN}\\cdot\\text{m/rad}}$$ 2. **Calculate Transverse Shear Stiffness Entry ($k_{11}'$):** - Shear stiffness relates transverse shear force to unit lateral translation at the near node: $$k_{11}' = \\frac{12 E I}{L^3} = \\frac{12 \\times 36,000\\text{ kN}\\cdot\\text{m}^2}{(6.0\\text{ m})^3} = \\frac{432,000\\text{ kN}\\cdot\\text{m}^2}{216.0\\text{ m}^3} = \\mathbf{2000.0\\text{ kN/m}}$$ 3. **Calculate Cross-Coupling Shear-Moment Entry ($k_{12}'$):** $$k_{12}' = \\frac{6 E I}{L^2} = \\frac{6 \\times 36,000\\text{ kN}\\cdot\\text{m}^2}{(6.0\\text{ m})^2} = \\frac{216,000}{36.0} = \\mathbf{6000.0\\text{ kN/rad}}$$ 4. **Assemble the Complete $4\\times 4$ Matrix:** $$\\mathbf{k}' = \\begin{bmatrix} 2000 & 6000 & -2000 & 6000 \\\\ 6000 & 24000 & -6000 & 12000 \\\\ -2000 & -6000 & 2000 & -6000 \\\\ 6000 & 12000 & -6000 & 24000 \\end{bmatrix}$$ Flawless Euler-Bernoulli beam stiffness matrix calculation!" },
        { "text": "k22' = 12,000 kNm/rad and k11' = 1,000 kN/m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "k22' = 24,000 kNm/rad and k11' = 6,000 kN/m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "k22' = 36,000 kNm/rad and k11' = 2,000 kN/m", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
