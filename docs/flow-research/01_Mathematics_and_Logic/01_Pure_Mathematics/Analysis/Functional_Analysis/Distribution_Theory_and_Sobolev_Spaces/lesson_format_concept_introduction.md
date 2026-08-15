# Duofy Reusable Lesson Format: Distribution Theory and Sobolev Spaces - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Functional_Analysis / Distribution_Theory_and_Sobolev_Spaces`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Schwartz Distributions $\mathcal{D}'(\Omega)$, the duality definition of weak derivatives ($\langle u', \phi \rangle = -\langle u, \phi' \rangle$), and the definition of Sobolev spaces $W^{k, p}(\Omega)$ and Hilbert space $H^1(\Omega) = W^{1, 2}(\Omega)$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Distributional Derivative & Sobolev Spaces | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Test Function Integration-by-Parts Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Function & Distributional Derivative Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Test Function Support Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Sobolev Space Membership Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of weak derivative: $v \in L_{\text{loc}}^1$ is the weak derivative of $u$ if $\int_\Omega u D^\alpha \phi dx = (-1)^{|\alpha|} \int_\Omega v \phi dx$ for all test functions $\phi \in C_c^\infty(\Omega)$, and the definition of Sobolev norm $\|u\|_{W^{k, p}}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct test functions ($C_c^\infty$), Heaviside step to Dirac delta, Sobolev $H^1 = W^{1, 2}$ Hilbert structure, and Lax-Milgram weak PDE formulation.
3. **Slide 3 (`matching`):** Pair 4 classical/generalized functions ($H(x)$, $|x|$, $\delta(x)$, $\ln|x|$) with their distributional derivatives.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that test functions have compact support. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking whether the Heaviside step function $H(x)$ belongs to $H^1([-1, 1])$ (No, because its weak derivative is the Dirac delta which is not in $L^2$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Weak Derivatives and Sobolev Spaces**\nLet $u \\in L_{\\text{loc}}^1(\\Omega)$. A function $v_\\alpha \\in L_{\\text{loc}}^1(\\Omega)$ is the **weak partial derivative** $D^\\alpha u$ if:\n$$\n\\int_\\Omega u \\, D^\\alpha \\phi \\, dx = (-1)^{|\\alpha|} \\int_\\Omega v_\\alpha \\, \\phi \\, dx \\quad \\forall \\phi \\in C_c^\\infty(\\Omega)\n$$\nThe **Sobolev space** $W^{k, p}(\\Omega)$ consists of functions in $L^p(\\Omega)$ whose weak derivatives up to order $k$ belong to $L^p(\\Omega)$, with $H^k(\\Omega) = W^{k, 2}(\\Omega)$ being a Hilbert space."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Test Functions:** $C_c^\\infty(\\Omega)$ smooth functions with compact support vanishing near boundary $\\partial \\Omega$.\n• **Distributional Differentiation:** Every locally integrable function has distributional derivatives of all orders.\n• **The Delta Distribution:** The derivative of the Heaviside step $H(x)$ is the Dirac delta $\\delta(x)$, satisfying $\\langle \\delta, \\phi \\rangle = \\phi(0)$.\n• **Lax-Milgram Formulation:** Weak derivatives allow elliptic PDEs like $-\\Delta u = f$ to be solved via energy minimization in $H_0^1(\\Omega)$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each function to its first distributional derivative.",
      "matchPairs": [
        { "left": "Heaviside Step H(x)", "right": "Dirac Delta Distribution delta(x)" },
        { "left": "Absolute Value |x|", "right": "Signum Function sgn(x)" },
        { "left": "Dirac Delta delta(x)", "right": "delta'(x) satisfying <delta', phi> = -phi'(0)" },
        { "left": "sgn(x)", "right": "2 * delta(x)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In distribution theory, test functions in C_c^infinity must be infinitely smooth and have ___ support.",
      "blankAnswer": "compact",
      "blankDistractors": ["infinite", "discrete", "unbounded"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Does the Heaviside step function H(x) belong to the Sobolev space H^1([-1, 1])?",
      "options": [
        { "text": "No, because its distributional derivative is the Dirac delta delta(x), which is not an L^2 function", "isCorrect": true, "explanation": "Correct! Since delta(x) is not representable by an L^2 function, H(x) lacks an L^2 weak derivative, so H is not in H^1." },
        { "text": "Yes, because H(x) is bounded on [-1, 1]", "isCorrect": false, "explanation": "Incorrect: Being in L^2 is necessary but not sufficient for H^1." },
        { "text": "Yes, because H'(x) = 0 almost everywhere", "isCorrect": false, "explanation": "Incorrect: Weak derivative includes the jump singularity at x = 0." },
        { "text": "No, because H(x) is not Lebesgue integrable", "isCorrect": false, "explanation": "Incorrect: H is bounded and hence in L^2." }
      ]
    }
  ]
}
```
