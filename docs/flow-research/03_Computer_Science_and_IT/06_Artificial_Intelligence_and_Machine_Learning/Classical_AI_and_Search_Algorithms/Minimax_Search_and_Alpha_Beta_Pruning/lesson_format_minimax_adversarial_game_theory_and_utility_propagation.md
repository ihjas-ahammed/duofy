# Duofy Reusable Lesson Format: Minimax Adversarial Game Theory and Utility Propagation

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Classical_AI_and_Search_Algorithms / Minimax_Search_and_Alpha_Beta_Pruning`  
**Lesson Format Type:** `minimax_adversarial_game_theory_and_utility_propagation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the game-theoretic problem formulations, recursive tree evaluations, and bottom-up utility backpropagation of the Minimax algorithm (John von Neumann 1928 Minimax Theorem; Russell & Norvig *AIMA* Chapter 5.1–5.2): master the **Formal Zero-Sum 2-Player Game Tuple** ($\langle S_0, \text{Player}(s), \text{Actions}(s), \text{Result}(s, a), \text{TerminalTest}(s), \text{Utility}(s, p) \rangle$), master the **Recursive Minimax Decision Rule** ($\mathbf{\text{MAX maximizes utility, MIN minimizes utility}}$), trace how numeric leaf utilities propagate upward through alternating MAX and MIN ply layers to determine the rational game-theoretic equilibrium move, evaluate game tree complexity bounds ($\mathcal{O}(b^d)$ time, $\mathcal{O}(bd)$ stack memory), and analyze why optimal play against a rational opponent yields the best possible worst-case outcome.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Minimax Decision Rule Equations, Zero-Sum Game Tree Alternating Ply Diagram Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Bottom-Up Utility Backpropagation in a 2-Ply Minimax Game Tree Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Game Tree Component / Minimax Property & Mathematical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Player in Minimax That Seeks to Minimize the Terminal Utility Score is ___ (MIN) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why Minimax Guarantees the Optimal Move Assuming Both Players Play Perfectly Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Minimax (Von Neumann 1928; Russell & Norvig *AIMA* 5.1–5.2):
   - **The Minimax Decision Rule:**
     $$\mathbf{\text{Minimax}(s) = \begin{cases} \text{Utility}(s) & \text{if TerminalTest}(s) \\ \max_{a \in \text{Actions}(s)} \text{Minimax}(\text{Result}(s, a)) & \text{if Player}(s) = \text{MAX} \\ \min_{a \in \text{Actions}(s)} \text{Minimax}(\text{Result}(s, a)) & \text{if Player}(s) = \text{MIN} \end{cases}}$$
   - **Zero-Sum Property:** $\text{Utility}_{\text{MAX}} + \text{Utility}_{\text{MIN}} = 0 \implies \text{MAX win is MIN loss}$.
   - **Complexity:** Time $\mathcal{O}(b^d)$, Space $\mathcal{O}(bd)$ using recursive Depth-First Search.
