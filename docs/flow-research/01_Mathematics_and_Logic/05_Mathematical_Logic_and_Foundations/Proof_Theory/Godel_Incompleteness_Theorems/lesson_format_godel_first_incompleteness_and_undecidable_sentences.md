# Duofy Reusable Lesson Format: Gödel's First Incompleteness Theorem and Undecidable Sentences

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Proof_Theory / Godel_Incompleteness_Theorems`  
**Lesson Format Type:** `godel_first_incompleteness_and_undecidable_sentences`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through **Gödel's First Incompleteness Theorem (1931)**: construct the Gödel sentence $G_T \leftrightarrow \neg \operatorname{Prov}_T(\ulcorner G_T \urcorner)$, prove that if $T$ is consistent then $T \not\vdash G_T$, prove that if $T$ is $\omega$-consistent then $T \not\vdash \neg G_T$, examine **Rosser's Theorem (1936)** eliminating the $\omega$-consistency requirement, and understand why $G_T$ is **true** in the standard model $\mathbb{N}$ despite being unprovable.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Gödel's First Incompleteness Theorem Formal Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Proof of Unprovability T not |- G_T Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Incompleteness Condition & Theoretical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Standard Model Truth Status of Gödel Sentence Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Rosser Sentence Comparison and Omega Consistency Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Gödel's First Incompleteness Theorem (G1, 1931): Let $T$ be a consistent, computably axiomatizable formal system containing Robinson arithmetic $Q$. Then there exists an arithmetic sentence $G_T$ such that:
   1. If $T$ is **consistent**, then $T \not\vdash G_T$.
   2. If $T$ is **$\omega$-consistent**, then $T \not\vdash \neg G_T$.
   State the Semantic Truth of $G_T$: Sentence $G_T$ asserts $\neg \operatorname{Prov}_T(\ulcorner G_T \urcorner)$ ("I am unprovable in $T$"). Since $T$ cannot prove $G_T$, $G_T$ is **true in the standard model $\mathbb{N}$**! State Rosser's Strengthening (1936): Replacing $G_T$ with the Rosser sentence $R_T$ proves incompleteness assuming **only simple consistency**.
2. **Slide 2 (`concept_pieces`):** Deconstruct proof of $T \not\vdash G_T$: (1) by the Diagonal Lemma applied to $\psi(y) = \neg \operatorname{Prov}_T(y)$, we have $T \vdash G_T \leftrightarrow \neg \operatorname{Prov}_T(\ulcorner G_T \urcorner)$, (2) assume for contradiction that $T \vdash G_T$, (3) since $T$ is sound for $\Sigma_1^0$ formulas, $T \vdash \operatorname{Prov}_T(\ulcorner G_T \urcorner)$, (4) but by the equivalence $G_T \leftrightarrow \neg \operatorname{Prov}_T(\ulcorner G_T \urcorner)$, $T \vdash \neg \operatorname{Prov}_T(\ulcorner G_T \urcorner)$, (5) thus $T$ proves both $\operatorname{Prov}_T(\ulcorner G_T \urcorner)$ and its negation $\neg \operatorname{Prov}_T(\ulcorner G_T \urcorner)$, contradicting the consistency of $T$, concluding $T \not\vdash G_T$!
3. **Slide 3 (`matching`):** Pair 4 formal systems/concepts (Peano Arithmetic $PA$, Presburger Arithmetic, Robinson Arithmetic $Q$, Gödel Sentence $G$) with their completeness and provability status.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in the standard model of natural numbers $\mathbb{N}$, the Gödel sentence $G_T$ is true. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why Presburger Arithmetic (addition only, no multiplication) is NOT subject to Gödel's Incompleteness Theorem: (Because Mojżesz Presburger proved in 1929 that the first-order theory of $(\mathbb{N}, +)$ is DECIDABLE and COMPLETE; multiplication is required to encode prime factorizations and arithmetize syntax).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "godel_first_incompleteness_and_undecidable_sentences",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Gödel's First Incompleteness Theorem (G1, 1931)**\n• **Hypotheses:** Let $T$ be a formal system that is:\n  1. **Consistent** (does not prove $0 = 1$).\n  2. **Computably Axiomatizable** (axioms can be recognized by an algorithm).\n  3. **Contains Robinson Arithmetic $Q$** (can represent basic addition and multiplication).\n• **The Theorem:** There exists an arithmetic sentence $G_T$ such that:\n$$\nT \\not\\vdash G_T \\quad \\text{and} \\quad T \\not\\vdash \\neg G_T\n$$\n($G_T$ is **undecidable / independent** of $T$).\n• **The Epistemic Paradox:** $G_T$ asserts 'I am not provable in $T$'. Because $G_T$ is unprovable, $G_T$ is **strictly TRUE in the standard model $\\mathbb{N}$**!"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Construct $G_T$):** Apply Diagonal Lemma to $\\neg \\operatorname{Prov}_T(x)$ to obtain $T \\vdash G_T \\leftrightarrow \\neg \\operatorname{Prov}_T(\\ulcorner G_T \\urcorner)$.\n• **Step 2 (Assume Provability):** Suppose for contradiction that $T \\vdash G_T$.\n• **Step 3 (Witness Existence):** There exists a valid proof code $p$ of $G_T$, so $T \\vdash \\operatorname{Prf}_T(\\mathbf{p}, \\ulcorner G_T \\urcorner) \\implies T \\vdash \\operatorname{Prov}_T(\\ulcorner G_T \\urcorner)$.\n• **Step 4 (Substitute Equivalence):** Since $T \\vdash G_T$, by the definition of $G_T$, $T \\vdash \\neg \\operatorname{Prov}_T(\\ulcorner G_T \\urcorner)$.\n• **Step 5 (Contradiction):** $T$ proves both $\\operatorname{Prov}_T(\\ulcorner G_T \\urcorner)$ and $\\neg \\operatorname{Prov}_T(\\ulcorner G_T \\urcorner)$, contradicting consistency $\\implies T \\not\\vdash G_T$!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each formal mathematical theory to its completeness status.",
      "matchPairs": [
        { "left": "Peano Arithmetic (PA)", "right": "Incomplete and undecidable (subject to Gödel's theorems)" },
        { "left": "Presburger Arithmetic (N, +)", "right": "Complete and decidable (lacks multiplication to encode syntax)" },
        { "left": "Tarski's Real Closed Fields (R, +, x)", "right": "Complete and decidable (Euclidean geometry is complete!)" },
        { "left": "Zermelo-Fraenkel Set Theory (ZFC)", "right": "Incomplete (cannot decide Continuum Hypothesis or own consistency)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Even though the Gödel sentence G_T cannot be proven within formal system T, it is mathematically ___ in the standard model of natural numbers N.",
      "blankAnswer": "true",
      "blankDistractors": ["false", "contradictory", "undefined"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does Gödel's First Incompleteness Theorem NOT apply to Presburger Arithmetic (the theory of natural numbers with addition only: (N, +))?",
      "options": [
        { "text": "Presburger arithmetic lacks MULTIPLICATION; without multiplication, it is impossible to perform prime factorizations to arithmetize syntax and construct self-referential Gödel sentences (Mojżesz Presburger proved (N, +) is complete and decidable in 1929)", "isCorrect": true, "explanation": "Correct! Gödel numbering relies on the Unique Factorization Theorem (multiplication) to encode arbitrary sequences of symbols into single numbers. Without multiplication, the system cannot talk about its own proofs." },
        { "text": "Because addition is inconsistent", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Presburger arithmetic has infinitely many axioms", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because all numbers in Presburger arithmetic are even", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
