# Duofy Reusable Lesson Format: Chain Complexes and Homology - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Homological_Algebra / Chain_Complexes_and_Homology`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute homology groups $H_n(C)$ from concrete chain complexes of free abelian groups, simplicial complexes (e.g., triangle, circle $S^1$, torus), and boundary matrix kernels/images using Smith Normal Form.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Homology Matrix Computation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Triangle Homology Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Boundary Map Image Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Betti Number Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Torsion Homology Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the formula for computing homology over $\mathbb{Z}$: $H_n(C) \cong \mathbb{Z}^{\beta_n} \oplus T_n$, where Betti number $\beta_n = \text{nullity}(d_n) - \text{rank}(d_{n+1})$.
2. **Slide 2 (`concept_pieces`):** Walk through the 4 steps of computing the homology of a hollow triangle (1-skeleton of a 2-simplex $\partial \Delta^2$).
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the $n$-th Betti number equals the rank of the $n$-th homology group. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the first Betti number $\beta_1(S^1)$ of a circle.
5. **Slide 5 (`quiz`):** Quiz testing the homology of the real projective plane $\mathbb{R}P^2$ (detecting $\mathbb{Z}/2\mathbb{Z}$ torsion in $H_1$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Computing Homology Groups via Linear Algebra**\nFor a chain complex of free abelian groups $C_n = \\mathbb{Z}^{k_n}$ with boundary matrices $D_n$:\n$$\n\\text{rank}(Z_n) = \\text{nullity}(D_n) = k_n - \\text{rank}(D_n)\n$$\n$$\n\\text{rank}(B_n) = \\text{rank}(D_{n+1})\n$$\nThe **$n$-th Betti number** is $\\beta_n = \\text{rank}(H_n(C)) = \\text{nullity}(D_n) - \\text{rank}(D_{n+1})$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Setup Complex):** For hollow triangle $\\partial \\Delta^2$, $C_1 = \\mathbb{Z}^3$ (edges $e_1, e_2, e_3$) and $C_0 = \\mathbb{Z}^3$ (vertices $v_1, v_2, v_3$).\n• **Step 2 (Boundary Map $d_1$):** Matrix $D_1 = \\begin{pmatrix} -1 & 0 & 1 \\\\ 1 & -1 & 0 \\\\ 0 & 1 & -1 \\end{pmatrix}$. $\\text{rank}(D_1) = 2$.\n• **Step 3 (Find Kernel $Z_1$):** $\\ker(D_1)$ is spanned by the 1-cycle $e_1 + e_2 + e_3$, so $\\ker(D_1) \\cong \\mathbb{Z}$.\n• **Step 4 (Compute $H_1$):** Since $C_2 = 0$, $B_1 = 0$, giving $H_1(\\partial \\Delta^2) = \\mathbb{Z}/0 \\cong \\mathbb{Z}$ (one 1D loop)."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The rank of the n-th homology group H_n(C) of a topological space is called the n-th ___ number.",
      "blankAnswer": "betti",
      "blankDistractors": ["euler", "poincare", "hadamard"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "What is the 1st Betti number beta_1 of the circle S^1?",
      "numericAnswer": 1.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the 1st homology group H_1(RP^2) of the real projective plane with boundary map d_2 = [2] : Z -> Z?",
      "options": [
        { "text": "Z / 2Z (cyclic group of order 2, representing torsion)", "isCorrect": true, "explanation": "Correct! Since Z_1 = Z and B_1 = 2Z, H_1 = Z / 2Z." },
        { "text": "Z (infinite cyclic group)", "isCorrect": false, "explanation": "Incorrect: RP^2 is non-orientable and has torsion in degree 1." },
        { "text": "0 (trivial group)", "isCorrect": false, "explanation": "Incorrect: The boundary map is multiplication by 2, not surjective." },
        { "text": "Z x Z", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
