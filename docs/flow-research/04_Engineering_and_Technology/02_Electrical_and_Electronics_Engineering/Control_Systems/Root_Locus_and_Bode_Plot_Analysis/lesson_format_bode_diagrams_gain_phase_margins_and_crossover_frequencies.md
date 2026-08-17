# Duofy Reusable Lesson Format: Frequency Response (Bode Plots, Gain & Phase Margins)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Control_Systems / Root_Locus_and_Bode_Plot_Analysis`  
**Lesson Format Type:** `bode_diagrams_gain_phase_margins_and_crossover_frequencies`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through logarithmic frequency response analysis, asymptotic Bode magnitude ($20\log_{10}|G(j\omega)|$) and phase ($\angle G(j\omega)$) curves, Gain Crossover frequency ($\omega_{gc}$), Phase Crossover frequency ($\omega_{pc}$), Gain Margin ($\text{GM}$), Phase Margin ($\text{PM}$), and relative stability metrics in feedback amplifier design (Hendrik W. Bode 1940; Katsuhiko Ogata *Modern Control Engineering* Chapter 7; Norman S. Nise *Control Systems Engineering* Chapter 10): master the **Bode Asymptotic Slope Rules**:
- **Pole at Origin ($1/s$):** Straight line with constant slope $-20\text{ dB/decade}$, phase $-90^\circ$;
- **Simple Zero $(1 + j\omega/\omega_z)$:** $+20\text{ dB/decade}$ slope above $\omega_z$, phase $+45^\circ/\text{decade}$ from $0.1\omega_z$ to $10\omega_z$;
- **Simple Pole $(1 + j\omega/\omega_p)$:** $-20\text{ dB/decade}$ slope above $\omega_p$, phase $-45^\circ/\text{decade}$ from $0.1\omega_p$ to $10\omega_p$;
derive the **Relative Stability Margin Equations**:
$$\mathbf{\text{Gain Crossover Frequency } (\omega_{gc}): \quad |G(j\omega_{gc})H(j\omega_{gc})| = 1 \ (0\text{ dB}) \implies \mathbf{\text{PM} = 180^\circ + \angle G(j\omega_{gc})H(j\omega_{gc})}}$$
$$\mathbf{\text{Phase Crossover Frequency } (\omega_{pc}): \quad \angle G(j\omega_{pc})H(j\omega_{pc}) = -180^\circ \implies \mathbf{\text{GM} = -20 \log_{10} |G(j\omega_{pc})H(j\omega_{pc})| \ [\text{dB}]}}$$
master the **Minimum-Phase Stability Rule**:
$$\mathbf{\text{Closed-Loop System Strictly Stable } \Longleftrightarrow \mathbf{\text{PM} > 0^\circ \text{ and } \text{GM} > 0\text{ dB}} \Longleftrightarrow \mathbf{\omega_{gc} < \omega_{pc}}}$$
(analyzing how Phase Margin directly correlates with closed-loop damping: $\text{PM} \approx 100 \zeta$, where $\text{PM} = 45^\circ \implies \zeta \approx 0.45, \ \%M_p \approx 20\%$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bode Plots, Gain Crossover ($\omega_{gc}$), Phase Margin ($\text{PM} = 180^\circ + \angle G$) & GM ($\text{dB}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate \omega_gc, \omega_pc, GM, and PM from an Open-Loop Transfer Function Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Frequency Domain Metric / Crossover Point & Technical Stability Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Frequency at Which the Open-Loop Magnitude Evaluates to Exactly Unity (0 dB) Is the Gain ___ Frequency (Crossover / \omega_gc) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Frequency-Domain Stability Problem: Calculating \omega_pc, \omega_gc, GM, and PM for a Feedback System Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Bode Diagrams & Stability Margins (Ogata 2010; Bode 1940):
   - **Margin Formulations:**
     $$\mathbf{|G(j\omega_{gc})| = 1 \ (0\text{ dB}) \implies \text{PM} = 180^\circ + \angle G(j\omega_{gc}) \quad \Big| \quad \angle G(j\omega_{pc}) = -180^\circ \implies \text{GM} = -20\log_{10}|G(j\omega_{pc})|}$$
   - **Bode Slope Synthesis Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Factor in } G(j\omega) & \textbf{Magnitude Asymptotic Slope} & \textbf{Phase Angle Contribution} \\
     \hline
     \mathbf{\text{Integrator } (1 / j\omega)} & \mathbf{-20\text{ dB/decade (Everywhere)}} & \mathbf{-90^\circ \text{ (Constant)}} \\
     \mathbf{\text{Differentiator } (j\omega)} & \mathbf{+20\text{ dB/decade (Everywhere)}} & \mathbf{+90^\circ \text{ (Constant)}} \\
     \mathbf{\text{Simple Pole } (1 + j\omega/\omega_p)^{-1}} & 0\text{ dB/dec for } \omega < \omega_p \to \mathbf{-20\text{ dB/dec for } \omega > \omega_p} & -45^\circ/\text{dec from } 0.1\omega_p \text{ to } 10\omega_p \\
     \mathbf{\text{Simple Zero } (1 + j\omega/\omega_z)} & 0\text{ dB/dec for } \omega < \omega_z \to \mathbf{+20\text{ dB/dec for } \omega > \omega_z} & +45^\circ/\text{dec from } 0.1\omega_z \text{ to } 10\omega_z \\
     \hline
     \end{array}$$
   - **The Phase Margin Rule of Thumb:** In standard control loops, achieving a **Phase Margin $\text{PM} \approx 45^\circ \text{ to } 60^\circ$** guarantees excellent transient damping ($\zeta \approx 0.5 \text{ to } 0.6$) with moderate overshoot ($\%M_p < 15\%$)!
2. **Slide 2 (`ordering`):** Provide 5 steps to compute PM and GM: (1) express open-loop plant in frequency domain $G(j\omega)H(j\omega)$, (2) solve phase crossover equation $\angle G(j\omega_{pc})H(j\omega_{pc}) = -180^\circ$ for $\omega_{pc}$, (3) evaluate magnitude at $\omega_{pc}$ to compute Gain Margin $\text{GM} = -20\log_{10}|G(j\omega_{pc})|$, (4) solve gain crossover equation $|G(j\omega_{gc})H(j\omega_{gc})| = 1.0$ for $\omega_{gc}$, (5) evaluate Phase Margin $\text{PM} = 180^\circ + \angle G(j\omega_{gc})$ and confirm $\text{PM} > 0$ and $\text{GM} > 0\text{ dB}$ for stability!
3. **Slide 3 (`matching`):** Pair 4 concepts (Gain Crossover Frequency $\omega_{gc}$, Phase Crossover Frequency $\omega_{pc}$, Phase Margin PM, Gain Margin GM) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Crossover (or \omega_gc). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating GM and PM: An open-loop control system has transfer function $G(s) = \frac{10}{s (s + 1)}$. What is the phase crossover frequency $\omega_{pc}$, gain crossover frequency $\omega_{gc}$, Phase Margin $\text{PM}$, and Gain Margin $\text{GM}$? ($\angle G(j\omega) = -90^\circ - \arctan(\omega)$; For phase to reach $-180^\circ$, $-\arctan(\omega) = -90^\circ \implies \omega_{pc} \to \infty$; Since magnitude $|G(j\omega)| \to 0$ as $\omega \to \infty$, $\text{GM} = \mathbf{+\infty\text{ dB}}$; Gain crossover: $|G(j\omega_{gc})| = \frac{10}{\omega\sqrt{\omega^2 + 1}} = 1 \implies \omega^2(\omega^2 + 1) = 100 \implies \omega^4 + \omega^2 - 100 = 0$; Let $u = \omega^2$: $u = \frac{-1 + \sqrt{1 + 400}}{2} = \frac{-1 + 20.025}{2} = 9.512 \implies \omega_{gc} = \sqrt{9.512} \approx \mathbf{3.084\text{ rad/s}}$; Phase at $\omega_{gc}$: $\angle G(j 3.084) = -90^\circ - \arctan(3.084) = -90^\circ - 72.04^\circ = -162.04^\circ$; Phase Margin: $\text{PM} = 180^\circ + (-162.04^\circ) = \mathbf{+17.96^\circ \approx 18.0^\circ}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "bode_diagrams_gain_phase_margins_and_crossover_frequencies",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Bode Frequency Response \\& Stability Margins (Hendrik Bode 1940)**\n• **Gain Crossover Frequency ($\\omega_{gc}$) \\& Phase Margin (PM):**\n$$\n\\mathbf{|G(j\\omega_{gc})H(j\\omega_{gc})| = 1 \\ (0\\text{ dB}) \\implies \\mathbf{\\text{PM} = 180^\\circ + \\angle G(j\\omega_{gc})H(j\\omega_{gc})}}\n$$\n• **Phase Crossover Frequency ($\\omega_{pc}$) \\& Gain Margin (GM):**\n$$\n\\mathbf{\\angle G(j\\omega_{pc})H(j\\omega_{pc}) = -180^\\circ \\implies \\mathbf{\\text{GM} = -20 \\log_{10} |G(j\\omega_{pc})H(j\\omega_{pc})| \\ [\\text{dB}] = \\frac{1}{|G(j\\omega_{pc})H(j\\omega_{pc})|}}}\n$$\n• **Asymptotic Bode Slopes:**\n  - **Integrator ($1/s$):** Fixed $-20\\text{ dB/decade}$, Phase $-90^\\circ$;\n  - **Simple Pole ($1 + s/\\omega_p$):** Breaks to $-20\\text{ dB/decade}$ for $\\omega > \\omega_p$, Phase drops by $-90^\\circ$;\n  - **Simple Zero ($1 + s/\\omega_z$):** Breaks to $+20\\text{ dB/decade}$ for $\\omega > \\omega_z$, Phase rises by $+90^\\circ$;\n• **The Stability Criterion Invariant:** A minimum-phase feedback system is strictly stable if and only if **both $\\mathbf{\\text{PM} > 0^\\circ}$ and $\\mathbf{\\text{GM} > 0\\text{ dB}}$ (equivalent to $\\mathbf{\\omega_{gc} < \\omega_{pc}}$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to extract Gain Margin and Phase Margin from an open-loop frequency response function G(j\u03c9)H(j\u03c9).",
      "orderItems": [
        "Express the open-loop transfer function in sinusoidal frequency form by substituting s = j*omega",
        "Formulate the phase angle equation \u2220GH(\u03c9) and solve \u2220GH(\u03c9_pc) = -180\u00b0 for the phase crossover frequency \u03c9_pc",
        "Evaluate the magnitude |GH(\u03c9_pc)| to compute the Gain Margin: GM = -20*log10(|GH(\u03c9_pc)|) dB",
        "Formulate the magnitude equation |GH(\u03c9)| and solve |GH(\u03c9_gc)| = 1.0 (0 dB) for the gain crossover frequency \u03c9_gc",
        "Evaluate the phase angle at \u03c9_gc to compute the Phase Margin: PM = 180\u00b0 + \u2220GH(\u03c9_gc) and verify PM > 0\u00b0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Frequency Response Term to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Gain Crossover (\u03c9gc)", "right": "Frequency where open-loop magnitude curve crosses the 0 dB (unity gain) axis" },
        { "left": "Phase Margin (PM)", "right": "PM = 180\u00b0 + \u2220GH(\u03c9gc), additional phase lag at \u03c9gc required to drive the closed-loop system into instability" },
        { "left": "Phase Crossover (\u03c9pc)", "right": "Frequency where open-loop phase angle curve crosses the -180\u00b0 phase axis" },
        { "left": "Gain Margin (GM)", "right": "GM = -20*log10|GH(\u03c9pc)| dB, factor by which plant gain can increase before instability occurs" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The frequency at which the open-loop system magnitude evaluates to exactly unity (0 dB) is the gain ___ frequency.",
      "blankAnswer": "crossover",
      "blankDistractors": ["corner", "breakaway", "resonant"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An open-loop plant has transfer function G(s) = 10 / [s(s + 1)]. What is the phase crossover frequency \u03c9pc, gain crossover frequency \u03c9gc, Gain Margin GM, and Phase Margin PM?",
      "options": [
        { "text": "\u03c9pc = \u221e rad/s (GM = +\u221e dB), \u03c9gc = 3.08 rad/s, and PM = +18.0\u00b0 (\u2220G = -90\u00b0 - arctan(\u03c9) \u2192 reaches -180\u00b0 only at \u03c9 = \u221e \u2192 GM = \u221e; |G| = 10/(\u03c9\u221a(\u03c9^2+1)) = 1 \u2192 \u03c9gc = 3.084 rad/s; PM = 180\u00b0 - 90\u00b0 - arctan(3.084) = 17.96\u00b0)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using frequency response equations (Katsuhiko Ogata *Modern Control Engineering* Chapter 7). 1. **Formulate Magnitude and Phase Functions:** - $$|G(j\\omega)| = \\frac{10}{\\omega \\sqrt{\\omega^2 + 1^2}}$$ - $$\\angle G(j\\omega) = -90^\\circ - \\arctan(\\omega)$$ 2. **Find Phase Crossover Frequency ($\\omega_{pc}$):** - Set $\\angle G(j\\omega_{pc}) = -180^\\circ$: $$-90^\\circ - \\arctan(\\omega_{pc}) = -180^\\circ \\implies \\arctan(\\omega_{pc}) = 90^\\circ \\implies \\mathbf{\\omega_{pc} \\to \\infty}$$ - At $\\omega \\to \\infty$, $|G(j\\omega)| \\to 0$. - $$\\text{Gain Margin (GM)} = \\frac{1}{0} = \\mathbf{+\\infty\\text{ dB}}$$ 3. **Find Gain Crossover Frequency ($\\omega_{gc}$):** - Set $|G(j\\omega_{gc})| = 1.0$: $$\\frac{10}{\\omega \\sqrt{\\omega^2 + 1}} = 1 \\implies 100 = \\omega^2 (\\omega^2 + 1) = \\omega^4 + \\omega^2$$ - Let $u = \\omega^2$: $$u^2 + u - 100 = 0 \\implies u = \\frac{-1 + \\sqrt{1 + 400}}{2} = \\frac{-1 + 20.02498}{2} = 9.51249$$ - $$\\omega_{gc} = \\sqrt{u} = \\sqrt{9.51249} = \\mathbf{3.0842\\text{ rad/s} \\approx 3.08\\text{ rad/s}}$$ 4. **Calculate Phase Margin (PM):** - Evaluate phase at $\\omega_{gc} = 3.0842\\text{ rad/s}$: $$\\angle G(j\\omega_{gc}) = -90^\\circ - \\arctan(3.0842) = -90^\\circ - 72.043^\\circ = \\mathbf{-162.043^\\circ}$$ - $$\\text{PM} = 180^\\circ + \\angle G(j\\omega_{gc}) = 180^\\circ - 162.043^\\circ = \\mathbf{+17.957^\\circ \\approx +18.0^\\circ}$$ Flawless Bode plot stability margin analysis!" },
        { "text": "\u03c9pc = 3.08 rad/s, \u03c9gc = \u221e rad/s, GM = 18 dB, and PM = +\u221e\u00b0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c9pc = 1.00 rad/s, \u03c9gc = 10.0 rad/s, GM = 0 dB, and PM = -45.0\u00b0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c9pc = \u221e rad/s, \u03c9gc = 3.08 rad/s, GM = 10 dB, and PM = +45.0\u00b0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
