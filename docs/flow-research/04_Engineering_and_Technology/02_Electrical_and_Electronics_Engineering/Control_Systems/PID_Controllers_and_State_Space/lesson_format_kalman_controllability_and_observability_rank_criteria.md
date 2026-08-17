# Duofy Reusable Lesson Format: Controllability & Observability (Kalman Rank Criteria)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Control_Systems / PID_Controllers_and_State_Space`  
**Lesson Format Type:** `kalman_controllability_and_observability_rank_criteria`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the fundamental dual concepts of structural state controllability and state observability, Kalman rank criteria, the Cayley-Hamilton theorem matrix subspace spans, uncontrollability/unobservability modal manifestations, and the Kalman Canonical Decomposition in modern multivariable control theory (Rudolf E. Kalman 1960; Katsuhiko Ogata *Modern Control Engineering* Chapter 10; Chi-Tsong Chen *Linear System Theory and Design* Chapter 6): formulate **Kalman's Controllability Rank Theorem**:
$$\mathbf{\text{A system } (\dot{x} = A x + B u) \text{ is Completely State Controllable } \Longleftrightarrow \mathbf{\text{Rank}(\mathcal{C}) = n}}$$
where the $n \times (n \cdot m)$ Controllability Matrix is defined as:
$$\mathbf{\mathcal{C} = \begin{bmatrix} B & AB & A^2 B & \dots & A^{n-1} B \end{bmatrix}}$$
formulate **Kalman's Observability Rank Theorem**:
$$\mathbf{\text{A system } (\dot{x} = A x, \ y = C x) \text{ is Completely State Observable } \Longleftrightarrow \mathbf{\text{Rank}(\mathcal{O}) = n}}$$
where the $(n \cdot p) \times n$ Observability Matrix is defined as:
$$\mathbf{\mathcal{O} = \begin{bmatrix} C \\ CA \\ CA^2 \\ \vdots \\ CA^{n-1} \end{bmatrix}}$$
(proving that if a system is completely controllable, **an arbitrary set of closed-loop eigenvalues can be placed in the complex $s$-plane using full-state feedback $u = -K x$**; whereas if a mode is uncontrollable or unobservable, it produces a **pole-zero cancellation in the transfer function $G(s)$**, concealing internal instabilities from input-output sensors).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Kalman Criteria ($\text{Rank}[\mathcal{C}] = n, \text{Rank}[\mathcal{O}] = n$), Cayley-Hamilton & Duality Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Test Controllability and Observability of a 2nd-Order Plant Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Kalman Structural Property / Matrix Test & Technical Control Implication Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | An n-th Order Dynamic System with System Matrix A and Input Matrix B Is Fully Controllable If Its Controllability Matrix Has Full Rank Equal to ___ (n) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Modern Control Problem: Evaluating Controllability and Observability Matrices for a 2x2 System Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Kalman Controllability & Observability (Kalman 1960; Ogata 2010):
   - **Kalman Matrix Formulations:**
     $$\mathbf{\mathcal{C} = \begin{bmatrix} B & AB & \dots & A^{n-1}B \end{bmatrix} \quad \Big| \quad \mathcal{O} = \begin{bmatrix} C \\ CA \\ \vdots \\ CA^{n-1} \end{bmatrix} \quad \Big| \quad \text{Rank}(\mathcal{C}) = n \quad \Big| \quad \text{Rank}(\mathcal{O}) = n}$$
   - **Structural Property Comparison Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Property} & \textbf{Matrix Condition} & \textbf{Physical Meaning} & \textbf{Control Design Consequence} \\
     \hline
     \mathbf{\text{Controllability}} & \mathbf{\text{Rank}(\mathcal{C}) = n} & \text{Inputs can steer state to ANY target vector in finite time} & \mathbf{\text{Arbitrary pole placement possible via } u = -Kx} \\
     \mathbf{\text{Observability}} & \mathbf{\text{Rank}(\mathcal{O}) = n} & \text{Initial states can be uniquely reconstructed from outputs } y(t) & \mathbf{\text{Full-order state observer can estimate all } x(t)} \\
     \hline
     \end{array}$$
   - **The Pole-Zero Cancellation Invariant:** A system is uncontrollable and/or unobservable **if and only if there is a common pole-zero cancellation in the transfer function $G(s) = C(sI - A)^{-1} B$**!
