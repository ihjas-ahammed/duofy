# Duofy Reusable Lesson Format: Polymer Physics (Glass Transition Tg & Percent Crystallinity)

**Target Topic:** `04_Engineering_and_Technology / 07_Materials_Science_and_Engineering / Ceramics_Polymers_and_Composites / Structure_and_Properties_of_Polymers`  
**Lesson Format Type:** `glass_transition_temperature_and_crystallinity_mechanics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the thermodynamic and structural transitions of semi-crystalline and amorphous solid polymers, the **Glass Transition Temperature ($T_g$)** marking the onset of cooperative long-range segmental backbone motion in amorphous domains, the **Melting Temperature ($T_m$)** marking the first-order thermodynamic dissolution of crystalline lamellae / spherulites, the Fox-Flory molecular weight effect on $T_g$ ($T_g = T_{g,\infty} - K / \bar{M}_n$), the factors that elevate $T_g$ (bulky pendant groups, crosslinking, chain stiffness), and the calculation of **Percent Crystallinity ($\%X_c$)** from density measurements (William D. Callister Jr., David G. Rethwisch *Materials Science and Engineering: An Introduction* 10th ed. Chapters 14 & 15; L. H. Sperling *Introduction to Physical Polymer Science* 4th ed.): formulate the **Polymer Percent Crystallinity Master Formulation**:
$$\mathbf{\%X_c = \left[ \frac{\rho_c \left( \rho_{\text{sample}} - \rho_a \right)}{\rho_{\text{sample}} \left( \rho_c - \rho_a \right)} \right] \times 100\%}$$
where:
1. **$\rho_{\text{sample}}$:** Measured macroscopic specimen density ($\text{g/cm}^3$);
2. **$\rho_c$:** Theoretical density of 100% perfectly crystalline polymer ($\text{g/cm}^3$);
3. **$\rho_a$:** Measured density of 100% purely amorphous polymer ($\text{g/cm}^3$);
master the **Polymer $T_g$ and $T_m$ Physical Property Matrix**:
$$\begin{array}{|l|c|c|c|l|}
\hline
\textbf{Thermoplastic Polymer} & \textbf{Glass Transition } T_g & \textbf{Melting Temp } T_m & \textbf{Percent Crystallinity } \%X_c & \textbf{Primary Physical State at } 25^\circ\text{C} \\
\hline
\mathbf{\text{Polydimethylsiloxane (Silicone)}} & \mathbf{-125^\circ\text{C}} & -40^\circ\text{C} & \approx 0\% & \mathbf{\text{Flexible elastomer / rubbery fluid}} \\
\mathbf{\text{Low-Density Polyethylene (LDPE)}} & \mathbf{-120^\circ\text{C}} & \mathbf{115^\circ\text{C}} & \mathbf{\approx 50 - 60\%} & \mathbf{\text{Flexible, ductile semi-crystalline plastic}} \\
\text{High-Density Polyethylene (HDPE)} & -120^\circ\text{C} & 135^\circ\text{C} & \approx 70 - 85\% & Stiff, opaque semi-crystalline plastic \\
\mathbf{\text{Polyvinyl Chloride (PVC)}} & \mathbf{+87^\circ\text{C}} & 212^\circ\text{C} & \approx 0 - 10\% & \mathbf{\text{Rigid glassy plastic (Pipes, credit cards)}} \\
\mathbf{\text{Polystyrene (PS)}} & \mathbf{+100^\circ\text{C}} & \text{None (Atactic)} & \mathbf{0\%\text{ (Purely Amorphous)}} & \mathbf{\text{Clear, brittle glassy plastic (Cups, petri dishes)}} \\
\text{Polycarbonate (PC)} & +145^\circ\text{C} & 230^\circ\text{C} & \approx 0\% & Tough, transparent impact-resistant glass \\
\hline
\end{array}$$
(proving that polymers used below their $T_g$ are hard, brittle glasses, while polymers used between $T_g$ and $T_m$ operate in their flexible, ductile semi-crystalline or rubbery state).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Glass Transition ($T_g$), Melting ($T_m$) & Density-Based Percent Crystallinity ($\%X_c = \frac{\rho_c(\rho_s - \rho_a)}{\rho_s(\rho_c - \rho_a)}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate the Percent Crystallinity of a Semi-Crystalline Polyethylene Specimen Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Polymer Physical Transition / Structural Entity & Technical Materials Science Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Temperature Range Where an Amorphous Polymer Transitions from a Rigid Brittle Glassy State to a Compliant Leathery/Rubbery State Is Defined as the Glass ___ Temperature (Transition / Tg) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Polymer Thermodynamics Problem: Computing Percent Crystallinity for High-Density Polyethylene (HDPE) Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Polymer Physics & Thermal Transitions (Callister 2020; Sperling 2006):
   - **Thermodynamic Formulations:**
     $$\mathbf{\%X_c = \left[ \frac{\rho_c (\rho_s - \rho_a)}{\rho_s (\rho_c - \rho_a)} \right] \times 100\% \quad \Big| \quad T_g = T_{g,\infty} - \frac{K}{\bar{M}_n} \quad \Big| \quad T_g \approx 0.5 - 0.75 \cdot T_m \ [\text{Kelvin}]}$$
   - **Chain Architecture & $T_g$ Determinants:**
     - **Bulky Side Groups (e.g. Phenyl in Polystyrene):** Steric hindrance restricts chain rotation $\implies T_g \uparrow (+100^\circ\text{C})$;
     - **Flexible Backbone (e.g. Si-O in PDMS):** Ultra-low rotational barrier $\implies T_g \downarrow (-125^\circ\text{C})$;
     - **Crosslinking:** Covalent network locks chains $\implies T_g \uparrow$;
     - **Plasticizers:** Small solvent molecules increase free volume $\implies T_g \downarrow$ (flexible PVC).
2. **Slide 2 (`ordering`):** Provide 5 steps of percent crystallinity calculation: (1) measure sample macroscopic density $\rho_s$ via pycnometry, (2) extract standard reference densities for purely amorphous state $\rho_a$ and 100% crystalline unit cell $\rho_c$, (3) compute density differences: $(\rho_s - \rho_a)$ and $(\rho_c - \rho_a)$, (4) evaluate the volumetric-to-mass weighted formula: $\%X_c = \frac{\rho_c (\rho_s - \rho_a)}{\rho_s (\rho_c - \rho_a)} \times 100\%$, (5) verify $0\% \le \%X_c \le 100\%$ and correlate with polymer mechanical stiffness and opacity!
3. **Slide 3 (`matching`):** Pair 4 concepts (Glass Transition $T_g$, Melting Temperature $T_m$, Spherulite Morphology, Plasticizer Addition) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Transition (or Tg). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating percent crystallinity for HDPE: A high-density polyethylene (HDPE) component has measured density $\rho_{\text{sample}} = 0.965\text{ g/cm}^3$. The density of totally amorphous polyethylene is $\rho_a = 0.855\text{ g/cm}^3$, and the theoretical density of 100% crystalline orthorhombic polyethylene is $\rho_c = 1.000\text{ g/cm}^3$.
   - Density differences:
     $\rho_{\text{sample}} - \rho_a = 0.965 - 0.855 = \mathbf{0.110\text{ g/cm}^3}$;
     $\rho_c - \rho_a = 1.000 - 0.855 = \mathbf{0.145\text{ g/cm}^3}$;
   - Percent crystallinity:
     $\%X_c = \left[ \frac{\rho_c (\rho_{\text{sample}} - \rho_a)}{\rho_{\text{sample}} (\rho_c - \rho_a)} \right] \times 100\% = \left[ \frac{1.000 \times 0.110}{0.965 \times 0.145} \right] \times 100\% = \left[ \frac{0.110}{0.139925} \right] \times 100\% = \mathbf{0.78613 \times 100\% = 78.61\% \approx 78.6\%}$;
   - What is the percent crystallinity $\%X_c$ of the HDPE sample? ($\%X_c = \mathbf{78.6\%}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "glass_transition_temperature_and_crystallinity_mechanics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Polymer Physics \\& Percent Crystallinity (L. H. Sperling)**\n• **Percent Crystallinity Master Formulation (Density-Based):**\n$$\n\\mathbf{\\%X_c = \\left[ \\frac{\\rho_c \\left( \\rho_{\\text{sample}} - \\rho_a \\right)}{\\rho_{\\text{sample}} \\left( \\rho_c - \\rho_a \\right)} \\right] \\times 100\\%}\n$$\n  - **$\\rho_{\\text{sample}}$:** Measured macroscopic specimen density ($\\text{g/cm}^3$);\n  - **$\\rho_c$:** Density of 100\\% perfectly crystalline polymer ($\\text{g/cm}^3$);\n  - **$\\rho_a$:** Density of 100\\% purely amorphous polymer ($\\text{g/cm}^3$);\n• **Thermal Transitions Dual Spectrum:**\n  - **Glass Transition ($T_g$):** Second-order transition where amorphous chains gain kinetic free volume for coordinated crankshaft rotation (Polystyrene $T_g = +100^\\circ\\text{C}$, PE $T_g = -120^\\circ\\text{C}$);\n  - **Melting Temperature ($T_m$):** First-order thermodynamic latent heat melting of crystalline lamellar spherulites (HDPE $T_m = 135^\\circ\\text{C}$);\n• **The Structural State Invariant:** At room temperature ($25^\\circ\\text{C}$), polymers with $T_g > 25^\\circ\\text{C}$ operate as **rigid, brittle glasses**, whereas polymers with $T_g < 25^\\circ\\text{C}$ and $T_m > 25^\\circ\\text{C}$ operate as **flexible, tough semi-crystalline thermoplastics**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the percent crystallinity of a semi-crystalline polymer from experimental pycnometry density data.",
      "orderItems": [
        "Measure the experimental bulk density of the polymer sample: \u03c1_sample using immersion pycnometry",
        "Obtain crystallographic reference values for the 100% crystalline unit cell (\u03c1c) and quenched 100% amorphous matrix (\u03c1a)",
        "Calculate the excess density above the amorphous baseline: \u0394\u03c11 = \u03c1_sample - \u03c1a",
        "Calculate the maximum possible density difference: \u0394\u03c12 = \u03c1c - \u03c1a",
        "Apply the mass-weighted crystallinity formula: %Xc = [ \u03c1c * (\u03c1_sample - \u03c1a) ] / [ \u03c1_sample * (\u03c1c - \u03c1a) ] * 100%"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Polymer Physics Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Glass Transition (Tg)", "right": "Second-order kinetic transition where amorphous segments unlock cooperative backbone rotational mobility" },
        { "left": "Melting Point (Tm)", "right": "First-order thermodynamic phase transformation where ordered crystalline lamellae dissolve into disordered melt" },
        { "left": "Plasticizer Addition", "right": "Low-molecular-weight additives increasing free volume between chains to dramatically reduce Tg and enhance flexibility" },
        { "left": "Percent Crystallinity (%Xc)", "right": "Fraction of polymer volume organized into tightly packed crystalline lamellae governing stiffness and opacity" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The temperature range where an amorphous polymer transitions from a rigid brittle glassy state to a compliant leathery/rubbery state is defined as the glass ___ temperature.",
      "blankAnswer": "transition",
      "blankDistractors": ["melting", "degradation", "crystallization"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An HDPE specimen has measured density \u03c1_sample = 0.965 g/cm^3. Pure amorphous density is \u03c1a = 0.855 g/cm^3 and 100% crystalline density is \u03c1c = 1.000 g/cm^3. \u03c1_sample - \u03c1a = 0.110 g/cm^3 and \u03c1c - \u03c1a = 0.145 g/cm^3. %Xc = [1.000 * 0.110] / [0.965 * 0.145] * 100% = 0.110 / 0.139925 * 100% = 78.61%. What is the percent crystallinity %Xc?",
      "options": [
        { "text": "%Xc = 78.6% (%Xc = [ 1.000 * 0.110 ] / [ 0.965 * 0.145 ] * 100% = 0.78613 * 100% = 78.61% \u2248 78.6%)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the density-based percent crystallinity formulation (William D. Callister Jr. *Materials Science and Engineering: An Introduction* Chapter 14; L. H. Sperling *Introduction to Physical Polymer Science* Chapter 6). 1. **Identify Density Parameters:** - Measured specimen density: $\\rho_{\\text{sample}} = 0.965\\text{ g/cm}^3$. - Purely amorphous density: $\\rho_a = 0.855\\text{ g/cm}^3$. - 100% perfectly crystalline unit cell density: $\\rho_c = 1.000\\text{ g/cm}^3$. 2. **Calculate Density Differences:** - Numerator factor: $$\\rho_{\\text{sample}} - \\rho_a = 0.965\\text{ g/cm}^3 - 0.855\\text{ g/cm}^3 = \\mathbf{0.110\\text{ g/cm}^3}$$ - Denominator factor: $$\\rho_c - \\rho_a = 1.000\\text{ g/cm}^3 - 0.855\\text{ g/cm}^3 = \\mathbf{0.145\\text{ g/cm}^3}$$ 3. **Evaluate Mass-Weighted Percent Crystallinity ($\\sum \\%X_c$):** $$\\%X_c = \\left[ \\frac{\\rho_c (\\rho_{\\text{sample}} - \\rho_a)}{\\rho_{\\text{sample}} (\\rho_c - \\rho_a)} \\right] \\times 100\\%$$ $$\\%X_c = \\left[ \\frac{1.000\\text{ g/cm}^3 \\times 0.110\\text{ g/cm}^3}{0.965\\text{ g/cm}^3 \\times 0.145\\text{ g/cm}^3} \\right] \\times 100\\%$$ $$\\%X_c = \\left[ \\frac{0.11000}{0.139925} \\right] \\times 100\\% = 0.786135 \\times 100\\% = \\mathbf{78.61\\% \\approx 78.6\\%}$$ Flawless polymer percent crystallinity derivation!" },
        { "text": "%Xc = 75.9% (Simple volumetric linear ratio without \u03c1c/\u03c1_sample weighting: 0.110/0.145 = 75.86%)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "%Xc = 21.4% (Calculated amorphous fraction instead of crystalline fraction)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "%Xc = 96.5%", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
