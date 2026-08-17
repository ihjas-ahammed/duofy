# Duofy Reusable Lesson Format: Force Moments (Varignon's Theorem and Force-Couple Systems)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Engineering_Mechanics_and_SOM / Statics_and_Force_Systems`  
**Lesson Format Type:** `moment_of_a_force_varignons_theorem_and_force_couple_systems`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through vector moments, cross products, equivalent systems, and couple reduction in statics (Ferdinand P. Beer & E. Russell Johnston Jr. *Vector Mechanics for Engineers: Statics* Chapter 3; Russell C. Hibbeler *Engineering Mechanics: Statics* Chapter 4): master the **Moment of a Force Vector ($\mathbf{M}_O = \mathbf{r} \times \mathbf{F}$)** (where $\mathbf{r}$ is the position vector from reference pivot $O$ to any point along the line of action of $\mathbf{F}$), master **Varignon's Theorem of Moments** ($\mathbf{M}_O = \mathbf{r} \times (\sum \mathbf{F}_i) = \sum (\mathbf{r} \times \mathbf{F}_i) = (r_x F_y - r_y F_x)\hat{\mathbf{k}}$), master **Couple Moments** (two equal, opposite, and non-collinear parallel forces whose resultant force is zero but produces a pure rotational moment $\mathbf{M} = \mathbf{r} \times \mathbf{F}$ independent of the reference origin / **free vector**), and reduce general 2D/3D force systems to an equivalent **Single Resultant Force and Couple Moment at point $O$**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Vector Cross Product Moment Formula ($\mathbf{M}_O = \mathbf{r} \times \mathbf{F}$), Varignon's Theorem & Couple Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Mathematical Calculation of a 3D Force Moment Using the Determinant Cross Product Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Moment / Force System Reduction Concept & Technical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | A System of Two Parallel Forces That Are Equal in Magnitude and Opposite in Direction Is a ___ (Couple) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Mechanics Problem: Calculating the 3D Moment of a Force Vector About the Origin Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Moments & Varignon (Beer & Johnston 2019; Hibbeler 2016):
   - **Vector Moment Formulation:**
     $$\mathbf{M}_O = \mathbf{r} \times \mathbf{F} = \begin{vmatrix} \hat{\mathbf{i}} & \hat{\mathbf{j}} & \hat{\mathbf{k}} \\ r_x & r_y & r_z \\ F_x & F_y & F_z \end{vmatrix} = (r_y F_z - r_z F_y)\hat{\mathbf{i}} - (r_x F_z - r_z F_x)\hat{\mathbf{j}} + (r_x F_y - r_y F_x)\hat{\mathbf{k}}$$
   - **Varignon's Theorem:**
     $$\mathbf{\text{Moment of Resultant Force}} = \sum (\mathbf{\text{Moments of Individual Component Forces}})$$
   - **Couple Moment Invariant:** A couple moment is a **Free Vector**; its magnitude $M = F \cdot d$ and direction are **independent of the chosen coordinate origin**!
