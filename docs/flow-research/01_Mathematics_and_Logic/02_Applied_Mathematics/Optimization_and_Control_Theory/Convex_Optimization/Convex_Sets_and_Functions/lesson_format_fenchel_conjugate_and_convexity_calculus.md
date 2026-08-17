# Duofy Reusable Lesson Format: Fenchel Conjugate and Convexity-Preserving Calculus

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Convex_Optimization / Convex_Sets_and_Functions`  
**Lesson Format Type:** `fenchel_conjugate_and_convexity_calculus`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of the **Fenchel Conjugate (Legendre-Fenchel Transform)** $f^*(y) = \sup_{x \in \operatorname{dom} f} (y^T x - f(x))$, establish the **Fenchel-Young Inequality** $f(x) + f^*(y) \ge x^T y$, evaluate **Convexity-Preserving Operations** (pointwise supremum, affine composition, perspective functions), and interact with live Fenchel conjugate slope-envelope simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fenchel Conjugate & Fenchel-Young Inequality Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Primal Function & Fenchel Dual Conjugate Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Perspective Function Convexity Preservation Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Biconjugate Equality Condition Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Fenchel Conjugate Legendre Transform Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "fenchel_conjugate_and_convexity_calculus",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the definition of the Fenchel Conjugate function f*(y) of a function f: R^n -> R, and what fundamental inequality does it satisfy?",
      "blankAnswer": "f*(y) = sup_{x in dom f} (y^T x - f(x)). The conjugate f* is ALWAYS convex (as the pointwise supremum of affine functions in y), even if f is non-convex. It satisfies the Fenchel-Young Inequality: f(x) + f*(y) >= y^T x for all x, y, with equality if and only if y is a subgradient of f at x (y in partial f(x))."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each primal convex function f(x) to its exact Fenchel conjugate f*(y).",
      "matchPairs": [
        { "left": "Quadratic f(x) = (1/2) x^T Q x (Q succ 0)", "right": "f*(y) = (1/2) y^T Q^{-1} y" },
        { "left": "Negative Logarithm f(x) = -log(x) on x > 0", "right": "f*(y) = -1 - log(-y) on y < 0" },
        { "left": "Exponential f(x) = e^x", "right": "f*(y) = y log(y) - y on y > 0 (f*(0) = 0)" },
        { "left": "Indicator Function I_C(x) of Convex Set C", "right": "Support function S_C(y) = sup_{x in C} y^T x" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Given a convex function f: R^n -> R, what is the perspective function g: R^n x R_{++} -> R, and is g guaranteed to be convex?",
      "options": [
        { "text": "g(x, t) = t * f(x / t) for t > 0, and g is GUARANTEED to be convex on its domain", "isCorrect": true, "explanation": "Correct! The perspective operation scales the epigraph of f by a cone transformation, preserving convexity. For example, f(x) = x^T x gives g(x, t) = x^T x / t (matrix fractional / quadratic over linear)." },
        { "text": "g(x, t) = f(x) / t, and g is concave", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "g(x, t) = f(x * t), and g is never convex", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Perspective transformations destroy convexity", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "By the Fenchel-Moreau theorem, the biconjugate f**(x) equals f(x) if and only if f is closed, proper, and ___.",
      "blankAnswer": "convex"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Fenchel Conjugate Transform Calculator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Fenchel Conjugate: f(x) = ½ x²</h3><p>Compute f*(y) = sup_x (y x - ½ x²)</p><button id=\"fenchelBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Evaluate Supremum at y = 4.0</button><div id=\"fenchelOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('fenchelBtn').onclick=()=>{document.getElementById('fenchelOut').innerText='Maximizer x* = y = 4.0. Conjugate value f*(4.0) = 4.0(4.0) - ½(4.0)² = 16 - 8 = 8.0 = ½ y²! Self-conjugate!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
