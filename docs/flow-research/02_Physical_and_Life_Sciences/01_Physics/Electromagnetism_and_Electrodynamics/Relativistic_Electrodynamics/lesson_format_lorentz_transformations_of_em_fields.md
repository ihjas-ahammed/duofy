# Duofy Reusable Lesson Format: Lorentz Transformations of EM Fields

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Electromagnetism_and_Electrodynamics / Relativistic_Electrodynamics`  
**Lesson Format Type:** `lorentz_transformations_of_em_fields`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the transformation of electric and magnetic fields under Lorentz boosts: apply the tensor transformation law $F'^{\mu\nu} = \Lambda^\mu_\alpha \Lambda^\nu_\beta F^{\alpha\beta}$ for a boost along the $x$-axis, derive parallel ($E_\parallel' = E_\parallel, B_\parallel' = B_\parallel$) and perpendicular ($E_\perp' = \gamma(\mathbf{E} + \mathbf{v}\times\mathbf{B})_\perp, B_\perp' = \gamma(\mathbf{B} - \frac{\mathbf{v}\times\mathbf{E}}{c^2})_\perp$) field components, and solve the classic paradox of the magnetic force on a moving charge near a neutral current-carrying wire.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Lorentz Transformations of EM Fields Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Moving Charge Near Current Wire Paradox Resolution | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Field Component & Lorentz Boost Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Parallel Electric Field Component Invariance Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Origin of Magnetism as Relativistic Effect of Electrostatics Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the transformation of Electric and Magnetic Fields under a Lorentz boost with velocity $\mathbf{v} = v \hat{\mathbf{x}}$ (Lorentz factor $\gamma = 1/\sqrt{1 - v^2/c^2}$):
   - **Parallel Components (Unaltered!):**
     $$E_x' = E_x, \qquad B_x' = B_x$$
   - **Perpendicular Components (Mixes $\mathbf{E}$ and $\mathbf{B}$!):**
     $$E_y' = \gamma(E_y - v B_z), \qquad E_z' = \gamma(E_z + v B_y)$$
     $$B_y' = \gamma\left(B_y + \frac{v}{c^2} E_z\right), \qquad B_z' = \gamma\left(B_z - \frac{v}{c^2} E_y\right)$$
   - **General Vector Formulation for Arbitrary Velocity $\mathbf{v}$:**
     $$\mathbf{E}' = \gamma(\mathbf{E} + \mathbf{v} \times \mathbf{B}) - \frac{\gamma^2}{\gamma + 1} \frac{\mathbf{v}(\mathbf{v} \cdot \mathbf{E})}{c^2}$$
     $$\mathbf{B}' = \gamma\left(\mathbf{B} - \frac{\mathbf{v} \times \mathbf{E}}{c^2}\right) - \frac{\gamma^2}{\gamma + 1} \frac{\mathbf{v}(\mathbf{v} \cdot \mathbf{B})}{c^2}$$
2. **Slide 2 (`concept_pieces`):** Deconstruct resolution of the current-carrying wire paradox: (1) in Lab Frame $S$, a neutral wire carries drift current with stationary positive ions ($\lambda_+ = \lambda_0$) and moving electrons ($\lambda_- = -\lambda_0$ at speed $v_0$), so net charge density $\lambda = 0 \implies E = 0$, (2) a test charge $+q$ moves parallel to wire at velocity $v$; in $S$, it experiences purely **Magnetic Force** $F_{\text{mag}} = q v B = q v \frac{\mu_0 I}{2\pi r}$ toward the wire, (3) in the Rest Frame $S'$ of the test charge, the charge is stationary ($v' = 0$), so magnetic force is $F_{\text{mag}}' = 0$, (4) Lorentz length contraction alters the linear densities: positive ions move at $-v$ ($\lambda_+' = \gamma \lambda_0$), while electrons move at a different relative speed ($\lambda_-' \ne -\lambda_+'$), (5) the wire becomes NET ELECTRICALLY CHARGED ($\lambda_{\text{net}}' \ne 0$) in $S'$, exerting a purely **Electrostatic Force** $F_{\text{elec}}' = q E' = \frac{q \lambda_{\text{net}}'}{2\pi\epsilon_0 r} = F / \gamma$! (Magnetism is simply electrostatics viewed in a moving frame!).
3. **Slide 3 (`matching`):** Pair 4 field components ($E_x'$, $E_y'$, $B_x'$, $B_y'$) with their boosted expressions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that field components parallel to the boost velocity are unchanged (invariant) under Lorentz transformations. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the physical origin of magnetism: How does Special Relativity explain magnetism? (Magnetism is NOT an independent fundamental force; it is the relativistic correction to electrostatics when moving charges undergo differential Lorentz length contraction, creating local electric charge imbalances in moving reference frames).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "lorentz_transformations_of_em_fields",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Lorentz Transformations of EM Fields**\n• **Boost along $x$-axis at velocity $\\mathbf{v} = v\\hat{\\mathbf{x}}$ ($\\gamma = 1/\\sqrt{1 - v^2/c^2}$):**\n  - **Parallel Components (Unchanged!):**\n$$\nE_x' = E_x, \\qquad B_x' = B_x\n$$\n  - **Perpendicular Components (Mixes $\\mathbf{E}$ and $\\mathbf{B}$!):**\n$$\nE_y' = \\gamma(E_y - v B_z), \\qquad E_z' = \\gamma(E_z + v B_y)\n$$\n$$\nB_y' = \\gamma\\left(B_y + \\frac{v}{c^2} E_z\\right), \\qquad B_z' = \\gamma\\left(B_z - \\frac{v}{c^2} E_y\\right)\n$$\n• **Vector Form:** $\\mathbf{E}_\\perp' = \\gamma(\\mathbf{E} + \\mathbf{v} \\times \\mathbf{B})_\\perp$ and $\\mathbf{B}_\\perp' = \\gamma(\\mathbf{B} - \\frac{\\mathbf{v} \\times \\mathbf{E}}{c^2})_\\perp$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Lab Frame $S$):** Neutral wire has $\\lambda_+ = \\lambda_0$ and $\\lambda_- = -\\lambda_0 \\implies E = 0$. Test charge $+q$ moving at $v$ feels magnetic force $F = q v B$.\n• **Step 2 (Charge Rest Frame $S'$):** The charge is stationary ($v' = 0$), so magnetic force $F_{\\text{mag}}' = 0$!\n• **Step 3 (Relativistic Length Contraction):** In $S'$, positive ions move at $-v$ (contracted spacing $\\lambda_+' = \\gamma \\lambda_0$), while electrons have different relative speed.\n• **Step 4 (Net Charge Emergence):** The wire acquires net positive charge density $\\lambda_{\\text{net}}' = \\gamma \\lambda_0 \\frac{v v_0}{c^2} \\ne 0$.\n• **Step 5 (Unified Force):** In $S'$, a purely **Electrostatic Force** $F' = q E' = \\frac{q \\lambda_{\\text{net}}'}{2\\pi \\epsilon_0 r}$ acts on $+q$, matching $F/\\gamma$! (Magnetism is electrostatics in a moving frame!)."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each boosted field component (x-axis boost) to its transformation formula.",
      "matchPairs": [
        { "left": "Parallel Electric Field E_x'", "right": "E_x' = E_x (completely unaltered by boost along x)" },
        { "left": "Transverse Electric Field E_y'", "right": "E_y' = gamma * (E_y - v * B_z)" },
        { "left": "Parallel Magnetic Field B_x'", "right": "B_x' = B_x (completely unaltered by boost along x)" },
        { "left": "Transverse Magnetic Field B_y'", "right": "B_y' = gamma * (B_y + (v / c^2) * E_z)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Under a Lorentz boost, electric and magnetic field components ___ to the boost direction are completely invariant (unchanged).",
      "blankAnswer": "parallel",
      "blankDistractors": ["perpendicular", "orthogonal", "inverse"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What does Special Relativity reveal about the physical nature of magnetism?",
      "options": [
        { "text": "Magnetism is NOT an independent physical interaction, but is the RELATIVISTIC KINEMATIC MANIFESTATION of Coulomb electrostatics caused by differential Lorentz length contraction between positive and negative charge densities in moving frames", "isCorrect": true, "explanation": "Correct! Special Relativity proves that a purely electrostatic field in one frame appears as a mixture of electric and magnetic fields in a moving frame. Magnetism is electrostatics viewed through the lens of Lorentz transformations." },
        { "text": "Magnetic fields are caused by magnetic monopole particles", "isCorrect": false, "explanation": "Incorrect: Magnetic monopoles have never been observed." },
        { "text": "Electricity and magnetism are completely unrelated", "isCorrect": false, "explanation": "Incorrect: They are unified in F^{mu nu}." },
        { "text": "Magnetism only exists at zero Kelvin", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
