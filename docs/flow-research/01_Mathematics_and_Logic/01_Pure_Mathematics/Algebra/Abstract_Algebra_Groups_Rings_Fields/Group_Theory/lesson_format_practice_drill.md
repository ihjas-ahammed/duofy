# Duofy Reusable Lesson Format: Practice Drill & Spaced Fluency (Mathematics & Logic)

**Lesson Format Type:** `practice_drill`  
**Applicable Discipline:** `01_Mathematics_and_Logic` (All sub-topics requiring rapid recall, formula fluency, classification, and interactive simulations)  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
The `practice_drill` format builds mathematical retrieval speed, formula fluency, and interactive visual/spatial intuition. It utilizes spaced-repetition flashcards, matching drills, multiple-choice recognition, unprompted typed recall, and interactive webview simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Spaced Recall Formula Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Rapid Classification Matching Drill | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Application & Distractor Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Term / Value Free Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Simulator / Web Canvas Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 🤖 LLM Prompt Generation Rules & Directives

When generating a lesson of type `practice_drill`, the system prompt MUST inject the following instructions:

1. **Slide 1 (`flashcard`):**
   * Present a clear prompt on the front (`content`) asking for a core identity, theorem statement, or formula.
   * Provide the back answer in `blankAnswer`.

2. **Slide 2 (`matching`):**
   * Create 3 to 6 matching pairs pairing transformations, matrices, or formulas with their corresponding geometric/algebraic outcomes.

3. **Slide 3 (`quiz`):**
   * Ask an applied problem-solving question testing distractor discrimination.

4. **Slide 4 (`one_word`):**
   * Require typed unprompted retrieval of a single exact word or term.
   * **STRICT RULE (Rule 11):** Plain text answer ONLY. NO LaTeX `$` or `$$`.

5. **Slide 5 (`custom_html`):**
   * Author an interactive HTML5/CSS3/JavaScript webview simulator widget.
   * **STRICT RULE:** The JavaScript code MUST trigger `DuoMessageChannel.postMessage("complete")` when the user successfully solves or completes the interactive widget!
   * Use responsive Flexbox/Grid layouts with glassmorphism dark theme styling (`#0b0f19` background).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "{{FLASHCARD_FRONT_PROMPT_KEY_FORMULA_OR_THEOREM}}",
      "blankAnswer": "{{FLASHCARD_BACK_SOLUTION_OR_IDENTITY}}"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each {{MATHEMATICAL_OBJECT}} to its {{CORRESPONDING_PROPERTY_OR_RESULT}}.",
      "matchPairs": [
        { "left": "{{OBJECT_1}}", "right": "{{RESULT_1}}" },
        { "left": "{{OBJECT_2}}", "right": "{{RESULT_2}}" },
        { "left": "{{OBJECT_3}}", "right": "{{RESULT_3}}" },
        { "left": "{{OBJECT_4}}", "right": "{{RESULT_4}}" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "{{PRACTICE_DRILL_MULTIPLE_CHOICE_QUESTION_PROMPT}}",
      "options": [
        {
          "text": "{{CORRECT_ANSWER_TEXT}}",
          "isCorrect": true,
          "explanation": "Correct! {{WHY_THIS_IS_CORRECT}}"
        },
        {
          "text": "{{DISTRACTOR_1_TEXT}}",
          "isCorrect": false,
          "explanation": "Incorrect: {{WHY_DISTRACTOR_1_IS_WRONG}}"
        },
        {
          "text": "{{DISTRACTOR_2_TEXT}}",
          "isCorrect": false,
          "explanation": "Incorrect: {{WHY_DISTRACTOR_2_IS_WRONG}}"
        },
        {
          "text": "{{DISTRACTOR_3_TEXT}}",
          "isCorrect": false,
          "explanation": "Incorrect: {{WHY_DISTRACTOR_3_IS_WRONG}}"
        }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "{{UNPROMPTED_TYPED_RECALL_QUESTION_PROMPT}}",
      "blankAnswer": "{{EXACT_PLAIN_TEXT_SINGLE_WORD_ANSWER}}"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Widget: {{SIMULATOR_NAME}}",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>{{WIDGET_TITLE}}</h3><p>{{WIDGET_INSTRUCTIONS}}</p><script>{{WIDGET_JAVASCRIPT_LOGIC}}; if(solved) { DuoMessageChannel.postMessage('complete'); }</script></div>"
    }
  ]
}
```

---

## ⚡ Multi-Domain Math Applications

* **Group Theory:** Cayley table completion widget, Cycle parity matching.
* **Linear Algebra:** Matrix transformation sliders, Subspace basis flashcards.
* **Geometry:** Interactive angle/curvature sliders, Polyhedron property matching.
