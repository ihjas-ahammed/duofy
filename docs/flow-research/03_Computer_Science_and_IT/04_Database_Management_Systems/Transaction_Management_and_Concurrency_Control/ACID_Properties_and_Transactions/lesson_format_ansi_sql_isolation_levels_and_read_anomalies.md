# Duofy Reusable Lesson Format: ANSI SQL Isolation Levels and Read Anomalies

**Target Topic:** `03_Computer_Science_and_IT / 04_Database_Management_Systems / Transaction_Management_and_Concurrency_Control / ACID_Properties_and_Transactions`  
**Lesson Format Type:** `ansi_sql_isolation_levels_and_read_anomalies`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the concurrency anomaly taxonomy, lock durations, and isolation level guarantees of the ANSI SQL standard (ANSI SQL-92 Standard; Hal Berenson et al. 1995 *A Critique of ANSI SQL Isolation Levels*, SIGMOD; Martin Kleppmann DDIA Chapter 7; Silberschatz Chapter 17): define the **4 ANSI SQL Isolation Levels** (**Read Uncommitted**, **Read Committed**, **Repeatable Read**, and **Serializable**), decode the **3 Canonical Read Anomalies** (**Dirty Read [G1a]**, **Non-Repeatable / Fuzzy Read [G1b]**, and **Phantom Read [G2]**), evaluate how each isolation level sequentially eliminates anomalies (Read Committed eliminates Dirty Reads; Repeatable Read eliminates Fuzzy Reads; Serializable eliminates Phantoms via Predicate/Index Locking), and trace interleaved concurrent transaction execution timelines.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | ANSI SQL Isolation Level Matrix, Anomaly Elimination Rules, & Mechanisms Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Interleaving Timeline of a Non-Repeatable (Fuzzy) Read Anomaly Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Concurrency Anomaly & Exact Phenomenological Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Anomaly Where a Transaction Re-Executes a Range Query and Discovers Newly Inserted Rows (Phantom Read) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why Read Committed Fails to Prevent Non-Repeatable Reads Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State ANSI SQL Isolation Levels & Anomalies (ANSI SQL-92; Berenson 1995; DDIA 7):
   - **The Master ANSI Isolation Matrix:**
     $$\begin{array}{|l|c|c|c|}
     \hline
     \textbf{Isolation Level} & \textbf{Dirty Read (G1a)} & \textbf{Non-Repeatable Read (G1b)} & \textbf{Phantom Read (G2)} \\
     \hline
     \mathbf{\text{Read Uncommitted}} & \mathbf{\text{ALLOWED}} & \text{ALLOWED} & \text{ALLOWED} \\
     \mathbf{\text{Read Committed}} & \mathbf{\text{PREVENTED}} & \mathbf{\text{ALLOWED}} & \text{ALLOWED} \\
     \mathbf{\text{Repeatable Read}} & \mathbf{\text{PREVENTED}} & \mathbf{\text{PREVENTED}} & \mathbf{\text{ALLOWED}} \\
     \mathbf{\text{Serializable}} & \mathbf{\text{PREVENTED}} & \mathbf{\text{PREVENTED}} & \mathbf{\text{PREVENTED}} \\
     \hline
     \end{array}$$
   - **Definitions of the 3 Classical Anomalies:**
     - **Dirty Read:** $T_1$ reads uncommitted changes of $T_2$; $T_2$ then rolls back!
     - **Non-Repeatable (Fuzzy) Read:** $T_1$ reads row $x$; $T_2$ updates/deletes $x$ and commits; $T_1$ re-reads $x$ and observes modified data!
     - **Phantom Read:** $T_1$ executes range query `WHERE salary > 50k`; $T_2$ inserts a NEW employee and commits; $T_1$ re-runs query and sees a new "phantom" row!
