# Duofy Reusable Lesson Format: Group Representations - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Representation_Theory / Group_Representations`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the constructive proof of **Maschke's Theorem** via group-averaged projection operators and **Schur's Lemma** for endomorphisms of irreducible representations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Maschke's Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Projection Averaging Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Projection Averaging Idempotency Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Schur's Lemma Interactive Proof | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Semisimplicity Property Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Maschke's Theorem: Let $G$ be a finite group, $k = \mathbb{C}$. If $W \subseteq V$ is a $G$-subrepresentation, there exists a $G$-invariant complement $W'$ such that $V = W \oplus W'$.
2. **Slide 2 (`ordering`):** Provide 5 proof steps: (1) choose an arbitrary vector space projection $\pi: V \to W$, (2) define the group-averaged projection $\Pi = \frac{1}{|G|} \sum_{g \in G} \rho(g) \pi \rho(g^{-1})$, (3) prove $\Pi$ is $G$-equivariant, (4) prove $\Pi(w) = w$ for all $w \in W$ (idempotent with $\text{im}(\Pi) = W$), (5) set $W' = \ker(\Pi)$ to obtain the $G$-invariant complement.
3. **Slide 3 (`quiz`):** Test why dividing by $|G|$ is required for $\Pi$ to act as the identity on $W$.
4. **Slide 4 (`proof`):** Interactive derivation of Schur's Lemma showing that any $G$-endomorphism of an irreducible representation over $\mathbb{C}$ has an eigenvalue $\lambda$, making $\phi - \lambda I = 0$.
5. **Slide 5 (`one_word`):** Plain-text recall of the name of the theorem (Maschke).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Maschke's Theorem**\nLet $G$ be a finite group and $V$ a representation of $G$ over $\\mathbb{C}$ (or any field where $\\text{char}(k) \\nmid |G|$).\n\nIf $W \\subseteq V$ is a $G$-subrepresentation, then there exists a $G$-subrepresentation $W' \\subseteq V$ such that:\n$$\nV = W \\oplus W'\n$$\nEvery finite-dimensional representation of $G$ over $\\mathbb{C}$ is **completely reducible**."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps in proving Maschke's Theorem via group-averaged projections.",
      "orderItems": [
        "Choose an arbitrary linear projection pi : V -> W (so pi(w) = w for all w in W, but pi is not necessarily G-equivariant)",
        "Construct the Reynolds/group-averaged operator Pi = (1/|G|) sum_{g in G} rho(g) pi rho(g^{-1})",
        "Show that Pi is G-equivariant: rho(h) Pi = Pi rho(h) for all h in G",
        "Verify that for any w in W, Pi(w) = w because W is G-invariant and pi acts as identity on W",
        "Conclude that W' = ker(Pi) is a G-invariant subspace with V = W ⊕ W'"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the factor (1/|G|) necessary in the definition of the averaged projection Pi?",
      "options": [
        { "text": "Because sum_{g in G} rho(g) pi rho(g^{-1})(w) = sum_{g in G} w = |G| w, so dividing by |G| ensures Pi(w) = w (idempotency)", "isCorrect": true, "explanation": "Correct! Without dividing by |G|, the sum would scale elements of W by |G| instead of projecting onto W." },
        { "text": "To make the determinant equal to 1", "isCorrect": false, "explanation": "Incorrect: The determinant of a projection onto a proper subspace is 0." },
        { "text": "Because all group representations are unitary", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "To ensure Pi is an invertible matrix", "isCorrect": false, "explanation": "Incorrect: A projection onto a proper subspace is never invertible." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Schur's Lemma for Complex Endomorphisms",
      "interactiveSteps": [
        {
          "stepText": "Let V be an irreducible representation of G over C and phi in Hom_G(V, V)."
        },
        {
          "prompt": "Since C is algebraically closed, phi has an eigenvalue lambda in C. What is the kernel of the G-homomorphism (phi - lambda id_V)?",
          "options": [
            { "text": "ker(phi - lambda id_V) = V, because ker is a non-zero G-submodule, forcing phi = lambda id_V", "isCorrect": true },
            { "text": "ker(phi - lambda id_V) = {0}", "isCorrect": false },
            { "text": "ker(phi - lambda id_V) is not G-invariant", "isCorrect": false },
            { "text": "lambda must equal 0", "isCorrect": false }
          ]
        },
        {
          "stepText": "Thus, the only G-intertwining operators from an irrep V to itself are scalar multiples of the identity."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What mathematician's theorem guarantees complete reducibility of finite group representations over the complex numbers?",
      "blankAnswer": "maschke"
    }
  ]
}
```
