# Duofy Reusable Lesson Format: Cauchy-Riemann Equations - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis / Cauchy_Riemann_Equations`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to determine whether a given function is harmonic, compute the exact harmonic conjugate $v(x, y)$ of a real harmonic function $u(x, y)$, and express the resulting holomorphic function $f(z) = u + iv$ in terms of the complex variable $z$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Harmonic Conjugate Finding Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Conjugate Integration Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Integration Constant Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Conjugate Evaluation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Non-Harmonic Disqualification Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the worked example: Find the harmonic conjugate $v(x, y)$ of $u(x, y) = x^2 - y^2 + 2x$ with $v(0, 0) = 0$, and find $f(z)$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) verify $\Delta u = 2 - 2 = 0$, (2) integrate $v_y = u_x = 2x + 2 \implies v = 2xy + 2y + g(x)$, (3) differentiate $v_x = 2y + g'(x) = -u_y = 2y \implies g'(x) = 0 \implies g(x) = C$, (4) assemble $f(z) = (x^2 - y^2 + 2x) + i(2xy + 2y) = z^2 + 2z$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that a harmonic conjugate is unique up to an additive constant. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to evaluate $v(2, 3)$ where $v(x, y) = 2xy + 2y$ ($v(2, 3) = 2(2)(3) + 2(3) = 12 + 6 = 18$).
5. **Slide 5 (`quiz`):** Quiz asking which given function CANNOT be the real part of any holomorphic function (i.e. fails $\Delta u = 0$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Worked Example: Finding the Harmonic Conjugate**\nLet $u(x, y) = x^2 - y^2 + 2x$. Find its harmonic conjugate $v(x, y)$ such that $v(0, 0) = 0$, and reconstruct $f(z) = u + iv$.\n$$\nu_x = 2x + 2, \\quad u_y = -2y, \\quad u_{xx} = 2, \\quad u_{yy} = -2\n$$\n$\\Delta u = u_{xx} + u_{yy} = 2 - 2 = 0$, so $u$ is harmonic on all of $\\mathbb{R}^2$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Integrate $v_y = u_x$):** $v_y = 2x + 2 \\implies v(x, y) = \\int (2x + 2)\\,dy = 2xy + 2y + g(x)$.\n• **Step 2 (Differentiate w.r.t. $x$):** $v_x = \\frac{\\partial}{\\partial x}(2xy + 2y + g(x)) = 2y + g'(x)$.\n• **Step 3 (Equate to $-u_y$):** $2y + g'(x) = -(-2y) = 2y \\implies g'(x) = 0 \\implies g(x) = C$.\n• **Step 4 (Assemble $f(z)$):** With $v(0,0)=0 \\implies C=0$, $v(x,y) = 2xy + 2y$. Thus $f(z) = (x^2 - y^2 + 2x) + i(2xy + 2y) = z^2 + 2z$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "On a connected domain, the harmonic conjugate v(x, y) of a harmonic function u(x, y) is unique up to an additive real ___.",
      "blankAnswer": "constant",
      "blankDistractors": ["function", "variable", "derivative"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "If u(x, y) = x^2 - y^2 + 2x and v(x, y) = 2xy + 2y, compute the value of the harmonic conjugate v at the point (x, y) = (2, 3).",
      "numericAnswer": 18.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Which of the following functions u(x, y) CANNOT be the real part of any holomorphic function?",
      "options": [
        { "text": "u(x, y) = x^2 + y^2", "isCorrect": true, "explanation": "Correct! u_{xx} + u_{yy} = 2 + 2 = 4 != 0, so x^2 + y^2 is not harmonic and cannot be the real part of a holomorphic function." },
        { "text": "u(x, y) = x^2 - y^2", "isCorrect": false, "explanation": "Incorrect: u_{xx} + u_{yy} = 2 - 2 = 0 (harmonic, real part of z^2)." },
        { "text": "u(x, y) = e^x cos(y)", "isCorrect": false, "explanation": "Incorrect: Harmonic (real part of e^z)." },
        { "text": "u(x, y) = 2xy", "isCorrect": false, "explanation": "Incorrect: Harmonic (real part of -i z^2)." }
      ]
    }
  ]
}
```
