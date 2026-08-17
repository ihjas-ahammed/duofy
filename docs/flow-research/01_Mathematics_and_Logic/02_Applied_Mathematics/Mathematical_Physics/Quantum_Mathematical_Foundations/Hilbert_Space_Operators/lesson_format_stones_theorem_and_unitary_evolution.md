# Duofy Reusable Lesson Format: Stone's Theorem and 1-Parameter Unitary Groups

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Mathematical_Physics / Quantum_Mathematical_Foundations / Hilbert_Space_Operators`  
**Lesson Format Type:** `stones_theorem_and_unitary_evolution`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly evaluate **Marshall Stone's Theorem (1932)**, establish the bijective correspondence between strongly continuous 1-parameter unitary groups $\{U(t)\}_{t \in \mathbb{R}}$ and self-adjoint generator operators $H = H^*$ ($U(t) = e^{-itH/\hbar}$), and prove the **Time-Dependent Schrödinger Equation** $i\hbar \partial_t \psi(t) = H \psi(t)$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Stone's Theorem & Strongly Continuous Unitary Group Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Infinitesimal Generator Limit Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Strong Continuity Group Multiplication Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Translation Phase Exponent Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Spatial Translation Generator Momentum Operator Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Stone's Theorem (1932): Let $\{U(t)\}_{t \in \mathbb{R}}$ be a strongly continuous 1-parameter unitary group on Hilbert space $\mathcal{H}$ (satisfying $U(t+s) = U(t)U(s), U(0) = I$, and $\lim_{t \to 0} \|U(t)\psi - \psi\| = 0$ for all $\psi \in \mathcal{H}$). Then there exists a unique, densely defined self-adjoint operator $H = H^*$ such that $U(t) = e^{-i t H / \hbar}$, and the domain $D(H)$ is precisely the set of vectors $\psi$ where the derivative $\lim_{t \to 0} \frac{U(t)\psi - \psi}{t} = -\frac{i}{\hbar} H \psi$ exists.
2. **Slide 2 (`concept_pieces`):** Deconstruct: (1) Strong vs Uniform continuity: Uniform continuity $\lim_{t \to 0} \|U(t) - I\| = 0$ holds if and only if $H$ is a *bounded* operator; since quantum Hamiltonians are unbounded, only strong continuity holds, (2) Unitary evolution preserves total probability: $\|U(t)\psi\|^2 = \langle U(t)\psi, U(t)\psi \rangle = \langle \psi, U(t)^* U(t)\psi \rangle = \|\psi\|^2 = 1$, (3) Self-adjointness is non-negotiable: if $H$ were merely symmetric, $U(t)$ would not be unitary (probability would leak), (4) Schrödinger equation $i\hbar \frac{d\psi}{dt} = H \psi$ is the literal infinitesimal generator equation.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that a strongly continuous 1-parameter group satisfies the group law $U(t+s) = U(t) U(s)$ and $U(0) = I$. Plain text only.
4. **Slide 4 (`numerical`):** Ask student: For a Hamiltonian eigenvalue $E = 3.0 \text{ eV}$, what is the norm $\|U(t)\psi_E\|$ of the evolved state $U(t)\psi_E = e^{-i E t / \hbar}\psi_E$ for a normalized initial state $\|\psi_E\| = 1.0$? (Numeric answer: 1.0).
5. **Slide 5 (`quiz`):** Quiz on the spatial translation operator $T(a) f(x) = f(x - a)$: What self-adjoint operator generates spatial translations via Stone's Theorem ($T(a) = e^{-i a P / \hbar}$)? (The quantum momentum operator $P = -i\hbar \frac{d}{dx}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "stones_theorem_and_unitary_evolution",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Marshall Stone's Theorem (1932)**\n• Let $\\{U(t)\\}_{t \\in \\mathbb{R}}$ be a **strongly continuous 1-parameter unitary group** on Hilbert space $\\mathcal{H}$:\n  1. $U(t+s) = U(t)U(s) \\quad \\forall t, s \\in \\mathbb{R}, \\quad U(0) = I$\n  2. $U(t)^* = U(t)^{-1} = U(-t)$ (Unitary preservation of norms)\n  3. $\\lim_{t \\to 0} \\|U(t)\\psi - \\psi\\| = 0 \\quad \\forall \\psi \\in \\mathcal{H}$ (Strong continuity)\n• **Stone's Equivalence:** There exists a **unique self-adjoint operator** $H = H^*$ such that:\n$$\nU(t) = e^{-i t H / \\hbar}\n$$\n• For any $\\psi \\in D(H)$, $\\psi(t) = U(t)\\psi$ satisfies the **Time-Dependent Schrödinger Equation**:\n$$\ni \\hbar \\frac{d\\psi(t)}{dt} = H \\psi(t)\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Strong vs Uniform Continuity:** If $\\lim_{t \\to 0} \\|U(t) - I\\| = 0$ in operator norm, $H$ would be bounded. Quantum Hamiltonians ($P^2/2m + V$) are unbounded, requiring *strong* pointwise convergence $\\|U(t)\\psi - \\psi\\| \\to 0$.\n• **Conservation of Probability:** Self-adjointness of $H$ guarantees $U(t)^* U(t) = I$, ensuring total probability $\\|\\psi(t)\\|^2 = 1$ is invariant for all time.\n• **Symmetric Fails:** If $H$ is only symmetric, deficiency indices $n_\\pm > 0$ cause probability loss or non-unique time evolution!\n• **Universal Generator Dictionary:** Time translation $\\leftrightarrow$ Energy ($H$), Spatial translation $\\leftrightarrow$ Momentum ($P$), Spatial rotation $\\leftrightarrow$ Angular momentum ($J$)."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In Stone's theorem, the composition of unitary time-evolution operators obeys the one-parameter abelian group law U(t + s) = U(t) ___ U(s).",
      "blankAnswer": "times",
      "blankDistractors": ["plus", "minus", "cross"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "If a quantum state is initially normalized to ||psi_0|| = 1.0, what is the exact Hilbert space norm ||U(t) psi_0|| after evolving for 50 seconds under a self-adjoint Hamiltonian?",
      "numericAnswer": 1.0,
      "numericTolerance": 0.001
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "By Stone's theorem, what fundamental quantum observable serves as the self-adjoint generator of spatial translations T(a) psi(x) = psi(x - a) = e^{-i a P / hbar} psi(x)?",
      "options": [
        { "text": "The linear momentum operator P = -i hbar (d/dx), by Taylor expansion: psi(x - a) = sum (-a)^n/n! (d^n psi / dx^n) = e^{-a d/dx} psi(x) = e^{-i a P / hbar} psi(x)", "isCorrect": true, "explanation": "Correct! Momentum is the generator of spatial translations, matching the classical Noether symmetry." },
        { "text": "The position operator X", "isCorrect": false, "explanation": "Incorrect: Position generates momentum translations (boosts)." },
        { "text": "The kinetic energy operator", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The Pauli sigma_z matrix", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
