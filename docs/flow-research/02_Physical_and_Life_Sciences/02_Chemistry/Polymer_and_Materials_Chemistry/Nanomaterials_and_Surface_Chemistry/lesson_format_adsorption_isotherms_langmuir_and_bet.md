# Duofy Reusable Lesson Format: Adsorption Isotherms (Langmuir and BET)

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Polymer_and_Materials_Chemistry / Nanomaterials_and_Surface_Chemistry`  
**Lesson Format Type:** `adsorption_isotherms_langmuir_and_bet`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the physical chemistry, mathematical derivations, and experimental porosimetry of gas-solid adsorption isotherms: derive the **Langmuir Monolayer Isotherm ($\theta = \frac{KP}{1 + KP}$)** from the dynamic equilibrium of adsorption ($\text{rate}_{\text{ads}} = k_a P (1-\theta)$) and desorption ($\text{rate}_{\text{des}} = k_d \theta$), analyze its linear transformations ($\frac{P}{V} = \frac{1}{K V_m} + \frac{P}{V_m}$), extend to multilayer physical adsorption via the **BET Isotherm (Stephen Brunauer, Paul Emmett, Edward Teller, 1938)** ($\frac{P}{V(P_0 - P)} = \frac{1}{V_m C} + \frac{C-1}{V_m C}\frac{P}{P_0}$), extract the **BET Specific Surface Area ($S_{\text{BET}} = \frac{V_m N_A \sigma_{\text{cross}}}{V_{\text{molar}}}$)** from nitrogen physisorption at $77\text{ K}$, and classify IUPAC Type I through Type VI adsorption isotherms.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Langmuir & BET Adsorption Isotherms Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Langmuir Isotherm Derivation from Kinetic Equilibrium Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | IUPAC Adsorption Isotherm Type & Porous Material Classification Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Langmuir Saturated High-Pressure Fractional Coverage Value Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | BET Linear Plot Extraction of Monolayer Volume and Surface Area Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Langmuir and BET Adsorption Models:
   - **Langmuir Monolayer Adsorption (Irving Langmuir, 1916):**
     - Assumptions: (1) Uniform flat surface with identical localized sites, (2) Exactly one molecule per site (monolayer max), (3) No lateral interactions between adsorbed molecules.
     - **Kinetic Balance:**
       $$\text{Rate}_{\text{adsorption}} = k_a P (1 - \theta) = k_d \theta = \text{Rate}_{\text{desorption}}$$
       $$\theta = \frac{K P}{1 + K P} \qquad \left(\text{where } K = \frac{k_a}{k_d}\right)$$
     - **Linearized Langmuir Equation:**
       $$\frac{P}{V} = \frac{1}{K V_m} + \frac{P}{V_m}$$
   - **The BET Multilayer Model (Brunauer, Emmett, Teller, 1938):**
     - Extends Langmuir by allowing infinite layers of molecules to condense on top of the first layer (heat of adsorption for layers $\ge 2$ equals heat of liquefaction $\Delta H_{\text{vap}}$):
       $$\frac{P}{V(P_0 - P)} = \frac{1}{V_m C} + \left(\frac{C - 1}{V_m C}\right)\frac{P}{P_0}$$
       where $P_0$ is saturation vapor pressure, $V_m$ is monolayer volume, and $C \approx \exp\left(\frac{\Delta H_{\text{des},1} - \Delta H_{\text{vap}}}{RT}\right)$.
     - **Specific Surface Area Calculation ($S_{\text{BET}}$):**
       $$S_{\text{BET}} = \frac{V_m \cdot N_A \cdot \sigma}{V_{\text{molar}}} \quad (\sigma_{\text{N}_2} = 0.162\text{ nm}^2 \text{ at } 77\text{ K}).$$
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the Langmuir isotherm: (1) define fractional surface coverage $\theta = \frac{N_{\text{occupied}}}{N_{\text{total}}}$, giving fraction of empty vacant sites as $(1 - \theta)$, (2) formulate the rate of gas adsorption as proportional to gas pressure and available vacant sites: $\text{Rate}_{\text{ads}} = k_a P (1 - \theta)$, (3) formulate the rate of desorption as proportional to the occupied sites: $\text{Rate}_{\text{des}} = k_d \theta$, (4) set adsorption rate equal to desorption rate at dynamic thermodynamic equilibrium: $k_a P (1 - \theta) = k_d \theta$, (5) define equilibrium constant $K = k_a / k_d$ and solve algebraically for coverage: $\theta = \frac{K P}{1 + K P}$!
3. **Slide 3 (`matching`):** Pair 4 IUPAC isotherm types (Type I Microporous, Type II Macroporous / Non-porous, Type IV Mesoporous with hysteresis, Type III Weak-interaction non-porous) with their adsorption behaviors.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that at infinite pressure (P -> infinity), the fractional surface coverage theta in the Langmuir isotherm approaches a saturation value of 1. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on interpreting BET parameters: A porous metal-organic framework (MOF) is analyzed using nitrogen physisorption at $77\text{ K}$. The linear BET plot yields a slope of $S = 0.00095\text{ cm}^{-3}$ and a y-intercept of $I = 0.00005\text{ cm}^{-3}$. How is the monolayer volume $V_m$ calculated from this data? (The monolayer volume is calculated as **$V_m = \frac{1}{\text{Slope} + \text{Intercept}} = \frac{1}{0.00095 + 0.00005} = 1000\text{ cm}^3\ (\text{STP})$**, because adding the BET slope $\frac{C-1}{V_m C}$ to the y-intercept $\frac{1}{V_m C}$ yields $\frac{C}{V_m C} = \frac{1}{V_m}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "adsorption_isotherms_langmuir_and_bet",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Adsorption Isotherms (Langmuir and BET)**\n• **Langmuir Monolayer Model (1916):**\n  - Homogeneous equivalent sites; Monolayer max; No lateral site-site interactions.\n$$\n\\text{Rate}_{\\text{ads}} = k_a P (1 - \\theta) = k_d \\theta = \\text{Rate}_{\\text{des}} \\implies \\theta = \\frac{K P}{1 + K P}\n$$\n  - **Linear Form:** $\\frac{P}{V} = \\frac{1}{K V_m} + \\frac{P}{V_m}$ (Monolayer capacity $V_m$).\n• **The BET Multilayer Model (Brunauer, Emmett, Teller, 1938):**\n  - Extends to infinite stacked multilayers on porous solid matrices:\n$$\n\\frac{P}{V(P_0 - P)} = \\frac{1}{V_m C} + \\left(\\frac{C - 1}{V_m C}\\right)\\frac{P}{P_0}\n$$\n  - $\\text{Slope} + \\text{Intercept} = \\frac{C-1}{V_m C} + \\frac{1}{V_m C} = \\frac{1}{V_m} \\implies V_m = \\frac{1}{\\text{Slope} + \\text{Intercept}}$.\n  - **Specific Surface Area:** $S_{\\text{BET}} = \\frac{V_m N_A \\sigma_{\\text{cross}}}{V_{\\text{molar}}}$ ($\\sigma_{\\text{N}_2} = 0.162\\text{ nm}^2$ at $77\\text{ K}$)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the derivation steps for the Langmuir adsorption isotherm from kinetic equilibrium.",
      "orderItems": [
        "Define fractional surface coverage theta and express the fraction of open, unoccupied surface sites as (1 - theta)",
        "Formulate the rate of adsorption as proportional to gas pressure and available vacant sites: Rate_ads = k_a * P * (1 - theta)",
        "Formulate the rate of desorption as proportional to the population of occupied sites: Rate_des = k_d * theta",
        "Equate adsorption rate to desorption rate at dynamic thermodynamic equilibrium: k_a * P * (1 - theta) = k_d * theta",
        "Define the adsorption equilibrium constant K = k_a / k_d and solve algebraically for coverage: theta = K*P / (1 + K*P)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each IUPAC adsorption isotherm type to its material porosity characteristic.",
      "matchPairs": [
        { "left": "Type I Isotherm (Langmuir-like plateau)", "right": "Microporous materials (pore diameter < 2 nm, e.g. Zeolites and MOFs)" },
        { "left": "Type II Isotherm (Unrestricted multilayer)", "right": "Non-porous or macroporous solids with complete monolayer-to-multilayer progression" },
        { "left": "Type IV Isotherm (with Hysteresis Loop)", "right": "Mesoporous materials (2-50 nm pores, e.g. MCM-41) undergoing capillary condensation" },
        { "left": "Type III Isotherm (Convex curve)", "right": "Non-porous solids with very weak adsorbate-adsorbent interactions (C < 2)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Langmuir adsorption isotherm, as the equilibrium gas pressure approaches infinity (P -> infinity), the fractional surface coverage theta saturates at exactly ___.",
      "blankAnswer": "1",
      "blankDistractors": ["0", "0.5", "infinity"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a standard nitrogen BET surface area measurement at 77 K, a linear plot of P / [V(P0 - P)] vs P/P0 gives a Slope of 0.0090 cm⁻³ and a Y-Intercept of 0.0010 cm⁻³. What is the monolayer volume V_m?",
      "options": [
        { "text": "V_m = 100 cm³ (STP); because the sum of the BET slope (C-1)/(Vm*C) and the y-intercept 1/(Vm*C) mathematically simplifies to 1/V_m, so V_m = 1 / (0.0090 + 0.0010) = 1 / 0.010 = 100 cm³", "isCorrect": true, "explanation": "Correct! In the BET equation, Slope = (C-1)/(Vm*C) and Intercept = 1/(Vm*C). Adding them together gives: Slope + Intercept = (C - 1 + 1) / (Vm*C) = C / (Vm*C) = 1 / Vm. Therefore, Vm is calculated directly as the reciprocal of (Slope + Intercept) = 1 / (0.0090 + 0.0010) = 1 / 0.0100 = 100 cm³." },
        { "text": "V_m = 0.008 cm³", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "V_m = 1000 cm³", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "V_m = 9.0 cm³", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
