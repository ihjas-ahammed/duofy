# Duofy Reusable Lesson Format: Conformal Mapping - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis / Conformal_Mapping`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof that holomorphic maps with $f'(z) \ne 0$ preserve angles and tangent vectors, and derive the invariance of the **Cross-Ratio** under Möbius transformations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Angle Preservation Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Tangent Vector Argument Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Non-Zero Derivative Requirement Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Cross-Ratio Invariance Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Conformal Automorphism Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Theorem: Let $f$ be holomorphic at $z_0$ with $f'(z_0) \ne 0$. If $\gamma_1, \gamma_2$ are smooth curves through $z_0$ intersecting at angle $\theta$, their images $f(\gamma_1), f(\gamma_2)$ intersect at $f(z_0)$ at the exact same angle $\theta$ with identical orientation.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof: (1) parameterize curves $\gamma_1(t)$ and $\gamma_2(t)$ with $\gamma_1(0)=\gamma_2(0)=z_0$, (2) express tangent vector of image as $\frac{d}{dt}f(\gamma(t))|_{t=0} = f'(z_0)\gamma'(0)$, (3) compute angle of image tangent vector: $\arg(f'(z_0)\gamma'(0)) = \arg(f'(z_0)) + \arg(\gamma'(0))$, (4) subtract angles: $[\arg(f'(z_0)) + \arg(\gamma_2'(0))] - [\arg(f'(z_0)) + \arg(\gamma_1'(0))] = \arg(\gamma_2'(0)) - \arg(\gamma_1'(0)) = \theta$, (5) conclude the angle is preserved in magnitude and sign.
3. **Slide 3 (`quiz`):** Test what happens when $f'(z_0) = 0$ (e.g. $f(z) = z^2$ at $0$, where angles are doubled).
4. **Slide 4 (`proof`):** Interactive derivation showing cross-ratio invariance $(T(z), T(z_1), T(z_2), T(z_3)) = (z, z_1, z_2, z_3)$.
5. **Slide 5 (`one_word`):** Plain-text recall of the name of the transformation class (Möbius).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Conformal Angle Preservation**\nLet $f(z)$ be holomorphic at $z_0$ with $f'(z_0) \\ne 0$.\nIf $\\gamma_1$ and $\\gamma_2$ are two smooth curves intersecting at $z_0$ with angle $\\theta = \\arg(\\gamma_2'(0)) - \\arg(\\gamma_1'(0))$, then the image curves $w_1 = f(\\gamma_1)$ and $w_2 = f(\\gamma_2)$ intersect at $f(z_0)$ with the **same angle and orientation**:\n$$\n\\theta' = \\arg(w_2'(0)) - \\arg(w_1'(0)) = \\theta\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps demonstrating angle preservation of holomorphic maps.",
      "orderItems": [
        "Let gamma_1(t) and gamma_2(t) be curves with gamma_1(0) = gamma_2(0) = z_0 and tangent vectors gamma_1'(0), gamma_2'(0)",
        "Apply the chain rule to the image curves w_k(t) = f(gamma_k(t)), yielding w_k'(0) = f'(z_0) * gamma_k'(0)",
        "Compute the argument of the transformed tangent vectors: arg(w_k'(0)) = arg(f'(z_0)) + arg(gamma_k'(0))",
        "Subtract the image arguments: arg(w_2'(0)) - arg(w_1'(0)) = [arg(f'(z_0)) + arg(gamma_2'(0))] - [arg(f'(z_0)) + arg(gamma_1'(0))]",
        "Observe that the common rotation arg(f'(z_0)) cancels completely, proving the angle between curves is invariant"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What happens to the angle between curves at a critical point where f'(z_0) = 0 with f(z) - f(z_0) = a_k (z - z_0)^k for k >= 2?",
      "options": [
        { "text": "Angles between intersecting curves are multiplied by the integer factor k", "isCorrect": true, "explanation": "Correct! At a zero of order k, the local transformation acts like z^k, multiplying all angles by k (e.g. f(z)=z^2 doubles angles at 0)." },
        { "text": "Angles are preserved", "isCorrect": false, "explanation": "Incorrect: Conformal angle preservation fails when f'(z_0) = 0." },
        { "text": "Angles are reversed in sign but magnitude is unchanged", "isCorrect": false, "explanation": "Incorrect: That is an isogonal mapping (like complex conjugation)." },
        { "text": "The angle becomes 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Cross-Ratio Invariance under Inversion w = 1/z",
      "interactiveSteps": [
        {
          "stepText": "The cross ratio is (z, z_1, z_2, z_3) = [(z - z_1)(z_2 - z_3)] / [(z - z_3)(z_2 - z_1)]."
        },
        {
          "prompt": "Substituting z = 1/w and z_k = 1/w_k into the cross-ratio formula, what simplifies upon clearing common denominators (w * w_1 * w_2 * w_3)?",
          "options": [
            { "text": "[(w_1 - w)(w_3 - w_2)] / [(w_3 - w)(w_1 - w_2)] = (w, w_1, w_2, w_3)", "isCorrect": true },
            { "text": "1 / (w, w_1, w_2, w_3)", "isCorrect": false },
            { "text": "0", "isCorrect": false },
            { "text": "(w_1 w_2) / (w_3 w)", "isCorrect": false }
          ]
        },
        {
          "stepText": "Since translations, dilations, and inversions preserve the cross-ratio, all Möbius transformations preserve cross-ratios."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the family name of linear fractional transformations of the form (az+b)/(cz+d)?",
      "blankAnswer": "mobius"
    }
  ]
}
```
