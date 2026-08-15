# Duofy Reusable Lesson Format: Elementary Number Theory - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Elementary_Number_Theory`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Build rapid retrieval speed for modular arithmetic rules, Euler's totient calculations $\phi(n)$, Legendre symbol values, and interactive modular clock visualizers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fermat's Theorem Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Modulo Identity Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Coprime Euler Totient Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Modular Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Modular Clock Webview | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Fermat's Little Theorem statement?",
      "blankAnswer": "a^(p-1) ≡ 1 (mod p) for prime p not dividing a"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Legendre Symbol value to its quadratic residue meaning.",
      "matchPairs": [
        { "left": "(a / p) = +1", "right": "a is a Quadratic Residue (x^2 ≡ a mod p is solvable)" },
        { "left": "(a / p) = -1", "right": "a is a Quadratic Non-Residue (x^2 ≡ a mod p unsolvable)" },
        { "left": "(a / p) = 0", "right": "p divides a (a ≡ 0 mod p)" },
        { "left": "(-1 / p)", "right": "+1 if p ≡ 1 mod 4, and -1 if p ≡ 3 mod 4" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the inverse of $3 \\pmod 7$?",
      "options": [
        { "text": "5 (since 3 * 5 = 15 ≡ 1 mod 7)", "isCorrect": true, "explanation": "Correct! 3 * 5 = 15 = 2(7) + 1 ≡ 1 mod 7." },
        { "text": "2", "isCorrect": false, "explanation": "Incorrect: 3 * 2 = 6 ≡ -1 mod 7." },
        { "text": "4", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "1", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What function phi(n) counts positive integers up to n that are coprime to n?",
      "blankAnswer": "totient"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Modular Clock Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>12-Hour Clock Arithmetic</h3><p>Compute 8 + 7 mod 12:</p><button id=\"btn\" style=\"padding:10px 20px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">Set to 3 o'clock</button><script>document.getElementById('btn').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! 8 + 7 = 15 ≡ 3 mod 12!'); };</script></div>"
    }
  ]
}
```
