# Duofy Reusable Lesson Format: Brayton Cycle (Gas Turbines and Jet Propulsion)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Thermodynamics_and_Heat_Transfer / Thermodynamic_Cycles_Rankine_Otto_Diesel`  
**Lesson Format Type:** `brayton_gas_turbine_cycle_pressure_ratio_and_jet_propulsion`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through open-cycle and closed-cycle gas turbine systems, rotary compressors, and aviation jet propulsion thermodynamics (George Brayton 1872; Yunus A. Çengel, Michael A. Boles, Mehmet Kanoğlu *Thermodynamics: An Engineering Approach* Chapter 9; Michael J. Moran et al. *Fundamentals of Engineering Thermodynamics* Chapter 9): master the **Four Thermodynamic Processes of the Ideal Brayton Cycle**: (1) Process 1-2: Isentropic Compression in rotary compressor ($s_1 = s_2, \frac{T_2}{T_1} = r_p^{(k-1)/k}$), (2) Process 2-3: Constant-Pressure (Isobaric) Heat Addition in combustion chamber ($P_2 = P_3, q_{\text{in}} = c_p(T_3 - T_2)$), (3) Process 3-4: Isentropic Expansion in gas turbine ($s_3 = s_4, \frac{T_4}{T_3} = \frac{1}{r_p^{(k-1)/k}}$), and (4) Process 4-1: Constant-Pressure Heat Rejection ($P_4 = P_1, q_{\text{out}} = c_p(T_4 - T_1)$); derive the **Air-Standard Brayton Thermal Efficiency Formula**:
$$\mathbf{\eta_{\text{th,Brayton}} = 1 - \frac{1}{r_p^{(k - 1)/k}} \quad \left(r_p = \frac{P_2}{P_1}, \ k = \frac{c_p}{c_v} \approx 1.4\right)}$$
master the **Back Work Ratio ($\mathbf{r_{\text{bw}} = \frac{w_{\text{comp}}}{w_{\text{turb}}} = \frac{h_2 - h_1}{h_3 - h_4}}$)** (analyzing why gas turbines require $40-80\%$ of turbine work just to drive the compressor, compared to $<1-2\%$ for pumps in Rankine steam cycles), and explore **Regeneration / Recuperation, Intercooling, and Reheat** in stationary combined-cycle power plants and turbojet thrust nozzles.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Ideal Brayton Gas Turbine Cycle ($P-v$ & $T-s$ Coordinates) & Pressure Ratio Efficiency Formula Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Chronological Progression Through the 4 Gas Turbine Open Cycle Components Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Brayton Gas Turbine Component / Modification Technique & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Primary Parameter Governing the Thermal Efficiency of an Ideal Brayton Gas Turbine Is the Pressure ___ (Ratio / rp) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Gas Turbine Systems Analysis: Why Brayton Gas Turbines Exhibit an Exceptionally High Back Work Ratio Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Brayton Cycle (Çengel & Boles 2019; Brayton 1872):
   - **Brayton Efficiency Formulation:**
     $$\mathbf{\eta_{\text{th,Brayton}} = 1 - \frac{q_{\text{out}}}{q_{\text{in}}} = 1 - \frac{c_p(T_4 - T_1)}{c_p(T_3 - T_2)} = 1 - \frac{1}{r_p^{(k - 1)/k}} \quad \left(r_p = \frac{P_2}{P_1}\right)}$$
   - **Gas Turbine Cycle Process Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{State Path} & \textbf{Component} & \textbf{Thermodynamic Process} & \textbf{Energy Balance} \\
     \hline
     \mathbf{1 \to 2} & \mathbf{\text{Compressor}} & \mathbf{\text{Isentropic Compression}} & w_{\text{comp}} = c_p(T_2 - T_1) = c_p T_1 (r_p^{(k-1)/k} - 1) \\
     \mathbf{2 \to 3} & \mathbf{\text{Combustor}} & \mathbf{\text{Isobaric Heat Addition}} & \mathbf{q_{\text{in}} = c_p (T_3 - T_2) \ (P = C)} \\
     \mathbf{3 \to 4} & \mathbf{\text{Gas Turbine}} & \mathbf{\text{Isentropic Expansion}} & w_{\text{turb}} = c_p(T_3 - T_4) = c_p T_3 (1 - 1/r_p^{(k-1)/k}) \\
     \mathbf{4 \to 1} & \mathbf{\text{Exhaust / Cooler}} & \mathbf{\text{Isobaric Heat Rejection}} & \mathbf{q_{\text{out}} = c_p (T_4 - T_1) \ (P = C)} \\
     \hline
     \end{array}$$
   - **The Back Work Ratio ($r_{\text{bw}}$):**
     $$\mathbf{r_{\text{bw}} = \frac{w_{\text{comp}}}{w_{\text{turb}}} \approx 0.40 - 0.80 \ (40-80\% \text{ in gas turbines vs } 1\% \text{ in steam plants!})}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of the gas turbine cycle: (1) ambient air enters axial compressor at state 1 and is compressed isentropically to high pressure $P_2$, (2) compressed air enters combustion chamber where fuel is injected and burned at constant pressure ($P=\text{constant}$), reaching peak temperature $T_3$, (3) high-temperature gas expands isentropically through the gas turbine, driving both the compressor and the generator, (4) gas exits turbine at state 4; in turbojets, remaining enthalpy expands through an exhaust nozzle to produce forward thrust, (5) exhaust gases are discharged to atmosphere while fresh atmospheric air is continuously ingested!
