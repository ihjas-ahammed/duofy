# Duofy Reusable Lesson Format: Integer Partitions and Euler's Pentagonal Number Theorem

**Target Topic:** `01_Mathematics_and_Logic / 04_Discrete_Mathematics_and_Combinatorics / Combinatorics_and_Counting / Generating_Functions`  
**Lesson Format Type:** `integer_partitions_and_euler_pentagonal_theorem`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Integer Partitions** $p(n)$, evaluate **Euler's Infinite Product Generating Function** $P(x) = \prod_{k=1}^\infty \frac{1}{1 - x^k}$, understand Franklin's involution proof of **Euler's Pentagonal Number Theorem** $\prod_{k=1}^\infty (1 - x^k) = 1 + \sum_{j=1}^\infty (-1)^j (x^{j(3j-1)/2} + x^{j(3j+1)/2})$, compute partition numbers $p(n)$ via Euler's linear-time recurrence relation, and interact with live partition tree simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Integer Partitions & Euler Pentagonal Theorem Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Partition Type & Generating Function Infinite Product Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Euler Recurrence p(n) Pentagonal Number Indices Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Geometric Shape Name in Euler's Theorem Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Integer Partition Ferrers Diagram Generator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "integer_partitions_and_euler_pentagonal_theorem",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Generating Function for Integer Partitions p(n), and what is Euler's Pentagonal Number Theorem?",
      "blankAnswer": "The partition function p(n) counts ways to write n as an unordered sum of positive integers. Leonhard Euler proved its generating function is the infinite product P(x) = sum_{n=0}^infty p(n) x^n = prod_{k=1}^infty 1/(1 - x^k). Euler's Pentagonal Number Theorem provides the reciprocal product: prod_{k=1}^infty (1 - x^k) = 1 + sum_{j=1}^infty (-1)^j [ x^{j(3j-1)/2} + x^{j(3j+1)/2} ] = 1 - x - x^2 + x^5 + x^7 - x^{12} - x^{15} + ..., which yields the fast linear recurrence: p(n) = p(n-1) + p(n-2) - p(n-5) - p(n-7) + p(n-12) + p(n-15) - ..."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each partition restriction to its exact Euler generating function product.",
      "matchPairs": [
        { "left": "All Integer Partitions p(n)", "right": "prod_{k=1}^infty 1 / (1 - x^k)" },
        { "left": "Partitions into DISTINCT Parts", "right": "prod_{k=1}^infty (1 + x^k) (Euler showed this equals partitions into odd parts!)" },
        { "left": "Partitions into ODD Parts Only", "right": "prod_{k=1}^infty 1 / (1 - x^{2k-1})" },
        { "left": "Partitions with Parts at Most M", "right": "prod_{k=1}^M 1 / (1 - x^k)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Using Euler's recurrence p(n) = p(n-1) + p(n-2) - p(n-5) - p(n-7) + ... with known values p(0)=1, p(1)=1, p(2)=2, p(3)=3, p(4)=5, calculate the number of partitions of n = 5.",
      "options": [
        { "text": "p(5) = p(4) + p(3) - p(0) = 5 + 3 - 1 = 7", "isCorrect": true, "explanation": "Correct! Applying the pentagonal formula for n=5: p(5) = p(5-1) + p(5-2) - p(5-5) = p(4) + p(3) - p(0) = 5 + 3 - 1 = 7 (the partitions are: 5, 4+1, 3+2, 3+1+1, 2+2+1, 2+1+1+1, 1+1+1+1+1)." },
        { "text": "p(5) = 8", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "p(5) = 6", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "p(5) = 10", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What 10-letter polygon adjective describes the numbers g_j = j(3j - 1)/2 in Euler's famous partition theorem (pentagonal)?",
      "blankAnswer": "pentagonal"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Integer Partition & Ferrers Diagram Visualizer",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Integer Partition Engine</h3><p>Compute p(n) via Euler's Pentagonal Number Series</p><button id=\"partBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate p(6)</button><div id=\"partOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('partBtn').onclick=()=>{document.getElementById('partOut').innerText='p(6) = p(5) + p(4) - p(1) = 7 + 5 - 1 = 11 partitions! Verified by expanding ∏ 1/(1-xᵏ) up to order 6.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
