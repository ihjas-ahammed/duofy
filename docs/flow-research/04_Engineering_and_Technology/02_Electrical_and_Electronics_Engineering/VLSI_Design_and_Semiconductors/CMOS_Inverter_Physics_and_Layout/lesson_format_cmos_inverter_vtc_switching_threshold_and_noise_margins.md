# Duofy Reusable Lesson Format: CMOS Inverter VTC (Switching Threshold & Noise Margins)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / VLSI_Design_and_Semiconductors / CMOS_Inverter_Physics_and_Layout`  
**Lesson Format Type:** `cmos_inverter_vtc_switching_threshold_and_noise_margins`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the static DC Voltage Transfer Characteristic ($\text{VTC}$) of a CMOS inverter, transistor operating regions ($A \to E$), the analytical derivation of the switching threshold voltage ($V_M = V_{in} = V_{out}$), the symmetric sizing condition compensating for hole-vs-electron mobility differentials ($\mu_n / \mu_p$), and the extraction of High and Low Static Noise Margins ($NM_H, NM_L$) via unity-gain tangent slopes ($\frac{dV_{out}}{dV_{in}} = -1$) in custom VLSI standard cell design (Neil Weste & David Harris *CMOS VLSI Design* Chapter 2; Sung-Mo Kang *CMOS Digital Integrated Circuits* Chapter 5): formulate the **CMOS Inverter Switching Threshold ($V_M$) Equation**:
$$\mathbf{V_M = \frac{V_{tn} + r (V_{DD} - |V_{tp}|)}{1 + r} \quad \text{where } \mathbf{r = \sqrt{\frac{k_p}{k_n}} = \sqrt{\frac{\mu_p C_{ox} (W/L)_p}{\mu_n C_{ox} (W/L)_n}}}}$$
derive the **Symmetric Inverter Design Condition ($\mathbf{V_M = V_{DD}/2}$ with $\mathbf{V_{tn} = |V_{tp}|}$)**:
$$\mathbf{r = 1.0 \implies k_p = k_n \implies \mathbf{\left(\frac{W}{L}\right)_p = \left(\frac{\mu_n}{\mu_p}\right) \left(\frac{W}{L}\right)_n \approx 2.0 - 3.0 \left(\frac{W}{L}\right)_n}}$$
(proving why PMOS pull-up transistors must be sized $2\times$ to $3\times$ wider than NMOS pull-down transistors to equalize pull-up and pull-down channel on-resistances $R_p = R_n$); and formulate the **Static Noise Margins**:
$$\mathbf{NM_L = V_{IL} - V_{OL} = V_{IL} \quad \Big| \quad \mathbf{NM_H = V_{OH} - V_{IH} = V_{DD} - V_{IH}} \quad \left(\left. \frac{dV_{out}}{dV_{in}} \right|_{V_{IL}, V_{IH}} = -1\right)}$$
(analyzing how wide noise margins prevent spurious logic flips in noisy digital environments).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Inverter VTC Regions ($A\text{-}E$), Threshold ($V_M = \frac{V_{tn}+r(V_{DD}-|V_{tp}|)}{1+r}$), $W_p \approx 2.5 W_n$ & Noise Margins Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Size PMOS Width Wp for a Symmetric Inverter with Equal Noise Margins Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Inverter VTC Region / Operating Metric & Technical MOSFET State Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The DC Voltage at Which the Inverter Input Voltage Exactly Equals the Output Voltage Is the Switching ___ Voltage (Threshold / VM) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Silicon VLSI Problem: Calculating PMOS Width Wp and Switching Threshold VM for a 1.8V Process Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State CMOS Inverter VTC & Sizing (Weste & Harris 2011; Kang 2014):
   - **VTC Threshold & Noise Margin Formulations:**
     $$\mathbf{V_M = \frac{V_{tn} + r(V_{DD} - |V_{tp}|)}{1 + r} \quad \Big| \quad r = \sqrt{\frac{\mu_p (W/L)_p}{\mu_n (W/L)_n}} \quad \Big| \quad NM_L = V_{IL} \quad \Big| \quad NM_H = V_{DD} - V_{IH}}$$
   - **VTC Five Operating Regions Matrix:**
     $$\begin{array}{|l|l|l|l|l|}
     \hline
     \textbf{Region} & \textbf{Input Range } V_{in} & \textbf{NMOS State} & \textbf{PMOS State} & \textbf{Output } V_{out} \\
     \hline
     \mathbf{\text{Region A}} & 0 \le V_{in} < V_{tn} & \text{Cutoff (Off)} & \text{Linear (Triode)} & \mathbf{V_{OH} = V_{DD}} \\
     \mathbf{\text{Region B}} & V_{tn} \le V_{in} < V_M & \text{Saturation} & \text{Linear} & \text{High, decaying} \\
     \mathbf{\text{Region C}} & \mathbf{V_{in} = V_M} & \mathbf{\text{Saturation}} & \mathbf{\text{Saturation}} & \mathbf{V_{out} = V_M \ (\text{High Gain Slope})} \\
     \mathbf{\text{Region D}} & V_M < V_{in} \le V_{DD} - |V_{tp}| & \text{Linear} & \text{Saturation} & \text{Low, decaying} \\
     \mathbf{\text{Region E}} & V_{DD} - |V_{tp}| < V_{in} \le V_{DD} & \text{Linear} & \text{Cutoff (Off)} & \mathbf{V_{OL} = 0\text{ V (GND)}} \\
     \hline
     \end{array}$$
   - **The Mobility Compensation Invariant:** In silicon, electron mobility is significantly higher than hole mobility ($\mu_n \approx 2.5 \mu_p$); sizing $W_p = 2.5 W_n$ equalizes transistor strengths, centering $V_M = V_{DD}/2$ and maximizing total noise margin!
