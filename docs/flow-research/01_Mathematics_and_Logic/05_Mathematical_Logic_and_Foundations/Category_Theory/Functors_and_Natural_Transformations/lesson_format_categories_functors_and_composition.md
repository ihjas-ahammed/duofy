# Duofy Reusable Lesson Format: Categories, Functors, and Composition

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Category_Theory / Functors_and_Natural_Transformations`  
**Lesson Format Type:** `categories_functors_and_composition`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the foundational architecture of **Categories** ($\operatorname{Ob}(\mathcal{C}), \operatorname{Hom}_{\mathcal{C}}(A, B), \circ, \operatorname{id}_A$), define **Covariant vs Contravariant Functors** ($F(g \circ f) = F(g) \circ F(f)$ vs $F(g \circ f) = F(f) \circ F(g)$), examine canonical mathematical categories ($\mathbf{Set}, \mathbf{Grp}, \mathbf{Top}, \mathbf{Vect}_k$), and explore the opposite category $\mathcal{C}^{\text{op}}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Category & Functor Axiomatic Mathematical Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Functoriality & Hom-Functor Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Category Name & Object-Morphism Specification Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Contravariant Functor Arrow Direction Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Dual Vector Space Contravariant Functor Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of a Category $\mathcal{C}$ (Eilenberg & Mac Lane, 1945): (1) A class of objects $\operatorname{Ob}(\mathcal{C})$, (2) For each pair $A, B \in \operatorname{Ob}(\mathcal{C})$, a set of morphisms $\operatorname{Hom}_{\mathcal{C}}(A, B)$, (3) An associative composition law $\circ: \operatorname{Hom}(B, C) \times \operatorname{Hom}(A, B) \to \operatorname{Hom}(A, C)$, (4) An identity morphism $\operatorname{id}_A \in \operatorname{Hom}(A, A)$ satisfying $\operatorname{id}_B \circ f = f = f \circ \operatorname{id}_A$. State Functor Definition: A mapping $F: \mathcal{C} \to \mathcal{D}$ assigning objects $A \mapsto F(A)$ and morphisms $f \mapsto F(f)$ such that:
   - **Covariant Functor:** $F(g \circ f) = F(g) \circ F(f)$ and $F(\operatorname{id}_A) = \operatorname{id}_{F(A)}$.
   - **Contravariant Functor:** $F(g \circ f) = F(f) \circ F(g)$ (equivalently a covariant functor $F: \mathcal{C}^{\text{op}} \to \mathcal{D}$).
2. **Slide 2 (`ordering`):** Provide 5 steps proving that the covariant Hom-functor $h^A = \operatorname{Hom}_{\mathcal{C}}(A, -): \mathcal{C} \to \mathbf{Set}$ is a valid functor: (1) on objects $X \in \mathcal{C}$, define $h^A(X) = \operatorname{Hom}_{\mathcal{C}}(A, X)$, (2) on morphisms $f: X \to Y$, define the post-composition map $h^A(f): \operatorname{Hom}(A, X) \to \operatorname{Hom}(A, Y)$ by $h^A(f)(g) = f \circ g$, (3) evaluate identity: $h^A(\operatorname{id}_X)(g) = \operatorname{id}_X \circ g = g = \operatorname{id}_{h^A(X)}(g)$, (4) evaluate composite $f_2 \circ f_1$: $h^A(f_2 \circ f_1)(g) = (f_2 \circ f_1) \circ g = f_2 \circ (f_1 \circ g) = (h^A(f_2) \circ h^A(f_1))(g)$, (5) conclude that $h^A$ strictly preserves identities and composition, proving it is a covariant functor.
3. **Slide 3 (`matching`):** Pair 4 fundamental categories ($\mathbf{Set}$, $\mathbf{Grp}$, $\mathbf{Top}$, $\mathbf{Vect}_k$) with their objects and morphisms.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that a contravariant functor reverses the direction of all morphisms / arrows. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the Dual Vector Space Functor $(-)^*: \mathbf{Vect}_k \to \mathbf{Vect}_k$: Why is the dual vector space mapping $V \mapsto V^* = \operatorname{Hom}_k(V, k)$ contravariant rather than covariant? (Because for a linear transformation $T: V \to W$, the pullback dual map $T^*: W^* \to V^*$ is defined by $T^*(\phi) = \phi \circ T$, which REVERSES the direction of arrows from $W^*$ back to $V^*$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "categories_functors_and_composition",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Categories, Functors, and Composition**\n• **A Category $\\mathcal{C}$ (Eilenberg & Mac Lane, 1945) consists of:**\n  1. Objects $\\operatorname{Ob}(\\mathcal{C})$ and Hom-sets $\\operatorname{Hom}_{\\mathcal{C}}(A, B)$.\n  2. Associative composition: $h \\circ (g \\circ f) = (h \\circ g) \\circ f$.\n  3. Identity morphisms: $\\operatorname{id}_B \\circ f = f = f \\circ \\operatorname{id}_A$.\n• **Functor $F: \\mathcal{C} \\to \\mathcal{D}$ (Structure-Preserving Map):**\n  - **Covariant:** $F(g \\circ f) = F(g) \\circ F(f)$ and $F(\\operatorname{id}_A) = \\operatorname{id}_{F(A)}$.\n  - **Contravariant:** $F(g \\circ f) = F(f) \\circ F(g)$ (reverses arrows: $F: \\mathcal{C}^{\\text{op}} \\to \\mathcal{D}$).\n• **Opposite Category $\\mathcal{C}^{\\text{op}}$:** Identical objects with reversed arrows: $\\operatorname{Hom}_{\\mathcal{C}^{\\text{op}}}(A, B) = \\operatorname{Hom}_{\\mathcal{C}}(B, A)$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps establishing that the Hom-functor Hom(A, -) is a valid covariant functor into Set.",
      "orderItems": [
        "Define object mapping h^A(X) = Hom_C(A, X) assigning each object X to the set of morphisms from A to X",
        "Define morphism mapping h^A(f): Hom_C(A, X) -> Hom_C(A, Y) via post-composition: h^A(f)(g) = f circ g",
        "Verify identity preservation: h^A(id_X)(g) = id_X circ g = g = id_{h^A(X)}(g)",
        "Verify composition preservation: h^A(f_2 circ f_1)(g) = (f_2 circ f_1) circ g = f_2 circ (f_1 circ g) = (h^A(f_2) circ h^A(f_1))(g)",
        "Conclude that h^A satisfies both functor axioms, proving Hom_C(A, -) is a covariant functor"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each category to its objects and morphisms.",
      "matchPairs": [
        { "left": "Category Set", "right": "Objects: Sets; Morphisms: Functions between sets" },
        { "left": "Category Grp", "right": "Objects: Groups; Morphisms: Group homomorphisms" },
        { "left": "Category Top", "right": "Objects: Topological spaces; Morphisms: Continuous maps" },
        { "left": "Category Vect_k", "right": "Objects: Vector spaces over field k; Morphisms: k-linear transformations" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A contravariant functor F: C -> D reverses the direction of all ___: F(g circ f) = F(f) circ F(g).",
      "blankAnswer": "morphisms",
      "blankDistractors": ["objects", "identities", "isomorphisms"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the Dual Vector Space operation V |-> V* = Hom_k(V, k) a CONTRAVARIANT functor rather than a covariant functor?",
      "options": [
        { "text": "Because for a linear transformation T: V -> W, the induced dual map T*: W* -> V* maps functionals from W* BACK to V* via pullback T*(phi) = phi circ T, reversing the direction of morphisms", "isCorrect": true, "explanation": "Correct! Linear map T: V -> W induces pullback map T*: W* -> V*. Because the arrow direction flips from W* to V*, the dual functor (-)* is contravariant." },
        { "text": "Because dual spaces have negative dimensions", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because vector spaces cannot be inverted", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because T* is non-linear", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
