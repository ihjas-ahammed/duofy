# Duofy Reusable Lesson Format: Minimum Spanning Trees (Kruskal DSU and Prim)

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Algorithm_Design_Techniques / Greedy_Algorithms`  
**Lesson Format Type:** `minimum_spanning_trees_kruskal_dsu_and_prim`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid graph-algorithms, greedy cut-property, and disjoint-set data structure mastery for Minimum Spanning Trees (MST) in connected undirected graphs (Otakar Borůvka 1926; Joseph B. Kruskal 1956; Robert C. Prim 1957; Robert Tarjan): master the **Cut Property Theorem** (the minimum-weight edge crossing any cut $(S, V \setminus S)$ belongs to the MST), contrast **Kruskal's Algorithm** (sorting edges by weight, adding non-cycle edges using **Disjoint-Set Union [DSU / Union-Find]** with **Path Compression and Union by Rank** in $O(E\log E)$) with **Prim's Algorithm** (growing a single connected tree from an arbitrary root vertex using a **Min-Priority Queue / Binary Heap** in $O((V + E)\log V)$), analyze graph density trade-offs (Kruskal on sparse graphs vs Prim on dense graphs), and interact with live MST network construction engines.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Cut Property, Kruskal DSU, & Prim Priority Queue Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | MST Algorithm / Data Structure Optimization & Performance Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Dense vs Sparse Graph Selection: Kruskal vs Prim Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Total Number of Edges in an MST of a Connected Graph with V Vertices Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Minimum Spanning Tree (Kruskal vs Prim) Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "minimum_spanning_trees_kruskal_dsu_and_prim",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Cut Property and how do Kruskal's and Prim's algorithms find Minimum Spanning Trees?",
      "blankAnswer": "Minimum Spanning Tree (MST) algorithms on connected weighted undirected graphs G = (V, E) (Kruskal 1956; Prim 1957; CLRS): (1) THE CUT PROPERTY: For any partition (cut) of vertices into S and V \\ S, the lightest edge e = (u, v) crossing the cut is guaranteed to belong to the MST. (2) KRUSKAL'S ALGORITHM (Edge-Centric): (a) Sort all E edges by ascending weight in O(E log E). (b) Iterate through sorted edges, greedily adding edge (u, v) to the MST if it connects two previously disconnected components. (c) Uses Disjoint-Set Union (DSU / Union-Find with Path Compression and Union by Rank) to perform near-constant time O(alpha(V)) cycle detection! Total Runtime: O(E log E) -> Ideal for sparse graphs! (3) PRIM'S ALGORITHM (Vertex-Centric): (a) Start at an arbitrary root vertex r. (b) Maintain a Min-Priority Queue of cut-crossing edges connecting the growing tree to unvisited vertices. (c) Repeatedly extract the minimum-weight crossing edge and absorb the new vertex into the tree. Total Runtime: O(E log V) with binary heap, or O(E + V log V) with Fibonacci heap -> Ideal for dense graphs!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Minimum Spanning Tree component to its exact algorithmic definition.",
      "matchPairs": [
        { "left": "The Cut Property", "right": "Theorem proving that the minimum-weight edge crossing any cut boundary must belong to the MST" },
        { "left": "Disjoint-Set Union (DSU)", "right": "Data structure maintaining connected components with near O(1) find and union operations" },
        { "left": "Path Compression", "right": "DSU optimization pointing all visited tree nodes directly to the root during find operations" },
        { "left": "Prim's Algorithm", "right": "Vertex-growing greedy approach continuously absorbing the nearest unvisited node via priority queue" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "When finding the Minimum Spanning Tree of a dense graph where the number of edges approaches the maximum possible (E ≈ V^2), why is Prim's algorithm using an adjacency matrix or Fibonacci heap preferred over Kruskal's algorithm?",
      "options": [
        { "text": "Kruskal's algorithm must sort all E edges, taking O(E log E) = O(V^2 log(V^2)) = O(V^2 log V) time; whereas Prim's algorithm implemented with an adjacency matrix executes in O(V^2) time, completely eliminating edge-sorting overhead in dense graphs", "isCorrect": true, "explanation": "Correct! In computational graph theory, the choice between Kruskal's and Prim's algorithms depends on graph density. A dense graph has $E = \\Theta(V^2)$ edges. Kruskal's algorithm begins by sorting all edges, which takes $O(E \\log E) = O(V^2 \\log(V^2)) = O(2 V^2 \\log V) = O(V^2 \\log V)$ time. In contrast, Prim's algorithm implemented with an adjacency matrix and a simple array (or Fibonacci heap) finds the minimum distance vertex in $O(V)$ time per step for $V$ steps, yielding a total runtime of $O(V^2)$ time with zero logarithmic overhead ($O(V^2) < O(V^2 \\log V)$). Conversely, for sparse graphs where $E = O(V)$, Kruskal's algorithm runs in $O(V \\log V)$ time, making it exceptionally fast." },
        { "text": "Because Kruskal's algorithm crashes if a graph has more than 10 edges", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Prim's algorithm only works on graphs with zero edge weights", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because dense graphs do not have spanning trees", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A Minimum Spanning Tree of any connected graph with V vertices contains exactly V minus ___ edges (E = V - 1).",
      "blankAnswer": "1",
      "blankDistractors": ["2", "0", "V"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Minimum Spanning Tree (Kruskal vs Prim) Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Minimum Spanning Tree (MST) Engine</h3><p>Graph: 4 Vertices (A, B, C, D) | Edges: (A-B:1, B-C:2, C-D:3, A-D:4, A-C:5)</p><button id=\"krusBtn\" style=\"padding:8px 14px; margin:3px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">Run Kruskal's (DSU Edge-Sort)</button><button id=\"primBtn\" style=\"padding:8px 14px; margin:3px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">Run Prim's (Cut-Growing Heap)</button><div id=\"mstOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Select an MST algorithm above...</div><script>document.getElementById('krusBtn').onclick=()=>{document.getElementById('mstOut').innerText='KRUSKAL: Sorted edges [A-B:1, B-C:2, C-D:3, A-D:4, A-C:5] -> Picked A-B(1), B-C(2), C-D(3) -> Total Weight = 6 (Acyclic via DSU)!';}; document.getElementById('primBtn').onclick=()=>{document.getElementById('mstOut').innerText='PRIM: Start at A -> Add A-B(1) -> Cut boundary to C/D -> Add B-C(2) -> Add C-D(3) -> Total Weight = 6 (Grown via Min-Cut)!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
