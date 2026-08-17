# Duofy Reusable Lesson Format: Binary Heaps and Linear-Time Build-Heap Proof

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Linear_and_Nonlinear_Data_Structures / Heaps_and_Priority_Queues`  
**Lesson Format Type:** `binary_heaps_and_linear_time_build_heap_proof`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the implicit array representation of complete binary trees, sift-down heapify recursion, and the mathematical series summation proving the linear-time construction of binary heaps (J.W.J. Williams 1964; Robert W. Floyd 1964; Thomas H. Cormen et al. CLRS Chapter 6): master the **0-Indexed Array Mapping Formulas ($\mathbf{\text{parent}(i) = \lfloor (i-1)/2 \rfloor, \ \text{left}(i) = 2i+1, \ \text{right}(i) = 2i+2}$)**, analyze the **Bottom-Up `BUILD-MAX-HEAP` Protocol** (invoking `MAX-HEAPIFY` on indices $\lfloor n/2 \rfloor - 1$ down to $0$), prove the **Linear-Time Theorem ($\mathbf{T(n) = \sum_{h=0}^{\lfloor \log n \rfloor} \lceil n/2^{h+1} \rceil O(h) = O(n \sum h/2^h) = \mathbf{O(n)\text{ Linear Time}}}$)**, and contrast against naive sequential $O(n\log n)$ insertion.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Binary Heap Array Invariants & Linear-Time Build-Heap Proof Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Bottom-Up Build-Heap Execution Sequence Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Heap Operation / Index Formula & Computational Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Asymptotic Time Complexity of Building a Binary Heap Bottom-Up (O(n)) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Summation Proof Why Bottom-Up Build-Heap is O(n) Rather Than O(n log n) Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Binary Heaps & Build-Heap Linear Time Proof (Williams 1964; Floyd 1964; CLRS Chapter 6):
   - **Implicit Complete Binary Tree Array Indexing (0-Indexed):**
     $$\mathbf{\text{parent}(i) = \left\lfloor \frac{i - 1}{2} \right\rfloor \qquad \text{left}(i) = 2i + 1 \qquad \text{right}(i) = 2i + 2}$$
   - **Max-Heap Invariant:** $A[\text{parent}(i)] \ge A[i]$ for all active indices $i > 0$.
   - **Bottom-Up `BUILD-MAX-HEAP` (Floyd 1964):**
     - Leaf nodes (indices $\lfloor n/2 \rfloor$ to $n-1$) are already valid 1-element heaps!
     - Run `MAX-HEAPIFY` on all internal nodes from $\lfloor n/2 \rfloor - 1$ down to 0.
   - **The Formal Mathematical Summation Proof:**
     - Height $h$ of a node is the number of edges to the farthest leaf.
     - A heap of size $n$ contains at most $\mathbf{\lceil n / 2^{h+1} \rceil}$ nodes of height $h$.
     - `MAX-HEAPIFY` on a node of height $h$ takes $O(h)$ time:
       $$\mathbf{T(n) = \sum_{h=0}^{\lfloor \log_2 n \rfloor} \left\lceil \frac{n}{2^{h+1}} \right\rceil O(h) = O\left( n \sum_{h=0}^{\infty} \frac{h}{2^h} \right) = O(n \cdot 2) = \mathbf{O(n)\text{ Linear Time!}}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of the bottom-up BUILD-MAX-HEAP algorithm: (1) receive an arbitrary unsorted array of n elements, (2) recognize that all elements from index floor(n/2) to n - 1 are leaf nodes with height 0 (already valid trivial heaps), (3) initialize a loop variable i starting at the last internal node index i = floor(n/2) - 1, (4) call MAX-HEAPIFY(A, i) to sift down element A[i] until the subtree rooted at i satisfies the max-heap property, (5) decrement loop variable i and repeat heapify down to root index 0, producing a valid Max-Heap in O(n) total time!
3. **Slide 3 (`matching`):** Pair 4 heap operations/formulas (Left Child index 2i+1, Parent index floor((i-1)/2), Build-Heap Time O(n), Extract-Max Time O(log n)) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that building a binary heap bottom-up runs in O(n) linear time. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the core pedagogical intuition behind why bottom-up Build-Heap is $O(n)$ while sequential insertion is $O(n\log n)$: Why does bottom-up `BUILD-MAX-HEAP` run in $O(n)$ linear time whereas inserting $n$ elements one-by-one into an initially empty heap takes $O(n\log n)$ time? (Because in sequential insertion, nodes are sifted up from the bottom, doing $O(\text{depth})$ work where **most nodes (the $n/2$ leaves) must travel the maximum distance $\approx \log n$**; whereas in bottom-up `BUILD-HEAP`, nodes are sifted down, doing $O(\text{height})$ work where **most nodes (the $n/2$ leaves) have height $h=0$ and do ZERO sift work**, while only the single root node has height $\log n$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "binary_heaps_and_linear_time_build_heap_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Binary Heaps & The Linear-Time Build-Heap Proof (1964)**\n• **Implicit 0-Indexed Array Mapping:**\n$$\n\\mathbf{\\text{parent}(i) = \\lfloor (i - 1) / 2 \\rfloor \\qquad \\text{left}(i) = 2i + 1 \\qquad \\text{right}(i) = 2i + 2}\n$$\n• **Max-Heap Invariant:** $A[\\text{parent}(i)] \\ge A[i]$ for all $i > 0$.\n• **The Linear-Time Build-Heap Proof (CLRS Theorem 6.3):**\n$$\n\\text{Nodes at height } h \\le \\left\\lceil \\frac{n}{2^{h+1}} \\right\\rceil \\implies \\mathbf{T(n) = \\sum_{h=0}^{\\log n} \\frac{n}{2^{h+1}} O(h) = O\\left( n \\sum_{h=0}^{\\infty} \\frac{h}{2^h} \\right) = \\mathbf{O(n)!}}\n$$\n• **The Infinite Geometric Derivative Sum:** $\\sum_{h=0}^{\\infty} \\frac{h}{2^h} = 2$ $\\implies$ **Build-Heap runs in strictly $O(n)$ time!**"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of Floyd's bottom-up BUILD-MAX-HEAP construction algorithm.",
      "orderItems": [
        "Receive an unsorted array A of size n representing an implicit complete binary tree",
        "Identify that array elements from index floor(n/2) to n - 1 are leaf nodes with height 0",
        "Set the loop iteration pointer i to the last non-leaf parent node at index floor(n/2) - 1",
        "Execute MAX-HEAPIFY(A, i) to sift down value A[i] into its correct subtree position",
        "Decrement loop index i by 1 and repeat sift-down operations until reaching root index 0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each binary heap parameter to its exact formula or asymptotic bound.",
      "matchPairs": [
        { "left": "Left Child Index Formula", "right": "2*i + 1 for 0-indexed contiguous array representations" },
        { "left": "Parent Index Formula", "right": "floor((i - 1) / 2) mapping child nodes back to their direct tree parent" },
        { "left": "BUILD-HEAP Time Complexity", "right": "O(n) linear time using bottom-up sift-down height aggregation" },
        { "left": "EXTRACT-MAX Time Complexity", "right": "O(log n) logarithmic time swapping root with last element and sifting down" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Building a binary heap bottom-up from an unsorted array of n elements takes an optimal time complexity of O(___).",
      "blankAnswer": "n",
      "blankDistractors": ["n log n", "log n", "n^2"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the primary intuitive and mathematical reason why bottom-up BUILD-HEAP executes in O(n) linear time while inserting n elements one-by-one into an empty heap takes O(n log n) time?",
      "options": [
        { "text": "In sequential insertion, nodes are sifted UP (doing work proportional to depth), meaning roughly n/2 leaf nodes must travel the full height of the tree (~log n); in bottom-up BUILD-HEAP, nodes are sifted DOWN (doing work proportional to height), meaning roughly n/2 leaf nodes have height 0 and do ZERO sift work, while only a tiny fraction of nodes near the root do log n work", "isCorrect": true, "explanation": "Correct! This is one of the most elegant analyses in algorithm design (CLRS Section 6.3). Consider the distribution of nodes in a complete binary tree of $n$ elements: 1. In sequential insertion (`heap.insert()`), every new element is placed at the bottom leaf level and sifted UP toward the root. The work done is proportional to the node's DEPTH (distance from root). In a tree of height $H = \\log_2 n$, the bottom level contains roughly $n/2$ nodes, and each leaf must travel up to $\\log n$ steps. Total work is $\\approx \\frac{n}{2} \\times \\log n = O(n \\log n)$. 2. In bottom-up `BUILD-HEAP` (Floyd's algorithm), we start from the bottom and sift DOWN toward the leaves. The work done is proportional to the node's HEIGHT (distance to leaf). The bottom level contains roughly $n/2$ leaves with height $h = 0$, which do EXACTLY 0 work! The level above contains $n/4$ nodes with height $h = 1$ (at most 1 swap each). The level above contains $n/8$ nodes with height $h = 2$ (at most 2 swaps each). Only the single root node has height $\\log n$. The total work is: $T(n) = n \\cdot \\sum_{h=0}^{\\log n} \\frac{h}{2^{h+1}} = \\frac{n}{2} \\sum_{h=0}^{\\infty} \\frac{h}{2^h} = \\frac{n}{2} \\times 2 = n = O(n)$! Thus, bottom-up construction does the least work where there are the most nodes, yielding a strictly linear $O(n)$ runtime." },
        { "text": "Because BUILD-HEAP uses multi-threading while insertion uses a single thread", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because complete binary trees have only 1 leaf node", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because array indexing takes O(1/n) time in modern RAM", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
