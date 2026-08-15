# Duofy Reusable Lesson Format: Cauchy-Riemann Equations - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis / Cauchy_Riemann_Equations`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid verification of Cauchy-Riemann conditions, recognition of standard harmonic conjugates (e.g. $e^x\cos y \leftrightarrow e^x\sin y$, $\ln(r) \leftrightarrow \theta$), Jacobian determinants, and interactive C-R verification tools.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Polar Form Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Real Part & Harmonic Conjugate Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Level Curve Orthogonality Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Differential Operator Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive C-R Partial Derivative Checker | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are the Cauchy-Riemann equations in polar coordinates (r, theta) for f(z) = u(r, theta) + i v(r, theta)?",
      "blankAnswer": "u_r = (1/r) v_theta and v_r = -(1/r) u_theta."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each real harmonic function u(x, y) to its harmonic conjugate v(x, y).",
      "matchPairs": [
        { "left": "u = x^2 - y^2 (Re(z^2))", "right": "v = 2xy" },
        { "left": "u = e^x cos(y) (Re(e^z))", "right": "v = e^x sin(y)" },
        { "left": "u = ln(sqrt(x^2 + y^2)) (Re(ln z))", "right": "v = arctan(y/x)" },
        { "left": "u = x^3 - 3xy^2 (Re(z^3))", "right": "v = 3x^2 y - y^3" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "If f(z) = u + iv is holomorphic with f'(z) != 0, what is the geometric relationship between the level curves u(x, y) = c_1 and v(x, y) = c_2?",
      "options": [
        { "text": "They intersect orthogonally everywhere (dot product of gradient vectors grad(u) . grad(v) = 0)", "isCorrect": true, "explanation": "Correct! grad(u) . grad(v) = u_x v_x + u_y v_y = u_x(-u_y) + u_y(u_x) = 0." },
        { "text": "They are parallel lines", "isCorrect": false, "explanation": "Incorrect: Level curves are perpendicular, not parallel." },
        { "text": "They are concentric circles", "isCorrect": false, "explanation": "Incorrect: Depends on the specific function." },
        { "text": "They never intersect", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What complex differential operator with respect to z_bar must evaluate to zero for any holomorphic function?",
      "blankAnswer": "wirtinger"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Cauchy-Riemann Equations Tester",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Test f(z) = z^2 = (x^2 - y^2) + i(2xy)</h3><p>Check: u_x = 2x, v_y = 2x, u_y = -2y, v_x = 2y</p><button id=\"crBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Verify C-R: u_x = v_y & u_y = -v_x</button><div id=\"crOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('crBtn').onclick=()=>{document.getElementById('crOut').innerText='u_x (2x) == v_y (2x) AND u_y (-2y) == -v_x (-2y)! Satisfied everywhere in C.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
