# Duofy Reusable Lesson Format: Active Noise Cancellation (Driven Right Leg Circuit)

**Target Topic:** `04_Engineering_and_Technology / 06_Biomedical_Engineering / Medical_Instrumentation_and_Sensors / Biopotential_Electrodes_ECG_EEG`  
**Lesson Format Type:** `driven_right_leg_circuit_and_mains_noise_cancellation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the problem of 50/60 Hz power line displacement current interference ($i_{\text{disp}} \approx 0.5 - 2.0\text{ }\mu\text{A}$) capacitively coupled from building mains wiring into the human patient, the resulting common-mode voltage ($v_{cm} = i_{\text{disp}} R_{\text{ground}} \approx 100 - 500\text{ mV}$), Bruce B. Winter and John G. Webster's 1983 **Driven Right Leg (RLD / DRL)** circuit, active negative feedback common-mode cancellation, summing resistors ($R_{\text{in}} / 2$), inverting auxiliary op-amp feedback ($R_f$), the equivalent patient-to-ground impedance reduction ($R_{\text{eff}} = \frac{R_{\text{RLD}}}{1 + 2 R_f / R_{\text{in}}}$), and clinical patient electrical safety (John G. Webster *Medical Instrumentation: Application and Design* 5th ed. Chapter 6; Bruce B. Winter & John G. Webster 1983): formulate the **Driven Right Leg (RLD) Common-Mode Voltage Master Formulation**:
$$\mathbf{v_{cm,\text{patient}} = \frac{i_{\text{disp}} \cdot R_{\text{RLD}}}{1 + \frac{2 R_f}{R_{\text{in}}}} \Longleftrightarrow \mathbf{R_{\text{eff,ground}} = \frac{R_{\text{RLD}}}{1 + \frac{2 R_f}{R_{\text{in}}}} \quad [\Omega]}}$$
where:
1. **$v_{cm,\text{patient}}$:** Residual common-mode voltage remaining on the patient's body (reduced from $>200\text{ mV}$ down to $<1\text{ mV}$!);
2. **$i_{\text{disp}}$:** Capacitively coupled 50/60 Hz displacement current from ambient AC electrical power lines ($\approx 1.0\text{ }\mu\text{A}$);
3. **$R_{\text{RLD}}$:** Right-leg electrode-skin contact resistance plus safety current-limiting resistor ($\approx 50 - 100\text{ k}\Omega$);
4. **$R_{\text{in}}$:** Resistors sensing common-mode voltage from the two input buffer outputs ($R_a = R_b = R_{\text{in}}$);
5. **$R_f$:** Auxiliary RLD feedback resistor establishing loop gain ($\approx 1 - 5\text{ M}\Omega$);
derive the **Common-Mode Noise Attenuation Factor ($AF_{\text{RLD}}$)**:
$$\mathbf{AF_{\text{RLD}} = \frac{v_{cm,\text{open}}}{v_{cm,\text{driven}}} = 1 + \frac{2 R_f}{R_{\text{in}}} \quad \left(AF_{\text{RLD}} \approx 40 - 60\text{ dB Reduction!}\right)}$$
(proving that the RLD circuit acts as an active electronic "virtual ground" that actively drives the patient's body to zero common-mode potential, eliminating 50/60 Hz noise without creating a hazardous low-resistance direct ground path).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | RLD Feedback ($v_{cm} = \frac{i_{\text{disp}} R_{\text{RLD}}}{1 + 2 R_f / R_{\text{in}}}$), $AF = 1 + 2R_f/R_{\text{in}}$ & Virtual Ground Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Unattenuated Common-Mode Noise, RLD Feedback Gain, and Residual Patient Voltage Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Driven Right Leg Circuit Element / Interference Parameter & Technical Biopotential Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Driven Right Leg (RLD) Circuit Actively Cancels 50/60 Hz Power Line Noise by Inverting the Patient's Common-Mode Potential and Feeding It Back to the Patient's Body Through an Auxiliary ___ Amplifier (Inverting / Operational / Op-Amp) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Clinical Instrumentation Problem: Calculating Common-Mode Noise Attenuation and Residual Voltage with an RLD Circuit Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Driven Right Leg Circuit Mechanics (Winter & Webster 1983; Webster 2020):
   - **RLD Formulations:**
     $$\mathbf{v_{cm} = \frac{i_{\text{disp}} R_{\text{RLD}}}{1 + \frac{2 R_f}{R_{\text{in}}}} \quad \Big| \quad R_{\text{eff}} = \frac{R_{\text{RLD}}}{1 + \frac{2 R_f}{R_{\text{in}}}} \quad \Big| \quad AF = 1 + \frac{2 R_f}{R_{\text{in}}} \quad \Big| \quad v_{\text{RLD,out}} = -\frac{2 R_f}{R_{\text{in}}} v_{cm}}$$
   - **Grounding Architecture Comparison Matrix:**
     $$\begin{array}{|l|c|c|l|}
     \hline
     \textbf{Patient Grounding Strategy} & \textbf{Effective } R_{\text{ground}} & \textbf{Common-Mode Noise } v_{cm} & \textbf{Clinical Electrical Safety} \\
     \hline
     \mathbf{\text{Direct Earth Grounding}} & \approx 50\text{ k}\Omega & \approx 50\text{ mV} & \mathbf{\text{FATAL Hazard (Direct microshock / macroshock path!)}} \\
     \text{Passive High-Impedance Ground} & \approx 100\text{ k}\Omega & \approx 100 - 200\text{ mV} & Safe, but severe 50/60 Hz trace distortion \\
     \mathbf{\text{Active Driven Right Leg (RLD)}} & \mathbf{\approx 500\text{ }\Omega \ (\text{Active}) } & \mathbf{< 1.0\text{ mV} \ (99\% \text{ noise cut})} & \mathbf{\text{Safe (Current-limited by } 100\text{ k}\Omega \text{ series resistor)}} \\
     \hline
     \end{array}$$
   - **The Active Cancellation Invariant:** The auxiliary RLD op-amp senses average common-mode voltage $(v_1 + v_2)/2$, inverts it to create $-G_{\text{RLD}} v_{cm}$, and **drives it into the right leg to cancel ambient displacement currents at their biological point of entry**!
2. **Slide 2 (`ordering`):** Provide 5 steps of RLD noise analysis: (1) determine ambient mains displacement current $i_{\text{disp}}$ (e.g. $1.0\text{ }\mu\text{A}$) and right-leg resistance $R_{\text{RLD}}$, (2) calculate passive unattenuated common-mode voltage: $v_{cm,\text{open}} = i_{\text{disp}} \cdot R_{\text{RLD}}$, (3) determine sensing resistors $R_{\text{in}}$ and feedback resistor $R_f$ to calculate loop gain: $G_{\text{loop}} = 2 R_f / R_{\text{in}}$, (4) compute the attenuation factor: $AF = 1 + 2 R_f / R_{\text{in}}$, (5) calculate residual patient common-mode voltage: $v_{cm,\text{driven}} = v_{cm,\text{open}} / AF$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Driven Right Leg RLD, Displacement Current $i_{\text{disp}}$, Attenuation Factor $AF$, Safety Resistor $R_{\text{limit}}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Inverting (or Operational / Op-Amp). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating RLD common-mode voltage: Ambient $60\text{ Hz}$ power wiring couples a displacement current $i_{\text{disp}} = 1.50\text{ }\mu\text{A} = 1.50 \times 10^{-6}\text{ A}$ into an ECG patient. The right leg electrode contact plus safety resistance is $R_{\text{RLD}} = 100.0\text{ k}\Omega = 100,000.0\text{ }\Omega$.
   - Without RLD, passive common-mode voltage is:
     $v_{cm,\text{open}} = i_{\text{disp}} \cdot R_{\text{RLD}} = (1.50 \times 10^{-6}\text{ A}) \times 100,000.0\text{ }\Omega = \mathbf{0.150\text{ V} = 150.0\text{ mV}}$;
   - The RLD circuit uses sensing resistors $R_{\text{in}} = 20.0\text{ k}\Omega$ and feedback resistor $R_f = 2.0\text{ M}\Omega = 2000.0\text{ k}\Omega$;
   - Loop gain factor:
     $\frac{2 R_f}{R_{\text{in}}} = \frac{2 \times 2000.0\text{ k}\Omega}{20.0\text{ k}\Omega} = \frac{4000.0}{20.0} = \mathbf{200.0}$;
   - Attenuation factor: $AF = 1 + 200.0 = \mathbf{201.0}$;
   - Residual common-mode voltage on patient:
     $v_{cm,\text{driven}} = \frac{v_{cm,\text{open}}}{AF} = \frac{150.0\text{ mV}}{201.0} = \mathbf{0.7463\text{ mV} \approx 0.75\text{ mV}}$ (Attenuated by $200\times$ from $150\text{ mV}$ down to $<1\text{ mV}$!);
   - What are the open-loop common-mode voltage $v_{cm,\text{open}}$ and the residual voltage $v_{cm,\text{driven}}$ with RLD? ($v_{cm,\text{open}} = \mathbf{150.0\text{ mV}}$ and $v_{cm,\text{driven}} = \mathbf{0.75\text{ mV}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "driven_right_leg_circuit_and_mains_noise_cancellation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Driven Right Leg Circuit \\& Noise Cancellation (Winter \\& Webster 1983)**\n• **Driven Right Leg (RLD) Common-Mode Voltage Master Formulation:**\n$$\n\\mathbf{v_{cm,\\text{patient}} = \\frac{i_{\\text{disp}} \\cdot R_{\\text{RLD}}}{1 + \\frac{2 R_f}{R_{\\text{in}}}} \\Longleftrightarrow R_{\\text{eff,ground}} = \\frac{R_{\\text{RLD}}}{1 + \\frac{2 R_f}{R_{\\text{in}}}} \\quad [\\text{Volts}]}\n$$\n  - **$i_{\\text{disp}}$:** Capacitively coupled 50/60 Hz power line displacement current ($\\approx 0.5 - 2.0\\text{ }\\mu\\text{A}$);\n  - **$R_{\\text{RLD}}$:** Right leg electrode resistance + safety current-limiting resistor ($\\approx 100\\text{ k}\\Omega$);\n  - **$R_{\\text{in}}, R_f$:** Common-mode sensing resistors and inverting feedback resistor;\n• **Common-Mode Attenuation Factor Formulation ($AF$):**\n$$\n\\mathbf{AF = 1 + \\frac{2 R_f}{R_{\\text{in}}} \\quad (\\text{Typical attenuation } AF \\approx 100 - 300 \\equiv 40 - 50\\text{ dB reduction})}\n$$\n• **The Virtual Ground Invariant:** RLD actively inverts sensed body potential and **drives negative cancellation current back to the patient**, creating an active virtual ground that crushes 50/60 Hz noise to $<1\\text{ mV}$ while retaining safety isolation!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to evaluate 50/60 Hz interference cancellation using an active Driven Right Leg (RLD) circuit.",
      "orderItems": [
        "Determine the ambient power line displacement current idisp coupled into the patient's torso",
        "Calculate the baseline unattenuated common-mode voltage: v_cm,open = idisp * R_RLD",
        "Extract the RLD sensing resistors Rin and feedback resistor Rf to calculate active feedback gain: G_loop = 2*Rf / Rin",
        "Calculate the total common-mode noise attenuation factor: AF = 1 + (2*Rf / Rin)",
        "Compute the reduced residual common-mode voltage on the patient: v_cm,driven = v_cm,open / AF"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Driven Right Leg Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Driven Right Leg (RLD)", "right": "Active feedback circuit inverting sensed common-mode noise and injecting cancellation current into patient's body" },
        { "left": "Displacement Current (idisp)", "right": "Capacitively coupled 50/60 Hz AC current (\u2248 1 \u03bcA) leaking from room mains wiring into the human torso" },
        { "left": "Attenuation Factor (AF)", "right": "AF = 1 + 2Rf/Rin, factor by which active RLD feedback reduces patient common-mode noise voltage" },
        { "left": "Safety Resistor (\u2248 100 k\u03a9)", "right": "Current-limiting resistor in series with right leg preventing lethal macroshock if op-amp fails to rail" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Driven Right Leg (RLD) circuit actively cancels 50/60 Hz power line noise by inverting the patient's common-mode potential and feeding it back to the patient's body through an auxiliary ___ amplifier.",
      "blankAnswer": "inverting",
      "blankDistractors": ["buffer", "differential", "logarithmic"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Ambient 60 Hz wiring couples idisp = 1.50 \u03bcA into an ECG patient. R_RLD = 100.0 k\u03a9. Without RLD, v_cm,open = 1.50 \u03bcA * 100 k\u03a9 = 150.0 mV. The RLD circuit has Rin = 20.0 k\u03a9 and Rf = 2.0 M\u03a9 (2*Rf / Rin = 2 * 2000 / 20 = 200.0 \u2192 AF = 1 + 200 = 201.0). What is the unattenuated voltage v_cm,open and the residual common-mode voltage v_cm,driven with RLD?",
      "options": [
        { "text": "v_cm,open = 150.0 mV and v_cm,driven = 0.75 mV (v_cm,open = 150.0 mV; v_cm,driven = 150.0 mV / 201.0 = 0.746 mV \u2248 0.75 mV)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Driven Right Leg (RLD) active noise cancellation equations (Bruce B. Winter & John G. Webster 1983; John G. Webster *Medical Instrumentation* Chapter 6). 1. **Calculate Passive Unattenuated Common-Mode Voltage ($v_{cm,\\text{open}}$):** - Displacement current: $i_{\\text{disp}} = 1.50\\text{ }\\mu\\text{A} = 1.50 \\times 10^{-6}\\text{ A}$. - Right leg electrode resistance: $R_{\\text{RLD}} = 100.0\\text{ k}\\Omega = 100,000.0\\text{ }\\Omega$. $$v_{cm,\\text{open}} = i_{\\text{disp}} \\cdot R_{\\text{RLD}} = (1.50 \\times 10^{-6}\\text{ A}) \\times 100,000.0\\text{ }\\Omega = \\mathbf{0.1500\\text{ V} = 150.0\\text{ mV}}$$ 2. **Calculate Active RLD Feedback Loop Gain ($\\frac{2 R_f}{R_{\\text{in}}}$):** - Sensing resistors: $R_{\\text{in}} = 20.0\\text{ k}\\Omega$. - Inverting feedback resistor: $R_f = 2.0\\text{ M}\\Omega = 2000.0\\text{ k}\\Omega$. $$\\text{Loop Gain} = \\frac{2 R_f}{R_{\\text{in}}} = \\frac{2 \\times 2000.0\\text{ k}\\Omega}{20.0\\text{ k}\\Omega} = \\frac{4000.0}{20.0} = \\mathbf{200.0}$$ 3. **Calculate Common-Mode Noise Attenuation Factor ($AF$):** $$AF = 1 + \\frac{2 R_f}{R_{\\text{in}}} = 1 + 200.0 = \\mathbf{201.0}$$ - Logarithmic attenuation: $20 \\log_{10}(201.0) = \\mathbf{46.06\\text{ dB reduction}}$. 4. **Calculate Residual Common-Mode Voltage on Patient ($v_{cm,\\text{driven}}$):** $$v_{cm,\\text{driven}} = \\frac{v_{cm,\\text{open}}}{AF} = \\frac{150.0\\text{ mV}}{201.0} = \\mathbf{0.74627\\text{ mV} \\approx 0.75\\text{ mV}}$$ - The RLD circuit slashes the common-mode voltage from a disruptive $150\\text{ mV}$ down to a harmless sub-millivolt $0.75\\text{ mV}$! Flawless Driven Right Leg active noise reduction derivation!" },
        { "text": "v_cm,open = 150.0 mV and v_cm,driven = 15.0 mV", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "v_cm,open = 1.50 mV and v_cm,driven = 0.01 mV", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "v_cm,open = 150.0 mV and v_cm,driven = 75.0 mV", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
