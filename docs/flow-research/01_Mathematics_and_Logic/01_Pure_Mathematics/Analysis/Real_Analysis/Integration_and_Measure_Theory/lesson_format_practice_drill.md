# Duofy Reusable Lesson Format: Integration and Measure Theory - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Real_Analysis / Integration_and_Measure_Theory`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of convergence theorem prerequisites (MCT monotonicity, DCT domination, Tonelli non-negativity, Fubini absolute integrability), Lebesgue null set rules, and interactive horizontal Lebesgue slicing simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fubini vs Tonelli Theorem Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Theorem Name & Core Application Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Cantor Set Measure Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Collection Property Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Lebesgue Slicing Visualizer Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the key difference in assumptions between Tonelli's Theorem and Fubini's Theorem for iterated integrals?",
      "blankAnswer": "Tonelli's Theorem requires non-negativity (f >= 0) with no prior integrability check, while Fubini's Theorem requires absolute integrability (f in L^1(mu x nu))."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each measure theoretic theorem to its primary use case.",
      "matchPairs": [
        { "left": "Monotone Convergence Theorem", "right": "Interchange limit and integral for non-decreasing non-negative sequences" },
        { "left": "Dominated Convergence Theorem", "right": "Interchange limit and integral under bounded L^1 envelope" },
        { "left": "Radon-Nikodym Theorem", "right": "Represents absolutely continuous measures as density integrals" },
        { "left": "Carathéodory's Extension Theorem", "right": "Extends pre-measures on algebras to full sigma-algebras" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the Lebesgue measure of the standard Cantor middle-thirds set C subset [0, 1]?",
      "options": [
        { "text": "0 (even though it is uncountable and has continuum cardinality)", "isCorrect": true, "explanation": "Correct! The total length of removed intervals is sum_{k=0}^infty 2^k / 3^{k+1} = 1, leaving mu(C) = 1 - 1 = 0." },
        { "text": "1", "isCorrect": false, "explanation": "Incorrect: 1 is the length of the initial interval [0, 1]." },
        { "text": "1/3", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "1/2", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the mathematical name for a collection of subsets closed under complements and countable unions?",
      "blankAnswer": "sigma-algebra"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Lebesgue vs Riemann Slicing Explorer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Riemann vs Lebesgue Integration</h3><div style=\"display:flex; gap:10px; margin:15px 0;\"><button id=\"riemannBtn\" style=\"padding:8px 16px; background:#334155; color:white; border:none; border-radius:6px; cursor:pointer;\">Riemann (Domain Slices)</button><button id=\"lebesgueBtn\" style=\"padding:8px 16px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Lebesgue (Range Slices)</button></div><div id=\"sliceOut\" style=\"color:#38bdf8; font-weight:bold;\">Select a method above</div><script>document.getElementById('riemannBtn').onclick=()=>{document.getElementById('sliceOut').innerText='Vertical strips on X-axis (Fails on Dirichlet 1_Q)';}; document.getElementById('sliceOut').innerText='Horizontal slices on Y-axis: Measures preimage sets f^{-1}([y_i, y_{i+1}]) (Works for all measurable functions!)'; document.getElementById('lebesgueBtn').onclick=()=>{document.getElementById('sliceOut').innerText='Lebesgue: Measures sizes of pre-images! Integrates Dirichlet 1_Q to 0.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
