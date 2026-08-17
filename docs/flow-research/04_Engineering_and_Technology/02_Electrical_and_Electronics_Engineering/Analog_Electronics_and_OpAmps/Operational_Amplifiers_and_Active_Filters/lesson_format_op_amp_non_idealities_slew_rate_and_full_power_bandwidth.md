# Duofy Reusable Lesson Format: Real Op-Amps (Slew Rate & Full-Power Bandwidth)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Analog_Electronics_and_OpAmps / Operational_Amplifiers_and_Active_Filters`  
**Lesson Format Type:** `op_amp_non_idealities_slew_rate_and_full_power_bandwidth`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through practical operational amplifier non-idealities, Gain-Bandwidth Product ($\text{GBWP}$ / $f_t$), internal Miller frequency compensation capacitor charging limits, Slew Rate ($\text{SR}$), and Full-Power Bandwidth ($f_{\text{max}}$) in high-speed analog electronics (Adel S. Sedra & Kenneth C. Smith *Microelectronic Circuits* Chapter 2; Sergio Franco *Design with Operational Amplifiers* Chapter 6): formulate **Gain-Bandwidth Product (GBWP)**:
$$\mathbf{f_t = |A_{CL}| \times f_{3\text{dB}} \Longleftrightarrow \mathbf{f_{3\text{dB}} = \frac{f_t}{|A_{CL}|}}}$$
(proving that increasing closed-loop gain proportionally reduces small-signal $3\text{-dB}$ bandwidth); derive the **Slew Rate ($\text{SR}$) Physical Mechanism**:
$$\mathbf{\text{SR} = \left. \frac{dv_o}{dt} \right|_{\text{max}} = \frac{I_{\text{tail}}}{C_c} \ \left[\frac{\text{V}}{\mu\text{s}}\right]}$$
where $I_{\text{tail}}$ is the input differential stage bias current and $C_c$ is the internal frequency compensation capacitor; and derive the **Full-Power Bandwidth Equation**:
$$\mathbf{v_o(t) = V_p \sin(2\pi f t) \implies \left. \frac{dv_o}{dt} \right|_{\text{max}} = 2\pi f V_p \le \text{SR} \implies \mathbf{f_{\text{max}} = \frac{\text{SR}}{2\pi V_p}}}$$
(analyzing why attempting to drive full-scale sinusoids beyond $f_{\text{max}}$ degrades the output into a distorted triangle wave).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Slew Rate ($\text{SR} = \frac{I_{\text{tail}}}{C_c}$), Full-Power Bandwidth ($f_{\text{max}} = \frac{\text{SR}}{2\pi V_p}$) & GBWP ($f_t$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Slew-Rate Limited Full-Power Bandwidth Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Op-Amp Non-Ideality / Limiting Parameter & Technical Physical Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Maximum Frequency at Which an Op-Amp Can Produce an Undistorted Full-Scale Peak Sinusoid Is the Full-Power ___ (Bandwidth / FPBW) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | High-Frequency Analog Problem: Calculating Small-Signal f3dB vs Slew-Rate Limited fmax for a 741 Op-Amp Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Op-Amp Non-Idealities & Slew Rate (Sedra & Smith 2020; Franco 2015):
   - **Non-Idealities Formulations:**
     $$\mathbf{\text{SR} = \left. \frac{dv_o}{dt} \right|_{\text{max}} = \frac{I_{\text{tail}}}{C_c} \quad \Big| \quad \mathbf{f_{\text{max}} = \frac{\text{SR}}{2\pi V_p}} \quad \Big| \quad f_{3\text{dB}} = \frac{f_t}{A_{CL}} \quad \Big| \quad V_{o,\text{offset}} = V_{OS} \left(1 + \frac{R_f}{R_1}\right)}$$
   - **Small-Signal vs Large-Signal Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Regime} & \textbf{Limiting Metric} & \textbf{Governing Formula} & \textbf{Distortion Character} \\
     \hline
     \mathbf{\text{Small-Signal } (V_o \ll 1\text{V})} & \text{Gain-Bandwidth Product} & \mathbf{f_{3\text{dB}} = f_t / |A_{CL}|} & \text{Linear low-pass attenuation, no harmonics} \\
     \mathbf{\text{Large-Signal } (V_o \approx V_p)} & \mathbf{\text{Slew Rate (SR)}} & \mathbf{f_{\text{max}} = \text{SR} / (2\pi V_p)} & \mathbf{\text{Non-linear triangular waveshaping distortion}} \\
     \hline
     \end{array}$$
   - **The Slew Distortion Invariant:** Even if small-signal bandwidth is $10\text{ MHz}$, a $10\text{ V}_{\text{peak}}$ sine wave at $1\text{ MHz}$ on an op-amp with $\text{SR} = 0.5\text{ V/}\mu\text{s}$ will turn into a **mutilated triangle wave** because required slew ($62.8\text{ V/}\mu\text{s}$) exceeds capacity by $125\times$!
