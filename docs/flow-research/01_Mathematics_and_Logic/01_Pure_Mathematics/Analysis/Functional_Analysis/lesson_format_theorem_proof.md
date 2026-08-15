# Duofy Reusable Lesson Format: Functional Analysis - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Functional_Analysis`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the Four Pillars of Functional Analysis: Hahn-Banach Theorem, Open Mapping Theorem, Closed Graph Theorem, and Uniform Boundedness Principle (Banach-Steinhaus).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Four Pillars Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Proof Strategy & Zorn's Lemma Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Open Mapping / Bounded Inverse Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Step Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Functional Extension Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The Hahn-Banach Extension Theorem**\nLet $X$ be a real vector space, $p$ a sublinear functional on $X$, and $f$ a linear functional defined on a subspace $Z \\subset X$ such that $f(x) \\le p(x)$ for all $x \\in Z$.\nThen $f$ can be extended to a linear functional $F$ defined on all of $X$ such that:\n$$\nF(x) \\le p(x) \\quad \\forall x \\in X \\quad \\text{and} \\quad F(x) = f(x) \\quad \\forall x \\in Z\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove Hahn-Banach Extension using Zorn's Lemma.",
      "orderItems": [
        "Extend functional f from subspace Z to Z ⊕ R y_0 by 1 dimension.",
        "Choose constant c = F(y_0) satisfying consistency bounds for all z in Z.",
        "Define partial ordering on pair extensions (g, Y) where Y ⊃ Z and g|Z = f.",
        "Show every chain has an upper bound by taking unions of domain subspaces.",
        "Apply Zorn's Lemma to deduce existence of maximal extension defined on full space X."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What does the Bounded Inverse Theorem (consequence of Open Mapping Theorem) guarantee for a bijective continuous linear operator $T: X \\to Y$ between Banach spaces?",
      "options": [
        { "text": "The inverse operator T⁻¹: Y -> X is automatically continuous and bounded", "isCorrect": true, "explanation": "Correct! Bijective bounded linear maps between Banach spaces have bounded inverses." },
        { "text": "T is compact", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "X is finite-dimensional", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "T is an isometry", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Corollary: Separating Hyperplanes",
      "interactiveSteps": [
        { "stepText": "Let $X$ be a normed space and $x_0 \\neq 0$ a non-zero vector in $X$." },
        {
          "prompt": "By Hahn-Banach, there exists a bounded linear functional $f \\in X^*$ such that $f(x_0) = \|x_0\|$ and $\|f\| = \n$?",
          "options": [
            { "text": "1", "isCorrect": true },
            { "text": "0", "isCorrect": false },
            { "text": "||x₀||", "isCorrect": false },
            { "text": "infinity", "isCorrect": false }
          ]
        },
        { "stepText": "Thus the continuous dual space $X^*$ separates points in $X$." }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What theorem states that a pointwise bounded family of continuous linear operators on a Banach space is uniformly bounded?",
      "blankAnswer": "banach-steinhaus"
    }
  ]
}
```
