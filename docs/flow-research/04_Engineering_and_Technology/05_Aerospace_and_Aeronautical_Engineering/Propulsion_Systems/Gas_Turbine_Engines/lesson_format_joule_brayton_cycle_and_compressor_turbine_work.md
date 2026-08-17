# Duofy Reusable Lesson Format: Gas Turbine Cycles (Joule-Brayton Thermodynamics & Work Balances)

**Target Topic:** `04_Engineering_and_Technology / 05_Aerospace_and_Aeronautical_Engineering / Propulsion_Systems / Gas_Turbine_Engines`  
**Lesson Format Type:** `joule_brayton_cycle_and_compressor_turbine_work`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the thermodynamic cycle analysis of aircraft gas turbine engines, the **Ideal & Real Joule-Brayton Cycle** on $T-s$ and $P-v$ diagrams, standard aero-station numbering ($0 \to 2 \to 3 \to 4 \to 5 \to 9$), total temperature and pressure ratios ($\tau = T_{t,\text{out}} / T_{t,\text{in}}, \pi = P_{t,\text{out}} / P_{t,\text{in}}$), compressor pressure ratio ($\pi_c$), compressor isentropic efficiency ($\eta_c$), turbine isentropic efficiency ($\eta_t$), combustor heat addition ($q_{\text{in}} = c_p (T_{t4} - T_{t3})$), mechanical transmission efficiency ($\eta_m$), and the fundamental **Compressor-Turbine Work Balance Equation** driving the turbojet shaft ($w_t = w_c / \eta_m$) (Jack D. Mattingly *Elements of Propulsion: Gas Turbines and Rockets* 2nd ed. Chapter 5; Saeed Farokhi *Aircraft Propulsion* Chapter 4): formulate the **Compressor Work Master Formulation ($w_c$)**:
$$\mathbf{w_c = c_p (T_{t3} - T_{t2}) = c_p T_{t2} \left[ \frac{\pi_c^{(\gamma-1)/\gamma} - 1}{\eta_c} \right] \quad \left[\frac{\text{kJ}}{\text{kg}}\right]}$$
where:
1. **$T_{t2}, T_{t3}$:** Total temperatures at compressor inlet and exit ($\text{K}$);
2. **$\pi_c = P_{t3} / P_{t2}$:** Compressor total pressure ratio ($\approx 25 - 45$ in modern engines);
3. **$\eta_c$:** Compressor isentropic polytropic efficiency ($\approx 0.85 - 0.90$);
4. **$\gamma, c_p$:** Specific heat ratio ($\gamma = 1.40$) and specific heat capacity ($c_p = 1.005\text{ kJ/kg}\cdot\text{K}$);
derive the **Turbine Work Balance & Temperature Drop Equation ($\Delta T_{t,\text{turb}} = T_{t4} - T_{t5}$)**:
$$\mathbf{\dot{W}_{\text{turbine}} \cdot \eta_m = \dot{W}_{\text{compressor}} \Longleftrightarrow \mathbf{T_{t4} - T_{t5} = \frac{T_{t3} - T_{t2}}{\eta_m (1 + f)}}}$$
where:
1. **$T_{t4}$:** Turbine Inlet Temperature (TIT in $\text{K}$, metallurgical barrier $\approx 1600 - 2000\text{ K}$);
2. **$T_{t5}$:** Turbine exit total temperature ($\text{K}$);
3. **$\eta_m$:** Mechanical shaft transmission efficiency ($\approx 0.98 - 0.99$);
4. **$f$:** Fuel-to-air ratio ($f = \frac{c_p (T_{t4} - T_{t3})}{\eta_b h_{\text{PR}} - c_p T_{t4}} \approx 0.015 - 0.030$);
(proving that the turbine extracts exactly the immense shaft power needed to compress incoming ambient air before high-enthalpy gas expands through the exhaust nozzle to produce thrust).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Joule-Brayton Cycle, Compressor Work ($w_c = c_p T_{t2}\frac{\pi_c^{(\gamma-1)/\gamma}-1}{\eta_c}$) & Turbine Balance ($T_{t4}-T_{t5}=\frac{T_{t3}-T_{t2}}{\eta_m(1+f)}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Compressor Exit Temperature, Fuel-to-Air Ratio, and Turbine Exit Temperature Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Gas Turbine Thermodynamic Parameter / Station Index & Technical Aero-Engine Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In a Turbojet Engine Operating at Steady State, the Power Extracted by the High-Pressure Turbine Must Exactly Equal the Mechanical Power Consumed by the Engine ___ (Compressor / Air Compressor) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Aero-Thermodynamics Problem: Calculating Compressor Exit Temperature Tt3 and Turbine Exit Temperature Tt5 Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Joule-Brayton Cycle Thermodynamics (Mattingly 2006; Farokhi 2014):
   - **Thermodynamic Formulations:**
     $$\mathbf{w_c = c_p T_{t2}\left[\frac{\pi_c^{(\gamma-1)/\gamma}-1}{\eta_c}\right] \quad \Big| \quad T_{t3} = T_{t2}\left[1 + \frac{\pi_c^{(\gamma-1)/\gamma}-1}{\eta_c}\right] \quad \Big| \quad T_{t4} - T_{t5} = \frac{T_{t3}-T_{t2}}{\eta_m(1+f)}}$$
   - **Station Numbering Standard Matrix:**
     $$\begin{array}{|c|l|l|}
     \hline
     \textbf{Station Index} & \textbf{Engine Component Location} & \textbf{Thermodynamic Process} \\
     \hline
     \mathbf{0} & \text{Freestream Ambient Air} & T_0, P_0, M_0 \ (\text{Flight state}) \\
     \mathbf{2} & \text{Diffuser Exit / Compressor Face} & \text{Isentropic ram compression } (T_{t2}, P_{t2}) \\
     \mathbf{3} & \mathbf{\text{Compressor Exit / Combustor Inlet}} & \mathbf{\text{High-pressure compression }} (T_{t3}, P_{t3} = \pi_c P_{t2}) \\
     \mathbf{4} & \mathbf{\text{Combustor Exit / Turbine Inlet (TIT)}} & \mathbf{\text{Isobaric heat addition }} (T_{t4} \text{ at peak cycle temperature}) \\
     \mathbf{5} & \mathbf{\text{Turbine Exit / Nozzle Inlet}} & \mathbf{\text{Work extraction }} (T_{t5}, P_{t5} \text{ powering compressor}) \\
     \mathbf{9} & \text{Exhaust Nozzle Throat / Exit} & \text{Isentropic expansion to generate high } u_9 \\
     \hline
     \end{array}$$
   - **The Turbine Work Balance Invariant:** The turbine operates as a **parasitic shaft driver**; it must extract exactly enough enthalpy $(\dot{m}_a + \dot{m}_f) c_p (T_{t4} - T_{t5})$ to feed the compressor power demand $\dot{m}_a c_p (T_{t3} - T_{t2})$!
2. **Slide 2 (`ordering`):** Provide 5 steps of Brayton cycle calculation: (1) extract compressor inlet temperature $T_{t2}$, compressor pressure ratio $\pi_c$, and isentropic efficiency $\eta_c$, (2) calculate compressor exit temperature: $T_{t3} = T_{t2} [ 1 + (\pi_c^{(\gamma-1)/\gamma} - 1)/\eta_c ]$, (3) determine turbine inlet temperature $T_{t4}$ (TIT) and compute fuel-to-air ratio $f = \frac{c_p(T_{t4}-T_{t3})}{\eta_b h_{\text{PR}}}$, (4) apply the turbine-compressor work balance: $\Delta T_{t,\text{turb}} = \frac{T_{t3}-T_{t2}}{\eta_m(1+f)}$, (5) calculate turbine exit temperature: $T_{t5} = T_{t4} - \Delta T_{t,\text{turb}}$ and expand to nozzle exit!
3. **Slide 3 (`matching`):** Pair 4 concepts (Compressor Ratio $\pi_c$, Turbine Inlet Temp $T_{t4}$, Shaft Work Balance $w_t = w_c$, Combustor Heat Input $q_{\text{in}}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Compressor (or Air Compressor). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating compressor and turbine temperatures: A turbojet engine has compressor inlet temperature $T_{t2} = 280.0\text{ K}$, pressure ratio $\pi_c = 16.0$ ($\gamma = 1.40 \implies \frac{\gamma-1}{\gamma} = \frac{0.40}{1.40} = 0.285714$, $\pi_c^{0.2857} = 16^{0.285714} = \mathbf{2.20824}$), and isentropic efficiency $\eta_c = 0.850$.
   - Compressor exit temperature:
     $T_{t3} = 280.0 \times \left[ 1 + \frac{2.20824 - 1}{0.850} \right] = 280.0 \times \left[ 1 + \frac{1.20824}{0.850} \right] = 280.0 \times [ 1 + 1.42146 ] = 280.0 \times 2.42146 = \mathbf{678.01\text{ K} \approx 678\text{ K}}$;
   - Compressor temperature rise: $\Delta T_{\text{comp}} = T_{t3} - T_{t2} = 678.01 - 280.0 = \mathbf{398.01\text{ K}}$;
   - Turbine inlet temperature is $T_{t4} = 1500.0\text{ K}$, fuel-to-air ratio is $f = 0.020$ ($1+f = 1.020$), and mechanical efficiency is $\eta_m = 0.980$ ($\eta_m(1+f) = 0.980 \times 1.020 = \mathbf{0.9996} \approx 1.000$);
   - Turbine temperature drop:
     $\Delta T_{\text{turb}} = T_{t4} - T_{t5} = \frac{398.01}{0.9996} = \mathbf{398.17\text{ K} \approx 398\text{ K}}$;
   - Turbine exit temperature:
     $T_{t5} = T_{t4} - \Delta T_{\text{turb}} = 1500.0 - 398.17 = \mathbf{1101.83\text{ K} \approx 1102\text{ K}}$;
   - What are the compressor exit temperature $T_{t3}$ and turbine exit temperature $T_{t5}$? ($T_{t3} = \mathbf{678\text{ K}}$ and $T_{t5} = \mathbf{1102\text{ K}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "joule_brayton_cycle_and_compressor_turbine_work",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Joule-Brayton Cycle \\& Work Balances (Jack D. Mattingly)**\n• **Compressor Thermodynamic Work Formulation ($w_c$):**\n$$\n\\mathbf{w_c = c_p (T_{t3} - T_{t2}) = c_p T_{t2} \\left[ \\frac{\\pi_c^{(\\gamma-1)/\\gamma} - 1}{\\eta_c} \\right] \\quad \\left[\\frac{\\text{kJ}}{\\text{kg}}\\right]}\n$$\n  - **$T_{t2}, T_{t3}$:** Compressor face and exit total temperatures ($\\text{K}$);\n  - **$\\pi_c = P_{t3}/P_{t2}$:** Compressor total pressure ratio;\n  - **$\\eta_c$:** Compressor isentropic efficiency ($\\approx 0.85 - 0.90$);\n• **Turbine Work Balance \\& Temperature Drop Formulation:**\n$$\n\\mathbf{T_{t4} - T_{t5} = \\frac{T_{t3} - T_{t2}}{\\eta_m (1 + f)} \\Longleftrightarrow T_{t5} = T_{t4} - \\frac{\\Delta T_{\\text{comp}}}{\\eta_m (1 + f)}}\n$$\n  - **$T_{t4}$:** Turbine Inlet Temperature (TIT, metallurgical limit $\\approx 1600 - 2000\\text{ K}$);\n  - **$T_{t5}$:** Turbine exit total temperature entering the exhaust nozzle;\n  - **$\\eta_m$:** Mechanical shaft transmission efficiency ($\\approx 0.98 - 0.99$);\n• **The Work Matching Invariant:** The turbine operates as a **parasitic shaft driver**; it must extract exactly enough enthalpy $(\\dot{m}_a + \\dot{m}_f) c_p (T_{t4} - T_{t5})$ to feed the compressor power demand $\\dot{m}_a c_p (T_{t3} - T_{t2})$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the compressor work, combustor heat addition, and turbine exit temperature of a gas turbine cycle.",
      "orderItems": [
        "Determine the compressor inlet total temperature Tt2, pressure ratio \u03c0c, and isentropic efficiency \u03b7c",
        "Calculate the compressor exit temperature: Tt3 = Tt2 * [ 1 + (\u03c0c^(\u03b3-1)/\u03b3 - 1) / \u03b7c ]",
        "Specify the maximum turbine inlet temperature Tt4 and compute fuel-to-air ratio: f = cp*(Tt4 - Tt3) / (h_PR * \u03b7b)",
        "Apply the turbine-compressor mechanical shaft power balance: \u0394T_turb = (Tt3 - Tt2) / [ \u03b7m * (1 + f) ]",
        "Calculate the turbine exit total temperature: Tt5 = Tt4 - \u0394T_turb and expand gas through the exhaust nozzle"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Gas Turbine Thermodynamic Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Compressor Ratio (\u03c0c)", "right": "Pt3 / Pt2, total pressure rise factor across multi-stage axial compressor discs" },
        { "left": "Turbine Inlet Temp (Tt4)", "right": "Peak thermodynamic cycle temperature governed by single-crystal superalloy blade metallurgy" },
        { "left": "Shaft Work Balance", "right": "\u1e41_core*cp*(Tt3-Tt2) = \u1e41_core*(1+f)*cp*(Tt4-Tt5)*\u03b7m, mechanical energy conservation between turbine and compressor" },
        { "left": "Isentropic Efficiency (\u03b7c)", "right": "(Tt3,ideal - Tt2) / (Tt3,actual - Tt2), aerodynamic performance metric penalizing internal fluid friction" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a turbojet engine operating at steady state, the power extracted by the high-pressure turbine must exactly equal the mechanical power consumed by the engine ___.",
      "blankAnswer": "compressor",
      "blankDistractors": ["nozzle", "afterburner", "diffuser"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A turbojet has Tt2 = 280.0 K, \u03c0c = 16.0 (\u03c0c^0.2857 = 2.2082), and \u03b7c = 0.850. Tt3 = 280 * [1 + 1.2082 / 0.850] = 280 * 2.4215 = 678.0 K (\u0394T_comp = 398.0 K). Maximum TIT is Tt4 = 1500.0 K with \u03b7m*(1+f) = 1.000 (\u0394T_turb = 398.0 K). What is the compressor exit temperature Tt3 and the turbine exit temperature Tt5?",
      "options": [
        { "text": "Tt3 = 678 K and Tt5 = 1102 K (Tt3 = 678.0 K; \u0394T_turb = 398.0 K \u2192 Tt5 = 1500.0 - 398.0 = 1102.0 K)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Joule-Brayton cycle compressor and turbine thermodynamic relations (Jack D. Mattingly *Elements of Propulsion* Chapter 5; Saeed Farokhi *Aircraft Propulsion* Chapter 4). 1. **Calculate Compressor Exit Total Temperature ($T_{t3}$):** - Inlet temperature: $T_{t2} = 280.0\\text{ K}$. - Pressure ratio: $\\pi_c = 16.0$. - Isentropic exponent: $\\frac{\\gamma - 1}{\\gamma} = \\frac{1.40 - 1}{1.40} = \\frac{0.40}{1.40} = \\mathbf{0.285714}$. - Isentropic pressure ratio factor: $$\\pi_c^{(\\gamma-1)/\\gamma} = 16.0^{0.285714} = \\mathbf{2.20824}$$ - Compressor isentropic efficiency: $\\eta_c = 0.850$. - Actual exit temperature: $$T_{t3} = T_{t2} \\left[ 1 + \\frac{\\pi_c^{(\\gamma-1)/\\gamma} - 1}{\\eta_c} \\right]$$ $$T_{t3} = 280.0\\text{ K} \\times \\left[ 1 + \\frac{2.20824 - 1}{0.850} \\right] = 280.0 \\times \\left[ 1 + \\frac{1.20824}{0.850} \\right]$$ $$T_{t3} = 280.0 \\times [ 1 + 1.42146 ] = 280.0 \\times 2.42146 = \\mathbf{678.01\\text{ K} \\approx 678\\text{ K}}$$ 2. **Calculate Compressor Temperature Rise ($\\Delta T_{\\text{comp}}$):** $$\\Delta T_{\\text{comp}} = T_{t3} - T_{t2} = 678.01\\text{ K} - 280.0\\text{ K} = \\mathbf{398.01\\text{ K}}$$ 3. **Calculate Turbine Exit Total Temperature ($T_{t5}$):** - Turbine Inlet Temperature: $T_{t4} = 1500.0\\text{ K}$. - Shaft power balance: $\\Delta T_{\\text{turb}} = \\frac{\\Delta T_{\\text{comp}}}{\\eta_m (1 + f)} = \\frac{398.01\\text{ K}}{1.000} = \\mathbf{398.01\\text{ K}}$. - Turbine exit temperature: $$T_{t5} = T_{t4} - \\Delta T_{\\text{turb}} = 1500.0\\text{ K} - 398.01\\text{ K} = \\mathbf{1101.99\\text{ K} \\approx 1102\\text{ K}}$$ Flawless Joule-Brayton cycle compressor and turbine temperature derivation!" },
        { "text": "Tt3 = 618 K and Tt5 = 1162 K (Used ideal isentropic compressor without efficiency)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Tt3 = 678 K and Tt5 = 1500 K (Forgot turbine enthalpy extraction)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Tt3 = 850 K and Tt5 = 950 K", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
