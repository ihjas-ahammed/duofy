# Duofy Reusable Lesson Format: Transition State Theory and the Eyring Equation

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Physical_Chemistry / Chemical_Kinetics_and_Reaction_Dynamics`  
**Lesson Format Type:** `transition_state_theory_and_eyring_equation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the statistical thermodynamics and quantum mechanics of chemical reaction rates: formulate **Transition State Theory (Henry Eyring, Michael Polanyi, Eugene Wigner, 1935)** assuming quasi-equilibrium between reactants and the activated complex ($K^\ddagger$), derive the **Eyring-Polanyi Equation ($k = \kappa \frac{k_B T}{h} e^{\Delta S^\ddagger / R} e^{-\Delta H^\ddagger / RT}$)**, construct **Eyring Plots ($\ln(k/T)$ vs $1/T$)** to extract enthalpy ($\Delta H^\ddagger$) and entropy ($\Delta S^\ddagger$) of activation, interpret the physical significance of activation entropy (associative $\Delta S^\ddagger < 0$ vs dissociative $\Delta S^\ddagger > 0$), and relate TST parameters to Arrhenius activation energy ($E_a = \Delta H^\ddagger + RT$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | TST Quasi-Equilibrium & Eyring Equation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Eyring Rate Constant Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Activation Thermodynamic Parameter & Physical Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Eyring Pre-Exponential Fundamental Frequency Factor Formula Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Associative Bimolecular Reaction Negative Activation Entropy Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Transition State Theory & The Eyring-Polanyi Equation:
   - **Transition State Theory Postulate (1935):**
     - Reactants exist in quasi-equilibrium with an activated complex $[A-B]^\ddagger$ residing at the saddle point of a Potential Energy Surface (PES).
     - The rate of product formation equals the concentration of the activated complex multiplied by the universal passage frequency over the barrier:
       $$\nu_{\text{passage}} = \frac{k_B T}{h} \approx 6.2 \times 10^{12}\text{ s}^{-1} \text{ at } 298\text{ K}$$
   - **The Eyring-Polanyi Rate Equation:**
     $$k = \kappa \frac{k_B T}{h} K^\ddagger = \kappa \frac{k_B T}{h} e^{-\Delta G^\ddagger / RT} = \kappa \frac{k_B T}{h} e^{\Delta S^\ddagger / R} e^{-\Delta H^\ddagger / RT}$$
     where $\kappa \approx 1$ is the transmission coefficient, $k_B$ is Boltzmann's constant, and $h$ is Planck's constant.
   - **The Linear Eyring Plot:**
     $$\ln\left(\frac{k}{T}\right) = \left[\ln\left(\frac{k_B}{h}\right) + \frac{\Delta S^\ddagger}{R}\right] - \frac{\Delta H^\ddagger}{R}\left(\frac{1}{T}\right)$$
     - $\text{Slope} = -\frac{\Delta H^\ddagger}{R}$
     - $\text{Y-Intercept} = \ln\left(\frac{k_B}{h}\right) + \frac{\Delta S^\ddagger}{R}$
   - **Relationship to Arrhenius Parameters:**
     $$E_a = \Delta H^\ddagger + RT \quad (\text{solutions}), \qquad A = \frac{e k_B T}{h} e^{\Delta S^\ddagger / R}$$
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the Eyring equation from statistical mechanics: (1) define quasi-equilibrium between reactants and activated complex: $K^\ddagger = \frac{[X^\ddagger]}{[A][B]} = \frac{q^\ddagger}{q_A q_B} e^{-\Delta E_0 / RT}$, (2) factor out the translational partition function for motion along the reaction coordinate: $q^\ddagger = q_{\text{vib}}^\ddagger \times \frac{(2\pi m^\ddagger k_B T)^{1/2} \delta}{h}$, (3) express reaction rate as passage flux across barrier width $\delta$: $\text{Rate} = \nu_{\text{passage}} [X^\ddagger] = \frac{\bar{v}}{2\delta} [X^\ddagger]$, (4) substitute mean thermal velocity $\bar{v} = \sqrt{\frac{2 k_B T}{\pi m^\ddagger}}$, cancelling barrier width $\delta$ and mass $m^\ddagger$, (5) express equilibrium constant in terms of standard Gibbs activation energy to establish $k = \frac{k_B T}{h} e^{-\Delta G^\ddagger / RT} = \frac{k_B T}{h} e^{\Delta S^\ddagger/R} e^{-\Delta H^\ddagger/RT}$!
3. **Slide 3 (`matching`):** Pair 4 kinetic parameters ($\Delta H^\ddagger$, $\Delta S^\ddagger < 0$, $\Delta S^\ddagger > 0$, $k_B T / h$) with their physical meanings (Enthalpy barrier to reach transition state, Associative/ordered transition state, Dissociative/disordered transition state, Fundamental universal passage frequency).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in transition state theory, the universal transition state passage frequency is given by (k_B * T) / h, where h is Planck's constant. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on interpreting activation entropy: An organic substitution reaction exhibits an experimentally determined activation entropy of $\Delta S^\ddagger = -120\text{ J}\cdot\text{mol}^{-1}\cdot\text{K}^{-1}$ (strongly negative). What does this large negative $\Delta S^\ddagger$ reveal about the reaction mechanism? (It proves an **Associative Bimolecular ($\text{S}_{\text{N}}2$) Mechanism**; two independent reactant molecules must collide and freeze out multiple rotational and translational degrees of freedom to assemble into a highly ordered, rigid pentacoordinate transition state).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "transition_state_theory_and_eyring_equation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Transition State Theory and the Eyring Equation**\n• **The Eyring-Polanyi Equation (1935):**\n$$\nk = \\kappa \\frac{k_B T}{h} e^{-\\Delta G^\\ddagger / RT} = \\kappa \\frac{k_B T}{h} e^{\\Delta S^\\ddagger / R} e^{-\\Delta H^\\ddagger / RT}\n$$\n  - $\\frac{k_B T}{h} \\approx 6.21 \\times 10^{12}\\text{ s}^{-1}$ at $298\\text{ K}$ (Universal barrier passage frequency).\n  - $\\kappa \\approx 1$ (Transmission coefficient).\n• **The Linearized Eyring Plot:**\n$$\n\\ln\\left(\\frac{k}{T}\\right) = -\\frac{\\Delta H^\\ddagger}{R}\\left(\\frac{1}{T}\\right) + \\left[\\ln\\left(\\frac{k_B}{h}\\right) + \\frac{\\Delta S^\\ddagger}{R}\\right]\n$$\n  - $\\text{Slope} = -\\frac{\\Delta H^\\ddagger}{R}, \\qquad \\text{Intercept} = 23.76 + \\frac{\\Delta S^\\ddagger}{R}$.\n• **Physical Significance of $\\Delta S^\\ddagger$:**\n  - **$\\Delta S^\\ddagger \\ll 0$ (Negative):** Associative mechanism (ordered transition state, e.g. $\\text{S}_{\\text{N}}2$).\n  - **$\\Delta S^\\ddagger > 0$ (Positive):** Dissociative mechanism (disordered transition state, e.g. $\\text{S}_{\\text{N}}1$)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the statistical mechanics steps deriving the Eyring rate equation.",
      "orderItems": [
        "Postulate quasi-equilibrium between reactant molecules and the activated complex at the barrier peak: K‡ = [X‡] / [A][B]",
        "Factor out the one-dimensional translational partition function along the reaction coordinate from the total partition function",
        "Formulate the rate of crossing the barrier top as the product of passage frequency and activated complex concentration",
        "Substitute the average thermal velocity across barrier width delta, observing exact mathematical cancellation of mass and width",
        "Express the resulting quasi-equilibrium constant in terms of standard activation parameters: k = (k_B * T / h) * exp(-Delta G‡ / RT)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each kinetic parameter to its physical thermodynamic significance.",
      "matchPairs": [
        { "left": "Enthalpy of Activation (Delta H‡)", "right": "Energy penalty required to stretch bonds and reach transition state saddle point (Delta H‡ = E_a - RT)" },
        { "left": "Negative Activation Entropy (Delta S‡ < 0)", "right": "Bimolecular associative transition state with loss of translational/rotational freedom" },
        { "left": "Positive Activation Entropy (Delta S‡ > 0)", "right": "Unimolecular dissociative transition state with bond breaking and increased freedom" },
        { "left": "Universal Frequency Factor (k_B * T / h)", "right": "Fundamental vibration rate at which activated complexes cross the potential barrier (~6.2 x 10^12 s^-1)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Eyring equation, the universal pre-exponential frequency factor is given by Boltzmann's constant k_B multiplied by temperature T, divided by ___'s constant h.",
      "blankAnswer": "planck",
      "blankDistractors": ["boltzmann", "newton", "avogadro"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A reaction exhibits a strongly negative activation entropy Delta S‡ = -130 J/(mol K). What mechanistic pathway does this experimental value indicate?",
      "options": [
        { "text": "An ASSOCIATIVE BIMOLECULAR pathway (such as S_N2 or concerted cycloaddition); two separate molecules must come together and adopt a highly restricted, ordered transition state, losing multiple translational and rotational degrees of freedom", "isCorrect": true, "explanation": "Correct! When two separate reactant molecules assemble into a single, tightly constrained activated complex, three translational and three rotational degrees of freedom are converted into stiff vibrational modes, resulting in a large loss of entropy (strongly negative Delta S‡, typically -80 to -150 J/(mol·K)). Unimolecular dissociative reactions (like S_N1) show Delta S‡ near zero or positive." },
        { "text": "A unimolecular radioactive decay process", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A dissociative S_N1 carbocation formation", "isCorrect": false, "explanation": "Incorrect: S_N1 has positive or near-zero Delta S‡." },
        { "text": "A zero-barrier explosion", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
