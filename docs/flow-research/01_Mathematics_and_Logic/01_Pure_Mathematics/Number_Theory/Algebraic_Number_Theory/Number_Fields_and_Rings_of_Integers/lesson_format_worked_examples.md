# Duofy Reusable Lesson Format: Number Fields and Rings of Integers - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Algebraic_Number_Theory / Number_Fields_and_Rings_of_Integers`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly factor rational primes into prime ideals using the Dedekind-Kummer Theorem in quadratic fields (e.g. factoring $(2), (3), (5)$ in $\mathcal{O}_K = \mathbb{Z}[\sqrt{-5}]$), compute the Minkowski bound $M_K = \frac{4}{\pi} \sqrt{20} \approx 5.7$, and determine the Class Number $h_K = 2$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | $\mathbb{Q}(\sqrt{-5})$ Prime Ideal Factorization Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Prime Factorization Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Principal Ideal Status Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Class Number Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Gaussian Integer Prime Splitting Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the problem: Factor the rational primes $(2), (3),$ and $(5)$ into prime ideals in $\mathcal{O}_K = \mathbb{Z}[\sqrt{-5}]$ (where $f(x) = x^2 + 5$, discriminant $\Delta_K = -20$).
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) $p=2$: $x^2 + 5 \equiv x^2 + 1 \equiv (x+1)^2 \pmod 2 \implies (2) = \mathfrak{p}_2^2$ where $\mathfrak{p}_2 = (2, 1+\sqrt{-5})$ (ramified), (2) $p=3$: $x^2 + 5 \equiv x^2 - 1 \equiv (x+1)(x-1) \pmod 3 \implies (3) = \mathfrak{p}_3 \mathfrak{p}_3'$ where $\mathfrak{p}_3 = (3, 1+\sqrt{-5}), \mathfrak{p}_3' = (3, 1-\sqrt{-5})$ (split), (3) $p=5$: $x^2 + 5 \equiv x^2 \pmod 5 \implies (5) = \mathfrak{p}_5^2$ where $\mathfrak{p}_5 = (\sqrt{-5})$ (ramified principal), (4) evaluate non-principal status of $\mathfrak{p}_2$: since $N(a+b\sqrt{-5}) = a^2 + 5b^2 = 2$ has no integer solutions, $\mathfrak{p}_2$ is non-principal, so $h_K = 2$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the ideal $\mathfrak{p}_2 = (2, 1+\sqrt{-5})$ is non-principal because no element in $\mathbb{Z}[\sqrt{-5}]$ has norm 2. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to compute the class number $h_K = |\operatorname{Cl}(\mathbb{Q}(\sqrt{-5}))|$ ($h_K = 2.0$).
5. **Slide 5 (`quiz`):** Quiz asking: In the Gaussian integers $\mathbb{Z}[i]$, how does the rational prime $p = 5$ factor? ($(5) = (2+i)(2-i)$ splits into two distinct conjugate principal prime ideals).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Factoring Rational Primes in $K = \\mathbb{Q}(\\sqrt{-5})$**\nHere $\\mathcal{O}_K = \\mathbb{Z}[\\sqrt{-5}]$ with minimal polynomial $f(x) = x^2 + 5$ and discriminant $\\Delta_K = -20$.\n• **Minkowski Bound:** $M_K = \\frac{4}{\\pi} \\frac{2!}{2^2} \\sqrt{20} = \\frac{2}{\\pi} \\sqrt{20} \\approx 2.85$.\n• To determine the class group $\\operatorname{Cl}(K)$, we only need to factor primes $p \\le 2$ (namely $p = 2$)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Factor $p=2$):** $x^2 + 5 \\equiv x^2 + 1 \\equiv (x+1)^2 \\pmod 2$.\n  $$(2) = \\mathfrak{p}_2^2, \\quad \\text{where } \\mathfrak{p}_2 = (2, \\, 1 + \\sqrt{-5})$$\n• **Step 2 (Factor $p=3$):** $x^2 + 5 \\equiv x^2 - 1 \\equiv (x-1)(x+1) \\pmod 3$.\n  $$(3) = \\mathfrak{p}_3 \\mathfrak{p}_3', \\quad \\mathfrak{p}_3 = (3, 1+\\sqrt{-5}), \\; \\mathfrak{p}_3' = (3, 1-\\sqrt{-5})$$\n• **Step 3 (Factor $p=5$):** $x^2 + 5 \\equiv x^2 \\pmod 5 \\implies (5) = (\\sqrt{-5})^2$.\n• **Step 4 (Class Number):** $\\mathfrak{p}_2$ has norm 2. The equation $a^2 + 5b^2 = 2$ has no integer solutions, so $\\mathfrak{p}_2$ is **non-principal**. Since $\\mathfrak{p}_2^2 = (2)$ is principal, $\\operatorname{Cl}(K) \\cong \\mathbb{Z}_2$, so $h_K = 2$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "The prime ideal p_2 = (2, 1 + sqrt{-5}) in Z[sqrt{-5}] is non-principal because the norm equation a^2 + 5 b^2 = 2 has ___ integer solutions.",
      "blankAnswer": "no",
      "blankDistractors": ["two", "infinite", "four"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "What is the exact class number h_K = |Cl(Q(sqrt{-5}))| of the imaginary quadratic field Q(sqrt{-5})?",
      "numericAnswer": 2.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In the Gaussian integers Z[i] (where x^2 + 1 factors mod 5 as (x-2)(x+2)), how does the rational prime 5 factor into prime ideals?",
      "options": [
        { "text": "(5) = (2 + i)(2 - i) (splits into two distinct principal prime ideals)", "isCorrect": true, "explanation": "Correct! Since 5 = 1 mod 4, -1 is a quadratic residue mod 5, so 5 splits as (2+i)(2-i) in Z[i]." },
        { "text": "(5) is prime and remains inert in Z[i]", "isCorrect": false, "explanation": "Incorrect: Primes congruent to 3 mod 4 (like 3, 7, 11) remain inert, but 5 splits." },
        { "text": "(5) = (1 + i)^4 (ramified)", "isCorrect": false, "explanation": "Incorrect: Only 2 ramifies in Z[i] as (1+i)^2." },
        { "text": "(5) = (5, 1+i)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
