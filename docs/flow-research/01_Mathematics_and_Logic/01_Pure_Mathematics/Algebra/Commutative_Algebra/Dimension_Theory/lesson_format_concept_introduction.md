# Duofy Reusable Lesson Format: Dimension Theory - Concept Introduction & Definition

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Commutative_Algebra / Dimension_Theory`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce fundamental concepts of Dimension Theory in Commutative Algebra (Krull Dimension $\dim R$, Height $\text{ht}(\mathfrak{p})$, and Coheight $\dim(R/\mathfrak{p})$) by connecting chains of prime ideals $\mathfrak{p}_0 \subsetneq \dots \subsetneq \mathfrak{p}_n$ to the geometric dimension and codimension of algebraic varieties.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Formal Krull Dimension Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Geometric Duality & Height Intuition | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Dimension Terminology Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Krull Dimension Formula Completion | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Dimension & Codimension Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the formal definition of Krull Dimension $\dim R$ as the supremum of lengths $n$ of chains $\mathfrak{p}_0 \subsetneq \dots \subsetneq \mathfrak{p}_n$. Double-escape LaTeX (`\\mathfrak{p}`, `\\subsetneq`).
2. **Slide 2 (`concept_pieces`):** Deconstruct the duality between prime ideal containment and geometric variety inclusion ($V(\mathfrak{p}_0) \supsetneq V(\mathfrak{p}_1)$) in 4 intuitive bullets.
3. **Slide 3 (`matching`):** Pair 4 key dimensional concepts (Krull dimension, Height, Coheight, Zero-dimensional ring) with their exact definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of the definition of height. **STRICT RULE (Rule 11):** Plain text only, NO LaTeX `$`.
5. **Slide 5 (`quiz`):** Multiple choice question asking to calculate or classify the Krull dimension of a concrete ring (e.g., $k[x_1, \dots, x_n]$ or a PID).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Krull Dimension**\nThe **Krull dimension** of a commutative ring $R$, denoted $\\dim R$, is the supremum of the lengths $n$ of all strictly increasing chains of prime ideals:\n$$\n\\mathfrak{p}_0 \\subsetneq \\mathfrak{p}_1 \\subsetneq \\dots \\subsetneq \\mathfrak{p}_n\n$$\nIf $R$ is a field, its only prime ideal is $(0)$, so $\\dim R = 0$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Geometric Duality:** In algebraic geometry, prime ideals correspond to irreducible subvarieties, with containment reversed ($V(\\mathfrak{p}_0) \\supsetneq V(\\mathfrak{p}_n)$).\n• **Height (Codimension):** $\\text{ht}(\\mathfrak{p})$ is the length of the longest chain ending at $\\mathfrak{p}$, representing the codimension of $V(\\mathfrak{p})$.\n• **Coheight (Dimension):** $\\text{coht}(\\mathfrak{p}) = \\dim(R/\\mathfrak{p})$ is the length of the longest chain starting from $\\mathfrak{p}$.\n• **Affine Domains:** In nice geometric rings, $\\text{ht}(\\mathfrak{p}) + \\dim(R/\\mathfrak{p}) = \\dim R$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each dimension theory concept to its algebraic definition.",
      "matchPairs": [
        { "left": "Krull Dimension (dim R)", "right": "Supremum of lengths of prime ideal chains" },
        { "left": "Height of prime p (ht p)", "right": "Length of longest prime chain descending from p" },
        { "left": "Coheight of prime p", "right": "Krull dimension of the quotient ring R/p" },
        { "left": "Zero-dimensional Ring", "right": "Every prime ideal is a maximal ideal" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The supremum of the lengths of all chains of prime ideals contained in a prime ideal p is called the ___ of p.",
      "blankAnswer": "height",
      "blankDistractors": ["coheight", "degree", "depth"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the Krull dimension of the ring of integers Z?",
      "options": [
        { "text": "1", "isCorrect": true, "explanation": "Correct! The longest chain of prime ideals is (0) ⊊ (p) where p is a prime number, which has length 1." },
        { "text": "0", "isCorrect": false, "explanation": "Incorrect: Z is not a field, as (0) is strictly contained in (p)." },
        { "text": "2", "isCorrect": false, "explanation": "Incorrect: There are no prime ideals strictly between (0) and (p) or containing (p)." },
        { "text": "Infinite", "isCorrect": false, "explanation": "Incorrect: Z is a PID, so all chains have length at most 1." }
      ]
    }
  ]
}
```
