# Duofy Reusable Lesson Format: Hopcroft-Tarjan Bridges and Articulation Points

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Graph_Algorithms_and_Network_Flow / Breadth_First_and_Depth_First_Search_BFS_DFS`  
**Lesson Format Type:** `hopcroft_tarjan_bridges_and_articulation_points`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid network vulnerability, 2-edge/vertex connectivity, and low-link recursion mastery across connected undirected graphs (John E. Hopcroft & Robert E. Tarjan 1973, *Algorithm 447: Efficient Algorithms for Graph Manipulation*; Thomas H. Cormen et al. CLRS Chapter 22): master the formal definitions of **Bridges (Cut Edges)** and **Articulation Points (Cut Vertices)** whose removal increases the number of connected components, formulate the **Entry Time ($\text{tin}[u]$)** and **Low-Link Metric ($\mathbf{\text{low}[u] = \min(\text{tin}[u], \ \text{low}[v], \ \text{tin}[p])}$)** representing the earliest discovery time reachable from $u$'s subtree via at most one back-edge, evaluate the **Bridge Condition ($\mathbf{\text{low}[v] > \text{tin}[u]}$)** and **Articulation Point Conditions** (**Root Condition: $\ge 2$ DFS tree children**; **Non-Root Condition: $\mathbf{\text{low}[v] \ge \text{tin}[u]}$**), and interact with live network cut-vertex and bridge simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hopcroft-Tarjan Bridge & Cut Vertex Conditions Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Graph Component / Connectivity Condition & Mathematical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Difference Between Bridge Condition (Strict >) and Articulation Condition (>=) Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Minimum Number of DFS Tree Children Making a Root Node an Articulation Point Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Bridge & Articulation Point Hopcroft-Tarjan Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hopcroft_tarjan_bridges_and_articulation_points",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are Bridges and Articulation Points, and what are Hopcroft-Tarjan's tin/low conditions?",
      "blankAnswer": "Network connectivity in undirected graphs (Hopcroft & Tarjan 1973; CLRS Chapter 22): (1) DEFINITIONS: (a) Bridge (Cut Edge): An edge whose removal disconnects the graph. (b) Articulation Point (Cut Vertex): A vertex whose removal disconnects the graph. (2) TIMESTAMPS: (a) tin[u]: Discovery time of vertex u in DFS. (b) low[u]: The earliest discovery time reachable from u's subtree via back-edges: low[u] = min(tin[u], min_tree(low[v]), min_back(tin[to])). (3) THE BRIDGE CONDITION: Edge (u, v) is a bridge IF AND ONLY IF: low[v] > tin[u] (meaning v's subtree has NO back-edge reaching u or any of u's ancestors)! (4) THE ARTICULATION POINT CONDITIONS: (a) Root Case: The DFS root is an articulation point iff it has >= 2 children in the DFS tree. (b) Non-Root Case: A non-root vertex u is an articulation point iff it has a child v with: low[v] >= tin[u] (meaning v cannot reach any strict ancestor of u without passing through u)! Linear time O(V + E)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Hopcroft-Tarjan connectivity metric to its exact mathematical role.",
      "matchPairs": [
        { "left": "Bridge Condition (low[v] > tin[u])", "right": "Strict inequality proving no back-edge exists from v's subtree to u or above" },
        { "left": "Articulation Condition (low[v] >= tin[u])", "right": "Condition proving child v has no back-edge escaping to any strict ancestor above u" },
        { "left": "DFS Root Articulation Rule", "right": "Root is an articulation point if and only if it possesses at least 2 disjoint DFS tree children" },
        { "left": "Low-Link low[u]", "right": "Earliest entry timestamp reachable from u's subtree via at most one back-edge" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the bridge condition a strict inequality (low[v] > tin[u]) while the articulation point condition is a non-strict inequality (low[v] >= tin[u]) for a tree edge (u, v)?",
      "options": [
        { "text": "If low[v] == tin[u], v's subtree has a back-edge that loops back directly to vertex u; this back-edge prevents edge (u, v) from being a bridge (since u and v remain connected via the back-edge loop), BUT removing vertex u itself destroys that connection point entirely, stranding v's subtree and making u an articulation point", "isCorrect": true, "explanation": "Correct! This is one of the most elegant conceptual distinctions in graph theory. Consider a simple triangle graph $A-B-C-A$. Let $A$ be the parent of $B$ in the DFS tree, and suppose $C$ (in $B$'s subtree) has a back-edge returning to $A$. Here, $\\text{low}[B] = \\text{tin}[A]$: 1. Is edge $(A, B)$ a bridge? No! If you delete edge $(A, B)$, $B$ can still reach $A$ via the path $B-C-A$. Thus, a bridge requires $\\mathbf{\\text{low}[v] > \\text{tin}[u]}$ (no back-edge even to $u$). 2. Is vertex $A$ an articulation point? Yes (if $A$ was an internal connector)! If you delete vertex $A$, both edge $(A, B)$ and the back-edge $(C, A)$ are destroyed simultaneously. $B$'s subtree has no path to any ancestor ABOVE $A$. Therefore, $\\mathbf{\\text{low}[v] \\ge \\text{tin}[u]}$ is sufficient to make $u$ an articulation point." },
        { "text": "Because bridges are edges and articulation points are vertices", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because computer compilers cannot evaluate strict inequality on edges", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because articulation points require O(V^3) time while bridges require O(1)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The root of a Depth-First Search tree is an articulation point if and only if it has at least ___ children in the DFS tree.",
      "blankAnswer": "2",
      "blankDistractors": ["1", "3", "0"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Hopcroft-Tarjan Bridge & Articulation Point Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Hopcroft-Tarjan Connectivity Engine</h3><p>Graph: (1-2, 2-3, 3-1 [Triangle]) connected to (3-4-5 [Line])</p><button id=\"findBridge\" style=\"padding:8px 14px; margin:3px; background:#ef4444; color:white; border:none; border-radius:4px; cursor:pointer;\">Find Bridges (low[v] > tin[u])</button><button id=\"findCut\" style=\"padding:8px 14px; margin:3px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">Find Articulation Points (low[v] >= tin[u])</button><div id=\"htOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Select an analysis tool above...</div><script>document.getElementById('findBridge').onclick=()=>{document.getElementById('htOut').innerText='BRIDGES FOUND: (3-4) and (4-5)! Deleting (3-4) disconnects the triangle from the tail!';}; document.getElementById('findCut').onclick=()=>{document.getElementById('htOut').innerText='ARTICULATION POINTS FOUND: Node 3 and Node 4! Deleting Node 3 isolates the triangle {1,2} from {4,5}!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
