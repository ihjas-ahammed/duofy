# Duofy Reusable Lesson Format: Plane Mappings (s-to-z Conformal Geometry & Unit Circle)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Signals_and_Systems / Z_Transforms_and_Filter_Design`  
**Lesson Format Type:** `discrete_s_to_z_plane_mapping_and_unit_circle_dynamics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through continuous-to-discrete complex mapping geometry, exponential point-by-point transformations ($z = e^{s T_s}$), sampling period scaling ($T_s$), discrete frequency wrapping ($\omega = \Omega T_s$), and unit circle pole dynamics (Alan V. Oppenheim & Ronald W. Schafer *Discrete-Time Signal Processing* Chapter 3 & 4; John G. Proakis *Digital Signal Processing* Chapter 3 & 4): master the **Exact Continuous-to-Discrete Exponential Mapping**:
$$\mathbf{z = e^{s T_s} = e^{(\sigma + j\Omega) T_s} = e^{\sigma T_s} \cdot e^{j\Omega T_s} = r e^{j\omega} \quad \left(r = e^{\sigma T_s}, \ \omega = \Omega T_s\right)}$$
master the **Three Conformal Domain Mappings**:
1. **Open Left-Half $s$-Plane ($\mathbf{\sigma < 0}$):** Maps strictly **INSIDE the Unit Circle ($\mathbf{r = e^{\sigma T_s} < 1 \implies |z| < 1}$)**;
2. **Imaginary $j\Omega$-Axis ($\mathbf{\sigma = 0}$):** Maps directly **ONTO the Unit Circle ($\mathbf{r = e^0 = 1 \implies |z| = 1}$)**, with primary frequency interval $-\pi/T_s \le \Omega \le \pi/T_s$ wrapping around the full $2\pi$ circle perimeter;
3. **Open Right-Half $s$-Plane ($\mathbf{\sigma > 0}$):** Maps strictly **OUTSIDE the Unit Circle ($\mathbf{r = e^{\sigma T_s} > 1 \implies |z| > 1}$)**;
and analyze **Discrete Pole Geometric Dynamics** ($z = r e^{\pm j\theta}$ creates damped oscillations whose envelope decay rate is governed by radius $r < 1$ and ringing frequency is governed by angle $\theta$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | $s$-to-$z$ Mapping ($z = e^{s T_s}$), Unit Circle ($|z|=1$) & Left-Half Plane Invariants Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Mapping of Continuous Analog Poles into Discrete Digital z-Plane Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Complex $s$-Plane Region / Feature & Corresponding Complex $z$-Plane Target Region Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Entire Continuous Imaginary Axis \sigma = 0 in the s-Plane Maps Directly Onto the Discrete ___ Circle in the z-Plane (Unit / Unit Circle) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Digital Signal Processing Problem: Mapping an Analog Pole s = -2 + j500 into the Discrete z-Plane Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State $s$-to-$z$ Plane Mapping (Oppenheim & Schafer 2010; Proakis 2007):
   - **Exponential Mapping Formulations:**
     $$\mathbf{z = e^{s T_s} = e^{\sigma T_s} e^{j\Omega T_s} \quad \Big| \quad |z| = e^{\sigma T_s} \quad \Big| \quad \angle z = \omega = \Omega T_s \ [\text{rad}]}$$
   - **Conformal Mapping Geometry Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Complex } s\textbf{-Plane Feature } (\sigma + j\Omega) & \textbf{Complex } z\textbf{-Plane Target } (r e^{j\omega}) & \textbf{Physical System Meaning} \\
     \hline
     \mathbf{\text{Open Left-Half Plane } (\sigma < 0)} & \mathbf{\text{Inside Unit Circle } (|z| < 1)} & \mathbf{\text{Stable exponentially decaying transients}} \\
     \mathbf{\text{Imaginary Axis } (\sigma = 0)} & \mathbf{\text{On the Unit Circle } (|z| = 1)} & \mathbf{\text{Pure sinusoidal steady-state response}} \\
     \mathbf{\text{Open Right-Half Plane } (\sigma > 0)} & \mathbf{\text{Outside Unit Circle } (|z| > 1)} & \mathbf{\text{Unstable growing exponential blowup}} \\
     \mathbf{\text{Origin } s = 0} & \mathbf{z = 1.0 \angle 0^\circ \ (\text{DC point})} & \text{Zero-frequency constant DC response} \\
     \mathbf{\text{Negative Real Axis } s \to -\infty} & \mathbf{z = 0.0 \ (\text{Origin of } z\text{-plane})} & \text{Deadbeat instantaneous decay (pure FIR delay)} \\
     \hline
     \end{array}$$
   - **The Frequency Wrapping Invariant:** Frequencies $\Omega$ separated by multiples of the sampling frequency $\Omega_s = \frac{2\pi}{T_s}$ map to **the EXACT SAME POINT on the unit circle** (the root cause of aliasing!).
2. **Slide 2 (`ordering`):** Provide 5 steps of pole mapping: (1) determine continuous analog pole location $s_0 = \sigma_0 + j\Omega_0$ and sampling period $T_s$, (2) compute discrete pole radius $r = e^{\sigma_0 T_s}$, (3) compute discrete pole angle $\theta = \Omega_0 T_s$ (in radians), (4) construct polar discrete pole location $z_0 = r e^{j\theta} = r\cos\theta + j r\sin\theta$, (5) verify that $r < 1$ if $\sigma_0 < 0$ to confirm that the digitized pole remains strictly stable!
3. **Slide 3 (`matching`):** Pair 4 concepts (Open LHP $\sigma<0 \to |z|<1$, Imaginary Axis $\sigma=0 \to |z|=1$, Open RHP $\sigma>0 \to |z|>1$, Analog DC $s=0 \to z=1$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Unit (or Unit Circle). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on mapping analog pole to $z$-plane: An analog continuous system has a stable complex pole at $s = -100 + j 500\text{ rad/s}$. The system is digitized using sampling period $T_s = 2.0\text{ ms} = 0.0020\text{ s}$. What is the magnitude $|z_p|$ and angle $\angle z_p$ of the mapped discrete pole in the $z$-plane? ($|z_p| = e^{\sigma T_s} = e^{(-100)(0.0020)} = e^{-0.20} \approx \mathbf{0.8187}$; Angle $\angle z_p = \Omega T_s = (500\text{ rad/s})(0.0020\text{ s}) = \mathbf{1.0\text{ radian}} \approx 57.30^\circ$; The mapped pole is $z_p = 0.8187 e^{j 1.0\text{ rad}} = \mathbf{0.8187 \angle 57.3^\circ}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "discrete_s_to_z_plane_mapping_and_unit_circle_dynamics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Complex Plane Mapping \\& Unit Circle Dynamics (Oppenheim \\& Schafer)**\n• **Exact Exponential s-to-z Conformal Mapping ($z = e^{s T_s}$):**\n$$\n\\mathbf{z = e^{(\\sigma + j\\Omega) T_s} = e^{\\sigma T_s} \\cdot e^{j\\Omega T_s} = r e^{j\\omega} \\quad \\left(r = e^{\\sigma T_s}, \\ \\omega = \\Omega T_s \\ [\\text{rad}]\\right)}\n$$\n• **The 3 Fundamental Geometric Region Mappings:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Continuous } s\\textbf{-Plane Region} & \\textbf{Discrete } z\\textbf{-Plane Target Region} & \\textbf{System Stability State} \\\\\n\\hline\n\\mathbf{\\text{Open Left-Half Plane } (\\sigma < 0)} & \\mathbf{\\text{Inside Unit Circle } (|z| < 1)} & \\mathbf{\\text{Strictly Stable (Decaying Transients)}} \\\\\n\\mathbf{\\text{Imaginary Axis } (\\sigma = 0)} & \\mathbf{\\text{On Unit Circle Boundary } (|z| = 1)} & \\mathbf{\\text{Marginally Stable (Pure Sinusoids)}} \\\\\n\\mathbf{\\text{Open Right-Half Plane } (\\sigma > 0)} & \\mathbf{\\text{Outside Unit Circle } (|z| > 1)} & \\mathbf{\\text{Unstable (Exponential Blowup)}} \\\\\n\\hline\n\\end{array}\n$$\n• **Key Reference Points:** Continuous DC $s = 0 \\implies \\mathbf{z = 1.0 \\angle 0^\\circ}$; Infinite damping $s \\to -\\infty \\implies \\mathbf{z = 0}$ (origin)!\n• **The Frequency Wrapping Invariant:** The entire infinite $j\\Omega$-axis wraps repeatedly around the perimeter of the unit circle every **$\\Omega_s = \\frac{2\\pi}{T_s}$ (Sampling Frequency)**, the origin of digital aliasing!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to map a continuous analog pole s = \u03c3 + j\u03a9 into the discrete z-plane given sampling period Ts.",
      "orderItems": [
        "Record the analog pole real damping \u03c3 and imaginary oscillation frequency \u03a9, along with sampling period Ts",
        "Compute the discrete pole radial magnitude: r = exp(\u03c3 * Ts)",
        "Compute the discrete pole digital radian angle: theta = \u03a9 * Ts",
        "Construct the complex polar discrete pole: z_p = r * exp(j * theta) = r * (cos(theta) + j * sin(theta))",
        "Verify that r < 1.0 when \u03c3 < 0 to confirm that the mapped discrete pole lies strictly inside the stable unit circle"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each s-Plane Region to its exact z-Plane Conformal Target.",
      "matchPairs": [
        { "left": "Open Left-Half Plane (\u03c3 < 0)", "right": "Interior of the unit circle (|z| < 1), mapping stable continuous poles to stable discrete poles" },
        { "left": "Imaginary Axis (\u03c3 = 0)", "right": "Perimeter boundary of the unit circle (|z| = 1), representing pure undamped sinusoidal frequencies" },
        { "left": "Open Right-Half Plane (\u03c3 > 0)", "right": "Exterior of the unit circle (|z| > 1), mapping unstable continuous blowups to unstable discrete poles" },
        { "left": "Continuous Origin (s = 0)", "right": "z = 1.0 + j0.0, the DC zero-frequency point on the real axis of the unit circle" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The entire continuous imaginary axis \u03c3 = 0 in the s-plane maps directly onto the discrete ___ circle in the z-plane.",
      "blankAnswer": "unit",
      "blankDistractors": ["nyquist", "bode", "smith"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An analog system has a stable complex pole at s = -100 + j500 rad/s. The system is sampled with period Ts = 2.0 ms (0.0020 s). What is the magnitude |zp| and angle \u2220zp of the mapped discrete pole in the z-plane?",
      "options": [
        { "text": "|zp| = 0.8187 and \u2220zp = 1.0 rad (~57.30\u00b0) (|zp| = e^(-100 * 0.002) = e^-0.20 = 0.8187, and \u2220zp = 500 rad/s * 0.002 s = 1.0 rad)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the exponential $s$-to-$z$ mapping $z = e^{s T_s}$ (Alan Oppenheim & Ronald Schafer *Discrete-Time Signal Processing* Chapter 3). 1. **Apply the Real Exponential to Find Pole Radius ($r$):** $$r = |z_p| = e^{\\sigma T_s} = e^{(-100\\text{ s}^{-1})(0.0020\\text{ s})} = e^{-0.200} = \\mathbf{0.81873\\text{ } \\approx 0.8187}$$ 2. **Apply the Imaginary Frequency to Find Pole Angle ($\\theta$):** $$\\theta = \\angle z_p = \\Omega T_s = (500\\text{ rad/s})(0.0020\\text{ s}) = \\mathbf{1.000\\text{ radian}}$$ - In degrees: $\\theta = 1.000 \\times \\left(\\frac{180^\\circ}{\\pi}\\right) \\approx \\mathbf{57.2958^\\circ \\approx 57.30^\\circ}$. 3. **Construct the Complex Discrete Pole ($z_p$):** $$z_p = 0.81873 e^{j 1.0} = 0.81873 (\\cos(1.0) + j \\sin(1.0)) = 0.81873 (0.54030 + j 0.84147) = \\mathbf{0.4424 + j 0.6889}$$ 4. **Stability Verification:** - Since $\\sigma = -100 < 0$, $|z_p| = 0.8187 < 1.0$, which lies **strictly inside the unit circle**, confirming that the discrete filter is **unconditionally BIBO stable**!" },
        { "text": "|zp| = 1.0000 and \u2220zp = 1.0 rad (On the unit circle)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "|zp| = 1.2214 and \u2220zp = 1.0 rad (Unstable outside unit circle)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "|zp| = 0.8187 and \u2220zp = 0.5 rad", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
