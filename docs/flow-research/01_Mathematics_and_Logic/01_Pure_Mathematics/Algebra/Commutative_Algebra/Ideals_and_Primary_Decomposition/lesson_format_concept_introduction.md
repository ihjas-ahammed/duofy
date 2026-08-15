# Duofy Reusable Lesson Format: Ideals and Primary Decomposition - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Commutative_Algebra / Ideals_and_Primary_Decomposition`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the definition of Primary Ideals $\mathfrak{q}$, their radical $\mathfrak{p} = \sqrt{\mathfrak{q}}$, and the Lasker-Noether decomposition theorem ($I = \bigcap \mathfrak{q}_i$), clarifying how primary ideals capture both geometric irreducible components and infinitesimal multiplicity.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Primary Ideal Formal Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Intuitive Zero-Divisor Deconstruction | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Ideal Type & Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Primary Condition Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Primary Ideal Discrimination Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the formal definition of a primary ideal $\mathfrak{q} \subsetneq R$: if $xy \in \mathfrak{q}$, then $x \in \mathfrak{q}$ or $y^n \in \mathfrak{q}$ for some $n \ge 1$. Display the equivalence with zero-divisors in $R/\mathfrak{q}$ being nilpotent.
2. **Slide 2 (`concept_pieces`):** Deconstruct primary ideals into 4 intuitive bullets: radical is prime, primary vs prime power, maximal radical implies primary, geometric thickening.
3. **Slide 3 (`matching`):** Pair 4 core terms (Prime Ideal, Primary Ideal, Radical Ideal, Associated Prime) with their defining algebraic conditions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of the definition of the radical of a primary ideal. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking whether a specific concrete ideal (e.g., $(x^2, y)$ in $k[x, y]$) is primary.

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Primary Ideal**\nAn ideal $\\mathfrak{q} \\subsetneq R$ in a commutative ring $R$ is called **primary** if:\n$$\nxy \\in \\mathfrak{q} \\implies x \\in \\mathfrak{q} \\quad \\text{or} \\quad y^n \\in \\mathfrak{q} \\text{ for some } n \\ge 1\n$$\nEquivalently, every zero-divisor in the quotient ring $R/\\mathfrak{q}$ is nilpotent. Its radical $\\mathfrak{p} = \\sqrt{\\mathfrak{q}}$ is always a prime ideal."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Radical is Prime:** If $\\mathfrak{q}$ is primary, then $\\mathfrak{p} = \\sqrt{\\mathfrak{q}}$ is prime, and $\\mathfrak{q}$ is called $\\mathfrak{p}$-primary.\n• **Prime Comparison:** Every prime ideal is primary, but a primary ideal need not be prime (e.g., $(x^2)$ in $k[x]$).\n• **Maximal Radical Shortcut:** If $\\sqrt{\\mathfrak{q}} = \\mathfrak{m}$ is a maximal ideal, then $\\mathfrak{q}$ is automatically $\\mathfrak{m}$-primary.\n• **Geometric Meaning:** A $\\mathfrak{p}$-primary ideal represents the geometric subvariety $V(\\mathfrak{p})$ with embedded algebraic multiplicity or tangent structure."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each commutative algebra concept to its characterizing condition.",
      "matchPairs": [
        { "left": "Primary Ideal q", "right": "Every zero-divisor in R/q is nilpotent" },
        { "left": "Prime Ideal p", "right": "xy in p implies x in p or y in p (R/p is an Integral Domain)" },
        { "left": "Radical Ideal I", "right": "I equals the intersection of all prime ideals containing I" },
        { "left": "Associated Prime p", "right": "p is the annihilator of some non-zero element in R/I" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "If q is a primary ideal in a commutative ring R, then the radical of q is always a ___ ideal.",
      "blankAnswer": "prime",
      "blankDistractors": ["maximal", "principal", "zero"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the ideal q = (x^2, y) in k[x, y] a primary ideal?",
      "options": [
        { "text": "Because its radical is the maximal ideal (x, y)", "isCorrect": true, "explanation": "Correct! Since sqrt(x^2, y) = (x, y) which is maximal, q is automatically (x,y)-primary." },
        { "text": "Because it is generated by two elements", "isCorrect": false, "explanation": "Incorrect: The number of generators does not determine whether an ideal is primary." },
        { "text": "Because (x^2, y) is a prime ideal", "isCorrect": false, "explanation": "Incorrect: (x^2, y) is not prime since x * x in q but x not in q." },
        { "text": "Because k[x, y] is a PID", "isCorrect": false, "explanation": "Incorrect: k[x, y] is a UFD, not a PID." }
      ]
    }
  ]
}
```
