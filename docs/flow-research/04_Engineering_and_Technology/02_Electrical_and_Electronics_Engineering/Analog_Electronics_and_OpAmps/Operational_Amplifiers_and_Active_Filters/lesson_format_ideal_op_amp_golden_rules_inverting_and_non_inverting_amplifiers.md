# Duofy Reusable Lesson Format: Linear Op-Amps (Golden Rules, Inverting & Non-Inverting)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Analog_Electronics_and_OpAmps / Operational_Amplifiers_and_Active_Filters`  
**Lesson Format Type:** `ideal_op_amp_golden_rules_inverting_and_non_inverting_amplifiers`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the axiomatic foundations of operational amplifiers, negative feedback stabilization, the two ideal Op-Amp Golden Rules, and the derivation of canonical linear amplifier topologies: Inverting, Non-Inverting, Voltage Follower / Buffer, and Weighted Summing Amplifiers in analog signal conditioning (Adel S. Sedra & Kenneth C. Smith *Microelectronic Circuits* Chapter 2; Sergio Franco *Design with Operational Amplifiers* Chapter 1): formulate the **Two Ideal Op-Amp Golden Rules**:
$$\mathbf{v_+ = v_- \quad (\text{Virtual Short Rule under Negative Feedback}) \quad \Big| \quad \mathbf{i_+ = i_- = 0 \quad (\text{Zero Input Current Rule / } R_{\text{in}} = \infty)}}$$
derive the **Canonical Linear Op-Amp Closed-Loop Gains**:
1. **Inverting Amplifier:**
   $$\mathbf{A_v = \frac{v_o}{v_{\text{in}}} = -\frac{R_f}{R_1} \quad \Big| \quad R_{\text{in}} = R_1 \quad \Big| \quad v_- = 0\text{ V (Virtual Ground)}}$$
2. **Non-Inverting Amplifier:**
   $$\mathbf{A_v = \frac{v_o}{v_{\text{in}}} = 1 + \frac{R_f}{R_1} \quad \Big| \quad R_{\text{in}} = \infty}$$
3. **Voltage Follower / Unity-Gain Buffer ($R_f = 0, R_1 = \infty$):**
   $$\mathbf{A_v = +1.0 \quad \Big| \quad R_{\text{in}} = \infty \quad \Big| \quad R_{\text{out}} = 0}$$
   (preventing interstage loading between high-impedance sensors and low-impedance digitizers);
4. **Inverting Summing Amplifier:**
   $$\mathbf{v_o = -\left( \frac{R_f}{R_1} v_1 + \frac{R_f}{R_2} v_2 + \frac{R_f}{R_3} v_3 \right)}$$

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Golden Rules ($v_+=v_-, i_+=i_-=0$), Inverting ($-\frac{R_f}{R_1}$) & Non-Inverting ($1+\frac{R_f}{R_1}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Derive the Closed-Loop Transfer Function of an Inverting Op-Amp Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Op-Amp Topology / Feedback Characteristic & Technical Circuit Performance Metric Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Condition Where Negative Feedback Drives the Differential Input Voltage (v+ - v-) to Zero Without a Physical Short Is a ___ Short (Virtual / Virtual Short) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Precision Analog Circuit Problem: Calculating Output Voltage vo for a Non-Inverting Summing/Gain Stage Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Op-Amp Golden Rules & Topologies (Sedra & Smith 2020; Franco 2015):
   - **Golden Rules & Linear Topologies Formulations:**
     $$\mathbf{v_+ = v_- \quad \Big| \quad i_+ = i_- = 0 \quad \Big| \quad A_{v,\text{inv}} = -\frac{R_f}{R_1} \quad \Big| \quad A_{v,\text{non-inv}} = 1 + \frac{R_f}{R_1} \quad \Big| \quad v_o = -\sum \frac{R_f}{R_k} v_k}$$
   - **Canonical Topologies Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Topology} & \textbf{Closed-Loop Gain } A_v & \textbf{Input Impedance } R_{\text{in}} & \textbf{Special Features} \\
     \hline
     \mathbf{\text{Inverting Amplifier}} & \mathbf{-R_f / R_1} & R_1 & \text{Virtual ground at } v_- \text{ eliminates cross-talk} \\
     \mathbf{\text{Non-Inverting}} & \mathbf{1 + R_f / R_1} & \mathbf{\infty \ (\text{Zero loading})} & \text{High input impedance sensor interface} \\
     \mathbf{\text{Voltage Follower}} & \mathbf{+1.0} & \mathbf{\infty} & \mathbf{\text{Ideal unity-gain impedance buffer}} \\
     \mathbf{\text{Summing Amplifier}} & -(R_f/R_1 v_1 + \dots) & R_k \text{ per channel} & \text{Linear analog weighting / DAC summation} \\
     \hline
     \end{array}$$
   - **The Feedback Polarity Invariant:** The Virtual Short Rule ($v_+ = v_-$) is **valid strictly when negative feedback is present**; with positive feedback, the op-amp acts as a bistable Schmitt trigger comparator!
