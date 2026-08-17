# Duofy Reusable Lesson Format: Disjoint-Set Union DSU (Rank and Path Compression)

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Linear_and_Nonlinear_Data_Structures / Hash_Tables_and_Disjoint_Sets`  
**Lesson Format Type:** `disjoint_set_union_dsu_rank_and_path_compression`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid disjoint set equivalence partitioning, path compression flattening, and rank-based union mastery (Robert E. Tarjan 1975, *Efficiency of a Good But Not Linear Set Union Algorithm*; Thomas H. Cormen et al. CLRS Chapter 21): master the **Forest of Trees Representation** for disjoint sets with `Make-Set(x)`, `Find-Set(x)`, and `Union(x, y)`, formulate the **Union by Rank Optimization** (maintaining tree height bounds of $\le \lfloor \log_2 n \rfloor$ by attaching lower-rank root under higher-rank root), formulate the **Recursive Path Compression Optimization ($\mathbf{\text{parent}[x] = \text{Find-Set}(\text{parent}[x])}$)** collapsing all ancestor nodes along the query path directly to the root, evaluate the **Inverse Ackermann Complexity ($\mathbf{O(m \cdot \alpha(n))}$)**, and interact with live DSU forest tree-flattening simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | DSU Forest Invariants, Path Compression, & Inverse Ackermann Alpha Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | DSU Optimization / Operation & Asymptotic Performance Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Rank Only Increments When Two Equal-Rank Roots Merge Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Name of the DSU Tree-Flattening Technique Executed During Find-Set Queries Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Disjoint-Set Union (DSU) Tree-Flattening Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "disjoint_set_union_dsu_rank_and_path_compression",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are Disjoint-Set Forests and how do Union by Rank + Path Compression achieve O(alpha(n)) amortized time?",
      "blankAnswer": "Disjoint-Set Union (Robert E. Tarjan 1975; CLRS Chapter 21): (1) THE 3 CORE OPERATIONS: (a) Make-Set(x): parent[x] = x, rank[x] = 0 in O(1). (b) Find-Set(x): Traverses parent pointers to find representative root. (c) Union(x, y): Merges trees of Find-Set(x) and Find-Set(y). (2) OPTIMIZATION 1 - UNION BY RANK: Attach root of smaller rank under root of larger rank. Rank only increments when two roots of EQUAL rank merge. Bounds tree height to <= log2 n! (3) OPTIMIZATION 2 - PATH COMPRESSION: In Find-Set(x), set parent[x] = Find-Set(parent[x]). Every node on the path points directly to root, flattening the tree during search! (4) THE THEORETICAL BOUND: Any sequence of m operations on n elements takes O(m * alpha(n)) amortized time, where alpha is the Inverse Ackermann function (alpha(n) <= 4 for all n <= 10^80)! (5) APPLICATIONS: Kruskal's MST, dynamic connectivity, percolation theory, LCA offline queries!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Disjoint-Set Union concept to its exact mathematical purpose.",
      "matchPairs": [
        { "left": "Path Compression", "right": "Recursively sets parent[x] = find(parent[x]) to flatten the tree during lookups" },
        { "left": "Union by Rank", "right": "Attaches root of smaller rank under root of larger rank, bounding depth to log n" },
        { "left": "Inverse Ackermann alpha(n)", "right": "Extremely slow-growing theoretical bound ensuring amortized near-constant runtime" },
        { "left": "Representative Root", "right": "Unique canonical node where parent[root] == root identifying set membership" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "When merging two disjoint-set trees with roots r1 and r2 using the Union by Rank heuristic, under what exact condition does the rank of the resulting root increase by +1?",
      "options": [
        { "text": "Only when the ranks of both roots are identical (rank[r1] == rank[r2]); if ranks are unequal, attaching the shorter tree under the taller root does not increase the overall height of the taller tree, so its rank remains completely unchanged", "isCorrect": true, "explanation": "Correct! In DSU, the 'rank' of a root is an upper bound on the height of its subtree (CLRS Lemma 21.2). When merging two sets with roots $r_1$ and $r_2$: 1. If $\\text{rank}[r_1] > \\text{rank}[r_2]$, $r_2$ is attached as a child of $r_1$. Because $r_2$'s subtree is strictly shorter than $r_1$'s subtree, adding it as a child of $r_1$ does not increase the maximum path length from $r_1$ to any leaf. Thus, $\\text{rank}[r_1]$ remains unchanged. 2. If $\\text{rank}[r_1] < \\text{rank}[r_2]$, $r_1$ is attached under $r_2$, and $\\text{rank}[r_2]$ remains unchanged. 3. If $\\text{rank}[r_1] == \\text{rank}[r_2]$, both subtrees have the exact same height $h$. Attaching one root (say $r_2$) under the other ($r_1$) creates a new path of length $h + 1$ passing through $r_1$. Therefore, $\\text{rank}[r_1]$ must increment by exactly $+1$: $\\text{rank}[r_1] = \\text{rank}[r_1] + 1$. This guarantees that a tree of rank $k$ contains at least $2^k$ nodes, proving that rank is strictly bounded by $\\lfloor \\log_2 n \\rfloor$." },
        { "text": "Rank increases by +1 on every single union operation regardless of ranks", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Rank only increases when the graph has negative cycles", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Rank increments when a node is deleted from the tree", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The DSU optimization that re-links every node on a traversal path directly to the root is called path ___.",
      "blankAnswer": "compression",
      "blankDistractors": ["relaxation", "expansion", "partition"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Disjoint-Set Union (DSU) Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Disjoint-Set Union (DSU) Engine</h3><p>Elements: 0, 1, 2, 3, 4</p><button id=\"un01\" style=\"padding:6px 12px; margin:3px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">Union(0, 1)</button><button id=\"un23\" style=\"padding:6px 12px; margin:3px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">Union(2, 3)</button><button id=\"un13\" style=\"padding:6px 12px; margin:3px; background:#8b5cf6; color:white; border:none; border-radius:4px; cursor:pointer;\">Union(1, 3)</button><button id=\"find4\" style=\"padding:6px 12px; margin:3px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer;\">Find(3) with Path Compression</button><div id=\"dsuOut\" style=\"margin-top:12px; color:#38bdf8; font-family:monospace;\">Initial State: {0}, {1}, {2}, {3}, {4}</div><script>let p=[0,1,2,3,4], r=[0,0,0,0,0]; function find(i){if(p[i]===i) return i; return p[i]=find(p[i]);} function union(i,j){let ri=find(i), rj=find(j); if(ri===rj) return; if(r[ri]<r[rj]) p[ri]=rj; else if(r[ri]>r[rj]) p[rj]=ri; else{p[rj]=ri; r[ri]++;}} document.getElementById('un01').onclick=()=>{union(0,1); updateUI('Union(0,1) complete!');}; document.getElementById('un23').onclick=()=>{union(2,3); updateUI('Union(2,3) complete!');}; document.getElementById('un13').onclick=()=>{union(1,3); updateUI('Union(1,3) complete! Merged components {0,1} and {2,3}');}; document.getElementById('find4').onclick=()=>{let root=find(3); updateUI('Find(3) -> Root is '+root+' (Path Compressed!)'); if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');}; function updateUI(msg){document.getElementById('dsuOut').innerText=msg+' | Parents: ['+p.join(', ')+']';}</script></div>"
    }
  ]
}
```
