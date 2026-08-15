# Duofy Reusable Lesson Format: Point-Set Topology - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / General_and_Point_Set_Topology`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through foundational topological proofs: Tychonoff's Theorem (arbitrary products of compact spaces are compact), Urysohn's Lemma, and the Heine-Borel Theorem.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Tychonoff Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Proof Strategy & Ultrafilter Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Urysohn Separation Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Product Topology Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Compact Product Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Tychonoff's Theorem**\nLet $\\{X_i\\}_{i \\in I}$ be any indexed collection of compact topological spaces.\nThen the product space equipped with the product topology:\n$$\nX = \\prod_{i \\in I} X_i\n$$\nis a **compact topological space**."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove Tychonoff's Theorem using Ultrafilters.",
      "orderItems": [
        "Let U be an ultrafilter on product space X = ∏ X_i.",
        "Project ultrafilter U to component space X_i via projection map π_i(U).",
        "Since X_i is compact, projected ultrafilter π_i(U) converges to point x_i in X_i.",
        "Construct point x = (x_i) in product space X.",
        "By definition of product topology, ultrafilter U converges to x, proving X is compact."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What does **Urysohn's Lemma** state for any two disjoint closed sets $A, B \\subset X$ in a normal ($T_4$) space $X$?",
      "options": [
        { "text": "There exists a continuous function f: X -> [0, 1] such that f(A) = 0 and f(B) = 1", "isCorrect": true, "explanation": "Correct! Urysohn's Lemma constructs continuous Urysohn functions separating closed sets." },
        { "text": "A and B are compact", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A and B intersect at 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "X is metric space", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: Continuous Image of Compact Space",
      "interactiveSteps": [
        { "stepText": "Let $f: X \\to Y$ be continuous and $X$ compact. Let $\\mathcal{V} = \\{V_j\\}$ be an open cover of $f(X)$." },
        {
          "prompt": "What does continuity of $f$ imply about preimages $U_j = f^{-1}(V_j)$ in $X$?",
          "options": [
            { "text": "{U_j} forms an open cover of compact space X", "isCorrect": true },
            { "text": "{U_j} are closed sets", "isCorrect": false },
            { "text": "{U_j} is empty", "isCorrect": false },
            { "text": "{U_j} is finite", "isCorrect": false }
          ]
        },
        { "stepText": "Since $X$ is compact, select finite subcover $\\{U_1, \\dots, U_k\\}$. Then $\\{V_1, \\dots, V_k\\}$ is a finite subcover of $f(X)$, proving $f(X)$ is compact!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What theorem states that a subset of R^n is compact if and only if it is closed and bounded?",
      "blankAnswer": "heine-borel"
    }
  ]
}
```
