# Duofy Lesson Format: Theory & Concept Definition (Mathematics & Logic)

**Subject Discipline:** `01_Mathematics_and_Logic`  
**Lesson Type:** `theory_definition`  
**Pedagogical Purpose:** Introduce foundational mathematical definitions, axioms, algebraic structures, and intuitive mental models without cognitive overload.

---

## 📐 5-Slide Sequential Flow

Each `theory_definition` lesson consists of **EXACTLY 5 SLIDES** following Duofy's Active Recall & Practice-First Architecture:

| Slide # | Slide Function | Duofy Slide Type | Cognitive Phase | Bloom's Level |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Formal Definition & Axioms | `theory` | Phase A: Encoding | Remembering / Understanding |
| **Slide 2** | Intuitive Bullet Flow & Mental Model | `concept_pieces` | Phase A: Encoding | Understanding |
| **Slide 3** | Terminology & Symbol Association | `matching` | Phase B: Discrimination | Understanding / Applying |
| **Slide 4** | Key Axiom / Condition Recall | `fill_in_blank` | Phase B: Recognition | Applying |
| **Slide 5** | Conceptual Edge-Case Discrimination | `quiz` | Phase C: Production | Analyzing |

---

## 📝 Detailed Slide-by-Slide Content & Schema Specifications

### Slide 1: Formal Definition & Axioms
* **Slide Type:** `theory`
* **Purpose:** Present the precise mathematical definition or set of axioms clearly and concisely (max ~70 words / 4 sentences).
* **Formatting Rules:** Full LaTeX inline (`$...$`) and display (`$$...$$`) support. Must double-escape all backslashes (`\\frac{a}{b}`).
* **Content Structure:**
  * Bold title of the concept.
  * Formal definition using LaTeX set notation or algebraic structure.
* **JSON Output Schema:**
```json
{
  "type": "theory",
  "content": "**Definition: Group ($G, \\cdot$)**\nA group is a set $G$ together with a binary operation $\\cdot : G \\times G \\to G$ satisfying three core axioms:\n1. **Associativity:** $(a \\cdot b) \\cdot c = a \\cdot (b \\cdot c)$ for all $a, b, c \\in G$.\n2. **Identity:** $\\exists e \\in G$ such that $a \\cdot e = e \\cdot a = a$.\n3. **Inverse:** $\\forall a \\in G, \\exists a^{-1} \\in G$ such that $a \\cdot a^{-1} = e$."
}
```

---

### Slide 2: Intuitive Bullet Flow & Mental Model
* **Slide Type:** `concept_pieces`
* **Purpose:** Break complex mathematical definitions into short, sequential statements to prevent wall-of-text fatigue and build physical intuition.
* **Content Structure:** 3 to 4 sequential bullet points explaining concrete examples (e.g. symmetries of shapes, matrix transformations).
* **JSON Output Schema:**
```json
{
  "type": "concept_pieces",
  "content": "• **Physical Intuition:** Think of a group as a collection of symmetrical actions (like rotating a square by 90°).\n• **Closure:** Performing any two actions in sequence results in another valid action in the set.\n• **Identity Action:** Leaving the object completely untouched serves as the identity element $e$.\n• **Reversibility:** Every action can be undone by its inverse action $a^{-1}$."
}
```

---

### Slide 3: Terminology & Symbol Association
* **Slide Type:** `matching`
* **Purpose:** Force active discrimination between mathematical symbols, properties, and their exact meanings.
* **Content Structure:** 3 to 6 matching pairs (`left` symbol/term $\leftrightarrow$ `right` definition/property).
* **JSON Output Schema:**
```json
{
  "type": "matching",
  "content": "Match each algebraic property to its formal mathematical statement.",
  "matchPairs": [
    { "left": "Closure", "right": "a * b in G for all a,b in G" },
    { "left": "Identity Element", "right": "a * e = a" },
    { "left": "Inverse Element", "right": "a * a^(-1) = e" },
    { "left": "Abelian Group", "right": "a * b = b * a" }
  ]
}
```

---

### Slide 4: Key Axiom / Condition Recall
* **Slide Type:** `fill_in_blank`
* **Purpose:** Test exact recall of crucial mathematical keywords or conditions.
* **CRITICAL RULE (Rule 11):** **NEVER use LaTeX `$` or `$$` inside `fill_in_blank` content, `blankAnswer`, or `blankDistractors`!** User chip selection requires plain text.
* **JSON Output Schema:**
```json
{
  "type": "fill_in_blank",
  "content": "A group in which the binary operation is commutative is called an ___ group.",
  "blankAnswer": "abelian",
  "blankDistractors": ["cyclic", "isomorphic", "normal"]
}
```

---

### Slide 5: Conceptual Edge-Case Discrimination
* **Slide Type:** `quiz`
* **Purpose:** Test deep conceptual understanding by presenting distractor choices representing common student misconceptions.
* **Content Structure:** Exactly 4 options, exactly 1 `isCorrect: true`, each option containing a 1-line pedagogical explanation.
* **JSON Output Schema:**
```json
{
  "type": "quiz",
  "content": "Which of the following sets under standard multiplication is NOT a group?",
  "options": [
    {
      "text": "Non-zero Real Numbers (R \\ {0})",
      "isCorrect": false,
      "explanation": "Valid group: 1 is identity and every non-zero element x has inverse 1/x."
    },
    {
      "text": "Integers (Z)",
      "isCorrect": true,
      "explanation": "Correct! Non-zero integers like 2 do not have multiplicative inverses in Z (1/2 is not an integer)."
    },
    {
      "text": "Positive Rational Numbers (Q^+)",
      "isCorrect": false,
      "explanation": "Valid group: 1 is identity and reciprocal q/p is positive rational."
    },
    {
      "text": "Complex Numbers of modulus 1 (U)",
      "isCorrect": false,
      "explanation": "Valid group under complex multiplication."
    }
  ]
}
```
