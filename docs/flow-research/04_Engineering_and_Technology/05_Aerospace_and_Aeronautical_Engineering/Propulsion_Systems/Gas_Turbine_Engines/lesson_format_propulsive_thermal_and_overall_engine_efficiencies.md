# Duofy Reusable Lesson Format: Jet Efficiencies (Propulsive, Thermal, & Overall Triad)

**Target Topic:** `04_Engineering_and_Technology / 05_Aerospace_and_Aeronautical_Engineering / Propulsion_Systems / Gas_Turbine_Engines`  
**Lesson Format Type:** `propulsive_thermal_and_overall_engine_efficiencies`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the energy conversions in airbreathing jet engines, the rate of fuel chemical energy release ($\dot{Q}_{\text{in}} = \dot{m}_f h_{\text{PR}}$), the rate of kinetic energy addition to the working fluid ($\Delta \dot{K}E = \frac{1}{2} \dot{m}_a (u_9^2 - u_0^2)$), the useful propulsive thrust power ($P_{\text{thrust}} = F \cdot u_0$), the classical **Engine Efficiency Triad**: **Thermal Efficiency ($\eta_{\text{th}}$)**, **Propulsive Efficiency ($\eta_p$)**, and **Overall Efficiency ($\eta_o = \eta_{\text{th}} \cdot \eta_p$)**, and the physical proof of why high-bypass turbofans maximize propulsive efficiency (Jack D. Mattingly *Elements of Propulsion: Gas Turbines and Rockets* 2nd ed. Chapter 4; Nicholas Cumpsty *Jet Propulsion* Chapter 2): formulate the **Propulsive Efficiency Master Formulation ($\eta_p$)**:
$$\mathbf{\eta_p = \frac{\text{Useful Thrust Power}}{\text{Rate of Added Kinetic Energy}} = \frac{F \cdot u_0}{\frac{1}{2} \dot{m}_a \left( u_9^2 - u_0^2 \right)} = \frac{\dot{m}_a (u_9 - u_0) u_0}{\frac{1}{2} \dot{m}_a (u_9 - u_0)(u_9 + u_0)} = \frac{2 u_0}{u_9 + u_0} = \frac{2}{1 + \frac{u_9}{u_0}}}$$
where:
1. **$u_0$:** Aircraft forward flight speed ($\text{m/s}$);
2. **$u_9$:** Average exhaust jet exit velocity ($\text{m/s}$);
3. **$\frac{u_9}{u_0}$:** Jet velocity ratio ($\ge 1.0$);
formulate the **Thermal Efficiency ($\eta_{\text{th}}$)** & **Overall Efficiency ($\eta_o$)**:
$$\mathbf{\eta_{\text{th}} = \frac{\Delta \dot{K}E}{\dot{Q}_{\text{in}}} = \frac{\frac{1}{2} \dot{m}_a \left( u_9^2 - u_0^2 \right)}{\dot{m}_f h_{\text{PR}}} \quad \Big| \quad \mathbf{\eta_o = \eta_{\text{th}} \cdot \eta_p = \frac{F \cdot u_0}{\dot{m}_f h_{\text{PR}}}}}$$
where:
1. **$h_{\text{PR}}$:** Fuel lower heating value ($h_{\text{PR}} \approx 43.0\text{ MJ/kg}$ for Jet-A kerosene);
2. **$\dot{m}_f$:** Fuel mass flow rate ($\text{kg/s}$);
(proving that maximum propulsive efficiency $\eta_p \to 1.0$ is achieved when $u_9 \to u_0$, meaning the engine leaves behind stationary exhaust gas with zero wasted wake kinetic energy).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Efficiency Triad ($\eta_p = \frac{2u_0}{u_9+u_0}, \eta_{\text{th}} = \frac{\Delta KE}{\dot{Q}_{\text{in}}}, \eta_o = \eta_{\text{th}}\eta_p$) & Wake Losses Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Propulsive, Thermal, and Overall Efficiencies of a Jet Engine Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Jet Engine Efficiency Entity / Energy Flow Construct & Technical Thermodynamic Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Propulsive Efficiency $\eta_p$ of an Airbreathing Jet Engine Reaches its Theoretical Maximum of 100% When the Exhaust Jet Velocity $u_9$ Equals the Aircraft Flight Velocity ___ (u_0 / u0 / Forward Speed) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Propulsion Performance Problem: Computing Propulsive, Thermal, and Overall Efficiencies for a Cruise Turbofan Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Jet Engine Efficiency Mechanics (Mattingly 2006; Cumpsty 2015):
   - **Efficiency Formulations:**
     $$\mathbf{\eta_p = \frac{2 u_0}{u_9 + u_0} \quad \Big| \quad \eta_{\text{th}} = \frac{\dot{m}_a(u_9^2 - u_0^2)}{2 \dot{m}_f h_{\text{PR}}} \quad \Big| \quad \eta_o = \eta_{\text{th}} \cdot \eta_p = \frac{F \cdot u_0}{\dot{m}_f h_{\text{PR}}} \quad \Big| \quad TSFC = \frac{u_0}{\eta_o h_{\text{PR}}}}$$
   - **Efficiencies Comparison Matrix ($u_0 = 250\text{ m/s}$):**
     $$\begin{array}{|l|c|c|c|l|}
     \hline
     \textbf{Engine Architecture} & \textbf{Jet Speed } u_9 & \textbf{Propulsive } \eta_p & \textbf{Thermal } \eta_{\text{th}} & \textbf{Overall Efficiency } \eta_o \\
     \hline
     \mathbf{\text{Pure Turbojet (Concorde)}} & \mathbf{900\text{ m/s}} & \mathbf{\frac{2(250)}{900+250} = 43.5\%} & \approx 50.0\% & \mathbf{\eta_o \approx 21.8\% \ (\text{High wake energy loss})} \\
     \text{Low-Bypass Turbofan} & 600\text{ m/s} & \frac{2(250)}{600+250} = 58.8\% & \approx 52.0\% & \eta_o \approx 30.6\% \\
     \mathbf{\text{High-Bypass Turbofan (B787)}} & \mathbf{350\text{ m/s}} & \mathbf{\frac{2(250)}{350+250} = 83.3\%} & \mathbf{\approx 55.0\%} & \mathbf{\eta_o \approx 45.8\% \ (\text{State of the Art!})} \\
     \hline
     \end{array}$$
   - **The Wake Energy Loss Invariant:** The kinetic energy wasted in the atmosphere scales as **$\dot{m}_a (u_9 - u_0)^2 / 2$**; shrinking $(u_9 - u_0)$ through high bypass ratios maximizes propulsive efficiency $\eta_p$!
