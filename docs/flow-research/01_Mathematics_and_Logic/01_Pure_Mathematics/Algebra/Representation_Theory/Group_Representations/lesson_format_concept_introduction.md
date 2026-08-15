# Duofy Reusable Lesson Format: Group Representations - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Representation_Theory / Group_Representations`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the definition of a Group Representation $\rho: G \to GL(V)$, $G$-invariant subrepresentations, and irreducible representations (irreps) as minimal building blocks of symmetry actions.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Group Homomorphism to GL(V) Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | G-Invariant Subspace Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Representation Type Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Irreducibility Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Complete Reducibility Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of a linear representation $(\rho, V)$ as a group homomorphism $\rho: G \to GL(V)$ satisfying $\rho(gh) = \rho(g)\rho(h)$ and $\rho(1) = I$.
2. **Slide 2 (`concept_pieces`):** Deconstruct $G$-invariant subspaces, subrepresentations, irreducible representations, and direct sum decomposition.
3. **Slide 3 (`matching`):** Pair 4 canonical representations (Trivial, Sign, Permutation, Standard) with their defining actions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that an irreducible representation has no proper non-trivial $G$-invariant subspaces. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question testing the condition of Maschke's theorem for complete reducibility.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Group Representation**\nA **linear representation** of a group $G$ on a complex vector space $V$ is a group homomorphism:\n$$\n\\rho: G \\to GL(V)\n$$\nmeaning for all $g, h \\in G$:\n$$\n\\rho(gh) = \\rho(g)\\rho(h) \\quad \\text{and} \\quad \\rho(1) = I_V\n$$\nA subspace $W \\subseteq V$ is **$G$-invariant** if $\\rho(g)w \\in W$ for all $g \\in G$ and $w \\in W$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Irreducible (Simple):** $V$ is **irreducible** if its only $G$-invariant subspaces are $\{0\}$ and $V$ itself.\n• **Reducible:** $V$ is reducible if there exists a non-trivial proper invariant subspace $0 \\subsetneq W \\subsetneq V$.\n• **Complete Reducibility:** Under Maschke's Theorem, $V$ decomposes into a direct sum of irreps: $V \\cong V_1 \\oplus \\dots \\oplus V_k$.\n• **G-Equivariance:** A linear map $\\phi: V \\to W$ is a $G$-homomorphism if $\\phi(\\rho_V(g)v) = \\rho_W(g)\\phi(v)$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each canonical representation of S_n to its vector space action.",
      "matchPairs": [
        { "left": "Trivial Representation", "right": "rho(g) = [1] for all g in G on C" },
        { "left": "Sign Representation (S_n)", "right": "rho(sigma) = [sgn(sigma)] on C" },
        { "left": "Permutation Representation", "right": "Permutes standard basis vectors e_1, ..., e_n in C^n" },
        { "left": "Standard Representation (S_n)", "right": "Subspace of C^n where sum of coordinates equals 0 (dim n-1)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A representation V is called ___ if it contains no non-trivial proper G-invariant subspaces.",
      "blankAnswer": "irreducible",
      "blankDistractors": ["regular", "trivial", "faithful"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Under Maschke's Theorem, which condition guarantees that every representation of a finite group G is completely reducible?",
      "options": [
        { "text": "The characteristic of the base field does not divide the order of the group |G|", "isCorrect": true, "explanation": "Correct! Maschke's theorem requires division by |G| to average projection operators." },
        { "text": "The group G must be abelian", "isCorrect": false, "explanation": "Incorrect: Maschke's theorem holds for all finite groups, abelian or non-abelian." },
        { "text": "The representation must be 1-dimensional", "isCorrect": false, "explanation": "Incorrect: It applies to representations of any finite dimension." },
        { "text": "The field must have prime characteristic p dividing |G|", "isCorrect": false, "explanation": "Incorrect: If char(k) divides |G|, complete reducibility fails (modular representation theory)." }
      ]
    }
  ]
}
```
