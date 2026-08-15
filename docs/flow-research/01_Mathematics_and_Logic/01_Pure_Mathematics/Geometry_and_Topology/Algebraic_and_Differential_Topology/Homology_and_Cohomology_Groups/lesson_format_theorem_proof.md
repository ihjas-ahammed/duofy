# Duofy Reusable Lesson Format: Homology and Cohomology Groups - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Algebraic_and_Differential_Topology / Homology_and_Cohomology_Groups`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the derivation of the **Mayer-Vietoris Long Exact Sequence** from the short exact sequence of chain complexes, and prove **Poincaré Duality** ($H^k(M) \cong H_{n-k}(M)$) for compact oriented manifolds.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Mayer-Vietoris Sequence Formal Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Snake Lemma Zig-Zag Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Boundary Homomorphism Connecting Map Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Poincaré Duality Cap Product Interactive Proof | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Manifold Orientation Class Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Mayer-Vietoris Theorem: For an open cover $X = A \cup B$, there is a long exact sequence $\dots \to H_n(A \cap B) \xrightarrow{\Phi} H_n(A) \oplus H_n(B) \xrightarrow{\Psi} H_n(X) \xrightarrow{\partial_*} H_{n-1}(A \cap B) \to \dots$ where $\Phi(x) = (i_A(x), i_B(x))$ and $\Psi(x, y) = j_A(x) - j_B(y)$.
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof via the Snake Lemma: (1) construct short exact sequence of chain complexes $0 \to C_n(A \cap B) \xrightarrow{i} C_n(A) \oplus C_n(B) \xrightarrow{j} C_n(A + B) \to 0$, (2) apply the algebraic Snake Lemma (Zig-Zag Lemma) to obtain long exact homology sequence for $C_*(A+B)$, (3) apply the Excision Theorem / barycentric subdivision to show $C_*(A+B) \hookrightarrow C_*(X)$ is a chain homotopy equivalence, (4) replace $H_n(A+B)$ by $H_n(X)$ via the isomorphism, (5) define the connecting homomorphism $\partial_*[c] = [\partial c_A]$ where $c = c_A + c_B$.
3. **Slide 3 (`quiz`):** Test why the connecting homomorphism $\partial_*$ reduces the homology degree from $n$ to $n-1$.
4. **Slide 4 (`proof`):** Interactive derivation of Poincaré Duality cap product $D(\phi) = [M] \frown \phi \in H_{n-k}(M)$ for $\phi \in H^k(M)$.
5. **Slide 5 (`one_word`):** Plain-text recall of the generating homology class $[M] \in H_n(M)$ of an oriented closed $n$-manifold (fundamental).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Mayer-Vietoris Sequence**\nLet $X = A \\cup B$ be the union of two open subsets $A, B \\subseteq X$.\nThere exists a natural **long exact sequence** in homology:\n$$\n\\dots \\xrightarrow{\\ \\partial_*\\ } H_n(A \\cap B) \\xrightarrow{\\ \\Phi\\ } H_n(A) \\oplus H_n(B) \\xrightarrow{\\ \\Psi\\ } H_n(X) \\xrightarrow{\\ \\partial_*\\ } H_{n-1}(A \\cap B) \\xrightarrow{\\ \\Phi\\ } \\dots\n$$\nwhere $\\Phi(c) = (i_{A*}(c), i_{B*}(c))$ and $\\Psi(a, b) = j_{A*}(a) - j_{B*}(b)$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps establishing the Mayer-Vietoris Sequence via the Snake Lemma.",
      "orderItems": [
        "Construct the short exact sequence of chain complexes 0 -> C_n(A intersect B) -> C_n(A) + C_n(B) -> C_n(A + B) -> 0",
        "Apply the algebraic Snake Lemma (Zig-Zag Lemma) to induce a long exact sequence on the homology groups of these chain complexes",
        "Use Small Simplices / Barycentric Subdivision to prove that the inclusion C_*(A + B) -> C_*(X) is a chain homotopy equivalence",
        "Replace H_n(C_*(A + B)) with H_n(X) via the canonical isomorphism",
        "Formulate the connecting boundary homomorphism d_*[z] = [d(z_A)] for any cycle z = z_A + z_B in C_n(A + B)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does the connecting homomorphism d_*: H_n(X) -> H_{n-1}(A intersect B) lower the dimension of the homology group by 1?",
      "options": [
        { "text": "A representative n-cycle z = a + b has boundary 0 = da + db, which forces the (n-1)-chain da = -db to lie entirely in the intersection A intersect B with d(da) = 0", "isCorrect": true, "explanation": "Correct! Applying the boundary operator d lowers the geometric dimension from n to n-1, creating an (n-1)-cycle in A intersect B." },
        { "text": "Because homology groups alternate signs", "isCorrect": false, "explanation": "Incorrect: Groups are abelian groups, not signed numbers." },
        { "text": "Because A and B are contractible", "isCorrect": false, "explanation": "Incorrect: A and B can have arbitrary topology." },
        { "text": "Because H_0 is always zero", "isCorrect": false, "explanation": "Incorrect: H_0 counts path components and is non-zero for non-empty spaces." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Poincaré Duality via the Cap Product",
      "interactiveSteps": [
        {
          "stepText": "Let M be a compact, oriented n-manifold with fundamental homology class [M] in H_n(M; Z)."
        },
        {
          "prompt": "For any cohomology class phi in H^k(M; Z), how is the Poincaré Duality map D: H^k(M) -> H_{n-k}(M) defined?",
          "options": [
            { "text": "D(phi) = [M] cap phi (cap product with the fundamental class)", "isCorrect": true },
            { "text": "D(phi) = [M] cup phi", "isCorrect": false },
            { "text": "D(phi) = phi + [M]", "isCorrect": false },
            { "text": "D(phi) = d(phi)", "isCorrect": false }
          ]
        },
        {
          "stepText": "The cap product pairs the n-dimensional fundamental class with a k-cochain, yielding an isomorphic (n-k)-dimensional homology class."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the name of the top-dimensional homology class [M] in H_n(M) that generates the homology of an oriented closed n-manifold?",
      "blankAnswer": "fundamental"
    }
  ]
}
```
