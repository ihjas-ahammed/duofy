# Duofy Reusable Lesson Format: Concept Introduction & Definition (Mathematics & Logic)

**Lesson Format Type:** `concept_introduction`  
**Applicable Discipline:** `01_Mathematics_and_Logic` (All sub-topics: Algebra, Analysis, Geometry, Topology, Number Theory, Logic)  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
The `concept_introduction` format introduces a new mathematical concept, set of axioms, algebraic structure, or topological space. It transitions the learner from raw formal definitions to intuitive mental models, followed by immediate distractor discrimination and active recall.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Formal Definition & LaTeX Notation | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Intuitive Deconstructed Bullet Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Symbol & Property Association Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Key Axiom / Condition Completion | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` (3) |
| **Slide 5** | Conceptual Edge-Case Discrimination | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

When generating a lesson of type `concept_introduction`, the system prompt MUST inject the following instructions:

1. **Slide 1 (`theory`):**
   * Limit narrative prose to max ~70 words (4 sentences).
   * Present the formal definition using precise mathematical notation.
   * Wrap inline math in `$ ... $` and display equations in `$$ ... $$`.
   * **Mandate:** Double-escape all backslashes inside JSON strings (`\\frac{a}{b}`, `\\in`, `\\forall`).

2. **Slide 2 (`concept_pieces`):**
   * Provide 3 to 4 sequential bullet points translating the formal definition into a physical, geometric, or intuitive mental model.
   * Use bold lead-in tags for each bullet point (`• **Visual Intuition:** ...`).

3. **Slide 3 (`matching`):**
   * Supply 3 to 6 key-value pairs matching mathematical terms/symbols on the `left` with their exact properties/definitions on the `right`.

4. **Slide 4 (`fill_in_blank`):**
   * Construct a single sentence with a `___` blank testing a critical condition or term.
   * **STRICT RULE (Rule 11):** NEVER include LaTeX `$` or `$$` in `content`, `blankAnswer`, or `blankDistractors`. Plain text only.

5. **Slide 5 (`quiz`):**
   * Provide exactly 4 options with exactly 1 `isCorrect: true`.
   * Include a 1-line pedagogical explanation for EVERY option explaining why it is correct or why it is a distractor.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: {{CONCEPT_NAME}}**\n{{FORMAL_DEFINITION_PROSE}}\n$$\n{{PRIMARY_DISPLAY_EQUATION_OR_AXIOMS}}\n$$\n{{KEY_NOTE_ON_NOTATION}}"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Intuitive Model:** {{MENTAL_MODEL_BULLET_1}}\n• **Key Property:** {{KEY_PROPERTY_BULLET_2}}\n• **Operational Rule:** {{OPERATIONAL_RULE_BULLET_3}}\n• **Boundary Condition:** {{BOUNDARY_CONDITION_BULLET_4}}"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each {{CONCEPT_NAME}} property to its formal mathematical condition.",
      "matchPairs": [
        { "left": "{{TERM_1}}", "right": "{{DEFINITION_OR_CONDITION_1}}" },
        { "left": "{{TERM_2}}", "right": "{{DEFINITION_OR_CONDITION_2}}" },
        { "left": "{{TERM_3}}", "right": "{{DEFINITION_OR_CONDITION_3}}" },
        { "left": "{{TERM_4}}", "right": "{{DEFINITION_OR_CONDITION_4}}" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "{{PLAIN_TEXT_QUESTION_PROMPT_WITH_SINGLE____BLANK}}",
      "blankAnswer": "{{EXACT_PLAIN_TEXT_CORRECT_TOKEN}}",
      "blankDistractors": [
        "{{PLAUSIBLE_DISTRACTOR_1}}",
        "{{PLAUSIBLE_DISTRACTOR_2}}",
        "{{PLAUSIBLE_DISTRACTOR_3}}"
      ]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "{{EDGE_CASE_OR_DISCRIMINATION_QUESTION_PROMPT}}",
      "options": [
        {
          "text": "{{CORRECT_OPTION_TEXT}}",
          "isCorrect": true,
          "explanation": "Correct! {{PEDAGOGICAL_EXPLANATION_WHY_CORRECT}}"
        },
        {
          "text": "{{DISTRACTOR_OPTION_1_TEXT}}",
          "isCorrect": false,
          "explanation": "Incorrect: {{EXPLANATION_WHY_MISCONCEPTION_1}}"
        },
        {
          "text": "{{DISTRACTOR_OPTION_2_TEXT}}",
          "isCorrect": false,
          "explanation": "Incorrect: {{EXPLANATION_WHY_MISCONCEPTION_2}}"
        },
        {
          "text": "{{DISTRACTOR_OPTION_3_TEXT}}",
          "isCorrect": false,
          "explanation": "Incorrect: {{EXPLANATION_WHY_MISCONCEPTION_3}}"
        }
      ]
    }
  ]
}
```

---

## ⚡ Concrete Instantiation Examples for Topic Generation

* **Group Theory Example:** `{{CONCEPT_NAME}}` = Normal Subgroup ($N \unlhd G$), `{{FORMAL_DEFINITION_PROSE}}` = $g N g^{-1} = N$, `{{PLAIN_TEXT_QUESTION_PROMPT}}` = "A subgroup whose left and right cosets coincide is called a ___ subgroup.", `{{blankAnswer}}` = "normal".
* **Linear Algebra Example:** `{{CONCEPT_NAME}}` = Eigenvector, `{{FORMAL_DEFINITION_PROSE}}` = $A v = \lambda v$, `{{blankAnswer}}` = "eigenvalue".
* **Real Analysis Example:** `{{CONCEPT_NAME}}` = Compact Space, `{{FORMAL_DEFINITION_PROSE}}` = Every open cover has a finite subcover, `{{blankAnswer}}` = "compact".
