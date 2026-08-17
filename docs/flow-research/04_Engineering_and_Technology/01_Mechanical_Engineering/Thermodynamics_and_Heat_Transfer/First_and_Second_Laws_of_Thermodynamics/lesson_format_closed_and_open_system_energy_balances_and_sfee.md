# Duofy Reusable Lesson Format: Energy Conservation (Closed Systems and Steady-Flow SFEE)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Thermodynamics_and_Heat_Transfer / First_and_Second_Laws_of_Thermodynamics`  
**Lesson Format Type:** `closed_and_open_system_energy_balances_and_sfee`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the First Law of Thermodynamics, control mass vs control volume energy accounting, and the Steady-Flow Energy Equation (SFEE) across industrial thermal devices (Yunus A. Çengel, Michael A. Boles, Mehmet Kanoğlu *Thermodynamics: An Engineering Approach* Chapter 4 & 5; Michael J. Moran et al. *Fundamentals of Engineering Thermodynamics* Chapter 3 & 4): master **Closed System Energy Conservation ($\mathbf{Q - W = \Delta U = m c_v \Delta T}$)**, master the **Open System Steady-Flow Energy Equation (SFEE)**:
$$\mathbf{\dot{Q} - \dot{W}_{cv} = \dot{m}\left[\left(h_2 - h_1\right) + \frac{V_2^2 - V_1^2}{2000} + \frac{g(z_2 - z_1)}{1000}\right] \quad [\text{kW}]}$$
master engineering device simplifications: **1. Adiabatic Steam/Gas Turbine ($\mathbf{\dot{W}_T = \dot{m}(h_1 - h_2)}$)**, **2. Adiabatic Compressor / Pump ($\mathbf{\dot{W}_C = \dot{m}(h_2 - h_1)}$)**, **3. Subsonic Nozzle ($\mathbf{V_2 = \sqrt{2(h_1 - h_2) \cdot 1000 + V_1^2}}$)**, **4. Throttling Valve ($\mathbf{h_1 = h_2}$, isenthalpic expansion)**, and **5. Heat Exchanger ($\mathbf{\dot{m}_{\text{hot}}(h_{h,1} - h_{h,2}) = \dot{m}_{\text{cold}}(h_{c,2} - h_{c,1})}$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The Master Steady-Flow Energy Equation (SFEE) & Industrial Device Simplification Matrix Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Energy Balance on an Industrial Adiabatic Steam Turbine Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Thermodynamic Open Device / Boundary Assumption & Governing SFEE Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | An Adiabatic Expansion Device Designed to Convert Fluid Enthalpy into High Kinetic Velocity with Zero Work Output Is a ___ (Nozzle) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Engineering Thermodynamics Problem: Calculating Shaft Power Produced by an Adiabatic Steam Turbine Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State SFEE & First Law (Çengel & Boles 2019; Moran & Shapiro 2018):
   - **SFEE Formulation:**
     $$\mathbf{\dot{Q} - \dot{W}_{cv} = \dot{m}\left[\Delta h + \frac{\Delta V^2}{2000} + \frac{g \Delta z}{1000}\right] \quad [\text{kW}]}$$
   - **Industrial Device Simplification Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Thermal Device} & \textbf{Neglected Terms} & \textbf{Key Boundary Invariant} & \textbf{Reduced SFEE Formula} \\
     \hline
     \mathbf{\text{Turbine}} & \dot{Q} \approx 0, \ \Delta KE \approx 0, \ \Delta PE \approx 0 & \text{Adiabatic Expansion} & \mathbf{\dot{W}_T = \dot{m}(h_{\text{in}} - h_{\text{out}})} \\
     \mathbf{\text{Compressor / Pump}} & \dot{Q} \approx 0, \ \Delta KE \approx 0, \ \Delta PE \approx 0 & \text{Work Consuming} & \mathbf{\dot{W}_C = \dot{m}(h_{\text{out}} - h_{\text{in}})} \\
     \mathbf{\text{Nozzle}} & \mathbf{\dot{W} = 0}, \ \dot{Q} \approx 0, \ \Delta PE \approx 0 & \mathbf{\text{Converts } h \to KE} & \mathbf{V_{\text{out}} = \sqrt{2000(h_{\text{in}} - h_{\text{out}}) + V_{\text{in}}^2}} \\
     \mathbf{\text{Throttling Valve}} & \dot{W} = 0, \ \dot{Q} \approx 0, \ \Delta KE \approx 0 & \text{Isenthalpic Flow} & \mathbf{h_{\text{in}} = h_{\text{out}}} \\
     \hline
     \end{array}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of solving a steam turbine: (1) draw control volume boundary enclosing the turbine, (2) look up inlet enthalpy $h_1$ from steam tables using $(P_1, T_1)$, (3) look up outlet enthalpy $h_2$ using $(P_2, T_2)$ or dryness fraction $x_2$, (4) apply adiabatic SFEE equation $\dot{W}_T = \dot{m}(h_1 - h_2)$ neglecting kinetic and potential energy changes, (5) multiply by mass flow rate $\dot{m}$ to obtain the net electrical shaft power output in Megawatts ($\text{MW}$)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Turbine, Compressor, Nozzle, Throttling Valve) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Nozzle. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on steam turbine power: Superheated steam enters an adiabatic turbine at a mass flow rate of $\dot{m} = 10\text{ kg/s}$ with an inlet enthalpy of $h_1 = 3400\text{ kJ/kg}$ and leaves the turbine at an outlet enthalpy of $h_2 = 2400\text{ kJ/kg}$. Neglecting changes in kinetic and potential energy, what is the mechanical shaft power output $\dot{W}_T$ generated by the turbine? ($\dot{W}_T = \dot{m}(h_1 - h_2) = (10\text{ kg/s})(3400\text{ kJ/kg} - 2400\text{ kJ/kg}) = (10)(1000\text{ kJ/kg}) = 10,000\text{ kW} = \mathbf{10\text{ MW}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "closed_and_open_system_energy_balances_and_sfee",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Steady-Flow Energy Equation (SFEE) \\& Control Volumes (Çengel \\& Boles)**\n• **The Open Control Volume Master Formulation:**\n$$\n\\mathbf{\\dot{Q} - \\dot{W}_{cv} = \\dot{m}\\left[ (h_2 - h_1) + \\frac{V_2^2 - V_1^2}{2000} + \\frac{g(z_2 - z_1)}{1000} \\right] \\ [\\text{kW}]}\n$$\n• **Industrial Open Steady-Flow Devices Matrix:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Device Profile} & \\textbf{Physical Function} & \\textbf{Vanishing Terms} & \\textbf{Governing Reduced SFEE} \\\\\n\\hline\n\\mathbf{\\text{Adiabatic Turbine}} & \\text{Extracts fluid enthalpy as shaft work} & \\dot{Q} \\approx 0, \\ \\Delta KE \\approx 0 & \\mathbf{\\dot{W}_T = \\dot{m}(h_1 - h_2)} \\\\\n\\mathbf{\\text{Compressor / Pump}} & \\text{Consumes shaft work to raise pressure} & \\dot{Q} \\approx 0, \\ \\Delta KE \\approx 0 & \\mathbf{\\dot{W}_C = \\dot{m}(h_2 - h_1)} \\\\\n\\mathbf{\\text{Subsonic Nozzle}} & \\text{Accelerates fluid by dropping enthalpy} & \\mathbf{\\dot{W} = 0}, \\ \\dot{Q} \\approx 0 & \\mathbf{V_2 = \\sqrt{2000(h_1 - h_2) + V_1^2}} \\\\\n\\mathbf{\\text{Throttling Valve}} & \\text{Unresisted pressure drop expansion} & \\dot{W} = 0, \\ \\dot{Q} = 0 & \\mathbf{h_1 = h_2 \\text{ (Isenthalpic!)}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Closed System Balance:** For a stationary closed mass, $\\mathbf{Q - W = \\Delta U = m c_v \\Delta T}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the shaft power generated by a steady-flow adiabatic steam turbine in a thermal power plant.",
      "orderItems": [
        "Define the control volume enclosing the turbine rotor and establish steady-flow mass conservation (m_dot_in = m_dot_out)",
        "Determine the inlet specific enthalpy h1 from steam tables using inlet pressure P1 and temperature T1",
        "Determine the outlet specific enthalpy h2 using exit pressure P2 and moisture vapor quality x2",
        "Apply the adiabatic SFEE (Q_dot = 0, delta KE = 0, delta PE = 0) to obtain the specific work equation: w = h1 - h2",
        "Multiply specific work by the steam mass flow rate (W_dot = m_dot * (h1 - h2)) to obtain the total power output in Megawatts"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Steady-Flow Device to its exact Thermodynamic Signature.",
      "matchPairs": [
        { "left": "Steam Turbine", "right": "Adiabatic work-producing device converting high fluid enthalpy into shaft work (W_dot = m_dot * (h1 - h2))" },
        { "left": "Gas Compressor", "right": "Work-consuming device increasing gas pressure and temperature (W_dot = m_dot * (h2 - h1))" },
        { "left": "Supersonic / Subsonic Nozzle", "right": "Zero-work duct (W_dot = 0) converting enthalpy drop into high exit kinetic velocity" },
        { "left": "Throttling Valve (Joule-Thomson)", "right": "Flow restriction causing significant pressure drop at constant enthalpy (h1 = h2)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A zero-work steady-flow device designed to convert fluid enthalpy into high kinetic velocity is a ___.",
      "blankAnswer": "nozzle",
      "blankDistractors": ["diffuser", "turbine", "valve"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Superheated steam enters an adiabatic turbine at a mass flow rate of m_dot = 10 kg/s with enthalpy h1 = 3400 kJ/kg and leaves with enthalpy h2 = 2400 kJ/kg. Neglecting kinetic and potential energy changes, what is the power output W_dot produced by the turbine?",
      "options": [
        { "text": "W_dot = 10 MW (10,000 kW)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Steady-Flow Energy Equation (Çengel & Boles *Thermodynamics: An Engineering Approach* Chapter 5). 1. **Apply the SFEE:** $$\\dot{Q} - \\dot{W}_T = \\dot{m}\\left[ (h_2 - h_1) + \\Delta KE + \\Delta PE \\right]$$ 2. **Simplifications:** - Adiabatic turbine: $\\dot{Q} = 0$. - Neglecting kinetic and potential energy: $\\Delta KE = 0, \\Delta PE = 0$. 3. **Turbine Power Output:** $$-\\dot{W}_T = \\dot{m}(h_2 - h_1) \\implies \\dot{W}_T = \\dot{m}(h_1 - h_2)$$ $$\\dot{W}_T = (10\\text{ kg/s})(3400\\text{ kJ/kg} - 2400\\text{ kJ/kg}) = (10\\text{ kg/s})(1000\\text{ kJ/kg}) = 10,000\\text{ kW} = \\mathbf{10\\text{ MW}}$$ 4. **Physical Interpretation:** The steam gives up $1000\\text{ kJ}$ of internal thermal enthalpy for every single kilogram flowing through the turbine blades, driving the rotating electromagnetic generator!" },
        { "text": "W_dot = 58 MW", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "W_dot = 1.0 MW", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "W_dot = 24 MW", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
