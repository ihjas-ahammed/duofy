# Duofy Reusable Lesson Format: Modular Arithmetic and Congruences - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Elementary_Number_Theory / Modular_Arithmetic_and_Congruences`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of Euler totient modular reductions, Legendre symbol quadratic reciprocity rules, Wilson prime testing, and interactive modular clock simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Quadratic Reciprocity Parity Sign Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Integer & Modular Inverse mod 11 Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Wilson's Theorem Factorial Remainder Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Legendre Power Symbol Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Modular Clock Arithmetic Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "For distinct odd primes p and q, when is the Legendre symbol product (p/q)(q/p) equal to -1?",
      "blankAnswer": "If and only if both p and q are congruent to 3 modulo 4 (i.e. p = q = 3 mod 4)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each integer a to its multiplicative inverse a^{-1} modulo 11.",
      "matchPairs": [
        { "left": "2 mod 11", "right": "6 (since 2 * 6 = 12 = 1 mod 11)" },
        { "left": "3 mod 11", "right": "4 (since 3 * 4 = 12 = 1 mod 11)" },
        { "left": "5 mod 11", "right": "9 (since 5 * 9 = 45 = 1 mod 11)" },
        { "left": "10 mod 11", "right": "10 (since 10 * 10 = 100 = 1 mod 11)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "By Wilson's Theorem, what is the remainder when 12! is divided by 13?",
      "options": [
        { "text": "12 (since 12! = -1 = 12 mod 13 for prime p = 13)", "isCorrect": true, "explanation": "Correct! (p-1)! = -1 mod p, so 12! = -1 = 12 mod 13." },
        { "text": "1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "0", "isCorrect": false, "explanation": "Incorrect: 13 does not divide 12!." },
        { "text": "6", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the surname of the French mathematician who introduced the notation (a/p) for quadratic residues?",
      "blankAnswer": "legendre"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Modular Clock Multiplier",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Modular Ring Z/12Z Explorer</h3><p>Compute 7 * 5 mod 12:</p><button id=\"clockBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate Clock Position</button><div id=\"clockOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('clockBtn').onclick=()=>{document.getElementById('clockOut').innerText='7 * 5 = 35 = 2(12) + 11 ≡ 11 mod 12 (Position 11 on the clock)!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
