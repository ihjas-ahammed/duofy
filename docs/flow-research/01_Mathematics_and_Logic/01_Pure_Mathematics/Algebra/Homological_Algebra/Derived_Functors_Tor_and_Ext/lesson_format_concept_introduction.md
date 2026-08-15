# Duofy Reusable Lesson Format: Derived Functors (Tor and Ext) - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Homological_Algebra / Derived_Functors_Tor_and_Ext`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Left and Right Derived Functors, defining $\text{Tor}_n(A, B)$ as the left derived functors of tensor products (measuring torsion and failure of flatness) and $\text{Ext}^n(A, B)$ as the right derived functors of Hom (measuring module extensions and failure of projectivity).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Half-Exactness & Derived Functor Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Tor vs Ext Dual Roles | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Functor & Invariant Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Vanishing Condition Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Flatness & Projectivity Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of derived functors: $\text{Tor}_n^R(A, B) = H_n(P_\bullet \otimes_R B)$ and $\text{Ext}_R^n(A, B) = H^n(\text{Hom}_R(P_\bullet, B))$ where $P_\bullet \to A \to 0$ is a projective resolution.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 key roles: Tor restores right-exactness of $\otimes$, Ext restores left-exactness of Hom, Tor_0 = Tensor, Ext^0 = Hom.
3. **Slide 3 (`matching`):** Pair 4 functors ($\text{Tor}_0(A, B)$, $\text{Ext}^0(A, B)$, $\text{Tor}_1(A, B)$, $\text{Ext}^1(A, B)$) with their algebraic meanings.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that a module is flat iff Tor_1 vanishes. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking for the value of $\text{Tor}_n(A, B)$ for $n \ge 2$ over a PID like $\mathbb{Z}$.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Tor and Ext Derived Functors**\nLet $P_\\bullet \\to A \\to 0$ be a projective resolution of an $R$-module $A$.\n• **Tor Functors** (Left derived of $- \\otimes_R B$):\n$$\n\\text{Tor}_n^R(A, B) = H_n(P_\\bullet \\otimes_R B), \\quad \\text{Tor}_0^R(A, B) \\cong A \\otimes_R B\n$$\n• **Ext Functors** (Right derived of $\\text{Hom}_R(-, B)$):\n$$\n\\text{Ext}_R^n(A, B) = H^n(\\text{Hom}_R(P_\\bullet, B)), \\quad \\text{Ext}_R^0(A, B) \\cong \\text{Hom}_R(A, B)\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Tor Measures Flatness:** A module $A$ is flat if and only if $\\text{Tor}_1^R(A, B) = 0$ for all $B$.\n• **Ext Measures Projectivity:** A module $A$ is projective if and only if $\\text{Ext}_R^1(A, B) = 0$ for all $B$.\n• **Extension Classification:** Elements of $\\text{Ext}_R^1(A, B)$ correspond bijectively to equivalence classes of module extensions $0 \\to B \\to E \\to A \\to 0$.\n• **PID Dimension Bound:** Over PIDs (like $\\mathbb{Z}$), all submodules of free modules are free, so $\\text{Tor}_n = 0$ and $\\text{Ext}^n = 0$ for all $n \\ge 2$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each homological derived functor to its algebraic identity.",
      "matchPairs": [
        { "left": "Tor_0(A, B)", "right": "Isomorphic to A (x) B (Tensor product)" },
        { "left": "Ext^0(A, B)", "right": "Isomorphic to Hom(A, B)" },
        { "left": "Tor_1(A, B)", "right": "Measures failure of flatness / torsion obstruction" },
        { "left": "Ext^1(A, B)", "right": "Classifies short exact extensions of A by B" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "An R-module A is flat if and only if the derived functor Tor_1(A, B) vanishes to ___ for all R-modules B.",
      "blankAnswer": "zero",
      "blankDistractors": ["identity", "infinity", "one"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Over the ring of integers Z (or any PID), what is Tor_n(A, B) for all n >= 2?",
      "options": [
        { "text": "0, because every submodule of a free Z-module is free (projective dimension <= 1)", "isCorrect": true, "explanation": "Correct! Any abelian group has a projective resolution of length 1: 0 -> P_1 -> P_0 -> A -> 0, so all higher homology vanishes." },
        { "text": "Z", "isCorrect": false, "explanation": "Incorrect: Higher Tor groups vanish over PIDs." },
        { "text": "A (x) B", "isCorrect": false, "explanation": "Incorrect: A (x) B is Tor_0." },
        { "text": "gcd(a, b)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
