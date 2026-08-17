# Duofy Reusable Lesson Format: Huffman Coding and Optimal Prefix Trees

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Algorithm_Design_Techniques / Greedy_Algorithms`  
**Lesson Format Type:** `huffman_coding_and_optimal_prefix_trees`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the lossless data compression, prefix-free binary tree construction, and min-heap greedy optimization of Huffman Coding (David A. Huffman 1952; Claude Shannon; Thomas H. Cormen et al. CLRS): master the **Prefix-Free Code Property** (no valid codeword is a prefix of another codeword, enabling unambiguous, deterministic left-to-right stream decoding without delimiters), formulate the **Expected Codeword Length Cost Function ($B(T) = \sum_{c \in C} f(c) \cdot d_T(c)$)**, trace the **Min-Priority Queue Greedy Tree Construction** (extracting the two least frequent nodes, merging them under a parent whose frequency is their sum, and re-inserting into the heap in $O(n\log n)$), and prove optimality using the **Exchange Lemma** (the two characters with lowest frequencies appear as sibling leaves of maximum depth in an optimal code tree).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Huffman Prefix-Free Codes, Tree Cost Function, & Min-Heap Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Character Frequency Priority Queue Tree Construction Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Huffman Coding Component / Metric & Mathematical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Core Data Structure Used to Efficiently Extract Minimum Frequencies Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Unambiguous Decoding Property of Prefix-Free Binary Encodings Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Huffman Coding & Prefix Trees (Huffman 1952; CLRS):
   - **Prefix-Free Code Definition:**
     - A variable-length character code where **no codeword is a prefix of any other valid codeword** (e.g. if 'a' = `0`, 'b' = `10`, 'c' = `11`, code is prefix-free).
     - Represented as a **Full Binary Tree** where characters sit exclusively at the **leaves**!
   - **The Tree Cost Objective ($B(T)$):**
     $$\mathbf{B(T) = \sum_{c \in C} f(c) \cdot d_T(c) \qquad (f(c) = \text{frequency}, \ d_T(c) = \text{depth/length of code})}$$
   - **Huffman's Greedy Min-Heap Algorithm ($O(n\log n)$):**
     1. Insert all $n$ character leaves into a min-priority queue $Q$ keyed by frequency $f(c)$.
     2. Loop $n-1$ times:
        - $x = Q.\text{extract\_min}()$; $y = Q.\text{extract\_min}()$.
        - Allocate new internal node $z$ with left child $x$, right child $y$, and $f(z) = f(x) + f(y)$.
        - $Q.\text{insert}(z)$.
     3. Return the remaining root node in $Q$.
   - **The Greedy Choice Lemma:** Let $x$ and $y$ be the two characters with the lowest frequencies in alphabet $C$. There exists an optimal prefix code for $C$ in which $x$ and $y$ are sibling leaves of maximum depth in the code tree!
2. **Slide 2 (`ordering`):** Provide 5 steps of executing Huffman's algorithm on an input text: (1) scan the input text to compute the exact frequency of every unique character, (2) instantiate a leaf node for each character and insert all n nodes into a min-priority queue (min-heap), (3) repeatedly extract the two nodes with the lowest frequencies from the min-heap, (4) create a new internal parent node with frequency equal to the sum of the two children and re-insert the parent into the min-heap, (5) assign binary '0' to left branches and '1' to right branches from the root to generate optimal variable-length bit strings for each character!
3. **Slide 3 (`matching`):** Pair 4 Huffman concepts (Prefix-Free Code, Min-Priority Queue, Tree Cost B(T), Sibling Leaf Lemma) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the priority queue data structure used to implement Huffman coding in O(n log n) is a min heap. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on how prefix-free codes enable instantaneous stream decoding without delimiters: Why can a computer unambiguously decode a continuous stream of bits (e.g. `0101100`) encoded with a Huffman prefix code without needing commas or spacing delimiters between characters? (Because in a prefix-free code, **no codeword is the prefix of any other codeword**, allowing the decoder to **traverse from the root of the binary tree following bits 0 (left) and 1 (right) until it hits a leaf node**, outputting that character and instantly resetting to the root for the next bit).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "huffman_coding_and_optimal_prefix_trees",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Huffman Optimal Prefix Coding (1952)**\n• **Prefix-Free Property:** No valid codeword is a prefix of another $\\implies$ **Unambiguous stream decoding**!\n• **The Tree Cost Function (Minimize $B(T)$):**\n$$\n\\mathbf{B(T) = \\sum_{c \\in C} f(c) \\cdot d_T(c) \\qquad (f(c) = \\text{character frequency}, \\ d_T(c) = \\text{leaf depth})}\n$$\n• **Huffman's Min-Heap Greedy Loop ($O(n\\log n)$):**\n$$\n\\text{Extract } x, y \\ (\\min f) \\implies \\text{Create parent } z \\text{ with } f(z) = f(x) + f(y) \\implies \\text{Re-insert } z \\text{ into Heap!}\n$$\n• **The Optimality Lemma:** The two least frequent characters **always reside as sibling leaves at maximum tree depth** in an optimal tree!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential algorithmic steps of constructing an optimal Huffman compression tree.",
      "orderItems": [
        "Calculate the occurrence frequency of every unique character across the input text",
        "Create leaf nodes for each character and insert all n nodes into a min-priority queue (min-heap)",
        "Extract the two nodes with the lowest frequencies (x and y) from the min-heap",
        "Create an internal parent node z with frequency f(z) = f(x) + f(y) and re-insert z into the min-heap",
        "Traverse the completed binary tree from root to leaves, assigning '0' for left edges and '1' for right edges"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Huffman coding component to its exact mathematical role.",
      "matchPairs": [
        { "left": "Prefix-Free Code", "right": "Encoding where no codeword is a prefix of another, enabling instant one-pass stream decoding" },
        { "left": "Min-Priority Queue", "right": "Data structure providing O(log n) extraction of the two least frequent nodes at each merge" },
        { "left": "Tree Cost B(T)", "right": "Weighted average bit length of the compressed file (sum of frequency times depth for all leaves)" },
        { "left": "Sibling Leaf Invariant", "right": "Structural property placing lowest-frequency characters at the deepest levels of the binary tree" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The efficient priority queue data structure used to implement Huffman's greedy tree construction in O(n log n) time is a min ___.",
      "blankAnswer": "heap",
      "blankDistractors": ["stack", "deque", "hash"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How does a receiver decode an unbroken binary bitstream (such as '0101100') produced by a Huffman prefix code without requiring any spacing delimiters between individual letters?",
      "options": [
        { "text": "Because no codeword is a prefix of any other codeword, the decoder reads bits sequentially while traversing the Huffman binary tree (0 = branch left, 1 = branch right); whenever a leaf node is reached, the decoder uniquely outputs that character and immediately resets back to the root node to parse the subsequent bit", "isCorrect": true, "explanation": "Correct! The brilliant feature of a prefix-free code is that it is uniquely and instantaneously decodable in a single left-to-right pass without lookahead or punctuation markers. Because characters sit exclusively at the leaves of the Huffman binary tree, no path from the root to a leaf can ever pass through another leaf (which geometrically enforces the prefix-free property: no codeword can be the prefix of another). The decoding algorithm is simple: start at the root node of the Huffman tree. Read the first bit: if it is a '0', step to the left child; if '1', step to the right child. Repeat this for each incoming bit. The moment the current position in the tree is a LEAF node, there is zero ambiguity—that exact sequence of bits could not possibly mean anything else. The decoder outputs the character at the leaf, resets its pointer back to the root of the tree, and continues reading the very next bit. This allows massive compression without wasting a single bit on delimiters." },
        { "text": "All characters in Huffman codes are fixed at exactly 8 bits each", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The decoder pauses for 1 millisecond between each letter", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Huffman codes require commas stored as 16-bit integers between words", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
