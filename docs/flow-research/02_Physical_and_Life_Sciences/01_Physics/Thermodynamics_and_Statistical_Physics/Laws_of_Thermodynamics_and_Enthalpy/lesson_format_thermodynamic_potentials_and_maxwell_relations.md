# Duofy Reusable Lesson Format: Thermodynamic Potentials and Maxwell Relations

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Thermodynamics_and_Statistical_Physics / Laws_of_Thermodynamics_and_Enthalpy`  
**Lesson Format Type:** `thermodynamic_potentials_and_maxwell_relations`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the 4 fundamental thermodynamic potentials and their cross-derivative symmetries: formulate **Internal Energy $U(S, V)$**, **Enthalpy $H(S, P) = U + PV$**, **Helmholtz Free Energy $F(T, V) = U - TS$**, and **Gibbs Free Energy $G(T, P) = H - TS$**, derive the **4 Fundamental Maxwell Relations** via Euler-Schwarz exact differential reciprocity ($\frac{\partial^2 \Phi}{\partial x \partial y} = \frac{\partial^2 \Phi}{\partial y \partial x}$), and calculate the **Internal Pressure of a Van der Waals Gas ($\left(\frac{\partial U}{\partial V}\right)_T = T\left(\frac{\partial P}{\partial T}\right)_V - P = \frac{a}{V^2}$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | 4 Thermodynamic Potentials & Maxwell Relations Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Maxwell Relation Derivation from Helmholtz Free Energy Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Thermodynamic Potential & Natural Variables Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Gibbs Free Energy Natural Independent Variables Symbol Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Van der Waals Gas Internal Energy Volume Derivative Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the 4 Thermodynamic Potentials and Maxwell Relations:
   - **Fundamental Potentials (Legendre Transforms):**
     1. **Internal Energy:** $dU = T dS - P dV \implies T = \left(\frac{\partial U}{\partial S}\right)_V, \ -P = \left(\frac{\partial U}{\partial V}\right)_S$.
     2. **Enthalpy:** $dH = T dS + V dP \implies T = \left(\frac{\partial H}{\partial S}\right)_P, \ V = \left(\frac{\partial H}{\partial P}\right)_S$.
     3. **Helmholtz Free Energy:** $dF = -S dT - P dV \implies -S = \left(\frac{\partial F}{\partial T}\right)_V, \ -P = \left(\frac{\partial F}{\partial V}\right)_T$.
     4. **Gibbs Free Energy:** $dG = -S dT + V dP \implies -S = \left(\frac{\partial G}{\partial T}\right)_P, \ V = \left(\frac{\partial G}{\partial P}\right)_T$.
   - **The 4 Maxwell Relations (Schwarz Symmetry):**
     $$\left(\frac{\partial T}{\partial V}\right)_S = -\left(\frac{\partial P}{\partial S}\right)_V, \qquad \left(\frac{\partial T}{\partial P}\right)_S = \left(\frac{\partial V}{\partial S}\right)_P$$
     $$\left(\frac{\partial S}{\partial V}\right)_T = \left(\frac{\partial P}{\partial T}\right)_V, \qquad \left(\frac{\partial S}{\partial P}\right)_T = -\left(\frac{\partial V}{\partial T}\right)_P$$
   - **Thermodynamic Equation of State:**
     $$\left(\frac{\partial U}{\partial V}\right)_T = T \left(\frac{\partial P}{\partial T}\right)_V - P$$
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the Maxwell relation $\left(\frac{\partial S}{\partial V}\right)_T = \left(\frac{\partial P}{\partial T}\right)_V$ from Helmholtz free energy: (1) state Helmholtz free energy definition: $F = U - TS$, (2) write total differential: $dF = dU - TdS - SdT = (TdS - PdV) - TdS - SdT = -SdT - PdV$, (3) identify partial derivatives from exact differential: $-S = \left(\frac{\partial F}{\partial T}\right)_V$ and $-P = \left(\frac{\partial F}{\partial V}\right)_T$, (4) apply Schwarz theorem on mixed second derivatives: $\frac{\partial^2 F}{\partial V \partial T} = \frac{\partial^2 F}{\partial T \partial V}$, (5) equate mixed derivatives to obtain $-\left(\frac{\partial S}{\partial V}\right)_T = -\left(\frac{\partial P}{\partial T}\right)_V \implies \left(\frac{\partial S}{\partial V}\right)_T = \left(\frac{\partial P}{\partial T}\right)_V$!
3. **Slide 3 (`matching`):** Pair 4 potentials ($U(S,V)$, $H(S,P)$, $F(T,V)$, $G(T,P)$) with their natural independent variables and spontaneous minimization conditions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the natural independent state variables of Gibbs free energy are temperature T and pressure P. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on internal pressure of a gas: For a Van der Waals gas with equation of state $P = \frac{RT}{V - b} - \frac{a}{V^2}$, what is the isothermal rate of change of internal energy with volume $\left(\frac{\partial U}{\partial V}\right)_T$? ($\left(\frac{\partial U}{\partial V}\right)_T = \frac{a}{V^2}$; applying the thermodynamic identity $\left(\frac{\partial U}{\partial V}\right)_T = T\left(\frac{\partial P}{\partial T}\right)_V - P = T\left(\frac{R}{V-b}\right) - \left(\frac{RT}{V-b} - \frac{a}{V^2}\right) = \frac{a}{V^2}$, reflecting attractive intermolecular forces).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "thermodynamic_potentials_and_maxwell_relations",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Thermodynamic Potentials and Maxwell Relations**\n• **The 4 Fundamental Potentials:**\n  1. **Internal Energy:** $dU = T dS - P dV$\n  2. **Enthalpy:** $dH = T dS + V dP$\n  3. **Helmholtz Free Energy:** $dF = -S dT - P dV$\n  4. **Gibbs Free Energy:** $dG = -S dT + V dP$\n• **The 4 Fundamental Maxwell Relations (Schwarz Reciprocity):**\n$$\n\\left(\\frac{\\partial T}{\\partial V}\\right)_S = -\\left(\\frac{\\partial P}{\\partial S}\\right)_V, \\qquad \\left(\\frac{\\partial T}{\\partial P}\\right)_S = \\left(\\frac{\\partial V}{\\partial S}\\right)_P\n$$\n$$\n\\left(\\frac{\\partial S}{\\partial V}\\right)_T = \\left(\\frac{\\partial P}{\\partial T}\\right)_V, \\qquad \\left(\\frac{\\partial S}{\\partial P}\\right)_T = -\\left(\\frac{\\partial V}{\\partial T}\\right)_P\n$$\n• **Internal Energy Identity:** $\\left(\\frac{\\partial U}{\\partial V}\\right)_T = T \\left(\\frac{\\partial P}{\\partial T}\\right)_V - P$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the mixed partial derivative steps deriving the Maxwell relation (dS/dV)_T = (dP/dT)_V.",
      "orderItems": [
        "State the Legendre transform for Helmholtz Free Energy: F = U - T * S",
        "Write the total differential: dF = dU - T * dS - S * dT = -S * dT - P * dV",
        "Identify the first partial derivatives: -S = (dF/dT)_V and -P = (dF/dV)_T",
        "Apply Schwarz's Theorem asserting equality of mixed second derivatives: d²F / (dV dT) = d²F / (dT dV)",
        "Substitute the first derivatives into the mixed equality to establish: (dS/dV)_T = (dP/dT)_V"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each thermodynamic potential to its natural independent variables.",
      "matchPairs": [
        { "left": "Internal Energy U", "right": "Natural variables: Entropy S and Volume V (dU = T dS - P dV)" },
        { "left": "Enthalpy H", "right": "Natural variables: Entropy S and Pressure P (dH = T dS + V dP)" },
        { "left": "Helmholtz Free Energy F", "right": "Natural variables: Temperature T and Volume V (minimized at equilibrium under const T, V)" },
        { "left": "Gibbs Free Energy G", "right": "Natural variables: Temperature T and Pressure P (minimized at equilibrium under const T, P)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The natural independent thermodynamic state variables of Gibbs Free Energy G are temperature T and ___ P.",
      "blankAnswer": "pressure",
      "blankDistractors": ["volume", "entropy", "density"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "For a Van der Waals gas with equation of state P = (R T / [V - b]) - a / V², what is the isothermal internal pressure derivative (dU/dV)_T?",
      "options": [
        { "text": "(dU/dV)_T = a / V²; evaluating T*(dP/dT)_V - P gives T*(R / [V - b]) - [R T / (V - b) - a/V²] = a / V², proving that internal energy increases with volume due to attractive intermolecular forces overcoming potential energy", "isCorrect": true, "explanation": "Correct! Using the thermodynamic equation of state (dU/dV)_T = T(dP/dT)_V - P, we differentiate P with respect to T at constant V to get R/(V-b). Multiplying by T and subtracting P cancels the ideal thermal term, leaving only the attraction parameter a/V^2." },
        { "text": "(dU/dV)_T = 0", "isCorrect": false, "explanation": "Incorrect: That is only true for an IDEAL gas with zero intermolecular forces." },
        { "text": "(dU/dV)_T = -a / V²", "isCorrect": false, "explanation": "Incorrect: Sign error." },
        { "text": "(dU/dV)_T = R * T", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