2. **Slide 2 (`ordering`):** Provide 5 steps of Kalman testing: (1) determine system dimension $n$ from $n \times n$ matrix $A$, (2) compute matrix products $A B, A^2 B, \dots, A^{n-1} B$ to construct $\mathcal{C}$, (3) compute matrix determinant $\det(\mathcal{C})$; if $\det(\mathcal{C}) \neq 0$, the system is fully controllable, (4) compute matrix products $C A, C A^2, \dots, C A^{n-1}$ to construct $\mathcal{O}$, (5) compute determinant $\det(\mathcal{O})$; if $\det(\mathcal{O}) \neq 0$, the system is fully observable!
3. **Slide 3 (`matching`):** Pair 4 concepts (Controllability Matrix $\mathcal{C} = [B \ AB]$, Observability Matrix $\mathcal{O} = [C; CA]$, Duality Principle, Pole-Zero Cancellation) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of n. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on evaluating controllability and observability: A 2nd-order dynamic system has state matrices: $A = \begin{bmatrix} 1 & 1 \\ 0 & -1 \end{bmatrix}, \quad B = \begin{bmatrix} 1 \\ 0 \end{bmatrix}, \quad C = \begin{bmatrix} 1 & 0 \end{bmatrix}$. Is the system controllable, and is it observable? (Controllability: $B = \begin{bmatrix} 1 \\ 0 \end{bmatrix}$; $AB = \begin{bmatrix} 1 & 1 \\ 0 & -1 \end{bmatrix}\begin{bmatrix} 1 \\ 0 \end{bmatrix} = \begin{bmatrix} 1 \\ 0 \end{bmatrix}$; $\mathcal{C} = \begin{bmatrix} B & AB \end{bmatrix} = \begin{bmatrix} 1 & 1 \\ 0 & 0 \end{bmatrix}$; $\det(\mathcal{C}) = 1(0) - 1(0) = 0 \implies \text{Rank}(\mathcal{C}) = 1 < 2 \implies \mathbf{\text{NOT Controllable}}$; Observability: $C = \begin{bmatrix} 1 & 0 \end{bmatrix}$; $CA = \begin{bmatrix} 1 & 0 \end{bmatrix}\begin{bmatrix} 1 & 1 \\ 0 & -1 \end{bmatrix} = \begin{bmatrix} 1 & 1 \end{bmatrix}$; $\mathcal{O} = \begin{bmatrix} C \\ CA \end{bmatrix} = \begin{bmatrix} 1 & 0 \\ 1 & 1 \end{bmatrix}$; $\det(\mathcal{O}) = 1(1) - 0(1) = 1 \neq 0 \implies \text{Rank}(\mathcal{O}) = 2 \implies \mathbf{\text{Observable}}$; Result: **Uncontrollable and Observable**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "kalman_controllability_and_observability_rank_criteria",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Kalman Controllability \\& Observability (Rudolf Kalman 1960)**\n• **Kalman Controllability Rank Criterion:**\n$$\n\\mathbf{\\mathcal{C} = \\begin{bmatrix} B & AB & A^2 B & \\dots & A^{n-1} B \\end{bmatrix} \\implies \\mathbf{\\text{Controllable } \\Longleftrightarrow \\text{Rank}(\\mathcal{C}) = n}}\n$$\n• **Kalman Observability Rank Criterion:**\n$$\n\\mathbf{\\mathcal{O} = \\begin{bmatrix} C \\\\ CA \\\\ CA^2 \\\\ \\vdots \\\\ CA^{n-1} \\end{bmatrix} \\implies \\mathbf{\\text{Observable } \\Longleftrightarrow \\text{Rank}(\\mathcal{O}) = n}}\n$$\n• **The Structural Invariant:**\n  - **Controllability:** Guarantees that any arbitrary set of closed-loop poles can be assigned via state feedback $\\mathbf{u = -K x}$;\n  - **Observability:** Guarantees that all internal states can be uniquely estimated using an observer from sensor outputs $\\mathbf{y(t)}$;\n• **The Pole-Zero Cancellation Invariant:** An unobservable or uncontrollable mode creates a **hidden pole-zero cancellation** in transfer function $G(s)$, which conceals internal state dynamics from external I/O terminals!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to construct and evaluate the Kalman Controllability and Observability matrices of an n-th order system.",
      "orderItems": [
        "Determine the system state dimension n from the size of the n x n state matrix A",
        "Compute the sequential matrix-vector products: A*B, A^2*B, ..., A^(n-1)*B",
        "Assemble the Controllability matrix: C_mat = [B, A*B, ..., A^(n-1)*B] and verify Rank(C_mat) = n (det \u2260 0)",
        "Compute the sequential vector-matrix products: C*A, C*A^2, ..., C*A^(n-1)",
        "Assemble the Observability matrix: O_mat = [C; C*A; ...; C*A^(n-1)] and verify Rank(O_mat) = n (det \u2260 0)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Kalman Property to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Controllability Matrix (C_mat)", "right": "C_mat = [B, AB, ..., A^(n-1)B], subspace span determining whether control inputs can reach all states" },
        { "left": "Observability Matrix (O_mat)", "right": "O_mat = [C; CA; ...; CA^(n-1)], mapping determining whether output measurements reveal all initial states" },
        { "left": "Full-State Feedback Feasibility", "right": "Requires Rank(C_mat) = n to enable arbitrary pole placement anywhere in the complex s-plane" },
        { "left": "Pole-Zero Cancellation", "right": "Symptom of unobservable or uncontrollable hidden modes in the transfer function G(s)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "An n-th order linear dynamical system is completely controllable if its controllability matrix has full rank equal to ___.",
      "blankAnswer": "n",
      "blankDistractors": ["1", "0", "2n"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 2nd-order dynamic system has state matrices A = [[1, 1], [0, -1]], B = [[1], [0]], and C = [1, 0]. Is this system controllable, and is it observable?",
      "options": [
        { "text": "The system is Uncontrollable and Observable (C_mat = [[1, 1], [0, 0]] \u2192 det = 0 \u2192 Rank = 1 < 2 [Uncontrollable]; O_mat = [[1, 0], [1, 1]] \u2192 det = 1 \u2260 0 \u2192 Rank = 2 = n [Observable])", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Kalman's rank criteria (Katsuhiko Ogata *Modern Control Engineering* Chapter 10). 1. **Compute Controllability Matrix ($\mathcal{C}$):** - $$B = \\begin{bmatrix} 1 \\\\ 0 \\end{bmatrix}$$ - $$AB = \\begin{bmatrix} 1 & 1 \\\\ 0 & -1 \\end{bmatrix} \\begin{bmatrix} 1 \\\\ 0 \\end{bmatrix} = \\begin{bmatrix} 1(1) + 1(0) \\\\ 0(1) + (-1)(0) \\end{bmatrix} = \\begin{bmatrix} 1 \\\\ 0 \\end{bmatrix}$$ - $$\\mathcal{C} = \\begin{bmatrix} B & AB \\end{bmatrix} = \\begin{bmatrix} 1 & 1 \\\\ 0 & 0 \\end{bmatrix}$$ - $$\\det(\\mathcal{C}) = (1)(0) - (1)(0) = 0 \\implies \\text{Rank}(\\mathcal{C}) = 1 < n = 2$$ - Because $\\text{Rank}(\\mathcal{C}) < 2$, the system is **NOT Controllable (Uncontrollable)**! (Input $u$ only affects state $x_1$, while state $x_2$ is completely isolated). 2. **Compute Observability Matrix ($\mathcal{O}$):** - $$C = \\begin{bmatrix} 1 & 0 \\end{bmatrix}$$ - $$CA = \\begin{bmatrix} 1 & 0 \\end{bmatrix} \\begin{bmatrix} 1 & 1 \\\\ 0 & -1 \\end{bmatrix} = \\begin{bmatrix} 1(1) + 0(0) & 1(1) + 0(-1) \\end{bmatrix} = \\begin{bmatrix} 1 & 1 \\end{bmatrix}$$ - $$\\mathcal{O} = \\begin{bmatrix} C \\\\ CA \\end{bmatrix} = \\begin{bmatrix} 1 & 0 \\\\ 1 & 1 \\end{bmatrix}$$ - $$\\det(\\mathcal{O}) = (1)(1) - (0)(1) = 1 \\neq 0 \\implies \\text{Rank}(\\mathcal{O}) = 2 = n$$ - Because $\\text{Rank}(\\mathcal{O}) = 2$, the system is **Completely Observable**! 3. **Final Result:** The system is **Uncontrollable and Observable**!" },
        { "text": "The system is Controllable and Observable", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The system is Controllable and Unobservable", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The system is Uncontrollable and Unobservable", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
