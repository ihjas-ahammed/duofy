# Duofy Reusable Lesson Format: Instrumentation Amplifiers (CMRR & Sensor Bridges)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Analog_Electronics_and_OpAmps / Operational_Amplifiers_and_Active_Filters`  
**Lesson Format Type:** `instrumentation_amplifiers_cmrr_and_bridge_sensor_interfaces`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through differential signal acquisition, common-mode noise rejection ($\text{CMRR}$), Wheatstone strain gauge bridge interfaces, and the three-op-amp instrumentation amplifier ($\text{INA}$) architecture in precision medical/industrial instrumentation (Sergio Franco *Design with Operational Amplifiers* Chapter 2; Adel S. Sedra & Kenneth C. Smith *Microelectronic Circuits* Chapter 2): derive the **Three-Op-Amp Instrumentation Amplifier Output Equation**:
$$\mathbf{v_o = \left( 1 + \frac{2 R_1}{R_G} \right) \left( \frac{R_3}{R_2} \right) (v_2 - v_1) = A_d (v_2 - v_1)}$$
master the **Three Architectural Advantages of the Classic INA Topology**:
1. **Ultra-High Differential Input Impedance ($\mathbf{R_{\text{in}} = \infty}$):** Input signals $v_1, v_2$ feed directly into non-inverting op-amp terminals, eliminating sensor loading;
2. **Single-Resistor Gain Tuning ($\mathbf{R_G}$):** Differential gain $A_d = \left(1 + \frac{2 R_1}{R_G}\right)\left(\frac{R_3}{R_2}\right)$ is adjusted using a **single resistor $R_G$**, eliminating the need to tune tightly matched resistor pairs;
3. **Common-Mode Rejection Ratio ($\mathbf{\text{CMRR}}$):**
   $$\mathbf{A_{cm,1} = 1.0 \quad \Big| \quad A_{d,1} = 1 + \frac{2 R_1}{R_G} \implies \mathbf{\text{Stage 1 boosts differential signal while keeping common-mode gain at unity}}}$$
   producing system Common-Mode Rejection Ratio $\text{CMRR} = 20 \log_{10}\left|\frac{A_d}{A_{cm}}\right| > 100\text{ dB}$ (rejecting $50/60\text{ Hz}$ power line hum from microvolt ECG/EEG biopotential signals).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Three-Op-Amp INA ($v_o = (1 + \frac{2R_1}{R_G})\frac{R_3}{R_2}(v_2-v_1)$), CMRR & Bridge Interface Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of Gain Resistor RG for a Wheatstone Bridge Sensor Interface Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Instrumentation Amplifier Component / Performance Parameter & Technical Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Ability of a Differential Amplifier to Reject Noise Common to Both Input Leads Is Measured by the Common-Mode ___ Ratio (Rejection / CMRR) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Precision Sensor Design Problem: Sizing RG to Amplify a 10 mV Full-Scale Bridge Signal to 5.0 V Output Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Instrumentation Amplifiers & CMRR (Franco 2015; Sedra & Smith 2020):
   - **Three-Op-Amp INA Formulations:**
     $$\mathbf{v_o = \left( 1 + \frac{2 R_1}{R_G} \right) \left( \frac{R_3}{R_2} \right) (v_2 - v_1) \quad \Big| \quad A_d = \left( 1 + \frac{2 R_1}{R_G} \right) \frac{R_3}{R_2} \quad \Big| \quad \text{CMRR} = 20\log_{10}\left|\frac{A_d}{A_{cm}}\right|}$$
   - **INA vs Standard Difference Amplifier Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Architecture} & \textbf{Input Impedance } R_{\text{in}} & \textbf{Gain Adjustment} & \textbf{CMRR Sensitivity} \\
     \hline
     \mathbf{\text{Standard 1-Op-Amp Diff Amp}} & \text{Low/Unbalanced } (R_1, R_1+R_2) & \text{Requires 2 matched resistors} & \text{Degraded by source impedances} \\
     \mathbf{\text{Three-Op-Amp INA}} & \mathbf{\infty \ (\text{Direct non-inv inputs})} & \mathbf{\text{Single external resistor } R_G} & \mathbf{> 100\text{ dB (Source-independent)}} \\
     \hline
     \end{array}$$
   - **The Common-Mode Unity Invariant:** The first stage of a 3-Op-Amp INA has **common-mode gain $A_{cm,1} = 1.0$** regardless of how large differential gain $A_{d,1}$ is set, vastly improving CMRR!
