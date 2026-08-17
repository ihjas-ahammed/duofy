# Duofy Reusable Lesson Format: Arithmetization of Syntax and the Diagonal Lemma

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Proof_Theory / Godel_Incompleteness_Theorems`  
**Lesson Format Type:** `arithmetization_of_syntax_and_diagonal_lemma`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce **Arithmetization of Syntax (Gödel Numbering)** $\ulcorner \phi \urcorner \in \mathbb{N}$, define the substitution primitive recursive function $\operatorname{sub}(x, y) = \ulcorner \phi_x(\mathbf{y}) \urcorner$, prove the **Diagonal Lemma / Fixed Point Theorem (Carnap & Gödel)** ($\forall \psi(y) \, \exists \phi: T \vdash \phi \leftrightarrow \psi(\ulcorner \phi \urcorner)$), and explore how formal arithmetic constructs paradoxical self-referential sentences without logical inconsistency.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Gödel Numbering & Diagonal Lemma Mathematical Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Proof of the Diagonal Lemma Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Metamathematical Property & Arithmetic Representation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Substitution Function Primitive Recursive Term Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Tarski Undefinability of Truth Diagonal Corollary Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Arithmetization of Syntax: In any formal arithmetic system $T$ containing Robinson arithmetic $Q$, every symbol, formula $\phi$, and finite sequence of formulas (proof $p$) is assigned an effective unique integer code $\ulcorner \phi \urcorner \in \mathbb{N}$ via prime factorizations. State the Substitution Function $\operatorname{sub}(m, n)$: A primitive recursive function representing the Gödel number of the formula obtained by substituting the numeral $\mathbf{n}$ for the free variable $v$ in the formula with Gödel number $m$: $\operatorname{sub}(\ulcorner \alpha(v) \urcorner, n) = \ulcorner \alpha(\mathbf{n}) \urcorner$. State the Diagonal Lemma (Carnap 1934, Gödel 1931): For ANY first-order formula $\psi(y)$ with one free variable, there exists a sentence $\phi$ such that:
   $$T \vdash \phi \longleftrightarrow \psi(\ulcorner \phi \urcorner)$$
2. **Slide 2 (`concept_pieces`):** Deconstruct proof of the Diagonal Lemma: (1) let $\operatorname{Sub}(x, y, z)$ be the formula in $T$ representing the function $\operatorname{sub}(x, y) = z$, (2) given arbitrary formula $\psi(y)$, define helper formula $\alpha(x) \equiv \exists z \, (\operatorname{Sub}(x, x, z) \land \psi(z))$, (3) let $k = \ulcorner \alpha(x) \urcorner$ be the Gödel number of helper formula $\alpha(x)$, (4) define the diagonal sentence $\phi \equiv \alpha(\mathbf{k}) = \exists z \, (\operatorname{Sub}(\mathbf{k}, \mathbf{k}, z) \land \psi(z))$, (5) note that $\ulcorner \phi \urcorner = \operatorname{sub}(k, k)$, so in $T$, $\operatorname{Sub}(\mathbf{k}, \mathbf{k}, z)$ forces $z = \ulcorner \phi \urcorner$, concluding $T \vdash \phi \leftrightarrow \psi(\ulcorner \phi \urcorner)$!
3. **Slide 3 (`matching`):** Pair 4 metamathematical predicates ($\operatorname{Prf}_T(p, x)$, $\operatorname{Prov}_T(x) = \exists p \, \operatorname{Prf}_T(p, x)$, $\operatorname{sub}(x, y)$, Gödel Sentence $G_T$) with their semantic definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the Diagonal Lemma is also known in mathematical logic as the Fixed Point Lemma. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Tarski's Theorem on the Undefinability of Truth (1936): Applying the Diagonal Lemma to the negation of a hypothetical truth predicate $\psi(y) = \neg \operatorname{True}(y)$ yields a sentence $L$ with $T \vdash L \leftrightarrow \neg \operatorname{True}(\ulcorner L \urcorner)$ (The Liar Paradox). What does this prove? (A consistent formal arithmetic system CANNOT contain its own truth predicate $\operatorname{True}(x)$; truth is strictly undefinable in the system).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "arithmetization_of_syntax_and_diagonal_lemma",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Arithmetization of Syntax and the Diagonal Lemma**\n• **Gödel Numbering $\\ulcorner \\phi \\urcorner$:** An injective computable encoding mapping every symbol, formula $\\phi$, and proof $p$ to a unique positive integer $\\ulcorner \\phi \\urcorner \\in \\mathbb{N}$.\n• **Substitution Function $\\operatorname{sub}(m, n)$:** Primitive recursive function computing:\n$$\n\\operatorname{sub}(\\ulcorner \\alpha(v) \\urcorner, n) = \\ulcorner \\alpha(\\mathbf{n}) \\urcorner\n$$\n(Replaces free variable $v$ with the numeral for $n$).\n• **The Diagonal Lemma (Carnap-Gödel Fixed Point Theorem):**\n  For **any** first-order formula $\\psi(y)$ with one free variable, there exists a sentence $\\phi$ such that:\n$$\nT \\vdash \\phi \\longleftrightarrow \\psi(\\ulcorner \\phi \\urcorner)\n$$\n(Sentence $\\phi$ asserts that its **own** Gödel number satisfies property $\\psi$!)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Represent Substitution):** Let $\\operatorname{Sub}(x, x, z)$ be the formula in $T$ representing the diagonal function $\\operatorname{sub}(x, x) = z$.\n• **Step 2 (Construct Helper Formula):** For given property $\\psi(y)$, define:\n  $$\\alpha(x) \\equiv \\exists z \\, (\\operatorname{Sub}(x, x, z) \\land \\psi(z))$$\n• **Step 3 (Encode Helper):** Let $k = \\ulcorner \\alpha(x) \\urcorner$ be the Gödel number of $\\alpha(x)$.\n• **Step 4 (Define Fixed Point Sentence):** Substitute numeral $\\mathbf{k}$ into $\\alpha$:\n  $$\\phi \\equiv \\alpha(\\mathbf{k}) = \\exists z \\, (\\operatorname{Sub}(\\mathbf{k}, \\mathbf{k}, z) \\land \\psi(z))$$\n• **Step 5 (Equivalence):** Since $\\operatorname{sub}(k, k) = \\ulcorner \\alpha(\\mathbf{k}) \\urcorner = \\ulcorner \\phi \\urcorner$, $T \\vdash \\phi \\leftrightarrow \\psi(\\ulcorner \\phi \\urcorner)$!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each metamathematical predicate to its formal arithmetic definition.",
      "matchPairs": [
        { "left": "Proof Predicate Prf_T(p, x)", "right": "Primitive recursive relation asserting p encodes a valid proof of formula x in T" },
        { "left": "Provability Predicate Prov_T(x)", "right": "Sigma_1^0 formula exists p : Prf_T(p, x) asserting x is provable in T" },
        { "left": "Diagonal Lemma Sentence phi", "right": "Fixed-point sentence satisfying T |- phi <-> psi([phi])" },
        { "left": "Consistency Sentence Con(T)", "right": "not Prov_T([0 = 1]) (asserts that falsehood cannot be proven in T)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Because the Diagonal Lemma produces a sentence that asserts a property of its own code, it is also called the ___ Point Lemma.",
      "blankAnswer": "fixed",
      "blankDistractors": ["limit", "critical", "saddle"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What did Alfred Tarski prove in 1936 by applying the Diagonal Lemma to the negated predicate psi(y) = not True(y)?",
      "options": [
        { "text": "TARSKI'S UNDEFINABILITY OF TRUTH: If system T is consistent, there cannot exist any first-order arithmetic formula True(x) satisfying T |- phi <-> True([phi]) for all sentences phi (arithmetic truth is not definable in arithmetic)", "isCorrect": true, "explanation": "Correct! Applying the Diagonal Lemma to not True(x) constructs the Liar sentence L <-> not True([L]). If a truth predicate existed, this would generate an immediate contradiction L <-> not L, proving truth cannot be formalized in T." },
        { "text": "All true sentences are provable", "isCorrect": false, "explanation": "Incorrect: Gödel showed some true sentences are unprovable." },
        { "text": "Logic contains no paradoxes", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Arithmetic is complete", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
