# Duofy Reusable Lesson Format: The Yoneda Lemma and Representable Functors

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Category_Theory / Functors_and_Natural_Transformations`  
**Lesson Format Type:** `yoneda_lemma_and_representable_functors`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students on the central theorem of Category Theory: **The Yoneda Lemma (Nobuo Yoneda, 1954)** ($\operatorname{Nat}(\operatorname{Hom}_{\mathcal{C}}(A, -), F) \cong F(A)$), prove that the **Yoneda Embedding $\mathcal{Y}: \mathcal{C} \hookrightarrow [\mathcal{C}^{\text{op}}, \mathbf{Set}]$** is **fully faithful**, define **Representable Functors**, and understand why an object is completely and uniquely determined by its incoming and outgoing network of morphisms.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The Yoneda Lemma & Embedding Formal Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Proof of the Yoneda Bijection Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Category Theory Concept & Representability Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Yoneda Embedding Faithfulness Property Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Universal Properties via Representable Functors Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Yoneda Lemma (Nobuo Yoneda, 1954): Let $\mathcal{C}$ be a locally small category, $A \in \operatorname{Ob}(\mathcal{C})$, and $F: \mathcal{C} \to \mathbf{Set}$ a covariant functor. There is a canonical bijection:
   $$\operatorname{Nat}(\operatorname{Hom}_{\mathcal{C}}(A, -), \, F) \cong F(A)$$
   given by $\Phi(\eta) = \eta_A(\operatorname{id}_A) \in F(A)$. Moreover, this isomorphism is **natural** in both $A$ and $F$. State the Contravariant Yoneda Lemma: For presheaf $P: \mathcal{C}^{\text{op}} \to \mathbf{Set}$, $\operatorname{Nat}(\operatorname{Hom}(-, A), P) \cong P(A)$. State the Yoneda Embedding: The functor $\mathcal{Y}: \mathcal{C} \to [\mathcal{C}^{\text{op}}, \mathbf{Set}]$ defined by $A \mapsto \operatorname{Hom}(-, A)$ is **fully faithful**:
   $$\operatorname{Hom}_{\mathcal{C}}(A, B) \cong \operatorname{Nat}(\operatorname{Hom}(-, A), \, \operatorname{Hom}(-, B))$$
   (An object $A$ is completely determined up to isomorphism by its presheaf of probes $\operatorname{Hom}(-, A)$!).
2. **Slide 2 (`concept_pieces`):** Deconstruct proof of the Yoneda Lemma bijection: (1) define forward map $\Phi: \operatorname{Nat}(\operatorname{Hom}(A, -), F) \to F(A)$ by evaluating the transformation on the identity: $\Phi(\eta) = \eta_A(\operatorname{id}_A)$, (2) define candidate inverse map $\Psi: F(A) \to \operatorname{Nat}(\operatorname{Hom}(A, -), F)$: for element $u \in F(A)$ and object $X$, define component $\Psi(u)_X: \operatorname{Hom}(A, X) \to F(X)$ by $\Psi(u)_X(f) = F(f)(u)$, (3) evaluate naturality of $\Psi(u)$: for $g: X \to Y$, $F(g)(\Psi(u)_X(f)) = F(g)(F(f)(u)) = F(g \circ f)(u) = \Psi(u)_Y(g \circ f)$, (4) evaluate round-trip 1: $\Phi(\Psi(u)) = \Psi(u)_A(\operatorname{id}_A) = F(\operatorname{id}_A)(u) = u$, (5) evaluate round-trip 2: for $\eta \in \operatorname{Nat}$, naturality gives $\eta_X(f) = \eta_X(f \circ \operatorname{id}_A) = F(f)(\eta_A(\operatorname{id}_A)) = \Psi(\Phi(\eta))_X(f)$, proving $\Phi$ and $\Psi$ are mutual inverses!
3. **Slide 3 (`matching`):** Pair 4 category theory terms (Representable Functor, Presheaf, Yoneda Embedding $\mathcal{Y}$, Universal Element) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that because the Yoneda embedding is full and faithful, it embeds any locally small category into its presheaf category without losing any morphism information. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Representable Functors and Universal Properties: In category theory, what does it mean to say that a functor $F: \mathcal{C}^{\text{op}} \to \mathbf{Set}$ is REPRESENTABLE? ($F \cong \operatorname{Hom}_{\mathcal{C}}(-, U)$ for some object $U \in \mathcal{C}$; this object $U$ equipped with universal element $u \in F(U)$ uniquely characterizes universal constructions like limits, tensor products, and free objects).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "yoneda_lemma_and_representable_functors",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Yoneda Lemma and Representable Functors**\n• **The Yoneda Lemma (Nobuo Yoneda, 1954):**\n  For any locally small category $\\mathcal{C}$, object $A \\in \\mathcal{C}$, and functor $F: \\mathcal{C} \\to \\mathbf{Set}$:\n$$\n\\operatorname{Nat}(\\operatorname{Hom}_{\\mathcal{C}}(A, -), \\, F) \\cong F(A)\n$$\n  *(The set of natural transformations from $\\operatorname{Hom}(A, -)$ to $F$ is in 1-to-1 correspondence with elements of $F(A)$, via $\\eta \\mapsto \\eta_A(\\operatorname{id}_A)$!).*\n• **The Yoneda Embedding $\\mathcal{Y}: \\mathcal{C} \\hookrightarrow [\\mathcal{C}^{\\text{op}}, \\mathbf{Set}]$:**\n  The functor $A \\mapsto \\operatorname{Hom}_{\\mathcal{C}}(-, A)$ is **fully faithful**:\n$$\n\\operatorname{Hom}_{\\mathcal{C}}(A, B) \\cong \\operatorname{Nat}(\\operatorname{Hom}(-, A), \\, \\operatorname{Hom}(-, B))\n$$\n• **Representable Functor:** A functor $F \\cong \\operatorname{Hom}(-, A)$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Forward Evaluation Map):** Define $\\Phi(\\eta) = \\eta_A(\\operatorname{id}_A) \\in F(A)$.\n• **Step 2 (Inverse Candidate Map):** For $u \\in F(A)$, define component $\\Psi(u)_X: \\operatorname{Hom}(A, X) \\to F(X)$ by $\\Psi(u)_X(f) = F(f)(u)$.\n• **Step 3 (Verify Naturality of $\\Psi(u)$):** For $g: X \\to Y$, $F(g)(\\Psi(u)_X(f)) = F(g)(F(f)(u)) = F(g \\circ f)(u) = \\Psi(u)_Y(g \\circ f)$.\n• **Step 4 (Verify $\\Phi \\circ \\Psi = \\operatorname{id}$):** $\\Phi(\\Psi(u)) = \\Psi(u)_A(\\operatorname{id}_A) = F(\\operatorname{id}_A)(u) = u$.\n• **Step 5 (Verify $\\Psi \\circ \\Phi = \\operatorname{id}$):** By naturality of $\\eta$, $\\eta_X(f) = F(f)(\\eta_A(\\operatorname{id}_A)) = \\Psi(\\Phi(\\eta))_X(f)$, concluding the isomorphism!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Yoneda concept to its mathematical significance.",
      "matchPairs": [
        { "left": "Yoneda Isomorphism eta |-> eta_A(id_A)", "right": "A natural transformation is completely determined by where it sends the identity morphism id_A" },
        { "left": "Fully Faithful Yoneda Embedding", "right": "Injects any category C into a nice category of presheaves preserving all Hom-sets" },
        { "left": "Representable Functor F cong Hom(-, A)", "right": "Functor isomorphic to a Hom-functor; encodes universal constructions and limits" },
        { "left": "Presheaf on C", "right": "Any contravariant functor P: C^{op} -> Set" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Because the Yoneda embedding is full and ___, it preserves all isomorphism classes and morphism sets of category C.",
      "blankAnswer": "faithful",
      "blankDistractors": ["finite", "dense", "continuous"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What philosophical and mathematical principle about mathematical objects is established by the Yoneda Embedding Y: C -> [C^{op}, Set]?",
      "options": [
        { "text": "An object A in a category is COMPLETELY AND UNIQUELY DETERMINED (up to isomorphism) by how it interacts with all other objects through its incoming morphisms Hom(-, A)", "isCorrect": true, "explanation": "Correct! The Yoneda embedding proves that to know an object, you do not need to know its internal elements; you only need to know its full network of morphisms to and from all other objects." },
        { "text": "All categories are isomorphic to Set", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Objects with the same name are identical", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Presheaves have no natural transformations", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
