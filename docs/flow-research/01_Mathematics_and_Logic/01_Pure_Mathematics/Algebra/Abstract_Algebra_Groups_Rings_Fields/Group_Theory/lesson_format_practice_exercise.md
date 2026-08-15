# Duofy Lesson Format: Group Theory - Practice & Interactive Exercise

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Abstract_Algebra_Groups_Rings_Fields / Group_Theory`  
**Lesson Type:** `practice_exercise`  
**Pedagogical Purpose:** Reinforce mathematical fluency, speed, Cayley table interpretation, and interactive permutation drills.

---

## 📐 5-Slide Sequential Flow

Each `practice_exercise` lesson in Group Theory consists of **EXACTLY 5 SLIDES** following Duofy's Active Recall & Practice-First Architecture:

| Slide # | Slide Function | Duofy Slide Type | Cognitive Phase | Bloom's Level |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Group Identity & Spaced Recall | `flashcard` | Phase A: Recall | Remembering |
| **Slide 2** | Permutation Cycle Classification | `matching` | Phase B: Discrimination | Understanding / Applying |
| **Slide 3** | Subgroup Verification Quiz | `quiz` | Phase B: Recognition | Applying |
| **Slide 4** | Exact Term Retrieval | `one_word` | Phase C: Production | Applying / Evaluating |
| **Slide 5** | Interactive Group Cayley Table Simulator | `custom_html` | Phase C: Production | Creating / Simulating |

---

## 📝 Detailed Slide-by-Slide Content & Schema Specifications

### Slide 1: Group Identity & Spaced Recall
* **Slide Type:** `flashcard`
* **Purpose:** Flashcard drill on First Isomorphism Theorem.
* **JSON Output Schema:**
```json
{
  "type": "flashcard",
  "content": "State the First Isomorphism Theorem for a group homomorphism $\\phi: G \\to H$.",
  "blankAnswer": "G / ker(phi) ≅ Im(phi)"
}
```

---

### Slide 2: Permutation Cycle Classification
* **Slide Type:** `matching`
* **Purpose:** Match permutation cycles in $S_n$ with their cycle structures and parities.
* **JSON Output Schema:**
```json
{
  "type": "matching",
  "content": "Match each permutation in S₄ to its cycle parity.",
  "matchPairs": [
    { "left": "(1 2 3)", "right": "Even Permutation (Product of 2 transpositions)" },
    { "left": "(1 2 3 4)", "right": "Odd Permutation (Product of 3 transpositions)" },
    { "left": "(1 2)(3 4)", "right": "Even Permutation (Product of 2 transpositions)" },
    { "left": "(1 2)", "right": "Odd Permutation (Single transposition)" }
  ]
}
```

---

### Slide 3: Subgroup Verification Quiz
* **Slide Type:** `quiz`
* **Purpose:** Test application of 1-Step Subgroup Test ($a b^{-1} \in H$).
* **JSON Output Schema:**
```json
{
  "type": "quiz",
  "content": "To prove a non-empty subset $H$ of a finite group $G$ is a subgroup, which single condition is sufficient?",
  "options": [
    {
      "text": "Closure under multiplication (ab ∈ H for all a,b ∈ H)",
      "isCorrect": true,
      "explanation": "Correct! For FINITE groups, non-emptiness and closure under multiplication automatically implies inverses exist."
    },
    {
      "text": "Every element of H is commutative",
      "isCorrect": false,
      "explanation": "Incorrect: Commutativity makes it abelian, but does not guarantee it contains identity or inverses."
    },
    {
      "text": "H contains the element 1 only",
      "isCorrect": false,
      "explanation": "Incorrect."
    },
    {
      "text": "H has prime order",
      "isCorrect": false,
      "explanation": "Incorrect."
    }
  ]
}
```

---

### Slide 4: Exact Term Retrieval
* **Slide Type:** `one_word`
* **Purpose:** Free-recall typing of a fundamental group concept.
* **CRITICAL RULE (Rule 11):** Plain text, NO LaTeX delimiters (`$`).
* **JSON Output Schema:**
```json
{
  "type": "one_word",
  "content": "What is the term for a group homomorphism that is both injective and surjective?",
  "blankAnswer": "isomorphism"
}
```

---

### Slide 5: Interactive Group Cayley Table Simulator
* **Slide Type:** `custom_html`
* **Purpose:** Interactive HTML5/JS WebView widget where the user completes a $4 \times 4$ Klein 4-Group Cayley table.
* **CRITICAL RULE:** JavaScript MUST call `DuoMessageChannel.postMessage("complete")` when solved! Responsive Glassmorphism styling (`#0b0f19`).
* **JSON Output Schema:**
```json
{
  "type": "custom_html",
  "content": "Interactive Cayley Table Construction",
  "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Klein 4-Group Table: Fill a * a</h3><p>Compute a * a where a is a non-identity element of V₄.</p><button id=\"btnE\" style=\"padding:10px 20px; margin:5px; background:#1cb0f6; color:white; border:none; border-radius:8px; cursor:pointer;\">e</button><button id=\"btnA\" style=\"padding:10px 20px; margin:5px; background:#58cc02; color:white; border:none; border-radius:8px; cursor:pointer;\">a</button><script>document.getElementById('btnE').onclick = function() { DuoMessageChannel.postMessage('complete'); alert('Correct! In V₄, every element is its own inverse (a * a = e).'); }; document.getElementById('btnA').onclick = function() { alert('Try again! In V₄, a * a equals identity e.'); };</script></div>"
}
```
