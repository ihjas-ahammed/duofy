# Duofy Reusable Lesson Format: Relativistic Four-Vectors and Energy-Momentum

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Astrophysics_and_Relativity / Special_and_General_Relativity`  
**Lesson Format Type:** `relativistic_four_vectors_and_energy_momentum`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through relativistic dynamics in 4D spacetime: formulate **Four-Position ($x^\mu$)**, **Four-Velocity ($U^\mu = \gamma(c, \mathbf{u})$)**, and **Four-Momentum ($P^\mu = (E/c, \mathbf{p})$)**, evaluate the fundamental invariant norm $P^\mu P_\mu = -(m_0 c)^2$, derive Einstein's mass-energy relation **$E = \gamma m_0 c^2$** and the dispersion relation **$E^2 = (pc)^2 + (m_0 c^2)^2$**, and compute threshold energies for particle collision reactions.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Four-Vectors & Energy-Momentum Invariant Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Relativistic Dispersion Relation Proof Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Four-Vector Quantity & Geometric Component Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Rest Mass Energy of Zero Speed Particle Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Massless Photon Energy-Momentum Relation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the definition of Four-Vectors in Minkowski spacetime with metric signature $(-, +, +, +)$:
   - **Four-Position:** $x^\mu = (ct, x, y, z) = (ct, \mathbf{x})$.
   - **Four-Velocity:** $U^\mu \equiv \frac{dx^\mu}{d\tau} = \gamma(c, \mathbf{u})$, with invariant norm $U^\mu U_\mu = \eta_{\mu\nu} U^\mu U^\nu = -c^2$.
   - **Four-Momentum:** $P^\mu \equiv m_0 U^\mu = (E/c, \mathbf{p})$ where total relativistic energy is $E = \gamma m_0 c^2$ and relativistic 3-momentum is $\mathbf{p} = \gamma m_0 \mathbf{u}$.
   - **Minkowski Invariant Norm:**
     $$P^\mu P_\mu = -(E/c)^2 + |\mathbf{p}|^2 = -(m_0 c)^2$$
   - **Einstein's Relativistic Energy-Momentum Relation:**
     $$E^2 = (pc)^2 + (m_0 c^2)^2$$
2. **Slide 2 (`concept_pieces`):** Deconstruct proof of $E^2 = (pc)^2 + (m_0 c^2)^2$: (1) start with definitions $E = \gamma m_0 c^2$ and $p = \gamma m_0 v$, (2) calculate $(pc)^2 = \gamma^2 m_0^2 v^2 c^2$, (3) add $(m_0 c^2)^2$: $(pc)^2 + (m_0 c^2)^2 = m_0^2 c^4 (\gamma^2 \frac{v^2}{c^2} + 1)$, (4) substitute $\gamma^2 = \frac{1}{1 - v^2/c^2}$, so $\gamma^2 \frac{v^2}{c^2} + 1 = \frac{v^2/c^2 + 1 - v^2/c^2}{1 - v^2/c^2} = \frac{1}{1 - v^2/c^2} = \gamma^2$, (5) conclude: $(pc)^2 + (m_0 c^2)^2 = \gamma^2 m_0^2 c^4 = E^2$!
3. **Slide 3 (`matching`):** Pair 4 four-vectors ($x^\mu$, $U^\mu$, $P^\mu$, Four-Gradient $\partial_\mu$) with their component representations.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that when a particle is at rest ($v = 0, p = 0$), its total energy equals its rest mass energy $E = m_0 c^2$. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the relativistic energy and momentum of a massless particle ($m_0 = 0$, like a photon): What does the dispersion relation $E^2 = (pc)^2 + (m_0 c^2)^2$ reduce to for a photon? (Setting $m_0 = 0$ yields $E = pc \implies p = E/c = h\nu/c = h/\lambda$, proving photons carry non-zero momentum despite having zero rest mass).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "relativistic_four_vectors_and_energy_momentum",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Relativistic Four-Vectors and Energy-Momentum**\n• **Minkowski Four-Vectors in Spacetime ($\\eta_{\\mu\\nu} = \\operatorname{diag}(-1, 1, 1, 1)$):**\n  - **Four-Position:** $x^\\mu = (ct, \\mathbf{x})$.\n  - **Four-Velocity:** $U^\\mu = \\frac{dx^\\mu}{d\\tau} = \\gamma(c, \\mathbf{u})$, satisfying $U^\\mu U_\\mu = -c^2$.\n  - **Four-Momentum:** $P^\\mu = m_0 U^\\mu = \\left(\\frac{E}{c}, \\mathbf{p}\\right)$.\n• **The Energy-Momentum Invariant Norm:**\n$$\nP^\\mu P_\\mu = -\\left(\\frac{E}{c}\\right)^2 + |\\mathbf{p}|^2 = -(m_0 c)^2\n$$\n• **The Relativistic Energy Dispersion Formula:**\n$$\nE^2 = (pc)^2 + (m_0 c^2)^2\n$$\n  - At Rest ($p = 0$): $E_0 = m_0 c^2$ (**Einstein's Mass-Energy Equivalence**).\n  - Massless ($m_0 = 0$, Photons): $E = pc$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Express $E$ and $p$):** $E = \\gamma m_0 c^2$ and $p = \\gamma m_0 v$.\n• **Step 2 (Evaluate Momentum Term):** $(pc)^2 = \\gamma^2 m_0^2 v^2 c^2$.\n• **Step 3 (Add Rest Energy Square):**\n  $$(pc)^2 + (m_0 c^2)^2 = m_0^2 c^4 \\left( \\gamma^2 \\frac{v^2}{c^2} + 1 \\right)$$\n• **Step 4 (Substitute Lorentz Factor Identity):**\n  $$\\gamma^2 \\frac{v^2}{c^2} + 1 = \\frac{v^2/c^2 + (1 - v^2/c^2)}{1 - v^2/c^2} = \\frac{1}{1 - v^2/c^2} = \\gamma^2$$\n• **Step 5 (Conclude Invariance):**\n  $$(pc)^2 + (m_0 c^2)^2 = \\gamma^2 m_0^2 c^4 = E^2!$$"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each four-vector to its spacetime component definition.",
      "matchPairs": [
        { "left": "Four-Position x^mu", "right": "(ct, x, y, z)" },
        { "left": "Four-Velocity U^mu", "right": "gamma * (c, u_x, u_y, u_z)" },
        { "left": "Four-Momentum P^mu", "right": "(E/c, p_x, p_y, p_z)" },
        { "left": "Four-Current J^mu", "right": "(c * rho_charge, j_x, j_y, j_z)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "When a massive particle is at rest with momentum p = 0, its total relativistic energy equals its rest ___ energy E = m_0 c^2.",
      "blankAnswer": "mass",
      "blankDistractors": ["kinetic", "potential", "thermal"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "For a massless photon (m_0 = 0), what is the relationship between its energy E and its linear momentum p in Special Relativity?",
      "options": [
        { "text": "E = pc, meaning a photon carries momentum p = E / c = h / lambda despite having ZERO rest mass", "isCorrect": true, "explanation": "Correct! Setting m_0 = 0 in E^2 = (pc)^2 + (m_0 c^2)^2 yields E = pc. Photons have zero rest mass but carry non-zero energy and momentum, allowing radiation pressure and the Compton effect." },
        { "text": "p = 0 because momentum requires mass", "isCorrect": false, "explanation": "Incorrect: Light exerts radiation pressure." },
        { "text": "E = 0 for all photons", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "E = 1/2 m v^2", "isCorrect": false, "explanation": "Incorrect: Classical formula fails for light." }
      ]
    }
  ]
}
```
