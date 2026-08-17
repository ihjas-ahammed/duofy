# Duofy Reusable Lesson Format: Conjugate Gradient Method and SPD Convergence

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Numerical_Analysis_and_Scientific_Computing / Numerical_Linear_Algebra / Iterative_Solvers_Krylov`  
**Lesson Format Type:** `conjugate_gradient_spd_convergence`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mathematical derivation of the **Conjugate Gradient (CG)** algorithm (Hestenes & Stiefel, 1952) for Symmetric Positive Definite (SPD) systems, prove $A$-orthogonality of search directions ($p_i^T A p_j = 0$), and establish the Chebyshev condition number bound $\|x_k - x^*\|_A \le 2 \left(\frac{\sqrt{\kappa}-1}{\sqrt{\kappa}+1}\right)^k \|x_0 - x^*\|_A$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Conjugate Gradient Formulation & Energy Minimization | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | CG Recurrence & Update Cycle Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Quadratic Optimization Equivalence Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Chebyshev Spectral Error Bound Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Conjugate Direction Inner Product Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Conjugate Gradient problem for SPD matrix $A \succ 0$: solving $Ax = b$ is equivalent to minimizing the quadratic functional $\phi(x) = \frac{1}{2} x^T A x - b^T x$. At step $k$, CG chooses $x_k \in x_0 + \mathcal{K}_k(A, r_0)$ that strictly minimizes the energy norm of the error $\|x_k - x^*\|_A = \sqrt{(x_k - x^*)^T A (x_k - x^*)}$. State the convergence theorem: $\|x_k - x^*\|_A \le 2 \left( \frac{\sqrt{\kappa} - 1}{\sqrt{\kappa} + 1} \right)^k \|x_0 - x^*\|_A$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the CG loop: (1) compute step length $\alpha_k = \frac{r_k^T r_k}{p_k^T A p_k}$, (2) update solution iterate $x_{k+1} = x_k + \alpha_k p_k$, (3) update residual $r_{k+1} = r_k - \alpha_k A p_k$, (4) compute Gram-Schmidt momentum parameter $\beta_k = \frac{r_{k+1}^T r_{k+1}}{r_k^T r_k}$, (5) construct new conjugate search direction $p_{k+1} = r_{k+1} + \beta_k p_k$.
3. **Slide 3 (`quiz`):** Test why CG terminates in at most $n$ iterations in exact arithmetic for an $n \times n$ SPD matrix: (Because the search directions $p_0, \dots, p_{n-1}$ are non-zero and mutually $A$-orthogonal, spanning all of $\mathbb{R}^n$, so $x_n$ achieves the absolute minimum of the quadratic form).
4. **Slide 4 (`proof`):** Interactive derivation showing that the error $e_k = x_k - x^*$ satisfies $\|e_k\|_A \le \min_{p \in \mathcal{P}_k, p(0)=1} \max_{\lambda \in [\lambda_{\min}, \lambda_{\max}]} |p(\lambda)| \|e_0\|_A$, and choosing the shifted Chebyshev polynomial $T_k\left(\frac{\lambda_{\max} + \lambda_{\min} - 2\lambda}{\lambda_{\max} - \lambda_{\min}}\right) / T_k\left(\frac{\lambda_{\max} + \lambda_{\min}}{\lambda_{\max} - \lambda_{\min}}\right)$ yields the factor $2\left(\frac{\sqrt{\kappa}-1}{\sqrt{\kappa}+1}\right)^k$.
5. **Slide 5 (`one_word`):** Plain-text recall of the adjective describing two vectors $u, v$ satisfying $u^T A v = 0$ with respect to matrix $A$ (conjugate).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "conjugate_gradient_spd_convergence",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Conjugate Gradient Method (Hestenes & Stiefel, 1952)**\nLet $A \\in \\mathbb{R}^{n \\times n}$ be **Symmetric Positive Definite (SPD)** ($A = A^T \\succ 0$).\n• Solving $A\\mathbf{x} = \\mathbf{b}$ is equivalent to minimizing the quadratic energy functional:\n$$\n\\phi(\\mathbf{x}) = \\frac{1}{2} \\mathbf{x}^T A \\mathbf{x} - \\mathbf{b}^T \\mathbf{x}\n$$\n• At iteration $k$, CG generates an iterate $\\mathbf{x}_k \\in \\mathbf{x}_0 + \\mathcal{K}_k(A, \\mathbf{r}_0)$ that **minimizes the energy norm** $\\|\\mathbf{x}_k - \\mathbf{x}^*\\|_A = \\sqrt{(\\mathbf{x}_k - \\mathbf{x}^*)^T A (\\mathbf{x}_k - \\mathbf{x}^*)}$.\n• **Chebyshev Convergence Bound:** With condition number $\\kappa = \\lambda_{\\max}(A) / \\lambda_{\\min}(A)$:\n$$\n\\|\\mathbf{x}_k - \\mathbf{x}^*\\|_A \\le 2 \\left( \\frac{\\sqrt{\\kappa} - 1}{\\sqrt{\\kappa} + 1} \\right)^k \\|\\mathbf{x}_0 - \\mathbf{x}^*\\|_A\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the computational update steps inside a single iteration of the Conjugate Gradient algorithm.",
      "orderItems": [
        "Compute optimal step length: alpha_k = (r_k^T r_k) / (p_k^T A p_k)",
        "Update solution iterate: x_{k+1} = x_k + alpha_k * p_k",
        "Update residual vector without extra matrix multiply: r_{k+1} = r_k - alpha_k * A * p_k",
        "Compute conjugate momentum ratio: beta_k = (r_{k+1}^T r_{k+1}) / (r_k^T r_k)",
        "Construct next A-orthogonal search direction: p_{k+1} = r_{k+1} + beta_k * p_k"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In exact arithmetic (neglecting floating-point roundoff), what is the MAXIMUM number of iterations required for the Conjugate Gradient algorithm to converge to the exact solution of an n x n SPD system?",
      "options": [
        { "text": "At most n iterations (or the number of distinct eigenvalues m <= n), because the n search directions span R^n and are mutually A-orthogonal", "isCorrect": true, "explanation": "Correct! Since all search directions p_k are non-zero and mutually A-orthogonal, they form an A-conjugate basis of R^n, guaranteeing finite termination in at most n steps." },
        { "text": "Always 1 iteration", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "n^2 iterations", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Infinitely many iterations (CG never terminates in exact arithmetic)", "isCorrect": false, "explanation": "Incorrect: CG is an exact direct solver in exact arithmetic." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Chebyshev Bound on the CG Polynomial",
      "interactiveSteps": [
        {
          "stepText": "The CG error is e_k = p_k(A) e_0 where p_k in P_k with p_k(0) = 1. Thus ||e_k||_A <= min_{p(0)=1} max_{lambda in [lambda_min, lambda_max]} |p(lambda)| ||e_0||_A."
        },
        {
          "prompt": "Which polynomial family achieves the minimal maximum value on the interval [lambda_min, lambda_max] normalized to p(0) = 1?",
          "options": [
            { "text": "Scaled and shifted Chebyshev polynomials T_k", "isCorrect": true },
            { "text": "Legendre polynomials", "isCorrect": false },
            { "text": "Hermite polynomials", "isCorrect": false },
            { "text": "Monomials x^k", "isCorrect": false }
          ]
        },
        {
          "stepText": "Evaluating 1 / T_k((kappa+1)/(kappa-1)) explicitly yields the bound 2 * ((sqrt(kappa) - 1) / (sqrt(kappa) + 1))^k, proving that convergence depends solely on the square root of the condition number."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What adjective describes two non-zero vectors u and v that satisfy the orthogonality condition u^T A v = 0 with respect to matrix A?",
      "blankAnswer": "conjugate"
    }
  ]
}
```
