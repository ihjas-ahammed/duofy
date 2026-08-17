# Duofy Reusable Lesson Format: Arrhenius Kinetics (Rate Laws & Activation Energy)

**Target Topic:** `04_Engineering_and_Technology / 04_Chemical_Engineering / Chemical_Reaction_Engineering_CRE / Kinetics_of_Homogeneous_Reactions`  
**Lesson Format Type:** `arrhenius_kinetics_and_rate_law_determination`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through chemical reaction kinetics foundations, reaction rate definition ($-r_A = -\frac{1}{V}\frac{dN_A}{dt} \ [\text{mol/m}^3\cdot\text{s}]$), elementary vs non-elementary reaction mechanisms, empirical power-law rate laws ($-r_A = k C_A^\alpha C_B^\beta$), reaction orders ($\alpha, \beta$ and overall order $n = \alpha + \beta$), rate constant units ($[\text{concentration}]^{1-n} [\text{time}]^{-1}$), Svante Arrhenius temperature dependence ($k(T) = A e^{-E_a/RT}$), **Activation Energy ($E_a$)** determination from two temperatures, Arrhenius plot linearization ($\ln k$ vs $1/T$), and transition state theory (H. Scott Fogler *Elements of Chemical Reaction Engineering* 5th/6th ed. Chapter 3; Octave Levenspiel *Chemical Reaction Engineering* Chapter 2): formulate the **Arrhenius Temperature Dependence Master Formulation**:
$$\mathbf{k(T) = A \cdot \exp\left( -\frac{E_a}{R T} \right) \Longleftrightarrow \mathbf{\ln k = \ln A - \frac{E_a}{R} \left( \frac{1}{T} \right)}}$$
where:
1. **$k(T)$:** Reaction rate constant at absolute temperature $T$ in Kelvin ($\text{K}$);
2. **$A$:** Frequency pre-exponential factor (same units as $k$);
3. **$E_a$:** Activation energy in Joules per mole ($\text{J/mol}$ or $\text{kJ/mol}$);
4. **$R$:** Universal gas constant ($8.314\text{ J/mol}\cdot\text{K}$);
5. **$T$:** Absolute thermodynamic temperature in Kelvin ($T[\text{K}] = T[^\circ\text{C}] + 273.15$);
derive the **Two-Temperature Arrhenius Ratio Formula**:
$$\mathbf{\ln\left( \frac{k(T_2)}{k(T_1)} \right) = \frac{E_a}{R} \left( \frac{1}{T_1} - \frac{1}{T_2} \right) = \frac{E_a}{R} \left( \frac{T_2 - T_1}{T_1 \cdot T_2} \right)}$$
master the **Reaction Rate Units Matrix**:
- **0th Order:** $k \to \text{mol/m}^3\cdot\text{s}$;
- **1st Order:** $k \to \text{s}^{-1} \text{ or } \text{min}^{-1}$;
- **2nd Order:** $k \to \text{m}^3\text{/mol}\cdot\text{s} \text{ or } \text{L/mol}\cdot\text{s}$;
- **3rd Order:** $k \to (\text{m}^3\text{/mol})^2\cdot\text{s}^{-1}$;
(proving that on an Arrhenius plot of $\ln k$ versus $1/T$, the slope is strictly equal to $-E_a/R$, providing a direct experimental path to measure activation energy barriers).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Arrhenius Law ($k = A e^{-E_a/RT}$), Two-Temperature Ratio ($\ln(k_2/k_1) = \frac{E_a}{R}(\frac{1}{T_1}-\frac{1}{T_2})$) & Units Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Activation Energy and Predict Rate Constant at Higher Temperature Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Reaction Kinetic Entity / Temperature Parameter & Technical Physical Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | On an Arrhenius Plot Linearizing the Temperature Dependence of a Reaction Rate Constant, the Slope of $\ln k$ Plotted Against $1/T$ Equals Exactly $-E_a$ Divided by ___ (R / Gas Constant) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Chemical Reaction Engineering Problem: Computing Activation Energy Ea and Reaction Rate Constant at 350K Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Arrhenius Law & Rate Kinetics (Arrhenius 1889; Fogler 2016; Levenspiel 1999):
   - **Kinetic Formulations:**
     $$\mathbf{k(T) = A e^{-E_a/RT} \quad \Big| \quad \ln\left(\frac{k_2}{k_1}\right) = \frac{E_a}{R}\left(\frac{1}{T_1} - \frac{1}{T_2}\right) \quad \Big| \quad -r_A = k C_A^\alpha C_B^\beta \quad \Big| \quad \text{Slope} = -\frac{E_a}{R}}$$
   - **Units of Reaction Rate Constants Matrix ($n = \alpha + \beta$):**
     $$\begin{array}{|l|c|l|}
     \hline
     \textbf{Reaction Order } n & \textbf{Rate Law Form} & \textbf{SI Units of Rate Constant } k \\
     \hline
     \mathbf{n = 0 \text{ (Zero Order)}} & -r_A = k & \mathbf{\text{mol}\cdot\text{m}^{-3}\cdot\text{s}^{-1}} \\
     \mathbf{n = 1 \text{ (First Order)}} & -r_A = k C_A & \mathbf{\text{s}^{-1} \text{ (Independent of Concentration Units)}} \\
     \mathbf{n = 2 \text{ (Second Order)}} & -r_A = k C_A^2 \text{ or } k C_A C_B & \mathbf{\text{m}^3\cdot\text{mol}^{-1}\cdot\text{s}^{-1} \text{ or } \text{L}\cdot\text{mol}^{-1}\cdot\text{s}^{-1}} \\
     \mathbf{n = 3 \text{ (Third Order)}} & -r_A = k C_A^3 & \text{m}^6\cdot\text{mol}^{-2}\cdot\text{s}^{-1} \\
     \hline
     \end{array}$$
   - **The Temperature Sensitivity Invariant:** Reactions with **large activation energies ($E_a \gg 100\text{ kJ/mol}$) are hypersensitive to temperature shifts**; a modest $10^\circ\text{C}$ temperature rise can increase the reaction rate by $300-500\%$, whereas low $E_a$ reactions show minimal acceleration!
