# Duofy Reusable Lesson Format: Bellman-Ford and Negative Cycle Detection

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Graph_Algorithms_and_Network_Flow / Dijkstra_Bellman_Ford_Floyd_Warshall`  
**Lesson Format Type:** `bellman_ford_and_negative_cycle_detection`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the dynamic programming convergence, edge relaxation multi-pass loops, and negative cycle detection mechanics of the Bellman-Ford algorithm (Richard Bellman 1958; Lester Ford Jr. 1956; Edward F. Moore; Thomas H. Cormen et al. CLRS Chapter 24): master the foundational structural property that any simple shortest path in a graph with $|V|$ vertices contains at most **$|V| - 1$ edges**, execute the **$|V| - 1$ Global Relaxation Passes** over all $|E|$ edges in $O(V \cdot E)$ time, formulate the **$|V|$-th Pass Negative Cycle Detection Theorem** (if any edge $(u, v)$ can still be relaxed such that $d[u] + w(u, v) < d[v]$ during the $|V|$-th iteration, a **negative-weight cycle reachable from source $s$ exists**), reconstruct negative cycles via predecessor backtracking, and explore the queue-based **SPFA (Shortest Path Faster Algorithm)** optimization.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bellman-Ford Formulation, V-1 Passes, & Negative Cycle Test Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Bellman-Ford Multi-Pass Relaxation and Cycle Check Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Bellman-Ford Pass / Variable & Mathematical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Maximum Number of Edges in Any Simple Path Between Vertices (|V| - 1) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Proof Why the V-th Pass Discovers Reachable Negative Cycles Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State The Bellman-Ford Algorithm (Bellman 1958; Ford 1956; CLRS):
   - **The Single-Source Shortest Path (SSSP) with Negative Weights:**
     - Solves SSSP on graphs with arbitrary real edge weights $w: E \to \mathbb{R}$.
   - **The Path-Length Principle:**
     - In any graph without negative cycles, the shortest path between any two vertices is a **simple path containing at most $|V| - 1$ edges**.
   - **The Algorithm Architecture ($O(V \cdot E)\text{ Time}$):**
     1. Initialize: $d[s] = 0, \ d[v] = \infty \ (\forall v \ne s)$.
     2. **Execute $|V| - 1$ Passes:**
        - For pass $i = 1 \dots |V| - 1$:
          - For every directed edge $(u, v) \in E$:
            $$\mathbf{\text{if } d[u] + w(u, v) < d[v] \implies d[v] = d[u] + w(u, v), \quad \pi[v] = u}$$
     3. **The $|V|$-th Pass (Negative Cycle Check):**
        $$\mathbf{\text{if } \exists (u, v) \in E \text{ such that } d[u] + w(u, v) < d[v] \implies \mathbf{\text{NEGATIVE-WEIGHT CYCLE DETECTED!}}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of executing the Bellman-Ford algorithm: (1) initialize the distance array setting source distance d[s] = 0 and all other vertex distances to infinity, (2) run an outer loop that executes for exactly |V| - 1 iterations, (3) in each iteration, iterate through all |E| directed edges in the graph, relaxing every edge where d[u] + w(u, v) < d[v], (4) execute a final |V|-th pass over all |E| edges to test if any edge can still be successfully relaxed, (5) if any distance decreases in the |V|-th pass, report a negative cycle; otherwise return True with the optimal shortest path tree!
3. **Slide 3 (`matching`):** Pair 4 Bellman-Ford components (|V| - 1 Iteration Loop, |V|-th Pass, O(V * E) Time, SPFA Queue Optimization) with their algorithmic functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the outer relaxation loop of Bellman-Ford runs for exactly |V| minus 1 passes. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the mathematical proof behind negative cycle detection on the $|V|$-th pass: Why does an edge relaxation succeeding on the $|V|$-th pass of Bellman-Ford conclusively prove the existence of a negative-weight cycle? (Because any simple cycle-free path can contain at most $|V| - 1$ edges and is **guaranteed to have fully converged to its optimal shortest distance by pass $|V| - 1$**; if a distance can STILL decrease on pass $|V|$, the path must contain **at least $|V|$ edges, which means by the Pigeonhole Principle it must repeat a vertex (forming a cycle)** whose net weight must be negative to decrease the path cost).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "bellman_ford_and_negative_cycle_detection",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Bellman-Ford Algorithm (1958)**\n• **The Path-Length Principle:** Any simple shortest path contains **at most $|V| - 1$ edges**.\n• **The $|V| - 1$ Pass Relaxation Invariant ($O(V \\cdot E)$ Time):**\n$$\n\\text{For } i = 1 \\dots |V|-1: \\quad \\text{For each } (u, v) \\in E: \\quad \\mathbf{\\text{if } d[u] + w(u, v) < d[v] \\implies d[v] = d[u] + w(u, v)}\n$$\n  - Pass $k$ guarantees shortest paths using $\\le k$ edges are completely solved!\n• **The $|V|$-th Pass (Negative Cycle Theorem):**\n$$\n\\mathbf{\\exists (u, v) \\in E : d[u] + w(u, v) < d[v] \\implies \\mathbf{\\text{NEGATIVE-WEIGHT CYCLE DETECTED!}}}\n$$\n• **Arbitrage Applications:** Detects currency exchange arbitrage loops via $\\log$ weight inversion!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential algorithmic steps of the Bellman-Ford shortest path and negative cycle detection solver.",
      "orderItems": [
        "Initialize distance array with d[s] = 0 and d[v] = infinity for all other vertices in graph G = (V, E)",
        "Execute an outer iteration loop that runs for exactly |V| - 1 complete passes",
        "Within each pass, iterate through all |E| directed edges and apply the relaxation condition d[v] = min(d[v], d[u] + w)",
        "Perform a final |V|-th pass over all |E| edges checking if any edge can still reduce a destination distance d[v]",
        "If any edge relaxes on the |V|-th pass, output False (Negative Cycle Detected); otherwise return True with shortest paths"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Bellman-Ford algorithm concept to its exact operational role.",
      "matchPairs": [
        { "left": "|V| - 1 Relaxation Passes", "right": "Guarantees full convergence of all simple shortest paths containing up to |V| - 1 edges" },
        { "left": "|V|-th Detection Pass", "right": "Identifies reachable negative-weight cycles by testing if any edge can still be relaxed" },
        { "left": "O(V * E) Time Complexity", "right": "Asymptotic cost resulting from |V| passes scanning all |E| graph edges" },
        { "left": "SPFA (Queue Optimization)", "right": "Heuristic variant that enqueues only nodes whose distances were updated in the previous step" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In any graph with |V| vertices, a simple path containing no repeated nodes can have at most |V| minus ___ edges.",
      "blankAnswer": "1",
      "blankDistractors": ["2", "0", "V"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What mathematical theorem proves that if an edge (u, v) can still be successfully relaxed during the |V|-th pass of Bellman-Ford, a negative-weight cycle must exist?",
      "options": [
        { "text": "In a graph with |V| vertices, every simple path contains at most |V| - 1 edges, which are mathematically guaranteed to achieve their minimum possible distance by pass |V| - 1; if a distance decreases on the |V|-th pass, the corresponding path must contain at least |V| edges, which by the Pigeonhole Principle forces it to contain a repeated vertex (a cycle) whose net weight must be negative to produce a lower total sum", "isCorrect": true, "explanation": "Correct! This is the formal convergence theorem of Bellman-Ford (CLRS Theorem 24.4). Consider a graph $G = (V, E)$ with $|V|$ vertices. A path without cycles (a simple path) can visit at most $|V|$ distinct vertices, which means it consists of at most $|V| - 1$ edges. In Bellman-Ford, Pass 1 guarantees that all shortest paths of length 1 edge are optimal. Pass 2 guarantees that all shortest paths of length 2 edges are optimal. By induction, Pass $|V| - 1$ guarantees that ALL shortest paths of length up to $|V| - 1$ edges are 100% optimal and converged. If the graph contains no negative cycles, all shortest paths are simple paths (since traversing a positive or zero cycle only increases or maintains path cost). Therefore, if there are NO negative cycles, no edge in the entire graph can possibly be relaxed on Pass $|V|$. However, if some edge $(u, v)$ CAN still be relaxed on the $|V|$-th pass ($d[u] + w(u, v) < d[v]$), it means the algorithm has found a path with $|V|$ edges that is cheaper than any path with $|V| - 1$ edges. By the Pigeonhole Principle, a path with $|V|$ edges across $|V|$ vertices MUST visit at least one vertex twice, forming a cycle. Because traversing this cycle resulted in a strictly smaller path weight, the sum of edge weights around this cycle must be strictly negative ($< 0$), proving a negative cycle exists." },
        { "text": "Because all |V|-th passes automatically multiply edge weights by -1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because graphs with |V| edges cannot be stored in computer memory", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Bellman-Ford is an exponential algorithm that guesses answers on pass |V|", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
