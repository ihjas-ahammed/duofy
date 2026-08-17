# Key to Flow: Write-Ahead Logging (WAL), Buffer Pool Policies, and ARIES Crash Recovery

**Subject Area:** `03_Computer_Science_and_IT / 04_Database_Management_Systems / Transaction_Management_and_Concurrency_Control / Write_Ahead_Logging_WAL_and_Recovery`

---

## 📌 Core Concept & Mental Model
**Buffer Pool Buffer Management Policies (Steal / No-Force), The Two Cardinal WAL Invariants, Log Sequence Number (LSN) Monotonic Chains, The 3-Phase ARIES Crash Recovery Pipeline, and Compensation Log Records (CLRs)** govern fault-tolerant persistence and atomic crash recovery in relational database storage engines (C. Mohan, Don Haderle, Bruce Lindsay, Hamid Pirahesh, Peter Schwarz 1992 *ARIES: A Transaction Recovery Method Supporting Fine-Granularity Locking and Partial Rollbacks Using Write-Ahead Logging*, ACM TODS; Silberschatz Chapter 19; Elmasri & Navathe Chapter 22):
* **1. The Buffer Pool Management Policy Taxonomy:**
  $$\begin{array}{|l|l|l|}
  \hline
  \textbf{Policy Dimension} & \textbf{Operational Semantic} & \textbf{Recovery Engine Requirement} \\
  \hline
  \mathbf{\text{STEAL}} & \text{Buffer manager can write uncommitted dirty pages to disk to free RAM} & \mathbf{\text{Requires UNDO logging (to rollback on abort)}} \\
  \mathbf{\text{NO-STEAL}} & \text{Uncommitted pages NEVER written to disk} & \text{No Undo needed (High RAM pressure)} \\
  \mathbf{\text{FORCE}} & \text{Every commit forces all modified pages to disk synchronously} & \text{No Redo needed (Slow disk I/O bottleneck)} \\
  \mathbf{\text{NO-FORCE}} & \mathbf{\text{Commit writes ONLY log to disk; pages flushed asynchronously}} & \mathbf{\text{Requires REDO logging (High performance standard!)}} \\
  \hline
  \end{array}$$
  - **Modern Standard:** High-performance databases use **STEAL + NO-FORCE** $\implies$ **Requires BOTH Undo and Redo logging!**
* **2. The Two Golden Rules of Write-Ahead Logging (WAL):**
  1. **Rule 1 (Undo Rule):** A dirty data page cannot be written to non-volatile disk until the log record describing the update is flushed to disk: $\mathbf{\text{pageLSN} \le \text{flushedLSN}}$.
  2. **Rule 2 (Redo Rule):** A transaction is not committed until all of its log records (up through the `COMMIT` record) are safely flushed to non-volatile disk.
* **3. Log Sequence Numbers (LSN) Architecture:**
  - `LSN`: Monotonically increasing byte offset in log file.
  - `pageLSN`: LSN of the most recent log record that modified this specific disk page.
  - `flushedLSN`: The largest LSN currently written to stable disk storage.
  - `recLSN`: In the Dirty Page Table (DPT), the earliest LSN that dirtied the page in memory.
* **4. The Canonical 3-Phase ARIES Recovery Algorithm (Mohan 1992):**
  1. **Phase 1: Analysis Phase (Scan Forward from Checkpoint):**
     - Reconstructs the in-memory **Transaction Table (TT)** and **Dirty Page Table (DPT)**.
     - Identifies active **Loser Transactions** (transactions that were active during the crash) and smallest `recLSN`.
  2. **Phase 2: Redo Phase (Repeating History Forward from smallest `recLSN`):**
     - Re-applies ALL operations (both committed and aborted!) to restore the exact physical memory/disk state at the moment of the crash.
     - Optimization: If $\text{pageLSN} \ge \text{LSN}$, skip redo for that page!
  3. **Phase 3: Undo Phase (Scan Backward from end of log):**
     - Rolls back all loser transactions.
     - Writes **Compensation Log Records (CLRs)** with `UndoNextLSN` pointers.
     - **Crash-Proof Guarantee:** CLRs are **NEVER undone**! If the server crashes *during* recovery, `UndoNextLSN` allows recovery to jump directly to the remaining undone operations without repeating prior undo work!

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The ARIES 3-Phase Recovery Pipeline
* Crash $\to$ Scan Forward from Checkpoint (Analysis) $\to$ Scan Forward from Min recLSN (Redo "Repeat History") $\to$ Scan Backward (Undo Losers with CLRs).

### 2. Top Recommended Resources
* **The Classic Paper:** *ARIES: A Transaction Recovery Method Supporting Fine-Granularity Locking and Partial Rollbacks Using Write-Ahead Logging* (C. Mohan et al., ACM TODS 1992).
* **Database Concepts:** *Database System Concepts* (Silberschatz et al.), Chapter 19 (Recovery System).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you explain why modern database engines use the STEAL / NO-FORCE buffer policy?
- [ ] Can you state the WAL invariant inequality $\text{pageLSN} \le \text{flushedLSN}$?
- [ ] Can you trace the 3 phases of ARIES crash recovery (Analysis $\to$ Redo $\to$ Undo)?
- [ ] Can you explain why CLRs and `UndoNextLSN` prevent infinite loops during repeated crashes?
