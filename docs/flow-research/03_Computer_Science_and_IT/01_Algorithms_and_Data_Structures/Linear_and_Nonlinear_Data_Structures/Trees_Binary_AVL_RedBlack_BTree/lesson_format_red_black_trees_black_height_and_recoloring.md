# Duofy Reusable Lesson Format: Red-Black Trees (Black-Height and Recoloring)

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Linear_and_Nonlinear_Data_Structures / Trees_Binary_AVL_RedBlack_BTree`  
**Lesson Format Type:** `red_black_trees_black_height_and_recoloring`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the 5 color invariants, black-height mathematical proofs, and recoloring/rotation rebalancing cases of Red-Black Trees (Rudolf Bayer 1972; Leonidas J. Guibas & Robert Sedgewick 1978; Thomas H. Cormen et al. CLRS Chapter 13): master the **5 Red-Black Properties** (**1. Node is RED or BLACK**, **2. Root is BLACK**, **3. Every leaf NIL is BLACK**, **4. No Double Red: RED node cannot have RED children**, and **5. Equal Black-Height: all simple paths to descendant leaves contain the exact same number of black nodes $bh(u)$**), prove the **Logarithmic Height Theorem ($\mathbf{h \le 2\log_2(n+1)}$)** showing the longest path is at most twice the shortest path, analyze the **3 Insertion Fixup Cases** (Case 1: Red Uncle $\implies$ recolor parent, uncle, and grandparent; Case 2: Black Uncle Zigzag $\implies$ rotate into straight line; Case 3: Black Uncle Straight Line $\implies$ rotate grandparent and swap colors), and evaluate 2-3-4 tree isomorphism.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The 5 Red-Black Invariants, Black-Height Lemma, & Height Bound Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Red-Black Insertion Fixup Algorithm (Uncle Cases) Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Red-Black Tree Insertion Case / Property & Corrective Fix Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Maximum Height of a Red-Black Tree Containing n Internal Nodes (2 log(n + 1)) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Proof Why Equal Black-Height Guarantees Logarithmic Tree Height Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Red-Black Trees & Height Bounds (Guibas & Sedgewick 1978; CLRS Chapter 13):
   - **The 5 Red-Black Invariants:**
     1. Every node is colored either **RED** or **BLACK**.
     2. The **Root is BLACK**.
     3. Every leaf (**NIL sentinel**) is **BLACK**.
     4. **No Double Red:** If a node is RED, both of its children MUST be BLACK.
     5. **Equal Black-Height ($bh(u)$):** For each node $u$, all simple paths from $u$ to descendant leaves contain the exact same number of black nodes.
   - **Lemma (CLRS Lemma 13.1):** A subtree rooted at $u$ contains at least $\mathbf{2^{bh(u)} - 1}$ internal nodes.
   - **The Height Bound Theorem:**
     - By Property 4, at most half the nodes on any path can be RED $\implies bh(\text{root}) \ge h/2$.
     - Therefore: $n \ge 2^{h/2} - 1 \implies \mathbf{h \le 2\log_2(n + 1)} \implies \mathbf{O(\log n)\text{ Worst-Case Search!}}$
   - **The 3 Insertion Fixup Cases (when newly inserted RED node $z$ violates Property 4):**
     - **Case 1:** $z$'s Uncle $y$ is **RED** $\implies$ Recolor parent and uncle BLACK, grandparent RED; push $z$ up to grandparent!
     - **Case 2:** $z$'s Uncle $y$ is **BLACK** and $z$ is a right child $\implies$ Left-Rotate parent of $z$ (transforms to Case 3).
     - **Case 3:** $z$'s Uncle $y$ is **BLACK** and $z$ is a left child $\implies$ Recolor parent BLACK, grandparent RED; Right-Rotate grandparent!
2. **Slide 2 (`ordering`):** Provide 5 steps of the Red-Black Tree insertion algorithm: (1) insert new key z as a leaf in the BST and color node z RED, (2) while z is not the root and parent(z) is colored RED (violating Property 4), inspect the color of z's uncle y, (3) if uncle y is RED (Case 1), recolor parent and uncle to BLACK and grandparent to RED, advancing z to grandparent, (4) if uncle y is BLACK and z forms a zigzag (Case 2), rotate parent to transform into a straight line, (5) if uncle y is BLACK and z is straight (Case 3), recolor parent to BLACK, grandparent to RED, and rotate grandparent, concluding by forcing root to BLACK!
3. **Slide 3 (`matching`):** Pair 4 Red-Black concepts (Property 4 No Double Red, Property 5 Equal Black-Height, Insertion Case 1 Red Uncle, Height Bound 2 log(n+1)) with their mathematical definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that a Red-Black tree with n internal nodes has a maximum height of at most 2 * log2(n + 1). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the mathematical proof why a Red-Black tree cannot have a path longer than $2\times$ the shortest path: Why do the 5 Red-Black tree invariants mathematically guarantee that the longest path from the root to any leaf is at most twice as long as the shortest path? (Because Property 5 requires every path to have the **exact same number of black nodes ($B$)**, and Property 4 forbids two consecutive red nodes, which means **the shortest possible path consists of $B$ black nodes (length $B$), while the longest possible path strictly alternates Red-Black-Red-Black containing at most $B$ black and $B$ red nodes (length $\le 2B$)**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "red_black_trees_black_height_and_recoloring",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Red-Black Trees & Height Bounds (CLRS 13)**\n• **The 5 Red-Black Invariants:**\n$$\n\\begin{array}{|l|l|}\n\\hline\n\\textbf{Invariant} & \\textbf{Rule} \\\\\n\\hline\n\\mathbf{1. \\ \\text{Color}} & \\text{Every node is either RED or BLACK} \\\\\n\\mathbf{2. \\ \\text{Root}} & \\text{The root is strictly BLACK} \\\\\n\\mathbf{3. \\ \\text{Leaves}} & \\text{Every external leaf (NIL sentinel) is BLACK} \\\\\n\\mathbf{4. \\ \\text{No Double Red}} & \\mathbf{\\text{If node is RED } \\implies \\text{Both children MUST be BLACK!}} \\\\\n\\mathbf{5. \\ \\text{Black-Height } (bh)} & \\mathbf{\\text{All paths from a node to descendant leaves have equal black count!}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Height Bound Theorem:**\n$$\n\\mathbf{n \\ge 2^{bh(\\text{root})} - 1 \\ge 2^{h/2} - 1 \\implies \\mathbf{h \\le 2\\log_2(n + 1) = \\mathbf{O(\\log n)!}}}\n$$\n• **Ratio:** Longest path (alternating Red-Black) is at most **$2\\times$ the shortest path** (all Black)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the Red-Black Tree insertion fixup loop when resolving a double-red conflict.",
      "orderItems": [
        "Insert new node z as a standard BST leaf and color z strictly RED",
        "While z is not root and z's parent is RED, inspect the color of z's uncle node y",
        "If uncle y is RED (Case 1), recolor parent and uncle to BLACK, grandparent to RED, and push z to grandparent",
        "If uncle y is BLACK and z is an inner child (Case 2), rotate parent to transform into a straight outer line",
        "If uncle y is BLACK and z is an outer child (Case 3), recolor parent BLACK, grandparent RED, rotate grandparent, and recolor root BLACK"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Red-Black tree property to its exact architectural significance.",
      "matchPairs": [
        { "left": "Property 4: No Double Red", "right": "Forbids consecutive red nodes along any path, bounding red node frequency to at most 50%" },
        { "left": "Property 5: Equal Black-Height", "right": "Enforces that all root-to-leaf paths pass through the exact same number of black nodes bh" },
        { "left": "Insertion Case 1: Red Uncle", "right": "Resolved by recoloring parent and uncle to black and grandparent to red without rotations" },
        { "left": "Height Bound: h <= 2 log(n+1)", "right": "Proves search, insertion, and deletion run in guaranteed O(log n) worst-case time" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a Red-Black tree with n internal nodes, the maximum possible height is at most 2 times log2 of n plus ___.",
      "blankAnswer": "1",
      "blankDistractors": ["2", "0", "k"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What mathematical proof shows why the 5 Red-Black tree invariants guarantee that the longest path from the root to a leaf is at most twice the length of the shortest path?",
      "options": [
        { "text": "Property 5 requires every simple path from the root to any leaf to have the exact same number of black nodes B; Property 4 forbids consecutive red nodes, so red nodes can at most alternate between black nodes; therefore, the shortest possible path contains only B black nodes (length B), while the longest possible path alternates Red-Black-Red-Black containing at most B black and B red nodes (length 2B)", "isCorrect": true, "explanation": "Correct! This is the core geometric proof of Red-Black tree balance (CLRS Section 13.1). Let the black-height of the root be $B = bh(\\text{root})$: 1. By Property 5 (Equal Black-Height), EVERY simple path from the root to any descendant NIL leaf contains EXACTLY $B$ black nodes. 2. The shortest possible path to a leaf is one that contains ZERO red nodes. Its total length is simply $B$ (all black nodes). 3. The longest possible path is one that tries to pack in as many red nodes as possible. However, Property 4 (No Double Red) states that no two red nodes can ever appear consecutively. Therefore, red nodes can only appear strictly sandwiched between black nodes (alternating Black-Red-Black-Red...). The maximum number of red nodes that can fit along a path with $B$ black nodes is at most $B$. Thus, the maximum length of any path is at most $B \\text{ (black)} + B \\text{ (red)} = 2B$. 4. Comparing the longest path ($2B$) to the shortest path ($B$), the ratio is $\\frac{2B}{B} = 2$. The longest path is at most twice the length of the shortest path, guaranteeing the tree is approximately balanced with height $h \\le 2 \\log_2(n + 1) = O(\\log n)$." },
        { "text": "Because computers automatically multiply red nodes by 2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Red-Black trees are always perfectly complete binary trees", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because black nodes can only have 1 child in red-black trees", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
