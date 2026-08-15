# Duofy Reusable Lesson Format: Algebraic & Differential Topology - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Algebraic_and_Differential_Topology`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through foundational topological proofs: Brouwer Fixed Point Theorem (no continuous retraction $D^n \to S^{n-1}$), Seifert-van Kampen Theorem, and Mayer-Vietoris Sequence.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Brouwer Fixed Point Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Retraction Contradiction Proof Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Homology Exact Sequence Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Mayer-Vietoris Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Fixed Point Property Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Brouwer Fixed Point Theorem**\nEvery continuous map $f: D^n \\to D^n$ from the closed unit disk $D^n \\subset \\mathbb{R}^n$ to itself has at least one **fixed point**:\n$$\n\\exists x_0 \\in D^n \\quad \\text{such that} \\quad f(x_0) = x_0\n$$\nEquivalently, there exists no continuous retraction $r: D^n \\to \\partial D^n = S^{n-1}$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove Brouwer Fixed Point Theorem using Homology.",
      "orderItems": [
        "Assume f has no fixed points. Construct retraction r: D^n -> S^(n-1) by ray extending from f(x) through x.",
        "Include boundary i: S^(n-1) -> D^n such that composite r ∘ i = id_S^(n-1).",
        "Apply (n-1)-th homology functor H_(n-1) to composite maps.",
        "Obtain map sequence: Z = H_(n-1)(S^(n-1)) -> H_(n-1)(D^n) = 0 -> H_(n-1)(S^(n-1)) = Z.",
        "Observe id_Z = r_* ∘ i_* passes through 0 group, forcing id_Z = 0—a contradiction!"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What does the **Mayer-Vietoris Sequence** compute for a topological space $X = U \\cup V$ decomposed into two open sets?",
      "options": [
        { "text": "Homology groups H_k(X) using long exact sequence of H_k(U), H_k(V), and H_k(U ∩ V)", "isCorrect": true, "explanation": "Correct! Mayer-Vietoris is the algebraic topology analogue of inclusion-exclusion." },
        { "text": "Curvature K", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Number of points in X", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Metric distances", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: Seifert-van Kampen Free Product Pushout",
      "interactiveSteps": [
        { "stepText": "Decompose $X = U \\cup V$ where $U, V, U \\cap V$ are path-connected open sets." },
        {
          "prompt": "Seifert-van Kampen Theorem expresses $\\pi_1(U \\cup V)$ as which group construction?",
          "options": [
            { "text": "Free product with amalgamation π₁(U) *_π₁(U ∩ V) π₁(V)", "isCorrect": true },
            { "text": "Direct product π₁(U) × π₁(V)", "isCorrect": false },
            { "text": "Direct sum", "isCorrect": false },
            { "text": "Trivial group {0}", "isCorrect": false }
          ]
        },
        { "stepText": "Thus loops in $U$ and loops in $V$ combine freely, identifying loops that lie in $U \\cap V$!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What term describes a continuous map r: X -> A onto a subspace A such that r(a) = a for all a in A?",
      "blankAnswer": "retraction"
    }
  ]
}
```
