# Duofy Reusable Lesson Format: Cox Proportional Hazards Model and Partial Likelihood

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Applied_Statistics / Biostatistics_and_Actuarial_Math`  
**Lesson Format Type:** `cox_proportional_hazards_and_partial_likelihood`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to formulate the **Cox Proportional Hazards Model** (Sir David Cox, 1972) $h(t \mid \mathbf{x}) = h_0(t) \exp(\mathbf{\beta}^T \mathbf{x})$, maximize **Cox's Partial Likelihood** $L_p(\mathbf{\beta}) = \prod \frac{\exp(\beta^T x_i)}{\sum_{j \in \mathcal{R}(t_i)} \exp(\beta^T x_j)}$ without specifying the non-parametric baseline hazard $h_0(t)$, interpret **Hazard Ratios** $\text{HR} = \exp(\beta_j)$, and check the proportional hazards assumption via Schoenfeld residuals.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cox Proportional Hazards & Partial Likelihood Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Partial Likelihood Derivation Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Regression Parameter & Clinical Interpretation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Constant Ratio Proportional Hazards Assumption Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Hazard Ratio Interpretation in Clinical Trials Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Cox Proportional Hazards Model (1972): The hazard of individual $i$ with covariate vector $\mathbf{x}_i = (x_{i1}, \dots, x_{ip})^T$ is $h(t \mid \mathbf{x}_i) = h_0(t) \exp(\mathbf{\beta}^T \mathbf{x}_i) = h_0(t) \exp\left(\sum_{j=1}^p \beta_j x_{ij}\right)$, where $h_0(t)$ is an arbitrary unspecified **baseline hazard**. State the Hazard Ratio: $\text{HR} = \frac{h(t \mid \mathbf{x}_A)}{h(t \mid \mathbf{x}_B)} = \exp(\mathbf{\beta}^T(\mathbf{x}_A - \mathbf{x}_B))$ is strictly constant over time $t$. State Cox's Partial Likelihood: $L_p(\mathbf{\beta}) = \prod_{i: \delta_i = 1} \frac{\exp(\mathbf{\beta}^T \mathbf{x}_i)}{\sum_{j \in \mathcal{R}(t_i)} \exp(\mathbf{\beta}^T \mathbf{x}_j)}$, which depends only on $\mathbf{\beta}$ and eliminates $h_0(t)$ completely!
2. **Slide 2 (`concept_pieces`):** Deconstruct the conditional probability formulation: (1) at event time $t_i$, condition on the fact that an event occurred among individuals in the risk set $\mathcal{R}(t_i)$, (2) compute conditional probability that individual $i$ is the one who failed: $P(\text{individual } i \text{ fails} \mid \text{one failure in } \mathcal{R}(t_i)) = \frac{h(t_i \mid \mathbf{x}_i)}{\sum_{j \in \mathcal{R}(t_i)} h(t_i \mid \mathbf{x}_j)}$, (3) substitute proportional hazards formula: $\frac{h_0(t_i) \exp(\mathbf{\beta}^T \mathbf{x}_i)}{\sum_{j \in \mathcal{R}(t_i)} h_0(t_i) \exp(\mathbf{\beta}^T \mathbf{x}_j)}$, (4) cancel the unknown baseline hazard $h_0(t_i)$ from numerator and denominator, (5) multiply terms across all uncensored event times to form the complete partial likelihood $L_p(\mathbf{\beta})$!
3. **Slide 3 (`matching`):** Pair 4 Cox model components (Baseline Hazard $h_0(t)$, Regression Coefficient $\beta_j$, Hazard Ratio $\text{HR} = e^{\beta}$, Schoenfeld Residuals) with their statistical roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the foundational assumption of the Cox model is that the hazard ratio between any two individuals remains constant over time. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question on interpreting hazard ratios: In a clinical trial for a new oncology drug, the Cox regression coefficient for the treatment indicator ($x = 1$ for drug, $x = 0$ for placebo) is estimated as $\hat{\beta} = -0.693$, giving $\text{HR} = e^{-0.693} = 0.50$. What does this mean? (The drug reduces the instantaneous risk of death by 50% relative to placebo at any given point in time).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cox_proportional_hazards_and_partial_likelihood",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Cox Proportional Hazards Model and Partial Likelihood**\n• **The Cox Proportional Hazards Model (Sir David Cox, 1972):**\n$$\nh(t \\mid \\mathbf{x}_i) = h_0(t) \\exp(\\mathbf{\\beta}^T \\mathbf{x}_i) = h_0(t) \\exp\\left( \\sum_{j=1}^p \\beta_j x_{ij} \\right)\n$$\nwhere $h_0(t)$ is the **unspecified baseline hazard** function.\n• **Hazard Ratio (HR):** For two subjects with covariates $\\mathbf{x}_A$ and $\\mathbf{x}_B$:\n$$\n\\text{HR} = \\frac{h(t \\mid \\mathbf{x}_A)}{h(t \\mid \\mathbf{x}_B)} = \\exp\\left( \\mathbf{\\beta}^T (\\mathbf{x}_A - \\mathbf{x}_B) \\right) \\quad (\\text{Constant across all time } t!)\n$$\n• **Cox Partial Likelihood $L_p(\\mathbf{\\beta})$:**\n$$\nL_p(\\mathbf{\\beta}) = \\prod_{i: \\delta_i = 1} \\frac{\\exp(\\mathbf{\\beta}^T \\mathbf{x}_i)}{\\sum_{j \\in \\mathcal{R}(t_i)} \\exp(\\mathbf{\\beta}^T \\mathbf{x}_j)}\n$$\n(Completely eliminates the unknown baseline hazard $h_0(t)$!)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Condition on Event):** At failure time $t_i$, let $\\mathcal{R}(t_i)$ be the set of all individuals at risk.\n• **Step 2 (Conditional Probability):** Probability that subject $i$ failed given that one failure occurred in $\\mathcal{R}(t_i)$:\n  $$P(i \\text{ fails} \\mid \\text{one failure in } \\mathcal{R}(t_i)) = \\frac{h(t_i \\mid \\mathbf{x}_i)}{\\sum_{j \\in \\mathcal{R}(t_i)} h(t_i \\mid \\mathbf{x}_j)}$$\n• **Step 3 (Substitute Model):**\n  $$= \\frac{h_0(t_i) \\exp(\\mathbf{\\beta}^T \\mathbf{x}_i)}{\\sum_{j \\in \\mathcal{R}(t_i)} h_0(t_i) \\exp(\\mathbf{\\beta}^T \\mathbf{x}_j)}$$\n• **Step 4 (Cancel Baseline):** The baseline hazard $h_0(t_i)$ cancels out identically from numerator and denominator!\n• **Step 5 (Partial Likelihood):** Multiplying across all observed event times yields the semi-parametric partial likelihood $L_p(\\mathbf{\\beta})$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each component of the Cox Proportional Hazards framework to its statistical function.",
      "matchPairs": [
        { "left": "Baseline Hazard h_0(t)", "right": "Non-parametric hazard profile of a subject with all covariates equal to zero (x = 0)" },
        { "left": "Hazard Ratio HR = exp(beta_j)", "right": "Relative multiplicative change in instantaneous hazard per unit increase in covariate x_j" },
        { "left": "Schoenfeld Residuals", "right": "Diagnostic tool used to test whether hazard ratios remain constant over time" },
        { "left": "Semi-Parametric Property", "right": "Parametric linear predictor beta^T x combined with non-parametric baseline h_0(t)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The central mathematical assumption of the Cox model is that the hazard ratio between any two individuals remains ___ over time.",
      "blankAnswer": "constant",
      "blankDistractors": ["increasing", "decreasing", "infinite"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a cancer clinical trial, a Cox regression reports a coefficient beta = -0.693 for a new drug compared to standard of care. Given HR = exp(-0.693) = 0.50, how is this result interpreted clinically?",
      "options": [
        { "text": "Patients taking the new drug experience a 50% REDUCTION in the instantaneous hazard (risk) of death at any given point in time compared to standard of care (HR = 0.50)", "isCorrect": true, "explanation": "Correct! HR = 0.50 means the hazard in the treatment group is half that of the control group at any moment during follow-up, indicating a substantial survival benefit." },
        { "text": "All patients live exactly twice as long", "isCorrect": false, "explanation": "Incorrect: HR applies to instantaneous event risk, not deterministic lifespan." },
        { "text": "50% of patients are cured permanently", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The drug has no effect", "isCorrect": false, "explanation": "Incorrect: HR = 1.0 represents no effect." }
      ]
    }
  ]
}
```
