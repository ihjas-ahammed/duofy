# Duofy Lesson Format: Worked Examples & Calculation (Mathematics & Logic)

**Subject Discipline:** `01_Mathematics_and_Logic`  
**Lesson Type:** `worked_examples`  
**Pedagogical Purpose:** Train students to perform numerical and symbolic computations, matrix operations, and algorithmic problem solving step-by-step.

---

## 📐 5-Slide Sequential Flow

Each `worked_examples` lesson consists of **EXACTLY 5 SLIDES** following Duofy's Active Recall & Practice-First Architecture:

| Slide # | Slide Function | Duofy Slide Type | Cognitive Phase | Bloom's Level |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Problem Setup & Operational Rule | `theory` | Phase A: Encoding | Understanding |
| **Slide 2** | Step-by-Step Computational Breakdown | `concept_pieces` | Phase A: Encoding | Applying |
| **Slide 3** | Intermediate Step Recall | `fill_in_blank` | Phase B: Recognition | Applying |
| **Slide 4** | Quantitative Numerical Problem | `numerical` | Phase C: Production | Applying / Computing |
| **Slide 5** | Methodological Edge-Case Quiz | `quiz` | Phase C: Production | Analyzing |

---

## 📝 Detailed Slide-by-Slide Content & Schema Specifications

### Slide 1: Problem Setup & Operational Rule
* **Slide Type:** `theory`
* **Purpose:** Introduce the computational formula or algorithm (e.g. Matrix Determinant, Eigenvalues, Derivative rule) with clean LaTeX formatting.
* **JSON Output Schema:**
```json
{
  "type": "theory",
  "content": "**Determinant of a $2 \\times 2$ Matrix**\nFor a matrix $A = \\begin{pmatrix} a & b \\\\ c & d \\end{pmatrix}$, the determinant is calculated as:\n$$\\det(A) = ad - bc$$\nMatrix $A$ is invertible if and only if $\\det(A) \\neq 0$."
}
```

---

### Slide 2: Step-by-Step Computational Breakdown
* **Slide Type:** `concept_pieces`
* **Purpose:** Break down a sample worked example into progressive steps.
* **JSON Output Schema:**
```json
{
  "type": "concept_pieces",
  "content": "• **Step 1:** Identify elements $a=4, b=2, c=1, d=3$ in matrix $A = \\begin{pmatrix} 4 & 2 \\\\ 1 & 3 \\end{pmatrix}$.\n• **Step 2:** Compute diagonal product $ad = 4 \\times 3 = 12$.\n• **Step 3:** Compute off-diagonal product $bc = 2 \\times 1 = 2$.\n• **Step 4:** Subtract $ad - bc = 12 - 2 = 10$."
}
```

---

### Slide 3: Intermediate Step Recall
* **Slide Type:** `fill_in_blank`
* **Purpose:** Test the student's ability to identify the correct algebraic operation for an intermediate step.
* **CRITICAL RULE (Rule 11):** Plain text answer chips, NO LaTeX.
* **JSON Output Schema:**
```json
{
  "type": "fill_in_blank",
  "content": "To find eigenvalues of matrix A, we set the characteristic polynomial det(A - lambda * I) equal to ___.",
  "blankAnswer": "zero",
  "blankDistractors": ["one", "identity", "trace"]
}
```

---

### Slide 4: Quantitative Numerical Problem
* **Slide Type:** `numerical`
* **Purpose:** Direct numerical calculation input to test independent quantitative execution.
* **CRITICAL RULE (Rule 10):** `numericAnswer` MUST be a raw JSON number (e.g., `14.0`), NOT a string or LaTeX equation! `numericTolerance` specifies acceptable error margin.
* **JSON Output Schema:**
```json
{
  "type": "numerical",
  "content": "Calculate the determinant of matrix $B = \\begin{pmatrix} 5 & 2 \\\\ 3 & 4 \\end{pmatrix}$.",
  "numericAnswer": 14.0,
  "numericTolerance": 0.01
}
```

---

### Slide 5: Methodological Edge-Case Quiz
* **Slide Type:** `quiz`
* **Purpose:** Test student discrimination on what happens when the algorithm encounters edge cases (e.g. $\det(A) = 0$).
* **JSON Output Schema:**
```json
{
  "type": "quiz",
  "content": "If $\\det(A) = 0$, what does this imply about the system of linear equations $A x = 0$?",
  "options": [
    {
      "text": "It has a unique solution x = 0",
      "isCorrect": false,
      "explanation": "Incorrect: Unique solution requires det(A) != 0."
    },
    {
      "text": "It has infinitely many non-trivial solutions",
      "isCorrect": true,
      "explanation": "Correct! A determinant of zero means the matrix is singular and has a non-trivial nullspace."
    },
    {
      "text": "The matrix A is invertible",
      "isCorrect": false,
      "explanation": "Incorrect: Singular matrices with zero determinant have no inverse."
    },
    {
      "text": "All eigenvalues of A are equal to 1",
      "isCorrect": false,
      "explanation": "Incorrect: At least one eigenvalue must be 0."
    }
  ]
}
```
