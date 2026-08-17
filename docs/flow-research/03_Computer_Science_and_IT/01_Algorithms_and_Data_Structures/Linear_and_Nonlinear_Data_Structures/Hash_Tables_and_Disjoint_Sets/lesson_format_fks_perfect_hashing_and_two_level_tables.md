# Duofy Reusable Lesson Format: FKS Perfect Hashing and Two-Level Tables

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Linear_and_Nonlinear_Data_Structures / Hash_Tables_and_Disjoint_Sets`  
**Lesson Format Type:** `fks_perfect_hashing_and_two_level_tables`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the two-level hierarchical architecture, Birthday Paradox collision elimination, and worst-case $O(1)$ search guarantees of FKS Perfect Hashing for static key sets (Michael L. Fredman, János Komlós, & Endre Szemerédi 1984, *Storing a Sparse Table with O(1) Worst Case Access Time*; Thomas H. Cormen et al. CLRS Chapter 11.5): master the **Two-Level Hashing Hierarchy** (**Level 1: Primary Table of size $m = n$** mapping keys into buckets using universal hash $h$; **Level 2: Secondary Tables $S_i$ for each bucket $i$ of size $\mathbf{m_i = n_i^2}$**), prove via the Birthday Paradox that setting secondary table capacity to $n_i^2$ bounds collision probability to $\Pr[\text{Collision}] \le \binom{n_i}{2} \frac{1}{n_i^2} < \frac{1}{2}$, prove that the total expected memory space satisfies $\mathbf{\sum_{i=1}^n n_i^2 < 2n = O(n)\text{ Space}}$, and achieve strictly deterministic **$\mathbf{O(1)\text{ Worst-Case Search Time}}$**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | FKS Two-Level Hashing, Quadratic Secondary Sizing, & O(1) Worst-Case Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step FKS Construction and Collision-Free Secondary Rehash Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | FKS Architecture Layer / Metric & Mathematical Invariant Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Secondary Table Sizing Formula in FKS Perfect Hashing for n_i Keys (n_i^2) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Proof Why Quadratic Sizing m_i = n_i^2 Eliminates Collisions Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State FKS Perfect Hashing (Fredman, Komlós, Szemerédi 1984; CLRS Section 11.5):
   - **The Objective:** Given a static set $S$ of $n$ keys (e.g. dictionary, compiler keywords, CD-ROM index), guarantee **$O(1)$ WORST-CASE search time** in **$O(n)$ Total Space**.
   - **The Two-Level Architecture:**
     - **Level 1 (Primary Table):** Array of size $m = n$ using universal hash function $h(k)$. Keys hashing to slot $i$ form subset $S_i$ of size $n_i$.
     - **Level 2 (Secondary Tables):** Each slot $i$ holds a secondary table $T_i$ of size $\mathbf{m_i = n_i^2}$ with its own universal hash function $h_i$.
   - **The Collision Guarantee (Birthday Paradox):**
     $$\mathbf{E[\text{Collisions in } T_i] = \binom{n_i}{2} \frac{1}{m_i} = \frac{n_i(n_i-1)}{2 n_i^2} < \frac{1}{2} \implies \mathbf{\Pr[\text{Any Collision in } T_i] < \frac{1}{2}}}$$
     - If a collision occurs, simply pick a new random hash function $h_i$ (takes $\le 2$ expected attempts!).
   - **Total Space Theorem:** $\mathbf{\sum_{i=1}^n m_i = \sum_{i=1}^n n_i^2 < 2n = O(n)\text{ Total Space}}$!
2. **Slide 2 (`ordering`):** Provide 5 steps of constructing an FKS perfect hash table: (1) initialize primary table of size m = n and select a random universal hash function h, (2) hash all n keys into the primary table, counting the number of colliding elements n_i in each bucket i, (3) if the sum of squares sum(n_i^2) >= 4n, re-select primary hash function h and re-distribute keys, (4) for each bucket i with n_i keys, allocate a secondary table of size m_i = n_i^2, (5) repeatedly test random universal hash functions h_i for bucket i until all n_i keys hash with ZERO collisions, finalizing the O(1) worst-case table!
3. **Slide 3 (`matching`):** Pair 4 FKS components (Primary Table Size m = n, Secondary Table Size m_i = n_i^2, Total Space Sum(n_i^2) < 2n, Lookup Cost O(1) Worst-Case) with their roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in FKS perfect hashing, each secondary table for bucket i is sized to n_i squared (n_i^2). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the Birthday Paradox proof showing why secondary tables sized to $m_i = n_i^2$ have collision probability strictly less than $1/2$: By Markov's inequality, why does allocating $m_i = n_i^2$ slots guarantee that a random universal hash function has at least a $50\%$ chance of producing zero collisions? (Because the expected number of colliding pairs is $E[\text{collisions}] = \binom{n_i}{2} \frac{1}{m_i} = \frac{n_i(n_i-1)}{2 n_i^2} < \frac{1}{2}$; by Markov's Inequality ($\Pr[X \ge 1] \le E[X]$), **$\Pr[\text{at least 1 collision}] \le E[\text{collisions}] < 1/2$**, guaranteeing that more than half of all universal hash functions will produce zero collisions on the first try).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "fks_perfect_hashing_and_two_level_tables",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: FKS Perfect Hashing (1984)**\n• **The Two-Level Table Architecture:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Level} & \\textbf{Table Size} & \\textbf{Mechanism} \\\\\n\\hline\n\\mathbf{\\text{Level 1 (Primary)}} & m = n & \\text{Universal hash } h \\text{ distributes keys into buckets } S_i \\\\\n\\mathbf{\\text{Level 2 (Secondary)}} & \\mathbf{m_i = n_i^2} & \\text{Universal hash } h_i \\text{ guarantees ZERO collisions!} \\\\\n\\hline\n\\end{array}\n$$\n• **Zero Collision Guarantee (Birthday Paradox):**\n$$\n\\mathbf{\\Pr[\\text{Collision in } S_i] \\le \\binom{n_i}{2} \\frac{1}{m_i} = \\frac{n_i(n_i-1)}{2 n_i^2} < \\mathbf{\\frac{1}{2}}}\n$$\n• **Space-Time Optimum:** Total Space $\\mathbf{\\sum n_i^2 < 2n = O(n)}$ and **Worst-Case Search $O(1)$**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of constructing a collision-free FKS Perfect Hash Table for a static key set.",
      "orderItems": [
        "Allocate primary hash table of size m = n and select a random universal hash function h",
        "Hash all n keys into primary table buckets, counting key frequency n_i for each bucket i",
        "Verify that sum of squared bucket sizes sum(n_i^2) < 4n; if not, re-select primary hash function h",
        "Allocate a secondary hash table of quadratic size m_i = n_i^2 for each bucket containing n_i keys",
        "Sample random secondary universal hash functions h_i until all n_i keys insert with zero collisions"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each component of the FKS Perfect Hashing scheme to its exact mathematical property.",
      "matchPairs": [
        { "left": "Primary Table (m = n)", "right": "Linear-sized top-level array partitioning n keys into manageable bucket subsets" },
        { "left": "Secondary Table (m_i = n_i^2)", "right": "Quadratic-sized subarray bounding collision probability to strictly less than 1/2" },
        { "left": "Total Expected Space: O(n)", "right": "Mathematical invariant proving the sum of all secondary table sizes sum(n_i^2) < 2n" },
        { "left": "Worst-Case Query: O(1)", "right": "Deterministic two-lookup search cost without any linked list traversals or probing loops" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In FKS perfect hashing, each secondary table for a bucket holding n_i keys is allocated with a capacity of n_i ___ (n_i^2).",
      "blankAnswer": "squared",
      "blankDistractors": ["cubed", "linear", "doubled"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How does allocating secondary tables with quadratic size m_i = n_i^2 mathematically guarantee that a randomly chosen universal hash function produces zero collisions with probability greater than 50%?",
      "options": [
        { "text": "The expected number of colliding key pairs in a table of size m_i is (n_i choose 2) * (1 / m_i) = n_i*(n_i - 1) / (2 * n_i^2) < 1/2; by Markov's Inequality, the probability that the number of collisions is >= 1 is strictly bounded by the expected value (< 1/2), proving that more than half of all candidate hash functions will achieve a 100% collision-free mapping on the first try", "isCorrect": true, "explanation": "Correct! This is the foundational theorem of FKS Perfect Hashing (CLRS Theorem 11.9). Let $S_i$ be the set of $n_i$ keys hashed into primary bucket $i$. When hashing these $n_i$ keys into a secondary table of size $m_i$ using a universal hash function $h_i$, the total number of distinct key pairs is $\\binom{n_i}{2} = \\frac{n_i(n_i - 1)}{2}$. By the definition of universal hashing, the probability that any specific pair collides is at most $\\frac{1}{m_i}$. Using linearity of expectation, the expected number of colliding pairs $X$ is: $E[X] = \\sum_{x \\ne y} \\Pr[h_i(x) = h_i(y)] \\le \\binom{n_i}{2} \\frac{1}{m_i} = \\frac{n_i(n_i - 1)}{2 m_i}$. By setting the secondary table size to $m_i = n_i^2$: $E[X] \\le \\frac{n_i(n_i - 1)}{2 n_i^2} = \\frac{n_i - 1}{2 n_i} < \\frac{1}{2}$. Since $X$ is a non-negative integer counting the number of collisions, Markov's Inequality states: $\\Pr[X \\ge 1] \\le E[X] < \\frac{1}{2}$. Therefore, the probability of having ZERO collisions is $\\Pr[X = 0] = 1 - \\Pr[X \\ge 1] > 1 - \\frac{1}{2} = \\frac{1}{2}$. This means a random universal hash function chosen from the family will have zero collisions with over $50\\%$ probability, requiring at most 2 random draws on average!" },
        { "text": "Because squaring a number makes all collisions physically impossible in RAM", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because secondary tables delete duplicate keys automatically", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because FKS tables only store numbers smaller than 10", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