2. **Slide 2 (`ordering`):** Provide 5 steps of computing 3D moment $\mathbf{M}_O = \mathbf{r} \times \mathbf{F}$: (1) identify coordinates of reference pivot point $O(0,0,0)$ and point of application $A(x_A, y_A, z_A)$, (2) construct position vector $\mathbf{r}_{OA} = (x_A - 0)\hat{\mathbf{i}} + (y_A - 0)\hat{\mathbf{j}} + (z_A - 0)\hat{\mathbf{k}}$, (3) express applied force as Cartesian vector $\mathbf{F} = F_x \hat{\mathbf{i}} + F_y \hat{\mathbf{j}} + F_z \hat{\mathbf{k}}$, (4) set up $3 \times 3$ determinant with unit vectors $(\hat{\mathbf{i}}, \hat{\mathbf{j}}, \hat{\mathbf{k}})$ on top row, position vector $\mathbf{r}$ on middle row, and force $\mathbf{F}$ on bottom row, (5) expand determinant by minors to obtain final moment vector $\mathbf{M}_O$ with units $\text{N}\cdot\text{m}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Varignon's Theorem, Couple Moment, Line of Action Principle of Transmissibility, Equivalent Force-Couple System) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Couple. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on computing 3D moment: A force vector $\mathbf{F} = (4\hat{\mathbf{i}} - 3\hat{\mathbf{j}} + 2\hat{\mathbf{k}})\text{ kN}$ is applied at point $A(2, 4, 1)\text{ m}$. What is the moment of this force about the coordinate origin $O(0,0,0)$? ($\mathbf{r} = 2\hat{\mathbf{i}} + 4\hat{\mathbf{j}} + 1\hat{\mathbf{k}}$; $\mathbf{M}_O = \mathbf{r} \times \mathbf{F} = \hat{\mathbf{i}}(4 \cdot 2 - 1 \cdot (-3)) - \hat{\mathbf{j}}(2 \cdot 2 - 1 \cdot 4) + \hat{\mathbf{k}}(2 \cdot (-3) - 4 \cdot 4) = \hat{\mathbf{i}}(8 + 3) - \hat{\mathbf{j}}(4 - 4) + \hat{\mathbf{k}}(-6 - 16) = \mathbf{(11\hat{\mathbf{i}} + 0\hat{\mathbf{j}} - 22\hat{\mathbf{k}})\text{ kN}\cdot\text{m}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "moment_of_a_force_varignons_theorem_and_force_couple_systems",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Force Moments \\& Varignon's Theorem (Beer \\& Johnston)**\n• **3D Vector Cross-Product Moment Formulation:**\n$$\n\\mathbf{M}_O = \\mathbf{r} \\times \\mathbf{F} = \\begin{vmatrix} \\hat{\\mathbf{i}} & \\hat{\\mathbf{j}} & \\hat{\\mathbf{k}} \\\\ r_x & r_y & r_z \\\\ F_x & F_y & F_z \\end{vmatrix} = (r_y F_z - r_z F_y)\\hat{\\mathbf{i}} - (r_x F_z - r_z F_x)\\hat{\\mathbf{j}} + (r_x F_y - r_y F_x)\\hat{\\mathbf{k}}\n$$\n• **Varignon's Theorem of Moments (Pierre Varignon 1687):**\n$$\n\\mathbf{M}_O = \\mathbf{r} \\times \\left( \\sum_{i=1}^n \\mathbf{F}_i \\right) = \\sum_{i=1}^n (\\mathbf{r} \\times \\mathbf{F}_i)\n$$\n• **The Couple Moment Invariant (Free Vector):**\n  - A **Couple** consists of two equal, opposite, and non-collinear forces $(\\mathbf{F}, -\\mathbf{F})$ separated by perpendicular distance $d$. Its resultant force is $\\mathbf{\\sum F = 0}$, producing a pure rotational moment $\\mathbf{M} = \\mathbf{r} \\times \\mathbf{F}$ whose value is **identical about EVERY point in space**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the moment vector of a 3D force acting on a rigid body about the origin.",
      "orderItems": [
        "Identify the reference origin point O(0,0,0) and the point of application A(x, y, z) on the line of action",
        "Construct the position vector r_OA = x*i + y*j + z*k pointing from the pivot to the point of application",
        "Express the applied force as a 3D Cartesian vector F = Fx*i + Fy*j + Fz*k",
        "Set up the 3x3 determinant matrix with unit vectors in row 1, position vector in row 2, and force vector in row 3",
        "Expand the cross-product determinant by minors to obtain the resultant moment vector M_O in Newton-meters"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Statics Moment Concept to its exact Mathematical Definition.",
      "matchPairs": [
        { "left": "Varignon's Theorem", "right": "The moment of a resultant force equals the algebraic sum of the moments of its components" },
        { "left": "Couple Moment", "right": "A free vector produced by two equal, opposite, non-collinear forces that is origin-independent" },
        { "left": "Principle of Transmissibility", "right": "A force may be applied anywhere along its line of action without changing external equilibrium" },
        { "left": "Equivalent Force-Couple System", "right": "Replacing an arbitrary force system with a single resultant force and a couple moment at point O" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A system of two equal, opposite, and non-collinear parallel forces producing pure rotation is a ___.",
      "blankAnswer": "couple",
      "blankDistractors": ["truss", "resultant", "scalar"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A force vector F = (4 i - 3 j + 2 k) kN acts at point A(2, 4, 1) m on a structural frame. What is the moment of this force vector about the coordinate origin O(0, 0, 0)?",
      "options": [
        { "text": "M_O = (11 i + 0 j - 22 k) kN·m", "isCorrect": true, "explanation": "Correct! Let's compute the vector cross product using the determinant method (Beer & Johnston *Vector Mechanics for Engineers: Statics* Chapter 3). 1. **Position Vector $\\mathbf{r}$:** Point $A(2, 4, 1)$ from origin $O(0,0,0) \\implies \\mathbf{r} = 2\\hat{\\mathbf{i}} + 4\\hat{\\mathbf{j}} + 1\\hat{\\mathbf{k}}$. 2. **Force Vector $\\mathbf{F}$:** $\\mathbf{F} = 4\\hat{\\mathbf{i}} - 3\\hat{\\mathbf{j}} + 2\\hat{\\mathbf{k}}$. 3. **Determinant Setup:** $$\\mathbf{M}_O = \\mathbf{r} \\times \\mathbf{F} = \\begin{vmatrix} \\hat{\\mathbf{i}} & \\hat{\\mathbf{j}} & \\hat{\\mathbf{k}} \\\\ 2 & 4 & 1 \\\\ 4 & -3 & 2 \\end{vmatrix}$$ 4. **Expansion by Minors:** - $\\hat{\\mathbf{i}}\\text{ component}: (4 \\cdot 2 - 1 \\cdot (-3)) = 8 - (-3) = \\mathbf{11\\hat{\\mathbf{i}}}$ - $\\hat{\\mathbf{j}}\\text{ component}: - (2 \\cdot 2 - 1 \\cdot 4) = - (4 - 4) = \\mathbf{0\\hat{\\mathbf{j}}}$ - $\\hat{\\mathbf{k}}\\text{ component}: (2 \\cdot (-3) - 4 \\cdot 4) = -6 - 16 = \\mathbf{-22\\hat{\\mathbf{k}}}$ 5. **Final Result:** $$\\mathbf{M}_O = (11\\hat{\\mathbf{i}} + 0\\hat{\\mathbf{j}} - 22\\hat{\\mathbf{k}})\\text{ kN}\\cdot\\text{m}$$" },
        { "text": "M_O = (8 i - 12 j + 2 k) kN·m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "M_O = (5 i + 8 j - 10 k) kN·m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "M_O = (0 i + 0 j + 0 k) kN·m", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
