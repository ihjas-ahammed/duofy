# Duofy Reusable Lesson Format: Advanced SQL Joins and Correlated Subqueries

**Target Topic:** `03_Computer_Science_and_IT / 04_Database_Management_Systems / Relational_Databases_and_SQL / SQL_DDL_DML_DCL_Queries`  
**Lesson Format Type:** `advanced_sql_joins_and_correlated_subqueries`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the relational algebra implementations, set-theoretic intersections, and nested query optimizations of advanced SQL joins and correlated subqueries (Alan Beaulieu *Learning SQL* Chapters 5 & 9; Silberschatz et al. Chapters 3.5 & 4): master the **SQL Join Taxonomy** (**`INNER JOIN` [Strict Intersection]**, **`LEFT (OUTER) JOIN` [All Left + Matched Right with NULL padding]**, **`RIGHT JOIN`**, **`FULL OUTER JOIN`**, **`CROSS JOIN` [Cartesian Product $|A| \times |B|$]**, and **`SELF JOIN` [Hierarchical trees via table aliases]**), evaluate **Correlated Subqueries** (inner subqueries referencing outer query row variables, executing conceptually per outer tuple), contrast **`EXISTS` vs `IN`** (short-circuit boolean semi-joins vs full materialization lists; NULL handling differences with `NOT IN`), and write optimized anti-joins (`LEFT JOIN ... WHERE right.id IS NULL`).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | SQL Join Taxonomy, Outer Null Padding, & Correlated Subquery Invariant Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Outer-to-Inner Evaluation of a Correlated Subquery Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | SQL Join Type / Subquery Predicate & Relational Operation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the SQL Predicate That Returns True as Soon as an Inner Subquery Produces at Least One Row (EXISTS) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of the Fatal NOT IN vs NOT EXISTS Trap When Subqueries Contain NULLs Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State SQL Joins & Correlated Subqueries (Beaulieu *Learning SQL* 5 & 9):
   - **The SQL Join Matrix:**
     $$\begin{array}{|l|l|}
     \hline
     \textbf{Join Type} & \textbf{Relational Output Semantics} \\
     \hline
     \mathbf{\text{INNER JOIN}} & \text{Retains only rows where join predicate evaluates to TRUE} \\
     \mathbf{\text{LEFT JOIN}} & \text{Retains ALL left-table rows; fills right columns with NULL if no match} \\
     \mathbf{\text{FULL OUTER}} & \text{Retains all rows from both tables; pads missing sides with NULL} \\
     \mathbf{\text{CROSS JOIN}} & \mathbf{\text{Cartesian product: produces } |T_1| \times |T_2| \text{ total output rows}} \\
     \mathbf{\text{SELF JOIN}} & \text{Joins table to itself via aliases (e.g. } \text{Emp } e \ \text{JOIN Emp } m \text{ ON } e.\text{mgr\_id} = m.\text{id)} \\
     \hline
     \end{array}$$
   - **Correlated Subqueries & Short-Circuit `EXISTS`:**
     - `WHERE EXISTS (SELECT 1 FROM Orders o WHERE o.cust_id = c.id)`
     - Engine stops scanning subquery immediately upon finding the first matching row!
   - **The `NOT IN (NULL)` Disaster:** If subquery returns `{1, 2, NULL}`, `x NOT IN (...)` evaluates to `UNKNOWN` $\implies$ **Returns ZERO rows!** (Always use `NOT EXISTS`).
