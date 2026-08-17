# Duofy Reusable Lesson Format: First Law, Internal Energy, and Enthalpy

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Thermodynamics_and_Statistical_Physics / Laws_of_Thermodynamics_and_Enthalpy`  
**Lesson Format Type:** `first_law_internal_energy_and_enthalpy`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the first law of thermodynamics, energy conservation, and enthalpy: formulate the **First Law of Thermodynamics ($dU = \delta Q - \delta W$)**, distinguish **State Functions ($U, H, T, P, V$)** from **Path Functions ($Q, W$)**, derive the **Enthalpy Function ($H \equiv U + PV$)**, prove that heat exchanged during a reversible isobaric process equals the change in enthalpy ($\Delta H = Q_P$), calculate work ($W = \int P dV$) across isothermal ($W = nRT\ln(V_f/V_i)$) and adiabatic ($P V^\gamma = \text{const}$) gas processes, and compute heat capacities $C_V = \left(\frac{\partial U}{\partial T}\right)_V$ and $C_P = \left(\frac{\partial H}{\partial T}\right)_P$ (Mayer's relation $C_P - C_V = nR$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | First Law & Enthalpy Definitions Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Isobaric Heat Enthalpy Equivalence Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Thermodynamic Process & Work Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Enthalpy Natural State Variables Symbol Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Adiabatic Free Expansion vs Reversible Adiabatic Expansion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the First Law of Thermodynamics and Enthalpy:
   - **The First Law (Rudolf Clausius, 1850):**
     $$dU = \delta Q - \delta W = \delta Q - P dV$$
     *(Internal energy $U$ is a state function: $\oint dU = 0$ around any closed cycle, while heat $Q$ and work $W$ are path-dependent!).*
   - **Enthalpy ($H$):**
     $$H \equiv U + PV \implies dH = dU + P dV + V dP = (\delta Q - P dV) + P dV + V dP = \delta Q + V dP$$
     - At constant pressure ($dP = 0$): $dH = \delta Q_P \implies \Delta H = Q_P$.
   - **Heat Capacities for Ideal Gases:**
     $$C_V \equiv \left(\frac{\partial U}{\partial T}\right)_V = \frac{f}{2} n R, \qquad C_P \equiv \left(\frac{\partial H}{\partial T}\right)_P = C_V + n R, \qquad \gamma \equiv \frac{C_P}{C_V} = \frac{f+2}{f}$$
2. **Slide 2 (`ordering`):** Provide 5 steps deriving $\Delta H = Q_P$: (1) define enthalpy: $H = U + PV$, (2) take the total differential: $dH = dU + d(PV) = dU + P dV + V dP$, (3) substitute the First Law $dU = \delta Q - P dV$: $dH = \delta Q - P dV + P dV + V dP$, (4) cancel the boundary expansion work terms: $dH = \delta Q + V dP$, (5) impose isobaric condition $dP = 0$ and integrate to conclude $\Delta H = Q_P$!
3. **Slide 3 (`matching`):** Pair 4 ideal gas processes (Isothermal ($T=\text{const}$), Adiabatic ($Q=0$), Isochoric ($V=\text{const}$), Isobaric ($P=\text{const}$)) with their work expressions ($W = nRT\ln(V_f/V_i)$, $W = -\Delta U = -\frac{nR}{\gamma-1}\Delta T$, $W = 0$, $W = P\Delta V$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that at constant pressure, the change in enthalpy Delta H equals the heat Q exchanged by the system. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Adiabatic Free Expansion (Gay-Lussac-Joule expansion into a vacuum): An ideal gas thermally insulated from its surroundings expands into an evacuated container. What happens to its internal energy $\Delta U$ and temperature $T$? ($\Delta U = 0$ and $\Delta T = 0$; since the system is insulated, $Q = 0$; since it expands into a vacuum against zero opposing pressure, $W = 0$. By the First Law, $\Delta U = Q - W = 0 - 0 = 0$. For an ideal gas $U = U(T)$, constant internal energy implies the temperature remains unchanged).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "first_law_internal_energy_and_enthalpy",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: First Law of Thermodynamics and Enthalpy**\n• **The First Law (Energy Conservation):**\n$$\ndU = \\delta Q - \\delta W = \\delta Q - P dV\n$$\n  *(Internal energy $U$ is a path-independent state function: $\\oint dU = 0$).*\n• **Enthalpy Function ($H$):**\n$$\nH \\equiv U + PV \\implies dH = \\delta Q + V dP\n$$\n  - **At Constant Pressure ($dP = 0$):** $dH = \\delta Q_P \\implies \\Delta H = Q_P$.\n• **Ideal Gas Heat Capacities & Mayer's Relation:**\n$$\nC_V = \\left(\\frac{\\partial U}{\\partial T}\\right)_V, \\qquad C_P = \\left(\\frac{\\partial H}{\\partial T}\\right)_P, \\qquad C_P - C_V = n R\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the thermodynamic differential steps proving Delta H = Q_P at constant pressure.",
      "orderItems": [
        "State the fundamental definition of enthalpy: H = U + P * V",
        "Take the total differential using the product rule: dH = dU + P * dV + V * dP",
        "Substitute the First Law differential for internal energy: dU = delta(Q) - P * dV",
        "Cancel the mechanical boundary work terms (+P dV and -P dV): dH = delta(Q) + V * dP",
        "Impose the constant pressure condition dP = 0 and integrate to conclude: Delta(H) = Q_P"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each quasi-static ideal gas process to its mechanical work formula W.",
      "matchPairs": [
        { "left": "Isothermal Expansion (T = const)", "right": "W = n * R * T * ln(V_f / V_i) (since Delta U = 0, Q = W)" },
        { "left": "Adiabatic Expansion (Q = 0)", "right": "W = -Delta U = (P_i V_i - P_f V_f) / (gamma - 1)" },
        { "left": "Isochoric Process (V = const)", "right": "W = 0 (no mechanical volume boundary displacement)" },
        { "left": "Isobaric Expansion (P = const)", "right": "W = P * (V_f - V_i) = n * R * Delta T" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In any reversible process occurring at constant pressure, the change in enthalpy Delta H equals the total ___ absorbed by the system.",
      "blankAnswer": "heat",
      "blankDistractors": ["work", "entropy", "volume"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An ideal gas inside an insulated vessel expands freely into an adjacent evacuated chamber (Joule expansion). What are Delta U and the final temperature change Delta T?",
      "options": [
        { "text": "Delta U = 0 and Delta T = 0, because the container is thermally insulated (Q = 0) and expansion into vacuum does zero work against external pressure (W = 0), so U is unchanged; for an ideal gas U = U(T), so temperature remains constant", "isCorrect": true, "explanation": "Correct! Free expansion is irreversible. Because Q = 0 and W = 0 (no opposing force), the First Law mandates Delta U = 0. Because internal energy of an ideal gas depends solely on temperature U = n C_v T, Delta U = 0 implies Delta T = 0." },
        { "text": "Delta T drops to absolute zero", "isCorrect": false, "explanation": "Incorrect: True for reversible adiabatic expansion against a piston, but NOT free expansion into vacuum." },
        { "text": "Delta U = +100 J and gas heats up", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Internal energy is destroyed", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
