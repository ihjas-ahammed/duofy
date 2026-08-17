# Duofy Reusable Lesson Format: MOSFET Amplifiers (Saturation Biasing & CS/CD/CG Circuits)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Analog_Electronics_and_OpAmps / BJT_and_MOSFET_Amplifier_Biasing`  
**Lesson Format Type:** `mosfet_biasing_saturation_overdrive_and_cs_cd_cg_amplifiers`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through NMOS/PMOS operating regions, saturation pinch-off criteria ($V_{DS} \ge V_{ov} = V_{GS} - V_{th}$), square-law drain current characteristics, overdrive voltage ($V_{ov}$), small-signal transconductance ($g_m$), and canonical single-stage MOSFET amplifier architectures: Common-Source (CS), Common-Drain (CD / Source Follower), and Common-Gate (CG) in CMOS analog IC design (Adel S. Sedra & Kenneth C. Smith *Microelectronic Circuits* Chapter 5 & 7; Behzad Razavi *Design of Analog CMOS Integrated Circuits* 2nd ed. Chapter 3): master the **MOSFET Saturation Current Equation**:
$$\mathbf{I_D = \frac{1}{2} \mu_n C_{ox} \frac{W}{L} (V_{GS} - V_{th})^2 (1 + \lambda V_{DS}) = \frac{1}{2} k_n' \frac{W}{L} V_{ov}^2 = \frac{1}{2} k_n V_{ov}^2 \quad \left(V_{DS} \ge V_{ov} = V_{GS} - V_{th}\right)}$$
derive the **Three Equivalent Formulations for MOSFET Transconductance ($g_m$)**:
$$\mathbf{g_m = \left. \frac{\partial I_D}{\partial V_{GS}} \right|_{V_{DS}} = \mathbf{k_n V_{ov} = \sqrt{2 k_n I_D} = \frac{2 I_D}{V_{ov}}} \quad \Big| \quad \mathbf{r_o = \frac{1}{\lambda I_D} = \frac{V_A}{I_D}}}$$
derive the **Three Canonical MOSFET Amplifier Topologies**:
1. **Common-Source (CS):** High inverting voltage gain $\mathbf{A_v = -g_m (R_D \parallel r_o \parallel R_L)}$ with infinite input gate resistance ($\mathbf{R_{\text{in}} = \infty}$);
2. **Common-Drain (CD / Source Follower):** Unity non-inverting gain $\mathbf{A_v = \frac{g_m R_S}{1 + g_m R_S} \approx 1.0}$, infinite $R_{\text{in}}$, and low output resistance $\mathbf{R_{\text{out}} = \frac{1}{g_m} \parallel R_S}$ (voltage buffer);
3. **Common-Gate (CG):** Non-inverting voltage gain $\mathbf{A_v = +g_m (R_D \parallel R_L)}$ with low input resistance $\mathbf{R_{\text{in}} = 1/g_m}$ (high-frequency current buffer).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | MOSFET Saturation ($I_D = \frac{1}{2}k_n V_{ov}^2$), Transconductance ($g_m = \frac{2I_D}{V_{ov}}$) & CS/CD/CG Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Size Overdrive Voltage and Calculate CS Amplifier Gain Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | MOSFET Operational Parameter / Topology & Technical Performance Characteristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Voltage Excess of Gate-to-Source Voltage Above Threshold Voltage (VGS - Vth) Is the ___ Voltage (Overdrive / Vov) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analog CMOS Circuit Problem: Calculating gm, ro, and Loaded Gain Av for a Common-Source Stage Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State MOSFET Biasing & Topologies (Sedra & Smith 2020; Razavi 2017):
   - **MOSFET Saturation & Transconductance Formulations:**
     $$\mathbf{I_D = \frac{1}{2} k_n V_{ov}^2 \quad \Big| \quad V_{ov} = V_{GS} - V_{th} \quad \Big| \quad \mathbf{g_m = \frac{2 I_D}{V_{ov}} = \sqrt{2 k_n I_D}} \quad \Big| \quad r_o = \frac{1}{\lambda I_D}}$$
   - **MOSFET Topologies Comparison Matrix:**
     $$\begin{array}{|l|l|l|l|l|}
     \hline
     \textbf{Topology} & \textbf{Voltage Gain } A_v & \textbf{Input Impedance } R_{\text{in}} & \textbf{Output Impedance } R_{\text{out}} & \textbf{Primary Use} \\
     \hline
     \mathbf{\text{Common Source (CS)}} & \mathbf{-g_m (R_D \parallel R_L)} & \mathbf{\infty \ (\text{Insulated Gate})} & \text{Moderate } (R_D \parallel r_o) & \text{High Voltage Gain} \\
     \mathbf{\text{Common Drain (CD / Follower)}} & \mathbf{\approx +1.0 \ (\text{Follower})} & \mathbf{\infty} & \mathbf{\text{Low } (1/g_m \parallel R_S)} & \mathbf{\text{Output Voltage Buffer}} \\
     \mathbf{\text{Common Gate (CG)}} & \mathbf{+g_m (R_D \parallel R_L)} & \mathbf{\text{Low } (1/g_m)} & \text{Moderate } (R_D) & \text{Wideband RF / Current Buffer} \\
     \hline
     \end{array}$$
   - **The Saturation Boundary Invariant:** To keep an NMOS strictly in saturation (pinch-off), drain voltage must satisfy $\mathbf{V_{DS} \ge V_{GS} - V_{th} = V_{ov}}$ (or equivalently $\mathbf{V_{GD} \le V_{th}}$)!
2. **Slide 2 (`ordering`):** Provide 5 steps of MOSFET amplifier analysis: (1) check gate-to-source bias voltage $V_{GS}$ and verify $V_{GS} > V_{th}$, (2) calculate overdrive voltage $V_{ov} = V_{GS} - V_{th}$ and saturation drain current $I_D = \frac{1}{2} k_n V_{ov}^2$, (3) compute transconductance $g_m = \frac{2 I_D}{V_{ov}}$ and channel-length output resistance $r_o = \frac{1}{\lambda I_D}$, (4) verify saturation condition $V_{DS} = V_{DD} - I_D R_D \ge V_{ov}$, (5) evaluate loaded small-signal voltage gain $A_v = -g_m (R_D \parallel r_o \parallel R_L)$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Overdrive Voltage $V_{GS}-V_{th}$, Common-Source Gain $-g_m R_D$, Source Follower Output Resistance $1/g_m$, Saturation Condition $V_{DS} \ge V_{ov}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Overdrive (or Vov). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating MOSFET amplifier gain: An NMOS transistor has threshold voltage $V_{th} = 0.8\text{ V}$, process transconductance parameter $k_n = \mu_n C_{ox} \frac{W}{L} = 2.0\text{ mA/V}^2$, and channel length modulation parameter $\lambda = 0.01\text{ V}^{-1}$. The device is biased with gate-to-source voltage $V_{GS} = 1.8\text{ V}$ with supply $V_{DD} = 10.0\text{ V}$ and drain resistor $R_D = 4.0\text{ k}\Omega$. A load $R_L = 12.0\text{ k}\Omega$ is AC-coupled to the drain. What is the overdrive voltage $V_{ov}$, quiescent drain current $I_D$, transconductance $g_m$, and loaded AC voltage gain $A_v$? ($V_{ov} = V_{GS} - V_{th} = 1.8 - 0.8 = \mathbf{1.0\text{ V}}$; $I_D = \frac{1}{2} k_n V_{ov}^2 = \frac{1}{2}(2.0\text{ mA/V}^2)(1.0\text{ V})^2 = \mathbf{1.0\text{ mA}}$; $g_m = \frac{2 I_D}{V_{ov}} = \frac{2(1.0\text{ mA})}{1.0\text{ V}} = \mathbf{2.0\text{ mA/V} = 2.0\text{ mS}}$; Output resistance $r_o = \frac{1}{\lambda I_D} = \frac{1}{(0.01)(1.0\text{ mA})} = 100\text{ k}\Omega$; Total parallel AC load: $R_L' = R_D \parallel r_o \parallel R_L = 4.0\text{ k}\Omega \parallel 100\text{ k}\Omega \parallel 12.0\text{ k}\Omega$; $4\text{ k} \parallel 12\text{ k} = 3.0\text{ k}\Omega$; $3.0\text{ k} \parallel 100\text{ k} = \frac{300}{103}\text{ k}\Omega \approx \mathbf{2.913\text{ k}\Omega}$; Voltage gain: $A_v = -g_m R_L' = -(2.0\text{ mS})(2.913\text{ k}\Omega) = \mathbf{-5.83\text{ V/V}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "mosfet_biasing_saturation_overdrive_and_cs_cd_cg_amplifiers",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: MOSFET Saturation Physics \\& Topologies (Sedra \\& Smith)**\n• **Square-Law Saturation Current \\& Overdrive Voltage:**\n$$\n\\mathbf{V_{ov} = V_{GS} - V_{th} \\quad \\Big| \\quad I_D = \\frac{1}{2} k_n' \\left(\\frac{W}{L}\\right) V_{ov}^2 = \\frac{1}{2} k_n V_{ov}^2 \\quad \\left(V_{DS} \\ge V_{ov}\\right)}\n$$\n• **The 3 Equivalent Transconductance Formulations ($g_m$):**\n$$\n\\mathbf{g_m = k_n V_{ov} = \\sqrt{2 k_n I_D} = \\frac{2 I_D}{V_{ov}} \\quad \\Big| \\quad r_o = \\frac{1}{\\lambda I_D} = \\frac{V_A}{I_D}}\n$$\n• **The 3 Canonical MOSFET Amplifier Topologies:**\n$$\n\\begin{array}{|l|l|l|l|l|}\n\\hline\n\\textbf{Topology} & \\textbf{Voltage Gain } A_v & \\textbf{Input Impedance } R_{\\text{in}} & \\textbf{Output Impedance } R_{\\text{out}} & \\textbf{Function} \\\\\n\\hline\n\\mathbf{\\text{Common Source (CS)}} & \\mathbf{-g_m (R_D \\parallel r_o \\parallel R_L)} & \\mathbf{\\infty \\ (\\text{SiO}_2\\text{ Insulator})} & \\text{Moderate } (R_D \\parallel r_o) & \\text{Voltage Gain} \\\\\n\\mathbf{\\text{Common Drain (CD / Follower)}} & \\mathbf{\\approx +1.0 \\ (\\text{Source Follower})} & \\mathbf{\\infty} & \\mathbf{\\text{Low } (1/g_m \\parallel R_S)} & \\mathbf{\\text{Voltage Buffer}} \\\\\n\\mathbf{\\text{Common Gate (CG)}} & \\mathbf{+g_m (R_D \\parallel R_L)} & \\mathbf{\\text{Low } (1/g_m)} & \\text{Moderate } (R_D) & \\text{Wideband RF} \\\\\n\\hline\n\\end{array}\n$$\n• **The Saturation Pinch-Off Invariant:** To remain strictly in saturation, drain voltage must satisfy **$V_{DS} \\ge V_{ov} = V_{GS} - V_{th}$ (channel remains pinched off at the drain end)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to size a MOSFET DC bias point and calculate the loaded voltage gain of a Common-Source amplifier.",
      "orderItems": [
        "Record threshold voltage Vth, transconductance parameter kn, and bias voltage VGS to verify VGS > Vth",
        "Compute the gate overdrive voltage: Vov = VGS - Vth",
        "Calculate the saturation drain current: I_D = 0.5 * kn * (Vov)^2",
        "Compute small-signal transconductance g_m = 2*I_D / Vov and channel resistance r_o = 1 / (\u03bb * I_D)",
        "Verify saturation state VDS = VDD - I_D*RD >= Vov and compute loaded AC voltage gain: A_v = -g_m * (RD || ro || RL)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each MOSFET Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Overdrive Voltage (Vov)", "right": "Vov = VGS - Vth, effective voltage above threshold driving inversion charge in the channel" },
        { "left": "Transconductance (gm)", "right": "gm = 2*ID / Vov = \u221a(2*kn*ID), small-signal voltage-to-current conversion gain" },
        { "left": "Source Follower (CD)", "right": "Av \u2248 1.0 and Rout = 1/gm, high-input-impedance buffer driving low-resistance loads" },
        { "left": "Saturation Boundary", "right": "VDS >= Vov (or VGD <= Vth), ensuring inversion channel remains pinched off at drain end" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The excess of gate-to-source voltage above the threshold voltage (VGS - Vth) is the ___ voltage.",
      "blankAnswer": "overdrive",
      "blankDistractors": ["breakdown", "pinchoff", "thermal"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An NMOS CS amplifier has Vth = 0.8 V, kn = 2.0 mA/V^2, \u03bb = 0.01 V^-1, VGS = 1.8 V, VDD = 10.0 V, RD = 4.0 k\u03a9, and RL = 12.0 k\u03a9. What is the overdrive voltage Vov, bias current ID, transconductance gm, and loaded AC gain Av?",
      "options": [
        { "text": "Vov = 1.0 V, ID = 1.0 mA, gm = 2.0 mS, and Av = -5.83 V/V (Vov = 1.8-0.8=1.0 V; ID = 0.5*2*1^2 = 1.0 mA; gm = 2*1mA/1.0V = 2.0 mS; ro = 100 k\u03a9; RL' = 4k||12k||100k = 2.913 k\u03a9 \u2192 Av = -2.0mS * 2.913k\u03a9 = -5.83)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using MOSFET saturation and small-signal equations (Adel Sedra & Kenneth Smith *Microelectronic Circuits* Chapter 5 & 7). 1. **Calculate Overdrive Voltage ($V_{ov}$):** $$V_{ov} = V_{GS} - V_{th} = 1.80\\text{ V} - 0.80\\text{ V} = \\mathbf{1.00\\text{ Volts}}$$ 2. **Calculate Saturation Drain Current ($I_D$):** $$I_D = \\frac{1}{2} k_n V_{ov}^2 = \\frac{1}{2} (2.00\\text{ mA/V}^2) (1.00\\text{ V})^2 = \\mathbf{1.00\\text{ mA}}$$ 3. **Calculate Small-Signal Transconductance ($g_m$):** $$g_m = \\frac{2 I_D}{V_{ov}} = \\frac{2 (1.00\\text{ mA})}{1.00\\text{ V}} = \\mathbf{2.00\\text{ mA/V} = 2.00\\text{ mS}}$$ 4. **Calculate Output Resistance ($r_o$):** $$r_o = \\frac{1}{\\lambda I_D} = \\frac{1}{(0.010\\text{ V}^{-1})(1.00\\text{ mA})} = \\frac{1}{1.00 \\times 10^{-5}}\\text{ }\\Omega = \\mathbf{100.0\\text{ k}\\Omega}$$ 5. **Calculate Total AC Parallel Load ($R_L'$):** $$R_L' = R_D \\parallel r_o \\parallel R_L = 4.0\\text{ k}\\Omega \\parallel 100.0\\text{ k}\\Omega \\parallel 12.0\\text{ k}\\Omega$$ - First combine $4\\text{ k} \\parallel 12\\text{ k} = \\frac{48}{16} = 3.00\\text{ k}\\Omega$. - Next combine $3\\text{ k} \\parallel 100\\text{ k} = \\frac{300}{103}\\text{ k}\\Omega \\approx \\mathbf{2.9126\\text{ k}\\Omega}$. 6. **Calculate Loaded Inverting Voltage Gain ($A_v$):** $$A_v = -g_m R_L' = -(2.00\\text{ mS}) \\times (2.9126\\text{ k}\\Omega) = \\mathbf{-5.8252\\text{ V/V} \\approx -5.83\\text{ V/V}}$$ 7. **Saturation Check:** $V_{DS} = V_{DD} - I_D R_D = 10.0\\text{ V} - (1.0\\text{ mA})(4.0\\text{ k}\\Omega) = 6.0\\text{ V} > V_{ov} = 1.0\\text{ V}$, confirming **safe saturation operation**!" },
        { "text": "Vov = 1.0 V, ID = 2.0 mA, gm = 4.0 mS, and Av = -11.6 V/V", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Vov = 1.0 V, ID = 1.0 mA, gm = 2.0 mS, and Av = -8.00 V/V (Forgetting load RL)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Vov = 0.8 V, ID = 0.64 mA, gm = 1.6 mS, and Av = -4.66 V/V", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
