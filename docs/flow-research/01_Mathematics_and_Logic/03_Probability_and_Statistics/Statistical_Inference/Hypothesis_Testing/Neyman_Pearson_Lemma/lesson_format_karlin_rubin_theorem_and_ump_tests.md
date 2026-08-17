# Duofy Reusable Lesson Format: The Karlin-Rubin Theorem and Uniformly Most Powerful Tests

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Statistical_Inference / Hypothesis_Testing / Neyman_Pearson_Lemma`  
**Lesson Format Type:** `karlin_rubin_theorem_and_ump_tests`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the **Karlin-Rubin Theorem (1956)** extending optimal hypothesis testing from simple alternatives to **One-Sided Composite Hypotheses** ($H_0: \theta \le \theta_0$ vs $H_1: \theta > \theta_0$), evaluate the **Monotone Likelihood Ratio (MLR)** property, and construct **Uniformly Most Powerful (UMP)** tests.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Karlin-Rubin Theorem & UMP Statement Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Monotone Likelihood Ratio Verification Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Composite Hypothesis Setup & UMP Test Existence Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Two-Sided Non-Existence UMP Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Non-Existence of Two-Sided UMP Tests Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Karlin-Rubin Theorem (1956): Let $X$ have distribution family $\{f(x \mid \theta) \mid \theta \in \Theta \subseteq \mathbb{R}\}$ with Monotone Likelihood Ratio (MLR) in sufficient statistic $T(X)$. Consider testing one-sided composite hypotheses $H_0: \theta \le \theta_0$ versus $H_1: \theta > \theta_0$. The test defined by $\phi(\mathbf{x}) = \mathbf{1}(T(\mathbf{x}) > c) + \gamma \mathbf{1}(T(\mathbf{x}) = c)$ (with $\mathbb{E}_{\theta_0}[\phi(\mathbf{X})] = \alpha$) is the **Uniformly Most Powerful (UMP)** test of size $\alpha$. That is, for EVERY $\theta_1 > \theta_0$, $\phi$ maximizes statistical power $\mathbb{E}_{\theta_1}[\phi(\mathbf{X})]$ simultaneously over all tests of size $\alpha$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the proof intuition: (1) pick any specific alternative value $\theta_1 > \theta_0$, (2) by the Neyman-Pearson Lemma, the most powerful test of $H_0': \theta = \theta_0$ vs $H_1': \theta = \theta_1$ rejects when $f(x \mid \theta_1) / f(x \mid \theta_0) > k$, (3) by the MLR property, this likelihood ratio is a strictly increasing function $g(T(x))$, so $g(T(x)) > k \iff T(x) > c$, (4) CRUCIAL INSIGHT: the threshold $c$ depends ONLY on $\theta_0$ and $\alpha$, completely independent of the choice of $\theta_1$, (5) since the same test is optimal for every $\theta_1 > \theta_0$, it is Uniformly Most Powerful!
3. **Slide 3 (`matching`):** Pair 4 hypothesis structures ($H_0: \theta \le \theta_0$ vs $\theta > \theta_0$ with MLR, $H_0: \theta \ge \theta_0$ vs $\theta < \theta_0$ with MLR, Two-sided $H_0: \theta = \theta_0$ vs $\theta \ne \theta_0$, Simple $H_0: \theta = \theta_0$ vs $H_1: \theta = \theta_1$) with their optimal test classifications (UMP, UMP Unbiased / UMPU, Neyman-Pearson MP).
4. **Fill in Blank (Slide 4):** Single sentence blank testing recall that for two-sided composite hypotheses $H_0: \theta = \theta_0$ vs $H_1: \theta \ne \theta_0$, a standard UMP test generally does not exist. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question explaining why two-sided tests $H_0: \theta = \theta_0$ vs $H_1: \theta \ne \theta_0$ lack a UMP test: (Because the MP test for $\theta_1 > \theta_0$ rejects in the right tail $T > c_R$, while the MP test for $\theta_1 < \theta_0$ rejects in the left tail $T < c_L$; no single test can be simultaneously optimal in both directions without imposing unbiasedness $\mathbb{E}_\theta[\phi] \ge \alpha$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "karlin_rubin_theorem_and_ump_tests",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Karlin-Rubin Theorem for UMP Tests (1956)**\n• Let $\\{f(\\mathbf{x} \\mid \\theta) \\mid \\theta \\in \\mathbb{R}\\}$ possess a **Monotone Likelihood Ratio (MLR)** in statistic $T(\\mathbf{X})$.\n• Consider testing the **one-sided composite hypothesis**:\n$$\nH_0: \\theta \\le \\theta_0 \\quad \\text{versus} \\quad H_1: \\theta > \\theta_0\n$$\n• **The UMP Decision Rule:** The test $\\phi(\\mathbf{x})$:\n$$\n\\phi(\\mathbf{x}) = \\begin{cases} 1 & \\text{if } T(\\mathbf{x}) > c \\\\ \\gamma & \\text{if } T(\\mathbf{x}) = c \\\\ 0 & \\text{if } T(\\mathbf{x}) < c \\end{cases}\n$$\nwhere $c, \\gamma$ satisfy $\\mathbb{E}_{\\theta_0}[\\phi(\\mathbf{X})] = \\alpha$, is the **Uniformly Most Powerful (UMP)** test of size $\\alpha$.\n• **Significance:** $\\phi(\\mathbf{x})$ simultaneously maximizes power $\\beta(\\theta) = \\mathbb{E}_\\theta[\\phi(\\mathbf{X})]$ for **EVERY** parameter value $\\theta > \\theta_0$ in the composite alternative!"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Fix Arbitrary Alternative):** Choose any specific value $\\theta_1 > \\theta_0$.\n• **Step 2 (Apply Neyman-Pearson):** The MP test for simple $\\theta_0$ vs $\\theta_1$ rejects when $\\frac{f(\\mathbf{x} \\mid \\theta_1)}{f(\\mathbf{x} \\mid \\theta_0)} > k$.\n• **Step 3 (MLR Inversion):** Because the likelihood ratio is a strictly increasing function $g(T(\\mathbf{x}))$, the inequality $g(T(\\mathbf{x})) > k$ is equivalent to $T(\\mathbf{x}) > c$.\n• **Step 4 (Independence of Alternative):** The critical cutoff $c$ is determined solely by $\\mathbb{E}_{\\theta_0}[\\phi] = \\alpha$, which does *not* depend on the numerical value of $\\theta_1$!\n• **Step 5 (Uniformity):** Since the exact same test is optimal for all $\\theta_1 > \\theta_0$, it is Uniformly Most Powerful."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each hypothesis testing scenario to its optimal test structure.",
      "matchPairs": [
        { "left": "One-sided H_0: theta <= theta_0 vs H_1: theta > theta_0 (with MLR)", "right": "Right-tailed UMP test rejecting when T(X) > c" },
        { "left": "One-sided H_0: theta >= theta_0 vs H_1: theta < theta_0 (with MLR)", "right": "Left-tailed UMP test rejecting when T(X) < c" },
        { "left": "Two-sided H_0: theta = theta_0 vs H_1: theta != theta_0", "right": "UMP test does NOT exist; requires UMP Unbiased (UMPU) test" },
        { "left": "Simple H_0: theta = theta_0 vs H_1: theta = theta_1", "right": "Neyman-Pearson Most Powerful (MP) likelihood ratio test" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "For two-sided composite hypotheses H_0: theta = theta_0 versus H_1: theta != theta_0, a Uniformly Most Powerful (UMP) test generally does not ___.",
      "blankAnswer": "exist",
      "blankDistractors": ["converge", "diverge", "simplify"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does a standard UMP test FAIL TO EXIST for two-sided composite hypothesis testing H_0: theta = theta_0 versus H_1: theta != theta_0?",
      "options": [
        { "text": "The optimal test for theta_1 > theta_0 rejects in the right tail (T > c_R) while the optimal test for theta_1 < theta_0 rejects in the left tail (T < c_L); no single one-sided test can be simultaneously optimal in both directions", "isCorrect": true, "explanation": "Correct! Rejection in the right tail gives great power for theta > theta_0 but near-zero power for theta < theta_0. Only by restricting attention to unbiased tests (UMPU) can two-sided optimality be established." },
        { "text": "Because sample sizes must be infinite", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because likelihood ratios cannot be computed for two-sided tests", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the null hypothesis is false", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
