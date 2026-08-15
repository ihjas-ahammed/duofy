# Duofy Reusable Lesson Format: Proof Theory - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Proof_Theory`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Gentzen's Sequent Calculus ($LK/LJ$), Cut-Elimination Hauptsatz, Gödel's Incompleteness Theorems, and the Curry-Howard Isomorphism ($\text{Proofs} \iff \text{Programs}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Sequent Calculus & Incompleteness Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Cut-Elimination & Curry-Howard Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Proof Theory Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Cut-Free Property Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Gödel Incompleteness Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Sequent Calculus & Gödel's Incompleteness**\n1. **Sequent Calculus ($LK$):** A formal inference system using sequents $\\Gamma \\vdash \\Delta$ (assumptions $\\Gamma$ entail disjunction $\\Delta$).\n2. **Gödel's First Incompleteness Theorem:** Any consistent, recursively axiomatizable formal system $T$ capable of doing arithmetic is **incomplete**: there exists a sentence $G$ such that $T \\nvdash G$ and $T \\nvdash \\neg G$.\n3. **Gödel's Second Incompleteness Theorem:** $T \\nvdash \\text{Con}(T)$ (system cannot prove its own consistency)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Gentzen's Cut-Elimination (Hauptsatz):** Any proof using the Cut rule $\\frac{\\Gamma \\vdash A, \\Delta \\quad \\Gamma, A \\vdash \\Delta}{\\Gamma \\vdash \\Delta}$ can be transformed into a Cut-Free proof!\n• **Subformula Property:** In a Cut-free proof, every formula in the proof tree is a subformula of the final conclusion (Analytic Proofs).\n• **Curry-Howard Isomorphism:** Deep correspondence between logic and computation:\n$$\n\\text{Propositions} \\iff \\text{Types}, \\quad \\text{Proofs} \\iff \\text{Programs}, \\quad \\text{Normalization} \\iff \\text{Evaluation}\n$$"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Proof Theory concept to its computational / logical partner.",
      "matchPairs": [
        { "left": "Logical Proposition A", "right": "Data Type A (Curry-Howard)" },
        { "left": "Formal Proof of A", "right": "Executable Program of type A (Curry-Howard)" },
        { "left": "Proof Normalization (Cut Elimination)", "right": "Program Evaluation / Beta Reduction" },
        { "left": "Implication A -> B", "right": "Function Type A -> B" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Gentzen's Cut-Elimination theorem proves that every proof in sequent calculus can be transformed into a cut-___ proof.",
      "blankAnswer": "free",
      "blankDistractors": ["bound", "full", "linear"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the self-referential meaning of Gödel sentence $G$ constructed via Diagonalization in Peano Arithmetic?",
      "options": [
        { "text": "'This statement is not provable in Peano Arithmetic'", "isCorrect": true, "explanation": "Correct! G asserts its own unprovability, forcing G to be true but unprovable." },
        { "text": "'This statement is false'", "isCorrect": false, "explanation": "Incorrect: That is the Liar Paradox." },
        { "text": "'0 equals 1'", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "'Arithmetic is inconsistent'", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
