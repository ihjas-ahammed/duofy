# Duofy Reusable Lesson Format: Axiomatic Geometry - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Euclidean_and_Non_Euclidean_Geometry / Axiomatic_Geometry`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the structure of Hilbert's 5 Axiom Groups (Incidence, Betweenness/Order, Congruence, Parallels, Continuity), Euclid's 5th Postulate vs Playfair's Axiom, Neutral (Absolute) Geometry, and the Saccheri-Legendre Theorem.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Axiomatic Systems & Neutral Geometry Formal Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Hilbert's 5 Axiom Groups Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Geometric Property & Axiomatic System Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Saccheri-Legendre Inequality Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Pasch's Axiom Separation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of Neutral (Absolute) Geometry (geometry without the parallel postulate), Euclid's 5th Postulate, Playfair's Axiom, and Hilbert's 5 Axiom Groups.
2. **Slide 2 (`concept_pieces`):** Deconstruct Incidence axioms (points and lines), Order/Betweenness (Pasch's axiom), Congruence (rigid motions / SAS), Parallelism, and Continuity (Archimedes/Dedekind).
3. **Slide 3 (`matching`):** Pair 4 geometric statements (Triangle angle sum $\le 180^\circ$, Triangle angle sum $= 180^\circ$, Triangle angle sum $< 180^\circ$, Exists rectanguloid with 4 right angles) with their valid geometry system (Neutral, Euclidean, Hyperbolic, Euclidean only).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that by the Saccheri-Legendre Theorem, the angle sum of any triangle in neutral geometry is less than or equal to one hundred eighty degrees. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking what Pasch's Axiom states (if a line intersects the interior of a side of a triangle, it must intersect one of the other two sides).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Axiomatic Systems and Neutral Geometry**\n• **Neutral (Absolute) Geometry** is the axiomatic system consisting of all geometric axioms of incidence, betweenness, congruence, and continuity, **without** assuming Euclid's 5th Postulate (or Playfair's Parallel Axiom).\n• **Playfair's Parallel Axiom:** Given a line $\\ell$ and a point $P \\notin \\ell$, there exists *at most one* line through $P$ parallel to $\\ell$.\n• **Saccheri-Legendre Theorem:** In neutral geometry with Archimedean continuity, the sum of the angles of any triangle satisfies:\n$$\n\\sum_{i=1}^3 \\angle_i \\le 180^\\circ \\quad (\\le \\pi \\text{ radians})\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Group I (Incidence):** Formalizes that two distinct points lie on a unique line.\n• **Group II (Betweenness & Pasch's Axiom):** Formalizes linear order on a line and plane separation (a line entering a triangle must exit).\n• **Group III (Congruence):** Establishes segment and angle congruence (including SAS criterion).\n• **Group IV (Parallels):** The single pivot separating Euclidean from Non-Euclidean geometries.\n• **Group V (Continuity):** The Archimedean and Line Completeness axioms, eliminating gaps."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each geometric statement to the axiomatic geometry in which it holds universally.",
      "matchPairs": [
        { "left": "Sum of triangle angles is <= 180 degrees", "right": "Neutral Geometry (Holds in both Euclidean and Hyperbolic)" },
        { "left": "Sum of triangle angles is exactly = 180 degrees", "right": "Euclidean Geometry (Requires Parallel Axiom)" },
        { "left": "Sum of triangle angles is strictly < 180 degrees", "right": "Hyperbolic Geometry (Multiple parallels through a point)" },
        { "left": "There exists a rectangle with four right angles", "right": "Euclidean Geometry (Equivalent to Parallel Postulate)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In neutral geometry, the Saccheri-Legendre Theorem establishes that the sum of the three interior angles of any triangle is less than or equal to one hundred ___ degrees.",
      "blankAnswer": "eighty",
      "blankDistractors": ["ninety", "sixty", "twenty"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the formal statement of Pasch's Axiom (Hilbert's Betweenness Axiom II.4)?",
      "options": [
        { "text": "If a line l in the plane of triangle ABC intersects the interior of side AB, then l must also intersect side AC or side BC (or pass through vertex C)", "isCorrect": true, "explanation": "Correct! Pasch's axiom guarantees that a line cannot get 'trapped' inside a triangle and must exit through another edge." },
        { "text": "Parallel lines never meet", "isCorrect": false, "explanation": "Incorrect: That is Playfair's axiom." },
        { "text": "Two triangles with equal sides are congruent", "isCorrect": false, "explanation": "Incorrect: That is SSS congruence." },
        { "text": "All right angles are equal", "isCorrect": false, "explanation": "Incorrect: That is Euclid's 4th postulate." }
      ]
    }
  ]
}
```
