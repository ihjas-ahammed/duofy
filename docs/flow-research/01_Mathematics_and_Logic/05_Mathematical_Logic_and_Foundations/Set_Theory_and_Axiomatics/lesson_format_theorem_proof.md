# Duofy Reusable Lesson Format: Set Theory & Axiomatics - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Set_Theory_and_Axiomatics`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through foundational set theory proofs: Cantor's Diagonal Theorem ($|A| < |\mathcal{P}(A)|$), Zorn's Lemma Equivalence to AC, and Cantor-Schröder-Bernstein Theorem.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cantor's Diagonal Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Diagonal Construction Proof Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Schröder-Bernstein Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Zorn's Lemma Application | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Diagonalization Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Proof of Cantor's Theorem ($|A| < |\\mathcal{P}(A)|$)**\nWe prove there is no surjection $f: A \\to \\mathcal{P}(A)$ for any set $A$.\nConstruct the diagonal set:\n$$\nD = \\{ x \\in A \\mid x \\notin f(x) \\}\n$$\nSince $D \\in \\mathcal{P}(A)$, if $f$ were surjective, there would exist $d \\in A$ with $f(d) = D$. But then $d \\in D \\iff d \\notin f(d) = D$ (contradiction!)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove Cantor's Diagonalization Theorem.",
      "orderItems": [
        "Assume for contradiction that there exists a surjective function f: A -> P(A).",
        "Define diagonal set D = { x ∈ A | x ∉ f(x) }.",
        "Since D is a subset of A, D belongs to the power set P(A).",
        "By surjectivity of f, there must exist an element d ∈ A such that f(d) = D.",
        "Ask whether d ∈ D: d ∈ D <-> d ∉ f(d) <-> d ∉ D, reaching an immediate contradiction!"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What does the **Cantor-Schröder-Bernstein Theorem** state if there exist injective functions $f: A \\to B$ and $g: B \\to A$?",
      "options": [
        { "text": "There exists a BIJECTION between A and B (|A| = |B|)", "isCorrect": true, "explanation": "Correct! Mutual injections guarantee equinumerosity |A| = |B| without requiring AC." },
        { "text": "A is a proper subset of B", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A and B are finite", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A = ∅", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: Proving Every Vector Space Has a Basis via Zorn's Lemma",
      "interactiveSteps": [
        { "stepText": "Let $V$ be a vector space. Consider poset $\\mathcal{S}$ of all linearly independent subsets of $V$ ordered by inclusion $\\subseteq$." },
        {
          "prompt": "For any chain of linearly independent subsets $\\mathcal{C} = \\{I_j\\}$, why is the union $\\bigcup I_j$ an upper bound in $\\mathcal{S}$?",
          "options": [
            { "text": "Any linear combination uses finitely many vectors, all contained in some single I_j in the chain, preserving independence", "isCorrect": true },
            { "text": "Union is empty", "isCorrect": false },
            { "text": "Union contains 0", "isCorrect": false },
            { "text": "Vector space is finite", "isCorrect": false }
          ]
        },
        { "stepText": "By Zorn's Lemma, $\\mathcal{S}$ has a maximal element $B$, which must span $V$ and thus forms a basis for $V$!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What proof method constructs set D = {x in A | x not in f(x)} to derive contradiction?",
      "blankAnswer": "diagonalization"
    }
  ]
}
```
