# Duofy Reusable Lesson Format: Survival Functions, Hazard Rates, and Censoring

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Applied_Statistics / Biostatistics_and_Actuarial_Math`  
**Lesson Format Type:** `survival_functions_hazard_rates_and_censoring`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the core objects of **Survival Analysis**: the **Survival Function** $S(t) = P(T > t)$, the **Instantaneous Hazard Rate** $h(t) = -S'(t)/S(t)$, the **Cumulative Hazard** $H(t) = \int_0^t h(s)ds \implies S(t) = e^{-H(t)}$, distinguish **Right, Left, and Interval Censoring**, and explain why ordinary OLS regression fails on time-to-event data.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Survival Trio & Hazard Rate Formal Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | S(t) = exp(-H(t)) Exponential Hazard Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Censoring Mechanism & Clinical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Constant Hazard Exponential Survival Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Time-To-Event Incomplete Data Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of a continuous non-negative time-to-event random variable $T \ge 0$: (1) Survival Function: $S(t) = P(T > t) = 1 - F(t)$. (2) Hazard Rate Function (Instantaneous Risk): $h(t) = \lim_{\Delta t \to 0} \frac{P(t \le T < t+\Delta t \mid T \ge t)}{\Delta t} = \frac{f(t)}{S(t)} = -\frac{d}{dt}\ln S(t)$. (3) Cumulative Hazard Function: $H(t) = \int_0^t h(s) ds$. State Theorem: $S(t) = \exp(-H(t)) = \exp\left(-\int_0^t h(s) ds\right)$ and $f(t) = h(t) \exp(-H(t))$. Define Right Censoring: Subject is observed until time $C$ without event, yielding $Y = \min(T, C)$ and event indicator $\delta = \mathbf{1}(T \le C)$.
2. **Slide 2 (`ordering`):** Provide 5 steps proving $S(t) = \exp(-\int_0^t h(s)ds)$: (1) write conditional hazard definition: $h(t) = \lim \frac{P(t \le T < t+\Delta t)}{S(t) \Delta t} = \frac{f(t)}{S(t)}$, (2) substitute density $f(t) = -S'(t)$ since $S(t) = 1 - F(t)$, (3) rewrite as logarithmic derivative: $h(t) = -\frac{S'(t)}{S(t)} = -\frac{d}{dt}\ln S(t)$, (4) integrate both sides from $0$ to $t$: $\int_0^t h(s) ds = -[\ln S(t) - \ln S(0)]$, (5) use initial condition $S(0) = P(T > 0) = 1 \implies \ln S(0) = 0$, giving $\ln S(t) = -\int_0^t h(s) ds \implies S(t) = \exp\left(-\int_0^t h(s) ds\right)$.
3. **Slide 3 (`matching`):** Pair 4 censoring mechanisms (Right Censoring, Left Censoring, Interval Censoring, Informative Censoring) with their clinical definitions.
4. **Slide 4 (`proof`):** Interactive derivation showing that for constant hazard $h(t) = \lambda$, $H(t) = \lambda t \implies S(t) = e^{-\lambda t} \implies T \sim \operatorname{Exp}(\lambda)$ (Exponential distribution is the unique constant-hazard model).
5. **Slide 5 (`one_word`):** Plain-text recall of the term for incomplete observation where a subject's exact event time is unknown due to study termination or loss to follow-up (censoring).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "survival_functions_hazard_rates_and_censoring",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Survival Function, Hazard Rate, and Censoring**\n• Let $T \\ge 0$ denote time until event occurrence (death, failure, relapse).\n• **1. Survival Function $S(t)$:** Probability of surviving past time $t$:\n$$\nS(t) = P(T > t) = 1 - F(t)\n$$\n• **2. Hazard Rate Function $h(t)$:** Instantaneous rate of failure at time $t$ given survival to $t$:\n$$\nh(t) = \\lim_{\\Delta t \\to 0} \\frac{P(t \\le T < t + \\Delta t \\mid T \\ge t)}{\\Delta t} = \\frac{f(t)}{S(t)} = -\\frac{d}{dt}\\ln S(t)\n$$\n• **3. Cumulative Hazard $H(t)$:**\n$$\nH(t) = \\int_0^t h(s) \\, ds \\implies S(t) = \\exp(-H(t)) = \\exp\\left(-\\int_0^t h(s) \\, ds\\right)\n$$\n• **Right Censoring:** Observed pair $(Y_i, \\delta_i)$ where $Y_i = \\min(T_i, C_i)$ and $\\delta_i = \\mathbf{1}(T_i \\le C_i)$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps establishing that S(t) = exp(-int_0^t h(s) ds).",
      "orderItems": [
        "Express hazard rate as ratio of PDF to survival function: h(t) = f(t) / S(t)",
        "Substitute the negative derivative of survival f(t) = -S'(t) to obtain h(t) = -S'(t) / S(t)",
        "Recognize the logarithmic derivative formula: h(t) = -d/dt [ln S(t)]",
        "Integrate both sides from 0 to t: int_0^t h(s) ds = -[ln S(t) - ln S(0)]",
        "Apply boundary condition S(0) = 1 (ln S(0) = 0) and exponentiate: S(t) = exp(-int_0^t h(s) ds)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each type of censoring in clinical trials to its definition.",
      "matchPairs": [
        { "left": "Right Censoring", "right": "Event occurs after study ends or patient is lost to follow-up (T > C)" },
        { "left": "Left Censoring", "right": "Event occurred before observation began (true event time T < C)" },
        { "left": "Interval Censoring", "right": "Event is known only to have occurred between two medical visits (t_A < T <= t_B)" },
        { "left": "Independent / Non-Informative Censoring", "right": "Censoring time C is statistically independent of survival time T" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Constant Hazard Model Leads to Exponential Distribution",
      "interactiveSteps": [
        {
          "stepText": "Suppose a medical device has constant failure hazard h(t) = lambda > 0 for all t >= 0."
        },
        {
          "prompt": "Evaluate the cumulative hazard H(t) and survival function S(t).",
          "options": [
            { "text": "H(t) = lambda * t and S(t) = exp(-lambda * t) (Exponential distribution Exp(lambda))", "isCorrect": true },
            { "text": "H(t) = lambda^2 * t", "isCorrect": false },
            { "text": "S(t) = 1 - lambda * t", "isCorrect": false },
            { "text": "S(t) = exp(-lambda * t^2 / 2)", "isCorrect": false }
          ]
        },
        {
          "stepText": "The constant hazard assumption is the defining signature of the Exponential distribution, exhibiting a completely memoryless failure risk."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What statistical term describes incomplete observation where a patient's exact event time is unknown due to study termination or loss to follow-up?",
      "blankAnswer": "censoring"
    }
  ]
}
```