2. **Slide 2 (`ordering`):** Provide 5 steps of INA gain sizing: (1) record sensor differential full-scale output $\Delta v_{\text{in}} = v_2 - v_1$ and desired full-scale ADC input voltage $v_{o,\text{FS}}$, (2) compute required overall differential gain $A_d = v_{o,\text{FS}} / \Delta v_{\text{in}}$, (3) set the output subtractor stage gain (typically $R_3 / R_2 = 1.0$), (4) rearrange stage 1 gain formula to solve for gain-setting resistor: $R_G = \frac{2 R_1}{A_d - 1}$, (5) verify that input common-mode voltage does not exceed op-amp supply rails ($V_{\text{sat}}$)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Gain Setting Resistor $R_G$, Common-Mode Rejection Ratio CMRR, Input Buffer Stage $R_{\text{in}}=\infty$, Output Subtractor Stage $R_3/R_2$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Rejection (or CMRR). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on sizing INA gain resistor: A Wheatstone strain-gauge bridge produces a full-scale differential output $\Delta v_{\text{in}} = (v_2 - v_1) = 10.0\text{ mV}$ riding on a $2.50\text{ V}$ common-mode voltage. An instrumentation amplifier with internal resistors $R_1 = 50.0\text{ k}\Omega$ and $R_2 = R_3 = 10.0\text{ k}\Omega$ ($R_3/R_2 = 1.0$) is used to amplify the signal to $v_o = 5.00\text{ V}$ full scale. What is the required value of the external gain resistor $R_G$? ($A_d = \frac{v_o}{\Delta v_{\text{in}}} = \frac{5.00\text{ V}}{0.010\text{ V}} = \mathbf{500.0\text{ V/V}}$; Since $R_3/R_2 = 1.0$, $A_d = 1 + \frac{2 R_1}{R_G} = 500.0 \implies \frac{2 R_1}{R_G} = 499.0$; $R_G = \frac{2 R_1}{499.0} = \frac{2(50.0\text{ k}\Omega)}{499.0} = \frac{100,000\,\Omega}{499.0} \approx \mathbf{200.4\,\Omega}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "instrumentation_amplifiers_cmrr_and_bridge_sensor_interfaces",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Three-Op-Amp Instrumentation Amplifier (Sergio Franco)**\n• **Closed-Loop Differential Output Formulation:**\n$$\n\\mathbf{v_o = \\left( 1 + \\frac{2 R_1}{R_G} \\right) \\left( \\frac{R_3}{R_2} \\right) (v_2 - v_1) = A_d (v_2 - v_1)}\n$$\n• **Common-Mode Rejection Ratio (CMRR):**\n$$\n\\mathbf{\\text{CMRR} = 20 \\log_{10} \\left| \\frac{A_d}{A_{cm}} \\right| \\ [\\text{dB}] \\quad (\\text{Typically } > 100\\text{ dB in precision INAs})}\n$$\n• **The 3 Invariant Engineering Virtues of the INA:**\n  - **1. Infinite Input Impedance ($R_{\\text{in}} = \\infty$):** Bridge signals connect directly to non-inverting terminals;\n  - **2. Single Resistor Gain Knob ($R_G$):** Tunes gain without requiring matched resistor pairs;\n  - **3. High Common-Mode Immunity:** First stage amplifies differential signals by $(1 + 2R_1/R_G)$ while keeping common-mode gain **strictly at unity ($A_{cm,1} = 1.0$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to size the gain resistor RG of an instrumentation amplifier for a bridge sensor interface.",
      "orderItems": [
        "Record the full-scale differential sensor voltage \u0394vin = (v2 - v1) and desired full-scale output voltage vo,FS",
        "Compute the required overall differential amplifier voltage gain: Ad = vo,FS / \u0394vin",
        "Record the fixed internal resistor values R1 of the input stage and R2, R3 of the output subtractor stage",
        "Solve for the external gain-setting resistor: RG = (2 * R1) / [ (Ad / (R3/R2)) - 1 ]",
        "Verify that internal stage-1 op-amp outputs do not clip against power supply saturation rails"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Instrumentation Amplifier Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Gain Knob Resistor (RG)", "right": "RG = 2*R1 / (Ad - 1), single external resistor that tunes differential gain precisely" },
        { "left": "Common-Mode Rejection Ratio", "right": "CMRR = 20*log10(Ad / Acm), figure of merit measuring attenuation of common 50/60 Hz noise" },
        { "left": "Stage-1 Buffer Pair", "right": "Provides infinite input impedance (Rin = \u221e) and unloads high-impedance Wheatstone sensor bridges" },
        { "left": "Stage-2 Difference Subtractor", "right": "vo = (R3/R2)*(vo2 - vo1), strips common-mode voltage and converts to single-ended ground output" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The ability of a differential instrumentation amplifier to reject noise common to both inputs is measured by the common-mode ___ ratio.",
      "blankAnswer": "rejection",
      "blankDistractors": ["gain", "offset", "slew"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A Wheatstone strain gauge bridge produces full-scale differential output \u0394vin = 10.0 mV. An INA with R1 = 50.0 k\u03a9 and R2 = R3 = 10.0 k\u03a9 (R3/R2 = 1.0) must amplify this signal to vo = 5.00 V. What is the required gain resistor RG?",
      "options": [
        { "text": "RG = 200.4 \u03a9 (Ad = 5.0 V / 0.010 V = 500 V/V; RG = 2 * 50 k\u03a9 / (500 - 1) = 100,000 \u03a9 / 499 = 200.4 \u03a9)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using three-op-amp instrumentation amplifier equations (Sergio Franco *Design with Operational Amplifiers* Chapter 2). 1. **Calculate Required Differential Gain ($A_d$):** $$A_d = \\frac{v_o}{\\Delta v_{\\text{in}}} = \\frac{5.00\\text{ Volts}}{10.0\\text{ mV}} = \\frac{5.00\\text{ V}}{0.010\\text{ V}} = \\mathbf{500.0\\text{ V/V}}$$ 2. **Apply the 3-Op-Amp INA Gain Formula:** $$A_d = \\left( 1 + \\frac{2 R_1}{R_G} \\right) \\left( \\frac{R_3}{R_2} \\right)$$ - Since $R_2 = R_3 = 10.0\\text{ k}\\Omega$, $\\frac{R_3}{R_2} = 1.0$. - $$500.0 = 1 + \\frac{2 R_1}{R_G} \\implies \\frac{2 R_1}{R_G} = 500.0 - 1 = \\mathbf{499.0}$$ 3. **Solve for Gain Resistor ($R_G$):** $$R_G = \\frac{2 R_1}{499.0} = \\frac{2 \\times 50.0\\text{ k}\\Omega}{499.0} = \\frac{100,000\\,\\Omega}{499.0} \\approx \\mathbf{200.40\\,\\Omega \\approx 200.4\\,\\Omega}$$ 4. **Practical Resistor Selection:** An engineer would select a precision $200\\,\\Omega$ $0.1\\%$ metal-film resistor to set the sensor calibration gain perfectly!" },
        { "text": "RG = 200.0 \u03a9 (Using 500 in denominator instead of 499)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "RG = 100.2 \u03a9 (Forgetting the factor of 2 in 2*R1)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "RG = 400.8 \u03a9", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
