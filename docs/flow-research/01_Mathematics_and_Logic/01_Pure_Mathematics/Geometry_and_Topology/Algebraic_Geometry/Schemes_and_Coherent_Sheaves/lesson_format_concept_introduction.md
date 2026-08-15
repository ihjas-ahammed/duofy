# Duofy Reusable Lesson Format: Schemes and Coherent Sheaves - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Geometry_and_Topology / Algebraic_Geometry / Schemes_and_Coherent_Sheaves`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Grothendieck's Prime Spectrum $\operatorname{Spec}(R)$, the Structure Sheaf $\mathcal{O}_X$ and its stalks $R_\mathfrak{p}$, the definition of a Scheme as a locally ringed space, and Quasi-Coherent/Coherent sheaves.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Scheme & Spectrum Formal Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Generic Points & Nilpotent Tangents Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Algebraic Concept & Sheaf Object Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Stalk Localization Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Nilpotent Scheme Geometric Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of $\operatorname{Spec}(R)$ (the set of all prime ideals of $R$ with Zariski topology), structure sheaf $\mathcal{O}_X(D(f)) = R_f$, and the definition of a scheme as a locally ringed space locally isomorphic to $\operatorname{Spec}(R)$.
2. **Slide 2 (`concept_pieces`):** Deconstruct generic points (dense singleton closures), nilpotent infinitesimals $k[x]/(x^2)$, sheaf gluing axioms, and Serre's FAC vanishing theorem.
3. **Slide 3 (`matching`):** Pair 4 scheme-theoretic concepts ($\operatorname{Spec}(R)$, Structure sheaf $\mathcal{O}_X$, Coherent sheaf, Residue field $\kappa(\mathfrak{p})$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the stalk of the structure sheaf at a prime ideal $\mathfrak{p}$ is the local ring $R_\mathfrak{p}$. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking what geometric object the scheme $X = \operatorname{Spec}(k[x]/(x^2))$ represents (a single point equipped with an infinitesimal tangent vector).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Schemes and Structure Sheaves**\n• The **Prime Spectrum** $X = \\operatorname{Spec}(R)$ is the set of all prime ideals $\\mathfrak{p} \\subset R$, equipped with the Zariski topology where closed sets are $V(I) = \\{\\mathfrak{p} \\mid I \\subseteq \\mathfrak{p}\\}$.\n• The **Structure Sheaf** $\\mathcal{O}_X$ assigns $\\mathcal{O}_X(D(f)) = R_f$ for principal open sets $D(f)$.\n• The **Stalk** at $\\mathfrak{p}$ is the local ring $\\mathcal{O}_{X, \\mathfrak{p}} \\cong R_\\mathfrak{p}$.\n• A **Scheme** is a locally ringed space $(X, \\mathcal{O}_X)$ that is locally isomorphic to an affine scheme $(\\operatorname{Spec}(R), \\mathcal{O}_{\\operatorname{Spec}(R)})$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Generic Points:** Non-maximal prime ideals (like $(0) \\subset k[x]$) act as \"generic points\" whose closure $\\overline{\\{(0)\\}} = \\operatorname{Spec}(k[x])$ is the entire space.\n• **Nilpotents & Multiplicity:** Rings with nilpotents like $k[x]/(x^2)$ represent geometric spaces with infinitesimal thickening (tangent vectors).\n• **Sheaves of Modules:** A quasi-coherent sheaf $\\widetilde{M}$ attaches localized modules $M_f$ to open sets $D(f)$.\n• **Coherent Sheaves:** Finitely generated quasi-coherent sheaves over Noetherian schemes (the scheme-theoretic generalization of vector bundles and subschemes)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each scheme-theoretic concept to its mathematical definition.",
      "matchPairs": [
        { "left": "Spec(R)", "right": "The topological space of all prime ideals of R" },
        { "left": "Stalk O_{X, p}", "right": "The local ring of germs R_p at the prime ideal p" },
        { "left": "Residue Field kappa(p)", "right": "The quotient field R_p / p R_p = Frac(R/p)" },
        { "left": "Coherent Sheaf", "right": "A finitely generated quasi-coherent O_X-module" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The stalk of the structure sheaf of an affine scheme Spec(R) at a prime ideal p is the algebraic ___ of R at p.",
      "blankAnswer": "localization",
      "blankDistractors": ["completion", "quotient", "derivative"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the geometric interpretation of the affine scheme X = Spec(k[x] / (x^2)) over an algebraically closed field k?",
      "options": [
        { "text": "A single topological point (the maximal ideal (x)) equipped with a 1D infinitesimal tangent vector (a double point of length 2)", "isCorrect": true, "explanation": "Correct! Topologically it is one point, but its ring of regular functions k[x]/(x^2) retains non-trivial nilpotent tangent information x != 0, x^2 = 0." },
        { "text": "Two distinct geometric points", "isCorrect": false, "explanation": "Incorrect: Spec(k[x]/(x(x-1))) has two points, but k[x]/(x^2) has only one prime ideal (x)." },
        { "text": "The entire affine line A^1", "isCorrect": false, "explanation": "Incorrect: Spec(k[x]) is the line." },
        { "text": "An empty scheme", "isCorrect": false, "explanation": "Incorrect: The ring is non-zero, so Spec is non-empty." }
      ]
    }
  ]
}
```
