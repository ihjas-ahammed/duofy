# Duofy Reusable Lesson Format: Algebraic Combinatorics - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Algebraic_Combinatorics`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through landmark proofs in algebraic combinatorics: RSK Bijection Proof $\sum_{\lambda \vdash n} (f^\lambda)^2 = n!$, Hook Length Formula Proof via Probabilistic Bumping, and Matroid Independent Set Exchange Property.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | RSK Identity Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Schensted Bumping Proof Order | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Matroid Independent Exchange Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Hook Length Calculation Step | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Robinson-Schensted Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The RSK Correspondence & Symmetry Group Identity**\nThe Robinson-Schensted-Knuth (RSK) algorithm establishes a constructive bijection:\n$$\n\\sigma \\in S_n \\stackrel{1:1}{\\longleftrightarrow} (P, Q)\n$$\nwhere $P, Q$ are Standard Young Tableaux of identical shape $\\lambda \\vdash n$. Summing over all shapes yields $\\sum_{\\lambda \\vdash n} (f^\\lambda)^2 = |S_n| = n!$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to perform Schensted row insertion of element x into tableau P.",
      "orderItems": [
        "Compare x with first row of tableau P.",
        "If x is strictly greater than all elements in first row, append x to end of first row.",
        "Otherwise, find smallest element y in first row such that y > x.",
        "Replace y with x in first row ('x bumps y').",
        "Insert bumped element y into second row of P, repeating bumping process downwards."
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the **Independent Set Exchange Axiom** for a matroid $M = (E, \\mathcal{I})$ if $I_1, I_2 \\in \\mathcal{I}$ with $|I_1| < |I_2|$?",
      "options": [
        { "text": "There exists e ∈ I_2 \\ I_1 such that I_1 ∪ {e} ∈ I (can grow smaller independent set)", "isCorrect": true, "explanation": "Correct! Independent set exchange axiom guarantees extension of smaller independent sets." },
        { "text": "I_1 ∪ I_2 = E", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "I_1 ∩ I_2 = ∅", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Rank of I_1 is 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Step: Hook Lengths for Partition $\\lambda = (2, 1) \\vdash 3$",
      "interactiveSteps": [
        { "stepText": "Partition $(2, 1)$ has 3 cells: $(1,1), (1,2), (2,1)$." },
        {
          "prompt": "Calculate product of hook lengths $\\prod h(i,j)$ for shape $(2,1)$ (Cell (1,1) has hook 3, cell (1,2) has hook 1, cell (2,1) has hook 1):",
          "options": [
            { "text": "3 * 1 * 1 = 3", "isCorrect": true },
            { "text": "6", "isCorrect": false },
            { "text": "1", "isCorrect": false },
            { "text": "2", "isCorrect": false }
          ]
        },
        { "stepText": "Using Hook Length Formula: $f^{(2,1)} = \\frac{3!}{3} = \\frac{6}{3} = 2$ SYTs: `[[1,2],[3]]` and `[[1,3],[2]]`!" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What algorithm maps permutations to pairs of standard Young tableaux (P, Q)?",
      "blankAnswer": "rsk"
    }
  ]
}
```
