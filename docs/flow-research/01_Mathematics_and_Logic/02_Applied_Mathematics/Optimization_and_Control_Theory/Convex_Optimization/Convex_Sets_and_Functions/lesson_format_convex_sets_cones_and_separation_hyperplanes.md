# Duofy Reusable Lesson Format: Convex Sets, Cones, and Separation Hyperplanes

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Convex_Optimization / Convex_Sets_and_Functions`  
**Lesson Format Type:** `convex_sets_cones_and_separation_hyperplanes`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the geometric definitions of **Convex Sets**, **Proper Cones** ($\mathbb{R}^n_+$, Second-Order Cone $\mathcal{Q}^{n+1}$, PSD Cone $\mathbb{S}^n_+$), apply the **Separating Hyperplane Theorem** and Supporting Hyperplane Theorem, and calculate dual cones $\mathcal{K}^*$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Convex Set & Cone Formal Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Geometric Separation Hyperplane Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Convex Cone & Dual Cone Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Line Segment Convex Combination Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Strict Separation Disjoint Compact Sets Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of a convex set $C$: $\forall x, y \in C, \theta x + (1-\theta)y \in C$ for all $\theta \in [0, 1]$. State the definition of a convex cone $\mathcal{K}$: $\forall x, y \in \mathcal{K}, \theta_1 x + \theta_2 y \in \mathcal{K}$ for all $\theta_1, \theta_2 \ge 0$. State the Separating Hyperplane Theorem: If $C$ and $D$ are disjoint non-empty convex sets ($C \cap D = \emptyset$), there exist $a \ne 0 \in \mathbb{R}^n$ and $b \in \mathbb{R}$ such that $a^T x \le b$ for all $x \in C$ and $a^T y \ge b$ for all $y \in D$.
2. **Slide 2 (`concept_pieces`):** Deconstruct fundamental proper cones: (1) Non-negative orthant $\mathbb{R}^n_+ = \{x \mid x_i \ge 0\}$, self-dual $(\mathbb{R}^n_+)^* = \mathbb{R}^n_+$, (2) Second-Order Cone (Lorentz / Ice-cream cone) $\mathcal{Q}^{n+1} = \{(x, t) \in \mathbb{R}^n \times \mathbb{R} \mid \|x\|_2 \le t\}$, self-dual, (3) Positive Semidefinite Cone $\mathbb{S}^n_+ = \{X \in \mathbb{S}^n \mid X \succeq 0\}$, self-dual under Frobenius inner product $\operatorname{Tr}(X Y) \ge 0$, (4) Supporting Hyperplane Theorem: at every boundary point $x_0 \in \partial C$ of a convex set, there exists a supporting hyperplane tangent to $C$.
3. **Slide 3 (`matching`):** Pair 4 cones ($\mathbb{R}^n_+$ Non-negative orthant, $\mathcal{Q}^{n+1}$ Second-Order Cone, $\mathbb{S}^n_+$ Positive Semidefinite Cone, General Dual Cone $\mathcal{K}^*$) with their algebraic definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that a set is convex if the line segment connecting any two points in the set lies entirely within the set. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking: Under what conditions does a STRICT separating hyperplane ($a^T x < b$ for $x \in C$ and $a^T y > b$ for $y \in D$) exist? (If $C$ and $D$ are disjoint non-empty convex sets, $C$ is compact (closed and bounded), and $D$ is closed).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "convex_sets_cones_and_separation_hyperplanes",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Convex Sets, Cones, and the Separating Hyperplane Theorem**\n• A set $C \\subseteq \\mathbb{R}^n$ is **convex** if the line segment connecting any two points lies entirely within $C$:\n$$\n\\forall \\mathbf{x}, \\mathbf{y} \\in C, \\quad \\theta \\mathbf{x} + (1 - \\theta)\\mathbf{y} \\in C \\quad \\forall \\theta \\in [0, 1]\n$$\n• A set $\\mathcal{K}$ is a **convex cone** if $\\theta_1 \\mathbf{x} + \\theta_2 \\mathbf{y} \\in \\mathcal{K}$ for all $\\mathbf{x}, \\mathbf{y} \\in \\mathcal{K}$ and $\\theta_1, \\theta_2 \\ge 0$.\n• **Separating Hyperplane Theorem:** If $C, D \\subset \\mathbb{R}^n$ are non-empty disjoint convex sets ($C \\cap D = \\emptyset$), there exist $\\mathbf{a} \\ne \\mathbf{0}$ and $b \\in \\mathbb{R}$ such that:\n$$\n\\mathbf{a}^T \\mathbf{x} \\le b \\quad \\forall \\mathbf{x} \\in C, \\qquad \\mathbf{a}^T \\mathbf{y} \\ge b \\quad \\forall \\mathbf{y} \\in D\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Non-Negative Orthant $\\mathbb{R}^n_+$:** $\\{\\mathbf{x} \\in \\mathbb{R}^n \\mid x_i \\ge 0\\}$, self-dual cone underlying Linear Programming (LP).\n• **Second-Order Cone (SOC) $\\mathcal{Q}^{n+1}$:** $\\{(\\mathbf{x}, t) \\in \\mathbb{R}^n \\times \\mathbb{R} \\mid \\|\\mathbf{x}\\|_2 \\le t\\}$, self-dual ice-cream cone underlying SOCP.\n• **Positive Semidefinite Cone $\\mathbb{S}^n_+$:** $\\{X \\in \\mathbb{S}^n \\mid X \\succeq 0\\}$, self-dual under trace inner product $\\langle X, Y \\rangle = \\operatorname{Tr}(X Y) \\ge 0$ underlying SDP.\n• **Supporting Hyperplane:** For any boundary point $\\mathbf{x}_0 \\in \\partial C$, there exists $\\mathbf{a} \\ne \\mathbf{0}$ such that $\\mathbf{a}^T \\mathbf{x} \\le \\mathbf{a}^T \\mathbf{x}_0$ for all $\\mathbf{x} \\in C$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each convex cone to its formal mathematical characterization.",
      "matchPairs": [
        { "left": "Non-Negative Orthant R^n_+", "right": "{x in R^n | x_i >= 0 for all i} (self-dual polyhedral cone)" },
        { "left": "Second-Order Cone Q^{n+1}", "right": "{(x, t) in R^n x R | ||x||_2 <= t} (self-dual Euclidean norm cone)" },
        { "left": "Positive Semidefinite Cone S^n_+", "right": "{X in S^n | z^T X z >= 0 for all z in R^n} (self-dual matrix cone)" },
        { "left": "Dual Cone K*", "right": "{y in R^n | x^T y >= 0 for all x in K} (non-negative inner products)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A geometric set C is convex if the straight line ___ connecting any two points in C lies completely within C.",
      "blankAnswer": "segment",
      "blankDistractors": ["cone", "tangent", "curve"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Under what topological conditions is a STRICT separating hyperplane (a^T x < b for x in C and a^T y > b for y in D) guaranteed to exist between two disjoint convex sets C and D?",
      "options": [
        { "text": "When C is compact (closed and bounded) and D is closed (allowing minimum distance dist(C, D) > 0 to be achieved)", "isCorrect": true, "explanation": "Correct! If C is compact and D is closed and disjoint, the distance inf ||x - y|| is strictly positive and attained, allowing a strictly separating hyperplane perpendicular to the shortest chord." },
        { "text": "For any two open sets regardless of overlap", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Only when both sets are 1-dimensional points", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Strict separation is never possible in finite dimensions", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
