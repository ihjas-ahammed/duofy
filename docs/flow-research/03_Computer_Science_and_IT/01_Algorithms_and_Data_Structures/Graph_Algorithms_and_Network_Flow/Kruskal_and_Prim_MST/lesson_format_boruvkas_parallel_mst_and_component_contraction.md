# Duofy Reusable Lesson Format: Borůvka's Parallel MST and Component Contraction

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Graph_Algorithms_and_Network_Flow / Kruskal_and_Prim_MST`  
**Lesson Format Type:** `boruvkas_parallel_mst_and_component_contraction`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid parallel graph contraction, multi-component greedy cuts, and distributed Minimum Spanning Tree mastery (Otakar Borůvka 1926, *O jistém problému minimálním*; Georges Sollin 1965; Thomas H. Cormen et al. CLRS Chapter 23): master the **Parallel Component Invariant** (in each round, every connected component simultaneously finds and selects its cheapest outgoing edge across the component cut boundary), prove that each phase reduces the number of connected components by at least half ($C_{k+1} \le C_k / 2 \implies \le \lceil \log_2 V \rceil$ total phases), evaluate the resulting **$O(E\log V)$ runtime**, analyze why Borůvka's algorithm is naturally suited for SIMD GPU parallelism and distributed cluster processing (MapReduce / Pregel), and interact with live parallel MST contraction engines.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Borůvka's Parallel Contraction Phases & O(E log V) Runtime Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | MST Algorithm Family & Core Structural Philosophy Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Component Halving Invariant and Total Round Count Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Year Otakar Borůvka Published the First Minimum Spanning Tree Algorithm Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Borůvka Parallel Component Contraction Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "boruvkas_parallel_mst_and_component_contraction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Borůvka's algorithm and why is it ideal for parallel/distributed Minimum Spanning Tree computation?",
      "blankAnswer": "Parallel Minimum Spanning Tree computation (Otakar Borůvka 1926; Sollin 1965): (1) THE PARALLEL CUT MECHANISM: Unlike Prim (1 growing tree) or Kruskal (1 edge at a time), Borůvka's algorithm processes ALL connected components simultaneously in parallel phases! (2) THE PHASE EXECUTION: (a) Start with V isolated components (each vertex is its own component). (b) In each round, every component simultaneously identifies the minimum-weight edge connecting it to a different component. (c) All chosen minimum edges are added to the MST, and the connected components are contracted/merged into super-nodes! (3) THE HALVING PRINCIPLE: In each round, every component merges with at least one other component, cutting the total number of components by AT LEAST HALF (C_{k+1} <= C_k / 2). (4) TOTAL RUNTIME: The algorithm terminates in at most ceil(log2 V) phases. Scanning all E edges takes O(E) per phase, yielding a total time of O(E log V)! (5) DISTRIBUTED POWER: Because each component's cheapest edge search is completely independent, Borůvka is the primary MST algorithm used in GPU parallel computing and distributed frameworks (MapReduce / Pregel)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each classic Minimum Spanning Tree algorithm to its fundamental operational paradigm.",
      "matchPairs": [
        { "left": "Borůvka's Algorithm (1926)", "right": "Parallel contraction algorithm where all components simultaneously select cheapest incident edges" },
        { "left": "Kruskal's Algorithm (1956)", "right": "Global edge-centric greedy approach sorting all edges and validating acyclicity via DSU" },
        { "left": "Prim-Jarník Algorithm (1930/1957)", "right": "Vertex-centric tree-growing approach expanding a single connected component via priority queues" },
        { "left": "The Halving Invariant (C / 2)", "right": "Guarantees Borůvka terminates in at most ceil(log2 V) total contraction rounds" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In a graph with |V| = 64 vertices and |E| = 500 edges, what is the maximum possible number of contraction phases Borůvka's algorithm will execute before completing the Minimum Spanning Tree?",
      "options": [
        { "text": "At most 6 phases (ceil(log2 64) = 6); because each phase guarantees that every active component merges with at least one other component, reducing the total component count by at least half in every single round (64 -> 32 -> 16 -> 8 -> 4 -> 2 -> 1)", "isCorrect": true, "explanation": "Correct! In Borůvka's algorithm, during each round, every active component $C_i$ independently chooses its cheapest outgoing edge. Because every component selects at least one edge, every component participates in at least one merge. The absolute worst case occurs when components pair up in pairs (e.g. 2 components merge into 1). Even in this worst case, the number of components is strictly divided by 2: $C_{k+1} \\le C_k / 2$. Starting with $|V| = 64$ components: Round 1 reduces to $\\le 32$; Round 2 reduces to $\\le 16$; Round 3 reduces to $\\le 8$; Round 4 reduces to $\\le 4$; Round 5 reduces to $\\le 2$; Round 6 reduces to $\\le 1$ (the single unified Minimum Spanning Tree!). In general, the maximum number of rounds is strictly bounded by $\\lceil \\log_2 |V| \\rceil = \\lceil \\log_2 64 \\rceil = 6$ phases." },
        { "text": "64 phases because each phase only processes 1 vertex", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "500 phases because it must check all 500 edges one by one", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Borůvka's algorithm takes an infinite number of phases on graphs with 64 vertices", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Otakar Borůvka published the very first Minimum Spanning Tree algorithm in history in the year ___ to design an efficient electrical power network in Moravia.",
      "blankAnswer": "1926",
      "blankDistractors": ["1956", "1972", "1980"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Borůvka Parallel Component Contraction Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Borůvka Parallel MST Contraction Engine</h3><p>Initial State: 4 Isolated Components {A}, {B}, {C}, {D}</p><p>Edges: (A-B: 2), (B-C: 4), (C-D: 1), (A-D: 7), (A-C: 3)</p><button id=\"phase1\" style=\"padding:8px 14px; margin:3px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">Run Phase 1 (Parallel Min Edge Selection)</button><button id=\"phase2\" style=\"padding:8px 14px; margin:3px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">Run Phase 2 (Merge Remaining Components)</button><div id=\"borOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Click Phase 1 to begin parallel contraction...</div><script>document.getElementById('phase1').onclick=()=>{document.getElementById('borOut').innerText='PHASE 1: (A picks A-B:2), (B picks A-B:2), (C picks C-D:1), (D picks C-D:1)\n• Added Edges: (A-B) and (C-D)!\n• Components halved from 4 to 2: {A, B} and {C, D}!';}; document.getElementById('phase2').onclick=()=>{document.getElementById('borOut').innerText='PHASE 2: Super-node {A,B} and Super-node {C,D} both select bridge (A-C: 3)\n• Added Edge: (A-C: 3)!\n• Final Component: {A, B, C, D} (MST Complete in 2 phases, Weight = 6)!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
