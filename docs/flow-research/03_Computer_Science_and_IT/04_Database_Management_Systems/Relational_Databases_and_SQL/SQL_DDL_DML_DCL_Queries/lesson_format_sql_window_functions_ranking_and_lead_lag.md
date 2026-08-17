# Duofy Reusable Lesson Format: SQL Window Functions (Ranking, Partitions, and LEAD/LAG)

**Target Topic:** `03_Computer_Science_and_IT / 04_Database_Management_Systems / Relational_Databases_and_SQL / SQL_DDL_DML_DCL_Queries`  
**Lesson Format Type:** `sql_window_functions_ranking_and_lead_lag`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through analytical window frames, partition-level aggregations, and sequential offset functions without row collapsing across ANSI SQL Window Functions (ANSI SQL:2003 Standard; Alan Beaulieu *Learning SQL* Chapter 13; Silberschatz et al. Chapter 5.5): master the **`OVER (PARTITION BY ... ORDER BY ... [ROWS/RANGE frame])`** syntax clause, distinguish **Ranking Functions** (**`ROW_NUMBER()` [Strict Monotonic Sequence $1, 2, 3, 4$]**, **`RANK()` [Tied Ranks with Gaps $1, 1, 3, 4$]**, and **`DENSE_RANK()` [Tied Ranks without Gaps $1, 1, 2, 3$]**), master **Offset Value Functions** (**`LEAD(col, n)` [Look Ahead]** and **`LAG(col, n)` [Look Behind]** to calculate running differences and period-over-period growth), evaluate running cumulative totals (`ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`), and compare Window Functions with traditional `GROUP BY` aggregations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Window Function Syntax, Partitioning Invariants, & Ranking Function Matrix Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Window Execution Computing Running Cumulative Totals Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Window Function / Clause Element & Analytical Behavior Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Ranking Function That Assigns Consecutive Integers to Ties Without Skipping Numbers (DENSE_RANK) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis and Output Trace of ROW_NUMBER vs RANK vs DENSE_RANK on Tied Scores Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State SQL Window Functions (ANSI SQL:2003; Beaulieu Chapter 13; Silberschatz 5.5):
   - **General Window Function Syntax:**
     $$\mathbf{\text{FUNCTION}(\text{expr}) \ \mathbf{\text{OVER}} \ (\mathbf{\text{PARTITION BY }} \text{dept\_id} \ \mathbf{\text{ORDER BY }} \text{salary DESC} \ [\text{frame\_clause}])}$$
   - **Crucial Distinction from `GROUP BY`:** Window functions compute aggregations across a group of rows **WITHOUT collapsing the rows into a single output row**! (Each original row retains its individual identity).
   - **Ranking Functions on Tied Values (e.g. Scores: 100, 100, 90, 80):**
     $$\begin{array}{|l|c|l|}
     \hline
     \textbf{Ranking Function} & \textbf{Rank Output for Tied Scores [100, 100, 90, 80]} & \textbf{Behavior on Ties} \\
     \hline
     \mathbf{\text{ROW\_NUMBER}()} & \mathbf{1, \ 2, \ 3, \ 4} & \text{Always unique, arbitrary order on tie} \\
     \mathbf{\text{RANK}()} & \mathbf{1, \ 1, \ 3, \ 4} & \mathbf{\text{Ties share rank; SKIPS subsequent ranks (gap created)}} \\
     \mathbf{\text{DENSE\_RANK}()} & \mathbf{1, \ 1, \ 2, \ 3} & \mathbf{\text{Ties share rank; NO gaps created (dense numbering)}} \\
     \hline
     \end{array}$$
   - **Offset Functions:**
     - `LAG(salary, 1)`: Accesses previous row's salary.
     - `LEAD(salary, 1)`: Accesses next row's salary.
