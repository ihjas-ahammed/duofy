# Duofy Reusable Lesson Format: Biot-Savart Law and Current Distributions

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Electromagnetism_and_Electrodynamics / Magnetostatics_and_Biot_Savart`  
**Lesson Format Type:** `biot_savart_law_and_current_distributions`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the foundational law of steady-state magnetic fields: formulate the **Biot-Savart Law (1820)** for line, surface, and volume currents, integrate $\mathbf{B}$ for an **Infinite Straight Wire ($B = \frac{\mu_0 I}{2\pi s}$)**, evaluate the magnetic field on the symmetry axis of a **Circular Current Loop ($B(z) = \frac{\mu_0 I R^2}{2(R^2+z^2)^{3/2}}$)**, determine the field at the center of a circular polygon / loop, and evaluate the magnetic force between parallel conductors.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Biot-Savart Law & Circular Loop Field Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step On-Axis Circular Loop Field Integration Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Current Geometry & Magnetic Field Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Infinite Wire Magnetic Field Denominator Pi Factor Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Parallel vs Antiparallel Current Conductor Force Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Biot-Savart Law for steady currents (Jean-Baptiste Biot & Félix Savart, 1820):
   $$\mathbf{B}(\mathbf{r}) = \frac{\mu_0}{4\pi} \int \frac{I \, d\mathbf{l}' \times \hat{\boldsymbol{r}}}{r^2} = \frac{\mu_0}{4\pi} \iiint \frac{\mathbf{J}(\mathbf{r}') \times (\mathbf{r} - \mathbf{r}')}{|\mathbf{r} - \mathbf{r}'|^3} \, dV'$$
   where $\mu_0 = 4\pi \times 10^{-7}\text{ N/A}^2$ is the permeability of free space.
   - **Key Field Configurations:**
     - **Infinite Straight Wire:** $B(s) = \frac{\mu_0 I}{2\pi s} \hat{\boldsymbol{\phi}}$ (Right-hand rule).
     - **Circular Loop (radius $R$) along $z$-axis:** $B_z(z) = \frac{\mu_0 I R^2}{2(R^2 + z^2)^{3/2}}$.
     - **Center of Circular Loop ($z = 0$):** $B = \frac{\mu_0 I}{2R}$.
2. **Slide 2 (`ordering`):** Provide 5 steps deriving on-axis field $B_z(z)$ of a circular ring: (1) consider line element $d\mathbf{l}' = R d\phi' \hat{\boldsymbol{\phi}}$ in the $xy$-plane, (2) compute cross product $d\mathbf{l}' \times \hat{\boldsymbol{r}}$ where separation distance is $r = \sqrt{R^2 + z^2}$, (3) note that transverse components cancel by azimuthal symmetry: $\oint d\mathbf{B}_\perp = \mathbf{0}$, (4) isolate vertical $z$-component: $d B_z = dB \cos\theta = dB \left(\frac{R}{\sqrt{R^2 + z^2}}\right) = \frac{\mu_0 I}{4\pi} \frac{R d\phi'}{R^2 + z^2} \frac{R}{\sqrt{R^2 + z^2}}$, (5) integrate over circle $\int_0^{2\pi} d\phi' = 2\pi$ to obtain $B_z(z) = \frac{\mu_0 I R^2}{2(R^2 + z^2)^{3/2}}$!
3. **Slide 3 (`matching`):** Pair 4 current geometries (Infinite Straight Wire, Center of Circular Loop, Semi-Infinite Wire, On-Axis Center of Helmholtz Coils) with their exact magnetic field formulas.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the magnetic field of an infinite straight wire $B = \frac{\mu_0 I}{2\pi s}$ has a factor of 2 in the denominator. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the magnetic force between parallel current-carrying wires: What is the nature and magnitude per unit length of the force between two long parallel wires carrying currents $I_1$ and $I_2$ in the SAME direction separated by distance $d$? (They ATTRACT each other with force per unit length $f = \frac{\mu_0 I_1 I_2}{2\pi d}$; by the right-hand rule, wire 1 creates field $B_1 = \mu_0 I_1 / (2\pi d)$, and the Lorentz force $\mathbf{F} = I_2 (\mathbf{L} \times \mathbf{B}_1)$ pulls wire 2 inward).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "biot_savart_law_and_current_distributions",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Biot-Savart Law and Current Fields**\n• **The Biot-Savart Law (1820):**\n$$\n\\mathbf{B}(\\mathbf{r}) = \\frac{\\mu_0}{4\\pi} \\int \\frac{I \\, d\\mathbf{l}' \\times \\hat{\\boldsymbol{r}}}{r^2}\n$$\n• **Permeability Constant:** $\\mu_0 = 4\\pi \\times 10^{-7}\\text{ T}\\cdot\\text{m/A}$.\n• **Standard Field Configurations:**\n  - **Infinite Straight Wire:** $B(s) = \\frac{\\mu_0 I}{2\\pi s}$ (circulating azimuthal field).\n  - **Circular Ring On-Axis ($z$-axis):** $B_z(z) = \\frac{\\mu_0 I R^2}{2(R^2 + z^2)^{3/2}}$.\n  - **Center of Loop ($z = 0$):** $B_0 = \\frac{\\mu_0 I}{2R}$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the geometric integration steps determining the on-axis magnetic field of a circular current loop.",
      "orderItems": [
        "Express differential current element dl' = R dphi' phi_hat in the xy-plane at radius R",
        "Compute distance to on-axis observation point: script_r = sqrt(R^2 + z^2)",
        "Observe that transverse horizontal components cancel pairwise by circular symmetry: oint dB_perp = 0",
        "Project differential field along the vertical z-axis: dB_z = dB * cos(alpha) = dB * (R / sqrt(R^2 + z^2))",
        "Integrate azimuthal angle from 0 to 2pi: B_z = (mu_0 I R / [4 pi (R^2 + z^2)^{3/2}]) * (2 pi R) = mu_0 I R^2 / [2 (R^2 + z^2)^{3/2}]"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each current configuration to its magnetic field formula.",
      "matchPairs": [
        { "left": "Infinite Straight Wire (distance s)", "right": "B = mu_0 * I / (2 pi s)" },
        { "left": "Center of Flat Circular Loop (radius R)", "right": "B = mu_0 * I / (2 R)" },
        { "left": "Semi-Infinite Straight Wire (end point)", "right": "B = mu_0 * I / (4 pi s)" },
        { "left": "Center of Semicircular Arc (radius R)", "right": "B = mu_0 * I / (4 R)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The magnetic field B at distance s from an infinite straight current wire equals mu_0 * I / (___ * pi * s).",
      "blankAnswer": "2",
      "blankDistractors": ["4", "1", "3"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the direction and magnitude of the magnetic force per unit length between two parallel straight wires carrying currents I_1 and I_2 in the SAME direction separated by distance d?",
      "options": [
        { "text": "ATTRACTIVE force per unit length f = mu_0 * I_1 * I_2 / (2 pi d); currents in the same direction attract, while antiparallel currents repel", "isCorrect": true, "explanation": "Correct! Wire 1 creates a magnetic field B_1 = mu_0 I_1 / (2 pi d) at wire 2. Applying the Lorentz force rule F = I_2 (L x B_1) yields an attractive force directed toward wire 1." },
        { "text": "Repulsive force f = mu_0 * I_1 * I_2 / (2 pi d)", "isCorrect": false, "explanation": "Incorrect: Parallel currents attract." },
        { "text": "Zero force because magnetic fields do no work", "isCorrect": false, "explanation": "Incorrect: Magnetic forces between wires are non-zero." },
        { "text": "Attractive force proportional to 1/d^2", "isCorrect": false, "explanation": "Incorrect: Force scales as 1/d." }
      ]
    }
  ]
}
```
