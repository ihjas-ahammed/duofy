# Duofy Reusable Lesson Format: Absorption Probabilities and Mean Hitting Times

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Probability_Theory / Stochastic_Processes_and_Markov_Chains / Markov_Chains`  
**Lesson Format Type:** `absorption_probabilities_and_hitting_times`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Absorbing Markov Chains**, compute the **Fundamental Matrix** $N = (I - Q)^{-1} = \sum_{k=0}^\infty Q^k$, solve for **Mean Time to Absorption** $\mathbf{k} = N \mathbf{1}$, evaluate the **Absorption Probability Matrix** $B = N R$, analyze Gambler's Ruin, and interact with live absorbing walk simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Fundamental Matrix & Absorption Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Absorbing Markov Chain Matrix Block Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Gambler's Ruin Absorption Probability Formula Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Fundamental Matrix Inverse Form Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Absorbing Chain & Gambler's Ruin Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "absorption_probabilities_and_hitting_times",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is an Absorbing Markov Chain, and how is the Fundamental Matrix N = (I - Q)^(-1) used to compute expected steps to absorption and absorption probabilities?",
      "blankAnswer": "An absorbing Markov chain has at least one absorbing state (P_ii = 1) accessible from every transient state. By arranging the canonical transition matrix as P = [[Q, R], [0, I]], the Fundamental Matrix is N = (I - Q)^(-1) = sum_{k=0}^infty Q^k, where N_ij is the expected number of times state j is visited starting from i. The expected steps until absorption is k = N * 1, and the probability of being absorbed into specific absorbing state r starting from i is given by matrix B = N * R."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each block matrix in canonical absorbing Markov chain form to its role.",
      "matchPairs": [
        { "left": "Transient-to-Transient Block Q", "right": "Submatrix of transition probabilities among transient states (spectral radius < 1)" },
        { "left": "Transient-to-Absorbing Block R", "right": "Probabilities of direct transitions from transient into absorbing states" },
        { "left": "Fundamental Matrix N = (I - Q)^{-1}", "right": "Entry N_ij = expected total number of visits to transient state j starting from i" },
        { "left": "Absorption Probability Matrix B = N R", "right": "Entry B_ij = probability that a chain starting at transient i ends up in absorbing state j" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In the classical Gambler's Ruin problem (absorbing boundaries at 0 and N with fair coin p = q = 0.5), what is the probability P_i of reaching the fortune N starting with fortune i (0 < i < N)?",
      "options": [
        { "text": "P_i = i / N (linear probability proportional to starting wealth)", "isCorrect": true, "explanation": "Correct! For a fair game p = 0.5, the process is a martingale, giving exact absorption probability P_i = i/N and expected duration E[T_i] = i(N - i)." },
        { "text": "P_i = 1/2 always", "isCorrect": false, "explanation": "Incorrect: Depends on starting fortune i." },
        { "text": "P_i = (i/N)^2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "P_i = 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "In the fundamental matrix formula N = (I - Q)^(-1), what adjective describes the matrix (I - Q) since all eigenvalues of Q are strictly less than 1?",
      "blankAnswer": "invertible"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Gambler's Ruin & Absorption Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Absorbing Markov Chain: Gambler's Ruin</h3><p>Wealth Goal: $10 | Initial Fortune: $4 | Fair Coin (p = 0.5)</p><button id=\"ruinBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Compute Absorption Statistics</button><div id=\"ruinOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('ruinBtn').onclick=()=>{document.getElementById('ruinOut').innerText='Fundamental Matrix Result: P(Reach $10) = 4/10 = 40.0% | P(Ruin at $0) = 60.0% | Expected game duration: E[T] = 4 × (10 - 4) = 24.0 steps!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
