# Duofy Reusable Lesson Format: Lie Algebra Representations - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Representation_Theory / Lie_Algebra_Representations`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute the polynomial representation of $\mathfrak{sl}_2(\mathbb{C})$ on $\mathbb{C}[x, y]_n$, evaluate differential operators on monomial bases, and decompose tensor products using the Clebsch-Gordan rule:
$$V_m \otimes V_n \cong V_{m+n} \oplus V_{m+n-2} \oplus \dots \oplus V_{|m-n|}$$

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Clebsch-Gordan Formula Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step $V_1 \otimes V_2$ Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Clebsch-Gordan Step Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Tensor Dimension Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Irreducible Decomposition Component Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Clebsch-Gordan formula for $\mathfrak{sl}_2(\mathbb{C})$ tensor products: $V_m \otimes V_n \cong \bigoplus_{k=0}^{\min(m,n)} V_{m+n-2k}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4-step decomposition of $V_1 \otimes V_2$ (dim $2 \times 3 = 6$) into $V_3$ (dim 4) $\oplus$ $V_1$ (dim 2).
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that highest weights in the Clebsch-Gordan sum decrease in steps of 2. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the total dimension of $V_3 \otimes V_2$ ($\dim = 4 \times 3 = 12$).
5. **Slide 5 (`quiz`):** Quiz testing the identification of the irreducible constituents in $V_2 \otimes V_2$ ($V_4 \oplus V_2 \oplus V_0$, with dimensions $5 + 3 + 1 = 9$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The Clebsch-Gordan Formula for $\\mathfrak{sl}_2(\\mathbb{C})$**\nFor irreducible representations $V_m$ (dim $m+1$) and $V_n$ (dim $n+1$):\n$$\nV_m \\otimes V_n \\cong V_{m+n} \\oplus V_{m+n-2} \\oplus \\dots \\oplus V_{|m-n|} = \\bigoplus_{k=0}^{\\min(m,n)} V_{m+n-2k}\n$$\nThis decomposes angular momentum tensor products in quantum mechanics."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Find Maximal Weight):** For $V_1 \\otimes V_2$, the highest weights are $1$ and $2$. The top weight in the tensor product is $1 + 2 = 3$.\n• **Step 2 (Apply Clebsch-Gordan Formula):** The index $k$ ranges from $0$ to $\\min(1, 2) = 1$.\n• **Step 3 (List Irreps):** $k=0 \\implies V_{3+0} = V_3$, and $k=1 \\implies V_{3-2} = V_1$.\n• **Step 4 (Check Dimension Equality):** $\\dim(V_1) \\times \\dim(V_2) = 2 \\times 3 = 6$. $\\dim(V_3) + \\dim(V_1) = 4 + 2 = 6$ (exact match)."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In the Clebsch-Gordan decomposition of V_m (x) V_n for sl_2(C), the highest weights of the irreducible constituents decrease in steps of ___.",
      "blankAnswer": "two",
      "blankDistractors": ["one", "three", "four"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "What is the total dimension of the tensor product representation V_3 (x) V_2 for sl_2(C)?",
      "numericAnswer": 12.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the complete irreducible decomposition of V_2 (x) V_2 for sl_2(C)?",
      "options": [
        { "text": "V_4 ⊕ V_2 ⊕ V_0 (dimensions 5 + 3 + 1 = 9)", "isCorrect": true, "explanation": "Correct! Clebsch-Gordan gives k from 0 to 2, yielding V_{4-2k}: V_4, V_2, and V_0." },
        { "text": "V_4 ⊕ V_3 ⊕ V_2 ⊕ V_1 ⊕ V_0", "isCorrect": false, "explanation": "Incorrect: Weights decrease in steps of 2, not 1." },
        { "text": "V_4 only", "isCorrect": false, "explanation": "Incorrect: V_2 (x) V_2 is reducible and contains lower-weight components." },
        { "text": "V_2 ⊕ V_2", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
