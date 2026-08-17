# Duofy Reusable Lesson Format: Karp's 21 NP-Complete Problems (Clique and Vertex Cover)

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Complexity_Theory_and_NP_Completeness / P_NP_NP_Complete_and_NP_Hard`  
**Lesson Format Type:** `karps_21_np_complete_problems_and_clique_vertex_cover`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the combinatorial reductions, graph gadgets, and polynomial equivalence proofs of Richard Karp's landmark 21 NP-Complete problems (Richard M. Karp 1972, *Reducibility Among Combinatorial Problems*; Thomas H. Cormen et al. CLRS Chapter 34; Michael Sipser): trace the foundational reduction tree ($\text{SAT} \le_P \text{3-SAT} \le_P \text{Clique} \le_P \text{Vertex Cover} \le_P \text{Subset Sum} \dots$), master the **3-SAT to CLIQUE Reduction** (constructing a cluster of 3 vertices for each clause $(l_1 \lor l_2 \lor l_3)$ and connecting all compatible non-negated literals across different clause clusters to form a $k$-clique where $k = m$ clauses), prove the exact complement duality theorem (**Complement Graph Theorem: $S$ is an Independent Set of size $k$ in $G \iff S$ is a Clique of size $k$ in $\bar{G} \iff V \setminus S$ is a Vertex Cover of size $|V| - k$ in $G$**), and demonstrate NPC proofs.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Karp's 21 Tree, 3-SAT to Clique Gadget, & Complement Duality Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step 3-SAT to Clique Graph Construction Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Graph Problem Duality & Set Invariant Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Total Number of Problems Proven NP-Complete in Richard Karp's 1972 Landmark Paper Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Tripartite Graph Duality: Independent Set, Clique, and Vertex Cover Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Karp's 21 NP-Complete Problems (Karp 1972; CLRS):
   - **Karp's Reduction Tree (1972):**
     $$\mathbf{\text{SAT} \le_P \text{3-SAT} \le_P \text{Clique} \le_P \text{Vertex Cover} \le_P \text{Feedback Vertex Set} \le_P \dots}$$
   - **The 3-SAT to CLIQUE Reduction ($3\text{-SAT} \le_P \text{CLIQUE}$):**
     - Given 3-CNF formula $\phi = C_1 \land \dots \land C_k$ with $k$ clauses.
     - For each clause $C_r = (l_1^r \lor l_2^r \lor l_3^r)$, create a **triplet cluster of 3 vertices**.
     - Add edge $(u, v)$ between two vertices in DIFFERENT clusters if and only if **$u$ and $v$ are NOT contradictory literals** ($u \ne \neg v$).
     - **Theorem:** $\phi$ is satisfiable $\iff G$ has a **Clique of size $k$**!
   - **The Fundamental Tripartite Graph Complement Duality:**
     $$\mathbf{S \subseteq V \text{ is an Independent Set of size } k \text{ in } G \iff S \text{ is a Clique of size } k \text{ in } \bar{G}}$$
     $$\mathbf{S \subseteq V \text{ is an Independent Set in } G \iff V \setminus S \text{ is a Vertex Cover of size } |V| - k \text{ in } G}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of the 3-SAT to CLIQUE graph transformation: (1) receive a 3-CNF formula phi containing k disjunctive clauses with 3 literals each, (2) instantiate a cluster of 3 vertices for each of the k clauses (totaling 3k vertices in graph G), (3) draw undirected edges between any two vertices belonging to different clause clusters whose literal labels are consistent (not logical negations of each other), (4) leave all vertices in the same clause cluster disconnected from each other to enforce at most one selection per clause, (5) output the constructed graph G and target integer k, completing the polynomial-time reduction!
3. **Slide 3 (`matching`):** Pair 4 Karp NP-Complete problems (3-SAT, Clique, Vertex Cover, Hamiltonian Cycle) with their mathematical graph/logical definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Richard Karp proved 21 classic problems were NP-complete in his 1972 paper. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the exact mathematical duality connecting Independent Set and Vertex Cover in graph theory: If a graph $G = (V, E)$ has $|V| = 20$ vertices and contains a Maximum Independent Set of size $k = 13$, what is the exact size of the Minimum Vertex Cover of graph $G$? (The Minimum Vertex Cover has size $|V| - k = 20 - 13 = \mathbf{7}$; because a subset $S$ is an Independent Set if and only if its complement $V \setminus S$ covers every edge in $E$, **maximizing the independent set directly minimizes the vertex cover**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "karps_21_np_complete_problems_and_clique_vertex_cover",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Karp's 21 NP-Complete Problems (1972)**\n• **The 3-SAT to CLIQUE Reduction ($3\\text{-SAT} \\le_P \\text{CLIQUE}$):**\n  - Formula $\\phi = C_1 \\land \\dots \\land C_k$ ($k$ clauses).\n  - Create a **cluster of 3 vertices** for each clause $C_r = (l_1 \\lor l_2 \\lor l_3)$.\n  - Connect $(u, v)$ across different clusters $\\iff \\mathbf{u \\ne \\neg v}$ (Non-contradictory!).\n  - $\\mathbf{\\phi \\text{ Satisfiable} \\iff G \\text{ contains a Clique of size } k}$!\n• **The Master Graph Duality Theorem:**\n$$\n\\mathbf{S \\text{ is Independent Set in } G \\iff S \\text{ is Clique in } \\bar{G} \\iff V \\setminus S \\text{ is Vertex Cover in } G}\n$$\n• **Karp's Heritage:** Extended Cook's SAT to 21 diverse combinatorial domains!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of reducing an arbitrary 3-SAT formula phi into a CLIQUE graph instance.",
      "orderItems": [
        "Receive a 3-CNF formula phi with k clauses, each containing exactly 3 boolean literals",
        "Create a group of 3 vertices for each clause, labeling each node with its corresponding literal",
        "Place zero edges between vertices within the same clause group to prevent multiple selections per clause",
        "Draw an edge between every pair of vertices in different groups whose literal labels are non-contradictory (u != not v)",
        "Set target clique size k equal to the number of clauses, completing the reduction in polynomial time"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Karp NP-Complete problem to its exact combinatorial definition.",
      "matchPairs": [
        { "left": "3-SAT Problem", "right": "Determining if a boolean formula in 3-CNF form has a satisfying truth assignment" },
        { "left": "CLIQUE Problem", "right": "Finding a subset of k vertices such that all pairs are connected by an edge (complete subgraph)" },
        { "left": "Vertex Cover Problem", "right": "Finding a subset of k vertices that touches at least one endpoint of every edge in the graph" },
        { "left": "Independent Set Problem", "right": "Finding a subset of k vertices such that no two vertices in the set are joined by an edge" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In 1972, Richard Karp established the practical breadth of computational complexity by proving that ___ classic combinatorial problems were NP-Complete.",
      "blankAnswer": "21",
      "blankDistractors": ["7", "100", "5"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A graph G = (V, E) possesses |V| = 20 total vertices and is known to contain a Maximum Independent Set of size k = 13. What is the size of the Minimum Vertex Cover of graph G?",
      "options": [
        { "text": "The Minimum Vertex Cover has size |V| - k = 20 - 13 = 7 vertices; because a subset of vertices S is an Independent Set if and only if the complement set V \\ S forms a valid Vertex Cover containing at least one endpoint of every edge in E", "isCorrect": true, "explanation": "Correct! This is one of the most fundamental duality theorems in graph theory (Gallai's identity). Let $G = (V, E)$ be any graph, and let $S \\subseteq V$. By definition, $S$ is an Independent Set if and only if NO two vertices in $S$ share an edge (for all $(u, v) \\in E$, at most one of $u, v$ is in $S$). This statement is logically equivalent to saying that for EVERY edge $(u, v) \\in E$, at least one of $u$ or $v$ must lie OUTSIDE of $S$ (i.e. in the complement set $V \\setminus S$). By definition, a subset of vertices that contains at least one endpoint of every edge in $E$ is a Vertex Cover! Therefore, $S$ is an Independent Set in $G$ if and only if $V \\setminus S$ is a Vertex Cover in $G$. Since $|V \\setminus S| = |V| - |S|$, maximizing the size of the independent set ($|S| = 13$) mathematically minimizes the size of the vertex cover: $|V \\setminus S| = 20 - 13 = 7$." },
        { "text": "The Minimum Vertex Cover has size 13 vertices because it must match the independent set", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The Minimum Vertex Cover has size 260 vertices (20 * 13)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The Minimum Vertex Cover cannot be determined without knowing the edge weights", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
