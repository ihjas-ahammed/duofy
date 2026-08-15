# Duofy Reusable Lesson Format: Character Theory - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Representation_Theory / Character_Theory`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the character of a group representation $\chi(g) = \text{Tr}(\rho(g))$ as a class function, establish the Frobenius inner product on class functions, and explain the orthonormality of irreducible characters as a generalized Fourier basis.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Character & Trace Formal Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Class Function & Invariant Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Character Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Identity Degree Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Irreducibility Inner Product Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the formal definition of the character $\chi_\rho(g) = \text{Tr}(\rho(g))$ and the Frobenius inner product $\langle \chi, \psi \rangle = \frac{1}{|G|} \sum_{g \in G} \chi(g) \overline{\psi(g)}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct class function property ($\chi(hgh^{-1}) = \chi(g)$), value at identity ($\chi(1) = \dim V$), character of direct sums ($\chi_{V \oplus W} = \chi_V + \chi_W$), and tensor products ($\chi_{V \otimes W} = \chi_V \chi_W$).
3. **Slide 3 (`matching`):** Pair 4 character algebraic operations with their formula outputs.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that $\chi(1)$ equals the dimension (degree) of the representation. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking how to check if a given character $\chi$ is irreducible ($\langle \chi, \chi \rangle = 1$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Character of a Representation**\nLet $\\rho: G \\to GL(V)$ be a linear representation of a finite group $G$.\nThe **character** $\\chi_V: G \\to \\mathbb{C}$ is the trace function:\n$$\n\\chi_V(g) = \\text{Tr}(\\rho(g))\n$$\nThe standard **Frobenius inner product** on class functions is:\n$$\n\\langle \\chi, \\psi \\rangle = \\frac{1}{|G|} \\sum_{g \\in G} \\chi(g) \\overline{\\psi(g)}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Class Function:** Because $\\text{Tr}(P A P^{-1}) = \\text{Tr}(A)$, $\\chi(hgh^{-1}) = \\chi(g)$, so characters are constant on conjugacy classes.\n• **Degree at Identity:** $\\chi(1) = \\text{Tr}(I_{\\dim V}) = \\dim V$ equals the vector space dimension of the representation.\n• **Direct Sum Addition:** $\\chi_{V \\oplus W}(g) = \\chi_V(g) + \\chi_W(g)$.\n• **Tensor Product Multiplication:** $\\chi_{V \\otimes W}(g) = \\chi_V(g) \\cdot \\chi_W(g)$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each character operation to its formula.",
      "matchPairs": [
        { "left": "chi_V(1)", "right": "dim(V) (Dimension of representation)" },
        { "left": "chi_{V (x) W}(g)", "right": "chi_V(g) * chi_W(g)" },
        { "left": "chi_{V (dirsum) W}(g)", "right": "chi_V(g) + chi_W(g)" },
        { "left": "<chi, chi>", "right": "1 if and only if chi is irreducible" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "For any representation V of group G, the value of the character chi_V evaluated at the identity element 1 is equal to the ___ of V.",
      "blankAnswer": "dimension",
      "blankDistractors": ["order", "trace", "determinant"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How can you tell if a given character chi is irreducible using the Frobenius inner product?",
      "options": [
        { "text": "<chi, chi> = 1", "isCorrect": true, "explanation": "Correct! A representation is irreducible if and only if the inner product of its character with itself is 1." },
        { "text": "<chi, chi> = |G|", "isCorrect": false, "explanation": "Incorrect: Inner product normalizes by 1/|G|, so the result is 1." },
        { "text": "<chi, 1> = 0", "isCorrect": false, "explanation": "Incorrect: That only means chi has no trivial subrepresentation." },
        { "text": "chi(g) is always real", "isCorrect": false, "explanation": "Incorrect: Irreducible characters can take complex values." }
      ]
    }
  ]
}
```
