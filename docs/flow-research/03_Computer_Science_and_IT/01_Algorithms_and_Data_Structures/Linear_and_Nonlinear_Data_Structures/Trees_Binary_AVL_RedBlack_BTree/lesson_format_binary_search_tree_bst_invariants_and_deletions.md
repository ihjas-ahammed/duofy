# Duofy Reusable Lesson Format: Binary Search Tree (BST) Invariants and Deletions

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Linear_and_Nonlinear_Data_Structures / Trees_Binary_AVL_RedBlack_BTree`  
**Lesson Format Type:** `binary_search_tree_bst_invariants_and_deletions`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the structural ordering invariants, recursive traversals, and multi-case deletion logic of Binary Search Trees (Thomas N. Hibbard 1962; Thomas H. Cormen et al. CLRS Chapter 12): master the **BST Invariant ($\forall x \in \text{left}(u): \text{key}(x) < \text{key}(u)$ and $\forall y \in \text{right}(u): \text{key}(y) > \text{key}(u)$)**, prove why an **In-Order Traversal** visits keys in monotonically ascending sorted order, execute the **3 Hibbard Deletion Cases** (**Case 1: Leaf node [delete directly]**, **Case 2: 1 child [bypass parent pointer directly to child]**, and **Case 3: 2 children [locate In-Order Successor / right subtree minimum, copy successor key to target, and recursively delete successor from right subtree]**), and analyze why sorted insertions cause pathological $O(n)$ degeneration into a linear linked list.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | BST Invariant, In-Order Sorted Property, & 3 Deletion Cases Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step BST Node Deletion with Two Children Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | BST Deletion Case / Traversal & Operational Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Smallest Key in a Node's Right Subtree (Successor) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Reason Sorted Input Degenerates an Unbalanced BST to O(n) Runtime Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Binary Search Trees (CLRS Chapter 12):
   - **The BST Invariant:**
     $$\mathbf{\forall x \in \text{left\_subtree}(u): \text{key}(x) < \text{key}(u) \qquad \forall y \in \text{right\_subtree}(u): \text{key}(y) > \text{key}(u)}$$
   - **In-Order Traversal Sorted Property:**
     - Left $\to$ Root $\to$ Right recursively outputs all keys in **strictly ascending sorted order**!
   - **The 3 Hibbard Deletion Cases (1962):**
     1. **Case 1 (0 Children / Leaf):** Set parent's pointer to `null`.
     2. **Case 2 (1 Child):** Replace target node with its single existing child (bypass link).
     3. **Case 3 (2 Children):** Find node's **In-Order Successor $s$** (minimum element in right subtree):
        $$\mathbf{\text{key}(u) = \text{key}(s) \ ; \quad \text{recursively delete } s \text{ from } \text{right}(u)}$$
   - **Asymptotic Performance:** Search/Insert/Delete run in **$O(h)$ time**, where $h = O(\log n)$ when balanced, but degrades to **$O(n)$ worst-case** on sorted inputs!
2. **Slide 2 (`ordering`):** Provide 5 steps of deleting a BST node with two children: (1) search and locate the target node z containing the key to be deleted, (2) traverse into target node z's right child to find its In-Order Successor y (the leftmost node in the right subtree), (3) copy the key value of successor y into target node z, (4) observe that successor y has at most ONE right child (and zero left children), (5) delete node y by splicing y's right child directly to y's parent, preserving all BST invariants!
3. **Slide 3 (`matching`):** Pair 4 BST concepts (In-Order Successor, In-Order Traversal, Case 2 Deletion, Degenerate BST) with their exact descriptions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the node with the smallest key in a node's right subtree is called its in-order successor. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the cause of unbalanced BST degeneration: What happens to the shape and search performance of an ordinary Binary Search Tree if $n$ numbers are inserted in strictly ascending sorted order ($1, 2, 3, \dots, n$)? (Every new node is larger than its predecessor and is inserted as the right child of the previous leaf, **degenerating the tree into a single linear chain of height $h = n$ identical to a linked list**, causing search and insertion times to degrade from $O(\log n)$ to slow $O(n)$ linear time).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "binary_search_tree_bst_invariants_and_deletions",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Binary Search Tree (BST) Invariants (CLRS 12)**\n• **The BST Ordering Invariant:**\n$$\n\\mathbf{\\forall x \\in \\text{left}(u): \\text{key}(x) < \\text{key}(u) \\qquad \\forall y \\in \\text{right}(u): \\text{key}(y) > \\text{key}(u)}\n$$\n• **In-Order Traversal Theorem:** Left $\\to$ Root $\\to$ Right outputs keys in **strictly ascending sorted order**!\n• **The 3 Hibbard Deletion Cases (1962):**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Case} & \\textbf{Node Structure} & \\textbf{Deletion Action} \\\\\n\\hline\n\\mathbf{\\text{Case 1}} & \\text{Leaf (0 Children)} & \\text{Set parent pointer to null} \\\\\n\\mathbf{\\text{Case 2}} & \\text{1 Child} & \\text{Bypass node; link parent directly to child} \\\\\n\\mathbf{\\text{Case 3}} & \\mathbf{2 \\text{ Children}} & \\mathbf{\\text{Replace with In-Order Successor } y, \\text{ delete } y} \\\\\n\\hline\n\\end{array}\n$$\n• **Degeneration Risk:** Sorted inputs degrade tree to **$O(n)$ linked list**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of deleting a BST node z possessing two active children.",
      "orderItems": [
        "Traverse the BST to locate the target node z containing the key to be removed",
        "Navigate into z's right subtree and follow left child pointers until reaching the minimum node (In-Order Successor y)",
        "Overwrite the key of target node z with the key value stored in successor node y",
        "Observe that successor y is guaranteed to have at most one right child and zero left children",
        "Relink y's parent directly to y's right child (Case 2 deletion), splicing y out of the tree"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Binary Search Tree concept to its exact operational definition.",
      "matchPairs": [
        { "left": "In-Order Successor", "right": "Smallest key in node's right subtree, found by moving right once and then fully left" },
        { "left": "In-Order Traversal", "right": "Recursive Left-Root-Right walk producing keys in monotonically non-decreasing order" },
        { "left": "Case 2 Deletion (1 Child)", "right": "Splices out target node by linking its parent directly to its single existing child" },
        { "left": "Degenerate BST (Linear Chain)", "right": "Pathological tree of height h = n formed by inserting pre-sorted keys sequentially" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In BST Case 3 deletion, a node with two children is replaced by its in-order ___, which is the minimum key in its right subtree.",
      "blankAnswer": "successor",
      "blankDistractors": ["predecessor", "ancestor", "descendant"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What happens to the structure and asymptotic search performance of an ordinary Binary Search Tree if n elements are inserted in strictly ascending sorted order (1, 2, 3, ... n)?",
      "options": [
        { "text": "Every inserted node is strictly larger than all previous keys, so each element is placed as the right child of the previous leaf; this degenerates the tree into a single right-skewed linear chain of height h = n identical to a linked list, degrading search and insertion times from O(log n) to slow O(n) linear time", "isCorrect": true, "explanation": "Correct! This is the fundamental vulnerability of standard unbalanced Binary Search Trees (CLRS Section 12.3). In a BST, the time complexity of search, insertion, and deletion is $O(h)$, where $h$ is the height of the tree. When keys are inserted in random order, the expected tree height is balanced at $h = O(\\log n)$. However, if keys arrive in strictly sorted order ($1, 2, 3, 4, 5$), key 1 becomes the root. Key 2 is larger than 1, so it becomes the right child of 1. Key 3 is larger than 1 and 2, so it becomes the right child of 2. By induction, every key $k$ becomes the right child of key $k-1$. The resulting tree contains zero left children and forms a 1D linear chain of height $h = n$. Searching for key $n$ requires traversing all $n$ nodes sequentially, yielding an $O(n)$ search time. This severe performance degradation motivated the invention of self-balancing trees like AVL and Red-Black trees." },
        { "text": "The tree automatically balances itself in O(1) time", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The tree deletes all elements except the root", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Sorted inputs make search run in O(1) instant time", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
