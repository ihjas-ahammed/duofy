# Duofy Reusable Lesson Format: Category Theory - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Category_Theory`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Categories $\mathcal{C}$, Functors $F: \mathcal{C} \to \mathcal{D}$, Natural Transformations $\eta: F \Rightarrow G$, The Yoneda Lemma, and Adjoint Functors ($L \dashv R$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Category Triad & Yoneda Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Functors, Naturality & Adjunction Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Category Theory Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Yoneda Isomorphism Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Duality Arrow Reversal Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Category Triad & The Yoneda Lemma**\n1. **Category $\\mathcal{C}$:** Objects $\\text{Ob}(\\mathcal{C})$ and Morphisms $f: A \\to B$ with associative composition and identities $1_A$.\n2. **Functor $F: \\mathcal{C} \\to \\mathcal{D}$:** Maps $A \\mapsto F(A)$ and $f \\mapsto F(f)$ preserving composition $F(g \\circ f) = F(g) \\circ F(f)$.\n3. **The Yoneda Lemma:** For any functor $F: \\mathcal{C} \\to \\text{Set}$ and object $A \\in \\mathcal{C}$:\n$$\n\\text{Nat}(\\text{Hom}(A, -), F) \\cong F(A)\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Natural Transformation $\\eta: F \\Rightarrow G$:** Family of morphisms $\\eta_A: F(A) \\to G(A)$ making naturality square commute: $\\eta_B \\circ F(f) = G(f) \\circ \\eta_A$.\n• **Categorical Duality ($\\mathcal{C}^{\\text{op}}$):** Reversing arrows $f: A \\to B \\implies f^{\\text{op}}: B \\to A$ turns Products into Coproducts, Monos into Epis, and Limits into Colimits!\n• **Adjoint Functors ($L \\dashv R$):** Left adjoint $L$ and Right adjoint $R$ with natural bijection $\\text{Hom}_{\\mathcal{D}}(L(A), B) \\cong \\text{Hom}_{\\mathcal{C}}(A, R(B))$.\n• **Monad ($T, \\eta, \\mu$):** Endofunctor $T: \\mathcal{C} \\to \\mathcal{C}$ with unit $\\eta: I \\Rightarrow T$ and multiplication $\\mu: T^2 \\Rightarrow T$ (Monads in programming represent computational side effects!)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each categorical concept to its dual concept in C^op.",
      "matchPairs": [
        { "left": "Product A × B", "right": "Coproduct / Direct Sum A + B" },
        { "left": "Monomorphism (Injective arrow)", "right": "Epimorphism (Surjective arrow)" },
        { "left": "Limit", "right": "Colimit" },
        { "left": "Left Adjoint Functor L", "right": "Right Adjoint Functor R" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Yoneda Lemma proves that natural transformations Nat(Hom(A, -), F) are in natural bijection with the set ___.",
      "blankAnswer": "F(A)",
      "blankDistractors": ["F(B)", "Hom(A, B)", "Set"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the universal property definition of the **Product** $A \\times B$ in a category $\\mathcal{C}$?",
      "options": [
        { "text": "Object A × B with projections π_A, π_B such that for any object X with f: X -> A, g: X -> B, there exists a UNIQUE h: X -> A × B", "isCorrect": true, "explanation": "Correct! Universal property defines products up to unique isomorphism." },
        { "text": "Sum of cardinalities of A and B", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Subobject of A", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Set of all functions from A to B", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
