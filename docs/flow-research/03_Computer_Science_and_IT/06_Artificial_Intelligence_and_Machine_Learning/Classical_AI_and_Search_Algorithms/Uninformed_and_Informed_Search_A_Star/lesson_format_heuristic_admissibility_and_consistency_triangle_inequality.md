# Duofy Reusable Lesson Format: Heuristic Admissibility and Consistency (Triangle Inequality)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Classical_AI_and_Search_Algorithms / Uninformed_and_Informed_Search_A_Star`  
**Lesson Format Type:** `heuristic_admissibility_and_consistency_triangle_inequality`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mathematical definitions, geometric triangle inequality proofs, and optimality guarantees of admissible and consistent heuristics in A* search (Hart, Nilsson, Raphael 1968; Russell & Norvig *AIMA* Chapter 3.5.2; Judea Pearl *Heuristics*): master **Admissibility ($\mathbf{h(n) \le h^*(n) \ \forall n}$ where $h^*(n)$ is true optimal cost to goal)**, prove why admissibility guarantees **Optimality in Tree-Search A***, master **Consistency / Monotonicity ($\mathbf{h(n) \le c(n, a, n') + h(n')}$)**, prove that consistency guarantees **monotonic non-decreasing $f(n)$ values ($f(n') \ge f(n)$) and Optimality in Graph-Search A*** (ensuring that when a node is expanded, the path found to it is already provably optimal, so closed nodes NEVER need to be reopened), and prove that **every consistent heuristic is admissible ($h(n) \le h^*(n)$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Admissibility & Consistency Mathematical Theorems, Triangle Inequality Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Mathematical Proof That Consistency Implies Monotonic f-Costs Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Heuristic Property / Mathematical Inequality & Theoretical Guarantee Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Mathematical Condition h(n) <= c(n,a,n') + h(n') Is Heuristic ___ (Consistency / Monotonicity) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why Inconsistent Heuristics Cause Graph-Search A* to Fail Without Reopening Closed Nodes Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Admissibility & Consistency (Russell & Norvig *AIMA* 3.5.2):
   - **Admissibility Definition (Tree Search Optimality):**
     $$\mathbf{h(n) \le h^*(n) \qquad \forall n \quad (h(\text{Goal}) = 0)}$$
     - An admissible heuristic is optimistic; it never overestimates the true remaining cost $h^*(n)$.
   - **Consistency / Monotonicity Definition (Graph Search Optimality):**
     $$\mathbf{h(n) \le c(n, a, n') \ + \ h(n') \qquad \forall n, n' \quad (\text{Triangle Inequality})}$$
   - **Monotonicity Theorem:**
     $$f(n') = g(n') + h(n') = g(n) + c(n, a, n') + h(n') \ge g(n) + h(n) = \mathbf{f(n)}$$
     $$\implies \mathbf{f(n') \ge f(n) \quad (f\text{-costs along any path are monotonically non-decreasing!})}$$
   - **Theorem:** $\mathbf{\text{Consistency} \implies \text{Admissibility}}$ (The converse is not always true!).
2. **Slide 2 (`ordering`):** Provide 5 steps of proving consistency yields optimal graph search: (1) let h(n) be a consistent heuristic satisfying h(n) <= c(n, a, n') + h(n'), (2) substitute g(n') = g(n) + c(n, a, n') into evaluation function f(n') = g(n') + h(n'), (3) rewrite f(n') = g(n) + c(n, a, n') + h(n') >= g(n) + h(n) = f(n), establishing monotonic f-costs, (4) A* expands nodes in strictly non-decreasing order of f(n), creating expanding f-cost contour lines, (5) whenever A* selects a node n for expansion, the shortest path to n has already been found; no closed node ever needs to be reopened!
3. **Slide 3 (`matching`):** Pair 4 heuristic concepts (Admissibility, Consistency, Monotonicity, Triangle Inequality) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that h(n) <= c + h(n') is consistency. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on inconsistent heuristics in graph search: If an admissible heuristic $h(n)$ is NOT consistent, why can standard Graph-Search A* (which permanently discards nodes once added to the Closed Set) fail to return the optimal path? (Because with an inconsistent heuristic, $f(n)$ values can decrease along a path; A* may expand a node $n$ via an expensive sub-optimal path first, placing $n$ into the Closed Set; **when a strictly cheaper path to $n$ is discovered later, standard Graph-Search A* will discard the cheaper path because $n$ is already marked closed**, causing A* to return a sub-optimal solution unless expensive node reopening is implemented).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "heuristic_admissibility_and_consistency_triangle_inequality",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Heuristic Properties in A* (Russell \\& Norvig *AIMA* 3.5.2)**\n• **Admissibility (Guarantees Optimality in Tree-Search):**\n$$\n\\mathbf{h(n) \\le h^*(n) \\qquad \\forall n \\quad (\\text{Never overestimates true remaining cost } h^*(n))}\n$$\n• **Consistency / Monotonicity (Guarantees Optimality in Graph-Search):**\n$$\n\\mathbf{h(n) \\le c(n, a, n') \\ + \\ h(n') \\qquad (\\text{The Triangle Inequality})}\n$$\n• **The Monotonic \\(f\\)-Cost Proof:**\n$$\n\\mathbf{f(n') = g(n') + h(n') = g(n) + c(n,a,n') + h(n') \\ge g(n) + h(n) = f(n) \\implies \\mathbf{f(n') \\ge f(n)}}\n$$\n• **Golden Theorem:** **Every consistent heuristic is admissible** (Consistency $\\implies$ Admissibility)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the mathematical proof showing that Consistency guarantees that A* never needs to reopen closed nodes.",
      "orderItems": [
        "Assume heuristic h satisfies the consistency triangle inequality: h(n) <= c(n, a, n') + h(n') for all successor nodes n'",
        "Substitute path cost recurrence g(n') = g(n) + c(n, a, n') into evaluation function f(n') = g(n') + h(n')",
        "Derive algebraic inequality: f(n') = g(n) + c(n, a, n') + h(n') >= g(n) + h(n) = f(n), proving f-costs are non-decreasing along paths",
        "Conclude that A* expands nodes in concentric, monotonically expanding f-cost contour boundaries across the state space",
        "Deduce that the first time any node n is selected from the priority queue for expansion, the optimal path to n has already been found"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Heuristic Mathematical Property to its exact Theoretical Guarantee.",
      "matchPairs": [
        { "left": "Admissibility [h(n) <= h*(n)]", "right": "Optimistic heuristic guaranteeing A* tree-search finds the lowest-cost optimal goal path" },
        { "left": "Consistency [h(n) <= c + h(n')]", "right": "Triangle inequality formulation guaranteeing A* graph-search optimality without reopening closed nodes" },
        { "left": "Monotonicity Invariant", "right": "Mathematical property ensuring f(n) evaluation costs never decrease along any explored search path" },
        { "left": "Straight-Line Distance Heuristic", "right": "Canonical consistent Euclidean distance heuristic for geographic road network pathfinding" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The mathematical condition h(n) <= c(n, a, n') + h(n') ensuring graph-search optimality is heuristic ___.",
      "blankAnswer": "consistency",
      "blankDistractors": ["admissibility", "dominance", "relaxation"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "If a heuristic h(n) is admissible (never overestimates goal distance) but is NOT consistent, why can standard Graph-Search A* (which never re-expands nodes in the Closed Set) fail to return the optimal shortest path?",
      "options": [
        { "text": "Because with an inconsistent heuristic, f(n) values can decrease along a path, breaking monotonic contour expansion; A* may expand a node n via an initial expensive path with artificially low heuristic cost, permanently recording n in the Closed Set; when a strictly cheaper path to n is discovered later, standard Graph-Search A* will discard the cheaper path because n is already marked closed, causing A* to return a sub-optimal solution unless expensive node reopening is implemented", "isCorrect": true, "explanation": "Correct! This is one of the most celebrated subtleties in search theory (Russell & Norvig *AIMA* Section 3.5.2; Judea Pearl *Heuristics*). 1. **Tree Search vs Graph Search:** - In **Tree Search**, every branch is explored independently; an admissible heuristic alone guarantees optimality. - In **Graph Search**, to prevent infinite loops on cycles, we maintain an `explored` (Closed) set of visited states. 2. **Why Inconsistent Heuristics Break Graph Search:** - Suppose $h$ is admissible but violates $h(n) \\le c(n, n') + h(n')$. - Path 1 to node $X$ has $g=10, h=0 \\implies f=10$. - Path 2 to node $X$ has $g=2, h=10 \\implies f=12$. - Because $10 < 12$, A* pops $X$ via Path 1 first, expands it, and inserts $X$ into the **Closed Set**. - Later, A* reaches node $X$ via Path 2 (which has true cheaper cost $g=2$!). - But since $X$ is in the Closed Set, standard Graph-Search **ignores and drops Path 2**! - The search proceeds using the sub-optimal Path 1 ($g=10$), returning a sub-optimal goal path! 3. **The Consistency Guarantee:** A consistent heuristic mathematically guarantees that the first time $X$ is expanded, its $g$-cost is ALREADY optimal, so discarding closed nodes is always 100% safe." },
        { "text": "Because inconsistent heuristics cause memory leaks in C++", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because inconsistent heuristics only work on negative edge weights", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Graph-Search A* cannot use priority queues", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
