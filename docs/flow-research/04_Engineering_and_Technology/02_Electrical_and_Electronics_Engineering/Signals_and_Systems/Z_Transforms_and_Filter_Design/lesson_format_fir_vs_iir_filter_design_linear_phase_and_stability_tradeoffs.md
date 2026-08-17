# Duofy Reusable Lesson Format: Digital Filters (FIR vs IIR Architectures & Linear Phase)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Signals_and_Systems / Z_Transforms_and_Filter_Design`  
**Lesson Format Type:** `fir_vs_iir_filter_design_linear_phase_and_stability_tradeoffs`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through digital filter classification, Finite Impulse Response (FIR) non-recursive architectures, Infinite Impulse Response (IIR) recursive feedback structures, exact linear phase conditions, group delay ($\tau_g$), and design tradeoffs in digital signal processing (Alan V. Oppenheim & Ronald W. Schafer *Discrete-Time Signal Processing* Chapters 5 & 7; John G. Proakis *Digital Signal Processing* Chapters 8 & 10): formulate the **Two Master Digital Filter Architectures**:
1. **FIR Filter (Non-Recursive, Moving Average):**
   $$\mathbf{y[n] = \sum_{k=0}^M b_k x[n - k] \Longleftrightarrow H(z) = \sum_{k=0}^M b_k z^{-k} \quad (\text{All } M \text{ poles located at origin } z = 0)}$$
   - **Guaranteed Stability:** Because all poles are at $z = 0$, FIR filters are **strictly unconditionally BIBO stable**!
   - **Exact Linear Phase Condition:** Achieved if impulse response is symmetric ($h[n] = h[M-n]$) or antisymmetric ($h[n] = -h[M-n]$), producing **constant group delay $\mathbf{\tau_g = \frac{M}{2}}$ samples** (zero phase distortion, preserving pulse shapes in audio/telecom);
