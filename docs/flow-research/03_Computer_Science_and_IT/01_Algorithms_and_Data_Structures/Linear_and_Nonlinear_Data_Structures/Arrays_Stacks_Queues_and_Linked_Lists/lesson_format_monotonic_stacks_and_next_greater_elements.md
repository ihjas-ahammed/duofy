# Duofy Reusable Lesson Format: Monotonic Stacks and Next Greater Elements

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Linear_and_Nonlinear_Data_Structures / Arrays_Stacks_Queues_and_Linked_Lists`  
**Lesson Format Type:** `monotonic_stacks_and_next_greater_elements`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the structural invariants, pop trigger mechanisms, and linear-time amortized bounds of Monotonic Stacks (Thomas H. Cormen et al. CLRS Chapter 10; Steven Skiena): master the definition of **Monotonically Decreasing Stacks** (elements maintained in strictly decreasing order from bottom to top), analyze the **Next Greater Element (NGE)** pattern (when scanning array $A$, if incoming element $A[i] > \text{stack.top()}$, the monotonic invariant is violated $\implies$ **the incoming element $A[i]$ is the exact Next Greater Element for the popped element!**), prove that because each element is pushed onto the stack exactly once and popped at most once, the total execution time is strictly **$\mathbf{O(N)\text{ Linear Time}}$** (reducing naive $O(N^2)$ brute-force comparisons to $O(N)$), and apply the pattern to the classic **Largest Rectangle in Histogram** and **Trapping Rain Water** problems.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Monotonic Stack Invariant, NGE Pop Condition, & O(N) Proof Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Monotonic Stack Array Scan and Pop Resolution Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Monotonic Stack Concept / Problem & Structural Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Total Time Complexity of Monotonic Stack Next Greater Element Scans (O(N)) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Proof Why Monotonic Stack Executes in Amortized O(N) Time Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Monotonic Stack Invariant & Next Greater Element (CLRS Chapter 10):
   - **The Monotonic Decreasing Stack Invariant:**
     - Elements in the stack must satisfy: $\text{bottom} > \dots > \text{top}$.
   - **The Pop Event (Resolving Unmatched Elements):**
     - For each incoming element $A[i]$ from left to right:
       $$\mathbf{\text{while } (\text{stack is not empty} \ \land \ A[i] > A[\text{stack.top()}]) : \quad \text{pop } u \implies \mathbf{\text{NGE}[u] = A[i]}}$$
     - Once all smaller elements are popped, push index $i$ onto stack.
   - **Amortized $O(N)$ Complexity Proof:**
     $$\mathbf{\text{Total Pushes} = N \quad + \quad \text{Total Pops} \le N \implies \mathbf{2N \text{ total operations } = \mathbf{O(N)\text{ Linear Time!}}}}$$
   - **Applications:** Next Greater Element, Daily Temperatures, Largest Rectangle in Histogram, Trapping Rain Water!
2. **Slide 2 (`ordering`):** Provide 5 steps of finding Next Greater Elements using a monotonic stack: (1) initialize an empty stack to store array indices and an output result array filled with -1, (2) iterate sequentially through the array from left to right with index i, (3) while stack is not empty and array[i] is strictly greater than array[stack.top()], pop the top index u from the stack, (4) set the next greater element for the popped index: result[u] = array[i], (5) push current index i onto the stack and continue the iteration until all elements are processed!
3. **Slide 3 (`matching`):** Pair 4 monotonic stack patterns (Monotonic Decreasing Stack, Monotonic Increasing Stack, Largest Rectangle in Histogram, Unmatched Stack Remainder) with their algorithmic functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that a monotonic stack resolves the Next Greater Element for all array elements in O(N) linear time. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the amortized complexity proof of monotonic stacks: Even though the while-loop inside the iteration can pop multiple elements in a single step (e.g. popping 10 elements when a huge number arrives), why is the overall time complexity of the algorithm strictly $O(N)$ rather than $O(N^2)$? (Because every array element is pushed onto the stack **at most once**, and once an element is popped from the stack, it is **never pushed back again**; the total number of pop operations across the entire algorithm is bounded by $N$, making total work across all loop iterations at most $N + N = 2N = O(N)$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "monotonic_stacks_and_next_greater_elements",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Monotonic Stacks & Next Greater Element (NGE)**\n• **The Monotonically Decreasing Invariant:**\n$$\n\\mathbf{\\text{Stack strictly maintained in decreasing order: } \\text{bottom} > \\dots > \\text{top}}\n$$\n• **The Pop Event (Resolving the Next Greater Element):**\n$$\n\\mathbf{\\text{while } (A[i] > A[\\text{stack.top()}]) : \\quad \\text{pop } u \\implies \\mathbf{\\text{NGE}[u] = A[i]}}\n$$\n  - The incoming element $A[i]$ is the **first element to the right that is strictly larger** than $A[u]$!\n• **Amortized $O(N)$ Complexity:**\n$$\n\\mathbf{\\text{Total Pushes} = N \\ ; \\quad \\text{Total Pops} \\le N \\implies \\mathbf{\\le 2N \\text{ Operations} = \\mathbf{O(N)\\text{ Linear Time!}}}}\n$$\n• **Applications:** Histogram max rectangle, Rainwater trapping, Stock span!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of computing Next Greater Elements using a monotonic decreasing stack.",
      "orderItems": [
        "Initialize an empty stack to store indices and a result array initialized with default values -1",
        "Iterate through the array from left to right with current pointer index i",
        "While the stack is not empty and array[i] > array[stack.top()], pop the top index u from the stack",
        "Record the incoming value as the Next Greater Element for popped index: result[u] = array[i]",
        "Push the current index i onto the stack and advance to the next element until the array is fully processed"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Monotonic Stack pattern to its exact computational application.",
      "matchPairs": [
        { "left": "Monotonic Decreasing Stack", "right": "Used to find Next Greater Element to the right by popping elements smaller than the incoming value" },
        { "left": "Monotonic Increasing Stack", "right": "Used to find Next Smaller Element to the right by popping elements larger than the incoming value" },
        { "left": "Largest Rectangle in Histogram", "right": "Uses monotonic stack to find left and right boundary limits for each bar in O(N) time" },
        { "left": "Unresolved Elements in Stack", "right": "Elements remaining in the stack at the end of the array scan that have no greater element to their right (-1)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A monotonic stack reduces the brute-force O(N^2) Next Greater Element problem to an optimal ___ O(N) runtime.",
      "blankAnswer": "linear",
      "blankDistractors": ["quadratic", "logarithmic", "exponential"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Even though the inner while-loop of a monotonic stack can pop many elements in a single step (e.g. popping 10 elements at once), why is the total runtime of the entire algorithm mathematically guaranteed to be O(N) rather than O(N^2)?",
      "options": [
        { "text": "Each array element is pushed onto the stack exactly once; once an element is popped from the stack, it is permanently discarded and can never be pushed again; therefore, the total number of pop operations executed across ALL loop iterations combined is at most N, bounding the total operations across the entire algorithm to at most N pushes + N pops = 2N = O(N)", "isCorrect": true, "explanation": "Correct! This is a classic example of Aggregate Amortized Analysis (CLRS Chapter 17). In naive analysis, one might look at the nested structure (a `for` loop over $N$ elements containing a `while` loop that can pop up to $N$ elements) and incorrectly assume the worst-case time is $O(N \\times N) = O(N^2)$. However, we must consider the total work performed over the LIFETIME of the data structure. How many times can any single element enter the stack? Exactly ONCE during its corresponding `for` loop iteration (at most $N$ total push operations). How many times can any single element be popped from the stack? At most ONCE, because once it is popped, it is gone forever and never re-enters the stack (at most $N$ total pop operations). The inner `while` loop condition runs at most once per pop. Therefore, the total number of operations across all iterations of the outer loop is at most $N \\text{ (pushes)} + N \\text{ (pops)} = 2N = O(N)$. Dividing by $N$ elements gives an amortized cost of $O(1)$ per element, guaranteeing a strictly linear $O(N)$ total execution time." },
        { "text": "Because the stack executes pop operations in parallel on multi-core processors", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because stacks are stored in CPU registers that run at infinite clock speeds", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because monotonic stacks only work on arrays of size 10 or smaller", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
