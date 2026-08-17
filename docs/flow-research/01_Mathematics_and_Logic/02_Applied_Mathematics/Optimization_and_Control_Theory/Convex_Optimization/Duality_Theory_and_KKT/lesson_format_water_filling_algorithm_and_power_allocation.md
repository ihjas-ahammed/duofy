# Duofy Reusable Lesson Format: The Water-Filling Algorithm and Power Allocation

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Convex_Optimization / Duality_Theory_and_KKT`  
**Lesson Format Type:** `water_filling_algorithm_and_power_allocation`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mathematical derivation of the **Water-Filling Algorithm** (Boyd Example 5.2) in convex communications theory, apply KKT conditions to maximize total channel capacity $\sum \log(\alpha_i + x_i)$ subject to budget $\sum x_i = P, x_i \ge 0$, and compute analytical threshold water levels.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Water-Filling Problem Formulation & KKT Solution Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Power Allocation KKT Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | High Noise Floor Channel Inactivation Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Numerical 2-Channel Optimal Power Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Water Level Inverse Dual Variable Symbol Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the convex power allocation problem: $\min_{\mathbf{x}} -\sum_{i=1}^n \log(\alpha_i + x_i)$ subject to $\sum_{i=1}^n x_i = P$ and $x_i \ge 0$ (where $\alpha_i = N_i / |h_i|^2$ is noise floor level). Formulate the Lagrangian: $L(x, \lambda, \nu) = -\sum \log(\alpha_i + x_i) - \sum \lambda_i x_i + \nu (\sum x_i - P)$. KKT stationarity: $-\frac{1}{\alpha_i + x_i} - \lambda_i + \nu = 0 \implies x_i^* = \max\left(0, \frac{1}{\nu^*} - \alpha_i\right) = (1/\nu^* - \alpha_i)_+$, where the water level $1/\nu^*$ satisfies the piecewise-linear monotonic equation $\sum (1/\nu^* - \alpha_i)_+ = P$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the solution algorithm: (1) sort noise levels in ascending order $\alpha_1 \le \alpha_2 \le \dots \le \alpha_n$, (2) assume the first $k$ lowest-noise channels receive positive power while channels $k+1, \dots, n$ receive zero power, (3) solve the linear equation for water level: $\sum_{i=1}^k (1/\nu - \alpha_i) = P \implies \frac{1}{\nu} = \frac{1}{k}\left(P + \sum_{i=1}^k \alpha_i\right)$, (4) verify consistency: $\alpha_k < \frac{1}{\nu} \le \alpha_{k+1}$, (5) assign powers $x_i^* = 1/\nu^* - \alpha_i$ for $i \le k$ and $x_i^* = 0$ for $i > k$.
3. **Slide 3 (`quiz`):** Test why noisy channels with $\alpha_i \ge 1/\nu^*$ receive strictly zero transmit power: (Because their noise floor is higher than the equilibrium water level; pouring power into high-noise channels yields lower marginal rate gain than concentrating power in cleaner low-noise channels).
4. **Slide 4 (`numerical`):** Ask student to calculate the power $x_1^*$ allocated to channel 1 with noise floor $\alpha_1 = 1.0, \alpha_2 = 3.0$ and total power budget $P = 4.0$: Water level $1/\nu = \frac{1}{2}(4.0 + 1.0 + 3.0) = 4.0$. Power $x_1^* = 4.0 - 1.0 = 3.0$ (numeric answer: 3.0).
5. **Slide 5 (`one_word`):** Plain-text recall of the Greek letter representing the Lagrange multiplier $\nu$ associated with the total power equality constraint (nu).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "water_filling_algorithm_and_power_allocation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The Water-Filling Problem (Boyd Example 5.2)**\n• **Objective:** Allocate total transmit power $P$ across $n$ independent Gaussian communication channels with noise levels $\\alpha_i > 0$ to maximize capacity:\n$$\n\\min_{\\mathbf{x}} -\\sum_{i=1}^n \\log(\\alpha_i + x_i) \\quad \\text{s.t.} \\quad \\sum_{i=1}^n x_i = P, \\quad x_i \\ge 0 \\; (i=1,\\dots,n)\n$$\n• **KKT Stationarity & Analytical Solution:**\n$$\n-\\frac{1}{\\alpha_i + x_i} - \\lambda_i + \\nu = 0 \\implies x_i^* = \\max\\left(0, \\; \\frac{1}{\\nu^*} - \\alpha_i\\right) = \\left( \\frac{1}{\\nu^*} - \\alpha_i \\right)_+\n$$\n• **The Water-Filling Principle:** Imagine pouring water of total volume $P$ into a vessel with uneven floor levels $\\alpha_i$. The water surface reaches uniform height $1/\\nu^*$, and water depth in vessel $i$ gives optimal power $x_i^*$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical computational steps executed by the exact Water-Filling algorithm.",
      "orderItems": [
        "Sort the channel noise floor parameters in non-decreasing order: alpha_1 <= alpha_2 <= ... <= alpha_n",
        "Set active channel count k and assume channels 1 through k receive positive power while channels k+1 through n receive zero power",
        "Solve for the candidate water level height: 1/nu = (P + sum_{i=1}^k alpha_i) / k",
        "Check threshold consistency condition: verify that alpha_k < 1/nu <= alpha_{k+1}",
        "Assign optimal powers: x_i* = 1/nu* - alpha_i for i <= k, and x_i* = 0 for all i > k"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In the water-filling solution x_i* = max(0, 1/nu* - alpha_i), why do very noisy channels with noise floor alpha_i >= 1/nu* receive EXACTLY ZERO transmit power?",
      "options": [
        { "text": "Their noise floor exceeds the equilibrium water level; investing power in poor channels yields smaller marginal Shannon capacity gains than concentrating all available power in clean channels", "isCorrect": true, "explanation": "Correct! Because log-capacity has diminishing returns, the marginal return 1/(alpha_i + x_i) is maximized by allocating power exclusively to channels with small alpha_i." },
        { "text": "Because negative power is required", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the problem is non-convex", "isCorrect": false, "explanation": "Incorrect: The problem is strictly convex." },
        { "text": "Because total power is infinite", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Two channels have noise levels alpha_1 = 1.0 and alpha_2 = 3.0. For a total power budget P = 4.0, calculate the exact optimal power x_1* allocated to channel 1.",
      "numericAnswer": 3.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What two-letter Greek name denotes the dual multiplier nu associated with the equality power constraint sum x_i = P?",
      "blankAnswer": "nu"
    }
  ]
}
```
