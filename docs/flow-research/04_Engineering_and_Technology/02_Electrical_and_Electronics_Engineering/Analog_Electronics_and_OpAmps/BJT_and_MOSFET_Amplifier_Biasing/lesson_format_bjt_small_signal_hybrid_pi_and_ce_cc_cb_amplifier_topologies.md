# Duofy Reusable Lesson Format: BJT Amplifiers (Hybrid-Pi & CE/CC/CB Topologies)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Analog_Electronics_and_OpAmps / BJT_and_MOSFET_Amplifier_Biasing`  
**Lesson Format Type:** `bjt_small_signal_hybrid_pi_and_ce_cc_cb_amplifier_topologies`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through BJT small-signal linearization, the Hybrid-$\pi$ model ($g_m, r_\pi, r_o$), the T-model ($r_e$), and the three canonical single-stage amplifier configurations: Common-Emitter (CE), Common-Collector (CC / Emitter Follower), and Common-Base (CB) in analog systems (Adel S. Sedra & Kenneth C. Smith *Microelectronic Circuits* Chapter 7; Behzad Razavi *Fundamentals of Microelectronics* Chapter 5): formulate **Small-Signal Parameters from DC Operating Point**:
$$\mathbf{g_m = \frac{I_C}{V_T} \approx \frac{I_C}{26\text{ mV}} \quad \Big| \quad r_\pi = \frac{\beta}{g_m} = \frac{\beta V_T}{I_C} \quad \Big| \quad r_e = \frac{V_T}{I_E} = \frac{\alpha}{g_m} = \frac{r_\pi}{\beta + 1} \quad \Big| \quad r_o = \frac{V_A}{I_C}}$$
derive the **Three Canonical BJT Amplifier Performance Metrics**:
1. **Common-Emitter (CE) with Emitter Degeneration:**
   $$\mathbf{A_v \approx -\frac{g_m (R_C \parallel R_L)}{1 + g_m R_E} \approx -\frac{R_C \parallel R_L}{r_e + R_E} \quad \Big| \quad R_{\text{in}} = R_B \parallel [r_\pi + (\beta + 1) R_E]}$$
2. **Common-Collector (CC / Emitter Follower):**
   $$\mathbf{A_v = \frac{R_E \parallel R_L}{(R_E \parallel R_L) + r_e} \approx 1.0 \quad \Big| \quad \mathbf{R_{\text{out}} = R_E \parallel \left( r_e + \frac{R_S \parallel R_B}{\beta + 1} \right) \approx r_e}}$$
   (analyzing how the Emitter Follower acts as an ideal low-impedance voltage buffer);
