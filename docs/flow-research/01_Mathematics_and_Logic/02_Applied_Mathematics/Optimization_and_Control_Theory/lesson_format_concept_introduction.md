# Duofy Reusable Lesson Format: Optimization & Control Theory - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Convex Optimization, Karush-Kuhn-Tucker (KKT) conditions, Linear Time-Invariant (LTI) Control Systems $\dot{\mathbf{x}} = A \mathbf{x} + B \mathbf{u}$, Controllability, and Observability.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | KKT Conditions & LTI Control Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Convexity & Controllability Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | KKT Condition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Complementary Slackness Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Controllability Rank Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: KKT Conditions & LTI Control Systems**\n1. **KKT Necessary Conditions:** For $\\min f(x)$ s.t. $g_i(x) \\le 0, h_j(x) = 0$:\n$$\n\\nabla f(x^*) + \\sum \\lambda_i \\nabla g_i(x^*) + \\sum \\nu_j \\nabla h_j(x^*) = 0, \\quad \\lambda_i \\ge 0, \\quad \\lambda_i g_i(x^*) = 0\n$$\n2. **LTI Control System:** $\\dot{\\mathbf{x}} = A \\mathbf{x} + B \\mathbf{u}$. Controllable iff $\\operatorname{rank}(\\mathcal{C}) = n$ where $\\mathcal{C} = [B \\ AB \\ \\dots \\ A^{n-1}B]$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Convexity Guarantee:** In convex optimization, every local minimum is automatically a **GLOBAL minimum**.\n• **Primal vs Dual:** Dual problem bounds primal objective from below (Weak Duality). Zero duality gap holds under Slater's Condition.\n• **Controllability:** Ability to steer system state $\\mathbf{x}(t)$ from any initial state to any target state in finite time using control $\\mathbf{u}(t)$.\n• **Observability:** Ability to reconstruct initial state $\\mathbf{x}(0)$ from output observations $\\mathbf{y}(t) = C \\mathbf{x}(t)$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each KKT condition to its structural description.",
      "matchPairs": [
        { "left": "Stationarity Condition", "right": "∇f(x*) + ∑ λ_i ∇g_i(x*) + ∑ ν_j ∇h_j(x*) = 0" },
        { "left": "Complementary Slackness", "right": "λ_i * g_i(x*) = 0 for all inequality constraints" },
        { "left": "Dual Feasibility", "right": "λ_i ≥ 0 for inequality multipliers" },
        { "left": "Primal Feasibility", "right": "g_i(x*) ≤ 0 and h_j(x*) = 0" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In KKT conditions, complementary slackness requires that lambda_i * g_i(x*) equals ___ for all i.",
      "blankAnswer": "0",
      "blankDistractors": ["1", "infinity", "f(x*)"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the condition for an $n$-dimensional LTI system $\\dot{\\mathbf{x}} = A \\mathbf{x} + B \\mathbf{u}$ to be **controllable**?",
      "options": [
        { "text": "Controllability matrix C = [B AB A²B ... A^(n-1)B] has full rank n", "isCorrect": true, "explanation": "Correct! Kalman's Controllability Condition requires rank(C) = n." },
        { "text": "Matrix A is symmetric", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Eigenvalues of A are positive", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Matrix B is zero", "isCorrect": false, "explanation": "Incorrect: If B=0, control input has no effect." }
      ]
    }
  ]
}
```
