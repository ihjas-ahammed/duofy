# Duofy Reusable Lesson Format: Rigid Pavement (Westergaard Stresses & Slab Stiffness)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Transportation_and_Highway_Engineering / Pavement_Design_Flexible_and_Rigid`  
**Lesson Format Type:** `rigid_pavement_westergaard_stresses_and_relative_stiffness`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through Harold M. Westergaard's 1926 classical mechanics for **Rigid Concrete Pavement Slabs** resting on a dense liquid Winkler subgrade foundation, the modulus of subgrade reaction ($k$ in $\text{MN/m}^3$ or $\text{pci}$), the fundamental parameter **Radius of Relative Stiffness ($\ell$)**, and the evaluation of critical flexural tensile stresses under wheel load $P$ at three distinct slab locations ((1) **Corner Loading $\sigma_c$**, (2) **Interior Loading $\sigma_i$**, and (3) **Edge Loading $\sigma_e$**) (Yang H. Huang *Pavement Analysis and Design* Chapter 4; Harold M. Westergaard 1926): formulate the **Westergaard Radius of Relative Stiffness ($\ell$) Master Formulation**:
$$\mathbf{\ell = \sqrt[4]{\frac{E \cdot h^3}{12 \left( 1 - \nu^2 \right) k}} \quad [\text{m} \text{ or } \text{in}]}$$
where:
1. **$E$:** Modulus of elasticity of concrete slab ($\approx 28,000\text{ MPa}$ or $4 \times 10^6\text{ psi}$);
2. **$h$:** Slab thickness ($\text{m}$ or $\text{in}$);
3. **$\nu$:** Poisson's ratio of concrete ($\nu \approx 0.15$);
4. **$k$:** Modulus of subgrade reaction ($\text{MPa/m}$ or $\text{pci}$);
formulate the **Westergaard Corner Tensile Stress Equation ($\sigma_c$)**:
$$\mathbf{\sigma_c = \frac{3 P}{h^2} \left[ 1 - \left( \frac{a \sqrt{2}}{\ell} \right)^{0.6} \right] \quad (a = \text{Radius of Circular Wheel Contact Area})}$$
formulate the **Westergaard Interior Tensile Stress Equation ($\sigma_i$)**:
$$\mathbf{\sigma_i = \frac{3 P (1 + \nu)}{2 \pi h^2} \left[ \ln\left( \frac{\ell}{b} \right) + 0.6159 \right] \quad \left(b = \sqrt{1.6 a^2 + h^2} - 0.675 h \text{ if } a < 1.724 h\right)}$$
(proving that corners experience the most severe flexural tensile stresses because they lack continuous lateral support from adjacent slab edges).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Radius of Relative Stiffness ($\ell = \sqrt[4]{\frac{Eh^3}{12(1-\nu^2)k}}$) & Westergaard Corner Stress ($\sigma_c$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Radius of Relative Stiffness and Corner Bending Stress Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Westergaard Loading Position / Rigid Pavement Parameter & Technical Mechanical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Westergaard Rigid Pavement Mechanics, the Radius of Relative Stiffness $\ell$ Scales with Slab Thickness $h$ to the Power of ___ (0.75 / 3/4 / Three-Fourths) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Concrete Pavement Problem: Calculating Relative Stiffness \ell and Corner Stress \sigma_c for a 250mm Slab Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Westergaard Rigid Pavement Mechanics (Westergaard 1926; Huang 2004):
   - **Relative Stiffness & Stress Formulations:**
     $$\mathbf{\ell = \left[ \frac{E h^3}{12(1-\nu^2)k} \right]^{1/4} \quad \Big| \quad \sigma_c = \frac{3 P}{h^2}\left[ 1 - \left(\frac{a\sqrt{2}}{\ell}\right)^{0.6} \right] \quad \Big| \quad \sigma_{\text{edge}} \approx \frac{0.803 P}{h^2}\left[ 4\log_{10}\left(\frac{\ell}{a}\right) + 0.666 \right]}$$
   - **Westergaard 3-Position Stress Comparison Matrix:**
     $$\begin{array}{|l|l|c|l|}
     \hline
     \textbf{Loading Location} & \textbf{Physical Boundary Condition} & \textbf{Critical Stress Zone} & \textbf{Design Vulnerability} \\
     \hline
     \mathbf{\text{Corner Loading}} & \text{Free discontinuous corner} & \mathbf{\text{Top Surface Tensile}} & \mathbf{\text{Diagonal corner break cracking}} \\
     \mathbf{\text{Edge Loading}} & \text{Free longitudinal slab edge} & \mathbf{\text{Bottom Surface Tensile}} & \mathbf{\text{Mid-panel transverse cracking}} \\
     \mathbf{\text{Interior Loading}} & \text{Infinite 2D plate continuity} & \text{Bottom Surface Tensile} & \text{Lowest tensile stress magnitude} \\
     \hline
     \end{array}$$
   - **The Modulus of Rupture Invariant:** The maximum calculated tensile stress $\sigma$ must strictly remain below the concrete's flexural tensile strength **$f_r = 0.7 \sqrt{f_c'} \ (\approx 4.0 - 5.0\text{ MPa})$** divided by an appropriate fatigue factor!
