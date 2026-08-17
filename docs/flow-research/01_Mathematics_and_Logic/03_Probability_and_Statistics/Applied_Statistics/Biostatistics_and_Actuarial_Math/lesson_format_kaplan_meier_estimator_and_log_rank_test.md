# Duofy Reusable Lesson Format: The Kaplan-Meier Estimator and Log-Rank Test

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Applied_Statistics / Biostatistics_and_Actuarial_Math`  
**Lesson Format Type:** `kaplan_meier_estimator_and_log_rank_test`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through non-parametric survival analysis: compute the **Kaplan-Meier Product-Limit Estimator** $\hat{S}(t) = \prod_{t_i \le t} (1 - \frac{d_i}{n_i})$, calculate variance via **Greenwood's Formula**, construct confidence intervals, execute the **Log-Rank Test (Mantel-Haenszel)** ($Q = \frac{(\sum O_j - E_j)^2}{\sum V_j} \sim \chi^2_1$) to compare treatment arms, and interpret survival curve steps.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Kaplan-Meier & Log-Rank Formal Theorem Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Kaplan-Meier Table Calculation Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Survival Metric & Statistical Estimator Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical 2-Step Kaplan-Meier Survival Probability Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Log-Rank Test Under Null Asymptotic Distribution Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Kaplan-Meier Product-Limit Estimator (Edward Kaplan & Paul Meier, 1958): For distinct ordered event times $t_1 < t_2 < \dots < t_k$, let $d_i$ be the number of events (deaths) at $t_i$ and $n_i$ be the number of individuals at risk just prior to $t_i$:
   $$\hat{S}(t) = \prod_{t_i \le t} \left( 1 - \frac{d_i}{n_i} \right)$$
   State Greenwood's Formula: $\widehat{\operatorname{Var}}(\hat{S}(t)) = \hat{S}(t)^2 \sum_{t_i \le t} \frac{d_i}{n_i(n_i - d_i)}$. State the Log-Rank Test (Nathan Mantel, 1966): For 2 groups with observed events $O_{1i}$ and expected $E_{1i} = n_{1i} \frac{d_i}{n_i}$, the test statistic $Z = \frac{\sum (O_{1i} - E_{1i})}{\sqrt{\sum V_i}} \xrightarrow{d} \mathcal{N}(0, 1)$ or $Q = Z^2 \sim \chi^2_1$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the risk set calculation: (1) sort all event and censored times in ascending order, (2) at each event time $t_i$, count number at risk $n_i$ (all patients alive and not yet censored just before $t_i$), (3) compute conditional survival probability $p_i = 1 - d_i/n_i$, (4) update cumulative survival by multiplying with previous step: $\hat{S}(t_i) = \hat{S}(t_{i-1}) \times p_i$, (5) when censoring occurs between event times, decrease $n_i$ for subsequent steps without causing a downward drop in the survival curve!
3. **Slide 3 (`matching`):** Pair 4 survival statistics (Kaplan-Meier Estimator, Greenwood's Formula, Nelson-Aalen Estimator $\hat{H}(t) = \sum d_i/n_i$, Log-Rank Test) with their mathematical expressions.
4. **Slide 4 (`numerical`):** Ask student: In a clinical cohort of $n_1 = 10$ cancer patients, at $t_1 = 3 \text{ months}$ $d_1 = 2$ patients die. Then at $t = 4 \text{ months}$, $1$ patient is censored (leaving $n_2 = 7$). At $t_2 = 6 \text{ months}$, $d_2 = 1$ patient dies. Calculate the Kaplan-Meier survival estimate $\hat{S}(6) = (1 - 2/10) \times (1 - 1/7) = 0.80 \times (6/7) = 0.80 \times 0.8571 = 0.6857 \approx 0.69$ to two decimal places (numeric answer: 0.69).
5. **Slide 5 (`quiz`):** Quiz on the Log-Rank Test: What null hypothesis does the log-rank test test, and what is its asymptotic distribution for comparing $K$ survival groups? ($H_0: S_1(t) = S_2(t) = \dots = S_K(t)$ across all $t$, with asymptotic Chi-Square distribution $\chi^2_{K-1}$ with $K-1$ degrees of freedom).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "kaplan_meier_estimator_and_log_rank_test",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Kaplan-Meier Estimator and Log-Rank Test**\n• **The Kaplan-Meier Product-Limit Estimator (1958):** For distinct ordered event times $t_1 < t_2 < \\dots < t_k$:\n$$\n\\hat{S}(t) = \\prod_{t_i \\le t} \\left( 1 - \\frac{d_i}{n_i} \\right)\n$$\nwhere $d_i$ = number of events at $t_i$, and $n_i$ = number of subjects at risk just before $t_i$.\n• **Greenwood's Variance Formula:**\n$$\n\\widehat{\\operatorname{Var}}(\\hat{S}(t)) = \\hat{S}(t)^2 \\sum_{t_i \\le t} \\frac{d_i}{n_i(n_i - d_i)}\n$$\n• **The Log-Rank Test (Mantel 1966):** Non-parametric test comparing $K$ survival curves:\n$$\nQ = \\sum_{k=1}^K \\frac{(O_k - E_k)^2}{E_k} \\xrightarrow{d} \\chi^2_{K-1}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Order Times):** Sort all event times $t_1 < t_2 < \\dots$ and censoring times.\n• **Step 2 (Form Risk Set):** At each event time $t_i$, count $n_i$ (individuals still alive and under observation).\n• **Step 3 (Conditional Survival):** Compute interval survival probability $p_i = 1 - \\frac{d_i}{n_i}$.\n• **Step 4 (Multiply History):** Multiply by previous survival: $\\hat{S}(t_i) = \\hat{S}(t_{i-1}) \\times \\left(1 - \\frac{d_i}{n_i}\\right)$.\n• **Step 5 (Censoring Effect):** Censored individuals reduce the risk set $n_{i+1}$ for subsequent times, but do NOT produce a downward step in $\\hat{S}(t)$ at their censoring time!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each non-parametric survival analysis method to its mathematical role.",
      "matchPairs": [
        { "left": "Kaplan-Meier Estimator", "right": "prod_{t_i <= t} (1 - d_i / n_i) (step-function estimate of survival curve)" },
        { "left": "Greenwood's Formula", "right": "S_hat(t)^2 * sum d_i / [n_i(n_i - d_i)] (computes standard error of KM estimate)" },
        { "left": "Nelson-Aalen Estimator", "right": "H_hat(t) = sum_{t_i <= t} (d_i / n_i) (non-parametric cumulative hazard estimate)" },
        { "left": "Log-Rank Test", "right": "Compares observed vs expected events under H_0: S_1(t) = S_2(t)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "A study starts with n_1 = 10 patients. At t_1 = 3 months, d_1 = 2 die. At t = 4 months, 1 patient is censored (leaving n_2 = 7 at risk). At t_2 = 6 months, d_2 = 1 dies. Calculate the Kaplan-Meier survival estimate S_hat(6) = (1 - 2/10) * (1 - 1/7) to two decimal places.",
      "numericAnswer": 0.69,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "When conducting a Log-Rank test to compare survival distributions between K = 2 treatment groups (Drug vs Placebo), what is the asymptotic distribution of the test statistic under the null hypothesis?",
      "options": [
        { "text": "Chi-Square distribution with 1 degree of freedom: Q ~ chi^2_1 (equivalent to Standard Normal Z ~ N(0, 1) where Q = Z^2)", "isCorrect": true, "explanation": "Correct! For K groups, the log-rank statistic follows a Chi-Square distribution with K - 1 degrees of freedom. For K = 2 groups, df = 2 - 1 = 1." },
        { "text": "Student's t-distribution with n - 1 degrees of freedom", "isCorrect": false, "explanation": "Incorrect: t-tests cannot handle censored data." },
        { "text": "F-distribution", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Poisson distribution", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
