# Duofy Reusable Lesson Format: Quadratic Variation and Nowhere Differentiability

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory / Martingales_and_Stochastic_Calculus / Brownian_Motion`  
**Lesson Format Type:** `quadratic_variation_and_nowhere_differentiability`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the core analytic pathology of Brownian motion: prove that sample paths are **Nowhere Differentiable** almost surely, calculate **Quadratic Variation** $[W, W]_t = \lim \sum (W(t_k) - W(t_{k-1}))^2 = t$ in $L^2$, show that **First Variation** is infinite ($V_1(W) = \infty$), and establish the stochastic differential heuristic $(dW_t)^2 = dt$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Quadratic Variation Theorem & (dW)^2 = dt Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step L2 Quadratic Variation Convergence Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Variation Type & Path Regularity Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Standard Deviation of Increment dt Exponent Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Failure of Classical Chain Rule Due to Quadratic Variation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Quadratic Variation Theorem: Let $\Pi = \{0 = t_0 < t_1 < \dots < t_n = t\}$ be a partition of $[0, t]$ with mesh $\|\Pi\| = \max(t_k - t_{k-1}) \to 0$. Define the Quadratic Variation $[W, W]_t = \lim_{\|\Pi\| \to 0} \sum_{k=1}^n (W(t_k) - W(t_{k-1}))^2$. Theorem: $[W, W]_t = t$ in $L^2(\Omega)$ and almost surely. State the First Variation Theorem: $V_1(W, [0, t]) = \lim \sum |W(t_k) - W(t_{k-1})| = \infty$ almost surely. State Nowhere Differentiability: For almost every sample path $\omega \in \Omega$, $t \mapsto W(t, \omega)$ is nowhere differentiable on $[0, \infty)$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the $L^2$ convergence proof: (1) let $\Delta W_k = W(t_k) - W(t_{k-1}) \sim \mathcal{N}(0, \Delta t_k)$, (2) compute expected sum: $\mathbb{E}\left[\sum (\Delta W_k)^2\right] = \sum \Delta t_k = t$, (3) compute variance of sum: $\operatorname{Var}\left(\sum (\Delta W_k)^2\right) = \sum \operatorname{Var}((\Delta W_k)^2)$ by independent increments, (4) evaluate moments: $\operatorname{Var}((\Delta W_k)^2) = \mathbb{E}[(\Delta W_k)^4] - (\mathbb{E}[(\Delta W_k)^2])^2 = 3 (\Delta t_k)^2 - (\Delta t_k)^2 = 2 (\Delta t_k)^2$, (5) bound total variance: $\sum 2 (\Delta t_k)^2 \le 2 \|\Pi\| \sum \Delta t_k = 2 \|\Pi\| t \to 0$ as $\|\Pi\| \to 0$, proving $L^2$ convergence to deterministic $t$!
3. **Slide 3 (`matching`):** Pair 4 variation metrics (Smooth function first variation, Smooth function quadratic variation, Brownian path first variation, Brownian path quadratic variation) with their exact values.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the standard deviation of increment $W(t+\Delta t) - W(t)$ scales as the square root of time $\Delta t^{1/2}$, causing infinite velocity $\Delta W / \Delta t \sim \Delta t^{-1/2} \to \infty$. Plain text only.
5. **Slide 5 (`quiz`):** Quiz explaining why ordinary Newton-Leibniz calculus fails for Brownian motion: (Because $(dW_t)^2 = dt \ne 0$ does not vanish in second-order Taylor expansions, requiring Itô's Lemma with the non-zero correction term $\frac{1}{2}f''(W_t)dt$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "quadratic_variation_and_nowhere_differentiability",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Quadratic Variation and Nowhere Differentiability**\n• **Quadratic Variation $[W, W]_t$:** For partition $0 = t_0 < t_1 < \\dots < t_n = t$ with mesh $\\|\\Pi\\| \\to 0$:\n$$\n[W, W]_t = \\lim_{\\|\\Pi\\| \\to 0} \\sum_{k=1}^n \\left( W(t_k) - W(t_{k-1}) \\right)^2 = t \\quad \\text{in } L^2 \\text{ and a.s.}\n$$\n• **Heuristic Notation:** $(dW_t)^2 = dt$ (deterministic linear growth in quadratic variation!).\n• **Path Irregularity Theorems (Paley, Wiener, Zygmund 1933):**\n  1. **Infinite Total Variation:** $V_1(W, [0, t]) = \\sum |\\Delta W_k| = \\infty$ a.s. on every interval.\n  2. **Nowhere Differentiability:** With probability 1, Brownian paths are **continuous everywhere but differentiable nowhere**."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Expected Sum):** Since $\\Delta W_k \\sim \\mathcal{N}(0, \\Delta t_k)$, $\\mathbb{E}[(\\Delta W_k)^2] = \\Delta t_k$. Summing over partition:\n  $$\\mathbb{E}\\left[ \\sum_{k=1}^n (\\Delta W_k)^2 \\right] = \\sum_{k=1}^n \\Delta t_k = t$$\n• **Step 2 (Variance of Sum):** By independent increments:\n  $$\\operatorname{Var}\\left( \\sum_{k=1}^n (\\Delta W_k)^2 \\right) = \\sum_{k=1}^n \\operatorname{Var}((\\Delta W_k)^2)$$\n• **Step 3 (Fourth Moment):** For Gaussian variables, $\\mathbb{E}[X^4] = 3 \\sigma^4$, so $\\operatorname{Var}((\\Delta W_k)^2) = 2 (\\Delta t_k)^2$.\n• **Step 4 (Mesh Vanishing):**\n  $$\\operatorname{Var}\\left( \\sum (\\Delta W_k)^2 \\right) = 2 \\sum (\\Delta t_k)^2 \\le 2 \\|\\Pi\\| \\sum \\Delta t_k = 2 \\|\\Pi\\| t \\xrightarrow{\\|\\Pi\\| \\to 0} 0$$\n  (The variance vanishes, proving quadratic variation converges to exact deterministic constant $t$!)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each function and process type to its variation properties.",
      "matchPairs": [
        { "left": "Smooth Differentiable Path f(t)", "right": "First variation is finite; Quadratic variation [f, f]_t = 0 (vanishes)" },
        { "left": "Brownian Motion Path W(t)", "right": "First variation is INFINITE; Quadratic variation [W, W]_t = t" },
        { "left": "Differential dt * dW_t", "right": "o(dt) = 0 (negligible in stochastic calculus)" },
        { "left": "Stochastic Square (dW_t)^2", "right": "Equals dt (preserves second-order curvature terms in Ito's Lemma)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Because the standard deviation of a Brownian increment scales as the square root of time (sqrt(dt)), the differential ratio dW/dt diverges, making sample paths nowhere ___.",
      "blankAnswer": "differentiable",
      "blankDistractors": ["continuous", "integrable", "measurable"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the standard Newton-Leibniz chain rule from ordinary calculus fail when differentiating functions of Brownian motion f(W_t)?",
      "options": [
        { "text": "Because (dW_t)^2 = dt is of order dt (first-order in time), meaning second-order Taylor terms do NOT vanish, requiring the Ito correction + 1/2 f''(W_t) dt", "isCorrect": true, "explanation": "Correct! In ordinary calculus (dt)^2 = 0, so second derivatives vanish. But in stochastic calculus (dW)^2 = dt, forcing the second derivative term to survive as an essential first-order drift!" },
        { "text": "Because Brownian motion is always equal to zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Gaussian distributions have no derivatives", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Brownian motion cannot be integrated", "isCorrect": false, "explanation": "Incorrect: It is integrated via Ito integrals." }
      ]
    }
  ]
}
```
