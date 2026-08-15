# Duofy Reusable Lesson Format: Probability Theory - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through foundational probability proofs: Central Limit Theorem via Characteristic Functions, Itô's Lemma Derivation ($dB_t^2 = dt$), and the First & Second Borel-Cantelli Lemmas.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CLT Statement & Characteristic Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Taylor Expansion Proof Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Borel-Cantelli Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Itô's Lemma Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Stochastic Differential Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Proof of Central Limit Theorem via Characteristic Functions**\nLet $X_1, \\dots, X_n$ be i.i.d. with mean $0$ and variance $\\sigma^2 = 1$. Let $S_n = \\frac{1}{\\sqrt{n}} \\sum_{i=1}^n X_i$.\nCharacteristic function $\\phi_{S_n}(t) = \\left( \\phi_X\\left(\\frac{t}{\\sqrt{n}}\\right) \\right)^n$.\n$$\n\\lim_{n \\to \\infty} \\phi_{S_n}(t) = e^{-t^2 / 2} = \\phi_{\\mathcal{N}(0,1)}(t)\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove the Central Limit Theorem.",
      "orderItems": [
        "Taylor expand characteristic function of single X: ϕ_X(u) = 1 + i u E[X] - (u^2 / 2) E[X^2] + o(u^2).",
        "Substitute u = t / √n: ϕ_X(t / √n) = 1 - t^2 / (2n) + o(t^2 / n).",
        "Form normalized sum characteristic function: ϕ_{S_n}(t) = [1 - t^2 / (2n) + o(t^2 / n)]^n.",
        "Take limit as n -> ∞ using identity lim (1 + z/n)^n = e^z: lim ϕ_{S_n}(t) = e^(-t^2 / 2).",
        "Apply Lévy's Continuity Theorem: convergence of characteristic functions implies convergence in distribution to N(0, 1)."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What does the **First Borel-Cantelli Lemma** state if $\\sum_{n=1}^\\infty P(E_n) < \\infty$?",
      "options": [
        { "text": "The probability that infinitely many events E_n occur is zero: P(E_n i.o.) = 0", "isCorrect": true, "explanation": "Correct! If sum of probabilities converges, infinitely many events occur with probability 0." },
        { "text": "P(E_n i.o.) = 1", "isCorrect": false, "explanation": "Incorrect: That requires independence and divergence (Second Borel-Cantelli)." },
        { "text": "Events E_n are independent", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "All E_n are empty", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: Itô's Lemma Second-Order Term $(dB_t)^2$",
      "interactiveSteps": [
        { "stepText": "Taylor expand $f(B_t + dB_t) - f(B_t) = f'(B_t) dB_t + \\frac{1}{2} f''(B_t) (dB_t)^2 + \\dots$" },
        {
          "prompt": "In Brownian motion, what is the expected value of quadratic variation $(dB_t)^2$?",
          "options": [
            { "text": "(dB_t)^2 = dt (deterministic second-order time increment)", "isCorrect": true },
            { "text": "(dB_t)^2 = 0", "isCorrect": false },
            { "text": "(dB_t)^2 = dB_t", "isCorrect": false },
            { "text": "(dB_t)^2 = dt^2", "isCorrect": false }
          ]
        },
        { "stepText": "Since $(dB_t)^2 = dt$, Itô's formula gains a deterministic second-derivative drift term $\\frac{1}{2} f''(B_t) dt$!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What stochastic differential rule calculates d f(t, B_t) for functions of Brownian motion?",
      "blankAnswer": "ito"
    }
  ]
}
```
