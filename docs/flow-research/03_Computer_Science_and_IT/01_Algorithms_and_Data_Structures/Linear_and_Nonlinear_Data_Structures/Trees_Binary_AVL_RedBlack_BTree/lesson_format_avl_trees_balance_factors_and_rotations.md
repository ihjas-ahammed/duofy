# Duofy Reusable Lesson Format: AVL Trees (Balance Factors and Rotations)

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Linear_and_Nonlinear_Data_Structures / Trees_Binary_AVL_RedBlack_BTree`  
**Lesson Format Type:** `avl_trees_balance_factors_and_rotations`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the strict height-balancing invariants, balance factors, and 4 corrective rotation algorithms of AVL Trees (Georgy Adelson-Velsky & Evgenii Landis 1962; Thomas H. Cormen et al. CLRS Chapter 13): master the **Balance Factor Definition ($\mathbf{\text{BF}(u) = \text{height}(\text{left}) - \text{height}(\text{right}) \in \{-1, 0, +1\}}$)**, prove the **Fibonacci Minimal-Node Recurrence ($N(h) = N(h-1) + N(h-2) + 1 \implies \mathbf{h < 1.44 \log_2(n+2)}$)**, formulate the **4 Fundamental Tree Rotations** (**1. Left-Left (LL) Imbalance: single Right Rotation on critical node**, **2. Right-Right (RR) Imbalance: single Left Rotation on critical node**, **3. Left-Right (LR) Imbalance: Left Rotate child $\to$ Right Rotate critical node**, and **4. Right-Left (RL) Imbalance: Right Rotate child $\to$ Left Rotate critical node**), and analyze why AVL trees provide strictly faster lookup than Red-Black trees at the cost of more frequent rebalancing rotations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | AVL Balance Factor Invariant, Height Bound h < 1.44 log n, & 4 Rotations Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step LR (Left-Right) Double Rotation Execution Sequence Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | AVL Imbalance Type & Corrective Rotation Algorithm Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Allowed Set of Values for Balance Factor BF(u) in a Valid AVL Tree Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Reason AVL Trees Require Double Rotations for LR and RL Imbalances Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State AVL Trees & Rotations (Adelson-Velsky & Landis 1962; CLRS):
   - **The Strict Balance Factor Invariant:**
     $$\mathbf{\text{BF}(u) = \text{height}(\text{left\_child}) - \text{height}(\text{right\_child}) \in \{-1, 0, +1\}}$$
     - An imbalance occurs whenever $|\text{BF}(u)| \ge 2$.
   - **The Strict Height Bound:**
     - Let $N(h)$ be the minimum number of nodes in an AVL tree of height $h$:
       $$N(h) = N(h-1) + N(h-2) + 1 \implies \mathbf{h < 1.4404 \log_2(n + 2) - 0.328} \implies \mathbf{O(\log n)\text{ Worst-Case Search!}}$$
   - **The 4 Imbalance Cases & Corrective Rotations:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Imbalance Case} & \textbf{Node BF} & \textbf{Child BF} & \textbf{Corrective Action} \\
     \hline
     \mathbf{\text{Left-Left (LL)}} & +2 & +1 \text{ or } 0 & \mathbf{\text{Single RIGHT Rotation}(u)} \\
     \mathbf{\text{Right-Right (RR)}} & -2 & -1 \text{ or } 0 & \mathbf{\text{Single LEFT Rotation}(u)} \\
     \mathbf{\text{Left-Right (LR)}} & +2 & -1 & \mathbf{\text{LEFT-Rotate}(\text{left}(u)) \to \text{RIGHT-Rotate}(u)} \\
     \mathbf{\text{Right-Left (RL)}} & -2 & +1 & \mathbf{\text{RIGHT-Rotate}(\text{right}(u)) \to \text{LEFT-Rotate}(u)} \\
     \hline
     \end{array}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of resolving an LR (Left-Right) imbalance: (1) detect that node A has balance factor BF(A) = +2 and its left child B has balance factor BF(B) = -1, (2) identify node C as the right child of node B (forming a bent zigzag structure A -> B -> C), (3) perform a Left Rotation on left child B, elevating C to become the left child of A and making B the left child of C, (4) observe that the tree is now transformed into a straight Left-Left (LL) imbalance with BF(A) = +2 and BF(C) = +1, (5) execute a Right Rotation on root node A, making node C the new balanced root with B as left child and A as right child!
3. **Slide 3 (`matching`):** Pair 4 AVL imbalance types (LL Case, RR Case, LR Case, RL Case) with their exact rotation fixes.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the balance factor in an AVL tree must strictly remain in the set {-1, 0, 1}. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why single rotation fails on LR / RL zigzag imbalances: Why can an LR (Left-Right) imbalance NOT be fixed by a single Right Rotation on the critical root node $A$? (Because an LR imbalance has a 'zigzag' shape where the heavy subtree is the inner grandchild $C$; performing a single Right Rotation on $A$ **simply inverts the zigzag into an equally unbalanced RL imbalance ($\text{BF} = -2$)**, failing to reduce the tree height; a preliminary Left Rotation on child $B$ is required to **straighten the zigzag into a linear LL chain before rotating $A$**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "avl_trees_balance_factors_and_rotations",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: AVL Trees & The 4 Rotations (1962)**\n• **The Strict Balance Factor Invariant:**\n$$\n\\mathbf{\\text{BF}(u) = \\text{height}(\\text{left}) - \\text{height}(\\text{right}) \\in \\{-1, 0, +1\\}}\n$$\n• **Strict Height Bound ($N(h) = N(h-1) + N(h-2) + 1$):**\n$$\n\\mathbf{h < 1.4404 \\log_2(n + 2) \\implies \\mathbf{O(\\log n)\\text{ Worst-Case Search Time!}}}\n$$\n• **The 4 Imbalance Cases & Corrective Actions:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Case} & \\textbf{Balance Factors} & \\textbf{Corrective Rotation} \\\\\n\\hline\n\\mathbf{\\text{LL (Left-Left)}} & \\text{BF}(u) = +2, \\ \\text{BF}(\\text{child}) \\ge 0 & \\mathbf{\\text{Single RIGHT Rotation}(u)} \\\\\n\\mathbf{\\text{RR (Right-Right)}} & \\text{BF}(u) = -2, \\ \\text{BF}(\\text{child}) \\le 0 & \\mathbf{\\text{Single LEFT Rotation}(u)} \\\\\n\\mathbf{\\text{LR (Left-Right)}} & \\text{BF}(u) = +2, \\ \\text{BF}(\\text{child}) = -1 & \\mathbf{\\text{LEFT}(child) \\to \\text{RIGHT}(u)} \\\\\n\\mathbf{\\text{RL (Right-Left)}} & \\text{BF}(u) = -2, \\ \\text{BF}(\\text{child}) = +1 & \\mathbf{\\text{RIGHT}(child) \\to \\text{LEFT}(u)} \\\\\n\\hline\n\\end{array}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of fixing an LR (Left-Right) imbalance using a double rotation.",
      "orderItems": [
        "Detect that root node A has balance factor BF(A) = +2 and left child B has balance factor BF(B) = -1",
        "Identify inner grandchild C as the right child of B, forming a bent zigzag path A -> B -> C",
        "Execute a single LEFT rotation on child node B, elevating grandchild C to become the direct left child of A",
        "Verify that the zigzag is now straightened into a standard Left-Left (LL) imbalance A -> C -> B",
        "Execute a single RIGHT rotation on root node A, establishing C as the new balanced subtree root"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each AVL tree imbalance case to its exact corrective rotation strategy.",
      "matchPairs": [
        { "left": "Left-Left (LL) Imbalance", "right": "Single Right Rotation on critical root node to restore balance factor to 0" },
        { "left": "Right-Right (RR) Imbalance", "right": "Single Left Rotation on critical root node to restore balance factor to 0" },
        { "left": "Left-Right (LR) Imbalance", "right": "Double Rotation: Left Rotate left child first, then Right Rotate critical root" },
        { "left": "Right-Left (RL) Imbalance", "right": "Double Rotation: Right Rotate right child first, then Left Rotate critical root" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a valid AVL tree, the balance factor BF(u) of every node must strictly belong to the set {-1, 0, ___}.",
      "blankAnswer": "1",
      "blankDistractors": ["2", "-2", "3"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is a single Right Rotation on root node A mathematically incapable of resolving a Left-Right (LR) imbalance?",
      "options": [
        { "text": "In an LR imbalance, the excess height is located in the inner grandchild subtree (the right subtree of left child B); executing a single Right Rotation on A merely transfers this inner subtree over to become an equally tall inner left subtree of A, converting the +2 LL-imbalance directly into a -2 RR-imbalance without reducing overall tree height; a preliminary Left Rotation on B is strictly necessary to straighten the inner zigzag into an outer branch", "isCorrect": true, "explanation": "Correct! This is the core geometric intuition behind double rotations in AVL trees (CLRS Chapter 13). Consider an LR imbalance at node $A$: $A$ has a left child $B$, and $B$ has a heavy RIGHT child $C$ (forming a 'zigzag' shape $A \\to B \\to C$). The balance factors are $\\text{BF}(A) = +2$ and $\\text{BF}(B) = -1$. If you attempt to fix this with a single Right Rotation on $A$: $B$ becomes the root, $A$ becomes the right child of $B$, and $C$ (which was the heavy right child of $B$) is attached as the left child of $A$. Because $C$ was the tall subtree, $A$ now has a heavy left child $C$ and an empty or short right child, causing $A$ to have $\\text{BF}(A) = +2$ or $B$ to have $\\text{BF}(B) = -2$! The single rotation fails because it didn't elevate the deep node $C$. To solve this, we MUST perform TWO rotations: 1. Left-Rotate on child $B$: Elevates $C$ above $B$, straightening the zigzag $A \\to B \\to C$ into a linear line $A \\to C \\to B$ (an LL imbalance). 2. Right-Rotate on root $A$: Elevates $C$ to become the new balanced root with $B$ on its left and $A$ on its right, restoring balance factors of all three nodes to 0." },
        { "text": "Because right rotations are not permitted in AVL trees", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because single rotations delete the root node", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because AVL trees can only rotate left", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