3. **Common-Base (CB):**
   $$\mathbf{A_v = +g_m (R_C \parallel R_L) \quad \Big| \quad \mathbf{R_{\text{in}} = r_e = \frac{1}{g_m}} \quad \Big| \quad R_{\text{out}} = R_C}$$
   (non-inverting wideband current buffer with zero Miller multiplication).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Small-Signal ($g_m = \frac{I_C}{26\text{mV}}$), Hybrid-$\pi$ ($r_\pi = \frac{\beta}{g_m}$) & CE/CC/CB Topologies Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Derive Small-Signal Parameters and Calculate CE Amplifier Gain Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Canonical BJT Amplifier Topology / Parameter & Technical Performance Signature Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Single-Stage BJT Amplifier Configuration That Provides Near-Unity Voltage Gain (~1.0) and Ultra-Low Output Impedance Is the Common-___ (Collector / Emitter Follower) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analog Amplifier Problem: Calculating gm, rpi, and Voltage Gain Av for a Common-Emitter Stage Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State BJT Small-Signal & Topologies (Sedra & Smith 2020; Razavi 2021):
   - **Small-Signal Model Formulations:**
     $$\mathbf{g_m = \frac{I_C}{V_T} \approx \frac{I_C}{26\text{ mV}} \quad \Big| \quad r_\pi = \frac{\beta}{g_m} \quad \Big| \quad r_e = \frac{V_T}{I_E} \approx \frac{1}{g_m} \quad \Big| \quad r_o = \frac{V_A}{I_C}}$$
   - **BJT Topologies Comparison Matrix:**
     $$\begin{array}{|l|l|l|l|l|}
     \hline
     \textbf{Topology} & \textbf{Voltage Gain } A_v & \textbf{Input Resistance } R_{\text{in}} & \textbf{Output Resistance } R_{\text{out}} & \textbf{Circuit Function} \\
     \hline
     \mathbf{\text{Common Emitter (CE)}} & \mathbf{\text{High Inverting } (-g_m R_L')} & \text{Moderate } (r_\pi) & \text{Moderate } (R_C) & \text{Core Voltage Gain} \\
     \mathbf{\text{CE with Degeneration } R_E} & \mathbf{\approx -\frac{R_C \parallel R_L}{R_E + r_e}} & \mathbf{\text{High } [r_\pi + (\beta+1)R_E]} & \text{Moderate } (R_C) & \text{Linearized Gain} \\
     \mathbf{\text{Common Collector (CC)}} & \mathbf{\approx +1.0 \ (\text{Non-inverting})} & \mathbf{\text{Very High } [(\beta+1)R_L']} & \mathbf{\text{Ultra-Low } (\approx r_e)} & \mathbf{\text{Voltage Buffer}} \\
     \mathbf{\text{Common Base (CB)}} & \mathbf{\text{High Non-Inverting } (+g_m R_L')} & \mathbf{\text{Ultra-Low } (\approx r_e)} & \text{Moderate } (R_C) & \text{High-Freq / Current Buffer} \\
     \hline
     \end{array}$$
   - **The Transconductance Linearity Invariant:** BJT transconductance $g_m = \frac{I_C}{V_T}$ depends **strictly on DC bias current $I_C$**, enabling precise small-signal parameter scaling!
2. **Slide 2 (`ordering`):** Provide 5 steps of BJT amplifier analysis: (1) determine DC collector current $I_C$ from DC bias analysis, (2) compute small-signal transconductance $g_m = I_C / 26\text{ mV}$ and input resistance $r_\pi = \beta / g_m$, (3) deactivate DC supplies and replace transistor with Hybrid-$\pi$ model, (4) evaluate AC input resistance $R_{\text{in}}$ and output load resistance $R_L' = R_C \parallel R_L$, (5) calculate small-signal voltage gain $A_v = v_o / v_i = -g_m R_L'$ (or $-\frac{R_L'}{R_E + r_e}$ with degeneration)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Common-Emitter Inverting Gain, Common-Collector Emitter Follower Buffer, Common-Base Current Buffer, Transconductance $g_m = I_C/V_T$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Collector (or Emitter Follower). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on computing CE amplifier gain: A Common-Emitter BJT amplifier is biased at $I_C = 2.6\text{ mA}$ with $\beta = 100$ ($V_T = 26\text{ mV}$). The collector resistor is $R_C = 3.0\text{ k}\Omega$, connected to a load $R_L = 6.0\text{ k}\Omega$ through a coupling capacitor. The emitter resistor is bypassed with a large capacitor ($R_E$ bypassed, so AC emitter is grounded). Neglect Early effect ($r_o = \infty$). What is the transconductance $g_m$, input resistance $r_\pi$, and loaded AC voltage gain $A_v = v_o / v_i$? ($g_m = \frac{I_C}{V_T} = \frac{2.6\text{ mA}}{26\text{ mV}} = 0.10\text{ A/V} = \mathbf{100\text{ mA/V} = 0.10\text{ S}}$; $r_\pi = \frac{\beta}{g_m} = \frac{100}{0.10\text{ S}} = 1000\,\Omega = \mathbf{1.0\text{ k}\Omega}$; Total AC collector load: $R_L' = R_C \parallel R_L = 3.0\text{ k}\Omega \parallel 6.0\text{ k}\Omega = \frac{18}{9}\text{ k}\Omega = \mathbf{2.0\text{ k}\Omega} = 2000\,\Omega$; Loaded voltage gain: $A_v = -g_m R_L' = -(0.10\text{ S})(2000\,\Omega) = \mathbf{-200\text{ V/V}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "bjt_small_signal_hybrid_pi_and_ce_cc_cb_amplifier_topologies",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: BJT Small-Signal Hybrid-\\(\\pi\\) \\& Topologies (Sedra \\& Smith)**\n• **Small-Signal Parameter Formulations ($V_T \\approx 26\\text{ mV}$):**\n$$\n\\mathbf{g_m = \\frac{I_C}{V_T} \\approx \\frac{I_C}{26\\text{ mV}} \\quad \\Big| \\quad r_\\pi = \\frac{\\beta}{g_m} \\quad \\Big| \\quad r_e = \\frac{V_T}{I_E} = \\frac{r_\\pi}{\\beta + 1} \\quad \\Big| \\quad r_o = \\frac{V_A}{I_C}}\n$$\n• **The 3 Canonical BJT Single-Stage Amplifier Configurations:**\n$$\n\\begin{array}{|l|l|l|l|l|}\n\\hline\n\\textbf{Topology} & \\textbf{Voltage Gain } A_v & \\textbf{Input Impedance } R_{\\text{in}} & \\textbf{Output Impedance } R_{\\text{out}} & \\textbf{Role} \\\\\n\\hline\n\\mathbf{\\text{Common Emitter (CE)}} & \\mathbf{-g_m (R_C \\parallel R_L)} & \\text{Moderate } (r_\\pi) & \\text{Moderate } (R_C) & \\text{Voltage Gain Stage} \\\\\n\\mathbf{\\text{CE with Degeneration}} & \\mathbf{-\\frac{R_C \\parallel R_L}{r_e + R_E}} & \\mathbf{r_\\pi + (\\beta + 1) R_E} & \\text{Moderate } (R_C) & \\text{Linearized High-}R_{\\text{in}} \\\\\n\\mathbf{\\text{Common Collector (CC)}} & \\mathbf{\\approx +1.0 \\ (\\text{Follower})} & \\mathbf{\\text{Very High } [(\\beta+1)R_L']} & \\mathbf{\\text{Ultra-Low } (\\approx r_e)} & \\mathbf{\\text{Voltage Buffer}} \\\\\n\\mathbf{\\text{Common Base (CB)}} & \\mathbf{+g_m (R_C \\parallel R_L)} & \\mathbf{\\text{Ultra-Low } (\\approx r_e)} & \\text{Moderate } (R_C) & \\text{Current Buffer / RF} \\\\\n\\hline\n\\end{array}\n$$\n• **The Transconductance Invariant:** BJT transconductance $g_m = \\frac{I_C}{26\\text{ mV}}$ scales **purely linearly with DC bias current $I_C$**, providing the highest transconductance per milliampere of any standard transistor family!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to evaluate small-signal parameters and calculate the loaded voltage gain of a Common-Emitter amplifier.",
      "orderItems": [
        "Perform DC bias analysis to extract the quiescent collector current I_C",
        "Calculate the small-signal transconductance: g_m = I_C / 26 mV",
        "Calculate the small-signal base-emitter input resistance: r_pi = \u03b2 / g_m",
        "Determine the effective AC parallel collector load: R_L' = R_C || R_L",
        "Apply the Hybrid-pi model to compute the loaded inverting voltage gain: A_v = -g_m * R_L'"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each BJT Amplifier Topology to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Common Emitter (CE)", "right": "Av = -gm*RL', standard high inverting voltage gain configuration with 180\u00b0 phase inversion" },
        { "left": "Common Collector (CC / Follower)", "right": "Av \u2248 +1.0 and Rout \u2248 re, unity gain buffer providing high input impedance and low output impedance" },
        { "left": "Common Base (CB)", "right": "Av = +gm*RL' and Rin \u2248 re, non-inverting current buffer immune to Miller capacitance effect" },
        { "left": "Emitter Degeneration (RE)", "right": "Av \u2248 -RL' / (RE + re), trading off raw gain to increase input impedance and linearize dynamic range" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The single-stage BJT amplifier configuration that provides near-unity voltage gain (~1.0) and ultra-low output impedance is the common-___.",
      "blankAnswer": "collector",
      "blankDistractors": ["emitter", "base", "source"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A Common-Emitter amplifier is biased at IC = 2.6 mA with \u03b2 = 100 (VT = 26 mV, ro = \u221e). Collector resistor RC = 3.0 k\u03a9 is AC-coupled to load RL = 6.0 k\u03a9, with RE fully bypassed. What is gm, rpi, and loaded AC voltage gain Av?",
      "options": [
        { "text": "gm = 100 mA/V (0.10 S), rpi = 1.0 k\u03a9, and Av = -200 V/V (gm = 2.6mA/26mV = 0.10 S; rpi = 100/0.10 = 1000 \u03a9; RL' = 3k||6k = 2.0 k\u03a9; Av = -0.10 S * 2000 \u03a9 = -200)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using BJT small-signal Hybrid-$\\pi$ equations (Adel Sedra & Kenneth Smith *Microelectronic Circuits* Chapter 7). 1. **Calculate Transconductance ($g_m$):** $$g_m = \\frac{I_C}{V_T} = \\frac{2.60\\text{ mA}}{26.0\\text{ mV}} = 0.100\\text{ A/V} = \\mathbf{100.0\\text{ mA/V} = 0.10\\text{ S}}$$ 2. **Calculate Input Resistance ($r_\\pi$):** $$r_\\pi = \\frac{\\beta}{g_m} = \\frac{100}{0.100\\text{ S}} = 1000\\,\\Omega = \\mathbf{1.0\\text{ k}\\Omega}$$ 3. **Calculate Total AC Parallel Collector Load ($R_L'$):** $$R_L' = R_C \\parallel R_L = 3.0\\text{ k}\\Omega \\parallel 6.0\\text{ k}\\Omega = \\frac{3.0 \\times 6.0}{3.0 + 6.0}\\text{ k}\\Omega = \\frac{18.0}{9.0}\\text{ k}\\Omega = \\mathbf{2.0\\text{ k}\\Omega} = 2000\\,\\Omega$$ 4. **Calculate Loaded Inverting Voltage Gain ($A_v$):** $$A_v = -g_m R_L' = -(0.100\\text{ S})(2000\\,\\Omega) = \\mathbf{-200.0\\text{ V/V}}$$ 5. **Interpretation:** An AC input signal $v_i = 10\\text{ mV}_{\\text{peak}}$ produces an inverted output voltage $v_o = -200 \\times 10\\text{ mV} = -2.0\\text{ V}_{\\text{peak}}$! Flawless BJT amplifier analysis!" },
        { "text": "gm = 100 mA/V, rpi = 1.0 k\u03a9, and Av = -300 V/V (Forgetting load RL)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "gm = 50 mA/V, rpi = 2.0 k\u03a9, and Av = -100 V/V", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "gm = 100 mA/V, rpi = 10 k\u03a9, and Av = +200 V/V", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
