# Duofy Reusable Lesson Format: Element Stiffness Matrix and Global Assembly

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing / Numerical_Solutions_of_Differential_Equations / Finite_Element_Methods_FEM`  
**Lesson Format Type:** `element_stiffness_matrix_and_assembly`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute 1D and 2D local element stiffness matrices $K_{ij}^e = \int_{T_e} \nabla \phi_i \cdot \nabla \phi_j dx$, perform **Global Matrix Assembly** via connectivity maps, apply essential Dirichlet boundary conditions, and calculate numerical entries for 1D hat linear elements.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | 1D Element Stiffness Matrix & Hat Function Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step 1D Stiffness & Assembly Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Element Topology & Connectivity Map Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Local Stiffness Off-Diagonal Entry Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | 2D Linear Triangle Element Gradient Constancy Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the 1D linear element setup: For element $e = [x_1, x_2]$ of length $h = x_2 - x_1$, local shape functions are $\phi_1(x) = \frac{x_2 - x}{h}$ and $\phi_2(x) = \frac{x - x_1}{h}$ with derivatives $\phi_1' = -1/h, \phi_2' = 1/h$. State the local element stiffness matrix $K^e = \frac{1}{h} \begin{bmatrix} 1 & -1 \\ -1 & 1 \end{bmatrix}$ and local mass matrix $M^e = \frac{h}{6} \begin{bmatrix} 2 & 1 \\ 1 & 2 \end{bmatrix}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) evaluate $K_{11}^e = \int_{x_1}^{x_2} (-1/h)^2 dx = 1/h$ and $K_{12}^e = \int_{x_1}^{x_2} (-1/h)(1/h) dx = -1/h$, (2) global assembly: at internal node $i$, two adjacent elements overlap to form diagonal entry $K_{ii} = K_{22}^{e-1} + K_{11}^e = \frac{1}{h} + \frac{1}{h} = \frac{2}{h}$, (3) assemble global tridiagonal system $\frac{1}{h}\operatorname{tridiag}(-1, 2, -1) \mathbf{u} = \mathbf{F}$, (4) observe exact algebraic equivalence between 1D $P_1$ linear FEM and standard central finite difference stencils for uniform grids.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that local element matrices are aggregated into the global system matrix using the element connectivity array. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the off-diagonal entry $K_{12}^e = -1/h$ of the local stiffness matrix for an element of length $h = 0.2$ (numeric answer: $-1/0.2 = -5.0$).
5. **Slide 5 (`quiz`):** Quiz analyzing 2D linear triangular ($P_1$) elements: Why is the gradient $\nabla \phi_i(x, y)$ of a linear shape function constant across the entire triangle? ($\phi_i(x, y) = a_i + b_i x + c_i y$ is affine linear, so $\nabla \phi_i = (b_i, c_i)$ is constant, making the integral $\int_T \nabla \phi_i \cdot \nabla \phi_j dx = (\nabla \phi_i \cdot \nabla \phi_j) \operatorname{Area}(T)$ trivially exact without quadrature).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "element_stiffness_matrix_and_assembly",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**1D Linear Finite Element Stiffness Matrix**\nLet $e = [x_1, x_2]$ be a 1D element of length $h = x_2 - x_1$.\n• **Local Shape Functions:**\n$$\n\\phi_1(x) = \\frac{x_2 - x}{h}, \\quad \\phi_2(x) = \\frac{x - x_1}{h} \\implies \\phi_1'(x) = -\\frac{1}{h}, \\, \\phi_2'(x) = \\frac{1}{h}\n$$\n• **Local Element Stiffness Matrix $K^e$:**\n$$\nK_{ij}^e = \\int_{x_1}^{x_2} \\frac{d\\phi_i}{dx} \\frac{d\\phi_j}{dx} \\, dx \\implies K^e = \\frac{1}{h} \\begin{bmatrix} 1 & -1 \\\\ -1 & 1 \\end{bmatrix}\n$$\n• **Local Mass Matrix $M^e$:** $M^e = \\frac{h}{6} \\begin{bmatrix} 2 & 1 \\\\ 1 & 2 \\end{bmatrix}$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Local Integration):**\n  $$K_{11}^e = \\int_{x_1}^{x_2} \\left(-\\frac{1}{h}\\right)^2 dx = \\frac{1}{h}, \\quad K_{12}^e = \\int_{x_1}^{x_2} \\left(-\\frac{1}{h}\\right)\\left(\\frac{1}{h}\\right) dx = -\\frac{1}{h}$$\n• **Step 2 (Global Assembly):** Internal node $i$ receives contributions from element $e-1$ (node 2) and element $e$ (node 1):\n  $$K_{ii} = K_{22}^{e-1} + K_{11}^e = \\frac{1}{h} + \\frac{1}{h} = \\frac{2}{h}$$\n• **Step 3 (Global Tridiagonal System):** The assembled stiffness matrix is $\\frac{1}{h} \\operatorname{tridiag}(-1, \\, 2, \\, -1)$, identical to the central finite difference stencil!\n• **Step 4 (Dirichlet Boundary Enforcement):** Fix boundary rows/columns to enforce essential boundary constraints $u(0) = 0, u(1) = 0$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In finite element code, local element matrices are mapped into the global system matrix using the element ___ array.",
      "blankAnswer": "connectivity",
      "blankDistractors": ["quadrature", "gradient", "boundary"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the value of the off-diagonal entry K_{12}^e = -1 / h of the 1D element stiffness matrix when the element length is h = 0.2.",
      "numericAnswer": -5.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "For a 2D linear triangular element (P_1), why is the evaluation of the local stiffness integral K_{ij}^e = int_T nabla phi_i . nabla phi_j dx analytically exact without numerical quadrature?",
      "options": [
        { "text": "Linear shape functions phi_i(x, y) = a_i + b_i x + c_i y have CONSTANT gradients nabla phi_i = (b_i, c_i), so the integral simplifies directly to (nabla phi_i . nabla phi_j) * Area(T)", "isCorrect": true, "explanation": "Correct! Because the gradients are spatially constant, they factor out of the integral completely, leaving just the triangle area." },
        { "text": "Because triangles have zero area", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the stiffness matrix is always zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because 2D FEM only works on squares", "isCorrect": false, "explanation": "Incorrect: Triangular elements handle arbitrary complex geometries." }
      ]
    }
  ]
}
```
