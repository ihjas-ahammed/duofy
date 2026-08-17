# Duofy Reusable Lesson Format: Heuristic Dominance and Memory-Bounded IDA*

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Classical_AI_and_Search_Algorithms / Uninformed_and_Informed_Search_A_Star`  
**Lesson Format Type:** `heuristic_dominance_and_memory_bounded_ida_star`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify heuristic dominance metrics, relaxed problem generation, and memory-bounded search algorithms (Richard Korf 1985 Iterative-Deepening A* [IDA*]; Russell & Norvig *AIMA* Chapter 3.5.3–3.6): master the **Heuristic Dominance Principle** (if $h_2(n) \ge h_1(n)$ for all non-goal nodes $n$ and both are admissible, $h_2$ **dominates** $h_1$; proving that $h_2$ will never expand more nodes than $h_1$), analyze how to derive admissible heuristics via **Problem Relaxation (e.g. 8-Puzzle: Manhattan Distance $h_{\text{MD}}$ dominates Misplaced Tiles $h_{\text{misplaced}}$)**, master **Iterative Deepening A* (IDA*)** (combines the linear memory $\mathcal{O}(bd)$ of DFS with the heuristic power of A*, setting the cutoff threshold to the minimum $f$-cost that exceeded the previous bound), and interact with live 8-puzzle heuristic evaluation and A* vs IDA* frontier simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Heuristic Dominance Theorem, 8-Puzzle Relaxation, & IDA* Cutoff Threshold Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Heuristic Search Construct / Algorithm & Performance Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Manhattan Distance Dominates Misplaced Tiles in the 8-Puzzle Problem Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Memory-Bounded Heuristic Search Algorithm That Uses f-Cost Thresholds in DFS Loops is ___ (IDA* / Iterative Deepening A*) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive A* vs IDA* Frontier Expansion & Heuristic Comparison Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "heuristic_dominance_and_memory_bounded_ida_star",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is heuristic dominance, how are heuristics derived via relaxation, and how does IDA* solve A*'s memory bottleneck?",
      "blankAnswer": "Heuristic Dominance & IDA* (Russell & Norvig *AIMA* 3.5-3.6; Korf 1985): (1) HEURISTIC DOMINANCE: If h_2(n) >= h_1(n) for all nodes n (and both are admissible), h_2 is said to DOMINATE h_1. An A* search using h_2 will never expand more nodes than an A* search using h_1 (it is strictly more efficient!). (2) PROBLEM RELAXATION: Removing constraints creates a simplified problem whose exact optimal solution cost is an admissible heuristic for the original problem. E.g. 8-Puzzle: (i) h_1 (Misplaced Tiles): Count tiles in wrong position. (ii) h_2 (Manhattan Distance): Sum of grid horizontal/vertical distances. Since each misplaced tile requires at least 1 move, h_2(n) >= h_1(n) always; Manhattan distance dominates! (3) IDA* (Iterative Deepening A*): Solves A*'s exponential memory problem. Uses Depth-First Search with an f-cost cutoff threshold (initially set to f(Root) = h(Root)). Each iteration prunes any branch where f(n) > threshold. If no goal is found, the next threshold is set to the smallest f(n) value that exceeded the previous threshold. Space complexity is reduced to linear O(b*d)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Advanced Heuristic Search Concept to its exact Operational Definition.",
      "matchPairs": [
        { "left": "Heuristic Dominance", "right": "Property where admissible heuristic h2(n) >= h1(n) for all states, guaranteeing fewer or equal node expansions" },
        { "left": "Problem Relaxation", "right": "Generating admissible heuristics by removing physical movement constraints from the state transition model" },
        { "left": "Iterative Deepening A* (IDA*)", "right": "Memory-efficient heuristic search using DFS iterations bounded by monotonically increasing f-cost thresholds" },
        { "left": "Manhattan Distance Heuristic", "right": "Sum of absolute horizontal and vertical coordinate offsets of tiles from their target goal positions" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In the classic 8-puzzle sliding tile game, why is the Manhattan Distance heuristic h_2 mathematically guaranteed to dominate the Misplaced Tiles heuristic h_1, and what is the practical consequence for A* search?",
      "options": [
        { "text": "For every misplaced tile in any puzzle state, the tile must be moved at least 1 step to reach its goal position, which means its Manhattan distance is always >= 1; summing these values across all misplaced tiles proves that Manhattan Distance h_2(n) >= h_1(n) for every possible board configuration n; because h_2 is closer to the true optimal cost h*(n) while remaining strictly admissible, A* using Manhattan Distance will prune more search space and expand significantly fewer total nodes than Misplaced Tiles", "isCorrect": true, "explanation": "Correct! This is the canonical textbook example of heuristic dominance and problem relaxation (Russell & Norvig *AIMA* Section 3.6; Judea Pearl *Heuristics*). 1. **Mathematical Proof of Dominance:** - For any individual tile $i$: - If tile $i$ is already in its goal position, its misplaced count is $0$ and its Manhattan distance is $0$. - If tile $i$ is misplaced, its misplaced count is $1$. But to reach its goal, it must move at least $1$ step horizontally or vertically (so Manhattan distance $\\text{MD}(i) \\ge 1$). - Summing over all 8 tiles: $\\mathbf{h_2(n) = \\sum \\text{MD}(i) \\ge \\sum \\text{Misplaced}(i) = h_1(n)}$. 2. **Consequence of Dominance:** - In A*, any node with $f(n) < C^*$ is guaranteed to be expanded. - Because $h_2(n) \\ge h_1(n)$, $f_2(n) = g(n) + h_2(n) \\ge g(n) + h_1(n) = f_1(n)$. - This means fewer non-optimal nodes will satisfy $f_2(n) < C^*$. - On standard 8-puzzle benchmarks, A* with Misplaced Tiles expands an average of $\\approx 280,000\\text{ nodes}$ for depth-20 problems, whereas A* with Manhattan Distance expands only $\\approx 1,500\\text{ nodes}$—a $180\\times$ performance boost!" },
        { "text": "Because Manhattan distance was invented in New York City", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Misplaced Tiles is not an admissible heuristic", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because 8-puzzles cannot be solved using Misplaced Tiles", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The memory-bounded heuristic search algorithm that uses f-cost thresholds in DFS loops is ___.",
      "blankAnswer": "IDA*",
      "blankDistractors": ["BFS", "UCS", "DFS"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive A* vs IDA* Frontier Expansion Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>8-Puzzle Heuristic & Search Engine</h3><div style=\"display:flex; gap:6px;\"><button id=\"btnMisplaced\" style=\"padding:6px 10px; background:#ef4444; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Eval h1 (Misplaced Tiles)</button><button id=\"btnManhattan\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Eval h2 (Manhattan Distance)</button><button id=\"btnIda\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Run IDA* (Linear RAM)</button></div><div id=\"searchLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Select a heuristic or search method...</div><script>document.getElementById('btnMisplaced').onclick=()=>{document.getElementById('searchLog').innerHTML='<b>EVALUATING h1 (MISPLACED TILES):</b><br>• Count of misplaced tiles: <b>h1 = 4</b><br>• A* Node Expansions (Depth 16): <b>~39,000 nodes</b><br>• Memory: Heavy RAM usage (storing 39k states in priority queue).';}; document.getElementById('btnManhattan').onclick=()=>{document.getElementById('searchLog').innerHTML='<b>EVALUATING h2 (MANHATTAN DISTANCE):</b><br>• Sum of grid displacements: <b>h2 = 8</b><br>• Theorem: h2(n) &ge; h1(n) &rarr; <b style=\"color:#38bdf8;\">h2 DOMINATES h1!</b><br>• A* Node Expansions (Depth 16): <b>~1,300 nodes (30x faster!)</b>';}; document.getElementById('btnIda').onclick=()=>{document.getElementById('searchLog').innerHTML='<b>RUNNING IDA* (Iterative Deepening A*):</b><br>• Threshold 1: f &le; 8 (Explored 4 nodes)<br>• Threshold 2: f &le; 10 (Explored 28 nodes)<br>• Threshold 3: f &le; 12 (Goal Reached!)<br>💾 <b style=\"color:#10b981;\">RAM Usage: O(b*d) = ONLY 48 BYTES!</b><br>🎉 Optimal path found with zero memory exhaustion!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