2. **IIR Filter (Recursive Feedback, Autoregressive Moving Average):**
   $$\mathbf{y[n] = \sum_{k=0}^M b_k x[n - k] - \sum_{k=1}^N a_k y[n - k] \Longleftrightarrow H(z) = \frac{\sum_{k=0}^M b_k z^{-k}}{1 + \sum_{k=1}^N a_k z^{-k}}}$$
   - **High Computational Efficiency:** Reaches sharp roll-off with **orders of magnitude fewer coefficients** than FIR;
   - **Tradeoffs:** Non-linear phase response (phase distortion) and conditional stability ($|p_k| < 1$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | FIR ($H(z) = \sum b_k z^{-k}$) vs IIR ($H(z) = \frac{B(z)}{A(z)}$), Stability & Linear Phase ($\tau_g = \frac{M}{2}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Select Between FIR and IIR Filter Topologies Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Digital Filter Class / Architectural Property & Technical Performance Metric Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | A Symmetric FIR Digital Filter of Order M Has a Constant Frequency-Independent Group Delay Equal to M Divided by ___ (Two / 2) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | DSP Architecture Problem: Evaluating Group Delay and Filter Class for a Symmetric 6-Tap Filter Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State FIR vs IIR Filters (Oppenheim & Schafer 2010; Proakis 2007):
   - **Filter Architectures Formulations:**
     $$\mathbf{\text{FIR: } H(z) = \sum_{k=0}^M b_k z^{-k} \quad \Big| \quad \text{IIR: } H(z) = \frac{\sum_{k=0}^M b_k z^{-k}}{1 + \sum_{k=1}^N a_k z^{-k}} \quad \Big| \quad \tau_g = -\frac{d\theta(\omega)}{d\omega} = \frac{M}{2}}$$
   - **Architectural Comparison Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Filter Property} & \textbf{FIR (Finite Impulse Response)} & \textbf{IIR (Infinite Impulse Response)} \\
     \hline
     \mathbf{\text{Structure}} & \text{Non-recursive (feedforward only)} & \text{Recursive (feedback loops)} \\
     \mathbf{\text{Pole Locations}} & \mathbf{\text{All poles at origin } z = 0} & \text{Poles located anywhere in } |z| < 1 \\
     \mathbf{\text{BIBO Stability}} & \mathbf{\text{Unconditionally Guaranteed}} & \text{Conditional (must ensure } |p| < 1) \\
     \mathbf{\text{Phase Response}} & \mathbf{\text{Exact Linear Phase achievable}} & \text{Non-linear phase (group delay distortion)} \\
     \mathbf{\text{Computational Order}} & \text{Higher order (more taps needed)} & \mathbf{\text{Low order (highly efficient)}} \\
     \hline
     \end{array}$$
   - **The Linear Phase Invariant:** Linear phase requires **exact coefficient symmetry ($h[n] = \pm h[M-n]$)**, which is **mathematically impossible for causal stable IIR filters**!
2. **Slide 2 (`ordering`):** Provide 5 steps of digital filter selection: (1) review application phase requirements (if zero phase distortion/waveform preservation needed, select FIR), (2) review hardware budget (if strict resource limits and steep roll-off required, select IIR), (3) for FIR, choose window method (Hamming, Kaiser) or Parks-McClellan Remez exchange to size filter order $M$, (4) verify coefficient symmetry $h[n] = h[M-n]$ to guarantee linear phase, (5) calculate constant group delay $\tau_g = M/2$ samples!
3. **Slide 3 (`matching`):** Pair 4 concepts (FIR Stability Guarantee, IIR Efficiency, Linear Phase Symmetry $h[n]=h[M-n]$, Constant Group Delay $\tau_g=M/2$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 2 (or Two). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on FIR linear phase and group delay: A digital audio processing system uses a causal, Type-I linear-phase FIR low-pass filter with $N = 11$ taps ($M = N - 1 = 10$ filter order) with symmetric coefficients $h[n] = h[10 - n]$ operating at sampling rate $f_s = 48\text{ kHz}$. What is the filter's constant group delay $\tau_g$ in samples and in milliseconds? ($\tau_g = \frac{M}{2} = \frac{10}{2} = \mathbf{5.0\text{ samples}}$; Time delay $\tau_{\text{time}} = \frac{\tau_g}{f_s} = \frac{5.0}{48,000\text{ Hz}} = \frac{5}{48} \times 10^{-3}\text{ s} \approx \mathbf{0.1042\text{ ms}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "fir_vs_iir_filter_design_linear_phase_and_stability_tradeoffs",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: FIR vs IIR Digital Filter Architectures (Oppenheim \\& Schafer)**\n• **Mathematical Transfer Function Formulations:**\n$$\n\\mathbf{\\text{FIR: } H(z) = \\sum_{k=0}^M b_k z^{-k} \\quad \\Big| \\quad \\text{IIR: } H(z) = \\frac{\\sum_{k=0}^M b_k z^{-k}}{1 + \\sum_{k=1}^N a_k z^{-k}}}\n$$\n• **The 4 Fundamental Architectural Tradeoffs:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Performance Dimension} & \\textbf{FIR (Finite Impulse Response)} & \\textbf{IIR (Infinite Impulse Response)} \\\\\n\\hline\n\\mathbf{\\text{Poles / Stability}} & \\mathbf{\\text{All poles at origin } z=0 \\text{ (Always Stable!)}} & \\text{Poles must be kept strictly inside } |z|<1 \\\\\n\\mathbf{\\text{Phase Linearity}} & \\mathbf{\\text{Exact Linear Phase } (\\tau_g = M/2)} & \\text{Non-linear phase (causes waveform dispersion)} \\\\\n\\mathbf{\\text{Computational Cost}} & \\text{Higher order (e.g. 50-200 taps for sharp cutoff)} & \\mathbf{\\text{Ultra-low order (e.g. 4-8 poles for sharp cutoff)}} \\\\\n\\mathbf{\\text{Feedback Sensitivity}} & \\text{Zero feedback (No limit cycle oscillations)} & \\text{Sensitive to coefficient quantization \\& roundoff} \\\\\n\\hline\n\\end{array}\n$$\n• **The Linear Phase Symmetry Condition:** Linear phase is guaranteed if and only if **$h[n] = \\pm h[M - n]$**, producing **constant group delay $\\mathbf{\\tau_g = -\\frac{d\\theta(\\omega)}{d\\omega} = \\frac{M}{2}\\text{ samples}}$**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design and verify an exact linear-phase FIR digital filter.",
      "orderItems": [
        "Define the digital filter frequency specifications: passband ripple, stopband attenuation, and transition bandwidth",
        "Select an appropriate FIR design methodology (Window Method or Parks-McClellan Remez Exchange)",
        "Determine the required filter order M (length N = M + 1 taps) to satisfy the transition sharpness",
        "Enforce exact coefficient symmetry h[n] = h[M - n] to guarantee linear phase response",
        "Compute the constant group delay tau_g = M / 2 samples and verify that all poles reside safely at z = 0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Digital Filter Architecture Property to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Unconditional FIR Stability", "right": "All poles residing exclusively at the origin z = 0, preventing any possibility of feedback divergence" },
        { "left": "Exact Linear Phase", "right": "\u03c4g = M/2, ensuring all frequency components experience identical time delay to preserve waveforms" },
        { "left": "IIR High Efficiency", "right": "Using recursive feedback poles to achieve razor-sharp transition bands with minimal filter order" },
        { "left": "Coefficient Symmetry (h[n] = h[M-n])", "right": "Hermitian time-domain symmetry producing purely real frequency responses scaled by linear phase" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A symmetric linear-phase FIR digital filter of order M has a constant group delay equal to M divided by ___.",
      "blankAnswer": "2",
      "blankDistractors": ["4", "10", "pi"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A high-fidelity digital audio DSP system implements a Type-I linear-phase FIR filter with N = 11 taps (order M = 10) with symmetric impulse response h[n] = h[10 - n] operating at sampling rate fs = 48 kHz. What is the constant group delay \u03c4g in samples and in milliseconds?",
      "options": [
        { "text": "\u03c4g = 5.0 samples and \u03c4_time = 0.104 ms (\u03c4g = M/2 = 10/2 = 5.0 samples; and \u03c4_time = 5.0 / 48,000 Hz = 0.10417 ms)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using linear-phase FIR filter properties (Alan Oppenheim & Ronald Schafer *Discrete-Time Signal Processing* Chapter 5). 1. **Calculate Filter Order ($M$):** - Number of taps $N = 11$. - Filter order $M = N - 1 = 11 - 1 = \\mathbf{10}$. 2. **Calculate Group Delay in Samples ($\\tau_g$):** - For any symmetric FIR filter ($h[n] = h[M-n]$), the phase response is strictly linear: $$\\theta(\\omega) = -\\frac{M}{2} \\omega$$ - Group delay is the negative derivative of phase: $$\\tau_g = -\\frac{d\\theta(\\omega)}{d\\omega} = \\frac{M}{2} = \\frac{10}{2} = \\mathbf{5.0\\text{ samples}}$$ 3. **Convert to Physical Time Delay ($\\tau_{\\text{time}}$):** $$\\tau_{\\text{time}} = \\frac{\\tau_g}{f_s} = \\frac{5.0\\text{ samples}}{48,000\\text{ samples/sec}} = \\frac{5}{48,000}\\text{ s} = 1.04167 \\times 10^{-4}\\text{ s} \\approx \\mathbf{0.1042\\text{ ms}}$$ 4. **Audio Consequence:** Because $\\tau_g$ is **strictly independent of frequency**, all audio frequencies (from $20\\text{ Hz}$ to $20\\text{ kHz}$) are delayed by exactly $0.104\\text{ ms}$, preserving crisp audio transients without phase smear!" },
        { "text": "\u03c4g = 10.0 samples and \u03c4_time = 0.208 ms", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c4g = 5.5 samples and \u03c4_time = 0.115 ms (Using N/2 instead of M/2)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c4g = 2.5 samples and \u03c4_time = 0.052 ms", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
