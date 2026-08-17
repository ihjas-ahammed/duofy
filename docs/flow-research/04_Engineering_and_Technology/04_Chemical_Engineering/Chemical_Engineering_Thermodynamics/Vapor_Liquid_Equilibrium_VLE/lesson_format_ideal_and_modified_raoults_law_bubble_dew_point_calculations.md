# Duofy Reusable Lesson Format: VLE Fundamentals (Modified Raoult's Law & Bubble/Dew Points)

**Target Topic:** `04_Engineering_and_Technology / 04_Chemical_Engineering / Chemical_Engineering_Thermodynamics / Vapor_Liquid_Equilibrium_VLE`  
**Lesson Format Type:** `ideal_and_modified_raoults_law_bubble_dew_point_calculations`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the fundamentals of low-to-moderate pressure Vapor-Liquid Equilibrium (VLE), the transition from ideal gas/ideal solution Raoult's Law to **Modified Raoult's Law** with liquid activity coefficients ($\gamma_i$), Antoine vapor pressure modeling ($P_i^{\text{sat}}(T)$), the distinction between **Bubble-Point Pressure ($P_{\text{bubl}}$)** (first bubble of vapor forms in liquid of given $\{x_i\}$) and **Dew-Point Pressure ($P_{\text{dew}}$)** (first droplet of liquid condenses from vapor of given $\{y_i\}$), equilibrium vapor composition calculation ($y_i = x_i \gamma_i P_i^{\text{sat}} / P$), and binary P-x-y phase envelopes (J. M. Smith, H. C. Van Ness, M. M. Abbott, M. T. Swihart *Introduction to Chemical Engineering Thermodynamics* 8th/9th ed. Chapter 10; Stanley I. Sandler *Chemical Thermodynamics* Chapter 10): formulate **Modified Raoult's Law Master Formulation**:
$$\mathbf{y_i \cdot P = x_i \cdot \gamma_i \cdot P_i^{\text{sat}}(T) \quad (i = 1, 2, \dots, N)}$$
where:
1. **$y_i$:** Mole fraction of species $i$ in vapor phase ($\sum y_i = 1.0$);
2. **$x_i$:** Mole fraction of species $i$ in liquid phase ($\sum x_i = 1.0$);
3. **$\gamma_i$:** Liquid phase activity coefficient ($\gamma_i = 1.0$ for ideal solution);
4. **$P_i^{\text{sat}}(T)$:** Saturated pure component vapor pressure at system temperature $T$;
5. **$P$:** Total system pressure;
formulate the **Bubble-Point Pressure ($P_{\text{bubl}}$) Equation**:
$$\mathbf{P_{\text{bubl}} = \sum_{i=1}^N x_i \cdot \gamma_i \cdot P_i^{\text{sat}}(T) \quad \Big| \quad y_i = \frac{x_i \cdot \gamma_i \cdot P_i^{\text{sat}}(T)}{P_{\text{bubl}}}}$$
formulate the **Dew-Point Pressure ($P_{\text{dew}}$) Equation**:
$$\mathbf{P_{\text{dew}} = \frac{1}{\sum_{i=1}^N \frac{y_i}{\gamma_i \cdot P_i^{\text{sat}}(T)}} \quad \Big| \quad x_i = \frac{y_i \cdot P_{\text{dew}}}{\gamma_i \cdot P_i^{\text{sat}}(T)}}$$
(proving that bubble-point calculations are direct non-iterative summations while dew-point calculations with composition-dependent activity coefficients require successive substitution on liquid mole fractions $\{x_i\}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Modified Raoult's Law ($y_i P = x_i \gamma_i P_i^{\text{sat}}$), $P_{\text{bubl}} = \sum x_i \gamma_i P_i^{\text{sat}}$ & $P_{\text{dew}} = 1/\sum \frac{y_i}{\gamma_i P_i^{\text{sat}}}$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Perform a BUBL P Calculation and Determine Vapor Equilibrium Composition Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | VLE State Variable / Point & Technical Thermodynamic Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In an Ideal Binary Solution Obeying Raoult's Law, the Bubble-Point Pressure Curve on a P-x-y Diagram Is Strictly a Straight ___ (Line / Linear Function) Connecting the Pure Component Vapor Pressures Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Chemical Thermodynamics Problem: Computing Bubble Pressure and Equilibrium Vapor Composition y1 for Non-Ideal Binary Mix Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Modified Raoult's Law & Bubble/Dew Mechanics (Raoult 1887; Smith, Van Ness, Abbott 2018):
   - **VLE Formulations:**
     $$\mathbf{y_i P = x_i \gamma_i P_i^{\text{sat}} \quad \Big| \quad P_{\text{bubl}} = \sum x_i \gamma_i P_i^{\text{sat}} \quad \Big| \quad P_{\text{dew}} = \frac{1}{\sum \frac{y_i}{\gamma_i P_i^{\text{sat}}}} \quad \Big| \quad K_i = \frac{y_i}{x_i} = \frac{\gamma_i P_i^{\text{sat}}}{P}}$$
   - **The 4 Standard VLE Problem Types Matrix:**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{VLE Problem Type} & \textbf{Given Quantities} & \textbf{Calculated Quantities} & \textbf{Mathematical Nature} \\
     \hline
     \mathbf{\text{BUBL P}} & \mathbf{\{x_i\}, \ T} & \mathbf{P, \ \{y_i\}} & \mathbf{\text{Direct explicit summation }} P = \sum x_i \gamma_i P_i^{\text{sat}} \\
     \mathbf{\text{DEW P}} & \mathbf{\{y_i\}, \ T} & \mathbf{P, \ \{x_i\}} & \text{Harmonic sum; iterative if } \gamma_i = f(\{x_i\}) \\
     \mathbf{\text{BUBL T}} & \{x_i\}, \ P & T, \ \{y_i\} & \text{Iterative on } T \text{ via Antoine vapor pressures} \\
     \mathbf{\text{DEW T}} & \{y_i\}, \ P & T, \ \{x_i\} & \text{Iterative on both } T \text{ and liquid composition } \{x_i\} \\
     \hline
     \end{array}$$
   - **The Phase Equilibrium Invariant:** Total pressure in a closed container is **strictly bounded between pure component vapor pressures** in ideal solutions ($P_2^{\text{sat}} \le P \le P_1^{\text{sat}}$), but can exceed this bracket if strong positive deviations ($\gamma_i > 1.0$) form an azeotrope!
2. **Slide 2 (`ordering`):** Provide 5 steps of BUBL P calculation: (1) obtain pure component saturation vapor pressures $P_1^{\text{sat}}(T)$ and $P_2^{\text{sat}}(T)$ from Antoine equations at system temperature $T$, (2) extract liquid mole fractions $x_1$ and $x_2 = 1 - x_1$, (3) evaluate liquid activity coefficients $\gamma_1$ and $\gamma_2$ from the activity model at $\{x_i\}$, (4) calculate total bubble-point pressure: $P_{\text{bubl}} = x_1 \gamma_1 P_1^{\text{sat}} + x_2 \gamma_2 P_2^{\text{sat}}$, (5) compute equilibrium vapor mole fractions: $y_1 = \frac{x_1 \gamma_1 P_1^{\text{sat}}}{P_{\text{bubl}}}$ and $y_2 = 1 - y_1$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Modified Raoult's Law, Bubble Point, Dew Point, K-Value $y_i/x_i$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Line (or Linear Function). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating bubble-point pressure and vapor composition: A binary liquid mixture at $T = 50^\circ\text{C}$ has $x_1 = 0.40$ and $x_2 = 0.60$. Pure saturation vapor pressures are $P_1^{\text{sat}} = 80.0\text{ kPa}$ and $P_2^{\text{sat}} = 40.0\text{ kPa}$. The liquid activity coefficients at this composition are $\gamma_1 = 1.25$ and $\gamma_2 = 1.10$.
   - Partial vapor pressure 1: $p_1 = x_1 \gamma_1 P_1^{\text{sat}} = 0.40 \times 1.25 \times 80.0\text{ kPa} = 0.50 \times 80.0 = \mathbf{40.0\text{ kPa}}$;
   - Partial vapor pressure 2: $p_2 = x_2 \gamma_2 P_2^{\text{sat}} = 0.60 \times 1.10 \times 40.0\text{ kPa} = 0.66 \times 40.0 = \mathbf{26.4\text{ kPa}}$;
   - Total bubble-point pressure: $P_{\text{bubl}} = p_1 + p_2 = 40.0 + 26.4 = \mathbf{66.4\text{ kPa}}$;
   - Equilibrium vapor mole fraction of component 1: $y_1 = \frac{p_1}{P_{\text{bubl}}} = \frac{40.0\text{ kPa}}{66.4\text{ kPa}} = \mathbf{0.6024 \approx 0.602}$;
   - What is the total bubble pressure $P_{\text{bubl}}$ and vapor composition $y_1$? ($P_{\text{bubl}} = \mathbf{66.4\text{ kPa}}$ and $y_1 = \mathbf{0.602}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ideal_and_modified_raoults_law_bubble_dew_point_calculations",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Modified Raoult's Law \\& Phase Equilibrium (Smith, Van Ness, \\& Abbott)**\n• **Modified Raoult's Law Master Formulation:**\n$$\n\\mathbf{y_i \\cdot P = x_i \\cdot \\gamma_i \\cdot P_i^{\\text{sat}}(T) \\quad (i = 1, 2, \\dots, N)}\n$$\n  - **$y_i, x_i$:** Vapor and liquid phase mole fractions ($\\sum y_i = \\sum x_i = 1.0$);\n  - **$\\gamma_i$:** Liquid phase activity coefficient accounting for intermolecular non-ideality;\n  - **$P_i^{\\text{sat}}(T)$:** Pure species saturation vapor pressure at temperature $T$;\n  - **$P$:** Total system pressure;\n• **Bubble-Point Pressure Formulation ($P_{\\text{bubl}}$):**\n$$\n\\mathbf{P_{\\text{bubl}} = \\sum_{i=1}^N x_i \\cdot \\gamma_i \\cdot P_i^{\\text{sat}}(T) \\quad \\Big| \\quad y_i = \\frac{x_i \\cdot \\gamma_i \\cdot P_i^{\\text{sat}}(T)}{P_{\\text{bubl}}}}\n$$\n• **Dew-Point Pressure Formulation ($P_{\\text{dew}}$):**\n$$\n\\mathbf{P_{\\text{dew}} = \\frac{1}{\\sum_{i=1}^N \\frac{y_i}{\\gamma_i \\cdot P_i^{\\text{sat}}(T)}} \\quad \\Big| \\quad x_i = \\frac{y_i \\cdot P_{\\text{dew}}}{\\gamma_i \\cdot P_i^{\\text{sat}}(T)}}\n$$\n• **The Vapor-Liquid Invariant:** In a binary system, component 1 is the more volatile species ($P_1^{\\text{sat}} > P_2^{\\text{sat}}$); in equilibrium vapor, **it is always enriched ($y_1 > x_1$)** unless an azeotropic pinch point is reached!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to perform a BUBL P calculation and determine the equilibrium vapor composition for a non-ideal binary mixture.",
      "orderItems": [
        "Calculate the pure component saturation vapor pressures P1_sat(T) and P2_sat(T) using Antoine equations at system temperature",
        "Extract the known liquid mole fractions x1 and x2 = 1 - x1",
        "Calculate the liquid activity coefficients \u03b31 and \u03b32 from an activity coefficient model at liquid composition {xi}",
        "Compute the total bubble-point pressure by summing partial pressures: P_bubl = x1*\u03b31*P1_sat + x2*\u03b32*P2_sat",
        "Determine the equilibrium vapor mole fractions: y1 = (x1 * \u03b31 * P1_sat) / P_bubl and y2 = 1 - y1"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each VLE Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Modified Raoult's Law", "right": "yi*P = xi*\u03b3i*Pi_sat, low-pressure VLE model incorporating liquid non-ideality through activity coefficients" },
        { "left": "Bubble-Point Pressure", "right": "Pressure at which the first infinitesimal bubble of vapor forms upon depressurizing a subcooled liquid" },
        { "left": "Dew-Point Pressure", "right": "Pressure at which the first infinitesimal droplet of liquid condenses upon pressurizing a superheated vapor" },
        { "left": "K-Value (Equilibrium Ratio)", "right": "Ki = yi / xi = (\u03b3i * Pi_sat) / P, measure of a chemical species' tendency to vaporize into the gas phase" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In an ideal binary solution obeying Raoult's law, the bubble-point pressure curve on a P-x-y diagram is strictly a straight ___ connecting the pure component vapor pressures.",
      "blankAnswer": "line",
      "blankDistractors": ["circle", "hyperbola", "parabola"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A binary liquid has x1 = 0.40, x2 = 0.60 at 50\u00b0C. Pure vapor pressures are P1_sat = 80.0 kPa and P2_sat = 40.0 kPa. Activity coefficients are \u03b31 = 1.25 and \u03b32 = 1.10 (p1 = 0.40 * 1.25 * 80.0 = 40.0 kPa; p2 = 0.60 * 1.10 * 40.0 = 26.4 kPa). What is the total bubble pressure P_bubl and the equilibrium vapor mole fraction y1?",
      "options": [
        { "text": "P_bubl = 66.4 kPa and y1 = 0.602 (P_bubl = 40.0 + 26.4 = 66.4 kPa; y1 = 40.0 / 66.4 = 0.6024 \u2248 0.602)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Modified Raoult's Law for bubble-point pressure and vapor composition (Smith, Van Ness, Abbott *Introduction to Chemical Engineering Thermodynamics* Chapter 10). 1. **Calculate Partial Vapor Pressures of Components:** - Component 1 partial pressure: $$p_1 = x_1 \\cdot \\gamma_1 \\cdot P_1^{\\text{sat}}(T) = 0.40 \\times 1.25 \\times 80.0\\text{ kPa} = 0.500 \\times 80.0\\text{ kPa} = \\mathbf{40.0\\text{ kPa}}$$ - Component 2 partial pressure: $$p_2 = x_2 \\cdot \\gamma_2 \\cdot P_2^{\\text{sat}}(T) = 0.60 \\times 1.10 \\times 40.0\\text{ kPa} = 0.660 \\times 40.0\\text{ kPa} = \\mathbf{26.4\\text{ kPa}}$$ 2. **Calculate Total Bubble-Point Pressure ($P_{\\text{bubl}}$):** $$P_{\\text{bubl}} = p_1 + p_2 = 40.0\\text{ kPa} + 26.4\\text{ kPa} = \\mathbf{66.4\\text{ kPa}}$$ 3. **Calculate Equilibrium Vapor Mole Fraction ($y_1$):** $$y_1 = \\frac{p_1}{P_{\\text{bubl}}} = \\frac{40.0\\text{ kPa}}{66.4\\text{ kPa}} = \\mathbf{0.60241 \\approx 0.602}$$ - Equilibrium vapor mole fraction of component 2: $$y_2 = 1 - y_1 = 1 - 0.60241 = \\mathbf{0.39759 \\approx 0.398}$$ 4. **Check Equilibrium Enrichment:** - Since component 1 is more volatile ($P_1^{\\text{sat}} = 80 > P_2^{\\text{sat}} = 40$), the vapor phase is strongly enriched in component 1 ($y_1 = 0.602 > x_1 = 0.400$), confirming thermodynamic equilibrium! Flawless Modified Raoult's Law bubble-point pressure derivation!" },
        { "text": "P_bubl = 56.0 kPa and y1 = 0.571 (Assumed ideal solution with \u03b31 = \u03b32 = 1.0)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "P_bubl = 66.4 kPa and y1 = 0.400", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "P_bubl = 120.0 kPa and y1 = 0.667", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
