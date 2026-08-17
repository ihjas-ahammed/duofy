# Duofy Reusable Lesson Format: Backtracking Search (MRV, Degree, and LCV Heuristics)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Classical_AI_and_Search_Algorithms / Constraint_Satisfaction_Problems`  
**Lesson Format Type:** `backtracking_search_mrv_degree_and_lcv_heuristics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the depth-first backtracking search engine and the foundational variable/value ordering heuristics that accelerate CSP solving (Russell & Norvig *AIMA* Chapter 6.3): master the **Standard CSP Backtracking Recursive Search Algorithm** (one-variable-at-a-time depth-first assignment with immutability checkpoints and backtracking on conflict), contrast the **"Fail-First" Variable Ordering Heuristics** (**1. Minimum Remaining Values [MRV / Most Constrained Variable]**: chooses the variable with the fewest legal domain values remaining $|D_i|$ to prune dead ends at the top of the search tree; **2. Degree Heuristic**: acts as an MRV tie-breaker by selecting the variable with the most constraints on other unassigned variables), with the **"Fail-Last" Value Ordering Heuristic** (**Least Constraining Value [LCV]**: prefers the domain value that rules out the fewest choices for neighboring variables in the constraint graph, maximizing future assignment flexibility).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Backtracking Search Algorithm, MRV / Degree / LCV Heuristic Spectrum Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Execution of Backtracking with MRV and LCV on Map Coloring Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | CSP Heuristic / Ordering Rule & Strategic Purpose Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Heuristic That Selects the Variable with the Fewest Legal Values Remaining is ___ (MRV / Minimum Remaining Values) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why Variable Ordering Follows 'Fail-First' While Value Ordering Follows 'Fail-Last' Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Backtracking & Heuristics (Russell & Norvig *AIMA* 6.3):
   - **CSP Backtracking Recursive Structure:**
     - Depth-First Search choosing 1 variable per ply.
     - Prunes branch whenever a partial assignment violates any constraint.
   - **The 3 Cardinal Heuristics:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Heuristic} & \textbf{Selection Target} & \textbf{Decision Rule} & \textbf{Philosophy} \\
     \hline
     \mathbf{\text{MRV (Min Remaining Values)}} & \mathbf{\text{Variable Selection}} & \mathbf{\arg\min_{X_i} |D_i|} & \mathbf{\text{Fail-First (Prune early)}} \\
     \mathbf{\text{Degree Heuristic}} & \text{Variable Tie-Breaker} & \arg\max_{X_i} \text{Degree}(X_i) & \text{Constrain future options} \\
     \mathbf{\text{LCV (Least Constraining)}} & \mathbf{\text{Value Selection}} & \mathbf{\arg\min_{v} \text{Conflicts}(v)} & \mathbf{\text{Fail-Last (Keep options open)}} \\
     \hline
     \end{array}$$
   - **The Guiding Principle:**
     - **Variable:** Be aggressive, pick the most difficult/fragile variable first (**Fail-First**).
     - **Value:** Be optimistic, pick the value most likely to succeed (**Fail-Last**).
2. **Slide 2 (`ordering`):** Provide 5 steps of Backtracking with MRV and LCV: (1) start with empty assignment and unassigned variables, (2) apply MRV heuristic: inspect all unassigned variables and select variable X_target with smallest domain size |D_target|, (3) apply LCV heuristic: sort values in D_target by least impact on neighboring variable domains, (4) assign candidate value v to X_target; if consistent with current assignment, recurse to next variable, (5) if child returns failure, unassign X_target = null and backtrack to try next LCV candidate!
3. **Slide 3 (`matching`):** Pair 4 concepts (MRV Heuristic, Degree Heuristic, LCV Heuristic, Backtracking Search) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of MRV (Minimum Remaining Values). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the dual philosophy of variable vs value ordering: Why does optimal CSP search design dictate that VARIABLE SELECTION follow a 'Fail-First' philosophy (MRV), whereas VALUE SELECTION follow a 'Fail-Last' philosophy (LCV)? (In variable selection, **all $n$ variables must eventually be assigned a value to reach a complete solution**; therefore, choosing the most restricted variable first (**Fail-First**) discovers inevitable failures immediately near the root of the search tree, preventing millions of useless subtree expansions; in value selection, **we only need ONE valid value per variable to find a solution**; therefore, choosing the value that leaves maximum remaining freedom for neighboring variables (**Fail-Last**) maximizes the mathematical probability of finding a solution on the very first try without backtracking).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "backtracking_search_mrv_degree_and_lcv_heuristics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: CSP Backtracking \\& Heuristic Ordering (Russell & Norvig *AIMA* 6.3)**\n• **The Search Paradigm Matrix:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Heuristic} & \\textbf{Target} & \\textbf{Mathematical Selection} & \\textbf{Core Philosophy} \\\\\n\\hline\n\\mathbf{\\text{MRV (Most Constrained)}} & \\mathbf{\\text{Variable}} & \\mathbf{\\arg\\min_{X_i} |D_i|} & \\mathbf{\\text{Fail-First (Prune early)}} \\\\\n\\mathbf{\\text{Degree Heuristic}} & \\text{Variable} & \\arg\\max_{X_i} \\text{Degree}(X_i) & \\text{Tie-breaker on MRV} \\\\\n\\mathbf{\\text{LCV (Least Constraining)}} & \\mathbf{\\text{Value}} & \\mathbf{\\arg\\min_{v \\in D_i} \\text{NeighborImpact}(v)} & \\mathbf{\\text{Fail-Last (Maximize options)}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Dual Philosophy Rule:**\n  - **Variable Choice:** Pick the most difficult/constrained variable (**Fail-First** to detect dead ends immediately)!\n  - **Value Choice:** Pick the most accommodating value (**Fail-Last** to succeed on the 1st branch)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed during an iteration of Backtracking Search using MRV and LCV heuristics.",
      "orderItems": [
        "Select unassigned variable X with the fewest remaining legal domain values using the Minimum Remaining Values (MRV) heuristic",
        "If multiple variables tie in domain size, apply the Degree Heuristic as a tie-breaker to select the variable with the most unassigned neighbors",
        "Order the candidate values in Domain(X) using Least Constraining Value (LCV), ranking values that eliminate fewest neighbor choices first",
        "Assign the top-ranked LCV value to variable X and check consistency with existing partial assignments",
        "If a downstream recursive assignment leads to a constraint violation, undo the assignment (backtrack) and attempt the next LCV value"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each CSP Backtracking Heuristic to its exact Operational Purpose.",
      "matchPairs": [
        { "left": "Minimum Remaining Values (MRV)", "right": "Variable selection rule choosing the most restricted variable (smallest |D|) to fail as early as possible" },
        { "left": "Degree Heuristic", "right": "Variable tie-breaker choosing the variable connected to the largest number of unassigned constraint neighbors" },
        { "left": "Least Constraining Value (LCV)", "right": "Value selection rule choosing the candidate value that leaves the maximum number of choices for neighbors" },
        { "left": "Backtracking Algorithm", "right": "Depth-first search traversing single-variable assignments with recursive backtracking on failure" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The fail-first heuristic that selects the variable with the smallest remaining domain size is ___ (Minimum Remaining Values).",
      "blankAnswer": "MRV",
      "blankDistractors": ["LCV", "AC3", "DFS"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does optimal CSP search design dictate that VARIABLE SELECTION follow a 'Fail-First' philosophy (MRV), whereas VALUE SELECTION follow a 'Fail-Last' philosophy (LCV)?",
      "options": [
        { "text": "In a CSP, every single variable must eventually be assigned a value to construct a complete valid solution; therefore, choosing the most restricted variable first (Fail-First / MRV) forces inevitable contradictions to occur immediately near the top of the search tree, pruning massive exponential dead ends before wasted effort occurs; in contrast, to find a solution we only need ONE legal value per variable, so selecting the value that rules out the fewest choices for neighboring variables (Fail-Last / LCV) maximizes the mathematical probability of finding a solution on the very first branch without backtracking", "isCorrect": true, "explanation": "Correct! This is one of the most fundamental pedagogical insights in classical artificial intelligence (Russell & Norvig *AIMA* Section 6.3.1). 1. **The Logic of Fail-First for Variables (MRV):** - Suppose variable $X_1$ has only 1 legal value left, and variable $X_2$ has 10 values. - If you assign $X_2$ first, you might explore 10 big branches. But on every single branch, you eventually have to assign $X_1$! - If $X_1$'s single value causes a contradiction, you just wasted 10 massive subtrees! - By picking $X_1$ FIRST, you either solve it immediately or prune the entire branch instantly. 2. **The Logic of Fail-Last for Values (LCV):** - When picking a value for $X_1$, you don't need all values to work; you only need **ONE** value to succeed. - If you pick a value that aggressively deletes all options for neighboring variables $X_2, X_3$, you almost guarantee a future dead end. - By picking the value that is **Least Constraining** (leaves $X_2$ and $X_3$ with maximum choices), you maximize the chance that your very first greedy path goes straight to a complete solution without ever having to backtrack!" },
        { "text": "Because MRV was designed for sorting algorithms and LCV for databases", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because values are always stored in stacks while variables are in queues", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Fail-First only works on binary numbers", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
