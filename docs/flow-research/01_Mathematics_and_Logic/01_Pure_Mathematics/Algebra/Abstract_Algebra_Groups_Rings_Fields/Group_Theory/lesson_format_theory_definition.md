# Duofy Lesson Format: Group Theory - Theory & Definition

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Abstract_Algebra_Groups_Rings_Fields / Group_Theory`  
**Lesson Type:** `theory_definition`  
**Pedagogical Purpose:** Introduce foundational Group Theory definitions (Groups, Subgroups, Normal Subgroups, Homomorphisms) and physical symmetry mental models without cognitive overload.

---

## 📐 5-Slide Sequential Flow

Each `theory_definition` lesson in Group Theory consists of **EXACTLY 5 SLIDES** following Duofy's Active Recall & Practice-First Architecture:

| Slide # | Slide Function | Duofy Slide Type | Cognitive Phase | Bloom's Level |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Formal Axiomatic Definition | `theory` | Phase A: Encoding | Remembering / Understanding |
| **Slide 2** | Concrete Mental Model & Symmetry Flow | `concept_pieces` | Phase A: Encoding | Understanding |
| **Slide 3** | Symbol & Property Association | `matching` | Phase B: Discrimination | Understanding / Applying |
| **Slide 4** | Key Condition / Axiom Fill-in-the-Blank | `fill_in_blank` | Phase B: Recognition | Applying |
| **Slide 5** | Group vs Non-Group Discrimination Quiz | `quiz` | Phase C: Production | Analyzing |

---

## 📝 Detailed Slide-by-Slide Content & Schema Specifications

### Slide 1: Formal Axiomatic Definition
* **Slide Type:** `theory`
* **Purpose:** State the formal mathematical definition of a Group $(G, \cdot)$ or Subgroup $(H \le G)$ concisely (max ~70 words / 4 sentences).
* **Formatting Rules:** Full LaTeX inline (`$...$`) and display (`$$...$$`) support. Must double-escape backslashes (`\\cdot`, `\\in`).
* **Content Structure:**
```json
{
  "type": "theory",
  "content": "**Definition: Group ($G, \\cdot$)**\nA group is a set $G$ together with a binary operation $\\cdot : G \\times G \\to G$ satisfying three core axioms:\n1. **Associativity:** $(a \\cdot b) \\cdot c = a \\cdot (b \\cdot c)$ for all $a, b, c \\in G$.\n2. **Identity:** $\\exists e \\in G$ such that $a \\cdot e = e \\cdot a = a$ for all $a \\in G$.\n3. **Inverse:** $\\forall a \\in G, \\exists a^{-1} \\in G$ such that $a \\cdot a^{-1} = a^{-1} \\cdot a = e$."
}
```

---

### Slide 2: Concrete Mental Model & Symmetry Flow
* **Slide Type:** `concept_pieces`
* **Purpose:** Translate abstract axioms into physical symmetry actions (e.g. Dihedral group $D_3$ rotating an equilateral triangle) split into bite-sized sequential bullets.
* **Content Structure:** 3 to 4 short sequential points.
```json
{
  "type": "concept_pieces",
  "content": "• **Symmetry Mental Model:** Think of group elements as rotational actions on a physical shape (like rotating a triangle by 120°).\n• **Closure:** Combining two valid rotations always yields another valid rotation in the set.\n• **Identity Action ($e$):** Doing nothing (0° rotation) acts as the identity element.\n• **Inverse Action ($a^{-1}$):** Rotating backwards by -120° perfectly undoes the +120° rotation."
}
```

---

### Slide 3: Symbol & Property Association
* **Slide Type:** `matching`
* **Purpose:** Interactive column matching to associate Group Theory concepts with their algebraic equations.
* **Content Structure:** 3-6 matching pairs (`left` term $\leftrightarrow$ `right` property).
```json
{
  "type": "matching",
  "content": "Match each Group Theory property to its exact mathematical condition.",
  "matchPairs": [
    { "left": "Subgroup (H ≤ G)", "right": "h1 * h2^(-1) in H for all h1,h2 in H" },
    { "left": "Abelian Group", "right": "a * b = b * a for all a,b in G" },
    { "left": "Normal Subgroup (N ⊴ G)", "right": "g * N * g^(-1) = N for all g in G" },
    { "left": "Homomorphism Kernel", "right": "Set of elements x in G such that phi(x) = e_H" }
  ]
}
```

---

### Slide 4: Key Condition / Axiom Fill-in-the-Blank
* **Slide Type:** `fill_in_blank`
* **Purpose:** Test unprompted recall of fundamental Group Theory terminology.
* **CRITICAL RULE (Rule 11):** **NEVER use LaTeX `$` or `$$` inside `fill_in_blank` content, `blankAnswer`, or `blankDistractors`!**
```json
{
  "type": "fill_in_blank",
  "content": "A subgroup H is called a ___ subgroup if g * H * g^(-1) = H for all elements g in G.",
  "blankAnswer": "normal",
  "blankDistractors": ["cyclic", "abelian", "isomorphic"]
}
```

---

### Slide 5: Group vs Non-Group Discrimination Quiz
* **Slide Type:** `quiz`
* **Purpose:** Force discrimination between valid groups and non-groups based on failure of specific axioms (e.g. lack of inverses).
* **Content Structure:** Exactly 4 options, 1 `isCorrect: true`, 1-line pedagogical explanation each.
```json
{
  "type": "quiz",
  "content": "Which of the following algebraic structures is NOT a group?",
  "options": [
    {
      "text": "(R \\ {0}, ×)",
      "isCorrect": false,
      "explanation": "Valid group: 1 is identity and non-zero reals have inverses 1/x."
    },
    {
      "text": "(Z, ×)",
      "isCorrect": true,
      "explanation": "Correct! Non-zero integers like 2 lack multiplicative inverses in Z (1/2 is not an integer)."
    },
    {
      "text": "(Z, +)",
      "isCorrect": false,
      "explanation": "Valid group: 0 is identity and inverse of n is -n."
    },
    {
      "text": "Symmetric Group S₃ under composition",
      "isCorrect": false,
      "explanation": "Valid non-abelian group of degree 3."
    }
  ]
}
```
