# Duofy Reusable Lesson Format: Master Theorem and Recurrence Relations

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Algorithm_Design_Techniques / Divide_and_Conquer`  
**Lesson Format Type:** `master_theorem_and_recurrence_relations`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the asymptotic complexity analysis, recursion tree methodology, and master theorem cases of divide-and-conquer recurrences (Jon L. Bentley, Dorothea Haken, James B. Saxe 1980; Thomas H. Cormen et al. CLRS): master the canonical recurrence form **$T(n) = a T(n/b) + f(n)$** ($a \ge 1, b > 1$), formulate the critical watershed exponent **$n^{\log_b a}$** (representing total work done across the leaf level of the recursion tree), evaluate the **Three Cases of the Master Theorem** (**Case 1: Leaves Dominate** $f(n) = O(n^{\log_b a - \epsilon}) \implies T(n) = \Theta(n^{\log_b a})$; **Case 2: Even Balance** $f(n) = \Theta(n^{\log_b a} \lg^k n) \implies T(n) = \Theta(n^{\log_b a} \lg^{k+1} n)$; **Case 3: Root Dominates** $f(n) = \Omega(n^{\log_b a + \epsilon})$ with regularity $a f(n/b) \le c f(n) \implies T(n) = \Theta(f(n))$), and solve benchmark recurrences (Merge Sort, Binary Search, Strassen).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Master Theorem Formulation & The 3 Complexity Cases Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Application of Master Theorem to Solve a Recurrence Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Recurrence Relation / Algorithm & Master Theorem Case / Complexity Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Constant Factor Parameter 'b' in T(n) = a T(n/b) + f(n) Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Identification of the Applicable Master Theorem Case for a Given Recurrence Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State The Master Theorem (CLRS; Bentley et al. 1980):
   - **The Master Recurrence Equation:**
     $$\mathbf{T(n) = a T\left(\frac{n}{b}\right) + f(n) \qquad (a \ge 1, \ b > 1)}$$
     - $a$: Number of subproblems generated in each recursive step.
     - $b$: Subproblem size reduction factor.
     - $f(n)$: Work performed outside recursion (divide + combine steps).
     - **The Critical Watershed Function:** $\mathbf{n^{\log_b a}}$ (Total leaf-level cost).
   - **The 3 Master Theorem Cases:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Case} & \textbf{Condition on } f(n) \text{ vs } n^{\log_b a} & \textbf{Dominant Work} & \textbf{Asymptotic Solution } T(n) \\
     \hline
     \mathbf{\text{Case 1}} & f(n) = O(n^{\log_b a - \epsilon}) \ (\epsilon > 0) & \text{Leaves Dominate} & \mathbf{T(n) = \Theta(n^{\log_b a})} \\
     \mathbf{\text{Case 2}} & f(n) = \Theta(n^{\log_b a} \lg^k n) \ (k \ge 0) & \text{Evenly Distributed} & \mathbf{T(n) = \Theta(n^{\log_b a} \lg^{k+1} n)} \\
     \mathbf{\text{Case 3}} & f(n) = \Omega(n^{\log_b a + \epsilon}) \ (\text{Regularity: } a f(n/b) \le c f(n)) & \text{Root Dominates} & \mathbf{T(n) = \Theta(f(n))} \\
     \hline
     \end{array}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of evaluating an unknown recurrence relation using the Master Theorem: (1) inspect the recurrence equation to extract the parameters a (number of subproblems), b (shrinkage factor), and the combine function f(n), (2) compute the critical watershed value log_b(a) and formulate the leaf power function n^(log_b a), (3) compare the asymptotic growth rate of f(n) against n^(log_b a) to test for polynomial difference, (4) identify which of the 3 cases applies (Case 1 if f(n) is polynomially smaller, Case 2 if matching, Case 3 if polynomially larger), (5) write out the final closed-form Theta asymptotic bound for T(n)!
3. **Slide 3 (`matching`):** Pair 4 classic divide-and-conquer algorithms (Merge Sort T(n)=2T(n/2)+n, Binary Search T(n)=T(n/2)+1, Strassen T(n)=7T(n/2)+n^2, Karatsuba T(n)=3T(n/2)+n) with their Master Theorem complexities.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in T(n) = a*T(n/b) + f(n), the parameter 'a' represents the number of subproblems. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on solving a specific recurrence relation using the Master Theorem: Solve the recurrence relation $T(n) = 8 T(n/2) + 1000 n^2$ using the Master Theorem. What is the asymptotic time complexity of $T(n)$? ($a = 8, b = 2 \implies n^{\log_b a} = n^{\log_2 8} = n^3$; since $f(n) = 1000 n^2 = O(n^{3 - \epsilon})$ with $\epsilon = 1$, **Case 1 applies, yielding $T(n) = \Theta(n^3)$**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "master_theorem_and_recurrence_relations",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Master Theorem for Recurrences (CLRS)**\n• **The Master Equation:** $\\mathbf{T(n) = a T(n/b) + f(n)} \\quad (a \\ge 1, \\ b > 1)$.\n• **The Watershed Metric:** $\\mathbf{n^{\\log_b a}}$ (Total work across tree leaves).\n• **The 3 Master Cases:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Case} & \\textbf{Condition} & \\textbf{Solution } T(n) \\\\\n\\hline\n\\mathbf{1.\\ \\text{Leaves Dominate}} & f(n) = O(n^{\\log_b a - \\epsilon}) \\ (\\epsilon > 0) & \\mathbf{\\Theta(n^{\\log_b a})} \\\\\n\\mathbf{2.\\ \\text{Even Balance}} & f(n) = \\Theta(n^{\\log_b a} \\lg^k n) \\ (k \\ge 0) & \\mathbf{\\Theta(n^{\\log_b a} \\lg^{k+1} n)} \\\\\n\\mathbf{3.\\ \\text{Root Dominates}} & f(n) = \\Omega(n^{\\log_b a + \\epsilon}) \\ (a f(n/b) \\le c f(n)) & \\mathbf{\\Theta(f(n))} \\\\\n\\hline\n\\end{array}\n$$\n• **Examples:** Merge Sort ($T(n) = 2T(n/2) + n \\implies \\Theta(n\\log n)$, Case 2)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential analytical steps of applying the Master Theorem to solve a divide-and-conquer recurrence.",
      "orderItems": [
        "Extract the integer parameters a (number of subproblems) and b (division factor) and identify the combine function f(n)",
        "Calculate the critical logarithmic exponent log_b(a) and write out the leaf comparison function n^(log_b a)",
        "Compare the asymptotic growth rate of f(n) against n^(log_b a) to test for a polynomial difference (epsilon > 0)",
        "Classify the recurrence under Case 1 (leaves dominate), Case 2 (balanced), or Case 3 (root dominates with regularity)",
        "Write out the definitive asymptotic Theta bound for the overall recurrence T(n)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each classic recurrence relation to its exact asymptotic time complexity.",
      "matchPairs": [
        { "left": "T(n) = 2T(n/2) + O(n) [Merge Sort]", "right": "Theta(n log n) [Master Theorem Case 2 with k = 0]" },
        { "left": "T(n) = T(n/2) + O(1) [Binary Search]", "right": "Theta(log n) [Master Theorem Case 2 with n^0 and k = 0]" },
        { "left": "T(n) = 7T(n/2) + O(n^2) [Strassen]", "right": "Theta(n^(log2 7)) ≈ Theta(n^2.807) [Master Theorem Case 1]" },
        { "left": "T(n) = 3T(n/2) + O(n) [Karatsuba]", "right": "Theta(n^(log2 3)) ≈ Theta(n^1.585) [Master Theorem Case 1]" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Master Theorem recurrence equation T(n) = a*T(n/b) + f(n), the parameter 'a' represents the number of ___ created in each step.",
      "blankAnswer": "subproblems",
      "blankDistractors": ["elements", "arrays", "matrices"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Using the Master Theorem, what is the exact asymptotic time complexity of the recurrence relation T(n) = 8 T(n/2) + 1000 n^2?",
      "options": [
        { "text": "T(n) = Theta(n^3); here a = 8 and b = 2, so the watershed leaf function is n^(log_b a) = n^(log_2 8) = n^3; since f(n) = 1000 n^2 = O(n^(3 - 1)), f(n) is polynomially smaller than n^3 (Case 1 applies with epsilon = 1), meaning leaf-level work completely dominates the computation", "isCorrect": true, "explanation": "Correct! Let us systematically apply the Master Theorem to T(n) = 8 T(n/2) + 1000 n^2: Step 1: Identify parameters: a = 8, b = 2, and f(n) = 1000 n^2. Step 2: Compute n^(log_b a): log_2(8) = 3, so n^(log_b a) = n^3. Step 3: Compare f(n) to n^3: We have f(n) = 1000 n^2. Does f(n) grow strictly slower than n^3 by a polynomial factor? Yes, because 1000 n^2 = O(n^(3 - epsilon)) for epsilon = 1.0 (since n^2 is a full power of n smaller than n^3). Step 4: Apply Case 1: According to Case 1 of the Master Theorem, when f(n) is polynomially smaller than n^(log_b a), the total runtime is determined entirely by the bottom leaf level of the recursion tree. Therefore, T(n) = Theta(n^(log_b a)) = Theta(n^3)." },
        { "text": "T(n) = Theta(n^2 log n) because Case 2 applies", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "T(n) = Theta(n^2) because 1000 n^2 is the largest term in the equation", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "T(n) = Theta(8^n) because the coefficient is 8", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
