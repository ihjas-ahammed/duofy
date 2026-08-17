# Duofy Reusable Lesson Format: The Likelihood Ratio Test and Most Powerful Tests

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Statistical_Inference / Hypothesis_Testing / Neyman_Pearson_Lemma`  
**Lesson Format Type:** `likelihood_ratio_and_most_powerful_tests`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the **Neyman-Pearson Fundamental Lemma (1933)** for simple hypotheses ($H_0: \theta = \theta_0$ vs $H_1: \theta = \theta_1$), construct the **Likelihood Ratio Test (LRT)** statistic $\Lambda(x) = \frac{f(x \mid \theta_1)}{f(x \mid \theta_0)}$, prove that LRT is **Most Powerful (MP)** of size $\alpha$, and calculate exact rejection thresholds $k$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Neyman-Pearson Lemma Formal Theorem Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Power Maximization Integral Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Type I vs Type II Error Tradeoff Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Normal Mean Testing Threshold Calculation Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Hypothesis Testing Power Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Neyman-Pearson Lemma (1933): Consider testing simple $H_0: \theta = \theta_0$ vs simple $H_1: \theta = \theta_1$. Let $\phi(\mathbf{x}) = \mathbf{1}(\Lambda(\mathbf{x}) > k) + \gamma \mathbf{1}(\Lambda(\mathbf{x}) = k)$ where $\Lambda(\mathbf{x}) = \frac{f(\mathbf{x} \mid \theta_1)}{f(\mathbf{x} \mid \theta_0)}$ and constants $k \ge 0, \gamma \in [0, 1]$ satisfy $\mathbb{E}_{\theta_0}[\phi(\mathbf{X})] = \alpha$. State Theorem: (1) Existence & Sufficiency: The test $\phi$ is the Most Powerful (MP) test of size $\alpha$ (i.e. $\mathbb{E}_{\theta_1}[\phi(\mathbf{X})] \ge \mathbb{E}_{\theta_1}[\phi^*(\mathbf{X})]$ for any other test $\phi^*$ with size $\mathbb{E}_{\theta_0}[\phi^*(\mathbf{X})] \le \alpha$), (2) Uniqueness: Any MP test of size $\alpha$ is essentially equal to $\phi$.
2. **Slide 2 (`ordering`):** Provide 5 steps proving the Neyman-Pearson Lemma: (1) let $\phi^*$ be any competing test with size $\mathbb{E}_{\theta_0}[\phi^*] \le \alpha$, (2) consider the pointwise product $(\phi(\mathbf{x}) - \phi^*(\mathbf{x}))(f(\mathbf{x} \mid \theta_1) - k f(\mathbf{x} \mid \theta_0))$, (3) observe that whenever $\Lambda(\mathbf{x}) > k$, $\phi(\mathbf{x}) = 1 \ge \phi^*(\mathbf{x})$ and $f_1 > k f_0$, so the product is $\ge 0$; whenever $\Lambda(\mathbf{x}) < k$, $\phi(\mathbf{x}) = 0 \le \phi^*(\mathbf{x})$ and $f_1 < k f_0$, so the product is also $\ge 0$, (4) integrate the non-negative product over all $\mathbf{x}$: $\int (\phi - \phi^*)(f_1 - k f_0) d\mathbf{x} \ge 0$, (5) expand the integral: $(\text{Power}(\phi) - \text{Power}(\phi^*)) - k (\text{Size}(\phi) - \text{Size}(\phi^*)) \ge 0 \implies \text{Power}(\phi) - \text{Power}(\phi^*) \ge k (\alpha - \text{Size}(\phi^*)) \ge 0$.
3. **Slide 3 (`quiz`):** Test the definitions of error rates: What is the exact mathematical definition of statistical Power $\beta(\theta_1)$? (Power $= 1 - \beta = P(\text{Reject } H_0 \mid H_1 \text{ is true})$, the probability of correctly detecting a real effect).
4. **Slide 4 (`proof`):** Interactive derivation testing $H_0: \mu = 0$ vs $H_1: \mu = 1$ for $X_1, \dots, X_n \sim \mathcal{N}(\mu, 1)$, showing that $\Lambda(\mathbf{x}) = \exp(n \bar{x} - n/2) > k \iff \bar{x} > c = z_\alpha / \sqrt{n}$.
5. **Slide 5 (`one_word`):** Plain-text recall of the term for the probability of correctly rejecting the null hypothesis when the alternative is true ($1 - \beta$) (power).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "likelihood_ratio_and_most_powerful_tests",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Neyman-Pearson Fundamental Lemma (1933)**\n• Consider testing simple hypotheses $H_0: \\theta = \\theta_0$ versus $H_1: \\theta = \\theta_1$.\n• **The Likelihood Ratio Test Statistic:**\n$$\n\\Lambda(\\mathbf{x}) = \\frac{L(\\theta_1 \\mid \\mathbf{x})}{L(\\theta_0 \\mid \\mathbf{x})} = \\frac{f(\\mathbf{x} \\mid \\theta_1)}{f(\\mathbf{x} \\mid \\theta_0)}\n$$\n• **The Most Powerful (MP) Decision Rule $\\phi(\\mathbf{x})$:**\n$$\n\\phi(\\mathbf{x}) = \\begin{cases} 1 & \\text{if } \\Lambda(\\mathbf{x}) > k \\quad (\\text{Reject } H_0) \\\\ \\gamma & \\text{if } \\Lambda(\\mathbf{x}) = k \\quad (\\text{Reject with prob } \\gamma) \\\\ 0 & \\text{if } \\Lambda(\\mathbf{x}) < k \\quad (\\text{Accept } H_0) \\end{cases}\n$$\nwhere $k \\ge 0, \\gamma \\in [0, 1]$ are chosen so that the test has exact **Type I error rate** $\\mathbb{E}_{\\theta_0}[\\phi(\\mathbf{X})] = \\alpha$.\n• **Optimality Theorem:** The test $\\phi$ maximizes **Power** $\\mathbb{E}_{\\theta_1}[\\phi(\\mathbf{X})] = 1 - \\beta$ over *all* possible tests of size $\\le \\alpha$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps establishing that the Likelihood Ratio test maximizes statistical power.",
      "orderItems": [
        "Let phi* be any arbitrary competing test of size E_{theta_0}[phi*] <= alpha",
        "Form the pointwise algebraic product (phi(x) - phi*(x)) * (f(x | theta_1) - k * f(x | theta_0))",
        "Verify that this product is non-negative (>= 0) for EVERY point x across the entire sample space",
        "Integrate the non-negative product over sample space: int (phi - phi*) (f_1 - k f_0) dx >= 0",
        "Distribute integrals to show (Power(phi) - Power(phi*)) >= k (alpha - Size(phi*)) >= 0, proving Power(phi) >= Power(phi*)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In the Neyman-Pearson framework of hypothesis testing, what is the exact definition of the statistical POWER (1 - beta) of a test?",
      "options": [
        { "text": "The probability of CORRECTLY REJECTING the null hypothesis when the alternative hypothesis is true: P(Reject H_0 | H_1 is true)", "isCorrect": true, "explanation": "Correct! Power = 1 - P(Type II error) = P(Reject H_0 | H_1), measuring the test's ability to discover real effects." },
        { "text": "The probability of falsely rejecting H_0 when H_0 is true (Type I error alpha)", "isCorrect": false, "explanation": "Incorrect: That is the significance level alpha." },
        { "text": "The probability of accepting H_0 when H_1 is true (Type II error beta)", "isCorrect": false, "explanation": "Incorrect: That is beta." },
        { "text": "The sample size n", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Most Powerful Test for Normal Mean H_0: mu = 0 vs H_1: mu = 1",
      "interactiveSteps": [
        {
          "stepText": "Let X_1, ..., X_n ~ N(mu, 1). The likelihood ratio is Lambda(x) = exp( -1/2 sum (x_i - 1)^2 + 1/2 sum x_i^2 ) = exp( n x_bar - n/2 )."
        },
        {
          "prompt": "The condition Lambda(x) > k is algebraically equivalent to which test statistic threshold?",
          "options": [
            { "text": "x_bar > c (where sample mean exceeds critical threshold c = z_alpha / sqrt(n))", "isCorrect": true },
            { "text": "x_bar < 0", "isCorrect": false },
            { "text": "sum x_i^2 > k", "isCorrect": false },
            { "text": "x_bar = 1 always", "isCorrect": false }
          ]
        },
        {
          "stepText": "Since x_bar ~ N(0, 1/n) under H_0, setting c = z_alpha / sqrt(n) gives P(x_bar > c | mu = 0) = alpha, providing the exact Most Powerful test."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What statistical term represents the probability of correctly rejecting the null hypothesis when the alternative is true (1 - beta)?",
      "blankAnswer": "power"
    }
  ]
}
```
