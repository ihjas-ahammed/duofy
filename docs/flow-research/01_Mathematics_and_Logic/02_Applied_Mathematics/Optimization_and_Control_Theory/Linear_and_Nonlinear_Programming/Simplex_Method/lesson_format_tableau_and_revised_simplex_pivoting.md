# Duofy Reusable Lesson Format: Simplex Tableau and Revised Simplex Pivoting

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Linear_and_Nonlinear_Programming / Simplex_Method`  
**Lesson Format Type:** `tableau_and_revised_simplex_pivoting`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the execution of a complete **Simplex Pivot Step**, compute **Reduced Costs** $\bar{c}_j = c_j - \mathbf{c}_B^T B^{-1} \mathbf{A}_j$, execute the **Minimum Ratio Test** $\theta^* = \min_{i: d_i > 0} (x_B)_i / d_i$, and compare the memory/speed advantages of the **Revised Simplex Method** ($B^{-1}$ updates).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Simplex Pivot & Reduced Cost Formulation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Simplex Iteration Execution Cycle Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Non-Positive Pivot Column Unboundedness Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Revised Simplex Dual Vector Pricing Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Ratio Test Direction Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Simplex optimality condition: At BFS $\mathbf{x} = [\mathbf{x}_B; \mathbf{x}_N]$, the objective value is $z = \mathbf{c}_B^T B^{-1} \mathbf{b} + \sum_{j \in N} \bar{c}_j x_j$ where the reduced cost is $\bar{c}_j = c_j - \mathbf{c}_B^T B^{-1} \mathbf{A}_j = c_j - \mathbf{y}^T \mathbf{A}_j$ (with dual vector $\mathbf{y}^T = \mathbf{c}_B^T B^{-1}$). If $\bar{c}_j \ge 0$ for all $j \in N$, current BFS is optimal. If any $\bar{c}_j < 0$, entering variable $j$ decreases cost. The step size is determined by the Minimum Ratio Test: $\theta^* = \min_{i \in \{1,\dots,m\} \mid d_i > 0} \frac{(x_B)_i}{d_i}$ where $\mathbf{d} = B^{-1}\mathbf{A}_j$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the Revised Simplex iteration: (1) solve the dual system $\mathbf{y}^T B = \mathbf{c}_B^T$ for simplex multipliers $\mathbf{y}^T = \mathbf{c}_B^T B^{-1}$, (2) price out non-basic variables by calculating $\bar{c}_j = c_j - \mathbf{y}^T \mathbf{A}_j$, (3) if all $\bar{c}_j \ge 0$, STOP (optimal); else select entering index $j$ with $\bar{c}_j < 0$, (4) compute search direction $\mathbf{d} = B^{-1} \mathbf{A}_j$ by solving $B \mathbf{d} = \mathbf{A}_j$, (5) perform minimum ratio test to select leaving variable $l$, update basis $B$, and update basis inverse $B^{-1}$ via rank-1 Sherman-Morrison update.
3. **Slide 3 (`quiz`):** Test what happens when an entering variable $j$ has $\bar{c}_j < 0$ but all entries of the pivot column are non-positive ($\mathbf{d} = B^{-1}\mathbf{A}_j \le \mathbf{0}$): (The LP is UNBOUNDED below ($z \to -\infty$), because $x_j$ can be increased to $+\infty$ without violating any feasibility constraints).
4. **Slide 4 (`proof`):** Interactive derivation showing that updating from basis $B$ to new basis $\bar{B}$ changes the objective by $\Delta z = -\theta^* |\bar{c}_j| \le 0$, proving strict objective improvement for non-degenerate pivots ($\theta^* > 0$).
5. **Slide 5 (`one_word`):** Plain-text recall of the two-word term for the step size calculation rule $\theta^* = \min (x_B)_i / d_i$ (minimum-ratio / ratio-test).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "tableau_and_revised_simplex_pivoting",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The Simplex Pivoting Mechanism and Reduced Costs**\n• For a standard form LP $\\min \\mathbf{c}^T \\mathbf{x}$ s.t. $A\\mathbf{x} = \\mathbf{b}, \\mathbf{x} \\ge \\mathbf{0}$ at basis $B$:\n• **Dual Vector & Reduced Costs:**\n$$\n\\mathbf{y}^T = \\mathbf{c}_B^T B^{-1}, \\qquad \\bar{c}_j = c_j - \\mathbf{y}^T \\mathbf{A}_j \\quad (j \\in N)\n$$\n• **Optimality Test:** If $\\bar{c}_j \\ge 0$ for all $j \\in N$, the current BFS is **globally optimal**.\n• **Entering Variable:** Choose non-basic column $j$ with negative reduced cost $\\bar{c}_j < 0$.\n• **Minimum Ratio Test (Leaving Variable):** Compute direction $\\mathbf{d} = B^{-1} \\mathbf{A}_j$. Step length $\\theta^*$ is:\n$$\n\\theta^* = \\min_{i \\in \\{1,\\dots,m\\}, \\, d_i > 0} \\frac{(x_B)_i}{d_i}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the computational steps in a single iteration of the Revised Simplex algorithm.",
      "orderItems": [
        "Solve the linear dual system y^T B = c_B^T for the simplex multipliers y^T = c_B^T B^{-1}",
        "Price out non-basic variables: compute reduced costs c_bar_j = c_j - y^T A_j for candidate columns",
        "Select entering variable j with most negative reduced cost c_bar_j < 0",
        "Solve the primal system B d = A_j to determine the descent direction vector d in basic coordinates",
        "Perform the minimum ratio test to identify leaving variable l, swap columns in basis B, and update B^{-1}"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "If an entering non-basic variable x_j has a strictly negative reduced cost c_bar_j < 0, but ALL entries of its pivot column are non-positive (d = B^{-1} A_j <= 0), what does this prove about the linear program?",
      "options": [
        { "text": "The linear program is UNBOUNDED: the objective value can decrease to -infinity along the ray x(theta) without violating any non-negativity constraints", "isCorrect": true, "explanation": "Correct! When d <= 0, increasing x_j actually increases (or leaves constant) all basic variables x_B = B^{-1} b - theta d, so theta can grow to +infinity while reducing cost by theta * c_bar_j -> -infinity." },
        { "text": "The problem is infeasible", "isCorrect": false, "explanation": "Incorrect: Current BFS is already feasible." },
        { "text": "The current point is optimal", "isCorrect": false, "explanation": "Incorrect: c_bar_j < 0 means cost can decrease." },
        { "text": "Bland's rule must be applied", "isCorrect": false, "explanation": "Incorrect: Unboundedness terminates the algorithm." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Objective Value Change Under a Simplex Pivot",
      "interactiveSteps": [
        {
          "stepText": "Let the current objective be z_0 = c_B^T x_B. Moving by step theta along column j gives x_B(theta) = x_B - theta d and x_j = theta."
        },
        {
          "prompt": "Evaluate the new objective value z(theta) = c_B^T (x_B - theta d) + c_j theta.",
          "options": [
            { "text": "z(theta) = z_0 + theta (c_j - c_B^T d) = z_0 + theta * c_bar_j", "isCorrect": true },
            { "text": "z(theta) = z_0 + theta", "isCorrect": false },
            { "text": "z(theta) = 0", "isCorrect": false },
            { "text": "z(theta) = z_0 * theta", "isCorrect": false }
          ]
        },
        {
          "stepText": "Since c_bar_j < 0 and theta* > 0 for a non-degenerate pivot, the objective strictly decreases: z(theta*) = z_0 - theta* |c_bar_j| < z_0."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What hyphenated name describes the step size calculation rule theta* = min (x_B)_i / d_i used to select the leaving variable in the Simplex method?",
      "blankAnswer": "ratio-test"
    }
  ]
}
```
