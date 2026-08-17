# Duofy Reusable Lesson Format: Baire Category Theorem and Dense G-Delta Sets

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Real_Analysis_and_Measure_Theory / Metric_Spaces_and_Topology`  
**Lesson Format Type:** `baire_category_and_dense_g_delta_sets`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of the **Baire Category Theorem (BCT)** in complete metric spaces, distinguish First Category (meager) vs Second Category (non-meager) sets, understand dense $G_\delta$ sets, and explore interactive nested closed ball constructions.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Baire Category Theorem Statement Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Topological Set Classification & Baire Status Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Nowhere Differentiable Functions Density Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Meager Set Category Number Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Baire Nested Ball Squeeze Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "baire_category_and_dense_g_delta_sets",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Baire Category Theorem (BCT) for complete metric spaces?",
      "blankAnswer": "In any non-empty complete metric space X, the intersection of any countable family of open dense sets is dense in X. Equivalently, X cannot be expressed as a countable union of nowhere dense sets."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each topological subset of the real line R to its Baire category status.",
      "matchPairs": [
        { "left": "Rationals Q (countable union of singletons)", "right": "First Category (Meager set - countable union of nowhere dense sets)" },
        { "left": "Irrationals R \\ Q (countable intersection of dense opens)", "right": "Second Category (Generic residual dense G_delta set)" },
        { "left": "Cantor Middle-Thirds Set C", "right": "Uncountable nowhere dense closed set of measure zero" },
        { "left": "The Complete Real Line R", "right": "Second Category (Non-meager space by BCT)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "How does the Baire Category Theorem prove that 'most' continuous functions in C[0, 1] are NOWHERE differentiable?",
      "options": [
        { "text": "Functions with a derivative at even a single point form a First Category (meager) set in C[0, 1], meaning nowhere differentiable functions form a dense residual G_delta set", "isCorrect": true, "explanation": "Correct! Banach used BCT to prove that continuous nowhere differentiable functions (like Weierstrass's monster) are mathematically generic." },
        { "text": "Because all continuous functions are polynomials", "isCorrect": false, "explanation": "Incorrect: Polynomials are differentiable everywhere." },
        { "text": "Because C[0, 1] is finite-dimensional", "isCorrect": false, "explanation": "Incorrect: C[0, 1] is infinite-dimensional." },
        { "text": "Because derivatives do not exist in analysis", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "A subset of a topological space that can be written as a countable union of nowhere dense sets is called a set of the ___ category.",
      "blankAnswer": "first"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Baire Nested Closed Ball Squeeze",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Baire Category Theorem: Nested Ball Squeeze</h3><p>Construct sequence of nested closed balls: B_1 ⊃ B_2 ⊃ B_3 ⊃ ... with radii r_n → 0</p><button id=\"baireBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Intersect All Dense Opens</button><div id=\"baireOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('baireBtn').onclick=()=>{document.getElementById('baireOut').innerText='By completeness, ⋂ B_n = {x*} contains a unique point belonging to every dense open set U_n! Intersection is dense.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
