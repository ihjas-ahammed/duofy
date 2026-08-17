# Duofy Reusable Lesson Format: Boundary Work (Polytropic and Isothermal Processes)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Thermodynamics_and_Heat_Transfer / First_and_Second_Laws_of_Thermodynamics`  
**Lesson Format Type:** `boundary_work_in_polytropic_and_isothermal_processes`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through moving boundary work integration, $P-v$ diagram areas, and quasi-equilibrium gas expansion paths in thermodynamics (Yunus A. Çengel, Michael A. Boles, Mehmet Kanoğlu *Thermodynamics: An Engineering Approach* Chapter 4; Michael J. Moran et al. *Fundamentals of Engineering Thermodynamics* Chapter 3): master the fundamental moving boundary work integral ($\mathbf{W_b = \int_1^2 P \, dV}$), master the complete **Taxonomy of Thermodynamic Expansion Processes**: **1. Isochoric ($V=C$): $\mathbf{W_b = 0}$**, **2. Isobaric ($P=C$): $\mathbf{W_b = P(V_2 - V_1) = m R (T_2 - T_1)}$**, **3. Isothermal Ideal Gas ($T=C, n=1$): $\mathbf{W_b = P_1 V_1 \ln\left(\frac{V_2}{V_1}\right) = m R T \ln\left(\frac{P_1}{P_2}\right)}$**, **4. General Polytropic ($P V^n = C, n \ne 1$): $\mathbf{W_b = \frac{P_2 V_2 - P_1 V_1}{1 - n} = \frac{m R(T_2 - T_1)}{1 - n}}$**, and **5. Reversible Adiabatic / Isentropic ($P V^k = C$ where $k = c_p/c_v$): $\mathbf{W_b = \frac{P_2 V_2 - P_1 V_1}{1 - k}}$**; and evaluate work areas on $P-V$ coordinate planes.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Boundary Work Integral Formula Matrix ($W_b = \int P \, dV$) Across All 5 Polytropic Exponents Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Mathematical Calculation of Boundary Work and Final Temperature for a Polytropic Gas Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Thermodynamic Process Type / Polytropic Exponent n & Boundary Work Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In a Constant-Volume Rigid Container, the Moving Boundary Work Done by an Expanding Gas Is Identically ___ (Zero / 0) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Thermodynamics Problem: Calculating Boundary Work for an Isothermal Ideal Gas Expansion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Boundary Work & Polytropic Paths (Çengel & Boles 2019; Moran & Shapiro):
   - **Boundary Work Integration Matrix:**
     $$\begin{array}{|l|c|l|l|}
     \hline
     \textbf{Thermodynamic Process} & \textbf{Exponent } n & \textbf{Path Equation } P(V) & \textbf{Boundary Work Integral } W_b = \int P \, dV \\
     \hline
     \mathbf{\text{Isochoric (Constant Volume)}} & n \to \pm \infty & V = \text{Constant} & \mathbf{W_b = 0 \text{ (Zero Area on } P-V)} \\
     \mathbf{\text{Isobaric (Constant Pressure)}} & n = 0 & P = \text{Constant} & \mathbf{W_b = P(V_2 - V_1)} \\
     \mathbf{\text{Isothermal (Ideal Gas } T=C\text{)}} & n = 1 & P V = m R T = C & \mathbf{W_b = P_1 V_1 \ln\left(\frac{V_2}{V_1}\right) = m R T \ln\left(\frac{P_1}{P_2}\right)} \\
     \mathbf{\text{General Polytropic } (P V^n = C)} & n \ne 1 & P = C V^{-n} & \mathbf{W_b = \frac{P_2 V_2 - P_1 V_1}{1 - n} = \frac{m R(T_2 - T_1)}{1 - n}} \\
     \mathbf{\text{Isentropic (Reversible Adiabatic)}} & n = k = \frac{c_p}{c_v} & P V^k = C & \mathbf{W_b = \frac{P_2 V_2 - P_1 V_1}{1 - k} = \frac{m R(T_2 - T_1)}{1 - k}} \\
     \hline
     \end{array}$$
   - **The $P-V$ Diagram Invariant:** Boundary work is **geometrically identical to the area under the process curve** on a $P-V$ coordinate diagram!
