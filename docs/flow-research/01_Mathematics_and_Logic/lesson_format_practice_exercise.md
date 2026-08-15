# Duofy Lesson Format: Practice & Interactive Exercise (Mathematics & Logic)

**Subject Discipline:** `01_Mathematics_and_Logic`  
**Lesson Type:** `practice_exercise`  
**Pedagogical Purpose:** Reinforce mathematical fluency, speed, formula recall, and interactive geometric/algebraic problem-solving via active retrieval drills.

---

## 📐 5-Slide Sequential Flow

Each `practice_exercise` lesson consists of **EXACTLY 5 SLIDES** following Duofy's Active Recall & Practice-First Architecture:

| Slide # | Slide Function | Duofy Slide Type | Cognitive Phase | Bloom's Level |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Rapid Formula & Identity Flashcard | `flashcard` | Phase A: Recall | Remembering |
| **Slide 2** | Pair Association & Classification Drill | `matching` | Phase B: Discrimination | Understanding / Applying |
| **Slide 3** | Problem-Solving Multiple Choice | `quiz` | Phase B: Recognition | Applying |
| **Slide 4** | Exact Value / Key Property Recall | `one_word` | Phase C: Production | Applying / Evaluating |
| **Slide 5** | Interactive Derivation OR Canvas Simulator | `custom_html` | Phase C: Production | Creating / Simulating |

---

## 📝 Detailed Slide-by-Slide Content & Schema Specifications

### Slide 1: Rapid Formula & Identity Flashcard
* **Slide Type:** `flashcard`
* **Purpose:** Test spaced repetition self-graded recall of mathematical identities, rules, or formulas.
* **Content Structure:** Front prompt (`content`), back answer (`blankAnswer`).
* **JSON Output Schema:**
```json
{
  "type": "flashcard",
  "content": "What is the formula for the roots of a quadratic equation $a x^2 + b x + c = 0$?",
  "blankAnswer": "x = (-b ± √(b² - 4ac)) / (2a)"
}
```

---

### Slide 2: Pair Association & Classification Drill
* **Slide Type:** `matching`
* **Purpose:** Train rapid classification of mathematical functions, matrices, or sets.
* **JSON Output Schema:**
```json
{
  "type": "matching",
  "content": "Match each matrix transformation to its geometric effect.",
  "matchPairs": [
    { "left": "[[0, -1], [1, 0]]", "right": "90 degree counter-clockwise rotation" },
    { "left": "[[1, 0], [0, -1]]", "right": "Reflection across x-axis" },
    { "left": "[[-1, 0], [0, -1]]", "right": "180 degree rotation around origin" },
    { "left": "[[k, 0], [0, k]]", "right": "Uniform scaling by factor k" }
  ]
}
```

---

### Slide 3: Problem-Solving Multiple Choice
* **Slide Type:** `quiz`
* **Purpose:** Test application of mathematical principles with distractor options targeting miscalculations.
* **JSON Output Schema:**
```json
{
  "type": "quiz",
  "content": "What are the eigenvalues of the matrix $C = \\begin{pmatrix} 2 & 0 \\\\ 0 & 5 \\end{pmatrix}$?",
  "options": [
    {
      "text": "λ₁ = 2, λ₂ = 5",
      "isCorrect": true,
      "explanation": "Correct! For diagonal matrices, eigenvalues are simply the diagonal entries."
    },
    {
      "text": "λ₁ = 10, λ₂ = 7",
      "isCorrect": false,
      "explanation": "Incorrect: 10 is the determinant and 7 is the trace, not the individual eigenvalues."
    },
    {
      "text": "λ₁ = 0, λ₂ = 0",
      "isCorrect": false,
      "explanation": "Incorrect."
    },
    {
      "text": "λ₁ = 2.5, λ₂ = 2.5",
      "isCorrect": false,
      "explanation": "Incorrect."
    }
  ]
}
```

---

### Slide 4: Exact Value / Key Property Recall
* **Slide Type:** `one_word`
* **Purpose:** Require unprompted free-recall typing of a core property name or numerical constant.
* **CRITICAL RULE (Rule 11):** Plain text, NO LaTeX delimiters.
* **JSON Output Schema:**
```json
{
  "type": "one_word",
  "content": "What term describes a square matrix whose transpose equals its negative (A^T = -A)?",
  "blankAnswer": "skew-symmetric"
}
```

---

### Slide 5: Interactive Derivation OR Canvas Simulator
* **Slide Type:** `custom_html`
* **Purpose:** Offer a hands-on webview simulator or interactive canvas widget.
* **CRITICAL RULE:** JavaScript MUST call `DuoMessageChannel.postMessage("complete")` when solved! Responsive CSS using Flexbox/Grid and Glassmorphism styling (`#0b0f19` background).
* **JSON Output Schema:**
```json
{
  "type": "custom_html",
  "content": "Interactive Vector Addition Simulator",
  "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px;\"><h3>Adjust vector components to achieve magnitude = 5.0</h3><label>Vx: <input type=\"range\" id=\"vx\" min=\"0\" max=\"5\" value=\"0\"></label><label>Vy: <input type=\"range\" id=\"vy\" min=\"0\" max=\"5\" value=\"0\"></label><p id=\"mag\">Magnitude: 0.0</p><script>const vx = document.getElementById('vx'); const vy = document.getElementById('vy'); function check() { const m = Math.sqrt(vx.value*vx.value + vy.value*vy.value); document.getElementById('mag').innerText = 'Magnitude: ' + m.toFixed(1); if(Math.abs(m - 5.0) < 0.1) { DuoMessageChannel.postMessage('complete'); } } vx.oninput = check; vy.oninput = check;</script></div>"
}
```
