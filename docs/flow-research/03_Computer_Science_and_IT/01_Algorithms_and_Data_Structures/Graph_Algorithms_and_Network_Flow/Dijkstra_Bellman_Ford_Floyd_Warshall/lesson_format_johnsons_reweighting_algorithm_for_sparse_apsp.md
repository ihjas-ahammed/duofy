# Duofy Reusable Lesson Format: Johnson's Reweighting Algorithm for Sparse APSP

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Graph_Algorithms_and_Network_Flow / Dijkstra_Bellman_Ford_Floyd_Warshall`  
**Lesson Format Type:** `johnsons_reweighting_algorithm_for_sparse_apsp`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid potential-energy reweighting, sparse graph optimization, and hybrid all-pairs shortest path mastery across arbitrary-weighted graphs (Donald B. Johnson 1977; Thomas H. Cormen et al. CLRS Chapter 25): master the **Potential Reweighting Formula ($\mathbf{\hat{w}(u, v) = w(u, v) + h(u) - h(v)}$)**, prove by telescoping cancellation that reweighting preserves the exact shortest path ordering between all vertex pairs ($\hat{w}(p) = w(p) + h(v_0) - h(v_k)$), construct the **Auxiliary Graph $G'$** with zero-weight super-source $s$ and apply **Bellman-Ford** to derive non-negative edge potentials ($h(v) = \delta(s, v) \implies \mathbf{\hat{w}(u, v) \ge 0}$ via the Triangle Inequality), evaluate the asymptotic speedup to **$\mathbf{O(V^2 \log V + VE)}$** (substantially outperforming Floyd-Warshall's $O(V^3)$ on sparse graphs), and interact with live Johnson reweighting simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Johnson Reweighting Formula, Potential Transformation, & Sparse APSP Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Johnson Algorithm Component / Step & Mathematical Operation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Proof of Non-Negativity via Triangle Inequality and Telescoping Cancellation Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Single-Source Shortest Path Algorithm Used in Step 1 of Johnson's Algorithm Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Johnson's Potential Reweighting & Sparse APSP Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "johnsons_reweighting_algorithm_for_sparse_apsp",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Johnson's algorithm and how does potential reweighting solve APSP on sparse graphs in O(V^2 log V + VE)?",
      "blankAnswer": "All-Pairs Shortest Paths on sparse graphs with negative weights (Donald B. Johnson 1977; CLRS Chapter 25): (1) THE CORE IDEA: Floyd-Warshall runs in O(V^3), which is slow for sparse graphs where E << V^2. If edge weights were all non-negative (w >= 0), we could run Dijkstra V times in O(V * E log V) = O(V E log V)! Johnson transforms any graph with negative edges into an equivalent graph with ONLY NON-NEGATIVE EDGES using potential reweighting! (2) THE REWEIGHTING FORMULA: (a) Add super-source s with 0-weight edges to all v. (b) Run Bellman-Ford from s in O(VE) to find vertex potentials h(v) = delta(s, v). (c) Define new edge weights: w_hat(u, v) = w(u, v) + h(u) - h(v). (3) NON-NEGATIVITY GUARANTEE: By the triangle inequality (h(v) <= h(u) + w(u, v)), we have: w_hat(u, v) >= 0 for ALL edges! (4) TELESCOPING PATH PRESERVATION: For any path p from u to v, w_hat(p) = w(p) + h(u) - h(v). The potential difference depends ONLY on endpoints u and v, so the shortest path in the reweighted graph is IDENTICAL to the shortest path in original G! (5) EXECUTION: Run Dijkstra V times using w_hat, then recover true distances: d(u, v) = d_hat(u, v) - h(u) + h(v) in total O(V^2 log V + VE) time!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each phase of Johnson's algorithm to its exact mathematical execution.",
      "matchPairs": [
        { "left": "Super-Source s Insertion", "right": "Adds a temporary node connected to all V vertices with zero-weight directed edges (w(s, v) = 0)" },
        { "left": "Bellman-Ford Phase", "right": "Computes vertex potentials h(v) = delta(s, v) and detects negative cycles in O(V * E) time" },
        { "left": "Edge Reweighting Formula", "right": "Transforms edge costs to w_hat(u, v) = w(u, v) + h(u) - h(v) >= 0 ensuring all weights are non-negative" },
        { "left": "V Dijkstra Invocations", "right": "Executes Dijkstra from every vertex in O(V * E log V) time on the non-negative reweighted graph" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does adding a constant potential difference h(u) - h(v) to each edge (u, v) preserve the exact shortest path between any two vertices u and v?",
      "options": [
        { "text": "Along any path from u to v consisting of edges (v0, v1), (v1, v2)... (vk-1, vk), the intermediate potential terms h(v1), h(v2)... telescope and cancel out completely; the total reweighted path cost becomes w_hat(p) = w(p) + h(u) - h(v), shifting the cost of ALL candidate paths between u and v by the exact same constant difference (h(u) - h(v)) and leaving their relative ordering and minimum path unchanged", "isCorrect": true, "explanation": "Correct! This is the telescoping sum property that makes potential theory valid in computer science (CLRS Lemma 25.1). Consider any path $p = \\langle v_0, v_1, v_2, \\dots, v_k \\rangle$ from vertex $u = v_0$ to vertex $v = v_k$. The reweighted cost of path $p$ is the sum of its reweighted edges: $\\hat{w}(p) = \\sum_{i=1}^k \\hat{w}(v_{i-1}, v_i) = \\sum_{i=1}^k [w(v_{i-1}, v_i) + h(v_{i-1}) - h(v_i)]$. Expanding this summation: $\\hat{w}(p) = [w(v_0, v_1) + h(v_0) - h(v_1)] + [w(v_1, v_2) + h(v_1) - h(v_2)] + \\dots + [w(v_{k-1}, v_k) + h(v_{k-1}) - h(v_k)]$. Notice that every intermediate potential term $+h(v_i)$ is immediately cancelled by $-h(v_i)$ from the next term! The entire sum telescopes down to: $\\hat{w}(p) = \\sum w(v_{i-1}, v_i) + h(v_0) - h(v_k) = w(p) + h(u) - h(v)$. Because $h(u) - h(v)$ is a fixed constant that depends ONLY on the start and end nodes ($u$ and $v$), EVERY single path between $u$ and $v$ has its weight increased by the EXACT same amount. Therefore, whichever path had the minimum weight under $w$ still has the minimum weight under $\\hat{w}$." },
        { "text": "Because potential functions multiply all edge lengths by zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because negative edges turn into positive numbers when multiplied by -1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because all graphs with potentials form trees", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Johnson's APSP algorithm, the preliminary algorithm used to compute vertex potentials h(v) on the auxiliary graph is ___.",
      "blankAnswer": "Bellman-Ford",
      "blankDistractors": ["Dijkstra", "Kruskal", "Prim"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Johnson's Potential Reweighting & Sparse APSP Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Johnson's Potential Reweighting Engine</h3><p>Original Graph: Edge (A -> B, w = -2), (B -> C, w = 4), (A -> C, w = 3)</p><button id=\"runBF\" style=\"padding:8px 14px; margin:3px; background:#ef4444; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Run Bellman-Ford (Compute Potentials h)</button><button id=\"runReweight\" style=\"padding:8px 14px; margin:3px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Reweight: w_hat = w + h(u) - h(v)</button><div id=\"johnOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Select an execution step above...</div><script>document.getElementById('runBF').onclick=()=>{document.getElementById('johnOut').innerText='BELLMAN-FORD POTENTIALS: h(A) = 0 | h(B) = -2 | h(C) = 2 (Triangle Inequality satisfied)!';}; document.getElementById('runReweight').onclick=()=>{document.getElementById('johnOut').innerText='REWEIGHTED EDGES (w_hat >= 0):\n• (A->B): -2 + 0 - (-2) = 0 (NON-NEGATIVE!)\n• (B->C): 4 + (-2) - 2 = 0 (NON-NEGATIVE!)\n• (A->C): 3 + 0 - 2 = 1 (NON-NEGATIVE!)\nDijkstra can now run safely from all nodes!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
