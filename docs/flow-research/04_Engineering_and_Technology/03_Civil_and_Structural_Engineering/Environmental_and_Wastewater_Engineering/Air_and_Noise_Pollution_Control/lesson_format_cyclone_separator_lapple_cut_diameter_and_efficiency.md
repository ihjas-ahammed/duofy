# Duofy Reusable Lesson Format: Cyclone Separators (Lapple Cut Diameter & Particle Removal)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Environmental_and_Wastewater_Engineering / Air_and_Noise_Pollution_Control`  
**Lesson Format Type:** `cyclone_separator_lapple_cut_diameter_and_efficiency`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through industrial particulate control using reverse-flow **Cyclone Separators**, centrifugal particle separation mechanics ($F_c = \frac{m v^2}{r}$), standard 2D2D and 1D3D cyclone geometry proportions, the number of effective outer spiral gas turns ($N_e \approx 5$), C. E. Lapple's **50% Cut Diameter ($d_{pc}$ or $d_{p50}$)** formula, particle grade collection efficiency curves ($\eta_j$), and overall particulate mass collection efficiency ($\eta_{\text{overall}} = \sum m_j \eta_j$) (C. David Cooper, F. C. Alley *Air Pollution Control: A Design Approach* Chapter 5; Mackenzie L. Davis *Introduction to Environmental Engineering* Chapter 10; C. E. Lapple 1951): formulate the **Lapple 50% Cut Diameter ($d_{pc}$) Master Equation**:
$$\mathbf{d_{pc} = \sqrt{\frac{9 \mu W}{2 \pi N_e v_i \left( \rho_p - \rho_g \right)}} \quad [\text{m}]}$$
where:
1. **$\mu$:** Flue gas dynamic viscosity ($\text{Pa}\cdot\text{s}$ or $\text{kg/m}\cdot\text{s}$);
2. **$W$:** Rectangular inlet duct width ($W = D / 4$ for standard 2D2D cyclone of body diameter $D$);
3. **$N_e$:** Effective number of spiral vortex revolutions in the outer cylinder and cone ($\mathbf{N_e \approx \frac{1}{H} \left( L_b + \frac{L_c}{2} \right) \approx 5.0}$);
4. **$v_i$:** Tangential gas inlet velocity ($\mathbf{v_i = \frac{Q}{W \cdot H_{\text{inlet}}}} \approx 15 - 20\text{ m/s}$);
5. **$\rho_p, \rho_g$:** Particle and gas densities ($\rho_p \gg \rho_g \implies \rho_p - \rho_g \approx \rho_p$);
derive the **Lapple Fractional Grade Collection Efficiency ($\eta_j$)**:
$$\mathbf{\eta_j = \frac{1}{1 + \left( \frac{d_{pc}}{d_j} \right)^2} \Longleftrightarrow \mathbf{\eta_j = \frac{d_j^2}{d_{pc}^2 + d_j^2}}}$$
- If particle size $d_j = d_{pc} \implies \eta_j = \frac{1}{1 + 1} = \mathbf{50.0\%}$;
- If particle size $d_j = 2 d_{pc} \implies \eta_j = \frac{1}{1 + (1/2)^2} = \frac{1}{1.25} = \mathbf{80.0\%}$;
- If particle size $d_j = 3 d_{pc} \implies \eta_j = \frac{1}{1 + (1/3)^2} = \frac{1}{1.111} = \mathbf{90.0\%}$;
(proving that cyclones effectively capture coarse dusts $>10\text{ }\mu\text{m}$ at low operating cost but require downstream baghouses or ESPs for sub-micron particulate control).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Lapple Cut Diameter ($d_{pc} = \sqrt{\frac{9\mu W}{2\pi N_e v_i \rho_p}}$), Grade Efficiency ($\eta_j = \frac{1}{1+(d_{pc}/d_j)^2}$) & Vortex Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Size a 2D2D Cyclone Separator and Calculate Collection Efficiency for Target Dust Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Cyclone Design Parameter / Vortex Characteristic & Technical Mechanical Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Lapple's Cyclone Model, a Particle Whose Diameter $d_j$ Is Exactly Equal to Twice the Cut Diameter ($2 d_{pc}$) Has a Collection Efficiency of Exactly ___ Percent (80 / 80% / Eighty) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Industrial Pollution Problem: Computing Lapple Cut Diameter d_pc and Efficiency for 15 \mu m Fly Ash Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Lapple Cyclone Separator Mechanics (Lapple 1951; Cooper & Alley 2011; Davis 2020):
   - **Cyclone & Efficiency Formulations:**
     $$\mathbf{d_{pc} = \sqrt{\frac{9 \mu W}{2 \pi N_e v_i (\rho_p - \rho_g)}} \quad \Big| \quad \eta_j = \frac{1}{1 + (d_{pc}/d_j)^2} \quad \Big| \quad \eta_{\text{overall}} = \sum m_j \eta_j \quad \Big| \quad \Delta P \propto \rho_g v_i^2}$$
   - **Standard 2D2D Cyclone Geometric Proportions Matrix ($D = \text{Barrel Diameter}$):**
     $$\begin{array}{|l|c|l|}
     \hline
     \textbf{Dimension Entity} & \textbf{2D2D Ratio} & \textbf{Engineering Function} \\
     \hline
     \mathbf{\text{Inlet Height } H} & \mathbf{D / 2 = 0.50 D} & \text{Vertical rectangular tangential gas entrance} \\
     \mathbf{\text{Inlet Width } W} & \mathbf{D / 4 = 0.25 D} & \text{Narrow width minimizing particle radial travel distance} \\
     \text{Gas Exit Duct Diameter } D_e & D / 2 = 0.50 D & \text{Central clean vortex finder exhaust tube} \\
     \text{Barrel Cylinder Length } L_b & 2.0 D & \text{Upper cylindrical outer downward vortex zone} \\
     \text{Cone Length } L_c & 2.0 D & \text{Tapered conical zone forcing inner upward clean vortex} \\
     \mathbf{\text{Effective Spiral Turns } N_e} & \mathbf{\approx 5.0\text{ turns}} & \text{Total spiral revolutions of gas before exiting} \\
     \hline
     \end{array}$$
   - **The Centrifugal Velocity Invariant:** Increasing gas inlet velocity $v_i$ increases centrifugal drag ($F_c \propto v_i^2$), **reducing cut diameter $d_{pc} \propto 1/\sqrt{v_i}$** and boosting collection efficiency at the expense of higher pressure drop $\Delta P$!
