# Duofy Reusable Lesson Format: Solar Photovoltaics (I-V Curves, MPP, & Fill Factor)

**Target Topic:** `04_Engineering_and_Technology / 09_Nuclear_and_Energy_Engineering / Renewable_Energy_Systems / Solar_Photovoltaics_and_Thermal`  
**Lesson Format Type:** `solar_cell_iv_characteristics_and_fill_factor`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the semiconductor physics and electrical characterization of photovoltaic solar cells, the current-voltage ($I$-$V$) and power-voltage ($P$-$V$) characteristic curves, **Short-Circuit Current ($I_{\text{sc}}$)**, **Open-Circuit Voltage ($V_{\text{oc}}$)**, the **Maximum Power Point (MPP, $P_{\text{mp}} = V_{\text{mp}} \cdot I_{\text{mp}}$)**, the geometric definition and analytical calculation of the **Fill Factor ($FF = \frac{P_{\text{mp}}}{V_{\text{oc}} \cdot I_{\text{sc}}} = \frac{V_{\text{mp}} I_{\text{mp}}}{V_{\text{oc}} I_{\text{sc}}}$)**, the one-diode equivalent circuit model, and the impact of solar irradiance $G$ and cell operating temperature $T_{\text{cell}}$ on the $I$-$V$ curve knee (John A. Duffie, William A. Beckman *Solar Engineering of Thermal Processes, Photovoltaics and Wind* 5th ed. Chapter 23; Martin A. Green *Solar Cells: Operating Principles, Technology, and System Applications* Chapters 4 & 5): formulate the **Fill Factor & Maximum Power Master Formulations**:
$$\mathbf{P_{\text{mp}} = V_{\text{mp}} \cdot I_{\text{mp}} \quad [\text{Watts}] \quad \Big| \quad \mathbf{FF = \frac{P_{\text{mp}}}{V_{\text{oc}} \cdot I_{\text{sc}}} = \frac{V_{\text{mp}} \cdot I_{\text{mp}}}{V_{\text{oc}} \cdot I_{\text{sc}}} \quad (0.0 < FF < 1.00)}}$$
where:
1. **$I_{\text{sc}}$:** Short-circuit current at $V = 0\text{ V}$ ($\text{Amperes}$), directly proportional to solar irradiance ($I_{\text{sc}} \propto G$);
2. **$V_{\text{oc}}$:** Open-circuit voltage at $I = 0\text{ A}$ ($\text{Volts}$), logarithmically dependent on irradiance;
3. **$V_{\text{mp}}, I_{\text{mp}}$:** Voltage and current coordinates operating at the maximum power point knee;
4. **$FF$:** Dimensionless fill factor measuring the "squareness" of the $I$-$V$ curve (typically $0.75 - 0.85$ for silicon cells);
derive the **Ideal Diode Open-Circuit Voltage Equation ($V_{\text{oc}}$)**:
$$\mathbf{V_{\text{oc}} = \frac{n k_B T}{q} \ln\left( \frac{I_{\text{sc}}}{I_0} + 1 \right) \approx n V_t \ln\left( \frac{I_{\text{sc}}}{I_0} \right) \quad \left(V_t = \frac{k_B T}{q} \approx 0.0259\text{ V at } 300\text{ K}\right)}$$
master the **Environmental Sensitivity Matrix of Solar PV Cells**:
$$\begin{array}{|l|l|l|}
\hline
\textbf{Environmental Parameter Change} & \textbf{Primary Electrical Impact on } I\text{-}V \textbf{ Curve} & \textbf{Effect on Total Power } P_{\text{mp}} \\
\hline
\mathbf{\text{Increasing Solar Irradiance } (G \uparrow)} & \mathbf{I_{\text{sc}} \text{ increases linearly } (I_{\text{sc}} \propto G); \ V_{\text{oc}} \text{ rises logarithmically}} & \mathbf{P_{\text{mp}} \text{ increases proportionally}} \\
\mathbf{\text{Increasing Cell Temperature } (T_{\text{cell}} \uparrow)} & \mathbf{V_{\text{oc}} \text{ drops heavily } (\approx -2.0 \text{ to } -2.3\text{ mV/}^\circ\text{C}); \ I_{\text{sc}} \text{ slight rise}} & \mathbf{P_{\text{mp}} \text{ drops by } -0.35\% \text{ to } -0.45\%/^\circ\text{C}} \\
\text{Increasing Series Resistance } (R_s \uparrow) & \text{Rounds the } I\text{-}V \text{ knee; reduces } I_{\text{mp}} \text{ at high current} & FF \text{ degrades; } P_{\text{mp}} \text{ decreases} \\
\text{Decreasing Shunt Resistance } (R_{\text{sh}} \downarrow) & \text{Introduces leakage slope near } I_{\text{sc}}; \text{ drops } V_{\text{oc}} & FF \text{ degrades; } P_{\text{mp}} \text{ decreases} \\
\hline
\end{array}$$
(proving that the Fill Factor quantitatively measures how closely a real solar cell approaches the theoretical maximum rectangular power box $V_{\text{oc}} \cdot I_{\text{sc}}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Solar Cell $I$-$V$ Curve, $P_{\text{mp}} = V_{\text{mp}} I_{\text{mp}}$ & Fill Factor ($FF = \frac{P_{\text{mp}}}{V_{\text{oc}} I_{\text{sc}}}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate MPP Power, Fill Factor, and Diode Open-Circuit Voltage Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Photovoltaic Curve Parameter / Operating Metric & Technical Solar Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Ratio of a Solar Cell's Maximum Power Output to the Product of Its Open-Circuit Voltage and Short-Circuit Current ($P_{\text{mp}} / [V_{\text{oc}} \cdot I_{\text{sc}}]$) Is Defined as the ___ Factor (Fill / Fill Factor) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Solar Photovoltaic Problem: Computing Maximum Power and Fill Factor for a Monocrystalline Silicon Module Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Solar Cell $I$-$V$ Characteristics & Fill Factor Mechanics (Duffie & Beckman 2020; Green 1982):
   - **Photovoltaic Formulations:**
     $$\mathbf{P_{\text{mp}} = V_{\text{mp}} I_{\text{mp}} \quad \Big| \quad FF = \frac{V_{\text{mp}} I_{\text{mp}}}{V_{\text{oc}} I_{\text{sc}}} \quad \Big| \quad V_{\text{oc}} = n V_t \ln\left( \frac{I_{\text{sc}}}{I_0} \right) \quad \Big| \quad P(V) = V \cdot I(V)}$$
   - **The $I$-$V$ Curve Invariants:**
     - Maximum Current occurs at $V = 0\text{ V} \implies I_{\text{sc}}$ (Short-Circuit Current);
     - Maximum Voltage occurs at $I = 0\text{ A} \implies V_{\text{oc}}$ (Open-Circuit Voltage);
     - Maximum Power Point (MPP) occurs at the knee where $\frac{dP}{dV} = 0 \Longleftrightarrow I + V \frac{dI}{dV} = 0$!
2. **Slide 2 (`ordering`):** Provide 5 steps of solar PV $I$-$V$ curve characterization: (1) illuminate solar cell under calibrated solar simulator at $G = 1000\text{ W/m}^2$, (2) sweep electronic load across voltage range from $0\text{ V}$ to $V_{\text{oc}}$, recording current $I(V)$, (3) extract key endpoints: short-circuit current $I_{\text{sc}}$ at $V = 0$ and open-circuit voltage $V_{\text{oc}}$ at $I = 0$, (4) identify the Maximum Power Point (MPP) where $P(V) = V \cdot I$ reaches its peak: $P_{\text{mp}} = V_{\text{mp}} \cdot I_{\text{mp}}$, (5) calculate the Fill Factor: $FF = P_{\text{mp}} / (V_{\text{oc}} \cdot I_{\text{sc}})$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Short-Circuit Current $I_{\text{sc}}$, Open-Circuit Voltage $V_{\text{oc}}$, Maximum Power Point MPP, Fill Factor FF) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Fill (or Fill Factor). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating $P_{\text{mp}}$ and $FF$ for a silicon solar PV module: A commercial monocrystalline silicon PV panel has the following measured parameters under standard illumination:
   - Open-circuit voltage: $V_{\text{oc}} = 40.0\text{ V}$;
   - Short-circuit current: $I_{\text{sc}} = 10.0\text{ A}$ (Theoretical product $V_{\text{oc}} \cdot I_{\text{sc}} = 40.0 \times 10.0 = \mathbf{400.0\text{ W}}$);
   - At the Maximum Power Point (MPP): $V_{\text{mp}} = 32.8\text{ V}$ and $I_{\text{mp}} = 9.50\text{ A}$.
   - Maximum power:
     $P_{\text{mp}} = V_{\text{mp}} \times I_{\text{mp}} = 32.8\text{ V} \times 9.50\text{ A} = \mathbf{311.60\text{ W} = 311.6\text{ W}}$;
   - Fill Factor:
     $FF = \frac{P_{\text{mp}}}{V_{\text{oc}} \cdot I_{\text{sc}}} = \frac{311.60\text{ W}}{400.0\text{ W}} = \mathbf{0.7790 = 77.90\% \approx 0.779}$;
   - What are the maximum power $P_{\text{mp}}$ and the Fill Factor $FF$? ($P_{\text{mp}} = \mathbf{311.6\text{ W}}$ and $FF = \mathbf{0.779}$ [or $77.9\%$]).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "solar_cell_iv_characteristics_and_fill_factor",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Solar Cell I-V Characteristics \\& Fill Factor (Duffie \\& Beckman)**\n• **Maximum Power Point (MPP) \\& Fill Factor Master Formulations:**\n$$\n\\mathbf{P_{\\text{mp}} = V_{\\text{mp}} \\cdot I_{\\text{mp}} \\quad [\\text{Watts}] \\quad \\Big| \\quad FF = \\frac{P_{\\text{mp}}}{V_{\\text{oc}} \\cdot I_{\\text{sc}}} = \\frac{V_{\\text{mp}} \\cdot I_{\\text{mp}}}{V_{\\text{oc}} \\cdot I_{\\text{sc}}} \\quad (0 < FF < 1.00)}\n$$\n  - **$I_{\\text{sc}}$ (Short-Circuit Current):** Maximum current at $V = 0\\text{ V}$, directly proportional to solar irradiance ($I_{\\text{sc}} \\propto G$);\n  - **$V_{\\text{oc}}$ (Open-Circuit Voltage):** Maximum voltage at $I = 0\\text{ A}$ ($\\approx n V_t \\ln(I_{\\text{sc}} / I_0)$);\n  - **$V_{\\text{mp}}, I_{\\text{mp}}$:** Voltage and current operating coordinates maximizing instantaneous electrical power ($dP/dV = 0$);\n• **The Fill Factor Invariant:** $FF$ quantifies the **geometric rectangularity / sharpness of the $I$-$V$ knee**; high series resistance ($R_s$) or low shunt resistance ($R_{\\text{sh}}$) rounds the curve, degrading $FF$ below standard commercial values ($0.78 - 0.84$)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to extract the Maximum Power Point (MPP) and calculate the Fill Factor of a photovoltaic module.",
      "orderItems": [
        "Place the PV module under calibrated 1000 W/m^2 solar simulator illumination at 25\u00b0C cell temperature",
        "Sweep an electronic load across the operating range from short circuit (0 V) to open circuit (Voc)",
        "Record the short-circuit current Isc at V = 0 V and open-circuit voltage Voc at I = 0 A",
        "Calculate the instantaneous power P(V) = V * I across the curve and locate the peak Maximum Power Point: Pmp = Vmp * Imp",
        "Compute the Fill Factor: FF = Pmp / (Voc * Isc) to assess the internal resistive health of the solar cell"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Solar PV Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Short-Circuit Current (Isc)", "right": "Maximum photogenerated current generated at zero terminal voltage directly proportional to solar irradiance G" },
        { "left": "Open-Circuit Voltage (Voc)", "right": "Maximum terminal potential difference under zero net current proportional to thermal voltage and log(Isc/I0)" },
        { "left": "Maximum Power Point (Pmp)", "right": "Operating condition on I-V curve knee (Vmp * Imp) where electrical power output is maximized" },
        { "left": "Fill Factor (FF)", "right": "Dimensionless ratio FF = Pmp / (Voc * Isc) measuring the squareness of the I-V curve" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The ratio of a solar cell's maximum power output to the product of its open-circuit voltage and short-circuit current (Pmp / [Voc * Isc]) is defined as the ___ factor.",
      "blankAnswer": "fill",
      "blankDistractors": ["loss", "gain", "power"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A monocrystalline silicon PV panel has Voc = 40.0 V and Isc = 10.0 A (Voc * Isc = 400.0 W). At the Maximum Power Point, Vmp = 32.8 V and Imp = 9.50 A. Pmp = 32.8 * 9.50 = 311.6 W. Fill Factor FF = 311.6 / 400.0 = 0.7790 (77.9%). What are the maximum power Pmp and the Fill Factor FF?",
      "options": [
        { "text": "Pmp = 311.6 W and FF = 0.779 (Pmp = 32.8 V * 9.50 A = 311.6 W; FF = 311.6 W / (40.0 V * 10.0 A) = 311.6 / 400.0 = 0.7790)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the solar PV power and Fill Factor equations (John A. Duffie & William A. Beckman *Solar Engineering of Thermal Processes, Photovoltaics and Wind* Chapter 23; Martin A. Green *Solar Cells* Chapter 5). 1. **Calculate Theoretical Bounding Power ($P_{\\text{theoretical}}$):** - Open-circuit voltage: $V_{\\text{oc}} = 40.0\\text{ V}$. - Short-circuit current: $I_{\\text{sc}} = 10.0\\text{ A}$. $$P_{\\text{theoretical}} = V_{\\text{oc}} \\times I_{\\text{sc}} = 40.0\\text{ V} \\times 10.0\\text{ A} = \\mathbf{400.0\\text{ W}}$$ 2. **Calculate Maximum Power Point ($P_{\\text{mp}}$):** - Voltage at MPP: $V_{\\text{mp}} = 32.8\\text{ V}$. - Current at MPP: $I_{\\text{mp}} = 9.50\\text{ A}$. $$P_{\\text{mp}} = V_{\\text{mp}} \\times I_{\\text{mp}} = 32.8\\text{ V} \\times 9.50\\text{ A} = \\mathbf{311.60\\text{ W} = 311.6\\text{ W}}$$ 3. **Calculate Fill Factor ($FF$):** $$FF = \\frac{P_{\\text{mp}}}{V_{\\text{oc}} \\cdot I_{\\text{sc}}} = \\frac{311.60\\text{ W}}{400.00\\text{ W}} = \\mathbf{0.7790 = 77.90\\% \\approx 0.779}$$ - Notice that $FF = 0.779$ is typical for high-quality monocrystalline silicon modules! Flawless solar PV power and Fill Factor derivation!" },
        { "text": "Pmp = 400.0 W and FF = 1.000 (Assumed ideal square I-V box with no knee curve)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Pmp = 311.6 W and FF = 1.284 (Inverted ratio: 400 / 311.6)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Pmp = 200.0 W and FF = 0.500", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
