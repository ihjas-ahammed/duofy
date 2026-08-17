# Duofy Reusable Lesson Format: Singularity Functions (Dirac Delta & Step Operations)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Signals_and_Systems / Continuous_and_Discrete_Time_Signals`  
**Lesson Format Type:** `singularity_functions_dirac_delta_sifting_and_unit_step`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through generalized singularity functions, the continuous Heaviside unit step $u(t)$, discrete unit step $u[n]$, Dirac delta distribution $\delta(t)$, discrete unit impulse $\delta[n]$, the Sifting/Sampling property, and time/amplitude scaling transformations in signal analysis (Paul Dirac 1927; Oliver Heaviside; Alan V. Oppenheim & Alan S. Willsky *Signals and Systems* Chapter 1; B.P. Lathi Chapter 1): master the **Calculus of Singularity Functions**:
$$\mathbf{u(t) = \begin{cases} 1, & t > 0 \\ 0, & t < 0 \end{cases} \quad \Longleftrightarrow \quad \mathbf{\delta(t) = \frac{du(t)}{dt} \quad \Big| \quad u(t) = \int_{-\infty}^t \delta(\tau) \, d\tau}}$$
derive the **Fundamental Mathematical Properties of Dirac Delta ($\delta(t)$)**:
1. **The Sampling / Sifting Property (Continuous & Discrete):**
   $$\mathbf{\int_{-\infty}^\infty x(t) \cdot \delta(t - t_0) \, dt = x(t_0) \quad \Big| \quad \sum_{k=-\infty}^\infty x[k] \cdot \delta[n - k] = x[n]}$$
2. **The Product Property:**
   $$\mathbf{x(t) \cdot \delta(t - t_0) = x(t_0) \cdot \delta(t - t_0)}$$
3. **The Time Scaling Property ($a \ne 0$):**
   $$\mathbf{\delta(at - b) = \frac{1}{|a|} \delta\left(t - \frac{b}{a}\right)}$$
(proving how the absolute value $\frac{1}{|a|}$ preserves total unit impulse area under time reversal $\delta(-t) = \delta(t)$ and compression/dilation).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Singularity Functions ($\delta(t) = \frac{du}{dt}$), Sifting ($\int x \delta dt = x(t_0)$) & Scaling ($\delta(at) = \frac{1}{|a|}\delta(t)$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Evaluate an Integral Containing a Scaled and Shifted Delta Function Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Singularity Function Property / Operation & Technical Mathematical Identity Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Mathematical Property Where an Integral Product of x(t) and \delta(t-t0) Extracts the Exact Value x(t0) Is the ___ Property (Sifting / Sampling) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Signal Calculus Problem: Evaluating an Integral Containing a Scaled Dirac Delta Function \delta(3t - 6) Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Singularity Functions & Delta Properties (Oppenheim & Willsky 1997; Dirac 1927):
   - **Singularity Identities Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Property Name} & \textbf{Continuous Formulation } \delta(t) & \textbf{Discrete Formulation } \delta[n] \\
     \hline
     \mathbf{\text{Sifting / Sampling}} & \mathbf{\int_{-\infty}^\infty x(t) \delta(t - t_0) dt = x(t_0)} & \mathbf{\sum_{k=-\infty}^\infty x[k] \delta[n - k] = x[n]} \\
     \mathbf{\text{Product Property}} & \mathbf{x(t) \delta(t - t_0) = x(t_0) \delta(t - t_0)} & x[n] \delta[n - n_0] = x[n_0] \delta[n - n_0] \\
     \mathbf{\text{Scaling Property}} & \mathbf{\delta(at - b) = \frac{1}{|a|} \delta(t - b/a)} & \text{N/A (Discrete deltas do not scale linearly)} \\
     \mathbf{\text{Step Derivative}} & \mathbf{\delta(t) = \frac{du(t)}{dt}} & \delta[n] = u[n] - u[n-1] \\
     \hline
     \end{array}$$
   - **The Scaling Factor Invariant:** For any non-zero scaling constant $a$, $\mathbf{\delta(at) = \frac{1}{|a|} \delta(t)}$ (total area under the delta distribution is strictly preserved as $1.0$).
