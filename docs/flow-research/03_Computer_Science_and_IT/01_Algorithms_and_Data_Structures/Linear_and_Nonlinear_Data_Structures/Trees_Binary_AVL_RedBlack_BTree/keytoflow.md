# Key to Flow: Trees Binary, AVL, Red-Black, and B-Tree (Rotations, Black-Height, & Disk I/O)

**Subject Area:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Linear_and_Nonlinear_Data_Structures / Trees_Binary_AVL_RedBlack_BTree`

---

## 📌 Core Concept & Mental Model
**Binary Search Invariants, Strict Balance Factors (AVL), 5-Property Color Skeletons (Red-Black), and Multi-Way Disk-Page Block Merging (B-Trees)** govern hierarchical searching, dictionary indexing, and database storage engines (Georgy Adelson-Velsky & Evgenii Landis 1962, Rudolf Bayer & Edward McCreight 1970, Leonidas Guibas & Robert Sedgewick 1978, CLRS Chapters 12, 13, & 18):
* **1. Binary Search Tree (BST) Foundations:**
  - **In-Order Sorted Invariant:** $\forall x \in \text{left}(u): \text{key}(x) < \text{key}(u)$, and $\forall y \in \text{right}(u): \text{key}(y) > \text{key}(u)$.
  - **Hibbard Deletion (3 Cases):**
    - Case 1: Node is a leaf $\implies$ simply remove.
    - Case 2: Node has 1 child $\implies$ bypass node by linking parent to child.
    - Case 3: Node has 2 children $\implies$ replace node's key with its **In-Order Successor** (minimum of right subtree), then delete the successor.
  - **Degeneration:** Sorted insertions produce an $O(n)$ linked list $\implies$ motivates balanced trees!
* **2. AVL Trees (Strict Balance Factor - 1962):**
  - **Balance Factor Invariant:** $\mathbf{\text{BF}(u) = \text{height}(\text{left}) - \text{height}(\text{right}) \in \{-1, 0, +1\}}$.
  - **Strict Height Guarantee:** Height $h < 1.44 \log_2(n + 2) \implies \mathbf{O(\log n)\text{ Worst-Case Lookup}}$.
  - **The 4 Tree Rotations:**
    1. **LL Imbalance (Left-Left):** Single **Right Rotation** on critical node.
    2. **RR Imbalance (Right-Right):** Single **Left Rotation** on critical node.
    3. **LR Imbalance (Left-Right):** Double Rotation: **Left Rotate child $\to$ Right Rotate critical node**.
    4. **RL Imbalance (Right-Left):** Double Rotation: **Right Rotate child $\to$ Left Rotate critical node**.
* **3. Red-Black Trees (Loosely Balanced 5-Invariant Trees - 1978):**
  - **The 5 Red-Black Invariants:**
    1. Every node is colored either **RED or BLACK**.
    2. The **Root is BLACK**.
    3. Every leaf (**NIL sentinel**) is **BLACK**.
    4. **No Double Red:** If a node is RED, both its children MUST be BLACK.
    5. **Equal Black-Height:** Every simple path from a node to any descendant leaf contains the **exact same number of black nodes ($bh(u)$)**.
  - **Height Bound Theorem:** $\mathbf{h \le 2\log_2(n + 1)} \implies O(\log n)$ search.
  - **Isomorphism:** 1-to-1 correspondence with balanced 2-3-4 trees.
  - **Why Industry Chooses Red-Black over AVL:** Faster insertions/deletions ($O(1)$ amortized rotations) $\implies$ used in C++ `std::map`, Linux kernel CPU scheduler, Java `TreeMap`.
* **4. B-Trees & B+ Trees (Multi-Way Disk I/O Trees - 1970):**
  - Designed for secondary disk storage where reading a block (4KB page) is $100,000\times$ slower than RAM.
  - **Minimum Degree $t \ge 2$ Properties:**
    - Every non-root node contains at least **$t - 1$ keys** and at most **$2t - 1$ keys**.
    - Every internal node with $k$ keys has exactly **$k + 1$ children**.
    - **All leaves are at the exact same depth**!
  - **Height Bound:** $\mathbf{h \le \log_t \frac{n+1}{2}}$ (for $t = 1000$, a 3-level tree indexes 1 billion records in 3 disk I/Os!).

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Balance Invariant Spectrum
* AVL: Strict height ($\Delta h \le 1$) $\to$ Faster lookups, more rebalancing rotations.
* Red-Black: Black-height skeleton $\to$ Faster inserts/deletes, fewer rotations ($O(1)$).
* B-Tree: High branching factor $t \to$ Minimizes disk seek latency.

### 2. Top Recommended Resources
* **The Algorithms Standard:** *Introduction to Algorithms* (CLRS), Chapters 12 (BST), 13 (Red-Black Trees), & 18 (B-Trees).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you implement the 3 cases of BST deletion using the in-order successor?
- [ ] Can you identify LL, RR, LR, and RL imbalances in an AVL tree and execute the corrective rotations?
- [ ] Can you state all 5 Red-Black tree invariants and prove $h \le 2\log(n+1)$?
- [ ] Can you trace a B-tree node split when an insertion causes a node to exceed $2t-1$ keys?
