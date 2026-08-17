# Duofy Reusable Lesson Format: Superposition and Thinning of Poisson Processes

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory / Stochastic_Processes_and_Markov_Chains / Poisson_Processes`  
**Lesson Format Type:** `superposition_and_thinning_of_poisson_processes`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the core closure operations on Poisson streams: **Superposition** (merging independent processes $N_1 \sim \operatorname{PP}(\lambda_1)$ and $N_2 \sim \operatorname{PP}(\lambda_2)$ to yield $\operatorname{PP}(\lambda_1 + \lambda_2)$), **Thinning / Splitting** (classifying arrivals with probability $p$ to yield independent processes $\operatorname{PP}(p\lambda)$ and $\operatorname{PP}((1-p)\lambda)$), and evaluate competing exponential race probabilities ($P(T_1 < T_2) = \frac{\lambda_1}{\lambda_1 + \lambda_2}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Superposition & Thinning Theorems Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Thinning Independence Proof Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Poisson Process Operation & Resulting Parameter Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Merged Process First Arrival Exponential Race Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 5** | Numerical Superposition Arrival Count Probability Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Superposition Theorem: If $N_1(t), \dots, N_k(t)$ are independent Poisson processes with rates $\lambda_1, \dots, \lambda_k$, then the superposition $N(t) = \sum_{i=1}^k N_i(t)$ is a Poisson process with rate $\lambda = \sum_{i=1}^k \lambda_i$. State the Thinning / Decomposition Theorem: If each arrival in a Poisson process $N(t) \sim \operatorname{PP}(\lambda)$ is independently classified as Type 1 with probability $p$ and Type 2 with probability $1-p$, then the resulting counting processes $N_1(t)$ and $N_2(t)$ are **independent Poisson processes** with respective rates $\lambda_1 = p\lambda$ and $\lambda_2 = (1-p)\lambda$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the bivariate joint probability proof: (1) evaluate $P(N_1(t) = j, N_2(t) = k)$, (2) condition on total arrivals $N(t) = j + k$: $P(N_1 = j, N_2 = k \mid N = j+k) P(N = j+k)$, (3) conditional distribution is $\operatorname{Binomial}(j+k, p)$: $\binom{j+k}{j} p^j (1-p)^k$, (4) multiply by Poisson PMF: $\frac{(j+k)!}{j! k!} p^j (1-p)^k \frac{(\lambda t)^{j+k} e^{-\lambda t}}{(j+k)!}$, (5) factor terms: $\frac{(p\lambda t)^j e^{-p\lambda t}}{j!} \cdot \frac{((1-p)\lambda t)^k e^{-(1-p)\lambda t}}{k!} = P(N_1 = j) \cdot P(N_2 = k)$, proving independence and marginal Poisson distributions!
3. **Slide 3 (`matching`):** Pair 4 operations (Superposition of 2 processes, Thinning with probability $p$, Minimum of 2 Exponential clocks, Probability that clock 1 rings first) with their mathematical formulas.
4. **Slide 4 (`quiz`):** Quiz on the Exponential Race: For two independent exponential clocks $T_1 \sim \operatorname{Exp}(\lambda_1)$ and $T_2 \sim \operatorname{Exp}(\lambda_2)$, what is the probability $P(T_1 < T_2)$ that event 1 occurs before event 2? ($P(T_1 < T_2) = \frac{\lambda_1}{\lambda_1 + \lambda_2}$).
5. **Slide 5 (`numerical`):** Ask student: Two independent Poisson streams of customers arrive at a service desk: Type A with rate $\lambda_A = 3.0 \text{ /hr}$ and Type B with rate $\lambda_B = 2.0 \text{ /hr}$. In a 2-hour window ($t = 2.0$), what is the expected total number of customers $\mathbb{E}[N(2)] = (\lambda_A + \lambda_B) \times t = (3+2) \times 2 = 10.0$? (numeric answer: 10.0).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "superposition_and_thinning_of_poisson_processes",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Superposition and Thinning of Poisson Processes**\n• **Superposition (Merging):** Let $N_1(t) \\sim \\operatorname{PP}(\\lambda_1)$ and $N_2(t) \\sim \\operatorname{PP}(\\lambda_2)$ be independent.\n  The merged process $N(t) = N_1(t) + N_2(t)$ is a **Poisson Process with rate $\\lambda_1 + \\lambda_2$**.\n• **Thinning (Splitting / Decomposition):** Let $N(t) \\sim \\operatorname{PP}(\\lambda)$. If each arrival is independently classified as:\n  - **Type 1** with probability $p$\n  - **Type 2** with probability $1 - p$\n• **Independence Theorem:** The split counting streams $N_1(t)$ and $N_2(t)$ are **completely independent Poisson processes** with rates:\n$$\nN_1(t) \\sim \\operatorname{PP}(p\\lambda), \\qquad N_2(t) \\sim \\operatorname{PP}((1-p)\\lambda)\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Joint Probability Setup):** Evaluate $P(N_1(t) = j, N_2(t) = k)$.\n• **Step 2 (Condition on Total):** Condition on $N(t) = j + k$ arrivals:\n  $$P(N_1 = j, N_2 = k) = P(N_1 = j \\mid N = j+k) \\cdot P(N = j+k)$$\n• **Step 3 (Binomial Splitting):** Given $j+k$ total arrivals, each independently chooses Type 1 with probability $p$ (Binomial distribution):\n  $$= \\binom{j+k}{j} p^j (1-p)^k \\cdot \\frac{(\\lambda t)^{j+k} e^{-\\lambda t}}{(j+k)!}$$\n• **Step 4 (Algebraic Factorization):** Cancel $(j+k)!$ and group exponents:\n  $$= \\left[ \\frac{(p\\lambda t)^j e^{-p\\lambda t}}{j!} \\right] \\cdot \\left[ \\frac{((1-p)\\lambda t)^k e^{-(1-p)\\lambda t}}{k!} \\right]$$\n• **Step 5 (Conclusion):** The joint probability equals the product of two independent Poisson PMFs!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Poisson process operation to its resulting property.",
      "matchPairs": [
        { "left": "Superposition of N_1(lambda_1) and N_2(lambda_2)", "right": "Poisson process with combined rate lambda = lambda_1 + lambda_2" },
        { "left": "Thinning with Probability p", "right": "Two independent Poisson processes with rates p*lambda and (1-p)*lambda" },
        { "left": "Minimum of 2 Exponential Clocks min(T_1, T_2)", "right": "Exp(lambda_1 + lambda_2) with mean 1 / (lambda_1 + lambda_2)" },
        { "left": "Probability Clock 1 Rings First P(T_1 < T_2)", "right": "lambda_1 / (lambda_1 + lambda_2)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "quiz",
      "content": "Two competing independent radioactive sources emit particles: Source 1 with rate lambda_1 = 4 /sec and Source 2 with rate lambda_2 = 6 /sec. What is the exact probability that the next detected particle came from Source 1?",
      "options": [
        { "text": "P(T_1 < T_2) = lambda_1 / (lambda_1 + lambda_2) = 4 / (4 + 6) = 4/10 = 0.40 (40%)", "isCorrect": true, "explanation": "Correct! By integrating the joint density P(T_1 < T_2) = int_0^infty lambda_1 e^{-lambda_1 t} e^{-lambda_2 t} dt = lambda_1 / (lambda_1 + lambda_2) = 0.40." },
        { "text": "50% always", "isCorrect": false, "explanation": "Incorrect: Depends on the rates lambda_1 and lambda_2." },
        { "text": "60%", "isCorrect": false, "explanation": "Incorrect: That is the probability Source 2 fires first." },
        { "text": "100%", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 5,
      "type": "numerical",
      "content": "A call center receives English calls at rate lambda_E = 3.0 calls/min and Spanish calls at rate lambda_S = 2.0 calls/min. For a t = 2.0 minute window, calculate the expected total number of calls received.",
      "numericAnswer": 10.0,
      "numericTolerance": 0.01
    }
  ]
}
```