2. **Slide 2 (`ordering`):** Provide 5 steps of slew rate evaluation: (1) record op-amp slew rate specification $\text{SR}$ (in $\text{V}/\mu\text{s}$) and peak output voltage amplitude $V_p$, (2) differentiate sinusoidal output waveform: $\frac{dv_o}{dt} = 2\pi f V_p \cos(2\pi f t)$, (3) equate peak time-derivative to slew rate: $2\pi f_{\text{max}} V_p = \text{SR}$, (4) solve for full-power bandwidth: $f_{\text{max}} = \frac{\text{SR}}{2\pi V_p}$, (5) compare signal operating frequency $f_{\text{sig}}$ against $f_{\text{max}}$; if $f_{\text{sig}} > f_{\text{max}}$, reduce peak output amplitude or upgrade to a higher-speed op-amp!
3. **Slide 3 (`matching`):** Pair 4 concepts (Slew Rate Limit $I_{\text{tail}}/C_c$, Full-Power Bandwidth $f_{\text{max}} = \text{SR}/(2\pi V_p)$, Gain-Bandwidth Product $f_t = A_{CL} f_{3\text{dB}}$, Input Offset Voltage $V_{OS}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Bandwidth (or FPBW). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating small-signal vs slew-limited bandwidth: A non-inverting op-amp circuit with closed-loop gain $A_{CL} = 20.0\text{ V/V}$ uses a standard op-amp having unity-gain frequency $f_t = 2.0\text{ MHz}$ and slew rate $\text{SR} = 0.50\text{ V/}\mu\text{s} = 5.0 \times 10^5\text{ V/s}$. An input sine wave is applied that produces a large output swing with peak voltage $V_p = 5.0\text{ V}$. What is the small-signal $3\text{-dB}$ bandwidth $f_{3\text{dB}}$, and what is the maximum undistorted full-power bandwidth $f_{\text{max}}$? ($f_{3\text{dB}} = \frac{f_t}{A_{CL}} = \frac{2.0\text{ MHz}}{20.0} = \mathbf{100.0\text{ kHz}}$; Full-power bandwidth: $f_{\text{max}} = \frac{\text{SR}}{2\pi V_p} = \frac{0.50 \times 10^6\text{ V/s}}{2\pi (5.0\text{ V})} = \frac{500,000}{31.4159} \approx \mathbf{15.915\text{ kHz} \approx 15.9\text{ kHz}}$; Notice that large signals distort above $15.9\text{ kHz}$ even though small signals pass cleanly up to $100\text{ kHz}$!).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "op_amp_non_idealities_slew_rate_and_full_power_bandwidth",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Op-Amp Slew Rate \\& Non-Idealities (Sedra \\& Smith)**\n• **Slew Rate Formulation (Internal Miller Capacitor Charging Limit):**\n$$\n\\mathbf{\\text{SR} = \\left. \\frac{dv_o}{dt} \\right|_{\\text{max}} = \\frac{I_{\\text{tail}}}{C_c} \\ \\left[\\frac{\\text{V}}{\\mu\\text{s}}\\right]}\n$$\n• **Full-Power Bandwidth ($f_{\\text{max}}$ for Undistorted Peak Sinusoids):**\n$$\n\\mathbf{v_o(t) = V_p \\sin(2\\pi f t) \\implies \\left. \\frac{dv_o}{dt} \\right|_{\\text{max}} = 2\\pi f V_p \\le \\text{SR} \\implies \\mathbf{f_{\\text{max}} = \\frac{\\text{SR}}{2\\pi V_p}}}\n$$\n• **Small-Signal Gain-Bandwidth Product (GBWP):**\n$$\n\\mathbf{f_{3\\text{dB}} = \\frac{f_t}{|A_{CL}|} \\quad (f_t = \\text{Unity-Gain Frequency})}\n$$\n• **The Large-Signal Slew Distortion Invariant:** When input frequency exceeds $f_{\\text{max}}$, the op-amp output rate cannot track the sinusoid slope at zero crossings, turning clean sine waves into **triangular distorted waveforms** regardless of small-signal bandwidth!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the full-power bandwidth fmax of an op-amp for a given peak output voltage Vp.",
      "orderItems": [
        "Record the manufacturer slew rate rating SR (convert to V/s) and desired peak output voltage Vp",
        "Differentiate the output sinusoidal waveform with respect to time: dvo/dt = 2*pi*f*Vp*cos(2*pi*f*t)",
        "Identify the maximum slope point occurring at sinusoidal zero-crossings: (dvo/dt)_max = 2*pi*f*Vp",
        "Equate the maximum waveform slope to the op-amp slew rate capacity: 2*pi*fmax*Vp = SR",
        "Solve for the full-power bandwidth: fmax = SR / (2 * pi * Vp) and confirm operation below this limit"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Op-Amp Non-Ideality to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Slew Rate (SR)", "right": "SR = Itail / Cc, maximum possible rate of change of output voltage governed by compensation capacitor charging" },
        { "left": "Full-Power Bandwidth (fmax)", "right": "fmax = SR / (2\u03c0*Vp), highest frequency producing undistorted full-scale sinusoidal output" },
        { "left": "Gain-Bandwidth Product (ft)", "right": "f3dB = ft / ACL, constant trading closed-loop gain directly against small-signal bandwidth" },
        { "left": "Input Offset Voltage (VOS)", "right": "Small DC differential voltage required between inputs to force the unloaded output voltage to zero" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The maximum frequency at which an op-amp can output an undistorted full-scale sinusoidal voltage is the full-power ___.",
      "blankAnswer": "bandwidth",
      "blankDistractors": ["gain", "slew", "margin"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A non-inverting op-amp stage has gain ACL = 20.0 V/V using an op-amp with unity-gain frequency ft = 2.0 MHz and slew rate SR = 0.50 V/\u03bcs. The output delivers a peak voltage swing Vp = 5.0 V. What is the small-signal 3-dB bandwidth f3dB and the full-power bandwidth fmax?",
      "options": [
        { "text": "f3dB = 100.0 kHz and fmax = 15.9 kHz (f3dB = 2.0 MHz / 20.0 = 100 kHz; and fmax = (0.50*10^6 V/s) / (2\u03c0 * 5.0 V) = 15.915 kHz)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using small-signal and large-signal op-amp equations (Adel Sedra & Kenneth Smith *Microelectronic Circuits* Chapter 2). 1. **Calculate Small-Signal 3-dB Bandwidth ($f_{3\\text{dB}}$):** $$f_{3\\text{dB}} = \\frac{f_t}{A_{CL}} = \\frac{2.00 \\times 10^6\\text{ Hz}}{20.0} = 100,000\\text{ Hz} = \\mathbf{100.0\\text{ kHz}}$$ 2. **Calculate Full-Power Bandwidth ($f_{\\text{max}}$):** - Slew rate $\\text{SR} = 0.50\\text{ V/}\\mu\\text{s} = 5.0 \\times 10^5\\text{ V/s}$. - Peak voltage $V_p = 5.0\\text{ V}$. $$f_{\\text{max}} = \\frac{\\text{SR}}{2 \\pi V_p} = \\frac{5.0 \\times 10^5\\text{ V/s}}{2 \\pi \\times (5.0\\text{ V})} = \\frac{500,000}{31.4159265\\text{ V}} = \\mathbf{15,915.5\\text{ Hz} \\approx 15.9\\text{ kHz}}$$ 3. **Critical Engineering Takeaway:** - If you feed a $100\\text{ mV}_{\\text{peak}}$ small signal ($V_p = 2.0\\text{ V}$), the circuit operates up to $100\\text{ kHz}$. - But if you feed a full-scale signal resulting in $V_p = 5.0\\text{ V}$, the output becomes **slew-rate limited and severely distorted above $15.9\\text{ kHz}$**!" },
        { "text": "f3dB = 100.0 kHz and fmax = 100.0 kHz", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "f3dB = 20.0 kHz and fmax = 15.9 kHz", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "f3dB = 100.0 kHz and fmax = 31.8 kHz", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
