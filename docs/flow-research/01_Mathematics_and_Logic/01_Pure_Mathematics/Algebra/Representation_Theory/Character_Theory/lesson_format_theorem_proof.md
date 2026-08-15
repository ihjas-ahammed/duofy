# Duofy Reusable Lesson Format: Character Theory - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Representation_Theory / Character_Theory`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof of **First and Second Schur Orthogonality Relations** using Schur's Lemma and group-averaging projections, establishing the orthonormality of irreducible characters and completeness of character tables.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | First Orthogonality Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Schur's Lemma Averaging Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Group Averaging Invariance Justification | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Regular Representation Interactive Proof | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Orthogonality Relation Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the First Orthogonality Relation: $\langle \chi_i, \chi_j \rangle = \frac{1}{|G|} \sum_{g \in G} \chi_i(g) \overline{\chi_j(g)} = \delta_{ij}$.
2. **Slide 2 (`ordering`):** Provide 5 steps using Schur's Lemma on the averaged matrix $T = \frac{1}{|G|} \sum_{g \in G} \rho_i(g) M \rho_j(g^{-1})$ to deduce orthogonality of matrix coefficients.
3. **Slide 3 (`quiz`):** Test why the averaged operator $T$ is an intertwining map ($\rho_i(h) T = T \rho_j(h)$ for all $h \in G$).
4. **Slide 4 (`proof`):** Interactive derivation proving $\sum_{i=1}^k (\dim V_i)^2 = |G|$ using the regular representation $\mathbb{C}[G]$.
5. **Slide 5 (`one_word`):** Plain-text recall of the mathematician whose lemma anchors orthogonality (Schur).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: First Orthogonality Relations (Schur)**\nLet $\\chi_1, \\dots, \\chi_k$ be the distinct irreducible characters of a finite group $G$.\nUnder the Frobenius inner product, they form an **orthonormal set**:\n$$\n\\langle \\chi_i, \\chi_j \\rangle = \\frac{1}{|G|} \\sum_{g \\in G} \\chi_i(g) \\overline{\\chi_j(g)} = \\delta_{ij} = \\begin{cases} 1 & \\text{if } i = j \\\\ 0 & \\text{if } i \\ne j \\end{cases}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps deriving Schur's Orthogonality Relations.",
      "orderItems": [
        "Let V and W be irreducible representations with matrix forms rho_V and rho_W, and pick an arbitrary linear map M : W -> V",
        "Construct the group-averaged map T = (1/|G|) sum_{g in G} rho_V(g) M rho_W(g^{-1})",
        "Verify that T is a G-homomorphism: rho_V(h) T = T rho_W(h) for all h in G",
        "Apply Schur's Lemma: if V != W, then T = 0; if V = W, then T = (Tr(M)/dim V) id_V",
        "Take M = E_{kl} (elementary basis matrices) and trace over coordinates to obtain character orthogonality"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the group-averaged map T = (1/|G|) sum_{g in G} rho_V(g) M rho_W(g^{-1}) an intertwining map (G-equivariant)?",
      "options": [
        { "text": "Multiplying by rho_V(h) on the left and rho_W(h^{-1}) on the right permutes the group elements in the sum (substitution g' = hg)", "isCorrect": true, "explanation": "Correct! Since summation over all g in G is invariant under left multiplication by h, rho_V(h) T rho_W(h^{-1}) = T." },
        { "text": "Because all finite groups are abelian", "isCorrect": false, "explanation": "Incorrect: This holds for all finite groups, abelian or non-abelian." },
        { "text": "Because M is the identity matrix", "isCorrect": false, "explanation": "Incorrect: M can be any arbitrary matrix." },
        { "text": "Because the trace of T is zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Sum of Squares of Dimensions Rule",
      "interactiveSteps": [
        {
          "stepText": "The regular representation C[G] has character chi_reg(1) = |G| and chi_reg(g) = 0 for g != 1."
        },
        {
          "prompt": "Using the inner product <chi_reg, chi_i>, how many times does each irreducible representation V_i appear in C[G]?",
          "options": [
            { "text": "dim(V_i) times", "isCorrect": true },
            { "text": "1 time", "isCorrect": false },
            { "text": "|G| times", "isCorrect": false },
            { "text": "0 times", "isCorrect": false }
          ]
        },
        {
          "stepText": "Therefore C[G] ≅ ⊕ (dim V_i) V_i, giving |G| = chi_reg(1) = sum_{i=1}^k (dim V_i)^2."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "Whose foundational lemma stating that non-zero G-maps between irreducible representations are isomorphisms anchors character orthogonality?",
      "blankAnswer": "schur"
    }
  ]
}
```
