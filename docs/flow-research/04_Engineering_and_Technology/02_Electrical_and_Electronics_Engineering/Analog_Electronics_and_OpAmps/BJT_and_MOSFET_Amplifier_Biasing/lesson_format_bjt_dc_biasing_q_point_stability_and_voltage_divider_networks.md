# Duofy Reusable Lesson Format: BJT Biasing (Voltage Dividers & Q-Point Thermal Stability)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Analog_Electronics_and_OpAmps / BJT_and_MOSFET_Amplifier_Biasing`  
**Lesson Format Type:** `bjt_dc_biasing_q_point_stability_and_voltage_divider_networks`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through Bipolar Junction Transistor (BJT) DC operating point stabilization, forward-active mode prerequisites ($V_{BE} \approx 0.7\text{ V}, \ V_{CE} > 0.2\text{ V}$), Thevenin voltage-divider biasing, emitter feedback degeneration, and $\beta$-drift immunity criteria in discrete analog design (Adel S. Sedra & Kenneth C. Smith *Microelectronic Circuits* Chapter 5; Robert L. Boylestad *Electronic Devices and Circuit Theory* Chapter 4): derive the **Thevenin Equivalent of the Voltage-Divider Bias Network**:
$$\mathbf{V_{TH} = V_{CC} \left( \frac{R_2}{R_1 + R_2} \right) \quad \Big| \quad R_{TH} = R_1 \parallel R_2 = \frac{R_1 R_2}{R_1 + R_2}}$$
formulate the **Base Loop KVL and Collector Current Equation**:
$$\mathbf{I_B = \frac{V_{TH} - V_{BE}}{R_{TH} + (\beta + 1) R_E} \implies \mathbf{I_C \approx I_E = \frac{V_{TH} - V_{BE}}{\frac{R_{TH}}{\beta + 1} + R_E}}}$$
enforce the **$\beta$-Independence Stiff Voltage Divider Criterion**:
$$\mathbf{R_{TH} \le 0.1 (\beta + 1) R_E \implies \mathbf{I_C \approx \frac{V_{TH} - 0.7\text{ V}}{R_E}}}$$
(proving that when base Thevenin resistance is less than a tenth of reflected emitter resistance, collector current becomes virtually immune to transistor $\beta$ variations and temperature drift); and calculate the **Collector-Emitter Voltage to Guarantee Forward-Active Operation**:
$$\mathbf{V_{CE} = V_{CC} - I_C (R_C + R_E) \ge 0.3\text{ V} \gg V_{CE,\text{sat}} \approx 0.2\text{ V}}$$

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Voltage-Divider BJT Bias ($V_{TH}, R_{TH}$), $\beta$-Immunity ($R_{TH} \le 0.1\beta R_E$) & Active Region ($V_{CE} > 0.2\text{V}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate the DC Quiescent Operating Point (Q-Point) Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | BJT Bias Network Component / Voltage Metric & Technical Stabilization Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | To Make the DC Collector Current Independent of Transistor Beta Variations, Base Thevenin Resistance RTH Must Be Less Than 0.1 Times Beta Times ___ (RE / Emitter Resistance) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analog Circuit Bias Problem: Calculating IC, VCE, and Active Mode Verification for a 4-Resistor Network Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State BJT Biasing & Q-Point Stability (Sedra & Smith 2020; Boylestad 2013):
   - **Voltage-Divider BJT Bias Formulations:**
     $$\mathbf{V_{TH} = V_{CC}\frac{R_2}{R_1+R_2} \quad \Big| \quad R_{TH} = R_1 \parallel R_2 \quad \Big| \quad I_C = \frac{\beta(V_{TH}-V_{BE})}{R_{TH}+(\beta+1)R_E} \quad \Big| \quad V_{CE} = V_{CC}-I_C(R_C+R_E)}$$
   - **BJT Operating Regions Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Region} & \textbf{Base-Emitter Junction } (V_{BE}) & \textbf{Collector-Base Junction } (V_{CB}) & \textbf{Circuit Application} \\
     \hline
     \mathbf{\text{Cutoff}} & \text{Reverse Biased } (V_{BE} < 0.5\text{V}) & \text{Reverse Biased } (V_{CB} > 0) & \text{Digital logic OFF state } (I_C = 0) \\
     \mathbf{\text{Forward-Active}} & \mathbf{\text{Forward Biased } (V_{BE} \approx 0.7\text{V})} & \mathbf{\text{Reverse Biased } (V_{CE} > 0.2\text{V})} & \mathbf{\text{Linear analog amplifier amplification}} \\
     \mathbf{\text{Saturation}} & \text{Forward Biased } (V_{BE} \approx 0.7\text{V}) & \text{Forward Biased } (V_{CE} = 0.2\text{V}) & \text{Digital logic ON state } (I_C < \beta I_B) \\
     \hline
     \end{array}$$
   - **The Thermal Runaway Invariant:** An emitter resistor $R_E$ provides **negative feedback**: if temperature increases $I_C$, the voltage drop $V_E = I_E R_E$ rises, reducing $V_{BE} = V_B - V_E$, which pulls $I_C$ back down, stabilizing the Q-point!
