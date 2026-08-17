# Duofy Reusable Lesson Format: Branch and Bound 0/1 Knapsack (Fractional Relaxation)

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Algorithm_Design_Techniques / Backtracking_and_Branch_and_Bound`  
**Lesson Format Type:** `branch_and_bound_01_knapsack_fractional_relaxation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the state-space tree exploration, linear programming relaxation, and bounding function pruning of Branch and Bound optimization applied to the NP-hard 0/1 Knapsack problem (Thomas H. Cormen et al.; Jon Kleinberg & Éva Tardos): master **Best-First Search (LC-BB / Least-Cost / Priority Queue)** traversal of the binary decision tree (item $i$ included vs excluded), formulate the **Upper Bound ($UB$) Calculation via Fractional Knapsack Relaxation** (sorting items by descending value-to-weight ratio $v_j / w_j$, greedily packing whole items, and taking a fractional fraction of the break-item $\frac{W_{\text{rem}}}{w_k} v_k$), establish the rigorous **Pruning Criterion ($UB(\text{node}) \le \text{max\_profit\_found\_so\_far} \implies \text{Kill Node}$)**, and compare memory and node-expansion efficiency against Dynamic Programming.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | 0/1 Knapsack B&B, Fractional Upper Bound, & Priority Queue Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Priority Queue Node Expansion and Pruning Loop Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Branch and Bound Component / State & Mathematical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Continuous Relaxation Problem Used to Compute Upper Bound Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Reason a Fractional Knapsack Relaxation Yields an Upper Bound Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Branch and Bound for 0/1 Knapsack (CLRS; Kleinberg & Tardos):
   - **The 0/1 Knapsack Optimization Problem:** Maximize $\sum_{i=1}^n v_i x_i$ subject to $\sum_{i=1}^n w_i x_i \le W$, where $x_i \in \{0, 1\}$.
   - **The Fractional Upper Bounding Function ($UB$):**
     - Sort remaining items by value density: $\frac{v_1}{w_1} \ge \frac{v_2}{w_2} \ge \dots \ge \frac{v_n}{w_n}$.
     - At node $u$ with current profit $P$ and current weight $C \le W$:
       $$\mathbf{UB(u) = P + \sum_{j=\text{level}+1}^{k-1} v_j + \left(W - C_{\text{accum}}\right) \times \frac{v_k}{w_k} \quad (\text{where } k \text{ is the break item})}$$
     - Because fractional items are strictly allowed, $UB(u) \ge \text{Optimal Integer Profit in subtree of } u$.
   - **Best-First Priority Queue Execution:**
     - Insert root node into max-heap prioritized by $UB$.
     - Pop node with highest $UB$.
     - **Pruning Rule:** If $\mathbf{UB(\text{node}) \le \text{max\_profit}}$, kill/prune node and discard its subtree!
