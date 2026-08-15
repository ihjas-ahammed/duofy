# Duofy Reusable Lesson Format: Operator Algebras and Spectral Theory - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Functional_Analysis / Operator_Algebras_and_Spectral_Theory`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of operator spectrum types (point, continuous, residual), verification of the $C^*$-identity ($\|a^* a\| = \|a\|^2$), continuous functional calculus results ($|T| = \sqrt{T^* T}$), and interactive spectral decomposition widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Normal Operator Spectral Radius Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Operator Type & Involutive Identity Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Compact Operator Spectral Accumulation Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Polar Decomposition Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Spectral Decomposition Explorer Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "For a normal operator T (T* T = T T*) on a Hilbert space, how does the spectral radius r(T) relate to the operator norm ||T||?",
      "blankAnswer": "r(T) = ||T|| (the spectral radius equals the operator norm exactly)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each operator algebraic property to its mathematical definition.",
      "matchPairs": [
        { "left": "Normal Operator", "right": "T* T = T T*" },
        { "left": "Self-Adjoint (Hermitian)", "right": "T = T*" },
        { "left": "Unitary Operator", "right": "T* T = T T* = I (isometry and surjective)" },
        { "left": "C*-Identity", "right": "||a* a|| = ||a||^2" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the only possible accumulation point for the non-zero eigenvalues of a compact operator K on an infinite-dimensional Hilbert space?",
      "options": [
        { "text": "0 (zero is the only possible limit point of eigenvalues)", "isCorrect": true, "explanation": "Correct! By the Riesz-Schauder theorem, eigenvalues of a compact operator form a sequence converging to 0." },
        { "text": "1", "isCorrect": false, "explanation": "Incorrect: Eigenvalues must decay to 0." },
        { "text": "Infinity", "isCorrect": false, "explanation": "Incorrect: Compact operators are bounded, so eigenvalues cannot approach infinity." },
        { "text": "-1", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "In the polar decomposition T = U |T|, what type of operator is U (mapping (ker T)^perp isometrically to Range(T))?",
      "blankAnswer": "partial isometry"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Spectral Measure Integrator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Spectral Theorem: T = ∫ λ dE(λ)</h3><p>Compute f(T) for f(x) = x^2 with eigenvalues λ_1 = 2, λ_2 = -3:</p><button id=\"specBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Apply Functional Calculus f(T)</button><div id=\"specOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('specBtn').onclick=()=>{document.getElementById('specOut').innerText='Spectrum of f(T): σ(f(T)) = {2^2, (-3)^2} = {4, 9}! Verified by Spectral Mapping Theorem.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
