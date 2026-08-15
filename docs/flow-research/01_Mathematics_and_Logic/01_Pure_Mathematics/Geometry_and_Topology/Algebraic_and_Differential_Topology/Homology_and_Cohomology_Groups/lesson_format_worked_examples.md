# Duofy Reusable Lesson Format: Homology and Cohomology Groups - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Algebraic_and_Differential_Topology / Homology_and_Cohomology_Groups`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute the homology groups of standard spaces (e.g. the $n$-sphere $S^n$ via the Mayer-Vietoris sequence, and the Torus $T^2$ via cellular boundary matrices), calculate Euler characteristics $\chi(X) = \sum (-1)^k b_k$, and identify torsion subgroups.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | $S^n$ Mayer-Vietoris Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Induction on Sphere Homology Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Sphere Homology Group Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Euler Characteristic Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Cellular Boundary Matrix for Torus Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Mayer-Vietoris decomposition of the $n$-sphere $S^n$: split $S^n = A \cup B$ where $A = S^n \setminus \{N\}$ and $B = S^n \setminus \{S\}$ are contractible open hemispheres, with intersection $A \cap B \simeq S^{n-1}$ (homotopy equivalent to the equatorial $(n-1)$-sphere).
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) $H_k(A) \oplus H_k(B) = 0$ for all $k \ge 1$ (contractible), (2) exact sequence segment $0 \to H_k(S^n) \xrightarrow{\partial_*} H_{k-1}(S^{n-1}) \to 0$ for $k \ge 2$, (3) inductive isomorphism $H_k(S^n) \cong H_{k-1}(S^{n-1}) \cong \dots \cong H_1(S^1) \cong \mathbb{Z}$, (4) base cases $H_0(S^n) = \mathbb{Z}$ and $H_k(S^n) = 0$ for $0 < k < n$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the $n$-th homology group $H_n(S^n)$ is isomorphic to the integers Z. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the Euler characteristic $\chi(T^2)$ of the 2-torus ($b_0 = 1, b_1 = 2, b_2 = 1 \implies \chi(T^2) = 1 - 2 + 1 = 0.0$).
5. **Slide 5 (`quiz`):** Quiz testing the cellular boundary operator $\partial_2: C_2 \to C_1$ for the Torus $T^2$ (attaching boundary $a + b - a - b = 0$, so $\partial_2 = 0 \implies H_2(T^2) = \mathbb{Z}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Computing Homology of $S^n$ via Mayer-Vietoris**\nDecompose $S^n = A \\cup B$ into the upper hemisphere $A = S^n \\setminus \\{(0,\\dots,0,-1)\\}$ and lower hemisphere $B = S^n \\setminus \\{(0,\\dots,0,1)\\}$.\n• Both $A$ and $B$ are contractible to a point: $H_k(A) = H_k(B) = 0$ for all $k \\ge 1$.\n• The intersection $A \\cap B$ deformation retracts to the equator $S^{n-1}$.\nThe reduced Mayer-Vietoris sequence gives the exact isomorphism:\n$$\n0 \\longrightarrow \\tilde{H}_k(S^n) \\xrightarrow{\\ \\partial_*\\ \\cong\\ } \\tilde{H}_{k-1}(S^{n-1}) \\longrightarrow 0\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Base Case $n=1$):** For the circle $S^1$, $A \\cap B \\simeq S^0$ (two points). $\\tilde{H}_0(S^0) \\cong \\mathbb{Z} \\implies H_1(S^1) \\cong \\mathbb{Z}$.\n• **Step 2 (Inductive Step):** For $k \\ge 2$, the connecting homomorphism is an isomorphism $\\tilde{H}_k(S^n) \\cong \\tilde{H}_{k-1}(S^{n-1})$.\n• **Step 3 (Cascading Down):** $\\tilde{H}_n(S^n) \\cong \\tilde{H}_{n-1}(S^{n-1}) \\cong \\dots \\cong \\tilde{H}_1(S^1) \\cong \\mathbb{Z}$.\n• **Step 4 (Summary):** For all $n \\ge 1$, $H_0(S^n) = \\mathbb{Z}$, $H_n(S^n) = \\mathbb{Z}$, and $H_k(S^n) = 0$ for all $0 < k < n$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "For any n >= 1, the top-dimensional integer homology group H_n(S^n; Z) of the n-dimensional sphere is isomorphic to ___.",
      "blankAnswer": "Z",
      "blankDistractors": ["0", "Z_2", "Q"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Compute the Euler characteristic chi(T^2) = b_0 - b_1 + b_2 of the 2-dimensional Torus T^2 with Betti numbers (1, 2, 1).",
      "numericAnswer": 0.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In the standard cellular decomposition of the Torus T^2 (one 0-cell, two 1-cells a and b, one 2-cell attached along aba^{-1}b^{-1}), what is the cellular boundary map d_2: C_2 -> C_1?",
      "options": [
        { "text": "d_2(e^2) = a + b - a - b = 0, which implies H_2(T^2) = ker(d_2) = Z", "isCorrect": true, "explanation": "Correct! Because opposite edges are traversed in opposite directions, the 1-chains cancel out identically to 0, giving H_2(T^2) = Z." },
        { "text": "d_2(e^2) = 2a + 2b", "isCorrect": false, "explanation": "Incorrect: 2a + 2b is for the Klein bottle." },
        { "text": "d_2(e^2) = a - b", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "d_2 is undefined", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
