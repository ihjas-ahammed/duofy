# Duofy Reusable Lesson Format: CSP Formulation and Constraint Graphs

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Classical_AI_and_Search_Algorithms / Constraint_Satisfaction_Problems`  
**Lesson Format Type:** `constraint_satisfaction_problem_formulation_and_constraint_graphs`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the formal mathematical definitions, factored state representations, and relational topology graphs of Constraint Satisfaction Problems (CSPs) (Russell & Norvig *AIMA* Chapter 6.1–6.2): master the **Formal CSP Tuple Formulation $\mathbf{\langle X, D, C \rangle}$** (**Variables $X = \{X_1, \dots, X_n\}$, Domains $D = \{D_1, \dots, D_n\}$, and Constraints $C = \{C_1, \dots, C_m\}$**), distinguish **Unary Constraints (restricting a single variable $X_1 \ne \text{Green}$)**, **Binary Constraints (restricting variable pairs $X_1 \ne X_2$)**, and **Global / Higher-Order Constraints (e.g. $\text{Alldiff}(X_1, \dots, X_9)$ in Sudoku / Cryptarithmetic puzzles)**, master the translation of real-world problems (Map Coloring of Australia, $N$-Queens, Cryptarithmetic $\text{TWO} + \text{TWO} = \text{FOUR}$) into formal CSP graphs (where **nodes represent variables and undirected/hyper-edges represent constraints**), and contrast CSP factored state spaces with unstructured atomic search states.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Formal CSP Formulation $\langle X, D, C \rangle$, Constraint Typology, & Graph Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Translation of the Australia Map Coloring Problem into a CSP Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Constraint Classification / CSP Component & Mathematical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Global Constraint Specifying That All Listed Variables Must Take Distinct Non-Overlapping Values (Alldiff) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why CSP Factored State Representations Enable Domain Pruning Compared to Atomic Search States Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State CSP Formulation (Russell & Norvig *AIMA* 6.1–6.2):
   - **The CSP Mathematical Definition Tuple:**
     $$\mathbf{\text{CSP} = \mathbf{\langle X, D, C \rangle}}$$
     - **Variables:** $X = \{X_1, X_2, \dots, X_n\}$.
     - **Domains:** $D = \{D_1, D_2, \dots, D_n\}$ where each variable $X_i \in D_i$.
     - **Constraints:** $C = \{C_1, C_2, \dots, C_m\}$ specifying allowable value tuples $\langle \text{scope}, \text{relation} \rangle$.
   - **Constraint Taxonomy:**
     - **Unary:** Restricts 1 variable ($X_i \ne \text{Red}$).
     - **Binary:** Relates 2 variables ($X_i \ne X_j$). Represented as edges in a **Constraint Graph**!
     - **Global (Higher-Order):** Involves arbitrary variables (e.g. $\text{Alldiff}(X_1, \dots, X_k)$).
   - **Assignment Types:** Complete vs Partial; Consistent (Legal) vs Inconsistent.
2. **Slide 2 (`ordering`):** Provide 5 steps of formulating the Australia Map Coloring problem as a CSP: (1) define variables X = {WA, NT, SA, Q, NSW, V, T} representing the 7 Australian states/territories, (2) define discrete domains D_i = {Red, Green, Blue} for every variable, (3) define binary constraints specifying that adjacent bordering territories cannot share the same color (e.g. WA != NT, WA != SA), (4) construct constraint graph placing variables as nodes and bordering adjacency as undirected edges, (5) assign consistent color values satisfying all boundary edge constraints across the network!
3. **Slide 3 (`matching`):** Pair 4 CSP concepts (Variables X, Domains D, Binary Constraint, Constraint Graph) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of the Alldiff global constraint. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why factored state representations empower CSP solvers: Why does representing a problem as a factored Constraint Satisfaction Problem (CSP) allow artificial intelligence solvers to prune exponential search spaces significantly faster than classical atomic state search algorithms (such as BFS or DFS)? (In classical atomic search, states are "black boxes" with no internal visibility, meaning the algorithm cannot evaluate partial progress until a complete path is tested; **in a factored CSP representation, states are decomposed into explicit variable-value assignments, allowing domain-independent inference algorithms (like AC-3 and Forward Checking) to identify constraint violations immediately in partial assignments and prune entire exponential subtrees** before attempting illegal choices).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "constraint_satisfaction_problem_formulation_and_constraint_graphs",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Constraint Satisfaction Problem Formulation (Russell \\& Norvig *AIMA* 6.1)**\n• **The Formal CSP Mathematical Tuple:**\n$$\n\\mathbf{\\text{CSP} = \\mathbf{\\langle X, D, C \\rangle}}\n$$\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Component} & \\textbf{Mathematical Set} & \\textbf{Description} \\\\\n\\hline\n\\mathbf{\\text{Variables } X} & X = \\{X_1, X_2, \\dots, X_n\\} & \\text{Set of decision variables requiring assignment} \\\\\n\\mathbf{\\text{Domains } D} & D = \\{D_1, D_2, \\dots, D_n\\} & \\text{Sets of permissible discrete/continuous values for each } X_i \\\\\n\\mathbf{\\text{Constraints } C} & C = \\{C_1, C_2, \\dots, C_m\\} & \\text{Allowable variable value tuples } \\langle \\text{scope}, \\text{rel} \\rangle \\\\\n\\hline\n\\end{array}\n$$\n• **Constraint Graph Representation:** Nodes represent variables $X_i$; edges represent binary relational constraints $C_{ij}$!\n• **Global Constraints:** $\\mathbf{\\text{Alldiff}(X_1, X_2, \\dots, X_k)}$ dictates that all $k$ variables must take pairwise distinct values (e.g. Sudoku rows)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed to formulate and solve the classic Map Coloring Problem as a formal CSP.",
      "orderItems": [
        "Identify the geographic regions to be colored and define them as the variable set: X = {WA, NT, SA, Q, NSW, V, T}",
        "Specify the finite discrete color domain available for each region: D_i = {Red, Green, Blue} for all i in X",
        "Define the set of binary inequality constraints between adjacent neighboring territories: C = {WA != NT, WA != SA, NT != SA, ...}",
        "Construct the formal Constraint Graph by mapping each variable to a node and connecting bordering pairs with constraint edges",
        "Execute backtracking search with constraint propagation to find a complete, consistent assignment of colors to all nodes"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each CSP Component / Constraint Classification to its exact Definition.",
      "matchPairs": [
        { "left": "Variable Set (X)", "right": "The formal set of entities in the problem that must be assigned values" },
        { "left": "Domain Set (D)", "right": "The collection of permissible candidate values that can be assigned to a specific variable" },
        { "left": "Binary Constraint", "right": "A relational restriction relating pairs of variables represented as an edge in a constraint graph" },
        { "left": "Global Alldiff Constraint", "right": "Higher-order constraint specifying that all variables in its scope must take unique, distinct values" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The global constraint specifying that all variables in a set must take distinct non-overlapping values is ___.",
      "blankAnswer": "Alldiff",
      "blankDistractors": ["Binary", "Unary", "Linear"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does modeling a problem as a factored Constraint Satisfaction Problem (CSP) allow artificial intelligence solvers to prune combinatorial search spaces significantly faster than classical atomic state search algorithms (such as BFS or DFS)?",
      "options": [
        { "text": "In classical atomic search, states are treated as indivisible 'black boxes' with zero internal visibility, meaning the solver cannot evaluate errors until a full path is constructed; in a factored CSP representation, states are decomposed into explicit variable-value pairs, which allows domain-independent constraint propagation algorithms (such as AC-3 and Forward Checking) to detect inconsistencies in partial assignments immediately and prune vast exponential subtrees before attempting invalid combinations", "isCorrect": true, "explanation": "Correct! This is the primary theoretical motivation for CSPs in artificial intelligence (Russell & Norvig *AIMA* Chapter 6.1). 1. **The Black Box Problem in Atomic Search:** - In a standard graph search, state $S$ is just an abstract token. The algorithm has no idea what is *inside* $S$. - To solve an 8-Queens problem, standard DFS might place 8 queens on the board, check if it's a goal, find it fails, and backtrack. - This requires searching $8^8 \\approx 16.7\\text{ million states}$! 2. **The Power of Factored CSPs:** - In a CSP, the state is a transparent tuple: $\\{Q_1=1, Q_2=1, Q_3=?, \\dots\\}$. - The moment $Q_2=1$ is assigned, the constraint $Q_1 \\ne Q_2$ is **immediately violated on a partial assignment**! - The solver halts exploration of that branch instantly, pruning all $8^6 = 262,144$ sub-states beneath it in one microsecond! 3. Factoring state variables enables general-purpose heuristics (MRV, LCV, AC-3) that solve huge scheduling and routing problems without domain-specific heuristics." },
        { "text": "Because CSPs automatically convert all mathematical numbers into binary strings", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because constraint graphs can only be solved on quantum computers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because CSP domains can never contain more than two values", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
