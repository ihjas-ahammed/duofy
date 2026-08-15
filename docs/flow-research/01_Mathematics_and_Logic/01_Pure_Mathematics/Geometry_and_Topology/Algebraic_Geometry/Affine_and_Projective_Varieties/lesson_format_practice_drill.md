# Duofy Reusable Lesson Format: Affine and Projective Varieties - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Algebraic_Geometry / Affine_and_Projective_Varieties`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of projective varieties (Segre quadric, Veronese twisted cubic), Nullstellensatz radical relations ($\sqrt{I}$), Bézout intersection counting, Jacobian singularity tests, and interactive projective chart simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Projective Space Dimension Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Classical Variety & Defining Equation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Bézout Parallel Line Intersection Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Variety Coordinate Ring Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Projective Chart Explorer Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How is the n-dimensional projective space P^n defined as a quotient of affine space A^{n+1}?",
      "blankAnswer": "P^n = (A^{n+1} \\ {0}) / ~, where two non-zero vectors (x_0, ..., x_n) ~ (lambda x_0, ..., lambda x_n) are equivalent for any non-zero scalar lambda in k*."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each classical projective variety to its defining homogeneous equation(s).",
      "matchPairs": [
        { "left": "Segre Surface P^1 x P^1 in P^3", "right": "z_0 z_3 - z_1 z_2 = 0" },
        { "left": "Twisted Cubic Curve in P^3", "right": "z_0 z_2 - z_1^2 = 0, z_0 z_3 - z_1 z_2 = 0, z_1 z_3 - z_2^2 = 0" },
        { "left": "Fermat Cubic Curve in P^2", "right": "x^3 + y^3 + z^3 = 0" },
        { "left": "Projective Line in P^2", "right": "a x + b y + c z = 0" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In the projective plane P^2, where do two distinct affine parallel lines (e.g. y = 2x + 1 and y = 2x + 5) intersect?",
      "options": [
        { "text": "At a unique point at infinity [1 : 2 : 0] on the line at infinity z = 0", "isCorrect": true, "explanation": "Correct! Homogenizing gives -2x + y - z = 0 and -2x + y - 5z = 0. Subtracting gives 4z = 0 => z = 0, yielding y = 2x, so the intersection is [1:2:0]." },
        { "text": "They do not intersect anywhere in P^2", "isCorrect": false, "explanation": "Incorrect: In projective geometry, any two coplanar lines must intersect." },
        { "text": "At the origin [0 : 0 : 1]", "isCorrect": false, "explanation": "Incorrect: (0, 0) is an affine point where the lines do not meet." },
        { "text": "At infinitely many points", "isCorrect": false, "explanation": "Incorrect: Distinct lines intersect in exactly one point by Bézout's theorem (1 * 1 = 1)." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the name of the quotient ring k[x_1, ..., x_n] / I(V) representing all regular polynomial functions on an affine variety V?",
      "blankAnswer": "coordinate"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Projective Chart Inspector",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Projective Chart: P^2 = U_0 ∪ U_1 ∪ U_2</h3><p>Select a non-zero coordinate to dehomogenize [x : y : z]:</p><div style=\"display:flex; gap:10px; margin:15px 0;\"><button id=\"chartZ\" style=\"padding:8px 16px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Chart U_z (z ≠ 0)</button><button id=\"chartX\" style=\"padding:8px 16px; background:#334155; color:white; border:none; border-radius:6px; cursor:pointer;\">Chart U_x (x ≠ 0)</button></div><div id=\"chartOut\" style=\"color:#38bdf8; font-weight:bold;\">Chart U_z: Affine coordinates (u, v) = (x/z, y/z) covering standard A^2 plane!</div><script>document.getElementById('chartZ').onclick=()=>{document.getElementById('chartOut').innerText='Chart U_z (z != 0): Standard affine coordinates (x/z, y/z). Point at infinity is z = 0!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');}; document.getElementById('chartX').onclick=()=>{document.getElementById('chartOut').innerText='Chart U_x (x != 0): Affine coordinates (y/x, z/x). Reveals behavior at x-axis horizons!';};</script></div>"
    }
  ]
}
```
