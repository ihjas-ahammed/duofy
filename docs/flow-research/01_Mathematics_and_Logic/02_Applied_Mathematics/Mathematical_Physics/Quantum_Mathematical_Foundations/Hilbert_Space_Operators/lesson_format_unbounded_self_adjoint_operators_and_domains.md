# Duofy Reusable Lesson Format: Unbounded Operators, Domains, and Self-Adjoint Extensions

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Mathematical_Physics / Quantum_Mathematical_Foundations / Hilbert_Space_Operators`  
**Lesson Format Type:** `unbounded_self_adjoint_operators_and_domains`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the functional analysis of **Unbounded Operators** in quantum mechanics, rigorously distinguish **Symmetric vs Self-Adjoint** operators ($D(A) = D(A^*)$), apply **von Neumann's Deficiency Indices** $n_\pm = \dim \ker(A^* \mp i I)$, and evaluate boundary conditions for momentum on an interval.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Adjoint Operator Definition & Domain Specification | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Von Neumann Deficiency Index Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Operator Classification & Deficiency Index Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Adjoint Domain Equality Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Momentum on Half-Line [0, infty) Self-Adjointness Failure Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of the adjoint of a densely defined operator $A$ on Hilbert space $\mathcal{H}$: $D(A^*) = \{y \in \mathcal{H} \mid \exists z \in \mathcal{H} \text{ s.t. } \langle Ax, y \rangle = \langle x, z \rangle \, \forall x \in D(A)\}$ and $A^* y = z$. State the hierarchy: (1) Symmetric: $\langle Ax, y \rangle = \langle x, Ay \rangle$ for all $x, y \in D(A) \iff A \subseteq A^*$, (2) Self-Adjoint: $A = A^*$ (meaning $A$ is symmetric AND $D(A) = D(A^*)$). State von Neumann's Theorem: A closed symmetric operator has self-adjoint extensions $\iff n_+ = n_-$ where $n_\pm = \dim \ker(A^* \mp i I)$.
2. **Slide 2 (`concept_pieces`):** Deconstruct: (1) why quantum observables MUST be self-adjoint (real spectrum $\sigma(A) \subset \mathbb{R}$ and unitary time evolution via Stone's Theorem), (2) the Hellinger-Toeplitz Theorem (an operator defined on the *entire* Hilbert space $\mathcal{H}$ that is symmetric is automatically bounded), (3) unbounded quantum operators ($X, P, H$) are necessarily defined only on dense subspaces $D(A) \subsetneq \mathcal{H}$, (4) domain boundary conditions dictate self-adjointness.
3. **Slide 3 (`matching`):** Pair 4 operators (Free Hamiltonian on $\mathbb{R}$, Momentum on Half-Line $[0, \infty)$, Momentum on Interval $[0, 1]$, Symmetric with $n_+ = 1, n_- = 1$) with their self-adjoint extension statuses.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that an operator is self-adjoint if and only if it is symmetric and its domain equals the domain of its adjoint. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question analyzing the momentum operator $P = -i\hbar \frac{d}{dx}$ on $L^2([0, \infty))$ with $D(P) = \{f \in H^1([0, \infty)) \mid f(0) = 0\}$: Why does $P$ have NO self-adjoint extensions on the half-line? (The deficiency indices are asymmetric: $n_+ = 0, n_- = 1$, because $e^{-x/\hbar} \in L^2([0, \infty))$ is a square-integrable eigenfunction of $P^*$ with eigenvalue $-i\hbar$, but no square-integrable solution exists for $+i\hbar$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "unbounded_self_adjoint_operators_and_domains",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Unbounded Operators, Adjoints, and Self-Adjointness**\nLet $A: D(A) \\subset \\mathcal{H} \\to \\mathcal{H}$ be densely defined.\n• **The Adjoint Operator $A^*$:**\n$$\nD(A^*) = \\{y \\in \\mathcal{H} \\mid \\exists z \\in \\mathcal{H} \\text{ s.t. } \\langle Ax, y \\rangle = \\langle x, z \\rangle \\, \\forall x \\in D(A)\\}; \\quad A^*y = z\n$$\n• **The Functional Analysis Hierarchy:**\n  1. **Symmetric (Hermitian):** $\\langle Ax, y \\rangle = \\langle x, Ay \\rangle \\quad \\forall x, y \\in D(A) \\iff A \\subseteq A^*$\n  2. **Self-Adjoint:** $A = A^* \\iff A \\text{ is symmetric } \\mathbf{AND} \\, D(A) = D(A^*)$.\n• **Von Neumann's Deficiency Criterion:** A symmetric operator $A$ admits self-adjoint extensions if and only if its deficiency indices are equal:\n$$\nn_+ = n_-, \\quad \\text{where } n_\\pm = \\dim \\ker(A^* \\mp i I)\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Hellinger-Toeplitz Theorem:** If a symmetric operator is defined on the *entire* Hilbert space ($D(A) = \\mathcal{H}$), it is automatically bounded. Thus unbounded quantum operators ($X, P, H$) can *never* be defined on all of $\\mathcal{H}$!\n• **Why Mere Symmetry Fails:** A merely symmetric operator with $D(A) \\subsetneq D(A^*)$ can have complex eigenvalues and non-unitary time evolution.\n• **Self-Adjoint Necessity:** Real spectrum $\\sigma(A) \\subset \\mathbb{R}$, spectral decomposition, and unitary evolution $e^{-itA}$ require strictly $A = A^*$.\n• **Boundary Conditions as Domain Specifiers:** On bounded domains, changing boundary conditions changes $D(A)$, altering deficiency indices."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each differential operator to its self-adjointness classification and deficiency indices.",
      "matchPairs": [
        { "left": "Free Momentum P = -i d/dx on R", "right": "Essentially self-adjoint (n_+ = 0, n_- = 0; unique self-adjoint closure)" },
        { "left": "Momentum P on Half-Line [0, infty)", "right": "Symmetric with n_+ = 0, n_- = 1 (NO self-adjoint extensions exist!)" },
        { "left": "Momentum P on Interval [0, 1]", "right": "n_+ = 1, n_- = 1 (1-parameter U(1) family of quasi-periodic extensions)" },
        { "left": "Free Laplacian -d^2/dx^2 on R", "right": "Self-adjoint on Sobolev domain H^2(R) with purely continuous spectrum [0, infty)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A densely defined linear operator A on a Hilbert space is self-adjoint if and only if it is symmetric and its domain D(A) is strictly ___ to the domain of its adjoint D(A*).",
      "blankAnswer": "equal",
      "blankDistractors": ["orthogonal", "dense", "smaller"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the momentum operator P = -i hbar d/dx on the half-line [0, infty) with domain D(P) = {f in H^1([0, infty)) | f(0) = 0} fail to admit ANY self-adjoint extension?",
      "options": [
        { "text": "Its deficiency indices are unequal (n_+ = 0, n_- = 1) because the adjoint eigenfunction e^{-x/hbar} is square-integrable in L^2([0, infty)) but e^{+x/hbar} is not, violating von Neumann's criterion", "isCorrect": true, "explanation": "Correct! Solving P^* f = -i hbar f gives f(x) = C e^{-x/hbar} in L^2 (n_- = 1), while P^* f = +i hbar f gives C e^{+x/hbar} not in L^2 (n_+ = 0). Since 0 != 1, no self-adjoint extensions exist." },
        { "text": "Because half-lines do not have derivatives", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because hbar must equal 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because L^2([0, infty)) is not a Hilbert space", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
