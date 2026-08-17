# Duofy Reusable Lesson Format: Excess Gibbs Energy (Margules & Van Laar Activity Models)

**Target Topic:** `04_Engineering_and_Technology / 04_Chemical_Engineering / Chemical_Engineering_Thermodynamics / Vapor_Liquid_Equilibrium_VLE`  
**Lesson Format Type:** `margules_and_van_laar_activity_coefficient_models`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the thermodynamic foundation of liquid phase non-ideality, Excess Gibbs Free Energy ($G^E = G - G^{\text{ideal}} = R T \sum x_i \ln\gamma_i$), partial molar excess properties ($\ln\gamma_i = \left[ \frac{\partial (n G^E / R T)}{\partial n_i} \right]_{T,P,n_j}$), the symmetrical **2-Suffix Margules Model**, the asymmetric **3-Suffix Margules Model**, the **Van Laar Model** (derived from the Van der Waals equation of state), and the physical meaning and estimation of **Infinite Dilution Activity Coefficients ($\gamma_1^\infty, \gamma_2^\infty$)** (J. M. Smith, H. C. Van Ness, M. M. Abbott, M. T. Swihart *Introduction to Chemical Engineering Thermodynamics* 8th/9th ed. Chapters 11 & 12; Stanley I. Sandler *Chemical Thermodynamics* Chapter 10): formulate the **2-Suffix Margules Model Formulation**:
$$\mathbf{\frac{G^E}{R T} = A \cdot x_1 \cdot x_2 \Longleftrightarrow \mathbf{\ln\gamma_1 = A \cdot x_2^2 \quad \Big| \quad \ln\gamma_2 = A \cdot x_1^2 \quad \Big| \quad \gamma_1^\infty = \gamma_2^\infty = e^A}}}$$
where:
1. **$A$:** Symmetrical binary interaction parameter (dimensionless);
2. **$x_1, x_2$:** Liquid phase mole fractions ($x_2 = 1 - x_1$);
3. **$\gamma_1^\infty = \lim_{x_1 \to 0} \gamma_1 = e^A$:** Infinite dilution activity coefficient of component 1 in pure solvent 2;
formulate the **3-Suffix Margules Model (Asymmetric)**:
$$\mathbf{\frac{G^E}{R T} = x_1 x_2 \left[ A_{21} x_1 + A_{12} x_2 \right] \implies \begin{cases} \mathbf{\ln\gamma_1 = x_2^2 \left[ A_{12} + 2 (A_{21} - A_{12}) x_1 \right]} & \left(\gamma_1^\infty = e^{A_{12}}\right) \\ \mathbf{\ln\gamma_2 = x_1^2 \left[ A_{21} + 2 (A_{12} - A_{21}) x_2 \right]} & \left(\gamma_2^\infty = e^{A_{21}}\right) \end{cases}}$$
formulate the **Van Laar Model**:
$$\mathbf{\ln\gamma_1 = A_{12}' \left[ 1 + \frac{A_{12}' x_1}{A_{21}' x_2} \right]^{-2} \quad \Big| \quad \ln\gamma_2 = A_{21}' \left[ 1 + \frac{A_{21}' x_2}{A_{12}' x_1} \right]^{-2} \quad \left(A_{12}' = \ln\gamma_1^\infty, \ A_{21}' = \ln\gamma_2^\infty\right)}$$
(proving that as a pure component is approached ($x_1 \to 1.0, x_2 \to 0$), $\ln\gamma_1 \to 0 \implies \gamma_1 \to 1.00$, recovering the pure component Raoult's law boundary condition).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Excess Gibbs Energy ($G^E/RT = Ax_1 x_2$), Margules ($\ln\gamma_1 = Ax_2^2$) & Infinite Dilution ($\gamma^\infty = e^A$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Margules Parameter A and Predict Binary VLE Activity Coefficients Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Activity Model Construct / Excess Property & Technical Thermodynamic Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the 2-Suffix Symmetrical Margules Model $\ln\gamma_1 = A x_2^2$, as Component 1 Becomes Infinitely Dilute ($x_1 \to 0, x_2 \to 1$), its Activity Coefficient $\gamma_1^\infty$ Equals $e$ Raised to the Power of ___ (A / Margules Parameter A) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Chemical Engineering Problem: Computing Margules Parameter A from a Single VLE Data Point and Finding Activity Coefficients Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Excess Gibbs & Margules Activity Models (Margules 1895; Van Laar 1906; Smith, Van Ness, Abbott 2018):
   - **Activity Formulations:**
     $$\mathbf{\frac{G^E}{RT} = Ax_1 x_2 \quad \Big| \quad \ln\gamma_1 = A x_2^2 \quad \Big| \quad \ln\gamma_2 = A x_1^2 \quad \Big| \quad \gamma_1^\infty = e^A \quad \Big| \quad A = \frac{\ln\gamma_1}{x_2^2}}$$
   - **Activity Models Comparison Matrix:**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Activity Model} & \textbf{Parameters} & \textbf{Symmetry} & \textbf{Best Suited Chemical Systems} \\
     \hline
     \mathbf{\text{2-Suffix Margules}} & \mathbf{1 \ (A)} & \mathbf{\text{Symmetric }} (\gamma_1^\infty = \gamma_2^\infty) & \text{Chemically similar non-polar liquid pairs} \\
     \mathbf{\text{3-Suffix Margules}} & \mathbf{2 \ (A_{12}, A_{21})} & \text{Asymmetric} & \text{Moderate polarity / size asymmetry} \\
     \mathbf{\text{Van Laar Equation}} & \mathbf{2 \ (A_{12}', A_{21}')} & \text{Asymmetric} & \text{Hydrocarbon-alcohol mixtures with size differences} \\
     \text{Wilson / NRTL} & 2\text{ to }3 & \text{Local Composition} & \text{Partially miscible / highly polar aqueous organics} \\
     \hline
     \end{array}$$
   - **The Pure Component Limit Invariant:** As $x_1 \to 1.0$ (pure liquid 1), $x_2 = 0 \implies \ln\gamma_1 = A(0)^2 = 0 \implies \mathbf{\gamma_1 = 1.000}$, ensuring all models obey the Lewis-Randall pure component boundary state!
