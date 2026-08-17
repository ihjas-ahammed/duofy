# Duofy Reusable Lesson Format: Power & Delays (Dynamic Switching & RC Elmore Models)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / VLSI_Design_and_Semiconductors / CMOS_Inverter_Physics_and_Layout`  
**Lesson Format Type:** `cmos_inverter_dynamic_switching_power_and_rc_delay_models`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the physical mechanisms of power dissipation in CMOS digital circuits (dynamic capacitive charging, short-circuit crowbar current, and static subthreshold/gate leakage), quadratic voltage scaling ($V_{DD}^2$), propagation delay metrics ($t_{pHL}, t_{pLH}, t_{pd} = \frac{t_{pHL} + t_{pLH}}{2}$), equivalent channel on-resistance models ($R_n, R_p$), and RC Elmore delay network formulations in high-performance digital VLSI (Neil Weste & David Harris *CMOS VLSI Design* Chapters 4 & 5; Jan M. Rabaey *Digital Integrated Circuits* Chapter 5): formulate the **Total CMOS Power Dissipation Equation**:
$$\mathbf{P_{\text{total}} = P_{\text{dynamic}} + P_{\text{short-circuit}} + P_{\text{static}} = \mathbf{\alpha C_L V_{DD}^2 f_{\text{clk}}} + I_{sc} V_{DD} + I_{\text{leakage}} V_{DD}}$$
where:
1. **$P_{\text{switching}} = \alpha C_L V_{DD}^2 f_{\text{clk}}$:** Dominant dynamic component charging and discharging node capacitance $C_L$ with activity factor $\alpha$;
2. **$P_{\text{static}} = I_{\text{subthreshold}} V_{DD} \propto e^{\frac{V_{gs} - V_t}{n v_T}} V_{DD}$:** Exponential leakage current through turned-off transistors;
derive the **RC Inverter Propagation Delay ($t_{pd}$)**:
$$\mathbf{t_{pHL} = \ln(2) \cdot R_n C_L \approx 0.69 R_n C_L \quad \Big| \quad \mathbf{t_{pLH} = \ln(2) \cdot R_p C_L \approx 0.69 R_p C_L}}$$
$$\mathbf{t_{pd} = \frac{t_{pHL} + t_{pLH}}{2} \approx 0.69 \left(\frac{R_n + R_p}{2}\right) C_L}$$
(proving why supply voltage reduction $V_{DD} \to V_{DD}/2$ produces an enormous **$4\times$ reduction in dynamic switching power**, balanced against the tradeoff of increased RC gate propagation delay).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Dynamic Power ($P = \alpha C_L V_{DD}^2 f$), Leakage & RC Propagation Delay ($t_{pd} = 0.69 R C_L$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Dynamic Switching Power and Static Leakage of a Processor Core Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Power Dissipation Mechanism / Delay Parameter & Technical Physical Origin Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Dynamic Switching Power in CMOS Digital Logic Scales Quadratically with the Supply ___ (Voltage / VDD) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | VLSI Chip Problem: Calculating Total Dynamic Power for a 1 Billion Transistor Processor at 2 GHz Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State CMOS Power & Delays (Weste & Harris 2011; Rabaey 2003):
   - **Power & Delay Formulations:**
     $$\mathbf{P_{\text{dyn}} = \alpha C_L V_{DD}^2 f \quad \Big| \quad P_{\text{static}} = I_{\text{leak}} V_{DD} \quad \Big| \quad t_{pd} = 0.69 R_{eq} C_L \quad \Big| \quad R_n \propto \frac{1}{\mu_n C_{ox} (W/L)_n (V_{DD}-V_t)}}$$
   - **CMOS Power Component Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Power Component} & \textbf{Physical Mechanism} & \textbf{Mathematical Formula} & \textbf{Reduction Strategy} \\
     \hline
     \mathbf{\text{Dynamic Switching}} & \text{Capacitor charging/discharging} & \mathbf{P_{\text{sw}} = \alpha C_L V_{DD}^2 f} & \mathbf{\text{Lower } V_{DD}\text{, Clock Gating } (\alpha \downarrow)} \\
     \mathbf{\text{Short-Circuit Crowbar}} & \text{Simultaneous ON during transition} & P_{sc} = I_{\text{peak}} t_{rf} V_{DD} f & \text{Match input/output edge transition times} \\
     \mathbf{\text{Subthreshold Leakage}} & \text{Weak inversion carrier diffusion} & P_{\text{sub}} \propto e^{-V_t / (n v_T)} V_{DD} & \text{Multi-threshold CMOS (MTCMOS / High-}V_t) \\
     \hline
     \end{array}$$
   - **The Quadratic Voltage Scaling Invariant:** Lowering $V_{DD}$ from $1.2\text{ V}$ to $0.8\text{ V}$ cuts dynamic power by **$55.6\%$** because power depends on the square of the voltage ($V_{DD}^2$)!
