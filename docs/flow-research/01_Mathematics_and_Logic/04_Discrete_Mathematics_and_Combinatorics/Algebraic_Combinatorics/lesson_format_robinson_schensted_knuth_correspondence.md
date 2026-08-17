# Duofy Reusable Lesson Format: The Robinson-Schensted-Knuth (RSK) Correspondence

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Algebraic_Combinatorics`  
**Lesson Format Type:** `robinson_schensted_knuth_correspondence`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the **Robinson-Schensted-Knuth (RSK) Correspondence** (Gilbert de B. Robinson 1938, Craige Schensted 1961, Donald Knuth 1970): execute **Schensted Row Bumping** algorithm, construct the Insertion Tableau $P$ and Recording Tableau $Q$, prove the combinatorial bijection $S_n \longleftrightarrow \bigcup_{\lambda \vdash n} (\operatorname{SYT}(\lambda) \times \operatorname{SYT}(\lambda))$, and evaluate Greene's Theorem on longest increasing/decreasing subsequences.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | RSK Bijection & Row Bumping Algorithm Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Schensted Row Insertion Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Permutation Property & Tableau Geometric Feature Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Involutory Permutation Self-Dual Tableau Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Greene's Theorem Longest Subsequence Length Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the RSK Theorem: There exists an explicit algorithmic bijection:
   $$\sigma \in S_n \longleftrightarrow (P, Q) \in \operatorname{SYT}(\lambda) \times \operatorname{SYT}(\lambda)$$
   where $P$ is the **Insertion Tableau** and $Q$ is the **Recording Tableau** of the same partition shape $\lambda \vdash n$. State Schensted's Row Insertion Rule $P \leftarrow x$: Insert $x$ into the first row of $P$. If $x$ is greater than all elements, place $x$ at the end of the row. Otherwise, find the smallest element $y > x$ in the row; replace $y$ with $x$ ("bump" $y$), and insert $y$ into the next row down. Place the step index $i$ in the recording tableau $Q$ at the new cell position.
2. **Slide 2 (`concept_pieces`):** Deconstruct RSK insertion for permutation $\sigma = (3, 1, 4, 2)$: (1) insert $3$: $P = [[3]], Q = [[1]]$, (2) insert $1$: $1 < 3$, bumps $3$ to row 2: $P = [[1], [3]], Q = [[1], [2]]$, (3) insert $4$: $4 > 1$, added to row 1: $P = [[1, 4], [3]], Q = [[1, 3], [2]]$, (4) insert $2$: $2$ bumps $4$ to row 2, $4 > 3$ added to row 2: $P = [[1, 2], [3, 4]], Q = [[1, 3], [2, 4]]$, (5) verify both $P$ and $Q$ are valid SYT of rectangular shape $\lambda = (2, 2) \vdash 4$.
3. **Slide 3 (`matching`):** Pair 4 permutation properties (Inverse $\sigma^{-1}$, Involutions $\sigma = \sigma^{-1}$, Reverse Permutation $\sigma^R$, Longest Increasing Subsequence $\text{LIS}(\sigma)$) with their tableau images ($(Q, P)$, $P = Q$, Transposed shape $\lambda'$, First row length $\lambda_1$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that if permutation $\sigma$ is an involution ($\sigma = \sigma^{-1}$), then its insertion tableau equals its recording tableau ($P = Q$). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Schensted's / Greene's Theorem (1974): What do the length of the FIRST ROW $\lambda_1$ and the length of the FIRST COLUMN $\lambda_1'$ in the RSK shape $\lambda$ equal? ($\lambda_1$ equals the length of the Longest Increasing Subsequence (LIS), and $\lambda_1'$ equals the length of the Longest Decreasing Subsequence (LDS)).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "robinson_schensted_knuth_correspondence",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Robinson-Schensted-Knuth (RSK) Bijection**\n• **The RSK Bijection (1938, 1961, 1970):** A 1-to-1 correspondence between permutations and pairs of Standard Young Tableaux of identical shape $\\lambda \\vdash n$:\n$$\n\\sigma \\in S_n \\longleftrightarrow (P, Q) \\in \\operatorname{SYT}(\\lambda) \\times \\operatorname{SYT}(\\lambda)\n$$\n  - **$P$ (Insertion Tableau):** Built by sequential **Schensted Row Bumping**.\n  - **$Q$ (Recording Tableau):** Records the order in which new cells are created.\n• **Schensted Row Insertion Algorithm ($P \\leftarrow x$):**\n  1. Insert $x$ into the first row of $P$.\n  2. If $x \\ge$ all row elements, append $x$ to the end of the row.\n  3. Else, find smallest $y > x$; replace $y$ with $x$ (**bump $y$**), and recursively insert $y$ into the next row below."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Insert 3):** $P_1 = [[3]], \\; Q_1 = [[1]]$.\n• **Step 2 (Insert 1):** $1 < 3 \\implies 1$ bumps $3$ to Row 2: $P_2 = [[1], [3]], \\; Q_2 = [[1], [2]]$.\n• **Step 3 (Insert 4):** $4 > 1 \\implies 4$ appends to Row 1: $P_3 = [[1, 4], [3]], \\; Q_3 = [[1, 3], [2]]$.\n• **Step 4 (Insert 2):** $2$ bumps $4$ from Row 1; $4$ appends to Row 2: $P_4 = [[1, 2], [3, 4]], \\; Q_4 = [[1, 3], [2, 4]]$.\n• **Step 5 (Final Tableaux):** Both $P$ and $Q$ have identical valid shape $\\lambda = (2, 2) \\vdash 4$!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each permutation operation to its RSK tableau counterpart.",
      "matchPairs": [
        { "left": "Inverse Permutation sigma^{-1}", "right": "(Q, P) (swaps insertion and recording tableaux)" },
        { "left": "Involution sigma = sigma^{-1}", "right": "P = Q (insertion and recording tableaux are identical)" },
        { "left": "Longest Increasing Subsequence (LIS)", "right": "lambda_1 (length of the first row of shape lambda)" },
        { "left": "Longest Decreasing Subsequence (LDS)", "right": "lambda_1' (length of the first column of shape lambda)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Under the RSK bijection sigma <-> (P, Q), a permutation is an involution sigma = sigma^{-1} if and only if its insertion tableau P ___ its recording tableau Q.",
      "blankAnswer": "equals",
      "blankDistractors": ["dominates", "transposes", "inverts"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "According to Schensted's Theorem (1961), what combinatorial property of permutation sigma is encoded by the length of the FIRST ROW lambda_1 of the resulting RSK shape?",
      "options": [
        { "text": "The length of the LONGEST INCREASING SUBSEQUENCE (LIS) in sigma", "isCorrect": true, "explanation": "Correct! Craige Schensted proved that lambda_1 equals the maximum length of an increasing subsequence in sigma, and the height of the first column lambda_1' equals the maximum length of a decreasing subsequence." },
        { "text": "The number of inversions in sigma", "isCorrect": false, "explanation": "Incorrect: Inversions are related to the major index." },
        { "text": "The number of disjoint cycles in sigma", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The determinant of the permutation matrix", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
