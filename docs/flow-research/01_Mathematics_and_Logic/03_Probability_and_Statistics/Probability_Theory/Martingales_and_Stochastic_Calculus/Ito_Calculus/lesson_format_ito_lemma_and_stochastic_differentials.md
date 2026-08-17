# Duofy Reusable Lesson Format: Itô's Lemma and Stochastic Differentials

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory / Martingales_and_Stochastic_Calculus / Ito_Calculus`  
**Lesson Format Type:** `ito_lemma_and_stochastic_differentials`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through **Itô's Lemma (Stochastic Chain Rule)** in 1D ($df = f_t dt + f_x dX + \frac{1}{2} f_{xx} (dX)^2$), understand the differential multiplication table ($dt \cdot dt = 0, dt \cdot dW = 0, (dW)^2 = dt$), compute stochastic differentials for non-linear functions (e.g. $d(W_t^3), d(e^{W_t}), d(\ln S_t)$), and evaluate 2D cross-variation differentials ($d(X_t Y_t) = X_t dY_t + Y_t dX_t + dX_t dY_t$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Itô's Lemma & Stochastic Differential Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Taylor Expansion Itô's Lemma Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Differential Multiplication & Stochastic Product Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Second-Order Taylor Expansion Correction Factor Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Stochastic Differential of ln(S) in Black-Scholes Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Itô's Lemma for Itô process $dX_t = \mu(t, X_t) dt + \sigma(t, X_t) dW_t$ and $f(t, x) \in C^{1, 2}([0, \infty) \times \mathbb{R})$:
   $$df(t, X_t) = \frac{\partial f}{\partial t} dt + \frac{\partial f}{\partial x} dX_t + \frac{1}{2} \frac{\partial^2 f}{\partial x^2} (dX_t)^2$$
   Substitute $(dX_t)^2 = \sigma^2 dt$:
   $$df(t, X_t) = \left( \frac{\partial f}{\partial t} + \mu \frac{\partial f}{\partial x} + \frac{1}{2}\sigma^2 \frac{\partial^2 f}{\partial x^2} \right) dt + \sigma \frac{\partial f}{\partial x} dW_t$$
   State the Stochastic Product Rule (Itô Product Rule): $d(X_t Y_t) = X_t dY_t + Y_t dX_t + dX_t dY_t$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the derivation: (1) write 2D Taylor series expansion of $\Delta f = f(t+\Delta t, X+\Delta X) - f(t, X)$: $\frac{\partial f}{\partial t}\Delta t + \frac{\partial f}{\partial x}\Delta X + \frac{1}{2}\frac{\partial^2 f}{\partial t^2}(\Delta t)^2 + \frac{\partial^2 f}{\partial t \partial x}\Delta t \Delta X + \frac{1}{2}\frac{\partial^2 f}{\partial x^2}(\Delta X)^2 + \dots$, (2) plug in $\Delta X = \mu \Delta t + \sigma \Delta W$, (3) compute $(\Delta X)^2 = \mu^2 (\Delta t)^2 + 2\mu\sigma \Delta t \Delta W + \sigma^2 (\Delta W)^2$, (4) drop terms higher than $dt$: $(\Delta t)^2 \to 0, \Delta t \Delta W \to 0$, (5) substitute $(\Delta W)^2 \to dt$, keeping the term $\frac{1}{2}\frac{\partial^2 f}{\partial x^2} \sigma^2 dt$!
3. **Slide 3 (`matching`):** Pair 4 stochastic differential rules ($(dW_t)^2$, $dt \cdot dW_t$, $d(e^{W_t})$, $d(W_t^2)$) with their exact differential representations.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the coefficient in front of the second spatial derivative in Itô's Lemma is one-half (1/2). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on evaluating $d(\ln S_t)$ where $dS_t = \mu S_t dt + \sigma S_t dW_t$: What is the exact stochastic differential of $Y_t = \ln S_t$? ($d(\ln S_t) = (\mu - \frac{1}{2}\sigma^2)dt + \sigma dW_t$, explaining why log-returns have drift $\mu - \frac{1}{2}\sigma^2$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ito_lemma_and_stochastic_differentials",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Itô's Lemma (The Stochastic Chain Rule)**\n• Let $dX_t = \\mu(t, X_t) \\, dt + \\sigma(t, X_t) \\, dW_t$ be an **Itô Diffusion Process**.\n• For any function $f(t, x) \\in C^{1, 2}$, the stochastic differential is:\n$$\ndf(t, X_t) = \\frac{\\partial f}{\\partial t} \\, dt + \\frac{\\partial f}{\\partial x} \\, dX_t + \\frac{1}{2} \\frac{\\partial^2 f}{\\partial x^2} \\, (dX_t)^2\n$$\n• **Stochastic Multiplication Rules:** $(dt)^2 = 0, \\; dt \\cdot dW_t = 0, \\; (dW_t)^2 = dt$.\n• **Explicit Differential Form:**\n$$\ndf(t, X_t) = \\left( \\frac{\\partial f}{\\partial t} + \\mu \\frac{\\partial f}{\\partial x} + \\frac{1}{2}\\sigma^2 \\frac{\\partial^2 f}{\\partial x^2} \\right) dt + \\sigma \\frac{\\partial f}{\\partial x} \\, dW_t\n$$\n• **Itô Product Rule:** $d(X_t Y_t) = X_t \\, dY_t + Y_t \\, dX_t + dX_t \\, dY_t$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Taylor Expansion):** Expand $\\Delta f$ to second order:\n  $$\\Delta f \\approx f_t \\Delta t + f_x \\Delta X + \\frac{1}{2} f_{tt} (\\Delta t)^2 + f_{tx} \\Delta t \\Delta X + \\frac{1}{2} f_{xx} (\\Delta X)^2$$\n• **Step 2 (Substitute $\\Delta X$):** $\\Delta X = \\mu \\Delta t + \\sigma \\Delta W$.\n• **Step 3 (Square $\\Delta X$):**\n  $$(\\Delta X)^2 = \\mu^2 (\\Delta t)^2 + 2\\mu\\sigma \\Delta t \\Delta W + \\sigma^2 (\\Delta W)^2$$\n• **Step 4 (Drop High-Order Terms):** $(\\Delta t)^2 = o(dt)$ and $\\Delta t \\Delta W = o(dt)$ vanish.\n• **Step 5 (Apply $(\\Delta W)^2 \\to dt$):** The term $\\sigma^2 (\\Delta W)^2$ becomes $\\sigma^2 dt$, yielding the $\\frac{1}{2} \\sigma^2 f_{xx} dt$ correction!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each stochastic differential operation to its result.",
      "matchPairs": [
        { "left": "(dW_t)^2", "right": "dt (quadratic variation rate)" },
        { "left": "d(W_t^2)", "right": "2 W_t dW_t + dt (includes +dt correction)" },
        { "left": "d(exp(W_t))", "right": "exp(W_t) dW_t + 1/2 exp(W_t) dt" },
        { "left": "d(X_t Y_t) Cross-Term", "right": "dX_t dY_t (non-zero when processes have correlated Brownian drivers)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Itô's Lemma df = f_t dt + f_x dX + c * f_xx (dX)^2, the mathematical constant c multiplying the second spatial derivative is ___.",
      "blankAnswer": "1/2",
      "blankDistractors": ["1", "2", "0"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Given Geometric Brownian Motion dS_t = mu S_t dt + sigma S_t dW_t, apply Itô's Lemma to f(S) = ln(S) with f'(S) = 1/S and f''(S) = -1/S^2. What is d(ln S_t)?",
      "options": [
        { "text": "d(ln S_t) = (mu - 1/2 * sigma^2) dt + sigma dW_t", "isCorrect": true, "explanation": "Correct! df = (1/S)(mu S dt + sigma S dW) + 1/2 (-1/S^2)(sigma^2 S^2 dt) = mu dt + sigma dW - 1/2 sigma^2 dt = (mu - 1/2 sigma^2)dt + sigma dW." },
        { "text": "d(ln S_t) = mu dt + sigma dW_t", "isCorrect": false, "explanation": "Incorrect: Forgets the -1/2 sigma^2 dt Itô correction." },
        { "text": "d(ln S_t) = (mu + 1/2 * sigma^2) dt + sigma dW_t", "isCorrect": false, "explanation": "Incorrect: f''(S) = -1/S^2 carries a minus sign." },
        { "text": "d(ln S_t) = 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
