# Duofy Reusable Lesson Format: Fundamental Group and Covering Spaces - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Algebraic_and_Differential_Topology / Fundamental_Group_and_Covering_Spaces`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof that $\pi_1(S^1) \cong \mathbb{Z}$ via the universal cover $p: \mathbb{R} \to S^1$, proving the **Path Lifting Lemma** and the **Homotopy Lifting Lemma**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fundamental Group of the Circle Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Path Lifting Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Homotopy Lifting Endpoint Invariance Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Winding Number Isomorphism Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Covering Automorphism Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Theorem: The fundamental group of the circle $\pi_1(S^1, 1)$ is an infinite cyclic group isomorphic to the additive group of integers $\mathbb{Z}$, with isomorphism given by the degree (winding number) of the lifted loop.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof of the Path Lifting Lemma for $p: \mathbb{R} \to S^1$ ($t \mapsto e^{2\pi i t}$): (1) let $\gamma: [0, 1] \to S^1$ be a path with $\gamma(0) = 1$, (2) cover $S^1$ by open sets $U_1, U_2$ evenly covered by disjoint intervals in $\mathbb{R}$, (3) by Lebesgue number lemma, subdivide $[0, 1]$ into $0 = t_0 < t_1 < \dots < t_k = 1$ such that $\gamma([t_i, t_{i+1}]) \subseteq U_{j_i}$, (4) inductively define unique lift $\tilde{\gamma}$ on $[t_i, t_{i+1}]$ using the homeomorphic slice containing $\tilde{\gamma}(t_i)$, (5) evaluate terminal endpoint $\tilde{\gamma}(1) = n \in \mathbb{Z}$ to define the winding number homomorphism.
3. **Slide 3 (`quiz`):** Test why Homotopy Lifting guarantees that homotopic loops lift to paths with the exact same endpoint in $\mathbb{Z}$.
4. **Slide 4 (`proof`):** Interactive derivation showing the map $[\gamma] \mapsto \tilde{\gamma}(1)$ is a bijective group homomorphism from $\pi_1(S^1)$ to $\mathbb{Z}$.
5. **Slide 5 (`one_word`):** Plain-text recall of the name of the group of covering automorphisms (Deck).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Fundamental Group of the Circle**\nThe fundamental group of the circle $S^1$ is isomorphic to the additive group of integers:\n$$\n\\pi_1(S^1, 1) \\cong \\mathbb{Z}\n$$\nThe isomorphism is given by the degree map $\\Phi: \\pi_1(S^1, 1) \\to \\mathbb{Z}$ defined by $\\Phi([\\gamma]) = \\tilde{\\gamma}(1)$, where $\\tilde{\\gamma}: [0, 1] \\to \\mathbb{R}$ is the unique lift of $\\gamma$ starting at $0$ under the covering map $p(t) = e^{2\\pi i t}$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps demonstrating unique path lifting for the covering map p: R -> S^1.",
      "orderItems": [
        "Let gamma: [0, 1] -> S^1 be a continuous path with gamma(0) = 1, and choose basepoint lift 0 in p^{-1}(1)",
        "Cover S^1 by two evenly covered open arcs U_1 and U_2, whose preimages are disjoint open intervals in R",
        "Use the Lebesgue Number Lemma to partition [0, 1] into subintervals [t_i, t_{i+1}] such that gamma([t_i, t_{i+1}]) is contained in U_1 or U_2",
        "On each step [t_i, t_{i+1}], lift gamma using the unique homeomorphic slice containing the already established point tilde{gamma}(t_i)",
        "By mathematical induction, glue the subinterval lifts to construct a unique continuous path tilde{gamma}: [0, 1] -> R starting at 0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does the Homotopy Lifting Property ensure that the degree map Phi: pi_1(S^1) -> Z is well-defined on homotopy classes?",
      "options": [
        { "text": "A homotopy of loops H(s, t) lifts to a homotopy of paths tilde{H}(s, t) in R; since the fiber p^{-1}(1) = Z is discrete, the endpoint tilde{H}(s, 1) must be constant in s", "isCorrect": true, "explanation": "Correct! Continuous paths in a discrete set Z must be constant, guaranteeing that homotopic loops have identical lifted endpoints." },
        { "text": "Because R is compact", "isCorrect": false, "explanation": "Incorrect: R is not compact." },
        { "text": "Because all loops in S^1 are constant", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because S^1 has no covering spaces", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Homomorphism Property of the Degree Map",
      "interactiveSteps": [
        {
          "stepText": "Let gamma_1, gamma_2 be loops based at 1 with lifted paths tilde{gamma}_1, tilde{gamma}_2 starting at 0 with endpoints m, n in Z."
        },
        {
          "prompt": "What is the endpoint of the lift of the concatenated loop gamma_1 . gamma_2 starting at 0?",
          "options": [
            { "text": "m + n (translating the second lift by +m)", "isCorrect": true },
            { "text": "m * n", "isCorrect": false },
            { "text": "0", "isCorrect": false },
            { "text": "m - n", "isCorrect": false }
          ]
        },
        {
          "stepText": "Thus Phi([gamma_1 . gamma_2]) = m + n = Phi([gamma_1]) + Phi([gamma_2]), proving Phi is an isomorphism onto Z."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the name of the group of covering automorphisms phi: E -> E preserving the projection map p(phi(x)) = p(x)?",
      "blankAnswer": "deck"
    }
  ]
}
```
