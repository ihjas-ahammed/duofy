# Duofy Reusable Lesson Format: AC Power & Phasors (Complex Power & Power Factor Correction)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Electric_Circuits_and_Network_Theory / Transient_and_Sinusoidal_Steady_State`  
**Lesson Format Type:** `ac_phasor_analysis_complex_power_and_power_factor_correction`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through AC sinusoidal steady-state phasor transformations, complex impedance arithmetic, the complex power triangle, and power factor correction in industrial electrical networks (Charles P. Steinmetz 1893; Charles K. Alexander & Matthew N.O. Sadiku *Fundamentals of Electric Circuits* Chapters 9 & 11; James W. Nilsson & Susan A. Riedel *Electric Circuits* Chapters 9 & 10): master the **Phasor Transformation & Complex Impedances**:
$$\mathbf{v(t) = V_m \cos(\omega t + \theta_v) \Longleftrightarrow \mathbf{V}_{\text{rms}} = \frac{V_m}{\sqrt{2}} \angle \theta_v \quad \Big| \quad Z_R = R, \ Z_L = j\omega L, \ Z_C = -j\frac{1}{\omega C}}$$
master the **Complex Power Triangle Formulation**:
$$\mathbf{\mathbf{S} = \mathbf{V}_{\text{rms}} \mathbf{I}_{\text{rms}}^* = P + j Q = |\mathbf{S}| \angle \theta \quad \left(|\mathbf{S}| = \sqrt{P^2 + Q^2} = V_{\text{rms}} I_{\text{rms}}\right)}$$
where $P$ is Real Active Power ($\text{Watts}$, performing mechanical work/heat), $Q$ is Reactive Power ($\text{VAR}$, magnetizing field storage), and $|\mathbf{S}|$ is Apparent Power ($\text{VA}$); define **Power Factor ($\mathbf{pf = \cos\theta = \frac{P}{|\mathbf{S}|}}$)** (lagging for inductive industrial motor loads, leading for capacitive loads); and derive the **Shunt Power Factor Correction Capacitor Sizing Formula**:
$$\mathbf{C_{\text{correction}} = \frac{P \left( \tan\theta_{\text{old}} - \tan\theta_{\text{new}} \right)}{\omega V_{\text{rms}}^2}}$$
(proving why adding parallel capacitors supplies the required reactive magnetizing VARs locally, reducing transmission line current and eliminating utility low-power-factor penalty charges).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Complex Power Triangle ($\mathbf{S} = \mathbf{V} \mathbf{I}^* = P + jQ$), Power Factor ($pf = \cos\theta$) & PFC Sizing Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of Apparent Power, Reactive Power, and Shunt Correction Capacitance Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | AC Power Parameter / Phasor Entity & Technical Electrical Unit Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | An Industrial AC Load Dominated by Induction Motors Draws a Power Factor Classified as ___ (Lagging / Inductive) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Industrial Power Systems Problem: Sizing a Shunt Capacitor Bank to Improve Plant Power Factor to 0.95 Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Complex AC Power (Alexander & Sadiku 2021; Steinmetz 1893):
   - **Complex Power Formulations:**
     $$\mathbf{\mathbf{S} = \mathbf{V}_{\text{rms}} \mathbf{I}_{\text{rms}}^* = P + j Q = |\mathbf{S}| \angle (\theta_v - \theta_i) \quad \Big| \quad |\mathbf{S}| = \sqrt{P^2 + Q^2} \quad \Big| \quad pf = \cos(\theta_v - \theta_i) = \frac{P}{|\mathbf{S}|}}$$
   - **Power Matrix & Units:**
     $$\begin{array}{|l|c|l|l|}
     \hline
     \textbf{Power Component} & \textbf{Symbol} & \textbf{Measurement Unit} & \textbf{Physical Role} \\
     \hline
     \mathbf{\text{Real (Active) Power}} & \mathbf{P} & \mathbf{\text{Watts (W) or kW}} & \text{Performs actual work (heat, torque)} \\
     \mathbf{\text{Reactive Power}} & \mathbf{Q} & \mathbf{\text{VAR or kVAR}} & \text{Exchanges magnetic/electric field energy} \\
     \mathbf{\text{Apparent Power}} & \mathbf{|\mathbf{S}|} & \mathbf{\text{Volt-Amperes (VA) or kVA}} & \text{Total capacity sizing for cables/transformers} \\
     \hline
     \end{array}$$
   - **Power Factor Correction Sizing:**
     $$\mathbf{Q_C = P \left( \tan\theta_{\text{old}} - \tan\theta_{\text{new}} \right) \implies \mathbf{C = \frac{Q_C}{\omega V_{\text{rms}}^2}}}$$
   - **The Conjugate Invariant:** $\mathbf{I}_{\text{rms}}^*$ ensures that inductive loads (current lags voltage $\theta_v - \theta_i > 0$) have **positive reactive power ($+j Q$)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of power factor correction: (1) measure real power $P$ (kW) and initial power factor $pf_1$ of the factory load, (2) compute initial phase angle $\theta_1 = \cos^{-1}(pf_1)$ and initial reactive power $Q_1 = P \tan\theta_1$, (3) determine target power factor $pf_2$ (e.g. $0.95$) and target angle $\theta_2 = \cos^{-1}(pf_2)$, (4) calculate required capacitive reactive power injection $Q_C = P(\tan\theta_1 - \tan\theta_2)$, (5) compute required shunt capacitance $C = \frac{Q_C}{\omega V_{\text{rms}}^2}$ to install across supply terminals!
