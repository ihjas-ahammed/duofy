# Duofy Reusable Lesson Format: Group Representations - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Representation_Theory / Group_Representations`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly write down matrix representations for dihedral groups ($D_3, D_4$) and symmetric groups ($S_3$), find invariant subspaces, construct equivariant projections, and decompose permutation representations into irreducible components.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Matrix Representation Definition Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step $S_3$ Permutation Decomposition | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Invariant Subspace Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Invariant Subspace Dimension | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Intertwining Map Homomorphism Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the defining $3 \times 3$ permutation matrices of $S_3$ acting on $\mathbb{C}^3$ ($r = (123) \mapsto \begin{pmatrix} 0 & 0 & 1 \\ 1 & 0 & 0 \\ 0 & 1 & 0 \end{pmatrix}$, $s = (12) \mapsto \begin{pmatrix} 0 & 1 & 0 \\ 1 & 0 & 0 \\ 0 & 0 & 1 \end{pmatrix}$).
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4-step decomposition of $\mathbb{C}^3$ into $V_{\text{triv}} = \text{span}(e_1+e_2+e_3)$ (dim 1) and $V_{\text{std}} = \{(x_1,x_2,x_3) \mid x_1+x_2+x_3=0\}$ (dim 2).
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the all-ones vector $(1, 1, 1)^T$ spans the trivial 1D subrepresentation. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the dimension of the standard representation of $S_4$ in $\mathbb{C}^4$ ($\dim = 4 - 1 = 3$).
5. **Slide 5 (`quiz`):** Quiz testing the dimension of $\text{Hom}_{S_3}(V_{\text{std}}, V_{\text{std}}) = 1$ by Schur's Lemma.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Permutation Representation of $S_3$ on $\\mathbb{C}^3$**\nLet $S_3 = \\langle r, s \\mid r^3 = 1, s^2 = 1, srs = r^{-1} \\rangle$ act on the standard basis $\{e_1, e_2, e_3\}$ of $\\mathbb{C}^3$:\n$$\n\\rho(r) = \\begin{pmatrix} 0 & 0 & 1 \\\\ 1 & 0 & 0 \\\\ 0 & 1 & 0 \\end{pmatrix}, \\quad \\rho(s) = \\begin{pmatrix} 0 & 1 & 0 \\\\ 1 & 0 & 0 \\\\ 0 & 0 & 1 \\end{pmatrix}\n$$\nThis representation is reducible: $\\mathbb{C}^3 \\cong V_{\\text{triv}} \\oplus V_{\\text{std}}$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Find Fixed Line):** Vector $v_{\\text{triv}} = (1, 1, 1)^T$ is fixed by both matrices: $\\rho(r)v = v$ and $\\rho(s)v = v$.\n• **Step 2 (Identify Trivial Subspace):** $V_{\\text{triv}} = \\text{span}(v_{\\text{triv}})$ is a 1-dimensional $G$-invariant subrepresentation.\n• **Step 3 (Find Orthogonal Complement):** Take $V_{\\text{std}} = V_{\\text{triv}}^\\perp = \\{(x_1, x_2, x_3) \\in \\mathbb{C}^3 \\mid x_1 + x_2 + x_3 = 0\\}$.\n• **Step 4 (Verify Irreducibility):** $V_{\\text{std}}$ has dimension $3 - 1 = 2$. No 1D subline is preserved by both $r$ and $s$, so $V_{\\text{std}}$ is irreducible."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In any permutation representation of S_n on C^n, the line spanned by the all-ones vector (1, 1, ..., 1) forms the 1-dimensional ___ subrepresentation.",
      "blankAnswer": "trivial",
      "blankDistractors": ["standard", "sign", "regular"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "What is the dimension of the standard irreducible representation of the symmetric group S_4?",
      "numericAnswer": 3.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "By Schur's Lemma, what is the complex dimension of the space of G-homomorphisms Hom_{S_3}(V_std, V_std)?",
      "options": [
        { "text": "1 (all intertwining maps are scalar multiples of the identity matrix)", "isCorrect": true, "explanation": "Correct! Schur's Lemma states that Hom_G(V, V) ≅ C for any complex irreducible representation V." },
        { "text": "2", "isCorrect": false, "explanation": "Incorrect: 2 is the dimension of the vector space V_std, not the dimension of Hom(V, V)." },
        { "text": "4", "isCorrect": false, "explanation": "Incorrect: 4 is the dimension of general 2x2 matrices End(V_std), but only scalar multiples are G-equivariant." },
        { "text": "0", "isCorrect": false, "explanation": "Incorrect: The identity map is always a non-zero G-homomorphism." }
      ]
    }
  ]
}
```
