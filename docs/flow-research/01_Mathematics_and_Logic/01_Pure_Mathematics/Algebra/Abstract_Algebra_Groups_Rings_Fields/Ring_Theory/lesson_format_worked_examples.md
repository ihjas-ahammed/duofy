# Duofy Reusable Lesson Format: Ring Theory - Worked Examples & Calculation

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Abstract_Algebra_Groups_Rings_Fields / Ring_Theory`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to test polynomial irreducibility (Eisenstein's Criterion, Mod $p$ reduction), compute GCDs using the Euclidean Algorithm in $\mathbb{Z}[i]$ or $F[x]$, and evaluate elements in quotient rings $R/I$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Operational Rule / Criterion Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Worked Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Intermediate Condition Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Quantitative GCD / Quotient Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer` (raw number), `numericTolerance` |
| **Slide 5** | Irreducibility Edge-Case Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Irreducibility Test: {{TEST_NAME}}**\nLet $f(x) = a_n x^n + a_{n-1} x^{n-1} + \\dots + a_0 \\in \\mathbb{Z}[x]$.\n$$\n{{CRITERION_FORMULA_OR_RULE}}\n$$\nIf these conditions are satisfied for a prime $p$, then $f(x)$ is irreducible over $\\mathbb{Q}$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1:** {{STEP_1_IDENTIFY_COEFFICIENTS}}\n• **Step 2:** {{STEP_2_CHOOSE_PRIME_P}}\n• **Step 3:** {{STEP_3_VERIFY_DIVISIBILITY_CONDITIONS}}\n• **Step 4:** {{STEP_4_CONCLUDE_IRREDUCIBILITY}}"
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "According to Eisenstein's Criterion for prime p, the prime p squared must NOT divide the constant term ___.",
      "blankAnswer": "a0",
      "blankDistractors": ["an", "a1", "p"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "{{QUANTITATIVE_GCD_OR_DEGREE_PROBLEM_STATEMENT}}",
      "numericAnswer": 3.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "{{EDGE_CASE_IRREDUCIBILITY_QUIZ_PROMPT}}",
      "options": [
        { "text": "{{CORRECT_RESULT}}", "isCorrect": true, "explanation": "Correct! {{WHY_CORRECT}}" },
        { "text": "{{DISTRACTOR_1}}", "isCorrect": false, "explanation": "Incorrect: {{WHY_DISTRACTOR_1}}" },
        { "text": "{{DISTRACTOR_2}}", "isCorrect": false, "explanation": "Incorrect: {{WHY_DISTRACTOR_2}}" },
        { "text": "{{DISTRACTOR_3}}", "isCorrect": false, "explanation": "Incorrect: {{WHY_DISTRACTOR_3}}" }
      ]
    }
  ]
}
```
