# Duofy Reusable Lesson Format: Distribution Theory and Sobolev Spaces - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Functional_Analysis / Distribution_Theory_and_Sobolev_Spaces`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute weak derivatives of piecewise smooth functions (e.g. $f(x) = 1 - |x|$ on $[-1, 1]$), verify membership in Sobolev space $H^1([-1, 1])$, and calculate exact $H^1$ norms.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Weak Derivative Computation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Triangle Function Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Integration by Parts Boundary Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical $H^1$ Norm Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Sobolev Embedding Dimension Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the test for weak differentiability: For $u(x) = 1 - |x|$ on $(-1, 1)$, test with $\phi \in C_c^\infty(-1, 1)$ to verify if $v(x) = -\text{sgn}(x)$ satisfies $-\int_{-1}^1 u \phi' dx = \int_{-1}^1 v \phi dx$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) split integral $\int_{-1}^0 (1+x)\phi' dx + \int_0^1 (1-x)\phi' dx$, (2) integrate by parts on each piece, (3) show boundary terms at 0 cancel because $u$ is continuous: $(1+0)\phi(0) - (1-0)\phi(0) = 0$, (4) identify weak derivative $u'(x) = -\text{sgn}(x) \in L^2(-1, 1) \implies u \in H^1(-1, 1)$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that continuous piecewise $C^1$ functions have weak derivatives in $L^2$. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute $\|u'\|_{L^2}^2 = \int_{-1}^1 (-\text{sgn}(x))^2 dx = \int_{-1}^1 1 dx = 2.0$.
5. **Slide 5 (`quiz`):** Quiz asking for the 1D Sobolev embedding theorem: Why is any function in $H^1(\mathbb{R})$ automatically continuous? ($k=1, p=2, n=1 \implies k - n/p = 1 - 1/2 = 1/2 > 0$, so $H^1(\mathbb{R}) \hookrightarrow C^{0, 1/2}(\mathbb{R})$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Weak Derivative of Triangle Function $u(x) = 1 - |x|$**\nLet $u(x) = 1 - |x|$ on $\\Omega = (-1, 1)$.\nTo find its weak derivative $v = u'$, evaluate $-\\int_{-1}^1 u(x) \\phi'(x)\\,dx$ for any test function $\\phi \\in C_c^\\infty(-1, 1)$:\n$$\n-\\int_{-1}^1 u \\phi'\\,dx = -\\int_{-1}^0 (1+x)\\phi'\\,dx - \\int_0^1 (1-x)\\phi'\\,dx\n$$\nIntegrate each interval by parts to isolate $\\phi(x)$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (First Interval):** $-\\int_{-1}^0 (1+x)\\phi'\\,dx = -[(1+x)\\phi(x)]_{-1}^0 + \\int_{-1}^0 1\\cdot\\phi\\,dx = -\\phi(0) + \\int_{-1}^0 \\phi\\,dx$.\n• **Step 2 (Second Interval):** $-\\int_0^1 (1-x)\\phi'\\,dx = -[(1-x)\\phi(x)]_0^1 + \\int_0^1 (-1)\\cdot\\phi\\,dx = +\\phi(0) - \\int_0^1 \\phi\\,dx$.\n• **Step 3 (Boundary Cancellation):** The terms $-\\phi(0) + \\phi(0) = 0$ cancel completely because $u(x)$ is continuous at $x = 0$.\n• **Step 4 (Identify Weak Derivative):** $-\\int_{-1}^1 u\\phi'\\,dx = \\int_{-1}^0 (+1)\\phi\\,dx + \\int_0^1 (-1)\\phi\\,dx = \\int_{-1}^1 (-\\text{sgn}(x))\\phi\\,dx$. Thus $u'(x) = -\\text{sgn}(x) \\in L^2(-1, 1)$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "Piecewise C^1 functions have weak derivatives in L^2 if and only if they have no jump ___ across subinterval boundaries.",
      "blankAnswer": "discontinuities",
      "blankDistractors": ["derivatives", "constants", "roots"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "For u(x) = 1 - |x| on [-1, 1] with weak derivative u'(x) = -sgn(x), compute the squared L^2 norm of the derivative: int_{-1}^1 (u'(x))^2 dx.",
      "numericAnswer": 2.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is every function in the 1D Sobolev space H^1([a, b]) guaranteed to be Hölder continuous?",
      "options": [
        { "text": "By the Sobolev Embedding Theorem, k - n/p = 1 - 1/2 = 1/2 > 0, ensuring H^1([a, b]) embeds continuously into C^{0, 1/2}([a, b])", "isCorrect": true, "explanation": "Correct! When k > n/p (here 1 > 1/2), functions in the Sobolev space are continuous by Morrey's inequality." },
        { "text": "Because all L^2 functions are continuous", "isCorrect": false, "explanation": "Incorrect: General L^2 functions can be discontinuous everywhere." },
        { "text": "Because [a, b] is bounded", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the derivative is identically zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
