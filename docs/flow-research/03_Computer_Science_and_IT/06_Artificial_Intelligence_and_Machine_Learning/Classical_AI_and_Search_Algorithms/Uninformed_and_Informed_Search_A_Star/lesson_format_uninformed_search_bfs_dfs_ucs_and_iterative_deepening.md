# Duofy Reusable Lesson Format: Uninformed Search (BFS, DFS, UCS, and Iterative Deepening)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Classical_AI_and_Search_Algorithms / Uninformed_and_Informed_Search_A_Star`  
**Lesson Format Type:** `uninformed_search_bfs_dfs_ucs_and_iterative_deepening`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the frontier queuing disciplines, state space exploration mechanics, and asymptotic complexity trade-offs of uninformed blind search algorithms (Russell & Norvig *AIMA* Chapter 3.4): master **Breadth-First Search (BFS)** (FIFO queue, complete, optimal for uniform step costs, $\mathcal{O}(b^d)$ time and catastrophic $\mathcal{O}(b^d)$ exponential memory), master **Depth-First Search (DFS)** (LIFO stack, non-optimal, incomplete in infinite spaces, $\mathcal{O}(b^m)$ time, linear $\mathcal{O}(bm)$ memory), master **Uniform-Cost Search (UCS / Dijkstra)** (priority queue ordered by path cost $g(n)$, complete and optimal for non-negative step costs with complexity $\mathcal{O}(b^{1 + \lfloor C^* / \epsilon \rfloor})$), and master **Iterative Deepening Search (IDS)** (iteratively increasing depth-limited DFS calls $L = 0, 1, 2, \dots, d$, combining **BFS completeness and shallowest-goal optimality** with **DFS linear space efficiency $\mathcal{O}(bd)$**).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Uninformed Search Algorithm Master Matrix (BFS, DFS, UCS, IDS) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Execution of Iterative Deepening Search (IDS) Across Increasing Depth Limits Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Search Algorithm / Frontier Queue & Theoretical Complexity Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Uninformed Search Strategy That Expands Nodes with the Lowest Cumulative Path Cost g(n) (Uniform-Cost Search / UCS) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Proof of Why the Redundant Node Expansion Overhead of IDS is Negligible Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Uninformed Search (Russell & Norvig *AIMA* 3.4):
   - **The 4 Uninformed Strategies Comparison Matrix:**
     $$\begin{array}{|l|l|l|l|l|l|}
     \hline
     \textbf{Strategy} & \textbf{Frontier Data Struct} & \textbf{Complete?} & \textbf{Optimal?} & \textbf{Time} & \textbf{Space} \\
     \hline
     \mathbf{\text{BFS}} & \text{FIFO Queue} & \text{Yes (if } b < \infty\text{)} & \mathbf{\text{Yes (unit cost)}} & \mathcal{O}(b^d) & \mathbf{\mathcal{O}(b^d) \text{ (Fatal RAM bottleneck)}} \\
     \mathbf{\text{DFS}} & \text{LIFO Stack} & \text{No (infinite loops)} & \text{No} & \mathcal{O}(b^m) & \mathbf{\mathcal{O}(b \cdot m) \text{ (Linear RAM)}} \\
     \mathbf{\text{UCS}} & \text{Priority Queue by } g(n) & \text{Yes (if } c \ge \epsilon > 0\text{)} & \mathbf{\text{Yes (arbitrary cost)}} & \mathcal{O}(b^{1 + \lfloor C^* / \epsilon \rfloor}) & \mathcal{O}(b^{1 + \lfloor C^* / \epsilon \rfloor}) \\
     \mathbf{\text{IDS}} & \text{Iterative Depth Limits} & \mathbf{\text{Yes}} & \mathbf{\text{Yes (unit cost)}} & \mathbf{\mathcal{O}(b^d)} & \mathbf{\mathcal{O}(b \cdot d) \text{ (Optimal Blind Search)}} \\
     \hline
     \end{array}$$
   - **Key Invariant:** $b = \text{branching factor}$, $d = \text{depth of shallowest goal}$, $m = \text{maximum search tree depth}$.
