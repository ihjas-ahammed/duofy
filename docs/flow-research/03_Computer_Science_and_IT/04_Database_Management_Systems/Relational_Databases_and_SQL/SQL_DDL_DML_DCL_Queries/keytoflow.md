# Key to Flow: SQL DDL, DML, DCL Queries (Execution Order, Joins, Window Functions, & TCL)

**Subject Area:** `03_Computer_Science_and_IT / 04_Database_Management_Systems / Relational_Databases_and_SQL / SQL_DDL_DML_DCL_Queries`

---

## 📌 Core Concept & Mental Model
**Declarative Relational Algebra Mapping, The 8-Step Logical Query Execution Pipeline, Correlated Subquery Existence Predicates (`EXISTS` vs `IN`), Sliding Partition Analytical Window Functions, and Atomic Transaction Controls** govern relational database querying and schema manipulation (Donald D. Chamberlin & Raymond F. Boyce SQL/SEQUEL 1974; ANSI/ISO SQL Standard; Alan Beaulieu *Learning SQL*; Silberschatz Chapters 3–5):
* **1. The 4 SQL Sublanguage Families:**
  - **DDL (Data Definition Language):** Schema structure (`CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME`). (Auto-commits in most engines!).
  - **DML (Data Manipulation Language):** Data content (`SELECT`/DQL, `INSERT`, `UPDATE`, `DELETE`, `MERGE`).
  - **DCL (Data Control Language):** Security & Permissions (`GRANT`, `REVOKE`).
  - **TCL (Transaction Control Language):** ACID Boundaries (`COMMIT`, `ROLLBACK`, `SAVEPOINT`).
* **2. The Canonical 8-Step Logical SQL Query Execution Order:**
  - While written starting with `SELECT`, the database engine executes clauses in strict logical order:
    $$\mathbf{\mathbf{1. \ FROM / JOIN} \ \longrightarrow \ \mathbf{2. \ WHERE} \ \longrightarrow \ \mathbf{3. \ GROUP \ BY} \ \longrightarrow \ \mathbf{4. \ HAVING} \ \longrightarrow \ \mathbf{5. \ SELECT} \ \longrightarrow \ \mathbf{6. \ DISTINCT} \ \longrightarrow \ \mathbf{7. \ ORDER \ BY} \ \longrightarrow \ \mathbf{8. \ LIMIT / OFFSET}}$$
    - *Why column aliases fail in `WHERE`:* `WHERE` (Step 2) executes *before* `SELECT` (Step 5) defines the alias!
    - *`WHERE` vs `HAVING`:* `WHERE` filters individual base rows *before* grouping; `HAVING` filters aggregated group rows *after* grouping.
* **3. SQL Joins & Correlated Subqueries:**
  - **Join Types:** `INNER JOIN` (intersection), `LEFT JOIN` (all left + matching right), `RIGHT JOIN`, `FULL OUTER JOIN` (union with nulls), `CROSS JOIN` (Cartesian product), `SELF JOIN`.
  - **Correlated Subqueries:** Inner query references an outer query column (`WHERE EXISTS (SELECT 1 FROM Orders o WHERE o.cust_id = c.id)`). Re-evaluated per outer tuple; optimized by query engine into semi-joins.
* **4. SQL Window Functions (`OVER (PARTITION BY ... ORDER BY ...)`):**
  - Compute running/aggregated values **WITHOUT collapsing rows** (unlike `GROUP BY`):
    - **Ranking Functions:**
      - `ROW_NUMBER()`: Unique sequential integers ($1, 2, 3, 4$).
      - `RANK()`: Ties get same rank; skips subsequent ranks ($1, 1, 3, 4$).
      - `DENSE_RANK()`: Ties get same rank; does NOT skip ranks ($1, 1, 2, 3$).
    - **Offset Functions:** `LEAD(col, 1)` (next row value), `LAG(col, 1)` (previous row value).
    - **Running Aggregates:** `SUM(amount) OVER (PARTITION BY dept ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)`.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The 8-Step Clause Execution Sequence
* Always trace queries in the engine's internal order: `FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> DISTINCT -> ORDER BY -> LIMIT`.

### 2. Top Recommended Resources
* **The SQL Masterclass:** *Learning SQL* (Alan Beaulieu 3rd Ed., O'Reilly).
* **Database Query Fundamentals:** *Database System Concepts* (Silberschatz, Korth, Sudarshan), Chapters 3, 4, & 5.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you trace why column aliases created in `SELECT` cannot be referenced inside `WHERE`?
- [ ] Can you differentiate `ROW_NUMBER()`, `RANK()`, and `DENSE_RANK()` on tied values?
- [ ] Can you write a correlated `EXISTS` subquery to find customers with zero orders?
- [ ] Can you use `LAG()` to calculate month-over-month revenue growth?