2. **Slide 2 (`ordering`):** Provide 5 steps of a Non-Repeatable Read anomaly occurring under Read Committed: (1) Transaction 1 begins and reads Account balance: $500, (2) concurrent Transaction 2 begins, updates Account balance from $500 to $900, and commits immediately, (3) Transaction 1 continues and re-reads Account balance within its original transaction boundary, (4) Transaction 1 observes new value $900 (different from earlier read of $500), (5) demonstrate that because Read Committed only prevents reading uncommitted data, committed changes by T2 were immediately visible to T1, violating repeatable read isolation!
3. **Slide 3 (`matching`):** Pair 4 concurrency anomalies (Dirty Read, Non-Repeatable Read, Phantom Read, Lost Update) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that range query anomalies are phantom reads. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why Read Committed permits Non-Repeatable Reads: Why does the 'Read Committed' isolation level allow Non-Repeatable Reads to occur? (Because under Read Committed, the database engine **releases read locks immediately after each individual `SELECT` statement finishes executing (or generates a fresh MVCC snapshot per statement)**; if a concurrent transaction modifies and commits changes to that row between statement 1 and statement 2, the subsequent read sees the new committed value, causing two reads of the exact same row in the same transaction to return different results).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ansi_sql_isolation_levels_and_read_anomalies",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: ANSI SQL Isolation Levels (SQL-92 & Berenson 1995)**\n• **The Master Anomaly Elimination Matrix:**\n$$\n\\begin{array}{|l|c|c|c|}\n\\hline\n\\textbf{Isolation Level} & \\textbf{Dirty Read (G1a)} & \\textbf{Non-Repeatable Read (G1b)} & \\textbf{Phantom Read (G2)} \\\\\n\\hline\n\\mathbf{\\text{Read Uncommitted}} & \\mathbf{\\text{Allowed}} & \\text{Allowed} & \\text{Allowed} \\\\\n\\mathbf{\\text{Read Committed}} & \\mathbf{\\text{Prevented}} & \\mathbf{\\text{Allowed}} & \\text{Allowed} \\\\\n\\mathbf{\\text{Repeatable Read}} & \\mathbf{\\text{Prevented}} & \\mathbf{\\text{Prevented}} & \\mathbf{\\text{Allowed}} \\\\\n\\mathbf{\\text{Serializable}} & \\mathbf{\\text{Prevented}} & \\mathbf{\\text{Prevented}} & \\mathbf{\\text{Prevented}} \\\\\n\\hline\n\\end{array}\n$$\n• **The 3 Classic Read Anomalies (DDIA Chapter 7):**\n  - **Dirty Read:** Reading uncommitted in-flight writes that are later rolled back.\n  - **Non-Repeatable Read:** Re-reading the *same individual row* returns different column values.\n  - **Phantom Read:** Re-executing a *range query* (`WHERE val > 10`) discovers newly inserted rows!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of a Non-Repeatable (Fuzzy) Read anomaly occurring under Read Committed isolation.",
      "orderItems": [
        "Transaction T1 starts and reads product inventory for item #42: reads quantity = 50 units",
        "Concurrent Transaction T2 starts and executes: UPDATE inventory SET quantity = 10 WHERE id = 42",
        "Transaction T2 successfully executes COMMIT, persisting the update of item #42 to disk",
        "Transaction T1 re-reads product inventory for item #42 within its active transaction: reads quantity = 10 units",
        "Transaction T1 observes conflicting data across two reads of the exact same row (Non-Repeatable Read anomaly)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Concurrency Read Anomaly to its exact operational description.",
      "matchPairs": [
        { "left": "Dirty Read (G1a)", "right": "A transaction reads uncommitted data written by a concurrent transaction that subsequently aborts" },
        { "left": "Non-Repeatable Read (G1b)", "right": "A transaction re-reads a specific row and finds modified values because a concurrent transaction committed updates" },
        { "left": "Phantom Read (G2)", "right": "A transaction re-runs a search predicate range query and discovers new records inserted by a committed transaction" },
        { "left": "Lost Update (G1c)", "right": "Two concurrent transactions read value X and write back X+1 simultaneously; one write overwrites the other" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The concurrency anomaly where a transaction re-executes a range query and discovers newly inserted rows is a ___ read.",
      "blankAnswer": "phantom",
      "blankDistractors": ["dirty", "fuzzy", "skewed"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the 'Read Committed' transaction isolation level permit Non-Repeatable (Fuzzy) Reads to occur within an active transaction?",
      "options": [
        { "text": "Because under Read Committed, the database engine releases shared read locks immediately after each individual SQL statement completes (or generates a fresh point-in-time MVCC snapshot for each separate SQL statement); if a concurrent transaction modifies and commits changes to that row between statement 1 and statement 2, the subsequent query sees the newly committed value, causing two reads of the exact same record to return different data", "isCorrect": true, "explanation": "Correct! This is the precise mechanical reason why Read Committed allows Non-Repeatable Reads (Martin Kleppmann DDIA Chapter 7; Silberschatz Section 17.6). 1. **How Read Committed is Implemented:** - In Lock-Based systems: Shared read locks are held ONLY for the duration of the current `SELECT` statement and released immediately afterward. - In MVCC systems (PostgreSQL, MySQL): A new read snapshot is generated at the start of **each individual SQL statement**, rather than at the start of the transaction! 2. **Tracing the Sequence:** - Step 1: Transaction 1 executes `SELECT balance FROM Account WHERE id = 1;` $\implies$ Reads `$500`. Statement finishes; read lock is dropped (or statement snapshot expires). - Step 2: Transaction 2 updates Account 1 to `$900` and executes `COMMIT`. - Step 3: Transaction 1 executes `SELECT balance FROM Account WHERE id = 1;` again. Because Transaction 2 is committed, and Transaction 1 creates a fresh statement snapshot, Transaction 1 sees the new committed value: `$900`! 3. To prevent this, **Repeatable Read** isolation must be used, which holds read locks until transaction `COMMIT`/`ROLLBACK` (or freezes a single MVCC snapshot for the entire transaction lifetime)." },
        { "text": "Because Read Committed disables the database buffer pool", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Non-Repeatable Reads only happen on read-only transactions", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because SQL-92 forbids transactions from holding more than one lock", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
