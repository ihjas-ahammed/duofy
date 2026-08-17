# Duofy Reusable Lesson Format: DFS Timestamps and Directed Edge Classification

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Graph_Algorithms_and_Network_Flow / Breadth_First_and_Depth_First_Search_BFS_DFS`  
**Lesson Format Type:** `dfs_timestamps_and_directed_edge_classification`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the recursive stack mechanics, timestamp intervals, and 4-way edge categorization of Depth-First Search (DFS) on directed graphs (Robert E. Tarjan 1972; Thomas H. Cormen et al. CLRS Chapter 22): master the **Timestamp Intervals ($[d[u], f[u]]$)** where $d[u]$ is the discovery time and $f[u]$ is the finish time, prove the **Parenthesis Theorem** (intervals are either entirely disjoint or strictly nested, indicating ancestor-descendant relationships), formulate the **4 Directed Edge Types** (**1. Tree Edges [White $v$]**, **2. Back Edges [Gray $v \implies$ DIRECTED CYCLE]**, **3. Forward Edges [Black $v$ with $d[u] < d[v]$]**, and **4. Cross Edges [Black $v$ with $d[u] > d[v]$]**), prove that an undirected graph has ONLY Tree and Back edges, and perform **Topological Sorting on DAGs** by sorting vertices in descending order of finish times $f[u]$ in $O(V + E)$ time.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | DFS Timestamps, Parenthesis Theorem, & 4 Edge Categories Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Recursive DFS Traversal and Timestamp Assignment Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Directed Edge Type & Vertex Color / Timestamp Condition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Edge Type Whose Presence Conclusively Proves a Directed Graph Has a Cycle Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Connection Between DFS Finish Times f[u] and Topological Sorting on DAGs Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State DFS Timestamps & Edge Classification (Tarjan 1972; CLRS):
   - **DFS Three-Color State System & Timestamps:**
     - **White:** Undiscovered ($d[u] = \text{undef}, f[u] = \text{undef}$).
     - **Gray:** Discovered, currently on recursion stack ($d[u] = \text{time}++$).
     - **Black:** Finished, all descendants explored ($f[u] = \text{time}++$).
   - **The Parenthesis Theorem:**
     - For any $u, v \in V$, the intervals $[d[u], f[u]]$ and $[d[v], f[v]]$ are either:
       1. **Disjoint:** Neither is a descendant of the other.
       2. **Nested ($[d[v], f[v]] \subset [d[u], f[u]]$):** $v$ is a descendant of $u$ in the DFS tree!
   - **The 4 Directed Edge Classifications for $(u, v) \in E$:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Edge Type} & \textbf{Target Color } v & \textbf{Timestamp Invariant} & \textbf{Structural Meaning} \\
     \hline
     \mathbf{\text{Tree Edge}} & \text{White} & d[u] < d[v] < f[v] < f[u] & \text{Discovers a new vertex} \\
     \mathbf{\text{Back Edge}} & \mathbf{\text{Gray}} & d[v] < d[u] < f[u] < f[v] & \mathbf{\text{Points to Ancestor } \implies \text{CYCLE DETECTED!}} \\
     \mathbf{\text{Forward Edge}} & \text{Black} & d[u] < d[v] < f[v] < f[u] & \text{Points to non-child descendant} \\
     \mathbf{\text{Cross Edge}} & \text{Black} & d[v] < f[v] < d[u] < f[u] & \text{Points to lateral/unrelated subtree} \\
     \hline
     \end{array}$$
   - **Topological Sort on DAGs:** Directed Acyclic Graph has NO back edges $\implies$ **Sort vertices in decreasing order of $f[u]$** in $O(V + E)$!
2. **Slide 2 (`ordering`):** Provide 5 steps of the recursive DFS visit algorithm: (1) increment global time counter and record discovery time d[u], painting vertex u Gray (active on stack), (2) iterate through all outgoing edges (u, v) from vertex u, (3) if target v is White, classify (u, v) as a Tree edge and recursively call DFS-Visit(v), (4) if target v is Gray, classify (u, v) as a Back edge indicating a directed cycle in the graph, (5) after all outgoing edges from u are explored, paint u Black, increment global time counter, and record finish time f[u]!
3. **Slide 3 (`matching`):** Pair 4 DFS directed edge types (Tree Edge, Back Edge, Forward Edge, Cross Edge) with their color states and structural roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that a directed graph contains a cycle if and only if DFS produces at least one back edge. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why topological sort on a DAG is achieved by ordering vertices in reverse finish time: In a Directed Acyclic Graph (DAG), why does ordering vertices in descending order of their DFS finish times ($f[u]$) produce a valid topological sort where every directed edge $(u, v)$ has $u$ appearing before $v$? (Because for any directed edge $(u, v)$ in a DAG, **$v$ cannot be an ancestor of $u$ (which would create a back-edge cycle)**; thus, whether $v$ is a descendant of $u$ or in a previously completed cross branch, **$v$ must finish and be painted Black before $u$ finishes, guaranteeing $f[u] > f[v]$**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "dfs_timestamps_and_directed_edge_classification",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: DFS Timestamps & Edge Classification (CLRS)**\n• **Timestamp Intervals ($[d[u], f[u]]$) & The Parenthesis Theorem:**\n$$\n[d[v], f[v]] \\subset [d[u], f[u]] \\iff \\mathbf{v \\text{ is a descendant of } u \\text{ in the DFS tree!}}\n$$\n• **The 4 Directed Edge Categories:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Edge Type} & \\textbf{Target Color } v & \\textbf{Structural Meaning} \\\\\n\\hline\n\\mathbf{\\text{Tree Edge}} & \\text{White} & \\text{Traverses to undiscovered node} \\\\\n\\mathbf{\\text{Back Edge}} & \\mathbf{\\text{Gray (Ancestor)}} & \\mathbf{\\text{DIRECTED CYCLE DETECTED!}} \\\\\n\\mathbf{\\text{Forward Edge}} & \\text{Black} & \\text{Points to non-child descendant ($d[u] < d[v]$)} \\\\\n\\mathbf{\\text{Cross Edge}} & \\text{Black} & \\text{Points to unrelated subtree ($d[v] < d[u]$)} \\\\\n\\hline\n\\end{array}\n$$\n• **Topological Sort on DAGs:** Reverse order of finish times $\\mathbf{f[u]}$ in $O(V + E)$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the recursive DFS-Visit algorithm on a vertex u.",
      "orderItems": [
        "Increment global timestamp counter and record discovery time d[u], coloring vertex u Gray",
        "Iterate through all outgoing directed edges (u, v) incident from vertex u",
        "If neighbor v is White, mark (u, v) as a Tree edge and recursively invoke DFS-Visit(v)",
        "If neighbor v is Gray, classify (u, v) as a Back edge confirming the presence of a directed cycle",
        "After inspecting all incident edges, color vertex u Black, increment timestamp counter, and record finish time f[u]"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each directed DFS edge classification to its exact mathematical properties.",
      "matchPairs": [
        { "left": "Tree Edge (u -> White v)", "right": "Edge in the DFS depth tree discovering a new unvisited vertex where d[u] < d[v] < f[v] < f[u]" },
        { "left": "Back Edge (u -> Gray v)", "right": "Edge pointing backward to an active ancestor on the recursion stack proving a cycle exists" },
        { "left": "Forward Edge (u -> Black v)", "right": "Nontree edge connecting an ancestor node u directly to a descendant node v in the tree" },
        { "left": "Cross Edge (u -> Black v)", "right": "Edge connecting two vertices in different subtrees where d[v] < f[v] < d[u] < f[u]" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A directed graph is acyclic (a DAG) if and only if a Depth-First Search traversal yields zero ___ edges.",
      "blankAnswer": "back",
      "blankDistractors": ["cross", "forward", "tree"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does sorting the vertices of a Directed Acyclic Graph (DAG) in descending order of their DFS finish times f[u] mathematically guarantee a valid topological sort?",
      "options": [
        { "text": "For every directed edge (u, v) in a DAG, the finish time of u is strictly greater than the finish time of v (f[u] > f[v]); because if v was undiscovered when exploring u, v finishes before u returns; and if v was already finished (Black), v finished before u was discovered; since DAGs contain zero back-edges, v could never be Gray, guaranteeing f[u] > f[v] for all edges", "isCorrect": true, "explanation": "Correct! This is the fundamental theorem connecting DFS and Topological Sorting (CLRS Theorem 22.7). Consider any directed edge $(u, v)$ in a graph $G$. When the DFS algorithm examines edge $(u, v)$ while at node $u$, there are three possible color states for node $v$: 1. If $v$ is Gray: $(u, v)$ is a Back Edge, which means $v$ is an ancestor of $u$. This would create a directed cycle $v \rightsquigarrow u \to v$. But since $G$ is a DAG (Acyclic), Back Edges are impossible! 2. If $v$ is White: $v$ becomes a descendant of $u$ in the DFS tree. By the Parenthesis Theorem, $[d[v], f[v]] \subset [d[u], f[u]]$, which guarantees $f[u] > f[v]$. 3. If $v$ is Black: $v$ has already completely finished its entire exploration before edge $(u, v)$ was even examined, meaning $f[v] < d[u] < f[u]$. In ALL valid cases in a DAG, we mathematically have $\mathbf{f[u] > f[v]}$. Therefore, if we place vertices with larger finish times before vertices with smaller finish times (sorting in descending order of finish time $f$), every edge $(u, v)$ will point from left to right, producing a perfect linear topological order." },
        { "text": "Because vertices with larger finish times have more RAM allocated to them", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because DAGs can only be traversed using Breadth-First Search", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because all vertices in a DAG finish at the exact same second", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
