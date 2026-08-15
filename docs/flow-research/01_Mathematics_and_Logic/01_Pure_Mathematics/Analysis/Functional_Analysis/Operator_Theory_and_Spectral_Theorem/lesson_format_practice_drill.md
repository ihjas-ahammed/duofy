# Duofy Reusable Lesson Format: Operator Theory and Spectral Theorem - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Functional_Analysis / Operator_Theory_and_Spectral_Theorem`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of spectrum subdivisions (point, continuous, residual), compact operator spectral properties ($\lambda_n \to 0$), functional calculus algebra isomorphisms, and interactive spectrum visualizer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Resolvent Operator Definition Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Operator Family & Spectral Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Compact Operator Non-Zero Eigenvalue Finite Multiplicity Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Spectral Radius Symbol Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Operator Spectrum and Resolvent Visualizer Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Resolvent Operator R(lambda, T) of a bounded operator T, and on what set is it holomorphic?",
      "blankAnswer": "R(lambda, T) = (T - lambda I)^{-1}. It is an analytic operator-valued function on the open resolvent set rho(T) = C \\ sigma(T)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each spectrum classification component to its operator-theoretic behavior.",
      "matchPairs": [
        { "left": "Point Spectrum sigma_p(T)", "right": "T - lambda I is NOT injective (ker != {0}, non-zero eigenvectors exist)" },
        { "left": "Continuous Spectrum sigma_c(T)", "right": "T - lambda I is injective with dense range Ran(T - lambda I), but inverse is unbounded" },
        { "left": "Residual Spectrum sigma_r(T)", "right": "T - lambda I is injective, but its range Ran(T - lambda I) is NOT dense in H" },
        { "left": "Resolvent Set rho(T)", "right": "T - lambda I is a bijection with a bounded inverse in B(H)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "For any compact operator T in K(H), what is guaranteed about the eigenspace E_lambda for any NON-ZERO eigenvalue lambda != 0?",
      "options": [
        { "text": "dim(E_lambda) is strictly finite (each non-zero eigenvalue has finite geometric multiplicity)", "isCorrect": true, "explanation": "Correct! If dim(E_lambda) were infinite, the unit ball in E_lambda would contain an infinite orthonormal sequence with no convergent subsequence, violating compactness of T." },
        { "text": "dim(E_lambda) is infinite", "isCorrect": false, "explanation": "Incorrect: Only lambda = 0 can have infinite multiplicity for compact operators." },
        { "text": "E_lambda = {0}", "isCorrect": false, "explanation": "Incorrect: Eigenvectors must be non-zero." },
        { "text": "dim(E_lambda) = 1 always", "isCorrect": false, "explanation": "Incorrect: Multiplicities can be any finite integer k." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What Latin-derived word describes the radius r(T) = sup {|lambda| : lambda in sigma(T)} bounding the spectrum of an operator?",
      "blankAnswer": "spectral"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Hilbert Space Spectrum Visualizer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Spectral Measure Decomposer</h3><p>Self-Adjoint Operator T with spectrum σ(T) = [0, 4]</p><button id=\"specBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Apply Projection E([0, 2])</button><div id=\"specOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('specBtn').onclick=()=>{document.getElementById('specOut').innerText='Spectral projection E([0, 2]) applied! Subspace isolated for frequencies λ ≤ 2.0 with norm ||E|| = 1.0.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
