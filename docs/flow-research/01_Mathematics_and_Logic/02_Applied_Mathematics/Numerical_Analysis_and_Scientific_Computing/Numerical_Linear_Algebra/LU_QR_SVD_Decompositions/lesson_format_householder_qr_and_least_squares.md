# Duofy Reusable Lesson Format: Householder QR Decomposition and Linear Least Squares

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing / Numerical_Linear_Algebra / LU_QR_SVD_Decompositions`  
**Lesson Format Type:** `householder_qr_and_least_squares`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the construction of **Householder Reflectors** $H = I - 2\frac{v v^*}{v^* v}$ to compute the $A = Q R$ factorization, compare Householder stability against Gram-Schmidt, and solve overdetermined **Linear Least Squares** problems $\min \|A x - b\|_2$ via $R x = Q^T b$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Householder QR & Least Squares Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Householder Vector Sign Choice Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | QR Least Squares vs Normal Equations Conditioning Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Householder Orthogonality H^2 = I Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Geometric Reflection Operator Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the QR decomposition: Any $m \times n$ matrix $A$ ($m \ge n$) factors into an $m \times m$ unitary matrix $Q$ and an $m \times n$ upper-trapezoidal matrix $R$. Define Householder reflector $H = I - 2\frac{v v^*}{v^* v}$ with $v = x + \operatorname{sgn}(x_1)\|x\|_2 e_1$ mapping $x \mapsto \mp \|x\|_2 e_1$. State the least squares solution: $\min \|Ax - b\|_2 \iff R_1 x = Q_1^* b$.
2. **Slide 2 (`ordering`):** Provide 5 steps constructing a Householder reflection: (1) let $x = A_{k:m, k}$ be the subvector to eliminate, (2) select target vector $\alpha e_1$ where $|\alpha| = \|x\|_2$, (3) set $v = x + \operatorname{sgn}(x_1)\|x\|_2 e_1$ to avoid catastrophic cancellation, (4) normalize $u = v / \|v\|_2$, (5) apply transformation $H x = (I - 2 u u^*) x = x - 2 u (u^* x) = -\operatorname{sgn}(x_1)\|x\|_2 e_1$, zeroing out all subdiagonal entries.
3. **Slide 3 (`quiz`):** Test why solving least squares via QR is superior to the Normal Equations $A^T A x = A^T b$: (The condition number of the Normal Equations is squared $\kappa(A^T A) = \kappa(A)^2$, destroying up to half of the available floating-point digits, whereas QR has condition number $\kappa(A)$).
4. **Slide 4 (`proof`):** Interactive derivation proving that $H = I - 2 \frac{v v^*}{v^* v}$ is both Hermitian ($H^* = H$) and Unitary ($H^2 = I$).
5. **Slide 5 (`one_word`):** Plain-text recall of the surname of the American mathematician who introduced elementary matrix reflections in 1958 (Householder).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "householder_qr_and_least_squares",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Householder QR Factorization and Least Squares**\n• For $A \\in \\mathbb{R}^{m \\times n}$ ($m \\ge n$):\n$$\nA = Q R = \\begin{bmatrix} Q_1 & Q_2 \\end{bmatrix} \\begin{bmatrix} R_1 \\\\ 0 \\end{bmatrix}\n$$\nwhere $Q$ is orthogonal ($Q^T Q = I$) and $R_1$ is $n \\times n$ upper-triangular.\n• **Householder Reflector:** $H = I - 2\\frac{\\mathbf{v}\\mathbf{v}^T}{\\mathbf{v}^T\\mathbf{v}}$, with $\\mathbf{v} = \\mathbf{x} + \\operatorname{sgn}(x_1)\\|\\mathbf{x}\\|_2 \\mathbf{e}_1$.\n• **Linear Least Squares:** The solution to $\\min_{\\mathbf{x}} \\|A\\mathbf{x} - \\mathbf{b}\\|_2$ is obtained by solving the triangular system:\n$$\nR_1 \\mathbf{x} = Q_1^T \\mathbf{b}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical steps to construct a backward-stable Householder reflector zeroing out subdiagonal vector entries.",
      "orderItems": [
        "Extract the column subvector x = A[k:m, k] to be reduced",
        "Compute the Euclidean norm ||x||_2 and determine the sign of the pivot s = sgn(x_1)",
        "Form the Householder vector v = x + s * ||x||_2 * e_1, strategically choosing the sign to prevent catastrophic subtraction cancellation",
        "Normalize the reflector direction vector: u = v / ||v||_2",
        "Apply the rank-1 update H A[k:m, k:n] = A[k:m, k:n] - 2 * u * (u^T A[k:m, k:n]), setting subdiagonal entries strictly to zero"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is solving the least squares problem min ||Ax - b||_2 via QR decomposition (R_1 x = Q_1^T b) dramatically superior to solving the Normal Equations (A^T A x = A^T b)?",
      "options": [
        { "text": "The Normal Equations square the condition number kappa(A^T A) = (kappa(A))^2, which can double the loss of machine precision digits, whereas QR has condition number kappa(A)", "isCorrect": true, "explanation": "Correct! If kappa(A) = 10^8, the normal equations matrix has condition number 10^{16} (completely singular in 64-bit float!), while QR remains stable." },
        { "text": "Because QR cannot be computed on computers", "isCorrect": false, "explanation": "Incorrect: QR is standard in LAPACK (dgeqrf)." },
        { "text": "Because A^T A has smaller dimensions", "isCorrect": false, "explanation": "Incorrect: Smaller dimensions do not compensate for squared conditioning." },
        { "text": "Because Q is always the identity matrix", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Householder Reflection Orthogonality H^T H = I",
      "interactiveSteps": [
        {
          "stepText": "Let H = I - 2 (v v^T) / (v^T v). Since (v v^T)^T = v v^T, H is symmetric (H^T = H)."
        },
        {
          "prompt": "Expanding the square H^2 = (I - 2 (v v^T) / (v^T v))^2, what does the product of the two outer terms 4 (v v^T v v^T) / (v^T v)^2 simplify to?",
          "options": [
            { "text": "4 (v v^T) / (v^T v), which cancels with the middle cross-term -4 (v v^T) / (v^T v)", "isCorrect": true },
            { "text": "0", "isCorrect": false },
            { "text": "I", "isCorrect": false },
            { "text": "2 v v^T", "isCorrect": false }
          ]
        },
        {
          "stepText": "Thus H^2 = I - 4 (v v^T)/(v^T v) + 4 (v v^T)/(v^T v) = I, proving H is both an orthogonal reflector and its own inverse."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the surname of the American mathematician who introduced elementary matrix reflection operators in 1958?",
      "blankAnswer": "householder"
    }
  ]
}
```