2. **Slide 2 (`ordering`):** Provide 5 steps of processor power estimation: (1) calculate total switched capacitance $C_{\text{total}} = N_{\text{gates}} \times C_{\text{gate,avg}}$, (2) determine average switching activity factor $\alpha$ across the clock domain, (3) compute dynamic capacitive switching power $P_{\text{dyn}} = \alpha C_{\text{total}} V_{DD}^2 f_{\text{clk}}$, (4) evaluate static leakage power $P_{\text{leak}} = I_{\text{leak,total}} \times V_{DD}$, (5) sum components to find total thermal design power (TDP) $P_{\text{total}} = P_{\text{dyn}} + P_{\text{leak}}$ to size chip heatsinks!
3. **Slide 3 (`matching`):** Pair 4 concepts (Dynamic Switching Power $\alpha C_L V_{DD}^2 f$, Subthreshold Leakage $I_{\text{sub}} V_{DD}$, Propagation Delay $0.69 R C_L$, Activity Factor $\alpha$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Voltage (or VDD). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating dynamic power: A microprocessor core fabricated in a $7\text{ nm}$ FinFET process operates at clock frequency $f_{\text{clk}} = 2.50\text{ GHz}$ with supply voltage $V_{DD} = 0.80\text{ V}$. The total active switched capacitance across the core is $C_L = 10.0\text{ nF} = 10.0 \times 10^{-9}\text{ F}$, and the average switching activity factor is $\alpha = 0.15$ ($15\%$). What is the dynamic switching power dissipated by the core? ($P_{\text{dyn}} = \alpha C_L V_{DD}^2 f_{\text{clk}} = (0.15) \times (10.0 \times 10^{-9}\text{ F}) \times (0.80\text{ V})^2 \times (2.50 \times 10^9\text{ Hz}) = 0.15 \times 10.0 \times 0.64 \times 2.50 = 0.15 \times 16.0 = \mathbf{2.40\text{ W}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cmos_inverter_dynamic_switching_power_and_rc_delay_models",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: CMOS Dynamic Power \\& RC Propagation Delays (Neil Weste)**\n• **Dynamic Capacitive Switching Power Formulation:**\n$$\n\\mathbf{P_{\\text{dynamic}} = \\alpha C_L V_{DD}^2 f_{\\text{clk}}}\n$$\n  - **$\\alpha$:** Switching activity factor (probability of $0 \\to 1$ transition per clock period);\n  - **$C_L$:** Total lumped load capacitance (gate, diffusion, and interconnect wires);\n  - **$V_{DD}$:** Supply voltage (governing quadratic power scaling $\\mathbf{\\propto V_{DD}^2}$!);\n• **Static Leakage Power Dissipation:**\n$$\n\\mathbf{P_{\\text{static}} = I_{\\text{leakage}} V_{DD} = \\left( I_{\\text{subthreshold}} + I_{\\text{gate}} + I_{\\text{junction}} \\right) V_{DD}}\n$$\n• **RC Propagation Delay Formulation ($50\\%$ Midpoint):**\n$$\n\\mathbf{t_{pHL} = \\ln(2) R_n C_L \\approx 0.69 R_n C_L \\quad \\Big| \\quad \\mathbf{t_{pLH} = \\ln(2) R_p C_L \\approx 0.69 R_p C_L}}\n$$\n• **The Quadratic Scaling Invariant:** Voltage scaling delivers **quadratic power savings ($P \\propto V_{DD}^2$)**, making dynamic voltage-frequency scaling (DVFS) the single most powerful thermal management tool in modern multi-core CPUs!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to estimate the total dynamic switching and leakage power dissipation of a digital VLSI microprocessor core.",
      "orderItems": [
        "Calculate the total lumped capacitive load C_total combining gate oxide, diffusion junctions, and metal interconnects",
        "Determine the average switching activity factor \u03b1 representing the probability of logic transitions per cycle",
        "Compute the dynamic capacitive charging power: P_dyn = \u03b1 * C_total * (VDD)^2 * f_clk",
        "Extract the total subthreshold and gate dielectric leakage current I_leak from semiconductor process models",
        "Compute static leakage power: P_static = I_leak * VDD and sum with dynamic power to find Total Power"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Power and Delay Mechanism to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Dynamic Switching Power", "right": "P = \u03b1*CL*VDD^2*f, energy drawn from supply to charge parasitic capacitances during logic transitions" },
        { "left": "Subthreshold Leakage Power", "right": "P = I_sub * VDD, static power dissipated by subthreshold diffusion current when transistors are turned off" },
        { "left": "Propagation Delay (tpd)", "right": "tpd = 0.69 * Req * CL, time delay measured between 50% input transition and 50% output transition" },
        { "left": "Switching Activity Factor (\u03b1)", "right": "Statistical fraction of clock cycles during which a given node undergoes a 0-to-1 power-consuming transition" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Dynamic capacitive switching power in CMOS digital logic scales quadratically with the supply ___.",
      "blankAnswer": "voltage",
      "blankDistractors": ["frequency", "capacitance", "temperature"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A high-performance CPU core operates at clock frequency f_clk = 2.50 GHz with supply voltage VDD = 0.80 V. Total switched capacitance is CL = 10.0 nF and the average switching activity factor is \u03b1 = 0.15 (15%). What is the dynamic switching power consumed by the processor core?",
      "options": [
        { "text": "P_dynamic = 2.40 W (P = 0.15 * (10.0 * 10^-9 F) * (0.80 V)^2 * (2.50 * 10^9 Hz) = 0.15 * 10.0 * 0.64 * 2.50 = 2.40 W)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the CMOS dynamic switching power formula (Neil Weste & David Harris *CMOS VLSI Design* Chapter 4). 1. **Recall the Dynamic Power Equation:** $$P_{\\text{dynamic}} = \\alpha \\cdot C_L \\cdot V_{DD}^2 \\cdot f_{\\text{clk}}$$ 2. **Substitute Given Parameters:** - Activity factor: $\\alpha = 0.15$. - Total load capacitance: $C_L = 10.0\\text{ nF} = 10.0 \\times 10^{-9}\\text{ F}$. - Supply voltage: $V_{DD} = 0.80\\text{ V} \\implies V_{DD}^2 = (0.80\\text{ V})^2 = 0.64\\text{ V}^2$. - Operating frequency: $f_{\\text{clk}} = 2.50\\text{ GHz} = 2.50 \\times 10^9\\text{ Hz}$. 3. **Multiply Factors Step-by-Step:** - Combine capacitance and frequency: $$C_L \\times f_{\\text{clk}} = (10.0 \\times 10^{-9}\\text{ F}) \\times (2.50 \\times 10^9\\text{ s}^{-1}) = 25.0\\text{ A/V}$$ - Multiply by $V_{DD}^2$: $$25.0 \\times 0.64\\text{ V}^2 = 16.0\\text{ W}$$ - Multiply by activity factor $\\alpha = 0.15$: $$P_{\\text{dynamic}} = 0.15 \\times 16.0\\text{ W} = \\mathbf{2.40\\text{ W}}$$ 4. **Energy Analysis:** Each clock cycle consumes $E = \\alpha C_L V_{DD}^2 = 0.15 \\times 10\\text{ nF} \\times 0.64\\text{ V}^2 = \\mathbf{0.96\\text{ nJ/cycle}}$! Flawless dynamic power calculation!" },
        { "text": "P_dynamic = 3.00 W (Forgot VDD^2 squaring)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "P_dynamic = 1.20 W", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "P_dynamic = 4.80 W", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
