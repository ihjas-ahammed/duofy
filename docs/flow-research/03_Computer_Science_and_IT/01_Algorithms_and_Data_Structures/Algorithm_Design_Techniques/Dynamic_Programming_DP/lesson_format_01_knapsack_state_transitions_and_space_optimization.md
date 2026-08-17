# Duofy Reusable Lesson Format: 0/1 Knapsack (State Transitions and Space Optimization)

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Algorithm_Design_Techniques / Dynamic_Programming_DP`  
**Lesson Format Type:** `01_knapsack_state_transitions_and_space_optimization`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the state-space formulation, optimal substructure transitions, and 1D memory array compression of the pseudo-polynomial 0/1 Knapsack Dynamic Programming algorithm (Richard Bellman 1957; Thomas H. Cormen et al. CLRS): master the **2D DP Recurrence ($\mathbf{dp[i][w] = \max(dp[i-1][w], \ dp[i-1][w-w_i] + v_i)}$)** representing the binary decision (exclude item $i$ vs include item $i$), analyze the pseudo-polynomial complexity ($O(N \cdot W)$ time and $O(N \cdot W)$ space), formulate the **1D Rolling Array Space Optimization ($\mathbf{dp[w] = \max(dp[w], \ dp[w-w_i] + v_i)}$)**, rigorously prove why the inner capacity loop **MUST iterate strictly backwards ($w = W \to w_i$)** to prevent reusing the same item multiple times (which would turn it into Unbounded Knapsack), and reconstruct the optimal item subset via backwards table backtracking.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | 0/1 Knapsack 2D Recurrence & The 1D Backward Loop Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step 1D DP Array Initialization and Backward Transition Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Knapsack DP Term / State Variable & Algorithmic Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Direction the Inner Loop Must Run in 1D 0/1 Knapsack Space Optimization Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Algorithmic Consequence of Iterating the Inner Loop Forward in 1D DP Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State 0/1 Knapsack DP & Space Optimization (Bellman 1957; CLRS):
   - **The 2D Dynamic Programming Formulation:**
     - Let $dp[i][w]$ = Maximum value using a subset of the first $i$ items with total weight $\le w$.
     - **The Recurrence Relation:**
       $$\mathbf{dp[i][w] = \begin{cases} dp[i-1][w] & \text{if } w_i > w \ (\text{Cannot fit}) \\ \max\Big(\underbrace{dp[i-1][w]}_{\text{Exclude item } i}, \ \underbrace{dp[i-1][w-w_i] + v_i}_{\text{Include item } i}\Big) & \text{if } w_i \le w \end{cases}}$$
   - **The 1D Space Optimization Miracle ($O(N \cdot W) \to O(W)$ Memory):**
     - Notice that row $i$ depends **ONLY on the previous row $i-1$**.
     - Drop the first dimension: $\mathbf{dp[w] = \max(dp[w], \ dp[w - w_i] + v_i)}$.
     - **CRITICAL INVARIANT:** The inner loop **MUST ITERATE BACKWARDS** from $w = W$ down to $w_i$:
       $$\mathbf{\text{for } w = W \text{ down to } w_i: \quad dp[w] = \max(dp[w], \ dp[w-w_i] + v_i)}$$
       *(Iterating backwards guarantees that $dp[w-w_i]$ comes from the PREVIOUS item iteration, preventing multiple inclusions!)*.
2. **Slide 2 (`ordering`):** Provide 5 steps of executing the 1D space-optimized 0/1 Knapsack algorithm: (1) allocate a 1D integer array dp of size W+1 initialized with zeros (base case representing zero items), (2) start an outer loop iterating through each item i from 1 to N, (3) start an inner loop iterating capacity w backwards from maximum capacity W down to current item weight w_i, (4) update each cell dp[w] with max(dp[w], dp[w - w_i] + v_i) using values from the previous item's state, (5) after processing all N items, return dp[W] as the globally optimal maximum knapsack value!
3. **Slide 3 (`matching`):** Pair 4 0/1 Knapsack concepts (dp[i][w] State, 1D Array Optimization, Backward Iteration w=W->w_i, Forward Iteration w=w_i->W) with their algorithmic functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in 1D space-optimized 0/1 knapsack, the inner capacity loop must iterate backward. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the exact bug that occurs if the inner capacity loop is accidentally written in forward order ($w = w_i \to W$): If a programmer accidentally writes the inner loop of a 1D space-optimized Knapsack solver in forward ascending order (`for w in range(w_i, W + 1)`), what algorithmic problem does the code actually solve instead of 0/1 Knapsack? (It solves the **Unbounded (Complete) Knapsack Problem**; because updating $dp[w]$ forward immediately overwrites the array with the current item's choice, subsequent higher capacities $w' > w$ will read the already-updated value, **allowing the same item $i$ to be selected multiple times**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "01_knapsack_state_transitions_and_space_optimization",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: 0/1 Knapsack & 1D Space Optimization**\n• **The Standard 2D Recurrence ($O(N \\cdot W)$ Space):**\n$$\n\\mathbf{dp[i][w] = \\max\\Big(\\underbrace{dp[i-1][w]}_{\\text{Exclude item } i}, \\ \\underbrace{dp[i-1][w-w_i] + v_i}_{\\text{Include item } i}\\Big) \\quad (w \\ge w_i)}\n$$\n• **The 1D Rolling Space Optimization ($O(W)$ Space):**\n  - Row $i$ depends **ONLY on row $i-1$** $\\implies$ Drop the item dimension!\n  - **The Golden Rule:** The capacity loop **MUST RUN BACKWARDS** ($w = W \\to w_i$):\n$$\n\\mathbf{\\text{for } w = W \\text{ down to } w_i: \\quad dp[w] = \\max(dp[w], \\ dp[w - w_i] + v_i)}\n$$\n  - **Why Backwards?** Ensures $dp[w - w_i]$ represents the state **before** item $i$ was considered, enforcing the $0/1$ single-use constraint!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential algorithmic steps of the 1D space-optimized 0/1 Knapsack dynamic programming solver.",
      "orderItems": [
        "Allocate a 1D integer array dp of size W + 1 initialized with all zeros (representing base case)",
        "Iterate an outer loop through each item i from index 1 to N with weight w_i and value v_i",
        "Iterate an inner loop running backwards from maximum knapsack capacity W down to item weight w_i",
        "Compute dp[w] = max(dp[w], dp[w - w_i] + v_i) to update the maximum achievable value at capacity w",
        "Terminate both loops and return dp[W] as the globally optimal integer knapsack value"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Knapsack DP formulation to its exact computational property.",
      "matchPairs": [
        { "left": "2D Array dp[i][w]", "right": "Classic DP state matrix consuming O(N * W) space and O(N * W) time" },
        { "left": "1D Array Space Optimization", "right": "Memory reduction storing only the current capacity array consuming O(W) space" },
        { "left": "Backward Loop (w = W -> w_i)", "right": "Traversal order guaranteeing each item is included at most ONCE (0/1 constraint)" },
        { "left": "Forward Loop (w = w_i -> W)", "right": "Traversal order allowing items to be reused infinitely (Unbounded Knapsack)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In 1D space-optimized 0/1 Knapsack dynamic programming, the inner capacity loop must strictly iterate in the ___ direction.",
      "blankAnswer": "backward",
      "blankDistractors": ["forward", "random", "diagonal"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What happens if a software engineer accidentally writes the inner loop of a 1D space-optimized knapsack solver in ascending forward order ('for w from w_i up to W') instead of backward order?",
      "options": [
        { "text": "The algorithm accidentally solves the Unbounded (Complete) Knapsack problem instead of 0/1 Knapsack; updating smaller capacities first causes dp[w - w_i] to already contain item i, allowing the exact same item i to be included multiple times (up to W / w_i times) within a single knapsack packing", "isCorrect": true, "explanation": "Correct! This is one of the classic pitfalls in Dynamic Programming. In 0/1 Knapsack, every item can be picked at most ONCE ($x_i \\in \\{0, 1\\}$). In the 2D formulation $dp[i][w] = \\max(dp[i-1][w], dp[i-1][w-w_i] + v_i)$, the state $dp[i-1][w-w_i]$ explicitly looks at row $i-1$ (the state before item $i$ was considered). When we compress this into a single 1D array $dp[w]$, running the loop BACKWARD from $W$ down to $w_i$ ensures that when we compute $dp[w] = \\max(dp[w], dp[w-w_i] + v_i)$, the value sitting at $dp[w-w_i]$ is still pristine from the PREVIOUS item $(i-1)$. However, if you iterate FORWARD from $w_i$ up to $W$, $dp[w-w_i]$ has already been updated in the current iteration of item $i$. When you reach a larger capacity $w = 2 w_i$, the formula $dp[2w_i] = \\max(dp[2w_i], dp[w_i] + v_i)$ uses the newly updated $dp[w_i]$ (which already contains item $i$), effectively adding item $i$ a second time! This forward loop perfectly implements the Unbounded Knapsack problem (infinite copies of each item available)." },
        { "text": "The program will crash with an out-of-bounds memory error", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The array will fill with negative infinity at all indices", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The runtime complexity increases from O(N*W) to O(2^N)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
