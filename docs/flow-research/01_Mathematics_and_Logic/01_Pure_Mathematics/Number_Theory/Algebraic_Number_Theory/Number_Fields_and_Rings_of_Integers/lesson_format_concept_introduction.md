# Duofy Reusable Lesson Format: Number Fields and Rings of Integers - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Number_Theory / Algebraic_Number_Theory / Number_Fields_and_Rings_of_Integers`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Number Fields $K = \mathbb{Q}(\theta)$, the Ring of Integers $\mathcal{O}_K$ as a Dedekind Domain, Unique Prime Ideal Factorization, the Ideal Class Group $\operatorname{Cl}(K)$, and Dirichlet's Unit Theorem ($\mathcal{O}_K^\times \cong \mu(K) \times \mathbb{Z}^{r+s-1}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Number Fields & Dedekind Domains Formal Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Ideals Rescuing Unique Factorization Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Quadratic Field & Ring of Integers Basis Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Class Group Finiteness Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Dirichlet Unit Rank Formula Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of a number field $K$, its ring of integers $\mathcal{O}_K$ (integral closure of $\mathbb{Z}$), Dedekind domain properties (Noetherian, integrally closed, non-zero primes are maximal), and unique factorization of ideals into prime ideals.
2. **Slide 2 (`concept_pieces`):** Deconstruct failure of element factorization in $\mathbb{Z}[\sqrt{-5}]$, resolution via prime ideals $(6) = \mathfrak{p}_2^2 \mathfrak{p}_3 \mathfrak{p}_3'$, Ideal Class Group $\operatorname{Cl}(K)$, Minkowski's bound, and Dirichlet's Unit Theorem.
3. **Slide 3 (`matching`):** Pair 4 quadratic fields ($\mathbb{Q}(i)$, $\mathbb{Q}(\sqrt{-3})$, $\mathbb{Q}(\sqrt{5})$, $\mathbb{Q}(\sqrt{-5})$) with their exact integer rings $\mathcal{O}_K$.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that by Minkowski's geometry of numbers, the ideal class group of any number field is strictly finite. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question computing the Dirichlet unit rank $r + s - 1$ for a real quadratic field $K = \mathbb{Q}(\sqrt{2})$ ($r=2, s=0 \implies 2 + 0 - 1 = 1$, rank 1 with fundamental unit $1 + \sqrt{2}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Number Fields and Dedekind Domains**\n• A **Number Field** $K$ is a finite extension of $\\mathbb{Q}$ of degree $n = [K : \\mathbb{Q}]$.\n• The **Ring of Integers** $\\mathcal{O}_K$ is the integral closure of $\\mathbb{Z}$ in $K$ (all elements with monic integer minimal polynomials).\n• $\\mathcal{O}_K$ is a **Dedekind Domain**: Noetherian, integrally closed, with every non-zero prime ideal being maximal.\n• **Fundamental Theorem of Ideal Arithmetic:** Every non-zero ideal $\\mathfrak{a} \\subseteq \\mathcal{O}_K$ factors uniquely into a product of prime ideals:\n$$\n\\mathfrak{a} = \\mathfrak{p}_1^{e_1} \\mathfrak{p}_2^{e_2} \\cdots \\mathfrak{p}_k^{e_k}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Restoring Unique Factorization:** Elements in $\\mathbb{Z}[\\sqrt{-5}]$ fail unique factorization ($6 = 2 \\cdot 3 = (1+\\sqrt{-5})(1-\\sqrt{-5})$), but the principal ideal $(6)$ factors uniquely into four prime ideals $\\mathfrak{p}_2^2 \\mathfrak{p}_3 \\mathfrak{p}_3'$.\n• **Class Group $\\operatorname{Cl}(K)$:** The quotient of fractional ideals by principal ideals measures the failure of element factorization ($\\operatorname{Cl}(K) = \\{1\\} \\iff \\mathcal{O}_K$ is a UFD).\n• **Minkowski's Bound:** Guarantees that the class number $h_K = |\\operatorname{Cl}(K)|$ is always finite.\n• **Dirichlet's Unit Theorem:** $\\mathcal{O}_K^\\times \\cong \\mu(K) \\times \\mathbb{Z}^{r + s - 1}$ where $r$ is real embeddings and $s$ is complex conjugate pairs."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each quadratic field to its exact ring of algebraic integers O_K.",
      "matchPairs": [
        { "left": "Q(i) with d = -1 = 3 mod 4", "right": "Z[i] (Gaussian Integers)" },
        { "left": "Q(sqrt{-3}) with d = -3 = 1 mod 4", "right": "Z[(1 + sqrt{-3})/2] (Eisenstein Integers)" },
        { "left": "Q(sqrt{5}) with d = 5 = 1 mod 4", "right": "Z[(1 + sqrt{5})/2] (Golden Ratio Ring)" },
        { "left": "Q(sqrt{-5}) with d = -5 = 3 mod 4", "right": "Z[sqrt{-5}]" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Minkowski's geometric lattice bound proves that for any algebraic number field K, the ideal class group Cl(K) is strictly ___.",
      "blankAnswer": "finite",
      "blankDistractors": ["infinite", "trivial", "cyclic"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "According to Dirichlet's Unit Theorem, what is the free abelian rank of the unit group O_K^* for a real quadratic field K = Q(sqrt{2})?",
      "options": [
        { "text": "1 (since r = 2 real embeddings, s = 0 complex pairs, so rank = 2 + 0 - 1 = 1)", "isCorrect": true, "explanation": "Correct! Real quadratic fields have rank r + s - 1 = 2 + 0 - 1 = 1, with fundamental unit 1 + sqrt(2)." },
        { "text": "0 (only roots of unity)", "isCorrect": false, "explanation": "Incorrect: Rank 0 occurs for imaginary quadratic fields Q(sqrt{-d}) where r=0, s=1." },
        { "text": "2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Infinity", "isCorrect": false, "explanation": "Incorrect: The unit group is always finitely generated." }
      ]
    }
  ]
}
```
