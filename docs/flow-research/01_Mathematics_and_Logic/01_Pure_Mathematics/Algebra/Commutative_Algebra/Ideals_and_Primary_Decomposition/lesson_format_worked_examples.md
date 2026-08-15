# Duofy Reusable Lesson Format: Ideals and Primary Decomposition - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Commutative_Algebra / Ideals_and_Primary_Decomposition`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute minimal primary decompositions of polynomial and monomial ideals (such as $(x^2, xy)$, $(xy, xz)$, or $(x^2, xy, xz)$ in $k[x, y, z]$), identify minimal and embedded primes, and determine radical intersections.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Primary Decomposition Calculation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Monomial Decomposition Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Associated Prime Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Number of Associated Primes Count | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Non-Uniqueness of Embedded Component Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the decomposition of $I = (x^2, xy)$ in $k[x, y]$: $I = (x) \cap (x^2, y)$. Differentiate the minimal component $(x)$ from the embedded component $(x^2, y)$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4-step process: factoring generators, identifying radical components, verifying intersection, classifying isolated vs embedded primes.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that isolated components correspond to minimal primes. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to calculate the exact number of associated prime ideals for a concrete ideal (e.g., $I = (x^2, xy)$ has $|\text{Ass}(R/I)| = 2$).
5. **Slide 5 (`quiz`):** Quiz testing why the embedded primary component in $(x^2, xy) = (x) \cap \mathfrak{q}_2$ is not unique (e.g., $\mathfrak{q}_2$ can be $(x^2, y)$ or $(x^2, xy, y^2)$ or $(x^2, y + cx)$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Worked Example: Decomposing $I = (x^2, xy)$ in $k[x, y]$**\nThe ideal $I = (x^2, xy)$ decomposes as:\n$$\n(x^2, xy) = (x) \\cap (x^2, y)\n$$\nHere:\n• $\\mathfrak{q}_1 = (x)$ is prime (hence $(x)$-primary) with $\\mathfrak{p}_1 = (x)$ (minimal prime).\n• $\\mathfrak{q}_2 = (x^2, y)$ is $(x, y)$-primary with $\\mathfrak{p}_2 = (x, y)$ (embedded prime, since $\\mathfrak{p}_1 \\subsetneq \\mathfrak{p}_2$)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Factor Generators):** Factor $x^2 = x \\cdot x$ and $xy = x \\cdot y$. Both share the common factor $x$.\n• **Step 2 (Split Minimal Component):** The line $x = 0$ is the main visual component, giving primary component $(x)$.\n• **Step 3 (Find Residue at Origin):** When $x \\ne 0$, $y$ must vanish; at $x=0$, $x^2=0$ gives nilpotent order 2 at origin $(0,0)$.\n• **Step 4 (Verify Intersection):** Check $(x) \\cap (x^2, y) = (x \\cdot (x^2, y)) + (x^2) = (x^2, xy)$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "In a primary decomposition, the primary components corresponding to ___ primes are uniquely determined.",
      "blankAnswer": "minimal",
      "blankDistractors": ["embedded", "maximal", "zero"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "How many associated prime ideals does the ideal I = (x^2, xy) have in k[x, y]?",
      "numericAnswer": 2.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Which of the following is ALSO a valid minimal primary decomposition of I = (x^2, xy) in k[x, y]?",
      "options": [
        { "text": "(x) ∩ (x^2, xy, y^2)", "isCorrect": true, "explanation": "Correct! (x^2, xy, y^2) is an (x, y)-primary ideal, and (x) ∩ (x^2, xy, y^2) = (x^2, xy). Embedded components are not unique!" },
        { "text": "(x) ∩ (y)", "isCorrect": false, "explanation": "Incorrect: (x) ∩ (y) = (xy), which is strictly larger than (x^2, xy)." },
        { "text": "(x^2) ∩ (y)", "isCorrect": false, "explanation": "Incorrect: (x^2) ∩ (y) = (x^2 y)." },
        { "text": "(x, y) ∩ (x^2, y^2)", "isCorrect": false, "explanation": "Incorrect: Does not equal (x^2, xy)." }
      ]
    }
  ]
}
```
