# Duofy Reusable Lesson Format: IIR Filter Design (Bilinear Transform & Frequency Pre-Warping)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Signals_and_Systems / Z_Transforms_and_Filter_Design`  
**Lesson Format Type:** `bilinear_transformation_frequency_prewarping_and_butterworth_synthesis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify analog-to-digital IIR filter synthesis, the Bilinear Transformation (BLT), conformal frequency compression, tangent pre-warping, and analog Butterworth prototype digitization in digital signal processing (Alan V. Oppenheim & Ronald W. Schafer *Discrete-Time Signal Processing* Chapter 7; John G. Proakis *Digital Signal Processing* Chapter 10): derive the **Bilinear Transformation (BLT)**:
$$\mathbf{s = \frac{2}{T} \left( \frac{1 - z^{-1}}{1 + z^{-1}} \right) = \frac{2}{T} \left( \frac{z - 1}{z + 1} \right) \Longleftrightarrow \mathbf{z = \frac{1 + \frac{T}{2} s}{1 - \frac{T}{2} s}}}$$
(derived from the trapezoidal numerical integration rule, mapping the entire continuous $j\Omega$-axis onto the discrete unit circle without aliasing); derive the **Non-Linear Frequency Warping Relationship**:
$$\mathbf{\Omega_{\text{analog}} = \frac{2}{T} \tan\left( \frac{\omega_{\text{digital}}}{2} \right) \Longleftrightarrow \mathbf{\omega_{\text{digital}} = 2 \arctan\left( \frac{\Omega_{\text{analog}} T}{2} \right)}}$$
master the **Four-Step IIR Design Protocol**:
1. **Pre-warp** digital critical frequencies: $\Omega_c = \frac{2}{T} \tan(\omega_c / 2)$;
2. Design analog continuous filter prototype $H_a(s)$ (e.g. Butterworth $H_a(s) = \frac{\Omega_c}{s + \Omega_c}$);
3. Substitute BLT transformation $s = \frac{2}{T}\left(\frac{z-1}{z+1}\right)$ into $H_a(s)$;
4. Simplify into standard discrete rational form $H_d(z) = \frac{b_0 + b_1 z^{-1}}{1 + a_1 z^{-1}}$,
and interact with live Z-transform ROC pole-zero mapper, $s$-to-$z$ plane conformal transformation visualizer, FIR/IIR group delay comparator, and Bilinear transform frequency pre-warping Butterworth synthesizer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bilinear Transform ($s = \frac{2}{T}\frac{z-1}{z+1}$), Pre-Warping ($\Omega = \frac{2}{T}\tan\frac{\omega}{2}$) & IIR Synthesis Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Bilinear Transform Entity / Design Step & Technical Role in IIR Filter Synthesis Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why the Bilinear Transformation Requires Frequency Pre-Warping Prior to Analog Prototype Design Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Mathematical Step of Adjusting Analog Filter Prototype Frequencies Using the Tangent Function Prior to Applying the Bilinear Transform Is Pre-___ (Warping / Warp) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive DSP Studio: Z-Transform ROC, s-to-z Plane Mapping, FIR vs IIR & Bilinear Filter Synthesis Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "bilinear_transformation_frequency_prewarping_and_butterworth_synthesis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Bilinear Transformation, why does it prevent aliasing, and how does Frequency Pre-Warping work?",
      "blankAnswer": "Bilinear Transform & IIR Synthesis (Oppenheim & Schafer): (1) BILINEAR TRANSFORM (BLT): Conformal mapping s = (2/T)*((z - 1)/(z + 1)) derived from trapezoidal integration. (2) NO ALIASING: Maps entire continuous j\u03a9-axis (-\u221e to +\u221e) uniquely onto the finite discrete unit circle (-\u03c0 to +\u03c0). (3) FREQUENCY WARPING: Non-linear compression \u03a9_analog = (2/T)*tan(\u03c9_digital/2). (4) PRE-WARPING PROTOCOL: To achieve digital cutoff \u03c9c, you MUST first compute pre-warped analog cutoff \u03a9c = (2/T)*tan(\u03c9c/2), design analog prototype Ha(s), then substitute s = (2/T)*((1 - z^-1)/(1 + z^-1)) to produce exact digital filter Hd(z)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Bilinear Transform Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Bilinear Transformation", "right": "s = (2/T)*((z - 1)/(z + 1)), algebraic conformal mapping between continuous and discrete domains" },
        { "left": "Frequency Pre-Warping", "right": "\u03a9 = (2/T)*tan(\u03c9/2), adjusting analog prototype frequencies to compensate for tangent distortion" },
        { "left": "Aliasing Elimination", "right": "Compressing infinite analog frequency range into the finite [-\u03c0, +\u03c0] digital frequency interval" },
        { "left": "Butterworth Prototype", "right": "Ha(s) = \u03a9c / (s + \u03a9c), maximally flat continuous low-pass filter template transformed into discrete Hd(z)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In digital IIR filter synthesis, why is it mandatory to pre-warp the critical cutoff frequencies (\u03a9 = (2/T)*tan(\u03c9/2)) before designing the analog prototype filter Ha(s)?",
      "options": [
        { "text": "The Bilinear Transformation maps the infinite analog frequency range -\u221e < \u03a9 < +\u221e into the finite digital frequency range -\u03c0 < \u03c9 < +\u03c0 using a highly non-linear tangent function (\u03a9 = (2/T)*tan(\u03c9/2)); this non-linear compression causes severe high-frequency warping (distortion); without pre-warping the target analog cutoff frequency prior to designing Ha(s), the resulting digital filter cutoff frequency would be severely shifted away from the desired specification", "isCorrect": true, "explanation": "Correct! This is Alan Oppenheim and Ronald Schafer's fundamental proof for bilinear transform filter synthesis (*Discrete-Time Signal Processing* Chapter 7). 1. **The Origin of Frequency Warping:** - Substituting $s = j\Omega$ and $z = e^{j\omega}$ into the BLT definition gives: $$j\Omega = \\frac{2}{T} \\left( \\frac{e^{j\omega} - 1}{e^{j\omega} + 1} \\right) = \\frac{2}{T} \\left( \\frac{e^{j\omega/2}(e^{j\omega/2} - e^{-j\omega/2})}{e^{j\omega/2}(e^{j\omega/2} + e^{-j\omega/2})} \\right) = j \\frac{2}{T} \\tan\\left( \\frac{\\omega}{2} \\right)$$ - Therefore: $$\\mathbf{\\Omega = \\frac{2}{T} \\tan\\left( \\frac{\\omega}{2} \\right)}$$ 2. **The Warping Effect:** - At low frequencies ($\\omega \\ll 1$), $\\tan(\\omega/2) \\approx \\omega/2 \\implies \\Omega \\approx \\omega/T$ (linear). - As $\\omega \\to \\pi$, $\\tan(\\omega/2) \\to \\infty \\implies \\Omega \\to \\infty$ (infinite compression!). 3. **The Pre-Warping Remedy:** - If your digital filter requires cutoff $\\omega_c = 0.4\\pi$, and you design an analog filter with $\\Omega_c = \\omega_c/T$, the transformed digital filter will cut off at a completely wrong frequency! - Pre-warping forces the analog prototype cutoff to be $\\Omega_c = \\frac{2}{T} \\tan(\\omega_c / 2)$, ensuring the BLT maps it **EXACTLY back to $\\omega_c$ in the digital domain**!" },
        { "text": "Because analog filters cannot process digital numbers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because pre-warping removes all poles from the filter", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the bilinear transform only works at DC frequency", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The mathematical step of adjusting analog prototype frequencies using the tangent function before applying the bilinear transform is pre-___.",
      "blankAnswer": "warping",
      "blankDistractors": ["scaling", "filtering", "folding"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Signals & Systems and DSP Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Signals & Systems & DSP Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Z-Transforms, s-to-z Mapping, FIR/IIR & Bilinear Transform</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnZ\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Z-Transform ROC (|z|=1)</button><button id=\"btnMap\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. s-to-z Pole (r=0.8187)</button><button id=\"btnBlt\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. FIR Linear Phase & Bilinear BLT</button></div><div id=\"dspLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate Z-transform ROC...</div><script>document.getElementById('btnZ').onclick=()=>{document.getElementById('dspLog').innerHTML='<b>1. Z-TRANSFORM ROC \\& STABILITY:</b><br>• H(z) = 1 / [(1 - 0.5z^-1)(1 - 2z^-1)]<br>• BIBO Stable: ROC MUST contain unit circle |z|=1 &rarr; <b style=\"color:#10b981;\">0.5 < |z| < 2.0!</b><br>• Non-Causal because ROC is an annular ring!';}; document.getElementById('btnMap').onclick=()=>{document.getElementById('dspLog').innerHTML='<b>2. s-to-z CONFORMAL MAPPING:</b><br>• Analog pole s = -100 + j500 rad/s @ Ts = 2ms<br>• <b style=\"color:#38bdf8;\">|zp| = e^-0.20 = 0.8187, \\u2220zp = 1.0 rad (57.3\\u00b0)!</b><br>• Stable because |zp| < 1.0 (inside unit circle)!';}; document.getElementById('btnBlt').onclick=()=>{document.getElementById('dspLog').innerHTML='<b>3. FIR LINEAR PHASE \\& BILINEAR BLT:</b><br>• FIR 11-tap symmetric: \\u03c4g = M/2 = 5 samples (0.104 ms @ 48kHz)<br>• Bilinear Transform: s = (2/T)*(z-1)/(z+1)<br>• Pre-warping: \\u03a9 = (2/T)*tan(\\u03c9/2) (Zero aliasing!)<br>🏆 <b style=\"color:#10b981;\">Signals_and_Systems (ALL 3 LEAF DIRS) 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
