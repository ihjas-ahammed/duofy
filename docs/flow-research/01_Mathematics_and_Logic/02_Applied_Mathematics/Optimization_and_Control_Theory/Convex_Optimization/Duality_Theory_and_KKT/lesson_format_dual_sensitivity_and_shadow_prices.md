# Duofy Reusable Lesson Format: Dual Sensitivity Analysis and Shadow Prices

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Convex_Optimization / Duality_Theory_and_KKT`  
**Lesson Format Type:** `dual_sensitivity_and_shadow_prices`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Dual Sensitivity Analysis** and **Shadow Prices** ($\lambda_i^* = -\frac{\partial p^*}{\partial u_i}$), evaluate the **Perturbation Function** $p^*(u, v)$, understand the global lower bound inequality $p^*(u, v) \ge p^*(0, 0) - (\lambda^*)^T u - (\nu^*)^T v$, and interact with live resource budget relaxation simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Perturbed Problem & Shadow Price Definition Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Perturbation Parameter & Economic Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Constraint Tightening Objective Impact Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Shadow Price Partial Derivative Sign Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Resource Shadow Price Sensitivity Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "dual_sensitivity_and_shadow_prices",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the economic and mathematical interpretation of the optimal Lagrange multiplier lambda_i* as a 'shadow price'?",
      "blankAnswer": "lambda_i* represents the marginal rate of change (shadow price) of the optimal objective value p* with respect to perturbing constraint i: lambda_i* = - partial p*(u, v) / partial u_i evaluated at u=0. Relaxing constraint i by delta u_i > 0 decreases optimal cost by approximately lambda_i* * delta u_i."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each sensitivity concept to its mathematical inequality or definition.",
      "matchPairs": [
        { "left": "Global Perturbation Lower Bound", "right": "p*(u, v) >= p*(0, 0) - (lambda*)^T u - (nu*)^T v for all perturbations (u, v)" },
        { "left": "Constraint Relaxation (u_i > 0)", "right": "Feasible set expands => optimal cost p*(u) <= p*(0) (non-increasing)" },
        { "left": "Constraint Tightening (u_i < 0)", "right": "Feasible set shrinks => optimal cost p*(u) >= p*(0) (cost increases by at least lambda_i* |u_i|)" },
        { "left": "Zero Shadow Price (lambda_i* = 0)", "right": "Small perturbations of constraint i produce zero first-order change in optimal cost" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "If a factory optimization problem has an optimal Lagrange multiplier lambda_1* = 45 $/kg on a raw material constraint Ax <= b_1, what is the maximum price per kilogram the factory should be willing to pay to buy an additional small amount Delta b_1 of raw material?",
      "options": [
        { "text": "Up to $45/kg (since purchasing 1 additional kg increases profit or decreases minimum cost by exactly $45)", "isCorrect": true, "explanation": "Correct! The shadow price lambda_1* = $45/kg represents the marginal value of the resource; any purchase price below $45/kg creates net profit." },
        { "text": "$0/kg", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Infinite dollars", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "$1/kg only", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the two-word economic term for the optimal dual multiplier lambda* that measures the marginal value of relaxing a resource constraint?",
      "blankAnswer": "shadow-price"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Resource Sensitivity Analyzer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Dual Sensitivity: Perturbing u₁</h3><p>Base Cost p*(0) = $1,200 | Shadow Price λ₁* = $35/unit</p><button id=\"sensBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Relax Constraint by Δu₁ = +10 units</button><div id=\"sensOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('sensBtn').onclick=()=>{document.getElementById('sensOut').innerText='Predicted New Cost: $1,200 - ($35 × 10) = $850. Global lower bound strictly satisfied: p*(10) ≥ $850!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
