# Duofy Reusable Lesson Format: Fourier Series (Harmonic Expansion & Parseval's Power)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Signals_and_Systems / Fourier_Series_Transforms_and_Laplace`  
**Lesson Format Type:** `continuous_time_fourier_series_harmonics_and_parsevals_power`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through continuous-time periodic signal representations, orthogonal complex harmonic bases ($e^{j k \omega_0 t}$), Dirichlet convergence criteria, Gibbs phenomenon, and Parseval's Power Theorem in harmonic signal analysis (Joseph Fourier 1822; Alan V. Oppenheim & Alan S. Willsky *Signals and Systems* Chapter 3; B.P. Lathi Chapter 3): derive the **Continuous-Time Exponential Fourier Series (CTFS)**:
$$\mathbf{x(t) = \sum_{k=-\infty}^\infty c_k e^{j k \omega_0 t} \quad \Big| \quad \mathbf{c_k = \frac{1}{T_0} \int_{T_0} x(t) e^{-j k \omega_0 t} \, dt} \quad \left(\omega_0 = \frac{2\pi}{T_0}\right)}$$
derive the **Trigonometric Fourier Series Dual Representation**:
$$\mathbf{x(t) = a_0 + \sum_{n=1}^\infty \left[ a_n \cos(n \omega_0 t) + b_n \sin(n \omega_0 t) \right] \quad \Big| \quad c_0 = a_0, \ c_n = \frac{a_n - j b_n}{2}, \ c_{-n} = c_n^*}$$
and master **Parseval's Power Conservation Theorem for Periodic Signals**:
$$\mathbf{P_{\text{avg}} = \frac{1}{T_0} \int_{T_0} |x(t)|^2 \, dt = \sum_{k=-\infty}^\infty |c_k|^2 = a_0^2 + \frac{1}{2} \sum_{n=1}^\infty (a_n^2 + b_n^2)}$$
(proving that total average signal power equals the sum of the powers contained in all individual orthogonal harmonic frequencies).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Exponential CTFS ($x(t) = \sum c_k e^{jk\omega_0 t}$), Coefficients ($c_k$) & Parseval's Power Law Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Complex Fourier Series Coefficients of a Periodic Wave Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Fourier Series Construct / Harmonic Property & Technical Mathematical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Theorem Stating That the Total Time-Domain Average Power of a Periodic Wave Equals the Infinite Sum of Squared Harmonic Magnitudes Is ___ Theorem (Parseval's / Parseval) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Periodic Signal Analysis Problem: Calculating the DC Coefficient c0 and First Harmonic Power of a Square Wave Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State CTFS & Parseval's Theorem (Oppenheim & Willsky 1997; Fourier 1822):
   - **Fourier Series & Power Formulations:**
     $$\mathbf{x(t) = \sum_{k=-\infty}^\infty c_k e^{j k \omega_0 t} \quad \Big| \quad c_k = \frac{1}{T_0} \int_{T_0} x(t) e^{-j k \omega_0 t} dt \quad \Big| \quad \mathbf{P_{\text{avg}} = \frac{1}{T_0}\int_{T_0} |x(t)|^2 dt = \sum_{k=-\infty}^\infty |c_k|^2}}$$
   - **Dirichlet Convergence Criteria Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Dirichlet Condition} & \textbf{Mathematical Definition} & \textbf{Physical Consequence} \\
     \hline
     \mathbf{\text{1. Absolute Integrability}} & \int_{T_0} |x(t)| dt < \infty & \text{Guarantees finite area per period} \\
     \mathbf{\text{2. Bounded Variations}} & \text{Finite number of maxima/minima in } T_0 & \text{Excludes pathological infinite oscillations} \\
     \mathbf{\text{3. Finite Discontinuities}} & \text{Finite step jumps in } T_0 & \text{Converges to midpoint } \frac{x(t^+)+x(t^-)}{2} \\
     \hline
     \end{array}$$
   - **Gibbs Phenomenon Invariant:** At any isolated step discontinuity, truncating the Fourier series to $N$ harmonics produces an overshoot of **strictly $\approx 8.95\%$ ($9\%$) regardless of how large $N$ becomes**!
