# Duofy Reusable Lesson Format: Heapsort and In-Place Priority Queues

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Linear_and_Nonlinear_Data_Structures / Heaps_and_Priority_Queues`  
**Lesson Format Type:** `heapsort_and_in_place_priority_queues`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the in-place array manipulation, root-to-end swapping, and non-stability analysis of the Heapsort algorithm (J.W.J. Williams 1964; Robert W. Floyd 1964; Thomas H. Cormen et al. CLRS Chapter 6): master the two-phase Heapsort architecture (**Phase 1: Bottom-up `BUILD-MAX-HEAP` in $O(n)$ time**; **Phase 2: $n-1$ extractions where root $A[0]$ is swapped with current heap tail $A[\text{heap\_size}-1]$, $\text{heap\_size}$ is decremented, and `MAX-HEAPIFY(A, 0)` is invoked in $O(\log n)$ time**), prove that total runtime is strictly **$\mathbf{O(n\log n)\text{ Worst-Case}}$** in strictly **$\mathbf{O(1)\text{ Auxiliary Space}}$**, contrast against Quicksort (which has $O(n^2)$ worst-case) and Mergesort (which requires $O(n)$ space), and demonstrate why Heapsort is inherently an **unstable sorting algorithm**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Heapsort Two-Phase Architecture, O(n log n) Bounds, & In-Place Space Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Heapsort In-Place Array Sorting Loop Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Sorting Algorithm & Asymptotic Space-Time Comparison Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Auxiliary Space Complexity of the In-Place Heapsort Algorithm (O(1)) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Counterexample Showing Why Heapsort is Not a Stable Sort Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Heapsort (Williams 1964; Floyd 1964; CLRS Chapter 6):
   - **The 2 Phases of Heapsort:**
     1. **Phase 1: `BUILD-MAX-HEAP(A)`:** Transforms unsorted array into a max-heap in $O(n)$ time.
     2. **Phase 2: Extraction Loop ($n-1$ Iterations):**
        - For $i = n - 1$ down to 1:
          $$\mathbf{\text{swap}(A[0], A[i]) \ ; \quad \text{heap\_size} = \text{heap\_size} - 1 \ ; \quad \text{MAX-HEAPIFY}(A, 0)}$$
   - **Complexity Profile:**
     - **Worst-Case Time:** $\mathbf{O(n\log n)}$ (Guaranteed; no bad pivots!).
     - **Auxiliary Space:** $\mathbf{O(1)}$ (In-place array manipulation).
   - **Algorithm Comparison:**
     $$\begin{array}{|l|l|l|l|l|}
     \hline
     \textbf{Sorting Algorithm} & \textbf{Average Time} & \textbf{Worst-Case Time} & \textbf{Auxiliary Space} & \textbf{Stability} \\
     \hline
     \mathbf{\text{Heapsort}} & O(n\log n) & \mathbf{O(n\log n)} & \mathbf{O(1)} & \mathbf{\text{Unstable}} \\
     \mathbf{\text{Quicksort}} & O(n\log n) & O(n^2) & O(\log n) & \text{Unstable} \\
     \mathbf{\text{Mergesort}} & O(n\log n) & O(n\log n) & O(n) & \mathbf{\text{Stable}} \\
     \hline
     \end{array}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of executing Heapsort in-place: (1) transform the raw unsorted array into a valid Max-Heap using bottom-up BUILD-MAX-HEAP in O(n) time, (2) set heap_size equal to the total array length n, (3) swap the maximum element at the root A[0] with the current tail element at index heap_size - 1, (4) decrement heap_size by 1 to lock the maximum element into its final sorted position at the end of the array, (5) invoke MAX-HEAPIFY on root index 0 with the reduced heap_size and repeat steps 3-5 until heap_size equals 1!
3. **Slide 3 (`matching`):** Pair 4 sorting algorithms (Heapsort O(1) space, Mergesort Stable O(n) space, Quicksort O(n^2) worst-case, Build-Heap Phase O(n)) with their operational characteristics.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in-place Heapsort operates in O(1) auxiliary memory space. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why Heapsort is an unstable sort: What causes Heapsort to destroy the relative order of duplicate keys (making it an unstable sort)? (Because the `BUILD-HEAP` phase and root-to-tail swapping operations **jump elements across large non-adjacent strides in the array (e.g. swapping root $A[0]$ directly with the last element $A[\text{heap\_size}-1]$)**, causing an earlier duplicate key to jump behind a later duplicate key without preserving their original relative index order).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "heapsort_and_in_place_priority_queues",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Heapsort Algorithm (Williams 1964)**\n• **The 2-Phase In-Place Architecture:**\n$$\n\\mathbf{\\text{Phase 1: } \\text{BUILD-MAX-HEAP}(A) \\ [O(n)]} \\implies \\mathbf{\\text{Phase 2: } n-1 \\text{ Extract Swaps } [O(n\\log n)]}\n$$\n• **The In-Place Extraction Loop:**\n$$\n\\text{For } i = n-1 \\text{ down to } 1: \\quad \\mathbf{\\text{swap}(A[0], A[i]) \\ ; \\quad \\text{heap\\_size}-- \\ ; \\quad \\text{MAX-HEAPIFY}(A, 0)}\n$$\n• **Algorithmic Profile:**\n  - **Worst-Case Time:** $\\mathbf{O(n\\log n)}$ (Guaranteed optimal comparison bound).\n  - **Auxiliary Space:** $\\mathbf{O(1)}$ (Completely in-place; no extra arrays).\n  - **Stability:** **Unstable** (Long-distance swaps destroy relative key order)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the in-place Heapsort sorting procedure.",
      "orderItems": [
        "Construct a valid Max-Heap from the unsorted input array using bottom-up BUILD-MAX-HEAP in O(n) time",
        "Initialize active heap_size variable to the total array length n",
        "Swap the global maximum element at root A[0] with the current tail element at index heap_size - 1",
        "Decrement heap_size by 1 to lock the extracted maximum value into its final sorted position at the end",
        "Execute MAX-HEAPIFY on root index 0 with the reduced heap_size, repeating swaps until heap_size = 1"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each sorting algorithm to its exact space-time classification.",
      "matchPairs": [
        { "left": "Heapsort", "right": "O(n log n) worst-case time with O(1) in-place auxiliary space (Unstable)" },
        { "left": "Mergesort", "right": "O(n log n) worst-case time with O(n) auxiliary buffer space (Stable)" },
        { "left": "Standard Quicksort", "right": "O(n log n) average time with O(n^2) worst-case pivot degradation" },
        { "left": "BUILD-MAX-HEAP Phase", "right": "O(n) linear-time prerequisite phase organizing raw array into a heap" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In-place Heapsort sorts an array without allocating secondary buffers, requiring O(___) auxiliary memory space.",
      "blankAnswer": "1",
      "blankDistractors": ["n", "log n", "n^2"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is Heapsort categorized as an 'unstable' sorting algorithm?",
      "options": [
        { "text": "The algorithm executes long-distance swaps between the root at index 0 and the current tail at index heap_size - 1, as well as during parent-child sift-down operations; these non-adjacent swaps can jump an earlier duplicate element past a later duplicate element, destroying their original relative input order", "isCorrect": true, "explanation": "Correct! A sorting algorithm is defined as 'stable' if elements with equal keys appear in the output array in the exact same relative order as they were in the input. In Heapsort, elements are moved across large distances in the array during two operations: 1. `BUILD-MAX-HEAP` / `sift-down`: An internal node can jump over equal elements in lower branches. 2. Root-to-tail swap: In every iteration of Phase 2, the root element $A[0]$ is swapped directly with the last element of the active heap $A[\\text{heap\\_size}-1]$. Consider the simple array $\\langle 3_a, 3_b, 1 \\rangle$: After building the heap, $3_a$ is at root $A[0]$, $3_b$ is at $A[1]$, and $1$ is at $A[2]$. In the first extraction, root $3_a$ is swapped with the last element $A[2]$, placing $3_a$ at the very end of the array! The resulting sorted array becomes $\\langle 1, 3_b, 3_a \\rangle$. Notice that $3_b$ now appears BEFORE $3_a$, inverting their original order. Because Heapsort cannot preserve equal key ordering, it is inherently unstable." },
        { "text": "Because Heapsort crashes on arrays with odd lengths", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Heapsort has an O(n!) worst-case runtime", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Heapsort can only sort floating-point numbers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
