# Duofy Reusable Lesson Format: Chemical Potential and the Gibbs-Duhem Equation

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Physical_Chemistry / Chemical_Thermodynamics_and_Equilibrium`  
**Lesson Format Type:** `chemical_potential_and_gibbs_duhem_equation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the partial molar properties of open multicomponent systems and the thermodynamic constraints on chemical potentials: formulate the **Chemical Potential ($\mu_i = (\frac{\partial G}{\partial n_i})_{T,P,n_{j\ne i}}$)** as the fundamental escaping tendency and partial molar Gibbs energy, derive total Gibbs energy via Euler's homogeneous function theorem ($G = \sum n_i \mu_i$), derive the **Gibbs-Duhem Equation ($\sum n_i d\mu_i = -S dT + V dP$)**, apply the isothermal-isobaric constraint ($\sum x_i d\mu_i = 0$), and utilize Gibbs-Duhem integration to verify thermodynamic consistency of activity coefficients ($\ln \gamma_i$) in non-ideal binary solutions ($x_1 \frac{d\ln\gamma_1}{dx_1} + x_2 \frac{d\ln\gamma_2}{dx_1} = 0$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Chemical Potential & Gibbs-Duhem Equation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Gibbs-Duhem Equation Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Multicomponent Property & Thermodynamic Equation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Partial Molar Gibbs Free Energy Defining Symbol Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Gibbs-Duhem Interdependence in Binary Liquid Mixtures Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Chemical Potential & The Gibbs-Duhem Equation (J. Willard Gibbs, 1876):
   - **Chemical Potential ($\mu_i$):**
     - The partial molar Gibbs free energy of species $i$ in a mixture:
       $$\mu_i = \left(\frac{\partial G}{\partial n_i}\right)_{T, P, n_{j\ne i}} = \left(\frac{\partial U}{\partial n_i}\right)_{S, V, n_{j\ne i}} = \left(\frac{\partial A}{\partial n_i}\right)_{T, V, n_{j\ne i}}$$
     - **Physical Interpretation:** The "escaping tendency" of matter; substance flows spontaneously from high $\mu_i$ to low $\mu_i$ until $\mu_i^{(\alpha)} = \mu_i^{(\beta)}$ across all phases.
   - **Euler's Theorem on Homogeneous Functions:**
     - Because $G$ is an extensive state function homogeneous of degree 1 with respect to mole numbers:
       $$G = \sum_{i=1}^k n_i \mu_i$$
   - **The Gibbs-Duhem Equation:**
     - Differentiating $G = \sum n_i \mu_i$ yields $dG = \sum n_i d\mu_i + \sum \mu_i dn_i$.
     - Equating with the fundamental open-system relation $dG = -S dT + V dP + \sum \mu_i dn_i$ produces:
       $$\sum_{i=1}^k n_i d\mu_i = -S dT + V dP \implies \sum_{i=1}^k x_i d\mu_i = 0 \quad (\text{at constant } T, P)$$
   - **Application to Binary Solutions ($x_1 + x_2 = 1$):**
     $$x_1 d\mu_1 + x_2 d\mu_2 = 0 \implies x_1 \left(\frac{\partial \ln \gamma_1}{\partial x_1}\right)_{T,P} + x_2 \left(\frac{\partial \ln \gamma_2}{\partial x_1}\right)_{T,P} = 0$$
     *(Proves that measuring the activity/vapor pressure of the solvent experimentally allows exact calculation of the solute's activity!).*
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the Gibbs-Duhem equation: (1) state Euler's integrated expression for total Gibbs energy of a mixture: $G = \sum_i n_i \mu_i$, (2) compute the total derivative using the product rule: $dG = \sum_i \mu_i dn_i + \sum_i n_i d\mu_i$, (3) write the fundamental differential equation of state for an open multicomponent system: $dG = -S dT + V dP + \sum_i \mu_i dn_i$, (4) equate the two expressions for $dG$ and cancel the common term $\sum_i \mu_i dn_i$, (5) obtain the general Gibbs-Duhem relation $\sum_i n_i d\mu_i = -S dT + V dP$, which simplifies to $\sum_i x_i d\mu_i = 0$ at constant $T$ and $P$!
3. **Slide 3 (`matching`):** Pair 4 multicomponent thermodynamic concepts ($\mu_i$, $\sum x_i d\mu_i = 0$, $G = \sum n_i \mu_i$, $\mu_i = \mu_i^\circ + RT\ln a_i$) with their names and applications.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the chemical potential of a component is defined as its partial molar Gibbs free energy. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the implications of the Gibbs-Duhem equation for a binary mixture: In a binary solution of ethanol (component 1) and water (component 2) at constant temperature and pressure, if adding more ethanol causes the chemical potential of ethanol ($\mu_1$) to increase ($d\mu_1 > 0$), what MUST happen to the chemical potential of water ($\mu_2$)? (The chemical potential of water **$\mu_2$ must DECREASE ($d\mu_2 < 0$)**, because the Gibbs-Duhem equation strictly mandates that $x_1 d\mu_1 + x_2 d\mu_2 = 0$; with positive mole fractions $x_1, x_2 > 0$, any positive change in $\mu_1$ must be counterbalanced by a negative change $d\mu_2 = -\frac{x_1}{x_2} d\mu_1$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "chemical_potential_and_gibbs_duhem_equation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Chemical Potential and the Gibbs-Duhem Equation**\n• **Chemical Potential ($\\mu_i$) Defined:**\n$$\n\\mu_i = \\left( \\frac{\\partial G}{\\partial n_i} \\right)_{T, P, n_{j \\ne i}} = \\text{Partial Molar Gibbs Energy}\n$$\n  - Matter flows spontaneously from high $\\mu_i$ to low $\\mu_i$ until $\\mu_i^{(\\alpha)} = \\mu_i^{(\\beta)}$ (Phase Equilibrium).\n• **Euler's Integrated Free Energy:**\n$$\nG = \\sum_{i=1}^k n_i \\mu_i\n$$\n• **The Gibbs-Duhem Equation (Gibbs, 1876):**\n$$\n\\sum_{i=1}^k n_i d\\mu_i = -S dT + V dP \\implies \\sum_{i=1}^k x_i d\\mu_i = 0 \\quad (\\text{at constant } T, P)\n$$\n• **Binary Solution Constraint ($x_1 d\\mu_1 + x_2 d\\mu_2 = 0$):**\n  - The chemical potentials of components in a mixture **cannot change independently**!\n  - Knowing solvent activity ($a_1$) allows exact calculation of solute activity ($a_2$)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps deriving the Gibbs-Duhem equation from fundamental thermodynamic potentials.",
      "orderItems": [
        "State Euler's theorem on homogeneous functions for total Gibbs energy of a mixture: G = sum(n_i * mu_i)",
        "Differentiate G using the product rule to obtain the total derivative: dG = sum(mu_i * dn_i) + sum(n_i * dmu_i)",
        "Write the fundamental thermodynamic differential for an open system: dG = -S dT + V dP + sum(mu_i * dn_i)",
        "Equate the two expressions for dG and cancel the identical composition differential term sum(mu_i * dn_i)",
        "Establish the fundamental Gibbs-Duhem relation sum(n_i * dmu_i) = -S dT + V dP, reducing to sum(x_i * dmu_i) = 0 at constant T, P"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each multicomponent thermodynamic expression to its physical meaning.",
      "matchPairs": [
        { "left": "mu_i = (∂G/∂n_i)_{T,P,n_j}", "right": "Chemical potential (partial molar Gibbs energy / escaping tendency)" },
        { "left": "sum(x_i * dmu_i) = 0", "right": "Isothermal-isobaric Gibbs-Duhem equation (mutual interdependence of chemical potentials)" },
        { "left": "G = sum(n_i * mu_i)", "right": "Euler's integrated extensive Gibbs energy for a multicomponent mixture" },
        { "left": "mu_i = mu_i° + RT*ln(a_i)", "right": "Chemical potential expressed in terms of thermodynamic activity and standard state" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The chemical potential of a pure substance or component in solution is identical to its partial molar ___ free energy.",
      "blankAnswer": "gibbs",
      "blankDistractors": ["helmholtz", "internal", "bond"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a binary liquid mixture of acetone (1) and chloroform (2) at constant temperature and pressure, experimental data shows that adding acetone causes dmu_1 > 0. According to the Gibbs-Duhem equation, what MUST happen to the chemical potential of chloroform (dmu_2)?",
      "options": [
        { "text": "The chemical potential of chloroform MUST DECREASE (dmu_2 < 0); because x1*dmu_1 + x2*dmu_2 = 0 and mole fractions are strictly positive, any increase in mu_1 must be exactly compensated by a decrease dmu_2 = -(x1/x2)*dmu_1", "isCorrect": true, "explanation": "Correct! The Gibbs-Duhem equation establishes that intensive properties in a mixture cannot vary independently. For a binary system at constant T and P, x1*dmu_1 + x2*dmu_2 = 0. Since mole fractions x1 and x2 are always positive, if dmu_1 is positive, dmu_2 is mathematically required to be negative." },
        { "text": "mu_2 must increase by the exact same amount as mu_1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "mu_2 remains strictly zero at all concentrations", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The Gibbs-Duhem equation only applies to ideal gases, so nothing can be deduced", "isCorrect": false, "explanation": "Incorrect: Gibbs-Duhem is exact for all real mixtures." }
      ]
    }
  ]
}
```
