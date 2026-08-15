# Duofy Reusable Lesson Format: Riemannian Geometry - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Differential_Geometry / Riemannian_Geometry`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof of the **Fundamental Theorem of Riemannian Geometry** (deriving Koszul's Formula for the Levi-Civita Connection $\nabla$) and prove the algebraic Bianchi identities for the Riemann Curvature Tensor.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fundamental Theorem of Riemannian Geometry Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Koszul Cyclic Permutation Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Christoffel Symbol Metric Derivative Formula Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | First Bianchi Identity Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Positive Ricci Curvature Theorem Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Fundamental Theorem of Riemannian Geometry: On any Riemannian manifold $(M, g)$, there exists a unique affine connection $\nabla$ that is metric-compatible and torsion-free, characterized by Koszul's Formula: $2g(\nabla_X Y, Z) = X(g(Y, Z)) + Y(g(Z, X)) - Z(g(X, Y)) + g([X, Y], Z) - g([Y, Z], X) + g([Z, X], Y)$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof: (1) write metric compatibility for $X(g(Y, Z))$, (2) cyclically permute variables to get equations for $Y(g(Z, X))$ and $Z(g(X, Y))$, (3) add the first two equations and subtract the third, (4) substitute the zero-torsion condition $\nabla_A B - \nabla_B A = [A, B]$ to cancel 4 covariant derivative terms, (5) conclude the unique formula for $2g(\nabla_X Y, Z)$, establishing uniqueness and existence via non-degeneracy of $g$.
3. **Slide 3 (`quiz`):** Test how Koszul's formula simplifies when evaluated on coordinate vector fields $\partial_i, \partial_j, \partial_k$ (where $[\partial_i, \partial_j] = 0$), yielding the standard Christoffel symbol formula $\Gamma_{ij}^k = \frac{1}{2} g^{k\ell}(\partial_i g_{j\ell} + \partial_j g_{i\ell} - \partial_\ell g_{ij})$.
4. **Slide 4 (`proof`):** Interactive derivation of the First Algebraic Bianchi Identity $R(X, Y)Z + R(Y, Z)X + R(Z, X)Y = 0$ using torsion-free connections and Jacobi identity of Lie brackets.
5. **Slide 5 (`one_word`):** Plain-text recall of the theorem proving manifolds with strictly positive Ricci curvature have finite diameter and finite fundamental group (Myers / Bonnet-Myers).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Fundamental Theorem of Riemannian Geometry**\nLet $(M, g)$ be a Riemannian manifold.\nThere exists a **unique** affine connection $\\nabla$ on $M$ satisfying:\n1. $\\nabla_X Y - \\nabla_Y X = [X, Y]$ (Torsion-free)\n2. $X(g(Y, Z)) = g(\\nabla_X Y, Z) + g(Y, \\nabla_X Z)$ (Metric-compatible)\nIt is uniquely determined by **Koszul's Formula**:\n$$\n\\begin{aligned}\n2g(\\nabla_X Y, Z) &= X(g(Y, Z)) + Y(g(Z, X)) - Z(g(X, Y)) \\\\\n&\\quad + g([X, Y], Z) - g([Y, Z], X) + g([Z, X], Y)\n\\end{aligned}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps deriving Koszul's formula for the Levi-Civita Connection.",
      "orderItems": [
        "Write out metric compatibility for X(g(Y, Z)) = g(nabla_X Y, Z) + g(Y, nabla_X Z)",
        "Write out cyclic permutations of the indices: Y(g(Z, X)) and Z(g(X, Y))",
        "Add the first two cyclic equations and subtract the third equation",
        "Use the zero-torsion condition nabla_A B - nabla_B A = [A, B] to group and cancel terms into Lie brackets [X, Y], [Y, Z], [Z, X]",
        "Isolate 2 g(nabla_X Y, Z) on the left hand side; use non-degeneracy of metric g to uniquely define the vector nabla_X Y"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why do the Lie bracket terms g([X, Y], Z) completely vanish when evaluating Koszul's formula in a local coordinate basis d/dx^i?",
      "options": [
        { "text": "Coordinate vector fields commute identically: [d/dx^i, d/dx^j] = 0 (equality of mixed partials)", "isCorrect": true, "explanation": "Correct! Since coordinate derivations commute, all Lie brackets vanish, simplifying Koszul's formula directly to the Christoffel symbols." },
        { "text": "Because Christoffel symbols are zero", "isCorrect": false, "explanation": "Incorrect: Christoffel symbols are generally non-zero in curved coordinates." },
        { "text": "Because the metric tensor is constant", "isCorrect": false, "explanation": "Incorrect: Metric components vary with position." },
        { "text": "Because the tangent space is 1-dimensional", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: The First Algebraic Bianchi Identity",
      "interactiveSteps": [
        {
          "stepText": "Let R(X, Y)Z = nabla_X nabla_Y Z - nabla_Y nabla_X Z - nabla_{[X, Y]} Z on a Riemannian manifold with zero torsion."
        },
        {
          "prompt": "Summing R(X, Y)Z + R(Y, Z)X + R(Z, X)Y cyclically and expanding using zero torsion and the Jacobi identity for Lie brackets, what does the cyclic sum equal?",
          "options": [
            { "text": "0 (The First Algebraic Bianchi Identity)", "isCorrect": true },
            { "text": "Ric(X, Y) Z", "isCorrect": false },
            { "text": "Scalar Curvature S", "isCorrect": false },
            { "text": "g(X, Y) Z", "isCorrect": false }
          ]
        },
        {
          "stepText": "Thus R(X, Y)Z + R(Y, Z)X + R(Z, X)Y = 0 identically for all vector fields."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the surname of the mathematician whose theorem states that a complete manifold with Ricci curvature bounded below by a positive constant is compact with finite fundamental group?",
      "blankAnswer": "myers"
    }
  ]
}
```
