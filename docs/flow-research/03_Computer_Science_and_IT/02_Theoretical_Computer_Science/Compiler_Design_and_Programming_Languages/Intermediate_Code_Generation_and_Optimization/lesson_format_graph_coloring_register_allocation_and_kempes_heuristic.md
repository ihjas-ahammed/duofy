# Duofy Reusable Lesson Format: Graph Coloring Register Allocation and Kempe's Heuristic

**Target Topic:** `03_Computer_Science_and_IT / 02_Theoretical_Computer_Science / Compiler_Design_and_Programming_Languages / Intermediate_Code_Generation_and_Optimization`  
**Lesson Format Type:** `graph_coloring_register_allocation_and_kempes_heuristic`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the interference graph modeling, live-range conflict detection, and Kempe heuristic simplification passes of Graph-Coloring Register Allocation (Gregory J. Chaitin 1981, *Register Allocation & Spilling via Graph Coloring*; Preston Briggs 1992; Alfred V. Aho et al. *The Dragon Book* Chapter 8.8): construct the **Interference Graph $G = (V, E)$** (where nodes are variable live ranges, and edge $(u, v) \in E$ indicates variables $u$ and $v$ are **simultaneously live** at some program point and cannot share the same physical register), formulate **Kempe's $K$-Coloring Heuristic** (if node $u$ has degree $< K$, it can always be assigned a color after the rest of the graph is colored), execute the **4-Phase Build-Simplify-Spill-Select Architecture**, manage **Spill Costs and Memory Loads/Stores**, and evaluate why register allocation is NP-complete for $K \ge 3$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Register Allocation Problem, Interference Graph Invariant, & Kempe's Lemma Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Chaitin-Briggs Build-Simplify-Spill-Select Register Allocation Loop Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Register Allocation Entity / Phase & Algorithmic Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the State When a Variable Cannot Get a Physical Register and is Written to RAM (Spill) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Proof Why Any Node with Degree < K is Guaranteed Colorable (Kempe's Lemma) Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Graph Coloring Register Allocation (Chaitin 1981; Briggs 1992; Dragon Book Chapter 8):
   - **The Problem:** Map an unbounded number of symbolic IR variables into $K$ physical hardware registers without collisions.
   - **The Interference Graph $G = (V, E)$:**
     - Vertices $V$: Variable live ranges.
     - Edges $E$: An edge connects $u$ and $v$ $\iff$ $u$ and $v$ are **simultaneously LIVE at the same program point**.
     - A valid register allocation is equivalent to a **$K$-Coloring of $G$**!
   - **Kempe's Heuristic (1879 / Chaitin 1981):**
     - If graph $G$ contains a node $u$ with $\mathbf{\text{degree}(u) < K}$, removing $u$ from $G$ produces a smaller graph $G'$. If $G'$ can be colored with $K$ colors, $u$ has at most $K - 1$ neighbors, leaving **at least 1 unused color available for $u$**!
   - **The 4 Chaitin-Briggs Phases:**
     1. **Build:** Run Liveness Analysis and construct Interference Graph.
     2. **Simplify:** Repeatedly remove nodes with degree $< K$ and push onto coloring stack.
     3. **Spill:** If all remaining nodes have degree $\ge K$, select a high-spill-cost candidate to spill to RAM stack frame.
     4. **Select:** Pop nodes from stack and assign valid physical register colors.
2. **Slide 2 (`ordering`):** Provide 5 steps of the Chaitin register allocation loop: (1) perform Live Variable Analysis on the CFG to compute live ranges of all symbolic variables, (2) construct the Interference Graph G by adding edges between any two variables that are simultaneously live, (3) repeatedly find a node v with degree < K, remove v from graph G, and push v onto the coloring stack (Simplify), (4) if all remaining nodes have degree >= K, select a variable with lowest spill-cost metric to spill into memory (Spill), (5) pop nodes from stack one by one and assign an available physical register color distinct from all colored neighbors (Select)!
3. **Slide 3 (`matching`):** Pair 4 register allocation concepts (Interference Graph Edge, Simplify Phase, Spill Phase, Kempe's Lemma degree < K) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that storing a variable in memory when physical registers are exhausted is called a spill. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the mathematical guarantee of Kempe's degree $< K$ simplification rule: Why is a node $v$ with $\text{degree}(v) < K$ in the interference graph guaranteed to receive a valid physical register color if the remaining subgraph is successfully $K$-colored? (Because node $v$ has at most $K - 1$ neighbors in the original graph; even if every single one of its neighbors is assigned a completely different color, they can consume at most $K - 1$ of the available $K$ hardware register colors, **guaranteeing that at least one distinct color remains free to be assigned to $v$**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "graph_coloring_register_allocation_and_kempes_heuristic",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Graph Coloring Register Allocation (Chaitin 1981)**\n• **The Interference Graph $G = (V, E)$:**\n$$\n\\mathbf{(u, v) \\in E \\iff u \\text{ and } v \\text{ are simultaneously LIVE at some program point!}}\n$$\n• **Kempe's Simplification Lemma (1879 / 1981):**\n$$\n\\mathbf{\\text{degree}(v) < K \\implies \\text{Node } v \\text{ is guaranteed colorable if remaining graph is } K\\text{-colored!}}\n$$\n• **The 4 Chaitin-Briggs Phases (Dragon Book Section 8.8):**\n  1. **Build:** Compute Liveness and construct Interference Graph $G$.\n  2. **Simplify:** Remove nodes with degree $< K$, pushing them to coloring stack.\n  3. **Spill:** If no nodes have degree $< K$, select lowest cost variable to spill to RAM.\n  4. **Select:** Pop nodes from stack and assign valid hardware register colors!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of Chaitin's Graph Coloring Register Allocation algorithm.",
      "orderItems": [
        "Execute Live Variable Analysis across the Control Flow Graph to compute variable live ranges",
        "Construct the Interference Graph G by adding an edge between any two variables simultaneously live",
        "Repeatedly select a node v with degree < K, remove v from graph G, and push v onto the coloring stack",
        "If all remaining nodes have degree >= K, select a variable with minimal spill cost to spill into memory",
        "Pop nodes from the stack in reverse order, assigning each node an available physical register color"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Register Allocation concept to its exact functional role.",
      "matchPairs": [
        { "left": "Interference Edge (u, v)", "right": "Indicates variables u and v overlap in live range and cannot share the same physical register" },
        { "left": "Simplify Phase", "right": "Safely removes nodes with degree < K and pushes them onto stack for deferred color assignment" },
        { "left": "Spill Phase", "right": "Allocates stack frame memory for a variable when physical hardware registers are exhausted" },
        { "left": "Select Phase", "right": "Pops nodes from stack and greedily assigns non-conflicting physical register colors" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "When all physical registers are exhausted, an uncolorable variable must be allocated to memory in an operation called a ___.",
      "blankAnswer": "spill",
      "blankDistractors": ["hoist", "branch", "clone"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the mathematical guarantee behind Kempe's simplification heuristic (removing a node with degree < K from the interference graph)?",
      "options": [
        { "text": "A node v with degree < K has at most K - 1 neighbors; even in the worst-case scenario where every neighbor is assigned a completely different color, those neighbors can consume at most K - 1 distinct colors, mathematically guaranteeing that at least one of the K available physical register colors will be free to assign to node v upon selection", "isCorrect": true, "explanation": "Correct! This is the foundational lemma of Kempe's graph coloring heuristic (Gregory Chaitin 1981; Dragon Book Section 8.8). In register allocation, we are given $K$ physical registers (colors). Suppose we remove a node $v$ whose degree in the interference graph is strictly less than $K$ ($\text{degree}(v) \le K - 1$). If the rest of the graph can be successfully colored using the $K$ colors: When we pop $v$ off the stack to assign its color in the Select phase, $v$ has at most $K - 1$ neighbors. In the worst possible case, every single one of $v$'s neighbors has already been assigned a mutually distinct color. This uses up at most $K - 1$ distinct register colors. Because there are $K$ total colors available, at least $K - (K - 1) = 1$ valid color is guaranteed to remain unused among $v$'s neighbors. Thus, $v$ will NEVER cause a coloring conflict and can always be safely colored. This allows the compiler to simplify the graph greedily without risking an unnecessary spill." },
        { "text": "Because nodes with degree < K are deleted from the final binary executable", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because hardware registers automatically double when degree is small", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because all graphs with degree < K have exactly 1 node", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
