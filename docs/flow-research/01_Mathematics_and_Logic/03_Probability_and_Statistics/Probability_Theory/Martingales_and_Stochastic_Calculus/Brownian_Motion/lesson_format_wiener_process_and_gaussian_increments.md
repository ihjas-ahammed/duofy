# Duofy Reusable Lesson Format: The Wiener Process and Gaussian Increments

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory / Martingales_and_Stochastic_Calculus / Brownian_Motion`  
**Lesson Format Type:** `wiener_process_and_gaussian_increments`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce **Standard Brownian Motion (the Wiener Process)** $\{W(t), t \ge 0\}$, establish the 4 defining axioms ($W(0)=0$, independent increments, $W(t)-W(s) \sim \mathcal{N}(0, t-s)$, almost sure continuity), derive the covariance formula $\operatorname{Cov}(W(s), W(t)) = \min(s, t)$, and evaluate Donsker's Invariance Principle.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Wiener Process Axioms & Covariance Structure Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Brownian Covariance min(s, t) Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Brownian Scaling Invariance Symmetries Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Donsker Invariance Scaled Random Walk Limit Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Increment Probability Distribution Family Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the 4 axioms of Standard Brownian Motion $\{W(t), t \ge 0\}$: (1) $W(0) = 0$ a.s., (2) Independent Increments: $W(t_k) - W(t_{k-1})$ are independent for non-overlapping intervals, (3) Stationary Gaussian Increments: $W(t) - W(s) \sim \mathcal{N}(0, t-s)$ for $0 \le s \le t$, (4) Continuous sample paths $t \mapsto W(t)$ a.s. State the fundamental Covariance Formula: For any $s, t \ge 0$, $\operatorname{Cov}(W(s), W(t)) = \mathbb{E}[W(s) W(t)] = \min(s, t)$.
2. **Slide 2 (`ordering`):** Provide 5 steps deriving $\operatorname{Cov}(W(s), W(t)) = \min(s, t)$ for $s \le t$: (1) write $\mathbb{E}[W(s) W(t)]$ since means are zero $\mathbb{E}[W(t)] = 0$, (2) rewrite $W(t)$ by decomposing into independent increments: $W(t) = W(s) + [W(t) - W(s)]$, (3) expand the product: $\mathbb{E}[W(s)(W(s) + W(t) - W(s))] = \mathbb{E}[W(s)^2] + \mathbb{E}[W(s)(W(t) - W(s))]$, (4) by independent increments, $\mathbb{E}[W(s)(W(t) - W(s))] = \mathbb{E}[W(s)] \mathbb{E}[W(t) - W(s)] = 0 \cdot 0 = 0$, (5) substitute $\mathbb{E}[W(s)^2] = \operatorname{Var}(W(s)) = s$, concluding $\operatorname{Cov}(W(s), W(t)) = s = \min(s, t)$.
3. **Slide 3 (`quiz`):** Test Brownian Scaling Invariance: For any scaling constant $c > 0$, how does the transformed process $X(t) = \frac{1}{\sqrt{c}} W(c t)$ behave? (It is IDENTICALLY distributed to a standard Brownian motion: $X(t) \stackrel{d}{=} W(t)$, reflecting the fractal self-similarity of Brownian paths).
4. **Slide 4 (`proof`):** Interactive derivation showing that by Donsker's Invariance Principle (Functional Central Limit Theorem), the scaled random walk $S_{\lfloor n t \rfloor} / \sqrt{n} \xrightarrow{d} W(t)$ converges weakly to Brownian motion in the Skorokhod space $D[0, T]$.
5. **Slide 5 (`one_word`):** Plain-text recall of the probability distribution family governing Brownian increments $W(t) - W(s)$ (gaussian / normal).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "wiener_process_and_gaussian_increments",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Standard Brownian Motion (The Wiener Process)**\n• A stochastic process $\\{W(t), t \\ge 0\\}$ is a **Standard Brownian Motion** if:\n  1. $W(0) = 0$ almost surely.\n  2. **Independent Increments:** Disjoint increments $W(t_2) - W(t_1)$ and $W(t_4) - W(t_3)$ are independent.\n  3. **Stationary Gaussian Increments:** For any $0 \\le s \\le t$:\n$$\nW(t) - W(s) \\sim \\mathcal{N}(0, \\, t - s)\n$$\n  4. Sample paths $t \\mapsto W(t)$ are **continuous** almost surely everywhere.\n• **Covariance Structure:** For any two time points $s, t \\ge 0$:\n$$\n\\operatorname{Cov}(W(s), W(t)) = \\mathbb{E}[W(s) W(t)] = \\min(s, t)\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps establishing that Cov(W(s), W(t)) = min(s, t) for s <= t.",
      "orderItems": [
        "Express the covariance: Cov(W(s), W(t)) = E[W(s) * W(t)] - E[W(s)] * E[W(t)] = E[W(s) * W(t)]",
        "Decompose W(t) into the sum of past state W(s) and forward increment: W(t) = W(s) + (W(t) - W(s))",
        "Expand the product expectation: E[W(s) * W(t)] = E[W(s)^2] + E[W(s) * (W(t) - W(s))]",
        "Apply the independent increments axiom: E[W(s) * (W(t) - W(s))] = E[W(s)] * E[W(t) - W(s)] = 0 * 0 = 0",
        "Evaluate the remaining variance: E[W(s)^2] = Var(W(s)) = s = min(s, t), concluding the proof"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the Brownian Scaling Invariance Theorem for any constant c > 0?",
      "options": [
        { "text": "The scaled process X(t) = (1 / sqrt(c)) * W(c * t) is itself a STANDARD BROWNIAN MOTION identically in law: X(t) =^d W(t)", "isCorrect": true, "explanation": "Correct! Brownian motion has self-similar fractal geometry with Hurst parameter H = 1/2, meaning zooming in by factor c in time requires zooming in by sqrt(c) in space." },
        { "text": "The variance increases by c^2", "isCorrect": false, "explanation": "Incorrect: The 1/sqrt(c) factor normalizes variance exactly to t." },
        { "text": "The paths become differentiable", "isCorrect": false, "explanation": "Incorrect: Paths remain nowhere differentiable." },
        { "text": "The process becomes deterministic", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Donsker's Invariance Principle (Functional CLT)",
      "interactiveSteps": [
        {
          "stepText": "Let xi_1, xi_2, ... be i.i.d. random variables with mean 0 and variance 1, and let S_k = sum_{i=1}^k xi_i be the discrete random walk."
        },
        {
          "prompt": "According to Donsker's Theorem (1951), what is the continuous-time limiting process of X_n(t) = S_{floor(n t)} / sqrt(n) as n -> infty?",
          "options": [
            { "text": "X_n(t) converges in distribution to a Standard Brownian Motion W(t)", "isCorrect": true },
            { "text": "X_n(t) converges to 0", "isCorrect": false },
            { "text": "X_n(t) converges to a Poisson process", "isCorrect": false },
            { "text": "X_n(t) diverges to infinity", "isCorrect": false }
          ]
        },
        {
          "stepText": "This proves that Brownian motion is the universal continuous-time limit of all finite-variance random walks regardless of jump distribution!"
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What probability distribution family governs the increments W(t) - W(s) ~ N(0, t - s) in Brownian motion?",
      "blankAnswer": "gaussian"
    }
  ]
}
```
