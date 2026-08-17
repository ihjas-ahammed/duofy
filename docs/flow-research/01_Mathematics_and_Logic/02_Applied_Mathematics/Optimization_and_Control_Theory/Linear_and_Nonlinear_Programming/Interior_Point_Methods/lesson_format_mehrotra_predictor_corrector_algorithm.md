# Duofy Reusable Lesson Format: Mehrotra's Predictor-Corrector Algorithm

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Linear_and_Nonlinear_Programming / Interior_Point_Methods`  
**Lesson Format Type:** `mehrotra_predictor_corrector_algorithm`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Mehrotra's Predictor-Corrector Algorithm (1992)**, analyze the 3-step sequence (Affine-Scaling Predictor $\Delta^{\text{aff}}$, Adaptive Centering $\sigma = (\hat{\eta}_{\text{aff}} / \hat{\eta})^3$, Combined Centering-Corrector $\Delta^{\text{cc}}$), understand matrix factorization sharing, and interact with live IPM convergence trajectory simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Mehrotra Predictor-Corrector Strategy Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Algorithmic Step & Computational Purpose Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Shared Matrix Factorization Efficiency Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Centering Parameter Exponent Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Mehrotra Predictor-Corrector Step Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "mehrotra_predictor_corrector_algorithm",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "Why is Sanjay Mehrotra's Predictor-Corrector algorithm (1992) the undisputed industry gold standard for solving Linear, Quadratic, and Semidefinite Programs?",
      "blankAnswer": "It drastically accelerates interior-point convergence by using a pure affine-scaling 'predictor' step to test how far the iterates can move toward the boundary, using the result to adaptively compute a centering parameter sigma = (eta_aff / eta)^3, and solving a second-order 'corrector' step that cancels non-linear cross-terms Delta x_i Delta s_i. Crucially, BOTH steps use the EXACT SAME matrix factorization (Cholesky/LDL^T), adding almost zero computational cost for a massive speedup!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each phase of Mehrotra's algorithm to its mathematical operation.",
      "matchPairs": [
        { "left": "Step 1: Affine Predictor Step", "right": "Solves KKT Newton system with sigma = 0 to probe maximum step sizes alpha_pri, alpha_dual" },
        { "left": "Step 2: Adaptive Centering Parameter", "right": "Computes sigma = (eta_aff / eta)^3 where eta_aff is the predicted duality gap" },
        { "left": "Step 3: Corrector RHS Adjustment", "right": "Adds non-linear term -Delta X_aff Delta S_aff e + sigma mu e to the centering RHS" },
        { "left": "Step 4: Primal-Dual Update", "right": "Advances (x, s, lambda) by fraction (e.g. 0.995) of max allowable distance to boundary" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the computational cost of the Corrector step in Mehrotra's algorithm virtually negligible compared to the Predictor step?",
      "options": [
        { "text": "The KKT coefficient matrix is IDENTICAL for both steps; the expensive Cholesky/LDL^T factorization is performed only once, and the corrector requires only a cheap triangular back-solve", "isCorrect": true, "explanation": "Correct! The matrix factorization represents ~90% of the computation in each iteration. Reusing the exact same factorization for the corrector step yields second-order accuracy at almost zero extra cost." },
        { "text": "Because the corrector step does not use matrices", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the corrector step is skipped in every iteration", "isCorrect": false, "explanation": "Incorrect: It is evaluated in every iteration." },
        { "text": "Because linear programs have no dual variables", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "In Mehrotra's adaptive centering formula sigma = (eta_aff / eta)^p, what integer exponent p is standardly used across all modern commercial solvers?",
      "blankAnswer": "three"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Mehrotra Predictor-Corrector Solver",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Mehrotra Predictor-Corrector Step</h3><p>Current Duality Gap: η = 1.000 | Predictor Step: η_aff = 0.200</p><button id=\"mehrotraBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Compute Adaptive σ and Corrector</button><div id=\"mehrotraOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('mehrotraBtn').onclick=()=>{document.getElementById('mehrotraOut').innerText='Centering parameter σ = (0.200/1.000)³ = 0.008 (heavy progress towards boundary!). Corrector applied with zero refactorizations. New gap η_new = 0.038!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
