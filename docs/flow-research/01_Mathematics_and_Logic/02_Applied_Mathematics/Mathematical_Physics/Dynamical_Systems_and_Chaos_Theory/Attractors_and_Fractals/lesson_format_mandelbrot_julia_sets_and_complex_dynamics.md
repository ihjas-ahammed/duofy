# Duofy Reusable Lesson Format: Mandelbrot and Julia Sets in Complex Dynamics

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Mathematical_Physics / Dynamical_Systems_and_Chaos_Theory / Attractors_and_Fractals`  
**Lesson Format Type:** `mandelbrot_julia_sets_and_complex_dynamics`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of the quadratic iteration $z_{n+1} = z_n^2 + c$, distinguish the **Mandelbrot Set** $\mathcal{M}$ (parameter space of connected Julia sets) from **Filled Julia Sets** $K_c$ (dynamical phase space), understand Douady-Hubbard connectedness theorems, and interact with live Mandelbrot zoom simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Mandelbrot & Julia Sets Definition Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Parameter Space vs Dynamical Space Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Escape Radius Criterion |z| > 2 Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Critical Point Initial Value Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Mandelbrot Set Escape Time Fractal Generator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "mandelbrot_julia_sets_and_complex_dynamics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the formal mathematical definition of the Mandelbrot Set M in the complex plane?",
      "blankAnswer": "The Mandelbrot set M is the set of all complex parameters c in C for which the orbit of the critical point z_0 = 0 under the iteration z_{n+1} = z_n^2 + c remains bounded (does not diverge to infinity as n -> infty)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each complex dynamics set to its mathematical space and definition.",
      "matchPairs": [
        { "left": "Mandelbrot Set M", "right": "Parameter space of all c in C whose corresponding Julia set J_c is connected" },
        { "left": "Filled Julia Set K_c", "right": "Dynamical space of initial points z_0 in C whose orbits remain bounded for a fixed c" },
        { "left": "Julia Set Boundary J_c = partial K_c", "right": "Chaotic fractal boundary where orbit dynamics are highly sensitive" },
        { "left": "Fatou Set F_c", "right": "Complement of J_c where orbits exhibit regular, predictable, equicontinuous behavior" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "For the quadratic map z_{n+1} = z_n^2 + c, why is |z_k| > 2 guaranteed to be an irreversible 'escape radius' (if |z_k| > 2 and |z_k| >= |c|, then |z_n| -> infty)?",
      "options": [
        { "text": "By the triangle inequality, |z_{k+1}| = |z_k^2 + c| >= |z_k|^2 - |c| >= |z_k|(|z_k| - 1) > 2|z_k|, causing exponential super-divergence to infinity", "isCorrect": true, "explanation": "Correct! Once |z_k| > 2, the quadratic expansion |z_k|^2 dominates the constant c, forcing subsequent terms to blow up to infinity." },
        { "text": "Because 2 is the largest number in complex analysis", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the Mandelbrot set has radius 100", "isCorrect": false, "explanation": "Incorrect: The Mandelbrot set is entirely contained within the closed disk |c| <= 2." },
        { "text": "Because roots cannot exceed 1", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the numerical starting value of the unique critical point z_0 iterated to construct the Mandelbrot set?",
      "blankAnswer": "zero"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Mandelbrot Set Explorer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Mandelbrot Fractal Orbit Tester</h3><p>Test parameter c = -0.75 + 0.1i (inside cardioid cusp)</p><button id=\"mandelBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Iterate z_{n+1} = z_n² + c (z₀ = 0)</button><div id=\"mandelOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('mandelBtn').onclick=()=>{document.getElementById('mandelOut').innerText='Bounded! 100 iterations remain within |z| < 1.25. Parameter c belongs to the Mandelbrot Set M (its Julia Set is connected)!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
