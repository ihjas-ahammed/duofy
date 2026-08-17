# Duofy Reusable Lesson Format: Young Tableaux and the Frame-Robinson-Thrall Hook Length Formula

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Algebraic_Combinatorics`  
**Lesson Format Type:** `young_tableaux_and_hook_length_formula`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce **Ferrers Diagrams** and **Standard Young Tableaux (SYT)** for integer partitions $\lambda \vdash n$, define the **Hook Length** $h(i, j) = (\lambda_i - j) + (\lambda_j' - i) + 1$, apply the **Frame-Robinson-Thrall Hook Length Formula (1954)** $f^\lambda = \frac{n!}{\prod_{(i, j) \in \lambda} h(i, j)}$ to count standard tableaux, and connect SYT to irreducible representations of the symmetric group $S_n$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Standard Young Tableaux & Hook Length Formula Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Hook Length Grid Calculation Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Young Diagram Shape & Hook Product Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical SYT Count f^(3,2) via Hook Formula Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Frobenius Sum of Squares Dim Identity Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of a Standard Young Tableau (SYT) of shape $\lambda \vdash n$: A bijection from $\{1, 2, \dots, n\}$ to the cells of the Ferrers diagram $\lambda = (\lambda_1, \dots, \lambda_k)$ such that entries strictly increase along every row (left to right) and along every column (top to bottom). Define the Hook Length $h(i, j)$ of cell $(i, j)$: $h(i, j) = (\lambda_i - j) + (\lambda_j' - i) + 1$ (the cell itself plus all cells strictly to its right and strictly below it). State the Frame-Robinson-Thrall Hook Length Theorem (1954):
   $$f^\lambda = \frac{n!}{\prod_{(i, j) \in \lambda} h(i, j)}$$
   State Representation Theory Link: $f^\lambda = \dim(S^\lambda)$ is the dimension of the irreducible Specht module $S^\lambda$ of the symmetric group $S_n$.
2. **Slide 2 (`concept_pieces`):** Deconstruct hook computation for $\lambda = (3, 2) \vdash 5$: (1) draw $2 \times 3$ grid diagram with row 1 of 3 cells, row 2 of 2 cells, (2) cell $(1,1)$: 2 right + 1 down + 1 = 4, (3) cell $(1,2)$: 1 right + 1 down + 1 = 3, (4) cell $(1,3)$: 0 right + 0 down + 1 = 1, (5) cell $(2,1)$: 1 right + 0 down + 1 = 2, cell $(2,2)$: 0 right + 0 down + 1 = 1, yielding hook lengths $\{4, 3, 1, 2, 1\}$ with product $4 \times 3 \times 1 \times 2 \times 1 = 24$, giving $f^{(3,2)} = 5! / 24 = 120 / 24 = 5$.
3. **Slide 3 (`matching`):** Pair 4 partition shapes ($\lambda = (n)$, $\lambda = (1^n)$, $\lambda = (n, n)$, $\lambda = (3, 2)$) with their SYT count formulas ($1$, $1$, Catalan number $C_n$, $5$).
4. **Slide 4 (`numerical`):** Ask student: Using the hook length product $24$ for partition $\lambda = (3, 2) \vdash 5$, calculate the exact number of Standard Young Tableaux $f^{(3,2)} = 5! / 24 = 120 / 24$ (numeric answer: 5).
5. **Slide 5 (`quiz`):** Quiz on Frobenius's sum of squares identity for symmetric group representations: What is the sum of squared SYT counts $\sum_{\lambda \vdash n} (f^\lambda)^2$ over all partitions of $n$? (By the representation theory of finite groups, $\sum_{\lambda \vdash n} (\dim S^\lambda)^2 = |S_n| = n!$, which also matches the total number of permutations via the RSK correspondence!).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "young_tableaux_and_hook_length_formula",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Standard Young Tableaux and the Hook Length Formula**\n• **Standard Young Tableau (SYT):** A filling of Ferrers diagram $\\lambda \\vdash n$ with $\\{1, \\dots, n\\}$ such that numbers **strictly increase** across rows and down columns.\n• **Hook Length $h(i, j)$:** For cell $(i, j)$, $h(i, j) = (\\text{cells to the right}) + (\\text{cells below}) + 1$.\n• **The Frame-Robinson-Thrall Hook Length Formula (1954):**\n$$\nf^\\lambda = \\frac{n!}{\\prod_{(i, j) \\in \\lambda} h(i, j)}\n$$\n• **Group Representation Dimension:** $f^\\lambda = \\dim(S^\\lambda)$ is the exact dimension of the irreducible Specht representation of the symmetric group $S_n$.\n• **Frobenius Sum of Squares Identity:** $\\sum_{\\lambda \\vdash n} (f^\\lambda)^2 = n!$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Draw Diagram):** For partition $\\lambda = (3, 2) \\vdash 5$, row 1 has 3 boxes, row 2 has 2 boxes.\n• **Step 2 (Row 1 Hooks):**\n  - Box $(1, 1)$: 2 right + 1 down + 1 = **4**.\n  - Box $(1, 2)$: 1 right + 1 down + 1 = **3**.\n  - Box $(1, 3)$: 0 right + 0 down + 1 = **1**.\n• **Step 3 (Row 2 Hooks):**\n  - Box $(2, 1)$: 1 right + 0 down + 1 = **2**.\n  - Box $(2, 2)$: 0 right + 0 down + 1 = **1**.\n• **Step 4 (Hook Product):** $\\prod h(i,j) = 4 \\times 3 \\times 1 \\times 2 \\times 1 = 24$.\n• **Step 5 (Evaluate $f^\\lambda$):** $f^{(3,2)} = \\frac{5!}{24} = \\frac{120}{24} = 5$ standard Young tableaux!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each partition shape to its Standard Young Tableaux count f^lambda.",
      "matchPairs": [
        { "left": "Single Row lambda = (n)", "right": "f^{(n)} = 1 (trivial representation dim 1)" },
        { "left": "Single Column lambda = (1^n)", "right": "f^{(1^n)} = 1 (sign representation dim 1)" },
        { "left": "Two Equal Rows lambda = (n, n)", "right": "f^{(n, n)} = C_n (the n-th Catalan number!)" },
        { "left": "Standard Hook lambda = (n-k, 1^k)", "right": "f^lambda = (n-1) choose k" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the number of Standard Young Tableaux f^{(3, 2)} for the partition lambda = (3, 2) of n = 5.",
      "numericAnswer": 5,
      "numericTolerance": 0
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What algebraic quantity does the sum of squared SYT counts sum_{lambda vdash n} (f^lambda)^2 equal across all integer partitions of n?",
      "options": [
        { "text": "n! (the order of the symmetric group |S_n|, reflecting the sum of squared dimensions of all irreducible group representations)", "isCorrect": true, "explanation": "Correct! By Peter-Weyl / Artin-Wedderburn theorem, the group algebra C[S_n] decomposes into sum (dim V_i)^2 = |S_n| = n!, matching the RSK bijection sum (f^lambda)^2 = n!." },
        { "text": "2^n", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "n^2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Catalan number C_n", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
