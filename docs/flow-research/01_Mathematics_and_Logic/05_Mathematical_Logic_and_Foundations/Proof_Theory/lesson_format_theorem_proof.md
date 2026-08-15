# Duofy Reusable Lesson Format: Proof Theory - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Proof_Theory`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through landmark proof theory derivations: Gödel's Diagonalization Lemma, First Incompleteness Proof, and Gentzen's Cut-Elimination Procedure.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Diagonal Lemma Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Gödel Sentence Proof Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Second Incompleteness Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Cut-Elimination Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Gödel Number Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Gödel's Diagonalization Lemma**\nFor any formula $\\psi(x)$ with one free variable $x$ in formal arithmetic $T$, there exists a sentence $G$ such that:\n$$\nT \\vdash G \\iff \\psi(\\ulcorner G \\urcorner)\n$$\nwhere $\\ulcorner G \\urcorner$ is the Gödel number of sentence $G$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove Gödel's First Incompleteness Theorem.",
      "orderItems": [
        "Construct proof predicate Prov(x, y) meaning 'x is the Gödel number of a proof of sentence with Gödel number y'.",
        "Define unprovability formula Unprov(y) = ~ ∃ x Prov(x, y).",
        "Apply Diagonalization Lemma to Unprov(y) to obtain sentence G such that PA ⊢ G <-> Unprov(⌜G⌝).",
        "Assume PA ⊢ G. Then there is a proof of G, so PA ⊢ Prov(k, ⌜G⌝), leading to PA ⊢ ~G (contradiction!).",
        "Assume PA ⊢ ~G. Then by ω-consistency, PA ⊢ G (contradiction!). Conclude G is undecidable (true but unprovable)."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the primary conclusion of Gödel's **Second Incompleteness Theorem** for Peano Arithmetic (PA)?",
      "options": [
        { "text": "PA cannot prove its own consistency: PA ⊬ Con(PA)", "isCorrect": true, "explanation": "Correct! No consistent formal system expressing arithmetic can prove its own consistency." },
        { "text": "PA is inconsistent", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "PA can prove all truths", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "PA has no proofs", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: Gentzen's Cut-Elimination Step",
      "interactiveSteps": [
        { "stepText": "The Cut rule takes premisses $\\frac{\\Gamma \\vdash A, \\Delta \\quad \\Gamma, A \\vdash \\Delta}{\\Gamma \\vdash \\Delta}$ where $A$ is the cut formula." },
        {
          "prompt": "If $A = B \\land C$ was introduced by $\\land$-right and $\\land$-left rules, how is the cut rank reduced?",
          "options": [
            { "text": "Replace Cut on B ∧ C with two smaller cuts on subformulas B and C", "isCorrect": true },
            { "text": "Delete the proof tree", "isCorrect": false },
            { "text": "Add a new axiom", "isCorrect": false },
            { "text": "Double the cut rank", "isCorrect": false }
          ]
        },
        { "stepText": "Inducting on cut-rank and degree reduces all cuts until the entire proof is completely Cut-Free!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What encoding scheme maps formal symbols and formulas to unique natural numbers ⌜φ⌝?",
      "blankAnswer": "godel"
    }
  ]
}
```
