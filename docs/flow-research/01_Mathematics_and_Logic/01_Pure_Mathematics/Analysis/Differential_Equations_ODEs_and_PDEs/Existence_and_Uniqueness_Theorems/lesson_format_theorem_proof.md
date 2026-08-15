# Duofy Reusable Lesson Format: Existence and Uniqueness Theorems - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Differential_Equations_ODEs_and_PDEs / Existence_and_Uniqueness_Theorems`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof of the **Picard-Lindelöf Theorem** using the **Banach Fixed-Point Theorem** on the complete metric space $(C([t_0-\delta, t_0+\delta]), \|\cdot\|_\infty)$, and prove uniqueness using **Grönwall's Inequality**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Contraction Mapping Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Contraction Operator Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Time-Step Contraction Bound Justification | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Grönwall Uniqueness Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Fixed Point Operator Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Fixed-Point reformulation: $y(t) = (Ty)(t) = y_0 + \int_{t_0}^t f(s, y(s))ds$ with contraction constant $k = L \delta < 1$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof: (1) set up the complete metric space of continuous functions $X = \{y \in C(I) \mid \|y - y_0\|_\infty \le b\}$, (2) prove $T(X) \subseteq X$ by bounding $|(Ty)(t) - y_0| \le M \delta \le b$, (3) prove $T$ is a contraction: $\|Ty_1 - Ty_2\|_\infty \le L \delta \|y_1 - y_2\|_\infty$, (4) choose $\delta < \min(a, b/M, 1/L)$, (5) apply Banach Fixed-Point Theorem to guarantee a unique fixed point $y^* = Ty^*$.
3. **Slide 3 (`quiz`):** Test why choosing $\delta < 1/L$ guarantees that the Picard operator is a strict contraction.
4. **Slide 4 (`proof`):** Interactive derivation using Grönwall's inequality on $u(t) = |y_1(t) - y_2(t)|$ to prove uniqueness across any interval where solutions exist.
5. **Slide 5 (`one_word`):** Plain-text recall of the French mathematician who developed the iterative method (Picard).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Picard-Lindelöf via Banach Fixed-Point Theorem**\nLet $X = \\{y \\in C([t_0-\\delta, t_0+\\delta]) \\mid \\|y - y_0\\_\\infty \\le b\\}$ equipped with the supremum norm $\\|y\\_\\infty = \\max |y(t)|$.\nDefine the Picard operator:\n$$\n(Ty)(t) = y_0 + \\int_{t_0}^t f(s, y(s))\\,ds\n$$\nIf $\\delta < \\min(a, b/M, 1/L)$, then $T$ is a **strict contraction mapping** on the complete metric space $X$, having a unique fixed point $y = Ty$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps of the Picard-Lindelöf Contraction Mapping proof.",
      "orderItems": [
        "Reformulate the ODE IVP y' = f(t, y), y(t_0) = y_0 as the integral operator equation y = Ty",
        "Show that for delta <= b/M, the operator maps the closed subset X into itself: |(Ty)(t) - y_0| <= M |t - t_0| <= M delta <= b",
        "Apply the Lipschitz condition to bound |(Ty_1)(t) - (Ty_2)(t)| <= L |t - t_0| ||y_1 - y_2||_infty <= (L delta) ||y_1 - y_2||_infty",
        "Choose delta < 1/L so that the Lipschitz constant k = L delta < 1 (strict contraction)",
        "Invoke the Banach Fixed-Point Theorem to conclude that a unique continuous solution exists on [t_0-delta, t_0+delta]"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the condition delta < 1/L sufficient to guarantee that the Picard operator T is a contraction?",
      "options": [
        { "text": "Because ||Ty_1 - Ty_2||_infty <= (L delta) ||y_1 - y_2||_infty, and L delta < 1 makes the operator strictly contract distances", "isCorrect": true, "explanation": "Correct! A map is a contraction on a metric space if d(Tx, Ty) <= k d(x, y) with k < 1." },
        { "text": "Because it forces L to equal 0", "isCorrect": false, "explanation": "Incorrect: L is the fixed Lipschitz constant of the function f." },
        { "text": "Because it makes f linear", "isCorrect": false, "explanation": "Incorrect: f can be non-linear." },
        { "text": "Because delta must be infinite", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Uniqueness via Grönwall's Inequality",
      "interactiveSteps": [
        {
          "stepText": "Let y_1(t) and y_2(t) be two solutions with y_1(t_0) = y_2(t_0) = y_0. Define u(t) = |y_1(t) - y_2(t)|."
        },
        {
          "prompt": "Subtracting the integral equations gives u(t) <= integral_{t_0}^t L u(s) ds. By Grönwall's inequality with alpha = 0, what is the maximum value of u(t)?",
          "options": [
            { "text": "u(t) <= 0 * e^{L(t - t_0)} = 0, so y_1(t) = y_2(t) identically", "isCorrect": true },
            { "text": "u(t) = e^{Lt}", "isCorrect": false },
            { "text": "u(t) = L", "isCorrect": false },
            { "text": "u(t) is unbounded", "isCorrect": false }
          ]
        },
        {
          "stepText": "Thus, the two solutions must be identical everywhere, proving uniqueness."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the name of the French mathematician whose iterative integral method constructs the unique solution to the IVP?",
      "blankAnswer": "picard"
    }
  ]
}
```
