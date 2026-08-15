# Duofy Reusable Lesson Format: Conformal Mapping - Concept Introduction

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Analysis / Complex_Analysis / Conformal_Mapping`  
**Lesson Format Type:** `concept_introduction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce Conformal Mapping as an angle-preserving transformation ($f'(z) \ne 0$), define Möbius transformations $f(z) = \frac{az+b}{cz+d}$, and explain the Riemann Mapping Theorem connecting arbitrary simply connected proper domains to the unit disk $\mathbb{D}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Conformal Mapping & Angle Preservation Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Möbius Transformation Decomposition Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Geometric Transformation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Non-Zero Derivative Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Riemann Mapping Theorem Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of a conformal mapping $w = f(z)$ preserving angles at points where $f'(z) \ne 0$, and the definition of a Möbius transformation $f(z) = \frac{az+b}{cz+d}$ with $ad - bc \ne 0$.
2. **Slide 2 (`concept_pieces`):** Deconstruct angle preservation, generalized circle preservation (circles and lines), cross-ratio invariance, and Riemann Mapping existence.
3. **Slide 3 (`matching`):** Pair 4 conformal transformations (Cayley map, Exponential map, Power map $z^\alpha$, Joukowsky transform) with their geometric domain mappings.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that a holomorphic map is conformal at all points where its first derivative is non-zero. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking why the entire complex plane $\mathbb{C}$ cannot be conformally mapped onto the unit disk $\mathbb{D}$ (by Liouville's Theorem).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "concept_introduction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Conformal Mapping**\nA complex mapping $w = f(z)$ is **conformal** at $z_0$ if it preserves both the magnitude and orientation of angles between smooth curves intersecting at $z_0$.\n**Theorem:** If $f(z)$ is holomorphic on a domain $D$ and $f'(z) \\ne 0$ for all $z \\in D$, then $f$ is conformal on $D$.\n**Möbius Transformations:** $f(z) = \\frac{az + b}{cz + d}$ ($ad - bc \\ne 0$) are conformal automorphisms of the extended complex plane $\\hat{\\mathbb{C}}$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Local Shape Preservation:** Infinitesimal circles remain circles; small triangles map to similar triangles.\n• **Generalized Circles:** Möbius transformations map lines and circles into lines and circles.\n• **Three-Point Uniqueness:** Any 3 distinct points $z_1, z_2, z_3$ can be mapped to any 3 specified targets $w_1, w_2, w_3$ by a unique Möbius transformation.\n• **Riemann Mapping Theorem:** Any simply connected open proper subset $U \\subsetneq \\mathbb{C}$ can be conformally mapped bijectively onto the open unit disk $\\mathbb{D}$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each canonical conformal mapping to its geometric domain transition.",
      "matchPairs": [
        { "left": "Cayley Map f(z) = (z - i)/(z + i)", "right": "Upper half-plane Im(z) > 0 to open unit disk |w| < 1" },
        { "left": "Exponential Map f(z) = e^z", "right": "Horizontal strip 0 < Im(z) < pi to upper half-plane" },
        { "left": "Power Map f(z) = z^2", "right": "First quadrant Re(z)>0, Im(z)>0 to upper half-plane" },
        { "left": "Joukowsky Map f(z) = (1/2)(z + 1/z)", "right": "Exterior of circle to aerodynamic airfoil profile" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A holomorphic function f(z) is conformal at all points where its first derivative f'(z) is not equal to ___.",
      "blankAnswer": "zero",
      "blankDistractors": ["one", "infinity", "pi"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the Riemann Mapping Theorem require the domain U to be a PROPER subset of C (U != C)?",
      "options": [
        { "text": "By Liouville's Theorem, any bounded entire function on all of C must be constant, so no bijective holomorphic map from C to the unit disk exists", "isCorrect": true, "explanation": "Correct! If f: C -> D were holomorphic, |f(z)| < 1 would make f a bounded entire function, forcing f to be constant (never bijective)." },
        { "text": "Because C is not connected", "isCorrect": false, "explanation": "Incorrect: C is connected." },
        { "text": "Because C has infinite area", "isCorrect": false, "explanation": "Incorrect: Many domains of infinite area map to the unit disk." },
        { "text": "Because C is not simply connected", "isCorrect": false, "explanation": "Incorrect: C is simply connected." }
      ]
    }
  ]
}
```
