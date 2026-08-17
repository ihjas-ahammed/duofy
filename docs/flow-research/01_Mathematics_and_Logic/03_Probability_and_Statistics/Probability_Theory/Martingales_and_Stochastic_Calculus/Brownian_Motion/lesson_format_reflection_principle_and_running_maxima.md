# Duofy Reusable Lesson Format: The Reflection Principle and Running Maxima

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory / Martingales_and_Stochastic_Calculus / Brownian_Motion`  
**Lesson Format Type:** `reflection_principle_and_running_maxima`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to apply the **Brownian Reflection Principle** (Désiré André), compute the distribution of the **Running Maximum** $M(t) = \max_{0 \le s \le t} W(s)$ via $P(M(t) \ge a) = 2 P(W(t) \ge a) = 2(1 - \Phi(a/\sqrt{t}))$, derive the **First Hitting Time Distribution** $f_{\tau_a}(t) = \frac{a}{\sqrt{2\pi t^3}} e^{-a^2/(2t)}$ (Lévy distribution), and price barrier options.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Reflection Principle & Running Maximum Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step André Reflection Proof Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Brownian Extremum & Stopping Time Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Maximum Equals Absolute Value Terminal Law Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 5** | Numerical Running Maximum Probability Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Reflection Principle: Let $\{W(t), t \ge 0\}$ be a standard Brownian motion and let $\tau_a = \inf\{t \ge 0 \mid W(t) = a\}$ be the first hitting time of level $a > 0$. By the strong Markov property and spatial symmetry of Brownian motion, the reflected path $\tilde{W}(t) = W(t)$ for $t \le \tau_a$ and $\tilde{W}(t) = 2a - W(t)$ for $t > \tau_a$ is also a standard Brownian motion. Theorem: For any $a > 0$ and $x \le a$, $P(M(t) \ge a, W(t) \le x) = P(W(t) \ge 2a - x)$. Setting $x = a$ yields the Running Maximum Distribution: $P(M(t) \ge a) = 2 P(W(t) \ge a) = 2 \left(1 - \Phi\left(\frac{a}{\sqrt{t}}\right)\right)$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 proof steps: (1) partition the event $\{M(t) \ge a\} = \{M(t) \ge a, W(t) \ge a\} \cup \{M(t) \ge a, W(t) < a\}$, (2) note that $\{W(t) \ge a\} \subseteq \{M(t) \ge a\}$, so the first set is just $\{W(t) \ge a\}$, (3) by reflecting paths across the horizontal line $y = a$ after the first hitting time $\tau_a$, there is a 1-to-1 measure-preserving bijection between paths ending below $a$ and paths ending above $a$ after hitting $a$, (4) therefore $P(M(t) \ge a, W(t) < a) = P(W(t) > a)$, giving $P(M(t) \ge a) = P(W(t) \ge a) + P(W(t) > a) = 2 P(W(t) \ge a)$!
3. **Slide 3 (`matching`):** Pair 4 Brownian path extrema formulas (Running Maximum Distribution $P(M(t) \ge a)$, First Hitting Time Density $f_{\tau_a}(t)$, Running Minimum Distribution, Joint Density of $(W_t, M_t)$) with their mathematical expressions.
4. **Slide 4 (`quiz`):** Quiz on the distributional equivalence between the running maximum and absolute terminal value: What is the remarkable law of the running maximum $M(t) = \max_{0 \le s \le t} W(s)$? ($M(t) \stackrel{d}{=} |W(t)|$, meaning the maximum has the EXACT same half-normal probability distribution as the absolute value of the endpoint!).
5. **Slide 5 (`numerical`):** Ask student: For standard Brownian motion at $t = 1.0$, what is the probability $P(M(1) \ge 1.96)$ of the running maximum exceeding 1.96? Given $\Phi(1.96) = 0.9750 \implies 1 - \Phi(1.96) = 0.0250$, by the reflection principle $P(M(1) \ge 1.96) = 2 \times 0.0250 = 0.050$ (numeric answer: 0.05).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "reflection_principle_and_running_maxima",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Brownian Reflection Principle and Running Maxima**\n• Let $M(t) = \\max_{0 \\le s \\le t} W(s)$ be the **running maximum** of a Standard Brownian Motion.\n• **The Reflection Principle (Désiré André):** For any barrier level $a > 0$:\n$$\nP(M(t) \\ge a) = 2 P(W(t) \\ge a) = 2 \\left( 1 - \\Phi\\left( \\frac{a}{\\sqrt{t}} \\right) \\right)\n$$\n• **Distributional Identity:** The running maximum has the exact same distribution as the absolute terminal value:\n$$\nM(t) \\stackrel{d}{=} |W(t)| \\sim \\text{Half-Normal}(\\sigma = \\sqrt{t})\n$$\n• **First Hitting Time Density (Lévy Distribution):** The time $\\tau_a = \\inf\\{t \\ge 0 \\mid W(t) = a\\}$ has density:\n$$\nf_{\\tau_a}(t) = \\frac{a}{\\sqrt{2\\pi t^3}} e^{-\\frac{a^2}{2t}}, \\quad t > 0\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Decompose Event):** Partition into paths ending above and below barrier $a$:\n  $$P(M(t) \\ge a) = P(M(t) \\ge a, \\, W(t) \\ge a) + P(M(t) \\ge a, \\, W(t) < a)$$\n• **Step 2 (Simplify First Term):** Since $W(t) \\ge a \\implies M(t) \\ge a$, the first term is simply $P(W(t) \\ge a)$.\n• **Step 3 (Reflect Path):** After reaching level $a$ at time $\\tau_a$, the path is equally likely to move up or down (by spatial symmetry).\n• **Step 4 (Equivalence):** Reflecting across $y = a$ maps paths ending below $a$ bijectively to paths ending above $a$:\n  $$P(M(t) \\ge a, \\, W(t) < a) = P(W(t) > a)$$\n• **Step 5 (Combine):** $P(M(t) \\ge a) = P(W(t) \\ge a) + P(W(t) > a) = 2 P(W(t) \\ge a)$!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Brownian barrier property to its exact mathematical formula.",
      "matchPairs": [
        { "left": "Running Maximum Law", "right": "P(M(t) >= a) = 2 * (1 - Phi(a / sqrt(t)))" },
        { "left": "First Hitting Time Density f_{tau_a}(t)", "right": "a / sqrt(2 pi t^3) * exp(-a^2 / (2t)) (heavy-tailed Levy distribution)" },
        { "left": "Running Minimum Law m(t)", "right": "P(min_{0<=s<=t} W(s) <= -a) = 2 * (1 - Phi(a / sqrt(t)))" },
        { "left": "Expected Hitting Time E[tau_a]", "right": "Infinite (E[tau_a] = infty, though hitting occurs with probability 1)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "quiz",
      "content": "What is the remarkable distributional relationship between the running maximum M(t) = max_{0 <= s <= t} W(s) and the terminal value W(t) of a standard Brownian motion?",
      "options": [
        { "text": "M(t) is distributed IDENTICALLY to the absolute value |W(t)|: M(t) =^d |W(t)|, following a Half-Normal distribution with density f_M(x) = sqrt(2 / (pi * t)) * exp(-x^2 / (2t)) for x >= 0", "isCorrect": true, "explanation": "Correct! Differentiating the CDF F_M(a) = 2Phi(a/sqrt(t)) - 1 with respect to a yields the exact density of |W(t)|." },
        { "text": "M(t) is always equal to W(t)", "isCorrect": false, "explanation": "Incorrect: M(t) >= W(t)." },
        { "text": "M(t) is exponentially distributed", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "M(t) is a constant", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 5,
      "type": "numerical",
      "content": "For a standard Brownian motion at t = 1.0, given 1 - Phi(1.96) = 0.0250, calculate the probability P(M(1) >= 1.96) that the running maximum exceeded 1.96 to two decimal places.",
      "numericAnswer": 0.05,
      "numericTolerance": 0.01
    }
  ]
}
```
