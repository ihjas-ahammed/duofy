# Key to Flow: Database Management Systems (DBMS)

**Subject Area:** `03_Computer_Science_and_IT / 04_Database_Management_Systems`

---

## 📌 Core Concept & Mental Model
DBMS provides software to store, retrieve, update, and manage data efficiently while guaranteeing data integrity, multi-user concurrency, and fault tolerance.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Relational Design & Normalization
* **Relational Algebra:** Selection ($\sigma$), Projection ($\pi$), Join ($\bowtie$), Union ($\cup$).
* **Functional Dependencies ($X \to Y$):**
  * **1NF:** Atomic values.
  * **2NF:** No partial dependencies on composite keys.
  * **3NF:** No transitive dependencies.
  * **BCNF:** For every $X \to Y$, $X$ is a superkey.

### 2. Transaction Management & Concurrency (ACID)
* **ACID Properties:** **Atomicity** (All or nothing), **Consistency** (Valid state transitions), **Isolation** (Concurrent transactions behave as if executed serially), **Durability** (Committed changes survive crashes).
* **Two-Phase Locking (2PL):** Growing phase (acquire locks) $\to$ Shrinking phase (release locks). Strict 2PL prevents cascading rollbacks.
* **Logging & Recovery:** Write-Ahead Logging (WAL) and ARIES recovery algorithm (Analysis, Redo, Undo).

### 3. Indexing & Storage Engine
* **B+ Trees:** Balanced search trees with data pointers stored exclusively in leaf nodes linked sequentially.
* **Hash Indexes:** $O(1)$ equality lookups.

### 4. Top Recommended Resources
* **The DBMS Bible ("Cow Book"):** *Database Management Systems* by Raghu Ramakrishnan & Johannes Gehrke.
* **Standard Text:** *Database System Concepts* by Silberschatz, Korth, Sudarshan.
* **Modern Distributed DBs:** *Designing Data-Intensive Applications (DDIA)* by Martin Kleppmann.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you normalize an unnormalized relation table up to BCNF using Armstrong's axioms?
- [ ] Can you evaluate transaction schedules for Conflict Serializability using Precedence Graphs?
- [ ] Can you write complex SQL queries using JOINs, Subqueries, GROUP BY, and Window Functions?
- [ ] Can you explain the B+ Tree insertion and splitting mechanism?