2. **Slide 2 (`ordering`):** Provide 5 steps of calculating polytropic work: (1) state initial state parameters ($P_1, V_1, T_1$) and polytropic index $n$, (2) use polytropic relation $P_1 V_1^n = P_2 V_2^n$ to solve unknown final pressure $P_2$ or final volume $V_2$, (3) determine final temperature using ideal gas law $T_2 = T_1 \left(\frac{V_1}{V_2}\right)^{n-1} = T_1 \left(\frac{P_2}{P_1}\right)^{\frac{n-1}{n}}$, (4) evaluate boundary work using $W_b = \frac{P_2 V_2 - P_1 V_1}{1 - n}$, (5) confirm work sign convention (positive for expansion work done BY the gas, negative for compression work done ON the gas)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Isochoric $W=0$, Isobaric $W=P\Delta V$, Isothermal $W=P_1V_1\ln(V_2/V_1)$, Polytropic $W=\frac{P_2V_2-P_1V_1}{1-n}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Zero (or 0). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating isothermal boundary work: An ideal gas initially at $P_1 = 300\text{ kPa} = 300 \times 10^3\text{ Pa}$ and $V_1 = 0.2\text{ m}^3$ expands isothermally ($T = \text{Constant}$) to a final volume of $V_2 = 0.4\text{ m}^3$. What is the boundary work $W_b$ done by the gas during this expansion process? ($\ln(2) \approx 0.69315$; $W_b = P_1 V_1 \ln\left(\frac{V_2}{V_1}\right) = (300\text{ kPa})(0.2\text{ m}^3) \ln\left(\frac{0.4}{0.2}\right) = (60\text{ kJ}) \ln(2) = 60 \times 0.69315 = \mathbf{41.59\text{ kJ}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "boundary_work_in_polytropic_and_isothermal_processes",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Moving Boundary Work \\& Polytropic Expansion Paths (Çengel \\& Boles)**\n• **The Master Boundary Work Formulation:**\n$$\n\\mathbf{W_b = \\int_1^2 P \\, dV \\quad (\\text{Geometrically equal to the area under the } P-V \\text{ curve!})}\n$$\n• **Thermodynamic Expansion Taxonomy Matrix:**\n$$\n\\begin{array}{|l|c|l|l|}\n\\hline\n\\textbf{Thermodynamic Path} & \\textbf{Exponent } n & \\textbf{Governing Relation} & \\textbf{Integrated Boundary Work Formula } W_b \\\\\n\\hline\n\\mathbf{\\text{Isochoric (Rigid Tank)}} & n \\to \\infty & V = \\text{Constant} & \\mathbf{W_b = 0 \\text{ (Zero moving boundary work!)}} \\\\\n\\mathbf{\\text{Isobaric (Weighted Piston)}} & n = 0 & P = \\text{Constant} & \\mathbf{W_b = P(V_2 - V_1) = m R (T_2 - T_1)} \\\\\n\\mathbf{\\text{Isothermal (Ideal Gas)}} & n = 1 & P V = C & \\mathbf{W_b = P_1 V_1 \\ln\\left(\\frac{V_2}{V_1}\\right) = m R T \\ln\\left(\\frac{P_1}{P_2}\\right)} \\\\\n\\mathbf{\\text{Polytropic Expansion}} & n \\ne 1 & P V^n = C & \\mathbf{W_b = \\frac{P_2 V_2 - P_1 V_1}{1 - n} = \\frac{m R(T_2 - T_1)}{1 - n}} \\\\\n\\mathbf{\\text{Isentropic (Adiabatic)}} & n = k = \\frac{c_p}{c_v} & P V^k = C & \\mathbf{W_b = \\frac{P_2 V_2 - P_1 V_1}{1 - k} \\quad (Q = 0)} \\\\\n\\hline\n\\end{array}\n$$\n• **Sign Convention:** $\\mathbf{W_b > 0}$ for expansion (work done BY system); $\\mathbf{W_b < 0}$ for compression (work done ON system)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the moving boundary work done during a polytropic expansion (PV^n = C) of an ideal gas.",
      "orderItems": [
        "Record initial thermodynamic state properties: pressure P1, volume V1, temperature T1, and polytropic index n",
        "Apply the polytropic relationship P1 * V1^n = P2 * V2^n to solve for the unknown final pressure P2 or final volume V2",
        "Calculate the final temperature using the ideal gas polytropic relation: T2 = T1 * (V1 / V2)^(n - 1)",
        "Substitute state variables into the polytropic work integral formula: W_b = (P2 * V2 - P1 * V1) / (1 - n)",
        "Verify that calculated work is positive for expansion (V2 > V1) or negative for compression (V2 < V1)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Thermodynamic Path to its exact Boundary Work Formula.",
      "matchPairs": [
        { "left": "Isochoric Process (n -> inf)", "right": "W_b = 0, because zero boundary displacement occurs at constant volume" },
        { "left": "Isobaric Process (n = 0)", "right": "W_b = P * (V2 - V1), representing a rectangular area on the P-V plane" },
        { "left": "Isothermal Process (n = 1)", "right": "W_b = P1 * V1 * ln(V2 / V1), representing logarithmic expansion work at constant temperature" },
        { "left": "Polytropic Process (n != 1)", "right": "W_b = (P2 * V2 - P1 * V1) / (1 - n), representing general gas expansion along PV^n = C" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a constant-volume rigid tank, the moving boundary work done by an expanding gas is identically ___.",
      "blankAnswer": "zero",
      "blankDistractors": ["maximum", "positive", "negative"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An ideal gas initially at P1 = 300 kPa and V1 = 0.2 m^3 expands isothermally (T = Constant) to a final volume of V2 = 0.4 m^3. Given that ln(2) = 0.69315, what is the boundary work W_b done by the expanding gas?",
      "options": [
        { "text": "W_b = 41.59 kJ", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the isothermal boundary work integral for an ideal gas (Çengel & Boles *Thermodynamics: An Engineering Approach* Chapter 4). 1. **Isothermal Boundary Work Formula:** For an ideal gas at constant temperature $T$: $$P V = m R T = C \\implies P = \\frac{P_1 V_1}{V}$$ $$W_b = \\int_{V_1}^{V_2} P \\, dV = P_1 V_1 \\int_{V_1}^{V_2} \\frac{dV}{V} = P_1 V_1 \\ln\\left(\\frac{V_2}{V_1}\\right)$$ 2. **Calculation:** $$W_b = (300\\text{ kPa})(0.2\\text{ m}^3) \\ln\\left(\\frac{0.4\\text{ m}^3}{0.2\\text{ m}^3}\\right) = (60\\text{ kJ}) \\ln(2)$$ $$W_b = 60 \\times 0.69315 = \\mathbf{41.59\\text{ kJ}}$$ 3. **Physical Meaning:** The gas expands and pushes the piston outward against the surroundings, doing $41.59\\text{ kJ}$ of useful mechanical work while drawing heat from a thermal bath to keep temperature constant ($Q = W_b = 41.59\\text{ kJ}$ since $\\Delta U = 0$)!" },
        { "text": "W_b = 60.00 kJ", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "W_b = 120.00 kJ", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "W_b = 0.00 kJ", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
