# Duofy Reusable Lesson Format: Signal Metrics (Energy, Power, & Symmetry Decompositions)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Signals_and_Systems / Continuous_and_Discrete_Time_Signals`  
**Lesson Format Type:** `continuous_and_discrete_signal_classifications_energy_power_and_symmetry`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through signal taxonomies, continuous vs discrete domains, total signal energy ($E$), time-average power ($P$), periodic fundamental frequency determination, and even/odd symmetry decompositions in signal processing (Alan V. Oppenheim & Alan S. Willsky *Signals and Systems* Chapter 1; B.P. Lathi *Linear Systems and Signals* Chapter 1): formulate **Continuous & Discrete Signal Energy ($E$)**:
$$\mathbf{E_\infty = \int_{-\infty}^\infty |x(t)|^2 \, dt \quad \Big| \quad E_\infty = \sum_{n=-\infty}^\infty |x[n]|^2}$$
formulate **Continuous & Discrete Time-Average Power ($P$)**:
$$\mathbf{P_\infty = \lim_{T\to\infty} \frac{1}{2T} \int_{-T}^T |x(t)|^2 \, dt \quad \Big| \quad P_\infty = \lim_{N\to\infty} \frac{1}{2N+1} \sum_{n=-N}^N |x[n]|^2}$$
enforce the **Mutual Exclusivity Invariant**:
- **Energy Signals:** $0 < E < \infty \implies \mathbf{P = 0}$ (finite duration pulses, decaying exponentials);
- **Power Signals:** $0 < P < \infty \implies \mathbf{E = \infty}$ (infinite duration sinusoids, periodic waves, unit step);
- **Neither:** Signals with $E = \infty$ and $P = \infty$ (e.g. growing ramp $t u(t)$ or $e^{+at}$);
and derive the **Even and Odd Component Symmetry Decomposition**:
$$\mathbf{x_e(t) = \frac{x(t) + x(-t)}{2} \quad \Big| \quad x_o(t) = \frac{x(t) - x(-t)}{2} \implies \mathbf{x(t) = x_e(t) + x_o(t)}}$$
(proving that every arbitrary physical signal can be uniquely split into orthogonal symmetric and antisymmetric parts).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Energy ($E = \int |x|^2 dt$), Power ($P = \lim \frac{1}{2T}\int |x|^2 dt$) & Even/Odd Decomposition Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Decompose a Signal into Even and Odd Symmetric Components Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Signal Classification / Symmetry Metric & Technical Mathematical Characteristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | A Signal with Finite Non-Zero Total Energy (0 < E < infinity) Has an Average Power Exactly Equal to ___ (Zero / 0) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Signal Processing Problem: Calculating the Total Energy and Even Component of a Decaying Exponential Pulse Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Signal Energy, Power & Symmetry (Oppenheim & Willsky 1997; Lathi 2017):
   - **Energy, Power & Symmetry Formulations:**
     $$\mathbf{E = \int_{-\infty}^\infty |x(t)|^2 dt \quad \Big| \quad P = \lim_{T\to\infty}\frac{1}{2T}\int_{-T}^T |x(t)|^2 dt \quad \Big| \quad x_e(t) = \frac{x(t)+x(-t)}{2} \quad \Big| \quad x_o(t) = \frac{x(t)-x(-t)}{2}}$$
   - **Signal Classification Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Signal Class} & \textbf{Total Energy } E & \textbf{Average Power } P & \textbf{Physical Examples} \\
     \hline
     \mathbf{\text{Energy Signal}} & \mathbf{0 < E < \infty} & \mathbf{P = 0} & \text{Transient pulses, } e^{-at} u(t), \text{ rectangular gate} \\
     \mathbf{\text{Power Signal}} & \mathbf{E = \infty} & \mathbf{0 < P < \infty} & \text{Sinusoids } A\cos(\omega_0 t + \phi), \text{ unit step } u(t) \\
     \mathbf{\text{Neither}} & E = \infty & P = \infty & \text{Ramp } r(t) = t u(t), \text{ growing exp } e^{+at} u(t) \\
     \hline
     \end{array}$$
   - **The Symmetry Orthogonality Invariant:** The total energy of a signal equals the sum of the energies of its even and odd parts: $\mathbf{E_{\text{total}} = E_{\text{even}} + E_{\text{odd}}}$!
