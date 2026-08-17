# Duofy Reusable Lesson Format: Transient Response (2nd-Order Damping & Peak Overshoot)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Control_Systems / Transfer_Functions_and_Block_Diagrams`  
**Lesson Format Type:** `second_order_transient_response_damping_and_peak_overshoot`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through standard canonical second-order linear feedback systems, natural undamped frequency ($\omega_n$), damping ratio ($\zeta$), damped oscillation frequency ($\omega_d$), and time-domain step response specifications in dynamic control systems (Katsuhiko Ogata *Modern Control Engineering* Chapter 5; Norman S. Nise *Control Systems Engineering* Chapter 4): formulate the **Standard Prototype Second-Order Closed-Loop Transfer Function**:
$$\mathbf{T(s) = \frac{C(s)}{R(s)} = \frac{\omega_n^2}{s^2 + 2 \zeta \omega_n s + \omega_n^2} \quad \left(\text{Poles: } s_{1,2} = -\zeta \omega_n \pm j \omega_n \sqrt{1 - \zeta^2} = -\sigma \pm j \omega_d\right)}$$
master the **Four Damping Regimes**:
1. **Underdamped ($0 < \zeta < 1$):** Complex conjugate poles; oscillatory step response with overshoot;
2. **Critically Damped ($\zeta = 1$):** Real repeated poles ($s = -\omega_n$); fastest return without overshoot;
3. **Overdamped ($\zeta > 1$):** Real distinct poles; sluggish non-oscillatory response;
4. **Undamped ($\zeta = 0$):** Imaginary poles ($s = \pm j\omega_n$); sustained sinusoidal oscillation;
derive the **Master Transient Performance Metric Equations ($0 < \zeta < 1$)**:
$$\mathbf{\%M_p = e^{-\frac{\zeta \pi}{\sqrt{1 - \zeta^2}}} \times 100\% \Longleftrightarrow \mathbf{\zeta = \frac{-\ln(\%M_p / 100)}{\sqrt{\pi^2 + \ln^2(\%M_p / 100)}}}}$$
$$\mathbf{t_p = \frac{\pi}{\omega_d} = \frac{\pi}{\omega_n \sqrt{1 - \zeta^2}} \quad \Big| \quad \mathbf{t_s (2\%) = \frac{4}{\zeta \omega_n}} \quad \Big| \quad \mathbf{t_s (5\%) = \frac{3}{\zeta \omega_n}}}$$
(proving that damping ratio $\zeta$ uniquely governs percentage peak overshoot $\%M_p$, while the real pole distance $\sigma = \zeta\omega_n$ uniquely governs settling time $t_s$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Standard Form ($T(s) = \frac{\omega_n^2}{s^2 + 2\zeta\omega_n s + \omega_n^2}$), Overshoot ($\%M_p$) & Settling Time ($t_s = \frac{4}{\zeta\omega_n}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Size Control Parameters \zeta and \omega_n from Transient Specifications Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Transient Time Metric / Damping Parameter & Technical Mathematical Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Time Required for an Underdamped Second-Order Step Response to Settle and Remain Within a 2% Error Band Is 4 Divided by ___ (zeta * omega_n / sigma) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Servomechanism Design Problem: Calculating \zeta, \omega_n, Peak Time tp, and %Mp from Closed-Loop Transfer Function Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State 2nd-Order Transient Dynamics (Ogata 2010; Nise 2015):
   - **Canonical Equations & Formulations:**
     $$\mathbf{T(s) = \frac{\omega_n^2}{s^2 + 2\zeta\omega_n s + \omega_n^2} \quad \Big| \quad \omega_d = \omega_n\sqrt{1-\zeta^2} \quad \Big| \quad \%M_p = e^{-\frac{\zeta\pi}{\sqrt{1-\zeta^2}}}\times 100\% \quad \Big| \quad t_s(2\%) = \frac{4}{\zeta\omega_n}}$$
   - **Damping Regime Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Damping Regime} & \textbf{Damping Ratio } \zeta & \textbf{Complex } s\textbf{-Plane Pole Locations} & \textbf{Step Response Feature} \\
     \hline
     \mathbf{\text{Undamped}} & \zeta = 0 & s = \pm j \omega_n \ (\text{On } j\omega\text{-axis}) & \text{Perpetual sinusoidal ringing } (\%M_p = 100\%) \\
     \mathbf{\text{Underdamped}} & \mathbf{0 < \zeta < 1} & \mathbf{s = -\zeta\omega_n \pm j \omega_d \ (\text{LHP Complex})} & \mathbf{\text{Damped oscillations with overshoot}} \\
     \mathbf{\text{Critically Damped}} & \zeta = 1 & s = -\omega_n, -\omega_n \ (\text{Real repeated}) & \text{Fastest rise without any overshoot } (\%M_p = 0\%) \\
     \mathbf{\text{Overdamped}} & \zeta > 1 & s = -\zeta\omega_n \pm \omega_n\sqrt{\zeta^2 - 1} \ (\text{Real distinct}) & \text{Sluggish exponential approach to target} \\
     \hline
     \end{array}$$
   - **The Peak Overshoot Invariant:** Percentage peak overshoot $\%M_p$ depends **EXCLUSIVELY on damping ratio $\zeta$**; natural frequency $\omega_n$ scales the time axis (speed of response) but has zero effect on percentage overshoot!
2. **Slide 2 (`ordering`):** Provide 5 steps of transient controller parameter extraction: (1) compare system denominator with standard prototype $s^2 + 2\zeta\omega_n s + \omega_n^2 = 0$, (2) extract natural undamped frequency $\omega_n = \sqrt{a_0}$, (3) equate $s$-coefficient to $2\zeta\omega_n$ to solve for damping ratio $\zeta = a_1 / (2\omega_n)$, (4) calculate damped frequency $\omega_d = \omega_n\sqrt{1 - \zeta^2}$ and peak time $t_p = \pi / \omega_d$, (5) calculate percentage overshoot $\%M_p = e^{-\zeta\pi/\sqrt{1-\zeta^2}} \times 100\%$ and $2\%$ settling time $t_s = 4 / (\zeta\omega_n)$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Percentage Peak Overshoot $\%M_p$, Peak Time $t_p = \pi/\omega_d$, Settling Time $2\% = 4/(\zeta\omega_n)$, Damped Frequency $\omega_d = \omega_n\sqrt{1-\zeta^2}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of zeta * omega_n (or sigma). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating 2nd-order transient parameters: A unity feedback closed-loop position servomechanism has transfer function $T(s) = \frac{100}{s^2 + 12 s + 100}$. What is the natural frequency $\omega_n$, damping ratio $\zeta$, damped frequency $\omega_d$, and percentage peak overshoot $\%M_p$? ($\omega_n^2 = 100 \implies \mathbf{\omega_n = 10.0\text{ rad/s}}$; $2\zeta\omega_n = 12 \implies \zeta = \frac{12}{2(10.0)} = \mathbf{0.60}$; $\omega_d = \omega_n\sqrt{1 - \zeta^2} = 10.0\sqrt{1 - (0.60)^2} = 10.0\sqrt{0.64} = 10.0(0.80) = \mathbf{8.0\text{ rad/s}}$; $\%M_p = e^{-\frac{0.60\pi}{\sqrt{1 - 0.36}}} \times 100\% = e^{-\frac{0.60\pi}{0.80}} \times 100\% = e^{-0.75\pi} \times 100\% = e^{-2.35619} \times 100\% \approx \mathbf{9.48\% \approx 9.5\%}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "second_order_transient_response_damping_and_peak_overshoot",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: 2nd-Order Transient Response \\& Damping Specs (Katsuhiko Ogata)**\n• **Standard Canonical Second-Order Closed-Loop Transfer Function:**\n$$\n\\mathbf{T(s) = \\frac{C(s)}{R(s)} = \\frac{\\omega_n^2}{s^2 + 2 \\zeta \\omega_n s + \\omega_n^2} \\quad \\left(\\text{Poles: } s_{1,2} = -\\zeta \\omega_n \\pm j \\omega_n \\sqrt{1 - \\zeta^2} = -\\sigma \\pm j \\omega_d\\right)}\n$$\n• **The 4 Fundamental Transient Performance Metrics ($0 < \\zeta < 1$):**\n$$\n\\mathbf{\\%M_p = e^{-\\frac{\\zeta \\pi}{\\sqrt{1 - \\zeta^2}}} \\times 100\\% \\quad \\Big| \\quad \\mathbf{t_p = \\frac{\\pi}{\\omega_d} = \\frac{\\pi}{\\omega_n \\sqrt{1 - \\zeta^2}}}}\n$$\n$$\n\\mathbf{t_s (2\\%) = \\frac{4}{\\zeta \\omega_n} = \\frac{4}{\\sigma} \\quad \\Big| \\quad \\mathbf{t_s (5\\%) = \\frac{3}{\\zeta \\omega_n} = \\frac{3}{\\sigma}}}\n$$\n• **Damping Ratio Inverse Function:**\n$$\n\\mathbf{\\zeta = \\frac{-\\ln(\\%M_p / 100)}{\\sqrt{\\pi^2 + \\ln^2(\\%M_p / 100)}}}\n$$\n• **The Overshoot Independence Invariant:** Percentage peak overshoot $\\%M_p$ depends **EXCLUSIVELY on damping ratio $\\zeta$**; natural frequency $\\omega_n$ scales the speed of the system along the time axis but has zero effect on peak overshoot percentage!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to extract transient response parameters and calculate peak overshoot from a 2nd-order transfer function.",
      "orderItems": [
        "Compare the characteristic polynomial denominator with standard canonical form: s^2 + 2*\u03b6*\u03c9n*s + \u03c9n^2 = 0",
        "Extract the natural undamped frequency: \u03c9n = \u221a(constant_term)",
        "Equate the linear s-coefficient to 2*\u03b6*\u03c9n to solve for the damping ratio: \u03b6 = coefficient / (2 * \u03c9n)",
        "Calculate the damped natural oscillation frequency: \u03c9d = \u03c9n * \u221a(1 - \u03b6^2) and peak time tp = \u03c0 / \u03c9d",
        "Compute percentage peak overshoot %Mp = exp(-\u03b6*\u03c0 / \u221a(1 - \u03b6^2)) * 100% and 2% settling time ts = 4 / (\u03b6 * \u03c9n)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Transient Performance Specification to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Percentage Peak Overshoot (%Mp)", "right": "%Mp = exp(-\u03b6\u03c0 / \u221a(1-\u03b6^2)) * 100%, maximum peak excursion above steady-state target" },
        { "left": "Peak Time (tp)", "right": "tp = \u03c0 / \u03c9d, time elapsed from step input application until the response reaches its first maximum peak" },
        { "left": "2% Settling Time (ts)", "right": "ts = 4 / (\u03b6*\u03c9n), time required for step response envelope to decay and stay within \u00b12% of final value" },
        { "left": "Damped Frequency (\u03c9d)", "right": "\u03c9d = \u03c9n * \u221a(1 - \u03b6^2), actual ringing oscillation frequency of the underdamped transient waveform" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The time required for an underdamped 2nd-order step response to settle within a 2% error band is 4 divided by ___.",
      "blankAnswer": "zeta * omega_n",
      "blankDistractors": ["omega_d", "pi", "2 * zeta"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A closed-loop servomechanism position controller has transfer function T(s) = 100 / (s^2 + 12s + 100). What is the natural frequency \u03c9n, damping ratio \u03b6, damped frequency \u03c9d, and percentage peak overshoot %Mp?",
      "options": [
        { "text": "\u03c9n = 10.0 rad/s, \u03b6 = 0.60, \u03c9d = 8.0 rad/s, and %Mp = 9.48% (\u03c9n = \u221a100 = 10; 2\u03b6\u03c9n = 12 \u2192 \u03b6 = 12/20 = 0.60; \u03c9d = 10*\u221a(1-0.36) = 8.0 rad/s; %Mp = exp(-0.6\u03c0/0.8)*100% = 9.48%)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using standard second-order control system transient equations (Katsuhiko Ogata *Modern Control Engineering* Chapter 5). 1. **Compare Characteristic Polynomial to Standard Prototype Form:** $$s^2 + 12 s + 100 = s^2 + 2 \\zeta \\omega_n s + \\omega_n^2$$ 2. **Calculate Natural Frequency ($\\omega_n$):** $$\\omega_n^2 = 100 \\implies \\mathbf{\\omega_n = 10.0\\text{ rad/s}}$$ 3. **Calculate Damping Ratio ($\\zeta$):** $$2 \\zeta \\omega_n = 12 \\implies 2 \\zeta (10.0) = 12 \\implies 20 \\zeta = 12 \\implies \\mathbf{\\zeta = \\frac{12}{20} = 0.60}$$ - Since $0 < \\zeta = 0.60 < 1$, the system is **Underdamped**. 4. **Calculate Damped Oscillation Frequency ($\\omega_d$):** $$\\omega_d = \\omega_n \\sqrt{1 - \\zeta^2} = 10.0 \\times \\sqrt{1 - (0.60)^2} = 10.0 \\times \\sqrt{1 - 0.36} = 10.0 \\times \\sqrt{0.64} = 10.0 \\times 0.80 = \\mathbf{8.00\\text{ rad/s}}$$ 5. **Calculate Percentage Peak Overshoot ($\\%M_p$):** $$\\%M_p = e^{-\\frac{\\zeta \\pi}{\\sqrt{1 - \\zeta^2}}} \\times 100\\% = e^{-\\frac{0.60 \\pi}{0.80}} \\times 100\\% = e^{-0.75 \\pi} \\times 100\\% = e^{-2.356194} \\times 100\\% = 0.094789 \\times 100\\% \\approx \\mathbf{9.48\\%}$$ 6. **Peak Time and Settling Time:** - Peak Time: $t_p = \\frac{\\pi}{\\omega_d} = \\frac{3.14159}{8.0} = \\mathbf{0.393\\text{ s}}$. - $2\\%$ Settling Time: $t_s = \\frac{4}{\\zeta \\omega_n} = \\frac{4}{(0.60)(10.0)} = \\frac{4}{6.0} = \\mathbf{0.667\\text{ s}}$! Flawless transient analysis!" },
        { "text": "\u03c9n = 10.0 rad/s, \u03b6 = 1.20, \u03c9d = 0.0 rad/s, and %Mp = 0.00% (Overdamped)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c9n = 100.0 rad/s, \u03b6 = 0.06, \u03c9d = 99.8 rad/s, and %Mp = 82.5%", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c9n = 10.0 rad/s, \u03b6 = 0.60, \u03c9d = 6.0 rad/s, and %Mp = 16.3%", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
