# Duofy Reusable Lesson Format: Power Optimization (Maximum Power Transfer & AC Conjugate Matching)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Electric_Circuits_and_Network_Theory / Network_Theorems_Thevenin_Norton_Superposition`  
**Lesson Format Type:** `maximum_power_transfer_theorem_dc_and_ac_conjugate_matching`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through load impedance matching, power transfer calculus, and the Maximum Power Transfer Theorem (MPTT) across both DC and AC sinusoidal steady-state networks (Charles K. Alexander & Matthew N.O. Sadiku *Fundamentals of Electric Circuits* Chapters 4 & 11; James W. Nilsson & Susan A. Riedel *Electric Circuits* Chapters 4 & 10): derive the **DC Maximum Power Transfer Formulation**:
$$\mathbf{P_L(R_L) = i_L^2 R_L = \left(\frac{V_{th}}{R_{th} + R_L}\right)^2 R_L \implies \frac{dP_L}{dR_L} = 0 \Longleftrightarrow \mathbf{R_L = R_{th}}}$$
where peak power transferred into the load is:
$$\mathbf{P_{\text{max}} = \frac{V_{th}^2}{4 R_{th}} \quad \Big| \quad \mathbf{\text{Energy Efficiency } \eta = \frac{P_L}{P_{\text{total}}} = \frac{i^2 R_L}{i^2(R_{th} + R_L)} = 50\%}}$$
(analyzing why MPTT is vital in communications/RF signal transmission where signal power is scarce, but avoided in heavy power grid transmission where $50\%$ heat loss in source resistance would melt generators); and derive the **AC Complex Conjugate Matching Theorem**:
$$\mathbf{Z_L = Z_{th}^* = R_{th} - j X_{th} \implies \mathbf{P_{\text{max}} = \frac{|V_{th}|^2}{8 R_{th}} \ (\text{Peak}) = \frac{V_{\text{rms}}^2}{4 R_{th}}}}$$
(proving that setting load reactance $X_L = -X_{th}$ creates internal series resonance, canceling source reactance).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | DC MPTT ($R_L = R_{th}, P_{\text{max}} = \frac{V_{th}^2}{4R_{th}}$) & AC Conjugate Matching ($Z_L = Z_{th}^*$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of Optimal Load Resistance and Maximum Power Transfer Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Power Matching Condition / Domain Metric & Technical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In DC Circuits, the Power Transfer Efficiency at the Condition of Maximum Power Transfer Is Strictly ___ Percent (50 / Fifty) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | RF & Power Matching Problem: Sizing a Load Resistor and Calculating Maximum Dissipated Power Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Maximum Power Transfer (Alexander & Sadiku 2021; Nilsson 2020):
   - **DC & AC Matching Formulations:**
     $$\mathbf{R_L = R_{th} \implies P_{\text{max}} = \frac{V_{th}^2}{4 R_{th}} \quad \Big| \quad \mathbf{Z_L = Z_{th}^* = R_{th} - j X_{th} \implies P_{\text{max}} = \frac{V_{\text{rms}}^2}{4 R_{th}}}}$$
   - **Matching Condition Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Circuit Domain} & \textbf{Source Impedance } Z_{th} & \textbf{Optimal Load Condition } Z_L & \textbf{Max Load Power } P_{\text{max}} \\
     \hline
     \mathbf{\text{DC Resistive}} & R_{th} & \mathbf{R_L = R_{th}} & \mathbf{P_{\text{max}} = \frac{V_{th}^2}{4 R_{th}}} \\
     \mathbf{\text{AC General (R+jX)}} & R_{th} + j X_{th} & \mathbf{Z_L = R_{th} - j X_{th} \ (Z_{th}^*)} & \mathbf{P_{\text{max}} = \frac{V_{\text{rms}}^2}{4 R_{th}}} \\
     \mathbf{\text{AC Pure Resistive Load}} & R_{th} + j X_{th} & \mathbf{R_L = |Z_{th}| = \sqrt{R_{th}^2 + X_{th}^2}} & P_{\text{max}} = \frac{V_{\text{rms}}^2 R_L}{2(R_{th} + R_L)^2} \\
     \hline
     \end{array}$$
   - **The 50% Efficiency Invariant:** At maximum power transfer, exactly **$50\%$ of generated energy is delivered to the load, while $50\%$ is dissipated as heat inside source $R_{th}$**!