2. **Slide 2 (`ordering`):** Provide 5 steps of inverter sizing: (1) determine supply voltage $V_{DD}$ and threshold voltages $V_{tn}, |V_{tp}|$, (2) extract carrier mobility values $\mu_n$ and $\mu_p$ from semiconductor process data, (3) equate $k_n = k_p$ for symmetric midpoint threshold $V_M = V_{DD}/2$, (4) compute required PMOS aspect ratio $(W/L)_p = (\mu_n / \mu_p) (W/L)_n$, (5) locate unit-gain points $\frac{dV_{out}}{dV_{in}} = -1$ on the VTC to verify balanced noise margins $NM_L \approx NM_H \approx 0.4 V_{DD}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Region C Saturation/Saturation, Low Noise Margin $NM_L = V_{IL}$, High Noise Margin $NM_H = V_{DD}-V_{IH}$, Mobility Ratio $\mu_n/\mu_p$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Threshold (or VM). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating PMOS width and $V_M$: A CMOS inverter is fabricated in a $1.8\text{ V}$ digital process ($V_{DD} = 1.80\text{ V}$) with $V_{tn} = 0.40\text{ V}$ and $|V_{tp}| = 0.40\text{ V}$. The process parameters are $\mu_n C_{ox} = 200\ \mu\text{A/V}^2$ and $\mu_p C_{ox} = 80\ \mu\text{A/V}^2$ ($\mu_n / \mu_p = 2.5$). The NMOS transistor has width $W_n = 0.50\ \mu\text{m}$ (with $L_n = L_p = 0.18\ \mu\text{m}$). What PMOS width $W_p$ is required to achieve a perfectly symmetric switching threshold $V_M = V_{DD}/2 = 0.90\text{ V}$? ($k_n = k_p \implies \mu_n C_{ox} (W/L)_n = \mu_p C_{ox} (W/L)_p \implies 200 \times \left(\frac{0.50}{0.18}\right) = 80 \times \left(\frac{W_p}{0.18}\right) \implies 200 \times 0.50 = 80 \times W_p \implies W_p = \frac{100}{80} = \mathbf{1.25\ \mu\text{m}}$; Ratio $W_p / W_n = \frac{1.25}{0.50} = \mathbf{2.50}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cmos_inverter_vtc_switching_threshold_and_noise_margins",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: CMOS Inverter VTC \\& Switching Threshold (Weste \\& Harris)**\n• **Switching Threshold ($V_M$) Formulation (where $V_{in} = V_{out} = V_M$):**\n$$\n\\mathbf{V_M = \\frac{V_{tn} + r (V_{DD} - |V_{tp}|)}{1 + r} \\quad \\text{where } \\mathbf{r = \\sqrt{\\frac{k_p}{k_n}} = \\sqrt{\\frac{\\mu_p C_{ox} (W/L)_p}{\\mu_n C_{ox} (W/L)_n}}}}\n$$\n• **Symmetric Inverter Design Condition ($V_M = V_{DD}/2$):**\n$$\n\\mathbf{r = 1.0 \\implies k_p = k_n \\implies \\mathbf{\\left(\\frac{W}{L}\\right)_p = \\left(\\frac{\\mu_n}{\\mu_p}\\right) \\left(\\frac{W}{L}\\right)_n \\approx 2.5 \\left(\\frac{W}{L}\\right)_n}}\n$$\n• **Static Noise Margins (Extracted at Unity-Gain Tangent Slopes $\\frac{dV_{out}}{dV_{in}} = -1$):**\n$$\n\\mathbf{NM_L = V_{IL} - V_{OL} = V_{IL} \\quad \\Big| \\quad \\mathbf{NM_H = V_{OH} - V_{IH} = V_{DD} - V_{IH}}}\n$$\n• **The Region C Operating Invariant:** At the switching midpoint $V_{in} = V_M$, **BOTH the NMOS and PMOS transistors operate simultaneously in the SATURATION region**, creating maximum voltage amplification gain!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design a symmetric CMOS inverter with equal noise margins and centered switching threshold VM = VDD/2.",
      "orderItems": [
        "Record the supply voltage VDD, NMOS threshold Vtn, and PMOS threshold |Vtp| from foundry process specifications",
        "Extract the electron mobility (\u03bcn) and hole mobility (\u03bcp) process transconductance parameters",
        "Equate transistor conduction parameters kp = kn to set the strength ratio r = \u221a(kp/kn) = 1.0",
        "Compute the required PMOS transistor channel width: Wp = (\u03bcn / \u03bcp) * Wn (typically 2.0 to 3.0 times Wn)",
        "Extract unity-gain points VIL and VIH from the resulting VTC to verify balanced noise margins NML \u2248 NMH"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each CMOS Inverter Operating Characteristic to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Switching Threshold (VM)", "right": "DC voltage where Vin = Vout = VM, governed by the PMOS-to-NMOS transconductance ratio r" },
        { "left": "Region C (Vin = VM)", "right": "Operating state where BOTH NMOS and PMOS transistors operate simultaneously in Saturation" },
        { "left": "Low Noise Margin (NML)", "right": "NML = VIL - VOL = VIL, maximum allowable noise voltage superimposed on a logic 0 input" },
        { "left": "High Noise Margin (NMH)", "right": "NMH = VOH - VIH = VDD - VIH, maximum allowable noise voltage subtracted from a logic 1 input" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The DC operating point on the inverter VTC where input voltage exactly equals output voltage is the switching ___ voltage.",
      "blankAnswer": "threshold",
      "blankDistractors": ["saturation", "breakdown", "pinchoff"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A CMOS inverter is fabricated in a 1.80 V digital process (VDD = 1.80 V, Vtn = |Vtp| = 0.40 V) with \u03bcn*Cox = 200 \u03bcA/V^2 and \u03bp*Cox = 80 \u03bcA/V^2 (\u03bcn/\u03bp = 2.5). The NMOS transistor has width Wn = 0.50 \u03bcm (with equal channel lengths Ln = Lp = 0.18 \u03bcm). What PMOS width Wp is required to achieve a symmetric switching threshold VM = 0.90 V (VDD/2)?",
      "options": [
        { "text": "Wp = 1.25 \u03bcm (Wp = (\u03bcn/\u03bp) * Wn = 2.5 * 0.50 \u03bcm = 1.25 \u03bcm, equalizing kn = kp to center VM at VDD/2 = 0.90 V)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the CMOS inverter switching threshold equation (Neil Weste & David Harris *CMOS VLSI Design* Chapter 2). 1. **Recall the Symmetric Inverter Condition:** - For a centered switching threshold $V_M = \\frac{V_{DD}}{2} = 0.90\\text{ V}$ when $V_{tn} = |V_{tp}| = 0.40\\text{ V}$, the strength ratio must be: $$r = \\sqrt{\\frac{k_p}{k_n}} = 1.0 \\implies k_p = k_n$$ 2. **Formulate Conduction Parameter Equations ($k = \\mu C_{ox} \\frac{W}{L}$):** $$k_n = (\\mu_n C_{ox}) \\left(\\frac{W_n}{L_n}\\right) = 200\\ \\mu\\text{A/V}^2 \\times \\left(\\frac{0.50\\ \\mu\\text{m}}{0.18\\ \\mu\\text{m}}\\right)$$ $$k_p = (\\mu_p C_{ox}) \\left(\\frac{W_p}{L_p}\\right) = 80\\ \\mu\\text{A/V}^2 \\times \\left(\\frac{W_p}{0.18\\ \\mu\\text{m}}\\right)$$ 3. **Equate $k_p = k_n$ and Solve for $W_p$:** $$80 \\times W_p = 200 \\times 0.50$$ $$80 \\times W_p = 100 \\implies W_p = \\frac{100}{80} = \\mathbf{1.250\\ \\mu\\text{m} = 1.25\\ \\mu\\text{m}}$$ 4. **Physical Aspect Ratio Verification:** $$\\frac{W_p}{W_n} = \\frac{1.25\\ \\mu\\text{m}}{0.50\\ \\mu\\text{m}} = \\mathbf{2.50 = \\frac{\\mu_n}{\\mu_p}}$$ Because hole mobility is $2.5\\times$ lower than electron mobility, the PMOS must be **exactly $2.5\times$ wider** to conduct equal saturation current at $V_M$! Flawless CMOS inverter sizing calculation!" },
        { "text": "Wp = 0.50 \u03bcm (Equal width)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Wp = 0.20 \u03bcm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Wp = 2.50 \u03bcm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
