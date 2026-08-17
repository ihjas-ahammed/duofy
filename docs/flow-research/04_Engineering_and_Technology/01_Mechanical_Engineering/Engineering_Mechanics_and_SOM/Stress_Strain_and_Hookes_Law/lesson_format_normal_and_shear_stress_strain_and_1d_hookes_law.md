# Duofy Reusable Lesson Format: Normal & Shear Stress (Strain and 1D Hooke's Law)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Engineering_Mechanics_and_SOM / Stress_Strain_and_Hookes_Law`  
**Lesson Format Type:** `normal_and_shear_stress_strain_and_1d_hookes_law`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through internal resisting force intensities, axial elongation mechanics, shear distortion, and linear elasticity in mechanics of materials (Ferdinand P. Beer, E. Russell Johnston Jr. et al. *Mechanics of Materials* Chapter 1 & 2; Russell C. Hibbeler *Mechanics of Materials* Chapter 1 & 3): master **Normal Stress ($\mathbf{\sigma = \frac{P}{A}}$)** and **Engineering Normal Strain ($\mathbf{\epsilon = \frac{\delta}{L_0}}$)**, master **1D Hooke's Law ($\mathbf{\sigma = E \epsilon}$)** and the fundamental axial deformation equation ($\mathbf{\delta = \frac{PL}{AE}}$), master **Direct Shear Stress ($\mathbf{\tau = \frac{V}{A}}$)** (single shear vs double shear in bolted lap/butt joints), master **Shear Strain ($\mathbf{\gamma = \frac{\pi}{2} - \theta^*}$)** and **Hooke's Law in Shear ($\mathbf{\tau = G \gamma}$)** where $G$ is the Modulus of Rigidity, and solve stepped bar systems under multiple axial loads.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Normal vs Shear Stress Formulas ($\sigma = P/A, \tau = V/A$), 1D Hooke's Law & $\delta = PL/(AE)$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Procedure to Calculate Total Axial Elongation of a Multi-Stepped Bar Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Solid Mechanics Construct / Parameter & Exact Technical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Constant of Proportionality Relating Normal Stress to Normal Strain Within the Elastic Range Is Young's ___ (Modulus) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Mechanics Problem: Calculating the Total Axial Elongation of a Stepped Steel Bar Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Stress & Strain (Beer & Johnston 2020; Hibbeler 2018):
   - **Stress & Strain Formulation Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Loading Mode} & \textbf{Stress Formulation} & \textbf{Strain Formulation} & \textbf{Constitutive Hooke's Law} \\
     \hline
     \mathbf{\text{Axial Tension/Compression}} & \mathbf{\sigma = \frac{P}{A} \ [\text{N/m}^2 \equiv \text{Pa}]} & \mathbf{\epsilon = \frac{\delta}{L_0} \ [\text{dimensionless}]} & \mathbf{\sigma = E \epsilon \implies \delta = \frac{PL}{AE}} \\
     \mathbf{\text{Direct Shear Loading}} & \mathbf{\tau = \frac{V}{A} \ [\text{Pa}]} & \mathbf{\gamma \ [\text{radians}]} & \mathbf{\tau = G \gamma} \\
     \hline
     \end{array}$$
   - **Single Shear vs Double Shear:**
     - Single Shear (Lap Joint): $\tau = \frac{V}{A} = \frac{P}{\frac{\pi}{4} d^2}$.
     - Double Shear (Butt Joint): $\tau = \frac{V}{2A} = \frac{P}{2 \left(\frac{\pi}{4} d^2\right)} \implies$ Carries twice the shear load!
2. **Slide 2 (`ordering`):** Provide 5 steps of solving a multi-stepped bar: (1) pass imaginary section cuts through each discrete segment of the stepped bar, (2) apply axial static equilibrium $\sum F_x = 0$ on each section to find the internal normal force $P_i$ in segment $i$, (3) compute the cross-sectional area $A_i = \frac{\pi}{4} d_i^2$ and identify length $L_i$ and modulus $E_i$ for each segment, (4) evaluate individual segment axial deformations $\delta_i = \frac{P_i L_i}{A_i E_i}$ (positive for tension, negative for compression), (5) sum all segment deformations algebraically to find total end displacement $\delta_{\text{total}} = \sum_{i=1}^n \frac{P_i L_i}{A_i E_i}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Young's Modulus $E$, Modulus of Rigidity $G$, Normal Stress $\sigma$, Double Shear) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Modulus. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating stepped bar elongation: A solid steel bar of Young's modulus $E = 200\text{ GPa} = 200 \times 10^9\text{ Pa}$ consists of two segments: Segment 1 has length $L_1 = 1.0\text{ m}$ and area $A_1 = 500\text{ mm}^2 = 500 \times 10^{-6}\text{ m}^2$, carrying an axial tensile force of $P_1 = 50\text{ kN} = 50 \times 10^3\text{ N}$. Segment 2 has length $L_2 = 2.0\text{ m}$ and area $A_2 = 1000\text{ mm}^2 = 1000 \times 10^{-6}\text{ m}^2$, carrying an axial tensile force of $P_2 = 50\text{ kN}$. What is the total axial elongation $\delta_{\text{total}}$ of the bar? ($\delta_1 = \frac{P_1 L_1}{A_1 E} = \frac{(50 \times 10^3)(1.0)}{(500 \times 10^{-6})(200 \times 10^9)} = \frac{50 \times 10^3}{100 \times 10^6} = 0.5 \times 10^{-3}\text{ m} = 0.5\text{ mm}$; $\delta_2 = \frac{P_2 L_2}{A_2 E} = \frac{(50 \times 10^3)(2.0)}{(1000 \times 10^{-6})(200 \times 10^9)} = \frac{100 \times 10^3}{200 \times 10^6} = 0.5\text{ mm}$; $\delta_{\text{total}} = \delta_1 + \delta_2 = 0.5 + 0.5 = \mathbf{1.0\text{ mm}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "normal_and_shear_stress_strain_and_1d_hookes_law",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: 1D Stress, Strain \\& Hooke's Law (Beer \\& Johnston)**\n• **Normal vs Shear Constitutive Formulations:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Loading Mode} & \\textbf{Stress (Intensity of Force)} & \\textbf{Engineering Strain} & \\textbf{Hooke's Constitutive Law} \\\\\n\\hline\n\\mathbf{\\text{Axial Normal Loading}} & \\mathbf{\\sigma = \\frac{P}{A} \\ [\\text{Pa} \\equiv \\text{N/m}^2]} & \\mathbf{\\epsilon = \\frac{\\delta}{L_0} \\ [\\text{unitless}]} & \\mathbf{\\sigma = E \\epsilon \\implies \\delta = \\frac{PL}{AE}} \\\\\n\\mathbf{\\text{Direct Shear Loading}} & \\mathbf{\\tau = \\frac{V}{A} \\ [\\text{Pa}]} & \\mathbf{\\gamma \\ [\\text{angular rad}]} & \\mathbf{\\tau = G \\gamma} \\\\\n\\hline\n\\end{array}\n$$\n• **The Stepped Bar Superposition Law:**\n$$\n\\mathbf{\\delta_{\\text{total}} = \\sum_{i=1}^n \\frac{P_i L_i}{A_i E_i} \\quad (\\text{Tensile } P_i > 0, \\text{ Compressive } P_i < 0)}\n$$\n• **Double Shear Invariant:** A pin in double shear splits the applied shear force across two parallel failure planes: $\\mathbf{\\tau = \\frac{P}{2A}}$, doubling shear capacity!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the total axial elongation of a multi-stepped bar subjected to multiple axial point loads.",
      "orderItems": [
        "Pass imaginary cross-sectional cuts through each discrete segment of the stepped bar",
        "Apply static axial equilibrium sum Fx = 0 on each isolated section to determine the internal normal force Pi in each segment",
        "Calculate the cross-sectional area Ai and determine length Li and modulus Ei for each individual segment",
        "Compute the axial elongation of each segment using delta_i = (Pi * Li) / (Ai * Ei)",
        "Sum all individual segment deformations algebraically (delta_total = sum delta_i) to obtain the total end displacement"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Mechanics of Materials Primitive to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Young's Modulus (E)", "right": "Material stiffness property representing the ratio of normal stress to normal strain (sigma / epsilon)" },
        { "left": "Modulus of Rigidity (G)", "right": "Shear modulus representing the ratio of shear stress to shear strain (tau / gamma)" },
        { "left": "Axial Deformation Formula", "right": "delta = P * L / (A * E), expressing linear elastic elongation under constant axial load" },
        { "left": "Double Shear Joint", "right": "Fastener joint configuration distributing load across two shear planes (tau = P / 2A)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The fundamental constant of proportionality relating normal stress to normal strain within the linear elastic range is Young's ___.",
      "blankAnswer": "modulus",
      "blankDistractors": ["ratio", "factor", "limit"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A solid steel bar (E = 200 GPa = 200 x 10^9 Pa) has two segments: Segment 1 (L1 = 1.0 m, A1 = 500 mm^2 = 500 x 10^-6 m^2) and Segment 2 (L2 = 2.0 m, A2 = 1000 mm^2 = 1000 x 10^-6 m^2). The entire bar carries an axial tensile load of P = 50 kN. What is the total axial elongation delta_total of the bar?",
      "options": [
        { "text": "delta_total = 1.0 mm (delta_1 = 0.5 mm and delta_2 = 0.5 mm)", "isCorrect": true, "explanation": "Correct! Let's calculate the elongation of each segment independently using Hooke's Law (Beer & Johnston *Mechanics of Materials* Chapter 2). 1. **Elongation of Segment 1 ($\\delta_1$):** $$\\delta_1 = \\frac{P_1 L_1}{A_1 E} = \\frac{(50 \\times 10^3\\text{ N})(1.0\\text{ m})}{(500 \\times 10^{-6}\\text{ m}^2)(200 \\times 10^9\\text{ Pa})} = \\frac{50,000}{100,000,000} = 0.0005\\text{ m} = \\mathbf{0.5\\text{ mm}}$$ 2. **Elongation of Segment 2 ($\\delta_2$):** $$\\delta_2 = \\frac{P_2 L_2}{A_2 E} = \\frac{(50 \\times 10^3\\text{ N})(2.0\\text{ m})}{(1000 \\times 10^{-6}\\text{ m}^2)(200 \\times 10^9\\text{ Pa})} = \\frac{100,000}{200,000,000} = 0.0005\\text{ m} = \\mathbf{0.5\\text{ mm}}$$ 3. **Total Elongation ($\\delta_{\\text{total}}$):** $$\\delta_{\\text{total}} = \\delta_1 + \\delta_2 = 0.5\\text{ mm} + 0.5\\text{ mm} = \\mathbf{1.0\\text{ mm}}$$" },
        { "text": "delta_total = 0.5 mm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "delta_total = 2.5 mm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "delta_total = 4.0 mm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
