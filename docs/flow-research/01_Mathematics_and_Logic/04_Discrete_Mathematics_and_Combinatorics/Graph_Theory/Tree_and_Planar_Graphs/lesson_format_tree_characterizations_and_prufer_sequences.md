# Duofy Reusable Lesson Format: Tree Characterizations and Prüfer Sequences

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Graph_Theory / Tree_and_Planar_Graphs`  
**Lesson Format Type:** `tree_characterizations_and_prufer_sequences`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the 6 equivalent characterizations of **Trees**, execute the **Prüfer Sequence Encoding Algorithm** (Heinz Prüfer, 1918) mapping labelled trees on $n$ vertices to sequences of length $n-2$, execute the inverse decoding algorithm, and prove that a vertex of degree $d_v$ appears exactly $d_v - 1$ times in its Prüfer code.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Tree Characterizations & Prüfer Bijection Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Prüfer Encoding Algorithm Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Graph Property & Tree Characterization Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical Prüfer Sequence Length for 6-Vertex Tree | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Vertex Degree Frequency in Prüfer Sequence Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the 6 Equivalent Definitions of a Tree $T = (V, E)$ on $n$ vertices: (1) $T$ is connected and acyclic, (2) $T$ is connected and has $|E| = n - 1$, (3) $T$ is acyclic and has $|E| = n - 1$, (4) $T$ has a unique simple path between every pair of vertices, (5) $T$ is minimally connected (removing any edge disconnects it), (6) $T$ is maximally acyclic (adding any edge creates a unique cycle). State the Prüfer Theorem (1918): There is a constructive bijection between labelled trees on $\{1, 2, \dots, n\}$ and sequences $(s_1, \dots, s_{n-2}) \in \{1, 2, \dots, n\}^{n-2}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct Prüfer encoding for tree with edges $\{(1, 4), (2, 4), (3, 4), (4, 5)\}$ on $n=5$ vertices: (1) find leaves (degree 1 vertices): $\{1, 2, 3, 5\}$, (2) smallest leaf is $1$; record its neighbor $4$, remove leaf $1$: remaining tree has edges $\{(2,4), (3,4), (4,5)\}$, (3) smallest remaining leaf is $2$; record neighbor $4$, remove leaf $2$: remaining tree has edges $\{(3,4), (4,5)\}$, (4) smallest remaining leaf is $3$; record neighbor $4$, remove leaf $3$: remaining tree has single edge $(4, 5)$ on 2 vertices, (5) stop when 2 vertices remain! Resulting Prüfer sequence is $(4, 4, 4)$ of length $5-2 = 3$.
3. **Slide 3 (`matching`):** Pair 4 tree concepts (Leaf, Bridge / Cut-Edge, Spanning Forest, Star Graph $K_{1, n-1}$) with their structural graph properties.
4. **Slide 4 (`numerical`):** Ask student: For a labelled tree with $n = 6$ vertices, what is the exact length $n - 2$ of its corresponding Prüfer sequence? (numeric answer: 4).
5. **Slide 5 (`quiz`):** Quiz on degree decoding in Prüfer sequences: If vertex $v$ has degree $d(v)$ in a labelled tree $T$ on $n$ vertices, how many times does label $v$ appear in the Prüfer sequence of $T$? (Exactly $d(v) - 1$ times; a leaf with $d(v) = 1$ appears $0$ times, whereas an internal hub with degree $d(v)$ appears $d(v) - 1$ times before becoming a leaf itself).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "tree_characterizations_and_prufer_sequences",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Tree Characterizations and Prüfer Sequences**\n• **Equivalent Definitions of a Tree $T$ on $n$ vertices:**\n  1. $T$ is **connected and acyclic**.\n  2. $T$ is connected and has exactly **$n - 1$ edges**.\n  3. $T$ is acyclic and has exactly **$n - 1$ edges**.\n  4. There is a **unique simple path** between every pair of vertices.\n  5. $T$ is **minimally connected** (every edge is a bridge/cut-edge).\n  6. $T$ is **maximally acyclic** (adding any edge creates a unique cycle).\n• **Prüfer's Bijection Theorem (Heinz Prüfer, 1918):**\n  There is an explicit 1-to-1 bijection:\n$$\n\\{\\text{Labelled Trees on } n \\text{ vertices}\\} \\longleftrightarrow \\{1, 2, \\dots, n\\}^{n - 2}\n$$\n• **Degree-Frequency Formula:** Vertex $v$ appears in the Prüfer code exactly **$\\deg(v) - 1$ times**."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Find Smallest Leaf):** In tree on $n=5$ with edges $(1,4), (2,4), (3,4), (4,5)$, leaves are $\\{1, 2, 3, 5\\}$. Smallest leaf is **1**.\n• **Step 2 (Record & Delete 1):** Record neighbor **4**. Remove leaf 1. Code: `[4]`.\n• **Step 3 (Record & Delete 2):** Smallest leaf is **2**. Record neighbor **4**. Remove leaf 2. Code: `[4, 4]`.\n• **Step 4 (Record & Delete 3):** Smallest leaf is **3**. Record neighbor **4**. Remove leaf 3. Code: `[4, 4, 4]`.\n• **Step 5 (Stop at 2 Vertices):** Remaining edge is $(4, 5)$. Algorithm halts, producing sequence `(4, 4, 4)` of length $n-2 = 3$!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each tree concept to its structural property.",
      "matchPairs": [
        { "left": "Leaf Vertex", "right": "Vertex of degree exactly 1 (appears 0 times in Prüfer sequence)" },
        { "left": "Bridge / Cut-Edge", "right": "An edge whose deletion increases the number of connected components" },
        { "left": "Center of a Tree", "right": "Contains either 1 vertex or 2 adjacent vertices minimizing eccentricity" },
        { "left": "Star Graph K_{1, n-1}", "right": "Prüfer code consists of the center hub label repeated n-2 times" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the length of the Prüfer sequence for a labelled tree with n = 6 vertices: length = n - 2.",
      "numericAnswer": 4,
      "numericTolerance": 0
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a labelled tree on n vertices, if vertex v has degree deg(v) = k, how many times does label v appear in the Prüfer sequence?",
      "options": [
        { "text": "EXACTLY k - 1 times (each time an adjacent leaf is removed, v's degree drops by 1; when deg(v) reaches 1, v becomes a leaf and is never recorded again)", "isCorrect": true, "explanation": "Correct! A leaf (degree 1) appears 1 - 1 = 0 times. An internal vertex with degree k is recorded as a neighbor k - 1 times before it is reduced to a leaf." },
        { "text": "k times", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "k + 1 times", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "k / 2 times", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
