# Duofy Reusable Lesson Format: Arc Consistency (AC-3 Algorithm and Constraint Propagation)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Classical_AI_and_Search_Algorithms / Constraint_Satisfaction_Problems`  
**Lesson Format Type:** `arc_consistency_ac3_algorithm_and_constraint_propagation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mathematical definitions, queue processing state machines, and asymptotic complexity bounds of Arc Consistency and the AC-3 constraint propagation algorithm (Alan Mackworth 1977, *Consistency in networks of relations*, Artificial Intelligence; Russell & Norvig *AIMA* Chapter 6.2.2): define **Arc Consistency for a directed arc $(X_i, X_j)$ ($\mathbf{\forall x \in D_i, \ \exists y \in D_j \text{ such that } (x, y) \text{ satisfies the binary constraint } C_{ij}}$)**, master the step-by-step mechanics of the **AC-3 Algorithm** (queue initialization with all directed arcs $2 \cdot |C|$, processing `Revise(Xi, Xj)` to prune unsupported domain values, and **re-inserting all incoming neighbor arcs $(X_k, X_i)$ into the queue whenever $D_i$ is reduced**), prove the **Worst-Case Time Complexity Bound $\mathbf{\mathcal{O}(c \cdot d^3)}$** (where $c$ is the number of binary constraints and $d$ is the maximum domain size), and analyze why an empty domain $D_i = \emptyset$ proves the CSP is unsatisfiable.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Arc Consistency Definition, AC-3 Queue Invariants, & Complexity Theorem Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Execution of the AC-3 Algorithm Processing Arc Deletions Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | AC-3 Component / Propagation Event & Algorithmic Consequence Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | If a Value x in Domain Di Has No Satisfying Partner y in Dj, x Is ___ from Di (Deleted / Pruned / Removed) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Derivation of the O(c * d^3) Worst-Case Time Complexity of AC-3 Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Arc Consistency & AC-3 (Mackworth 1977; Russell & Norvig *AIMA* 6.2.2):
   - **Arc Consistency Definition:**
     $$\mathbf{\text{Arc } (X_i, X_j) \text{ is consistent } \iff \mathbf{\forall x \in D_i, \ \exists y \in D_j \text{ such that } (x, y) \text{ satisfies } C_{ij}}}$$
     - If some $x \in D_i$ has NO valid partner $y \in D_j$, $x$ is deleted from $D_i$!
   - **The AC-3 Queue Invariant:**
     - Initialize $Q$ with all directed arcs in CSP (each binary constraint produces 2 directed arcs: $(X_i, X_j)$ and $(X_j, X_i)$).
     - If `Revise(Xi, Xj)` deletes any value from $D_i$:
       $$\mathbf{\text{Add all neighbor arcs } (X_k, X_i) \text{ for } X_k \in \text{Neighbors}(X_i) \setminus \{X_j\} \text{ back into } Q!}$$
   - **Complexity Theorem:** $\mathbf{\mathcal{O}(c \cdot d^3)}$ ($c = \text{constraints}$, $d = \text{max domain size}$).
2. **Slide 2 (`ordering`):** Provide 5 steps of running AC-3: (1) initialize queue Q with all 2*c directed arcs in the CSP, (2) pop directed arc (Xi, Xj) from the front of queue Q, (3) call Revise(Xi, Xj): check if every x in Di has a satisfying partner y in Dj, (4) delete unsupported values from Di; if Di becomes empty, return FAILURE (no solution exists), (5) if Di was modified, push all incoming neighbor arcs (Xk, Xi) back into queue Q to propagate ripple effects!
3. **Slide 3 (`matching`):** Pair 4 AC-3 concepts (Arc Consistency, Revise(Xi, Xj), Queue Re-insertion, Empty Domain) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that unsupported values are deleted/pruned. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the $\mathcal{O}(c \cdot d^3)$ complexity derivation: How is the worst-case time complexity $\mathcal{O}(c \cdot d^3)$ of the AC-3 arc consistency algorithm mathematically derived? (In a CSP with $c$ binary constraints, there are $2c$ directed arcs; **each arc $(X_k, X_i)$ can be re-inserted into the queue at most $d$ times because variable $X_i$ has a domain of maximum size $d$ and at least one value must be deleted from $D_i$ for a re-insertion to occur**; testing the consistency of an arc in `Revise(Xi, Xj)` takes at most $d \times d = d^2$ comparisons; multiplying $2c \times d \times d^2$ yields the total worst-case time bound of $\mathbf{\mathcal{O}(c \cdot d^3)}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "arc_consistency_ac3_algorithm_and_constraint_propagation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Arc Consistency \\& AC-3 (Mackworth 1977)**\n• **Arc Consistency Formal Invariant (Russell & Norvig *AIMA* 6.2.2):**\n$$\n\\mathbf{\\text{Arc } (X_i, X_j) \\text{ is Arc-Consistent} \\iff \\mathbf{\\forall x \\in D_i, \\ \\exists y \\in D_j \\text{ such that } (x, y) \\text{ satisfies } C_{ij}}}\n$$\n• **The Pruning Rule:** If any $x \\in D_i$ lacks a legal partner $y \\in D_j$, prune $x$ from $D_i$ ($D_i \\leftarrow D_i \\setminus \\{x\\}$)!\n• **The AC-3 Queue Propagation Invariant:**\n$$\n\\mathbf{\\text{If } D_i \\text{ is reduced } \\implies \\mathbf{\\text{Re-insert all incoming arcs } (X_k, X_i) \\text{ for all neighbors } X_k \\ne X_j \\text{ into } Q!}}\n$$\n• **Worst-Case Complexity Bound:** $\\mathbf{\\mathcal{O}(c \\cdot d^3)}$ where $c = \\text{Binary Constraints}$, $d = \\text{Max Domain Size}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed during an iteration of the AC-3 constraint propagation algorithm.",
      "orderItems": [
        "Initialize the FIFO queue Q with all directed arcs (Xi, Xj) and (Xj, Xi) corresponding to every binary constraint in the CSP",
        "Pop the next directed arc (Xi, Xj) from the front of queue Q to evaluate consistency",
        "Execute Revise(Xi, Xj): Scan each value x in Di to confirm whether at least one satisfying value y in Dj exists",
        "Delete all unsupported values x from Di; if Di becomes an empty set, terminate immediately and return FAILURE",
        "If any value was deleted from Di, push all incoming neighbor arcs (Xk, Xi) back into queue Q to propagate domain reductions"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each AC-3 Constraint Propagation Construct to its exact Algorithmic Role.",
      "matchPairs": [
        { "left": "Arc Consistency (Xi, Xj)", "right": "Property ensuring every remaining candidate in Di has at least one valid supporting choice in Dj" },
        { "left": "Revise(Xi, Xj) Routine", "right": "Subroutine that prunes values from Di that lack valid constraint-satisfying partners in Dj" },
        { "left": "Neighbor Queue Re-insertion", "right": "Re-checks incoming arcs (Xk, Xi) because reducing Di might invalidate previously supported values in Dk" },
        { "left": "Empty Domain (Di = empty)", "right": "Immediate proof of unsolvability indicating that no consistent assignment can satisfy all constraints" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "If a value x in domain Di has no satisfying counterpart y in Dj, the value x is ___ from Di.",
      "blankAnswer": "deleted",
      "blankDistractors": ["duplicated", "expanded", "negated"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How is the worst-case computational time complexity of O(c * d^3) for the AC-3 arc consistency algorithm mathematically derived?",
      "options": [
        { "text": "In a CSP with c binary constraints, there are 2c directed arcs in the network; each arc (Xk, Xi) can be re-inserted into the queue Q at most d times because variable Xi has a domain of maximum size d and at least one value must be removed from Di for a re-insertion to occur; executing Revise(Xi, Xj) takes at most d * d = d^2 value consistency checks; multiplying 2c arcs * d domain reductions * d^2 comparisons yields the total worst-case time complexity of O(c * d^3)", "isCorrect": true, "explanation": "Correct! This is the classical asymptotic complexity proof for Mackworth's AC-3 algorithm (Alan Mackworth 1977; Russell & Norvig *AIMA* Section 6.2.2). 1. **Counting Queue Insertions:** - The CSP has $c$ binary constraint edges $\\implies 2c$ directed arcs. - An arc $(X_k, X_i)$ is added back to queue $Q$ ONLY when domain $D_i$ loses at least one value. - Since $D_i$ has at most $d$ values, at most $d$ values can ever be deleted from $D_i$. - Thus, the arc $(X_k, X_i)$ can enter queue $Q$ at most $d$ times in total. - Total queue pops across the entire algorithm: at most $2c \\times d = 2cd$. 2. **Cost per Arc Revision (`Revise`):** - For a popped arc $(X_i, X_j)$, we loop through each value $x \\in D_i$ (at most $d$ values). - For each $x$, we check if there exists $y \\in D_j$ (at most $d$ values) satisfying $C_{ij}$. - Worst-case cost of one `Revise` call: $d \\times d = d^2$ checks. 3. **Total Asymptotic Bound:** - $\\text{Total Time} = (2cd\\text{ calls}) \\times (d^2\\text{ per call}) = \\mathbf{\\mathcal{O}(c \\cdot d^3)}$. - (Note: AC-4 by Mohr & Henderson 1986 optimizes this further to $\\mathcal{O}(cd^2)$ using support counters!)." },
        { "text": "Because AC-3 runs in cubic time on 3D computer graphics", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because each constraint graph has exactly 3 variables", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because domain reductions are performed using 3 nested while loops", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
