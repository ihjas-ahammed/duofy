# Duofy Reusable Lesson Format: Matrix Chain Multiplication and Interval DP

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Algorithm_Design_Techniques / Dynamic_Programming_DP`  
**Lesson Format Type:** `matrix_chain_multiplication_and_interval_dp`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the interval dynamic programming formulation, optimal parenthesization trees, and $O(n^3)$ tabulation order of the Matrix Chain Multiplication (MCM) problem (Thomas H. Cormen, Charles E. Leiserson, Ronald L. Rivest, & Clifford Stein CLRS; Jon Kleinberg & Éva Tardos): master the associative property of matrix multiplication ($A(BC) = (AB)C$ where scalar multiplication operations vary by orders of magnitude based on parenthesization), define the **Interval DP State ($m[i, j]$)** as the minimum scalar multiplications to compute $A_i \dots A_j$ for dimensions $p_0, p_1, \dots, p_n$, formulate the **MCM Recurrence ($\mathbf{m[i,j] = \min_{i \le k < j} \{m[i,k] + m[k+1,j] + p_{i-1} p_k p_j\}}$)**, master the **Diagonal Tabulation Order** (iterating by increasing chain length $L = 2 \to n$), and reconstruct the full optimal parenthesization string using the auxiliary split matrix $s[i, j]$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | MCM Interval Recurrence, Associativity, & Diagonal DP Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Interval Chain Length DP Table Filling Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | MCM Variable / Table & Algorithmic Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Outer Loop Variable Controlling Sub-Chain Length in MCM Tabulation Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Calculation of Scalar Multiplications for Two Alternative Parenthesizations Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Matrix Chain Multiplication DP (CLRS):
   - **The Problem Statement:** Given a sequence of $n$ matrices $\langle A_1, A_2, \dots, A_n \rangle$ where matrix $A_i$ has dimension $p_{i-1} \times p_i$, find the parenthesization that minimizes total scalar multiplications.
   - **The Interval DP Formulation ($m[i, j]$):**
     - Base Case: $\mathbf{m[i, i] = 0}$ (single matrix requires 0 multiplications).
     - **The Recurrence Relation (for $1 \le i < j \le n$):**
       $$\mathbf{m[i, j] = \min_{i \le k < j} \Big( \underbrace{m[i, k]}_{\text{Cost } A_i \dots A_k} + \underbrace{m[k+1, j]}_{\text{Cost } A_{k+1} \dots A_j} + \underbrace{p_{i-1} p_k p_j}_{\text{Multiply } (p_{i-1} \times p_k) \text{ by } (p_k \times p_j)} \Big)}$$
     - Record optimal split: $s[i, j] = \arg\min_k \{\dots\}$.
   - **Tabulation Order:** Must solve all sub-chains of length $L=2$, then $L=3$, up to $L=n$ (filling the upper triangular matrix diagonally).
   - **Complexity:** $\mathbf{O(n^3)\text{ Time}}$ (3 nested loops: length $L$, start $i$, split $k$) and $\mathbf{O(n^2)\text{ Space}}$.
2. **Slide 2 (`ordering`):** Provide 5 steps of executing the Matrix Chain Multiplication dynamic programming algorithm: (1) initialize the n x n DP cost table m with zeros along the main diagonal (m[i, i] = 0), (2) iterate an outer loop over chain length L from 2 to n, (3) iterate an inner loop over start index i from 1 to n - L + 1, computing ending index j = i + L - 1, (4) iterate split point k from i to j - 1, calculating cost m[i, k] + m[k+1, j] + p_{i-1} * p_k * p_j and finding the minimum, (5) store the minimum cost in m[i, j] and optimal split index in s[i, j], returning m[1, n] as the global minimum cost!
3. **Slide 3 (`matching`):** Pair 4 MCM components (m[i, j] Table, s[i, j] Table, Chain Length L Loop, Scalar Product p_{i-1} * p_k * p_j) with their mathematical definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in Matrix Chain Multiplication tabulation, the outer loop iterates over the chain length L. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating scalar operations for two different parenthesizations: Given three matrices $A_1 (10 \times 100)$, $A_2 (100 \times 5)$, and $A_3 (5 \times 50)$, what is the number of scalar multiplications for $(A_1 A_2) A_3$ versus $A_1 (A_2 A_3)$, and which is optimal? ($(A_1 A_2)$ takes $10 \times 100 \times 5 = 5,000$, resulting in a $(10 \times 5)$ matrix; multiplying by $A_3$ takes $10 \times 5 \times 50 = 2,500 \implies \mathbf{\text{Total } = 7,500}$; while $A_1 (A_2 A_3)$ takes $(100 \times 5 \times 50) + (10 \times 100 \times 50) = 25,000 + 50,000 = \mathbf{75,000}$, making **$(A_1 A_2) A_3$ ten times faster!**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "matrix_chain_multiplication_and_interval_dp",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Matrix Chain Multiplication (CLRS)**\n• **Associativity Multiplier Discrepancy:** $A(BC) = (AB)C$, but scalar operations can differ by $10\\times$ or $100\\times$!\n• **The Interval DP Recurrence ($m[i, j]$):**\n$$\n\\mathbf{m[i, j] = \\min_{i \\le k < j} \\Big( m[i, k] + m[k+1, j] + p_{i-1} p_k p_j \\Big) \\quad (m[i, i] = 0)}\n$$\n  - $p_{i-1} \\times p_i$: Dimensions of matrix $A_i$.\n  - $k$: Optimal split index stored in table $s[i, j]$.\n• **Diagonal Tabulation Order:** Outer loop must iterate over **Chain Length $L = 2 \\to n$**!\n• **Complexity:** $\\mathbf{O(n^3)\\text{ Time}}$ (3 loops: $L$, $i$, $k$) and $\\mathbf{O(n^2)\\text{ Space}}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential algorithmic steps of the Matrix Chain Multiplication interval DP solver.",
      "orderItems": [
        "Initialize the n x n table m with zeros along the main diagonal (m[i, i] = 0 for single matrices)",
        "Iterate the outer loop over sub-chain length L from 2 up to total matrix count n",
        "Iterate starting index i from 1 to n - L + 1 and compute ending index j = i + L - 1",
        "Test all possible split indices k from i to j - 1, calculating m[i, k] + m[k+1, j] + p_(i-1) * p_k * p_j",
        "Record the minimum scalar multiplication cost in m[i, j] and the optimal split index in s[i, j]"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Matrix Chain Multiplication variable to its exact algorithmic function.",
      "matchPairs": [
        { "left": "m[i, j] Table", "right": "Stores the minimum number of scalar multiplications needed to compute matrix product A_i ... A_j" },
        { "left": "s[i, j] Table", "right": "Stores the optimal split index k that achieves the minimum cost, used to reconstruct parentheses" },
        { "left": "p_(i-1) * p_k * p_j", "right": "Cost of multiplying the resulting (p_(i-1) x p_k) left matrix by the (p_k x p_j) right matrix" },
        { "left": "Chain Length L Loop", "right": "Ensures all smaller subproblem intervals are fully solved before evaluating larger intervals" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In bottom-up Matrix Chain Multiplication dynamic programming, the outer loop must iterate across increasing sub-chain ___ from 2 to n.",
      "blankAnswer": "length",
      "blankDistractors": ["width", "height", "depth"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Given three matrices A1 of dimensions 10x100, A2 of dimensions 100x5, and A3 of dimensions 5x50, how many scalar multiplications are required for the parenthesization (A1 * A2) * A3 versus A1 * (A2 * A3)?",
      "options": [
        { "text": "(A1 * A2) * A3 requires 7,500 scalar multiplications (10*100*5 + 10*5*50 = 5,000 + 2,500 = 7,500), while A1 * (A2 * A3) requires 75,000 scalar multiplications (100*5*50 + 10*100*50 = 25,000 + 50,000 = 75,000); making the first parenthesization 10 times faster", "isCorrect": true, "explanation": "Correct! Let us explicitly compute the cost for both parenthesizations using the standard matrix multiplication cost formula (multiplying an a x b matrix by a b x c matrix takes a * b * c scalar operations): Case 1: (A1 * A2) * A3. Multiplying A1 (10x100) by A2 (100x5) takes 10 * 100 * 5 = 5,000 operations, producing an intermediate matrix of size 10x5. Multiplying this 10x5 result by A3 (5x50) takes 10 * 5 * 50 = 2,500 operations. Total cost = 5,000 + 2,500 = 7,500 multiplications. Case 2: A1 * (A2 * A3). Multiplying A2 (100x5) by A3 (5x50) takes 100 * 5 * 50 = 25,000 operations, producing an intermediate matrix of size 100x50. Multiplying A1 (10x100) by this 100x50 result takes 10 * 100 * 50 = 50,000 operations. Total cost = 25,000 + 50,000 = 75,000 multiplications. The two parenthesizations compute the exact same mathematical product, but one requires 75,000 operations while the other requires only 7,500 (a 10-fold speedup), demonstrating why the Matrix Chain Multiplication DP algorithm is essential." },
        { "text": "Both parenthesizations take exactly 75,000 multiplications because matrix multiplication is commutative", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "(A1 * A2) * A3 takes 1,000,000 multiplications", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Parenthesization has zero effect on computational operations", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
