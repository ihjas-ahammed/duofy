# Duofy Reusable Lesson Format: Vertex Cover to Set Cover and Hamiltonian TSP

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Complexity_Theory_and_NP_Completeness / Polynomial_Time_Reductions`  
**Lesson Format Type:** `vertex_cover_to_set_cover_and_hamiltonian_tsp`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid graph-to-set reduction, weighted metric embedding, and combinatorial equivalence mastery between classical NP-Complete problems (Richard M. Karp 1972; Michael Sipser; Thomas H. Cormen et al. CLRS Chapter 34): master the **$\text{Vertex Cover} \le_P \text{Set Cover}$ Reduction** (mapping graph edges $E$ to universe elements $U = E$, mapping each vertex $v \in V$ to subset $S_v = \{e \in E \mid v \in e\}$, and showing $G$ has a vertex cover of size $k \iff \mathcal{F}$ has a set cover of size $k$), master the **$\text{Hamiltonian Cycle} \le_P \text{TSP-Decision}$ Reduction** (constructing complete graph $G' = (V, E')$ with edge weights $w(u, v) = 1$ if $(u, v) \in E$ and $w(u, v) = 2$ if $(u, v) \notin E$, with cost threshold $B = |V|$), and interact with live reduction mapping simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Vertex Cover to Set Cover & Hamiltonian Cycle to TSP Reductions Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Source Problem Entity & Target Problem Gadget Mapping Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Construction of Complete Graph Edge Weights in Hamiltonian to TSP Reduction Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Name of the Universe in the Vertex Cover to Set Cover Reduction (Edges E) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Polynomial Reduction (VC to Set Cover & Ham to TSP) Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "vertex_cover_to_set_cover_and_hamiltonian_tsp",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do you reduce Vertex Cover to Set Cover and Hamiltonian Cycle to TSP-Decision in polynomial time?",
      "blankAnswer": "Combinatorial reductions (Richard Karp 1972; CLRS Chapter 34): (1) VERTEX COVER <=_P SET COVER: Given graph G = (V, E) and integer k: (a) Define Universe U = E (the set of all edges in G). (b) For each vertex v in V, define a subset S_v = {e in E | v is an endpoint of e}. (c) Set target k' = k. G has a vertex cover of size <= k iff collection {S_v} has a set cover of size <= k! (2) HAMILTONIAN CYCLE <=_P TSP-DECISION: Given graph G = (V, E) with n vertices: (a) Construct a complete graph G' = (V, E') with edge cost function w: w(u, v) = 1 if (u, v) is in E; w(u, v) = 2 if (u, v) is NOT in E. (b) Set budget threshold B = n. G has a Hamiltonian cycle iff G' has a TSP tour of total cost <= n (since visiting all n vertices using only original graph edges costs exactly 1 * n = n, while using even one non-edge costs >= n + 1)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each source problem element to its target reduction gadget counterpart.",
      "matchPairs": [
        { "left": "Graph Edges E (Vertex Cover)", "right": "Universe Elements U in the Set Cover instance (U = E)" },
        { "left": "Graph Vertex v (Vertex Cover)", "right": "Subset S_v containing all incident edges in the Set Cover collection" },
        { "left": "Original Edge in E (Hamiltonian)", "right": "Assigned an edge weight of w = 1 in the complete TSP distance matrix" },
        { "left": "Non-Edge not in E (Hamiltonian)", "right": "Assigned an edge penalty weight of w = 2 in the complete TSP distance matrix" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In the reduction from the Hamiltonian Cycle problem on graph G = (V, E) with n vertices to the Traveling Salesperson Decision Problem on complete graph G', why does choosing edge weights w(u, v) = 1 for original edges and w(u, v) = 2 for non-edges with budget B = n guarantee exact bidirectional equivalence?",
      "options": [
        { "text": "A valid TSP tour in G' must visit all n vertices in a closed loop containing exactly n edges; if G has a Hamiltonian cycle, following those exact edges yields a tour cost of n * 1 = n (which is <= B); whereas if G has no Hamiltonian cycle, any TSP tour in G' must use at least one non-edge of weight 2, forcing the total tour cost to be at least (n - 1)*1 + 1*2 = n + 1 > B", "isCorrect": true, "explanation": "Correct! This reduction demonstrates the elegance of metric embedding. A TSP tour on a complete graph with $n$ vertices must traverse exactly $n$ edges. If the original graph $G$ contains a Hamiltonian cycle, the salesperson simply follows that exact sequence of $n$ original edges. Since every original edge has cost $w = 1$, the total tour cost is $1 + 1 + \\dots + 1 = n \\le B$. Conversely, if $G$ does NOT contain a Hamiltonian cycle, it is impossible to form a closed tour of $n$ vertices using only original edges. Any valid TSP tour in the complete graph $G'$ must traverse at least one 'non-edge' (which was assigned penalty weight $w = 2$). The total cost of any such tour is at least $(n - 1) \\times 1 + 1 \\times 2 = n + 1$. Because $n + 1 > n$, the TSP decision instance outputs 'Yes' (cost $\\le n$) if and only if the original graph possesses a Hamiltonian cycle." },
        { "text": "Because TSP algorithms automatically delete all edges with weight 2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because all complete graphs have a total weight of 100", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Hamiltonian cycles can only exist on graphs where all edges have weight 2", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the polynomial reduction from Vertex Cover to Set Cover, the universe U of elements to be covered is the set of all graph ___ (U = E).",
      "blankAnswer": "edges",
      "blankDistractors": ["vertices", "cycles", "weights"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Polynomial Reduction (VC to Set Cover & Ham to TSP) Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Polynomial Reduction Engine</h3><p>Select Classic Reduction:</p><button id=\"vcBtn\" style=\"padding:8px 14px; margin:3px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">Vertex Cover <=_P Set Cover</button><button id=\"tspBtn\" style=\"padding:8px 14px; margin:3px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">Hamiltonian Cycle <=_P TSP</button><div id=\"redOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Select a reduction above...</div><script>document.getElementById('vcBtn').onclick=()=>{document.getElementById('redOut').innerText='VC -> Set Cover: Universe U = Edges E | Subsets S_v = {incident edges} | Target k = k | Equisatisfiable in O(|V|+|E|)!';}; document.getElementById('tspBtn').onclick=()=>{document.getElementById('redOut').innerText='Ham Cycle -> TSP: Complete G\' | Edge w=1 if in E, else w=2 | Budget B = n | Exact tour cost = n iff Ham Cycle exists!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
