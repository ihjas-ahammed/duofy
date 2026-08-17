# Duofy Reusable Lesson Format: Poisson Brackets and Constants of Motion

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Mathematical_Physics / Classical_Mechanics_Formulations / Hamiltonian_Mechanics`  
**Lesson Format Type:** `poisson_brackets_and_constants_of_motion`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the algebraic properties of **Poisson Brackets** $\{f, g\}$, prove the **Jacobi Identity** and Leibniz product rule, derive the time evolution equation $\frac{df}{dt} = \{f, H\} + \frac{\partial f}{\partial t}$, and apply **Poisson's Theorem** to discover new constants of motion.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Poisson Bracket Algebraic Definition & Jacobi Identity | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Time Evolution & Lie Algebra Properties Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Canonical Poisson Bracket Values Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Angular Momentum Commutator {Lx, Ly} Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Conserved Quantity Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of the Poisson bracket of two phase space functions $f(q, p), g(q, p)$: $\{f, g\} = \sum_{i=1}^n \left(\frac{\partial f}{\partial q_i}\frac{\partial g}{\partial p_i} - \frac{\partial f}{\partial p_i}\frac{\partial g}{\partial q_i}\right)$. State the 4 Lie algebra axioms: antisymmetry $\{f, g\} = -\{g, f\}$, bilinearity, Leibniz rule $\{f, gh\} = \{f, g\}h + g\{f, h\}$, and the Jacobi identity $\{f, \{g, h\}\} + \{g, \{h, f\}\} + \{h, \{f, g\}\} = 0$.
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the time evolution of an observable $f(q, p, t)$: (1) write the total time derivative $\frac{df}{dt} = \sum \left(\frac{\partial f}{\partial q_i}\dot{q}_i + \frac{\partial f}{\partial p_i}\dot{p}_i\right) + \frac{\partial f}{\partial t}$, (2) substitute Hamilton's equations $\dot{q}_i = \frac{\partial H}{\partial p_i}$ and $\dot{p}_i = -\frac{\partial H}{\partial q_i}$, (3) identify the summation: $\sum \left(\frac{\partial f}{\partial q_i}\frac{\partial H}{\partial p_i} - \frac{\partial f}{\partial p_i}\frac{\partial H}{\partial q_i}\right) = \{f, H\}$, (4) obtain the master dynamical evolution equation $\frac{df}{dt} = \{f, H\} + \frac{\partial f}{\partial t}$, (5) conclude that if $\partial_t f = 0$, $f$ is a constant of motion $\iff \{f, H\} = 0$.
3. **Slide 3 (`quiz`):** Test the fundamental canonical Poisson brackets: What are the exact values of $\{q_i, q_j\}$, $\{p_i, p_j\}$, and $\{q_i, p_j\}$? ($\{q_i, q_j\} = 0, \{p_i, p_j\} = 0, \{q_i, p_j\} = \delta_{ij}$).
4. **Slide 4 (`proof`):** Interactive derivation of the angular momentum Poisson bracket $\{L_x, L_y\} = L_z$ where $L_x = y p_z - z p_y$ and $L_y = z p_x - x p_z$, illustrating the classical $\mathfrak{so}(3)$ Lie algebra.
5. **Slide 5 (`one_word`):** Plain-text recall of the term used for a phase space function whose total time derivative is zero along trajectories (integral / invariant).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "poisson_brackets_and_constants_of_motion",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Poisson Brackets and Lie Algebra Structure**\nFor two smooth functions $f, g: T^*Q \\to \\mathbb{R}$ on phase space:\n$$\n\\{f, g\\} = \\sum_{i=1}^n \\left( \\frac{\\partial f}{\\partial q_i} \\frac{\\partial g}{\\partial p_i} - \\frac{\\partial f}{\\partial p_i} \\frac{\\partial g}{\\partial q_i} \\right)\n$$\n• **Lie Algebra Properties:**\n  1. **Antisymmetry:** $\\{f, g\\} = -\\{g, f\\} \\implies \\{f, f\\} = 0$.\n  2. **Leibniz Product Rule:** $\\{f, gh\\} = \\{f, g\\}h + g\\{f, h\\}$.\n  3. **Jacobi Identity:** $\\{f, \\{g, h\\}\\} + \\{g, \\{h, f\\}\\} + \\{h, \\{f, g\\}\\} = 0$.\n• **Poisson's Theorem:** If $f$ and $g$ are constants of motion ($\\{f, H\\} = 0, \\{g, H\\} = 0$), then their Poisson bracket $\\{f, g\\}$ is also a **constant of motion**."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps establishing the time evolution equation for any dynamical observable f(q, p, t).",
      "orderItems": [
        "Apply the multivariable chain rule to write df/dt = sum (partial f / partial q_i * q_dot_i + partial f / partial p_i * p_dot_i) + partial f / partial t",
        "Substitute Hamilton's canonical equations: q_dot_i = partial H / partial p_i and p_dot_i = - partial H / partial q_i",
        "Group the summation terms: sum (partial f / partial q_i * partial H / partial p_i - partial f / partial p_i * partial H / partial q_i)",
        "Recognize the exact algebraic definition of the Poisson bracket {f, H}",
        "Conclude the master dynamical equation: df/dt = {f, H} + partial f / partial t, proving that f is conserved iff {f, H} = 0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What are the exact values of the fundamental canonical Poisson brackets for generalized coordinates q_i and conjugate momenta p_j?",
      "options": [
        { "text": "{q_i, q_j} = 0, {p_i, p_j} = 0, and {q_i, p_j} = delta_{ij} (Kronecker delta)", "isCorrect": true, "explanation": "Correct! These three canonical relations define the classical Poisson algebra, matching the quantum canonical commutation relations [q_i, p_j] = i hbar delta_{ij}." },
        { "text": "{q_i, p_j} = 0 always", "isCorrect": false, "explanation": "Incorrect: {q_i, p_i} = 1." },
        { "text": "{q_i, q_j} = 1", "isCorrect": false, "explanation": "Incorrect: Coordinates Poisson-commute." },
        { "text": "{p_i, p_j} = delta_{ij}", "isCorrect": false, "explanation": "Incorrect: Momenta Poisson-commute." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Angular Momentum Poisson Bracket {L_x, L_y} = L_z",
      "interactiveSteps": [
        {
          "stepText": "Let L_x = y p_z - z p_y and L_y = z p_x - x p_z. Compute {L_x, L_y} = sum_{i=x,y,z} (partial L_x / partial r_i * partial L_y / partial p_i - partial L_x / partial p_i * partial L_y / partial r_i)."
        },
        {
          "prompt": "Evaluating the non-zero derivatives with respect to z and p_z, what do the two terms produce?",
          "options": [
            { "text": "(-p_y) * (-x) - (y) * (p_x) = x p_y - y p_x = L_z", "isCorrect": true },
            { "text": "0", "isCorrect": false },
            { "text": "L_x + L_y", "isCorrect": false },
            { "text": "-L_z", "isCorrect": false }
          ]
        },
        {
          "stepText": "Thus {L_x, L_y} = L_z, confirming that the classical angular momentum components form the Lie algebra so(3)."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the mathematical noun for a phase space function whose value remains strictly constant along all trajectories of a dynamical system?",
      "blankAnswer": "invariant"
    }
  ]
}
```
