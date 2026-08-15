# Duofy Reusable Lesson Format: Schemes and Coherent Sheaves - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Algebraic_Geometry / Schemes_and_Coherent_Sheaves`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute the points and Zariski closures of arithmetic and geometric schemes ($\operatorname{Spec}(\mathbb{Z})$ and $\operatorname{Spec}(k[x])$), calculate global sections $\Gamma(\mathbb{P}^1, \mathcal{O}_{\mathbb{P}^1}(d))$ of twisting sheaves on $\mathbb{P}^1$, and evaluate Čech cohomology groups $H^i(\mathbb{P}^1, \mathcal{O}(d))$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | $\mathbb{P}^1$ Cohomology Computation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Čech Complex Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Global Section Dimension Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Cohomology Dimension Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | $\operatorname{Spec}(\mathbb{Z})$ Generic Point Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Čech computation of $H^0(\mathbb{P}^1, \mathcal{O}(d))$ and $H^1(\mathbb{P}^1, \mathcal{O}(d))$ using the standard 2-chart cover $U_0 = D(x_0) = \operatorname{Spec}(k[t])$, $U_1 = D(x_1) = \operatorname{Spec}(k[t^{-1}])$ with overlap $U_0 \cap U_1 = \operatorname{Spec}(k[t, t^{-1}])$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps: (1) $C^0 = k[t] \oplus k[t^{-1}]$, (2) $C^1 = k[t, t^{-1}]$, (3) differential $\delta(P(t), Q(t^{-1})) = P(t) - t^d Q(t^{-1})$, (4) $\ker(\delta) = \Gamma(\mathbb{P}^1, \mathcal{O}(d)) \cong k[x_0, x_1]_d$ of dimension $d + 1$ (for $d \ge 0$), and $\operatorname{coker}(\delta) = H^1(\mathbb{P}^1, \mathcal{O}(d)) \cong k^{-d-1}$ (for $d \le -2$).
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that the space of global sections of $\mathcal{O}(d)$ on $\mathbb{P}^1$ has dimension $d + 1$ over the base field. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to calculate the dimension of $H^0(\mathbb{P}^1, \mathcal{O}(4))$ ($4 + 1 = 5.0$).
5. **Slide 5 (`quiz`):** Quiz testing the structure of $\operatorname{Spec}(\mathbb{Z})$: What is the closure of the zero ideal $(0)$ in $\operatorname{Spec}(\mathbb{Z})$? (The entire spectrum $\operatorname{Spec}(\mathbb{Z})$, because $(0)$ is contained in every prime ideal).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Čech Cohomology of Line Bundles on $\\mathbb{P}^1$**\nCover $\\mathbb{P}^1$ with $U_0 = \\operatorname{Spec}(k[t])$ and $U_1 = \\operatorname{Spec}(k[t^{-1}])$ where $t = x_1/x_0$.\nThe Čech complex for $\\mathcal{O}(d)$ is:\n$$\n0 \\longrightarrow \\mathcal{O}(d)(U_0) \\oplus \\mathcal{O}(d)(U_1) \\xrightarrow{\\ \\delta\\ } \\mathcal{O}(d)(U_0 \\cap U_1) \\longrightarrow 0\n$$\nwhere $C^0 = k[t] \\oplus k[t^{-1}]$, $C^1 = k[t, t^{-1}]$, and $\\delta(f_0, f_1) = f_0 - t^d f_1$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Global Sections $H^0$):** $\\ker(\\delta)$ consists of pairs $(f_0, f_1)$ with $f_0(t) = t^d f_1(t^{-1})$. For $d \\ge 0$, this yields polynomials of degree $\\le d$: $H^0(\\mathbb{P}^1, \\mathcal{O}(d)) = \\operatorname{span}\\{1, t, t^2, \\dots, t^d\\}$, with dimension $d + 1$.\n• **Step 2 (Negative Twists $d < 0$):** If $d < 0$, $\\ker(\\delta) = 0$, so $H^0(\\mathbb{P}^1, \\mathcal{O}(d)) = 0$.\n• **Step 3 (Higher Cohomology $H^1$):** $H^1(\\mathbb{P}^1, \\mathcal{O}(d)) = \\operatorname{coker}(\\delta) = k[t, t^{-1}] / \\operatorname{im}(\\delta)$. For $d = -2$, $\\operatorname{coker}(\\delta) = \\operatorname{span}\\{t^{-1}\\}$ (dimension 1).\n• **Step 4 (Serre Duality):** Confirms $H^1(\\mathbb{P}^1, \\mathcal{O}(d)) \\cong H^0(\\mathbb{P}^1, \\mathcal{O}(-d-2))^*$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "For d >= 0, the vector space dimension of global regular sections H^0 of the twisting sheaf O(d) on the projective line P^1 equals d plus ___.",
      "blankAnswer": "one",
      "blankDistractors": ["two", "zero", "d"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "What is the dimension of the space of global sections H^0(P^1, O(4)) over the ground field k?",
      "numericAnswer": 5.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In the arithmetic scheme X = Spec(Z), what is the topological closure of the generic point eta = (0)?",
      "options": [
        { "text": "The entire topological space Spec(Z), because (0) is contained in every prime ideal (p)", "isCorrect": true, "explanation": "Correct! V((0)) = {p in Spec(Z) | (0) subset of p} = Spec(Z), so the generic point is dense in the entire spectrum." },
        { "text": "Just the singleton set {(0)}", "isCorrect": false, "explanation": "Incorrect: Closed points in Spec(Z) are the maximal ideals (p), not (0)." },
        { "text": "The empty set", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The set of odd primes", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
