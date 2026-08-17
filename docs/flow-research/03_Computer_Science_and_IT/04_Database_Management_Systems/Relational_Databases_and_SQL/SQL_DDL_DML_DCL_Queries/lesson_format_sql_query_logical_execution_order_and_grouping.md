# Duofy Reusable Lesson Format: SQL Query Logical Execution Order and Grouping

**Target Topic:** `03_Computer_Science_and_IT / 04_Database_Management_Systems / Relational_Databases_and_SQL / SQL_DDL_DML_DCL_Queries`  
**Lesson Format Type:** `sql_query_logical_execution_order_and_grouping`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the relational algebra execution stages, clause processing pipelines, and aggregation filtering rules of SQL query engines (Donald D. Chamberlin & Raymond F. Boyce 1974; Alan Beaulieu *Learning SQL* Chapter 3; Silberschatz et al. Chapter 3): master the **Canonical 8-Step Logical Query Execution Order** (**1. `FROM / JOIN`**, **2. `WHERE` [row filtering]**, **3. `GROUP BY` [vector partitioning]**, **4. `HAVING` [group aggregate filtering]**, **5. `SELECT` [projection & alias creation]**, **6. `DISTINCT` [duplicate deduplication]**, **7. `ORDER BY` [sorting]**, and **8. `LIMIT / OFFSET` [pagination]**), understand why **column aliases declared in `SELECT` cannot be referenced in `WHERE`** (because `WHERE` executes at Step 2 while aliases are created at Step 5), and contrast **`WHERE` vs `HAVING`** semantics.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The 8-Step Logical Execution Order Pipeline, WHERE vs HAVING, & Alias Scope Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Logical Query Execution Pipeline for Complex Aggregate Query Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | SQL Clause & Logical Execution Phase / Processing Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the SQL Clause Used Exclusively to Filter Aggregated Groups After GROUP BY (HAVING) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Architectural Reason Why SELECT Column Aliases Cause Syntax Errors in WHERE Clauses Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State SQL Logical Execution Order (Beaulieu *Learning SQL* Chapter 3; Silberschatz 3):
   - **The 8-Step Logical Processing Pipeline:**
     $$\mathbf{\mathbf{1. \ FROM / JOIN} \ \longrightarrow \ \mathbf{2. \ WHERE} \ \longrightarrow \ \mathbf{3. \ GROUP \ BY} \ \longrightarrow \ \mathbf{4. \ HAVING} \ \longrightarrow \ \mathbf{5. \ SELECT} \ \longrightarrow \ \mathbf{6. \ DISTINCT} \ \longrightarrow \ \mathbf{7. \ ORDER \ BY} \ \longrightarrow \ \mathbf{8. \ LIMIT / OFFSET}}$$
   - **`WHERE` vs `HAVING` Invariant:**
     - `WHERE` executes at Step 2: Filters individual source table rows *before* grouping (CANNOT use aggregate functions like `SUM()` or `AVG()`!).
     - `HAVING` executes at Step 4: Filters grouped summary rows *after* aggregation (`HAVING COUNT(*) > 5`).
   - **Alias Visibility Rule:**
     - Aliases created in `SELECT` (Step 5) ARE visible in `ORDER BY` (Step 7), but are **COMPLETELY INVISIBLE in `WHERE` (Step 2)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of the SQL engine processing `SELECT dept, AVG(salary) AS avg_sal FROM Emp WHERE age > 25 GROUP BY dept HAVING AVG(salary) > 50000 ORDER BY avg_sal DESC LIMIT 5`: (1) FROM clause loads 'Emp' table into memory, (2) WHERE clause filters rows where age > 25, discarding younger employees, (3) GROUP BY clause partitions remaining rows into department buckets, (4) HAVING clause evaluates AVG(salary) > 50000 on each group, discarding low-paying departments, (5) SELECT computes final expressions and sets alias 'avg_sal', followed by ORDER BY avg_sal DESC and LIMIT 5!
