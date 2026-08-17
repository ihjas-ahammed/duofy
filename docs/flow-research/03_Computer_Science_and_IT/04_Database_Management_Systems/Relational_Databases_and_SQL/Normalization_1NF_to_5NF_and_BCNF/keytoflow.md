# Key to Flow: Database Normalization (1NF to 5NF, BCNF, Armstrong's Axioms, & Lossless Joins)

**Subject Area:** `03_Computer_Science_and_IT / 04_Database_Management_Systems / Relational_Databases_and_SQL / Normalization_1NF_to_5NF_and_BCNF`

---

## 📌 Core Concept & Mental Model
**Functional Dependencies, Armstrong's Axiomatic Closures, Candidate Key Derivations, Anomaly Elimination Hierarchies (1NF $\to$ 5NF), and Lossless-Join Decomposition Theorems** govern relational schema optimization, minimal redundancy, and data integrity (Edgar F. Codd 1970–1972; Raymond F. Boyce & Edgar F. Codd 1974 BCNF; Ronald Fagin 1977 4NF, 1979 5NF; William W. Armstrong 1974; Elmasri & Navathe Chapters 14 & 15; Silberschatz Chapter 7):
* **1. Functional Dependencies & Armstrong's Axioms (1974):**
  - **FD Definition:** $X \to Y$ holds in relation $R$ if whenever two tuples have $t_1[X] = t_2[X]$, they MUST have $t_1[Y] = t_2[Y]$.
  - **The 3 Sound and Complete Armstrong Axioms:**
    1. **Reflexivity:** If $Y \subseteq X \implies X \to Y$.
    2. **Augmentation:** If $X \to Y \implies XZ \to YZ$.
    3. **Transitivity:** If $X \to Y \land Y \to Z \implies X \to Z$.
  - **Attribute Closure ($X^+$):** The set of all attributes functionally determined by $X$.
    - **Superkey Test:** If $X^+ = \text{All Attributes of } R \implies X$ is a Superkey!
    - **Candidate Key Test:** Minimal superkey (no proper subset of $X$ is a superkey).
* **2. The Canonical Normal Forms Hierarchy (1NF $\to$ BCNF):**
  $$\begin{array}{|l|l|l|}
  \hline
  \textbf{Normal Form} & \textbf{Formal Requirement (For every non-trivial } X \to Y\textbf{)} & \textbf{Anomaly Eliminated} \\
  \hline
  \mathbf{\text{1NF}} & \text{All attribute domain values must be atomic (no arrays/repeating groups)} & \text{Non-atomic sets} \\
  \mathbf{\text{2NF}} & \mathbf{\text{1NF } + \text{ NO Partial Dependencies: No non-prime attr depends on subset of key}} & \text{Partial key redundancy} \\
  \mathbf{\text{3NF}} & \mathbf{\text{2NF } + \text{ For every } X \to A: \ X \text{ is Superkey OR } A \text{ is Prime Attribute}} & \text{Transitive redundancy} \\
  \mathbf{\text{BCNF}} & \mathbf{\text{Strict: For every non-trivial } X \to A, \ \mathbf{X \text{ MUST BE A SUPERKEY!}}} & \text{All functional redundancy} \\
  \hline
  \end{array}$$
  - **The 3NF vs BCNF Trade-Off:**
    - 3NF allows $X \to A$ if $A$ is prime (part of a candidate key).
    - BCNF strictly eliminates all anomalies, but **cannot always preserve all functional dependencies** during decomposition!
    - 3NF guarantees **both Lossless Join AND Dependency Preservation** in $O(N^3)$ polynomial synthesis time.
* **3. Lossless-Join Decomposition & Dependency Preservation:**
  - Decomposing $R$ into $\{R_1, R_2\}$ is **LOSSLESS (Heath's Theorem)** if and only if:
    $$\mathbf{(R_1 \cap R_2 \to R_1) \quad \lor \quad (R_1 \cap R_2 \to R_2)}$$
    *(The common attributes must form a superkey of at least one sub-relation!)*
* **4. Higher Normal Forms (4NF & 5NF):**
  - **4NF (Multivalued Dependencies $X \twoheadrightarrow Y$ - Fagin 1977):** Eliminates independent multi-valued facts (e.g. `Employee` has multiple `Skills` AND multiple `Languages`).
  - **5NF / PJNF (Project-Join Normal Form - Fagin 1979):** Eliminates lossless cyclic $N$-way join dependencies that cannot be reconstructed from binary joins.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Normalization Diagnostic Decision Tree
* Is data atomic? $\to$ 1NF.
* Is any non-key column dependent on half of a composite key? $\to$ Fail 2NF.
* Does any non-key column determine another non-key column? $\to$ Fail 3NF.
* Is the LHS of EVERY dependency a superkey? $\to$ BCNF!

### 2. Top Recommended Resources
* **The DB Bible:** *Fundamentals of Database Systems* (Elmasri & Navathe), Chapters 14 (Basics of Functional Dependencies and Normalization) & 15 (Relational Database Design Algorithms).
* **Database Concepts:** *Database System Concepts* (Silberschatz et al.), Chapter 7 (Relational Database Design).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you compute the attribute closure $X^+$ for a given set of FDs?
- [ ] Can you find all candidate keys for a relation $R(A, B, C, D, E)$?
- [ ] Can you distinguish 3NF from BCNF using the prime attribute escape clause?
- [ ] Can you apply Heath's theorem to prove whether a binary decomposition is lossless?
