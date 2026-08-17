# Duofy Reusable Lesson Format: Actuarial Life Tables and Annuity Contingencies

**Target Topic:** `01_Mathematics_and_Logic / 03_Probability_and_Statistics / Applied_Statistics / Biostatistics_and_Actuarial_Math`  
**Lesson Format Type:** `actuarial_life_tables_and_annuity_contingencies`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Actuarial Life Tables & Contingent Valuation**: evaluate survival probabilities ${}_t p_x = \frac{l_{x+t}}{l_x}$ and mortality ${}_t q_x = 1 - {}_t p_x$, compute **Actuarial Present Value of Life Annuities-Due** $\ddot{a}_x = \sum_{k=0}^\infty v^k \, {}_k p_x$, price **Whole Life Insurance Single Premiums** $A_x = 1 - d \ddot{a}_x$, apply the **Equivalence Principle** ($P_x = A_x / \ddot{a}_x$), and interact with live life table pricing simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Actuarial Life Table & Contingent Valuation Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Actuarial Life Contingency Symbol & Financial Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Annuity-Insurance Relationship A_x = 1 - d a_ddot_x Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Net Premium Principle Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Actuarial Life Annuity & Premium Calculator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "actuarial_life_tables_and_annuity_contingencies",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Actuarial Equivalence Principle for life insurance policies, and how are life annuities-due (ddot{a}_x) and whole life insurance (A_x) related?",
      "blankAnswer": "The Equivalence Principle sets the annual net premium P_x such that the Expected Present Value (EPV) of future premium income equals the EPV of future claim benefits: P_x * ddot{a}_x = A_x => P_x = A_x / ddot{a}_x. Here, ddot{a}_x = sum_{k=0}^infty v^k * {}_k p_x is the EPV of a $1/year continuous life annuity-due to a person aged x, and A_x = sum_{k=0}^infty v^{k+1} * {}_k p_x q_{x+k} is the net single premium for $1 payable at the end of the year of death. They satisfy the fundamental identity: A_x = 1 - d * ddot{a}_x where d = i/(1+i) is the annual rate of discount."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each standard actuarial life contingency symbol to its financial definition.",
      "matchPairs": [
        { "left": "{}_t p_x", "right": "Probability that a life aged x survives for at least t additional years (l_{x+t} / l_x)" },
        { "left": "ddot{a}_x", "right": "Actuarial present value of a whole life annuity-due paying $1 at the start of each year alive" },
        { "left": "A_x", "right": "Net single premium for a whole life insurance paying $1 at the end of year of death" },
        { "left": "P_x = A_x / ddot{a}_x", "right": "Annual level net premium determined by the Equivalence Principle" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "For an interest rate i = 5% (discount factor v = 1/1.05 = 0.9524, discount rate d = 0.05/1.05 = 0.04762), an actuarial valuation finds the life annuity-due value ddot{a}_{65} = 12.50. What is the net single premium A_{65} for a whole life insurance of $1,000?",
      "options": [
        { "text": "$404.76 (using fundamental identity A_x = 1 - d * ddot{a}_x = 1 - 0.04762 * 12.50 = 1 - 0.59524 = 0.40476 per dollar of benefit)", "isCorrect": true, "explanation": "Correct! Using A_x = 1 - d * ddot{a}_x gives A_{65} = 1 - (0.05/1.05) * 12.50 = 0.40476, so for a $1,000 benefit the single premium is $404.76." },
        { "text": "$800.00", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "$125.00", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "$500.00", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What principle in actuarial mathematics sets net premiums so that the expected present value of income equals the expected present value of claims?",
      "blankAnswer": "equivalence"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Actuarial Life Annuity & Premium Calculator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Actuarial Premium Valuation Engine</h3><p>Age: 65 | Benefit: $100,000 Whole Life | Interest: i = 5%</p><button id=\"actBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate Net Annual Premium</button><div id=\"actOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('actBtn').onclick=()=>{document.getElementById('actOut').innerText='Actuarial Results: ä₆₅ = 12.50 | Single Premium A₆₅ = $40,476 | Equivalence Principle Annual Premium: P₆₅ = $40,476 / 12.50 = $3,238.08 / year!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
