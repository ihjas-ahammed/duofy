# Duofy Reusable Lesson Format: Fibonacci Heaps and Lazy Decrease-Key

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Linear_and_Nonlinear_Data_Structures / Heaps_and_Priority_Queues`  
**Lesson Format Type:** `fibonacci_heaps_and_lazy_decrease_key`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the lazy forest architecture, cascading cuts, and amortized potential analysis of Fibonacci Heaps (Michael L. Fredman & Robert E. Tarjan 1987, *Fibonacci Heaps and Their Uses in Improved Network Optimization Algorithms*; Thomas H. Cormen et al. CLRS Chapter 19): master the **Lazy Forest Representation** (collection of min-heap-ordered trees linked in a circular doubly linked root list), analyze the **Cascading Cut Protocol** for `DECREASE-KEY` (if a node's key decreases below its parent, cut it and move it to the root list; if its parent was already marked, cut the parent too, cascading upward until an unmarked ancestor is reached), prove using the **Potential Function $\mathbf{\Phi(H) = t(H) + 2m(H)}$** that `INSERT`, `UNION`, and `DECREASE-KEY` execute in strictly **$\mathbf{O(1)\text{ Amortized Time}}$**, while `EXTRACT-MIN` executes tree consolidation in **$O(\log n)$ Amortized Time**, and evaluate why Fibonacci heaps enable the theoretical optimum runtimes for Dijkstra ($O(E + V\log V)$) and Prim ($O(E + V\log V)$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fibonacci Heap Lazy Philosophy, Cascading Cuts, & Potential Function Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Fibonacci Heap Decrease-Key and Cascading Cut Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Heap Operation & Amortized vs Worst-Case Time Complexity Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Amortized Time Complexity of the DECREASE-KEY Operation in a Fibonacci Heap (O(1)) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Proof Why Potential Function Phi = t(H) + 2m(H) Pays for Cascading Cuts Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Fibonacci Heaps (Fredman & Tarjan 1987; CLRS Chapter 19):
   - **The Lazy Design Philosophy:**
     - Postpone all expensive structural reorganization (consolidation) until `EXTRACT-MIN` is called!
     - `INSERT` & `UNION`: Just add new 1-node tree to the circular root list in $O(1)$ actual time.
   - **The Cascading Cut Protocol for `DECREASE-KEY(H, x, k)`:**
     - Decrease $x.\text{key} = k$. If $x.\text{key} < x.\text{parent}.\text{key}$:
       1. `CUT(H, x, parent)`: Detach $x$ from parent, add to root list, unmark $x$.
       2. `CASCADING-CUT(H, parent)`: If parent is unmarked, mark it. If parent is already marked, cut parent to root list and recurse on grandparent!
   - **Amortized Analysis via Potential Function:**
     $$\mathbf{\Phi(H) = t(H) + 2m(H)}$$
     - Where $t(H) = \text{number of trees in root list}$, $m(H) = \text{number of marked nodes}$.
   - **Amortized Complexity Master Table:**
     $$\mathbf{\text{INSERT}: O(1) \quad | \quad \text{UNION}: O(1) \quad | \quad \mathbf{\text{DECREASE-KEY}: O(1)} \quad | \quad \text{EXTRACT-MIN}: O(\log n)}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of the DECREASE-KEY operation with cascading cuts: (1) assign new smaller key value k to target node x, (2) check if x violates heap order with parent p (x.key < p.key), (3) if violated, cut node x from parent p, add x to the circular root list, and clear x's mark to false, (4) check parent p: if p is not in the root list and was unmarked, set p.mark = true and stop, (5) if parent p was already marked true, cut p to the root list, clear its mark, and recursively invoke cascading cut on grandparent!
3. **Slide 3 (`matching`):** Pair 4 Fibonacci heap operations (INSERT O(1) amortized, DECREASE-KEY O(1) amortized, EXTRACT-MIN O(log n) amortized, Potential Phi = t + 2m) with their functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that DECREASE-KEY runs in amortized O(1) time in a Fibonacci heap. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the amortized cost proof of cascading cuts: In a Fibonacci heap, if a `DECREASE-KEY` operation triggers a cascading chain of $c$ cuts, why is the amortized cost still $O(1)$ rather than $O(c)$? (Because the actual work is $O(c)$, but each of the $c-1$ marked parent nodes cut to the root list **loses its mark (decreasing $m(H)$ by $c-1$) and becomes a tree (increasing $t(H)$ by $c$)**; the change in potential is $\Delta\Phi = \Delta t + 2\Delta m = c - 2(c-1) = -c + 2$, which **releases enough stored potential credits to cancel out the $+O(c)$ actual work**, leaving an amortized cost of $O(1)$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "fibonacci_heaps_and_lazy_decrease_key",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Fibonacci Heaps & Lazy Amortization (1987)**\n• **The Lazy Philosophy:** Postpone all tree consolidation until `EXTRACT-MIN`!\n• **The Potential Function (CLRS Chapter 19):**\n$$\n\\mathbf{\\Phi(H) = t(H) + 2 \\cdot m(H) \\qquad (t = \\text{trees in root list}, \\ m = \\text{marked nodes})}\n$$\n• **Cascading Cut Protocol for `DECREASE-KEY`:**\n  - If $x.\\text{key} < x.\\text{parent}.\\text{key}$, cut $x$ to root list.\n  - If parent is **already marked** $\\implies$ **Cut parent to root list and cascade upward!**\n• **Amortized Operation Complexities:**\n$$\n\\mathbf{\\text{INSERT}: O(1) \\qquad \\text{UNION}: O(1) \\qquad \\mathbf{\\text{DECREASE-KEY}: O(1)} \\qquad \\text{EXTRACT-MIN}: O(\\log n)}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of executing DECREASE-KEY with cascading cuts in a Fibonacci Heap.",
      "orderItems": [
        "Assign the new smaller key value k to target node x, updating x.key = k",
        "Check if x.key is smaller than parent p.key; if not, terminate operation immediately",
        "Cut node x from parent p, insert x into the circular root list, and clear x.mark = false",
        "Inspect parent p: if p is not a root and p.mark is false, set p.mark = true and stop",
        "If parent p was already marked true, cut p to the root list and recursively trigger cascading cut on grandparent"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Fibonacci Heap operation to its exact amortized asymptotic performance.",
      "matchPairs": [
        { "left": "DECREASE-KEY Operation", "right": "O(1) amortized time leveraging cascading cuts and potential credit release" },
        { "left": "INSERT and UNION Operations", "right": "O(1) amortized time simply prepending new node/tree into circular root list" },
        { "left": "EXTRACT-MIN Operation", "right": "O(log n) amortized time executing lazy degree consolidation across all root trees" },
        { "left": "Potential Function: t(H) + 2*m(H)", "right": "Accounting metric tracking stored energy from root tree count and marked nodes" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a Fibonacci Heap, decreasing the priority key of a node executes in ___ O(1) time.",
      "blankAnswer": "amortized",
      "blankDistractors": ["worst-case", "linear", "logarithmic"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a Fibonacci Heap, if a single DECREASE-KEY operation triggers a cascading chain of c consecutive cuts (taking O(c) actual time), why is the amortized time complexity still mathematically bounded by O(1)?",
      "options": [
        { "text": "The actual work is c cuts, but each of the c - 1 intermediate marked parents loses its mark (decreasing m(H) by c - 1) and becomes a root tree (increasing t(H) by c); the change in potential is Delta Phi = Delta t + 2*Delta m = c - 2*(c - 1) = -c + 2; the released negative potential (-c) perfectly cancels the actual work (+c), leaving an amortized cost of O(1)", "isCorrect": true, "explanation": "Correct! This is the classic potential method proof designed by Fredman and Tarjan in 1987 (CLRS Chapter 19). In a Fibonacci heap, the potential function is defined as $\\Phi(H) = t(H) + 2m(H)$, where $t(H)$ is the number of trees in the root list and $m(H)$ is the number of marked nodes (nodes that have lost exactly 1 child). When `DECREASE-KEY` triggers a cascading cut of length $c$: 1. Actual Work: We perform $c$ cuts (the original node plus $c-1$ cascading ancestor cuts), which costs $O(c)$ actual time. 2. Change in Trees ($\\Delta t$): We add $c$ new trees to the root list, so $\\Delta t = +c$. 3. Change in Marks ($\\Delta m$): Each of the $c-1$ cascading parents was previously marked (`mark = true`) and is now unmarked upon becoming a root. At most the final ancestor becomes marked. Therefore, $\\Delta m \\le -(c - 1) + 1 = -c + 2$. 4. Total Change in Potential ($\\Delta \\Phi$): $\\Delta \\Phi = \\Delta t + 2 \\Delta m \\le c + 2(-c + 2) = c - 2c + 4 = -c + 4$. 5. Amortized Cost: $\\hat{C} = \\text{Actual Work} + \\Delta \\Phi = O(c) + (-c + 4) = O(1)$! The potential that was banked when nodes were originally marked pays for the entire cascading cleanup." },
        { "text": "Because cascading cuts only happen once in the lifetime of the universe", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Fibonacci heaps run on separate GPU threads", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the number of cuts c is always equal to 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
