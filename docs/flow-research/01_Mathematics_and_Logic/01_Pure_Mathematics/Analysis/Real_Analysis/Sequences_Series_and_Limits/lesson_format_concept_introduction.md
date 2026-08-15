# Duofy Reusable Lesson Format: Sequences, Series, and Limits - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Real_Analysis / Sequences_Series_and_Limits`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the rigorous $\epsilon$-$N$ definition of sequence limits, the Cauchy Criterion for completeness, the distinction between Pointwise and Uniform convergence of function sequences, and the Weierstrass M-test.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Sequence Limit & Uniform Convergence Formal Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Pointwise vs Uniform Convergence Game Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Convergence Test & Series Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Cauchy Criterion Finiteness Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Non-Uniform Pointwise Limit Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the $\epsilon$-$N$ definition of sequence convergence ($|a_n - L| < \epsilon$ for $n > N$) and uniform convergence of functions ($\|f_n - f\|_\infty = \sup_{x \in E} |f_n(x) - f(x)| \to 0$).
2. **Slide 2 (`concept_pieces`):** Deconstruct Cauchy sequence completeness, Bolzano-Weierstrass subsequence extraction, continuity preservation under uniform limits, and Weierstrass M-test.
3. **Slide 3 (`matching`):** Pair 4 convergence tests (Ratio test, Alternating series test, Integral test, Weierstrass M-test) with their mathematical condition.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that every Cauchy sequence in $\mathbb{R}$ converges due to the completeness of the real numbers. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking why $f_n(x) = x^n$ on $[0, 1]$ fails to converge uniformly (it converges to a discontinuous limit function).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Limits and Uniform Convergence**\n• A sequence $(a_n)$ in $\\mathbb{R}$ **converges** to $L$ ($a_n \\to L$) if:\n$$\n\\forall \\epsilon > 0, \\; \\exists N \\in \\mathbb{N} \\quad \\text{such that } \\forall n > N, \\; |a_n - L| < \\epsilon\n$$\n• A sequence of functions $(f_n)$ converges **uniformly** to $f$ on set $E$ if:\n$$\n\\lim_{n \\to \\infty} \\left( \\sup_{x \\in E} |f_n(x) - f(x)| \\right) = 0\n$$\nUniform convergence guarantees that the limit of continuous functions is continuous."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Cauchy Completeness:** $(a_n)$ converges in $\\mathbb{R}$ if and only if $\\forall \\epsilon > 0, \\exists N$ such that $|a_n - a_m| < \\epsilon$ for all $n, m > N$.\n• **Bolzano-Weierstrass:** Every bounded sequence in $\\mathbb{R}$ contains a convergent subsequence.\n• **Pointwise vs. Uniform:** Pointwise convergence allows the index $N(\\epsilon, x)$ to depend on $x$; uniform convergence requires a single $N(\\epsilon)$ for all $x \\in E$.\n• **Weierstrass M-Test:** If $|f_n(x)| \\le M_n$ on $E$ and $\\sum M_n < \\infty$, then $\\sum f_n(x)$ converges uniformly and absolutely on $E$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each real analysis test to its convergence criterion.",
      "matchPairs": [
        { "left": "Weierstrass M-Test", "right": "Uniform convergence of series bounded by summable constants |f_n(x)| <= M_n" },
        { "left": "Ratio Test", "right": "Absolute convergence if lim |a_{n+1} / a_n| < 1" },
        { "left": "Leibniz Alternating Series Test", "right": "Convergence of sum (-1)^n a_n for monotonically decreasing a_n -> 0" },
        { "left": "Cauchy Condensation Test", "right": "sum a_n converges iff sum 2^k a_{2^k} converges for non-increasing a_n" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Every Cauchy sequence of real numbers converges to a real limit because the real line satisfies the metric property of ___.",
      "blankAnswer": "completeness",
      "blankDistractors": ["compactness", "connectedness", "convexity"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the sequence of functions f_n(x) = x^n on the closed interval [0, 1] FAIL to converge uniformly?",
      "options": [
        { "text": "Each f_n is continuous, but the pointwise limit f(x) (0 for x < 1, and 1 for x = 1) is discontinuous at x = 1", "isCorrect": true, "explanation": "Correct! By the Uniform Limit Theorem, uniform convergence of continuous functions forces the limit to be continuous; discontinuity proves non-uniformity." },
        { "text": "Because the terms f_n(x) diverge to infinity", "isCorrect": false, "explanation": "Incorrect: 0 <= x^n <= 1 for all x in [0, 1]." },
        { "text": "Because [0, 1] is not compact", "isCorrect": false, "explanation": "Incorrect: [0, 1] is compact." },
        { "text": "Because x^n has no derivative", "isCorrect": false, "explanation": "Incorrect: x^n is infinitely differentiable." }
      ]
    }
  ]
}
```
