# Duofy Reusable Lesson Format: Ramsey Numbers and the Party Problem R(3,3) = 6

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Combinatorics_and_Counting / Ramsey_Theory`  
**Lesson Format Type:** `ramsey_numbers_and_party_problem`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the foundational principle of **Ramsey Theory** ("Complete disorder is impossible"), define the 2-color **Ramsey Number** $R(s, t)$, prove that **$R(3, 3) = 6$** (The Party Problem) using the **Pigeonhole Principle** on vertex degrees, and verify the $N=5$ counterexample ($C_5$ cycle graph with no monochromatic $K_3$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Ramsey Number Definition & Party Problem Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Pigeonhole Principle R(3,3) <= 6 Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Ramsey Graph Concept & Counterexample Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | C_5 2-Coloring Lower Bound R(3,3) > 5 Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Exact Value of Smallest Non-Trivial Ramsey Number Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of the Graph Ramsey Number $R(s, t)$: The smallest positive integer $N$ such that every 2-coloring (Red/Blue) of the edges of the complete graph $K_N$ is guaranteed to contain either a monochromatic Red complete subgraph $K_s$ or a monochromatic Blue complete subgraph $K_t$. State Theorem (The Party Problem): $R(3, 3) = 6$. In any gathering of 6 people, there are either 3 mutual acquaintances (Red $K_3$) or 3 mutual strangers (Blue $K_3$). State Trivial Values: $R(1, t) = 1$, $R(2, t) = t$, and Symmetry: $R(s, t) = R(t, s)$.
2. **Slide 2 (`ordering`):** Provide 5 steps proving $R(3, 3) \le 6$: (1) consider any 2-coloring of $K_6$ and pick an arbitrary vertex $v$, (2) vertex $v$ has 5 incident edges colored Red or Blue, (3) by the Pigeonhole Principle ($\lceil 5/2 \rceil = 3$), at least 3 edges incident to $v$ must share the same color (say Red), leading to neighbors $u_1, u_2, u_3$, (4) consider the 3 edges between $\{u_1, u_2, u_3\}$: if ANY edge $(u_i, u_j)$ is Red, then $\{v, u_i, u_j\}$ forms a Red $K_3$, (5) if NO edge is Red, then all 3 edges between $\{u_1, u_2, u_3\}$ are Blue, forming a Blue $K_3$; in all cases, a monochromatic $K_3$ exists!
3. **Slide 3 (`matching`):** Pair 4 Ramsey instances ($R(3, 3) = 6$, $R(3, 4) = 9$, $R(4, 4) = 18$, $R(5, 5)$ unknown exact [43-48]) with their combinatorial descriptions.
4. **Slide 4 (`proof`):** Interactive derivation establishing the lower bound $R(3, 3) > 5$: color the edges of $K_5$ by drawing a 5-cycle $C_5$ in Red (5 outer edges) and its interior chords / diagonals in Blue (another $C_5$); since $C_5$ contains no triangles, neither color contains a monochromatic $K_3$, proving $R(3, 3) \ge 6$.
5. **Slide 5 (`one_word`):** Plain-text recall of the exact integer value of $R(3, 3)$ (six).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ramsey_numbers_and_party_problem",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Graph Ramsey Numbers and the Party Problem**\n• **Ramsey Number $R(s, t)$ (Frank Ramsey, 1930):**\n  The smallest integer $N$ such that **every** 2-edge-coloring (Red/Blue) of the complete graph $K_N$ contains either:\n  - A **Red clique $K_s$**, OR\n  - A **Blue clique $K_t$**.\n• **The Party Problem Theorem:**\n$$\nR(3, 3) = 6\n$$\n  *(In any group of 6 people, there must exist at least 3 mutual acquaintances or 3 mutual strangers!).*\n• **Elementary Properties:**\n  - **Symmetry:** $R(s, t) = R(t, s)$.\n  - **Base Cases:** $R(2, t) = t, \\quad R(1, t) = 1$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps establishing that R(3,3) <= 6 using the Pigeonhole Principle.",
      "orderItems": [
        "Select an arbitrary vertex v in a 2-colored complete graph K_6",
        "Observe that vertex v has degree 5 (connected to 5 other vertices by Red or Blue edges)",
        "Apply the Pigeonhole Principle: at least ceil(5/2) = 3 incident edges must share the same color (assume Red, leading to neighbors u_1, u_2, u_3)",
        "Inspect the triangle formed by the three neighbors {u_1, u_2, u_3}: if ANY edge (u_i, u_j) is Red, then {v, u_i, u_j} forms a Red K_3",
        "If NONE of the edges between {u_1, u_2, u_3} are Red, then all three edges must be Blue, forming a Blue K_3, completing the proof"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Ramsey number to its exact value or status.",
      "matchPairs": [
        { "left": "R(3, 3)", "right": "6 (proven via Pigeonhole on K_6 with C_5 lower bound)" },
        { "left": "R(3, 4)", "right": "9 (Greenwood & Gleason, 1955)" },
        { "left": "R(4, 4)", "right": "18 (Evans, Pulleyblank & Wallis, 1979)" },
        { "left": "R(5, 5)", "right": "Unknown exact value! (Current proven bounds: 43 <= R(5,5) <= 48)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Lower Bound R(3, 3) > 5 via the Pentagonal 2-Coloring",
      "interactiveSteps": [
        {
          "stepText": "To prove R(3, 3) > 5, we must construct a 2-coloring of K_5 with ZERO monochromatic triangles."
        },
        {
          "prompt": "How are the 10 edges of K_5 partitioned into Red and Blue?",
          "options": [
            { "text": "Color the outer 5-cycle C_5 Red, and color the 5 internal diagonals (another C_5) Blue", "isCorrect": true },
            { "text": "Color all 10 edges Red", "isCorrect": false },
            { "text": "Color 9 edges Red and 1 Blue", "isCorrect": false },
            { "text": "Color edges randomly with equal probability", "isCorrect": false }
          ]
        },
        {
          "stepText": "Since a 5-cycle C_5 contains only cycles of length 5 (and no 3-cycles/triangles), neither the Red subgraph nor the Blue subgraph contains a K_3, proving R(3, 3) >= 6!"
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the exact integer value of the classical Ramsey number R(3, 3) (write as word six)?",
      "blankAnswer": "six"
    }
  ]
}
```
