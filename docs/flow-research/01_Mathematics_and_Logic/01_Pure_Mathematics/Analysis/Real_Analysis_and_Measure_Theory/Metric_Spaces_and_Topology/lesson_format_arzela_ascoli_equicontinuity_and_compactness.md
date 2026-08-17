# Duofy Reusable Lesson Format: Arzelà-Ascoli Theorem, Equicontinuity, and Compactness

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Real_Analysis_and_Measure_Theory / Metric_Spaces_and_Topology`  
**Lesson Format Type:** `arzela_ascoli_equicontinuity_and_compactness`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly evaluate the **Arzelà-Ascoli Theorem**, determine whether a family of functions is **equicontinuous** (e.g. via uniform derivative bounds $|f'(x)| \le M$), apply Cantor's diagonal argument to extract uniformly convergent subsequences, and calculate compact closure in $(C(K), \|\cdot\|_\infty)$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Arzelà-Ascoli Compactness Criterion Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Equicontinuity Verification Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Equicontinuity Delta Uniformity Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Lipschitz Constant Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Non-Equicontinuous Sequence Failure Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Arzelà-Ascoli Theorem: Let $K$ be a compact metric space. A subset $\mathcal{F} \subseteq C(K)$ is relatively compact (has compact closure in the supremum norm $\|\cdot\|_\infty$) if and only if $\mathcal{F}$ is **pointwise bounded** and **equicontinuous**.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) let $f_n(x) = \sin(nx) / n$ on $[0, \pi]$, (2) uniform boundedness: $|f_n(x)| \le 1/n \le 1$ for all $n$, (3) equicontinuity check: $|f_n'(x)| = |\cos(nx)| \le 1$; by Mean Value Theorem, $|f_n(x) - f_n(y)| \le 1 \cdot |x - y|$; choosing $\delta = \epsilon$ works simultaneously for *all* $n$, (4) conclusion: by Arzelà-Ascoli, $\{f_n\}$ has a uniformly convergent subsequence (which converges uniformly to $f \equiv 0$).
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that equicontinuity requires the choice of delta to depend only on epsilon, uniformly across all functions in the family. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the uniform Lipschitz derivative bound $M = \sup_{n, x} |f_n'(x)|$ for $f_n(x) = \frac{\cos(3nx)}{n}$ on $[0, 1]$ ($|f_n'(x)| = | -3\sin(3nx) | \le 3.0$).
5. **Slide 5 (`quiz`):** Quiz analyzing the sequence $f_n(x) = x^n$ on $[0, 1]$: Why does $\{f_n\}$ fail to have a uniformly convergent subsequence in $C[0, 1]$? (It is bounded by 1, but fails equicontinuity near $x = 1$, where derivatives $f_n'(1) = n \to \infty$ grow without bound, leading to a discontinuous limit).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "arzela_ascoli_equicontinuity_and_compactness",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Arzelà-Ascoli Theorem**\nLet $K$ be a **compact metric space** and let $\\mathcal{F} \\subseteq C(K)$ be a family of continuous functions.\n• $\\mathcal{F}$ has **compact closure** in $(C(K), \\|\\cdot\\|_\\infty)$ if and only if:\n  1. **Uniform Boundedness:** $\\exists M < \\infty$ such that $|f(x)| \\le M$ for all $f \\in \\mathcal{F}, x \\in K$.\n  2. **Equicontinuity:** $\\forall \\epsilon > 0, \\, \\exists \\delta > 0$ such that for **all** $f \\in \\mathcal{F}$:\n  $$\nd(x, y) < \\delta \\implies |f(x) - f(y)| < \\epsilon\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Candidate Family:** $f_n(x) = \\frac{\\sin(nx)}{n}$ on $[0, \\pi]$.\n• **Step 1 (Uniform Boundedness):** $|f_n(x)| = \\frac{|\\sin(nx)|}{n} \\le \\frac{1}{n} \\le 1$ for all $n \\ge 1$.\n• **Step 2 (Derivative Control):** $|f_n'(x)| = |\\cos(nx)| \\le 1$ for all $x \\in [0, \\pi]$ and all $n$.\n• **Step 3 (Equicontinuity via MVT):** $|f_n(x) - f_n(y)| \\le 1 \\cdot |x - y|$. Given $\\epsilon > 0$, choosing $\\delta = \\epsilon$ satisfies the condition for *all* $f_n$ simultaneously!\n• **Step 4 (Conclusion):** By Arzelà-Ascoli, $\{f_n\}$ is relatively compact and converges uniformly to $f(x) \\equiv 0$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In an equicontinuous family of functions, for every epsilon > 0, there exists a single delta > 0 that works ___ across all functions in the family.",
      "blankAnswer": "uniformly",
      "blankDistractors": ["pointwise", "discontinuously", "individually"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "What is the uniform Lipschitz derivative bound M = sup |f_n'(x)| on [0, 1] for the family f_n(x) = cos(3nx) / n?",
      "numericAnswer": 3.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the sequence of functions f_n(x) = x^n on the compact interval [0, 1] FAIL to have a uniformly convergent subsequence in C[0, 1]?",
      "options": [
        { "text": "Although uniformly bounded (|x^n| <= 1), the family fails equicontinuity near x = 1 because derivatives f_n'(1) = n grow unbounded, causing a discontinuous pointwise limit", "isCorrect": true, "explanation": "Correct! Near x = 1, slopes become infinitely steep, violating equicontinuity and resulting in a discontinuous step limit f(1) = 1, f(x) = 0 for x < 1." },
        { "text": "Because [0, 1] is not compact", "isCorrect": false, "explanation": "Incorrect: [0, 1] is compact." },
        { "text": "Because x^n is not differentiable", "isCorrect": false, "explanation": "Incorrect: x^n is smooth." },
        { "text": "Because x^n is unbounded", "isCorrect": false, "explanation": "Incorrect: |x^n| <= 1 is bounded." }
      ]
    }
  ]
}
```
