# Duofy Reusable Lesson Format: Maxwell's Equations and Displacement Current

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Electromagnetism_and_Electrodynamics / Maxwell_Equations_and_Electromagnetic_Waves`  
**Lesson Format Type:** `maxwells_equations_and_displacement_current`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the unification of electromagnetism: formulate the four **Maxwell Equations**, identify the mathematical inconsistency in Ampère's Law ($\nabla \cdot (\nabla \times \mathbf{B}) = 0 \ne \mu_0 \nabla \cdot \mathbf{J} = -\mu_0 \frac{\partial\rho}{\partial t}$), derive **Maxwell's Displacement Current Density ($\mathbf{J}_d = \epsilon_0 \frac{\partial\mathbf{E}}{\partial t}$)**, solve the charging capacitor paradox, and write the complete **Ampère-Maxwell Law**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Maxwell's Equations & Displacement Current Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Mathematical Derivation of Displacement Current Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Maxwell Equation & Physical Phenomenon Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Charging Capacitor Displacement Current Total Value Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Charging Capacitor Surface Independence Paradox Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Complete Set of Maxwell's Equations (James Clerk Maxwell, 1865):
   1. **Gauss's Law:** $\nabla \cdot \mathbf{E} = \frac{\rho}{\epsilon_0}$ (Electric charges produce divergence).
   2. **Gauss's Law for Magnetism:** $\nabla \cdot \mathbf{B} = 0$ (No magnetic monopoles).
   3. **Faraday's Law of Induction:** $\nabla \times \mathbf{E} = -\frac{\partial\mathbf{B}}{\partial t}$ (Changing magnetic flux induces electric field).
   4. **Ampère-Maxwell Law:** $\nabla \times \mathbf{B} = \mu_0 \mathbf{J} + \mu_0 \epsilon_0 \frac{\partial\mathbf{E}}{\partial t}$ (Conduction current + Displacement current induce magnetic field).
   - **Displacement Current Density:** $\mathbf{J}_d \equiv \epsilon_0 \frac{\partial\mathbf{E}}{\partial t}$.
   - **Total Current Continuity:** $\nabla \cdot (\mathbf{J} + \mathbf{J}_d) = 0$ (Guarantees charge conservation $\nabla \cdot \mathbf{J} = -\frac{\partial\rho}{\partial t}$!).
2. **Slide 2 (`ordering`):** Provide 5 steps deriving displacement current from charge conservation: (1) take divergence of old Ampère's Law: $\nabla \cdot (\nabla \times \mathbf{B}) = \mu_0 (\nabla \cdot \mathbf{J})$, (2) recall vector identity that divergence of any curl is identically zero: $\nabla \cdot (\nabla \times \mathbf{B}) = 0 \implies \nabla \cdot \mathbf{J} = 0$, (3) note that for non-steady currents, the Continuity Equation requires $\nabla \cdot \mathbf{J} = -\frac{\partial\rho}{\partial t} \ne 0$ (contradiction!), (4) substitute Gauss's Law $\rho = \epsilon_0 (\nabla \cdot \mathbf{E})$ into continuity equation: $\nabla \cdot \mathbf{J} = -\frac{\partial}{\partial t}(\epsilon_0 \nabla \cdot \mathbf{E}) = -\nabla \cdot \left(\epsilon_0 \frac{\partial\mathbf{E}}{\partial t}\right)$, (5) bring all terms inside divergence: $\nabla \cdot \left(\mathbf{J} + \epsilon_0 \frac{\partial\mathbf{E}}{\partial t}\right) = 0 \implies \nabla \times \mathbf{B} = \mu_0 \left(\mathbf{J} + \epsilon_0 \frac{\partial\mathbf{E}}{\partial t}\right)$!
3. **Slide 3 (`matching`):** Pair 4 Maxwell equations with their integral expressions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that between the plates of a charging parallel-plate capacitor, the total displacement current $I_d = \epsilon_0 \frac{d\Phi_E}{dt}$ exactly equals the conduction current $I_C$ in the connecting wires. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the charging capacitor paradox: How did Maxwell resolve the paradox of applying Ampère's Law to an open "bag" surface passing between capacitor plates where conduction current is zero ($I_{\text{enc}} = 0$)? (By adding the DISPLACEMENT CURRENT $I_d = \epsilon_0 \frac{d\Phi_E}{dt}$; the time-varying electric field between the charging plates produces a displacement current flux that EXACTLY MATCHES the conduction current $I_C$ flowing in the wire, making the line integral $\oint \mathbf{B}\cdot d\mathbf{l}$ independent of surface choice).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "maxwells_equations_and_displacement_current",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Maxwell's Equations and Displacement Current**\n• **The 4 Fundamental Maxwell Equations (1865):**\n$$\n\\nabla \\cdot \\mathbf{E} = \\frac{\\rho}{\\epsilon_0} \\qquad (\\text{Gauss's Law})\n$$\n$$\n\\nabla \\cdot \\mathbf{B} = 0 \\qquad (\\text{Gauss's Law for Magnetism})\n$$\n$$\n\\nabla \\times \\mathbf{E} = -\\frac{\\partial\\mathbf{B}}{\\partial t} \\qquad (\\text{Faraday's Law})\n$$\n$$\n\\nabla \\times \\mathbf{B} = \\mu_0 \\mathbf{J} + \\mu_0 \\epsilon_0 \\frac{\\partial\\mathbf{E}}{\\partial t} \\qquad (\\text{Ampère-Maxwell Law})\n$$\n• **Displacement Current Density:** $\\mathbf{J}_d \\equiv \\epsilon_0 \\frac{\\partial\\mathbf{E}}{\\partial t}$ (Preserves charge conservation $\\nabla \\cdot \\mathbf{J} + \\frac{\\partial\\rho}{\\partial t} = 0$!)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the vector calculus steps deriving Maxwell's displacement current from the continuity equation.",
      "orderItems": [
        "Take divergence of original Ampère's law: div(curl(B)) = mu_0 * div(J)",
        "Apply vector identity that the divergence of any curl vanishes identically: div(curl(B)) = 0",
        "Observe the contradiction with the charge continuity equation for time-varying charges: div(J) = -d(rho)/dt != 0",
        "Substitute Gauss's Law rho = eps_0 * div(E) to express charge rate: div(J) = -div(eps_0 * dE/dt)",
        "Combine into a single divergence: div[ J + eps_0 * dE/dt ] = 0, defining displacement current J_d = eps_0 * dE/dt"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Maxwell equation to its integral form.",
      "matchPairs": [
        { "left": "Gauss's Law", "right": "oint E . dA = Q_enc / eps_0" },
        { "left": "Gauss's Law for Magnetism", "right": "oint B . dA = 0" },
        { "left": "Faraday's Law of Induction", "right": "oint E . dl = -d/dt (int B . dA)" },
        { "left": "Ampère-Maxwell Law", "right": "oint B . dl = mu_0 * I_enc + mu_0 * eps_0 * d/dt (int E . dA)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Between the plates of a charging capacitor, the total integrated displacement current I_d is ___ to the conduction current I_c in the wires.",
      "blankAnswer": "equal",
      "blankDistractors": ["zero", "double", "half"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How does Maxwell's Displacement Current J_d = eps_0 * dE/dt resolve the charging capacitor paradox in Ampère's Law?",
      "options": [
        { "text": "For an Amperian loop enclosing the wire, choosing a flat surface cuts the conduction current I_c, while choosing a 'bag' surface ballooning between the plates cuts the changing electric flux; displacement current I_d = eps_0 dPhi_E/dt EXACTLY EQUALS I_c, making the magnetic field line integral oint B . dl independent of surface choice", "isCorrect": true, "explanation": "Correct! Without displacement current, Ampère's law gave oint B . dl = mu_0 I_c for a flat surface and 0 for a ballooned surface between the plates. Maxwell's displacement current perfectly bridges the gap, restoring mathematical and physical consistency." },
        { "text": "It proves that current travels backwards", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It eliminates the magnetic field entirely", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It turns the capacitor into a resistor", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
