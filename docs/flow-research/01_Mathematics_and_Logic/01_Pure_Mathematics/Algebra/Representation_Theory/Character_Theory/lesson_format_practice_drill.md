# Duofy Reusable Lesson Format: Character Theory - Practice Drill & Spaced Fluency

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Representation_Theory / Character_Theory`  
**Lesson Format Type:** `practice_drill`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recall of character degrees ($\sum d_i^2 = |G|$), class size relations, 1D character roots of unity, and interactive character table orthogonality checkers.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Sum of Squares Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Group Order & Irrep Dimensions Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Divisibility of Character Degree Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Character Table Term Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Character Orthogonality Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "practice_drill",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the formula relating the dimensions d_i of all irreducible representations to the order of a finite group G?",
      "blankAnswer": "The sum of the squares of the irreducible dimensions equals the group order: sum_{i=1}^k d_i^2 = |G|."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each group to the dimensions (degrees) of its irreducible representations.",
      "matchPairs": [
        { "left": "Symmetric Group S_3 (|G|=6)", "right": "Degrees: 1, 1, 2 (1^2 + 1^2 + 2^2 = 6)" },
        { "left": "Dihedral Group D_4 (|G|=8)", "right": "Degrees: 1, 1, 1, 1, 2 (4*1^2 + 2^2 = 8)" },
        { "left": "Alternating Group A_4 (|G|=12)", "right": "Degrees: 1, 1, 1, 3 (3*1^2 + 3^2 = 12)" },
        { "left": "Cyclic Group Z_n (|G|=n)", "right": "Degrees: n representations of degree 1" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Which of the following is a strict divisibility rule for the dimension d_i of any irreducible representation of a finite group G?",
      "options": [
        { "text": "d_i must divide the order of the group |G|", "isCorrect": true, "explanation": "Correct! A fundamental theorem of Frobenius and Burnside states that dim(V_i) divides |G|." },
        { "text": "d_i must equal |G| / 2", "isCorrect": false, "explanation": "Incorrect: Degrees do not need to equal |G|/2." },
        { "text": "d_i must be a prime number", "isCorrect": false, "explanation": "Incorrect: Irreducible dimensions can be non-prime (e.g. 1, 4, 6)." },
        { "text": "d_i is always an odd integer", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What linear algebra operation, equal to the sum of eigenvalues, defines the character of a matrix representation?",
      "blankAnswer": "trace"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive S_3 Character Orthogonality Verifier",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>S_3 Character Inner Product</h3><p>Compute &lt;chi_triv, chi_sgn&gt; = (1/6)[1(1)(1) + 3(1)(-1) + 2(1)(1)]</p><button id=\"evalBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Compute &lt;chi_triv, chi_sgn&gt;</button><div id=\"ans\" style=\"margin-top:12px; color:#10b981; font-size:18px; font-weight:bold;\"></div><script>document.getElementById('evalBtn').onclick=()=>{document.getElementById('ans').innerText='(1/6)[1 - 3 + 2] = 0 -> Strictly Orthogonal!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