2. **Slide 2 (`ordering`):** Provide 5 steps of maximum power transfer analysis: (1) isolate the variable load from access terminals $A-B$, (2) determine Thévenin equivalent voltage $V_{th} = V_{oc}$ and Thévenin resistance $R_{th}$, (3) set optimal load resistance equal to Thévenin resistance $R_L = R_{th}$ (or $Z_L = Z_{th}^*$ in AC), (4) calculate optimal circuit current $i_L = \frac{V_{th}}{2 R_{th}}$, (5) compute peak delivered load power $P_{\text{max}} = \frac{V_{th}^2}{4 R_{th}}$ and verify $50\%$ efficiency!
3. **Slide 3 (`matching`):** Pair 4 concepts (DC MPTT Condition $R_L = R_{th}$, Complex Conjugate Matching $Z_L = Z_{th}^*$, Peak Transferred Power $V_{th}^2 / 4R_{th}$, Pure Resistive Load Matching $R_L = |Z_{th}|$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 50 (or Fifty). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating maximum power: An audio power amplifier has a Thévenin equivalent open-circuit voltage $V_{th} = 20.0\text{ V}$ and an internal output resistance $R_{th} = 8.0\,\Omega$. What is the value of the load resistance $R_L$ required to draw maximum power from the amplifier, and what is the maximum power $P_{\text{max}}$ delivered to this load? ($R_L = R_{th} = \mathbf{8.0\,\Omega}$; $P_{\text{max}} = \frac{V_{th}^2}{4 R_{th}} = \frac{(20.0\text{ V})^2}{4(8.0\,\Omega)} = \frac{400}{32} = \mathbf{12.5\text{ Watts}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "maximum_power_transfer_theorem_dc_and_ac_conjugate_matching",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Maximum Power Transfer \\& Conjugate Matching (Alexander \\& Sadiku)**\n• **DC Maximum Power Transfer Formulation:**\n$$\n\\mathbf{R_L = R_{th} \\implies \\mathbf{P_{\\text{max}} = \\frac{V_{th}^2}{4 R_{th}} \\quad \\left(\\text{Efficiency } \\eta = \\frac{P_L}{P_{\\text{total}}} = 50\\%\\right)}}\n$$\n• **AC Complex Conjugate Matching Formulation ($Z_{th} = R_{th} + j X_{th}$):**\n$$\n\\mathbf{Z_L = Z_{th}^* = R_{th} - j X_{th} \\implies \\mathbf{P_{\\text{max}} = \\frac{V_{\\text{rms}}^2}{4 R_{th}} = \\frac{|V_{th}|^2}{8 R_{th}} \\text{ (Peak)}}}\n$$\n• **The 3 Operational Regimes:**\n  - **$R_L < R_{th}$:** Current is high, but most voltage drops across internal source resistance;\n  - **$R_L = R_{th}$ (Optimal):** Product of voltage and current at the load reaches global maximum ($P_{\\text{max}}$);\n  - **$R_L > R_{th}$:** Voltage is high, but total circuit current drops severely!\n• **The 50% Efficiency Invariant:** At $P_{\\text{max}}$, exactly **half the generated power is delivered to the load, and half is lost as heat inside the source ($R_{th}$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the optimal load resistance and calculate the maximum power transferred to a load.",
      "orderItems": [
        "Disconnect the load component RL from the source access terminals A and B",
        "Calculate the Thévenin open-circuit voltage V_th = V_oc and Thévenin resistance R_th",
        "Set the optimal load resistance equal to the source resistance: R_L = R_th",
        "Calculate the matched load current: I_L = V_th / (2 * R_th)",
        "Compute the maximum power delivered to the load using: P_max = (V_th)^2 / (4 * R_th)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Power Optimization Term to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "DC MPTT Condition (RL = Rth)", "right": "Load resistance matching the internal Thévenin resistance to maximize power delivery" },
        { "left": "AC Complex Conjugate (ZL = Zth*)", "right": "Load impedance having equal resistance and opposite reactance to cancel internal source reactance" },
        { "left": "Maximum Transferred Power", "right": "P_max = (V_th)^2 / (4*R_th), the peak power deliverable across the matched load interface" },
        { "left": "Power Transfer Efficiency (\u03b7 = 50%)", "right": "Percentage of total generated source power received by the load at the matched MPTT condition" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In DC circuit analysis, the energy efficiency at the exact condition of maximum power transfer is strictly ___ percent.",
      "blankAnswer": "50",
      "blankDistractors": ["100", "75", "25"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An audio amplifier has a Thévenin equivalent circuit with open-circuit voltage Vth = 20.0 V and internal output resistance Rth = 8.0 \u03a9. What is the value of the load resistance RL required to draw maximum power from the amplifier, and what is the maximum power P_max delivered to this load?",
      "options": [
        { "text": "RL = 8.0 \u03a9 and P_max = 12.5 W (RL = Rth = 8.0 \u03a9, and P_max = (20.0 V)^2 / (4 * 8.0 \u03a9) = 400 / 32 = 12.5 W)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Maximum Power Transfer Theorem (Charles Alexander & Matthew Sadiku *Fundamentals of Electric Circuits* Chapter 4). 1. **Apply MPTT Matching Condition:** $$R_L = R_{th} = \\mathbf{8.0\\,\\Omega}$$ 2. **Calculate Matched Load Current ($I_L$):** $$I_L = \\frac{V_{th}}{R_{th} + R_L} = \\frac{20.0\\text{ V}}{8.0\\,\\Omega + 8.0\\,\\Omega} = \\frac{20.0\\text{ V}}{16.0\\,\\Omega} = \\mathbf{1.25\\text{ A}}$$ 3. **Calculate Maximum Transferred Power ($P_{\\text{max}}$):** $$P_{\\text{max}} = I_L^2 \\cdot R_L = (1.25\\text{ A})^2 \\times 8.0\\,\\Omega = 1.5625 \\times 8.0 = \\mathbf{12.5\\text{ Watts}}$$ 4. **Verification via Direct Formula:** $$P_{\\text{max}} = \\frac{V_{th}^2}{4 R_{th}} = \\frac{(20.0\\text{ V})^2}{4 \\times 8.0\\,\\Omega} = \\frac{400}{32} = \\mathbf{12.5\\text{ Watts}}$$ 5. **Power Balance Check:** Total power supplied by internal source $= I_L \\times V_{th} = 1.25\\text{ A} \\times 20\\text{ V} = 25.0\\text{ W}$. Exactly $12.5\\text{ W}$ ($50\\%$) is delivered to the speaker load, and $12.5\\text{ W}$ ($50\\%$) is dissipated as heat inside the amplifier output stage!" },
        { "text": "RL = 4.0 \u03a9 and P_max = 25.0 W", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "RL = 16.0 \u03a9 and P_max = 6.25 W", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "RL = 8.0 \u03a9 and P_max = 50.0 W", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
