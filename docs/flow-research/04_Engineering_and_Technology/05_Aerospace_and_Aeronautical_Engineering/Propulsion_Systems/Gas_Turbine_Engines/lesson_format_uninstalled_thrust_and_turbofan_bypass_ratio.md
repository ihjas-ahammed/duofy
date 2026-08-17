# Duofy Reusable Lesson Format: Jet Propulsion (Uninstalled Thrust & Turbofan Bypass Ratio)

**Target Topic:** `04_Engineering_and_Technology / 05_Aerospace_and_Aeronautical_Engineering / Propulsion_Systems / Gas_Turbine_Engines`  
**Lesson Format Type:** `uninstalled_thrust_and_turbofan_bypass_ratio`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the momentum theory of airbreathing jet engines, Newton's second law momentum balance across a control volume, freestream intake momentum ($\dot{m}_a u_0$), exhaust jet momentum ($\dot{m}_e u_9$), fuel mass addition ($f = \dot{m}_f / \dot{m}_a$), nozzle exit pressure thrust ($(P_9 - P_0) A_9$), uninstalled net thrust ($F_N$), the architecture of the **Turbofan Engine**, the definition of **Bypass Ratio ($\alpha = \dot{m}_{\text{bypass}} / \dot{m}_{\text{core}}$)**, core vs fan bypass stream mixing, and specific thrust ($F / \dot{m}_a$) (Jack D. Mattingly *Elements of Propulsion: Gas Turbines and Rockets* 2nd ed. Chapter 4; Saeed Farokhi *Aircraft Propulsion* Chapter 5): formulate the **Turbofan Uninstalled Net Thrust Master Formulation**:
$$\mathbf{F_N = \dot{m}_{\text{core}} \left[ (1 + f) u_{9,\text{core}} - u_0 \right] + \dot{m}_{\text{bypass}} \left[ u_{9,\text{fan}} - u_0 \right] + (P_{9,\text{core}} - P_0) A_{9,\text{core}} + (P_{9,\text{fan}} - P_0) A_{9,\text{fan}}}$$
for a fully expanded nozzle ($P_9 = P_0$) with bypass ratio $\alpha = \frac{\dot{m}_{\text{bypass}}}{\dot{m}_{\text{core}}}$ and total air mass flow $\dot{m}_a = \dot{m}_{\text{core}} (1 + \alpha)$:
$$\mathbf{F_N = \dot{m}_{\text{core}} \left[ (1 + f) u_{9,\text{core}} - u_0 \right] + \alpha \cdot \dot{m}_{\text{core}} \left[ u_{9,\text{fan}} - u_0 \right] \quad [\text{Newtons}]}$$
for a simple turbojet ($\alpha = 0, \dot{m}_{\text{core}} = \dot{m}_a$):
$$\mathbf{F_N = \dot{m}_a \left[ (1 + f) u_9 - u_0 \right] \approx \dot{m}_a \left( u_9 - u_0 \right)}$$
derive the **Specific Thrust Metric ($F_{\text{spec}}$)**:
$$\mathbf{F_{\text{spec}} = \frac{F_N}{\dot{m}_a} = \frac{F_N}{\dot{m}_{\text{core}} (1 + \alpha)} \quad \left[\frac{\text{N}\cdot\text{s}}{\text{kg}}\right]}$$
(proving that high bypass turbofans reduce jet exit velocity $u_9$, generating enormous total thrust through massive mass throughput $\dot{m}_a$ rather than high kinetic energy loss).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Uninstalled Net Thrust ($F = \dot{m}_c[(1+f)u_{9,c}-u_0] + \alpha\dot{m}_c[u_{9,f}-u_0]$) & Bypass Ratio ($\alpha$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Core Flow, Bypass Flow, Jet Thrust, and Total Net Thrust for a Turbofan Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Turbofan Thrust Entity / Propulsion Parameter & Technical Aerothermodynamic Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Bypass Ratio $\alpha$ of a Turbofan Engine Is Formally Defined as the Ratio of the Mass Flow Rate of Air Passing Through the Fan Bypass Duct to the Mass Flow Rate Passing Through the Engine ___ (Core / Engine Core) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Jet Engine Design Problem: Computing Net Thrust for a High-Bypass Commercial Turbofan Engine Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Turbofan Thrust Mechanics (Mattingly 2006; Farokhi 2014):
   - **Thrust Formulations:**
     $$\mathbf{F = \dot{m}_c[(1+f)u_{9,c} - u_0] + \alpha\dot{m}_c[u_{9,f} - u_0] \quad \Big| \quad \alpha = \frac{\dot{m}_{\text{bypass}}}{\dot{m}_{\text{core}}} \quad \Big| \quad \dot{m}_a = \dot{m}_c(1 + \alpha) \quad \Big| \quad F_{\text{spec}} = \frac{F}{\dot{m}_a}}$$
   - **Engine Architecture Comparison Matrix ($u_0 = 250\text{ m/s}$ Cruise):**
     $$\begin{array}{|l|c|c|c|l|}
     \hline
     \textbf{Engine Cycle Type} & \textbf{Bypass Ratio } \alpha & \textbf{Core Exhaust } u_{9,c} & \textbf{Fan Exhaust } u_{9,f} & \textbf{Typical Aerospace Application} \\
     \hline
     \mathbf{\text{Pure Turbojet}} & \mathbf{\alpha = 0.0} & \mathbf{\approx 800 - 1000\text{ m/s}} & \text{No fan duct} & \text{Supersonic missiles, early jet fighters} \\
     \text{Low-Bypass Turbofan} & \alpha = 0.3 - 1.5 & \approx 650 - 850\text{ m/s} & \approx 450 - 550\text{ m/s} & Military fighters (F-22, F-35 afterburning) \\
     \mathbf{\text{High-Bypass Turbofan}} & \mathbf{\alpha = 5.0 - 9.0} & \approx 450 - 550\text{ m/s} & \approx 320 - 400\text{ m/s} & Commercial airliners (A320, B777) \\
     \mathbf{\text{Ultra-High-Bypass (UHB)}} & \mathbf{\alpha = 10.0 - 14.0} & \approx 400 - 450\text{ m/s} & \mathbf{\approx 290 - 340\text{ m/s}} & \mathbf{\text{Next-gen airliners (GE9X, CFM LEAP)}} \\
     \hline
     \end{array}$$
   - **The Bypass Ratio Thrust Invariant:** Increasing bypass ratio $\alpha$ shifts the vast majority of thrust generation ($>80\%$) into the cool, quiet **fan bypass stream**, generating net thrust with minimal fuel consumption!
2. **Slide 2 (`ordering`):** Provide 5 steps of turbofan thrust calculation: (1) determine total air mass flow $\dot{m}_a$ and bypass ratio $\alpha$, (2) calculate core air mass flow $\dot{m}_{\text{core}} = \dot{m}_a / (1 + \alpha)$ and bypass flow $\dot{m}_{\text{bypass}} = \alpha \cdot \dot{m}_{\text{core}}$, (3) calculate net core momentum thrust: $F_{\text{core}} = \dot{m}_{\text{core}} [(1 + f) u_{9,\text{core}} - u_0]$, (4) calculate net fan bypass momentum thrust: $F_{\text{fan}} = \dot{m}_{\text{bypass}} (u_{9,\text{fan}} - u_0)$, (5) sum core and fan thrusts to get total uninstalled net thrust: $F_N = F_{\text{core}} + F_{\text{fan}}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Bypass Ratio $\alpha$, Core Stream Thrust, Fan Bypass Thrust, Specific Thrust) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Core (or Engine Core). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating turbofan net thrust: A commercial turbofan engine flying at cruise velocity $u_0 = 240.0\text{ m/s}$ consumes total air mass flow $\dot{m}_a = 500.0\text{ kg/s}$ with a bypass ratio $\alpha = 9.00$. Fuel-to-air ratio is $f = 0.020$. Core exhaust velocity is $u_{9,\text{core}} = 450.0\text{ m/s}$ and fan exhaust velocity is $u_{9,\text{fan}} = 340.0\text{ m/s}$ (both nozzles fully expanded).
   - Core air mass flow: $\dot{m}_{\text{core}} = \frac{\dot{m}_a}{1 + \alpha} = \frac{500.0}{1 + 9.0} = \frac{500.0}{10.0} = \mathbf{50.0\text{ kg/s}}$;
   - Bypass air mass flow: $\dot{m}_{\text{bypass}} = \alpha \cdot \dot{m}_{\text{core}} = 9.0 \times 50.0 = \mathbf{450.0\text{ kg/s}}$;
   - Core thrust contribution:
     $F_{\text{core}} = \dot{m}_{\text{core}} [(1 + f) u_{9,\text{core}} - u_0] = 50.0 \times [ (1.020 \times 450.0) - 240.0 ] = 50.0 \times [ 459.0 - 240.0 ] = 50.0 \times 219.0 = \mathbf{10,950.0\text{ N} = 10.95\text{ kN}}$;
   - Fan bypass thrust contribution:
     $F_{\text{fan}} = \dot{m}_{\text{bypass}} [ u_{9,\text{fan}} - u_0 ] = 450.0 \times [ 340.0 - 240.0 ] = 450.0 \times 100.0 = \mathbf{45,000.0\text{ N} = 45.00\text{ kN}}$;
   - Total uninstalled net thrust:
     $F_N = F_{\text{core}} + F_{\text{fan}} = 10,950.0 + 45,000.0 = \mathbf{55,950.0\text{ N} \approx 55.95\text{ kN}}$ (Fan generates $45.0 / 55.95 = \mathbf{80.4\%}$ of total thrust!);
   - What is the total net thrust $F_N$ produced by the turbofan engine? ($F_N = \mathbf{55.95\text{ kN}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "uninstalled_thrust_and_turbofan_bypass_ratio",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Turbofan Thrust \\& Bypass Ratio (Jack D. Mattingly)**\n• **Turbofan Uninstalled Net Thrust Master Formulation:**\n$$\n\\mathbf{F_N = \\dot{m}_{\\text{core}} \\left[ (1 + f) u_{9,\\text{core}} - u_0 \\right] + \\alpha \\cdot \\dot{m}_{\\text{core}} \\left[ u_{9,\\text{fan}} - u_0 \\right] \\quad [\\text{Newtons}]}\n$$\n  - **$\\alpha = \\frac{\\dot{m}_{\\text{bypass}}}{\\dot{m}_{\\text{core}}}$:** Engine Bypass Ratio ($\\approx 8 - 12$ in modern airliners);\n  - **$\\dot{m}_{\\text{core}} = \\frac{\\dot{m}_a}{1 + \\alpha}$:** Core stream air mass flow rate ($\\text{kg/s}$);\n  - **$u_0$:** Aircraft flight velocity ($\\text{m/s}$);\n  - **$u_{9,\\text{core}}, u_{9,\\text{fan}}$:** Core and fan nozzle exhaust speeds ($\\text{m/s}$);\n  - **$f = \\dot{m}_f / \\dot{m}_{\\text{core}}$:** Combustor fuel-to-air mass ratio;\n• **Specific Thrust Formulation:** $\\mathbf{F_{\\text{spec}} = \\frac{F_N}{\\dot{m}_a} = \\frac{F_N}{\\dot{m}_{\\text{core}} (1 + \\alpha)} \\quad [\\text{N}\\cdot\\text{s/kg}]}$\n• **The Fan Thrust Invariant:** In modern high-bypass turbofans ($\\alpha \\ge 9.0$), the cool, quiet **fan bypass stream generates over $80\\%$ of total aircraft thrust**, dramatically reducing kinetic energy waste in the exhaust wake!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the core flow, bypass flow, component thrusts, and total net thrust of a turbofan engine.",
      "orderItems": [
        "Extract total engine air mass flow \u1e41a, flight velocity u0, and bypass ratio \u03b1",
        "Calculate the core air mass flow: \u1e41_core = \u1e41a / (1 + \u03b1) and bypass flow: \u1e41_bypass = \u03b1 * \u1e41_core",
        "Calculate the core net thrust: F_core = \u1e41_core * [ (1 + f) * u9,core - u0 ]",
        "Calculate the fan bypass net thrust: F_fan = \u1e41_bypass * [ u9,fan - u0 ]",
        "Sum both thrust streams to calculate total uninstalled engine thrust: F_N = F_core + F_fan"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Jet Propulsion Thrust Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Bypass Ratio (\u03b1)", "right": "\u03b1 = \u1e41_bypass / \u1e41_core, primary design parameter governing turbofan fuel efficiency and acoustic signature" },
        { "left": "Fan Bypass Thrust", "right": "F_fan = \u1e41_bypass*(u9,fan - u0), thrust generated by accelerating large air mass through outer cold duct" },
        { "left": "Core Stream Thrust", "right": "F_core = \u1e41_core*[(1+f)*u9,core - u0], hot high-velocity exhaust thrust generated by core gas generator" },
        { "left": "Specific Thrust", "right": "F_N / \u1e41a, thrust produced per unit total air mass flow rate measuring core aerodynamic compactness" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The bypass ratio \u03b1 of a turbofan engine is formally defined as the ratio of the mass flow rate of air passing through the fan bypass duct to the mass flow rate passing through the engine ___.",
      "blankAnswer": "core",
      "blankDistractors": ["nozzle", "diffuser", "compressor"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A turbofan engine has total \u1e41a = 500.0 kg/s, bypass ratio \u03b1 = 9.00 (\u1e41_core = 50.0 kg/s, \u1e41_bypass = 450.0 kg/s), f = 0.020, and flight speed u0 = 240.0 m/s. Exhaust velocities are u9,core = 450.0 m/s and u9,fan = 340.0 m/s. Core thrust is F_core = 50 * [1.02*450 - 240] = 50 * 219 = 10.95 kN. Fan thrust is F_fan = 450 * [340 - 240] = 45.00 kN. What is the total net thrust F_N?",
      "options": [
        { "text": "F_N = 55.95 kN (F_N = F_core + F_fan = 10.95 kN + 45.00 kN = 55.95 kN)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the turbofan momentum thrust equations (Jack D. Mattingly *Elements of Propulsion* Chapter 4; Saeed Farokhi *Aircraft Propulsion* Chapter 5). 1. **Calculate Mass Flow Split:** - Total air mass flow: $\\dot{m}_a = 500.0\\text{ kg/s}$. - Bypass ratio: $\\alpha = 9.00$. - Core air mass flow: $$\\dot{m}_{\\text{core}} = \\frac{\\dot{m}_a}{1 + \\alpha} = \\frac{500.0\\text{ kg/s}}{1 + 9.00} = \\frac{500.0}{10.0} = \\mathbf{50.0\\text{ kg/s}}$$ - Bypass air mass flow: $$\\dot{m}_{\\text{bypass}} = \\alpha \\cdot \\dot{m}_{\\text{core}} = 9.00 \\times 50.0\\text{ kg/s} = \\mathbf{450.0\\text{ kg/s}}$$ 2. **Calculate Hot Core Net Thrust ($F_{\\text{core}}$):** - Flight speed: $u_0 = 240.0\\text{ m/s}$. - Fuel-to-air ratio: $f = 0.020 \\implies 1 + f = 1.020$. - Core exhaust speed: $u_{9,\\text{core}} = 450.0\\text{ m/s}$. $$F_{\\text{core}} = \\dot{m}_{\\text{core}} \\left[ (1 + f) u_{9,\\text{core}} - u_0 \\right]$$ $$F_{\\text{core}} = 50.0\\text{ kg/s} \\times \\left[ (1.020 \\times 450.0\\text{ m/s}) - 240.0\\text{ m/s} \\right]$$ $$F_{\\text{core}} = 50.0 \\times [ 459.0 - 240.0 ] = 50.0 \\times 219.0 = \\mathbf{10,950.0\\text{ N} = 10.95\\text{ kN}}$$ 3. **Calculate Cold Fan Bypass Thrust ($F_{\\text{fan}}$):** - Fan exhaust speed: $u_{9,\\text{fan}} = 340.0\\text{ m/s}$. $$F_{\\text{fan}} = \\dot{m}_{\\text{bypass}} \\left( u_{9,\\text{fan}} - u_0 \\right)$$ $$F_{\\text{fan}} = 450.0\\text{ kg/s} \\times (340.0\\text{ m/s} - 240.0\\text{ m/s}) = 450.0 \\times 100.0 = \\mathbf{45,000.0\\text{ N} = 45.00\\text{ kN}}$$ 4. **Calculate Total Net Thrust ($F_N$):** $$F_N = F_{\\text{core}} + F_{\\text{fan}} = 10,950.0\\text{ N} + 45,000.0\\text{ N} = \\mathbf{55,950.0\\text{ N} = 55.95\\text{ kN}}$$ - Note that the fan bypass duct produces $\\frac{45.00}{55.95} = \\mathbf{80.43\\%}$ of total aircraft thrust! Flawless turbofan uninstalled thrust derivation!" },
        { "text": "F_N = 45.00 kN (Ignored hot core thrust contribution)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "F_N = 10.95 kN (Ignored fan bypass thrust contribution)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "F_N = 111.90 kN", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
