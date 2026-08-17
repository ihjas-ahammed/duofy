# Duofy Reusable Lesson Format: The Beltrami Identity and the Brachistochrone Problem

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Optimization_and_Control_Theory / Optimal_Control_and_Calculus_of_Variations / Euler_Lagrange_Equations`  
**Lesson Format Type:** `beltrami_identity_and_brachistochrone`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to derive and apply the **Beltrami Identity** ($L - y' \frac{\partial L}{\partial y'} = C$) for autonomous Lagrangians ($\frac{\partial L}{\partial x} = 0$), solve the classic **Brachistochrone Problem** (Johann Bernoulli, 1696), and derive the parametric cycloid equations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Beltrami Identity & Autonomous First Integral Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Beltrami Derivation Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Variational Problem & Optimal Extremal Curve Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Autonomous Lagrangian Explicit Variable Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Cycloid Tautochrone Isochronism Property Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Beltrami Identity (Eugenio Beltrami, 1868): For any variational problem where the Lagrangian has no explicit dependence on the independent variable $x$ ($\frac{\partial L}{\partial x} = 0$), the quantity $H = L - y' \frac{\partial L}{\partial y'}$ is a constant of motion ($L - y'\frac{\partial L}{\partial y'} = C$). State the Brachistochrone problem (Johann Bernoulli, 1696): Find the path $y(x)$ minimizing the time of descent $T = \int \frac{ds}{v} = \int \frac{\sqrt{1 + y'^2}}{\sqrt{2gy}} dx$. Applying Beltrami yields the cycloid parametric solution: $x = r(\theta - \sin\theta), y = r(1 - \cos\theta)$.
2. **Slide 2 (`concept_pieces`):** Deconstruct: (1) evaluate total derivative $\frac{d}{dx}\left(L - y'\frac{\partial L}{\partial y'}\right) = \frac{\partial L}{\partial x} + \frac{\partial L}{\partial y}y' + \frac{\partial L}{\partial y'}y'' - y''\frac{\partial L}{\partial y'} - y'\frac{d}{dx}\left(\frac{\partial L}{\partial y'}\right)$, (2) cancel the $y''\frac{\partial L}{\partial y'}$ terms, (3) group remaining terms: $\frac{\partial L}{\partial x} + y'\left[\frac{\partial L}{\partial y} - \frac{d}{dx}\left(\frac{\partial L}{\partial y'}\right)\right]$, (4) by Euler-Lagrange, the bracketed term is zero; if $\frac{\partial L}{\partial x} = 0$, the total derivative vanishes, proving $L - y'\frac{\partial L}{\partial y'} = C$.
3. **Slide 3 (`matching`):** Pair 4 classical variational problems (Brachistochrone / Fastest descent, Catenary / Hanging chain, Minimal Surface of Revolution, Euclidean Geodesic) with their extremal geometric curves.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the Beltrami identity applies when the Lagrangian contains no explicit dependence on the independent variable x. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question on the Tautochrone property of the cycloid discovered by Christiaan Huygens: What remarkable physical property does the inverted cycloid curve possess for a bead sliding frictionlessly under gravity? (Isochronism: The time taken for a bead to slide down to the lowest point is strictly INDEPENDENT of where along the curve it is released!).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "beltrami_identity_and_brachistochrone",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**The Beltrami Identity and the Brachistochrone Problem**\n• **The Beltrami Identity (Beltrami 1868):** If the Lagrangian $L(y, y')$ has **no explicit dependence on $x$** ($\\frac{\\partial L}{\\partial x} = 0$):\n$$\nL - y' \\frac{\\partial L}{\\partial y'} = C \\quad (\\text{First Integral of Euler-Lagrange})\n$$\n• **The Brachistochrone Problem (Johann Bernoulli, 1696):**\n  Find curve of fastest descent under gravity: $T[y] = \\int \\frac{ds}{v} = \\int \\frac{\\sqrt{1 + y'^2}}{\\sqrt{2gy}} \\, dx$.\n• **Applying Beltrami ($L = \\sqrt{\\frac{1 + y'^2}{y}}$):**\n$$\n\\sqrt{\\frac{1 + y'^2}{y}} - y' \\frac{y'}{\\sqrt{y(1 + y'^2)}} = C \\implies y (1 + y'^2) = 2r\n$$\n• **Solution:** The parametric **Cycloid** ($x = r(\\theta - \\sin\\theta), \\, y = r(1 - \\cos\\theta)$)."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Chain Rule Derivative):**\n  $$\\frac{d}{dx}\\left( L - y' \\frac{\\partial L}{\\partial y'} \\right) = \\frac{\\partial L}{\\partial x} + \\frac{\\partial L}{\\partial y}y' + \\frac{\\partial L}{\\partial y'}y'' - y'' \\frac{\\partial L}{\\partial y'} - y' \\frac{d}{dx}\\left( \\frac{\\partial L}{\\partial y'} \\right)$$\n• **Step 2 (Cancellation):** The terms $y'' \\frac{\\partial L}{\\partial y'}$ cancel out completely.\n• **Step 3 (Euler-Lagrange Substitution):**\n  $$\\frac{d}{dx}\\left( L - y' \\frac{\\partial L}{\\partial y'} \\right) = \\frac{\\partial L}{\\partial x} + y' \\left[ \\frac{\\partial L}{\\partial y} - \\frac{d}{dx}\\left( \\frac{\\partial L}{\\partial y'} \\right) \\right]$$\n• **Step 4 (Invariance):** The bracket is 0 by Euler-Lagrange. When $\\frac{\\partial L}{\\partial x} = 0$, the total derivative is 0, proving $L - y' L_{y'} = C$ is conserved!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each classical variational problem to its optimal extremal curve.",
      "matchPairs": [
        { "left": "Brachistochrone (Fastest descent under gravity)", "right": "Cycloid (curve traced by a point on a rolling wheel)" },
        { "left": "Catenary (Hanging heavy cable minimizing potential)", "right": "Hyperbolic Cosine y = c cosh(x/c)" },
        { "left": "Minimal Surface of Revolution (Soap film)", "right": "Catenoid (revolution of a catenary)" },
        { "left": "Shortest Path on Sphere (Geodesic)", "right": "Great circle arc" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Beltrami identity L - y' (partial L / partial y') = C holds whenever the Lagrangian L has no explicit dependence on the independent variable ___.",
      "blankAnswer": "x",
      "blankDistractors": ["y", "y'", "t"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the Tautochrone (Isochrone) property of the cycloid discovered by Christiaan Huygens in 1659?",
      "options": [
        { "text": "A bead sliding frictionlessly down an inverted cycloid reaches the lowest point in the EXACT SAME TIME regardless of its starting height: T = pi * sqrt(r / g)", "isCorrect": true, "explanation": "Correct! The cycloid is both the Brachistochrone (fastest path) and the Tautochrone (equal-time path), making it the ideal geometry for pendulum clocks." },
        { "text": "The velocity of the bead is constant everywhere", "isCorrect": false, "explanation": "Incorrect: Velocity increases as the bead falls." },
        { "text": "The curve is a circle", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The acceleration is zero", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
