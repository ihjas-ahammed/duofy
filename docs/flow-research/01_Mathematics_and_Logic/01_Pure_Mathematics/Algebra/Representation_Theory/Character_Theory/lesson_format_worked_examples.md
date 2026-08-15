# Duofy Reusable Lesson Format: Character Theory - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Representation_Theory / Character_Theory`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to construct character tables from scratch (e.g., for symmetric groups $S_3, S_4$, dihedral groups $D_4$, alternating groups $A_4$) and decompose reducible representations (such as permutation representations) into irreducible constituents using the Frobenius inner product.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Character Table Construction Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step $S_3$ Character Table Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Conjugacy Class Size Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Multiplicity Projection | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Missing Character Row Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the complete character table of $S_3$ (classes: $(1)$ of size 1, $(12)$ of size 3, $(123)$ of size 2; rows: Trivial $\chi_{\text{triv}}$, Sign $\chi_{\text{sgn}}$, Standard 2D $\chi_{\text{std}}$).
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps to derive the table: find classes, compute trivial and sign 1D characters, compute permutation character $\chi_{\text{perm}} = (3, 1, 0)$, subtract trivial to get $\chi_{\text{std}} = (2, 0, -1)$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the number of conjugacy classes equals the number of irreducible representations. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the inner product multiplicity $\langle \chi_{\text{perm}}, \chi_{\text{triv}} \rangle = 1$.
5. **Slide 5 (`quiz`):** Quiz testing row orthogonality to find a missing entry in a character table.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Complete Character Table of $S_3$ ($|G| = 6$)**\nConjugacy classes: $C_1 = [1]$ (size 1), $C_2 = [(12)]$ (size 3), $C_3 = [(123)]$ (size 2).\n$$\n\\begin{array}{c|ccc}\n\\text{Classes} & [1] & [(12)] & [(123)] \\\\\n\\text{Sizes} & 1 & 3 & 2 \\\\\n\\hline\n\\chi_{\\text{triv}} & 1 & 1 & 1 \\\\\n\\chi_{\\text{sgn}} & 1 & -1 & 1 \\\\\n\\chi_{\\text{std}} & 2 & 0 & -1 \\\\\n\\end{array}\n$$\nCheck: $1^2 + 1^2 + 2^2 = 6 = |S_3|$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Conjugacy Classes):** $S_3$ has 3 cycle types: identity (1), 2-cycles (3 elements), 3-cycles (2 elements).\n• **Step 2 (1D Irreps):** Abelianization $S_3/[S_3, S_3] \\cong \\mathbb{Z}/2\\mathbb{Z}$ gives two 1D representations: $\\chi_{\\text{triv}}$ and $\\chi_{\\text{sgn}}$.\n• **Step 3 (Permutation Representation):** Acting on 3 points gives $\\chi_{\\text{perm}} = (3, 1, 0)$ (fixed points: 3 on $[1]$, 1 on $[(12)]$, 0 on $[(123)]$).\n• **Step 4 (Extract Standard 2D):** $\\chi_{\\text{std}} = \\chi_{\\text{perm}} - \\chi_{\\text{triv}} = (3-1, 1-1, 0-1) = (2, 0, -1)$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The number of irreducible representations of a finite group is always equal to the number of ___ classes of the group.",
      "blankAnswer": "conjugacy",
      "blankDistractors": ["coset", "abelian", "sylow"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Compute the multiplicity of the trivial representation in the permutation representation of S_3, given by <chi_perm, chi_triv> = (1/6)[1*(3*1) + 3*(1*1) + 2*(0*1)].",
      "numericAnswer": 1.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "If a finite group G has order 24 and has conjugacy classes of sizes 1, 6, 8, 6, 3, how many irreducible representations does G have?",
      "options": [
        { "text": "5 (the number of conjugacy classes)", "isCorrect": true, "explanation": "Correct! The number of irreducible representations always equals the number of conjugacy classes." },
        { "text": "24", "isCorrect": false, "explanation": "Incorrect: 24 is the order of the group |G|." },
        { "text": "4", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "8", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