2. **Slide 2 (`ordering`):** Provide 5 steps of rigid pavement stress analysis: (1) extract concrete slab parameters: thickness $h$, elastic modulus $E$, Poisson's ratio $\nu$, and subgrade reaction $k$, (2) compute the radius of relative stiffness: $\ell = [ E h^3 / (12(1-\nu^2)k) ]^{1/4}$, (3) determine wheel load $P$ and circular tire contact radius $a = \sqrt{P / (\pi p_{\text{tire}})}$, (4) compute the corner stress reduction bracket: $[1 - (a\sqrt{2}/\ell)^{0.6}]$, (5) evaluate Westergaard corner flexural tensile stress: $\sigma_c = \frac{3P}{h^2}[1 - (a\sqrt{2}/\ell)^{0.6}]$ and compare against allowable flexural strength $f_r$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Radius of Relative Stiffness $\ell$, Subgrade Reaction $k$, Corner Loading $\sigma_c$, Modulus of Rupture $f_r$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 0.75 (or 3/4). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating Westergaard corner stress: A concrete pavement slab has thickness $h = 0.25\text{ m} = 250\text{ mm}$, $E = 30,000\text{ MPa} = 30 \times 10^9\text{ Pa}$, $\nu = 0.15$ ($\nu^2 = 0.0225 \implies 1 - \nu^2 = 0.9775$), and subgrade reaction modulus $k = 50.0\text{ MPa/m} = 50 \times 10^6\text{ N/m}^3$. A single wheel load $P = 50.0\text{ kN} = 50,000\text{ N}$ has contact radius $a = 0.15\text{ m}$.
   - Slab flexural rigidity: $D = \frac{E h^3}{12(1 - \nu^2)} = \frac{30 \times 10^9 \times (0.25)^3}{12 \times 0.9775} = \frac{468,750,000}{11.73} = \mathbf{39,961,637\text{ N}\cdot\text{m}}$;
   - Relative stiffness: $\ell = \left(\frac{39,961,637}{50 \times 10^6}\right)^{1/4} = (0.799233)^{1/4} = \mathbf{0.9453\text{ m} \approx 0.945\text{ m}}$;
   - Factor $a\sqrt{2}/\ell = \frac{0.15 \times 1.4142}{0.9453} = \frac{0.21213}{0.9453} = \mathbf{0.2244}$;
   - Bracket: $1 - (0.2244)^{0.6} = 1 - 0.4079 = \mathbf{0.5921}$;
   - Corner tensile stress: $\sigma_c = \frac{3 \times 50,000}{(0.25)^2} \times 0.5921 = \frac{150,000}{0.0625} \times 0.5921 = 2,400,000 \times 0.5921 = \mathbf{1.421 \times 10^6\text{ Pa} = 1.42\text{ MPa}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "rigid_pavement_westergaard_stresses_and_relative_stiffness",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Westergaard Rigid Pavement Mechanics (Harold Westergaard)**\n• **Radius of Relative Stiffness Master Formulation ($\\ell$):**\n$$\n\\mathbf{\\ell = \\sqrt[4]{\\frac{E \\cdot h^3}{12 \\left( 1 - \\nu^2 \\right) k}}}\n$$\n  - **$E$:** Concrete modulus of elasticity ($\\text{Pa}$ or $\\text{psi}$);\n  - **$h$:** Slab thickness ($\\text{m}$ or $\\text{in}$);\n  - **$\\nu$:** Poisson's ratio ($\\approx 0.15$);\n  - **$k$:** Modulus of subgrade reaction ($\\text{N/m}^3$ or $\\text{pci}$);\n• **Westergaard Critical Corner Tensile Stress ($\\sigma_c$):**\n$$\n\\mathbf{\\sigma_c = \\frac{3 P}{h^2} \\left[ 1 - \\left( \\frac{a \\sqrt{2}}{\\ell} \\right)^{0.6} \\right]}\n$$\n  - **$P$:** Applied single wheel load ($\\text{N}$ or $\\text{lb}$);\n  - **$a$:** Equivalent circular tire contact radius ($\\text{m}$ or $\\text{in}$);\n• **The Zone of Influence Invariant:** The radius of relative stiffness $\\ell$ governs the **flexural wave spread across the subgrade**; higher $\\ell$ spreads wheel loads over larger foundation areas, reducing peak subgrade pressures!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the radius of relative stiffness and the critical corner tensile stress for a concrete highway slab.",
      "orderItems": [
        "Extract concrete slab properties (E, h, \u03bd) and subgrade reaction modulus (k)",
        "Calculate the radius of relative stiffness: \u2113 = [ (E * h^3) / (12*(1 - \u03bd^2)*k) ]^(1/4)",
        "Determine the design wheel load P and calculate the equivalent circular tire contact radius: a = \u221a[P / (\u03c0 * ptire)]",
        "Compute the dimensionless corner geometric reduction term: 1 - [ (a * \u221a2) / \u2113 ]^0.6",
        "Multiply by 3*P / h^2 to obtain the Westergaard corner flexural tensile stress \u03c3c and compare against modulus of rupture fr"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Rigid Pavement Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Relative Stiffness (\u2113)", "right": "Characteristic dimension measuring the stiffness ratio of the concrete slab to the elastic subgrade" },
        { "left": "Subgrade Reaction (k)", "right": "Winkler spring constant (pci or MN/m^3) relating subgrade pressure to vertical deflection (p = k*\u03b4)" },
        { "left": "Corner Tensile Stress (\u03c3c)", "right": "Top surface flexural tension occurring at unbonded slab corners creating diagonal break lines" },
        { "left": "Modulus of Rupture (fr)", "right": "Beam flexural tensile cracking strength of concrete (fr \u2248 0.7*\u221afc' \u2248 4.0 to 5.0 MPa)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Westergaard rigid pavement mechanics, the radius of relative stiffness \u2113 scales with slab thickness h to the power of ___.",
      "blankAnswer": "0.75",
      "blankDistractors": ["0.50", "1.00", "2.00"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A concrete slab (h = 0.25 m, E = 30 GPa, \u03bd = 0.15, k = 50 MN/m^3) has radius of relative stiffness \u2113 = 0.945 m. A wheel load P = 50.0 kN with contact radius a = 0.15 m acts at the corner. [1 - (a\u221a2/\u2113)^0.6] = 1 - (0.2244)^0.6 = 0.5921. What is the Westergaard corner flexural tensile stress \u03c3c?",
      "options": [
        { "text": "\u03c3c = 1.42 MPa (\u03c3c = [3 * 50,000 / (0.25^2)] * 0.5921 = (150,000 / 0.0625) * 0.5921 = 2,400,000 * 0.5921 = 1,421,040 Pa = 1.42 MPa)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Westergaard's rigid pavement corner stress formula (Yang H. Huang *Pavement Analysis and Design* Chapter 4). 1. **Identify Given Mechanical Inputs:** - Slab thickness: $h = 0.25\\text{ m}$. - Concrete modulus: $E = 30.0 \\times 10^9\\text{ Pa}$. - Poisson's ratio: $\\nu = 0.15 \\implies 1 - \\nu^2 = 1 - 0.0225 = 0.9775$. - Subgrade modulus: $k = 50.0 \\times 10^6\\text{ N/m}^3$. - Applied wheel load: $P = 50.0\\text{ kN} = 50,000\\text{ N}$. - Tire contact radius: $a = 0.15\\text{ m}$. 2. **Verify Radius of Relative Stiffness ($\\ell$):** $$\\ell = \\left[ \\frac{E \\cdot h^3}{12(1 - \\nu^2) \\cdot k} \\right]^{1/4} = \\left[ \\frac{30 \\times 10^9 \\times (0.25)^3}{12 \\times 0.9775 \\times 50 \\times 10^6} \\right]^{1/4} = [0.799233]^{1/4} = \\mathbf{0.9453\\text{ m}}$$ 3. **Calculate Dimensionless Corner Stress Factor:** - Contact ratio: $$\\frac{a \\sqrt{2}}{\\ell} = \\frac{0.15\\text{ m} \\times 1.41421}{0.9453\\text{ m}} = \\frac{0.21213}{0.9453} = \\mathbf{0.22441}$$ - Stress reduction bracket: $$1 - \\left( \\frac{a \\sqrt{2}}{\\ell} \\right)^{0.6} = 1 - (0.22441)^{0.6} = 1 - 0.40790 = \\mathbf{0.59210}$$ 4. **Calculate Westergaard Corner Flexural Tensile Stress ($\\sigma_c$):** $$\\sigma_c = \\frac{3 P}{h^2} \\left[ 1 - \\left( \\frac{a \\sqrt{2}}{\\ell} \\right)^{0.6} \\right] = \\frac{3 \\times 50,000\\text{ N}}{(0.25\\text{ m})^2} \\times 0.59210$$ $$\\sigma_c = \\frac{150,000}{0.0625} \\times 0.59210 = 2,400,000\\text{ Pa} \\times 0.59210 = \\mathbf{1,421,040\\text{ Pa} = 1.421\\text{ MPa} \\approx 1.42\\text{ MPa}}$$ Flawless Westergaard rigid pavement slab stress derivation!" },
        { "text": "\u03c3c = 2.40 MPa (Omitted the corner reduction factor)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c3c = 0.71 MPa", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c3c = 3.55 MPa", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
