# Duofy Reusable Lesson Format: Lie Algebra Representations - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Representation_Theory / Lie_Algebra_Representations`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the representation of a Lie algebra $\rho: \mathfrak{g} \to \mathfrak{gl}(V)$, the canonical commutation relations of $\mathfrak{sl}_2(\mathbb{C})$ ($[h, e] = 2e, [h, f] = -2f, [e, f] = h$), and the highest weight vector classification of irreducible representations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Lie Algebra Homomorphism & sl_2 Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Ladder Operators & Weight Space Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Operator & Commutation Relation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Highest Weight Annihilation Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Irreducible Representation Dimension Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of a Lie algebra representation $\rho: \mathfrak{g} \to \mathfrak{gl}(V)$ and the $\mathfrak{sl}_2(\mathbb{C})$ commutation relations $[h, e] = 2e$, $[h, f] = -2f$, $[e, f] = h$.
2. **Slide 2 (`concept_pieces`):** Deconstruct Cartan element $h$ (diagonal weight generator), raising operator $e$, lowering operator $f$, and highest weight vector $v_0$ with $e v_0 = 0$.
3. **Slide 3 (`matching`):** Pair 4 operators/commutators with their actions on weight spaces.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the raising operator $e$ annihilates the highest weight vector. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking for the dimension of the irreducible $\mathfrak{sl}_2(\mathbb{C})$ representation with highest weight $n$ ($\dim = n+1$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: $\\mathfrak{sl}_2(\\mathbb{C})$ Lie Algebra Representation**\nA **Lie algebra representation** is a linear map $\\rho: \\mathfrak{g} \\to \\mathfrak{gl}(V)$ preserving Lie brackets: $\\rho([X, Y]) = [\\rho(X), \\rho(Y)]$.\nFor $\\mathfrak{sl}_2(\\mathbb{C}) = \\text{span}\\{e, f, h\\}$, the canonical bracket relations are:\n$$\n[h, e] = 2e, \\quad [h, f] = -2f, \\quad [e, f] = h\n$$\nStandard $2 \\times 2$ matrices: $h = \\begin{pmatrix} 1 & 0 \\\\ 0 & -1 \\end{pmatrix}, e = \\begin{pmatrix} 0 & 1 \\\\ 0 & 0 \\end{pmatrix}, f = \\begin{pmatrix} 0 & 0 \\\\ 1 & 0 \\end{pmatrix}$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Weight Spaces ($V_\\mu$):** $V_\\mu = \\{v \\in V \\mid h \\cdot v = \\mu v\\}$. The eigenvalues $\\mu$ are the **weights** of the representation.\n• **Raising Operator ($e$):** If $v \\in V_\\mu$, then $e \\cdot v \\in V_{\\mu + 2}$ (shifts weight up by $+2$).\n• **Lowering Operator ($f$):** If $v \\in V_\\mu$, then $f \\cdot v \\in V_{\\mu - 2}$ (shifts weight down by $-2$).\n• **Highest Weight Vector ($v_0$):** A non-zero vector $v_0 \\in V$ satisfying $e \\cdot v_0 = 0$ and $h \\cdot v_0 = n v_0$ for an integer $n \\ge 0$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each sl_2(C) operator to its algebraic action on weight space V_mu.",
      "matchPairs": [
        { "left": "Cartan element h", "right": "Acts diagonally with eigenvalue mu (h v = mu v)" },
        { "left": "Raising operator e", "right": "Maps weight space V_mu into V_{mu + 2}" },
        { "left": "Lowering operator f", "right": "Maps weight space V_mu into V_{mu - 2}" },
        { "left": "[e, f]", "right": "Equals the Cartan element h" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A highest weight vector v_0 in an sl_2(C) representation is annihilated by the ___ operator e.",
      "blankAnswer": "raising",
      "blankDistractors": ["lowering", "cartan", "casimir"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the dimension of the irreducible sl_2(C) representation with highest weight n in Z_{>= 0}?",
      "options": [
        { "text": "n + 1 (with weights n, n-2, ..., -n)", "isCorrect": true, "explanation": "Correct! The representation has n+1 distinct 1-dimensional weight spaces spanning from n down to -n." },
        { "text": "n", "isCorrect": false, "explanation": "Incorrect: A highest weight of 0 has dimension 1 (trivial representation), so the dimension is n+1." },
        { "text": "2n + 1", "isCorrect": false, "explanation": "Incorrect: 2n+1 would occur if weights decreased in steps of 1 instead of 2." },
        { "text": "n^2", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
