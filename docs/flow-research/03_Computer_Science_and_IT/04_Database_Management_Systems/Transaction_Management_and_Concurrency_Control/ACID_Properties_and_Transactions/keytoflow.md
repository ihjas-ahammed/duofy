# Key to Flow: ACID Properties and Transactions (ACID, ANSI Isolation, Read Anomalies, & MVCC)

**Subject Area:** `03_Computer_Science_and_IT / 04_Database_Management_Systems / Transaction_Management_and_Concurrency_Control / ACID_Properties_and_Transactions`

---

## 📌 Core Concept & Mental Model
**Atomic All-or-Nothing Commit Invariants, Application Integrity Constraints, ANSI Isolation Level Boundary Guarantees, Read Anomaly Classifications, and Multi-Version Non-Blocking Snapshot Histories (MVCC)** govern database transaction management and concurrent data access (Jim Gray 1981; Bruce Lindsay 1983; ANSI SQL-92 Standard; Hal Berenson et al. 1995 *A Critique of ANSI SQL Isolation Levels*; Silberschatz Chapter 17; Martin Kleppmann DDIA Chapter 7):
* **1. The 4 Fundamental ACID Invariants:**
  - **Atomicity ($A$):** All operations inside a transaction execute to completion OR none do (All-or-Nothing). Enforced via **Undo Logs / Write-Ahead Logging (WAL)**.
  - **Consistency ($C$):** A transaction transforms the database from one valid state satisfying all declarative schema constraints (`FOREIGN KEY`, `CHECK`, `NOT NULL`, business invariants) to another.
  - **Isolation ($I$):** Concurrently executing transactions appear to execute serially in isolation without interfering with one another.
  - **Durability ($D$):** Once committed, updates survive system power outages and hardware crashes. Enforced via **Redo Logs + `fsync` flushing**.
* **2. The ANSI SQL Isolation Levels & Concurrency Anomalies:**
  $$\begin{array}{|l|c|c|c|l|}
  \hline
  \textbf{Isolation Level} & \textbf{Dirty Read (G1a)} & \textbf{Non-Repeatable Read (G1b)} & \textbf{Phantom Read (G2)} & \textbf{Standard Mechanism} \\
  \hline
  \mathbf{\text{Read Uncommitted}} & \mathbf{\text{ALLOWED}} & \text{ALLOWED} & \text{ALLOWED} & \text{No read locks} \\
  \mathbf{\text{Read Committed}} & \mathbf{\text{PREVENTED}} & \text{ALLOWED} & \text{ALLOWED} & \text{Short read locks / MVCC statement snapshot} \\
  \mathbf{\text{Repeatable Read}} & \mathbf{\text{PREVENTED}} & \mathbf{\text{PREVENTED}} & \text{ALLOWED} & \text{Long read locks / MVCC transaction snapshot} \\
  \mathbf{\text{Serializable}} & \mathbf{\text{PREVENTED}} & \mathbf{\text{PREVENTED}} & \mathbf{\text{PREVENTED}} & \text{Strict 2PL / Serializable SSI} \\
  \hline
  \end{array}$$
  - **The 3 Classic Read Anomalies:**
    1. **Dirty Read:** Transaction $T_1$ reads uncommitted modified data written by $T_2$; $T_2$ then aborts/rolls back!
    2. **Non-Repeatable (Fuzzy) Read:** Transaction $T_1$ reads a row; $T_2$ updates/deletes that row and commits; $T_1$ re-reads the row and sees different values!
    3. **Phantom Read:** Transaction $T_1$ executes a range query (`WHERE age > 30`); $T_2$ inserts a new row with `age = 35` and commits; $T_1$ re-executes the query and sees a new "phantom" row!
* **3. Multi-Version Concurrency Control (MVCC):**
  - **The Core Mantram:** **"Readers NEVER block Writers, and Writers NEVER block Readers!"**
  - Keeps multiple historical versions of each tuple tagged with transaction IDs (`xmin`/`xmax` in PostgreSQL; rollback undo segments in MySQL InnoDB).
  - A transaction reads a consistent point-in-time **Snapshot** based on active transaction IDs.
* **4. Subtle Anomalies Beyond ANSI SQL (Berenson 1995):**
  - **Lost Update:** Two transactions read value $x$, compute $x+1$, and write back concurrently; one update overwrites and destroys the other!
  - **Write Skew (Snapshot Isolation Bug):** Two transactions read overlapping data and update distinct disjoint records, violating a global business invariant (e.g. hospital shift where at least 1 doctor must be on call; two doctors simultaneously check `count >= 2` and both go off duty, leaving 0 doctors!).

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Anomaly vs Isolation Elimination Ladder
* Read Uncommitted $\to$ Kill Dirty Reads $\to$ Read Committed $\to$ Kill Fuzzy Reads $\to$ Repeatable Read $\to$ Kill Phantoms $\to$ Serializable.

### 2. Top Recommended Resources
* **The Distributed Bible:** *Designing Data-Intensive Applications* (Martin Kleppmann), Chapter 7 (Transactions).
* **The Classical Foundation:** *A Critique of ANSI SQL Isolation Levels* (Berenson, Bernstein, Gray, Melton, O'Neil, O'Neil, 1995).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you define all 4 ACID properties and identify which subsystem enforces each?
- [ ] Can you trace Dirty Reads, Non-Repeatable Reads, and Phantom Reads across interleaved timelines?
- [ ] Can you explain how MVCC enables concurrent non-blocking reads and writes?
- [ ] Can you identify a Write Skew scenario and explain why Snapshot Isolation fails to prevent it?
