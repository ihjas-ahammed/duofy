# Duofy Reusable Lesson Format: Sand Filtration (Filter Hydraulics & Backwash Expansion)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Environmental_and_Wastewater_Engineering / Water_Purification_and_Treatment`  
**Lesson Format Type:** `rapid_sand_filtration_hydraulics_and_backwash_expansion`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through granular porous media filtration in drinking water treatment, deep-bed granular media mechanisms (sand, anthracite, garnet), hydraulic loading rate ($v_f = Q / A_{\text{filter}} \approx 5 - 15\text{ m/h}$), clean bed head loss modeling via the **Ergun / Carmen-Kozeny Equations**, filter media grain size distribution (Effective Size $E_{10} = d_{10} \approx 0.45-0.55\text{ mm}$, Uniformity Coefficient $\text{UC} = d_{60}/d_{10} \le 1.65$), head loss progression and breakthrough turbidities, minimum fluidization velocity ($v_{\text{mf}}$), and **Backwash Sand Bed Expansion Mechanics ($L_e$)** (Mackenzie L. Davis *Water and Wastewater Engineering* 2nd ed. Chapter 8; John C. Crittenden *MWH's Water Treatment* Chapter 10): formulate the **Filter Hydraulic Loading Rate Equation**:
$$\mathbf{v_f = \frac{Q}{A_{\text{filter}}} \quad [\text{m/h} \text{ or } \text{gpm/ft}^2] \quad \left(A_{\text{filter}} = \frac{Q}{v_f}\right)}$$
formulate the **Carmen-Kozeny Clean Bed Head Loss Formulation ($h_L$)**:
$$\mathbf{h_L = f \left( \frac{L_0}{\psi \cdot d_{\text{eq}}} \right) \left( \frac{v_f^2}{g} \right) \left( \frac{1 - \epsilon_0}{\epsilon_0^3} \right) \quad (\psi = \text{Sphericity}, \ \epsilon_0 = \text{Clean Bed Porosity} \approx 0.40)}$$
derive the **Fluidized Backwash Expanded Bed Depth ($L_e$) Equation**:
- Solid volume of sand grains is constant before and during backwash: $V_{\text{solids}} = A \cdot L_0 (1 - \epsilon_0) = A \cdot L_e (1 - \epsilon_e)$;
$$\mathbf{L_e = L_0 \left( \frac{1 - \epsilon_0}{1 - \epsilon_e} \right) \Longleftrightarrow \mathbf{\% \text{ Expansion} = \left( \frac{L_e - L_0}{L_0} \right) \times 100\% = \left( \frac{\epsilon_e - \epsilon_0}{1 - \epsilon_e} \right) \times 100\%}}$$
where:
1. **$L_0$:** Unexpanded resting filter bed depth ($\approx 0.60 - 0.75\text{ m}$);
2. **$\epsilon_0$:** Clean fixed-bed porosity ($\approx 0.40 - 0.45$);
3. **$\epsilon_e$:** Fluidized expanded bed porosity ($\approx 0.50 - 0.55$ target for $20-30\%$ expansion);
(proving how upward hydrodynamic drag fluidizes sand particles, detaching accumulated floc coatings without washing media into washwater troughs).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Filtration Loading ($v_f = Q/A$), Carmen-Kozeny $h_L$ & Backwash Expansion ($L_e = L_0 \frac{1-\epsilon_0}{1-\epsilon_e}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Size Filter Surface Area and Calculate Expanded Bed Depth During Backwash Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Granular Filtration Entity / Backwash Parameter & Technical Environmental Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Rapid Sand Filter Backwash Design, the Solid Volume Conservation Law Enforces That the Expanded Bed Depth $L_e$ Equals $L_0(1 - \epsilon_0)$ Divided by $(1 - \text{___})$ (epsilon_e / Expanded Porosity) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Water Filtration Problem: Sizing Number of Filter Cells and Calculating Backwash Depth L_e for 25% Expansion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Granular Filtration & Backwash Expansion (Davis 2020; Crittenden 2012):
   - **Filtration & Backwash Formulations:**
     $$\mathbf{v_f = \frac{Q}{A} \quad \Big| \quad h_L = f \left(\frac{L_0}{\psi d}\right)\left(\frac{v_f^2}{g}\right)\left(\frac{1-\epsilon_0}{\epsilon_0^3}\right) \quad \Big| \quad L_e = L_0 \left(\frac{1 - \epsilon_0}{1 - \epsilon_e}\right) \quad \Big| \quad \text{UC} = \frac{d_{60}}{d_{10}}}$$
   - **Filter Media Types Comparison Matrix:**
     $$\begin{array}{|l|c|c|c|l|}
     \hline
     \textbf{Filter Media Layer} & \textbf{Effective Size } d_{10} & \textbf{Specific Gravity } SG & \textbf{Porosity } \epsilon_0 & \textbf{Filtration Role} \\
     \hline
     \mathbf{\text{Anthracite Coal}} & \mathbf{0.90 - 1.10\text{ mm}} & \mathbf{1.50 - 1.60} & 0.50 & \text{Top coarse layer for deep floc penetration} \\
     \mathbf{\text{Silica Filter Sand}} & \mathbf{0.45 - 0.55\text{ mm}} & \mathbf{2.65} & \mathbf{0.42} & \mathbf{\text{Middle polishing layer for turbidity removal}} \\
     \mathbf{\text{Garnet Sand}} & 0.20 - 0.35\text{ mm} & 4.00 - 4.20 & 0.40 & \text{Bottom fine heavy layer preventing breakthrough} \\
     \hline
     \end{array}$$
   - **The Solid Volume Invariant:** During backwash fluidization, the sand mass is completely conserved ($V_{\text{solid}} = \text{constant}$), meaning **$L_0 (1 - \epsilon_0) = L_e (1 - \epsilon_e)$** strictly dictates the upward bed expansion!
2. **Slide 2 (`ordering`):** Provide 5 steps of filter design: (1) determine plant flow $Q$ and select design filtration rate $v_f \approx 10\text{ m/h}$ ($4\text{ gpm/ft}^2$), (2) calculate total filter area $A_{\text{total}} = Q / v_f$ and divide into $N \ge 4$ independent modular cells, (3) select media depth $L_0$ and initial porosity $\epsilon_0 \approx 0.40$, (4) determine backwash fluidization velocity $v_{\text{bw}}$ to achieve target expanded porosity $\epsilon_e \approx 0.52$, (5) compute expanded bed depth: $L_e = L_0 \frac{1-\epsilon_0}{1-\epsilon_e}$ and set washwater trough lip elevation $> L_e + 0.30\text{ m}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Hydraulic Loading Rate $v_f$, Effective Size $d_{10}$, Uniformity Coefficient $\text{UC}$, Expanded Bed Depth $L_e$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of epsilon_e (or Expanded Porosity). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating backwash expansion: A rapid sand filter has a resting unexpanded bed depth $L_0 = 0.60\text{ m} = 600\text{ mm}$ and a static clean bed porosity $\epsilon_0 = 0.40$. During backwash washing, upward water velocity fluidizes the sand bed to an expanded porosity $\epsilon_e = 0.52$.
   - Solid fraction in static bed: $1 - \epsilon_0 = 1 - 0.40 = \mathbf{0.60}$;
   - Solid fraction in expanded bed: $1 - \epsilon_e = 1 - 0.52 = \mathbf{0.48}$;
   - Expanded bed depth: $L_e = L_0 \left(\frac{1 - \epsilon_0}{1 - \epsilon_e}\right) = 0.60\text{ m} \times \left(\frac{0.60}{0.48}\right) = 0.60 \times 1.25 = \mathbf{0.750\text{ m} = 750\text{ mm}}$;
   - Percentage bed expansion: $\% \text{ Expansion} = \frac{0.750 - 0.600}{0.600} \times 100\% = \frac{0.150}{0.600} \times 100\% = \mathbf{25.0\%}$;
   - What is the expanded bed depth $L_e$ and the percent bed expansion? ($L_e = \mathbf{0.75\text{ m}}$ and $\% \text{ Expansion} = \mathbf{25.0\%}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "rapid_sand_filtration_hydraulics_and_backwash_expansion",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Granular Sand Filtration \\& Backwash Expansion (Davis \\& MWH)**\n• **Filter Hydraulic Loading Rate Formulation ($v_f$):**\n$$\n\\mathbf{v_f = \\frac{Q}{A_{\\text{filter}}} \\quad [\\text{m/h}] \\quad \\left(A_{\\text{filter}} = \\frac{Q}{v_f}\\right)}\n$$\n  - **Typical Range:** $v_f \\approx 5 - 15\\text{ m/h} \\ (2 - 6\\text{ gpm/ft}^2)$;\n• **Carmen-Kozeny Clean Bed Head Loss ($h_L$):**\n$$\n\\mathbf{h_L = f \\left( \\frac{L_0}{\\psi \\cdot d_{\\text{eq}}} \\right) \\left( \\frac{v_f^2}{g} \\right) \\left( \\frac{1 - \\epsilon_0}{\\epsilon_0^3} \\right)}\n$$\n• **Fluidized Bed Backwash Expansion Formulation ($L_e$):**\n$$\n\\mathbf{L_e = L_0 \\left( \\frac{1 - \\epsilon_0}{1 - \\epsilon_e} \\right) \\Longleftrightarrow \\mathbf{\\% \\text{ Expansion} = \\left( \\frac{L_e - L_0}{L_0} \\right) \\times 100\\%}}\n$$\n  - **$L_0$:** Clean resting static bed depth ($\\text{m}$);\n  - **$\\epsilon_0$:** Static clean bed porosity ($\\approx 0.40$);\n  - **$\\epsilon_e$:** Fluidized expanded bed porosity ($\\approx 0.50 - 0.55$);\n• **The Solid Volume Invariant:** During backwashing, sand grains do not escape; the **net solid sand volume is strictly conserved: $L_0(1 - \\epsilon_0) = L_e(1 - \\epsilon_e)$**, directly governing the minimum clearance height for washwater collection troughs!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to size a multi-cell rapid sand filter plant and verify backwash trough elevation.",
      "orderItems": [
        "Determine maximum daily water demand Q and select design filtration hydraulic loading rate vf (typically 10 m/h)",
        "Calculate total required filter surface area: A_total = Q / vf and split into N \u2265 4 parallel filter cells",
        "Select filter media depth L0 (e.g. 0.60 m sand) and identify clean static bed porosity \u03b50 (\u2248 0.40)",
        "Determine backwash fluidization velocity to reach target expanded bed porosity \u03b5e (\u2248 0.52)",
        "Calculate the expanded bed depth: Le = L0 * (1 - \u03b50) / (1 - \u03b5e) and position wash troughs at least 0.30 m above Le"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Filtration Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Filtration Rate (vf = Q/A)", "right": "Superficial downward approach velocity of water passing through granular media beds" },
        { "left": "Effective Size (d10)", "right": "Sieve opening size passing exactly 10% by weight of filter media grains" },
        { "left": "Uniformity Coefficient (d60/d10)", "right": "Gradation ratio measuring size consistency of filter sand (specified UC \u2264 1.65)" },
        { "left": "Backwash Expansion (Le)", "right": "Le = L0*(1-\u03b50)/(1-\u03b5e), fluidized bed depth reached during reverse upward washing" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In rapid sand filter backwash design, the solid volume conservation law enforces that the expanded bed depth Le equals L0*(1 - \u03b50) divided by (1 - ___).",
      "blankAnswer": "epsilon_e",
      "blankDistractors": ["epsilon_0", "d10", "vf"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A rapid sand filter bed has resting depth L0 = 0.60 m and clean static porosity \u03b50 = 0.40. During backwash fluidization, the sand expands to porosity \u03b5e = 0.52. (1 - \u03b50) = 0.60 and (1 - \u03b5e) = 0.48. What is the expanded bed depth Le and the percent bed expansion?",
      "options": [
        { "text": "Le = 0.75 m and 25.0% Expansion (Le = 0.60 * (0.60 / 0.48) = 0.60 * 1.25 = 0.750 m; % Expansion = (0.75 - 0.60)/0.60 * 100% = 0.15/0.60 * 100% = 25.0%)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using granular porous media backwash expansion mechanics (Mackenzie L. Davis *Water and Wastewater Engineering* Chapter 8). 1. **Apply Solid Grain Volume Conservation:** - Before backwash (static fixed bed): $$V_{\\text{solids}} = A_{\\text{filter}} \\cdot L_0 \\cdot (1 - \\epsilon_0)$$ - During backwash (fluidized expanded bed): $$V_{\\text{solids}} = A_{\\text{filter}} \\cdot L_e \\cdot (1 - \\epsilon_e)$$ - Equating both solid volumes: $$L_0 \\cdot (1 - \\epsilon_0) = L_e \\cdot (1 - \\epsilon_e)$$ 2. **Calculate Fluidized Expanded Bed Depth ($L_e$):** - Static depth: $L_0 = 0.60\\text{ m}$. - Solid fraction before backwash: $1 - \\epsilon_0 = 1 - 0.40 = \\mathbf{0.60}$. - Solid fraction during backwash: $1 - \\epsilon_e = 1 - 0.52 = \\mathbf{0.48}$. $$L_e = L_0 \\left( \\frac{1 - \\epsilon_0}{1 - \\epsilon_e} \\right) = 0.60\\text{ m} \\times \\left( \\frac{0.60}{0.48} \\right) = 0.60\\text{ m} \\times 1.25 = \\mathbf{0.750\\text{ m} = 750\\text{ mm}}$$ 3. **Calculate Percentage Bed Expansion:** $$\\text{\\% Expansion} = \\left( \\frac{L_e - L_0}{L_0} \\right) \\times 100\\% = \\left( \\frac{0.750\\text{ m} - 0.600\\text{ m}}{0.600\\text{ m}} \\right) \\times 100\\%$$ $$\\text{\\% Expansion} = \\frac{0.150\\text{ m}}{0.600\\text{ m}} \\times 100\\% = \\mathbf{25.0\\%}$$ 4. **Trough Placement Check:** Washwater collection troughs must be installed with bottoms at least $0.75 + 0.30 = 1.05\\text{ m}$ above the underdrain gravel to prevent sand loss! Flawless rapid sand filter backwash expansion derivation!" },
        { "text": "Le = 0.78 m and 30.0% Expansion", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Le = 0.48 m and 20.0% Expansion", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Le = 0.75 m and 12.5% Expansion", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
