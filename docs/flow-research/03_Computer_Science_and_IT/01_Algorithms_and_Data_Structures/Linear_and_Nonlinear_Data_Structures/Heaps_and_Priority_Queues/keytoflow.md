# Key to Flow: Heaps and Priority Queues (Binary Heaps, O(N) Build-Heap, Fibonacci Heaps, & Running Medians)

**Subject Area:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Linear_and_Nonlinear_Data_Structures / Heaps_and_Priority_Queues`

---

## 📌 Core Concept & Mental Model
**Implicit Array Binary Trees, Sift-Down Height Aggregations ($O(N)$ Build-Heap), Lazy Root Lists (Fibonacci Heaps), and Dual-Heap Equilibrium Barriers** govern priority-based scheduling, heap sorting, and online order statistics (J.W.J. Williams 1964, Robert W. Floyd 1964, Michael L. Fredman & Robert E. Tarjan 1987, CLRS Chapter 6 & 19):
* **1. Binary Heap Array Indexing & Invariants:**
  - Complete binary tree stored implicitly in a 0-indexed flat array:
    $$\mathbf{\text{parent}(i) = \lfloor (i - 1) / 2 \rfloor \qquad \text{left}(i) = 2i + 1 \qquad \text{right}(i) = 2i + 2}$$
  - **Max-Heap Invariant:** $A[\text{parent}(i)] \ge A[i]$ for all $i > 0$.
  - **Core Operations:**
    - `sift-up` / `bubble-up`: $O(\log n)$ (during `insert`).
    - `sift-down` / `max-heapify`: $O(\log n)$ (during `extract-max`).
* **2. The Linear-Time Build-Heap Theorem ($O(n)$):**
  - Building a heap bottom-up from an unsorted array of size $n$:
    $$\mathbf{\text{for } i = \lfloor n/2 \rfloor - 1 \text{ down to } 0: \quad \text{MAX-HEAPIFY}(A, i)}$$
  - **Mathematical Summation Proof:**
    - Number of nodes at height $h$ is at most $\lceil n / 2^{h+1} \rceil$.
    - Total work:
      $$\mathbf{T(n) = \sum_{h=0}^{\lfloor \log_2 n \rfloor} \left\lceil \frac{n}{2^{h+1}} \right\rceil O(h) = O\left( n \sum_{h=0}^{\infty} \frac{h}{2^h} \right) = O(n \cdot 2) = \mathbf{O(n)\text{ Linear Time!}}}$$
* **3. Advanced Heap Architecture Hierarchy:**
  $$\begin{array}{|l|l|l|l|l|}
  \hline
  \textbf{Heap Family} & \textbf{INSERT} & \textbf{EXTRACT-MIN} & \textbf{DECREASE-KEY} & \textbf{MERGE / MELD} \\
  \hline
  \mathbf{\text{Binary Heap}} & O(\log n) & O(\log n) & O(\log n) & O(n) \\
  \mathbf{\text{Binomial Heap}} & O(\log n) & O(\log n) & O(\log n) & \mathbf{O(\log n)} \\
  \mathbf{\text{Fibonacci Heap}} & \mathbf{O(1) \ (\text{Amort})} & O(\log n) \ (\text{Amort}) & \mathbf{O(1) \ (\text{Amort})} & \mathbf{O(1) \ (\text{Amort})} \\
  \hline
  \end{array}$$
  - **Fibonacci Heap Strategy:** Lazy insertion into root circular list; consolidation is deferred to `extract-min` using potential $\Phi = t(H) + 2m(H)$.
* **4. The Two-Heaps Running Median Algorithm:**
  - Split data stream into two balanced halves:
    1. **Max-Heap (Left Half):** Stores smaller half of numbers ($\le \text{median}$).
    2. **Min-Heap (Right Half):** Stores larger half of numbers ($\ge \text{median}$).
  - **Equilibrium Invariant:** $\text{size}(\text{MaxHeap}) == \text{size}(\text{MinHeap})$ or $\text{size}(\text{MaxHeap}) == \text{size}(\text{MinHeap}) + 1$.
  - **Median Query:** $O(1)$ time (top of Max-Heap if odd, average of both tops if even!).

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Height vs Depth Build-Heap Principle
* Naive inserts do $O(\text{depth})$ work on $N$ nodes $\to O(N\log N)$.
* Bottom-up `heapify` does $O(\text{height})$ work, where most nodes are leaves ($h=0$) $\to O(N)$!

### 2. Top Recommended Resources
* **The Algorithms Standard:** *Introduction to Algorithms* (CLRS), Chapter 6 (Heapsort) & Chapter 19 (Fibonacci Heaps).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you derive the closed-form summation proving Build-Heap runs in $O(N)$?
- [ ] Can you implement in-place Heapsort in $O(N\log N)$ time and $O(1)$ auxiliary space?
- [ ] Can you explain why Fibonacci heaps achieve $O(1)$ amortized `decrease-key`?
- [ ] Can you maintain a running median over a dynamic stream using Two Heaps?
