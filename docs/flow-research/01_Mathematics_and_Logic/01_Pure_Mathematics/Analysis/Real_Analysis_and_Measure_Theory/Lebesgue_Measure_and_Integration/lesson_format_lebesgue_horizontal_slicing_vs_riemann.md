# Duofy Reusable Lesson Format: Lebesgue Horizontal Slicing vs Riemann Integration

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Real_Analysis_and_Measure_Theory / Lebesgue_Measure_and_Integration`  
**Lesson Format Type:** `lebesgue_horizontal_slicing_vs_riemann`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of why Lebesgue integration ("horizontal range slicing") succeeds where Riemann integration ("vertical domain slicing") fails, test integrability of Dirichlet and Thomae functions, and interact with visual horizontal slicing simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Lebesgue vs Riemann Integration Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Function & Integration Status Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Lebesgue Monotone Limit Domination Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Measure Integral Founder Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Horizontal vs Vertical Slicing Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "lebesgue_horizontal_slicing_vs_riemann",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How does Lebesgue integration differ fundamentally from Riemann integration in its geometric partitioning method?",
      "blankAnswer": "Riemann integration partitions the domain [a, b] into vertical strips. Lebesgue integration partitions the range (codomain) into horizontal slices and measures the preimage sets f^{-1}([y_i, y_{i+1}))."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each mathematical function on [0, 1] to its integrability status.",
      "matchPairs": [
        { "left": "Dirichlet Function 1_{Q cap [0, 1]}", "right": "Lebesgue integrable (integral = 0), but NOT Riemann integrable" },
        { "left": "Continuous Function f in C[0, 1]", "right": "Both Riemann and Lebesgue integrable with identical values" },
        { "left": "Thomae's Popcorn Function", "right": "Both Riemann and Lebesgue integrable (continuous a.e., integral = 0)" },
        { "left": "Unbounded Function 1/sqrt(x) on (0, 1]", "right": "Lebesgue integrable in L^1 (integral = 2), but improper in Riemann" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the exact Lebesgue integral of the Dirichlet indicator function f(x) = 1 if x in Q, and 0 if x in R \\ Q over the interval [0, 1]?",
      "options": [
        { "text": "0, because the rationals Q have Lebesgue measure m(Q cap [0, 1]) = 0", "isCorrect": true, "explanation": "Correct! Since Q is countable, m(Q) = 0, so int_0^1 1_Q dm = 1 * m(Q cap [0, 1]) + 0 * m(Q^c) = 0." },
        { "text": "1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Undefined (does not exist)", "isCorrect": false, "explanation": "Incorrect: The Riemann integral is undefined, but the Lebesgue integral is well-defined and equals 0." },
        { "text": "1/2", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the surname of the French mathematician who introduced the measure and integral named after him in his 1902 doctoral thesis?",
      "blankAnswer": "lebesgue"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Horizontal vs Vertical Slicing Visualizer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Integration Paradigms: Dirichlet Function</h3><p>Compare Riemann domain partition vs Lebesgue range partition on 1_Q:</p><button id=\"intBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate Integrals</button><div id=\"intOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('intBtn').onclick=()=>{document.getElementById('intOut').innerText='Riemann: Upper sum = 1, Lower sum = 0 => Fails! | Lebesgue: Range {0, 1} => 1*m(Q) + 0*m(Q^c) = 0 => Integral = 0!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
