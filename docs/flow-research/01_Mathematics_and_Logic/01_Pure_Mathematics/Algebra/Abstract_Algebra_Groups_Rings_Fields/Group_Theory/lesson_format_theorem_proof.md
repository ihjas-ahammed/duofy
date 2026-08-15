# Duofy Reusable Lesson Format: Theorem & Proof Derivation (Mathematics & Logic)

**Lesson Format Type:** `theorem_proof`  
**Applicable Discipline:** `01_Mathematics_and_Logic` (All mathematical topics requiring proof step sequencing and logical derivations)  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
The `theorem_proof` format teaches mathematical theorems, lemmas, logical derivations, and proof structures. It breaks proof construction into logical chronological ordering, sub-claim verification, interactive step completion, and named corollary recall.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Theorem Statement & Hypotheses | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Logical Proof Strategy Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Sub-Claim / Lemma Justification | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Interactive Step-by-Step Proof | `proof` | Production (Phase C) | `content`, `interactiveSteps` (static/interactive) |
| **Slide 5** | Theorem Consequence & Active Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

When generating a lesson of type `theorem_proof`, the system prompt MUST inject the following instructions:

1. **Slide 1 (`theory`):**
   * State the formal theorem clearly, delineating Premises/Hypotheses ($H_1, H_2$) from Conclusion ($C$).
   * Display main formulas using display LaTeX (`$$ ... $$`). Double-escape all backslashes (`\\\\`).

2. **Slide 2 (`ordering`):**
   * Supply 4 to 6 `orderItems` representing the exact chronological logical proof steps from hypotheses to conclusion.
   * Provide the items in strict correct order in JSON (Duofy client app shuffles them automatically).

3. **Slide 3 (`quiz`):**
   * Ask about the critical mathematical lemma, axiom, or logical equivalence required for a key step in the proof.
   * Every option must contain a clear 1-line pedagogical explanation.

4. **Slide 4 (`proof` / `step_by_step`):**
   * Provide an `interactiveSteps` array containing static steps (`stepText`) intermixed with interactive prompts (`prompt` + `options`).
   * The user must actively solve or complete at least one step in the proof.

5. **Slide 5 (`one_word`):**
   * Test unprompted recall of a fundamental consequence, named corollary, or geometric property resulting from the theorem.
   * **STRICT RULE (Rule 11):** Plain text answer ONLY. NO LaTeX `$` or `$$`.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: {{THEOREM_NAME}}**\nLet {{HYPOTHESES_PREMISES_PROSE}}.\n\nThen:\n$$\n{{THEOREM_FORMULA_STATEMENT}}\n$$\n{{BRIEF_SIGNIFICANCE_NOTE}}"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Reorder the logical steps to construct the proof of {{THEOREM_NAME}}.",
      "orderItems": [
        "{{PROOF_STEP_1_HYPOTHESIS_SETUP}}",
        "{{PROOF_STEP_2_EQUIVALENCE_OR_MAP_CONSTRUCTION}}",
        "{{PROOF_STEP_3_CORE_ALGEBRAIC_OR_LOGICAL_TRANSFORMATION}}",
        "{{PROOF_STEP_4_SUMMATION_OR_BIJECTION_CONCLUSION}}",
        "{{PROOF_STEP_5_FINAL_QED_STATEMENT}}"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "{{JUSTIFICATION_QUESTION_ABOUT_PIVOTAL_PROOF_STEP}}",
      "options": [
        {
          "text": "{{CORRECT_MATHEMATICAL_REASON}}",
          "isCorrect": true,
          "explanation": "Correct! {{WHY_THIS_AXIOM_LEMMA_APPLIES}}"
        },
        {
          "text": "{{FALLACIOUS_REASON_1}}",
          "isCorrect": false,
          "explanation": "Incorrect: {{WHY_FALLACY_1_IS_INVALID}}"
        },
        {
          "text": "{{FALLACIOUS_REASON_2}}",
          "isCorrect": false,
          "explanation": "Incorrect: {{WHY_FALLACY_2_IS_INVALID}}"
        },
        {
          "text": "{{FALLACIOUS_REASON_3}}",
          "isCorrect": false,
          "explanation": "Incorrect: {{WHY_FALLACY_3_IS_INVALID}}"
        }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Interactive Proof Derivation: {{COROLLARY_OR_APPLIED_CASE}}",
      "interactiveSteps": [
        {
          "stepText": "{{GIVEN_SETUP_STEP_TEXT}}"
        },
        {
          "prompt": "{{INTERACTIVE_PROMPT_REQUIRING_STEP_COMPLETION}}",
          "options": [
            { "text": "{{CORRECT_STEP_OPTION}}", "isCorrect": true },
            { "text": "{{INCORRECT_STEP_OPTION_1}}", "isCorrect": false },
            { "text": "{{INCORRECT_STEP_OPTION_2}}", "isCorrect": false },
            { "text": "{{INCORRECT_STEP_OPTION_3}}", "isCorrect": false }
          ]
        },
        {
          "stepText": "{{CONCLUDING_CONFIRMATION_STEP_TEXT}}"
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "{{COROLLARY_OR_NAMED_CONSEQUENCE_RECALL_PROMPT}}",
      "blankAnswer": "{{EXACT_PLAIN_TEXT_SINGLE_WORD_ANSWER}}"
    }
  ]
}
```

---

## ⚡ Multi-Domain Math Applications

* **Abstract Algebra:** First Isomorphism Theorem ($G / \text{ker}(\phi) \cong \text{Im}(\phi)$).
* **Real Analysis:** Cauchy-Schwarz Inequality ($|\langle x, y \rangle| \le \|x\| \|y\|$).
* **Linear Algebra:** Rank-Nullity Theorem ($\text{rank}(A) + \text{nullity}(A) = n$).
* **Differential Equations:** Existence and Uniqueness Theorem (Picard-Lindelöf).
