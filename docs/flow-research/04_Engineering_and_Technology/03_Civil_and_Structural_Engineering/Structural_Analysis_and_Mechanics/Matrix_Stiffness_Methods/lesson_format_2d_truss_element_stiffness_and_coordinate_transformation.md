# Duofy Reusable Lesson Format: 2D Truss Elements (Coordinate Transformation & Matrices)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Structural_Analysis_and_Mechanics / Matrix_Stiffness_Methods`  
**Lesson Format Type:** `2d_truss_element_stiffness_and_coordinate_transformation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the derivation of the local $2\times 2$ axial bar stiffness matrix, 2D planar coordinate transformation using direction cosines ($\lambda_x = \cos\theta, \lambda_y = \sin\theta$), formulation of the $4\times 4$ global element stiffness matrix ($\mathbf{k} = \mathbf{T}^T \mathbf{k}' \mathbf{T}$), and direct numerical stamping into the structure stiffness matrix (William Weaver Jr. & James M. Gere *Matrix Analysis of Framed Structures* Chapter 3; Russell C. Hibbeler *Structural Analysis* Chapter 14): formulate the **Local 1D Axial Bar Element Stiffness Matrix ($\mathbf{k}'$)**:
$$\mathbf{\mathbf{k}' = \frac{A E}{L} \begin{bmatrix} 1 & -1 \\ -1 & 1 \end{bmatrix}}$$
derive the **Direction Cosines ($\lambda_x, \lambda_y$) and Transformation Matrix ($\mathbf{T}$)**:
$$\mathbf{\lambda_x = \cos\theta = \frac{x_F - x_N}{L} \quad \Big| \quad \mathbf{\lambda_y = \sin\theta = \frac{y_F - y_N}{L}} \quad \Big| \quad L = \sqrt{(x_F - x_N)^2 + (y_F - y_N)^2}}$$
$$\mathbf{\mathbf{T} = \begin{bmatrix} \lambda_x & \lambda_y & 0 & 0 \\ 0 & 0 & \lambda_x & \lambda_y \end{bmatrix}}$$
derive the **2D Planar Truss Global Element Stiffness Matrix ($4\times 4$)**:
$$\mathbf{\mathbf{k} = \mathbf{T}^T \mathbf{k}' \mathbf{T} = \frac{A E}{L} \begin{bmatrix} \lambda_x^2 & \lambda_x \lambda_y & -\lambda_x^2 & -\lambda_x \lambda_y \\ \lambda_x \lambda_y & \lambda_y^2 & -\lambda_x \lambda_y & -\lambda_y^2 \\ -\lambda_x^2 & -\lambda_x \lambda_y & \lambda_x^2 & \lambda_x \lambda_y \\ -\lambda_x \lambda_y & -\lambda_y^2 & \lambda_x \lambda_y & \lambda_y^2 \end{bmatrix}}$$
(proving that the global stiffness matrix is a dyadic outer product $\mathbf{\lambda} \mathbf{\lambda}^T$ scaled by axial stiffness $AE/L$, mapping global X-Y nodal displacements into projected bar elongations).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Local Stiffness ($\mathbf{k}' = \frac{AE}{L}[1,-1;-1,1]$), Direction Cosines ($\lambda_x, \lambda_y$) & Global $\mathbf{k}$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Formulate the $4\times 4$ Global Stiffness Matrix for a Slanted Truss Member Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Matrix Coordinate Parameter / Sub-block & Technical Structural Transformation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In 2D Truss Element Stiffness Transformation, the Direction Cosine Lambda_x Equals the Adjacent Horizontal Coordinate Delta_x Divided by Member ___ (Length / L) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Matrix Structural Analysis Problem: Computing the Global Stiffness Matrix for a 45-Degree Diagonal Truss Bar Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State 2D Truss Element Formulation (Weaver & Gere 1990; Hibbeler 2018):
   - **Stiffness & Transformation Formulations:**
     $$\mathbf{\lambda_x = \frac{x_F - x_N}{L} \quad \Big| \quad \lambda_y = \frac{y_F - y_N}{L} \quad \Big| \quad \mathbf{k} = \frac{AE}{L} \begin{bmatrix} \lambda_x^2 & \lambda_x \lambda_y & -\lambda_x^2 & -\lambda_x \lambda_y \\ \lambda_x \lambda_y & \lambda_y^2 & -\lambda_x \lambda_y & -\lambda_y^2 \\ -\lambda_x^2 & -\lambda_x \lambda_y & \lambda_x^2 & \lambda_x \lambda_y \\ -\lambda_x \lambda_y & -\lambda_y^2 & \lambda_x \lambda_y & \lambda_y^2 \end{bmatrix}}$$
   - **Direction Cosine Orientation Matrix:**
     $$\begin{array}{|l|c|c|c|l|}
     \hline
     \textbf{Member Orientation} & \textbf{Angle } \theta & \lambda_x = \cos\theta & \lambda_y = \sin\theta & \textbf{Global Stiffness Matrix Form} \\
     \hline
     \mathbf{\text{Horizontal Member}} & 0^\circ & 1.0 & 0.0 & \text{Only } X\text{-components active } (k_{11}=AE/L) \\
     \mathbf{\text{Vertical Member}} & 90^\circ & 0.0 & 1.0 & \text{Only } Y\text{-components active } (k_{22}=AE/L) \\
     \mathbf{45^\circ\text{ Diagonal Member}} & 45^\circ & \frac{1}{\sqrt{2}} \approx 0.707 & \frac{1}{\sqrt{2}} \approx 0.707 & \mathbf{\text{All 16 matrix entries equal } \pm 0.5 \frac{AE}{L}} \\
     \hline
     \end{array}$$
   - **The Transformation Orthogonality Invariant:** The transformation matrix is **orthonormal ($\mathbf{T}^{-1} = \mathbf{T}^T$)**, guaranteeing that total strain energy is invariant under rigid coordinate rotations ($U_{\text{local}} = U_{\text{global}}$)!
2. **Slide 2 (`ordering`):** Provide 5 steps of truss element matrix calculation: (1) record Near ($N$) and Far ($F$) node coordinates $(x_N, y_N)$ and $(x_F, y_F)$, (2) compute member length $L = \sqrt{\Delta x^2 + \Delta y^2}$ and axial stiffness factor $AE/L$, (3) compute direction cosines $\lambda_x = \Delta x / L$ and $\lambda_y = \Delta y / L$, (4) compute products $\lambda_x^2, \lambda_y^2, \lambda_x \lambda_y$, (5) populate the symmetric $4\times 4$ global stiffness matrix $\mathbf{k}$ using the 4 dyadic sub-blocks!
3. **Slide 3 (`matching`):** Pair 4 concepts (Direction Cosine $\lambda_x$, Direction Cosine $\lambda_y$, Diagonal Block $\lambda_x^2$, Off-Diagonal Block $-\lambda_x \lambda_y$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Length (or L). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating diagonal truss matrix: A diagonal truss member connects Near node 1 at $(0, 0)\text{ m}$ to Far node 2 at $(3.0, 3.0)\text{ m}$ ($\theta = 45^\circ$). The member has length $L = \sqrt{3^2 + 3^2} = 3\sqrt{2}\text{ m} \approx 4.243\text{ m}$ and axial stiffness factor $\frac{AE}{L} = 1000\text{ kN/m}$. What is the value of direction cosines $\lambda_x, \lambda_y$ and global stiffness matrix entry $k_{11}$ (the horizontal force at node 1 due to unit horizontal displacement at node 1)? ($\lambda_x = \cos(45^\circ) = \frac{1}{\sqrt{2}} \approx 0.7071$; $\lambda_y = \sin(45^\circ) = \frac{1}{\sqrt{2}} \approx 0.7071$; $\lambda_x^2 = \left(\frac{1}{\sqrt{2}}\right)^2 = 0.50$; $k_{11} = \frac{AE}{L} \lambda_x^2 = 1000\text{ kN/m} \times 0.50 = \mathbf{500.0\text{ kN/m}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "2d_truss_element_stiffness_and_coordinate_transformation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: 2D Truss Element Stiffness Matrix (Weaver \\& Gere)**\n• **Local 1D Element Stiffness Matrix:**\n$$\n\\mathbf{\\mathbf{k}' = \\frac{A E}{L} \\begin{bmatrix} 1 & -1 \\\\ -1 & 1 \\end{bmatrix}}\n$$\n• **Direction Cosines Formulation (Near Node $N \\to$ Far Node $F$):**\n$$\n\\mathbf{\\lambda_x = \\cos\\theta = \\frac{x_F - x_N}{L} \\quad \\Big| \\quad \\mathbf{\\lambda_y = \\sin\\theta = \\frac{y_F - y_N}{L}} \\quad (L = \\sqrt{\\Delta x^2 + \\Delta y^2})}\n$$\n• **Global 2D Truss Element Stiffness Matrix ($4\\times 4$):**\n$$\n\\mathbf{\\mathbf{k} = \\mathbf{T}^T \\mathbf{k}' \\mathbf{T} = \\frac{A E}{L} \\begin{bmatrix} \\lambda_x^2 & \\lambda_x \\lambda_y & -\\lambda_x^2 & -\\lambda_x \\lambda_y \\\\ \\lambda_x \\lambda_y & \\lambda_y^2 & -\\lambda_x \\lambda_y & -\\lambda_y^2 \\\\ -\\lambda_x^2 & -\\lambda_x \\lambda_y & \\lambda_x^2 & \\lambda_x \\lambda_y \\\\ -\\lambda_x \\lambda_y & -\\lambda_y^2 & \\lambda_x \\lambda_y & \\lambda_y^2 \\end{bmatrix}}\n$$\n• **The Energy Invariance:** The coordinate transformation matrix $\\mathbf{T}$ is **strictly orthonormal ($\\mathbf{T}^T = \\mathbf{T}^{-1}$)**, preserving total internal elastic strain energy across coordinate rotations ($U_{\\text{local}} = U_{\\text{global}}$)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to construct the 4x4 global stiffness matrix of an inclined 2D truss member.",
      "orderItems": [
        "Extract coordinates of the Near node (xN, yN) and Far node (xF, yF) in the global Cartesian coordinate system",
        "Compute the physical member length: L = \u221a((xF - xN)^2 + (yF - yN)^2) and the axial stiffness multiplier AE/L",
        "Calculate the direction cosines: \u03bbx = (xF - xN) / L and \u03bby = (yF - yN) / L",
        "Compute the quadratic direction cosine products: \u03bbx^2, \u03bby^2, and \u03bbx*\u03bby",
        "Populate the symmetric 4x4 global element stiffness matrix k by multiplying the direction cosine blocks by AE/L"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Matrix Truss Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Direction Cosine \u03bbx", "right": "\u03bbx = cos\u03b8 = (xF - xN) / L, projection of member axis onto the global X-axis" },
        { "left": "Direction Cosine \u03bby", "right": "\u03bby = sin\u03b8 = (yF - yN) / L, projection of member axis onto the global Y-axis" },
        { "left": "Stiffness Entry k11", "right": "(AE/L) * \u03bbx^2, horizontal restoring force at Near node induced by unit horizontal displacement" },
        { "left": "Coupling Entry k12", "right": "(AE/L) * \u03bbx*\u03bby, cross-axis force coupling horizontal and vertical displacements" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In 2D truss element stiffness transformation, the direction cosine \u03bbx equals the horizontal coordinate delta \u0394x divided by member ___.",
      "blankAnswer": "length",
      "blankDistractors": ["area", "modulus", "inertia"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A diagonal truss member connects Near node 1 at (0, 0) m to Far node 2 at (3.0, 3.0) m (\u03b8 = 45\u00b0). Axial stiffness factor is AE/L = 1000 kN/m. What are the direction cosines \u03bbx, \u03bby and the global stiffness matrix entry k11?",
      "options": [
        { "text": "\u03bbx = 0.7071 (1/\u221a2), \u03bby = 0.7071 (1/\u221a2), and k11 = 500.0 kN/m (\u03bbx = cos(45\u00b0) = 0.7071; \u03bbx^2 = 0.50; k11 = (AE/L) * \u03bbx^2 = 1000 * 0.50 = 500.0 kN/m)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using 2D truss matrix transformation formulas (William Weaver Jr. & James M. Gere *Matrix Analysis of Framed Structures* Chapter 3). 1. **Calculate Geometric Parameters:** - Near node: $(x_N, y_N) = (0, 0)\\text{ m}$. - Far node: $(x_F, y_F) = (3.0, 3.0)\\text{ m}$. - Coordinate deltas: $$\\Delta x = 3.0 - 0 = 3.0\\text{ m}, \\quad \\Delta y = 3.0 - 0 = 3.0\\text{ m}$$ - Member length: $$L = \\sqrt{\\Delta x^2 + \\Delta y^2} = \\sqrt{3.0^2 + 3.0^2} = \\sqrt{18.0} = 3\\sqrt{2}\\text{ m} \\approx \\mathbf{4.2426\\text{ m}}$$ 2. **Calculate Direction Cosines ($\\lambda_x, \\lambda_y$):** $$\\lambda_x = \\frac{\\Delta x}{L} = \\frac{3.0\\text{ m}}{3\\sqrt{2}\\text{ m}} = \\frac{1}{\\sqrt{2}} = \\cos(45^\\circ) = \\mathbf{0.707106 \\approx 0.7071}$$ $$\\lambda_y = \\frac{\\Delta y}{L} = \\frac{3.0\\text{ m}}{3\\sqrt{2}\\text{ m}} = \\frac{1}{\\sqrt{2}} = \\sin(45^\\circ) = \\mathbf{0.707106 \\approx 0.7071}$$ 3. **Calculate Diagonal Global Stiffness Entry $k_{11}$:** $$k_{11} = \\frac{A E}{L} \\cdot \\lambda_x^2 = (1000.0\\text{ kN/m}) \\times \\left(\\frac{1}{\\sqrt{2}}\\right)^2 = (1000.0) \\times (0.50) = \\mathbf{500.0\\text{ kN/m}}$$ 4. **Matrix Symmetry Check:** - Notice that all four $2\\times 2$ sub-blocks have entries: $$\\mathbf{k}_{\\text{sub}} = 1000 \\begin{bmatrix} 0.50 & 0.50 \\\\ 0.50 & 0.50 \\end{bmatrix} = \\begin{bmatrix} 500 & 500 \\\\ 500 & 500 \\end{bmatrix}\\text{ kN/m}$$ Flawless 2D truss element matrix transformation!" },
        { "text": "\u03bbx = 1.0, \u03bby = 0, and k11 = 1000.0 kN/m (Horizontal member)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03bbx = 0.50, \u03bby = 0.866, and k11 = 250.0 kN/m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03bbx = 0.7071, \u03bby = 0.7071, and k11 = 1000.0 kN/m", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
