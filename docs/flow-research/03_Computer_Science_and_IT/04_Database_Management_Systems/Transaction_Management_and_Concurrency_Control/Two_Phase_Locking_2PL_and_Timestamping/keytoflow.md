# Key to Flow: Two-Phase Locking (2PL), Multiple Granularity, and Timestamp Ordering

**Subject Area:** `03_Computer_Science_and_IT / 04_Database_Management_Systems / Transaction_Management_and_Concurrency_Control / Two_Phase_Locking_2PL_and_Timestamping`

---

## 📌 Core Concept & Mental Model
**Conflict Serializability Precedence Graphs, The 2PL Growing/Shrinking Phase Theorem, Intention Lock Hierarchies (IS, IX, SIX), and Monotonic Timestamp Ordering with Thomas' Write Rule** govern serializable scheduling and lock concurrency control (Kenneth Eswaran, Jim Gray, Raymond Lorie, Irving Traiger 1976; Ray Thomas 1979; Silberschatz Chapters 18 & 19; Elmasri & Navathe Chapters 20 & 21):
* **1. Conflict Serializability & Precedence Graphs (Serialization Graph):**
  - Two operations are in **Conflict** if: (1) they belong to different transactions, (2) access the same data item $Q$, and (3) at least one is a `WRITE` ($W_i(Q)-R_j(Q)$, $R_i(Q)-W_j(Q)$, or $W_i(Q)-W_j(Q)$).
  - **The Precedence Graph Theorem:** A schedule $S$ is **Conflict Serializable $\iff$ its Precedence Graph contains ZERO directed cycles (is a DAG)!**
* **2. Two-Phase Locking (2PL) Hierarchy (Eswaran & Gray 1976):**
  - **The 2PL Invariant:** A transaction may not acquire any new locks after it has released its first lock!
    - **Phase 1: Growing Phase:** Transaction may acquire locks; may NOT release any locks.
    - **Lock Point:** The exact instant the final lock is acquired.
    - **Phase 2: Shrinking Phase:** Transaction may release locks; may NOT acquire any new locks.
  - **2PL Variants:**
    - **Basic 2PL:** Guarantees conflict serializability, but allows cascading rollbacks and deadlocks.
    - **Strict 2PL:** Holds **ALL Exclusive ($X$) locks until transaction COMMIT/ABORT**. Prevents cascading aborts (Recoverable & ACA)!
    - **Rigorous (Conservative) 2PL:** Holds **ALL Shared ($S$) AND Exclusive ($X$) locks until COMMIT/ABORT**. Serializes commit order.
* **3. Multiple Granularity Locking (MGL) & Intention Locks (Gray 1975):**
  - Hierarchical tree: $\text{Database} \to \text{Table} \to \text{Page} \to \text{Row}$.
  - Intention Locks signal intention to acquire fine-grained locks lower in the tree:
    - **IS (Intention Shared):** Intends to acquire $S$-locks on descendent nodes.
    - **IX (Intention Exclusive):** Intends to acquire $X$-locks on descendent nodes.
    - **SIX (Shared + Intention Exclusive):** Holds $S$-lock on entire subtree, but intends to acquire $X$-locks on specific child nodes (e.g. read whole table, update a few rows).
  - **Lock Compatibility Matrix:**
    $$\begin{array}{|c|c|c|c|c|c|}
    \hline
    & \mathbf{\text{IS}} & \mathbf{\text{IX}} & \mathbf{\text{S}} & \mathbf{\text{SIX}} & \mathbf{\text{X}} \\
    \hline
    \mathbf{\text{IS}} & \text{YES} & \text{YES} & \text{YES} & \text{YES} & \text{NO} \\
    \mathbf{\text{IX}} & \text{YES} & \text{YES} & \text{NO} & \text{NO} & \text{NO} \\
    \mathbf{\text{S}}  & \text{YES} & \text{NO}  & \text{YES} & \text{NO} & \text{NO} \\
    \mathbf{\text{SIX}} & \text{YES} & \text{NO}  & \text{NO}  & \text{NO} & \text{NO} \\
    \mathbf{\text{X}}  & \text{NO}  & \text{NO}  & \text{NO}  & \text{NO} & \text{NO} \\
    \hline
    \end{array}$$
* **4. Timestamp Ordering & Thomas' Write Rule (TWR 1979):**
  - Each item $Q$ maintains $R\text{-TS}(Q)$ (largest read timestamp) and $W\text{-TS}(Q)$ (largest write timestamp).
  - Transaction $T_i$ issues $W_i(Q)$:
    - If $\text{TS}(T_i) < R\text{-TS}(Q) \implies$ Abort & Rollback (Too late; a newer transaction already read older state!).
    - If $\text{TS}(T_i) < W\text{-TS}(Q)$:
      - Under Basic TO: Abort & Rollback.
      - **Under Thomas' Write Rule (TWR):** **SIMPLY IGNORE THE OBSOLETE WRITE!** (The write is superseded by a newer committed write; no abort needed, increasing concurrency!).

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Precedence Cycle & Lock Diagnostic Rule
* Step 1: Draw directed edges for all conflicting pairs ($T_i \to T_j$).
* Step 2: Run topological cycle detection.
* Step 3: Verify 2PL Growing $\to$ Lock Point $\to$ Shrinking transitions.

### 2. Top Recommended Resources
* **The Classical Foundation:** *Database System Concepts* (Silberschatz, Korth, Sudarshan), Chapters 18 (Concurrency Control) & 19 (Recovery System).
* **Advanced Theory:** *Fundamentals of Database Systems* (Elmasri & Navathe), Chapters 20 & 21.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you construct a precedence graph for an interleaved schedule and detect cycles?
- [ ] Can you differentiate Basic 2PL, Strict 2PL, and Rigorous 2PL?
- [ ] Can you evaluate the MGL lock compatibility matrix (IS, IX, S, SIX, X)?
- [ ] Can you apply Thomas' Write Rule to avoid aborting an obsolete write?