2. **Slide 2 (`ordering`):** Provide 5 steps of even/odd signal decomposition: (1) express the functional definition of the input signal $x(t)$, (2) perform time reversal to construct $x(-t)$ by replacing $t$ with $-t$, (3) add $x(t)$ and $x(-t)$ and divide by 2 to compute even component $x_e(t) = \frac{1}{2}[x(t) + x(-t)]$, (4) subtract $x(-t)$ from $x(t)$ and divide by 2 to compute odd component $x_o(t) = \frac{1}{2}[x(t) - x(-t)]$, (5) verify that $x_e(t) + x_o(t) = x(t)$ and check that $x_e(-t) = x_e(t)$ and $x_o(-t) = -x_o(t)$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Energy Signal $P=0$, Power Signal $E=\infty$, Even Component $x_e(t)$, Odd Component $x_o(t)$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Zero (or 0). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating signal energy: A continuous-time signal is given by the causal real decaying exponential $x(t) = e^{-3t} u(t)$. What is the total signal energy $E$, and is $x(t)$ an energy signal, a power signal, or neither? ($E = \int_{-\infty}^\infty |x(t)|^2 dt = \int_0^\infty (e^{-3t})^2 dt = \int_0^\infty e^{-6t} dt = \left[ -\frac{1}{6} e^{-6t} \right]_0^\infty = 0 - \left(-\frac{1}{6}\right) = \mathbf{\frac{1}{6}\text{ Joules} \approx 0.167\text{ J}}$; Because $0 < E < \infty$, the signal is an **Energy Signal with average power $P = 0$**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "continuous_and_discrete_signal_classifications_energy_power_and_symmetry",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Signal Classifications, Energy, Power \\& Symmetry (Oppenheim \\& Willsky)**\n• **Continuous \\& Discrete Signal Energy Formulations:**\n$$\n\\mathbf{E_\\infty = \\int_{-\\infty}^\\infty |x(t)|^2 \\, dt \\quad \\Big| \\quad E_\\infty = \\sum_{n=-\\infty}^\\infty |x[n]|^2 \\ [\\text{Joules}]}\n$$\n• **Time-Average Signal Power Formulations:**\n$$\n\\mathbf{P_\\infty = \\lim_{T\\to\\infty} \\frac{1}{2T} \\int_{-T}^T |x(t)|^2 \\, dt \\quad \\Big| \\quad P_\\infty = \\lim_{N\\to\\infty} \\frac{1}{2N+1} \\sum_{n=-N}^N |x[n]|^2 \\ [\\text{Watts}]}\n$$\n• **The Classification Taxonomy Invariant:**\n  - **Energy Signal:** $\\mathbf{0 < E < \\infty \\implies P = 0}$ (e.g. finite pulses, decaying exponentials);\n  - **Power Signal:** $\\mathbf{0 < P < \\infty \\implies E = \\infty}$ (e.g. infinite sinusoids, square waves);\n• **Even \\& Odd Symmetry Decomposition:**\n$$\n\\mathbf{x_e(t) = \\frac{x(t) + x(-t)}{2} \\quad \\Big| \\quad x_o(t) = \\frac{x(t) - x(-t)}{2} \\implies \\mathbf{x(t) = x_e(t) + x_o(t)}}\n$$\n• **Energy Orthogonality:** $\\mathbf{E_{\\text{total}} = E_{\\text{even}} + E_{\\text{odd}}}$ because cross-product integral of even and odd functions is **identically zero**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to decompose an arbitrary continuous-time signal x(t) into its even and odd symmetric components.",
      "orderItems": [
        "Record the mathematical definition of the input signal x(t)",
        "Perform time-reversal to construct the mirrored signal x(-t) by substituting -t for t",
        "Add x(t) and x(-t) and divide by 2 to construct the even component: x_e(t) = 0.5 * [x(t) + x(-t)]",
        "Subtract x(-t) from x(t) and divide by 2 to construct the odd component: x_o(t) = 0.5 * [x(t) - x(-t)]",
        "Verify that x_e(t) + x_o(t) equals x(t) and that x_e(-t) = x_e(t) and x_o(-t) = -x_o(t)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Signal Category to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Energy Signal", "right": "Finite non-zero total energy (0 < E < \u221e) and strictly zero time-average power (P = 0)" },
        { "left": "Power Signal", "right": "Infinite total energy (E = \u221e) and finite non-zero average power (0 < P < \u221e)" },
        { "left": "Even Component xe(t)", "right": "xe(t) = 0.5*[x(t) + x(-t)], symmetric component satisfying xe(-t) = xe(t)" },
        { "left": "Odd Component xo(t)", "right": "xo(t) = 0.5*[x(t) - x(-t)], antisymmetric component satisfying xo(-t) = -xo(t)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A signal with finite non-zero total energy (0 < E < infinity) has a time-average power strictly equal to ___.",
      "blankAnswer": "zero",
      "blankDistractors": ["one", "infinity", "undefined"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A causal continuous-time signal is defined as x(t) = exp(-3t) * u(t). What is the total signal energy E, and what is the classification of x(t)?",
      "options": [
        { "text": "E = 1/6 Joules (~0.167 J) and x(t) is an Energy Signal (E = \u222b[0,\u221e] (e^-3t)^2 dt = \u222b[0,\u221e] e^-6t dt = [-e^-6t / 6] = 1/6 J; with P = 0)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using continuous-time signal energy definitions (Alan Oppenheim & Alan Willsky *Signals and Systems* Chapter 1). 1. **Apply Signal Energy Integral:** $$E = \\int_{-\\infty}^\\infty |x(t)|^2 \\, dt$$ 2. **Substitute $x(t) = e^{-3t} u(t)$ ($u(t) = 1$ for $t \\ge 0$, zero for $t < 0$):** $$E = \\int_0^\\infty \\left| e^{-3t} \\right|^2 \\, dt = \\int_0^\\infty e^{-6t} \\, dt$$ 3. **Evaluate the Definite Integral:** $$E = \\left[ \\frac{e^{-6t}}{-6} \\right]_0^\\infty = \\left( \\lim_{t\\to\\infty} \\frac{e^{-6t}}{-6} \\right) - \\left( \\frac{e^0}{-6} \\right) = 0 - \\left(-\\frac{1}{6}\\right) = \\mathbf{\\frac{1}{6}\\text{ Joules} \\approx 0.1667\\text{ J}}$$ 4. **Classify the Signal:** - Because total energy $E$ is **finite and non-zero** ($0 < E < \\infty$), $x(t)$ is an **Energy Signal**. - Average power $P = \\lim_{T\\to\\infty} \\frac{E}{2T} = \\mathbf{0\\text{ Watts}}$! Flawless signal energy classification!" },
        { "text": "E = 1/3 Joules and x(t) is an Energy Signal", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "E = infinity and x(t) is a Power Signal with P = 1/6 W", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "E = 1/9 Joules and x(t) is an Energy Signal", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
