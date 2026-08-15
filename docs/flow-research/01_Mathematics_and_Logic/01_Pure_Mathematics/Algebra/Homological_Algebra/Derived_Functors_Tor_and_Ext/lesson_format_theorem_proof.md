# Duofy Reusable Lesson Format: Derived Functors (Tor and Ext) - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Homological_Algebra / Derived_Functors_Tor_and_Ext`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the derivation of the **Long Exact Sequence of Tor and Ext** associated with a short exact sequence of modules, showing how derived functors complete and repair broken exact sequences.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Long Exact Sequence Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Horseshoe Lemma & Resolution Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Projective Resolution Independence Justification | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Tor Long Exact Sequence Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Extension Group Definition Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the theorem for the Long Exact Sequence of Tor: Given $0 \to A' \to A \to A'' \to 0$, there exists an infinite exact sequence ending at $A' \otimes B \to A \otimes B \to A'' \otimes B \to 0$.
2. **Slide 2 (`ordering`):** Provide 5 steps constructing the Long Exact Sequence: (1) start with short exact sequence of modules, (2) construct compatible projective resolutions using the Horseshoe Lemma, (3) apply functor $- \otimes B$ to obtain short exact sequence of complexes, (4) apply the Snake Lemma / Zig-Zag Lemma, (5) conclude with the long exact sequence of homology groups.
3. **Slide 3 (`quiz`):** Test why Tor is independent of the choice of projective resolution (comparison theorem for resolutions).
4. **Slide 4 (`proof`):** Interactive step-by-step derivation calculating the connecting boundary map.
5. **Slide 5 (`one_word`):** Plain-text recall of the name of the lemma used to construct compatible resolutions of submodules and quotients (Horseshoe lemma).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Long Exact Sequence of Tor**\nLet $0 \\to A' \\xrightarrow{i} A \\xrightarrow{p} A'' \\to 0$ be a short exact sequence of $R$-modules.\nFor any $R$-module $B$, there is a natural long exact sequence:\n$$\n\\dots \\to \\text{Tor}_1(A', B) \\to \\text{Tor}_1(A, B) \\to \\text{Tor}_1(A'', B) \\xrightarrow{\\delta} A' \\otimes B \\to A \\otimes B \\to A'' \\otimes B \\to 0\n$$\nThe connecting map $\\delta$ restores the exactness lost on the left of $A' \\otimes B$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps in proving the existence of the Long Exact Sequence of Tor.",
      "orderItems": [
        "Take a short exact sequence of modules 0 -> A' -> A -> A'' -> 0",
        "Choose projective resolutions P'_* for A' and P''_x for A''",
        "Apply the Horseshoe Lemma to construct a compatible projective resolution P_* for A with P_n = P'_n ⊕ P''_n",
        "Tensor the sequence of complexes with B to get 0 -> P'_* (x) B -> P_* (x) B -> P''_* (x) B -> 0",
        "Apply the Snake Lemma to extract the long exact sequence of homology groups (Tor_n)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the derived functor Tor_n(A, B) independent of the specific projective resolution chosen for A?",
      "options": [
        { "text": "Any two projective resolutions of A are chain homotopy equivalent (by the Comparison Theorem), inducing isomorphisms on homology", "isCorrect": true, "explanation": "Correct! The Comparison Theorem ensures a unique homotopy class of chain maps between any two projective resolutions." },
        { "text": "Because all projective modules are isomorphic", "isCorrect": false, "explanation": "Incorrect: Projective modules are generally not isomorphic to one another." },
        { "text": "Because Tor is always zero", "isCorrect": false, "explanation": "Incorrect: Tor can be non-zero." },
        { "text": "Because B must be a free module", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Repairing the Right-Exact Tensor Sequence",
      "interactiveSteps": [
        {
          "stepText": "The functor - (x) B is right-exact, giving A' (x) B -> A (x) B -> A'' (x) B -> 0."
        },
        {
          "prompt": "If i : A' -> A is injective, what condition on A'' guarantees that i (x) id_B : A' (x) B -> A (x) B is also injective?",
          "options": [
            { "text": "Tor_1(A'', B) = 0", "isCorrect": true },
            { "text": "Tor_1(A'', B) = A'' (x) B", "isCorrect": false },
            { "text": "Ext^1(A'', B) = 0", "isCorrect": false },
            { "text": "A'' is an Artinian ring", "isCorrect": false }
          ]
        },
        {
          "stepText": "Thus, the vanishing of Tor_1(A'', B) prevents injectivity failure upon tensoring."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What lemma guarantees that we can construct a projective resolution of module A from resolutions of A' and A'' in a short exact sequence?",
      "blankAnswer": "horseshoe"
    }
  ]
}
```
