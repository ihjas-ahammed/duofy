# Duofy Reusable Lesson Format: Prim's MST with Binary and Fibonacci Heaps

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Graph_Algorithms_and_Network_Flow / Kruskal_and_Prim_MST`  
**Lesson Format Type:** `prims_mst_with_binary_and_fibonacci_heaps`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the vertex-growing cut expansion, priority queue mechanics, and heap complexity tradeoffs of the Prim-Jarník Minimum Spanning Tree algorithm (Vojtěch Jarník 1930; Robert C. Prim 1957; Michael L. Fredman & Robert E. Tarjan 1987; Thomas H. Cormen et al. CLRS Chapter 23): master the **Cut Expansion Invariant** (growing a single contiguous tree $A$ from root $r$ by repeatedly selecting the minimum-weight edge crossing the cut between tree vertices $A$ and unvisited vertices $V \setminus A$), evaluate implementation performance across 3 distinct data structures (**1. Adjacency Matrix: $O(V^2)$**, **2. Binary Min-Heap: $\mathbf{O(E\log V)}$**, and **3. Fibonacci Heap: $\mathbf{O(E + V\log V)}$**), analyze why the $O(1)$ amortized `decrease-key` operation in Fibonacci heaps achieves the theoretical minimum bound for dense graphs, and compare memory locality against Kruskal.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Prim's Algorithm Formulation, Heap Implementations, & Cut Expansion Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Prim's Vertex Growth and Priority Queue Relaxation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Prim Heap Structure & Operation Complexity / Graph Density Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Czech Mathematician Who Discovered Prim's Algorithm in 1930 Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Reason Fibonacci Heaps Outperform Binary Heaps on Dense Graphs Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Prim's MST Algorithm (Jarník 1930; Prim 1957; Fredman & Tarjan 1987; CLRS):
   - **The Vertex-Centric Cut Growing Mechanism:**
     - Start at an arbitrary root vertex $r \in V$.
     - Maintain cut $(A, V \setminus A)$ where $A$ is the set of vertices already absorbed into the MST.
     - In each step, extract the minimum-weight edge $(u, v)$ crossing the cut ($u \in A, v \in V \setminus A$) and absorb $v$ into $A$.
   - **Data Structure Performance Comparison:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Priority Queue Implementation} & \textbf{EXTRACT-MIN} & \textbf{DECREASE-KEY} & \textbf{Total MST Runtime} \\
     \hline
     \mathbf{\text{Unsorted Array / Matrix}} & O(V) & O(1) & \mathbf{O(V^2)} \quad (\text{Optimal for dense } E = \Theta(V^2)) \\
     \mathbf{\text{Binary Min-Heap}} & O(\log V) & O(\log V) & \mathbf{O(E\log V)} \quad (\text{Standard for sparse graphs}) \\
     \mathbf{\text{Fibonacci Heap (Fredman-Tarjan)}} & O(\log V) & \mathbf{O(1) \ (\text{Amortized})} & \mathbf{O(E + V\log V)} \quad (\text{Theoretical optimum!}) \\
     \hline
     \end{array}$$
   - **Correctness:** Direct consequence of the Cut Property Theorem at every vertex expansion step.
2. **Slide 2 (`ordering`):** Provide 5 steps of executing Prim's algorithm using a binary min-heap: (1) initialize key values key[v] = infinity and parent pi[v] = null for all vertices, setting root key[r] = 0, (2) insert all |V| vertices into a min-priority queue keyed by their tentative cut-crossing edge weight, (3) extract the vertex u with minimum key[u] from the priority queue (absorbing u into the MST tree A), (4) scan all adjacent edges (u, v) incident to vertex u; if v is in the queue and w(u, v) < key[v], update parent pi[v] = u and decrease key[v] = w(u, v), (5) repeat extraction and key decreases until the queue is empty, returning the completed minimum spanning tree!
3. **Slide 3 (`matching`):** Pair 4 Prim data structures (Fibonacci Heap O(E + V log V), Binary Heap O(E log V), Adjacency Matrix O(V^2), Cut Invariant (A, V \ A)) with their properties.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Prim's algorithm was first discovered by Czech mathematician Vojtěch Jarník in 1930. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why Fibonacci heaps provide an asymptotic speedup over binary heaps in Prim's algorithm: Why does using a Fibonacci heap reduce the runtime of Prim's algorithm from $O(E\log V)$ to $O(E + V\log V)$? (Because Prim's algorithm performs $|V|$ `extract-min` operations and up to $|E|$ `decrease-key` operations; in a binary heap, each `decrease-key` costs $O(\log V)$ yielding $O(E\log V)$, whereas in a Fibonacci heap, **`decrease-key` executes in $O(1)$ amortized time**, reducing the total edge update cost from $O(E\log V)$ down to just $O(E)$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "prims_mst_with_binary_and_fibonacci_heaps",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Prim's MST Algorithm (Jarník 1930; Prim 1957)**\n• **The Vertex-Centric Cut Growing Invariant:**\n$$\n\\text{Repeatedly absorb } v \\in V \\setminus A \\text{ minimizing } \\mathbf{\\min_{u \\in A} w(u, v)} \\implies \\mathbf{\\text{Grows Single Connected Tree!}}\n$$\n• **Data Structure Hierarchy:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Priority Queue Structure} & \\textbf{Total Time Complexity} & \\textbf{Optimal Use Case} \\\\\n\\hline\n\\mathbf{\\text{Adjacency Matrix / Array}} & \\mathbf{O(V^2)} & \\text{Dense Graphs } (E = \\Theta(V^2)) \\\\\n\\mathbf{\\text{Binary Min-Heap}} & \\mathbf{O(E\\log V)} & \\text{Sparse Graphs } (E \\ll V^2) \\\\\n\\mathbf{\\text{Fibonacci Heap (1987)}} & \\mathbf{O(E + V\\log V)} & \\text{Theoretical Optimum (Fredman-Tarjan)} \\\\\n\\hline\n\\end{array}\n$$\n• **Key Insight:** Fibonacci heap makes `decrease-key` $\\mathbf{O(1)\\text{ amortized}}$, reducing edge updates to $O(E)$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of Prim's algorithm implemented with a binary min-heap.",
      "orderItems": [
        "Initialize all vertex key values key[v] = infinity and parent pi[v] = null, setting root key[r] = 0",
        "Push all |V| vertices into a min-priority queue keyed by tentative connection cost key[v]",
        "Extract vertex u with the minimum key value from the priority queue (permanently absorbing u into the tree)",
        "For each adjacent neighbor v still inside the queue, test if edge weight w(u, v) < key[v]",
        "If lighter, update parent pi[v] = u and decrease key[v] = w(u, v) in the priority queue, repeating until empty"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Prim algorithm implementation structure to its computational property.",
      "matchPairs": [
        { "left": "Fibonacci Heap: O(E + V log V)", "right": "Executes up to |E| decrease-key operations in O(1) amortized time each" },
        { "left": "Binary Min-Heap: O(E log V)", "right": "Standard priority queue where each decrease-key costs O(log V) time" },
        { "left": "Adjacency Matrix: O(V^2)", "right": "Array scan optimal for dense graphs where edge count approaches V squared" },
        { "left": "The Active Cut (A, V \\ A)", "right": "Boundary separating currently absorbed tree nodes from remaining unvisited graph nodes" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Prim's Minimum Spanning Tree algorithm was originally discovered by Czech mathematician Vojtěch ___ in 1930.",
      "blankAnswer": "Jarnik",
      "blankDistractors": ["Kruskal", "Dijkstra", "Boruvka"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does using a Fibonacci heap reduce the asymptotic runtime of Prim's algorithm from O(E log V) down to O(E + V log V)?",
      "options": [
        { "text": "Prim's algorithm performs |V| extract-min operations and up to |E| decrease-key operations; in a binary heap, each decrease-key takes O(log V) time yielding O(E log V) total update cost, whereas a Fibonacci heap executes decrease-key in O(1) amortized time, dropping total edge-update cost from O(E log V) down to just O(E)", "isCorrect": true, "explanation": "Correct! This is the classic analysis developed by Michael Fredman and Robert Tarjan in 1987. Prim's algorithm executes two main types of priority queue operations: 1. `EXTRACT-MIN`: Executed exactly $|V|$ times (once per vertex absorbed into the MST). 2. `DECREASE-KEY`: Executed whenever an edge relaxation finds a cheaper connection to an unvisited vertex, which can happen up to $|E|$ times (once per edge). In a standard Binary Min-Heap, `EXTRACT-MIN` takes $O(\\log V)$ and `DECREASE-KEY` takes $O(\\log V)$, giving a total runtime of $|V| \\cdot O(\\log V) + |E| \\cdot O(\\log V) = O(E \\log V)$. In a Fibonacci Heap, `EXTRACT-MIN` takes $O(\\log V)$ amortized, but `DECREASE-KEY` executes in $O(1)$ amortized time using cascading tree cuts. Therefore, the total runtime is $|V| \\cdot O(\\log V) + |E| \\cdot O(1) = O(E + V \\log V)$. For dense graphs where $E = \\Theta(V^2)$, $O(E + V \\log V) = O(V^2)$, which is strictly faster than a binary heap's $O(V^2 \\log V)$." },
        { "text": "Because Fibonacci heaps sort all vertices in O(1) time", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Fibonacci heaps eliminate the need for extract-min operations", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Fibonacci heaps can only be used on complete graphs", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
