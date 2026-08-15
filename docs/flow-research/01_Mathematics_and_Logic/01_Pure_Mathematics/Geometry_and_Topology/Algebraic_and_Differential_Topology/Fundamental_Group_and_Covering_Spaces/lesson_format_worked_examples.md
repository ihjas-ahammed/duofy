# Duofy Reusable Lesson Format: Fundamental Group and Covering Spaces - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Algebraic_and_Differential_Topology / Fundamental_Group_and_Covering_Spaces`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute the fundamental groups of CW surfaces using Van Kampen's theorem (Torus $T^2$, Klein Bottle $K$, Real Projective Plane $\mathbb{RP}^2$), determine their deck transformation groups, and classify all connected 2-sheeted covering spaces.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CW Complex Presentation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Klein Bottle Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Abelianization First Homology Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Covering Sheet Count Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Non-Orientable Double Cover Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Van Kampen recipe for 2D CW complexes with single 2-cell attached along boundary word $w$: $\pi_1(X) \cong \langle a_1, \dots, a_n \mid w = 1 \rangle$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps for the Klein bottle with attaching word $a b a^{-1} b = 1$: (1) 1-skeleton is $S^1 \vee S^1$ with $\pi_1 = \langle a, b \rangle$, (2) attach 2-cell along boundary loop $a b a^{-1} b$, (3) group presentation $\pi_1(K) = \langle a, b \mid a b a^{-1} b = 1 \rangle$, (4) abelianization $H_1(K) \cong \mathbb{Z} \oplus \mathbb{Z}_2$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the abelianization of $\pi_1(X)$ yields the first homology group $H_1(X, \mathbb{Z})$ (Hurewicz Theorem). Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the number of sheets of the orientable double cover of the Klein bottle (number of sheets = 2.0).
5. **Slide 5 (`quiz`):** Quiz asking: What is the fundamental group of the real projective plane $\mathbb{RP}^2$ obtained by attaching a disk along $a^2 = 1$? ($\pi_1(\mathbb{RP}^2) \cong \langle a \mid a^2 = 1 \rangle \cong \mathbb{Z}_2$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Computing $\\pi_1$ of 2D Surfaces via Van Kampen's Theorem**\nFor a 2D cell complex with one 0-cell, 1-cells $a_1, \\dots, a_k$, and a 2-cell attached along boundary word $w(a_1, \\dots, a_k)$:\n$$\n\\pi_1(X) \\cong \\langle a_1, \\dots, a_k \\mid w(a_1, \\dots, a_k) = 1 \\rangle\n$$\n• **Torus $T^2$:** Attaching word $a b a^{-1} b^{-1} \\implies \\pi_1(T^2) = \\langle a, b \\mid aba^{-1}b^{-1} = 1 \\rangle \\cong \\mathbb{Z} \\times \\mathbb{Z}$.\n• **Klein Bottle $K$:** Attaching word $a b a^{-1} b \\implies \\pi_1(K) = \\langle a, b \\mid aba^{-1}b = 1 \\rangle$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (1-Skeleton):** The 1-skeleton $X^1 = S^1 \\vee S^1$ has $\\pi_1(X^1) = \\langle a, b \\rangle$ (Free group $F_2$).\n• **Step 2 (Attaching 2-Cell):** Gluing the square $[0, 1]^2$ with sides $a, b, a^{-1}, b$ imposes the single relation $aba^{-1}b = 1$.\n• **Step 3 (Group Structure):** Rearranging $a b a^{-1} = b^{-1}$ reveals that $\\pi_1(K)$ is the semidirect product $\\mathbb{Z} \\rtimes \\mathbb{Z}$.\n• **Step 4 (Abelianization):** Setting $ab = ba$ gives $b^2 = 1$, yielding the first homology group $H_1(K) \\cong \\mathbb{Z} \\oplus \\mathbb{Z}_2$ (with 2-torsion)."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "By the Hurewicz Theorem, the abelianization of the fundamental group pi_1(X) of a path-connected space is isomorphic to the first ___ group H_1(X, Z).",
      "blankAnswer": "homology",
      "blankDistractors": ["cohomology", "homotopy", "fundamental"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "How many sheets does the orientable torus covering space T^2 -> K of the non-orientable Klein bottle K have?",
      "numericAnswer": 2.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the fundamental group of the real projective plane RP^2 with attaching boundary word a^2 = 1?",
      "options": [
        { "text": "Z_2 (cyclic group of order 2)", "isCorrect": true, "explanation": "Correct! Attaching the 2-cell along a^2 imposes the relation a^2 = 1, so pi_1(RP^2) = <a | a^2 = 1> = Z_2." },
        { "text": "Z", "isCorrect": false, "explanation": "Incorrect: Z is the fundamental group of S^1." },
        { "text": "Trivial group {1}", "isCorrect": false, "explanation": "Incorrect: S^2 has trivial pi_1, but RP^2 has order 2." },
        { "text": "Z * Z", "isCorrect": false, "explanation": "Incorrect: Free product of rank 2 is for S^1 v S^1." }
      ]
    }
  ]
}
```