2. **Slide 2 (`ordering`):** Provide 5 steps of the Best-First Branch and Bound algorithm loop: (1) sort all items in decreasing order of value-to-weight ratio (v_i / w_i) and insert the root node into a max-priority queue ordered by Upper Bound, (2) pop the node with the highest optimistic Upper Bound from the priority queue, (3) generate the left child node (including item i); if weight exceeds capacity W, prune it; otherwise update max_profit and compute its UB, (4) generate the right child node (excluding item i) and compute its fractional Upper Bound, (5) prune any child node whose UB is less than or equal to current max_profit, inserting surviving nodes into the priority queue until empty!
3. **Slide 3 (`matching`):** Pair 4 Branch & Bound concepts (Upper Bound UB, Best-First Search LC-BB, Break Item, Pruning Condition) with their algorithmic roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the relaxed continuous version of the knapsack problem used to compute optimistic upper bounds is the fractional knapsack. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why Fractional Knapsack relaxation is mathematically guaranteed to provide an upper bound for 0/1 Knapsack: Why is the solution to the Fractional Knapsack problem always greater than or equal to the optimal integer solution of the 0/1 Knapsack problem for the exact same items and capacity? (Because allowing items to be divided into fractions expands the feasible solution space ($\{0, 1\}^n \subset [0, 1]^n$); **maximizing an objective function over a larger superset of feasible solutions mathematically guarantees a result $\ge$ the maximum over a restricted subset**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "branch_and_bound_01_knapsack_fractional_relaxation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Branch \\& Bound 0/1 Knapsack**\n• **The Optimization Goal:** $\\max \\sum v_i x_i \\text{ s.t. } \\sum w_i x_i \\le W \\ (x_i \\in \\{0,1\\})$.\n• **The Fractional Upper Bound ($UB$):**\n$$\n\\mathbf{UB(\\text{node}) = \\text{Current Profit } P + \\sum_{\\text{whole}} v_j + (W - C_{\\text{accum}}) \\times \\frac{v_k}{w_k} \\quad (\\text{Break Item } k)}\n$$\n  - Continuous relaxation ($x_i \\in [0,1]$) guarantees $\\mathbf{UB(\\text{node}) \\ge \\text{True Optimal Integer Profit}}$!\n• **Best-First Search (Max-Priority Queue):**\n  - Explore node with highest $UB$ first.\n  - **The Pruning Rule:**\n$$\n\\mathbf{UB(\\text{child}) \\le \\text{max\\_profit\\_found} \\implies \\text{KILL / PRUNE SUBTREE!}}\n$$\n• **Advantage:** Bypasses exponential $2^N$ subtrees without large DP memory grids!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of a Best-First Branch and Bound 0/1 Knapsack optimization solver.",
      "orderItems": [
        "Sort all items in descending order of value density (v_i / w_i) and push the empty root node to a max-priority queue",
        "Extract the unexpanded node with the highest optimistic Upper Bound (UB) from the priority queue",
        "Generate the left child (including current item); if valid, update global max_profit and calculate its relaxed UB",
        "Generate the right child (excluding current item) and calculate its fractional Upper Bound",
        "Prune any child node whose UB is less than or equal to max_profit, enqueuing surviving nodes until the queue is empty"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Branch and Bound optimization concept to its exact mathematical function.",
      "matchPairs": [
        { "left": "Upper Bound (UB)", "right": "Optimistic profit estimate computed via greedy fractional relaxation guaranteeing UB >= True Max" },
        { "left": "Best-First Search (LC-BB)", "right": "Priority queue exploration strategy always expanding the node with the highest upper bound" },
        { "left": "Break Item (k)", "right": "The first item in value-density order that cannot fit completely into the remaining knapsack capacity" },
        { "left": "Pruning Threshold", "right": "Discarding any search tree branch whose upper bound cannot beat the current best integer profit" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Branch and Bound 0/1 Knapsack solvers, the optimistic upper bound at any node is computed by relaxing the problem to a ___ knapsack.",
      "blankAnswer": "fractional",
      "blankDistractors": ["dynamic", "quantum", "quadratic"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the solution to the Fractional Knapsack relaxation mathematically guaranteed to serve as an admissible Upper Bound (UB) for the 0/1 Integer Knapsack problem?",
      "options": [
        { "text": "Relaxing the binary constraint (x_i in {0, 1}) to a continuous interval (x_i in [0, 1]) expands the feasible solution space into a superset ({0,1}^n is a subset of [0,1]^n); the maximum value of an objective function over a larger feasible set is mathematically guaranteed to be greater than or equal to the maximum over any restricted subset", "isCorrect": true, "explanation": "Correct! In optimization theory and linear programming, this is the foundational principle of 'Continuous Relaxation'. The 0/1 Knapsack problem restricts decision variables to discrete integers: x_i ∈ {0, 1}. The Fractional Knapsack problem relaxes this constraint, allowing any fractional value: 0 ≤ x_i ≤ 1. Because any valid 0/1 solution is ALSO a valid fractional solution (every integer choice of 0 or 1 is contained within the continuous range [0, 1]), the set of all possible 0/1 knapsack packings forms a strict subset of all possible fractional knapsack packings. When you maximize total profit over a larger, unconstrained superset of possibilities, the resulting optimal value can never be smaller than the maximum over the restricted subset: Max_fractional ≥ Max_integer. Because the greedy fractional algorithm (taking items by descending v_i / w_i and taking a fraction of the break item) solves the relaxed problem optimally in $O(n \\log n)$, its result provides a mathematically unassailable upper bound. If this relaxed upper bound is already worse than an integer solution you have already found elsewhere in the tree, you can safely kill the entire subtree knowing that no valid integer combination inside it could ever beat your best answer." },
        { "text": "Because fractions are always larger than whole numbers in mathematics", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because knapsacks can hold infinite weight when items are cut in half", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Branch and Bound algorithms change the values of items during runtime", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