2. **Slide 2 (`ordering`):** Provide 5 steps of activation energy determination: (1) measure reaction rate constants $k_1$ and $k_2$ at two absolute temperatures $T_1$ and $T_2$ in Kelvin, (2) compute temperature reciprocals $1/T_1$ and $1/T_2$ and calculate difference $(1/T_1 - 1/T_2)$, (3) evaluate natural logarithm ratio $\ln(k_2 / k_1)$, (4) calculate activation energy: $E_a = \frac{R \cdot \ln(k_2 / k_1)}{(1/T_1 - 1/T_2)}$ in $\text{J/mol}$ (divide by 1000 for $\text{kJ/mol}$), (5) compute pre-exponential factor: $A = k_1 \exp(E_a / R T_1)$ and evaluate rate constant at any new temperature $T_3$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Arrhenius Equation, Activation Energy $E_a$, Pre-Exponential Factor $A$, First-Order Rate Unit $\text{s}^{-1}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of R (or Gas Constant). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating activation energy and rate constant: A first-order liquid reaction has rate constant $k_1 = 0.020\text{ s}^{-1}$ at $T_1 = 300.0\text{ K}$ ($26.85^\circ\text{C}$) and $k_2 = 0.100\text{ s}^{-1}$ at $T_2 = 320.0\text{ K}$ ($46.85^\circ\text{C}$). Universal gas constant $R = 8.314\text{ J/mol}\cdot\text{K}$.
   - Ratio: $k_2 / k_1 = \frac{0.100}{0.020} = 5.000 \implies \ln(5.000) = \mathbf{1.60944}$;
   - Temperature reciprocals:
     $\frac{1}{T_1} - \frac{1}{T_2} = \frac{1}{300.0} - \frac{1}{320.0} = \frac{320 - 300}{300 \times 320} = \frac{20}{96,000} = \mathbf{2.08333 \times 10^{-4}\text{ K}^{-1}}$;
   - Activation energy:
     $E_a = \frac{R \cdot \ln(k_2 / k_1)}{(1/T_1 - 1/T_2)} = \frac{8.314 \times 1.60944}{2.08333 \times 10^{-4}} = \frac{13.38089}{2.08333 \times 10^{-4}} = \mathbf{64,228\text{ J/mol} = 64.23\text{ kJ/mol}}$;
   - What is the activation energy $E_a$ of this reaction? ($E_a = \mathbf{64.2\text{ kJ/mol}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "arrhenius_kinetics_and_rate_law_determination",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Chemical Reaction Kinetics \\& Arrhenius Law (Svante Arrhenius)**\n• **Arrhenius Temperature Dependence Master Formulation:**\n$$\n\\mathbf{k(T) = A \\cdot \\exp\\left( -\\frac{E_a}{R T} \\right) \\Longleftrightarrow \\mathbf{\\ln k = \\ln A - \\frac{E_a}{R} \\left( \\frac{1}{T} \\right)}}\n$$\n  - **$k(T)$:** Reaction rate constant at absolute temperature $T$ ($\\text{K}$);\n  - **$A$:** Frequency pre-exponential factor;\n  - **$E_a$:** Activation energy barrier ($\\text{J/mol}$ or $\\text{kJ/mol}$);\n  - **$R = 8.314\\text{ J/mol}\\cdot\\text{K}$:** Universal gas constant;\n• **Two-Temperature Arrhenius Ratio Formulation:**\n$$\n\\mathbf{\\ln\\left( \\frac{k_2}{k_1} \\right) = \\frac{E_a}{R} \\left( \\frac{1}{T_1} - \\frac{1}{T_2} \\right) = \\frac{E_a}{R} \\left( \\frac{T_2 - T_1}{T_1 \\cdot T_2} \\right)}\n$$\n• **Rate Law \\& Reaction Order:** $\\mathbf{-r_A = k(T) \\cdot C_A^\\alpha \\cdot C_B^\\beta \\quad (n = \\alpha + \\beta = \\text{Overall Order})}$\n• **The Activation Energy Invariant:** On an Arrhenius plot of $\\ln k$ vs $1/T$, the **slope is strictly equal to $-E_a / R$**; high-$E_a$ reactions exhibit dramatic exponential acceleration upon heating, whereas low-$E_a$ reactions show mild temperature sensitivity!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the activation energy of a chemical reaction and predict its reaction rate constant at elevated temperatures.",
      "orderItems": [
        "Measure the reaction rate constants k1 and k2 at two distinct absolute temperatures T1 and T2 in Kelvin",
        "Calculate the reciprocal temperature difference: \u0394(1/T) = (1/T1) - (1/T2) = (T2 - T1) / (T1 * T2)",
        "Evaluate the natural logarithm of the rate constant ratio: ln(k2 / k1)",
        "Calculate the activation energy: Ea = [ R * ln(k2 / k1) ] / [ (1/T1) - (1/T2) ] in J/mol and convert to kJ/mol",
        "Determine the pre-exponential factor A = k1 * exp(Ea / (R*T1)) and calculate rate constant k3 at any target temperature T3"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Reaction Kinetics Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Arrhenius Law", "right": "k(T) = A*exp(-Ea/RT), fundamental exponential equation relating reaction rate constants to temperature" },
        { "left": "Activation Energy (Ea)", "right": "Minimum threshold kinetic energy reactant molecules must possess to overcome the transition state barrier" },
        { "left": "Pre-Exponential Factor (A)", "right": "Frequency factor representing total collision rate of reactant molecules with favorable orientation" },
        { "left": "First-Order Rate Unit (s^-1)", "right": "Time reciprocal unit that is completely independent of concentration scale (mol/L or mol/m^3)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "On an Arrhenius plot linearizing the temperature dependence of a reaction rate constant, the slope of ln(k) plotted against 1/T equals exactly -Ea divided by ___.",
      "blankAnswer": "R",
      "blankDistractors": ["T", "k", "A"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A first-order reaction has k1 = 0.020 s^-1 at T1 = 300.0 K and k2 = 0.100 s^-1 at T2 = 320.0 K (k2/k1 = 5.00, ln5.0 = 1.6094). (1/T1 - 1/T2) = (1/300 - 1/320) = 20 / 96,000 = 2.0833 \u00d7 10^-4 K^-1. Using R = 8.314 J/mol*K, what is the activation energy Ea of the reaction?",
      "options": [
        { "text": "Ea = 64.2 kJ/mol (Ea = [8.314 * 1.60944] / [2.08333 \u00d7 10^-4] = 13.3809 / (2.08333 \u00d7 10^-4) = 64,228 J/mol = 64.23 kJ/mol)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the two-point Arrhenius equation (H. Scott Fogler *Elements of Chemical Reaction Engineering* Chapter 3; Octave Levenspiel *Chemical Reaction Engineering* Chapter 2). 1. **Identify Experimental Kinetic Data:** - Rate constant at $T_1 = 300.0\\text{ K}$: $k_1 = 0.020\\text{ s}^{-1}$. - Rate constant at $T_2 = 320.0\\text{ K}$: $k_2 = 0.100\\text{ s}^{-1}$. - Universal gas constant: $R = 8.314\\text{ J/mol}\\cdot\\text{K}$. 2. **Calculate Rate Constant Ratio \\& Temperature Reciprocal Difference:** - Natural logarithm of ratio: $$\\ln\\left( \\frac{k_2}{k_1} \\right) = \\ln\\left( \\frac{0.100}{0.020} \\right) = \\ln(5.000) = \\mathbf{1.609438}$$ - Difference in reciprocal absolute temperatures: $$\\frac{1}{T_1} - \\frac{1}{T_2} = \\frac{1}{300.0\\text{ K}} - \\frac{1}{320.0\\text{ K}} = \\frac{320.0 - 300.0}{300.0 \\times 320.0} = \\frac{20.0}{96,000\\text{ K}} = \\mathbf{2.083333 \\times 10^{-4}\\text{ K}^{-1}}$$ 3. **Calculate Activation Energy ($E_a$):** - Rearranging Arrhenius two-point equation: $$E_a = \\frac{R \\cdot \\ln\\left( \\frac{k_2}{k_1} \\right)}{\\frac{1}{T_1} - \\frac{1}{T_2}} = \\frac{8.314\\text{ J/mol}\\cdot\\text{K} \\times 1.609438}{2.083333 \\times 10^{-4}\\text{ K}^{-1}}$$ $$E_a = \\frac{13.38087\\text{ J/mol}}{2.083333 \\times 10^{-4}} = \\mathbf{64,228.18\\text{ J/mol} = 64.228\\text{ kJ/mol} \\approx 64.2\\text{ kJ/mol}}$$ Flawless Arrhenius reaction kinetics and activation energy derivation!" },
        { "text": "Ea = 12.8 kJ/mol", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Ea = 128.4 kJ/mol", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Ea = 32.1 kJ/mol", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