2. **Slide 2 (`ordering`):** Provide 5 steps of Margules analysis: (1) measure or extract one experimental VLE data point ($x_1, y_1, T, P$), (2) calculate pure component vapor pressures $P_1^{\text{sat}}(T)$ and $P_2^{\text{sat}}(T)$ using Antoine equations, (3) determine experimental activity coefficient: $\gamma_1 = \frac{y_1 P}{x_1 P_1^{\text{sat}}}$, (4) compute Margules parameter: $A = \frac{\ln\gamma_1}{x_2^2} = \frac{\ln\gamma_1}{(1 - x_1)^2}$, (5) predict activity coefficients at any other composition using $\ln\gamma_1 = A x_2^2$ and $\ln\gamma_2 = A x_1^2$!
3. **Slide 3 (`matching`):** Pair 4 concepts (2-Suffix Margules, Infinite Dilution $\gamma^\infty$, Excess Gibbs Energy $G^E$, Van Laar Model) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of A (or Margules Parameter A). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating Margules parameter and activity coefficients: A binary system at $60^\circ\text{C}$ has an equimolar experimental VLE point ($x_1 = 0.50, x_2 = 0.50$) where the measured activity coefficient of component 1 is $\gamma_1 = 1.350$ ($\ln(1.350) = 0.3001$).
   - Symmetrical Margules parameter: $A = \frac{\ln\gamma_1}{x_2^2} = \frac{0.3001}{(0.50)^2} = \frac{0.3001}{0.25} = \mathbf{1.2004 \approx 1.20}$;
   - Infinite dilution activity coefficient: $\gamma_1^\infty = \gamma_2^\infty = e^A = e^{1.2004} = \mathbf{3.321}$;
   - At composition $x_1 = 0.80, x_2 = 0.20$:
     - $\ln\gamma_1 = A x_2^2 = 1.2004 \times (0.20)^2 = 1.2004 \times 0.04 = 0.04802 \implies \gamma_1 = e^{0.04802} = \mathbf{1.049}$;
     - $\ln\gamma_2 = A x_1^2 = 1.2004 \times (0.80)^2 = 1.2004 \times 0.64 = 0.76826 \implies \gamma_2 = e^{0.76826} = \mathbf{2.156}$;
   - What is the Margules parameter $A$ and the infinite dilution activity coefficient $\gamma^\infty$? ($A = \mathbf{1.20}$ and $\gamma^\infty = \mathbf{3.32}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "margules_and_van_laar_activity_coefficient_models",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Excess Gibbs Energy \\& Margules Models (Max Margules 1895)**\n• **Excess Gibbs Free Energy Master Relation:**\n$$\n\\mathbf{\\frac{G^E}{R T} = \\sum_{i=1}^N x_i \\ln\\gamma_i \\quad \\Big| \\quad \\ln\\gamma_i = \\left[ \\frac{\\partial (n G^E / R T)}{\\partial n_i} \\right]_{T, P, n_j}}\n$$\n• **Symmetrical 2-Suffix Margules Formulation:**\n$$\n\\mathbf{\\frac{G^E}{R T} = A \\cdot x_1 \\cdot x_2 \\Longleftrightarrow \\mathbf{\\ln\\gamma_1 = A \\cdot x_2^2 \\quad \\Big| \\quad \\ln\\gamma_2 = A \\cdot x_1^2}}\n$$\n  - **$A$:** Symmetrical binary interaction parameter ($A = \\ln\\gamma_1 / x_2^2$);\n  - **Infinite Dilution Limits ($x_1 \\to 0$ or $x_2 \\to 0$):**\n$$\n\\mathbf{\\lim_{x_1 \\to 0} \\gamma_1 = \\gamma_1^\\infty = e^A \\quad \\Big| \\quad \\lim_{x_2 \\to 0} \\gamma_2 = \\gamma_2^\\infty = e^A}\n$$\n• **The Pure Component Asymptote Invariant:** As $x_1 \\to 1.0$, $x_2 \\to 0 \\implies \\ln\\gamma_1 = A(0)^2 = 0 \\implies \\mathbf{\\gamma_1 = 1.000}$, ensuring thermodynamic convergence to Raoult's law for pure solvents!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the Margules parameter from experimental VLE data and predict non-ideal activity coefficients.",
      "orderItems": [
        "Obtain experimental VLE data (x1, y1, T, P) for a single equilibrium state point",
        "Calculate pure component vapor pressures P1_sat(T) and P2_sat(T) from Antoine equations",
        "Determine the experimental activity coefficient of component 1: \u03b31 = (y1 * P) / (x1 * P1_sat)",
        "Calculate the symmetrical Margules parameter: A = ln(\u03b31) / (x2^2) = ln(\u03b31) / (1 - x1)^2",
        "Predict activity coefficients across all compositions using ln(\u03b31) = A*x2^2 and ln(\u03b32) = A*x1^2"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Thermodynamic Activity Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "2-Suffix Margules Model", "right": "ln(\u03b31) = A*x2^2, single-parameter symmetric model describing liquid mixtures of similar molecular size" },
        { "left": "Infinite Dilution (\u03b3\u221e = e^A)", "right": "Maximum non-ideality experienced by isolated solute molecules completely surrounded by pure solvent" },
        { "left": "Excess Gibbs Energy (G^E)", "right": "G^E = RT \u2211 xi*ln(\u03b3i), thermodynamic difference between actual mixture Gibbs free energy and ideal solution" },
        { "left": "Van Laar Model", "right": "Two-parameter asymmetric activity model derived from the Van der Waals equation of state" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the 2-suffix symmetrical Margules model ln(\u03b31) = A*x2^2, as component 1 becomes infinitely dilute (x1 \u2192 0, x2 \u2192 1), its activity coefficient \u03b31^\u221e equals e raised to the power of ___.",
      "blankAnswer": "A",
      "blankDistractors": ["2A", "A/2", "x1"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "At 60\u00b0C, an equimolar binary mixture (x1 = 0.50, x2 = 0.50) has a measured activity coefficient \u03b31 = 1.350 (ln(1.350) = 0.3001). Using the 2-suffix Margules model (A = 0.3001 / 0.50^2 = 0.3001 / 0.25 = 1.200), what is the Margules parameter A and the infinite dilution activity coefficient \u03b3^\u221e = e^A?",
      "options": [
        { "text": "A = 1.20 and \u03b3^\u221e = 3.32 (A = 0.3001 / 0.25 = 1.2004 \u2248 1.20; \u03b3^\u221e = e^1.2004 = 3.321 \u2248 3.32)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the 2-suffix symmetrical Margules activity coefficient model (Smith, Van Ness, Abbott *Introduction to Chemical Engineering Thermodynamics* Chapter 11 & 12). 1. **Identify Experimental VLE State:** - Liquid mole fractions: $x_1 = 0.50, \\quad x_2 = 0.50$. - Measured activity coefficient: $\\gamma_1 = 1.350$. - Natural logarithm: $$\\ln\\gamma_1 = \\ln(1.350) = \\mathbf{0.300105}$$ 2. **Calculate Symmetrical Margules Parameter ($A$):** - Margules relation: $$\\ln\\gamma_1 = A \\cdot x_2^2 \\Longleftrightarrow A = \\frac{\\ln\\gamma_1}{x_2^2}$$ - Substituting $x_2 = 0.50 \\implies x_2^2 = (0.50)^2 = 0.25$: $$A = \\frac{0.300105}{0.25} = \\mathbf{1.20042 \\approx 1.20}$$ 3. **Calculate Infinite Dilution Activity Coefficient ($\\gamma_1^\\infty = \\gamma_2^\\infty$):** - In the 2-suffix Margules model, as $x_1 \\to 0$, $x_2 \\to 1.0$: $$\\ln\\gamma_1^\\infty = A \\cdot (1.0)^2 = A = 1.20042$$ $$\\gamma_1^\\infty = e^A = e^{1.20042} = \\mathbf{3.3215 \\approx 3.32}$$ 4. **Thermodynamic Interpretation:** - Positive interaction parameter ($A = 1.20 > 0$) signifies positive deviation from Raoult's law; molecules have higher escaping tendency than in an ideal solution! Flawless Margules activity coefficient model and infinite dilution derivation!" },
        { "text": "A = 0.60 and \u03b3^\u221e = 1.82 (Forgot to square x2)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A = 1.20 and \u03b3^\u221e = 1.20", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A = 2.40 and \u03b3^\u221e = 11.02", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
