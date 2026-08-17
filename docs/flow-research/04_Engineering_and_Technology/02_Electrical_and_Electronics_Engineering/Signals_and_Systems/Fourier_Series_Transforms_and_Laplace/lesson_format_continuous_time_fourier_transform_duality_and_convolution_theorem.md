# Duofy Reusable Lesson Format: Fourier Transforms (Duality & Convolution Theorems)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Signals_and_Systems / Fourier_Series_Transforms_and_Laplace`  
**Lesson Format Type:** `continuous_time_fourier_transform_duality_and_convolution_theorem`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through non-periodic spectral representations, the Continuous-Time Fourier Transform (CTFT) forward and inverse integral pair, spectral density functions, Duality, Frequency Modulation/Translation, Convolution-to-Multiplication Mapping, and Parseval's Energy Theorem in communication systems (Alan V. Oppenheim & Alan S. Willsky *Signals and Systems* Chapter 4 & 5; B.P. Lathi Chapter 4): derive the **Continuous-Time Fourier Transform (CTFT) Pair**:
$$\mathbf{X(j\omega) = \mathcal{F}\{x(t)\} = \int_{-\infty}^\infty x(t) e^{-j\omega t} \, dt \quad \Longleftrightarrow \quad \mathbf{x(t) = \mathcal{F}^{-1}\{X(j\omega)\} = \frac{1}{2\pi} \int_{-\infty}^\infty X(j\omega) e^{j\omega t} \, d\omega}}$$
derive the **Fundamental CTFT Operational Theorems**:
1. **Convolution Theorem:** $\mathbf{\mathcal{F}\{x(t) * h(t)\} = X(j\omega) \cdot H(j\omega)}$ (converting time-domain convolution into algebraic multiplication);
2. **Multiplication / Modulation Theorem:** $\mathbf{\mathcal{F}\{x(t) \cdot p(t)\} = \frac{1}{2\pi} \left[ X(j\omega) * P(j\omega) \right]}$;
3. **Duality Property:** $\mathbf{\text{If } x(t) \stackrel{\mathcal{F}}{\longleftrightarrow} X(j\omega), \ \text{then } X(t) \stackrel{\mathcal{F}}{\longleftrightarrow} 2\pi x(-\omega)}$ (linking rectangular pulses to $\text{sinc}$ spectra and $\text{sinc}$ time pulses to ideal brick-wall rectangular filters);
4. **Parseval's Energy Conservation Theorem:**
   $$\mathbf{E_{\text{total}} = \int_{-\infty}^\infty |x(t)|^2 \, dt = \frac{1}{2\pi} \int_{-\infty}^\infty |X(j\omega)|^2 \, d\omega}$$

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CTFT Integral Pair ($X(j\omega) = \int x e^{-j\omega t} dt$), Convolution ($\mathcal{F}\{x*h\} = X \cdot H$) & Duality Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Filter a Signal via the CTFT Convolution Theorem Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | CTFT Property / Operational Law & Technical Frequency-Domain Consequence Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Fundamental Theorem Stating That Time-Domain Convolution Transforms into Frequency-Domain Multiplication Is the ___ Theorem (Convolution) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Signal Processing CTFT Problem: Finding the Output Spectrum Y(j\omega) and Time Signal y(t) of an LTI Filter Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State CTFT & Convolution Property (Oppenheim & Willsky 1997; Lathi 2017):
   - **CTFT Integral Formulations:**
     $$\mathbf{X(j\omega) = \int_{-\infty}^\infty x(t) e^{-j\omega t} dt \quad \Big| \quad x(t) = \frac{1}{2\pi}\int_{-\infty}^\infty X(j\omega) e^{j\omega t} d\omega \quad \Big| \quad \mathcal{F}\{x(t) * h(t)\} = X(j\omega) H(j\omega)}$$
   - **CTFT Property Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Transform Property} & \textbf{Time Domain } x(t) & \textbf{Frequency Domain } X(j\omega) \\
     \hline
     \mathbf{\text{Time Shifting}} & x(t - t_0) & \mathbf{e^{-j\omega t_0} X(j\omega)} \\
     \mathbf{\text{Frequency Modulation}} & x(t) e^{j\omega_0 t} & \mathbf{X(j(\omega - \omega_0))} \\
     \mathbf{\text{Time Scaling}} & x(at) \ (a \ne 0) & \mathbf{\frac{1}{|a|} X\left(j\frac{\omega}{a}\right)} \\
     \mathbf{\text{Duality}} & X(t) & \mathbf{2\pi x(-\omega)} \\
     \mathbf{\text{Time Convolution}} & x(t) * h(t) & \mathbf{X(j\omega) \cdot H(j\omega)} \\
     \hline
     \end{array}$$
   - **The Scaling Uncertainty Invariant:** Compressing a signal in the time domain ($x(at)$ with $a > 1$) **expands its bandwidth in the frequency domain ($X(j\omega/a)$)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of frequency-domain filtering: (1) compute the CTFT of the input excitation $X(j\omega) = \mathcal{F}\{x(t)\}$, (2) compute the frequency response (CTFT of impulse response) $H(j\omega) = \mathcal{F}\{h(t)\}$, (3) multiply spectra algebraically to obtain output spectrum $Y(j\omega) = X(j\omega) \cdot H(j\omega)$, (4) perform partial fraction expansion on $Y(j\omega)$ if necessary, (5) take the inverse Fourier transform $\mathcal{F}^{-1}\{Y(j\omega)\}$ to obtain time-domain output $y(t)$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Time Convolution $X(j\omega)H(j\omega)$, Duality $X(t) \leftrightarrow 2\pi x(-\omega)$, Modulation $X(j(\omega-\omega_0))$, Parseval's Energy Theorem) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Convolution. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on LTI filtering via CTFT: An LTI system has impulse response $h(t) = e^{-2t} u(t)$ with frequency response $H(j\omega) = \frac{1}{2 + j\omega}$. An input signal $x(t) = e^{-4t} u(t)$ ($X(j\omega) = \frac{1}{4 + j\omega}$) is applied. What is the output time-domain signal $y(t) = x(t) * h(t)$? ($Y(j\omega) = X(j\omega) H(j\omega) = \frac{1}{(j\omega + 2)(j\omega + 4)}$; Partial fraction expansion: $\frac{1}{(j\omega + 2)(j\omega + 4)} = \frac{A}{j\omega + 2} + \frac{B}{j\omega + 4}$; $A = \left.\frac{1}{j\omega + 4}\right|_{j\omega = -2} = \frac{1}{2} = 0.5$; $B = \left.\frac{1}{j\omega + 2}\right|_{j\omega = -4} = -\frac{1}{2} = -0.5$; $Y(j\omega) = \frac{0.5}{j\omega + 2} - \frac{0.5}{j\omega + 4}$; Taking inverse CTFT: $y(t) = \mathbf{\left[ 0.5 e^{-2t} - 0.5 e^{-4t} \right] u(t) = \frac{1}{2}(e^{-2t} - e^{-4t}) u(t)}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "continuous_time_fourier_transform_duality_and_convolution_theorem",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Continuous-Time Fourier Transform \\& Duality (Oppenheim \\& Willsky)**\n• **Forward Analysis \\& Inverse Synthesis Transform Pair:**\n$$\n\\mathbf{X(j\\omega) = \\int_{-\\infty}^\\infty x(t) e^{-j\\omega t} \\, dt \\quad \\Longleftrightarrow \\quad x(t) = \\frac{1}{2\\pi} \\int_{-\\infty}^\\infty X(j\\omega) e^{j\\omega t} \\, d\\omega}\n$$\n• **The Convolution Theorem (Time-Domain to Frequency-Domain Mapping):**\n$$\n\\mathbf{\\mathcal{F}\\{x(t) * h(t)\\} = X(j\\omega) \\cdot H(j\\omega) \\quad \\Longleftrightarrow \\quad \\mathcal{F}\\{x(t) \\cdot p(t)\\} = \\frac{1}{2\\pi} \\left[ X(j\\omega) * P(j\\omega) \\right]}\n$$\n• **The Duality Property:**\n$$\n\\mathbf{x(t) \\stackrel{\\mathcal{F}}{\\longleftrightarrow} X(j\\omega) \\implies \\mathbf{X(t) \\stackrel{\\mathcal{F}}{\\longleftrightarrow} 2\\pi x(-\\omega)}}\n$$\n• **Parseval's Energy Conservation Theorem:**\n$$\n\\mathbf{E_{\\text{total}} = \\int_{-\\infty}^\\infty |x(t)|^2 \\, dt = \\frac{1}{2\\pi} \\int_{-\\infty}^\\infty |X(j\\omega)|^2 \\, d\\omega}\n$$\n• **The Uncertainty Invariant:** Time-domain compression ($x(at)$ with $a > 1$) forces **frequency-domain expansion ($\\frac{1}{|a|} X(j\\omega/a)$)**, proving that a signal cannot be simultaneously narrow in both time and frequency!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to solve an LTI system output y(t) using the Continuous-Time Fourier Transform Convolution Theorem.",
      "orderItems": [
        "Compute the Fourier transform of the input signal: X(j*omega) = F{x(t)}",
        "Compute the system frequency response: H(j*omega) = F{h(t)}",
        "Multiply the spectra algebraically to determine the output spectrum: Y(j*omega) = X(j*omega) * H(j*omega)",
        "Perform partial fraction expansion on Y(j*omega) to decompose it into standard transform pairs",
        "Apply the inverse Fourier transform F^-1{Y(j*omega)} to obtain the time-domain output signal y(t)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Fourier Transform Property to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Convolution Theorem", "right": "F{x(t) * h(t)} = X(j\u03c9) * H(j\u03c9), converting complex time convolution into simple algebraic multiplication" },
        { "left": "Duality Property", "right": "F{X(t)} = 2*\u03c0 * x(-\u03c9), establishing symmetric equivalence between time and frequency domains" },
        { "left": "Modulation Theorem", "right": "F{x(t) * e^(j\u03c90t)} = X(j(\u03c9 - \u03c90)), shifting the baseband signal spectrum to carrier frequency \u03c90" },
        { "left": "Parseval's Energy Theorem", "right": "E = (1/2\u03c0) * \u222b |X(j\u03c9)|^2 d\u03c9, proving total signal energy equals the integral of energy spectral density" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The fundamental theorem stating that time-domain convolution transforms into frequency-domain multiplication is the ___ theorem.",
      "blankAnswer": "convolution",
      "blankDistractors": ["duality", "modulation", "sampling"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An LTI system has impulse response h(t) = exp(-2t) * u(t) (H(j\u03c9) = 1 / (2 + j\u03c9)). The input signal is x(t) = exp(-4t) * u(t) (X(j\u03c9) = 1 / (4 + j\u03c9)). What is the output time signal y(t) = x(t) * h(t)?",
      "options": [
        { "text": "y(t) = 0.5 * [exp(-2t) - exp(-4t)] * u(t) (Y(j\u03c9) = 1 / [(j\u03c9 + 2)(j\u03c9 + 4)] = 0.5/(j\u03c9 + 2) - 0.5/(j\u03c9 + 4) \u2192 y(t) = (0.5*e^-2t - 0.5*e^-4t)*u(t))", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the CTFT Convolution Theorem and partial fraction expansion (Alan Oppenheim & Alan Willsky *Signals and Systems* Chapter 4). 1. **Compute Output Spectrum ($Y(j\omega)$):** $$Y(j\omega) = X(j\omega) \\cdot H(j\omega) = \\left( \\frac{1}{4 + j\omega} \\right) \\left( \\frac{1}{2 + j\omega} \\right) = \\frac{1}{(j\omega + 2)(j\omega + 4)}$$ 2. **Apply Partial Fraction Expansion (PFE):** $$\\frac{1}{(j\omega + 2)(j\omega + 4)} = \\frac{A}{j\omega + 2} + \\frac{B}{j\omega + 4}$$ - Find residue $A$: $$A = \\left. \\frac{1}{j\omega + 4} \\right|_{j\omega = -2} = \\frac{1}{-2 + 4} = \\frac{1}{2} = \\mathbf{0.5}$$ - Find residue $B$: $$B = \\left. \\frac{1}{j\omega + 2} \\right|_{j\omega = -4} = \\frac{1}{-4 + 2} = -\\frac{1}{2} = \\mathbf{-0.5}$$ 3. **Assemble Decomposed Spectrum:** $$Y(j\omega) = \\frac{0.5}{j\omega + 2} - \\frac{0.5}{j\omega + 4}$$ 4. **Take the Inverse Fourier Transform ($\\mathcal{F}^{-1}$):** - Using standard pair $\\mathcal{F}^{-1}\\left\\{ \\frac{1}{a + j\\omega} \\right\\} = e^{-at} u(t)$ for $a > 0$: $$y(t) = \\mathbf{0.5 e^{-2t} u(t) - 0.5 e^{-4t} u(t) = \\frac{1}{2} \\left( e^{-2t} - e^{-4t} \\right) u(t)}$$ Flawless frequency-domain convolution solution!" },
        { "text": "y(t) = [exp(-2t) + exp(-4t)] * u(t)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "y(t) = [exp(-6t)] * u(t) (Incorrectly multiplying time signals)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "y(t) = 0.25 * [exp(-2t) - exp(-4t)] * u(t)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
