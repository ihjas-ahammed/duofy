# Duofy Reusable Lesson Format: Two-Phase Simplex and Big-M Initialization

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Linear_and_Nonlinear_Programming / Simplex_Method`  
**Lesson Format Type:** `two_phase_simplex_and_big_m_initialization`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Initial BFS Construction** for standard form Linear Programs lacking a trivial basis, compare the **Two-Phase Simplex Method** (Phase-I auxiliary problem $\min \sum a_i$) vs the **Big-M Method** ($\min \mathbf{c}^T\mathbf{x} + M \sum a_i$), detect problem **Infeasibility**, and interact with live Phase-I/Phase-II transition simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Two-Phase Simplex & Auxiliary Problem Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Variable Type & Mathematical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Phase-I Infeasibility Termination Criterion Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Artificial Variable Optimal Value Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Two-Phase Simplex Solver Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "two_phase_simplex_and_big_m_initialization",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the purpose of Phase-I in the Two-Phase Simplex Method, and how is the Phase-I auxiliary problem formulated?",
      "blankAnswer": "Phase-I finds an initial Basic Feasible Solution (BFS) for standard form LPs Ax = b (b >= 0) that lack an identity basis. It introduces artificial variables a >= 0 and solves: min sum_{i=1}^m a_i subject to Ax + a = b, x >= 0, a >= 0. The starting BFS is x = 0, a = b. If the optimal cost of Phase-I is 0, all artificial variables are eliminated, yielding a valid BFS for the original problem (Phase-II). If min > 0, the LP is INFEASIBLE."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each variable type in linear programming to its definition and purpose.",
      "matchPairs": [
        { "left": "Slack Variable (+s_i >= 0)", "right": "Converts less-than-or-equal inequality sum a_ij x_j <= b_i into equality" },
        { "left": "Surplus Variable (-e_i >= 0)", "right": "Converts greater-than-or-equal inequality sum a_ij x_j >= b_i into equality" },
        { "left": "Artificial Variable (+a_i >= 0)", "right": "Provides a temporary identity basis column for Phase-I; penalized out of solution" },
        { "left": "Free / Unrestricted Variable x_k", "right": "Decomposed into difference of two non-negative variables x_k^+ - x_k^-" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "At the conclusion of Phase-I of the Simplex method, the optimal objective value is found to be w* = 0.042 > 0. What does this definitively prove about the original linear program?",
      "options": [
        { "text": "The original linear program is INFEASIBLE: no point x >= 0 exists that satisfies the constraints Ax = b", "isCorrect": true, "explanation": "Correct! Since artificial variables measure constraint violation distance, min sum a_i > 0 proves that there is no feasible vector x >= 0 with zero artificial violation." },
        { "text": "The problem has infinite solutions", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The problem is unbounded", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Phase-II should proceed normally", "isCorrect": false, "explanation": "Incorrect: Phase-II cannot start without a feasible BFS." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the numerical optimal objective value of the Phase-I auxiliary problem required for the original LP to be feasible?",
      "blankAnswer": "zero"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Two-Phase Simplex Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Two-Phase Simplex Initialization</h3><p>Constraints: 2x₁ + x₂ ≥ 6, x₁ + 2x₂ ≥ 6 (x₁, x₂ ≥ 0)</p><button id=\"phaseBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Run Phase-I Simplex</button><div id=\"phaseOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('phaseBtn').onclick=()=>{document.getElementById('phaseOut').innerText='Phase-I complete! Artificial variables a₁ = 0, a₂ = 0 (Cost w* = 0.00). Initial BFS found: (x₁=2, x₂=2). Transitioning to Phase-II for objective minimization!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
