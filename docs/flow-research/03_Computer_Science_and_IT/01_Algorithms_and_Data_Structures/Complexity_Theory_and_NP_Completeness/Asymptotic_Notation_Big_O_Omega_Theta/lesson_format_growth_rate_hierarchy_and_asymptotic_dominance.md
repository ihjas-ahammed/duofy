# Duofy Reusable Lesson Format: Growth Rate Hierarchy and Asymptotic Dominance

**Target Topic:** `03_Computer_Science_and_IT / 01_Algorithms_and_Data_Structures / Complexity_Theory_and_NP_Completeness / Asymptotic_Notation_Big_O_Omega_Theta`  
**Lesson Format Type:** `growth_rate_hierarchy_and_asymptotic_dominance`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid growth rate sorting, exponential vs polynomial asymptotic dominance, and transcendental function ordering mastery across computational complexity classes (Thomas H. Cormen et al. CLRS Chapter 3; Donald Knuth): master the **Master Hierarchy of Asymptotic Growth Rates** ($O(1) < O(\log\log n) < O(\log n) < O(n^\epsilon) < O(n) < O(n\log n) < O(n^2) < O(n^k) < O(2^n) < O(n!) < O(n^n)$), evaluate non-obvious logarithmic and exponential equivalences (**$2^{\log_2 n} = n$**, **$\log(n!) = \Theta(n\log n)$ via Stirling's Approximation**, **$n^{\log n} = (\log n)^{\log n \cdot \frac{\ln n}{\dots}} = 2^{(\log n)^2}$ [quasi-polynomial]** vs $2^{\sqrt{n}}$ vs $n^{\sqrt{n}}$), prove why any polynomial beats any poly-logarithmic power ($\log^k n = o(n^\epsilon)$ for any $k > 0, \epsilon > 0$), and interact with live mathematical function growth comparison engines.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The Master Complexity Growth Hierarchy & Stirling's Factorial Bound Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Function Ordering from Slowest to Fastest Asymptotic Growth Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Function Expression & Asymptotic Equivalence / Class Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Asymptotic Growth Class of log(n!) Established by Stirling's Approximation Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Asymptotic Growth Rate & Function Scaling Engine Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "growth_rate_hierarchy_and_asymptotic_dominance",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the universal hierarchy of asymptotic growth rates and how do transcendental/factorial functions rank?",
      "blankAnswer": "Asymptotic function dominance hierarchy (CLRS Chapter 3; Donald Knuth): (1) THE CANONICAL HIERARCHY (From slowest to fastest): 1 (Constant) << log(log n) (Double Log) << log n (Logarithmic) << sqrt(n) << n (Linear) << n log n (Linearithmic) << n^2 (Quadratic) << n^3 (Cubic) << n^k (Polynomial) << 2^(sqrt(n)) << 2^n (Exponential) << e^n << 3^n << n! (Factorial) << n^n (Superexponential)! (2) THE GOLDEN RULES: (a) Polylog vs Polynomial: (log n)^k = o(n^epsilon) for ANY k > 0 and ANY epsilon > 0 (even log^100(n) is eventually crushed by n^0.001)! (b) Polynomial vs Exponential: n^k = o(c^n) for any constant c > 1. (3) FACTORIAL & STIRLING'S FORMULA: By Stirling's approximation (n! ~ sqrt(2*pi*n) * (n/e)^n), we have: log(n!) = Theta(n log n), placing log(n!) in the exact same complexity class as Merge Sort!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order these mathematical functions in strictly ascending order of asymptotic growth rate as n approaches infinity.",
      "orderItems": [
        "ln(ln(n)) [Double Logarithmic]",
        "(ln n)^10 [Polylogarithmic]",
        "n^(0.01) [Sub-linear Polynomial]",
        "n * ln(n) [Linearithmic]",
        "2^n [Exponential]"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each mathematical function expression to its simplified asymptotic equivalence.",
      "matchPairs": [
        { "left": "ln(n!)", "right": "Theta(n log n) by Stirling's factorial approximation formula" },
        { "left": "2^(log2 n)", "right": "Theta(n) linear growth by basic logarithmic inverse cancellation" },
        { "left": "n^(log2 c)", "right": "Theta(c^(log2 n)) by the fundamental logarithmic exponent exchange identity" },
        { "left": "sum_(i=1)^n (1/i)", "right": "Theta(log n) harmonic series logarithmic divergence" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "By Stirling's factorial approximation formula, the asymptotic growth rate of log(n!) is tightly bounded by Theta(n ___ n).",
      "blankAnswer": "log",
      "blankDistractors": ["sqrt", "exp", "sqr"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Asymptotic Function Growth Rate Scaling Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Asymptotic Function Dominance Engine</h3><p>Select Input Size n:</p><button id=\"n10\" style=\"padding:8px 14px; margin:3px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">n = 10</button><button id=\"n100\" style=\"padding:8px 14px; margin:3px; background:#8b5cf6; color:white; border:none; border-radius:4px; cursor:pointer;\">n = 100</button><button id=\"n1000\" style=\"padding:8px 14px; margin:3px; background:#ec4899; color:white; border:none; border-radius:4px; cursor:pointer;\">n = 1,000</button><div id=\"funcOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Select an input size n above...</div><script>document.getElementById('n10').onclick=()=>{document.getElementById('funcOut').innerText='n = 10: log(n)=2.3 | n=10 | n^2=100 | 2^n=1,024 | n!=3.6*10^6';}; document.getElementById('n100').onclick=()=>{document.getElementById('funcOut').innerText='n = 100: log(n)=4.6 | n=100 | n^2=10,000 | 2^n=1.26*10^30 | n!=9.3*10^157 (Beyond universe particles!)';}; document.getElementById('n1000').onclick=()=>{document.getElementById('funcOut').innerText='n = 1,000: log(n)=6.9 | n=1,000 | n^2=1,000,000 | 2^1000=1.07*10^301 (Astronomical explosion!)'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
