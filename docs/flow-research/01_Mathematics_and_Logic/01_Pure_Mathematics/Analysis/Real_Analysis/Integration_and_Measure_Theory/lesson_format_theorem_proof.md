# Duofy Reusable Lesson Format: Integration and Measure Theory - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Real_Analysis / Integration_and_Measure_Theory`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof and interconnections of the **Monotone Convergence Theorem (MCT)**, **Fatou's Lemma**, and the **Dominated Convergence Theorem (DCT)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Dominated Convergence Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | DCT Proof from Fatou Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Non-Negative Function Construction Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Fatou's Lemma from MCT Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Measure Differentiation Derivative Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Dominated Convergence Theorem (DCT): Let $\{f_n\}$ be measurable functions with $f_n(x) \to f(x)$ a.e. If there exists $g \in L^1(\mu)$ such that $|f_n(x)| \le g(x)$ a.e. for all $n$, then $f \in L^1(\mu)$ and $\lim_{n\to\infty} \int f_n d\mu = \int f d\mu$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof of DCT: (1) apply Fatou's lemma to non-negative sequence $g + f_n \ge 0$, (2) obtain $\int (g + f) d\mu \le \liminf \int (g + f_n) d\mu = \int g d\mu + \liminf \int f_n d\mu$, (3) cancel finite $\int g d\mu$ to get $\int f d\mu \le \liminf \int f_n d\mu$, (4) apply Fatou to $g - f_n \ge 0$ to get $\limsup \int f_n d\mu \le \int f d\mu$, (5) combine inequalities to conclude $\lim_{n\to\infty} \int f_n d\mu = \int f d\mu$.
3. **Slide 3 (`quiz`):** Test why the integrability of the dominator $g \in L^1$ is necessary to subtract $\int g d\mu$ from both sides.
4. **Slide 4 (`proof`):** Interactive derivation proving Fatou's Lemma $\int \liminf f_n \le \liminf \int f_n$ by defining $g_k = \inf_{n \ge k} f_n$ and applying MCT to $g_k \uparrow \liminf f_n$.
5. **Slide 5 (`one_word`):** Plain-text recall of the hyphenated name of the theorem producing density derivatives of absolutely continuous measures (Radon-Nikodym).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Lebesgue's Dominated Convergence Theorem (DCT)**\nLet $(X, \\Sigma, \\mu)$ be a measure space, and let $(f_n)$ be a sequence of measurable functions such that $f_n(x) \\to f(x)$ almost everywhere.\nIf there exists an **integrable dominating function** $g \\in L^1(\\mu)$ such that:\n$$\n|f_n(x)| \\le g(x) \\quad \\text{for all } n \\text{ and a.e. } x \\in X\n$$\nThen $f \\in L^1(\\mu)$ and:\n$$\n\\lim_{n \\to \\infty} \\int_X f_n\\,d\\mu = \\int_X \\left( \\lim_{n \\to \\infty} f_n \\right)\\,d\\mu = \\int_X f\\,d\\mu\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps of the Dominated Convergence Theorem via Fatou's Lemma.",
      "orderItems": [
        "Construct the non-negative sequence u_n = g + f_n >= 0 almost everywhere",
        "Apply Fatou's Lemma to u_n: int (g + f) dmu <= liminf int (g + f_n) dmu = int g dmu + liminf int f_n dmu",
        "Subtract finite int g dmu from both sides to obtain the lower bound: int f dmu <= liminf int f_n dmu",
        "Construct the second non-negative sequence v_n = g - f_n >= 0, and apply Fatou to obtain: limsup int f_n dmu <= int f dmu",
        "Combine the two inequalities: limsup int f_n dmu <= int f dmu <= liminf int f_n dmu to conclude lim int f_n dmu = int f dmu"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the assumption that g is in L^1 (finite integral int g dmu < infty) strictly necessary to subtract int g dmu in the proof?",
      "options": [
        { "text": "If int g dmu = infinity, the algebraic cancellation (infinity - infinity) is undefined, making the inequality invalid", "isCorrect": true, "explanation": "Correct! Subtracting infinity from infinity is an indeterminate form; finiteness of int g is essential." },
        { "text": "Because g must be zero almost everywhere", "isCorrect": false, "explanation": "Incorrect: g is positive." },
        { "text": "Because f_n would become discontinuous", "isCorrect": false, "explanation": "Incorrect: Measurable functions need not be continuous." },
        { "text": "Because the domain X must be finite", "isCorrect": false, "explanation": "Incorrect: DCT holds on infinite measure spaces (like R) as long as g in L^1." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Fatou's Lemma from Monotone Convergence Theorem",
      "interactiveSteps": [
        {
          "stepText": "Let f_n >= 0. Define g_k = inf_{n >= k} f_n. Notice 0 <= g_1 <= g_2 <= ... is a non-decreasing sequence."
        },
        {
          "prompt": "Since g_k increases pointwise to liminf_{n -> infty} f_n, what does the Monotone Convergence Theorem state about lim int g_k dmu?",
          "options": [
            { "text": "lim_{k -> infty} int g_k dmu = int (liminf f_n) dmu", "isCorrect": true },
            { "text": "lim_{k -> infty} int g_k dmu = 0", "isCorrect": false },
            { "text": "lim_{k -> infty} int g_k dmu = infinity", "isCorrect": false },
            { "text": "lim_{k -> infty} int g_k dmu is undefined", "isCorrect": false }
          ]
        },
        {
          "stepText": "Since g_k <= f_n for all n >= k, int g_k dmu <= int f_n dmu for all n >= k, so int g_k <= inf_{n >= k} int f_n. Taking k -> infty proves int liminf f_n <= liminf int f_n."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the hyphenated surname of the theorem guaranteeing the existence of density derivatives for absolutely continuous measures?",
      "blankAnswer": "radon-nikodym"
    }
  ]
}
```
