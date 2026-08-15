# Duofy Reusable Lesson Format: Divisibility and Prime Numbers - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Elementary_Number_Theory / Divisibility_and_Prime_Numbers`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of Euclidean division remainder bounds, coprimality criteria ($\gcd(a, b) = 1$), Euler totient formula computations, divisor count formulas, and interactive Euclidean algorithm step-by-step simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Division Algorithm Remainder Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Integer & Divisor Function Values Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | GCD and LCM Product Identity Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Ancient Sieve Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Euclidean Algorithm Calculator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "In the Division Algorithm a = bq + r with b > 0, what is the exact range of allowed values for the remainder r?",
      "blankAnswer": "0 <= r < b (r is a non-negative integer strictly less than the divisor b)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each integer n to its number of positive divisors tau(n).",
      "matchPairs": [
        { "left": "n = 12 (2^2 * 3^1)", "right": "tau(12) = (2+1)(1+1) = 6 divisors" },
        { "left": "n = 16 (2^4)", "right": "tau(16) = 4+1 = 5 divisors" },
        { "left": "n = 17 (prime)", "right": "tau(17) = 1+1 = 2 divisors" },
        { "left": "n = 30 (2 * 3 * 5)", "right": "tau(30) = 2 * 2 * 2 = 8 divisors" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "For any two positive integers a and b, what is the exact relation between their product a * b, their gcd(a, b), and their lcm(a, b)?",
      "options": [
        { "text": "gcd(a, b) * lcm(a, b) = a * b", "isCorrect": true, "explanation": "Correct! Because min(a_i, b_i) + max(a_i, b_i) = a_i + b_i for every prime factor, gcd(a, b) * lcm(a, b) = a * b." },
        { "text": "gcd(a, b) + lcm(a, b) = a * b", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "lcm(a, b) = a * b * gcd(a, b)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "gcd(a, b) / lcm(a, b) = a * b", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the name of the ancient Greek algorithm that finds all prime numbers up to N by crossing out composites on a grid?",
      "blankAnswer": "eratosthenes"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Euclidean Algorithm Step-Through",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Euclidean GCD Calculator</h3><p>Compute gcd(1071, 462):</p><button id=\"gcdBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Run Euclidean Steps</button><div id=\"gcdOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('gcdBtn').onclick=()=>{document.getElementById('gcdOut').innerText='1071 = 2(462) + 147 | 462 = 3(147) + 21 | 147 = 7(21) + 0 => GCD = 21!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
