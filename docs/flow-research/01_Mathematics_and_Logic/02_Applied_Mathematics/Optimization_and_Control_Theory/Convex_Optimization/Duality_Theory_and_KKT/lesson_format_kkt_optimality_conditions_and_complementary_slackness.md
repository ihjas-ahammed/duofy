# Duofy Reusable Lesson Format: Karush-Kuhn-Tucker (KKT) Optimality and Complementary Slackness

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Convex_Optimization / Duality_Theory_and_KKT`  
**Lesson Format Type:** `kkt_optimality_conditions_and_complementary_slackness`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly evaluate the **4 Karush-Kuhn-Tucker (KKT) Conditions** (Primal Feasibility, Dual Feasibility, Complementary Slackness, Stationarity), prove why they are necessary and sufficient for convex programs with zero duality gap, and solve constrained optimization problems analytically.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The 4 KKT Conditions Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Complementary Slackness Logic Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | KKT Condition & Mathematical Expression Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Inactive Constraint Multiplier Value Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Non-Convex KKT Sufficiency Limitation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the KKT Theorem: For a convex optimization problem $\min f_0(x)$ s.t. $f_i(x) \le 0, h_i(x) = 0$ with differentiable functions and Slater's condition, a primal-dual pair $(x^*, \lambda^*, \nu^*)$ is optimal with zero duality gap if and only if it satisfies the 4 KKT conditions: (1) Primal Feasibility: $f_i(x^*) \le 0, h_i(x^*) = 0$, (2) Dual Feasibility: $\lambda_i^* \ge 0$, (3) Complementary Slackness: $\lambda_i^* f_i(x^*) = 0 \forall i$, (4) Stationarity: $\nabla f_0(x^*) + \sum \lambda_i^* \nabla f_i(x^*) + \sum \nu_i^* \nabla h_i(x^*) = 0$.
2. **Slide 2 (`concept_pieces`):** Deconstruct Complementary Slackness $\lambda_i^* f_i(x^*) = 0$: (1) since $\lambda_i^* \ge 0$ and $f_i(x^*) \le 0$, the product $\lambda_i^* f_i(x^*)$ is non-positive; for the sum to be zero, every individual term must be zero, (2) Case A (Inactive Constraint): if $f_i(x^*) < 0$ (interior of feasible region), then $\lambda_i^* = 0$ (constraint exerts zero shadow force on optimal point), (3) Case B (Active Constraint): if $\lambda_i^* > 0$, the boundary is pushed against and $f_i(x^*) = 0$, (4) geometric force balance: objective gradient $-\nabla f_0(x^*)$ is a positive linear combination of active inward constraint normals $\nabla f_i(x^*)$.
3. **Slide 3 (`matching`):** Pair the 4 KKT conditions (Primal Feasibility, Dual Feasibility, Complementary Slackness, Stationarity) with their exact vector equations.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that if an inequality constraint is strictly inactive ($f_i(x^*) < 0$), its optimal Lagrange multiplier is exactly zero. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the necessity vs sufficiency of KKT: When are the KKT conditions BOTH necessary AND sufficient for global optimality? (When the problem is convex, objectives and inequality constraints are convex, equality constraints are affine, and Slater's constraint qualification holds; for non-convex problems, KKT points are merely stationary points and may be local maxima or saddle points).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "kkt_optimality_conditions_and_complementary_slackness",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Karush-Kuhn-Tucker (KKT) Optimality Conditions**\nFor a convex optimization problem with differentiable $f_0, \\dots, f_m$ and affine $A\\mathbf{x} = \\mathbf{b}$ satisfying Slater's condition, a point $(\\mathbf{x}^*, \\mathbf{\\lambda}^*, \\mathbf{\\nu}^*)$ is **globally optimal** $\\iff$ it satisfies the **4 KKT Conditions**:\n1. **Primal Feasibility:** $f_i(\\mathbf{x}^*) \\le 0 \\; (i=1,\\dots,m), \\quad A\\mathbf{x}^* = \\mathbf{b}$\n2. **Dual Feasibility:** $\\lambda_i^* \\ge 0 \\; (i=1,\\dots,m)$\n3. **Complementary Slackness:** $\\lambda_i^* f_i(\\mathbf{x}^*) = 0 \\; (i=1,\\dots,m)$\n4. **Stationarity (Gradient of Lagrangian vanishes):**\n$$\n\\nabla f_0(\\mathbf{x}^*) + \\sum_{i=1}^m \\lambda_i^* \\nabla f_i(\\mathbf{x}^*) + A^T \\mathbf{\\nu}^* = \\mathbf{0}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Complementary Slackness Logic:** $\\lambda_i^* f_i(\\mathbf{x}^*) = 0$ for each $i = 1, \\dots, m$.\n• **Scenario 1 (Inactive Constraint):** If $f_i(\\mathbf{x}^*) < 0$ (the optimum lies safely inside the constraint interior), then $\\lambda_i^* = 0$ (zero shadow price; the constraint can be removed without changing the optimum).\n• **Scenario 2 (Active Constraint):** If $\\lambda_i^* > 0$ (the objective is actively pushing against the boundary wall), then $f_i(\\mathbf{x}^*) = 0$ strictly.\n• **Geometric Force Balance:** The negative objective gradient $-\\nabla f_0(\\mathbf{x}^*)$ is trapped inside the normal cone generated by active constraint outward normals $\\nabla f_i(\\mathbf{x}^*)$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each KKT condition to its exact mathematical equation.",
      "matchPairs": [
        { "left": "Primal Feasibility", "right": "f_i(x*) <= 0 for all i, and A x* = b" },
        { "left": "Dual Feasibility", "right": "lambda_i* >= 0 for all inequality multipliers" },
        { "left": "Complementary Slackness", "right": "lambda_i* * f_i(x*) = 0 for all i = 1, ..., m" },
        { "left": "Stationarity", "right": "grad f_0(x*) + sum lambda_i* grad f_i(x*) + A^T nu* = 0" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In complementary slackness, if an inequality constraint is strictly inactive at the optimal point (f_i(x*) < 0), its corresponding Lagrange multiplier lambda_i* must evaluate to ___.",
      "blankAnswer": "zero",
      "blankDistractors": ["one", "infinity", "negative"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "For general NON-CONVEX optimization problems, what is the exact status of a point x* that satisfies all 4 KKT conditions?",
      "options": [
        { "text": "KKT conditions are only NECESSARY for local optimality (under constraint qualifications); a KKT point may be a local minimum, a local maximum, or a saddle point", "isCorrect": true, "explanation": "Correct! In non-convex optimization, KKT points are first-order stationary points. Convexity is required to promote KKT stationarity to global optimality." },
        { "text": "KKT points are always strict global minima for all functions", "isCorrect": false, "explanation": "Incorrect: Only true for convex problems." },
        { "text": "KKT conditions never apply to non-convex problems", "isCorrect": false, "explanation": "Incorrect: They are the standard first-order necessary conditions." },
        { "text": "KKT points have undefined gradients", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
