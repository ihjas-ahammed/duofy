# Duofy Reusable Lesson Format: Traveling Salesperson (Reduced Matrix Branch and Bound)

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Algorithm_Design_Techniques / Backtracking_and_Branch_and_Bound`  
**Lesson Format Type:** `traveling_salesperson_reduced_matrix_branch_and_bound`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the combinatorial matrix reductions, lower bounding functions, and state-space pruning of the NP-hard Traveling Salesperson Problem (TSP) using Branch and Bound (John D.C. Little, Katta G. Murty, Dura W. Sweeney, & Caroline Karel 1963; Thomas H. Cormen et al.): master the **Reduced Cost Matrix Method** (subtracting the minimum element from each row $\sum r_i$, then subtracting the minimum element from each non-zero column $\sum c_j$, where the sum of reductions $\mathcal{R} = \sum r_i + \sum c_j$ establishes a rigorous **Admissible Lower Bound $LB$** on the cost of any complete Hamiltonian tour), trace the branching step choosing an edge $(u, \to v)$ (setting row $u$, column $v$, and back-edge $(v, u)$ to $\infty$ to prevent sub-tours), compute the child node lower bound $\mathbf{LB(\text{child}) = LB(\text{parent}) + \text{Cost}(u, v) + \mathcal{R}_{\text{child}}}$, and execute Best-First LC-BB pruning against the global best tour found.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | TSP Matrix Reduction, Lower Bounding LB, & Sub-Tour Prevention Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Initial Cost Matrix Reduction to Root Lower Bound Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | TSP Branch and Bound Operation / Matrix State & Mathematical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Value Assigned to Infeasible Sub-Tour Return Edges in Reduced Matrix Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Reason Row and Column Reductions Establish a Valid Lower Bound Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State TSP Matrix Reduction Branch & Bound (Little et al. 1963):
   - **The TSP Objective:** Find a minimum-cost directed Hamiltonian cycle visiting all $N$ vertices exactly once and returning to the start: $\min \sum c_{ij}$.
   - **The Reduced Matrix Method for Root Lower Bound ($LB_0$):**
     1. **Row Reduction:** For every row $i$, find minimum element $r_i = \min_j \{C_{ij}\}$, subtract $r_i$ from all elements in row $i$.
     2. **Column Reduction:** For every column $j$, find minimum element $c_j = \min_i \{C_{ij}\}$, subtract $c_j$ from all elements in column $j$.
     3. **Root Lower Bound:** $\mathbf{LB_0 = \sum_{i=1}^N r_i + \sum_{j=1}^N c_j}$.
   - **Branching from Vertex $u$ to Vertex $v$:**
     - Transitioning along edge $(u, v)$:
       1. Record edge cost $\hat{C}_{uv}$ from parent reduced matrix.
       2. Set all elements in row $u$ and column $v$ to $\infty$ (cannot leave $u$ or enter $v$ again).
       3. Set back-edge $C_{vu} = \infty$ to prevent premature 2-vertex sub-tours!
       4. Re-reduce the matrix, yielding additional reduction sum $\mathcal{R}_{\text{child}}$.
     - **Child Node Lower Bound:** $\mathbf{LB(\text{child}) = LB(\text{parent}) + \hat{C}_{uv} + \mathcal{R}_{\text{child}}}$.
   - **Pruning Rule:** If $\mathbf{LB(\text{child}) \ge \text{best\_tour\_cost}}$, prune child node immediately!
2. **Slide 2 (`ordering`):** Provide 5 steps of computing the initial root lower bound for a TSP cost matrix: (1) initialize the N x N directed edge cost matrix with diagonal elements set to infinity, (2) find the minimum value in each row and subtract it from all entries across that row, recording the row reduction sum, (3) check all columns for remaining non-zero minimums, subtracting column minimums to ensure every column has at least one zero, (4) sum all row and column reduction constants to establish the global root Lower Bound LB0, (5) verify that every row and column now contains at least one zero-cost entry representing potential tour segments!
3. **Slide 3 (`matching`):** Pair 4 TSP Branch & Bound terms (Row Reduction Sum, Back-Edge Infinity Setting, Best-First Priority Queue, Lower Bound LB) with their algorithmic functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that to prevent premature sub-tours in TSP matrix reduction, the reverse edge entry is set to infinity. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the mathematical proof behind why subtracting constants from rows and columns preserves relative tour costs while establishing a lower bound: Why does subtracting a constant $r_i$ from row $i$ in a TSP cost matrix leave the optimal permutation unchanged while establishing a valid lower bound? (Because every valid TSP tour must contain **exactly one outgoing edge from every vertex $i$ and exactly one incoming edge to every vertex $j$**; subtracting $r_i$ from row $i$ **reduces the cost of every conceivable valid tour by exactly $r_i$**, preserving the relative cost ordering of all tours while proving that any valid tour must cost at least $\sum r_i + \sum c_j$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "traveling_salesperson_reduced_matrix_branch_and_bound",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: TSP Reduced Matrix Branch \\& Bound (Little 1963)**\n• **Root Lower Bound Calculation ($LB_0$):**\n$$\n\\mathbf{LB_0 = \\sum_{i=1}^N r_i + \\sum_{j=1}^N c_j \\qquad (r_i = \\min \\text{Row } i, \\ c_j = \\min \\text{Col } j)}\n$$\n  - Every valid tour visits every city once $\\implies$ **Every tour costs at least $LB_0$**!\n• **Branching on Edge $(u \\to v)$:**\n  1. Take edge cost $\\hat{C}_{uv}$ from parent reduced matrix.\n  2. Set **Row $u = \\infty$**, **Col $v = \\infty$**, and **Back-Edge $C_{vu} = \\infty$** (Prevents Sub-Tours!).\n  3. Re-reduce child matrix to get reduction sum $\\mathcal{R}_{\\text{child}}$.\n• **Child Lower Bound:**\n$$\n\\mathbf{LB(\\text{child}) = LB(\\text{parent}) + \\hat{C}_{uv} + \\mathcal{R}_{\\text{child}}}\n$$\n• **Pruning:** If $\\mathbf{LB(\\text{child}) \\ge \\text{best\\_tour}}$, kill node immediately!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of performing initial matrix reduction to find the root lower bound of a TSP cost matrix.",
      "orderItems": [
        "Construct the N x N directed cost matrix with all self-loop diagonal entries set to infinity",
        "Scan each row to find its minimum element r_i and subtract r_i from all entries across that row",
        "Scan each column of the row-reduced matrix to find remaining non-zero column minimums c_j",
        "Subtract each column minimum c_j across its column, ensuring every row and column has at least one zero",
        "Sum all subtracted row and column constants to establish the root Lower Bound LB0 for all possible tours"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each TSP Branch and Bound operation to its exact mathematical purpose.",
      "matchPairs": [
        { "left": "Row Reduction Sum (sum r_i)", "right": "Guaranteed minimum exit cost required to depart each vertex in the Hamiltonian cycle" },
        { "left": "Setting Back-Edge C_vu = inf", "right": "Prevents the formation of premature 2-vertex sub-cycles before visiting all N cities" },
        { "left": "Setting Row u & Col v = inf", "right": "Enforces the constraint that vertex u cannot be left again and vertex v cannot be re-entered" },
        { "left": "Admissible Lower Bound (LB)", "right": "Provable minimum possible total distance of any complete tour passing through the current state" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In TSP matrix reduction, to prevent the algorithm from selecting a premature 2-city sub-tour, the reverse edge entry C(v,u) is set to ___.",
      "blankAnswer": "infinity",
      "blankDistractors": ["zero", "one", "negative"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does subtracting a constant value (r_i) from an entire row of a TSP cost matrix guarantee that the optimal tour in the original matrix remains optimal in the reduced matrix?",
      "options": [
        { "text": "Every valid TSP Hamiltonian tour must contain exactly one outgoing edge from every single vertex i; therefore, subtracting r_i from row i reduces the total cost of EVERY conceivable valid tour by the exact same amount (r_i), perfectly preserving the relative cost differences and ranking of all possible tours", "isCorrect": true, "explanation": "Correct! A valid TSP tour is a single closed Hamiltonian cycle that visits each of the N vertices exactly once. This means that for any vertex i, any valid tour MUST select exactly one edge originating from vertex i (one entry from row i) and exactly one edge entering vertex i (one entry from column i). If you subtract a constant r_i from every entry in row i of the cost matrix, whichever outgoing edge (i, j) a tour chooses from row i will have its cost reduced by exactly r_i. Because this reduction applies equally to all valid tours, the total length of EVERY valid tour in the entire search space drops by the exact same constant: New_Cost(Tour) = Old_Cost(Tour) - sum(r_i) - sum(c_j). Since all tour lengths are reduced by the identical constant amount, the permutation that was cheapest in the original matrix remains the cheapest in the reduced matrix. Furthermore, because all entries in the reduced matrix are non-negative (>= 0), the sum of all remaining edges chosen from the reduced matrix must be >= 0, mathematically proving that the sum of the subtracted constants (sum r_i + sum c_j) represents an unassailable Lower Bound (LB) on the original tour cost." },
        { "text": "Because subtracting numbers from matrices changes all numbers into zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because TSP is not NP-hard and can be solved in linear time by subtraction", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because rows and columns have no mathematical connection to graph edges", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
