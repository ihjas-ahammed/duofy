# Duofy Reusable Lesson Format: Field & Galois Theory - Theorem & Proof Derivation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Abstract_Algebra_Groups_Rings_Fields / Field_Theory_and_Galois_Theory`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through core Galois Theory theorems (The Fundamental Theorem of Galois Theory, Tower Law $[L:F] = [L:E][E:F]$, Insolvability of Quintic by Radicals) using interactive proof step sequencing.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Theorem Statement & Tower Law | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Proof Strategy & Chronological Reorder | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 steps) |
| **Slide 3** | Solvability / Group Structure Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Step-by-Step Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Theorem Consequence Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: {{GALOIS_THEOREM_NAME}}**\nLet $K/F$ be a finite Galois extension with Galois group $G = \\text{Gal}(K/F)$.\n$$\n{{FUNDAMENTAL_EQUATION_OR_TOWER_LAW}}\n$$\nFor any intermediate field $E$, $[K : E] = |\\text{Gal}(K/E)|$ and $[E : F] = [G : \\text{Gal}(K/E)]$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to prove {{GALOIS_THEOREM_NAME}}.",
      "orderItems": [
        "{{PROOF_STEP_1_AUTOS_AND_FIXED_FIELDS}}",
        "{{PROOF_STEP_2_INCLUSION_REVERSAL}}",
        "{{PROOF_STEP_3_VECTOR_SPACE_DIMENSION_EQUALITY}}",
        "{{PROOF_STEP_4_BIJECTION_PROOF}}",
        "{{PROOF_STEP_5_QED_CONCLUSION}}"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does the unsolvability of $S_5$ by radicals imply that general degree 5 polynomial equations cannot be solved by radicals?",
      "options": [
        { "text": "Radical extensions correspond to solvable Galois groups, but S₅ is not a solvable group", "isCorrect": true, "explanation": "Correct! Galois proved radical solvability iff Galois group is solvable. S₅ is simple and non-solvable." },
        { "text": "Because degree 5 polynomials have no roots", "isCorrect": false, "explanation": "Incorrect: Fundamental Theorem of Algebra guarantees 5 complex roots." },
        { "text": "Because Q is an infinite field", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because quintics have 5 roots", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Tower Law Calculation: $[\\mathbb{Q}(\\sqrt{2}, \\sqrt{3}) : \\mathbb{Q}]$",
      "interactiveSteps": [
        { "stepText": "Consider the extension $\\mathbb{Q}(\\sqrt{2}, \\sqrt{3}) / \\mathbb{Q}$ with intermediate field $E = \\mathbb{Q}(\\sqrt{2})$." },
        {
          "prompt": "What is the degree $[\\mathbb{Q}(\\sqrt{2}) : \\mathbb{Q}]$?",
          "options": [
            { "text": "2", "isCorrect": true },
            { "text": "3", "isCorrect": false },
            { "text": "4", "isCorrect": false },
            { "text": "1", "isCorrect": false }
          ]
        },
        { "stepText": "By the Tower Law, $[\\mathbb{Q}(\\sqrt{2}, \\sqrt{3}) : \\mathbb{Q}] = [\\mathbb{Q}(\\sqrt{2}, \\sqrt{3}) : \\mathbb{Q}(\\sqrt{2})] \\cdot [\\mathbb{Q}(\\sqrt{2}) : \\mathbb{Q}] = 2 \\times 2 = 4$." }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "A finite group G is called ___ if it possesses a subnormal series with abelian quotient factors.",
      "blankAnswer": "solvable"
    }
  ]
}
```
