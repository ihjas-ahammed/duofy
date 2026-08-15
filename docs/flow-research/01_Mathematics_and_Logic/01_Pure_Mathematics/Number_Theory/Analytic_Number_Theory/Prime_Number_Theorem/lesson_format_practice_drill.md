# Duofy Reusable Lesson Format: Prime Number Theorem - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Analytic_Number_Theory / Prime_Number_Theorem`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of prime density asymptotics, Chebyshev function bounds, von Mangoldt function evaluations, Riemann Hypothesis error bounds, and interactive prime counting simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Riemann Hypothesis Error Bound Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Arithmetic Function & Value Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | PNT Asymptotic Equivalence Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted von Mangoldt Symbol Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Prime Density Sieve Visualizer Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the sharpest known error bound for the Prime Number Theorem under the assumption that the Riemann Hypothesis is true?",
      "blankAnswer": "pi(x) = Li(x) + O(sqrt(x) * ln(x)), which means the fluctuation is at most of the order of the square root of x."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each integer input n to the value of the von Mangoldt function Lambda(n).",
      "matchPairs": [
        { "left": "Lambda(7) (p = 7, k = 1)", "right": "ln(7)" },
        { "left": "Lambda(8) (p = 2, k = 3)", "right": "ln(2)" },
        { "left": "Lambda(9) (p = 3, k = 2)", "right": "ln(3)" },
        { "left": "Lambda(10) (n = 2 * 5 composite)", "right": "0 (not a prime power)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Which of the following asymptotic relations is mathematically equivalent to the Prime Number Theorem?",
      "options": [
        { "text": "psi(x) ~ x as x -> infty (where psi is Chebyshev's second function)", "isCorrect": true, "explanation": "Correct! Proving psi(x) ~ x is the standard path to proving pi(x) ~ x / ln(x)." },
        { "text": "pi(x) = x / 2", "isCorrect": false, "explanation": "Incorrect: Primes thin out logarithmically." },
        { "text": "zeta(1) = 0", "isCorrect": false, "explanation": "Incorrect: zeta(s) has a simple pole at s = 1." },
        { "text": "theta(x) ~ ln(x)", "isCorrect": false, "explanation": "Incorrect: theta(x) ~ x, not ln(x)." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the name of the Greek letter used to denote the von Mangoldt arithmetic function?",
      "blankAnswer": "lambda"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Prime Density Sieve Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Prime Counting Function π(x)</h3><p>Compute π(x) vs x/ln(x) for x = 100:</p><button id=\"pntBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate Prime Count</button><div id=\"pntOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('pntBtn').onclick=()=>{document.getElementById('pntOut').innerText='Actual π(100) = 25 primes. Estimate 100/ln(100) = 21.7. Log integral Li(100) = 29.1!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
