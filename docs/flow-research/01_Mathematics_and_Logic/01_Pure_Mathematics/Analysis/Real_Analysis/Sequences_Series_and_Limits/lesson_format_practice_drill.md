# Duofy Reusable Lesson Format: Sequences, Series, and Limits - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Real_Analysis / Sequences_Series_and_Limits`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of series test selections (Ratio, Root, Integral, Alternating, Weierstrass M), Cauchy completeness checks, supremum error calculations, and interactive $\epsilon$-$N$ convergence simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Weierstrass M-Test Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Function Sequence & Uniform Convergence Domain Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Abel vs Dirichlet Test Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Subsequence Theorem Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive $\epsilon$-$N$ Epsilon Tube Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "State the Weierstrass M-Test for the uniform convergence of an infinite series of functions sum_{n=1}^infty f_n(x).",
      "blankAnswer": "If |f_n(x)| <= M_n for all x in E and the numerical series sum M_n converges, then sum f_n(x) converges uniformly and absolutely on E."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each function sequence to its uniform convergence status on the given domain.",
      "matchPairs": [
        { "left": "f_n(x) = x^n on [0, 0.9]", "right": "Converges uniformly to 0 (M_n = 0.9^n -> 0)" },
        { "left": "f_n(x) = x^n on [0, 1]", "right": "Pointwise convergence only (Limit discontinuous at 1)" },
        { "left": "f_n(x) = sin(nx) / n on R", "right": "Converges uniformly to 0 (M_n = 1/n -> 0)" },
        { "left": "f_n(x) = 1 / (1 + n x) on (0, 1)", "right": "Pointwise convergence to 0, but NOT uniform" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the primary condition required by Dirichlet's Test for the convergence of a series sum a_n b_n?",
      "options": [
        { "text": "The partial sums of a_n are bounded, and b_n is a monotonically decreasing sequence converging to 0", "isCorrect": true, "explanation": "Correct! Dirichlet's test requires |sum_{k=1}^N a_k| <= M and b_n downarrow 0." },
        { "text": "Both series sum a_n and sum b_n must converge absolutely", "isCorrect": false, "explanation": "Incorrect: Dirichlet's test is specifically designed for conditionally convergent series." },
        { "text": "a_n must be positive", "isCorrect": false, "explanation": "Incorrect: a_n often oscillates (like (-1)^n or e^{inx})." },
        { "text": "b_n must diverge", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "Whose hyphenated theorem states that every bounded sequence in real Euclidean space has a convergent subsequence?",
      "blankAnswer": "bolzano-weierstrass"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Epsilon-N Sequence Convergence Explorer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Sequence: a_n = 1/n -> 0</h3><p>Given Target ε = 0.05, find minimum N such that |1/n - 0| &lt; 0.05 for all n &gt; N:</p><button id=\"epsBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate N(ε)</button><div id=\"epsOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('epsBtn').onclick=()=>{document.getElementById('epsOut').innerText='N = ceil(1 / 0.05) = 20! For all n > 20, 1/n < 0.05. Convergence verified!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
