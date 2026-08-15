# Duofy Reusable Lesson Format: Operator Theory and Spectral Theorem - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Functional_Analysis / Operator_Theory_and_Spectral_Theorem`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof of the **Spectral Radius Formula for Self-Adjoint Operators** ($r(T) = \|T\|$) via the $C^*$-norm identity $\|T^* T\| = \|T\|^2$, and prove the **Hilbert-Schmidt Spectral Theorem for Compact Self-Adjoint Operators** using Rayleigh quotients.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Compact Self-Adjoint Spectral Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Rayleigh Quotient Eigenvector Maximization Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Invariant Orthogonal Complement Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Self-Adjoint Norm $C^*$ Identity Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Operator Calculus Property Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Hilbert-Schmidt Spectral Theorem: Let $T \in \mathcal{K}(\mathcal{H})$ be a compact self-adjoint operator on a Hilbert space $\mathcal{H}$. There exists an orthonormal basis $\{e_n\}$ of $\mathcal{H}$ consisting of eigenvectors of $T$, with real eigenvalues $\lambda_n \to 0$, such that $T = \sum_n \lambda_n \langle \cdot, e_n \rangle e_n$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof via Rayleigh quotients: (1) let $M = \|T\| = \sup_{\|x\|=1} |\langle Tx, x \rangle|$, (2) choose a maximizing sequence $\{x_n\}$ with $\|x_n\|=1$ such that $\langle Tx_n, x_n \rangle \to \lambda_1$ with $|\lambda_1| = M$, (3) compute $\|Tx_n - \lambda_1 x_n\|^2 = \|Tx_n\|^2 - 2\lambda_1 \langle Tx_n, x_n \rangle + \lambda_1^2 \le M^2 - 2\lambda_1^2 + \lambda_1^2 = 0$, so $Tx_n - \lambda_1 x_n \to 0$, (4) by compactness of $T$, extract a convergent subsequence $Tx_{n_k} \to y$, implying $x_{n_k} \to e_1 = y/\lambda_1$ with $T e_1 = \lambda_1 e_1$, (5) restrict $T$ to the invariant orthogonal complement $e_1^\perp$ and iterate to construct the full orthonormal basis.
3. **Slide 3 (`quiz`):** Test why the orthogonal complement $V^\perp$ of an eigenspace $V = \operatorname{ker}(T - \lambda I)$ is invariant under $T$ when $T = T^*$ (if $x \in V^\perp$ and $y \in V$, $\langle Tx, y \rangle = \langle x, Ty \rangle = \lambda \langle x, y \rangle = 0$, so $Tx \in V^\perp$).
4. **Slide 4 (`proof`):** Interactive derivation showing $\|T^2\| = \|T\|^2$ for self-adjoint $T$ using $\|T^2\| = \sup_{\|x\|=1} \langle T^2 x, x \rangle = \sup \|Tx\|^2 = \|T\|^2$, leading to $r(T) = \lim \|T^{2^k}\|^{1/2^k} = \|T\|$.
5. **Slide 5 (`one_word`):** Plain-text recall of the mathematical term describing a norm-preserving map in functional calculus (isometric).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Hilbert-Schmidt Spectral Theorem**\nLet $\\mathcal{H}$ be a separable Hilbert space and let $T \\in \\mathcal{K}(\\mathcal{H})$ be a **compact self-adjoint operator** ($T = T^*$).\nThere exists an **orthonormal basis** $\\{e_n\\}$ of $\\mathcal{H}$ consisting of eigenvectors of $T$, with real eigenvalues $\\lambda_n$ satisfying $\\lim_{n \\to \\infty} \\lambda_n = 0$, such that:\n$$\nTx = \\sum_{n=1}^\\infty \\lambda_n \\langle x, e_n \\rangle e_n \\quad \\forall x \\in \\mathcal{H}\n$$\n*(In particular, $T$ is completely diagonalizable in an infinite-dimensional basis).*"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps finding the maximal eigenvalue of a compact self-adjoint operator.",
      "orderItems": [
        "Let M = ||T|| = sup_{||x||=1} |<Tx, x>|; choose unit vectors x_n with <Tx_n, x_n> -> lambda_1 where |lambda_1| = M",
        "Expand ||Tx_n - lambda_1 x_n||^2 = ||Tx_n||^2 - 2 lambda_1 <Tx_n, x_n> + lambda_1^2 <= M^2 - 2 lambda_1^2 + lambda_1^2 = 0",
        "Conclude that (T - lambda_1 I)x_n -> 0 in norm as n -> infty",
        "Use compactness of T to pass to a subsequence where Tx_{n_k} converges to a vector y; then x_{n_k} -> e_1 = y / lambda_1, satisfying T e_1 = lambda_1 e_1",
        "Restrict T to the invariant orthogonal subspace e_1^perp and iterate inductively to extract the full orthonormal basis of eigenvectors"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the orthogonal complement W = e_1^perp GUARANTEED to be invariant under T (T(W) subset W) when T is self-adjoint?",
      "options": [
        { "text": "For any w in W, <Tw, e_1> = <w, T^* e_1> = <w, T e_1> = lambda_1 <w, e_1> = 0, proving Tw is perpendicular to e_1", "isCorrect": true, "explanation": "Correct! Self-adjointness allows transferring T to the eigenvector e_1 via the inner product, making orthogonal complements invariant." },
        { "text": "Because e_1 = 0", "isCorrect": false, "explanation": "Incorrect: e_1 is a non-zero unit vector." },
        { "text": "Because W is finite-dimensional", "isCorrect": false, "explanation": "Incorrect: W is infinite-dimensional." },
        { "text": "Because lambda_1 must be 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Norm Equality for Self-Adjoint Operators ||T^2|| = ||T||^2",
      "interactiveSteps": [
        {
          "stepText": "Let T be self-adjoint (T = T^*). By the C*-property, ||T^* T|| = ||T||^2."
        },
        {
          "prompt": "Since T^* = T, what does ||T^* T|| simplify to?",
          "options": [
            { "text": "||T^2|| = ||T||^2", "isCorrect": true },
            { "text": "||T^2|| = 2||T||", "isCorrect": false },
            { "text": "||T^2|| = 0", "isCorrect": false },
            { "text": "||T^2|| = ||T||", "isCorrect": false }
          ]
        },
        {
          "stepText": "Inductively ||T^{2^k}|| = ||T||^{2^k}, so the spectral radius r(T) = lim ||T^n||^{1/n} = ||T|| identically."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What adjective describes the continuous functional calculus map C(sigma(T)) -> C*(T, I) because it strictly preserves operator norms (||f(T)|| = ||f||_infty)?",
      "blankAnswer": "isometric"
    }
  ]
}
```
