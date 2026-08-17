# Duofy Reusable Lesson Format: Magnetic Dipoles and Multipole Expansion

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Electromagnetism_and_Electrodynamics / Magnetostatics_and_Biot_Savart`  
**Lesson Format Type:** `magnetic_dipoles_and_multipole_expansion`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the multipole expansion of vector potential $\mathbf{A}(\mathbf{r})$: prove the **Non-Existence of Magnetic Monopole Term ($\oint d\mathbf{l}' = \mathbf{0}$)**, define the **Magnetic Dipole Moment $\mathbf{m} \equiv I \mathbf{a} = \frac{1}{2} \oint (\mathbf{r}' \times I d\mathbf{l}')$**, derive the **Dipole Vector Potential $\mathbf{A}_{\text{dip}}(\mathbf{r}) = \frac{\mu_0}{4\pi}\frac{\mathbf{m}\times\hat{\mathbf{r}}}{r^2}$**, compute the **Dipole Magnetic Field $\mathbf{B}_{\text{dip}}(\mathbf{r}) = \frac{\mu_0}{4\pi r^3}[3(\mathbf{m}\cdot\hat{\mathbf{r}})\hat{\mathbf{r}} - \mathbf{m}]$**, and evaluate magnetic torque $\mathbf{N} = \mathbf{m}\times\mathbf{B}$ and energy $U = -\mathbf{m}\cdot\mathbf{B}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Magnetic Dipole & Multipole Expansion Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Dipole Vector Potential Expansion Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Dipole Physical Quantity & Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Pure Dipole Magnetic Field Radial Power Decay Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Force on Magnetic Dipole in Inhomogeneous Field Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Multipole Expansion of the Magnetic Vector Potential $\mathbf{A}(\mathbf{r})$ for localized current loop:
   $$\mathbf{A}(\mathbf{r}) = \frac{\mu_0 I}{4\pi} \oint \frac{d\mathbf{l}'}{|\mathbf{r} - \mathbf{r}'|} = \frac{\mu_0 I}{4\pi} \left[ \frac{1}{r}\oint d\mathbf{l}' + \frac{1}{r^2}\oint (\hat{\mathbf{r}}\cdot\mathbf{r}') d\mathbf{l}' + \dots \right]$$
   - **Monopole Term:** $\oint d\mathbf{l}' = \mathbf{0}$ (Magnetic monopoles do not exist!).
   - **Magnetic Dipole Moment:** $\mathbf{m} \equiv I \mathbf{a} = \frac{1}{2} I \oint (\mathbf{r}' \times d\mathbf{l}')$.
   - **Dipole Vector Potential:**
     $$\mathbf{A}_{\text{dip}}(\mathbf{r}) = \frac{\mu_0}{4\pi} \frac{\mathbf{m} \times \hat{\mathbf{r}}}{r^2}$$
   - **Dipole Magnetic Field:**
     $$\mathbf{B}_{\text{dip}}(\mathbf{r}) = \nabla \times \mathbf{A}_{\text{dip}} = \frac{\mu_0}{4\pi r^3} \left[ 3(\mathbf{m} \cdot \hat{\mathbf{r}})\hat{\mathbf{r}} - \mathbf{m} \right]$$
   - **Torque & Potential Energy:** $\mathbf{N} = \mathbf{m} \times \mathbf{B}$, $U = -\mathbf{m} \cdot \mathbf{B}$, $\mathbf{F} = \nabla(\mathbf{m} \cdot \mathbf{B})$.
2. **Slide 2 (`ordering`):** Provide 5 steps deriving dipole vector potential: (1) expand inverse distance $1/|\mathbf{r}-\mathbf{r}'| = \frac{1}{r} + \frac{\mathbf{r}\cdot\mathbf{r}'}{r^3} + \dots$, (2) substitute into vector potential: $\mathbf{A}_{\text{dip}}(\mathbf{r}) = \frac{\mu_0 I}{4\pi r^2} \oint (\hat{\mathbf{r}}\cdot\mathbf{r}') d\mathbf{l}'$, (3) apply loop vector identity $\oint (\mathbf{c}\cdot\mathbf{r}') d\mathbf{l}' = -\mathbf{c} \times \frac{1}{2}\oint (\mathbf{r}'\times d\mathbf{l}')$ with $\mathbf{c} = \hat{\mathbf{r}}$, (4) substitute definition of magnetic dipole moment $\mathbf{m} = \frac{1}{2} I \oint (\mathbf{r}'\times d\mathbf{l}') = I\mathbf{a}$, (5) conclude $\mathbf{A}_{\text{dip}}(\mathbf{r}) = \frac{\mu_0}{4\pi} \frac{\mathbf{m}\times\hat{\mathbf{r}}}{r^2}$!
3. **Slide 3 (`matching`):** Pair 4 dipole expressions (Dipole Moment $\mathbf{m}$, Magnetic Torque $\mathbf{N}$, Potential Energy $U$, Translational Force $\mathbf{F}$) with their vector formulas ($I\mathbf{a}$, $\mathbf{m}\times\mathbf{B}$, $-\mathbf{m}\cdot\mathbf{B}$, $\nabla(\mathbf{m}\cdot\mathbf{B})$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the magnetic field of a pure magnetic dipole decays with distance as 1/r^3. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the net translational force on a magnetic dipole in a UNIFORM magnetic field vs INHOMOGENEOUS magnetic field: Why is the net force $\mathbf{F} = \mathbf{0}$ in a uniform field, but non-zero in a gradient field? (In a uniform $\mathbf{B}$ field, $\mathbf{F} = \nabla(\mathbf{m}\cdot\mathbf{B}) = \mathbf{0}$ because $\mathbf{B}$ has zero spatial derivatives (only torque $\mathbf{N} = \mathbf{m}\times\mathbf{B}$ acts); in a non-uniform field ($\nabla B \ne 0$), opposite sides of the current loop experience unequal Lorentz forces, producing net translational force $\mathbf{F} = \nabla(\mathbf{m}\cdot\mathbf{B})$ like in the Stern-Gerlach experiment).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "magnetic_dipoles_and_multipole_expansion",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Magnetic Dipoles and Multipole Expansion**\n• **Multipole Expansion of Vector Potential $\\mathbf{A}$:**\n$$\n\\mathbf{A}(\\mathbf{r}) = \\frac{\\mu_0 I}{4\\pi} \\oint \\frac{d\\mathbf{l}'}{|\\mathbf{r} - \\mathbf{r}'|} = \\frac{\\mu_0 I}{4\\pi} \\left[ \\frac{1}{r}\\underbrace{\\oint d\\mathbf{l}'}_{= \\mathbf{0} \\text{ (No Monopole)}} + \\frac{1}{r^2}\\oint (\\hat{\\mathbf{r}}\\cdot\\mathbf{r}') d\\mathbf{l}' + \\dots \\right]\n$$\n• **Magnetic Dipole Moment $\\mathbf{m}$:** $\\mathbf{m} \\equiv I \\mathbf{a} = I \\iint d\\mathbf{a}$.\n• **Dipole Vector Potential & Field:**\n$$\n\\mathbf{A}_{\\text{dip}}(\\mathbf{r}) = \\frac{\\mu_0}{4\\pi} \\frac{\\mathbf{m} \\times \\hat{\\mathbf{r}}}{r^2}, \\qquad \\mathbf{B}_{\\text{dip}}(\\mathbf{r}) = \\frac{\\mu_0}{4\\pi r^3} \\left[ 3(\\mathbf{m} \\cdot \\hat{\\mathbf{r}})\\hat{\\mathbf{r}} - \\mathbf{m} \\right]\n$$\n• **Mechanics:** Torque $\\mathbf{N} = \\mathbf{m} \\times \\mathbf{B}$, Energy $U = -\\mathbf{m} \\cdot \\mathbf{B}$, Force $\\mathbf{F} = \\nabla(\\mathbf{m} \\cdot \\mathbf{B})$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the vector algebra steps deriving the magnetic dipole potential A_dip = (mu_0 / 4 pi) (m x r_hat) / r^2.",
      "orderItems": [
        "Taylor expand the inverse distance 1/|r - r'| in powers of r'/r to isolate the 1/r^2 dipole term",
        "Write the dipole integral: A_dip(r) = (mu_0 I / [4 pi r^2]) * oint (r_hat . r') dl'",
        "Apply loop contour vector identity: oint (c . r') dl' = -c x [ (1/2) oint (r' x dl') ] with c = r_hat",
        "Identify the magnetic dipole moment definition: m = (1/2) I * oint (r' x dl') = I * a",
        "Substitute m into the vector cross product to obtain A_dip(r) = (mu_0 / 4 pi) * (m x r_hat) / r^2"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each magnetic dipole property to its vector formula.",
      "matchPairs": [
        { "left": "Dipole Moment of Planar Loop (Area A)", "right": "m = I * A * n_hat (direction given by right-hand rule)" },
        { "left": "Torque on Dipole in Magnetic Field", "right": "N = m x B (aligns dipole parallel to field)" },
        { "left": "Potential Energy in Magnetic Field", "right": "U = -m . B (minimum energy U = -mB when aligned)" },
        { "left": "Translational Force in Non-Uniform Field", "right": "F = grad(m . B) (Stern-Gerlach deflection force)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The magnetic field B of an idealized magnetic dipole falls off inversely with the ___ of distance r (B proportional to 1/r^3).",
      "blankAnswer": "cube",
      "blankDistractors": ["square", "fourth", "linear"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What net magnetic force does a magnetic dipole m experience in a completely UNIFORM magnetic field B?",
      "options": [
        { "text": "F = 0 (zero net translational force, but a non-zero aligning torque N = m x B acts on the dipole)", "isCorrect": true, "explanation": "Correct! Because F = grad(m . B), if B is uniform, all spatial derivatives vanish (grad(B) = 0 => F = 0). The dipole experiences pure torque N = m x B tending to rotate it into alignment with B." },
        { "text": "F = m * B directed parallel to B", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "F = q * v * B", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "F = infinity", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
