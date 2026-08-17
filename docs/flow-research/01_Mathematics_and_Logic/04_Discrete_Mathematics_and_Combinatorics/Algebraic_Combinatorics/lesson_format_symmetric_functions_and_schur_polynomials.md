# Duofy Reusable Lesson Format: Symmetric Functions and Schur Polynomials

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Algebraic_Combinatorics`  
**Lesson Format Type:** `symmetric_functions_and_schur_polynomials`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to navigate the **Ring of Symmetric Functions** $\Lambda$: define the 5 classical algebraic bases (Monomial $m_\lambda$, Elementary $e_\lambda$, Complete Homogeneous $h_\lambda$, Power Sum $p_\lambda$, and **Schur Functions $s_\lambda$**), evaluate the **Bialternant / Cauchy Determinantal Formula** $s_\lambda(x_1, \dots, x_n) = \frac{\det(x_i^{\lambda_j + n - j})}{\det(x_i^{n - j})}$, apply the combinatorial **Semi-Standard Young Tableaux (SSYT)** definition $s_\lambda(\mathbf{x}) = \sum_{T \in \operatorname{SSYT}(\lambda)} \mathbf{x}^T$, and compute **Kostka Numbers** $K_{\lambda, \mu}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Symmetric Function Bases & Schur Polynomial Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Bialternant Vandermonde Ratio Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Symmetric Function Basis & Algebraic Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Semi-Standard Young Tableau Weight Exponent Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Littlewood-Richardson Coefficients Multiplicity Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of the Ring of Symmetric Functions $\Lambda$: Polynomials invariant under all permutations of variables $w \cdot f(x_1, \dots, x_n) = f(x_{w(1)}, \dots, x_{w(n)})$. The 5 canonical graded vector space bases indexed by partitions $\lambda \vdash d$:
   - Monomial: $m_\lambda = \sum_{\alpha \sim \lambda} x^\alpha$
   - Elementary: $e_k = \sum_{i_1 < \dots < i_k} x_{i_1} \dots x_{i_k}, \quad e_\lambda = \prod e_{\lambda_i}$
   - Complete Homogeneous: $h_k = \sum_{i_1 \le \dots \le i_k} x_{i_1} \dots x_{i_k}, \quad h_\lambda = \prod h_{\lambda_i}$
   - Power Sum: $p_k = \sum x_i^k, \quad p_\lambda = \prod p_{\lambda_i}$
   - **Schur Functions $s_\lambda$:** $s_\lambda(x_1, \dots, x_n) = \frac{a_{\lambda + \delta}(x_1, \dots, x_n)}{a_\delta(x_1, \dots, x_n)} = \frac{\det(x_i^{\lambda_j + n - j})}{\det(x_i^{n - j})}$ where denominator is the **Vandermonde determinant** $\prod_{1 \le i < j \le n} (x_i - x_j)$.
   - **Combinatorial SSYT Definition:** $s_\lambda(\mathbf{x}) = \sum_{T \in \operatorname{SSYT}(\lambda)} \mathbf{x}^T = \sum_{\mu} K_{\lambda, \mu} m_\mu(\mathbf{x})$ where $K_{\lambda, \mu}$ are the **Kostka numbers**.
2. **Slide 2 (`concept_pieces`):** Deconstruct bialternant formula for $s_{(1, 0)}(x_1, x_2)$ ($n=2, \lambda=(1, 0), \delta=(1, 0)$): (1) $\lambda + \delta = (1+1, 0+0) = (2, 0)$, (2) numerator determinant: $\det \begin{bmatrix} x_1^2 & x_1^0 \\ x_2^2 & x_2^0 \end{bmatrix} = x_1^2 - x_2^2$, (3) denominator Vandermonde: $\det \begin{bmatrix} x_1^1 & x_1^0 \\ x_2^1 & x_2^0 \end{bmatrix} = x_1 - x_2$, (4) divide numerator by denominator: $\frac{x_1^2 - x_2^2}{x_1 - x_2} = x_1 + x_2$, (5) verify $s_{(1,0)}(x_1, x_2) = e_1(x_1, x_2) = x_1 + x_2$!
3. **Slide 3 (`matching`):** Pair 4 symmetric function bases (Monomial $m_\lambda$, Power Sum $p_\lambda$, Complete Homogeneous $h_\lambda$, Schur $s_\lambda$) with their properties.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in a Semi-Standard Young Tableau (SSYT), entries are weakly increasing along rows and strictly increasing down columns. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the Littlewood-Richardson rule: In the product of two Schur functions $s_\mu \cdot s_\nu = \sum_\lambda c_{\mu, \nu}^\lambda s_\lambda$, what do the non-negative integer coefficients $c_{\mu, \nu}^\lambda$ represent in representation theory? (They represent the multiplicity of irreducible representation $V^\lambda$ in the tensor product representation $V^\mu \otimes V^\nu$ of the general linear group $GL_n(\mathbb{C})$, as well as the induction of representations in symmetric groups).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "symmetric_functions_and_schur_polynomials",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Ring of Symmetric Functions and Schur Polynomials**\n• **The 5 Classical Graded Bases of $\\Lambda$ (Indexed by Partitions $\\lambda \\vdash d$):**\n  1. **Monomial:** $m_\\lambda = \\sum_{\\alpha \\sim \\lambda} x^\\alpha$.\n  2. **Elementary:** $e_k = \\sum_{i_1 < \\dots < i_k} x_{i_1} \\dots x_{i_k}, \\quad e_\\lambda = \\prod e_{\\lambda_i}$.\n  3. **Complete Homogeneous:** $h_k = \\sum_{i_1 \\le \\dots \\le i_k} x_{i_1} \\dots x_{i_k}, \\quad h_\\lambda = \\prod h_{\\lambda_i}$.\n  4. **Power Sum:** $p_k = \\sum x_i^k, \\quad p_\\lambda = \\prod p_{\\lambda_i}$.\n  5. **Schur Functions (The Orthonormal Master Basis):**\n$$\ns_\\lambda(x_1, \\dots, x_n) = \\frac{\\det(x_i^{\\lambda_j + n - j})_{1 \\le i, j \\le n}}{\\prod_{1 \\le i < j \\le n} (x_i - x_j)} = \\sum_{T \\in \\operatorname{SSYT}(\\lambda)} \\mathbf{x}^T = \\sum_\\mu K_{\\lambda, \\mu} m_\\mu(\\mathbf{x})\n$$\nwhere $K_{\\lambda, \\mu}$ are the non-negative integer **Kostka Numbers**."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Partition & Shift):** For $n=2$ variables and $\\lambda = (1, 0)$, the shift vector is $\\delta = (1, 0) \\implies \\lambda + \\delta = (2, 0)$.\n• **Step 2 (Numerator Determinant):**\n  $$a_{(2, 0)} = \\det \\begin{bmatrix} x_1^2 & 1 \\\\ x_2^2 & 1 \\end{bmatrix} = x_1^2 - x_2^2$$\n• **Step 3 (Vandermonde Denominator):**\n  $$a_{(1, 0)} = \\det \\begin{bmatrix} x_1^1 & 1 \\\\ x_2^1 & 1 \\end{bmatrix} = x_1 - x_2$$\n• **Step 4 (Algebraic Division):**\n  $$s_{(1, 0)}(x_1, x_2) = \\frac{x_1^2 - x_2^2}{x_1 - x_2} = x_1 + x_2$$\n• **Step 5 (Combinatorial Verification):** $\\operatorname{SSYT}((1))$ with alphabet $\\{1, 2\\}$ has 2 tableaux: $[[1]]$ (weight $x_1$) and $[[2]]$ (weight $x_2$), summing to $x_1 + x_2$!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each symmetric function basis to its algebraic property.",
      "matchPairs": [
        { "left": "Schur Basis s_lambda", "right": "Orthonormal basis under the Hall inner product <s_lambda, s_mu> = delta_{lambda, mu}" },
        { "left": "Elementary Basis e_lambda", "right": "Generates the ring of symmetric polynomials by the Fundamental Theorem of Symmetric Functions" },
        { "left": "Power Sum Basis p_lambda", "right": "Orthogonal basis whose norms <p_lambda, p_lambda> = z_lambda count centralizer orders in S_n" },
        { "left": "Kostka Numbers K_{lambda, mu}", "right": "Transition matrix coefficients expressing Schur functions in terms of monomial functions" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a Semi-Standard Young Tableau (SSYT), entries are weakly increasing along rows and ___ increasing down columns.",
      "blankAnswer": "strictly",
      "blankDistractors": ["weakly", "decreasing", "randomly"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What do the Littlewood-Richardson coefficients c_{mu, nu}^lambda in the product expansion s_mu * s_nu = sum c_{mu, nu}^lambda s_lambda represent in representation theory?",
      "options": [
        { "text": "The tensor product decomposition multiplicities for irreducible representations of GL_n(C) (V^mu (x) V^nu = bigoplus (V^lambda)^{c_{mu,nu}^lambda}) and induced representations in S_n", "isCorrect": true, "explanation": "Correct! The Littlewood-Richardson rule provides the exact combinatorial count of tensor product component multiplicities in Lie algebra and symmetric group representation theory." },
        { "text": "The number of prime factors of n", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The determinant of the covariance matrix", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The eigenvalues of the adjacency matrix", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