2. **Slide 2 (`ordering`):** Provide 5 steps of cyclone design: (1) determine gas volumetric flow rate $Q$, dust particle density $\rho_p$, and gas viscosity $\mu$, (2) select design inlet velocity $v_i \approx 15-20\text{ m/s}$ and calculate inlet area $A_{\text{inlet}} = Q / v_i$, (3) determine cyclone body diameter $D$ using standard 2D2D ratios ($H = 0.5D, W = 0.25D \implies A_{\text{inlet}} = 0.125 D^2$), (4) compute Lapple $50\%$ cut diameter: $d_{pc} = \sqrt{\frac{9 \mu W}{2 \pi N_e v_i \rho_p}}$ (with $N_e \approx 5$), (5) evaluate fractional collection efficiencies $\eta_j = \frac{1}{1 + (d_{pc}/d_j)^2}$ across all dust particle size bins!
3. **Slide 3 (`matching`):** Pair 4 concepts (Lapple Cut Diameter $d_{pc}$, Effective Spiral Turns $N_e \approx 5$, Grade Efficiency $\eta_j$, 2D2D Geometry) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 80 (or 80% / Eighty). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating Lapple cut diameter and grade efficiency: A 2D2D cyclone with inlet width $W = 0.20\text{ m}$ treats flue gas ($\mu = 2.0 \times 10^{-5}\text{ Pa}\cdot\text{s}$) at inlet velocity $v_i = 18.0\text{ m/s}$ with $N_e = 5.0$ effective turns. Fly ash particles have density $\rho_p = 2000.0\text{ kg/m}^3$ (neglecting $\rho_g$).
   - Numerator: $9 \mu W = 9 \times (2.0 \times 10^{-5}) \times 0.20 = \mathbf{3.60 \times 10^{-5}}$;
   - Denominator: $2 \pi N_e v_i \rho_p = 2 \pi \times 5.0 \times 18.0 \times 2000.0 = 2 \pi \times 180,000 = \mathbf{1,130,973.36}$;
   - Ratio: $\frac{3.60 \times 10^{-5}}{1,130,973.36} = 3.1831 \times 10^{-11}\text{ m}^2$;
   - Cut diameter: $d_{pc} = \sqrt{3.1831 \times 10^{-11}} = \mathbf{5.642 \times 10^{-6}\text{ m} = 5.64\text{ }\mu\text{m}}$;
   - What is the cut diameter $d_{pc}$ and the collection efficiency for fly ash particles of size $d_j = 15.0\text{ }\mu\text{m}$?
     - Ratio $d_{pc} / d_j = 5.642 / 15.0 = \mathbf{0.3761} \implies (d_{pc}/d_j)^2 = 0.1415$;
     - Collection efficiency: $\eta = \frac{1}{1 + 0.1415} = \frac{1}{1.1415} = \mathbf{0.8760 = 87.6\%}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cyclone_separator_lapple_cut_diameter_and_efficiency",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Cyclone Separator Mechanics (C. E. Lapple 1951)**\n• **Lapple 50% Cut Particle Diameter Master Formulation ($d_{pc}$):**\n$$\n\\mathbf{d_{pc} = \\sqrt{\\frac{9 \\mu W}{2 \\pi N_e v_i \\left( \\rho_p - \\rho_g \\right)}} \\quad [\\text{m}]}\n$$\n  - **$\\mu$:** Gas dynamic viscosity ($\\text{Pa}\\cdot\\text{s}$);\n  - **$W$:** Rectangular inlet duct width ($W = D/4$ for standard 2D2D cyclone);\n  - **$N_e \\approx 5.0$:** Effective number of spiral gas turns in outer vortex;\n  - **$v_i$:** Tangential inlet gas velocity ($15 - 20\\text{ m/s}$);\n  - **$\\rho_p$:** Dust particle density ($\\approx 1500 - 2500\\text{ kg/m}^3$);\n• **Lapple Fractional Grade Collection Efficiency Formulation ($\\eta_j$):**\n$$\n\\mathbf{\\eta_j = \\frac{1}{1 + \\left( \\frac{d_{pc}}{d_j} \\right)^2} = \\frac{d_j^2}{d_{pc}^2 + d_j^2}}\n$$\n• **The Centrifugal Velocity Invariant:** Higher gas entrance velocity $v_i$ exerts greater centrifugal acceleration ($F_c \\propto v_i^2$), **reducing cut diameter $d_{pc} \\propto 1/\\sqrt{v_i}$** to capture progressively finer sub-10-micron particulates!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design a standard 2D2D cyclone separator and evaluate its overall particulate collection efficiency.",
      "orderItems": [
        "Determine the flue gas volumetric flow rate Q, gas viscosity \u03bc, and dust particle density \u03c1p",
        "Select design inlet velocity vi (\u2248 18 m/s) and calculate inlet dimensions: A_inlet = Q / vi = H * W = 0.125 * D^2",
        "Compute the cyclone barrel diameter D, inlet width W = D/4, and effective spiral turns Ne \u2248 5.0",
        "Calculate the Lapple 50% cut particle diameter: dpc = \u221a[ (9*\u03bc*W) / (2*\u03c0*Ne*vi*\u03c1p) ]",
        "Compute the collection efficiency for each particle size fraction: \u03b7j = 1 / [ 1 + (dpc / dj)^2 ] and integrate total mass removal"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Cyclone Separator Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "50% Cut Diameter (dpc)", "right": "Characteristic particle aerodynamic size collected with exactly 50% mechanical removal efficiency" },
        { "left": "Effective Turns (Ne \u2248 5)", "right": "Number of outer downward helical revolutions executed by the gas stream before entering the inner core" },
        { "left": "Standard 2D2D Proportions", "right": "Geometry where barrel height (2D) and cone height (2D) each equal twice the body diameter D" },
        { "left": "Vortex Finder", "right": "Central tubular exhaust duct extending into the cyclone barrel preventing short-circuiting of uncleaned gas" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Lapple's cyclone model, a particle whose diameter dj is exactly equal to twice the cut diameter (2*dpc) has a collection efficiency of exactly ___ percent.",
      "blankAnswer": "80",
      "blankDistractors": ["50", "90", "100"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 2D2D cyclone with W = 0.20 m treats gas (\u03bc = 2.0 \u00d7 10^-5 Pa*s) at vi = 18.0 m/s with Ne = 5.0 turns. Fly ash has \u03c1p = 2000 kg/m^3. The calculated cut diameter is dpc = 5.64 \u03bcm. What is the fractional collection efficiency \u03b7 for fly ash particles of diameter dj = 15.0 \u03bcm ((dpc / dj)^2 = (5.64 / 15.0)^2 = 0.1415)?",
      "options": [
        { "text": "\u03b7 = 87.6% (\u03b7 = 1 / [1 + (5.642 / 15.0)^2] = 1 / [1 + 0.1415] = 1 / 1.1415 = 0.8760 = 87.6%)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Lapple's cyclone cut diameter and grade collection efficiency formulas (C. David Cooper *Air Pollution Control* Chapter 5). 1. **Verify Lapple 50% Cut Diameter ($d_{pc}$):** - Gas dynamic viscosity: $\\mu = 2.0 \\times 10^{-5}\\text{ Pa}\\cdot\\text{s}$. - Cyclone inlet width: $W = 0.20\\text{ m}$. - Number of effective turns: $N_e = 5.0$. - Gas inlet velocity: $v_i = 18.0\\text{ m/s}$. - Particle density: $\\rho_p = 2000.0\\text{ kg/m}^3$. - Numerator: $$9 \\cdot \\mu \\cdot W = 9 \\times (2.0 \\times 10^{-5}\\text{ Pa}\\cdot\\text{s}) \\times 0.20\\text{ m} = \\mathbf{3.60 \\times 10^{-5}\\text{ kg}\\cdot\\text{m/s}}$$ - Denominator: $$2 \\pi \\cdot N_e \\cdot v_i \\cdot \\rho_p = 2 \\pi \\times 5.0 \\times 18.0\\text{ m/s} \\times 2000.0\\text{ kg/m}^3 = \\mathbf{1,130,973.36\\text{ kg/m}^2\\cdot\\text{s}}$$ - Cut diameter: $$d_{pc} = \\sqrt{\\frac{3.60 \\times 10^{-5}}{1,130,973.36}} = \\sqrt{3.1831 \\times 10^{-11}} = \\mathbf{5.6419 \\times 10^{-6}\\text{ m} = 5.642\\text{ }\\mu\\text{m}}$$ 2. **Calculate Fractional Collection Efficiency ($\\eta_j$) for $d_j = 15.0\\text{ }\\mu\\text{m}$:** - Particle size ratio: $$\\frac{d_{pc}}{d_j} = \\frac{5.6419\\text{ }\\mu\\text{m}}{15.0\\text{ }\\mu\\text{m}} = \\mathbf{0.37613}$$ - Square of ratio: $$\\left( \\frac{d_{pc}}{d_j} \\right)^2 = (0.37613)^2 = \\mathbf{0.14147}$$ - Lapple grade efficiency: $$\\eta_j = \\frac{1}{1 + \\left( \\frac{d_{pc}}{d_j} \\right)^2} = \\frac{1}{1 + 0.14147} = \\frac{1}{1.14147} = \\mathbf{0.87606 = 87.61\\% \\approx 87.6\\%}$$ Flawless cyclone separator Lapple cut diameter and collection efficiency derivation!" },
        { "text": "\u03b7 = 50.0% (This is the efficiency for 5.64 \u03bcm particles)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03b7 = 95.5%", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03b7 = 72.4%", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
