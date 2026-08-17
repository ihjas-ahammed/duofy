# Duofy Reusable Lesson Format: Signal Conditioning (ECG/EEG Filtering & Electrical Safety)

**Target Topic:** `04_Engineering_and_Technology / 06_Biomedical_Engineering / Medical_Instrumentation_and_Sensors / Biopotential_Electrodes_ECG_EEG`  
**Lesson Format Type:** `ecg_eeg_biopotential_filtering_and_safety_standards`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the signal conditioning and clinical electrical safety architecture of biopotential recording instruments (ECG, EEG, EMG), the **American Heart Association (AHA) Diagnostic ECG Bandpass Standard ($0.05\text{ Hz} - 150\text{ Hz}$)**, the physiological reason why the high-pass cutoff must be set at $0.05\text{ Hz}$ ($\tau = 3.18\text{ s}$) to prevent phase distortion of the diagnostic ST segment during myocardial infarction, the **Clinical Scalp EEG Bandpass Standard ($0.5\text{ Hz} - 70\text{ Hz}$ with $50/60\text{ Hz}$ Notch)**, and International Electrotechnical Commission **IEC 60601-1 Medical Electrical Safety Standards** (Type B, BF, and CF cardiac-floating patient isolation, auxiliary leakage current limits $<10\text{ }\mu\text{A}$ to prevent microshock ventricular fibrillation) (John G. Webster *Medical Instrumentation: Application and Design* 5th ed. Chapters 6 & 14; IEC 60601-1 3rd ed.): formulate the **Active Sallen-Key Filter Cutoff Master Formulation**:
$$\mathbf{f_c = \frac{1}{2\pi \sqrt{R_1 R_2 C_1 C_2}} \Longleftrightarrow \mathbf{f_c = \frac{1}{2\pi R C} \quad (\text{Equal Components})}}$$
master the **Diagnostic Biopotential Specifications & Safety Matrix**:
$$\begin{array}{|l|c|c|c|l|}
applied\hline
\textbf{Biopotential Signal} & \textbf{Typical Amplitude} & \textbf{Clinical Bandwidth} & \textbf{Preamplifier Gain} & \textbf{Clinical Diagnostic Purpose} \\
\hline
\mathbf{\text{Diagnostic ECG}} & \mathbf{0.5 - 4.0\text{ mV}} & \mathbf{0.05\text{ Hz} - 150\text{ Hz}} & \mathbf{\approx 1,000\times} & \mathbf{\text{Ischemia, ST-elevation MI, arrhythmias}} \\
\text{Monitoring ECG} & 0.5 - 4.0\text{ mV} & 0.5\text{ Hz} - 40\text{ Hz} & \approx 1,000\times & Intensive care heart rate rhythm tracking \\
\mathbf{\text{Scalp EEG}} & \mathbf{10 - 100\text{ }\mu\text{V}} & \mathbf{0.5\text{ Hz} - 70\text{ Hz}} & \mathbf{\approx 20,000 - 50,000\times} & \mathbf{\text{Epilepsy, sleep staging, brain death}} \\
\text{Surface EMG} & 0.1 - 10.0\text{ mV} & 10\text{ Hz} - 500\text{ Hz} & \approx 1,000 - 5,000\times & Neuromuscular pathology, biomechanics \\
\hline
\end{array}$$
master **IEC 60601-1 Patient Isolation Safety Standards**:
$$\begin{array}{|l|l|l|}
\hline
\textbf{Safety Isolation Class} & \textbf{Leakage Limit} & \textbf{Clinical Application} \\
\hline
\text{Type B (Body)} & < 100\text{ }\mu\text{A} & Non-invasive equipment without direct patient contact \\
\text{Type BF (Body Floating)} & < 100\text{ }\mu\text{A} & Surface electrodes (ECG pads, EEG caps, ultrasound) \\
\mathbf{\text{Type CF (Cardiac Floating)}} & \mathbf{< 10\text{ }\mu\text{A}} & \mathbf{\text{Direct cardiac contact (intracardiac catheters, pacemakers)}} \\
\hline
\end{array}$$
and interact with live Ag/AgCl skin impedance solver, 3-Op-Amp INA gain/CMRR designer, Driven Right Leg noise canceller, and Active ECG/EEG filter & safety simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | AHA ECG ($0.05-150\text{ Hz}$), EEG ($0.5-70\text{ Hz}$) & IEC 60601-1 Type CF ($<10\text{ }\mu\text{A}$) Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Design a Complete Diagnostic ECG Acquisition Signal Chain from Electrodes to ADC Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Biomedical Signal Processing / Safety Entity & Technical Regulatory Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The American Heart Association Requires Diagnostic 12-Lead ECG Machines to Have a High-Pass Cutoff of 0.05 Hz to Prevent Phase Distortion of the Critical ___-Segment (ST / ST-Segment) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Medical Instrumentation Studio: Ag/AgCl Electrodes, 3-Op-Amp INA, RLD & Filtering Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ecg_eeg_biopotential_filtering_and_safety_standards",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are the clinical frequency passbands for diagnostic ECG and EEG, and why is 0.05 Hz mandatory for ECG?",
      "blankAnswer": "Biopotential Standards \\& Safety (Webster 2020; IEC 60601-1): (1) DIAGNOSTIC ECG PASSBAND: 0.05 Hz to 150 Hz. The 0.05 Hz high-pass cutoff (\u03c4 = 3.18 s) is legally mandatory to prevent phase distortion and artificial elevation/depression of the ST-segment (critical for diagnosing myocardial infarction). (2) SCALP EEG PASSBAND: 0.5 Hz to 70 Hz for microvolt brainwaves (\u03b4, \u03b8, \u03b1, \u03b2, \u03b3 bands). (3) IEC 60601-1 TYPE CF ISOLATION: Limits patient leakage current to < 10 \u03bcA RMS to eliminate microshock ventricular fibrillation risk during direct cardiac contact!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential signal chain stages in a clinical diagnostic ECG acquisition front-end.",
      "orderItems": [
        "Acquire biopotentials from patient skin using non-polarizable Ag/AgCl electrodes with conductive electrolyte gel",
        "Amplify differential biopotential while rejecting common-mode noise using a 3-Op-Amp INA with Driven Right Leg feedback",
        "Apply analog high-pass filtering at fc = 0.05 Hz to eliminate DC half-cell offset and respiration baseline wander",
        "Apply analog low-pass filtering at fc = 150 Hz to prevent high-frequency muscle tremor noise and aliasing",
        "Transmit signal through galvanically isolated barrier (opto-isolator) to ADC for digital diagnostic display"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Biomedical Instrumentation Standard to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Diagnostic ECG (0.05 - 150 Hz)", "right": "AHA mandatory passband preserving ST-segment fidelity for acute myocardial infarction diagnosis" },
        { "left": "Scalp EEG (0.5 - 70 Hz)", "right": "High-gain (\u2248 50,000\u00d7) bandwidth capturing microvolt cortical oscillations from delta (0.5 Hz) to gamma (70 Hz)" },
        { "left": "Type CF Cardiac Floating", "right": "IEC 60601-1 highest safety class enforcing leakage currents < 10 \u03bcA to prevent fatal microshock" },
        { "left": "Galvanic Isolation Barrier", "right": "Optical or magnetic isolation breaking ground loops to protect patient from catastrophic AC mains faults" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The American Heart Association requires diagnostic 12-lead ECG machines to have a high-pass cutoff of 0.05 Hz to prevent phase distortion of the critical ___-segment.",
      "blankAnswer": "ST",
      "blankDistractors": ["PR", "QRS", "QT"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Medical Instrumentation & Biopotentials Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Medical Instrumentation & Biopotentials Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Ag/AgCl Electrodes, 3-Op-Amp INA, RLD & AHA Filtering</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnElec\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Ag/AgCl (|Z|=20.0 k\u03a9, Ehc=222mV)</button><button id=\"btnIna\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. 3-Op-Amp INA (Ad=100, Rgain=1.01k\u03a9)</button><button id=\"btnRld\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. RLD (AF=201x) & ECG Filter 0.05-150Hz</button></div><div id=\"medLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate biopotential electrode impedance...</div><script>document.getElementById('btnElec').onclick=()=>{document.getElementById('medLog').innerHTML='<b>1. AG/AGCL ELECTRODE-SKIN INTERFACE:</b><br>• Reversible Chemistry: Ag + Cl\u207b &harr; AgCl + e\u207b (Non-Polarizable)<br>• Equivalent Circuit: Z = Rs + Rd / (1 + j\\u03c9RdCd)<br>• <b style=\"color:#10b981;\">Impedance at 10 Hz: |Z| = 20.04 k\\u03a9 | Ehc = +222 mV!</b>';}; document.getElementById('btnIna').onclick=()=>{document.getElementById('medLog').innerHTML='<b>2. THREE-OP-AMP INSTRUMENTATION AMPLIFIER:</b><br>• Stage 1: A_d1 = 1 + 2*R1/Rgain | A_cm1 = 1.00 (Unity)<br>• Target Ad = 100 &rarr; <b style=\"color:#10b981;\">Rgain = 1.01 k\\u03a9 (R1=50 k\\u03a9)!</b><br>• <b style=\"color:#38bdf8;\">CMRR > 100 dB (Precision common-mode rejection)!</b>';}; document.getElementById('btnRld').onclick=()=>{document.getElementById('medLog').innerHTML='<b>3. DRIVEN RIGHT LEG \\& FILTERING STANDARDS:</b><br>• RLD Feedback: Attenuation AF = 201x (46 dB Noise Cut)<br>• Common-Mode Noise: 150 mV &rarr; <b style=\"color:#10b981;\">0.75 mV!</b><br>• Diagnostic ECG: <b style=\"color:#38bdf8;\">0.05 Hz - 150 Hz (ST-segment preservation)</b><br>• Safety: IEC 60601-1 Type CF Leakage < 10 \\u03bcA RMS<br>🏆 <b style=\"color:#10b981;\">Medical_Instrumentation_and_Sensors 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
