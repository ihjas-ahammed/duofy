# Duofy Reusable Lesson Format: Maximum Bipartite Matching (Flow Reductions)

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Graph_Algorithms_and_Network_Flow / Ford_Fulkerson_and_Max_Flow_Min_Cut`  
**Lesson Format Type:** `maximum_bipartite_matching_flow_reductions`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid combinatorial reduction, network transformation, and polynomial matching mastery across unweighted bipartite graphs (Dénes Kőnig 1931; Jack Edmonds 1965; John E. Hopcroft & Richard M. Karp 1973; Thomas H. Cormen et al. CLRS Chapter 26): master the reduction from **Maximum Bipartite Matching (MBM)** on $G = (L \cup R, E)$ to an **$s-t$ Flow Network $G'$** (introducing super-source $s$ with directed edges to all $u \in L$ of capacity 1, orienting all bipartite edges from $L \to R$ with capacity 1, and connecting all $v \in R$ to super-sink $t$ with directed edges of capacity 1), prove the **Integrality Theorem** (if capacities are integers, the maximum flow $f^*$ is integer-valued $\implies f(u, v) \in \{0, 1\}$, where saturated edges form an optimal maximum matching), analyze **Kőnig's Min Vertex Cover Theorem ($\mathbf{\text{Max Matching} = \text{Min Vertex Cover}}$)**, and interact with live bipartite matching network flow simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Maximum Bipartite Matching to Max-Flow Reduction Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Bipartite Reduction Component / Theorem & Mathematical Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Proof of Matching Disjointness via Capacity 1 and Flow Conservation Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Name of the Famous 1973 Hopcroft-___ Algorithm for O(E sqrt(V)) Matching Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Maximum Bipartite Matching Flow Reduction Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "maximum_bipartite_matching_flow_reductions",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do you reduce Maximum Bipartite Matching to a Max-Flow problem and why is it guaranteed to be integer-valued?",
      "blankAnswer": "Combinatorial reductions and matching theory (Kőnig 1931; Hopcroft & Karp 1973; CLRS Chapter 26): (1) THE NETWORK TRANSFORMATION: Given bipartite graph G = (L union R, E): (a) Add super-source s with directed edges (s, u) of capacity c = 1 for all u in L. (b) Orient all bipartite edges (u, v) in E from L to R with capacity c = 1 (or inf). (c) Add super-sink t with directed edges (v, t) of capacity c = 1 for all v in R. (2) INTEGRALITY THEOREM: If all capacities in a flow network are integers, there exists a maximum flow f* where EVERY edge flow f(u, v) is an integer! Since all capacities are 1, f(u, v) is strictly in {0, 1}. (3) 1-TO-1 MATCHING CORRESPONDENCE: Flow conservation at u in L ensures at most 1 unit enters u from s, so at most one outgoing edge from u to R can carry flow! Likewise, flow conservation at v in R ensures at most 1 unit departs to t, so at most one incoming edge from L can carry flow! Thus, the set of edges M = {(u, v) | f(u, v) = 1} forms a VALID MATCHING of size equal to |f*|! (4) KŐNIG'S THEOREM (1931): In ANY bipartite graph, Maximum Matching Size == Minimum Vertex Cover Size!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each bipartite matching reduction entity to its exact network flow role.",
      "matchPairs": [
        { "left": "Super-Source Edge (s, u in L)", "right": "Directed edge of capacity 1 enforcing that each left node is matched at most ONCE" },
        { "left": "Super-Sink Edge (v in R, t)", "right": "Directed edge of capacity 1 enforcing that each right node is matched at most ONCE" },
        { "left": "Integrality Theorem", "right": "Guarantees that optimal flow values are binary {0, 1} rather than fractional numbers" },
        { "left": "Kőnig's Theorem (1931)", "right": "Proves that in bipartite graphs, Maximum Matching equals Minimum Vertex Cover" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does setting capacity c(s, u) = 1 for all left nodes u in L and capacity c(v, t) = 1 for all right nodes v in R mathematically guarantee that the set of edges carrying 1 unit of flow forms a valid matching (where no two edges share a vertex)?",
      "options": [
        { "text": "By flow conservation, total flow entering node u from source s is at most c(s, u) = 1, forcing at most one outgoing edge from u to carry flow (preventing u from being matched twice); similarly, total flow leaving node v to sink t is at most c(v, t) = 1, forcing at most one incoming edge to v to carry flow (preventing v from being matched twice)", "isCorrect": true, "explanation": "Correct! This is the exact mathematical proof of the reduction's validity (CLRS Lemma 26.9). A matching $M \\subseteq E$ is defined as a subset of edges such that no two edges share a common vertex (each vertex has degree $\\le 1$ in $M$). In our constructed flow network $G'$: 1. For any left vertex $u \\in L$, the ONLY incoming edge is $(s, u)$ with capacity $c(s, u) = 1$. By the capacity constraint and integrality, $f(s, u) \\in \\{0, 1\\}$. By flow conservation, the sum of outgoing flows from $u$ into the right partition $R$ must equal $f(s, u) \\le 1$. Therefore, AT MOST ONE edge originating from $u$ can have flow $f(u, v) = 1$. 2. For any right vertex $v \\in R$, the ONLY outgoing edge is $(v, t)$ with capacity $c(v, t) = 1$. By flow conservation, the sum of incoming flows from $L$ into $v$ must equal $f(v, t) \\le 1$. Therefore, AT MOST ONE edge entering $v$ can have flow $f(u, v) = 1$. Consequently, no two edges carrying flow $f(u, v) = 1$ can ever share a vertex in $L$ or $R$, proving that the set of saturated edges forms a valid independent matching of size exactly equal to the total flow value $|f^*|$." },
        { "text": "Because all bipartite graphs are completely disconnected", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because flow networks automatically delete shared vertices", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because computers cannot process matching problems with more than 1 edge", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The famous Hopcroft-___ algorithm solves Maximum Bipartite Matching in O(E * sqrt(V)) time by implementing Dinic's blocking flow principle.",
      "blankAnswer": "Karp",
      "blankDistractors": ["Tarjan", "Dijkstra", "Fulkerson"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Maximum Bipartite Matching Flow Reduction Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Bipartite Matching to Max-Flow Engine</h3><p>Bipartite Graph: Left {L1, L2, L3} <-> Right {R1, R2, R3}</p><p>Edges: (L1-R1), (L1-R2), (L2-R2), (L3-R2), (L3-R3)</p><button id=\"runFlowMatch\" style=\"padding:8px 14px; margin:3px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">Run Max-Flow Reduction (Source s -> L, R -> Sink t)</button><div id=\"matchOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Click button above to solve matching...</div><script>document.getElementById('runFlowMatch').onclick=()=>{document.getElementById('matchOut').innerText='MAX FLOW COMPUTED: |f*| = 3!\nMatched Pairs:\n• L1 <-> R1 (Flow = 1)\n• L2 <-> R2 (Flow = 1)\n• L3 <-> R3 (Flow = 1)\nMaximum Matching Size = 3 (Perfect Matching)! Kőnig Min-Cover = 3!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
