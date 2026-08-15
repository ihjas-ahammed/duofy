# Duofy Reusable Lesson Format: Axiomatic Geometry - Theorem & Proof

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Euclidean_and_Non_Euclidean_Geometry / Axiomatic_Geometry`  
**Lesson Format Type:** `theorem_proof`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the proof of the **Saccheri-Legendre Theorem** (angle sum of any triangle $\le 180^\circ$ in Archimedean neutral geometry) using the bisection and replacement construction.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Saccheri-Legendre Theorem Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Angle Bisection Replacement Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Archimedean Contradiction Limit Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Saccheri Quadrilateral Summit Angle Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Quad-Angle Rectangle Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Saccheri-Legendre Theorem: In neutral geometry with the Archimedean axiom, the sum of the degree measures of the interior angles of any triangle is at most $180^\circ$ ($\sigma(\triangle ABC) = \alpha + \beta + \gamma \le 180^\circ$).
2. **Slide 2 (`ordering`):** Provide 5 steps of the proof by contradiction: (1) assume $\sigma(\triangle ABC) = 180^\circ + \epsilon$ with $\epsilon > 0$, (2) bisect side $BC$ at midpoint $M$, extend median $AM$ to $D$ such that $AM = MD$, (3) show $\triangle ABM \cong \triangle DCM$ by SAS, creating a new triangle $\triangle ACD$ with identical angle sum $\sigma(\triangle ACD) = 180^\circ + \epsilon$, (4) observe $\angle CAD + \angle CDA = \angle A$, so at least one angle in $\triangle ACD$ is $\le \frac{1}{2} \angle A$, (5) repeating $k$ times yields a triangle with one angle $\le \angle A / 2^k < \epsilon$, which forces the sum of the remaining two angles to exceed $180^\circ$, contradicting the Neutral Geometry Exterior Angle Theorem.
3. **Slide 3 (`quiz`):** Test how the Archimedean property forces $\angle A / 2^k < \epsilon$ for sufficiently large $k$.
4. **Slide 4 (`proof`):** Interactive derivation showing the summit angles $\angle C$ and $\angle D$ of a Saccheri quadrilateral are congruent ($\angle C \cong \angle D$).
5. **Slide 5 (`one_word`):** Plain-text recall of the quadrilateral with three right angles (Lambert).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "theorem_proof",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Saccheri-Legendre Theorem**\nIn Neutral Geometry (assuming Hilbert's Incidence, Betweenness, Congruence, and Archimedean Continuity axioms):\nThe sum of the interior angles of any triangle $\\triangle ABC$ is **at most $180^\\circ$**:\n$$\n\\sigma(\\triangle ABC) = \\angle A + \\angle B + \\angle C \\le 180^\\circ\n$$\n*(This foundational result is completely independent of the Parallel Postulate).*"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical proof steps of the Saccheri-Legendre Theorem by contradiction.",
      "orderItems": [
        "Assume there exists a triangle ABC whose angle sum is strictly greater than 180 degrees: sigma(ABC) = 180 + eps with eps > 0",
        "Bisect side BC at midpoint M, and extend median AM to D such that AM = MD",
        "Prove triangle ABM is congruent to triangle DCM via SAS, producing a new triangle ACD with identical angle sum sigma(ACD) = 180 + eps",
        "Observe that angle CAD + angle CDA = angle A, so at least one of these two angles is <= (1/2) angle A",
        "Iterate the construction k times until one angle is < eps; this forces the sum of the remaining two angles to exceed 180 degrees, contradicting the Exterior Angle Theorem"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does the Exterior Angle Theorem in Neutral Geometry prohibit any triangle from having two angles whose sum is >= 180 degrees?",
      "options": [
        { "text": "The exterior angle is strictly greater than either remote interior angle (angle ext > angle int); if two interior angles sum to >= 180, the exterior angle would be <= remote interior angle, a contradiction", "isCorrect": true, "explanation": "Correct! Neutral Exterior Angle Theorem forces any two interior angles of a triangle to sum to strictly less than 180 degrees." },
        { "text": "Because all triangles are equilateral in neutral geometry", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because parallel lines do not exist", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because angle measures cannot be added", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Equality of Summit Angles in a Saccheri Quadrilateral",
      "interactiveSteps": [
        {
          "stepText": "Let ABCD be a Saccheri quadrilateral with perpendicular base angles at A and B (90 deg) and equal vertical sides AD = BC. Draw diagonals AC and BD."
        },
        {
          "prompt": "By SAS on side-angle-side AD-AB-BC, triangle DAB is congruent to triangle CBA. What does this imply about diagonals AC and BD?",
          "options": [
            { "text": "AC = BD (diagonals are congruent)", "isCorrect": true },
            { "text": "AC = 2 BD", "isCorrect": false },
            { "text": "AC is perpendicular to BD", "isCorrect": false },
            { "text": "AC = 0", "isCorrect": false }
          ]
        },
        {
          "stepText": "Applying SSS to triangles ADC and BCD reveals they are congruent, concluding summit angles angle C = angle D."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the surname of the mathematician whose named quadrilateral features three right angles?",
      "blankAnswer": "lambert"
    }
  ]
}
```