3. **Slide 3 (`matching`):** Pair 4 concepts (Real Power $P$ [Watts], Reactive Power $Q$ [VAR], Apparent Power $|\mathbf{S}|$ [VA], Power Factor $pf = \cos\theta$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Lagging (or Inductive). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating shunt capacitor: A factory operates on a $V_{\text{rms}} = 240\text{ V}$, $f = 60\text{ Hz}$ ($\omega = 2\pi(60) \approx 377\text{ rad/s}$) line, drawing active power $P = 48\text{ kW} = 48,000\text{ W}$ at a lagging power factor $pf_1 = 0.60$ ($\theta_1 = \cos^{-1}(0.60) = 53.13^\circ$, $\tan\theta_1 = 1.3333$). It is desired to raise the power factor to $pf_2 = 0.96$ lagging ($\theta_2 = \cos^{-1}(0.96) = 16.26^\circ$, $\tan\theta_2 = 0.2917$). What is the required capacitance $C$ of the shunt capacitor bank? ($Q_C = P(\tan\theta_1 - \tan\theta_2) = 48,000 (1.33333 - 0.29167) = 48,000 (1.04167) = \mathbf{50,000\text{ VAR} = 50\text{ kVAR}}$; $C = \frac{Q_C}{\omega V_{\text{rms}}^2} = \frac{50,000}{(376.99)(240)^2} = \frac{50,000}{(376.99)(57,600)} = \frac{50,000}{21,714,683} \approx 2.3026 \times 10^{-3}\text{ F} \approx \mathbf{2303\text{ }\mu\text{F} \approx 2.30\text{ mF}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ac_phasor_analysis_complex_power_and_power_factor_correction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: AC Complex Power Triangle \\& Power Factor Correction (Steinmetz 1893)**\n• **Complex Power Formulation (RMS Phasors):**\n$$\n\\mathbf{\\mathbf{S} = \\mathbf{V}_{\\text{rms}} \\mathbf{I}_{\\text{rms}}^* = P + j Q = |\\mathbf{S}| \\angle (\\theta_v - \\theta_i) \\quad \\Big| \\quad |\\mathbf{S}| = \\sqrt{P^2 + Q^2} = V_{\\text{rms}} I_{\\text{rms}}}\n$$\n• **Power Triangle Component Units:**\n  - **Real Power ($P$):** Measured in **Watts (W)** $\\to P = V_{\\text{rms}} I_{\\text{rms}} \\cos\\theta$ (Performs actual mechanical work);\n  - **Reactive Power ($Q$):** Measured in **Volt-Amperes Reactive (VAR)** $\\to Q = V_{\\text{rms}} I_{\\text{rms}} \\sin\\theta$ (Magnetizes fields);\n  - **Apparent Power ($|\\mathbf{S}|$):** Measured in **Volt-Amperes (VA)** $\\to |\\mathbf{S}| = V_{\\text{rms}} I_{\\text{rms}}$ (Sizes transformers/cables).\n• **Power Factor Correction Sizing:**\n$$\n\\mathbf{Q_C = P \\left( \\tan\\theta_{\\text{old}} - \\tan\\theta_{\\text{new}} \\right) \\implies \\mathbf{C_{\\text{shunt}} = \\frac{Q_C}{\\omega V_{\\text{rms}}^2}}}\n$$\n• **The Current Reduction Invariant:** Correcting power factor to near unity ($pf \\to 1.0$) drastically reduces line current ($I = P / (V pf)$), eliminating line $I^2 R$ heat losses and voltage drops!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the required shunt capacitor rating to correct an industrial plant's lagging power factor.",
      "orderItems": [
        "Record the active power load P (kW), line voltage V_rms, and initial lagging power factor pf1",
        "Compute the initial phase angle theta1 = acos(pf1) and calculate initial reactive power: Q1 = P * tan(theta1)",
        "Determine the target power factor pf2 and compute target phase angle: theta2 = acos(pf2)",
        "Calculate the required reactive power compensation: Q_C = P * (tan(theta1) - tan(theta2))",
        "Compute the required shunt capacitance: C = Q_C / (omega * V_rms^2) where omega = 2*pi*f"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each AC Power Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Real Power (P) [Watts]", "right": "P = Vrms * Irms * cos\u03b8, the actual usable energy rate converted into mechanical torque or heat" },
        { "left": "Reactive Power (Q) [VAR]", "right": "Q = Vrms * Irms * sin\u03b8, the alternating power exchanged between magnetic and electric fields" },
        { "left": "Apparent Power (|S|) [VA]", "right": "|S| = sqrt(P^2 + Q^2), total volt-ampere rating required to size transmission lines and generators" },
        { "left": "Power Factor (pf = cos\u03b8)", "right": "Ratio of real working power to apparent power (P / |S|), quantifying electrical efficiency" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "An industrial AC electrical load dominated by inductive motors operates with a power factor classified as ___.",
      "blankAnswer": "lagging",
      "blankDistractors": ["leading", "unity", "resonant"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A factory operates on a Vrms = 240 V, 60 Hz (\u03c9 = 377 rad/s) supply, drawing P = 48 kW at a lagging power factor pf1 = 0.60 (tan\u03b81 = 1.3333). Management installs shunt capacitors to raise the power factor to pf2 = 0.96 lagging (tan\u03b82 = 0.2917). What is the required shunt capacitance C?",
      "options": [
        { "text": "C = 2303 \u03bcF (~2.30 mF) (QC = 48 kW * (1.3333 - 0.2917) = 50 kVAR, and C = 50,000 / (377 * 240^2) = 2303 \u03bcF)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using power factor correction principles (Charles Alexander & Matthew Sadiku *Fundamentals of Electric Circuits* Chapter 11). 1. **Calculate Required Reactive Power Injection ($Q_C$):** - Initial angle: $\\theta_1 = \\cos^{-1}(0.60) = 53.130^\\circ \\implies \\tan\\theta_1 = 1.33333$. - Target angle: $\\theta_2 = \\cos^{-1}(0.96) = 16.260^\\circ \\implies \\tan\\theta_2 = 0.29167$. - $$Q_C = P \\left( \\tan\\theta_1 - \\tan\\theta_2 \\right) = 48,000\\text{ W} \\times (1.33333 - 0.29167) = 48,000 \\times 1.04167 = \\mathbf{50,000\\text{ VAR} = 50\\text{ kVAR}}$$ 2. **Calculate Required Capacitance ($C$):** - Supply angular frequency: $\\omega = 2 \\pi (60\\text{ Hz}) \\approx 376.991\\text{ rad/s}$. - $$C = \\frac{Q_C}{\\omega V_{\\text{rms}}^2} = \\frac{50,000\\text{ VAR}}{(376.991\\text{ rad/s})(240\\text{ V})^2} = \\frac{50,000}{376.991 \\times 57,600} = \\frac{50,000}{21,714,682} \\approx \\mathbf{2.3026 \\times 10^{-3}\\text{ F} \\approx 2303\\text{ }\\mu\\text{F}}$$ 3. **Operational Result:** Line current drops from $I_1 = \\frac{48,000}{240 \\times 0.60} = \\mathbf{333.3\\text{ A}}$ down to $I_2 = \\frac{48,000}{240 \\times 0.96} = \\mathbf{208.3\\text{ A}}$, slashing distribution heat losses by **$61\\%$**!" },
        { "text": "C = 500 \u03bcF", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "C = 4606 \u03bcF", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "C = 1150 \u03bcF", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
