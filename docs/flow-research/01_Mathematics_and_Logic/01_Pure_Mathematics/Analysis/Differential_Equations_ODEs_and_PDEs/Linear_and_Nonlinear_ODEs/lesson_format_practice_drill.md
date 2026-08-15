# Duofy Reusable Lesson Format: Linear and Nonlinear ODEs - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Differential_Equations_ODEs_and_PDEs / Linear_and_Nonlinear_ODEs`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid trace-determinant fixed point classifications ($\tau, \Delta$), recognition of nullclines, verification of Lyapunov function time derivatives ($\dot{V} \le 0$), and interactive phase portrait vector field simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Trace-Determinant Diagram Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Trace/Determinant Value & Stability Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Nullcline Intersection Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Periodic Trajectory Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Nonlinear Phase Portrait Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What boundary curve in the trace-determinant plane separates real nodes from complex spirals/foci?",
      "blankAnswer": "The parabola (Tr J)^2 - 4 det(J) = 0 (repeated eigenvalue line)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each trace and determinant condition to its qualitative phase plane behavior.",
      "matchPairs": [
        { "left": "Tr(J) = -3, det(J) = 2", "right": "Stable Node (tau < 0, Delta > 0, tau^2 - 4Delta = 1 > 0)" },
        { "left": "Tr(J) = -2, det(J) = 5", "right": "Stable Spiral (tau < 0, Delta > 0, tau^2 - 4Delta = -16 < 0)" },
        { "left": "Tr(J) = 1, det(J) = -4", "right": "Saddle Point (Delta < 0)" },
        { "left": "Tr(J) = 0, det(J) = 9", "right": "Center (tau = 0, Delta > 0)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What occurs at any point in the phase plane where the x-nullcline f(x, y) = 0 and y-nullcline g(x, y) = 0 intersect?",
      "options": [
        { "text": "An equilibrium (fixed) point where dx/dt = 0 and dy/dt = 0 simultaneously", "isCorrect": true, "explanation": "Correct! Since both velocities are zero, the point is a stationary equilibrium." },
        { "text": "A limit cycle", "isCorrect": false, "explanation": "Incorrect: Limit cycles are closed curves, not isolated intersection points." },
        { "text": "A point of infinite velocity", "isCorrect": false, "explanation": "Incorrect: Velocity is exactly zero." },
        { "text": "A shock wave", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What mathematical term describes an isolated closed trajectory in a phase portrait to which adjacent paths spiral asymptotically?",
      "blankAnswer": "limit cycle"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Phase Plane Equilibrium Explorer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Phase Portrait: Stable Spiral vs Saddle</h3><p>Select a Jacobian signature:</p><div style=\"display:flex; gap:10px; margin:15px 0;\"><button id=\"btn1\" style=\"padding:8px 16px; background:#334155; color:white; border:none; border-radius:6px; cursor:pointer;\">Tr = -2, Det = +5</button><button id=\"btn2\" style=\"padding:8px 16px; background:#334155; color:white; border:none; border-radius:6px; cursor:pointer;\">Tr = 0, Det = -4</button></div><div id=\"resDisplay\" style=\"color:#38bdf8; font-weight:bold;\"></div><script>document.getElementById('btn1').onclick=()=>{document.getElementById('resDisplay').innerText='STABLE SPIRAL: Trajectories spiral inward to origin!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');}; document.getElementById('btn2').onclick=()=>{document.getElementById('resDisplay').innerText='SADDLE POINT: Trajectories approach along stable manifold, diverge along unstable manifold!';};</script></div>"
    }
  ]
}
```
