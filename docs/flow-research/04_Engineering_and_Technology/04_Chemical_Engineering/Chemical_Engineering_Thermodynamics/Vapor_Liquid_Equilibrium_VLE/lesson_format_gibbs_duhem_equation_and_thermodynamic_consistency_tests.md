# Duofy Reusable Lesson Format: Consistency Tests (Gibbs-Duhem & Redlich-Kister Area Test)

**Target Topic:** `04_Engineering_and_Technology / 04_Chemical_Engineering / Chemical_Engineering_Thermodynamics / Vapor_Liquid_Equilibrium_VLE`  
**Lesson Format Type:** `gibbs_duhem_equation_and_thermodynamic_consistency_tests`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the rigorous mathematical criteria governing multicomponent phase equilibrium data validation, the fundamental **Gibbs-Duhem Equation** relating partial molar properties at constant temperature and pressure, the derivation of the binary slope constraint ($x_1 \frac{d\ln\gamma_1}{dx_1} + x_2 \frac{d\ln\gamma_2}{dx_1} = 0$), the **Redlich-Kister Area Test** for thermodynamic consistency of isothermal VLE datasets, the Herington test for isobaric datasets, and point-to-point differential consistency checks (J. M. Smith, H. C. Van Ness, M. M. Abbott, M. T. Swihart *Introduction to Chemical Engineering Thermodynamics* 8th/9th ed. Chapter 11; Stanley I. Sandler *Chemical Thermodynamics* Chapter 10): formulate the **Gibbs-Duhem Equation at Constant T and P**:
$$\mathbf{\sum_{i=1}^N x_i \cdot d\bar{M}_i = 0 \Longleftrightarrow \mathbf{\sum_{i=1}^N x_i \cdot d\ln\gamma_i = 0 \quad (\text{at constant } T, P)}}$$
for a binary mixture ($N = 2$), derive the **Binary Slope Constraint Formulation**:
$$\mathbf{x_1 \frac{d\ln\gamma_1}{dx_1} + x_2 \frac{d\ln\gamma_2}{dx_1} = 0 \Longleftrightarrow \mathbf{x_1 \frac{d\ln\gamma_1}{dx_1} = - (1 - x_1) \frac{d\ln\gamma_2}{dx_1}}}$$
derive the **Redlich-Kister Integral Area Test Criterion**:
$$\mathbf{\int_0^1 \ln\left( \frac{\gamma_1}{\gamma_2} \right) dx_1 = \left[ \frac{G^E}{R T} \right]_0^1 = 0.000}$$
where:
1. **$I = \int_0^1 \ln\left(\frac{\gamma_1}{\gamma_2}\right) dx_1 = \text{Area Above Zero Axis } (A) - \text{Area Below Zero Axis } (B)$**;
2. **Consistency Criterion:** If $\mathbf{\frac{|A - B|}{A + B} \le 0.02 \text{ to } 0.10}$ ($\le 2-10\%$), the isothermal VLE dataset is declared **Thermodynamically Consistent**;
(proving that experimental activity coefficients cannot be chosen arbitrarily because molecular thermodynamics strictly links the chemical potentials of all coexisting species).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Gibbs-Duhem ($\sum x_i d\ln\gamma_i = 0$), Slope Constraint & Redlich-Kister Area Test ($\int_0^1 \ln(\frac{\gamma_1}{\gamma_2})dx_1 = 0$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Perform a Redlich-Kister Area Test on an Isothermal VLE Dataset Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Thermodynamic Consistency Construct / Mathematical Relation & Technical Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | According to the Redlich-Kister Integral Area Test, for an Isothermal Binary VLE Dataset to Be Strictly Consistent, the Definite Integral of $\ln(\gamma_1 / \gamma_2)$ from $x_1 = 0$ to $x_1 = 1$ Must Exactly Equal ___ (0 / Zero) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Thermodynamic Validation Problem: Evaluating Gibbs-Duhem Consistency on Proposed Activity Coefficient Models Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Gibbs-Duhem Equation & Consistency Mechanics (Gibbs 1876; Duhem 1886; Redlich & Kister 1948):
   - **Consistency Formulations:**
     $$\mathbf{\sum x_i d\ln\gamma_i = 0 \quad \Big| \quad x_1 \frac{d\ln\gamma_1}{dx_1} = -x_2 \frac{d\ln\gamma_2}{dx_1} \quad \Big| \quad \int_0^1 \ln\left(\frac{\gamma_1}{\gamma_2}\right) dx_1 = 0 \quad \Big| \quad D = \frac{|A - B|}{A + B} \le 0.10}$$
   - **Thermodynamic Consistency Tests Matrix:**
     $$\begin{array}{|l|c|l|}
     \hline
     \textbf{Consistency Test} & \textbf{Dataset Type} & \textbf{Mathematical Verification Condition} \\
     \hline
     \mathbf{\text{Redlich-Kister Area Test}} & \mathbf{\text{Isothermal }} (T = \text{const}) & \mathbf{\int_0^1 \ln(\gamma_1 / \gamma_2) dx_1 = 0 \ (\text{Net area under curve vanishes})} \\
     \mathbf{\text{Herington Test}} & \text{Isobaric } (P = \text{const}) & |D - J| < 10 \quad \left(J = 150 |\Delta T_{\text{max}}| / T_{\text{min}}\right) \\
     \mathbf{\text{Point-to-Point Test}} & \text{Differential } (P, T, x, y) & |\Delta y| \le 0.01 \text{ (Van Ness residuals method)} \\
     \text{Infinite Dilution Test} & Boundary & \text{Consistency of limiting slopes at } x_1 \to 0 \text{ and } x_1 \to 1 \\
     \hline
     \end{array}$$
   - **The Interdependence Invariant:** In a binary liquid mixture, **$\gamma_1$ and $\gamma_2$ cannot vary independently**; if the curve of $\ln\gamma_1$ vs $x_1$ has a negative slope, the curve of $\ln\gamma_2$ vs $x_1$ MUST strictly have a positive slope!
2. **Slide 2 (`ordering`):** Provide 5 steps of Redlich-Kister consistency test: (1) measure isothermal VLE data ($x_1, y_1, P$) across the full composition range $x_1 \in [0, 1]$, (2) compute activity coefficients $\gamma_1 = \frac{y_1 P}{x_1 P_1^{\text{sat}}}$ and $\gamma_2 = \frac{(1-y_1) P}{(1-x_1) P_2^{\text{sat}}}$, (3) calculate the logarithmic ratio $\ln(\gamma_1 / \gamma_2) = \ln\gamma_1 - \ln\gamma_2$ for every data point, (4) plot $\ln(\gamma_1 / \gamma_2)$ versus $x_1$ and integrate the positive area $A$ and negative area $B$, (5) calculate consistency index $D = \frac{|A - B|}{A + B} \times 100\%$ and verify $D < 10\%$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Gibbs-Duhem Equation, Binary Slope Constraint, Redlich-Kister Area Test, Van Ness Residuals) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 0 (or Zero). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on testing Gibbs-Duhem consistency: An engineer proposes an activity coefficient model for a binary mixture at constant $T$: $\ln\gamma_1 = A x_2$ and $\ln\gamma_2 = A x_1$. Let's test Gibbs-Duhem consistency:
   - $\frac{d\ln\gamma_1}{dx_1} = \frac{d}{dx_1}[A(1 - x_1)] = -A$;
   - $\frac{d\ln\gamma_2}{dx_1} = \frac{d}{dx_1}[A x_1] = +A$;
   - Gibbs-Duhem sum: $x_1 \frac{d\ln\gamma_1}{dx_1} + x_2 \frac{d\ln\gamma_2}{dx_1} = x_1(-A) + x_2(+A) = A(x_2 - x_1) = A(1 - 2x_1)$;
   - Since $A(1 - 2x_1) \ne 0$ for all $x_1 \ne 0.5$, this proposed model **violates the Gibbs-Duhem equation and is thermodynamically impossible**!
   - In contrast, the Margules model $\ln\gamma_1 = A x_2^2$ gives $x_1(-2Ax_2) + x_2(2Ax_1) = -2Ax_1 x_2 + 2Ax_1 x_2 \equiv 0$ (Identically Zero!).
   - Which model is thermodynamically consistent with the Gibbs-Duhem equation? ($\ln\gamma_1 = A x_2^2, \ln\gamma_2 = A x_1^2$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "gibbs_duhem_equation_and_thermodynamic_consistency_tests",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Gibbs-Duhem Equation \\& Consistency (J. W. Gibbs \\& P. Duhem)**\n• **Gibbs-Duhem Master Formulation (at Constant T and P):**\n$$\n\\mathbf{\\sum_{i=1}^N x_i \\cdot d\\ln\\gamma_i = 0 \\Longleftrightarrow \\mathbf{x_1 \\frac{d\\ln\\gamma_1}{dx_1} + x_2 \\frac{d\\ln\\gamma_2}{dx_1} = 0}}\n$$\n• **The Binary Slope Constraint:**\n$$\n\\mathbf{x_1 \\frac{d\\ln\\gamma_1}{dx_1} = - (1 - x_1) \\frac{d\\ln\\gamma_2}{dx_1}}\n$$\n• **Redlich-Kister Integral Area Test Criterion:**\n$$\n\\mathbf{\\int_0^1 \\ln\\left( \\frac{\\gamma_1}{\\gamma_2} \\right) dx_1 = \\int_0^1 \\left( \\ln\\gamma_1 - \\ln\\gamma_2 \\right) dx_1 = 0.000}\n$$\n  - **Area Test Index:** $\\mathbf{D = \\frac{|A_{\\text{pos}} - A_{\\text{neg}}|}{A_{\\text{pos}} + A_{\\text{neg}}} \\le 0.10 \\ (10\\%)}$;\n• **The Thermodynamic Truth Invariant:** Activity coefficients in a mixture are **fundamentally linked by molecular equilibrium**; experimental VLE datasets where the net area under the $\\ln(\\gamma_1/\\gamma_2)$ curve fails to vanish violate the Second Law of Thermodynamics!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to perform the Redlich-Kister integral area test on an experimental isothermal binary VLE dataset.",
      "orderItems": [
        "Collect complete isothermal binary VLE data (x1, y1, P) at constant temperature T across the full composition spectrum",
        "Calculate liquid activity coefficients \u03b31 = (y1*P)/(x1*P1_sat) and \u03b32 = ((1-y1)*P)/((1-x1)*P2_sat) for every data point",
        "Evaluate the logarithmic ratio: ln(\u03b31 / \u03b32) = ln(\u03b31) - ln(\u03b32) across all liquid mole fractions x1",
        "Plot ln(\u03b31 / \u03b32) versus x1 and compute the positive area A (above zero) and negative area B (below zero)",
        "Calculate the area discrepancy percentage D = |A - B| / (A + B) * 100% and confirm thermodynamic consistency (D \u2264 10%)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Thermodynamic Consistency Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Gibbs-Duhem Equation", "right": "\u2211 xi*dln(\u03b3i) = 0, exact differential constraint linking partial molar excess properties at constant T and P" },
        { "left": "Binary Slope Constraint", "right": "x1*(dln\u03b31/dx1) = -x2*(dln\u03b32/dx1), proving that as \u03b31 decreases with composition, \u03b32 must increase" },
        { "left": "Redlich-Kister Area Test", "right": "\u222b ln(\u03b31/\u03b32) dx1 = 0, integral consistency test verifying that net excess free energy closes to zero" },
        { "left": "Point-to-Point Test", "right": "Rigorous numerical method checking residuals between measured and modeled vapor compositions |\u0394y| \u2264 0.01" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "According to the Redlich-Kister integral area test, for an isothermal binary VLE dataset to be strictly consistent, the definite integral of ln(\u03b31 / \u03b32) from x1 = 0 to x1 = 1 must exactly equal ___.",
      "blankAnswer": "0",
      "blankDistractors": ["1", "0.5", "\u03c0"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Consider two proposed binary activity models: Model I [ln\u03b31 = A*x2, ln\u03b32 = A*x1] and Model II [ln\u03b31 = A*x2^2, ln\u03b32 = A*x1^2]. Evaluating the Gibbs-Duhem sum x1*(dln\u03b31/dx1) + x2*(dln\u03b32/dx1) reveals: for Model I, the sum equals A*(x2 - x1) \u2260 0; for Model II, the sum equals -2A*x1*x2 + 2A*x1*x2 \u2261 0. Which model is thermodynamically valid?",
      "options": [
        { "text": "Model II is strictly valid; Model I violates the Gibbs-Duhem equation (Model II satisfies x1*(dln\u03b31/dx1) + x2*(dln\u03b32/dx1) = x1*(-2A*x2) + x2*(2A*x1) = -2Ax1x2 + 2Ax1x2 = 0 for all compositions, whereas Model I yields A*(1 - 2x1) \u2260 0)", "isCorrect": true, "explanation": "Correct! Let's rigorously apply the Gibbs-Duhem equation at constant temperature and pressure (Smith, Van Ness, Abbott *Introduction to Chemical Engineering Thermodynamics* Chapter 11). 1. **State the Binary Gibbs-Duhem Condition:** $$\\mathbf{x_1 \\frac{d\\ln\\gamma_1}{dx_1} + x_2 \\frac{d\\ln\\gamma_2}{dx_1} = 0 \\quad \\text{for all } x_1 \\in [0, 1]}$$ Note that $x_2 = 1 - x_1 \\implies \\frac{dx_2}{dx_1} = -1$. 2. **Evaluate Proposed Model I (Linear in Composition):** - Model: $\\ln\\gamma_1 = A x_2 = A(1 - x_1)$ and $\\ln\\gamma_2 = A x_1$. - Derivatives with respect to $x_1$: $$\\frac{d\\ln\\gamma_1}{dx_1} = -A, \\quad \\frac{d\\ln\\gamma_2}{dx_1} = +A$$ - Evaluate Gibbs-Duhem sum: $$x_1(-A) + x_2(+A) = A(x_2 - x_1) = A(1 - 2x_1)$$ - This expression is **non-zero for every composition except the single point $x_1 = 0.50$**. Therefore, Model I **violates the Gibbs-Duhem equation and is thermodynamically impossible!** 3. **Evaluate Proposed Model II (Quadratic Margules):** - Model: $\\ln\\gamma_1 = A x_2^2 = A(1 - x_1)^2$ and $\\ln\\gamma_2 = A x_1^2$. - Derivatives with respect to $x_1$: $$\\frac{d\\ln\\gamma_1}{dx_1} = 2A(1 - x_1)(-1) = -2A x_2, \\quad \\frac{d\\ln\\gamma_2}{dx_1} = 2A x_1$$ - Evaluate Gibbs-Duhem sum: $$x_1(-2A x_2) + x_2(2A x_1) = -2A x_1 x_2 + 2A x_1 x_2 \\equiv \\mathbf{0.0000}$$ - Since the sum is **identically zero at all compositions**, Model II is **thermodynamically consistent and valid!** Flawless Gibbs-Duhem consistency proof!" },
        { "text": "Model I is strictly valid; Model II is invalid", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Both Model I and Model II are thermodynamically valid", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Neither model satisfies the Gibbs-Duhem equation", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
