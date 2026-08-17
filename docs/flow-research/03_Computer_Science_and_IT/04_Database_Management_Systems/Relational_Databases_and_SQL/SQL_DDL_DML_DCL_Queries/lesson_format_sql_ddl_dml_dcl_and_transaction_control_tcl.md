# Duofy Reusable Lesson Format: SQL DDL, DML, DCL, and Transaction Control (TCL)

**Target Topic:** `03_Computer_Science_and_IT / 04_Database_Management_Systems / Relational_Databases_and_SQL / SQL_DDL_DML_DCL_Queries`  
**Lesson Format Type:** `sql_ddl_dml_dcl_and_transaction_control_tcl`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify command language taxonomy, schema catalog definitions, data manipulation semantics, user access permissions, and ACID transaction boundary controls across SQL sublanguages (ISO/IEC 9075 SQL Standard; Alan Beaulieu *Learning SQL* Chapters 2 & 12; Silberschatz et al. Chapters 3 & 4): master **DDL (Data Definition Language: `CREATE`, `ALTER`, `DROP`, `TRUNCATE`)** with implicit schema commit behavior, master **DML (Data Manipulation Language: `INSERT`, `UPDATE`, `DELETE`, `MERGE`)**, master **DCL (Data Control Language: `GRANT`, `REVOKE`)**, master **TCL (Transaction Control Language: `COMMIT`, `ROLLBACK`, `SAVEPOINT`)**, contrast **`DELETE` vs `TRUNCATE` vs `DROP`** (Row-by-row logged transactional deletion vs High-speed page deallocation vs Schema destruction), and interact with live SQL sublanguage sandbox and transaction rollback simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | 4 SQL Sublanguage Taxonomy (DDL, DML, DCL, TCL), DELETE vs TRUNCATE Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | SQL Sublanguage Command & Language Family Classification Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why TRUNCATE is Dramatically Faster Than DELETE on Million-Row Tables Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The SQL TCL Statement Used to Create an Intermediate Rollback Marker Within an Active Transaction (SAVEPOINT) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive SQL Transaction Control (COMMIT, ROLLBACK, SAVEPOINT) Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "sql_ddl_dml_dcl_and_transaction_control_tcl",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are the 4 sublanguages of SQL (DDL, DML, DCL, TCL) and how do DELETE, TRUNCATE, and DROP differ?",
      "blankAnswer": "SQL Sublanguages & Table Management (Learning SQL Chapters 2 & 12): (1) THE 4 SUBLANGUAGES: (a) DDL (Data Definition Language): Manages schema structure (CREATE, ALTER, DROP, TRUNCATE). In most RDBMS engines, DDL statements issue an implicit COMMIT! (b) DML (Data Manipulation Language): Modifies table row data (INSERT, UPDATE, DELETE, MERGE, SELECT). (c) DCL (Data Control Language): Manages security & roles (GRANT, REVOKE). (d) TCL (Transaction Control Language): Manages ACID transaction boundaries (COMMIT, ROLLBACK, SAVEPOINT). (2) DELETE VS TRUNCATE VS DROP: (i) DELETE: DML command; scans and removes rows one by one, firing ON DELETE triggers and generating extensive rollback WAL logs (can be rolled back). (ii) TRUNCATE: DDL command; instantaneously deallocates data pages on disk, resetting identity seeds (cannot fire row triggers, ultra-fast!). (iii) DROP: DDL command; completely destroys both table data AND schema catalog metadata!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each SQL Command to its exact Sublanguage Category.",
      "matchPairs": [
        { "left": "CREATE, ALTER, TRUNCATE", "right": "DDL (Data Definition Language): Defines, alters, or destroys physical database schema structures" },
        { "left": "INSERT, UPDATE, DELETE", "right": "DML (Data Manipulation Language): Modifies the row data contents stored within existing tables" },
        { "left": "GRANT, REVOKE", "right": "DCL (Data Control Language): Manages user permissions, security access, and privileges" },
        { "left": "COMMIT, ROLLBACK, SAVEPOINT", "right": "TCL (Transaction Control Language): Controls atomic boundaries of active database transactions" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is executing 'TRUNCATE TABLE LargeLogs;' nearly instantaneous (taking milliseconds) on a table with 100 million rows, whereas 'DELETE FROM LargeLogs;' can take several minutes and lock the entire database?",
      "options": [
        { "text": "DELETE is a DML command that scans and deletes records row-by-row, recording every single deleted tuple in the write-ahead transaction log (WAL) for rollback and firing row-level triggers; TRUNCATE is a DDL command that deallocates entire data pages at the disk storage level in a single metadata operation, logging only page extent deallocations and bypassing row-by-row transaction logging", "isCorrect": true, "explanation": "Correct! This is one of the most vital performance differences in database administration (Alan Beaulieu *Learning SQL* Chapter 2; Silberschatz Section 3.2). 1. **How `DELETE` Works (Row-by-Row DML):** - When you run `DELETE FROM LargeLogs;`, the database engine must find each of the 100,000,000 rows. - For EVERY row, the engine creates a full undo/redo log record in the WAL (Write-Ahead Log) so you can `ROLLBACK`. - If the table has indexes, each index tree must delete entries row-by-row. - If row triggers exist, they fire 100 million times. - This creates gigabytes of log traffic and saturates the disk for minutes. 2. **How `TRUNCATE` Works (Extent Deallocation DDL):** - `TRUNCATE TABLE LargeLogs;` does NOT read individual rows! - The database engine simply marks the table's disk extents/pages as free in the storage allocation bitmap and resets the High Water Mark and Identity auto-increment seed to 1. - It writes a tiny metadata entry to the transaction log stating 'Extents deallocated'. - It finishes in $5\\text{ milliseconds}$ regardless of whether the table has 10 rows or 10 billion rows!" },
        { "text": "Because TRUNCATE runs only in memory and never modifies disk", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because DELETE automatically encrypts the database", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because TRUNCATE requires approval from all network client nodes", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The SQL TCL command used to set a marker within a transaction allowing partial rollback is ___.",
      "blankAnswer": "SAVEPOINT",
      "blankDistractors": ["CHECKPOINT", "COMMIT", "ROLLBACK"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive SQL Transaction Control (TCL) Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>SQL Transaction (TCL) Engine</h3><p>Balance: <span id=\"accBal\" style=\"color:#38bdf8; font-weight:bold; font-size:18px;\">$1000</span></p><div style=\"display:flex; gap:6px;\"><button id=\"btnDml\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Deduct $300 (DML)</button><button id=\"btnSp\" style=\"padding:6px 10px; background:#8b5cf6; color:white; border:none; border-radius:4px; cursor:pointer;\">2. SAVEPOINT sp1</button><button id=\"btnErr\" style=\"padding:6px 10px; background:#ef4444; color:white; border:none; border-radius:4px; cursor:pointer;\">3. Faulty Deduct $500</button><button id=\"btnRb\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer;\">4. ROLLBACK TO sp1</button></div><div id=\"tclLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:320px; font-family:monospace; color:#fbbf24;\">Transaction active (BEGIN)...</div><script>let bal=1000, spBal=1000; document.getElementById('btnDml').onclick=()=>{bal-=300; document.getElementById('accBal').innerText='$'+bal; document.getElementById('tclLog').innerText='UPDATE accounts SET bal = bal - 300;\nBalance is now $700.';}; document.getElementById('btnSp').onclick=()=>{spBal=bal; document.getElementById('tclLog').innerText='SAVEPOINT sp1 CREATED (Saved state: $'+spBal+').';}; document.getElementById('btnErr').onclick=()=>{bal-=500; document.getElementById('accBal').innerText='$'+bal; document.getElementById('tclLog').innerText='⚠️ FAULTY UPDATE: Deducted $500 (Balance = $'+bal+').\nError detected!';}; document.getElementById('btnRb').onclick=()=>{bal=spBal; document.getElementById('accBal').innerText='$'+bal; document.getElementById('tclLog').innerText='⚡ ROLLBACK TO SAVEPOINT sp1;\nRestored balance to $'+bal+'!\nPartial rollback successful.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