3. **Slide 3 (`matching`):** Pair 4 concepts (Pressure Ratio $r_p$, Back Work Ratio $r_{\text{bw}}$, Recuperator / Regenerator, Intercooling) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Ratio. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on back work ratio in gas turbines: In power generation thermodynamics, why do Brayton gas turbine power plants have an exceptionally high Back Work Ratio ($r_{\text{bw}} = \frac{w_{\text{comp}}}{w_{\text{turb}}} \approx 40-70\%$), whereas Rankine steam power plants have a back work ratio of less than $1-2\%$? (Compressor work is proportional to the **specific volume of the working fluid ($w = \int v \, dP$)**; in a Rankine cycle, **the fluid compressed by the pump is liquid water, which has an extremely small specific volume ($v_f \approx 0.001\text{ m}^3\text{/kg}$), so pumping requires negligible work ($< 1\%$ of turbine output)**; in a Brayton gas turbine, **the fluid compressed is gaseous air, which has a massive specific volume ($v_{\text{gas}} \approx 0.8\text{ m}^3\text{/kg}$, roughly 800 times larger than water), requiring the compressor to consume over half of the entire turbine power output just to compress the working gas**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "brayton_gas_turbine_cycle_pressure_ratio_and_jet_propulsion",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Air-Standard Brayton Cycle \\& Gas Turbines (George Brayton 1872)**\n• **Brayton Thermal Efficiency Formulation:**\n$$\n\\mathbf{\\eta_{\\text{th,Brayton}} = 1 - \\frac{1}{r_p^{(k - 1)/k}} \\quad \\left(r_p = \\frac{P_2}{P_1}, \\ k = \\frac{c_p}{c_v} \\approx 1.4\\right)}\n$$\n• **Component Process Matrix:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{State Path} & \\textbf{Component} & \\textbf{Thermodynamic Process} & \\textbf{Governing Equation} \\\\\n\\hline\n\\mathbf{1 \\to 2} & \\mathbf{\\text{Compressor}} & \\text{Isentropic Compression} & w_{\\text{comp}} = c_p (T_2 - T_1) = c_p T_1 (r_p^{(k-1)/k} - 1) \\\\\n\\mathbf{2 \\to 3} & \\mathbf{\\text{Combustor}} & \\mathbf{\\text{Isobaric Heat Addition}} & \\mathbf{q_{\\text{in}} = c_p (T_3 - T_2) \\ (P = C)} \\\\\n\\mathbf{3 \\to 4} & \\mathbf{\\text{Gas Turbine}} & \\text{Isentropic Expansion} & w_{\\text{turb}} = c_p (T_3 - T_4) = c_p T_3 (1 - 1/r_p^{(k-1)/k}) \\\\\n\\mathbf{4 \\to 1} & \\mathbf{\\text{Exhaust / Cooler}} & \\text{Isobaric Heat Rejection} & \\mathbf{q_{\\text{out}} = c_p (T_4 - T_1) \\ (P = C)} \\\\\n\\hline\n\\end{array}\n$$\n• **The Back Work Ratio Invariant:** Gas turbines exhibit $\\mathbf{r_{\\text{bw}} = \\frac{w_{\\text{comp}}}{w_{\\text{turb}}} \\approx 40 - 70\\%}$ because compressing low-density gas ($w = \\int v \\, dP$) requires massive shaft work!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential thermodynamic processes comprising the flow of air through an open-cycle Brayton gas turbine engine.",
      "orderItems": [
        "Ambient air is drawn into the rotary axial compressor at state 1 and compressed isentropically to high pressure P2",
        "High-pressure air enters the combustion chamber where fuel is injected and burned continuously at constant pressure (P = C)",
        "Superheated combustion gas enters the gas turbine at state 3 and expands isentropically, producing shaft work",
        "A large fraction (40-70%) of turbine shaft power is transmitted directly back through the central shaft to drive the compressor",
        "Remaining net turbine power drives an electrical generator or expands through an exhaust nozzle producing aircraft jet thrust"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Gas Turbine Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Pressure Ratio (r_p)", "right": "r_p = P2 / P1, the primary operating parameter dictating ideal Brayton cycle efficiency" },
        { "left": "Back Work Ratio (r_bw)", "right": "Fraction of turbine work consumed by the compressor (r_bw = w_comp / w_turb)" },
        { "left": "Regenerator / Recuperator", "right": "Counterflow heat exchanger utilizing hot exhaust gas to preheat air entering the combustor" },
        { "left": "Intercooling", "right": "Cooling gas between compression stages to reduce specific volume and total compressor work" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The primary dimensionless parameter governing the thermal efficiency of an ideal Brayton gas turbine is the pressure ___.",
      "blankAnswer": "ratio",
      "blankDistractors": ["gradient", "density", "limit"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In power generation thermodynamics, why do Brayton gas turbine engines have an exceptionally high Back Work Ratio (r_bw = w_comp / w_turb = 40-70%), whereas Rankine steam power plants have a back work ratio of less than 1-2%?",
      "options": [
        { "text": "Steady-flow boundary work is proportional to the specific volume of the working fluid (w = integral v dP); in a Rankine steam cycle, the fluid compressed by the feedwater pump is liquid water, which has an extremely small specific volume (v_f = 0.001 m^3/kg), requiring negligible mechanical work (less than 1% of turbine output); in a Brayton gas turbine, the fluid compressed is gaseous air, which has a massive specific volume (v_gas = 0.8 m^3/kg, nearly 800 times larger than water), requiring the compressor to consume more than half of the total turbine shaft power just to compress the gaseous working fluid", "isCorrect": true, "explanation": "Correct! This is Yunus Çengel and Michael Moran's fundamental comparison between gas power cycles and vapor power cycles (*Thermodynamics: An Engineering Approach* Chapter 9 & 10). 1. **Steady-Flow Compression Work Integral:** $$w_{\\text{rev,in}} = \\int_1^2 v \\, dP$$ 2. **Case A: Rankine Cycle (Liquid Water):** - Incompressible liquid water has $v \\approx 0.001\\text{ m}^3\\text{/kg}$. - To pump from $10\\text{ kPa}$ to $10\\text{ MPa}$ ($1000\\times$ pressure increase): - Pump work $w_p = v \\Delta P = (0.001\\text{ m}^3\\text{/kg})(10,000\\text{ kPa} - 10\\text{ kPa}) \\approx \\mathbf{10\\text{ kJ/kg}}$. - Turbine generates $w_t \\approx 1000\\text{ kJ/kg}$. - **Back Work Ratio ($r_{\\text{bw}}$):** $\\frac{10}{1000} = \\mathbf{1.0\\%}$! 3. **Case B: Brayton Cycle (Gaseous Air):** - Gaseous air has $v \\approx 0.80\\text{ m}^3\\text{/kg}$ ($800\\times$ larger than liquid!). - Compressing that huge volume of gas requires $w_{\\text{comp}} \\approx 300-400\\text{ kJ/kg}$. - Turbine generates $w_{\\text{turb}} \\approx 600\\text{ kJ/kg}$. - **Back Work Ratio ($r_{\\text{bw}}$):** $\\frac{350}{600} \\approx \\mathbf{58\\%}$! - **Result:** Over half of the turbine power is immediately eaten by the compressor!" },
        { "text": "Because gas turbines suffer from electrical resistance in the stator", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because steam turbines do not use rotating blades", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because gas turbines run in reverse half of the time", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
