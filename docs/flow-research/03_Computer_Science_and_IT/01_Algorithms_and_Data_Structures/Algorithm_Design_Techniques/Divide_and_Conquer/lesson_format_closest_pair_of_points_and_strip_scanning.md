# Duofy Reusable Lesson Format: Closest Pair of Points and Strip Scanning

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Algorithm_Design_Techniques / Divide_and_Conquer`  
**Lesson Format Type:** `closest_pair_of_points_and_strip_scanning`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the 2D computational geometry, divide-and-conquer decomposition, and geometric packing proofs of the Closest Pair of Points problem (Michael Ian Shamos & Dan Hoey 1975; Jon Kleinberg & Éva Tardos; Thomas H. Cormen et al. CLRS): contrast the naive $O(n^2)$ all-pairs distance comparison with the **$O(n\log n)$ Divide and Conquer Algorithm** (sorting points by $x$-coordinate, recursively finding minimum distance $\delta = \min(\delta_L, \delta_R)$ in left and right halves separated by vertical dividing line $x = x_{\text{mid}}$), master the **$2\delta$-Width Central Strip Scan**, prove the **Geometric Packing Invariant** (by dividing the $\delta \times 2\delta$ bounding rectangle into eight $\frac{\delta}{2} \times \frac{\delta}{2}$ sub-boxes, at most one point can occupy each box $\implies$ each point sorted by $y$-coordinate needs to be compared against **at most 7 subsequent points in $O(n)$ time**), and solve the Master Theorem recurrence ($T(n) = 2T(n/2) + O(n) \implies O(n\log n)$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Closest Pair 2D Decomposition & The 7-Point Strip Invariant Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Closest Pair of Points Execution Pipeline Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Closest Pair Component / Phase & Geometric Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Maximum Number of Subsequent Points Checked in the Strip Scan Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Geometric Packing Proof Bounding the Number of Strip Comparisons Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Closest Pair of Points in 2D (Shamos & Hoey 1975; CLRS):
   - **The Problem Statement:** Given $n$ points in the 2D Euclidean plane, find the pair $(p_i, p_j)$ minimizing Euclidean distance $d(p_i, p_j) = \sqrt{(x_i - x_j)^2 + (y_i - y_j)^2}$.
   - **The Divide and Conquer Architecture:**
     1. **Divide:** Sort by $x$-coordinate ($P_x$); split into $P_L$ and $P_R$ at median $x_{\text{mid}}$.
     2. **Conquer:** Recursively find closest pair in left ($\delta_L$) and right ($\delta_R$). Let $\mathbf{\delta = \min(\delta_L, \delta_R)}$.
     3. **Combine (The Strip Scan):**
        - Construct vertical strip of width $2\delta$: $S = \{p \in P \mid |x - x_{\text{mid}}| < \delta\}$.
        - Sort strip points by $y$-coordinate ($S_y$).
        - **The 7-Point Constant Bound:** For each point $p \in S_y$, check only points $q$ where $0 < q.y - p.y < \delta$. **There are at most 7 such points!**
   - **Time Complexity (Master Theorem Case 2):**
     $$\mathbf{T(n) = 2 T\left(\frac{n}{2}\right) + O(n) \implies \mathbf{T(n) = \Theta(n\log n) \quad (\text{Beating } O(n^2)!)}}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of the Closest Pair divide-and-conquer algorithm: (1) pre-sort all n input points by x-coordinate (Px) and by y-coordinate (Py) in O(n log n) time, (2) divide the x-sorted point set at the median x-coordinate into equal left (PL) and right (PR) subsets, (3) recursively compute the minimum closest pair distance delta_L in the left half and delta_R in the right half, setting delta = min(delta_L, delta_R), (4) filter points lying within distance delta of the vertical dividing line (the 2*delta strip) and collect them sorted by y-coordinate, (5) scan each strip point against at most 7 subsequent points in y-order to find any cross-border pair closer than delta, returning the global minimum!
3. **Slide 3 (`matching`):** Pair 4 Closest Pair concepts (Median Dividing Line, Delta = min(delta_L, delta_R), The 2-delta Strip, 7-Point Constant Bound) with their geometric functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in the strip scanning step, each point is compared against at most 7 subsequent points. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the pigeonhole/box-packing proof bounding the strip comparisons to a constant: Why is each point in the $y$-sorted strip guaranteed to have at most 7 candidate points within distance $\delta$ in the $2\delta \times \delta$ search rectangle? (Because the $2\delta \times \delta$ rectangle spans both sides of the dividing line and can be **divided into eight $\frac{\delta}{2} \times \frac{\delta}{2}$ square boxes**; because every pair of points in the same half is separated by at least $\delta$ (and the diagonal of each box is $d = \frac{\delta}{\sqrt{2}} < \delta$), **at most 1 point can reside in each box**, yielding at most $8 - 1 = \mathbf{7\text{ candidate points}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "closest_pair_of_points_and_strip_scanning",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Closest Pair of Points in 2D (1975)**\n• **Divide \\& Conquer Architecture:**\n  1. **Divide:** Split points at median line $x_{\\text{mid}}$ into $P_L$ and $P_R$.\n  2. **Conquer:** $\\delta_L = \\text{Closest}(P_L), \\ \\delta_R = \\text{Closest}(P_R) \\implies \\mathbf{\\delta = \\min(\\delta_L, \\delta_R)}$.\n  3. **Combine (Strip Scan):** Filter strip $|x - x_{\\text{mid}}| < \\delta$; sort by $y$.\n• **The 7-Point Geometric Invariant:**\n$$\n\\text{For each point } p \\in S_y, \\text{ check } q \\text{ where } 0 < q.y - p.y < \\delta \\implies \\mathbf{\\text{At most 7 candidates!}}\n$$\n• **Asymptotic Complexity:**\n$$\n\\mathbf{T(n) = 2 T(n/2) + O(n) \\implies \\mathbf{\\Theta(n\\log n) \\quad (\\text{Beats } O(n^2)!)}}}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential algorithmic steps of the 2D Closest Pair of Points divide-and-conquer solver.",
      "orderItems": [
        "Pre-sort the 2D point set by x-coordinate (Px) and by y-coordinate (Py) in O(n log n) preprocessing time",
        "Split the x-sorted point set at the median vertical line x_mid into equal left (PL) and right (PR) subsets",
        "Recursively find closest pair distances delta_L and delta_R, setting the baseline minimum delta = min(delta_L, delta_R)",
        "Extract all points within horizontal distance delta of the vertical line (|x - x_mid| < delta) in y-sorted order",
        "Scan each point in the strip against at most 7 subsequent points in y-order to check for cross-border distances < delta"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Closest Pair of Points component to its exact geometric role.",
      "matchPairs": [
        { "left": "Median Vertical Line (x_mid)", "right": "Spatial partition dividing the 2D point cloud into two equal halves of size n/2" },
        { "left": "Delta = min(delta_L, delta_R)", "right": "Current best known minimum distance established from recursive left and right subproblems" },
        { "left": "The 2*delta Strip", "right": "Vertical corridor around x_mid where potential cross-border closest pairs could reside" },
        { "left": "The 7-Point Constant Bound", "right": "Maximum number of candidate points that can fit in the delta x 2*delta box without violating delta" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the linear combine step of the 2D Closest Pair algorithm, each y-sorted strip point is compared against at most ___ subsequent points.",
      "blankAnswer": "7",
      "blankDistractors": ["15", "100", "2"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What geometric packing proof guarantees that any point in the y-sorted central strip needs to be compared against at most 7 subsequent points during the combine step?",
      "options": [
        { "text": "The candidate search area is a 2*delta by delta rectangle spanning the dividing line, which can be divided into eight (delta/2) x (delta/2) square sub-boxes; because the maximum diagonal distance inside each sub-box is delta / sqrt(2) < delta, no sub-box can contain more than 1 point from the same half without violating the definition of delta, bounding the maximum number of neighboring points to 8 - 1 = 7", "isCorrect": true, "explanation": "Correct! This is one of the most elegant geometric proofs in algorithm design. Consider a point p in the vertical strip with coordinates (x_p, y_p). Any candidate point q that could potentially be closer to p than delta must lie within the horizontal strip [x_mid - delta, x_mid + delta] and must have a y-coordinate in the range [y_p, y_p + delta]. This defines a rectangle of width 2*delta and height delta (a 2*delta x delta bounding box). Now, divide this rectangle in half along the vertical dividing line x_mid, creating two delta x delta squares (one on the left, one on the right). Divide each delta x delta square into four smaller (delta/2) x (delta/2) sub-boxes (giving 8 total sub-boxes in the rectangle). What is the maximum distance between any two points in the same (delta/2) x (delta/2) sub-box? By the Pythagorean theorem, the diagonal is d = sqrt((delta/2)^2 + (delta/2)^2) = delta / sqrt(2) ≈ 0.707 * delta. Because every pair of points in the left half is already separated by at least delta_L ≥ delta (and likewise in the right half), it is geometrically impossible for more than ONE point from the left half (or right half) to occupy the same sub-box! Since there are exactly 8 sub-boxes in total, at most 8 points can exist in the entire rectangle. Excluding the point p itself, there are AT MOST 8 - 1 = 7 other candidate points. Therefore, iterating through at most 7 subsequent points in the y-sorted array is mathematically sufficient to guarantee finding the closest pair in $O(n)$ time!" },
        { "text": "Because computer screens only have 7 pixels per row", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because 7 is a lucky prime number in computational geometry", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because divide and conquer algorithms always use the number 7", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
