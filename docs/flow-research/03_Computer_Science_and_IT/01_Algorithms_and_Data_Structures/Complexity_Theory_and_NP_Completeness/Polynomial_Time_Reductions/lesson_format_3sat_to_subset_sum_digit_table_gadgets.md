# Duofy Reusable Lesson Format: 3-SAT to Subset Sum (Digit Table Gadgets)

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Complexity_Theory_and_NP_Completeness / Polynomial_Time_Reductions`  
**Lesson Format Type:** `3sat_to_subset_sum_digit_table_gadgets`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the number-theoretic reduction, base-10 digit column gadgets, and carry-free arithmetic of the classic $3\text{-SAT} \le_P \text{Subset Sum}$ reduction (Richard M. Karp 1972; Michael Sipser; Thomas H. Cormen et al. CLRS Chapter 34): master the construction of large integer instances of total length $n + m$ digits (where $n$ is the number of Boolean variables and $m$ is the number of 3-CNF clauses), formulate the **Variable Selection Rows ($v_i, v_i'$)** enforcing that exactly one literal ($x_i$ or $\neg x_i$) is chosen per variable ($v_i + v_i' = 1$ in column $x_i$), formulate the **Clause Slack Rows ($s_j, s_j'$)** absorbing excess satisfied literals ($1, 2, \text{ or } 3$ true literals in clause $C_j$), establish the **Target Sum $\mathbf{T = 11\dots133\dots3}$** ($n$ ones followed by $m$ threes), and prove why using base-10 arithmetic prevents carry overflows between columns.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | 3-SAT to Subset Sum Base-10 Digit Table & Target T Formulation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Construction of the Subset Sum Integer Table Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Subset Sum Table Row Type & Arithmetic Gadget Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Target Digit Value Assigned to Each Clause Column in Target Sum T Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Mathematical Reason Base 10 is Used to Prevent Column Carry Invalidation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State The 3-SAT to Subset Sum Reduction ($3\text{-SAT} \le_P \text{SUBSET-SUM}$) (Karp 1972; CLRS):
   - **The Objective:** Given 3-CNF formula $\phi$ with $n$ variables $x_1 \dots x_n$ and $m$ clauses $C_1 \dots C_m$, construct a set of integers $S$ and target $T$ such that a subset sums to $T \iff \phi$ is satisfiable.
   - **The $(n + m)$-Digit Table Construction (Base 10):**
     $$\begin{array}{|l|c|c|c|c|c|c|}
     \hline
     \textbf{Row Name} & x_1 & \dots & x_n & C_1 & \dots & C_m \\
     \hline
     \mathbf{v_i \ (x_i)} & 1 & 0 & 0 & 1 & 0 & 0 \quad (\text{'1' if } x_i \in C_j) \\
     \mathbf{v_i' \ (\neg x_i)} & 1 & 0 & 0 & 0 & 1 & 0 \quad (\text{'1' if } \neg x_i \in C_j) \\
     \hline
     \mathbf{s_j \ (\text{Slack 1})} & 0 & 0 & 0 & 1 & 0 & 0 \\
     \mathbf{s_j' \ (\text{Slack 2})} & 0 & 0 & 0 & 2 & 0 & 0 \\
     \hline
     \mathbf{\text{Target } T} & \mathbf{1} & \mathbf{1} & \mathbf{1} & \mathbf{3} & \mathbf{3} & \mathbf{3} \\
     \hline
     \end{array}$$
   - **Why Target Digits are $1$ and $3$:**
     - Variable columns: Sum must be **$1$** $\implies$ Pick either $v_i$ (True) OR $v_i'$ (False), never both!
     - Clause columns: Variable choices contribute **$1, 2, \text{ or } 3$** satisfied literals. Using slack rows $s_j \in \{0, 1\}$ and $s_j' \in \{0, 2\}$, we can always reach the target sum **$3$** if and only if at least ONE literal in $C_j$ is True!
2. **Slide 2 (`ordering`):** Provide 5 steps of the 3-SAT to Subset Sum reduction: (1) count n variables and m clauses in the 3-CNF formula, creating an integer table of n + m decimal digit columns, (2) create two integers (v_i and v_i') for each variable x_i with a 1 in column x_i and 1s in clause columns where the literal appears, (3) create two slack integers (s_j with 1 and s_j' with 2 in column C_j) for each clause C_j, (4) construct the target integer T with 1s in all n variable columns and 3s in all m clause columns (T = 11...133...3), (5) output the set of 2n + 2m integers and target T, completing the polynomial-time reduction!
3. **Slide 3 (`matching`):** Pair 4 elements of the digit table gadget (Variable Row v_i, Slack Rows s_j & s_j', Variable Columns Target = 1, Clause Columns Target = 3) with their mathematical roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the target digit value for all clause columns in the 3-SAT to Subset Sum reduction is 3. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why base 10 (or any base $\ge 6$) is required instead of binary base 2 in the Subset Sum table: Why does the reduction from 3-SAT to Subset Sum require the constructed numbers to be represented in Base 10 (or a base greater than 5) rather than standard binary Base 2? (Because each clause column can receive up to $1 + 1 + 1 + 1 + 2 = 6$ from its literal and slack rows; in Base 10, **the sum of any column is at most 6, which is strictly less than 10, mathematically guaranteeing ZERO CARRIES between adjacent columns**; in binary Base 2, column carries would spill into neighboring variable columns and corrupt the truth assignment logic).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "3sat_to_subset_sum_digit_table_gadgets",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: 3-SAT to Subset Sum Reduction (Karp 1972)**\n• **The $(n + m)$-Digit Table Gadget (Base 10):**\n$$\n\\begin{array}{|l|c|c|c|c|}\n\\hline\n\\textbf{Integer Row} & \\text{Var Cols } (x_1 \\dots x_n) & \\text{Clause Cols } (C_1 \\dots C_m) \\\\\n\\hline\n\\mathbf{v_i \\ (x_i)} & 1 \\text{ at col } x_i & 1 \\text{ if } x_i \\in C_j \\\\\n\\mathbf{v_i' \\ (\\neg x_i)} & 1 \\text{ at col } x_i & 1 \\text{ if } \\neg x_i \\in C_j \\\\\n\\mathbf{s_j, s_j' \\ (\\text{Slacks})} & 0 & 1 \\text{ and } 2 \\text{ at col } C_j \\\\\n\\hline\n\\mathbf{\\text{Target } T} & \\mathbf{11\\dots1} & \\mathbf{33\\dots3} \\\\\n\\hline\n\\end{array}\n$$\n• **The 2 Structural Invariants:**\n  1. **Variable Columns ($T=1$):** Forces choosing **$v_i$ OR $v_i'$** (Never both!).\n  2. **Clause Columns ($T=3$):** Variable literals contribute $1, 2, \\text{ or } 3$; slacks $\{1, 2\}$ absorb remainder to hit **$3$** $\\iff$ Clause is Satisfied!\n• **Zero Carry Rule:** Max column sum is $1+1+1+1+2 = 6 < 10$ $\\implies$ **No carries**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of constructing the Subset Sum instance from a 3-CNF formula phi.",
      "orderItems": [
        "Count n variables and m clauses, defining numbers with n + m total decimal digit columns in base 10",
        "Generate 2n variable integers (v_i, v_i') with a 1 in column x_i and 1s in clause columns containing the literal",
        "Generate 2m slack integers (s_j, s_j') with values 1 and 2 in clause column C_j and 0s elsewhere",
        "Formulate the target sum integer T with digit 1 in all n variable columns and digit 3 in all m clause columns",
        "Output the collection of 2n + 2m constructed integers along with target integer T in polynomial time"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Subset Sum reduction component to its exact arithmetic purpose.",
      "matchPairs": [
        { "left": "Variable Columns (Target = 1)", "right": "Forces the subset to pick exactly one of v_i (True) or v_i' (False) per boolean variable" },
        { "left": "Clause Columns (Target = 3)", "right": "Requires at least one literal to be True so slack variables {1, 2} can reach the target sum of 3" },
        { "left": "Slack Integers (s_j=1, s_j'=2)", "right": "Absorbs surplus satisfied literals (1, 2, or 3 true literals) to always hit target sum 3" },
        { "left": "Base 10 Number Representation", "right": "Prevents arithmetic carries from overflowing and corrupting neighboring column values" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the 3-SAT to Subset Sum reduction, the required target digit value for all clause columns in target integer T is ___.",
      "blankAnswer": "3",
      "blankDistractors": ["1", "10", "2"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is it strictly necessary to represent the constructed integers in Base 10 (or any base greater than 5) rather than standard binary Base 2 in the 3-SAT to Subset Sum reduction?",
      "options": [
        { "text": "In any clause column, the maximum possible sum of the 3 literal rows and 2 slack rows is 1 + 1 + 1 + 1 + 2 = 6; by using Base 10, the maximum column sum (6) is strictly smaller than the base (10), guaranteeing that ZERO carries ever occur between adjacent columns (which would otherwise spill into neighboring variable columns and invalidate the boolean logic)", "isCorrect": true, "explanation": "Correct! This is the most crucial mathematical subtlety in the arithmetic encoding of 3-SAT into Subset Sum. In standard integer addition, if a column sum reaches or exceeds the base $B$, it produces a carry digit that propagates into the higher-order column to its left. In our reduction table, each column represents an isolated, independent logical condition (the first $n$ columns enforce variable consistency, while the last $m$ columns enforce clause satisfaction). If arithmetic carries were permitted to occur, a clause column with a sum of 2 in binary (Base 2) would produce a carry of 1 into the neighboring column, artificially altering the sum of that neighboring column and breaking the 1-to-1 correspondence with the boolean formula. In our table, the maximum possible entries that could ever be summed in a clause column is: 3 (if all 3 literals in the clause are True) + 1 (slack 1) + 2 (slack 2) = 6. By choosing Base 10 (where $6 < 10$), every single column addition is completely independent and self-contained with zero carries!" },
        { "text": "Because computers can only store numbers in base 10", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Subset Sum is solvable in polynomial time in base 2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because 3-SAT only uses base 10 numbers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