2. **Slide 2 (`ordering`):** Provide 5 steps to evaluate integrals with scaled deltas: (1) inspect the delta argument $\delta(at - b)$, (2) factor out the coefficient of $t$: $\delta(at - b) = \frac{1}{|a|}\delta(t - b/a)$, (3) pull the scalar constant $\frac{1}{|a|}$ outside the integral, (4) identify the sampling impulse location $t_0 = b/a$ and check if $t_0$ lies within integration limits $[\alpha, \beta]$, (5) evaluate the operand signal at $t_0$ to obtain final answer $\frac{1}{|a|} x(b/a)$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Sifting Property, Scaling Property $\delta(at)=\frac{1}{|a|}\delta(t)$, Step-Impulse Relation $\delta(t)=du/dt$, Even Symmetry $\delta(-t)=\delta(t)$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Sifting (or Sampling). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on evaluating integral with delta: Evaluate the definite integral: $I = \int_{-\infty}^\infty (t^3 + 4t + 2) \cdot \delta(3t - 6) \, dt$. What is the exact numerical value of $I$? ($\delta(3t - 6) = \delta(3(t - 2)) = \frac{1}{|3|} \delta(t - 2) = \frac{1}{3}\delta(t - 2)$; $I = \frac{1}{3} \int_{-\infty}^\infty (t^3 + 4t + 2) \delta(t - 2) dt$; By the sifting property, sample at $t = 2$: $x(2) = (2)^3 + 4(2) + 2 = 8 + 8 + 2 = 18$; $I = \frac{1}{3} \times 18 = \mathbf{6.0}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "singularity_functions_dirac_delta_sifting_and_unit_step",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Singularity Functions \\& Dirac Delta Properties (Paul Dirac 1927)**\n• **Step \\& Impulse Derivative Duals:**\n$$\n\\mathbf{\\delta(t) = \\frac{du(t)}{dt} \\quad \\Longleftrightarrow \\quad u(t) = \\int_{-\\infty}^t \\delta(\\tau) \\, d\\tau \\quad \\Big| \\quad \\delta[n] = u[n] - u[n-1]}\n$$\n• **The 3 Master Dirac Delta Operations:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Operation} & \\textbf{Mathematical Formulation} & \\textbf{Physical Action} \\\\\n\\hline\n\\mathbf{\\text{Sifting / Sampling}} & \\mathbf{\\int_{-\\infty}^\\infty x(t) \\delta(t - t_0) \\, dt = x(t_0)} & \\text{Extracts the exact instantaneous value at } t_0 \\\\\n\\mathbf{\\text{Product Property}} & \\mathbf{x(t) \\cdot \\delta(t - t_0) = x(t_0) \\cdot \\delta(t - t_0)} & \\text{Scales the impulse area by constant } x(t_0) \\\\\n\\mathbf{\\text{Scaling Property}} & \\mathbf{\\delta(at - b) = \\frac{1}{|a|} \\delta\\left(t - \\frac{b}{a}\\right)} & \\mathbf{\\text{Time scaling compresses/dilates impulse area by } 1/|a|} \\\\\n\\hline\n\\end{array}\n$$\n• **Even Symmetry Invariant:** $\\mathbf{\\delta(-t) = \\delta(t)}$ (the Dirac delta is a strictly even generalized distribution)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to evaluate an integral containing a scaled and time-shifted Dirac delta function \u222b x(t) * \u03b4(at - b) dt.",
      "orderItems": [
        "Inspect the argument of the Dirac delta distribution: delta(a*t - b)",
        "Apply the time-scaling theorem to factor out the coefficient of t: delta(a*t - b) = (1 / |a|) * delta(t - b/a)",
        "Factor the scalar constant (1 / |a|) outside the definite integral",
        "Identify the sampling impulse location t0 = b/a and confirm that it lies within the integration bounds",
        "Apply the Sifting Property to evaluate the operand function at t0, yielding final value (1 / |a|) * x(b/a)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Singularity Operation to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Sifting Property", "right": "\u222b x(t)*\u03b4(t-t0) dt = x(t0), filtering an integrand down to its point value at the impulse location" },
        { "left": "Time Scaling Property", "right": "\u03b4(at) = (1/|a|)*\u03b4(t), preserving total unit area under compression or reflection transformations" },
        { "left": "Step Derivative", "right": "\u03b4(t) = du(t)/dt, representing the infinite-amplitude instantaneous rate of change of a step" },
        { "left": "Product Property", "right": "x(t)*\u03b4(t-t0) = x(t0)*\u03b4(t-t0), multiplying a continuous signal by an impulse to produce a scaled impulse" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The mathematical property where an integral product of x(t) and \u03b4(t - t0) extracts the exact value x(t0) is the ___ property.",
      "blankAnswer": "sifting",
      "blankDistractors": ["scaling", "differentiating", "folding"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Evaluate the definite integral: I = \u222b[-\u221e, \u221e] (t^3 + 4t + 2) * \u03b4(3t - 6) dt. What is the exact numerical result?",
      "options": [
        { "text": "I = 6.0 (\u03b4(3t - 6) = (1/3)*\u03b4(t - 2); evaluating (2^3 + 4*2 + 2) = (8 + 8 + 2) = 18; then 18 / 3 = 6.0)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Dirac delta scaling and sifting properties (Alan Oppenheim & Alan Willsky *Signals and Systems* Chapter 1). 1. **Apply the Time Scaling Property to $\\delta(3t - 6)$:** $$\\delta(3t - 6) = \\delta(3(t - 2)) = \\frac{1}{|3|} \\delta(t - 2) = \\frac{1}{3} \\delta(t - 2)$$ 2. **Substitute into Integral:** $$I = \\int_{-\\infty}^\\infty (t^3 + 4t + 2) \\left[ \\frac{1}{3} \\delta(t - 2) \\right] dt = \\frac{1}{3} \\int_{-\\infty}^\\infty (t^3 + 4t + 2) \\delta(t - 2) \\, dt$$ 3. **Apply the Sifting Property at $t_0 = 2$:** - Evaluate the polynomial $x(t) = t^3 + 4t + 2$ at $t = 2$: $$x(2) = (2)^3 + 4(2) + 2 = 8 + 8 + 2 = \\mathbf{18}$$ 4. **Calculate Final Value:** $$I = \\frac{1}{3} \\times 18 = \\mathbf{6.0}$$ 5. **Common Mistake Alert:** Forgetting the $\\frac{1}{|a|} = \\frac{1}{3}$ scaling factor would incorrectly yield $18.0$!" },
        { "text": "I = 18.0 (Forgetting the 1/3 scaling factor)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "I = 54.0 (Multiplying by 3 instead of dividing)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "I = 2.0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
