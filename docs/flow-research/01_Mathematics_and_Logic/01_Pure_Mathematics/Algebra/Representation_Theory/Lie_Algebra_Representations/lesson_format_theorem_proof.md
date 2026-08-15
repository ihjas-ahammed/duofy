# Duofy Reusable Lesson Format: Lie Algebra Representations - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Representation_Theory / Lie_Algebra_Representations`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the rigorous classification theorem of finite-dimensional irreducible representations of $\mathfrak{sl}_2(\mathbb{C})$, deriving the ladder formula $e f^k v_0 = k(n - k + 1) f^{k-1} v_0$ and proving that highest weights must be non-negative integers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | $\mathfrak{sl}_2(\mathbb{C})$ Classification Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Ladder Induction Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Commutation Identity Proof Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Highest Weight Quantization Interactive Proof | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Quadratic Casimir Operator Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Classification Theorem: For every integer $n \ge 0$, there is a unique (up to isomorphism) irreducible representation $V_n$ of $\mathfrak{sl}_2(\mathbb{C})$ of dimension $n+1$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof: (1) start with highest weight vector $v_0$ ($e v_0 = 0, h v_0 = \lambda v_0$), (2) define $v_k = \frac{1}{k!} f^k v_0$, (3) prove $h v_k = (\lambda - 2k) v_k$, (4) prove $e v_k = (\lambda - k + 1) v_{k-1}$ by induction, (5) use finite-dimensionality to show $v_{m+1} = 0 \implies \lambda = m \in \mathbb{Z}_{\ge 0}$.
3. **Slide 3 (`quiz`):** Test why the commutator relation $[e, f^k] = k f^{k-1}(h - (k-1)I)$ holds.
4. **Slide 4 (`proof`):** Interactive derivation showing that the Casimir element $C = 2fe + \frac{1}{2}h^2 + h$ acts as the scalar $\frac{1}{2}n(n+2)$ on $V_n$.
5. **Slide 5 (`one_word`):** Plain-text recall of the quadratic central operator (Casimir).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Classification of Finite-Dimensional $\\mathfrak{sl}_2(\\mathbb{C})$ Irreps**\nFor every integer $n \\in \\mathbb{Z}_{\\ge 0}$, there exists a unique (up to isomorphism) irreducible representation $V_n$ of $\\mathfrak{sl}_2(\\mathbb{C})$ of dimension $n+1$.\nIts weights are symmetric about 0:\n$$\n\\text{Weights}(V_n) = \\{n, n-2, n-4, \\dots, -(n-2), -n\\}\n$$\nEvery finite-dimensional representation of $\\mathfrak{sl}_2(\\mathbb{C})$ is completely reducible."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps in proving the highest weight quantization for sl_2(C) representations.",
      "orderItems": [
        "Let V be an irreducible finite-dimensional representation, and choose a highest weight vector v_0 with e v_0 = 0 and h v_0 = lambda v_0",
        "Define the descending vectors v_k = (1/k!) f^k v_0 for k >= 0",
        "Use the commutator [h, f] = -2f to show that h v_k = (lambda - 2k) v_k (distinct eigenvalues)",
        "Prove by induction that e v_k = (lambda - k + 1) v_{k-1}",
        "Since V is finite-dimensional, there must exist an integer m such that v_m != 0 but v_{m+1} = 0, forcing lambda = m in Z_{>= 0}"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does the identity e v_{m+1} = (lambda - m) v_m force the highest weight lambda to be an integer m?",
      "options": [
        { "text": "Because v_{m+1} = 0 implies e v_{m+1} = 0, and since v_m != 0, we must have lambda - m = 0, so lambda = m", "isCorrect": true, "explanation": "Correct! Setting the coefficient to zero yields the discrete quantization lambda = m." },
        { "text": "Because all eigenvalues of matrices are integers", "isCorrect": false, "explanation": "Incorrect: General matrix eigenvalues can be arbitrary complex numbers." },
        { "text": "Because e is an invertible matrix", "isCorrect": false, "explanation": "Incorrect: e is a nilpotent matrix." },
        { "text": "Because lambda must be equal to 0", "isCorrect": false, "explanation": "Incorrect: lambda can be any non-negative integer." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: The Quadratic Casimir Operator",
      "interactiveSteps": [
        {
          "stepText": "The Casimir operator C = 2fe + (1/2)h^2 + h commutes with e, f, and h, so C is central in the Universal Enveloping Algebra."
        },
        {
          "prompt": "By Schur's Lemma, C acts as a scalar on irreducible V_n. Evaluating C on the highest weight vector v_0 (where e v_0 = 0 and h v_0 = n v_0), what is the eigenvalue?",
          "options": [
            { "text": "(1/2) n^2 + n = (1/2) n(n + 2)", "isCorrect": true },
            { "text": "n + 1", "isCorrect": false },
            { "text": "0", "isCorrect": false },
            { "text": "n^2", "isCorrect": false }
          ]
        },
        {
          "stepText": "Therefore, C acts as the scalar matrix (1/2)n(n+2) I on the entire irreducible representation V_n."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the name of the central quadratic element in the universal enveloping algebra that acts as a scalar on irreps?",
      "blankAnswer": "casimir"
    }
  ]
}
```
