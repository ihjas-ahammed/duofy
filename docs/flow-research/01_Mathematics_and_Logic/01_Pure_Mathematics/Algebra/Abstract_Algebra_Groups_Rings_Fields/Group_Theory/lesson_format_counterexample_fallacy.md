# Duofy Reusable Lesson Format: Misconceptions, Edge Cases & Fallacies (Mathematics & Logic)

**Lesson Format Type:** `counterexample_fallacy`  
**Applicable Discipline:** `01_Mathematics_and_Logic` (All mathematical topics requiring rigorous edge-case analysis, fallacy identification, and counterexample construction)  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
The `counterexample_fallacy` format deepens mathematical rigor by exposing subtle logical fallacies, invalid assumptions, false converses, and edge-case exceptions. It trains students to look beyond plausible-sounding claims and verify mathematical statements with strict rigor.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Plausible Fallacy / False Converse Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Fallacy Dissection & Counterexample Flow | `concept_pieces` | Encoding (Phase A) | `content` (Sequential breakdown) |
| **Slide 3** | Fallacy Line Identification | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | False Claim vs Counterexample Matching | `matching` | Recognition (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 5** | Corrected Rigorous Proof Reordering | `ordering` | Production (Phase C) | `content`, `orderItems` (3-6 corrected steps) |

---

## 🤖 LLM Prompt Generation Rules & Directives

When generating a lesson of type `counterexample_fallacy`, the system prompt MUST inject the following instructions:

1. **Slide 1 (`theory`):**
   * Present a widely held student misconception, false converse (e.g. "If $f$ is continuous, $f$ is differentiable"), or subtle algebraic fallacy.

2. **Slide 2 (`concept_pieces`):**
   * Dissect why the false claim fails step-by-step. Introduce a explicit concrete counterexample (e.g. Weierstrass continuous non-differentiable function or $S_3$ non-abelian group).

3. **Slide 3 (`quiz`):**
   * Present a pseudo-proof with a hidden logical flaw (e.g. division by zero, assuming commutativity) and ask the student to identify which exact line breaks mathematical validity.

4. **Slide 4 (`matching`):**
   * Match false general statements on the `left` with their explicit counterexamples on the `right`.

5. **Slide 5 (`ordering`):**
   * Require the learner to reorder the steps of the corrected, mathematically sound proof or counterexample verification.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "counterexample_fallacy",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Common Fallacy / False Converse: {{FALSE_CLAIM_TITLE}}**\nConsider the intuitive assertion:\n$$\n{{FALSE_CONVERSE_OR_FALLACIOUS_FORMULA}}\n$$\nWhile this claim appears plausible at first glance, it is **MATHEMATICALLY FALSE** without additional hypotheses!"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Where it Fails:** {{WHY_THE_LOGIC_BREAKS_DOWN}}\n• **The Counterexample:** {{EXPLICIT_COUNTEREXAMPLE_NAME_AND_FORMULA}}\n• **Verification:** {{STEP_SHOWING_COUNTEREXAMPLE_SATISFIES_HYPOTHESIS}}\n• **Result:** {{STEP_SHOWING_COUNTEREXAMPLE_FAILS_CONCLUSION}}"
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In the following flawed proof for {{TOPIC_NAME}}, where does the logical error occur?\n\n1. Let $a = b$\n2. $a^2 = a b$\n3. $a^2 - b^2 = a b - b^2$\n4. $(a-b)(a+b) = b(a-b)$\n5. $a+b = b$\n6. $2b = b \\implies 2 = 1$",
      "options": [
        {
          "text": "Step 5 (Dividing both sides by (a - b) when a - b = 0)",
          "isCorrect": true,
          "explanation": "Correct! Since a = b, (a - b) = 0. Division by zero is undefined and invalidates the proof."
        },
        {
          "text": "Step 2 (Multiplying both sides by a)",
          "isCorrect": false,
          "explanation": "Incorrect: Multiplication by a non-zero element is valid."
        },
        {
          "text": "Step 4 (Factoring algebraic expressions)",
          "isCorrect": false,
          "explanation": "Incorrect: Factoring is algebraically correct."
        },
        {
          "text": "Step 1 (Setting a = b)",
          "isCorrect": false,
          "explanation": "Incorrect: Setting variables equal is valid setup."
        }
      ]
    },
    {
      "slideIndex": 4,
      "type": "matching",
      "content": "Match each false mathematical claim to its definitive counterexample.",
      "matchPairs": [
        { "left": "{{FALSE_CLAIM_1}}", "right": "{{COUNTEREXAMPLE_1}}" },
        { "left": "{{FALSE_CLAIM_2}}", "right": "{{COUNTEREXAMPLE_2}}" },
        { "left": "{{FALSE_CLAIM_3}}", "right": "{{COUNTEREXAMPLE_3}}" },
        { "left": "{{FALSE_CLAIM_4}}", "right": "{{COUNTEREXAMPLE_4}}" }
      ]
    },
    {
      "slideIndex": 5,
      "type": "ordering",
      "content": "Reorder the steps to rigorously prove the corrected theorem with the necessary additional hypothesis.",
      "orderItems": [
        "{{CORRECTED_STEP_1_HYPOTHESIS}}",
        "{{CORRECTED_STEP_2_VALIDATION}}",
        "{{CORRECTED_STEP_3_TRANSFORMATION}}",
        "{{CORRECTED_STEP_4_CONCLUSION}}"
      ]
    }
  ]
}
```

---

## ⚡ Multi-Domain Math Applications

* **Group Theory:** Converse of Lagrange's Theorem is false (e.g. $A_4$ of order 12 has no subgroup of order 6).
* **Real Analysis:** Continuous functions are not necessarily differentiable (e.g. $|x|$ at $x=0$).
* **Linear Algebra:** $A B = 0$ does not imply $A = 0$ or $B = 0$ (Zero divisors in matrix rings).
* **Topology:** Connected spaces are not necessarily path-connected (e.g. Topologist's Sine Curve).