2. **Slide 2 (`ordering`):** Provide 5 steps of Iterative Deepening Search finding a goal at depth d=3: (1) set depth limit L=0; evaluate root node; goal not found, (2) increment limit L=1; execute depth-limited DFS up to depth 1; goal not found, (3) increment limit L=2; execute depth-limited DFS up to depth 2; goal not found, (4) increment limit L=3; execute depth-limited DFS expanding nodes at depth 0, 1, 2, and 3, (5) goal test succeeds at depth 3; return optimal shallowest solution path using only O(b*3) memory!
3. **Slide 3 (`matching`):** Pair 4 search algorithms (BFS, DFS, Uniform-Cost Search UCS, Iterative Deepening Search IDS) with their characteristics.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Uniform-Cost Search orders by path cost g(n). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why IDS recomputation overhead is negligible: Why is the overhead of re-generating top-level tree nodes in Iterative Deepening Search (IDS) mathematically insignificant for search trees with branching factor $b \ge 2$? (In an exponential search tree, **the vast majority of nodes reside at the bottom leaf layer (Layer $d$)**; in IDS, Layer $d$ nodes are generated only once, Layer $d-1$ twice, and Layer 1 $d$ times; the total nodes generated is $N(\text{IDS}) = (d)b^1 + (d-1)b^2 + \dots + 1 \cdot b^d = \mathcal{O}(b^d)$; for $b = 10$ and $d = 5$, **the recomputation overhead is only $\approx 11\%$ compared to standard BFS**, while slashing memory consumption from gigabytes down to kilobytes).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "uninformed_search_bfs_dfs_ucs_and_iterative_deepening",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Uninformed Blind Search (Russell \\& Norvig *AIMA* 3.4)**\n• **Core Search Complexity Comparison Matrix:**\n$$\n\\begin{array}{|l|l|l|l|l|l|}\n\\hline\n\\textbf{Algorithm} & \\textbf{Frontier Discipline} & \\textbf{Complete?} & \\textbf{Optimal?} & \\textbf{Time} & \\textbf{Space Complexity} \\\\\n\\hline\n\\mathbf{\\text{BFS}} & \\text{FIFO Queue} & \\text{Yes (finite } b\\text{)} & \\mathbf{\\text{Yes (unit cost)}} & \\mathcal{O}(b^d) & \\mathbf{\\mathcal{O}(b^d) \\text{ (RAM Bottleneck!)}} \\\\\n\\mathbf{\\text{DFS}} & \\text{LIFO Stack} & \\text{No (infinite path)} & \\text{No} & \\mathcal{O}(b^m) & \\mathbf{\\mathcal{O}(b \\cdot m) \\text{ (Linear Memory)}} \\\\\n\\mathbf{\\text{UCS}} & \\mathbf{\\text{Priority Queue by } g(n)} & \\text{Yes (step } \\ge \\epsilon\\text{)} & \\mathbf{\\text{Yes (general cost)}} & \\mathcal{O}(b^{1 + \\lfloor C^* / \\epsilon \\rfloor}) & \\mathcal{O}(b^{1 + \\lfloor C^* / \\epsilon \\rfloor}) \\\\\n\\mathbf{\\text{IDS}} & \\text{Depth-Limited Loop} & \\mathbf{\\text{Yes}} & \\mathbf{\\text{Yes (unit cost)}} & \\mathbf{\\mathcal{O}(b^d)} & \\mathbf{\\mathcal{O}(b \\cdot d) \\text{ (Preferred Blind Search!)}} \\\\\n\\hline\n\\end{array}\n$$\n• **Notation:** $b = \\text{Branching factor}$, $d = \\text{Depth of shallowest goal}$, $m = \\text{Maximum tree depth}$.\n• **The IDS Triumph:** Combines **BFS optimality** with **DFS linear $\\mathcal{O}(bd)$ memory**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed by Iterative Deepening Search (IDS) to find a goal located at depth d = 3.",
      "orderItems": [
        "Initialize depth limit L = 0; evaluate the root node; goal test fails and search terminates at limit 0",
        "Increment limit to L = 1; execute Depth-Limited DFS up to depth 1; expand root and evaluate depth-1 children without finding goal",
        "Increment limit to L = 2; execute Depth-Limited DFS up to depth 2; expand all nodes at depths 0, 1, and 2",
        "Increment limit to L = 3; execute Depth-Limited DFS expanding depth 0, 1, 2, and generating nodes at depth 3",
        "Perform goal test on depth-3 node; goal test succeeds and returns optimal shallowest path using only O(b * 3) memory"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Uninformed Search Strategy to its exact Theoretical Characteristic.",
      "matchPairs": [
        { "left": "Breadth-First Search (BFS)", "right": "Systematically explores level-by-level using a FIFO queue; optimal for unit costs but exhausts RAM" },
        { "left": "Depth-First Search (DFS)", "right": "Explores deep branches first using a LIFO stack; space-efficient O(bm) but prone to infinite loops" },
        { "left": "Uniform-Cost Search (UCS)", "right": "Expands the node with the lowest cumulative path cost g(n); optimal for variable non-negative step costs" },
        { "left": "Iterative Deepening Search (IDS)", "right": "Preferred uninformed search combining BFS completeness and optimality with DFS linear O(bd) memory" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The uninformed search algorithm that expands nodes in order of lowest cumulative path cost g(n) is ___-Cost Search.",
      "blankAnswer": "Uniform",
      "blankDistractors": ["Depth", "Breadth", "Iterative"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the computational overhead of repeatedly re-generating upper-level nodes in Iterative Deepening Search (IDS) mathematically negligible compared to Breadth-First Search (BFS) for trees with branching factor b >= 2?",
      "options": [
        { "text": "In an exponential search tree, the overwhelming majority of all nodes reside at the bottom leaf layer (depth d); in IDS, the leaf nodes at depth d are generated only once, the nodes at depth d-1 are generated twice, and the root is generated d+1 times; mathematically, the total nodes generated is N(IDS) = (d)b + (d-1)b^2 + ... + 1*b^d = O(b^d); for branching factor b = 10, the total recomputation overhead is only approximately 11% more than standard BFS while reducing memory consumption from gigabytes down to kilobytes", "isCorrect": true, "explanation": "Correct! This is one of the most elegant mathematical proofs in classical artificial intelligence (Russell & Norvig *AIMA* Section 3.4.5). 1. **Counting Node Generations:** - In BFS: $N(\\text{BFS}) = 1 + b + b^2 + \\dots + b^d$. - In IDS: $N(\\text{IDS}) = (d+1)1 + (d)b + (d-1)b^2 + \\dots + 1 \\cdot b^d$. 2. **Numerical Example ($b = 10, d = 5$):** - $N(\\text{BFS}) = 1 + 10 + 100 + 1,000 + 10,000 + 100,000 = \\mathbf{111,111\\text{ nodes}}$. - $N(\\text{IDS}) = 6(1) + 5(10) + 4(100) + 3(1,000) + 2(10,000) + 1(100,000) = \\mathbf{123,456\\text{ nodes}}$. - Ratio: $\\frac{123,456}{111,111} \\approx \\mathbf{1.11}$ (Only $11\\%$ extra work!). 3. **The Memory Difference:** - BFS requires storing all $100,000$ leaf nodes in RAM simultaneously (often crash-exhausting system memory). - IDS requires storing only the current active search path in stack memory: $b \\cdot d = 10 \\times 5 = \\mathbf{50\\text{ nodes}}$! - Doing $11\\%$ more CPU additions to save $99.95\\%$ of memory is an extraordinary algorithmic bargain." },
        { "text": "Because computer CPUs can cache the entire tree in L1 cache", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because depth-limited search skips all odd-numbered layers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because IDS automatically converts search trees into binary trees", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
