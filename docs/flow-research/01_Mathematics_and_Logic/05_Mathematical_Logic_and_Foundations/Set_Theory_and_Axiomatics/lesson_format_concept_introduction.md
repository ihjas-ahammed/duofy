# Duofy Reusable Lesson Format: Set Theory & Axiomatics - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Set_Theory_and_Axiomatics`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce ZFC Axioms, Transfinite Ordinals ($\alpha$) and Cardinals ($\kappa$), Cantor's Theorem ($|A| < |\mathcal{P}(A)|$), Axiom of Choice (AC) $\iff$ Zorn's Lemma, and the Continuum Hypothesis (CH).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | ZFC Axioms & Cardinality Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Transfinite Ordinals & Choice Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | ZFC Axiom Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Cantor Power Set Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Axiom of Choice Equivalence Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: ZFC Axiom System & Cantor's Theorem**\n**Zermelo-Fraenkel Set Theory with Choice (ZFC)** models all of mathematics using the binary relation $\\in$.\n**Cantor's Theorem:** For any set $A$, the cardinality of the power set $\\mathcal{P}(A)$ is strictly greater than $A$:\n$$\n|A| < |\\mathcal{P}(A)| = 2^{|A|}\n$$\nConsequence: There exists an infinite hierarchy of distinct cardinalities $\\aleph_0 < 2^{\\aleph_0} < 2^{2^{\\aleph_0}} \\dots$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Ordinals ($\nalpha$):** Transfinite transitive sets well-ordered by $\\in$: $0 = \\emptyset, 1 = \\{0\\}, 2 = \\{0, 1\\}, \\dots, \\omega = \\mathbb{N}$.\n• **Axiom of Choice Equivalences:** $\\text{AC} \\iff \\text{Well-Ordering Theorem} \\iff \\text{Zorn's Lemma}$ (Every non-empty poset where every chain has an upper bound contains a maximal element).\n• **Continuum Hypothesis (CH):** $2^{\\aleph_0} = \\aleph_1$ (no cardinal size strictly between $\\aleph_0$ and $c = 2^{\\aleph_0}$).\n• **Independence of CH:** Proved independent of ZFC by Gödel (1938, Constructible Universe $L$) and Cohen (1963, Forcing)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each ZFC axiom to its formal property.",
      "matchPairs": [
        { "left": "Axiom of Extensionality", "right": "Two sets are equal iff they contain exactly the same elements" },
        { "left": "Axiom of Regularity (Foundation)", "right": "Every non-empty set x contains an element y such that x ∩ y = ∅ (prevents x ∈ x)" },
        { "left": "Axiom of Choice (AC)", "right": "Cartesian product of non-empty sets is non-empty (exists choice function)" },
        { "left": "Axiom of Power Set", "right": "For any set x, there exists a set y = P(x) of all subsets of x" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Zorn's Lemma states that every non-empty partially ordered set in which every chain has an upper bound contains a ___ element.",
      "blankAnswer": "maximal",
      "blankDistractors": ["minimal", "unique", "finite"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Which of the following propositions is mathematically EQUIVALENT to the Axiom of Choice (AC) under ZF?",
      "options": [
        { "text": "Every vector space has a basis", "isCorrect": true, "explanation": "Correct! Proving every vector space has a basis requires Zorn's Lemma and is equivalent to AC." },
        { "text": "2 + 2 = 4", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The Continuum Hypothesis CH", "isCorrect": false, "explanation": "Incorrect: CH is independent of ZFC." },
        { "text": "Fermat's Last Theorem", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
