# Duofy Reusable Lesson Format: Banach Contraction Principle and Picard Iteration

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Real_Analysis_and_Measure_Theory / Metric_Spaces_and_Topology`  
**Lesson Format Type:** `banach_contraction_and_picard_iteration`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof and application of the **Banach Fixed-Point Theorem** ($d(Tx, Ty) \le k d(x, y)$ with $k < 1$), derive the geometric error bound $d(x_n, x^*) \le \frac{k^n}{1-k} d(x_0, x_1)$, and apply **Picard-Lindelöf Iteration** to prove ODE existence and uniqueness.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Banach Contraction Mapping Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Geometric Telescoping Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Strict Inequality Contraction Failure Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Picard Integral Operator Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Fixed Point Constant Bound Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Banach Fixed-Point Theorem: Let $(X, d)$ be a non-empty complete metric space. If $T: X \to X$ is a contraction mapping ($d(T(x), T(y)) \le k d(x, y)$ with constant $0 \le k < 1$), then $T$ has a unique fixed point $x^* \in X$ such that $T(x^*) = x^*$, and for any initial point $x_0$, the iteration $x_{n+1} = T(x_n)$ converges to $x^*$ with error estimate $d(x_n, x^*) \le \frac{k^n}{1-k} d(x_0, x_1)$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof of the Banach Contraction Theorem: (1) for initial $x_0$, define sequence $x_n = T^n(x_0)$, (2) by induction, show consecutive step distance $d(x_{n+1}, x_n) \le k^n d(x_1, x_0)$, (3) for any $m > n$, use triangle inequality and geometric series: $d(x_m, x_n) \le \sum_{j=n}^{m-1} d(x_{j+1}, x_j) \le d(x_1, x_0) \sum_{j=n}^{m-1} k^j \le \frac{k^n}{1-k} d(x_1, x_0)$, (4) since $k < 1$, $\frac{k^n}{1-k} \to 0$ as $n \to \infty$, proving $\{x_n\}$ is a Cauchy sequence, (5) by completeness, let $x^* = \lim x_n$; by continuity of $T$, $T(x^*) = T(\lim x_n) = \lim T(x_n) = \lim x_{n+1} = x^*$, and uniqueness follows since $d(x^*, y^*) = d(Tx^*, Ty^*) \le k d(x^*, y^*) \implies (1-k) d(x^*, y^*) \le 0 \implies x^* = y^*$.
3. **Slide 3 (`quiz`):** Test why the strict condition $k < 1$ is required rather than merely $d(Tx, Ty) < d(x, y)$ (e.g. $f(x) = x + 1/x$ on $[1, \infty)$ satisfies $|f(x) - f(y)| < |x - y|$ for $x \ne y$, but has no fixed point).
4. **Slide 4 (`proof`):** Interactive derivation of Picard's integral operator $T[y](t) = y_0 + \int_{t_0}^t f(s, y(s)) ds$ on $C([t_0-\delta, t_0+\delta])$ with Lipschitz constant $L$, showing $T$ is a contraction for $\delta < 1/L$.
5. **Slide 5 (`one_word`):** Plain-text recall of the term used for a mapping satisfying $d(Tx, Ty) \le k d(x, y)$ with $k < 1$ (contraction).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "banach_contraction_and_picard_iteration",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Banach Fixed-Point Theorem**\nLet $(X, d)$ be a **complete metric space**, and let $T: X \\to X$ be a **contraction mapping**:\n$$\nd(T(x), T(y)) \\le k \\, d(x, y) \\quad \\forall x, y \\in X, \\quad \\text{with } 0 \\le k < 1\n$$\n• **Existence & Uniqueness:** $T$ has a **unique fixed point** $x^* \\in X$ ($T(x^*) = x^*$).\n• **Picard Convergence:** For *any* starting point $x_0 \\in X$, the sequence $x_{n+1} = T(x_n)$ converges to $x^*$ with error bound:\n$$\nd(x_n, x^*) \\le \\frac{k^n}{1 - k} d(x_0, x_1)\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps demonstrating that Picard iterates form a Cauchy sequence.",
      "orderItems": [
        "Iteratively apply the contraction inequality to consecutive terms: d(x_{n+1}, x_n) <= k^n d(x_1, x_0)",
        "Use the Triangle Inequality for any m > n: d(x_m, x_n) <= sum_{j=n}^{m-1} d(x_{j+1}, x_j)",
        "Sum the geometric series: d(x_m, x_n) <= d(x_1, x_0) sum_{j=n}^{m-1} k^j <= (k^n / (1 - k)) d(x_1, x_0)",
        "Observe that as n -> infty, k^n -> 0 (since k < 1), proving {x_n} is a Cauchy sequence in X",
        "By completeness, let x* = lim x_n; apply continuity of T to verify T(x*) = x*, and use (1-k)d(x*, y*) <= 0 to prove uniqueness"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Consider the complete metric space X = [1, infty) with standard metric and map f(x) = x + 1/x. Why does f fail to have a fixed point even though |f(x) - f(y)| < |x - y| for all x != y?",
      "options": [
        { "text": "f is a weak contraction, but NOT a strict contraction (there is no constant k < 1 such that |f(x) - f(y)| <= k |x - y| for all x, y, since f'(x) -> 1 as x -> infty)", "isCorrect": true, "explanation": "Correct! Because f'(x) = 1 - 1/x^2 approaches 1 as x -> infty, sup |f'(x)| = 1, so no uniform k < 1 exists." },
        { "text": "Because [1, infty) is not complete", "isCorrect": false, "explanation": "Incorrect: Closed subsets of R are complete." },
        { "text": "Because f is not continuous", "isCorrect": false, "explanation": "Incorrect: f is smooth." },
        { "text": "Because 1/x is negative", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Picard-Lindelöf ODE Existence via Contraction",
      "interactiveSteps": [
        {
          "stepText": "To solve the initial value problem y'(t) = f(t, y), y(t_0) = y_0 with |f(t, u) - f(t, v)| <= L |u - v|, define operator T[y](t) = y_0 + int_{t_0}^t f(s, y(s)) ds on C([t_0-delta, t_0+delta])."
        },
        {
          "prompt": "Computing the distance ||T[u] - T[v]||_infty <= delta L ||u - v||_infty, what choice of delta guarantees T is a contraction?",
          "options": [
            { "text": "Any delta < 1 / L", "isCorrect": true },
            { "text": "delta = infinity", "isCorrect": false },
            { "text": "delta = 2L", "isCorrect": false },
            { "text": "delta = 0", "isCorrect": false }
          ]
        },
        {
          "stepText": "Since (C[t_0-delta, t_0+delta], ||.||_infty) is complete and delta L < 1, Banach's Theorem yields a unique solution y(t) = T[y](t)."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What mathematical term describes a map T satisfying d(Tx, Ty) <= k d(x, y) with a strict Lipschitz constant k < 1?",
      "blankAnswer": "contraction"
    }
  ]
}
```
