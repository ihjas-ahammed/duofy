# Duofy Reusable Lesson Format: Alpha-Beta Pruning (Cutoff Conditions and Move Ordering)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Classical_AI_and_Search_Algorithms / Minimax_Search_and_Alpha_Beta_Pruning`  
**Lesson Format Type:** `alpha_beta_pruning_cutoff_conditions_and_move_ordering`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mathematical bounds, branch pruning invariants, and asymptotic complexity speedups of the Alpha-Beta Pruning algorithm (Donald Knuth & Ronald W. Moore 1975, *An Analysis of Alpha-Beta Pruning*; Russell & Norvig *AIMA* Chapter 5.3): define the **Two Search Bounds ($\mathbf{\alpha}$ = highest value MAX is guaranteed along current path so far [initialized to $-\infty$], $\mathbf{\beta}$ = lowest value MIN is guaranteed along current path so far [initialized to $+\infty$])**, master the **Pruning Cutoff Invariant ($\mathbf{\alpha \ge \beta \implies \text{PRUNE SUBTREE}}$)**, trace step-by-step tree pruning executions, analyze how **Optimal Move Ordering (evaluating best moves first via Killer Heuristic or History Heuristic)** reduces computational complexity from $\mathcal{O}(b^d)$ down to the theoretical lower bound $\mathbf{\mathcal{O}(b^{d/2}) = \mathcal{O}((\sqrt{b})^d)}$ (effectively **doubling the playable search depth** within identical compute time), and evaluate Worst-Case ordering ($\mathcal{O}(b^d)$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Alpha-Beta Pruning Definition, Mathematical Invariant $\alpha \ge \beta$, & Complexity Theorems Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Alpha-Beta Pruning Execution and Cutoff Trigger Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Alpha-Beta Parameter / Move Ordering Scheme & Performance Characteristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Mathematical Invariant Triggering an Immediate Subtree Prune in Alpha-Beta Search is When Alpha is Greater Than or Equal to ___ (Beta / $\beta$) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Analysis of Why Optimal Move Ordering Doubles Search Depth ($\mathcal{O}(b^{d/2})$) Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Alpha-Beta (Knuth & Moore 1975; Russell & Norvig *AIMA* 5.3):
   - **The Two Search Bounds:**
     $$\mathbf{\alpha = \text{Best value for MAX along path (Initialized to } -\infty)}$$
     $$\mathbf{\beta = \text{Best value for MIN along path (Initialized to } +\infty)}$$
   - **The Alpha-Beta Pruning Cutoff Rule:**
     $$\mathbf{\text{If } \mathbf{\alpha \ge \beta} \implies \text{PRUNE remaining successor branches at this node!}}$$
   - **Complexity & Move Ordering:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Move Ordering Quality} & \textbf{Time Complexity} & \textbf{Effective Branching Factor} \\
     \hline
     \mathbf{\text{Worst-Case (Worst moves first)}} & \mathcal{O}(b^d) & b \\
     \mathbf{\text{Random Ordering}} & \approx \mathcal{O}(b^{3d/4}) & b^{3/4} \\
     \mathbf{\text{Perfect / Optimal Ordering}} & \mathbf{\mathcal{O}(b^{d/2}) = \mathcal{O}((\sqrt{b})^d)} & \mathbf{\sqrt{b} \text{ (DOUBLES SEARCH DEPTH!)}} \\
     \hline
     \end{array}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of an Alpha-Beta search where a cutoff occurs: (1) initialize root node with alpha = -infinity and beta = +infinity, (2) MAX traverses left branch to MIN node; MIN evaluates first child with utility 3; updates beta = 3, (3) MIN finishes evaluating left branch; returns value 3 to MAX; MAX updates alpha = max(-inf, 3) = 3, (4) MAX traverses right branch to second MIN node, passing down alpha = 3 and beta = +infinity, (5) second MIN node evaluates its first child with utility 2; updates beta = 2; since alpha (3) >= beta (2), trigger pruning cutoff and skip remaining right children!