3. **Slide 3 (`matching`):** Pair 4 SQL clauses (FROM/JOIN, WHERE, GROUP BY, HAVING) with their logical execution roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that HAVING filters grouped rows. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on alias scoping: A software developer writes the SQL query: `SELECT unit_price * quantity AS total_cost FROM Orders WHERE total_cost > 1000;`. Why does the database query engine reject this query with a syntax error stating 'column total_cost does not exist'? (Because in the logical SQL execution pipeline, the **`WHERE` clause (Step 2) is evaluated BEFORE the `SELECT` clause (Step 5)**; when the query engine processes `WHERE total_cost > 1000`, the column alias `total_cost` has not yet been computed or registered in the execution scope; the condition must be written as `WHERE unit_price * quantity > 1000`).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "sql_query_logical_execution_order_and_grouping",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Logical SQL Query Execution Pipeline**\n• **The 8-Step Engine Processing Pipeline (Learning SQL Chapter 3):**\n$$\n\\mathbf{\\mathbf{1. \\ FROM/JOIN} \\ \\longrightarrow \\ \\mathbf{2. \\ WHERE} \\ \\longrightarrow \\ \\mathbf{3. \\ GROUP \\ BY} \\ \\longrightarrow \\ \\mathbf{4. \\ HAVING} \\ \\longrightarrow \\ \\mathbf{5. \\ SELECT} \\ \\longrightarrow \\ \\mathbf{6. \\ DISTINCT} \\ \\longrightarrow \\ \\mathbf{7. \\ ORDER \\ BY} \\ \\longrightarrow \\ \\mathbf{8. \\ LIMIT}}\n$$\n• **WHERE vs HAVING Invariant:**\n  - **`WHERE` (Step 2):** Filters individual raw table rows **BEFORE grouping** (cannot use `SUM`, `AVG`, `COUNT`!).\n  - **`HAVING` (Step 4):** Filters aggregated summary records **AFTER grouping** (`HAVING COUNT(*) >= 2`).\n• **Alias Scoping Rule:** Column aliases defined in `SELECT` (Step 5) are available in `ORDER BY` (Step 7), but **CAUSE SYNTAX ERRORS IN `WHERE` (Step 2)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential logical execution stages evaluated by the database engine for an aggregated SQL query.",
      "orderItems": [
        "FROM & JOIN: identify source tables, evaluate join predicates, and construct intermediate virtual Cartesian dataset",
        "WHERE: evaluate row-level filter conditions on individual tuples, discarding non-qualifying base rows",
        "GROUP BY: partition the filtered rows into distinct categorical grouping buckets based on grouping keys",
        "HAVING: apply group-level aggregate filter conditions (e.g. SUM, COUNT) to discard non-qualifying grouped buckets",
        "SELECT & ORDER BY: compute projected column expressions, apply aliases, deduplicate DISTINCT rows, and sort output"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each SQL Clause to its exact Logical Execution Phase.",
      "matchPairs": [
        { "left": "FROM / JOIN (Phase 1)", "right": "Identifies physical base tables and performs relational join multiplications into working dataset" },
        { "left": "WHERE (Phase 2)", "right": "Applies boolean filtering predicates to individual raw tuples before any grouping occurs" },
        { "left": "GROUP BY (Phase 3)", "right": "Collapses multiple rows sharing identical key values into single aggregate summary groups" },
        { "left": "HAVING (Phase 4)", "right": "Filters summarized group buckets based on aggregate function computations (e.g. AVG > 500)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The SQL clause used to filter aggregated group records after the GROUP BY stage is ___.",
      "blankAnswer": "HAVING",
      "blankDistractors": ["WHERE", "FILTER", "QUALIFY"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A developer writes the query: SELECT unit_price * quantity AS total_cost FROM Sales WHERE total_cost > 500;. Why does the relational database query engine throw a syntax error stating 'column total_cost does not exist'?",
      "options": [
        { "text": "Because in the logical SQL execution pipeline, the WHERE clause (Step 2) is evaluated BEFORE the SELECT clause (Step 5); when the database evaluates 'WHERE total_cost > 500', the SELECT clause has not yet been executed, meaning the alias 'total_cost' does not exist in the execution scope; the condition must be written as 'WHERE unit_price * quantity > 500'", "isCorrect": true, "explanation": "Correct! This is one of the most famous and fundamental rules of SQL execution architecture (Alan Beaulieu *Learning SQL* Chapter 3; Silberschatz Chapter 3). 1. **Written Order vs Execution Order:** - We write queries starting with `SELECT`, then `FROM`, then `WHERE`. - BUT the database engine processes them in **Logical Execution Order**: 1. `FROM` $\\to$ 2. `WHERE` $\\to$ 3. `GROUP BY` $\\to$ 4. `HAVING` $\\to$ 5. `SELECT` $\\to$ 6. `ORDER BY`. 2. **Tracing the Bug:** - Step 1: The database loads rows from table `Sales`. - Step 2: The database evaluates `WHERE total_cost > 500`. The engine searches the `Sales` table metadata for a column named `total_cost`. No such column exists! - Step 5 (which creates the alias `total_cost` via `SELECT unit_price * quantity AS total_cost`) has NOT occurred yet! 3. Therefore, referencing a `SELECT` alias in `WHERE` triggers a fatal compilation error. (In contrast, `ORDER BY` executes at Step 7, so using `ORDER BY total_cost` is 100% valid!)." },
        { "text": "Because SQL does not allow multiplication arithmetic inside SELECT statements", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because total_cost is a reserved SQL keyword", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because WHERE clauses only accept string comparisons", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
