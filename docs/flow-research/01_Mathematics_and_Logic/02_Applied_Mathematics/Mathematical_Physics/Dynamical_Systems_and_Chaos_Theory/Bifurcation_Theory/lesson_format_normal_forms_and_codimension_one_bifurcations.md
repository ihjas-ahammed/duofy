# Duofy Reusable Lesson Format: Normal Forms of Codimension-1 Bifurcations

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Mathematical_Physics / Dynamical_Systems_and_Chaos_Theory / Bifurcation_Theory`  
**Lesson Format Type:** `normal_forms_and_codimension_one_bifurcations`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the canonical normal forms for 1D codimension-1 local bifurcations (Saddle-Node $\dot{x} = r + x^2$, Transcritical $\dot{x} = rx - x^2$, Supercritical Pitchfork $\dot{x} = rx - x^3$, Subcritical Pitchfork $\dot{x} = rx + x^3$), construct their bifurcation diagrams, and distinguish exchange of stability vs fixed-point annihilation.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Codimension-1 Normal Forms Formal Definition | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Geometric Mechanism & Stability Exchange Mental Model | `concept_pieces` | Encoding (Phase A) | `content` (Sequential bullets) |
| **Slide 3** | Bifurcation Normal Form & Qualitative Behavior Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Saddle-Node Annihilation Fill-in-the-Blank | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Subcritical Pitchfork Hysteresis Jump Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the 4 canonical normal forms: (1) Saddle-Node: $\dot{x} = r + x^2$, fixed points $x^* = \pm\sqrt{-r}$ (for $r < 0$, 1 stable, 1 unstable; at $r=0$ coalesce; for $r > 0$ none), (2) Transcritical: $\dot{x} = r x - x^2$, fixed points $x^* = 0, r$ (exchange stability at $r = 0$), (3) Supercritical Pitchfork: $\dot{x} = r x - x^3$, symmetric under $x \mapsto -x$ (pitchfork split into stable branches $x^* = \pm\sqrt{r}$ for $r > 0$), (4) Subcritical Pitchfork: $\dot{x} = r x + x^3 - x^5$ (unstable branches trigger subcritical explosive jumps).
2. **Slide 2 (`concept_pieces`):** Deconstruct: (1) eigenvalue condition: at bifurcation point, Jacobian eigenvalue satisfies $\lambda = f'(x^*) = 0$ (loss of hyperbolicity), (2) Taylor expansion of general system $\dot{x} = f(x, r)$ near $(0, 0)$, (3) structural stability and topological equivalence, (4) physical applications (laser thresholds, buckling of elastic beams, genetic switches).
3. **Slide 3 (`matching`):** Pair 4 normal forms (Saddle-Node, Transcritical, Supercritical Pitchfork, Subcritical Pitchfork) with their exact algebraic forms and symmetry constraints.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in a saddle-node bifurcation, two fixed points collide and annihilate each other. Plain text only.
5. **Slide 5 (`quiz`):** Multiple choice question asking why subcritical pitchfork bifurcations are dangerous in engineering structures (e.g. aerodynamic flutter or bridge buckling): (Because they exhibit hysteresis: losing stability at $r=0$ forces a discontinuous catastrophic jump to large amplitude states that cannot be reversed without lowering $r$ far below 0).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "normal_forms_and_codimension_one_bifurcations",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Definition: Canonical 1D Codimension-1 Normal Forms**\nLet $\\dot{x} = f(x, r)$ with a non-hyperbolic fixed point at $x^* = 0$ when parameter $r = 0$ ($f'(0, 0) = 0$):\n1. **Saddle-Node (Fold / Turning Point):**\n$$\n\\dot{x} = r + x^2 \\implies x^* = \\pm \\sqrt{-r} \\quad (r < 0: \\text{1 stable, 1 unstable; } r > 0: \\text{none})\n$$\n2. **Transcritical (Stability Exchange):**\n$$\n\\dot{x} = r x - x^2 \\implies x^* = 0, \\, r \\quad (\\text{two fixed points cross and swap stability at } r = 0)\n$$\n3. **Supercritical Pitchfork ($x \\mapsto -x$ Symmetry):**\n$$\n\\dot{x} = r x - x^3 \\implies x^* = 0 \\, (r < 0), \\quad x^* = \\pm\\sqrt{r} \\, (r > 0, \\text{stable})\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Loss of Hyperbolicity:** At $r = 0$, the linearized eigenvalue is $\\lambda = f'(x^*) = 0$, allowing nonlinear terms to govern topological restructuring.\n• **Saddle-Node Annihilation:** A stable node and unstable saddle move toward each other, merge into a half-stable state at $r = 0$, and vanish into empty phase space.\n• **Pitchfork Symmetry Breaking:** The $x \\mapsto -x$ parity invariance forces the quadratic coefficient to vanish, leaving cubic nonlinearities $\\pm x^3$.\n• **Structural Robustness:** Any smooth 1D dynamical system exhibiting these generic conditions can be locally transformed into one of these canonical normal forms."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each bifurcation type to its canonical normal form equation.",
      "matchPairs": [
        { "left": "Saddle-Node Bifurcation", "right": "x_dot = r + x^2 (creation/destruction of fixed points)" },
        { "left": "Transcritical Bifurcation", "right": "x_dot = r x - x^2 (fixed point at origin persists and swaps stability)" },
        { "left": "Supercritical Pitchfork", "right": "x_dot = r x - x^3 (symmetric birth of two stable branches)" },
        { "left": "Subcritical Pitchfork", "right": "x_dot = r x + x^3 - x^5 (unstable branches causing hysteresis jumps)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a saddle-node bifurcation as the control parameter crosses the critical value, a stable node and an unstable saddle point collide and ___ each other.",
      "blankAnswer": "annihilate",
      "blankDistractors": ["multiply", "stabilize", "separate"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why are subcritical pitchfork bifurcations (x_dot = r x + x^3 - x^5) often called 'dangerous' or catastrophic in mechanical and aerodynamic engineering?",
      "options": [
        { "text": "They exhibit HYSTERESIS: when r exceeds 0, the state undergoes a discontinuous explosive jump to a distant large-amplitude branch, and the original state cannot be restored without decreasing r significantly below 0", "isCorrect": true, "explanation": "Correct! Subcritical bifurcations feature unstable inner branches that cause sudden catastrophic jumps and hard hysteresis loops." },
        { "text": "Because they cause the system mass to become infinite", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because equations cannot be solved numerically", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because time becomes imaginary", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
