# Duofy Reusable Lesson Format: Differential Manifolds and Tensors - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Differential_Geometry / Differential_Manifolds_and_Tensors`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of differential form wedge products, exterior derivative degree shifts ($d: \Omega^k \to \Omega^{k+1}$), pullback commutativity ($d \Phi^* = \Phi^* d$), Lie bracket calculations, and interactive differential form simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cartan's Magic Formula Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Tensor Field Type & Input/Output Signature Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Closed vs Exact Differential Form Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Differential Space Dual Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Differential 2-Form Wedge Calculator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the difference between a 'closed' differential form and an 'exact' differential form?",
      "blankAnswer": "A form omega is closed if d(omega) = 0. A form omega is exact if omega = d(eta) for some form eta. Every exact form is closed (since d^2 = 0), but the converse depends on topology (de Rham cohomology)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each tensor field type to its input argument signature.",
      "matchPairs": [
        { "left": "(1, 0)-Tensor (Vector Field)", "right": "Takes 1 covector to produce a real number" },
        { "left": "(0, 1)-Tensor (1-Form / Covector)", "right": "Takes 1 vector to produce a real number" },
        { "left": "(0, 2)-Tensor (Riemannian Metric g)", "right": "Takes 2 vectors to produce an inner product scalar" },
        { "left": "(1, 3)-Tensor (Riemann Curvature R)", "right": "Takes 3 vectors and 1 covector to produce a scalar" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "On the punctured plane R^2 \\ {(0, 0)}, consider the angle 1-form omega = (-y dx + x dy) / (x^2 + y^2). Is omega closed and/or exact?",
      "options": [
        { "text": "omega is closed (d omega = 0) but NOT exact (oint_{S^1} omega = 2pi != 0)", "isCorrect": true, "explanation": "Correct! By Stokes' theorem, if omega were exact (omega = df), its integral around the closed circle S^1 would be 0, but it equals 2pi." },
        { "text": "omega is exact and therefore closed", "isCorrect": false, "explanation": "Incorrect: It is not exact on the punctured plane." },
        { "text": "omega is neither closed nor exact", "isCorrect": false, "explanation": "Incorrect: d omega = 0 everywhere on R^2 \\ {0}." },
        { "text": "omega is discontinuous", "isCorrect": false, "explanation": "Incorrect: omega is smooth on R^2 \\ {0}." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the name of the dual vector space T_p* M consisting of all linear functionals on the tangent space T_p M?",
      "blankAnswer": "cotangent"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Differential Form Wedge Operator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Wedge Product Simulator: α ∧ β</h3><p>Let α = 2 dx + 3 dy, and β = 4 dx + 5 dy:</p><button id=\"wedgeBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate α ∧ β</button><div id=\"wedgeOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('wedgeBtn').onclick=()=>{document.getElementById('wedgeOut').innerText='(2*5 - 3*4) dx ∧ dy = (10 - 12) dx ∧ dy = -2 dx ∧ dy!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
