# Duofy Reusable Lesson Format: Interval Scheduling and Greedy Stays Ahead Proofs

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Algorithm_Design_Techniques / Greedy_Algorithms`  
**Lesson Format Type:** `interval_scheduling_and_greedy_stays_ahead_proofs`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the algorithmic sorting criteria, linear scheduling loop, and formal mathematical induction proofs of the Interval (Activity) Scheduling problem (Jon Kleinberg & Éva Tardos; Thomas H. Cormen et al. CLRS): contrast failing greedy heuristics (**1. Earliest Start Time [fails for long intervals]**, **2. Shortest Interval Duration [fails for intervals blocking two others]**, **3. Fewest Overlaps**) with the provably optimal **Earliest Finish Time ($f_i$)** strategy, execute the $O(n\log n)$ sorting and $O(n)$ linear selection pass, and formulate the rigorous mathematical induction proof using the **"Greedy Stays Ahead" Method** (proving that for every step $r \le k$, the $r$-th greedy interval finishes no later than the $r$-th interval in any arbitrary optimal schedule: $\mathbf{f(i_r) \le f(j_r)}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Earliest Finish Time Strategy & The "Greedy Stays Ahead" Induction Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Interval Scheduling Sorting and Linear Selection Pass Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Greedy Candidate Heuristic & Counter-Example / Optimality Status Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Sorting Metric Key in the Optimal Interval Scheduling Strategy Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Mathematical Core of the "Greedy Stays Ahead" Induction Step Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Interval Scheduling & The "Greedy Stays Ahead" Proof (Kleinberg & Tardos; CLRS):
   - **The Problem Statement:** Given $n$ intervals with start time $s_i$ and finish time $f_i$, select a maximum-cardinality subset of mutually compatible (non-overlapping) intervals.
   - **The Optimal Greedy Rule:** Sort intervals by **Earliest Finish Time ($f_1 \le f_2 \le \dots \le f_n$)**.
     - Greedily pick the first interval $i_1$, discard all overlapping intervals ($s_j < f_1$), and repeat in $O(n\log n)$ time!
   - **The "Greedy Stays Ahead" Formal Induction Proof:**
     - Let Greedy select intervals $G = \langle i_1, i_2, \dots, i_k \rangle$. Let an arbitrary optimal schedule be $O = \langle j_1, j_2, \dots, j_m \rangle$ (where $m \ge k$).
     - **Induction Hypothesis:** For all $r \le k$, **$\mathbf{f(i_r) \le f(j_r)}$** (Greedy finishes no later than Optimal).
     - **Base Case ($r=1$):** True, because Greedy explicitly picks the interval with the absolute earliest finish time ($f(i_1) \le f(j_1)$).
     - **Inductive Step ($r \to r+1$):** By induction, $f(i_r) \le f(j_r)$. Since $O$ is valid, $s(j_{r+1}) \ge f(j_r) \ge f(i_r)$. This means $j_{r+1}$ is compatible with $i_r$! Since Greedy chooses the earliest available finish time among ALL compatible candidates, $f(i_{r+1}) \le f(j_{r+1})$.
     - **Conclusion:** If $m > k$, interval $j_{k+1}$ in $O$ would start after $f(j_k) \ge f(i_k)$, leaving an available candidate for Greedy, contradicting that Greedy terminated at $k$ $\implies \mathbf{k = m}$ (Greedy is Optimal!).
2. **Slide 2 (`ordering`):** Provide 5 steps of executing the Interval Scheduling algorithm: (1) sort all n input intervals in ascending order of their finish times f_i in O(n log n) time, (2) initialize an empty solution set S and set the finish time marker last_finish = -infinity, (3) iterate through the sorted intervals from index 1 to n, (4) if the current interval's start time s_i is greater than or equal to last_finish, add interval i to S and update last_finish = f_i, (5) return solution set S as the mathematically proven maximum-cardinality non-overlapping schedule!
3. **Slide 3 (`matching`):** Pair 4 interval scheduling heuristics (Earliest Finish Time, Earliest Start Time, Shortest Interval Duration, Fewest Conflicts) with their correctness status.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the provably optimal greedy interval scheduling strategy sorts by earliest finish time. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the fatal flaw of the "Shortest Duration" interval scheduling heuristic: Why does the intuitive greedy rule "always select the interval with the shortest duration ($f_i - s_i$)" fail to find the optimal schedule? (Because a single ultra-short interval can be positioned such that it **overlaps and conflicts with two longer non-overlapping intervals (one on its left, one on its right)**; selecting the short interval yields 1 task, while selecting the two outer intervals yields 2 tasks).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "interval_scheduling_and_greedy_stays_ahead_proofs",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Interval Scheduling & Greedy Stays Ahead**\n• **The Optimal Strategy:** Sort intervals by **Earliest Finish Time** ($f_1 \\le f_2 \\le \\dots \\le f_n$).\n• **The 'Greedy Stays Ahead' Proof (Kleinberg \\& Tardos):**\n  - Let Greedy produce $G = \\langle i_1, \\dots, i_k \\rangle$ and Optimal produce $O = \\langle j_1, \\dots, j_m \\rangle$.\n  - **Induction Claim:** For all $r \\le k$, $\\mathbf{f(i_r) \\le f(j_r)}$ (Greedy always finishes at least as early as Optimal).\n  - **Base Case ($r=1$):** $f(i_1) \\le f(j_1)$ by definition of Greedy choice.\n  - **Inductive Step ($r \\to r+1$):** Since $s(j_{r+1}) \\ge f(j_r) \\ge f(i_r)$, interval $j_{r+1}$ was available to Greedy $\\implies \\mathbf{f(i_{r+1}) \\le f(j_{r+1})}$!\n• **Optimality:** $G$ cannot terminate with fewer intervals than $O$ ($k = m$)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the O(n log n) Interval Scheduling greedy algorithm.",
      "orderItems": [
        "Sort all n input intervals in ascending order of their finish times f_i in O(n log n) time",
        "Initialize an empty schedule list S and set the tracker variable last_finish_time to -infinity",
        "Iterate through the sorted interval list from first to last",
        "If interval start time s_i is >= last_finish_time, append interval i to S and update last_finish_time = f_i",
        "Return the schedule set S containing the maximum possible number of mutually compatible tasks"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each interval scheduling heuristic to its algorithmic correctness status.",
      "matchPairs": [
        { "left": "Earliest Finish Time (f_i)", "right": "Provably optimal strategy maximizing available remaining time for future intervals" },
        { "left": "Earliest Start Time (s_i)", "right": "Fails: Selecting a very early start interval that spans the entire day blocks all other jobs" },
        { "left": "Shortest Interval Duration (f_i - s_i)", "right": "Fails: A tiny interval in the center can block two non-overlapping intervals on its sides" },
        { "left": "Fewest Overlap Conflicts", "right": "Fails: Pathological counter-examples exist where it selects suboptimal subsets" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The provably optimal greedy algorithm for maximum interval scheduling sorts all tasks in ascending order of their ___ time.",
      "blankAnswer": "finish",
      "blankDistractors": ["start", "duration", "arrival"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the intuitive greedy heuristic 'always pick the interval with the shortest duration (f_i - s_i)' fail to produce an optimal schedule?",
      "options": [
        { "text": "A single short interval (e.g. [10, 12]) can overlap with and destroy compatibility with two longer, mutually compatible intervals on either side (e.g. [0, 11] and [11, 20]); picking the shortest interval yields only 1 scheduled job, while picking the two non-overlapping intervals yields 2 scheduled jobs", "isCorrect": true, "explanation": "Correct! It is tempting to think that picking the shortest job leaves the maximum total free time, but this heuristic is flawed because of boundary overlaps. Consider three requests: Request A = [0, 11], Request B = [10, 12] (duration 2), and Request C = [11, 20]. Request A and Request C are completely compatible with each other (they do not overlap, since 11 <= 11). The optimal schedule selects both A and C, for a total of 2 completed tasks. However, the 'Shortest Duration' heuristic greedily selects Request B (length 2). Because B starts at 10 (conflicting with A) and finishes at 12 (conflicting with C), selecting B eliminates BOTH A and C from consideration, leaving a schedule of only 1 task (50% suboptimal). Only the 'Earliest Finish Time' strategy is mathematically guaranteed to be optimal because it frees up the resource at the earliest possible clock time." },
        { "text": "Because computer clocks cannot calculate subtraction between finish and start times", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because short intervals are always rejected by operating system schedulers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because shortest duration algorithms run in O(n!) factorial time", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
