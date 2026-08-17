# Duofy Reusable Lesson Format: Chebyshev Equioscillation Theorem and Remez Exchange Algorithm

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing / Approximation_Theory_and_Interpolation`  
**Lesson Format Type:** `remez_exchange_and_minimax_approximation`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the **Chebyshev Equioscillation Theorem** (the error curve $e(x) = f(x) - p_n^*(x)$ must reach alternating extrema $\pm E$ at least $n+2$ times), execute the **Remez Exchange Algorithm**, and compute minimax polynomial approximations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Chebyshev Equioscillation Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Remez Exchange Iteration Cycle Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Number of Alternating Extrema Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Remez Linear System Matrix Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Minimax Algorithm Founder Surname Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Minimax problem: Find $p_n^* \in \mathcal{P}_n$ minimizing $\|f - p_n\|_\infty = \max_{x \in [a, b]} |f(x) - p_n(x)|$. State the Chebyshev Equioscillation Theorem: A polynomial $p_n^* \in \mathcal{P}_n$ is the unique best uniform approximation $\iff$ there exist at least $n + 2$ points $a \le x_0 < x_1 < \dots < x_{n+1} \le b$ such that $f(x_i) - p_n^*(x_i) = (-1)^i \cdot \sigma \cdot \|f - p_n^*\|_\infty$ where $\sigma = \pm 1$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the Remez Exchange Algorithm: (1) initialize $n+2$ reference points $X^{(0)} = \{x_0, \dots, x_{n+1}\}$ (e.g. Chebyshev extrema), (2) solve the linear $(n+2) \times (n+2)$ system $p_n(x_i) + (-1)^i E = f(x_i)$ for polynomial coefficients and reference error $E$, (3) compute the continuous error function $e(x) = f(x) - p_n(x)$ on $[a, b]$, (4) find the $n+2$ local extrema of $e(x)$ where $|e(x)|$ reaches its global maximum $\|e\|_\infty$, (5) exchange the reference set with the new extrema points, and repeat until $\|e\|_\infty - |E| < \text{tol}$.
3. **Slide 3 (`quiz`):** Test the exact number of alternating equioscillation points required for a degree $n$ polynomial ($n + 2$ points).
4. **Slide 4 (`proof`):** Interactive derivation of the Remez linear system matrix showing why the extra column of alternating signs $[\dots, (-1)^i]$ makes the $(n+2) \times (n+2)$ Vandermonde matrix invertible.
5. **Slide 5 (`one_word`):** Plain-text recall of the surname of the Soviet mathematician who created the exchange algorithm in 1934 (Remez).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "remez_exchange_and_minimax_approximation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Chebyshev Equioscillation Theorem**\nLet $f \\in C[a, b]$ and let $\\mathcal{P}_n$ be the space of polynomials of degree $\\le n$.\n• A polynomial $p_n^* \\in \\mathcal{P}_n$ is the **unique minimax polynomial** minimizing $\\max_{x \\in [a, b]} |f(x) - p(x)|$ if and only if the error curve $e(x) = f(x) - p_n^*(x)$ achieves its maximum magnitude at least **$n + 2$ alternating extreme points**:\n$$\ne(x_i) = (-1)^i \\cdot \\sigma \\cdot \\|f - p_n^*\\|_\\infty, \\quad a \\le x_0 < x_1 < \\dots < x_{n+1} \\le b\n$$\nwhere $\\sigma \\in \\{+1, -1\\}$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical iteration steps of the Remez Exchange Algorithm for computing minimax polynomials.",
      "orderItems": [
        "Initialize a reference set of n+2 points X = {x_0, x_1, ..., x_{n+1}} using Chebyshev-Gauss-Lobatto extrema",
        "Solve the (n+2) x (n+2) linear system: p_n(x_i) + (-1)^i E = f(x_i) for polynomial coefficients c_0, ..., c_n and reference level E",
        "Evaluate the continuous error function e(x) = f(x) - p_n(x) across the entire interval [a, b]",
        "Locate all local extrema of e(x) and identify the points where |e(x)| reaches the global maximum ||e||_infty",
        "Exchange reference points with the new alternating local extrema, repeating until ||e||_infty - |E| < epsilon"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "How many alternating equioscillation extreme points are required to uniquely characterize the best minimax polynomial approximation of degree n in P_n?",
      "options": [
        { "text": "At least n + 2 points (for degree n, there are n+1 polynomial coefficients plus 1 error value E)", "isCorrect": true, "explanation": "Correct! Because there are n+1 polynomial degrees of freedom plus 1 unknown error equioscillation amplitude E, exactly n+2 constraints/points are needed." },
        { "text": "n points", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "n + 1 points", "isCorrect": false, "explanation": "Incorrect: n+1 points determine standard interpolation (error = 0), not equioscillation." },
        { "text": "2n points", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: The Remez Linear System Setup",
      "interactiveSteps": [
        {
          "stepText": "On reference set {x_0, ..., x_{n+1}}, we require c_0 + c_1 x_i + ... + c_n x_i^n + (-1)^i E = f(x_i) for i = 0, ..., n+1."
        },
        {
          "prompt": "What is the dimension of the resulting linear system matrix [V, (-1)^i] where V is the Vandermonde matrix?",
          "options": [
            { "text": "(n + 2) x (n + 2) square matrix", "isCorrect": true },
            { "text": "n x n", "isCorrect": false },
            { "text": "(n + 1) x (n + 1)", "isCorrect": false },
            { "text": "Infinite dimensional", "isCorrect": false }
          ]
        },
        {
          "stepText": "Because the alternating column prevents singular degeneracies, the system is always non-singular, uniquely yielding polynomial coefficients and leveled error E."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the surname of the Soviet mathematician who introduced the minimax exchange algorithm in 1934?",
      "blankAnswer": "remez"
    }
  ]
}
```
