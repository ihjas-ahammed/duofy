# Duofy Reusable Lesson Format: Worked Examples & Calculation (Mathematics & Logic)

**Lesson Format Type:** `worked_examples`  
**Applicable Discipline:** `01_Mathematics_and_Logic` (All quantitative and computational sub-topics: Matrix Algebra, Calculus, Differential Equations, Applied Math, Numerical Methods)  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
The `worked_examples` format trains students in quantitative calculations, formula applications, matrix operations, and procedural algorithms. It moves from general formula setup to step-by-step worked walkthroughs, culminating in unprompted numeric calculations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Computational Formula & Rule Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Worked Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential calculation steps) |
| **Slide 3** | Intermediate Step Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Independent Quantitative Problem | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Calculation Edge-Case / Boundary Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

When generating a lesson of type `worked_examples`, the system prompt MUST inject the following instructions:

1. **Slide 1 (`theory`):**
   * Introduce the operational formula or matrix transformation algorithm clearly.
   * Highlight domain restrictions or conditions (e.g., $\det(A) \neq 0$, $x > 0$).

2. **Slide 2 (`concept_pieces`):**
   * Walk through a concrete numerical example step-by-step (3-5 steps).
   * Show exact intermediate arithmetic/algebraic steps so the learner sees the mechanical progression.

3. **Slide 3 (`fill_in_blank`):**
   * Test an intermediate operation or variable choice in the algorithm.
   * **STRICT RULE (Rule 11):** Plain text answer, NO LaTeX `$` or `$$`.

4. **Slide 4 (`numerical`):**
   * Present a new, unprompted numerical problem for the student to solve independently.
   * **STRICT RULE (Rule 10):** `numericAnswer` MUST be a raw JSON number (e.g. `14.0` or `-3.5`), NOT a string or LaTeX equation! `numericTolerance` must be specified (e.g. `0.01`).

5. **Slide 5 (`quiz`):**
   * Test student understanding of what happens when special matrix conditions or edge cases occur (e.g., zero determinant, zero discriminant, boundary values).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Operational Formula: {{OPERATION_NAME}}**\nTo compute {{QUANTITY_OR_TRANSFORMATION_GOAL}}, use the formula:\n$$\n{{COMPUTATIONAL_FORMULA}}\n$$\nwhere {{VARIABLE_DEFINITIONS_PROSE}}."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** {{WORKED_STEP_1_SETUP}}\n• **Step 2:** {{WORKED_STEP_2_SUBSTITUTION}}\n• **Step 3:** {{WORKED_STEP_3_INTERMEDIATE_EVALUATION}}\n• **Step 4:** {{WORKED_STEP_4_FINAL_SIMPLIFICATION}}"
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "{{INTERMEDIATE_PROCEDURAL_QUESTION_WITH____BLANK}}",
      "blankAnswer": "{{EXACT_PLAIN_TEXT_CORRECT_STEP_TOKEN}}",
      "blankDistractors": [
        "{{WRONG_PROCEDURAL_STEP_1}}",
        "{{WRONG_PROCEDURAL_STEP_2}}",
        "{{WRONG_PROCEDURAL_STEP_3}}"
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "{{NEW_UNPROMPTED_QUANTITATIVE_PROBLEM_STATEMENT_WITH_LATEX}}",
      "numericAnswer": 42.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "{{EDGE_CASE_OR_BOUNDARY_CONDITION_QUIZ_PROMPT}}",
      "options": [
        {
          "text": "{{CORRECT_EDGE_CASE_RESULT_TEXT}}",
          "isCorrect": true,
          "explanation": "Correct! {{WHY_THIS_EDGE_CASE_BEHAVES_THIS_WAY}}"
        },
        {
          "text": "{{DISTRACTOR_RESULT_1}}",
          "isCorrect": false,
          "explanation": "Incorrect: {{MISCONCEPTION_1_EXPLANATION}}"
        },
        {
          "text": "{{DISTRACTOR_RESULT_2}}",
          "isCorrect": false,
          "explanation": "Incorrect: {{MISCONCEPTION_2_EXPLANATION}}"
        },
        {
          "text": "{{DISTRACTOR_RESULT_3}}",
          "isCorrect": false,
          "explanation": "Incorrect: {{MISCONCEPTION_3_EXPLANATION}}"
        }
      ]
    }
  ]
}
```

---

## ⚡ Multi-Domain Math Applications

* **Group Theory:** Element Order $|a|$ calculation in $\mathbb{Z}_n^*$, Permutation cycle multiplication.
* **Linear Algebra:** Eigenvalue calculation $\det(A - \lambda I) = 0$, Matrix inverse $A^{-1} = \frac{1}{\det(A)} \text{adj}(A)$.
* **Multivariable Calculus:** Gradient $\nabla f$, Double integrals $\iint_D f(x,y) dx dy$.
* **Differential Equations:** Solving 2nd Order ODEs via characteristic polynomial $r^2 + a r + b = 0$.
