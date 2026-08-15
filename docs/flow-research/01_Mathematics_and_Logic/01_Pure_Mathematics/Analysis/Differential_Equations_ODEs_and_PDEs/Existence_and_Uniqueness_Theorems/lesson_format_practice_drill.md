# Duofy Reusable Lesson Format: Existence and Uniqueness Theorems - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Differential_Equations_ODEs_and_PDEs / Existence_and_Uniqueness_Theorems`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of Lipschitz continuity failures (e.g. fractional powers $y^{p/q}$ with $p < q$), Picard iterate formula mechanics, Grönwall inequality applications, and interactive slope field simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Peano vs Picard Comparison Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Differential Equation & Uniqueness Status Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Grönwall Inequality Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Metric Space Property Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Picard Iteration Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the key difference in assumptions between Peano's Existence Theorem and the Picard-Lindelöf Theorem?",
      "blankAnswer": "Peano requires only continuity of f(t, y) (giving existence without uniqueness), while Picard-Lindelöf requires Lipschitz continuity in y (giving both existence and uniqueness)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each initial value problem to its solution uniqueness status at the origin.",
      "matchPairs": [
        { "left": "y' = y, y(0) = 0", "right": "Unique solution y(t) = 0 (Lipschitz continuous)" },
        { "left": "y' = y^{1/2}, y(0) = 0 for y >= 0", "right": "Non-unique solutions (fails Lipschitz at y=0)" },
        { "left": "y' = t^2 + y^2, y(0) = 1", "right": "Unique local solution (locally Lipschitz)" },
        { "left": "y' = sign(y), y(0) = 0", "right": "Fails Peano (discontinuous right-hand side)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "If u(t) <= integral_0^t 3 u(s) ds for all t >= 0 with u(t) >= 0 and u(0) = 0, what does Grönwall's Inequality conclude?",
      "options": [
        { "text": "u(t) = 0 for all t >= 0", "isCorrect": true, "explanation": "Correct! Grönwall states u(t) <= 0 * e^{3t} = 0, forcing u(t) to be identically zero." },
        { "text": "u(t) = e^{3t}", "isCorrect": false, "explanation": "Incorrect: The leading constant is 0." },
        { "text": "u(t) = 3t", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "u(t) -> infinity as t -> 3", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What metric space property (where all Cauchy sequences converge) is required for the Banach Fixed-Point Theorem to apply?",
      "blankAnswer": "completeness"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Picard Iterates Convergence Explorer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Solve y' = y, y(0) = 1</h3><div id=\"iterDisplay\" style=\"padding:12px; background:#1e293b; border-radius:8px; margin:15px 0; font-family:monospace; font-size:16px;\">y_0(t) = 1</div><button id=\"stepIter\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Next Picard Iterate</button><script>const iters=['y_0(t) = 1', 'y_1(t) = 1 + t', 'y_2(t) = 1 + t + t^2/2', 'y_3(t) = 1 + t + t^2/2 + t^3/6 -> e^t!']; let k=0; document.getElementById('stepIter').onclick=()=>{if(k < iters.length-1){k++; document.getElementById('iterDisplay').innerText=iters[k]; if(k===iters.length-1){document.getElementById('stepIter').style.background='#10b981'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');}}};</script></div>"
    }
  ]
}
```
