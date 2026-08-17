# Key to Flow: Hash Tables and Disjoint Sets (Universal Hashing, Open Addressing, FKS, & DSU)

**Subject Area:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Linear_and_Nonlinear_Data_Structures / Hash_Tables_and_Disjoint_Sets`

---

## 📌 Core Concept & Mental Model
**Hash Modulo Mappings, Load Factor Invariants, Collision Probing Sequences, FKS Two-Level Quadratic Space Guarantees, and Forest Flattener Disjoint-Set Trees** govern dynamic set membership, constant-time dictionary lookups, and equivalence partitioning (Michael L. Fredman, János Komlós, & Endre Szemerédi 1984, Robert E. Tarjan 1975, CLRS Chapters 11 & 21):
* **1. Hash Tables & Collision Resolution:**
  - Given universe $U$ and table of size $m$, load factor is $\mathbf{\alpha = n / m}$.
  - **The Hash Functions:**
    - Division Method: $h(k) = k \bmod m$ (requires $m$ to be prime not close to power of 2).
    - Multiplication Method: $h(k) = \lfloor m(kA \bmod 1) \rfloor$ (Knuth recommends $A = (\sqrt{5}-1)/2 \approx 0.6180339887$).
    - **Universal Hashing:** Family $\mathcal{H}$ of hash functions where $\mathbf{\Pr_{h \in \mathcal{H}}[h(x) = h(y)] \le \frac{1}{m}}$ for all $x \ne y$.
      $$h_{a, b}(k) = ((ak + b) \bmod p) \bmod m \quad (a \in \{1 \dots p-1\}, b \in \{0 \dots p-1\})$$
  - **Collision Resolution Strategies:**
    - **1. Separate Chaining:** Each bucket holds a linked list / balanced tree. Average search time $\mathbf{\Theta(1 + \alpha)}$.
    - **2. Open Addressing:** All elements stored directly in the array ($n \le m$). Probe sequence $h(k, i)$ for $i = 0 \dots m-1$:
      - **Linear Probing:** $h(k, i) = (h'(k) + i) \bmod m$ $\implies$ Suffers from **Primary Clustering** (long contiguous blocks of occupied slots).
      - **Quadratic Probing:** $h(k, i) = (h'(k) + c_1 i + c_2 i^2) \bmod m$ $\implies$ Suffers from Secondary Clustering.
      - **Double Hashing:** $\mathbf{h(k, i) = (h_1(k) + i \cdot h_2(k)) \bmod m}$ $\implies$ Eliminates clustering (requires $\gcd(h_2(k), m) = 1$).
* **2. FKS Perfect Hashing (Fredman, Komlós, Szemerédi 1984):**
  - Designed for static key sets providing **$O(1)$ WORST-CASE search time** in $O(n)$ total space.
  - **Two-Level Hashing Architecture:**
    - **Level 1:** Primary table of size $m = n$ using universal hash function $h$.
    - **Level 2:** Each bucket $i$ with $n_i$ keys gets a secondary table $S_i$ of size $\mathbf{m_i = n_i^2}$.
    - **The Birthday Paradox Guarantee:** Table size $n_i^2$ ensures $\Pr[\text{Collision in } S_i] < 1/2$. If collision occurs, rehash with new function.
    - **Total Expected Space:** $\mathbf{\sum_{i=1}^n m_i = \sum n_i^2 < 2n = O(n)\text{ Space}}$!
* **3. Disjoint-Set Union (DSU / Union-Find Forests - Tarjan 1975):**
  - Manages partitions of elements into disjoint sets.
  - **The 2 Master Optimizations:**
    1. **Union by Rank / Size:** Attach shorter tree root to taller root (bounds uncompressed depth to $O(\log N)$).
    2. **Path Compression:** Re-points every node on find path directly to root (`parent[x] = find(parent[x])`).
  - **Complexity:** Amortized **$O(m \cdot \alpha(n))$** time for $m$ operations, where $\alpha(n) \le 4$ is the inverse Ackermann function.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Collision Spectrum & DSU Tree Flattener
* Open Addressing: Linear (block collision) $\to$ Quadratic (stride collision) $\to$ Double Hash (independent probe permutations).
* FKS Perfect Hashing: Quadratic sizing $n_i^2$ guarantees collision-free secondary tables.
* DSU: Flattens trees on every `find()` query to make subsequent lookups instantaneous.

### 2. Top Recommended Resources
* **The Algorithms Standard:** *Introduction to Algorithms* (CLRS), Chapter 11 (Hash Tables) & Chapter 21 (Data Structures for Disjoint Sets).
* **FKS Original Paper:** *Storing a Sparse Table with O(1) Worst Case Access Time* (JACM 1984).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you define a Universal Hash Family and prove the collision bound $\le 1/m$?
- [ ] Can you contrast Linear Probing, Quadratic Probing, and Double Hashing?
- [ ] Can you explain why FKS Perfect Hashing allocates $n_i^2$ slots per secondary table?
- [ ] Can you implement DSU with Union by Rank and recursive Path Compression?
