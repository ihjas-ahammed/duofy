# Duofy Reusable Lesson Format: Singular Integrals and Wavelets - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Harmonic_Analysis / Singular_Integrals_and_Wavelets`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof of the **Calderón-Zygmund Theorem** (weak-type $(1, 1)$ bound via dyadic cube decomposition) and the construction of orthonormal wavelet bases via **Multiresolution Analysis (MRA)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Calderón-Zygmund Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | CZ Weak-(1, 1) Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Cancellation Condition Justification | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | MRA Wavelet Construction Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Non-Smooth Prototype Wavelet Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Calderón-Zygmund Theorem: If $T$ is an $L^2$-bounded convolution operator with kernel $K$ satisfying $|\nabla K(x)| \le C |x|^{-(n+1)}$, then $T$ is of weak-type $(1, 1)$: $m(\{x \in \mathbb{R}^n \mid |Tf(x)| > \alpha\}) \le \frac{C}{\alpha}\|f\|_{L^1}$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof: (1) apply CZ decomposition to $f$ at height $\alpha$ yielding $f = g + b$, (2) bound distribution of good part using Chebyshev: $m(\{|Tg| > \alpha/2\}) \le \frac{4}{\alpha^2}\|Tg\|_{L^2}^2 \le \frac{C}{\alpha}\|f\|_{L^1}$, (3) expand bad part $Tb = \sum T b_k$, (4) exploit zero-mean property $\int b_k dy = 0$ to write $Tb_k(x) = \int [K(x-y) - K(x-y_k)]b_k(y)dy$, (5) use kernel gradient decay to bound $\int_{\mathbb{R}^n \setminus 2Q_k} |Tb_k| dx \le C \|b_k\|_{L^1}$ and conclude weak-type $(1, 1)$.
3. **Slide 3 (`quiz`):** Test why the zero-mean condition $\int_{Q_k} b_k dy = 0$ is essential for subtracting $K(x - y_k)$.
4. **Slide 4 (`proof`):** Interactive derivation showing that the scaling filter $m_0(\xi)$ in MRA defines the mother wavelet via $\hat{\psi}(\xi) = e^{i\xi/2}\overline{m_0(\xi/2 + \pi)}\hat{\phi}(\xi/2)$.
5. **Slide 5 (`one_word`):** Plain-text recall of the Hungarian mathematician who invented the first orthogonal wavelet system (Haar).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Calderón-Zygmund Weak-(1, 1) Theorem**\nLet $Tf = K * f$ be an $L^2$-bounded singular integral operator whose kernel satisfies the **Hörmander gradient condition**:\n$$\n|\\nabla K(x)| \\le \\frac{C}{|x|^{n+1}} \\quad \\text{for } x \\ne 0\n$$\nThen $T$ is of **weak-type $(1, 1)$**:\n$$\nm(\\{x \\in \\mathbb{R}^n \\mid |Tf(x)| > \\alpha\\}) \\le \\frac{C'}{\\alpha} \\|f\\|_{L^1(\\mathbb{R}^n)}\n$$\nBy the Marcinkiewicz Interpolation Theorem, $T$ is strongly bounded on $L^p(\\mathbb{R}^n)$ for all $1 < p < \\infty$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps establishing the weak-(1, 1) bound of Calderón-Zygmund operators.",
      "orderItems": [
        "Decompose f = g + b at height alpha via dyadic cubes Q_k, with |g(x)| <= 2^n alpha and sum |Q_k| <= (C/alpha) ||f||_{L^1}",
        "Bound the good function distribution using L^2 boundedness and Chebyshev: m({|Tg| > alpha/2}) <= (4/alpha^2) ||Tg||_{L^2}^2 <= (C/alpha) ||f||_{L^1}",
        "For the bad function b = sum b_k, let E* = union 2Q_k denote the union of expanded cubes, whose total measure is bounded by (C/alpha) ||f||_{L^1}",
        "Outside E*, use the cancellation int_{Q_k} b_k dy = 0 to write Tb_k(x) = int [K(x-y) - K(x-y_k)] b_k(y) dy",
        "Integrate the kernel difference bound |K(x-y) - K(x-y_k)| over (2Q_k)^c to show int |Tb| dx <= C ||f||_{L^1}, concluding the weak-(1, 1) estimate"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the mean-zero property int_{Q_k} b_k(y) dy = 0 essential in the Calderón-Zygmund proof?",
      "options": [
        { "text": "It allows inserting the center-point term -K(x - y_k) without changing the integral, enabling the Mean Value Theorem to gain a decay factor of |y - y_k|/|x - y_k|^{n+1}", "isCorrect": true, "explanation": "Correct! Without subtracting K(x - y_k), the non-integrable 1/|x|^n singularity cannot be controlled outside the cube." },
        { "text": "It forces b_k to be identically zero", "isCorrect": false, "explanation": "Incorrect: b_k is non-zero with zero mean." },
        { "text": "It ensures the function is continuous", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It eliminates the Fourier transform", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Multiresolution Wavelet Orthogonality",
      "interactiveSteps": [
        {
          "stepText": "Let V_0 be spanned by integer shifts of scaling function phi, and V_1 by phi(2x)."
        },
        {
          "prompt": "How is the wavelet space W_0 defined relative to V_0 and V_1?",
          "options": [
            { "text": "W_0 is the orthogonal complement of V_0 in V_1 (V_1 = V_0 oplus W_0)", "isCorrect": true },
            { "text": "W_0 = V_0 intersect V_1", "isCorrect": false },
            { "text": "W_0 = V_0 + V_1 (not orthogonal)", "isCorrect": false },
            { "text": "W_0 = L^2(R)", "isCorrect": false }
          ]
        },
        {
          "stepText": "Constructing psi in W_0 guarantees that all dyadic dilations and integer translations {psi_{j,k}} form an orthonormal basis of L^2(R)."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the surname of the mathematician who created the classic step-function wavelet taking values +1 and -1?",
      "blankAnswer": "haar"
    }
  ]
}
```
