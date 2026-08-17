# Duofy Reusable Lesson Format: A* Search (f-Cost Evaluation and Frontier Expansion)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Classical_AI_and_Search_Algorithms / Uninformed_and_Informed_Search_A_Star`  
**Lesson Format Type:** `a_star_search_f_cost_evaluation_and_frontier_expansion`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the priority queue ordering, cost decomposition, and goal-termination invariants of the A* search algorithm (Peter Hart, Nils Nilsson, Bertram Raphael 1968, IEEE Transactions on Systems Science and Cybernetics; Russell & Norvig *AIMA* Chapter 3.5): master the **A* Evaluation Function ($\mathbf{f(n) = g(n) + h(n)}$ where $g(n)$ is the exact known cost from initial state to $n$, and $h(n)$ is the estimated heuristic cost from $n$ to goal)**, trace the **Priority Queue Frontier Management** (expanding nodes in ascending order of lowest $f(n)$), contrast **Tree-Search A* (requires Admissibility)** with **Graph-Search A* (requires Consistency / Monotonicity)**, master the **Goal Test Invariant** (**A* must NEVER terminate when a goal is generated/added to the frontier; it MUST terminate ONLY when a goal node is selected for EXPANSION from the top of the priority queue**), and trace A* path expansions on weighted graphs.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | A* Evaluation Cost Formula f(n) = g(n) + h(n), Frontier Invariants Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Priority Queue Expansion of Nodes in A* Search Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | A* Cost Component / Operation & Mathematical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Component of the A* Evaluation Function Representing the Exact Known Cost from Start to Node n is ___ (g(n)) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why A* Must Apply the Goal Test When Popping/Expanding a Node Rather Than Generating It Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State A* Search (Hart, Nilsson, Raphael 1968; Russell & Norvig 3.5):
   - **The A* Evaluation Cost Function:**
     $$\mathbf{f(n) = g(n) \ + \ h(n)}$$
     - $g(n)$: Exact path cost accumulated from initial state $S_0$ to node $n$.
     - $h(n)$: Estimated heuristic cost from node $n$ to the nearest goal state ($h(\text{Goal}) = 0$).
     - $f(n)$: Estimated total cost of the cheapest solution path through node $n$.
   - **Frontier Operation:** Priority Queue ordered by minimum $f(n)$.
   - **The Cardinal Rule of Goal Testing:**
     $$\mathbf{\text{Goal test MUST execute when node is DEQUEUED / EXPANDED, NEVER when generated!}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of A* search expanding start node S to Goal G: (1) insert initial root node S into priority queue with g(S)=0, f(S)=0+h(S), (2) pop node with minimum f(n) from priority queue; check goal test (fails), (3) generate valid successor child nodes, calculate g(child) = g(parent) + step_cost and f(child) = g(child) + h(child), (4) insert child nodes into priority queue frontier (or update if cheaper g found), (5) repeatedly pop lowest f(n) node; when Goal node is popped from top of queue, return optimal solution path!
3. **Slide 3 (`matching`):** Pair 4 A* constructs ($g(n)$ cost, $h(n)$ heuristic, $f(n)$ total estimate, Min-Priority Queue) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that g(n) is the path cost from start. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why goal test is applied on expansion: Why must the A* search algorithm apply the Goal Test only when a goal node is SELECTED FOR EXPANSION (popped from the priority queue) rather than when the goal node is first GENERATED (pushed to the queue)? (When a goal node $G$ is first generated as a child of some node $A$, **there may still exist other nodes in the priority queue whose paths lead to a strictly cheaper optimal path to $G$ via a different route**; if A* terminated upon generating $G$, it would return a sub-optimal solution; **applying the goal test on expansion guarantees that all other candidate paths with smaller $f(n)$ have already been explored and ruled out**, proving the path to $G$ is truly optimal).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "a_star_search_f_cost_evaluation_and_frontier_expansion",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: A* Search Algorithm (Hart, Nilsson, Raphael 1968)**\n• **The Three-Part Evaluation Cost Function (Russell & Norvig *AIMA* 3.5):**\n$$\n\\mathbf{f(n) = \\mathbf{g(n)} \\ + \\ \\mathbf{h(n)}}\n$$\n$$\n\\begin{array}{|c|l|l|}\n\\hline\n\\textbf{Component} & \\textbf{Mathematical Meaning} & \\textbf{Domain Scope} \\\\\n\\hline\n\\mathbf{g(n)} & \\text{Exact cumulative path cost from start state to node } n & \\text{Past (Known)} \\\\\n\\mathbf{h(n)} & \\text{Estimated heuristic cost from node } n \\text{ to nearest goal} & \\text{Future (Estimated)} \\\\\n\\mathbf{f(n)} & \\mathbf{\\text{Estimated total cost of cheapest path traversing } n} & \\mathbf{\\text{Total Estimate}} \\\\\n\\hline\n\\end{array}\n$$\n• **Frontier Discipline:** Min-Priority Queue ordered by lowest $f(n)$ value.\n• **Cardinal Invariant:** **NEVER goal-test upon generating a node!** Goal test is executed **ONLY when a node is DEQUEUED for expansion**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed during an iteration of the A* search algorithm.",
      "orderItems": [
        "Extract (pop) the node n with the lowest evaluation cost f(n) = g(n) + h(n) from the Priority Queue frontier",
        "Perform Goal Test on node n; if n is a goal state, terminate and return the optimal reconstructed path",
        "Generate all valid successor child nodes n' reachable by applying legal actions from node n",
        "For each child n', compute path cost g(n') = g(n) + c(n, a, n') and evaluation cost f(n') = g(n') + h(n')",
        "Insert child nodes into the Priority Queue frontier (or update existing entry if a cheaper path cost g(n') was discovered)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each A* Search Component to its exact Mathematical Function.",
      "matchPairs": [
        { "left": "Path Cost g(n)", "right": "The exact sum of edge step costs traversed from the initial start state to node n" },
        { "left": "Heuristic Estimate h(n)", "right": "Domain-specific estimate of the remaining cost from node n to the closest goal state" },
        { "left": "Evaluation Cost f(n)", "right": "Estimated total cost of the complete solution path passing through node n (f = g + h)" },
        { "left": "Min-Priority Queue", "right": "Frontier data structure that always serves the candidate node with the smallest f(n) value first" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the A* evaluation formula f(n) = g(n) + h(n), the exact path cost from the start state to node n is ___.",
      "blankAnswer": "g(n)",
      "blankDistractors": ["h(n)", "f(n)", "c(n)"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why must the A* search algorithm apply the Goal Test only when a goal node is selected for EXPANSION (dequeued from the priority queue) rather than when the goal node is first GENERATED (pushed to the queue)?",
      "options": [
        { "text": "When a goal node G is first generated as a child of some node, there may still exist other nodes in the priority queue frontier with lower total path costs that lead to a strictly cheaper, optimal path to G; if A* terminated upon generating G, it would return a sub-optimal path; delaying the goal test until G is popped from the top of the priority queue guarantees that all other candidate paths with smaller f(n) values have already been explored and exhausted, proving the path to G is truly optimal", "isCorrect": true, "explanation": "Correct! This is one of the most critical algorithmic invariants in A* and Uniform-Cost Search (Russell & Norvig *AIMA* Section 3.5.2). 1. **The Trap of Early Goal Testing:** - Suppose Start $S$ has two paths to Goal $G$: - Path 1: $S \\to A \\to G$ with total cost $1 + 10 = 11$. - Path 2: $S \\to B \\to C \\to G$ with total cost $2 + 2 + 2 = 6$ (Optimal). - Step 1: Expand $S$. Children are $A$ ($g=1$) and $B$ ($g=2$). - Step 2: Expand $A$. Child generated is $G$ with cost $g(G) = 11$. 2. **What Happens if Goal-Tested on Generation:** - If A* tested on generation, it would see $G$, yell 'Goal Found!', and return Path 1 (Cost 11). This is **sub-optimal**! 3. **The Correct Expansion Behavior:** - A* pushes $G$ ($f=11$) into the priority queue. - The queue now contains: $B$ ($f=2$) and $G$ ($f=11$). - Because $2 < 11$, A* pops $B$ NEXT! - $B$ generates $C$ ($f=4$). Next A* pops $C$. $C$ generates $G$ ($f=6$). - Now $G$ ($f=6$) is at the top of the queue. - A* pops $G$ ($f=6$), performs the goal test, and returns the true optimal cost of 6!" },
        { "text": "Because generating a goal node automatically clears all CPU registers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because priority queues cannot store goal nodes", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because heuristic h(Goal) is always equal to infinity", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
