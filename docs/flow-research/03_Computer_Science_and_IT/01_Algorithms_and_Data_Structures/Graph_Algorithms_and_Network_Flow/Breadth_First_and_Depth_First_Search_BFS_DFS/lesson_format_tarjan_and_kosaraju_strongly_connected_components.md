# Duofy Reusable Lesson Format: Tarjan and Kosaraju Strongly Connected Components

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Graph_Algorithms_and_Network_Flow / Breadth_First_and_Depth_First_Search_BFS_DFS`  
**Lesson Format Type:** `tarjan_and_kosaraju_strongly_connected_components`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the structural decomposition, graph transposition, and low-link recursion of Strongly Connected Components (SCC) algorithms in directed graphs (S. Rao Kosaraju 1978; Micha Sharir 1981; Robert E. Tarjan 1972; Thomas H. Cormen et al. CLRS Chapter 22): master the definition of an **SCC** as a maximal subgraph where mutual reachability holds ($u \rightsquigarrow v$ and $v \rightsquigarrow u$), contrast **Kosaraju-Sharir's 2-Pass DFS Algorithm** (Pass 1: compute finish times on $G$ and push to stack; Pass 2: execute DFS on the transposed graph $G^T$ popping the stack to extract SCCs one by one) with **Tarjan's 1-Pass DFS Algorithm** (tracking discovery times `tin[u]` and low-link values `low[u] = min(tin[u], tin[v], low[w])` using an explicit vertex stack, where an SCC root is identified by $\mathbf{\text{low}[u] == \text{tin}[u]}$), analyze linear $O(V + E)$ complexity, and evaluate component condensation DAGs.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | SCC Definition, Kosaraju Transposed DFS, & Tarjan Low-Link Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Kosaraju-Sharir Two-Pass SCC Algorithm Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | SCC Algorithmic Concept / Data Structure & Mathematical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Condition Identifying the Root of an SCC in Tarjan's Algorithm Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Architectural Reason Kosaraju's Second Pass Must Operate on Transposed Graph G^T Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State SCCs, Kosaraju, & Tarjan (Kosaraju 1978; Tarjan 1972; CLRS):
   - **Strongly Connected Component (SCC) Definition:**
     - A maximal set of vertices $C \subseteq V$ such that $\forall u, v \in C: u \rightsquigarrow v$ and $v \rightsquigarrow u$.
     - The **Component Graph $G^{\text{SCC}}$** (contracting each SCC to a super-node) is **GUARANTEED TO BE A DAG**!
   - **Algorithm 1: Kosaraju-Sharir (2-Pass DFS, $O(V + E)$):**
     1. **Pass 1:** Run DFS on original graph $G$, pushing vertices onto a LIFO stack upon completion (post-order finish).
     2. **Pass 2:** Construct transposed graph $G^T$ (reverse all edges). While stack is non-empty, pop vertex $u$; if $u$ is unvisited in $G^T$, run DFS from $u$ in $G^T$ $\implies$ The visited set forms an **exact SCC**!
   - **Algorithm 2: Tarjan's SCC (1-Pass DFS with Stack, $O(V + E)$):**
     - Maintain discovery time `tin[u]` and low-link `low[u]`:
       $$\mathbf{\text{low}[u] = \min \Big( \text{tin}[u], \ \min_{(u, v) \in \text{Tree}} \text{low}[v], \ \min_{(u, v) \in \text{Back/Cross}, v \text{ on stack}} \text{tin}[v] \Big)}$$
     - **Root Invariant:** When DFS finishes vertex $u$, if $\mathbf{\text{low}[u] == \text{tin}[u]}$, pop vertices from stack down to $u$ $\implies$ **Outputs complete SCC**!
2. **Slide 2 (`ordering`):** Provide 5 steps of executing Kosaraju's two-pass SCC algorithm: (1) initialize all vertices as unvisited and run a standard DFS traversal on original graph G, (2) as each vertex completes its DFS exploration, push it onto a global LIFO stack ordered by finish time, (3) construct the transposed graph G^T by reversing the direction of every directed edge in E, (4) reset all visited flags to false and begin popping vertices one by one from the LIFO stack, (5) if a popped vertex u is unvisited, launch a new DFS from u on transposed graph G^T, collecting all reachable nodes as one complete Strongly Connected Component!
3. **Slide 3 (`matching`):** Pair 4 SCC concepts (Transposed Graph G^T, Component DAG G^SCC, low[u] == tin[u] condition, On-Stack Array) with their algorithmic roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in Tarjan's SCC algorithm, a node is the root of an SCC if and only if low[u] equals tin[u]. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why Kosaraju's second DFS pass MUST be performed on the transposed graph $G^T$: Why does Kosaraju's algorithm reverse all directed edges ($G^T$) in the second pass rather than searching the original graph $G$? (Because the vertex with the latest finish time in Pass 1 belongs to a **Source SCC in the component DAG $G^{\text{SCC}}$**; running DFS on $G$ would bleed across forward edges into all descendant SCCs, but **transposing the graph reverses the component DAG (turning sources into sinks)**, confining the DFS strictly inside that single SCC).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "tarjan_and_kosaraju_strongly_connected_components",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Strongly Connected Components (Kosaraju 1978; Tarjan 1972)**\n• **SCC & The Component DAG ($G^{\\text{SCC}}$):**\n$$\n\\mathbf{\\forall u, v \\in C: \\ u \\rightsquigarrow v \\ \\land \\ v \\rightsquigarrow u \\qquad (G^{\\text{SCC}} \\text{ is strictly an Acyclic DAG!})}\n$$\n• **Kosaraju's 2-Pass DFS ($O(V + E)$):**\n  - **Pass 1 ($G$):** Push vertices to Stack in order of finish times $f[u]$.\n  - **Pass 2 ($G^T$):** Pop stack, run DFS on **Transposed Graph $G^T$** $\\implies$ Extracts SCCs one-by-one!\n• **Tarjan's 1-Pass DFS ($O(V + E)$):**\n$$\n\\mathbf{\\text{low}[u] = \\min(\\text{tin}[u], \\ \\text{low}[v], \\ \\text{tin}[w]) \\ ; \\quad \\text{If } \\mathbf{\\text{low}[u] == \\text{tin}[u]} \\implies \\text{POP ENTIRE SCC!}}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of Kosaraju's two-pass Strongly Connected Component algorithm.",
      "orderItems": [
        "Perform a full DFS traversal on the original graph G, recording finish order by pushing nodes onto a LIFO stack",
        "Construct the transposed graph G^T by reversing the direction of every directed edge in the graph",
        "Reset the visited tracking array for all vertices to false in preparation for the second traversal pass",
        "Pop the top unvisited vertex u from the LIFO stack (representing the node with the highest finish time)",
        "Execute a DFS traversal originating from u on the transposed graph G^T, outputting all newly visited nodes as one SCC"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Strongly Connected Component concept to its exact algorithmic definition.",
      "matchPairs": [
        { "left": "Transposed Graph G^T", "right": "Graph with all edge orientations reversed, converting source SCCs into sink SCCs" },
        { "left": "Component Graph G^SCC", "right": "Condensation graph collapsing each SCC into a single super-vertex, provably forming a DAG" },
        { "left": "Tarjan's Root Condition (low[u] == tin[u])", "right": "Identifies the head of an SCC on the recursion stack, triggering a batch pop of all component members" },
        { "left": "Tarjan's In-Stack Boolean Array", "right": "Prevents cross edges to previously closed SCCs from artificially corrupting active low-link values" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Tarjan's linear-time SCC algorithm, a vertex u is the root of an SCC if and only if low[u] is equal to ___.",
      "blankAnswer": "tin[u]",
      "blankDistractors": ["0", "f[u]", "low[v]"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why must the second DFS pass in Kosaraju's SCC algorithm be executed on the transposed graph G^T rather than the original graph G?",
      "options": [
        { "text": "The vertex popped from the stack has the highest finish time, guaranteeing it belongs to a Source component in the component DAG G^SCC; running DFS on original G would bleed across outgoing edges into all downstream sink SCCs, but transposing the graph (G^T) reverses all cross-component edges, turning source SCCs into isolated sinks and trapping the DFS strictly inside that single component", "isCorrect": true, "explanation": "Correct! This is the core topological genius of Kosaraju's algorithm (CLRS Section 22.5). In Pass 1, the vertex that finishes absolute last (the top element of the stack) is mathematically guaranteed to belong to a 'Source SCC' in the component DAG $G^{\\text{SCC}}$ (a component with no incoming edges from other components). If you ran DFS on the original graph $G$ starting from this vertex, the search would follow outgoing edges and visit not only its own SCC, but ALSO all other reachable downstream SCCs, jumbling multiple components together. However, when you reverse all edges ($G^T$), every outgoing edge between components becomes an incoming edge! The Source SCC in $G$ becomes a 'Sink SCC' in $G^T$ (having ZERO outgoing edges to any other component). Therefore, launching DFS from the top of the stack on $G^T$ is completely trapped inside that single SCC—it cannot escape into any other component. Once that component is extracted and marked visited, the next node on the stack belongs to the next sink in $G^T$, cleanly peeling off SCCs one by one." },
        { "text": "Because computers cannot perform DFS on non-transposed graphs twice", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because reversing edges changes an NP-complete problem into polynomial time", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because transposed graphs have zero edges", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
