# Duofy Reusable Lesson Format: Inertia Tensor and Principal Axes

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Classical_Mechanics / Rigid_Body_Dynamics`  
**Lesson Format Type:** `inertia_tensor_and_principal_axes`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the rotational inertia of 3D rigid bodies: formulate the **Inertia Tensor Matrix $\mathbf{I}$** ($I_{ij} = \int (r^2 \delta_{ij} - x_i x_j) \rho \, dV$), compute moments and products of inertia, apply the **Parallel Axis Theorem** ($I_{ij} = I_{ij}^{\text{CM}} + M(d^2 \delta_{ij} - a_i a_j)$), diagonalize $\mathbf{I}$ to find **Principal Axes** and **Principal Moments of Inertia ($I_1, I_2, I_3$)**, and evaluate angular momentum $\mathbf{L} = \mathbf{I}\boldsymbol{\omega}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Inertia Tensor & Principal Axes Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Rotational Kinetic Energy Quadratic Form Proof | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Rigid Rotor Symmetry Type & Moment Relations Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Diagonalized Product of Inertia Off-Diagonal Value Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Non-Collinearity of L and Omega in Asymmetric Bodies Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of the 3D Inertia Tensor $\mathbf{I}$ for a continuous rigid body with density $\rho(\mathbf{r})$:
   $$\mathbf{I} = \begin{bmatrix} I_{xx} & I_{xy} & I_{xz} \\ I_{yx} & I_{yy} & I_{yz} \\ I_{zx} & I_{zy} & I_{zz} \end{bmatrix}$$
   - **Diagonal Moments of Inertia:** $I_{xx} = \int (y^2 + z^2) \rho \, dV$, etc.
   - **Off-Diagonal Products of Inertia:** $I_{xy} = I_{yx} = -\int x y \rho \, dV$, etc.
   - **Principal Axes:** A symmetric real matrix is always orthogonally diagonalizable: $\mathbf{I}_{\text{body}} = \operatorname{diag}(I_1, I_2, I_3)$.
   - **Angular Momentum:** $\mathbf{L} = \mathbf{I} \boldsymbol{\omega}$. (In general, $\mathbf{L}$ is NOT parallel to $\boldsymbol{\omega}$ unless $\boldsymbol{\omega}$ lies along a principal axis!).
   - **Rotational Kinetic Energy:** $T_{\text{rot}} = \frac{1}{2} \boldsymbol{\omega}^T \mathbf{I} \boldsymbol{\omega} = \frac{1}{2} \mathbf{L} \cdot \boldsymbol{\omega}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct proof of $T_{\text{rot}} = \frac{1}{2} \boldsymbol{\omega}^T \mathbf{I} \boldsymbol{\omega}$: (1) write total kinetic energy of $N$ mass particles rotating with angular velocity $\boldsymbol{\omega}$: $T = \frac{1}{2} \sum_k m_k (\mathbf{v}_k \cdot \mathbf{v}_k)$, (2) substitute rigid body velocity $\mathbf{v}_k = \boldsymbol{\omega} \times \mathbf{r}_k$, (3) use scalar triple product cyclic identity: $(\boldsymbol{\omega} \times \mathbf{r}_k) \cdot (\boldsymbol{\omega} \times \mathbf{r}_k) = \boldsymbol{\omega} \cdot [\mathbf{r}_k \times (\boldsymbol{\omega} \times \mathbf{r}_k)]$, (4) apply BAC-CAB expansion: $\mathbf{r}_k \times (\boldsymbol{\omega} \times \mathbf{r}_k) = r_k^2 \boldsymbol{\omega} - (\mathbf{r}_k \cdot \boldsymbol{\omega})\mathbf{r}_k$, (5) factor $\boldsymbol{\omega}$: $T = \frac{1}{2} \boldsymbol{\omega} \cdot \left[ \sum_k m_k (r_k^2 \mathbf{1} - \mathbf{r}_k \otimes \mathbf{r}_k) \right] \cdot \boldsymbol{\omega} = \frac{1}{2} \boldsymbol{\omega} \cdot \mathbf{I} \cdot \boldsymbol{\omega}$!
3. **Slide 3 (`matching`):** Pair 4 rotor symmetry classifications (Spherical Top, Symmetric Prolate Top, Symmetric Oblate Top, Asymmetric Top) with their principal moment relations ($I_1 = I_2 = I_3$, $I_1 = I_2 > I_3$ (cigar), $I_1 = I_2 < I_3$ (pancake), $I_1 < I_2 < I_3$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that when coordinate axes are aligned with principal axes, all off-diagonal products of inertia vanish to zero. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the directional relationship between angular momentum $\mathbf{L}$ and angular velocity $\boldsymbol{\omega}$: Under what exact physical condition are $\mathbf{L}$ and $\boldsymbol{\omega}$ strictly PARALLEL to each other? (Only when the instantaneous axis of rotation $\boldsymbol{\omega}$ is an EIGENVECTOR of the inertia tensor $\mathbf{I}$, which corresponds to rotating along a **Principal Axis**; for arbitrary rotation axes, $\mathbf{L} = \mathbf{I}\boldsymbol{\omega}$ points in a different direction than $\boldsymbol{\omega}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "inertia_tensor_and_principal_axes",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Inertia Tensor and Principal Axes**\n• **The 3D Inertia Tensor Matrix $\\mathbf{I}$:**\n$$\nI_{ij} = \\int \\left( r^2 \\delta_{ij} - x_i x_j \\right) \\rho(\\mathbf{r}) \\, dV\n$$\n• **Principal Moments of Inertia ($I_1, I_2, I_3$):**\n  Because $\\mathbf{I}$ is a symmetric real tensor, there exists an orthogonal coordinate system where $\\mathbf{I}$ is diagonal:\n$$\n\\mathbf{I} = \\operatorname{diag}(I_1, I_2, I_3)\n$$\n• **Angular Momentum:** $\\mathbf{L} = \\mathbf{I} \\boldsymbol{\\omega} = (I_1 \\omega_1, I_2 \\omega_2, I_3 \\omega_3)$.\n• **Rotational Kinetic Energy:**\n$$\nT_{\\text{rot}} = \\frac{1}{2} \\boldsymbol{\\omega}^T \\mathbf{I} \\boldsymbol{\\omega} = \\frac{1}{2}(I_1 \\omega_1^2 + I_2 \\omega_2^2 + I_3 \\omega_3^2)\n$$\n  *(Note: $\\mathbf{L}$ and $\\boldsymbol{\\omega}$ are collinear **only** when rotating along a principal axis!).*"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Sum of Kinetic Energies):** $T = \\frac{1}{2} \\sum_k m_k (\\mathbf{v}_k \\cdot \\mathbf{v}_k)$.\n• **Step 2 (Substitute Rigid Velocity):** $\\mathbf{v}_k = \\boldsymbol{\\omega} \\times \\mathbf{r}_k$.\n• **Step 3 (Vector Identity Permutation):** $(\\boldsymbol{\\omega} \\times \\mathbf{r}_k) \\cdot (\\boldsymbol{\\omega} \\times \\mathbf{r}_k) = \\boldsymbol{\\omega} \\cdot [\\mathbf{r}_k \\times (\\boldsymbol{\\omega} \\times \\mathbf{r}_k)]$.\n• **Step 4 (BAC-CAB Expansion):** $\\mathbf{r}_k \\times (\\boldsymbol{\\omega} \\times \\mathbf{r}_k) = r_k^2 \\boldsymbol{\\omega} - (\\mathbf{r}_k \\cdot \\boldsymbol{\\omega})\\mathbf{r}_k$.\n• **Step 5 (Factor Angular Velocity):** $T = \\frac{1}{2} \\boldsymbol{\\omega} \\cdot [\\sum_k m_k (r_k^2 \\mathbf{1} - \\mathbf{r}_k \\otimes \\mathbf{r}_k)] \\cdot \\boldsymbol{\\omega} = \\frac{1}{2} \\boldsymbol{\\omega} \\cdot \\mathbf{I} \\cdot \\boldsymbol{\\omega}$!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each rotor symmetry classification to its principal moment relation.",
      "matchPairs": [
        { "left": "Spherical Top (e.g. solid sphere, cube)", "right": "I_1 = I_2 = I_3 (any axis is a principal axis)" },
        { "left": "Symmetric Prolate Top (cigar-shaped)", "right": "I_1 = I_2 > I_3 (moment around symmetry axis is smallest)" },
        { "left": "Symmetric Oblate Top (frisbee/pancake)", "right": "I_1 = I_2 < I_3 (moment around symmetry axis is largest)" },
        { "left": "Asymmetric Top (e.g. book, tennis racket)", "right": "I_1 < I_2 < I_3 (all 3 principal moments are distinct)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "When a rigid body's coordinate axes are aligned with its principal axes of inertia, all off-diagonal products of inertia I_xy, I_yz, I_xz equal ___.",
      "blankAnswer": "0",
      "blankDistractors": ["1", "-1", "infinity"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Under what exact condition is a rigid body's angular momentum vector L strictly PARALLEL to its angular velocity vector omega (L || omega)?",
      "options": [
        { "text": "Only when the body rotates around one of its PRINCIPAL AXES of inertia (an eigenvector of the inertia tensor matrix I)", "isCorrect": true, "explanation": "Correct! Because L = I * omega, L and omega are collinear if and only if omega is an eigenvector of I (i.e. I * omega = lambda * omega). For general rotation axes, off-diagonal moments or unequal eigenvalues cause L to tilt away from omega." },
        { "text": "For every possible axis of rotation in all bodies", "isCorrect": false, "explanation": "Incorrect: L and omega are generally non-collinear." },
        { "text": "Only when the body is at rest", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Only when external torques are non-zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
