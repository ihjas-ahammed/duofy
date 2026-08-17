# Duofy Reusable Lesson Format: Compactness Theorem and Non-Standard Models

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Model_Theory`  
**Lesson Format Type:** `compactness_theorem_and_nonstandard_models`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the foundational engine of Model Theory: **The Compactness Theorem (Kurt Gödel 1930, Anatoly Malcev 1936)** (a theory $T$ has a model $\iff$ every finite subset $T_0 \subseteq T$ has a model), construct **Non-Standard Models of Arithmetic $\mathbb{N}^*$** containing infinite non-standard integers ($c > n$ for all $n \in \mathbb{N}$), build **Hyperreal Fields $\mathbb{R}^*$** with infinitesimals (Abraham Robinson's Non-Standard Analysis), and evaluate Ultraproducts via **Łoś's Theorem**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Compactness Theorem & Non-Standard Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Construction of Infinite Integer Model Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Non-Standard Theory & Model Concept Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Compactness Finitary Subcollection Condition Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Non-Definability of Finiteness in First-Order Logic Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Compactness Theorem of First-Order Logic: A set of first-order sentences $T$ has a model ($T$ is satisfiable) if and only if every **finite subset** $T_0 \subseteq T$ has a model. State Non-Standard Model Construction: Let $T = \operatorname{Th}(\mathbb{N}, +, \times, <)$. Add a new constant symbol $c$ to the language and define the extended theory:
   $$T^* = T \cup \{c > \mathbf{n} \mid n \in \mathbb{N}\}$$
   Every finite subset $T_0 \subset T^*$ involves only finitely many constraints $c > n_1, \dots, c > n_k$, which is satisfied in standard $\mathbb{N}$ by setting $c = \max(n_i) + 1$. By Compactness, $T^*$ has a model $\mathbb{N}^*$, containing a strictly infinite number $c$ larger than all standard natural numbers!
2. **Slide 2 (`ordering`):** Provide 5 steps proving that the class of all finite graphs is NOT first-order axiomatizable: (1) assume for contradiction that sentence $\sigma$ is satisfied by a graph $G \iff G$ is finite, (2) consider the infinite family of sentences $\{\phi_n\}_{n \ge 2}$ where $\phi_n$ asserts "there are at least $n$ distinct vertices", (3) define the theory $T = \{\sigma\} \cup \{\phi_n \mid n \ge 2\}$, (4) every finite subset $T_0 \subset T$ has a model (e.g. any finite graph with vertices $N > \max(n_i)$), (5) by Compactness, the full theory $T$ has a model $G^*$, which must be both finite (satisfying $\sigma$) and infinite (satisfying all $\phi_n$), an impossible contradiction proving finiteness cannot be expressed in first-order logic!
3. **Slide 3 (`matching`):** Pair 4 model-theoretic concepts (Compactness Theorem, Non-Standard Arithmetic $\mathbb{N}^*$, Hyperreal Numbers $\mathbb{R}^*$, Ultraproduct / Łoś's Theorem) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the Compactness Theorem guarantees satisfiability of an infinite theory if every finite subset is satisfiable. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Abraham Robinson's Non-Standard Analysis: How does Robinson construct positive infinitesimals $\varepsilon > 0$ strictly smaller than all standard positive real numbers ($0 < \varepsilon < 1/n$ for all $n \in \mathbb{N}^+$)? (By applying the Compactness Theorem to $\operatorname{Th}(\mathbb{R}) \cup \{0 < \varepsilon < 1/n \mid n \in \mathbb{N}^+\}$; every finite subset is satisfied in standard $\mathbb{R}$ by taking $\varepsilon = 1/(N+1)$, generating hyperreal field $\mathbb{R}^*$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "compactness_theorem_and_nonstandard_models",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Compactness Theorem and Non-Standard Models**\n• **The Compactness Theorem (Gödel 1930, Malcev 1936):**\n  A first-order theory $T$ has a model (is satisfiable) **if and only if** every **finite subset** $T_0 \\subseteq T$ has a model.\n• **Construction of Non-Standard Arithmetic $\\mathbb{N}^*$:**\n  Let $T = \\operatorname{Th}(\\mathbb{N})$ and expand language with constant $c$:\n$$\nT^* = T \\cup \\{c > \\mathbf{n} \\mid n \\in \\mathbb{N}\\}\n$$\n  - Any finite subset $T_0 \\subset T^*$ mentions only $c > n_1, \\dots, c > n_k$, satisfied by standard $\\mathbb{N}$ setting $c = \\max(n_i) + 1$.\n  - By Compactness, $T^*$ has a model $\\mathbb{N}^*$ containing an **infinite non-standard integer** $c > \\mathbb{N}$!\n• **Hyperreals $\\mathbb{R}^*$ (Abraham Robinson, 1961):** Adds infinitesimal $\\varepsilon > 0$ such that $\\forall n \\in \\mathbb{N}^+, \\, \\varepsilon < 1/n$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps establishing that the property of a graph being FINITE is not axiomatizable in first-order logic.",
      "orderItems": [
        "Assume for contradiction that a first-order sentence sigma defines finiteness: G |= sigma iff G is a finite graph",
        "Define the infinite family of sentences phi_n asserting 'there exist at least n distinct vertices'",
        "Form the extended theory T = {sigma} cup {phi_n : n >= 2}",
        "Observe that every finite subset T_0 of T is satisfied by a sufficiently large finite complete graph",
        "Apply the Compactness Theorem: T has a model G* which must be simultaneously finite (satisfying sigma) and infinite (satisfying all phi_n), a contradiction"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each non-standard logic concept to its definition.",
      "matchPairs": [
        { "left": "Compactness Theorem", "right": "A first-order theory has a model iff every finite sub-theory has a model" },
        { "left": "Non-Standard Arithmetic N*", "right": "Elementary extension of N containing transfinite integers larger than all standard naturals" },
        { "left": "Hyperreal Field R*", "right": "Non-Archimedean real closed field containing infinitesimals and infinite numbers" },
        { "left": "Łoś's Theorem on Ultraproducts", "right": "First-order sentence phi is true in ultraproduct prod M_i / U iff {i : M_i |= phi} in U" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Compactness Theorem reduces the satisfiability of an infinite theory to the satisfiability of all its ___ subsets.",
      "blankAnswer": "finite",
      "blankDistractors": ["infinite", "countable", "dense"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How does Abraham Robinson's Non-Standard Analysis construct a rigorous positive infinitesimal epsilon > 0 using Compactness?",
      "options": [
        { "text": "Apply Compactness to Th(R) cup {0 < epsilon < 1/n : n in N+}; because every finite subset is satisfied in standard R by setting epsilon = 1/(N+1), the full theory has a model R* containing true infinitesimals", "isCorrect": true, "explanation": "Correct! Every finite subcollection of constraints {epsilon < 1/n : n <= N} has a standard real solution epsilon = 1/(N+1). Compactness guarantees the existence of a hyperreal model containing an infinitesimal strictly smaller than all standard positive reals." },
        { "text": "By dividing zero by zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "By proving the real numbers are inconsistent", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "By asserting 1/infinity = 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
