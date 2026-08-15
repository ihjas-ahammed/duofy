# Duofy Reusable Lesson Format: Probability Theory - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for probability distributions, expectation/variance formulas, stochastic process properties, and interactive Central Limit Theorem visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bayes' Theorem Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Probability Distribution Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Martingale Property Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Stochastic Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive CLT Simulation Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the defining condition of a Martingale stochastic process (M_n)?",
      "blankAnswer": "E[M_{n+1} | F_n] = M_n (expected next value equals current value)"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each probability distribution to its exact mean E[X] and variance Var(X).",
      "matchPairs": [
        { "left": "Binomial(n, p)", "right": "E[X] = n p, Var(X) = n p (1 - p)" },
        { "left": "Poisson(λ)", "right": "E[X] = λ, Var(X) = λ" },
        { "left": "Exponential(λ)", "right": "E[X] = 1/λ, Var(X) = 1/λ^2" },
        { "left": "Uniform(a, b)", "right": "E[X] = (a+b)/2, Var(X) = (b-a)^2 / 12" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the **Memoryless Property** in continuous probability distributions, and which continuous distribution uniquely possesses it?",
      "options": [
        { "text": "P(X > s + t | X > s) = P(X > t); unique to the Exponential distribution", "isCorrect": true, "explanation": "Correct! Exponential distribution is the unique memoryless continuous distribution." },
        { "text": "Unique to Normal distribution", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "P(X > t) = 1 always", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Unique to Poisson distribution", "isCorrect": false, "explanation": "Incorrect: Poisson is discrete." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What term describes a continuous Gaussian stochastic process B_t with independent stationary increments B_t - B_s ~ N(0, t-s)?",
      "blankAnswer": "brownian"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Central Limit Theorem Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Central Limit Theorem (CLT)</h3><p>Sum n=100 uniform dice rolls to observe Gaussian convergence:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Sample n = 1000 trials</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! As sample size n increases, standardized sum converges to Bell Curve N(0, 1)!'); };</script></div>"
    }
  ]
}
```
