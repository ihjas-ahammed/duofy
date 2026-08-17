# Duofy Reusable Lesson Format: Transposition Tables and Monte Carlo Tree Search (MCTS)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Classical_AI_and_Search_Algorithms / Minimax_Search_and_Alpha_Beta_Pruning`  
**Lesson Format Type:** `transposition_tables_and_monte_carlo_tree_search_mcts`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify state hashing caches, transposition tables, and modern simulation-based game tree exploration algorithms (Albert Zobrist 1970 Hashing; Rémi Coulom 2006 MCTS; Levente Kocsis & Csaba Szepesvári 2006 UCT; DeepMind AlphaGo 2016 Silver et al.; Russell & Norvig *AIMA* Chapter 5.5–5.6): master **Transposition Tables with Zobrist Hashing** (bitwise XOR hashing of 64-bit random integers per piece-square combination, caching min/max bounds and best moves to eliminate redundant graph permutations), master the **4 Phases of Monte Carlo Tree Search (MCTS)** (**1. Selection [Upper Confidence Bound for Trees UCT: $\mathbf{\text{UCT}(n) = \frac{Q(n)}{N(n)} + c \sqrt{\frac{\ln N(\text{parent})}{N(n)}}}$ balancing Exploitation vs Exploration]**, **2. Expansion**, **3. Simulation / Random Rollout**, and **4. Backpropagation [updating visit counts $N$ and win rates $Q$]**), and evaluate why MCTS completely revolutionized games with astronomical branching factors like Go ($b \approx 250$), where classical minimax evaluation functions fail, and interact with live MCTS selection and UCT simulation widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Zobrist Hashing Transposition Tables, MCTS 4-Phase Cycle, & UCT Equation Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | MCTS 4-Phase Step / Algorithmic Construct & Mathematical Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why MCTS Revolutionized AI in Games with High Branching Factors (like Go) Over Minimax Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Mathematical Formula Used in MCTS Selection to Balance Exploitation and Exploration (UCT / Upper Confidence Bound) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Monte Carlo Tree Search (MCTS) UCT Rollout Engine Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "transposition_tables_and_monte_carlo_tree_search_mcts",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are Transposition Tables, what are the 4 phases of MCTS, and how does the UCT selection formula work?",
      "blankAnswer": "Transposition Tables & MCTS (Zobrist 1970; Coulom 2006; Silver et al. 2016): (1) TRANSPOSITION TABLES (Zobrist Hashing): Caches previously evaluated game states reached via different move permutations (e.g. 1. e4 e5 2. Nf3 Nc6 vs 1. Nf3 Nc6 2. e4 e5). Uses fast bitwise XOR of 64-bit random numbers per piece/square. Avoids re-searching identical subtrees! (2) MONTE CARLO TREE SEARCH (MCTS - The 4 Phases): (i) Selection: Traverse tree from root using UCT formula to pick promising node. (ii) Expansion: Add one or more unvisited child nodes to tree. (iii) Simulation (Rollout): Play game out to end using fast random/heuristic moves. (iv) Backpropagation: Propagate simulation outcome (Win +1, Loss 0) upward to update win rate Q(n) and visit counts N(n) along the selected path! (3) UCT FORMULA (Upper Confidence Bound for Trees): UCT(n) = (Q(n)/N(n)) + c * sqrt(ln(N_parent) / N(n)). First term = EXPLOITATION (win rate); Second term = EXPLORATION (visit rarity). Solves games with huge branching factor (Go: b=250) without handcrafted eval functions!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Advanced Game AI Component to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Zobrist Hashing", "right": "Fast incremental bitwise XOR hashing caching identical transposed board states in memory" },
        { "left": "MCTS Selection Phase", "right": "Traverses tree from root down to an unexpanded leaf using the UCT formula to balance exploration" },
        { "left": "MCTS Simulation (Rollout)", "right": "Executes rapid random or heuristic playouts from the expanded node until a terminal game result is reached" },
        { "left": "MCTS Backpropagation", "right": "Updates visit counts N and win totals Q for all ancestor nodes traversed during the simulation iteration" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why did classical Minimax with Alpha-Beta pruning fail to achieve master-level performance in the ancient game of Go for decades, whereas Monte Carlo Tree Search (MCTS) revolutionized computer Go and defeated human world champions?",
      "options": [
        { "text": "Go features an enormous branching factor (b approx 250 compared to b approx 35 in chess) making minimax tree search explode exponentially, and creating an accurate handcrafted static evaluation function for Go is virtually impossible because stone influence is subtle and non-linear; MCTS avoids exhaustive full-width tree expansion by selectively growing asymmetrical trees along promising paths guided by UCT, using statistical random simulation rollouts rather than brittle handcrafted evaluation functions to estimate position strength", "isCorrect": true, "explanation": "Correct! This is the historic milestone that led from MCTS to DeepMind's AlphaGo (Coulom 2006; Kocsis & Szepesvári 2006; David Silver et al. *Nature* 2016). 1. **Why Minimax Failed in Go:** - **Combinatorial Explosion:** Chess has $b \\approx 35, d \\approx 80$. Go on a $19 \\times 19$ board has $b \\approx 250, d \\approx 150$. Alpha-Beta can only search 3-4 plies deep in Go before running out of compute time. - **The Evaluation Function Bottleneck:** In chess, counting pieces ($Q=9, R=5, B=3$) gives a great rough evaluation. In Go, every stone has identical material weight! Evaluating a Go board requires assessing 'thickness', 'influence', and 'liberties', which defied decades of handcrafted programming. 2. **The MCTS Breakthrough:** - MCTS doesn't try to search every move evenly. It builds an **asymmetrical search tree**, searching deep into the best moves and completely ignoring silly moves. - MCTS does not require a human-programmed evaluation function; it simply plays 10,000 rapid simulated games to the end and counts what percentage of games were won! - Combined with Deep Neural Networks (Policy & Value Networks), AlphaGo crushed human 9-dan world champion Lee Sedol in 2016." },
        { "text": "Because Go boards cannot be represented using binary numbers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Alpha-Beta pruning is illegal under international Go rules", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because MCTS only works on games played on 8x8 boards", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The mathematical selection formula in MCTS that balances exploitation and exploration is ___ (Upper Confidence Bound for Trees).",
      "blankAnswer": "UCT",
      "blankDistractors": ["A*", "DFS", "BFS"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Monte Carlo Tree Search (MCTS) Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>MCTS (UCT) Game Engine</h3><p>Root Visits: <b id=\"rootVisits\" style=\"color:#38bdf8;\">N = 100</b> | Move A vs Move B</p><div style=\"display:flex; gap:6px;\"><button id=\"btnUct\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Eval UCT Selection</button><button id=\"btnRollout\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Run Playout Simulation</button><button id=\"btnBackprop\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Backpropagate (Win +1)</button></div><div id=\"mctsLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate UCT bounds...</div><script>document.getElementById('btnUct').onclick=()=>{document.getElementById('mctsLog').innerHTML='<b>MCTS SELECTION (UCT):</b><br>• Move A: Q=35/50 (0.70) + UCT_Expl=0.42 &rarr; <b>1.12</b><br>• Move B: Q=12/20 (0.60) + UCT_Expl=0.67 &rarr; <b style=\"color:#38bdf8;\">1.27 (HIGHEST UCT!)</b><br>&rarr; Selected Move B for Exploration!';}; document.getElementById('btnRollout').onclick=()=>{document.getElementById('mctsLog').innerHTML='<b>MCTS SIMULATION (ROLLOUT):</b><br>• Executed 150 rapid random playout steps from Move B...<br>🎉 Playout Outcome: <b style=\"color:#10b981;\">WIN (Utility = +1)</b>!';}; document.getElementById('btnBackprop').onclick=()=>{document.getElementById('mctsLog').innerHTML='<b>MCTS BACKPROPAGATION:</b><br>• Move B Stats: Visits N = 20 &rarr; <b>21</b>, Wins Q = 12 &rarr; <b style=\"color:#10b981;\">13 (61.9%)</b><br>• Root Stats: Visits N = 100 &rarr; <b>101</b><br>🌳 Asymmetric tree search reinforced high-value tactical path!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