3. **Slide 3 (`matching`):** Pair 4 terms ($\alpha$ Bound, $\beta$ Bound, Pruning Condition $\alpha \ge \beta$, Killer Heuristic) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that pruning triggers when alpha >= beta. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why optimal move ordering achieves $\mathcal{O}(b^{d/2})$: Why does perfect move ordering in Alpha-Beta pruning reduce the time complexity from $\mathcal{O}(b^d)$ to $\mathcal{O}(b^{d/2})$, and what is the practical impact on game AI (e.g. Chess engines)? (With perfect move ordering, the best move is always evaluated first; for MAX nodes, evaluating the single best child immediately raises $\alpha$ to its highest possible value, allowing **all subsequent $b-1$ sibling moves to be pruned immediately at the MIN level**; this reduces the effective branching factor from $b$ to $\sqrt{b}$, meaning an engine that could previously search to depth $d=6$ can now **search to depth $d=12$ within the exact same computational time budget**, providing superhuman tactical foresight).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "alpha_beta_pruning_cutoff_conditions_and_move_ordering",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Alpha-Beta Pruning (Knuth \\& Moore 1975)**\n• **The Two Adversarial Search Bounds (Russell & Norvig *AIMA* 5.3):**\n$$\n\\mathbf{\\alpha = \\text{Highest utility value MAX has secured along the path (Default: } -\\infty)}\n$$\n$$\n\\mathbf{\\beta = \\text{Lowest utility value MIN has secured along the path (Default: } +\\infty)}\n$$\n• **The Pruning Invariant:**\n$$\n\\mathbf{\\text{Whenever } \\mathbf{\\alpha \\ge \\beta} \\implies \\text{PRUNE all remaining child branches immediately!}}\n$$\n• **Asymptotic Scaling Matrix:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Move Ordering Quality} & \\textbf{Time Complexity} & \\textbf{Effective Depth Impact} \\\\\n\\hline\n\\mathbf{\\text{Worst-Case Ordering}} & \\mathcal{O}(b^d) & \\text{Identical to standard Minimax} \\\\\n\\mathbf{\\text{Optimal Move Ordering}} & \\mathbf{\\mathcal{O}(b^{d/2}) = \\mathcal{O}((\\sqrt{b})^d)} & \\mathbf{\\text{DOUBLES searchable ply depth!}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Guarantee:** Pruning returns the **exact same minimax decision** with zero error!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed during an Alpha-Beta search resulting in an alpha-beta cutoff.",
      "orderItems": [
        "Initialize the root MAX node with search bounds alpha = -infinity and beta = +infinity",
        "Traverse down left subtree; MIN node evaluates child returning utility 4; MIN updates its bound: beta = min(+infinity, 4) = 4",
        "Left branch completes; value 4 returns to root MAX; MAX updates its guaranteed score: alpha = max(-infinity, 4) = 4",
        "MAX traverses right subtree; passes updated bounds (alpha = 4, beta = +infinity) down to the right MIN node",
        "Right MIN node evaluates first child returning utility 2; updates beta = 2; since alpha (4) >= beta (2), prune remaining children!"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Alpha-Beta Search Construct to its exact Technical Definition.",
      "matchPairs": [
        { "left": "Alpha (alpha) Bound", "right": "The maximum guaranteed score MAX has discovered along the current search path so far" },
        { "left": "Beta (beta) Bound", "right": "The minimum guaranteed score MIN has discovered along the current search path so far" },
        { "left": "Pruning Cutoff (alpha >= beta)", "right": "Condition where a branch is discarded because a rational adversary would never allow game flow here" },
        { "left": "Killer Move Heuristic", "right": "Move ordering optimization that tests moves that caused cutoffs in sibling nodes first" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Alpha-Beta pruning, remaining branches are pruned whenever alpha is greater than or equal to ___.",
      "blankAnswer": "beta",
      "blankDistractors": ["gamma", "delta", "infinity"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does optimal move ordering in Alpha-Beta pruning reduce computational time complexity from O(b^d) down to O(b^(d/2)), and what is the practical consequence for competitive game engines (like Deep Blue or Stockfish)?",
      "options": [
        { "text": "When the strongest moves are evaluated first, the best choice at each MAX node instantly raises alpha to its maximum possible threshold, causing all subsequent b-1 sub-optimal sibling branches to trigger the alpha >= beta cutoff after examining only a single child at the MIN level; mathematically, the effective branching factor drops from b to sqrt(b), which allows a game engine constrained to a fixed time budget per move to double its search depth (e.g. from 6 plies to 12 plies deep), providing massive tactical superiority", "isCorrect": true, "explanation": "Correct! This is the definitive mathematical proof of Alpha-Beta efficiency (Knuth & Moore 1975; Russell & Norvig *AIMA* Section 5.3). 1. **The Proof of $O(b^{d/2})$:** - In a tree of branching factor $b$ and depth $d$: - If the best move is searched first at every step: - For MAX nodes, you must evaluate all $b$ children to verify no better move exists. - For MIN nodes, evaluating the FIRST child is so strong that it immediately drops $\\beta \\le \\alpha$, allowing you to **prune all remaining $b-1$ children**! - The number of leaf nodes evaluated becomes: $N = b \\cdot 1 \\cdot b \\cdot 1 \\dots = b^{d/2} = (\\sqrt{b})^d$. 2. **Practical Impact in Chess ($b \\approx 35$):** - In standard Minimax, $35^6 \\approx 1.83\\text{ billion positions}$. - With optimal Alpha-Beta, searching depth 6 takes only $(\\sqrt{35})^6 = 35^3 = \\mathbf{42,875\\text{ positions}}$—a $42,000\\times$ reduction! - In the time standard Minimax reaches depth 6, Alpha-Beta reaches **depth 12** ($35^6 = 1.83\\text{ billion positions}$). - In chess, searching 12 plies instead of 6 is the difference between a novice engine and a Grandmaster." },
        { "text": "Because Alpha-Beta pruning eliminates all pawn moves in chess", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because game trees with optimal move ordering become 1-dimensional lists", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Alpha-Beta only evaluates nodes when the computer screen is turned off", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