2. **Slide 2 (`ordering`):** Provide 5 steps of BJT DC bias analysis: (1) calculate Thevenin equivalent voltage $V_{TH} = V_{CC} \frac{R_2}{R_1 + R_2}$ and resistance $R_{TH} = R_1 \parallel R_2$, (2) apply KVL around base-emitter loop to solve for base current $I_B = \frac{V_{TH} - V_{BE}}{R_{TH} + (\beta + 1) R_E}$, (3) compute collector current $I_C = \beta I_B$ and emitter current $I_E = (\beta + 1) I_B$, (4) apply KVL around collector-emitter loop to compute $V_{CE} = V_{CC} - I_C R_C - I_E R_E$, (5) verify $V_{CE} > 0.2\text{ V}$ to confirm transistor is safely in forward-active mode (not saturated)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Thevenin Voltage $V_{TH}$, Stiff Bias Rule $R_{TH} \le 0.1\beta R_E$, Emitter Resistor $R_E$ Thermal Feedback, Forward-Active Criterion $V_{CE} > 0.2\text{ V}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of RE (or Emitter Resistance). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating BJT Q-point: A four-resistor voltage-divider BJT circuit has $V_{CC} = 15.0\text{ V}$, $R_1 = 30\text{ k}\Omega$, $R_2 = 15\text{ k}\Omega$, $R_C = 2.0\text{ k}\Omega$, $R_E = 1.0\text{ k}\Omega$, and $\beta = 100$ ($V_{BE} = 0.7\text{ V}$). What is the collector current $I_C$ and collector-emitter voltage $V_{CE}$? ($V_{TH} = 15 \times \frac{15}{30+15} = 5.0\text{ V}$; $R_{TH} = 30\text{ k} \parallel 15\text{ k} = 10.0\text{ k}\Omega$; $I_B = \frac{5.0 - 0.7}{10\text{ k} + (101)(1.0\text{ k})} = \frac{4.3\text{ V}}{10\text{ k} + 101\text{ k}} = \frac{4.3}{111\text{ k}\Omega} \approx 0.03874\text{ mA} = 38.74\text{ }\mu\text{A}$; $I_C = \beta I_B = 100 \times 0.03874\text{ mA} = \mathbf{3.874\text{ mA} \approx 3.87\text{ mA}}$; $I_E = 101 \times 0.03874\text{ mA} = 3.913\text{ mA}$; $V_{CE} = V_{CC} - I_C R_C - I_E R_E = 15.0 - (3.874)(2.0) - (3.913)(1.0) = 15.0 - 7.748 - 3.913 = \mathbf{3.339\text{ V} \approx 3.34\text{ V}}$; Since $V_{CE} = 3.34\text{ V} > 0.2\text{ V}$, transistor is in forward-active mode!).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "bjt_dc_biasing_q_point_stability_and_voltage_divider_networks",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: BJT Voltage-Divider Biasing \\& Q-Point Stability (Sedra \\& Smith)**\n• **Thevenin Voltage-Divider Equivalent Formulations:**\n$$\n\\mathbf{V_{TH} = V_{CC} \\left( \\frac{R_2}{R_1 + R_2} \\right) \\quad \\Big| \\quad R_{TH} = R_1 \\parallel R_2 = \\frac{R_1 R_2}{R_1 + R_2}}\n$$\n• **Base Loop KVL \\& Collector Quiescent Current:**\n$$\n\\mathbf{I_B = \\frac{V_{TH} - V_{BE}}{R_{TH} + (\\beta + 1) R_E} \\implies \\mathbf{I_C = \\beta I_B = \\frac{V_{TH} - V_{BE}}{\\frac{R_{TH}}{\\beta} + R_E \\left( \\frac{\\beta + 1}{\\beta} \\right)}}}\n$$\n• **The Stiff \\(\\beta\\)-Independence Invariant:**\n$$\n\\mathbf{R_{TH} \\le 0.1 (\\beta + 1) R_E \\implies \\mathbf{I_C \\approx I_E \\approx \\frac{V_{TH} - 0.7\\text{ V}}{R_E}}}\n$$\n• **Active Mode Forward Bias Verification:**\n$$\n\\mathbf{V_{CE} = V_{CC} - I_C R_C - I_E R_E \\ge 0.3\\text{ V} \\gg V_{CE,\\text{sat}} \\approx 0.2\\text{ V}}\n$$\n• **Negative Thermal Feedback:** The emitter resistor $R_E$ stabilizes bias against temperature: rising $I_C \\to$ increases $V_E = I_E R_E \\to$ decreases $V_{BE} = V_B - V_E \\to$ chokes back $I_C$, preventing thermal runaway!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the DC quiescent operating point (Q-point) of a 4-resistor BJT bias network.",
      "orderItems": [
        "Calculate the Thevenin equivalent open-circuit voltage: V_TH = V_CC * [R2 / (R1 + R2)]",
        "Calculate the Thevenin equivalent base resistance: R_TH = R1 || R2 = (R1 * R2) / (R1 + R2)",
        "Apply KVL around the base-emitter loop to solve for base current: I_B = (V_TH - 0.7 V) / [R_TH + (\u03b2 + 1)*R_E]",
        "Multiply base current by transistor gain to determine collector current: I_C = \u03b2 * I_B",
        "Apply KVL around the collector-emitter loop to compute V_CE = V_CC - I_C*R_C - I_E*R_E and verify V_CE > 0.2 V"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each BJT Biasing Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Thevenin Base Voltage (VTH)", "right": "VTH = VCC * R2 / (R1 + R2), open-circuit DC voltage establishing the fixed base potential" },
        { "left": "\u03b2-Immunity Criterion", "right": "RTH <= 0.1*(\u03b2+1)*RE, condition making collector current immune to transistor gain spread" },
        { "left": "Emitter Resistor (RE)", "right": "Provides negative DC series feedback to stabilize the Q-point against thermal runaway" },
        { "left": "Active Mode Bound (VCE)", "right": "VCE > 0.2 V, ensuring collector-base junction remains reverse-biased to prevent saturation" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "To make the DC collector current independent of transistor beta variations, base Thevenin resistance RTH must be less than 0.1 times beta times ___.",
      "blankAnswer": "RE",
      "blankDistractors": ["RC", "R1", "RL"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A BJT bias circuit has VCC = 15.0 V, R1 = 30 k\u03a9, R2 = 15 k\u03a9, RC = 2.0 k\u03a9, RE = 1.0 k\u03a9, and \u03b2 = 100 (VBE = 0.7 V). What is the quiescent collector current IC and collector-emitter voltage VCE?",
      "options": [
        { "text": "IC = 3.87 mA and VCE = 3.34 V (VTH = 5.0 V, RTH = 10 k\u03a9; IB = (5.0 - 0.7)/(10k + 101k) = 38.74 \u03bcA \u2192 IC = 3.874 mA; VCE = 15 - 3.874*2k - 3.913*1k = 3.34 V)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Thevenin equivalent BJT bias analysis (Adel Sedra & Kenneth Smith *Microelectronic Circuits* Chapter 5). 1. **Compute Thevenin Equivalent ($V_{TH}, R_{TH}$):** $$V_{TH} = V_{CC} \\left( \\frac{R_2}{R_1 + R_2} \\right) = 15.0\\text{ V} \\left( \\frac{15\\text{ k}\\Omega}{30\\text{ k}\\Omega + 15\\text{ k}\\Omega} \\right) = 15.0 \\times \\frac{15}{45} = \\mathbf{5.00\\text{ Volts}}$$ $$R_{TH} = R_1 \\parallel R_2 = \\frac{30\\text{ k}\\Omega \\times 15\\text{ k}\\Omega}{30\\text{ k}\\Omega + 15\\text{ k}\\Omega} = \\frac{450\\text{ k}\\Omega^2}{45\\text{ k}\\Omega} = \\mathbf{10.0\\text{ k}\\Omega}$$ 2. **Calculate Base Current ($I_B$):** $$I_B = \\frac{V_{TH} - V_{BE}}{R_{TH} + (\\beta + 1) R_E} = \\frac{5.0\\text{ V} - 0.7\\text{ V}}{10.0\\text{ k}\\Omega + (100 + 1)(1.0\\text{ k}\\Omega)} = \\frac{4.30\\text{ V}}{10\\text{ k}\\Omega + 101\\text{ k}\\Omega} = \\frac{4.30\\text{ V}}{111\\text{ k}\\Omega} \\approx \\mathbf{0.038739\\text{ mA} = 38.74\\text{ }\\mu\\text{A}}$$ 3. **Calculate Collector and Emitter Currents ($I_C, I_E$):** $$I_C = \\beta I_B = 100 \\times 0.038739\\text{ mA} = \\mathbf{3.8739\\text{ mA} \\approx 3.87\\text{ mA}}$$ $$I_E = (\\beta + 1) I_B = 101 \\times 0.038739\\text{ mA} = \\mathbf{3.9126\\text{ mA} \\approx 3.91\\text{ mA}}$$ 4. **Calculate Collector-Emitter Voltage ($V_{CE}$):** $$V_{CE} = V_{CC} - I_C R_C - I_E R_E = 15.0\\text{ V} - (3.8739\\text{ mA} \\times 2.0\\text{ k}\\Omega) - (3.9126\\text{ mA} \\times 1.0\\text{ k}\\Omega)$$ $$V_{CE} = 15.0 - 7.7478 - 3.9126 = \\mathbf{3.3396\\text{ V} \\approx 3.34\\text{ Volts}}$$ 5. **Active Mode Verification:** Since $V_{CE} = 3.34\\text{ V} > 0.2\\text{ V}$, the BJT is **strictly in the linear Forward-Active region**!" },
        { "text": "IC = 4.30 mA and VCE = 2.10 V (Assuming ideal stiff divider without base loading)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "IC = 3.87 mA and VCE = 0.15 V (Incorrectly in saturation)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "IC = 1.95 mA and VCE = 7.50 V", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
