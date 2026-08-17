# Duofy Reusable Lesson Format: Center Manifold Reduction and Dimensionality Collapse

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Mathematical_Physics / Dynamical_Systems_and_Chaos_Theory / Bifurcation_Theory`  
**Lesson Format Type:** `center_manifold_reduction_and_stability`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Center Manifold Theory** (Jack Carr, 1981), separate fast exponentially stable modes ($E^s, \operatorname{Re}(\lambda) < 0$) from slow critical center modes ($E^c, \operatorname{Re}(\lambda) = 0$), compute polynomial approximations $y = h(x) = a x^2 + b x^3 + \dots$, and interact with live 2D-to-1D dimension reduction simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Center Manifold Theorem Definition Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Eigenspace Subspace & Stability Invariance Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Fast-Slow Variable Adiabatic Elimination Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Critical Eigenvalue Real Part Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Center Manifold Dimension Reducer Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "center_manifold_reduction_and_stability",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What does the Center Manifold Theorem (Carr, 1981) state regarding the stability and bifurcations of a high-dimensional system near a non-hyperbolic equilibrium?",
      "blankAnswer": "Near a fixed point with center eigenvalues (Re(lambda) = 0) and stable eigenvalues (Re(lambda) < 0), there exists an invariant local Center Manifold W^c tangent to the center eigenspace. The stable fast variables decay exponentially, so the long-term asymptotic behavior and stability of the full system are strictly governed by the reduced dynamics on the low-dimensional center manifold."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each linear invariant subspace to its eigenvalue spectrum and geometric role.",
      "matchPairs": [
        { "left": "Center Subspace E^c", "right": "Eigenvalues with Re(lambda) = 0 (slow critical modes governing bifurcations)" },
        { "left": "Stable Subspace E^s", "right": "Eigenvalues with Re(lambda) < 0 (fast decaying modes that collapse onto W^c)" },
        { "left": "Unstable Subspace E^u", "right": "Eigenvalues with Re(lambda) > 0 (exponentially expanding departures)" },
        { "left": "Center Manifold Graph y = h(x)", "right": "Invariant manifold satisfying h(0) = 0, Dh(0) = 0 and the invariance PDE" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "For the 2D system x_dot = x y, y_dot = -y - x^2, how does center manifold theory approximate the stable variable y in terms of the center variable x?",
      "options": [
        { "text": "y = h(x) = -x^2 + O(x^4), yielding the reduced 1D center equation x_dot = x(-x^2) = -x^3 (proving asymptotic stability)", "isCorrect": true, "explanation": "Correct! Setting Dh(x) x_dot = y_dot gives (2ax) (x(-ax^2)) = -(ax^2) - x^2 => 0 = -ax^2 - x^2 => a = -1. Thus y approx -x^2 and x_dot = -x^3 (stable cubic sink)." },
        { "text": "y = x", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "y = e^{-t}", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "y is undefined", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the numerical real value of the eigenvalues corresponding to the critical center eigenspace E^c?",
      "blankAnswer": "zero"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Center Manifold Dimension Reducer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Center Manifold: 2D → 1D Collapse</h3><p>System: ẋ = xy, ẏ = -y - x² | Invariant Manifold: y = -x²</p><button id=\"centerBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Collapse Fast Stable Variable y</button><div id=\"centerOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('centerBtn').onclick=()=>{document.getElementById('centerOut').innerText='Fast variable y(t) collapses to y = -x² exponentially fast (e^{-t}). Reduced 1D dynamics: ẋ = -x³ smoothly pulls all trajectories to the origin!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
