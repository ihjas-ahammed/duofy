# Duofy Lesson Format: Theorem & Proof Derivation (Mathematics & Logic)

**Subject Discipline:** `01_Mathematics_and_Logic`  
**Lesson Type:** `theorem_proof`  
**Pedagogical Purpose:** Guide the learner through mathematical theorems, lemmas, logical derivations, and step-by-step proofs using interactive logical sequencing.

---

## 📐 5-Slide Sequential Flow

Each `theorem_proof` lesson consists of **EXACTLY 5 SLIDES** following Duofy's Active Recall & Practice-First Architecture:

| Slide # | Slide Function | Duofy Slide Type | Cognitive Phase | Bloom's Level |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Theorem Statement & Hypotheses | `theory` | Phase A: Encoding | Remembering / Understanding |
| **Slide 2** | Logical Strategy & Proof Sequencing | `ordering` | Phase B: Discrimination | Understanding / Applying |
| **Slide 3** | Lemma & Sub-Claim Verification | `quiz` | Phase B: Discrimination | Analyzing |
| **Slide 4** | Interactive Step-by-Step Proof | `proof` | Phase C: Production | Analyzing / Evaluating |
| **Slide 5** | Theorem Consequence & Active Recall | `one_word` | Phase C: Production | Evaluating |

---

## 📝 Detailed Slide-by-Slide Content & Schema Specifications

### Slide 1: Theorem Statement & Hypotheses
* **Slide Type:** `theory`
* **Purpose:** State the formal theorem or lemma with precise mathematical hypotheses and conclusion.
* **Formatting Rules:** Double-escape all backslashes (`\\begin{aligned}`). Use `$ ... $` for inline math and `$$ ... $$` for display equations.
* **JSON Output Schema:**
```json
{
  "type": "theory",
  "content": "**Lagrange's Theorem**\nLet $G$ be a finite group and let $H \\le G$ be a subgroup of $G$.\n\nThen the order of $H$ divides the order of $G$:\n$$\\text{order}(H) \\mid \\text{order}(G)$$\nMoreover, the number of distinct left cosets of $H$ in $G$ (the index $[G : H]$) satisfies:\n$$[G : H] = \\frac{|G|}{|H|}$$"
}
```

---

### Slide 2: Logical Strategy & Proof Sequencing
* **Slide Type:** `ordering`
* **Purpose:** Force the learner to reconstruct the logical architecture of the proof by placing key proof steps in the correct chronological order.
* **Content Structure:** 3 to 6 `orderItems` specified in exact correct order (App automatically shuffles them for the user).
* **JSON Output Schema:**
```json
{
  "type": "ordering",
  "content": "Reorder the logical steps to prove Lagrange's Theorem for a finite group G.",
  "orderItems": [
    "Define the relation a ~ b iff a^(-1)b in H to partition G into left cosets aH.",
    "Show that this relation is an equivalence relation, proving cosets form a partition.",
    "Establish a bijection f: H -> aH via f(h) = ah to prove every coset has size |H|.",
    "Sum the sizes of all distinct cosets to conclude |G| = [G:H] * |H|.",
    "Conclude that |H| divides |G|."
  ]
}
```

---

### Slide 3: Lemma & Sub-Claim Verification
* **Slide Type:** `quiz`
* **Purpose:** Test critical reasoning regarding a pivotal lemma or step inside the proof.
* **JSON Output Schema:**
```json
{
  "type": "quiz",
  "content": "In proving that two left cosets $aH$ and $bH$ are either identical or disjoint, which property is fundamentally required?",
  "options": [
    {
      "text": "The group operation is commutative",
      "isCorrect": false,
      "explanation": "Incorrect: Lagrange's theorem holds for non-abelian groups as well."
    },
    {
      "text": "Equivalence classes under an equivalence relation partition the set",
      "isCorrect": true,
      "explanation": "Correct! Cosets are equivalence classes of the relation a ~ b iff a^(-1)b in H."
    },
    {
      "text": "The subgroup H is normal in G",
      "isCorrect": false,
      "explanation": "Incorrect: Normality is required for G/H to form a quotient group, not for coset partitioning."
    },
    {
      "text": "The group G is cyclic",
      "isCorrect": false,
      "explanation": "Incorrect: Cyclicity is not required."
    }
  ]
}
```

---

### Slide 4: Interactive Step-by-Step Proof
* **Slide Type:** `proof` (or `step_by_step`)
* **Purpose:** Guide the user through the mathematical derivation line-by-line, requiring interactive input on key steps.
* **Content Structure:** `interactiveSteps` containing static `stepText` and interactive steps with `prompt` and `options`.
* **JSON Output Schema:**
```json
{
  "type": "proof",
  "content": "Interactive Derivation: Index of Subgroup",
  "interactiveSteps": [
    {
      "stepText": "Let $|G| = 24$ and let $H$ be a subgroup of $G$ with $|H| = 6$."
    },
    {
      "prompt": "According to Lagrange's Theorem, what is the exact index $[G : H]$?",
      "options": [
        { "text": "4", "isCorrect": true },
        { "text": "18", "isCorrect": false },
        { "text": "144", "isCorrect": false },
        { "text": "Unknown without Cayley table", "isCorrect": false }
      ]
    },
    {
      "stepText": "Since $[G : H] = |G| / |H| = 24 / 6 = 4$, there are exactly 4 distinct left cosets."
    }
  ]
}
```

---

### Slide 5: Theorem Consequence & Active Recall
* **Slide Type:** `one_word`
* **Purpose:** Test unprompted typed memory retrieval of a major corollary or named consequence of the theorem.
* **CRITICAL RULE (Rule 11):** **NEVER use LaTeX `$` or `$$` inside `one_word` questions, `blankAnswer`, or distractors!**
* **JSON Output Schema:**
```json
{
  "type": "one_word",
  "content": "A group whose order is a prime number p has no non-trivial subgroups. What type of group MUST it be?",
  "blankAnswer": "cyclic"
}
```