2. **Slide 2 (`ordering`):** Provide 5 steps of evaluating `SUM(sales) OVER (PARTITION BY store_id ORDER BY sale_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)`: (1) query engine partitions full result set into distinct store_id slices, (2) sort rows within each store partition by ascending sale_date, (3) for Row 1 (first sale date), running total is simply Row 1 sales amount, (4) for Row 2, running sum evaluates Row 1 + Row 2 sales amounts, (5) continue accumulating prior rows through current row for all records, preserving every individual sale row in output!
3. **Slide 3 (`matching`):** Pair 4 window concepts (PARTITION BY, ROW_NUMBER(), DENSE_RANK(), LAG()) with their roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of the DENSE_RANK function. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on tracing ranking functions on tied scores: Four students receive exam scores: Alice (95), Bob (95), Charlie (90), David (85). What are the outputs produced by `RANK()` and `DENSE_RANK()` respectively when ordered by `score DESC`? (`RANK()` yields Alice: 1, Bob: 1, Charlie: 3, David: 4 (skips rank 2); `DENSE_RANK()` yields Alice: 1, Bob: 1, Charlie: 2, David: 3 (no rank skip); thus output is **RANK: [1, 1, 3, 4] and DENSE_RANK: [1, 1, 2, 3]**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "sql_window_functions_ranking_and_lead_lag",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: SQL Window Functions (ANSI SQL:2003)**\n• **Core Syntax (Learning SQL Chapter 13):**\n$$\n\\mathbf{\\text{FUNCTION}() \\ \\mathbf{\\text{OVER}} \\ (\\mathbf{\\text{PARTITION BY }} \\text{category} \\ \\mathbf{\\text{ORDER BY }} \\text{val} \\ [\\text{frame}])}\n$$\n• **The Non-Collapsing Invariant:** Unlike `GROUP BY` which collapses rows, window functions compute aggregate values while **preserving every original individual row**!\n• **Ranking Comparison Matrix (Scores: 100, 100, 90, 80):**\n$$\n\\begin{array}{|l|c|l|}\n\\hline\n\\textbf{Function} & \\textbf{Output Ranks} & \\textbf{Tie Handling Semantic} \\\\\n\\hline\n\\mathbf{\\text{ROW\\_NUMBER}()} & \\mathbf{1, \\ 2, \\ 3, \\ 4} & \\text{Strictly monotonic sequence (arbitrary order on tie)} \\\\\n\\mathbf{\\text{RANK}()} & \\mathbf{1, \\ 1, \\ 3, \\ 4} & \\mathbf{\\text{Ties share rank; SKIPS subsequent numbers (creates gap)}} \\\\\n\\mathbf{\\text{DENSE\\_RANK}()} & \\mathbf{1, \\ 1, \\ 2, \\ 3} & \\mathbf{\\text{Ties share rank; NO gaps created (consecutive ranks)}} \\\\\n\\hline\n\\end{array}\n$$\n• **Offset Functions:** `LAG(col, 1)` (look behind) and `LEAD(col, 1)` (look ahead) for period-over-period delta calculation!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of computing a cumulative running sales total: SUM(amt) OVER (PARTITION BY region ORDER BY date).",
      "orderItems": [
        "Divide the result set into independent data partitions based on the PARTITION BY region column",
        "Sort all records within each regional partition into chronological order using ORDER BY date",
        "Initialize cumulative accumulator to 0 for each new regional partition boundary encountered",
        "For each record, evaluate the window frame: compute sum of amounts from UNBOUNDED PRECEDING up to CURRENT ROW",
        "Attach the computed cumulative running total to the current row without collapsing the source records"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each SQL Window Function / Clause to its exact analytical behavior.",
      "matchPairs": [
        { "left": "PARTITION BY Clause", "right": "Subdivides the query result set into independent window groups where calculations reset" },
        { "left": "ROW_NUMBER() Function", "right": "Assigns a strictly unique, sequential integer (1, 2, 3, ...) to each row within its partition" },
        { "left": "DENSE_RANK() Function", "right": "Assigns identical ranks to tied values without skipping any subsequent ranking numbers" },
        { "left": "LAG(col, 1) Function", "right": "Fetches the value of a column from the preceding row within the current window partition" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The window ranking function that assigns the same rank to tied scores without skipping numbers is ___.",
      "blankAnswer": "DENSE_RANK",
      "blankDistractors": ["RANK", "ROW_NUMBER", "NTILE"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Four students receive the following exam scores: Alice (95), Bob (95), Charlie (90), and David (85). What are the exact rank values assigned to these four students by RANK() and DENSE_RANK() respectively when ordered by score DESC?",
      "options": [
        { "text": "RANK() produces [Alice: 1, Bob: 1, Charlie: 3, David: 4]; DENSE_RANK() produces [Alice: 1, Bob: 1, Charlie: 2, David: 3]; RANK() creates a gap after the tied rank 1 by skipping rank 2, whereas DENSE_RANK() assigns consecutive ranks without gaps", "isCorrect": true, "explanation": "Correct! This is the defining distinction between `RANK()` and `DENSE_RANK()` in SQL (Alan Beaulieu *Learning SQL* Chapter 13; Silberschatz Section 5.5). 1. **Given scores in descending order:** - Alice: 95 - Bob: 95 (Tie!) - Charlie: 90 - David: 85 2. **Evaluating `RANK()`:** - Alice gets Rank 1. - Bob has the same score (95), so Bob ALSO gets Rank 1. - Because two people tied for 1st place, Rank 2 is SKIPPED! - Charlie gets Rank 3. - David gets Rank 4. - Result for `RANK()`: `[1, 1, 3, 4]`. 3. **Evaluating `DENSE_RANK()`:** - Alice gets Rank 1. - Bob has the same score (95), so Bob ALSO gets Rank 1. - `DENSE_RANK()` NEVER skips numbers! - Charlie gets the next sequential integer: Rank 2. - David gets Rank 3. - Result for `DENSE_RANK()`: `[1, 1, 2, 3]`. 4. Symmetrically, `ROW_NUMBER()` would arbitrarily assign `[1, 2, 3, 4]`." },
        { "text": "RANK() produces [1, 2, 3, 4] and DENSE_RANK() produces [1, 1, 1, 1]", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "RANK() produces [1, 1, 2, 3] and DENSE_RANK() produces [1, 1, 3, 4]", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Both RANK() and DENSE_RANK() produce [1, 1, 1, 1]", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
