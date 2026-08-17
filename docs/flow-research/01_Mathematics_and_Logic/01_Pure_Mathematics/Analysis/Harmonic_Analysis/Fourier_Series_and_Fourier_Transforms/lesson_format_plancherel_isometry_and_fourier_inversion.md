# Duofy Reusable Lesson Format: Plancherel Isometry, Schwartz Space, and Fourier Inversion

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Harmonic_Analysis / Fourier_Series_and_Fourier_Transforms`  
**Lesson Format Type:** `plancherel_isometry_and_fourier_inversion`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof of the **Fourier Inversion Theorem** on the Schwartz space $\mathcal{S}(\mathbb{R})$ using Gaussians, and establish the **Plancherel Theorem** ($L^2$ isometry $\|f\|_{L^2} = \|\hat{f}\|_{L^2}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fourier Inversion & Plancherel Isometry Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Gaussian Kernel Approximation Inversion Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Derivative-Multiplication Fourier Dual Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Parseval Integral Energy Equality Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Rapid Decay Function Space Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Fourier Transform $\hat{f}(\xi) = \int_{\mathbb{R}} f(x) e^{-2\pi i x \xi} dx$, the Inversion Formula $f(x) = \int_{\mathbb{R}} \hat{f}(\xi) e^{2\pi i x \xi} d\xi$ for $f \in \mathcal{S}(\mathbb{R})$, and Plancherel's Theorem: $\mathcal{F}$ extends uniquely to a unitary isomorphism $\mathcal{F}: L^2(\mathbb{R}) \to L^2(\mathbb{R})$ with $\|f\|_{L^2} = \|\hat{f}\|_{L^2}$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof of Fourier Inversion via Gaussians: (1) let $G(x) = e^{-\pi x^2}$ and verify its self-duality $\hat{G}(\xi) = e^{-\pi \xi^2}$, (2) for $\epsilon > 0$, set $G_\epsilon(x) = \epsilon^{-1} G(x/\epsilon)$ so $\hat{G}_\epsilon(\xi) = G(\epsilon \xi)$, (3) use Fubini's Theorem on the regularized integral $\int_{\mathbb{R}} \hat{f}(\xi) e^{2\pi i x \xi} G(\epsilon \xi) d\xi = \int_{\mathbb{R}} f(y) G_\epsilon(x - y) dy = (f * G_\epsilon)(x)$, (4) observe that $G_\epsilon$ is a smooth approximate identity as $\epsilon \to 0$, (5) take $\epsilon \to 0$ to conclude $\int_{\mathbb{R}} \hat{f}(\xi) e^{2\pi i x \xi} d\xi = \lim_{\epsilon \to 0} (f * G_\epsilon)(x) = f(x)$.
3. **Slide 3 (`quiz`):** Test the duality property: What is the Fourier transform of the derivative $f'(x)$? ($\mathcal{F}[f'](\xi) = 2\pi i \xi \hat{f}(\xi)$).
4. **Slide 4 (`proof`):** Interactive derivation showing $\langle f, g \rangle_{L^2} = \langle \hat{f}, \hat{g} \rangle_{L^2}$ using Fubini's theorem and the inversion identity.
5. **Slide 5 (`one_word`):** Plain-text recall of the surname of the French mathematician who introduced the space of smooth functions of rapid decay (Schwartz).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "plancherel_isometry_and_fourier_inversion",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Fourier Inversion and Plancherel's Theorem**\n• For $f \\in \\mathcal{S}(\\mathbb{R})$ (the Schwartz space of rapidly decreasing functions):\n$$\n\\hat{f}(\\xi) = \\int_{-\\infty}^\\infty f(x) e^{-2\\pi i x \\xi} \\, dx \\implies f(x) = \\int_{-\\infty}^\\infty \\hat{f}(\\xi) e^{2\\pi i x \\xi} \\, d\\xi\n$$\n• **Plancherel's Theorem:** The Fourier transform $\\mathcal{F}$ extends uniquely from $\\mathcal{S}(\\mathbb{R})$ to a **unitary operator** on $L^2(\\mathbb{R})$ preserving the $L^2$-inner product:\n$$\n\\langle f, g \\rangle_{L^2} = \\langle \\hat{f}, \\hat{g} \\rangle_{L^2} \\implies \\|f\\|_{L^2} = \\|\\hat{f}\\|_{L^2}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps of the Fourier Inversion Formula using Gaussian regularizers.",
      "orderItems": [
        "Establish that the Gaussian G(x) = e^{-pi x^2} is an eigenfunction of the Fourier transform with G_hat(xi) = e^{-pi xi^2}",
        "Define the rescaled Gaussian G_eps(x) = (1/eps) G(x/eps), whose Fourier transform is G(eps xi)",
        "Apply Fubini's Theorem to equate the regularized integral int_R f_hat(xi) e^{2pi i x xi} G(eps xi) dxi with the convolution (f * G_eps)(x)",
        "Prove that G_eps is a smooth approximate identity on R as eps -> 0+",
        "Take the limit eps -> 0+ to conclude int_R f_hat(xi) e^{2pi i x xi} dxi = lim (f * G_eps)(x) = f(x)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Under the Fourier transform F[f](xi) = int f(x) e^{-2pi i x xi} dx, what is the exact algebraic image of the derivative operator d/dx f(x)?",
      "options": [
        { "text": "F[f'](xi) = 2pi i xi * f_hat(xi) (multiplication by 2pi i xi)", "isCorrect": true, "explanation": "Correct! Integration by parts transfers the derivative to the exponential kernel e^{-2pi i x xi}, producing a factor of 2pi i xi." },
        { "text": "F[f'](xi) = f_hat(xi) / (2pi i xi)", "isCorrect": false, "explanation": "Incorrect: Division corresponds to integration." },
        { "text": "F[f'](xi) = -f_hat(xi)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "F[f'](xi) = d/dxi f_hat(xi)", "isCorrect": false, "explanation": "Incorrect: d/dxi corresponds to multiplication by -2pi i x in the physical domain." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Plancherel L^2 Inner Product Conservation",
      "interactiveSteps": [
        {
          "stepText": "Let f, g in S(R). Write the inner product <f_hat, g_hat> = int_R f_hat(xi) conjugate(g_hat(xi)) dxi."
        },
        {
          "prompt": "Substituting the definition of f_hat and swapping integration order via Fubini, what does conjugate(int g_hat(xi) e^{2pi i x xi} dxi) evaluate to by Fourier Inversion?",
          "options": [
            { "text": "conjugate(g(x))", "isCorrect": true },
            { "text": "g_hat(x)", "isCorrect": false },
            { "text": "0", "isCorrect": false },
            { "text": "1", "isCorrect": false }
          ]
        },
        {
          "stepText": "Thus int f_hat(xi) conjugate(g_hat(xi)) dxi = int f(x) conjugate(g(x)) dx, proving ||f_hat||_2 = ||f||_2."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the surname of the French mathematician who defined the space S(R) of smooth functions whose derivatives decay faster than any polynomial?",
      "blankAnswer": "schwartz"
    }
  ]
}
```
