# Duofy Reusable Lesson Format: Biopotential Amplifiers (3-Op-Amp INA & CMRR Rejection)

**Target Topic:** `04_Engineering_and_Technology / 06_Biomedical_Engineering / Medical_Instrumentation_and_Sensors / Biopotential_Electrodes_ECG_EEG`  
**Lesson Format Type:** `three_opamp_instrumentation_amplifier_and_cmrr`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the electronic architecture of the classical **Three-Op-Amp Instrumentation Amplifier (INA)** used in medical ECG/EEG front-ends, the first-stage non-inverting cross-coupled input buffer ($A_1, A_2$) providing infinite differential input impedance ($Z_{\text{in}} > 10^9\text{ }\Omega$) and setting differential gain via a single external resistor ($R_{\text{gain}}$), the second-stage balanced difference amplifier ($A_3$) rejecting common-mode noise, the total **Differential Voltage Gain ($A_d$)**, the **Common-Mode Rejection Ratio ($\text{CMRR}_{\text{dB}} \ge 100 - 120\text{ dB}$)**, and the catastrophic impact of resistor tolerance mismatch on CMRR (John G. Webster *Medical Instrumentation: Application and Design* 5th ed. Chapter 6; Joseph D. Bronzino *The Biomedical Engineering Handbook* Chapter 46): formulate the **Three-Op-Amp INA Differential Gain Master Formulation**:
$$\mathbf{A_d = \frac{v_{\text{out}}}{v_1 - v_2} = \underbrace{\left( 1 + \frac{2 R_1}{R_{\text{gain}}} \right)}_{\text{Stage 1 Differential Gain } A_{d1}} \times \underbrace{\left( \frac{R_3}{R_2} \right)}_{\text{Stage 2 Difference Gain } A_{d2}}}$$
where:
1. **$R_{\text{gain}}$:** Single gain-setting resistor connected between inverting terminals of the two input buffers;
2. **$R_1$:** Feedback resistors in stage 1 ($R_{1A} = R_{1B} = R_1$);
3. **$R_2, R_3$:** Resistors in stage 2 difference amplifier ($R_3 / R_2$ ratio);
derive the **Common-Mode Gain ($A_{cm}$) & CMRR Formulation**:
$$\mathbf{A_{cm1} = 1.00 \quad (\text{Stage 1 passes common-mode signal with Unity Gain!})}$$
$$\mathbf{\text{CMRR} = \frac{A_d}{A_{cm}} \Longleftrightarrow \mathbf{\text{CMRR}_{\text{dB}} = 20 \log_{10}\left( \frac{A_d}{A_{cm}} \right) \ge 100\text{ dB}}}$$
derive the **Resistor Tolerance Mismatch CMRR Limit**:
$$\mathbf{\text{CMRR}_{\text{stage 2}} \approx \frac{1 + \frac{R_3}{R_2}}{4 \cdot \left( \frac{\Delta R}{R} \right)} \quad \left(\text{A } 0.1\% \text{ resistor mismatch drops CMRR to } 66\text{ dB}\right)}$$
(proving why precision laser-trimmed resistor networks such as INA128/AD620 are mandatory to reject $50/60\text{ Hz}$ common-mode interference from the patient's body).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | 3-Op-Amp INA ($A_d = (1 + \frac{2R_1}{R_{\text{gain}}})\frac{R_3}{R_2}$), $A_{cm1} = 1$ & CMRR ($\ge 100\text{ dB}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Size Rgain for a Target ECG Preamplifier Gain and Calculate System CMRR Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Instrumentation Amplifier Component / Parameter & Technical Electronic Circuit Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the First Stage of a 3-Op-Amp Instrumentation Amplifier, the Common-Mode Voltage Gain $A_{cm1}$ Is Strictly Equal to ___ (One / Unity / 1.0) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Biomedical Circuit Problem: Calculating Rgain and Output Voltage for a 12-Lead ECG Instrumentation Amplifier Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Instrumentation Amplifier Mechanics (Webster 2020; Bronzino 2014):
   - **Circuit Formulations:**
     $$\mathbf{A_d = \left(1 + \frac{2R_1}{R_{\text{gain}}}\right)\left(\frac{R_3}{R_2}\right) \quad \Big| \quad A_{cm1} = 1.0 \quad \Big| \quad \text{CMRR}_{\text{dB}} = 20\log_{10}\left(\frac{A_d}{A_{cm}}\right) \quad \Big| \quad Z_{\text{in}} > 10^9\text{ }\Omega}$$
   - **INA Stages Comparison Matrix:**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{INA Circuit Stage} & \textbf{Differential Gain } A_d & \textbf{Common-Mode Gain } A_{cm} & \textbf{Primary Biopotential Function} \\
     \hline
     \mathbf{\text{Stage 1 (Buffers } A_1, A_2\text{)}} & \mathbf{1 + \frac{2 R_1}{R_{\text{gain}}} \ (\approx 10 - 1000)} & \mathbf{A_{cm1} = 1.00 \ (\text{Unity})} & \mathbf{\text{High input impedance, amplifies difference only}} \\
     \mathbf{\text{Stage 2 (Difference } A_3\text{)}} & \mathbf{\frac{R_3}{R_2} \ (\approx 1 - 10)} & A_{cm2} \to 0 & \text{Subtracts common-mode voltage, delivers single-ended out} \\
     \hline
     \end{array}$$
   - **The Unity Common-Mode Invariant:** In the input buffer stage, the common-mode voltage appears identically on both sides of $R_{\text{gain}}$, causing **zero current through $R_{\text{gain}}$ ($i_{cm} = 0$)**, which forces common-mode gain to be strictly unity ($A_{cm1} = 1.0$) while differential signals are heavily amplified!
2. **Slide 2 (`ordering`):** Provide 5 steps of INA design: (1) specify target differential gain $A_d$ and supply voltages, (2) select stage 2 difference amplifier resistors with $R_3 / R_2 = 1.0$ (or target factor), (3) calculate required stage 1 gain: $A_{d1} = A_d / (R_3/R_2)$, (4) solve for gain-setting resistor: $R_{\text{gain}} = \frac{2 R_1}{A_{d1} - 1}$, (5) verify common-mode rejection ratio: $\text{CMRR}_{\text{dB}} = 20 \log_{10}(A_d / A_{cm}) \ge 100\text{ dB}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Gain Resistor $R_{\text{gain}}$, Input Buffer Stage, Difference Stage $R_3/R_2$, CMRR in dB) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of One (or Unity / 1.0). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating $R_{\text{gain}}$ and output voltage: An ECG front-end instrumentation amplifier has feedback resistors $R_1 = 50.0\text{ k}\Omega$ and stage 2 difference resistors $R_2 = 10.0\text{ k}\Omega, R_3 = 10.0\text{ k}\Omega$ ($R_3/R_2 = 1.00$). We require a total differential gain $A_d = 100.0$.
   - Stage 1 differential gain required: $A_{d1} = \frac{A_d}{R_3/R_2} = \frac{100.0}{1.00} = \mathbf{100.0}$;
   - Setting $1 + \frac{2 R_1}{R_{\text{gain}}} = 100.0 \implies \frac{2 R_1}{R_{\text{gain}}} = 99.0 \implies R_{\text{gain}} = \frac{2 \times 50.0\text{ k}\Omega}{99.0} = \frac{100.0\text{ k}\Omega}{99.0} = \mathbf{1.0101\text{ k}\Omega = 1010.1\text{ }\Omega \approx 1.01\text{ k}\Omega}$;
   - When a differential biopotential of $v_1 - v_2 = 1.50\text{ mV} = 0.00150\text{ V}$ is applied, the output voltage is:
     $v_{\text{out}} = A_d \cdot (v_1 - v_2) = 100.0 \times 1.50\text{ mV} = \mathbf{150.0\text{ mV} = 0.150\text{ V}}$;
   - What is the required gain resistor $R_{\text{gain}}$ and the output voltage $v_{\text{out}}$? ($R_{\text{gain}} = \mathbf{1.01\text{ k}\Omega}$ and $v_{\text{out}} = \mathbf{150\text{ mV}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "three_opamp_instrumentation_amplifier_and_cmrr",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Three-Op-Amp Instrumentation Amplifier (John G. Webster)**\n• **Differential Voltage Gain Master Formulation ($A_d$):**\n$$\n\\mathbf{A_d = \\frac{v_{\\text{out}}}{v_1 - v_2} = \\left( 1 + \\frac{2 R_1}{R_{\\text{gain}}} \\right) \\left( \\frac{R_3}{R_2} \\right)}\n$$\n  - **$R_{\\text{gain}}$:** Single precision resistor setting Stage 1 differential gain;\n  - **$R_1$:** Stage 1 buffer feedback resistors ($R_{1A} = R_{1B} = R_1$);\n  - **$R_2, R_3$:** Stage 2 difference amplifier matched resistors;\n• **Common-Mode Rejection Ratio Formulation (CMRR):**\n$$\n\\mathbf{\\text{CMRR} = \\frac{A_d}{A_{cm}} \\Longleftrightarrow \\text{CMRR}_{\\text{dB}} = 20 \\log_{10}\\left( \\frac{A_d}{A_{cm}} \\right) \\ge 100 - 120\\text{ dB}}\n$$\n• **The Unity Common-Mode Invariant:** In Stage 1, identical common-mode voltages create zero potential difference across $R_{\\text{gain}}$, forcing **$A_{cm1} = 1.00$ (Unity Gain)** while differential signals are amplified by $A_{d1} = 1 + 2R_1/R_{\\text{gain}}$, boosting CMRR before the signal reaches the subtractor!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design a Three-Op-Amp Instrumentation Amplifier for biopotential signal acquisition.",
      "orderItems": [
        "Specify the target differential voltage gain Ad (e.g. Ad = 100) and required input impedance (> 10^9 \u03a9)",
        "Select precision matched resistors for the Stage 2 difference amplifier (R2 = R3 = 10 k\u03a9 \u2192 Stage 2 gain = 1.0)",
        "Determine the required Stage 1 differential gain: A_d1 = Ad / (R3 / R2)",
        "Calculate the gain-setting resistor value from the Stage 1 equation: Rgain = (2 * R1) / (A_d1 - 1)",
        "Verify Common-Mode Rejection Ratio CMRR_dB = 20*log10(Ad / A_cm) \u2265 100 dB to ensure rejection of 50/60 Hz power line noise"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Instrumentation Amplifier Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Gain Resistor (Rgain)", "right": "Rgain = 2R1 / (Ad1 - 1), single external resistor adjusting differential gain without altering CMRR" },
        { "left": "Input Buffer Stage", "right": "Two non-inverting op-amps providing near-infinite input impedance (> 10^9 \u03a9) preventing skin loading" },
        { "left": "Difference Output Stage", "right": "Four-resistor subtractor stage with gain R3/R2 converting differential voltage to single-ended ground output" },
        { "left": "CMRR (\u2265 100 dB)", "right": "20*log10(Ad/Acm), logarithmic figure of merit quantifying rejection of common-mode interference" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the first stage of a 3-Op-Amp instrumentation amplifier, the common-mode voltage gain A_cm1 is strictly equal to ___.",
      "blankAnswer": "one",
      "blankDistractors": ["zero", "infinity", "Rgain"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An ECG instrumentation amplifier has R1 = 50.0 k\u03a9 and R2 = R3 = 10.0 k\u03a9 (R3/R2 = 1.00). We require Ad = 100.0. A_d1 = 100.0 \u2192 1 + 2*R1/Rgain = 100.0 \u2192 2*50 k\u03a9 / Rgain = 99.0 \u2192 Rgain = 100 k\u03a9 / 99.0 = 1.0101 k\u03a9. For a 1.50 mV differential ECG wave (v1 - v2 = 1.50 mV), what is Rgain and the output voltage v_out?",
      "options": [
        { "text": "Rgain = 1.01 k\u03a9 and v_out = 150 mV (Rgain = 100,000 \u03a9 / 99 = 1010.1 \u03a9 \u2248 1.01 k\u03a9; v_out = 100.0 * 1.50 mV = 150.0 mV)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the 3-Op-Amp Instrumentation Amplifier gain formula (John G. Webster *Medical Instrumentation: Application and Design* Chapter 6). 1. **Identify Circuit Component Values \\& Target Gain:** - Feedback resistors: $R_1 = 50.0\\text{ k}\\Omega = 50,000.0\\text{ }\\Omega$. - Second stage resistors: $R_2 = 10.0\\text{ k}\\Omega, \\quad R_3 = 10.0\\text{ k}\\Omega \\implies \\frac{R_3}{R_2} = \\mathbf{1.000}$. - Required total differential gain: $A_d = 100.0$. 2. **Calculate Required Gain-Setting Resistor ($R_{\\text{gain}}$):** - Total gain equation: $$A_d = \\left( 1 + \\frac{2 R_1}{R_{\\text{gain}}} \\right) \\left( \\frac{R_3}{R_2} \\right)$$ $$100.0 = \\left( 1 + \\frac{2 \\times 50.0\\text{ k}\\Omega}{R_{\\text{gain}}} \\right) \\times 1.000$$ $$1 + \\frac{100.0\\text{ k}\\Omega}{R_{\\text{gain}}} = 100.0 \\implies \\frac{100.0\\text{ k}\\Omega}{R_{\\text{gain}}} = 99.0$$ $$R_{\\text{gain}} = \\frac{100.0\\text{ k}\\Omega}{99.0} = \\mathbf{1.0101\\text{ k}\\Omega = 1010.1\\text{ }\\Omega \\approx 1.01\\text{ k}\\Omega}$$ 3. **Calculate Output Voltage ($v_{\\text{out}}$):** - Differential input voltage: $v_1 - v_2 = 1.50\\text{ mV} = 0.00150\\text{ V}$. $$v_{\\text{out}} = A_d \\cdot (v_1 - v_2) = 100.0 \\times 1.50\\text{ mV} = \\mathbf{150.0\\text{ mV} = 0.150\\text{ V}}$$ Flawless 3-Op-Amp INA gain and output voltage derivation!" },
        { "text": "Rgain = 1.00 k\u03a9 and v_out = 15.0 mV (Divided by 10 instead of multiplying)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Rgain = 2.02 k\u03a9 and v_out = 150 mV", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Rgain = 1.01 k\u03a9 and v_out = 1.50 V", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
