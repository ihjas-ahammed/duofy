# Duofy Reusable Lesson Format: Probability Theory - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to compute expectations $E[X]$, conditional expectations $E[X|Y]$, Itô differentials $d f(B_t)$, and Bayes' Theorem posterior probabilities $P(A|B) = \frac{P(B|A) P(A)}{P(B)}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bayes' Theorem / Itô Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Probability Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Conditional Expectation Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative Expected Value Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Markov Chain Transition Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Bayes' Theorem & Conditional Probability**\nFor events $A, B$ with $P(B) > 0$:\n$$\nP(A \\mid B) = \\frac{P(B \\mid A) P(A)}{P(B)} = \\frac{P(B \\mid A) P(A)}{P(B \\mid A) P(A) + P(B \\mid A^c) P(A^c)}\n$$\n$P(A)$ is the prior, $P(B|A)$ is the likelihood, and $P(A|B)$ is the posterior."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** Disease prevalence $P(D) = 0.01$. Test accuracy $P(T^+ \\mid D) = 0.99$, $P(T^+ \\mid D^c) = 0.05$.\n• **Step 2:** Calculate total probability $P(T^+) = (0.99)(0.01) + (0.05)(0.99) = 0.0099 + 0.0495 = 0.0594$.\n• **Step 3:** Posterior $P(D \\mid T^+) = \\frac{P(T^+ \\mid D) P(D)}{P(T^+)} = \\frac{0.0099}{0.0594} \\approx 0.1667$.\n• **Step 4:** A positive test gives a 16.67% chance of actual disease due to low prior!"
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "By the Law of Total Expectation, the expected value of the conditional expectation E[ E[X | Y] ] equals ___.",
      "blankAnswer": "E[X]",
      "blankDistractors": ["E[Y]", "0", "Var(X)"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the variance $\\text{Var}(X) = E[X^2] - (E[X])^2$ for a roll of a fair 6-sided die ($E[X] = 3.5, E[X^2] = 15.1667$).",
      "numericAnswer": 2.9167,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "If $B_t$ is standard Brownian motion, what is $d(B_t^2)$ using Itô's Lemma?",
      "options": [
        { "text": "d(B_t^2) = 2 B_t dB_t + dt", "isCorrect": true, "explanation": "Correct! f(B) = B² -> f' = 2B, f'' = 2. So df = 2 B dB + (1/2)(2) dt = 2 B dB + dt." },
        { "text": "d(B_t^2) = 2 B_t dB_t", "isCorrect": false, "explanation": "Incorrect: Missing the Itô drift term dt!" },
        { "text": "d(B_t^2) = dt", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "d(B_t^2) = 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
