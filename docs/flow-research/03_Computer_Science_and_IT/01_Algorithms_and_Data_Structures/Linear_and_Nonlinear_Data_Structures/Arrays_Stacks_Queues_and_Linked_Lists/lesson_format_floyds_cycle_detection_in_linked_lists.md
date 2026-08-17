# Duofy Reusable Lesson Format: Floyd's Cycle Detection in Linked Lists

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Linear_and_Nonlinear_Data_Structures / Arrays_Stacks_Queues_and_Linked_Lists`  
**Lesson Format Type:** `floyds_cycle_detection_in_linked_lists`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the pointer mathematics, relative speed gaps, and modular arithmetic of Floyd's Cycle-Finding Algorithm (The Tortoise and Hare) in linked lists (Robert W. Floyd 1967; Donald Knuth TAOCP Vol 2; Thomas H. Cormen et al. CLRS): master the **Two-Pointer Traversal System ($\mathbf{\text{slow} = \text{slow.next}, \ \text{fast} = \text{fast.next.next}}$)**, prove why the fast pointer is mathematically guaranteed to collide with the slow pointer inside a cycle without skipping past it (the distance between them shrinks by exactly 1 node per iteration modulo cycle length $C$), formulate the **Cycle Start Identification Proof** (let $L$ be distance from head to cycle entrance, $k$ be distance from entrance to collision point; prove $L \equiv C - k \pmod C \implies$ **resetting $\text{slow} = \text{head}$ and advancing both by 1 step finds the exact entry node in $O(N)$ time and $O(1)$ space**), and contrast against memory-heavy hash set lookups.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Floyd's Two-Pointer Mechanics, Collision Invariant, & Cycle Entry Math Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Floyd's Cycle Detection and Entry Point Discovery Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Pointer State / Mathematical Variable & Structural Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Memory Space Complexity of Floyd's Cycle Detection Algorithm (O(1)) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Proof Why Resetting Slow to Head Identifies the Exact Cycle Entrance Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Floyd's Cycle-Finding Algorithm (Floyd 1967; Knuth):
   - **The Two-Pointer Mechanism:**
     - Slow Pointer ($\text{slow}$): advances **1 node/step**.
     - Fast Pointer ($\text{fast}$): advances **2 nodes/step**.
   - **Phase 1: Detecting Cycle Presence:**
     - Inside a cycle of length $C$, the relative distance between $\text{fast}$ and $\text{slow}$ increases by $2 - 1 = 1$ node per step.
     - By modular arithmetic, the gap must reach $0 \pmod C \implies \mathbf{\text{slow} == \text{fast} \text{ within } C \text{ steps}}$!
   - **Phase 2: Locating Cycle Entrance:**
     - Let $L = \text{distance from head to cycle start}$, $C = \text{cycle length}$, $k = \text{distance from cycle start to collision}$.
     - Distance traveled by slow: $d_s = L + k$.
     - Distance traveled by fast: $d_f = 2(L + k) = L + nC + k \implies \mathbf{L = nC - k = (n-1)C + (C - k)}$.
     - **The Reset Rule:** Reset $\text{slow} = \text{head}$; advance BOTH $\text{slow}$ and $\text{fast}$ by **1 step at a time** $\implies$ **They meet EXACTLY at the cycle entrance!**
   - **Complexity:** $\mathbf{O(N)\text{ Time}}$ and $\mathbf{O(1)\text{ Auxiliary Space}}$!
2. **Slide 2 (`ordering`):** Provide 5 steps of finding the cycle entrance with Floyd's algorithm: (1) initialize two pointers slow and fast pointing to the head node of the linked list, (2) advance slow by 1 step and fast by 2 steps in a loop until fast becomes null (no cycle) or slow equals fast (cycle detected), (3) keep fast at the collision node and reset slow to point back to the head of the linked list, (4) advance both slow and fast pointer by exactly 1 step simultaneously, (5) when slow equals fast again, output their meeting node as the exact entry point of the cycle!
3. **Slide 3 (`matching`):** Pair 4 Floyd concepts (slow pointer 1-step, fast pointer 2-step, distance L = (n-1)C + (C-k), O(1) Space) with their mathematical functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Floyd's cycle detection algorithm requires only O(1) auxiliary space. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the algebraic proof of why advancing both pointers at speed 1 from head and collision point finds the cycle entrance: What algebraic relation mathematically proves that when $\text{slow}$ is reset to $\text{head}$ and both pointers move at speed 1, they will meet at the cycle entrance? (Because when they collided, slow traveled $L + k$ and fast traveled $2(L + k) = L + k + nC$, proving that **$L = nC - k$**; moving $L$ steps from the head reaches the entrance, and moving $L$ steps from the collision point is equivalent to **moving $nC - k$ steps (which loops around the cycle $n$ times minus $k$, placing fast exactly at the cycle entrance)**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "floyds_cycle_detection_in_linked_lists",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Floyd's Cycle-Finding Algorithm (1967)**\n• **Phase 1: Collision Detection (Speed Gap = 1):**\n$$\n\\mathbf{\\text{slow} = \\text{slow.next} \\ (1 \\text{ step}) \\qquad \\text{fast} = \\text{fast.next.next} \\ (2 \\text{ steps})}\n$$\n  - Inside cycle of length $C$, gap closes by 1 node/step $\\implies$ **Guaranteed collision in $\\le C$ steps!**\n• **Phase 2: Finding Cycle Entrance ($L = nC - k$):**\n$$\n\\mathbf{d_s = L + k \\ ; \\quad d_f = 2(L + k) = L + nC + k \\implies \\mathbf{L = (n-1)C + (C - k)}}\n$$\n• **The Reset Rule:** Reset $\\text{slow} = \\text{head}$, move both at **speed 1** $\\implies$ **Meet at cycle entrance in $O(N)$ time and $O(1)$ space!**"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of Floyd's Tortoise and Hare algorithm to detect and locate the start of a linked list cycle.",
      "orderItems": [
        "Initialize slow and fast pointers to the head node of the linked list",
        "Traverse the list advancing slow by 1 node and fast by 2 nodes until they collide or reach a null pointer",
        "Upon collision, keep fast at the meeting node and reset slow back to the head of the linked list",
        "Advance both slow and fast pointers forward by exactly 1 node per step simultaneously",
        "Terminate when slow and fast meet again, returning their current position as the exact cycle entrance node"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each component of Floyd's Cycle Detection algorithm to its exact role.",
      "matchPairs": [
        { "left": "Slow Pointer (1 Step)", "right": "Advances one node per iteration to guarantee that the fast pointer cannot jump over it without colliding" },
        { "left": "Fast Pointer (2 Steps)", "right": "Advances two nodes per iteration, creating a relative closing speed of exactly 1 node per step inside cycle" },
        { "left": "Equation L = nC - k", "right": "Proves distance from head to entrance equals distance from collision point to entrance along the cycle" },
        { "left": "O(1) Space Complexity", "right": "Executes cycle detection using only two pointers without allocating memory for a visited hash set" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Floyd's Tortoise and Hare cycle detection algorithm detects loops using only two pointers, requiring O(___) auxiliary memory space.",
      "blankAnswer": "1",
      "blankDistractors": ["N", "log N", "N^2"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What algebraic equation proves that after slow and fast collide, resetting slow to head and moving both at speed 1 guarantees they will meet at the cycle entrance?",
      "options": [
        { "text": "Let L be head-to-entrance distance and k be entrance-to-collision distance; slow traveled L + k and fast traveled 2(L + k) = L + k + nC, yielding L = nC - k; advancing slow L steps from head brings it to the entrance, while advancing fast L steps from the collision point moves it nC - k steps forward (n full loops minus k), landing fast at the exact same entrance node", "isCorrect": true, "explanation": "Correct! This is the formal algebraic proof of Floyd's cycle start algorithm. Let: $L = \\text{number of edges from list head to the first node of the cycle}$. $C = \\text{number of edges in the cycle}$. $k = \\text{number of edges from cycle entrance to the collision point}$. When $\\text{slow}$ and $\\text{fast}$ collide inside the cycle: 1. $\\text{slow}$ has traveled a total distance $d_s = L + k$. 2. $\\text{fast}$ has traveled $d_f = L + k + nC$ (where $n \\ge 1$ is the number of full cycle loops completed by fast). Because $\\text{fast}$ moves twice as fast as $\\text{slow}$, we have $d_f = 2 \\cdot d_s$: $L + k + nC = 2(L + k) \\implies L + k + nC = 2L + 2k \\implies L = nC - k$. Rewriting this expression: $L = (n - 1)C + (C - k)$. What does this mean geometrically? $(C - k)$ is the remaining distance from the collision point to the end of the cycle (the entrance). If you move $L$ steps from the head, you reach the cycle entrance. If you move $L$ steps starting from the collision point, you will complete $(n - 1)$ full loops around the cycle and travel the remaining $(C - k)$ steps to the entrance! Therefore, when both pointers move at speed 1, they will collide after exactly $L$ steps at the exact cycle entry node." },
        { "text": "Because fast pointer moves at the speed of light in computer RAM", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because all cycles have exactly 2 nodes", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because linked lists reverse their direction when fast reaches null", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
