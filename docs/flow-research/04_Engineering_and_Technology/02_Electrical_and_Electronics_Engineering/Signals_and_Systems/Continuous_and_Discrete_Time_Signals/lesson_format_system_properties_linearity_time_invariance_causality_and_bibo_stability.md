# Duofy Reusable Lesson Format: System Properties (Linearity, Invariance, Causality, & BIBO)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Signals_and_Systems / Continuous_and_Discrete_Time_Signals`  
**Lesson Format Type:** `system_properties_linearity_time_invariance_causality_and_bibo_stability`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the axiomatic definitions, rigorous mathematical testing procedures, and impulse response criteria for the six fundamental system classifications: Linearity, Time-Invariance (Shift-Invariance), Causality, Bounded-Input Bounded-Output (BIBO) Stability, Memory/Memoryless, and Invertibility in systems engineering (Alan V. Oppenheim & Alan S. Willsky *Signals and Systems* Chapter 1 & 2; B.P. Lathi Chapter 1): define the **Six Fundamental System Axioms**:
1. **Linearity (Superposition):**
   $$\mathbf{T\{a x_1(t) + b x_2(t)\} = a T\{x_1(t)\} + b T\{x_2(t)\} = a y_1(t) + b y_2(t)}}$$
2. **Time-Invariance (TI):**
   $$\mathbf{x(t - t_0) \xrightarrow{T} y(t - t_0) \Longleftrightarrow T\{S_{t_0} x(t)\} = S_{t_0} T\{x(t)\}}$$
3. **Causality:** Output $y(t_0)$ depends strictly on present and past inputs $x(\tau \le t_0)$;
   $$\mathbf{\text{LTI System Causal } \Longleftrightarrow \mathbf{h(t) = 0 \quad (\forall \ t < 0) \quad \Big| \quad h[n] = 0 \quad (\forall \ n < 0)}}}$$
4. **BIBO Stability:** Every bounded input $|x(t)| \le M_x < \infty$ produces a bounded output $|y(t)| \le M_y < \infty$;
   $$\mathbf{\text{LTI System BIBO Stable } \Longleftrightarrow \mathbf{\int_{-\infty}^\infty |h(t)| \, dt < \infty \quad \Big| \quad \sum_{n=-\infty}^\infty |h[n]| < \infty}}$$
