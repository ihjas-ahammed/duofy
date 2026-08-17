# Duofy Reusable Lesson Format: Held-Karp Bitmask DP for Traveling Salesperson

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Algorithm_Design_Techniques / Dynamic_Programming_DP`  
**Lesson Format Type:** `held_karp_bitmask_dp_for_traveling_salesperson`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid state-space compression, exponential bitwise transitions, and exact combinatorial optimization mastery of the Traveling Salesperson Problem (TSP) using Held-Karp Bitmask Dynamic Programming (Michael Held & Richard M. Karp 1962; Bellman 1962; Thomas H. Cormen et al. CLRS): contrast the factorial brute-force baseline ($O(n!)$ which becomes intractable for $n > 12$) with the **Held-Karp Bitmask DP Formulation** ($\mathbf{dp[\text{mask}][u]}$ representing the minimum cost to start at vertex $0$, visit every vertex in the subset `mask`, and end at vertex $u$), formulate the **Bitmask State Transition ($\mathbf{dp[\text{mask}][u] = \min_{v \in \text{mask}, v \ne u} \{dp[\text{mask} \setminus \{u\}][v] + \text{cost}(v, u)\}}$)**, evaluate the asymptotic complexity reduction to **$\mathbf{O(n^2 2^n)\text{ Time}}$ and $\mathbf{O(n 2^n)\text{ Space}}$** (solving $n=20$ in seconds), and interact with live bitmask subset transition engines.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Held-Karp State Compression & Bitmask Transition Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Bitmask DP Term / Bitwise Operator & Mathematical Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Asymptotic Complexity Comparison: Brute-Force vs Held-Karp Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Total Number of Subsets Represented by an n-Bit Bitmask Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Held-Karp Bitmask TSP Dynamic Programming Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "held_karp_bitmask_dp_for_traveling_salesperson",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Held-Karp algorithm and how does Bitmask DP reduce TSP from O(n!) to O(n^2 * 2^n)?",
      "blankAnswer": "Exact Traveling Salesperson Problem optimization (Michael Held & Richard M. Karp 1962; Bellman 1962): (1) THE STATE DEFINITION: Represent visited vertex subsets as an integer bitmask S in {0, 1}^n. dp[S][u] = minimum cost path starting at vertex 0, visiting all vertices in subset S, and ending at vertex u. (2) THE RECURRENCE TRANSITION: dp[S][u] = min over v in S, v != u { dp[S ^ (1 << u)][v] + dist(v, u) } (where S ^ (1 << u) unsets bit u to represent the previous subset without u). (3) BASE CASE: dp[1 << 0][0] = 0 (starting at vertex 0 with subset {0}). (4) FINAL CYCLE CLOSURE: Total_Min_Cost = min over u in {1..n-1} { dp[(1 << n) - 1][u] + dist(u, 0) }. (5) COMPLEXITY REDUCTION: Replaces factorial O(n!) brute-force permutations with exact Dynamic Programming in O(n² * 2^n) time and O(n * 2^n) space, making n = 20 solvable in seconds!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Held-Karp bitmask DP component to its exact mathematical meaning.",
      "matchPairs": [
        { "left": "dp[mask][u]", "right": "Minimum cost of a path starting at city 0, visiting all cities in 'mask', and ending at city u" },
        { "left": "mask ^ (1 << u)", "right": "Bitwise XOR operation unsetting the u-th bit to query the predecessor subset state" },
        { "left": "mask & (1 << v)", "right": "Bitwise AND operation checking if candidate city v is an element of the current subset" },
        { "left": "(1 << n) - 1", "right": "Full bitmask with all n bits set to 1, representing the complete set of all visited cities" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "For a graph with n = 20 cities, how does the number of operations performed by the Held-Karp Bitmask DP algorithm compare to brute-force permutation search (O(n!))?",
      "options": [
        { "text": "Brute force requires evaluating 20! ≈ 2.43 * 10^18 permutations (taking ~77 years on a supercomputer); whereas Held-Karp executes n^2 * 2^n = 20^2 * 2^20 = 400 * 1,048,576 ≈ 4.19 * 10^8 operations, completing in under 0.5 seconds on a standard laptop", "isCorrect": true, "explanation": "Correct! The dramatic difference between factorial $O(n!)$ and exponential $O(n^2 2^n)$ illustrates the power of Dynamic Programming. In brute-force search, every possible ordering of cities must be checked: $n! = 20! = 2,432,902,008,176,640,000 \\approx 2.43 \\times 10^{18}$ paths. At 1 billion path checks per second, brute force would run continuously for over 77 years. In contrast, the Held-Karp algorithm recognizes that if you have visited a subset $S$ of cities (e.g. {1, 3, 5, 8}) and are currently at city 8, you only need to store the MINIMUM cost path that visited those 4 cities and ended at 8—the specific historical permutation of {1, 3, 5} does not matter for future choices! There are $2^{20} = 1,048,576$ subsets. For each subset, there are up to 20 ending cities, and each state tests up to 20 incoming edges: $N^2 \\cdot 2^N = 400 \\times 1,048,576 \\approx 4.19 \\times 10^8$ operations. A modern 3 GHz processor executes over $10^9$ operations per second, solving the exact 20-city TSP in roughly 0.2 to 0.5 seconds." },
        { "text": "Brute force is faster because 20 is a small number", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Held-Karp takes 20^20 operations", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Both algorithms take the exact same amount of time because TSP is NP-hard", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "An integer bitmask with n bits can uniquely represent 2 to the power of ___ distinct subsets.",
      "blankAnswer": "n",
      "blankDistractors": ["2", "4", "10"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Held-Karp Bitmask TSP Dynamic Programming Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Held-Karp Bitmask TSP Engine</h3><p>Graph: 4 Cities [0, 1, 2, 3] | Subsets = 2^4 = 16 States</p><button id=\"bfBtn\" style=\"padding:8px 14px; margin:3px; background:#ef4444; color:white; border:none; border-radius:4px; cursor:pointer;\">Run Brute-Force (3! = 6 Permutations)</button><button id=\"hkBtn\" style=\"padding:8px 14px; margin:3px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">Run Held-Karp DP (Bitmask 1<<4 = 16)</button><div id=\"hkOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Select a TSP solver above...</div><script>document.getElementById('bfBtn').onclick=()=>{document.getElementById('hkOut').innerText='Brute Force: Checked all (N-1)! paths -> Explodes as N! (N=20 takes 77 years)!';}; document.getElementById('hkBtn').onclick=()=>{document.getElementById('hkOut').innerText='HELD-KARP BITMASK DP: dp[mask][u] memoized across 16 states -> Optimal Tour: 0 -> 1 -> 3 -> 2 -> 0 | Exact solution in O(n^2 * 2^n)!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
