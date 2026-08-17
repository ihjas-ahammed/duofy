# Duofy Reusable Lesson Format: Active Filters (Sallen-Key & 2nd-Order Butterworth)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Analog_Electronics_and_OpAmps / Operational_Amplifiers_and_Active_Filters`  
**Lesson Format Type:** `second_order_sallen_key_active_filters_and_butterworth_synthesis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify active filter synthesis, Voltage-Controlled Voltage-Source ($\text{VCVS}$) topologies, second-order Sallen-Key low-pass filter design, quality factor ($Q$), natural cut-off frequency ($\omega_0$), and maximally flat Butterworth filter polynomials in audio and anti-aliasing ADC signal conditioning (R. P. Sallen & E. L. Key 1955; Sergio Franco *Design with Operational Amplifiers* Chapter 3; Adel S. Sedra & Kenneth C. Smith *Microelectronic Circuits* Chapter 15): formulate the **Second-Order Low-Pass Transfer Function**:
$$\mathbf{H(s) = \frac{K \omega_0^2}{s^2 + \left(\frac{\omega_0}{Q}\right) s + \omega_0^2} \quad \left(K = 1 + \frac{R_B}{R_A} = \text{Passband DC Gain}\right)}$$
derive the **Sallen-Key Component Relationships**:
$$\mathbf{\omega_0 = \frac{1}{\sqrt{R_1 R_2 C_1 C_2}} \quad \Big| \quad \mathbf{Q = \frac{\sqrt{R_1 R_2 C_1 C_2}}{C_2(R_1 + R_2) + (1 - K) R_1 C_1}}}$$
master the **Equal-Component Sallen-Key Design Strategy**:
- For Unity Gain ($K = 1, \ R_1 = R_2 = R$):
  $$\mathbf{\omega_0 = \frac{1}{R\sqrt{C_1 C_2}} \quad \Big| \quad \mathbf{Q = \frac{1}{2} \sqrt{\frac{C_1}{C_2}} \implies \mathbf{C_1 = 4 Q^2 C_2}}}$$
- For **Maximally Flat Butterworth Response ($\mathbf{Q = \frac{1}{\sqrt{2}} \approx 0.7071}$)**:
  $$\mathbf{C_1 = 4 \left(\frac{1}{\sqrt{2}}\right)^2 C_2 = 2 C_2 \quad \left(C_1 \text{ must be exactly double } C_2!\right)}$$
and interact with live Op-Amp inverting/non-inverting simulator, Three-Op-Amp INA bridge tester, Slew rate / full-power bandwidth animator, and Sallen-Key Butterworth filter frequency response synthesizer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Sallen-Key Low-Pass ($H(s) = \frac{\omega_0^2}{s^2 + \frac{\omega_0}{Q}s + \omega_0^2}$), Butterworth ($Q = \frac{1}{\sqrt{2}}$) & Sizing Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Sallen-Key Filter Parameter / Characteristic & Technical Design Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Sallen-Key Active Filters Are Widely Preferred Over Passive R-L-C Filters for Audio and Low Frequencies Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | To Achieve a Maximally Flat 2nd-Order Butterworth Response (Q = 0.707) in an Equal-Resistor Sallen-Key Filter, Capacitor C1 Must Be Exactly ___ Times C2 (Two / 2) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Op-Amps & Active Filters Studio: Golden Rules, INA Bridges, Slew Rate & Sallen-Key Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "second_order_sallen_key_active_filters_and_butterworth_synthesis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Sallen-Key Active Filter topology, and how are components sized for a 2nd-order Butterworth low-pass filter?",
      "blankAnswer": "Sallen-Key Active Filter (Sallen & Key 1955; Sergio Franco): (1) SALLEN-KEY TOPOLOGY: Non-inverting op-amp VCVS filter using 2 resistors and 2 capacitors to synthesize a 2nd-order biquad H(s) = K*\u03c90^2 / (s^2 + (\u03c90/Q)*s + \u03c90^2). (2) FREQUENCY: \u03c90 = 1 / \u221a(R1*R2*C1*C2). (3) QUALITY FACTOR (Equal-R, R1=R2=R, K=1): Q = 0.5 * \u221a(C1 / C2). (4) BUTTERWORTH DESIGN (Q = 1/\u221a2 \u2248 0.7071): Setting Q = 0.7071 forces C1 = 4*Q^2*C2 = 4*(0.5)*C2 = 2*C2. To design for cutoff f0: pick C2, set C1 = 2*C2, then compute R = 1 / (2\u03c0 * f0 * \u221a(2) * C2)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Active Filter Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Sallen-Key Low-Pass", "right": "H(s) = K*\u03c90^2 / (s^2 + (\u03c90/Q)s + \u03c90^2), 2nd-order VCVS active filter eliminating heavy inductors" },
        { "left": "Butterworth Response (Q = 0.707)", "right": "Maximally flat passband with zero passband ripple and monotonic -40 dB/decade roll-off" },
        { "left": "Chebyshev Response (Q > 0.707)", "right": "Steeper transition band roll-off achieved at the expense of equiripple variations in the passband" },
        { "left": "Equal-Resistor Sizing Rule", "right": "C1 = 2*C2, capacitor ratio enforcing Butterworth Q = 1/\u221a2 when R1 = R2 = R and K = 1" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In analog audio processing, biomedical sensors, and anti-aliasing ADC inputs below 1 MHz, why are active op-amp filters (such as the Sallen-Key topology) overwhelmingly chosen instead of classic passive R-L-C filters?",
      "options": [
        { "text": "At low and audio frequencies (e.g. 10 Hz to 20 kHz), passive inductors (L) require massive physical size, heavy magnetic cores, and high copper wire resistance (low intrinsic inductor Q), which introduce severe losses and electromagnetic interference (EMI) pickup; active RC filters synthesize complex conjugate poles using compact capacitors, resistors, and op-amps without requiring any inductors, while op-amp buffer isolation prevents interstage loading when cascading multiple 2nd-order biquads", "isCorrect": true, "explanation": "Correct! This is Sergio Franco and Adel Sedra's classic motivation for active filter synthesis (*Design with Operational Amplifiers* Chapter 3; *Microelectronic Circuits* Chapter 15). 1. **The Low-Frequency Inductor Curse:** - At audio frequencies ($f = 100\\text{ Hz}$), an RLC filter often requires inductors on the order of **Henry ($1\\text{ H}$ to $10\\text{ H}$)**. - A $1\\text{ H}$ inductor is heavy, bulky (weighing several kilograms), expensive, lossy (high internal series resistance $R_s$), and acts as an open antenna picking up $60\\text{ Hz}$ magnetic fields from nearby transformers. 2. **The Active RC Solution:** - R. P. Sallen and E. L. Key (1955) proved that an active amplifier (op-amp) with negative/positive RC feedback creates **complex conjugate poles** identical to an LC tank, **completely eliminating inductors**! 3. **Cascadability Advantage:** - Because op-amps provide zero output impedance ($R_{\\text{out}} = 0$), engineers can cascade 2nd-order stages (e.g. 2nd-order + 2nd-order = 4th-order filter) without any impedance loading between stages!" },
        { "text": "Because inductors do not follow Ohm's law", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because passive filters cannot block high frequencies", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because op-amps only work with AC signals", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "To achieve a maximally flat 2nd-order Butterworth response in an equal-resistor Sallen-Key filter, capacitor C1 must be exactly ___ times C2.",
      "blankAnswer": "2",
      "blankDistractors": ["4", "10", "1"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Op-Amps & Active Filters Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Op-Amps & Active Filters Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Golden Rules, INA Bridges, Slew Rate & Sallen-Key</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnG\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Non-Inv Op-Amp (Av=10, 1.2V)</button><button id=\"btnIna\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. INA Bridge (RG=200.4\u03a9, Ad=500)</button><button id=\"btnFil\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Slew Rate & Sallen-Key (C1=2C2)</button></div><div id=\"opLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate non-inverting op-amp...</div><script>document.getElementById('btnG').onclick=()=>{document.getElementById('opLog').innerHTML='<b>1. NON-INVERTING OP-AMP:</b><br>• Rf = 90k\\u03a9, R1 = 10k\\u03a9 &rarr; <b style=\"color:#10b981;\">Av = 1 + 90/10 = 10.0 V/V!</b><br>• vo = 10.0 * 120 mV = 1.20 V (i_in = 0 A)<br>• Virtual Short: v- = v+ = 120 mV!';}; document.getElementById('btnIna').onclick=()=>{document.getElementById('opLog').innerHTML='<b>2. THREE-OP-AMP INA BRIDGE:</b><br>• Full scale \u0394vin = 10mV &rarr; vo = 5.0V (Ad = 500)<br>• <b style=\"color:#38bdf8;\">RG = 2*50k / (500 - 1) = 200.4 \\u03a9!</b><br>• CMRR > 100 dB (Strips 60Hz common noise)!';}; document.getElementById('btnFil').onclick=()=>{document.getElementById('opLog').innerHTML='<b>3. SLEW RATE \\& SALLEN-KEY FILTER:</b><br>• Slew Rate Limit: fmax = SR / (2\\u03c0*Vp) = 15.9 kHz<br>• Sallen-Key 2nd-order Butterworth (Q = 0.7071)<br>• Equal-R Sizing: <b style=\"color:#10b981;\">C1 = 2*C2!</b><br>🏆 <b style=\"color:#10b981;\">Analog_Electronics_and_OpAmps (ALL 3 LEAF DIRS) 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