2. **Slide 2 (`ordering`):** Provide 5 steps of efficiency calculation: (1) extract flight velocity $u_0$, exhaust velocity $u_9$, air mass flow $\dot{m}_a$, fuel mass flow $\dot{m}_f$, and fuel heating value $h_{\text{PR}}$, (2) calculate propulsive efficiency: $\eta_p = \frac{2 u_0}{u_9 + u_0}$, (3) calculate rate of kinetic energy addition: $\Delta \dot{K}E = \frac{1}{2}\dot{m}_a (u_9^2 - u_0^2)$, (4) calculate thermal efficiency: $\eta_{\text{th}} = \Delta \dot{K}E / (\dot{m}_f h_{\text{PR}})$, (5) multiply to calculate overall engine efficiency: $\eta_o = \eta_{\text{th}} \cdot \eta_p = (F \cdot u_0) / (\dot{m}_f h_{\text{PR}})$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Propulsive Efficiency $\eta_p$, Thermal Efficiency $\eta_{\text{th}}$, Overall Efficiency $\eta_o$, Fuel Chemical Power $\dot{Q}_{\text{in}}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of u_0 (or u0 / Forward Speed). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating engine efficiencies: An airliner turbofan cruises at $u_0 = 250.0\text{ m/s}$ with an effective mixed jet exhaust velocity of $u_9 = 350.0\text{ m/s}$. The engine produces net thrust $F = 50.0\text{ kN} = 50,000.0\text{ N}$ while burning fuel at $\dot{m}_f = 0.650\text{ kg/s}$ (Fuel heating value $h_{\text{PR}} = 43.0\text{ MJ/kg} = 43.0 \times 10^6\text{ J/kg}$).
   - Propulsive efficiency:
     $\eta_p = \frac{2 u_0}{u_9 + u_0} = \frac{2 \times 250.0}{350.0 + 250.0} = \frac{500.0}{600.0} = \mathbf{0.8333 = 83.33\%}$;
   - Useful thrust power:
     $P_{\text{thrust}} = F \cdot u_0 = 50,000.0\text{ N} \times 250.0\text{ m/s} = \mathbf{12.50 \times 10^6\text{ W} = 12.50\text{ MW}}$;
   - Fuel chemical thermal power:
     $\dot{Q}_{\text{in}} = \dot{m}_f h_{\text{PR}} = 0.650\text{ kg/s} \times 43.0 \times 10^6\text{ J/kg} = \mathbf{27.95 \times 10^6\text{ W} = 27.95\text{ MW}}$;
   - Overall efficiency:
     $\eta_o = \frac{P_{\text{thrust}}}{\dot{Q}_{\text{in}}} = \frac{12.50\text{ MW}}{27.95\text{ MW}} = \mathbf{0.4472 = 44.72\% \approx 44.7\%}$;
   - Thermal efficiency:
     $\eta_{\text{th}} = \frac{\eta_o}{\eta_p} = \frac{0.4472}{0.8333} = \mathbf{0.5367 = 53.67\% \approx 53.7\%}$;
   - What are the propulsive efficiency $\eta_p$ and overall efficiency $\eta_o$? ($\eta_p = \mathbf{83.3\%}$ and $\eta_o = \mathbf{44.7\%}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "propulsive_thermal_and_overall_engine_efficiencies",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Aircraft Jet Engine Efficiencies Triad (Jack D. Mattingly)**\n• **Propulsive Efficiency Master Formulation ($\\eta_p$):**\n$$\n\\mathbf{\\eta_p = \\frac{\\text{Useful Propulsive Power}}{\\text{Rate of Added Kinetic Energy}} = \\frac{2 u_0}{u_9 + u_0} = \\frac{2}{1 + \\frac{u_9}{u_0}}}\n$$\n  - **$u_0$:** Aircraft flight speed ($\\text{m/s}$);\n  - **$u_9$:** Jet exhaust velocity ($\\text{m/s}$);\n  - As $u_9 \\to u_0 \\implies \\eta_p \\to 1.00$ ($100\\%$ efficient energy transfer);\n• **Thermal ($\\eta_{\\text{th}}$) \\& Overall ($\\eta_o$) Efficiencies:**\n$$\n\\mathbf{\\eta_{\\text{th}} = \\frac{\\frac{1}{2} \\dot{m}_a (u_9^2 - u_0^2)}{\\dot{m}_f h_{\\text{PR}}}} \\quad \\Big| \\quad \\mathbf{\\eta_o = \\eta_{\\text{th}} \\cdot \\eta_p = \\frac{F \\cdot u_0}{\\dot{m}_f h_{\\text{PR}}}}\n$$\n• **The Wake Loss Invariant:** Unused kinetic energy dumped into the atmosphere scales as **$\\dot{m}_a (u_9 - u_0)^2 / 2$**; accelerating a giant mass of air by a small velocity increment (high bypass) minimizes wake loss and maximizes propulsive efficiency $\\eta_p$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the complete efficiency triad (propulsive, thermal, and overall) for a jet engine in cruise flight.",
      "orderItems": [
        "Extract flight speed u0, exhaust speed u9, net thrust F, fuel burn rate \u1e41f, and fuel lower heating value h_PR",
        "Calculate the propulsive efficiency directly from flight and exhaust velocities: \u03b7_p = 2*u0 / (u9 + u0)",
        "Calculate the useful mechanical propulsive thrust power: P_thrust = F * u0",
        "Calculate the total chemical thermal heat release rate of the consumed fuel: Q_in = \u1e41f * h_PR",
        "Calculate the overall efficiency \u03b7_o = P_thrust / Q_in and extract thermodynamic thermal efficiency: \u03b7_th = \u03b7_o / \u03b7_p"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Propulsion Efficiency Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Propulsive Efficiency (\u03b7_p)", "right": "\u03b7_p = 2u0 / (u9 + u0), fraction of jet kinetic energy converted into useful aircraft forward thrust power" },
        { "left": "Thermal Efficiency (\u03b7_th)", "right": "\u03b7_th = \u0394KE / Q_in, thermodynamic efficiency converting fuel chemical combustion heat into kinetic energy" },
        { "left": "Overall Efficiency (\u03b7_o)", "right": "\u03b7_o = \u03b7_th * \u03b7_p = (F*u0) / (\u1e41f*h_PR), ultimate fuel-to-flight power efficiency governing aircraft range" },
        { "left": "Wasted Wake Energy", "right": "0.5*\u1e41a*(u9 - u0)^2, kinetic energy loss dissipated as heat and turbulence in the atmosphere" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The propulsive efficiency \u03b7_p of an airbreathing jet engine reaches its theoretical maximum of 100% when the exhaust jet velocity u9 equals the aircraft flight velocity ___.",
      "blankAnswer": "u_0",
      "blankDistractors": ["0", "c", "v_esc"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A turbofan cruises at u0 = 250.0 m/s with exhaust u9 = 350.0 m/s. It produces F = 50.0 kN with fuel burn \u1e41f = 0.650 kg/s (h_PR = 43.0 MJ/kg \u2192 Q_in = 27.95 MW). P_thrust = 50 kN * 250 m/s = 12.50 MW. \u03b7_p = 2*250 / (350+250) = 500/600 = 83.3%. Overall efficiency is \u03b7_o = 12.50 MW / 27.95 MW = 44.7%. What are the propulsive efficiency \u03b7_p and overall efficiency \u03b7_o?",
      "options": [
        { "text": "\u03b7_p = 83.3% and \u03b7_o = 44.7% (\u03b7_p = 500 / 600 = 0.8333 = 83.3%; \u03b7_o = 12.50 MW / 27.95 MW = 0.4472 = 44.7%)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the jet engine efficiency triad equations (Jack D. Mattingly *Elements of Propulsion* Chapter 4; Nicholas Cumpsty *Jet Propulsion* Chapter 2). 1. **Calculate Propulsive Efficiency ($\\eta_p$):** - Flight speed: $u_0 = 250.0\\text{ m/s}$. - Exhaust velocity: $u_9 = 350.0\\text{ m/s}$. - Formula: $$\\eta_p = \\frac{2 u_0}{u_9 + u_0} = \\frac{2 \\times 250.0\\text{ m/s}}{350.0\\text{ m/s} + 250.0\\text{ m/s}} = \\frac{500.0}{600.0} = \\mathbf{0.83333 = 83.33\\% \\approx 83.3\\%}$$ 2. **Calculate Useful Thrust Power ($P_{\\text{thrust}}$):** - Net thrust: $F = 50.0\\text{ kN} = 50,000.0\\text{ N}$. $$P_{\\text{thrust}} = F \\cdot u_0 = 50,000.0\\text{ N} \\times 250.0\\text{ m/s} = 12,500,000.0\\text{ W} = \\mathbf{12.50\\text{ MW}}$$ 3. **Calculate Fuel Chemical Thermal Power Input ($\\dot{Q}_{\\text{in}}$):** - Fuel flow rate: $\\dot{m}_f = 0.650\\text{ kg/s}$. - Fuel lower heating value: $h_{\\text{PR}} = 43.0\\text{ MJ/kg} = 43.0 \\times 10^6\\text{ J/kg}$. $$\\dot{Q}_{\\text{in}} = \\dot{m}_f \\cdot h_{\\text{PR}} = 0.650\\text{ kg/s} \\times 43.0 \\times 10^6\\text{ J/kg} = 27,950,000.0\\text{ W} = \\mathbf{27.95\\text{ MW}}$$ 4. **Calculate Overall Engine Efficiency ($\\eta_o$):** $$\\eta_o = \\frac{P_{\\text{thrust}}}{\\dot{Q}_{\\text{in}}} = \\frac{12.50\\text{ MW}}{27.95\\text{ MW}} = \\mathbf{0.44723 = 44.72\\% \\approx 44.7\\%}$$ - And resulting thermal cycle efficiency: $$\\eta_{\\text{th}} = \\frac{\\eta_o}{\\eta_p} = \\frac{0.44723}{0.83333} = \\mathbf{0.53667 = 53.67\\%}$$ Flawless propulsive and overall engine efficiency derivation!" },
        { "text": "\u03b7_p = 50.0% and \u03b7_o = 25.0%", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03b7_p = 83.3% and \u03b7_o = 53.7% (Reported thermal efficiency instead of overall efficiency)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03b7_p = 95.0% and \u03b7_o = 60.0%", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