5. **Memoryless:** $y(t)$ depends only on input at the exact same instant $t$ ($\mathbf{h(t) = K \delta(t)}$);
6. **Invertibility:** Distinct inputs map to distinct outputs ($\mathbf{h(t) * h_{\text{inv}}(t) = \delta(t)}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Linearity ($T\{ax_1+bx_2\}=ay_1+by_2$), Time-Invariance, Causality ($h(t<0)=0$) & Stability ($\int |h|dt < \infty$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Mathematical Proof Execution to Test System Linearity and Time-Invariance Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | System Property / Axiom & Mathematical Impulse Response Criterion Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | An LTI System Is Bounded-Input Bounded-Output (BIBO) Stable If and Only If Its Impulse Response h(t) Is Absolutely ___ (Integrable / Summable) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Signal Processing Proof Problem: Classifying the System y(t) = t * x(t) for Linearity, Time-Invariance, and Causality Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State System Properties & LTI Criteria (Oppenheim & Willsky 1997; Lathi 2017):
   - **System Properties Axioms Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Property} & \textbf{General System Axiom} & \textbf{LTI Impulse Response Condition } h(t) \\
     \hline
     \mathbf{\text{Linearity}} & T\{a x_1 + b x_2\} = a y_1 + b y_2 & \text{Guaranteed for any convolution } y = x * h \\
     \mathbf{\text{Time-Invariance}} & T\{x(t - t_0)\} = y(t - t_0) & \text{Stationary impulse response } h(t,\tau) = h(t - \tau) \\
     \mathbf{\text{Causality}} & y(t_0) \text{ depends only on } x(\tau \le t_0) & \mathbf{h(t) = 0 \text{ for all } t < 0 \ (h[n] = 0 \text{ for } n < 0)} \\
     \mathbf{\text{BIBO Stability}} & |x(t)| \le M_x \implies |y(t)| \le M_y & \mathbf{\int_{-\infty}^\infty |h(t)| dt < \infty \ \left(\sum_n |h[n]| < \infty\right)} \\
     \mathbf{\text{Memoryless}} & y(t) \text{ depends only on } x(t) & \mathbf{h(t) = K \delta(t) \ (h[n] = K \delta[n])} \\
     \hline
     \end{array}$$
   - **The BIBO Absolute Integrability Invariant:** An LTI system is stable if and only if **total absolute area $\int_{-\infty}^\infty |h(t)| dt$ is finite**!
2. **Slide 2 (`ordering`):** Provide 5 steps of system classification testing: (1) apply linear combination $x_3(t) = a x_1(t) + b x_2(t)$ to system operator $T$ and check if $y_3(t) = a y_1(t) + b y_2(t)$ to prove linearity, (2) apply time-delayed input $x(t - t_0)$ to find response $y(t, t_0)$, (3) delay the original output by $t_0$ to find $y(t - t_0)$, (4) compare $y(t, t_0)$ with $y(t - t_0)$ to prove time-invariance (if equal, system is TI; if unequal, Time-Varying), (5) test causality by checking if output at $t$ depends on future inputs $x(\tau > t)$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Linearity $T\{ax_1+bx_2\}=ay_1+by_2$, Time-Invariance $T\{x(t-t_0)\}=y(t-t_0)$, Causal LTI $h(t<0)=0$, BIBO Stable LTI $\int|h|dt<\infty$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Integrable (or Summable). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on proving system properties: A continuous-time system is described by the input-output relationship: $y(t) = t \cdot x(t)$. Is this system Linear, Time-Invariant, Causal, and BIBO Stable? (Linearity: $T\{a x_1 + b x_2\} = t(a x_1 + b x_2) = a(t x_1) + b(t x_2) = a y_1 + b y_2 \implies$ **Linear**; Time-Invariance: $T\{x(t - t_0)\} = t \cdot x(t - t_0)$; Output delayed: $y(t - t_0) = (t - t_0) x(t - t_0) \ne t x(t - t_0) \implies$ **Time-Varying (NOT TI)**; Causality: $y(t)$ depends only on $x(t)$ at the current instant $t \implies$ **Causal (and memoryless)**; Stability: If $x(t) = 1$ (bounded, $M_x = 1$), then $y(t) = t \to \infty$ as $t \to \infty \implies$ **Unstable (NOT BIBO stable)**; Correct description: **Linear, Time-Varying, Causal, and Unstable**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "system_properties_linearity_time_invariance_causality_and_bibo_stability",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: System Classifications \\& LTI Axioms (Oppenheim \\& Willsky)**\n• **The 4 Core System Testing Axioms:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Property} & \\textbf{General System Axiom} & \\textbf{LTI Impulse Response Condition } h(t) \\\\\n\\hline\n\\mathbf{\\text{Linearity}} & T\\{a x_1(t) + b x_2(t)\\} = a y_1(t) + b y_2(t) & \\text{Guaranteed by convolution } y(t) = x(t) * h(t) \\\\\n\\mathbf{\\text{Time-Invariance}} & T\\{x(t - t_0)\\} = y(t - t_0) & \\text{Stationary impulse response } h(t,\\tau) = h(t - \\tau) \\\\\n\\mathbf{\\text{Causality}} & y(t_0) \\text{ depends only on } x(\\tau \\le t_0) & \\mathbf{h(t) = 0 \\quad (\\forall \\ t < 0) \\quad [h[n] = 0 \\text{ for } n < 0]} \\\\\n\\mathbf{\\text{BIBO Stability}} & |x(t)| \\le M_x \\implies |y(t)| \\le M_y & \\mathbf{\\int_{-\\infty}^\\infty |h(t)| \\, dt < \\infty \\quad \\left(\\sum_n |h[n]| < \\infty\\right)} \\\\\n\\hline\n\\end{array}\n$$\n• **Memoryless System:** $y(t)$ depends strictly on current value $x(t)$ $\\implies \\mathbf{h(t) = K \\delta(t)}$!\n• **The BIBO Absolute Integrability Invariant:** An LTI system is bounded-input bounded-output stable if and only if **total absolute area under $h(t)$ is finite**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to rigorously prove whether an arbitrary system y(t) = T{x(t)} is Linear and Time-Invariant.",
      "orderItems": [
        "Construct a linear combination of two arbitrary inputs: x3(t) = a*x1(t) + b*x2(t)",
        "Apply the system operator to x3(t) and verify if y3(t) = a*y1(t) + b*y2(t) to prove Linearity",
        "Apply a time-delayed input x(t - t0) to the system operator to determine the response y_delayed(t)",
        "Shift the original output signal by t0 to construct y(t - t0)",
        "Compare y_delayed(t) with y(t - t0); if identical for all t and t0, the system is Time-Invariant"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each System Property to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Linearity (Superposition)", "right": "T{a*x1 + b*x2} = a*y1 + b*y2, satisfying both scaling homogeneity and additive superposition" },
        { "left": "Time-Invariance (TI)", "right": "Shifting the input in time causes an identical, unscaled time shift in the output waveform" },
        { "left": "Causality (LTI)", "right": "h(t) = 0 for t < 0, ensuring system output never anticipates or responds to future inputs" },
        { "left": "BIBO Stability (LTI)", "right": "\u222b |h(t)| dt < \u221e, impulse response being absolutely integrable to guarantee bounded outputs" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "An LTI system is BIBO stable if and only if its continuous impulse response h(t) is absolutely ___.",
      "blankAnswer": "integrable",
      "blankDistractors": ["differentiable", "continuous", "periodic"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A system is defined by the input-output relationship: y(t) = t * x(t). What is the complete classification of this system with respect to Linearity, Time-Invariance, Causality, and BIBO Stability?",
      "options": [
        { "text": "Linear, Time-Varying, Causal, and Unstable (Linearity holds; time-delay gives t*x(t-t0) != (t-t0)*x(t-t0) making it time-varying; depends on current t so causal; bounded input x(t)=1 yields unbounded output y(t)=t \u2192 \u221e)", "isCorrect": true, "explanation": "Correct! Let's rigorously test all 4 properties (Alan Oppenheim & Alan Willsky *Signals and Systems* Chapter 1). 1. **Linearity Test:** - Let $x_3(t) = a x_1(t) + b x_2(t)$. - $y_3(t) = t \cdot x_3(t) = t [a x_1(t) + b x_2(t)] = a [t x_1(t)] + b [t x_2(t)] = a y_1(t) + b y_2(t)$. - **System is strictly Linear!** 2. **Time-Invariance Test:** - Response to delayed input $x(t - t_0)$: $$y_1(t) = t \cdot x(t - t_0)$$ - Original output delayed by $t_0$: $$y(t - t_0) = (t - t_0) \cdot x(t - t_0)$$ - Since $t \cdot x(t - t_0) \\ne (t - t_0) \cdot x(t - t_0)$, **System is Time-Varying (NOT Time-Invariant)!** 3. **Causality Test:** - For any time $t$, $y(t)$ depends only on $x(t)$ at the present moment $t$. - **System is strictly Causal (and memoryless)!** 4. **BIBO Stability Test:** - Consider a bounded input: $x(t) = 1$ for all $t$ ($|x(t)| \\le 1 < \\infty$). - Output: $y(t) = t \\cdot (1) = t$. - As $t \\to \\infty$, $y(t) \\to \\infty$ (unbounded!). - **System is NOT BIBO stable (Unstable)!**" },
        { "text": "Linear, Time-Invariant, Causal, and Stable", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Non-Linear, Time-Varying, Non-Causal, and Unstable", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Linear, Time-Invariant, Non-Causal, and Stable", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
