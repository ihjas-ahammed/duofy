# Duofy Reusable Lesson Format: Dijkstra's Single-Source Shortest Path and Heaps

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Graph_Algorithms_and_Network_Flow / Dijkstra_Bellman_Ford_Floyd_Warshall`  
**Lesson Format Type:** `dijkstras_single_source_shortest_path_and_heaps`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the greedy frontier expansion, priority queue mechanics, and non-negative edge constraints of Dijkstra's Single-Source Shortest Path algorithm (Edsger W. Dijkstra 1959; Thomas H. Cormen et al. CLRS Chapter 24): master the **Edge Relaxation Invariant ($\mathbf{d[v] = \min(d[v], \ d[u] + w(u, v))}$)**, analyze implementation complexities across data structures (**Unsorted Array: $O(V^2)$**, **Binary Min-Heap: $\mathbf{O((V + E)\log V)}$**, and **Fibonacci Heap: $O(E + V\log V)$**), prove the **Greedy Finalization Theorem** (when a vertex $u$ is extracted with minimum distance from the priority queue, $d[u]$ is mathematically guaranteed to equal the true shortest path distance $\delta(s, u)$ under non-negative weights $w \ge 0$), and analyze why Dijkstra fails catastrophically on graphs with negative edge weights.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Dijkstra Formulation, Min-Heap Mechanics, & Edge Relaxation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Dijkstra Min-Heap Execution Pipeline Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Dijkstra Implementation / Concept & Asymptotic Time Complexity Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Edge Weight Property Required for Dijkstra's Algorithm to be Correct Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Reason Dijkstra Fails on Graphs with Negative Edge Weights Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Dijkstra's Shortest Path Algorithm (Dijkstra 1959; CLRS):
   - **The Single-Source Shortest Path (SSSP) Problem:**
     - Given directed/undirected graph $G = (V, E)$ with non-negative edge weight function $w: E \to \mathbb{R}^+ \cup \{0\}$ and source vertex $s$.
   - **The Master Relaxation Function:**
     $$\mathbf{\text{RELAX}(u, v, w): \quad \text{if } d[u] + w(u, v) < d[v] \implies d[v] = d[u] + w(u, v), \quad \pi[v] = u}$$
   - **Data Structure & Complexity Comparison:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Queue Structure} & \textbf{EXTRACT-MIN Cost} & \textbf{DECREASE-KEY Cost} & \textbf{Total Time Complexity} \\
     \hline
     \mathbf{\text{Unsorted Array}} & O(V) & O(1) & \mathbf{O(V^2)} \quad (\text{Best for dense graphs } E \approx V^2) \\
     \mathbf{\text{Binary Min-Heap}} & O(\log V) & O(\log V) & \mathbf{O((V + E)\log V)} \quad (\text{Standard sparse graphs}) \\
     \mathbf{\text{Fibonacci Heap}} & O(\log V) & O(1) \ (\text{Amortized}) & \mathbf{O(E + V\log V)} \quad (\text{Theoretical optimum}) \\
     \hline
     \end{array}$$
   - **The Non-Negative Weight Invariant:** Requires $w(u, v) \ge 0$ so path distances grow monotonically along paths.
2. **Slide 2 (`ordering`):** Provide 5 steps of executing Dijkstra's algorithm with a binary min-heap: (1) initialize all vertex distances to infinity, set d[s] = 0, and push all vertices into a min-priority queue keyed by distance d, (2) extract the vertex u with the smallest tentative distance d[u] from the min-priority queue (finalizing d[u]), (3) iterate through each outgoing directed edge (u, v) incident from vertex u, (4) test relaxation: if d[u] + w(u, v) < d[v], update d[v] = d[u] + w(u, v), set predecessor pi[v] = u, and decrease key of v in the heap, (5) continue extracting vertices and relaxing neighbors until the priority queue is empty, returning distance array d!
3. **Slide 3 (`matching`):** Pair 4 Dijkstra implementations (Binary Heap, Fibonacci Heap, Flat 1D Array, Non-Negative Weights) with their asymptotic complexities/properties.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Dijkstra's algorithm strictly requires all edge weights to be non-negative. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the exact failure mode of Dijkstra's algorithm when negative edge weights are present: Why does Dijkstra's greedy algorithm produce incorrect shortest path answers on graphs containing negative edge weights (even if no negative cycles exist)? (Because Dijkstra permanently **finalizes and marks a vertex as 'visited' the moment it is extracted from the min-heap**, assuming that any alternate future path must be longer because edges have positive weights; a negative edge discovered later can **create a detour whose total distance is smaller than the already-finalized distance**, which Dijkstra cannot update without re-inserting finalized nodes).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "dijkstras_single_source_shortest_path_and_heaps",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Dijkstra's Shortest Path Algorithm (1959)**\n• **The Edge Relaxation Invariant:**\n$$\n\\mathbf{\\text{if } d[u] + w(u, v) < d[v] \\implies d[v] = d[u] + w(u, v), \\quad \\pi[v] = u}\n$$\n• **Queue Implementation Architectures:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Priority Queue Mechanism} & \\textbf{Total Time Complexity} & \\textbf{Optimal Use Case} \\\\\n\\hline\n\\mathbf{\\text{Array Matrix}} & \\mathbf{O(V^2)} & \\text{Dense graphs } (E \\approx V^2) \\\\\n\\mathbf{\\text{Binary Min-Heap}} & \\mathbf{O((V + E)\\log V)} & \\text{Sparse graphs } (E \\ll V^2) \\\\\n\\mathbf{\\text{Fibonacci Heap}} & \\mathbf{O(E + V\\log V)} & \\text{Theoretical minimum (Fredman-Tarjan)} \\\\\n\\hline\n\\end{array}\n$$\n• **The Non-Negative Constraint:** Strictly requires $\\mathbf{w(u, v) \\ge 0}$ to guarantee distance monotonicity!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of Dijkstra's algorithm implemented with a binary min-heap.",
      "orderItems": [
        "Initialize distance array with d[s] = 0 and d[v] = infinity for all other nodes, inserting all vertices into a min-heap",
        "Extract the vertex u with the smallest tentative distance d[u] from the min-heap (finalizing its shortest path)",
        "Scan all outgoing directed edges (u, v) incident from the extracted vertex u",
        "If d[u] + w(u, v) < d[v], update d[v] = d[u] + w(u, v), set predecessor pi[v] = u, and decrease key of v in the heap",
        "Repeat the extraction and relaxation loop until the min-heap is empty, returning the finalized shortest path tree"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Dijkstra algorithm implementation to its exact asymptotic time complexity.",
      "matchPairs": [
        { "left": "Binary Min-Heap Implementation", "right": "O((V + E) log V) using standard binary priority queue for sparse graphs" },
        { "left": "Fibonacci Heap Implementation", "right": "O(E + V log V) leveraging O(1) amortized decrease-key operations" },
        { "left": "Unsorted 1D Array Implementation", "right": "O(V^2) scanning all vertices for extract-min, ideal for dense graphs" },
        { "left": "Non-Negative Weight Property (w >= 0)", "right": "Mandatory requirement ensuring path distances grow monotonically during search" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Dijkstra's greedy shortest path algorithm is mathematically guaranteed to be correct only on graphs with non-___ edge weights.",
      "blankAnswer": "negative",
      "blankDistractors": ["zero", "integer", "directed"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does Dijkstra's greedy algorithm fail and produce provably incorrect shortest paths on graphs containing negative edge weights (even in the absence of negative cycles)?",
      "options": [
        { "text": "Dijkstra assumes distance monotonicity: once a vertex u is extracted from the min-heap, its shortest path distance d[u] is permanently finalized and marked visited under the assumption that no future path can be shorter; a negative-weight edge discovered later on a different path can reduce the path cost below the finalized value d[u], but Dijkstra will never re-visit or update the finalized node", "isCorrect": true, "explanation": "Correct! The foundational proof of correctness for Dijkstra's algorithm relies entirely on the Greedy Choice property and Non-Negative Edge weights ($w \\ge 0$). When a vertex $u$ is extracted with the smallest tentative distance from the priority queue, Dijkstra assumes: 'Since all edge weights in the graph are $\\ge 0$, any other unvisited path currently starting from $s$ will only ACCUMULATE more distance as it extends; therefore, no future path can ever reach $u$ with a smaller distance than $d[u]$!' This assumption allows Dijkstra to finalize $u$, color it Black, and never process it again. However, if negative edge weights exist ($w < 0$), extending a seemingly longer path could actually DECREASE total distance (e.g. adding an edge of weight $-10$). That longer path could reach $u$ with a smaller total cost than the finalized $d[u]$. Because standard Dijkstra never re-opens closed nodes, it misses the true shortest path. For negative weights, the Bellman-Ford algorithm must be used instead." },
        { "text": "Because computer priority queues cannot store negative numbers in memory", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because negative edge weights cause Dijkstra's algorithm to enter an infinite loop in 100% of graphs", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Dijkstra's algorithm only works on undirected trees", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
