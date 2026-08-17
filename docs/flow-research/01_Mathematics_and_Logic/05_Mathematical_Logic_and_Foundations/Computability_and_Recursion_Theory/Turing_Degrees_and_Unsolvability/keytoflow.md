# Key to Flow: Turing Degrees & Unsolvability (Mathematical Logic & Computability)

**Subject Area:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Computability_and_Recursion_Theory / Turing_Degrees_and_Unsolvability`

---

## 📌 Core Concept & Mental Model
**Turing Degrees & Relative Computability** structure the universe of undecidable decision problems by their informational complexity:
* **Turing Reducibility ($A \le_T B$ / Alan Turing, 1939):**
  Set $A \subseteq \mathbb{N}$ is computable by an **Oracle Turing Machine** equipped with an oracle query tape for set $B$ ($A = \Phi_e^B$).
* **Turing Degrees ($\mathbf{d}(A)$):** Equivalence classes under mutual reducibility ($A \equiv_T B \iff A \le_T B \text{ and } B \le_T A$).
  - $\mathbf{0} = \mathbf{d}(\emptyset)$: The degree of all computable / decidable sets.
  - $\mathbf{0}' = \mathbf{d}(K)$: The degree of the classical **Halting Problem** $K = \{e \mid \Phi_e(e) \downarrow\}$.
* **The Turing Jump Operator ($A'$):**
  $$A' = \{e \in \mathbb{N} \mid \Phi_e^A(e) \downarrow\} \implies A <_T A' \quad (\text{Strictly harder than } A!)$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Post's Problem & The Priority Method
* **Post's Problem (Emil Post, 1944):** Does there exist a computably enumerable (c.e.) set $A$ of intermediate degree: $\mathbf{0} <_T \mathbf{d}(A) <_T \mathbf{0}'$?
* **The Friedberg-Muchnik Theorem (1956/1957):** Solved Post's Problem affirmatively by constructing two c.e. sets $A$ and $B$ that are **Turing incomparable** ($A \not\le_T B$ and $B \not\le_T A$).
* **The Finite Injury Priority Method:**
  Manages an infinite family of requirements $\mathcal{R}_{2e}: A \ne \Phi_e^B$ and $\mathcal{R}_{2e+1}: B \ne \Phi_e^A$. High-priority requirements "restrain" elements from entering sets; lower-priority requirements can "injure" higher restraints at most finitely many times before stabilizing.

### 2. The Arithmetical Hierarchy & Post's Theorem
* **The Arithmetical Hierarchy (Kleene & Mostowski):**
  Classifies sets by quantifier alternations in first-order arithmetic:
  $$\Delta_0^0 = \Sigma_0^0 = \Pi_0^0 \text{ (Bounded/Computable)}, \quad \Sigma_{n+1}^0 = \exists x \, \Pi_n^0, \quad \Pi_{n+1}^0 = \forall x \, \Sigma_n^0, \quad \Delta_n^0 = \Sigma_n^0 \cap \Pi_n^0$$
* **Post's Theorem (1948):** Links logic to oracle computation:
  $$A \in \Sigma_{n+1}^0 \iff A \text{ is computably enumerable in } \emptyset^{(n)}$$
  $$A \in \Delta_{n+1}^0 \iff A \le_T \emptyset^{(n)}$$

### 3. Top Recommended Resources
* **The Definitive Computability Text:** *Turing Computability: Theory and Applications* by Robert I. Soare (Springer).
* **Comprehensive Classical Treatise:** *Classical Recursion Theory, Vol. I & II* by Piergiorgio Odifreddi.
* **Modern Accessible Reference:** *Computability Theory* by S. Barry Cooper.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you place decision problems into the Arithmetical Hierarchy ($\Sigma_1^0, \Pi_1^0, \Sigma_2^0, \Pi_2^0$)?
- [ ] Can you execute the diagonal Halting Problem proof showing $\emptyset <_T \emptyset'$?
- [ ] Can you trace a finite injury priority argument and calculate injury bounds for requirement $\mathcal{R}_e$?
- [ ] Can you apply Post's Theorem to show $\operatorname{TOTAL} = \{e \mid \Phi_e \text{ is total}\} \in \Pi_2^0$-complete?
