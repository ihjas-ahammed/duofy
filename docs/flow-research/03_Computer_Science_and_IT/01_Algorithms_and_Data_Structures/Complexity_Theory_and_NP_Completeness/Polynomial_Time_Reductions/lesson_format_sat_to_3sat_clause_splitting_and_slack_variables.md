# Duofy Reusable Lesson Format: SAT to 3-SAT (Clause Splitting and Slack Variables)

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Complexity_Theory_and_NP_Completeness / Polynomial_Time_Reductions`  
**Lesson Format Type:** `sat_to_3sat_clause_splitting_and_slack_variables`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the algebraic clause transformations, auxiliary slack (dummy) variable chaining, and equivalence preservation of the foundational $\text{SAT} \le_P \text{3-SAT}$ reduction (Stephen A. Cook 1971; Richard M. Karp 1972; Michael Sipser; Thomas H. Cormen et al. CLRS Chapter 34): master the conversion of an arbitrary CNF formula $\phi$ into an exact 3-CNF formula $\phi'$ where each clause contains exactly 3 distinct literals, analyze the 4 clause length cases (**Case 1: $k=1$ literal $(l_1) \implies (l_1 \lor y_1 \lor y_2) \land (l_1 \lor \neg y_1 \lor y_2) \land (l_1 \lor y_1 \lor \neg y_2) \land (l_1 \lor \neg y_1 \lor \neg y_2)$**, **Case 2: $k=2$ literals $(l_1 \lor l_2) \implies (l_1 \lor l_2 \lor y_1) \land (l_1 \lor l_2 \lor \neg y_1)$**, **Case 3: $k=3$ literals [unchanged]**, and **Case 4: $k \ge 4$ literals [chain splitting using $k-3$ slack variables $(l_1 \lor l_2 \lor y_1) \land (\neg y_1 \lor l_3 \lor y_2) \dots \land (\neg y_{k-3} \lor l_{k-1} \lor l_k)$]**), and prove bi-directional equisatisfiability.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | SAT to 3-SAT Clause Splitting & Slack Variable Chaining Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Splitting of a 5-Literal Clause into 3-SAT Chains Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Original Clause Length k & 3-CNF Equivalent Construction Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Number of New 3-Literal Clauses Produced from a k-Literal Clause (k - 2) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Proof Why Slack Variables Enforce Equisatisfiability Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State The SAT to 3-SAT Reduction ($\text{SAT} \le_P 3\text{-SAT}$) (Cook 1971; Karp 1972; CLRS):
   - **The Objective:** Transform any CNF formula $\phi = C_1 \land \dots \land C_m$ with arbitrary clause lengths into an equisatisfiable formula $\phi'$ where every clause has **EXACTLY 3 literals**.
   - **The 4 Clause Transformation Rules:**
     1. **1-Literal Clause ($C = l_1$):** Add 2 slack variables $y_1, y_2$:
        $$\mathbf{(l_1 \lor y_1 \lor y_2) \land (l_1 \lor \neg y_1 \lor y_2) \land (l_1 \lor y_1 \lor \neg y_2) \land (l_1 \lor \neg y_1 \lor \neg y_2)}$$
     2. **2-Literal Clause ($C = l_1 \lor l_2$):** Add 1 slack variable $y_1$:
        $$\mathbf{(l_1 \lor l_2 \lor y_1) \land (l_1 \lor l_2 \lor \neg y_1)}$$
     3. **3-Literal Clause ($C = l_1 \lor l_2 \lor l_3$):** Keep unchanged.
     4. **$k$-Literal Clause ($k \ge 4, \ C = l_1 \lor l_2 \lor \dots \lor l_k$):** Split using **$k-3$ slack variables ($y_1, \dots, y_{k-3}$)** into **$k-2$ 3-literal clauses**:
        $$\mathbf{(l_1 \lor l_2 \lor y_1) \land (\neg y_1 \lor l_3 \lor y_2) \land (\neg y_2 \lor l_4 \lor y_3) \dots \land (\neg y_{k-3} \lor l_{k-1} \lor l_k)}$$
   - **Equisatisfiability Theorem:** $\phi$ is satisfiable $\iff \phi'$ is satisfiable!
2. **Slide 2 (`ordering`):** Provide 5 steps of transforming a 5-literal clause $C = (x_1 \lor x_2 \lor x_3 \lor x_4 \lor x_5)$ into 3-CNF format: (1) count the number of literals k = 5, determining that k - 3 = 2 new slack variables (y1, y2) and k - 2 = 3 new 3-literal clauses are required, (2) form the first 3-literal clause by combining the first two original literals with the first positive slack variable: (x1 or x2 or y1), (3) form the middle 3-literal clause by chaining the negated previous slack variable with the middle original literal and next positive slack variable: (not y1 or x3 or y2), (4) form the final 3-literal clause by combining the negated second slack variable with the remaining two original literals: (not y2 or x4 or x5), (5) take the conjunction of all three 3-literal clauses to produce the equisatisfiable 3-CNF formula!
3. **Slide 3 (`matching`):** Pair 4 clause transformation cases (k=1 literal, k=2 literals, k=3 literals, k=k literals with k>=4) with their 3-CNF expansions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that a clause with k literals is split into exactly k minus 2 clauses in 3-CNF. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on how slack variables guarantee that a split clause is satisfied if and only if the original clause is satisfied: Why does the clause chain $(l_1 \lor l_2 \lor y_1) \land (\neg y_1 \lor l_3 \lor y_2) \land (\neg y_2 \lor l_4 \lor l_5)$ evaluate to False whenever all original literals $(l_1, l_2, l_3, l_4, l_5)$ are False, regardless of how the slack variables $y_1, y_2$ are assigned? (If all original literals are False, the chain collapses to $(y_1) \land (\neg y_1 \lor y_2) \land (\neg y_2)$; **to satisfy the first clause, $y_1$ must be True; which forces $y_2$ to be True to satisfy the second clause ($\neg y_1 \lor y_2$), which makes the final clause $(\neg y_2)$ False, creating a contradiction**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "sat_to_3sat_clause_splitting_and_slack_variables",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: SAT to 3-SAT Reduction ($SAT \\le_P 3\\text{-SAT}$)**\n• **Clause Splitting ($k \\ge 4$ Literals):**\n$$\nC = (l_1 \\lor l_2 \\lor \\dots \\lor l_k) \\implies \\mathbf{k-3 \\text{ Slack Variables } (y_1, \\dots, y_{k-3})} \\ \\& \\ \\mathbf{k-2 \\text{ Clauses}}\n$$\n$$\n\\mathbf{(l_1 \\lor l_2 \\lor y_1) \\ \\land \\ (\\neg y_1 \\lor l_3 \\lor y_2) \\ \\land \\ (\\neg y_2 \\lor l_4 \\lor y_3) \\dots \\land \\ (\\neg y_{k-3} \\lor l_{k-1} \\lor l_k)}\n$$\n• **Short Clauses ($k < 3$):**\n  - **$k=2$:** $(l_1 \\lor l_2) \\implies \\mathbf{(l_1 \\lor l_2 \\lor y_1) \\land (l_1 \\lor l_2 \\lor \\neg y_1)}$.\n  - **$k=1$:** $(l_1) \\implies \\mathbf{4 \\text{ clauses with all sign combinations of } (y_1, y_2)}$.\n• **Equisatisfiability:** $\\phi \\text{ is Satisfiable} \\iff \\phi' \\text{ is Satisfiable in } O(|\\phi|)$ time!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of splitting a 5-literal clause C = (x1 v x2 v x3 v x4 v x5) into an equisatisfiable 3-CNF clause chain.",
      "orderItems": [
        "Count the clause length k = 5, establishing that k - 3 = 2 slack variables (y1, y2) and k - 2 = 3 clauses are required",
        "Form the initial 3-literal clause using the first two literals and positive y1: (x1 v x2 v y1)",
        "Form the intermediate bridging clause combining negated y1, literal x3, and positive y2: (not y1 v x3 v y2)",
        "Form the final terminating clause using negated y2 and the last two original literals: (not y2 v x4 v x5)",
        "Conjoin the three generated clauses with logical AND to produce the polynomial equisatisfiable 3-CNF formula"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each original CNF clause structure to its exact 3-CNF equivalent construction.",
      "matchPairs": [
        { "left": "Clause with k = 1 Literal (l1)", "right": "Expands into 4 3-literal clauses covering all 4 truth assignments of dummy pair (y1, y2)" },
        { "left": "Clause with k = 2 Literals (l1 v l2)", "right": "Expands into 2 3-literal clauses: (l1 v l2 v y1) and (l1 v l2 v not y1)" },
        { "left": "Clause with k = 3 Literals", "right": "Remains unchanged as it already satisfies the 3-CNF format" },
        { "left": "Clause with k >= 4 Literals", "right": "Chains into (k - 2) 3-literal clauses using (k - 3) auxiliary slack variables" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the SAT to 3-SAT reduction, an arbitrary clause containing k literals is split into a chain of exactly k minus ___ 3-literal clauses.",
      "blankAnswer": "2",
      "blankDistractors": ["1", "3", "0"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the chained 3-CNF formula (l1 v l2 v y1) ^ (not y1 v l3 v y2) ^ (not y2 v l4 v l5) guaranteed to evaluate to False whenever all original literals (l1, l2, l3, l4, l5) are assigned False?",
      "options": [
        { "text": "Setting all original literals to False reduces the chain to (y1) ^ (not y1 v y2) ^ (not y2); to satisfy the first clause, y1 must be True; which forces y2 to be True to satisfy the second clause; which inevitably causes the third clause (not y2) to evaluate to False, creating an unavoidable contradiction", "isCorrect": true, "explanation": "Correct! This is the exact mathematical proof that the slack variable gadget cannot create false positives. Let all original literals be assigned False: $l_1 = l_2 = l_3 = l_4 = l_5 = \\text{False}$. Substituting these values into the 3-CNF chain: Clause 1: $(0 \\lor 0 \\lor y_1) \\implies y_1$. For Clause 1 to be True, we MUST choose $y_1 = \\text{True}$. Clause 2: $(\\neg y_1 \\lor 0 \\lor y_2) \\implies (\\text{False} \\lor y_2) \\implies y_2$. Because $y_1 = \\text{True}$, $\\neg y_1 = \\text{False}$, so to make Clause 2 True, we MUST choose $y_2 = \\text{True}$. Clause 3: $(\\neg y_2 \\lor 0 \\lor 0) \\implies \\neg y_2$. But since we were forced to set $y_2 = \\text{True}$, $\\neg y_2 = \\text{False}$! Therefore, Clause 3 evaluates to False, making the entire conjunction False. No matter what truth values are assigned to $y_1$ and $y_2$, the formula cannot be satisfied. Conversely, if at least ONE original literal $l_i$ is True, one can easily set the slack variables to propagate True across all clauses. Thus, the reduction is 100% equisatisfiable." },
        { "text": "Because slack variables are always set to False by the operating system", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because 3-CNF formulas with 3 clauses are always False", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because conjunctions cannot evaluate to True in boolean logic", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
