# Duofy Reusable Lesson Format: Bland's Anti-Cycling Rule and Degeneracy

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Linear_and_Nonlinear_Programming / Simplex_Method`  
**Lesson Format Type:** `blands_anti_cycling_rule_and_degeneracy`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to analyze **Degeneracy** in Linear Programs ($(x_B)_i = 0$), understand the danger of infinite **Cycling** on degenerate vertices, execute **Bland's Smallest-Subscript Anti-Cycling Rule** (Robert Bland, 1977), and prove finite termination.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Degeneracy, Cycling, & Bland's Rule Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Bland's Rule Execution Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Simplex Pivot Rule & Theoretical Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Degenerate Step Size Value Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Klee-Minty Cube Exponential Complexity Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of Degeneracy: A BFS is degenerate if one or more basic variables equal zero ($(x_B)_i = 0$). In degenerate pivots, the minimum ratio test yields $\theta^* = 0$, causing basis change without moving in physical space ($\Delta z = 0$). If multiple degenerate pivots occur, the Simplex algorithm can return to a previously visited basis, entering an infinite loop (**Cycling**). State Bland's Rule (1977): (1) Entering variable: $j = \min\{k \mid \bar{c}_k < 0\}$ (smallest index with negative reduced cost), (2) Leaving variable: in case of ties in $\theta^*$, choose $l = \min\{i \in \text{argmin}_{i} \frac{(x_B)_i}{d_i}\}$ (smallest index). State Theorem: Under Bland's rule, cycling is impossible, and Simplex terminates in finitely many steps.
2. **Slide 2 (`concept_pieces`):** Deconstruct: (1) why cycling occurs (Beale's 1955 cycling example: 6 pivots return to identical basis with zero progress), (2) how Bland's rule breaks cycles (a variable cannot enter and leave the basis repeatedly without forcing a strictly positive step on the highest-indexed cycle variable, which contradicts degeneracy), (3) Lexicographic pivoting alternative (perturbing RHS vector $b(\epsilon) = b + \sum \epsilon^i e_i$).
3. **Slide 3 (`matching`):** Pair 4 pivot rules (Dantzig's Rule / Largest Reduction, Bland's Rule / Smallest Subscript, Steepest Edge Rule, Lexicographic Rule) with their performance properties.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in a degenerate pivot where a basic variable is zero in the numerator of the ratio test, the step size theta is zero. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the worst-case complexity of the Simplex algorithm: On the Klee-Minty deformed hypercube (1972), how many iterations does Dantzig's standard Simplex rule take to solve an $n$-variable LP? (Exponential $2^n - 1$ iterations, visiting all $2^n$ vertices before reaching the optimum, despite Simplex being highly efficient in practice).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "blands_anti_cycling_rule_and_degeneracy",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Degeneracy, Cycling, and Bland's Anti-Cycling Rule**\n• **Degenerate BFS:** A basic feasible solution where at least one basic variable is zero: $(x_B)_i = 0$.\n• **Degenerate Pivot:** When $(x_B)_i = 0$, the minimum ratio test gives step length $\\theta^* = 0$. The basis changes, but the solution point $\\mathbf{x}$ and objective $z$ remain completely unchanged!\n• **The Danger of Cycling:** A sequence of degenerate pivots can visit a cyclic sequence of bases $B_1 \\to B_2 \\to \\dots \\to B_1$, causing the algorithm to loop infinitely.\n• **Bland's Rule (Robert Bland, 1977):**\n  1. **Entering Variable:** Select $j = \\min \\{k \\mid \\bar{c}_k < 0\\}$ (smallest variable index with negative reduced cost).\n  2. **Leaving Variable:** If ties occur in $\\theta^*$, select $l = \\min \\{i \\mid i \\text{ achieves } \\min \\frac{(x_B)_i}{d_i}\\}$.\n• **Theorem:** The Simplex method equipped with Bland's rule is **guaranteed never to cycle** and terminates in finitely many pivots."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Detect Degeneracy):** Identify $(x_B)_i = 0$ in the current basic variable vector.\n• **Step 2 (Scan Candidates):** Identify all candidate entering columns with $\\bar{c}_k < 0$.\n• **Step 3 (Apply Smallest Index):** Rather than picking the most negative reduced cost, strictly select the candidate $j$ with the minimum numerical subscript.\n• **Step 4 (Tie-Break Exits):** In the ratio test $\\theta^* = 0$, multiple basic indices tie. Select the leaving variable $x_l$ having the lowest index $l$.\n• **Step 5 (Finiteness Proof):** By tracking the highest-index variable involved in any potential cycle, Bland proved that a contradiction arises in sign matching of the dual vector, strictly precluding repetition."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Simplex pivot selection rule to its theoretical property.",
      "matchPairs": [
        { "left": "Dantzig's Original Rule", "right": "Picks most negative reduced cost (fast in practice, but vulnerable to cycling on degenerate LPs)" },
        { "left": "Bland's Smallest-Subscript Rule", "right": "Picks lowest index (theoretically immune to cycling; guarantees finite termination)" },
        { "left": "Lexicographic Pivoting Rule", "right": "Perturbs RHS vector by powers of epsilon to strictly eliminate all degenerate ties" },
        { "left": "Steepest Edge Rule", "right": "Normalizes reduced cost by Euclidean norm of direction vector (modern solver default)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a degenerate Simplex pivot where the numerator of the minimum ratio test is zero, the resulting step length theta* is exactly ___.",
      "blankAnswer": "zero",
      "blankDistractors": ["one", "infinity", "negative"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "On the famous Klee-Minty 'squashed hypercube' problem (1972), what is the worst-case number of iterations required by Dantzig's Simplex algorithm on an n-dimensional polytope?",
      "options": [
        { "text": "Exponential 2^n - 1 iterations (the algorithm visits all 2^n vertices of the hypercube before finding the global minimum)", "isCorrect": true, "explanation": "Correct! Victor Klee and George Minty constructed a perturbed n-cube where Dantzig's pivot rule follows a Hamiltonian path through every single vertex, proving Simplex has worst-case exponential complexity." },
        { "text": "Linear n iterations", "isCorrect": false, "explanation": "Incorrect: Simplex is average-case polynomial but worst-case exponential." },
        { "text": "Logarithmic log(n) iterations", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Exactly 1 iteration", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