2. **Slide 2 (`ordering`):** Provide 5 steps of evaluating a Minimax tree of depth 2: (1) MAX generates all legal moves from root, creating MIN child nodes, (2) MIN generates all legal responses from each child, creating terminal leaf states, (3) evaluate utility function on all terminal leaf states (e.g. +10, +3, -5, +7), (4) propagate values upward to MIN nodes: MIN selects the minimum utility among its children, (5) propagate values upward to MAX root: MAX selects the action leading to the maximum utility among the MIN nodes!
3. **Slide 3 (`matching`):** Pair 4 game tree concepts (MAX Node, MIN Node, Terminal State, Zero-Sum Game) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of the MIN player. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Minimax optimality assumptions: Why is the Minimax algorithm guaranteed to achieve the optimal strategy in a deterministic, zero-sum, perfect-information game (such as Tic-Tac-Toe or Chess), and what occurs if the opponent plays sub-optimally? (Minimax is derived from the **Von Neumann Minimax Theorem**, proving that against an optimal opponent who always chooses the move that minimizes MAX's payoff, Minimax selects the move that **maximizes MAX's guaranteed worst-case return (Nash Equilibrium)**; if the opponent makes a mistake and plays sub-optimally, Minimax is **mathematically guaranteed to achieve an outcome that is equal to or strictly better than its calculated minimax value**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "minimax_adversarial_game_theory_and_utility_propagation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Minimax Adversarial Search (Von Neumann 1928)**\n• **The Minimax Decision Rule (Russell & Norvig *AIMA* 5.2):**\n$$\n\\mathbf{\\text{Minimax}(s) = \\begin{cases} \\text{Utility}(s) & \\text{if TerminalTest}(s) \\\\ \\max_{a \\in \\text{Actions}(s)} \\text{Minimax}(\\text{Result}(s, a)) & \\text{if Player}(s) = \\text{MAX} \\\\ \\min_{a \\in \\text{Actions}(s)} \\text{Minimax}(\\text{Result}(s, a)) & \\text{if Player}(s) = \\text{MIN} \\end{cases}}\n$$\n• **Zero-Sum Game Invariant:** $\\text{Utility}_{\\text{MAX}} + \\text{Utility}_{\\text{MIN}} = 0$ (Total conflict of interest).\n• **Complexity Bounds:** Time $\\mathcal{O}(b^d)$, Linear DFS Stack Space $\\mathcal{O}(b \\cdot d)$.\n• **Game Equilibrium:** Chooses the strategy that **maximizes the minimum guaranteed payoff** against rational opposition!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed to compute the optimal Minimax move across a 2-ply adversarial game tree.",
      "orderItems": [
        "MAX generates all legal opening actions from the root state, producing level-1 successor states assigned to MIN",
        "MIN generates all legal counter-responses from each level-1 state, producing level-2 terminal leaf states",
        "Evaluate the static utility function on all level-2 terminal leaf nodes to assign raw numeric values (e.g. +8, +3, -2, +5)",
        "Propagate scores up to level 1: Each MIN node selects and stores the minimum utility value among its children",
        "Propagate scores up to root: MAX selects the action branch that leads to the maximum utility value among the MIN nodes"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Adversarial Search Concept to its exact Game-Theoretic Definition.",
      "matchPairs": [
        { "left": "MAX Player Node", "right": "Decision point where the agent chooses the action that maximizes the game-theoretic utility score" },
        { "left": "MIN Player Node", "right": "Decision point where the adversary chooses the action that minimizes the utility score for MAX" },
        { "left": "Zero-Sum Game", "right": "Mathematical game where one player's gain exactly equals the other player's loss (sum of payoffs = 0)" },
        { "left": "Terminal Utility Function", "right": "Objective numeric rating assigned to completed game end-states (e.g. +1 for Win, 0 for Draw, -1 for Loss)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a standard 2-player zero-sum game tree, the adversary seeking to minimize MAX's score is the ___ player.",
      "blankAnswer": "MIN",
      "blankDistractors": ["MAX", "EVAL", "ROOT"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the Minimax algorithm guaranteed to yield the optimal game-theoretic decision in a deterministic zero-sum game, and what is guaranteed to happen if the opponent makes a mistake and plays sub-optimally?",
      "options": [
        { "text": "Minimax is derived from Von Neumann's Minimax Theorem, proving that against an optimal opponent who always plays the best possible counter-move, Minimax selects the action that maximizes MAX's minimum guaranteed outcome (the Nash Equilibrium); if the opponent makes an error and chooses a sub-optimal move, Minimax is mathematically guaranteed to achieve an outcome that is equal to or strictly superior to its calculated minimax score", "isCorrect": true, "explanation": "Correct! This is the foundational game-theoretic theorem behind adversarial search (Russell & Norvig *AIMA* Section 5.2; John von Neumann 1928). 1. **Worst-Case Optimal Guarantee:** - Minimax assumes the opponent is a ruthless grandmaster who will find the move that hurts MAX the most. - By calculating the maximum of the minimums (MaxiMin), MAX guarantees that no matter what the opponent does, the final utility will be AT LEAST the minimax value $V^*$. 2. **What if the Opponent Plays Poorly?** - Suppose the minimax score is $+3$. - If the opponent plays perfectly, the final score will be exactly $+3$. - If the opponent blunders, they deviate to a branch with higher utility (e.g. $+8$ or $+10$). - Therefore, against a flawed opponent, MAX's actual payout is $\\ge V^*$, never worse! - Minimax never loses ground when the opponent makes a mistake." },
        { "text": "Because Minimax forces the opponent's computer to turn off", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Minimax only works when the opponent has zero pieces on the board", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Minimax computes the average of all possible random moves", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
