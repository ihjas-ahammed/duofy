# Duofy Reusable Lesson Format: Lagrangian Duality, Weak Duality, and Slater's Condition

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Convex_Optimization / Duality_Theory_and_KKT`  
**Lesson Format Type:** `lagrangian_duality_and_slaters_condition`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the formulation of the **Lagrangian Dual Function** $g(\lambda, \nu) = \inf_x L(x, \lambda, \nu)$, prove **Weak Duality** ($d^* \le p^*$), prove concavity of the dual objective, and apply **Slater's Constraint Qualification** to guarantee **Strong Duality** ($d^* = p^*$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Lagrangian & Dual Function Formal Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Weak Duality & Lower Bound Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Dual Function Unconditional Concavity Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Slater Strict Feasibility Qualification Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Duality Gap Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the primal problem: $\min f_0(x)$ s.t. $f_i(x) \le 0 (i=1,\dots,m)$ and $h_i(x) = 0 (i=1,\dots,p)$. The Lagrangian is $L(x, \lambda, \nu) = f_0(x) + \sum \lambda_i f_i(x) + \sum \nu_i h_i(x)$. The Lagrange dual function is $g(\lambda, \nu) = \inf_{x \in \mathcal{D}} L(x, \lambda, \nu)$. State the dual problem: $\max_{\lambda \ge 0, \nu} g(\lambda, \nu)$. State Weak Duality: $d^* \le p^*$ always holds. State Slater's Theorem: If the primal is convex and there exists a strictly feasible point $x \in \operatorname{relint}\mathcal{D}$ such that $f_i(x) < 0$ for non-affine constraints and $A x = b$, then strong duality holds ($d^* = p^*$).
2. **Slide 2 (`ordering`):** Provide 5 steps proving Weak Duality $g(\lambda, \nu) \le p^*$ for any feasible $\lambda \ge 0$: (1) let $\tilde{x}$ be any primal feasible point satisfying $f_i(\tilde{x}) \le 0$ and $h_i(\tilde{x}) = 0$, (2) since $\lambda_i \ge 0$, $\sum \lambda_i f_i(\tilde{x}) \le 0$ and $\sum \nu_i h_i(\tilde{x}) = 0$, (3) evaluate Lagrangian: $L(\tilde{x}, \lambda, \nu) = f_0(\tilde{x}) + \sum \lambda_i f_i(\tilde{x}) + \sum \nu_i h_i(\tilde{x}) \le f_0(\tilde{x})$, (4) by definition of infimum: $g(\lambda, \nu) = \inf_x L(x, \lambda, \nu) \le L(\tilde{x}, \lambda, \nu) \le f_0(\tilde{x})$, (5) taking the infimum over all primal feasible $\tilde{x}$ yields $g(\lambda, \nu) \le p^*$, and maximizing over $\lambda \ge 0, \nu$ gives $d^* \le p^*$.
3. **Slide 3 (`quiz`):** Test why the dual function $g(\lambda, \nu)$ is ALWAYS concave, even if the primal problem is non-convex: (Because for each fixed $x$, $L(x, \lambda, \nu)$ is an affine function of $(\lambda, \nu)$, and the pointwise infimum of affine functions is always concave).
4. **Slide 4 (`proof`):** Interactive derivation establishing Slater's theorem via the separating hyperplane theorem between the epigraph of the perturbation function and the vertical ray $(0, p^*)$.
5. **Slide 5 (`one_word`):** Plain-text recall of the two-word term for the non-negative difference $p^* - d^*$ between primal and dual optimal values (duality-gap / duality gap).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "lagrangian_duality_and_slaters_condition",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: The Lagrange Dual Problem and Slater's Condition**\n• **Primal Problem (Optimal Value $p^*$):**\n$$\n\\min_{\\mathbf{x}} f_0(\\mathbf{x}) \\quad \\text{s.t.} \\quad f_i(\\mathbf{x}) \\le 0 \\; (i=1,\\dots,m), \\quad A\\mathbf{x} = \\mathbf{b}\n$$\n• **The Lagrangian & Dual Function:**\n$$\nL(\\mathbf{x}, \\mathbf{\\lambda}, \\mathbf{\\nu}) = f_0(\\mathbf{x}) + \\sum_{i=1}^m \\lambda_i f_i(\\mathbf{x}) + \\mathbf{\\nu}^T (A\\mathbf{x} - \\mathbf{b}), \\quad g(\\mathbf{\\lambda}, \\mathbf{\\nu}) = \\inf_{\\mathbf{x} \\in \\mathcal{D}} L(\\mathbf{x}, \\mathbf{\\lambda}, \\mathbf{\\nu})\n$$\n• **Weak Duality ($d^* \\le p^*$):** Dual optimal $d^* = \\max_{\\mathbf{\\lambda} \\ge \\mathbf{0}, \\mathbf{\\nu}} g(\\mathbf{\\lambda}, \\mathbf{\\nu}) \\le p^*$ *always* holds.\n• **Slater's Constraint Qualification:** If the primal is convex and **strictly feasible** ($\\exists \\mathbf{x}_0 \\in \\operatorname{relint}\\mathcal{D}$ with $f_i(\\mathbf{x}_0) < 0$ for non-affine $f_i$ and $A\\mathbf{x}_0 = \\mathbf{b}$), then **Strong Duality** holds: $d^* = p^*$ (zero duality gap)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps establishing Weak Duality g(lambda, nu) <= p* for all lambda >= 0.",
      "orderItems": [
        "Select any arbitrary primal feasible point x_tilde satisfying f_i(x_tilde) <= 0 and A x_tilde = b",
        "Observe that for non-negative multipliers lambda_i >= 0, the sum sum lambda_i f_i(x_tilde) is non-positive (<= 0)",
        "Bound the Lagrangian: L(x_tilde, lambda, nu) = f_0(x_tilde) + sum lambda_i f_i(x_tilde) <= f_0(x_tilde)",
        "Apply the definition of the dual infimum: g(lambda, nu) = inf_x L(x, lambda, nu) <= L(x_tilde, lambda, nu) <= f_0(x_tilde)",
        "Take the infimum over all primal feasible points x_tilde to conclude g(lambda, nu) <= p*, ensuring d* <= p*"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the Lagrange dual function g(lambda, nu) GUARANTEED to be concave, even if the primal objective f_0 and constraint functions f_i are wildly non-convex?",
      "options": [
        { "text": "For each fixed x, L(x, lambda, nu) is an affine function of (lambda, nu), and the pointwise infimum of any family of affine functions is always concave", "isCorrect": true, "explanation": "Correct! Because L is linear in lambda and nu, taking the infimum over x produces a concave function, meaning dual problems are ALWAYS convex optimization problems." },
        { "text": "Because all dual variables are zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because non-convex functions cannot have duals", "isCorrect": false, "explanation": "Incorrect: Non-convex problems have valid convex duals." },
        { "text": "Because matrix multiplication is commutative", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Geometric Proof of Strong Duality via Supporting Hyperplane",
      "interactiveSteps": [
        {
          "stepText": "Consider the set of achievable values and constraint margins G = {(u, t) in R^m x R | exists x, f_i(x) <= u_i, f_0(x) <= t}."
        },
        {
          "prompt": "When the problem is convex, what geometric property does the set G possess?",
          "options": [
            { "text": "G is a convex set in R^{m+1}", "isCorrect": true },
            { "text": "G is a discrete lattice", "isCorrect": false },
            { "text": "G is non-convex", "isCorrect": false },
            { "text": "G is empty", "isCorrect": false }
          ]
        },
        {
          "stepText": "By the Supporting Hyperplane Theorem, there exists a non-vertical supporting hyperplane to G at the boundary point (0, p*), whose normal vector yields optimal dual multipliers (lambda*, 1) satisfying g(lambda*) = p*, proving strong duality."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What hyphenated term describes the non-negative difference between the primal optimal value and the dual optimal value (p* - d*)?",
      "blankAnswer": "duality-gap"
    }
  ]
}
```