2. **Slide 2 (`ordering`):** Provide 5 steps of CTFS analysis: (1) determine fundamental period $T_0$ and compute fundamental radian frequency $\omega_0 = 2\pi / T_0$, (2) integrate over one period to find the DC average component $c_0 = \frac{1}{T_0} \int_{T_0} x(t) dt$, (3) set up the complex exponential analysis integral $c_k = \frac{1}{T_0} \int_{T_0} x(t) e^{-j k \omega_0 t} dt$, (4) evaluate the integral to express $c_k$ as a closed-form function of harmonic index $k$ (e.g. $\text{sinc}$ function), (5) apply Parseval's theorem $P = \sum |c_k|^2$ to verify that the power of individual harmonics sums to total waveform power!
3. **Slide 3 (`matching`):** Pair 4 concepts (Fourier Analysis Integral, Parseval's Power Theorem, Gibbs Phenomenon 9% Overshoot, DC Coefficient $c_0$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Parseval's (or Parseval). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on computing Fourier series coefficients: A periodic square wave with fundamental period $T_0 = 4.0\text{ s}$ ($\omega_0 = \frac{2\pi}{4} = \frac{\pi}{2}\text{ rad/s}$) has amplitude $A = 6.0\text{ V}$ for $0 < t < 2.0\text{ s}$ and amplitude $0.0\text{ V}$ for $2.0 < t < 4.0\text{ s}$ ($50\%$ duty cycle). What is the DC average component $c_0$, and what is the magnitude of the fundamental first harmonic coefficient $|c_1|$? ($c_0 = \frac{1}{4} \int_0^2 6.0 \, dt = \frac{1}{4}(12.0) = \mathbf{3.0\text{ V}}$; $c_k = \frac{1}{4} \int_0^2 6.0 e^{-j k (\pi/2) t} dt = \frac{6}{4} \left[ \frac{e^{-j k \pi t / 2}}{-j k \pi / 2} \right]_0^2 = \frac{3}{2} \left( \frac{1 - e^{-j k \pi}}{j k \pi / 2} \right) = \frac{3(1 - (-1)^k)}{j k \pi}$; For $k = 1$: $c_1 = \frac{3(1 - (-1))}{j \pi} = \frac{6}{j \pi} = -j \frac{6}{\pi} \implies |c_1| = \frac{6}{\pi} \approx \mathbf{1.91\text{ V}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "continuous_time_fourier_series_harmonics_and_parsevals_power",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Continuous-Time Fourier Series \\& Parseval's Power (Joseph Fourier 1822)**\n• **Exponential Fourier Series Synthesis \\& Analysis Formulations:**\n$$\n\\mathbf{x(t) = \\sum_{k=-\\infty}^\\infty c_k e^{j k \\omega_0 t} \\quad \\Big| \\quad \\mathbf{c_k = \\frac{1}{T_0} \\int_{T_0} x(t) e^{-j k \\omega_0 t} \\, dt} \\quad \\left(\\omega_0 = \\frac{2\\pi}{T_0}\\right)}\n$$\n• **Parseval's Power Conservation Theorem:**\n$$\n\\mathbf{P_{\\text{avg}} = \\frac{1}{T_0} \\int_{T_0} |x(t)|^2 \\, dt = \\sum_{k=-\\infty}^\\infty |c_k|^2 = c_0^2 + 2 \\sum_{k=1}^\\infty |c_k|^2}\n$$\n• **The Dirichlet Convergence Conditions:**\n  - **1. Absolute Integrability:** $\\int_{T_0} |x(t)| dt < \\infty$;\n  - **2. Finite Maxima/Minima:** Finite bounded variations per period;\n  - **3. Finite Discontinuities:** At step jumps, series converges to midpoint $\\frac{x(t^+) + x(t^-)}{2}$!\n• **The Gibbs Phenomenon Invariant:** Truncating a Fourier series at jump discontinuities exhibits an irreducible ringing overshoot of **strictly $\\approx 8.95\\%$ ($9\\%$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the complex exponential Fourier series coefficients c_k and total harmonic power of a periodic signal.",
      "orderItems": [
        "Determine the fundamental period T0 and compute the fundamental radian frequency: omega_0 = 2*pi / T0",
        "Evaluate the DC average component: c0 = (1 / T0) * \u222b[T0] x(t) dt",
        "Formulate the complex harmonic analysis integral: ck = (1 / T0) * \u222b[T0] x(t) * exp(-j*k*omega_0*t) dt",
        "Evaluate the integral to express ck as an analytical function of harmonic index k",
        "Apply Parseval's power identity P_avg = \u2211 |ck|^2 to calculate the cumulative power contained in the harmonics"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Fourier Series Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Analysis Integral (ck)", "right": "ck = (1/T0) * \u222b x(t)*e^(-jk\u03c90t) dt, projecting periodic wave onto orthogonal harmonic basis" },
        { "left": "Parseval's Power Theorem", "right": "P = \u2211 |ck|^2, proving conservation of energy rate between time domain and harmonic spectrum" },
        { "left": "Gibbs Phenomenon", "right": "Persistent ~9% overshoot ringing occurring near jump discontinuities for finite harmonic sums" },
        { "left": "DC Coefficient (c0)", "right": "c0 = (1/T0) * \u222b x(t) dt, representing the time-average non-oscillating baseline level of the signal" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The theorem stating that total periodic signal power equals the infinite sum of squared harmonic coefficients is ___ theorem.",
      "blankAnswer": "Parseval's",
      "blankDistractors": ["Fourier's", "Laplace's", "Dirichlet's"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A periodic square wave has period T0 = 4.0 s (\u03c90 = \u03c0/2 rad/s). The signal is x(t) = 6.0 V for 0 < t < 2.0 s, and x(t) = 0.0 V for 2.0 < t < 4.0 s. What is the DC average component c0 and the magnitude of the fundamental first harmonic coefficient |c1|?",
      "options": [
        { "text": "c0 = 3.0 V and |c1| = 1.91 V (6/\u03c0 V) (c0 = (1/4)*\u222b[0,2] 6 dt = 3.0 V; and ck = 3*(1 - (-1)^k) / (j*k*\u03c0) \u2192 c1 = 6 / (j*\u03c0) \u2192 |c1| = 6/\u03c0 \u2248 1.91 V)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using continuous-time Fourier series analysis (Alan Oppenheim & Alan Willsky *Signals and Systems* Chapter 3). 1. **Calculate the DC Component ($c_0$):** $$c_0 = \\frac{1}{T_0} \\int_0^{T_0} x(t) \\, dt = \\frac{1}{4.0\\text{ s}} \\int_0^{2.0} 6.0 \\, dt = \\frac{1}{4.0} \\times (6.0 \\times 2.0) = \\frac{12.0}{4.0} = \\mathbf{3.0\\text{ Volts}}$$ 2. **Calculate Fourier Harmonic Coefficients ($c_k$ for $k \\ne 0$):** $$c_k = \\frac{1}{T_0} \\int_0^{T_0} x(t) e^{-j k \\omega_0 t} \\, dt = \\frac{1}{4} \\int_0^2 6.0 e^{-j k (\\pi/2) t} \\, dt$$ $$c_k = \\frac{6}{4} \\left[ \\frac{e^{-j k (\\pi/2) t}}{-j k \\pi / 2} \\right]_0^2 = \\frac{3}{2} \\left( \\frac{e^{-j k \\pi} - 1}{-j k \\pi / 2} \\right) = \\frac{3 \\left( 1 - e^{-j k \\pi} \\right)}{j k \\pi} = \\frac{3 \\left( 1 - (-1)^k \\right)}{j k \\pi}$$ 3. **Evaluate at Fundamental Harmonic ($k = 1$):** $$c_1 = \\frac{3 (1 - (-1)^1)}{j (1) \\pi} = \\frac{3 (2)}{j \\pi} = \\frac{6}{j \\pi} = -j \\frac{6}{\\pi}$$ 4. **Calculate Magnitude ($|c_1|$):** $$|c_1| = \\left| -j \\frac{6}{\\pi} \\right| = \\frac{6}{\\pi} \\approx \\mathbf{1.90986\\text{ V} \\approx 1.91\\text{ Volts}}$$ Flawless Fourier series harmonic derivation!" },
        { "text": "c0 = 6.0 V and |c1| = 3.82 V", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "c0 = 3.0 V and |c1| = 0.95 V (3/\u03c0 V)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "c0 = 0.0 V and |c1| = 1.91 V", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
