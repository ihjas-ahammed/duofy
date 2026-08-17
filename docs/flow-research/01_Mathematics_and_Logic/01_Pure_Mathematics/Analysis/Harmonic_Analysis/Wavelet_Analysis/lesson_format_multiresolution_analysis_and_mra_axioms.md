# Duofy Reusable Lesson Format: Multiresolution Analysis (MRA) and Scaling Axioms

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Harmonic_Analysis / Wavelet_Analysis`  
**Lesson Format Type:** `multiresolution_analysis_and_mra_axioms`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the axiomatic framework of **Multiresolution Analysis (MRA)** (Mallat & Meyer), the nested subspace hierarchy $V_j \subset V_{j+1}$, the scaling relation $\phi(t) = \sqrt{2} \sum h_k \phi(2t - k)$, and the construction of the Mother Wavelet $\psi(t) \in W_0$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Multiresolution Analysis Formal Axioms | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Nested Approximation Subspace Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | MRA Component & Geometric Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Detail Orthogonal Complement Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Haar Mother Wavelet Integral Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the formal definition of an MRA of $L^2(\mathbb{R})$: A sequence of closed subspaces $\{V_j\}_{j \in \mathbb{Z}}$ with $V_j \subset V_{j+1}$, $\bigcap V_j = \{0\}$, $\overline{\bigcup V_j} = L^2(\mathbb{R})$, scale invariance $f(t) \in V_j \iff f(2t) \in V_{j+1}$, shift invariance $f(t) \in V_0 \iff f(t-k) \in V_0$, and orthonormal scaling basis $\{\phi(t-k)\}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct Two-Scale Dilation Equation $\phi(t) = \sqrt{2}\sum h_k \phi(2t-k)$, Detail Subspace $W_j = V_{j+1} \cap V_j^\perp$, Wavelet Equation $\psi(t) = \sqrt{2}\sum g_k \phi(2t-k)$ with $g_k = (-1)^k \bar{h}_{1-k}$, and total decomposition $L^2(\mathbb{R}) = \bigoplus_{j \in \mathbb{Z}} W_j$.
3. **Slide 3 (`matching`):** Pair 4 MRA mathematical entities ($V_j$, $W_j$, $\phi(t)$, $\psi(t)$) with their functional and physical roles in signal decomposition.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the wavelet subspace $W_j$ is the orthogonal complement of $V_j$ in $V_{j+1}$. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question computing the total integral $\int_{-\infty}^\infty \psi(t) dt$ for any valid mother wavelet $\psi$ ($\int \psi(t) dt = \hat{\psi}(0) = 0$, reflecting zero DC component).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "multiresolution_analysis_and_mra_axioms",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Multiresolution Analysis (MRA)**\nA **Multiresolution Analysis** of $L^2(\\mathbb{R})$ is a sequence of closed subspaces $\\{V_j\\}_{j \\in \\mathbb{Z}}$ satisfying:\n1. $\\cdots \\subset V_{-1} \\subset V_0 \\subset V_1 \\subset V_2 \\subset \\cdots$\n2. $\\bigcap_{j \\in \\mathbb{Z}} V_j = \\{0\\}$ and $\\overline{\\bigcup_{j \\in \\mathbb{Z}} V_j} = L^2(\\mathbb{R})$ (Density).\n3. $f(t) \\in V_j \\iff f(2t) \\in V_{j+1}$ (Dilation invariance).\n4. $f(t) \\in V_0 \\iff f(t - k) \\in V_0$ for all $k \\in \\mathbb{Z}$ (Translation invariance).\n5. There exists a **scaling function** $\\phi \\in V_0$ such that $\\{\\phi(t - k)\\}_{k \\in \\mathbb{Z}}$ is an orthonormal basis of $V_0$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Scaling Dilation Equation:** Because $\\phi \\in V_0 \\subset V_1$, there exist filter coefficients $h_k$ such that $\\phi(t) = \\sqrt{2} \\sum_{k \\in \\mathbb{Z}} h_k \\phi(2t - k)$.\n• **Wavelet Detail Subspace $W_j$:** The orthogonal complement of $V_j$ in $V_{j+1}$: $V_{j+1} = V_j \\oplus W_j$.\n• **Mother Wavelet $\\psi(t)$:** Generated via quadrature mirror filter $g_k = (-1)^k \\overline{h_{1-k}}$: $\\psi(t) = \\sqrt{2} \\sum_k g_k \\phi(2t - k)$.\n• **Direct Sum Orthogonal Decomposition:** $L^2(\\mathbb{R}) = \\bigoplus_{j \\in \\mathbb{Z}} W_j$, giving an orthonormal wavelet basis $\\{\\psi_{j, k}(t) = 2^{j/2} \\psi(2^j t - k)\\}$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Multiresolution Analysis component to its exact mathematical representation.",
      "matchPairs": [
        { "left": "Approximation Space V_j", "right": "Subspace of coarse signal details at resolution 2^{-j}" },
        { "left": "Wavelet Detail Space W_j", "right": "Orthogonal complement V_{j+1} cap V_j^perp containing fine fluctuations" },
        { "left": "Father Scaling Function phi(t)", "right": "Low-pass kernel generating the approximation spaces V_j" },
        { "left": "Mother Wavelet psi(t)", "right": "High-pass kernel generating the orthonormal detail basis W_j" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Multiresolution Analysis, the detail wavelet subspace W_j is defined as the ___ complement of V_j inside V_{j+1}.",
      "blankAnswer": "orthogonal",
      "blankDistractors": ["algebraic", "continuous", "compact"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the exact value of the integral int_{-infty}^infty psi(t) dt for ANY admissible mother wavelet psi in L^2(R)?",
      "options": [
        { "text": "0 (the wavelet must have zero mean / zero DC component, so psi_hat(0) = 0)", "isCorrect": true, "explanation": "Correct! Admissibility requires int psi(t) dt = 0, ensuring that the wavelet acts as a band-pass filter with no zero-frequency bias." },
        { "text": "1", "isCorrect": false, "explanation": "Incorrect: Scaling functions integrate to 1, but mother wavelets integrate to 0." },
        { "text": "sqrt(2)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Infinity", "isCorrect": false, "explanation": "Incorrect: Wavelets are square-integrable and localized." }
      ]
    }
  ]
}
```