2. **Slide 2 (`ordering`):** Provide 5 steps of inverting op-amp analysis: (1) verify presence of negative feedback connected from output to inverting terminal $v_-$, (2) apply Golden Rule 1 to find inverting node potential $v_- = v_+ = 0\text{ V}$ (virtual ground), (3) write KCL at the $v_-$ inverting node: $\frac{v_{\text{in}} - v_-}{R_1} + \frac{v_o - v_-}{R_f} = i_-$, (4) apply Golden Rule 2 ($i_- = 0$) to set total current to zero: $\frac{v_{\text{in}}}{R_1} + \frac{v_o}{R_f} = 0$, (5) rearrange algebraically to obtain $v_o = -\frac{R_f}{R_1} v_{\text{in}}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Inverting Gain $-R_f/R_1$, Non-Inverting Gain $1+R_f/R_1$, Voltage Follower $A_v = 1.0$, Virtual Short $v_+=v_-$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Virtual (or Virtual Short). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on non-inverting op-amp calculation: A non-inverting op-amp amplifier is designed with feedback resistor $R_f = 90.0\text{ k}\Omega$ and ground resistor $R_1 = 10.0\text{ k}\Omega$. The input signal $v_{\text{in}} = 120\text{ mV}$ is applied to the non-inverting terminal $v_+$. What is the closed-loop voltage gain $A_v$, the output voltage $v_o$, and the current $i_{\text{in}}$ drawn from the input source under ideal op-amp conditions? ($A_v = 1 + \frac{R_f}{R_1} = 1 + \frac{90\text{ k}}{10\text{ k}} = 1 + 9.0 = \mathbf{10.0\text{ V/V}}$; Output voltage: $v_o = A_v \times v_{\text{in}} = 10.0 \times 120\text{ mV} = \mathbf{1200\text{ mV} = 1.20\text{ V}}$; Input current: By Golden Rule 2 ($R_{\text{in}} = \infty$), $\mathbf{i_{\text{in}} = 0.0\text{ A}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ideal_op_amp_golden_rules_inverting_and_non_inverting_amplifiers",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Op-Amp Golden Rules \\& Canonical Amplifiers (Sedra \\& Smith)**\n• **The 2 Master Ideal Op-Amp Golden Rules:**\n$$\n\\mathbf{v_+ = v_- \\quad (\\text{Virtual Short under Negative Feedback}) \\quad \\Big| \\quad \\mathbf{i_+ = i_- = 0 \\quad (R_{\\text{in}} = \\infty)}}\n$$\n• **Canonical Linear Closed-Loop Voltage Gains:**\n$$\n\\mathbf{\\text{Inverting: } A_v = -\\frac{R_f}{R_1} \\quad \\Big| \\quad \\text{Non-Inverting: } A_v = 1 + \\frac{R_f}{R_1} \\quad \\Big| \\quad \\text{Buffer: } A_v = +1.0}\n$$\n• **The 4 Canonical Linear Op-Amp Circuits:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Circuit Topology} & \\textbf{Closed-Loop Gain } A_v & \\textbf{Input Impedance } R_{\\text{in}} & \\textbf{Key Advantage} \\\\\n\\hline\n\\mathbf{\\text{Inverting Amplifier}} & \\mathbf{-R_f / R_1} & R_1 & \\text{Virtual ground prevents input cross-talk} \\\\\n\\mathbf{\\text{Non-Inverting Amplifier}} & \\mathbf{1 + R_f / R_1} & \\mathbf{\\infty \\ (\\text{Zero load})} & \\text{High input impedance eliminates sensor loading} \\\\\n\\mathbf{\\text{Voltage Follower / Buffer}} & \\mathbf{+1.0} & \\mathbf{\\infty} & \\mathbf{\\text{Zero output impedance buffer driver}} \\\\\n\\mathbf{\\text{Summing Amplifier}} & -\\sum (R_f/R_k) v_k & R_k & \\text{Weighted linear algebraic addition of signals} \\\\\n\\hline\n\\end{array}\n$$\n• **Negative Feedback Prerequisite:** The virtual short ($v_+ = v_-$) is **strictly enforced by negative feedback** driving error voltage $(v_+ - v_-) = v_o / A_{OL} \\to 0$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to derive the closed-loop voltage gain of an inverting op-amp amplifier.",
      "orderItems": [
        "Verify that a negative feedback path exists connecting the output node to the inverting input terminal v-",
        "Apply Golden Rule 1 (Virtual Short) to establish the inverting terminal potential: v- = v+ = 0 V (Virtual Ground)",
        "Write Kirchhoff's Current Law (KCL) at the inverting node: (vin - v-) / R1 + (vo - v-) / Rf = i-",
        "Apply Golden Rule 2 (Zero Input Current) by setting i- = 0: (vin - 0) / R1 + (vo - 0) / Rf = 0",
        "Solve the algebraic node equation for output voltage to obtain the closed-loop gain: vo = -(Rf / R1) * vin"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Op-Amp Topology to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Inverting Amplifier", "right": "Av = -Rf / R1, providing controlled gain with 180\u00b0 phase inversion and virtual ground input" },
        { "left": "Non-Inverting Amplifier", "right": "Av = 1 + Rf / R1, non-inverting gain stage with infinite input impedance (Rin = \u221e)" },
        { "left": "Voltage Follower", "right": "Av = +1.0 with Rf = 0 and R1 = \u221e, ideal unity gain buffer preventing source loading" },
        { "left": "Virtual Short Rule", "right": "v+ = v-, condition enforced by negative feedback forcing differential input voltage to zero" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The condition where negative feedback forces the differential input voltage (v+ - v-) to zero without a physical wire is a ___ short.",
      "blankAnswer": "virtual",
      "blankDistractors": ["ground", "dynamic", "floating"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A non-inverting op-amp amplifier has feedback resistor Rf = 90.0 k\u03a9 and ground resistor R1 = 10.0 k\u03a9. An input signal vin = 120 mV is applied to the non-inverting input terminal v+. What is the closed-loop voltage gain Av, output voltage vo, and input current drawn from the source?",
      "options": [
        { "text": "Av = 10.0 V/V, vo = 1.20 V, and i_in = 0.0 A (Av = 1 + 90k/10k = 10.0; vo = 10.0 * 120 mV = 1.20 V; and i_in = 0 due to infinite op-amp input impedance)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using non-inverting op-amp equations (Adel Sedra & Kenneth Smith *Microelectronic Circuits* Chapter 2). 1. **Calculate Closed-Loop Voltage Gain ($A_v$):** $$A_v = 1 + \\frac{R_f}{R_1} = 1 + \\frac{90.0\\text{ k}\\Omega}{10.0\\text{ k}\\Omega} = 1 + 9.0 = \\mathbf{10.0\\text{ V/V}}$$ 2. **Calculate Output Voltage ($v_o$):** $$v_o = A_v \\times v_{\\text{in}} = 10.0 \\times 120.0\\text{ mV} = 1200.0\\text{ mV} = \\mathbf{1.20\\text{ Volts}}$$ 3. **Calculate Input Current ($i_{\\text{in}}$):** - By Golden Rule 2, the ideal op-amp input terminal draws **zero current** ($i_+ = 0$). - Therefore, input impedance $R_{\\text{in}} = \\infty$, and: $$i_{\\text{in}} = \\mathbf{0.0\\text{ Amperes}}$$ 4. **Voltage Divider Verification:** The voltage at $v_-$ via output divider is $v_- = v_o \\frac{R_1}{R_1 + R_f} = 1.20\\text{ V} \\times \\frac{10}{100} = 0.120\\text{ V} = 120\\text{ mV} = v_+$, perfectly verifying the **virtual short**!" },
        { "text": "Av = 9.0 V/V, vo = 1.08 V, and i_in = 0.0 A (Using inverting gain formula Rf/R1)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Av = 10.0 V/V, vo = 1.20 V, and i_in = 12 \u03bcA (Assuming current into R1 comes from source)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Av = 1.0 V/V, vo = 120 mV, and i_in = 0.0 A", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