2. **Slide 2 (`ordering`):** Provide 5 steps of a correlated subquery finding employees earning more than their department average: (1) outer query scans first row in 'Employee' table (e.g. Alice in Dept 10), (2) outer query passes Alice's 'dept_id = 10' into correlated inner subquery, (3) inner subquery executes 'SELECT AVG(salary) FROM Employee WHERE dept_id = 10', (4) outer query compares Alice's salary against computed department average; if greater, emit row, (5) repeat steps 1-4 for every subsequent employee row in the table!
3. **Slide 3 (`matching`):** Pair 4 join/subquery types (LEFT ANTI JOIN, CROSS JOIN, Correlated EXISTS, SELF JOIN) with their operations.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of the EXISTS predicate. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on `NOT IN` with NULLs trap: In SQL, why does the query `SELECT name FROM Customer WHERE id NOT IN (SELECT customer_id FROM Blacklist);` unexpectedly return ZERO rows when the `Blacklist` table contains even a single row where `customer_id IS NULL`? (In three-valued SQL logic ($TRUE, FALSE, UNKNOWN$), `id NOT IN (1, 2, NULL)` is mathematically expanded to `id != 1 AND id != 2 AND id != NULL`; because comparing any value with NULL evaluates to `UNKNOWN`, the entire logical `AND` expression evaluates to `UNKNOWN`, which the `WHERE` clause treats as `FALSE`, resulting in **zero rows returned**; `NOT EXISTS` avoids this because it checks row existence rather than value equality).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "advanced_sql_joins_and_correlated_subqueries",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: SQL Joins & Correlated Subqueries (Learning SQL)**\n• **Relational Join Semantics:**\n$$\n\\begin{array}{|l|l|}\n\\hline\n\\textbf{Join Syntax} & \\textbf{Relational Output Mechanism} \\\\\n\\hline\n\\mathbf{\\text{INNER JOIN}} & \\text{Strict intersection: rows matching join predicate on both sides} \\\\\n\\mathbf{\\text{LEFT JOIN}} & \\mathbf{\\text{All left rows preserved; non-matching right columns populated with NULL}} \\\\\n\\mathbf{\\text{FULL JOIN}} & \\text{Full union with bidirectional NULL padding} \\\\\n\\mathbf{\\text{CROSS JOIN}} & \\mathbf{\\text{Cartesian product: } |A| \\times |B| \\text{ rows}} \\\\\n\\hline\n\\end{array}\n$$\n• **Correlated Subquery:** An inner query referencing outer row values, evaluated per outer tuple.\n• **The Fatal `NOT IN (NULL)` Trap:** If a subquery returns even a single `NULL`, `NOT IN` evaluates to `UNKNOWN` $\\implies$ **Returns ZERO rows!** (Always use `NOT EXISTS` or `LEFT JOIN ... WHERE right.id IS NULL`)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential execution steps evaluated by the query engine for a correlated subquery finding employees earning above their department average.",
      "orderItems": [
        "Outer query engine cursor fetches the first candidate tuple from the outer 'Employee e' table",
        "Outer query extracts candidate employee's dept_id and injects it into the inner correlated subquery",
        "Inner subquery executes: SELECT AVG(salary) FROM Employee WHERE dept_id = e.dept_id",
        "Outer query evaluates WHERE predicate: e.salary > computed_dept_average; if true, row is emitted to output",
        "Advance outer table cursor to the next candidate employee tuple and repeat the evaluation cycle"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each SQL Join / Subquery pattern to its exact relational behavior.",
      "matchPairs": [
        { "left": "LEFT ANTI JOIN", "right": "LEFT JOIN with WHERE right.id IS NULL to find records in table A that have zero matches in table B" },
        { "left": "CROSS JOIN", "right": "Produces the full Cartesian product combining every row in table A with every row in table B" },
        { "left": "EXISTS Subquery", "right": "Short-circuits evaluation and returns TRUE immediately upon locating the first matching inner record" },
        { "left": "SELF JOIN", "right": "Joins a table to an aliased instance of itself to model hierarchical tree and graph relationships" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The SQL predicate that returns true as soon as an inner subquery produces at least one matching row is ___.",
      "blankAnswer": "EXISTS",
      "blankDistractors": ["IN", "ANY", "ALL"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the SQL query 'SELECT name FROM Customers WHERE id NOT IN (SELECT customer_id FROM InactiveList);' unexpectedly return ZERO rows when the InactiveList table contains even a single record where customer_id IS NULL?",
      "options": [
        { "text": "Under SQL three-valued logic (TRUE, FALSE, UNKNOWN), 'id NOT IN (1, 2, NULL)' expands logically to 'id <> 1 AND id <> 2 AND id <> NULL'; because comparing any value to NULL using inequality (id <> NULL) produces UNKNOWN, the entire logical AND expression evaluates to UNKNOWN, which the WHERE filter treats as FALSE, resulting in zero rows returned; NOT EXISTS avoids this because it evaluates row existence rather than value comparison", "isCorrect": true, "explanation": "Correct! This is one of the most famous and dangerous pitfalls in SQL query development (Alan Beaulieu *Learning SQL* Chapter 9; Silberschatz Section 3.8.3). 1. **How SQL Evaluates `IN` and `NOT IN` with NULLs:** - Suppose `InactiveList` has IDs: `[10, 20, NULL]`. - The predicate `id NOT IN (10, 20, NULL)` is mathematically equivalent to: `(id <> 10) AND (id <> 20) AND (id <> NULL)`. 2. **Evaluating Three-Valued Logic:** - For any customer with `id = 5`: - `5 <> 10` $\\implies$ `TRUE`. - `5 <> 20` $\\implies$ `TRUE`. - `5 <> NULL` $\\implies$ `UNKNOWN`! (In SQL, comparing anything to NULL with `<>` or `=` yields UNKNOWN, never TRUE). - The full condition becomes: `TRUE AND TRUE AND UNKNOWN` $\\implies$ **`UNKNOWN`**! 3. **The WHERE Filter Rule:** - A `WHERE` clause ONLY returns rows where the condition evaluates strictly to `TRUE`. - Any condition evaluating to `FALSE` or `UNKNOWN` is rejected! 4. Therefore, EVERY customer in the database evaluates to `UNKNOWN` and is discarded, returning an empty result set! 5. The correct solution: Use `NOT EXISTS (SELECT 1 FROM InactiveList i WHERE i.customer_id = c.id)` or add `WHERE customer_id IS NOT NULL`." },
        { "text": "Because NOT IN only works with string characters", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because subqueries in SQL cannot contain more than 1 row", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because NULL values automatically delete foreign keys", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
