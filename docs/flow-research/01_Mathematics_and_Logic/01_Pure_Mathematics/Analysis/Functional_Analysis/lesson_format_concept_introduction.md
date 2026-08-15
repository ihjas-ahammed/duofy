# Duofy Reusable Lesson Format: Functional Analysis - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Functional_Analysis`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Banach Spaces (complete normed spaces), Hilbert Spaces (inner product spaces with geometric orthogonality), Bounded Linear Operators, and Dual Spaces $X^*$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Banach & Hilbert Space Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Space Hierarchy & Infinite Dim Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Functional Analysis Space Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Key Operator Term Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Non-Compact Unit Ball Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Banach & Hilbert Spaces**\n1. A **Banach Space** $X$ is a complete normed vector space (every Cauchy sequence converges in $X$).\n2. A **Hilbert Space** $H$ is a Banach space whose norm is induced by an inner product:\n$$\n\\|x\\| = \\sqrt{\\langle x, x \\rangle}\n$$\nDual Space $X^* = B(X, \\mathbb{F})$ is the space of continuous linear functionals on $X$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Space Hierarchy:** Normed Space $\\xrightarrow{\\text{Complete}}$ Banach Space $\\xrightarrow{\\text{Inner Product}}$ Hilbert Space.\n• **Infinite Dimensions:** Unlike $\\mathbb{R}^n$, the closed unit ball $B_1(0)$ in an infinite-dimensional space is NEVER compact (Riesz Lemma).\n• **Bounded Operators:** A linear operator $T: X \\to Y$ is continuous if and only if it is bounded ($\\|T x\\| \\le C \\|x\\|$).\n• **Dual Space Isomorphism:** By Riesz Representation Theorem, every Hilbert space is isometric to its dual ($H^* \\cong H$)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Function Space to its exact classification.",
      "matchPairs": [
        { "left": "L^2[a,b] / ℓ^2", "right": "Hilbert Space (inner product induced norm)" },
        { "left": "C[a,b] with max norm", "right": "Banach Space (NOT a Hilbert space)" },
        { "left": "Continuous Dual X*", "right": "Always a complete Banach space" },
        { "left": "Polynomals P[a,b]", "right": "Incomplete Normed Space" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A linear operator T between normed spaces is continuous if and only if it is ___.",
      "blankAnswer": "bounded",
      "blankDistractors": ["compact", "invertible", "self-adjoint"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What does Riesz's Lemma state about the closed unit ball $B_1(0) = \\{ x \\in X \\mid \\|x\\| \\le 1 \\}$ in a normed space $X$?",
      "options": [
        { "text": "B₁(0) is compact if and only if X is finite-dimensional", "isCorrect": true, "explanation": "Correct! Infinite-dimensional unit balls are never compact." },
        { "text": "B₁(0) is always compact in all spaces", "isCorrect": false, "explanation": "Incorrect: Fails in infinite dimensions." },
        { "text": "B₁(0) is never closed", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "B₁(0) has measure 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
