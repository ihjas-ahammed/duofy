# Duofy Reusable Lesson Format: Generated Sigma-Algebras and Independence

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory / Measure_Theoretic_Probability/Probability_Spaces_and_Random_Variables`  
**Lesson Format Type:** `generated_sigma_algebras_and_independence`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Generated $\sigma$-Algebras** $\sigma(X) = \{X^{-1}(B) \mid B \in \mathcal{B}(\mathbb{R})\}$, interpret $\sigma(X)$ as the **information content** observable through $X$, evaluate the rigorous measure-theoretic definition of **Independence** ($P(A \cap B) = P(A)P(B)$ for all $A \in \mathcal{G}_1, B \in \mathcal{G}_2$), and explore Dynkin's $\pi$-$\lambda$ Theorem.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Generated Sigma-Algebra & Independence Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Information Sub-Sigma-Algebra & Observable Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Dynkin Pi-Lambda Theorem Sufficiency Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Indicator Function Generated Sigma-Algebra Size Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Sigma-Algebra Partition & Information Tree Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "generated_sigma_algebras_and_independence",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Generated Sigma-Algebra sigma(X) of a random variable X, and how is independence of random variables defined in measure theory?",
      "blankAnswer": "The generated sigma-algebra sigma(X) = {X^{-1}(B) : B in B(R)} is the smallest sub-sigma-algebra of F making X measurable; it represents all events whose occurrence can be determined by observing the value of X. Two random variables X and Y are INDEPENDENT if and only if their generated sigma-algebras sigma(X) and sigma(Y) are independent: P(A cap B) = P(A) * P(B) for EVERY event A in sigma(X) and EVERY event B in sigma(Y)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each random variable to its generated sigma-algebra structure.",
      "matchPairs": [
        { "left": "Constant Random Variable X(omega) = c", "right": "Trivial sigma-algebra {emptyset, Omega} (contains zero information)" },
        { "left": "Indicator Random Variable X = 1_A", "right": "Four-element sigma-algebra {emptyset, A, A^c, Omega}" },
        { "left": "Discrete Random Variable with Partition {E_k}", "right": "All possible countable unions of partition atoms E_k" },
        { "left": "Dynkin's pi-lambda Theorem", "right": "Proves independence on full sigma-algebras by checking only simple pi-systems (rectangles)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "To prove that two continuous random variables X and Y are independent, why is it sufficient to show that joint CDF factors as F_{X,Y}(x, y) = F_X(x) F_Y(y) for all x, y in R?",
      "options": [
        { "text": "By Dynkin's pi-lambda Theorem: The family of semi-infinite rectangles (-infty, x] x (-infty, y] forms a pi-system (closed under intersection) that generates the entire 2D Borel sigma-algebra B(R^2)", "isCorrect": true, "explanation": "Correct! Dynkin's lemma guarantees that if two probability measures agree on a pi-system, they agree on the entire generated sigma-algebra." },
        { "text": "Because all functions are linear", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because CDFs are always zero", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because independence holds only at infinity", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "For a non-trivial indicator random variable X = 1_A (where 0 < P(A) < 1), what is the total number of sets in the generated sigma-algebra sigma(X) (write as word four)?",
      "blankAnswer": "four"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Generated Sigma-Algebra Explorer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Information in σ(X)</h3><p>Coin Toss Space: Ω = {HH, HT, TH, TT} | Let X = Number of Heads</p><button id=\"infoBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Generate σ(X) Partition Atoms</button><div id=\"infoOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('infoBtn').onclick=()=>{document.getElementById('infoOut').innerText='Partition Atoms: {TT} (X=0), {HT, TH} (X=1), {HH} (X=2). σ(X) contains exactly 2³ = 8 measurable events! Observing X cannot distinguish HT from TH.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
