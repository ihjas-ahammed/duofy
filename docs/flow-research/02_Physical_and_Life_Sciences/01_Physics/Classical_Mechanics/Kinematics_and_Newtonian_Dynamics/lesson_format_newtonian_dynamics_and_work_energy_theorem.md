# Duofy Reusable Lesson Format: Newtonian Dynamics and the Work-Energy Theorem

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Classical_Mechanics / Kinematics_and_Newtonian_Dynamics`  
**Lesson Format Type:** `newtonian_dynamics_and_work_energy_theorem`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through **Newton's Laws of Motion (1687)**: formulate the momentum definition $\mathbf{F} = \frac{d\mathbf{p}}{dt}$, evaluate impulse $\mathbf{J} = \Delta \mathbf{p}$, derive the line integral **Work-Energy Theorem** ($W_{\text{net}} = \int \mathbf{F}\cdot d\mathbf{r} = \Delta K$), characterize **Conservative Force Fields** ($\nabla \times \mathbf{F} = \mathbf{0} \iff \mathbf{F} = -\nabla V$), and formulate the total mechanical energy conservation law $E = K + V = \text{const}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Newton's Laws & Work-Energy Theorem Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Work-Energy Theorem Line Integral Derivation | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Force Field Type & Energy Conservation Behavior Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical Work Calculation for Constant 10 N Force | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Conservative Force Curl Zero Vector Criterion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Newton's Three Laws of Motion (Isaac Newton, 1687):
   - **First Law (Inertia):** In an inertial frame, a body remains at constant velocity unless acted upon by a net external force.
   - **Second Law (Momentum Rate of Change):** $\mathbf{F}_{\text{net}} = \frac{d\mathbf{p}}{dt} = m \mathbf{a}$ (for constant mass $m$).
   - **Third Law (Action-Reaction):** $\mathbf{F}_{12} = -\mathbf{F}_{21}$.
   - **The Work-Energy Theorem:**
     $$W_{\text{net}} = \int_{\mathbf{r}_1}^{\mathbf{r}_2} \mathbf{F}_{\text{net}} \cdot d\mathbf{r} = \Delta K = \frac{1}{2}m v_2^2 - \frac{1}{2}m v_1^2$$
   - **Conservative Forces:** Force $\mathbf{F}$ is conservative $\iff \oint \mathbf{F} \cdot d\mathbf{r} = 0 \iff \nabla \times \mathbf{F} = \mathbf{0} \iff \mathbf{F} = -\nabla V(\mathbf{r}) \implies E = K + V = \text{const}$.
2. **Slide 2 (`concept_pieces`):** Deconstruct line integral proof of the Work-Energy Theorem: (1) start with work definition $W = \int_{t_1}^{t_2} \mathbf{F} \cdot d\mathbf{r}$, (2) substitute Newton's 2nd Law $\mathbf{F} = m \frac{d\mathbf{v}}{dt}$ and differential displacement $d\mathbf{r} = \mathbf{v} dt$, (3) write integrand: $\mathbf{F} \cdot d\mathbf{r} = m \frac{d\mathbf{v}}{dt} \cdot \mathbf{v} dt$, (4) recognize derivative of scalar product: $\frac{d}{dt}(\mathbf{v} \cdot \mathbf{v}) = 2 \mathbf{v} \cdot \frac{d\mathbf{v}}{dt}$, so $\mathbf{F} \cdot d\mathbf{r} = \frac{1}{2} m \frac{d(v^2)}{dt} dt = d\left(\frac{1}{2} m v^2\right)$, (5) integrate from $v_1$ to $v_2$: $W = \int_{v_1}^{v_2} d\left(\frac{1}{2} m v^2\right) = \frac{1}{2} m v_2^2 - \frac{1}{2} m v_1^2 = \Delta K$!
3. **Slide 3 (`matching`):** Pair 4 forces (Gravity $\mathbf{F} = -mg\hat{\mathbf{k}}$, Hooke's Spring $\mathbf{F} = -k x\hat{\mathbf{i}}$, Kinetic Friction $\mathbf{F} = -\mu_k N \hat{\mathbf{v}}$, Magnetic Lorentz Force $\mathbf{F} = q(\mathbf{v} \times \mathbf{B})$) with their work-energy properties.
4. **Slide 4 (`numerical`):** Ask student: A constant net force $F = 10\text{ N}$ pushes a $2\text{ kg}$ mass along the $x$-axis from $x = 0\text{ m}$ to $x = 5\text{ m}$. Calculate the work done in Joules: $W = F \cdot \Delta x = 10 \times 5$ (numeric answer: 50).
5. **Slide 5 (`quiz`):** Quiz on the magnetic Lorentz force doing zero work: Why does a purely magnetic force $\mathbf{F} = q(\mathbf{v} \times \mathbf{B})$ do ZERO work on a charged particle? (Because $\mathbf{F}$ is always perpendicular to velocity $\mathbf{v}$ ($\mathbf{F} \cdot \mathbf{v} = q(\mathbf{v} \times \mathbf{B}) \cdot \mathbf{v} = 0$), so power $P = \mathbf{F} \cdot \mathbf{v} = 0$, meaning magnetic fields can change direction but CANNOT change kinetic energy or speed).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "newtonian_dynamics_and_work_energy_theorem",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Newtonian Dynamics and the Work-Energy Theorem**\n• **Newton's Second Law:** $\\mathbf{F}_{\\text{net}} = \\frac{d\\mathbf{p}}{dt} = m \\mathbf{a}$.\n• **The Work-Energy Theorem:**\n$$\nW_{\\text{net}} = \\int_{\\mathbf{r}_1}^{\\mathbf{r}_2} \\mathbf{F}_{\\text{net}} \\cdot d\\mathbf{r} = \\Delta K = \\frac{1}{2} m v_2^2 - \\frac{1}{2} m v_1^2\n$$\n• **Conservative Forces ($E = K + V = \\text{const}$):**\n$$\n\\nabla \\times \\mathbf{F} = \\mathbf{0} \\longleftrightarrow \\oint \\mathbf{F} \\cdot d\\mathbf{r} = 0 \\longleftrightarrow \\mathbf{F} = -\\nabla V(\\mathbf{r})\n$$\n• **Non-Conservative Work:** $W_{\\text{nc}} = \\Delta E = \\Delta(K + V)$."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Work Definition):** $W = \\int_{t_1}^{t_2} \\mathbf{F} \\cdot d\\mathbf{r}$.\n• **Step 2 (Substitute Motion):** $\\mathbf{F} = m \\frac{d\\mathbf{v}}{dt}$ and $d\\mathbf{r} = \\mathbf{v} dt$.\n• **Step 3 (Chain Rule on Dot Product):** $\\mathbf{F} \\cdot d\\mathbf{r} = m \\left(\\frac{d\\mathbf{v}}{dt} \\cdot \\mathbf{v}\\right) dt = \\frac{1}{2} m \\frac{d(v^2)}{dt} dt$.\n• **Step 4 (Exact Differential):** The integrand is an exact differential: $dK = d\\left(\\frac{1}{2} m v^2\\right)$.\n• **Step 5 (Integrate):** $W = \\int_{v_1}^{v_2} d\\left(\\frac{1}{2} m v^2\\right) = \\frac{1}{2} m v_2^2 - \\frac{1}{2} m v_1^2 = \\Delta K$!"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each force to its work and energy conservation characteristic.",
      "matchPairs": [
        { "left": "Uniform Gravity F = -mg k_hat", "right": "Conservative: Potential energy V(z) = mgz" },
        { "left": "Ideal Spring F = -k x i_hat", "right": "Conservative: Potential energy V(x) = (1/2) k x^2" },
        { "left": "Kinetic Friction F = -mu_k N v_hat", "right": "Non-conservative: Dissipates mechanical energy into thermal heat (W < 0)" },
        { "left": "Magnetic Force F = q(v x B)", "right": "Always does ZERO work (power P = F . v = 0; alters direction, not speed)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "Calculate the work done (in Joules) by a constant net force of 10 N pushing a 2 kg block over a straight displacement of 5 meters: W = F * Delta x.",
      "numericAnswer": 50,
      "numericTolerance": 0
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does a static magnetic field B exert ZERO work on a moving charged particle (F = q(v x B))?",
      "options": [
        { "text": "The magnetic force is STRICTLY PERPENDICULAR to the particle velocity at every instant (F . v = q(v x B) . v = 0); therefore, instantaneous power P = dW/dt = 0 and kinetic energy remains constant", "isCorrect": true, "explanation": "Correct! Because the vector cross product v x B is orthogonal to v, F . v is identically zero, meaning magnetic fields cannot alter a particle's speed or kinetic energy." },
        { "text": "Because magnetic fields have zero energy", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because magnetic charge does not exist", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because particles lose mass in magnetic fields", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
