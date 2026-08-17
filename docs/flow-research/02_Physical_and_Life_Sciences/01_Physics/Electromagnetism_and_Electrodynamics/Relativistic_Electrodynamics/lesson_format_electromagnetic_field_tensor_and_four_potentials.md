# Duofy Reusable Lesson Format: Electromagnetic Field Tensor and Four-Potentials

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Electromagnetism_and_Electrodynamics / Relativistic_Electrodynamics`  
**Lesson Format Type:** `electromagnetic_field_tensor_and_four_potentials`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the 4D geometric formulation of electromagnetism: define the **Four-Potential $A^\mu = (V/c, \mathbf{A})$** and **Four-Current $J^\mu = (c\rho, \mathbf{J})$**, enforce the **Lorenz Gauge Condition $\partial_\mu A^\mu = 0$**, construct the rank-2 antisymmetric **Electromagnetic Field Strength Tensor $F^{\mu\nu} = \partial^\mu A^\nu - \partial^\nu A^\mu$**, evaluate the covariant tensor $F_{\mu\nu}$ and Dual Tensor $\tilde{F}^{\mu\nu}$, and calculate the Lorentz invariants $F_{\mu\nu}F^{\mu\nu}$ and $\tilde{F}_{\mu\nu}F^{\mu\nu}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Four-Potentials & Field Strength Tensor Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Field Tensor Construction from Potentials Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | 4-Vector / Tensor Entity & Spacetime Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Field Strength Tensor Diagonal Elements Value Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Lorentz Invariant F_mu_nu F^mu_nu and Field Transformation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State 4D Spacetime Electrodynamics (metric signature $(-, +, +, +)$):
   - **Four-Vector Potential:** $A^\mu = \left(\frac{V}{c}, \mathbf{A}\right) = \left(\frac{V}{c}, A_x, A_y, A_z\right)$.
   - **Four-Current Density:** $J^\mu = (c\rho, \mathbf{J})$.
   - **Lorenz Gauge:** $\partial_\mu A^\mu = \frac{1}{c^2}\frac{\partial V}{\partial t} + \nabla \cdot \mathbf{A} = 0 \implies \Box A^\mu = -\mu_0 J^\mu$.
   - **The Electromagnetic Field Strength Tensor:**
     $$F^{\mu\nu} \equiv \partial^\mu A^\nu - \partial^\nu A^\mu = \begin{bmatrix} 0 & E_x/c & E_y/c & E_z/c \\ -E_x/c & 0 & B_z & -B_y \\ -E_y/c & -B_z & 0 & B_x \\ -E_z/c & B_y & -B_x & 0 \end{bmatrix}$$
   - **Antisymmetry:** $F^{\mu\nu} = -F^{\nu\mu}$ (has 6 independent components: 3 electric $E_i$, 3 magnetic $B_i$).
   - **Lorentz Invariants:**
     $$F_{\mu\nu} F^{\mu\nu} = 2\left(B^2 - \frac{E^2}{c^2}\right) = \text{invariant}, \qquad \tilde{F}_{\mu\nu} F^{\mu\nu} = -\frac{4}{c} (\mathbf{E} \cdot \mathbf{B}) = \text{invariant}$$
2. **Slide 2 (`ordering`):** Provide 5 steps constructing $F^{\mu\nu}$ from 4-potentials: (1) define 4-gradient operator: $\partial^\mu = \eta^{\mu\alpha} \partial_\alpha = (-\frac{1}{c}\frac{\partial}{\partial t}, \nabla)$, (2) compute time-space component: $F^{01} = \partial^0 A^1 - \partial^1 A^0 = -\frac{1}{c}\frac{\partial A_x}{\partial t} - \frac{\partial(V/c)}{\partial x} = \frac{1}{c}\left(-\nabla V - \frac{\partial\mathbf{A}}{\partial t}\right)_x = \frac{E_x}{c}$, (3) compute space-space component: $F^{12} = \partial^1 A^2 - \partial^2 A^1 = \frac{\partial A_y}{\partial x} - \frac{\partial A_x}{\partial y} = (\nabla \times \mathbf{A})_z = B_z$, (4) compute diagonal components: $F^{\mu\mu} = \partial^\mu A^\mu - \partial^\mu A^\mu = 0$ (diagonal is identically zero), (5) assemble the full $4 \times 4$ antisymmetric matrix $F^{\mu\nu}$!
3. **Slide 3 (`matching`):** Pair 4 relativistic electromagnetic objects ($A^\mu$, $J^\mu$, $F^{\mu\nu}$, $\tilde{F}^{\mu\nu}$) with their component structures.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that due to antisymmetry ($F^{\mu\nu} = -F^{\nu\mu}$), all diagonal elements $F^{00}, F^{11}, F^{22}, F^{33}$ equal zero. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the Lorentz Invariant $\mathbf{E}\cdot\mathbf{B}$: If an electromagnetic wave in vacuum has $\mathbf{E} \cdot \mathbf{B} = 0$ and $E = c B$ in a laboratory frame, what do other inertial observers moving at relativistic speeds observe? (They observe $\mathbf{E}' \cdot \mathbf{B}' = 0$ and $E' = c B'$ in ALL inertial reference frames, because $F_{\mu\nu}F^{\mu\nu} = 2(B^2 - E^2/c^2) = 0$ and $\tilde{F}_{\mu\nu}F^{\mu\nu} = -\frac{4}{c}(\mathbf{E}\cdot\mathbf{B}) = 0$ are strict Lorentz scalar invariants).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "electromagnetic_field_tensor_and_four_potentials",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Field Strength Tensor and Four-Potentials**\n• **Four-Potential & Four-Current:**\n$$\nA^\\mu = \\left(\\frac{V}{c}, \\mathbf{A}\\right), \\qquad J^\\mu = (c\\rho, \\mathbf{J})\n$$\n• **The Electromagnetic Field Strength Tensor $F^{\\mu\\nu}$:**\n$$\nF^{\\mu\\nu} \\equiv \\partial^\\mu A^\\nu - \\partial^\\nu A^\\mu = \\begin{bmatrix} 0 & E_x/c & E_y/c & E_z/c \\\\ -E_x/c & 0 & B_z & -B_y \\\\ -E_y/c & -B_z & 0 & B_x \\\\ -E_z/c & B_y & -B_x & 0 \\end{bmatrix}\n$$\n• **Antisymmetry:** $F^{\\mu\\nu} = -F^{\\nu\\mu}$ (6 independent components: $\\mathbf{E}$ and $\\mathbf{B}$!).\n• **Lorentz Invariants (Identical for ALL Observers):**\n$$\nF_{\\mu\\nu} F^{\\mu\\nu} = 2\\left(B^2 - \\frac{E^2}{c^2}\\right), \\qquad \\tilde{F}_{\\mu\\nu} F^{\\mu\\nu} = -\\frac{4}{c} (\\mathbf{E} \\cdot \\mathbf{B})\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the tensor calculus steps deriving the components of the field tensor F^{mu nu} = d^mu A^nu - d^nu A^mu.",
      "orderItems": [
        "Define the 4-gradient vector: d^mu = (-1/c * d/dt, grad)",
        "Calculate the 0-1 time-space component: F^{01} = d^0 A^1 - d^1 A^0 = -1/c * dA_x/dt - d/dx(V/c)",
        "Recognize definition of electric field E = -grad(V) - dA/dt to obtain F^{01} = E_x / c",
        "Calculate the 1-2 space-space component: F^{12} = d^1 A^2 - d^2 A^1 = dA_y/dx - dA_x/dy = (curl A)_z = B_z",
        "Observe that diagonal elements F^{mu mu} vanish identically, completing the 4x4 antisymmetric tensor"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each relativistic electrodynamic quantity to its 4-vector/tensor representation.",
      "matchPairs": [
        { "left": "Four-Vector Potential A^mu", "right": "(V/c, A_x, A_y, A_z)" },
        { "left": "Four-Current Density J^mu", "right": "(c * rho, J_x, J_y, J_z)" },
        { "left": "Lorenz Gauge Condition", "right": "d_mu A^mu = 0 (Lorentz invariant scalar equation)" },
        { "left": "Dual Field Tensor tilde{F}^{mu nu}", "right": "Obtained by duality rotation E/c -> B and B -> -E/c" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Due to the exact antisymmetry of the electromagnetic field tensor (F^{mu nu} = -F^{nu mu}), all diagonal elements F^{00}, F^{11}, F^{22}, F^{33} equal ___.",
      "blankAnswer": "0",
      "blankDistractors": ["1", "c", "-1"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "If an electromagnetic wave in vacuum has E ⊥ B and E = c B in one reference frame, what will an observer moving at 0.9c in a rocket measure?",
      "options": [
        { "text": "The observer will STILL measure E' ⊥ B' (E' · B' = 0) and E' = c B', because F_mu_nu F^mu_nu = 2(B² - E²/c²) = 0 and tilde{F}_mu_nu F^mu_nu = -4/c (E · B) = 0 are exact LORENTZ INVARIANTS", "isCorrect": true, "explanation": "Correct! Because B^2 - E^2/c^2 = 0 and E . B = 0 are Lorentz invariants, their values are identically zero in every inertial frame. An electromagnetic wave remains a transverse wave propagating at speed c for all observers." },
        { "text": "The wave becomes purely electrostatic with B' = 0", "isCorrect": false, "explanation": "Incorrect: Invariants forbid turning a null wave into a static field." },
        { "text": "E' and B' become parallel", "isCorrect": false, "explanation": "Incorrect: E . B = 0 in all frames." },
        { "text": "The speed of light changes to 0.1c", "isCorrect": false, "explanation": "Incorrect: c is invariant." }
      ]
    }
  ]
}
```
