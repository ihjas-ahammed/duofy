# Duofy Reusable Lesson Format: Leray-Hopf Weak Solutions and the Energy Inequality

**Target Topic:** `01_Mathematics_and_Logic / 02_Applied_Mathematics / Fluid_Dynamics_and_Continuum_Mechanics / Navier_Stokes_Equations`  
**Lesson Format Type:** `leray_hopf_weak_solutions_and_energy_inequality`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the construction of **Leray-Hopf Weak Solutions** (Jean Leray, 1934; Eberhard Hopf, 1951), derive the fundamental **Navier-Stokes Energy Inequality** ($\frac{1}{2}\|\mathbf{u}(t)\|_{L^2}^2 + \nu \int_0^t \|\nabla \mathbf{u}\|_{L^2}^2 ds \le \frac{1}{2}\|\mathbf{u}_0\|_{L^2}^2$), and explain the 3D Millennium Prize regularity problem.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Leray-Hopf Weak Solution & Energy Inequality Statement | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Faedo-Galerkin Construction Proof Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | 2D Global Smoothness vs 3D Open Problem Quiz | `quiz` | Discrimination (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | L2 Energy Dissipation Inequality Interactive Derivation | `proof` | Production (Phase C) | `content`, `interactiveSteps` |
| **Slide 5** | Weak Solution Founder French Surname Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Leray's Theorem (1934): For any divergence-free initial velocity $\mathbf{u}_0 \in L^2(\mathbb{R}^3)$, there exists a global weak solution $\mathbf{u} \in L^\infty(0, \infty; L^2(\mathbb{R}^3)) \cap L^2(0, \infty; \dot{H}^1(\mathbb{R}^3))$ satisfying the Navier-Stokes equations in the sense of distributions, alongside the energy inequality: $\frac{1}{2} \|\mathbf{u}(t)\|_{L^2}^2 + \nu \int_0^t \|\nabla \mathbf{u}(s)\|_{L^2}^2 ds \le \frac{1}{2} \|\mathbf{u}_0\|_{L^2}^2$.
2. **Slide 2 (`ordering`):** Provide 5 steps of Leray's construction: (1) project the momentum equation onto divergence-free spaces using the Leray projector $\mathbb{P}$, eliminating pressure, (2) construct finite-dimensional Faedo-Galerkin approximations $\mathbf{u}_N(t) = \sum_{j=1}^N c_j(t) w_j$, (3) derive uniform energy estimates $\|\mathbf{u}_N(t)\|_{L^2}^2 + 2\nu \int_0^t \|\nabla \mathbf{u}_N\|_{L^2}^2 \le \|\mathbf{u}_0\|_{L^2}^2$, (4) apply the Aubin-Lions-Simon Compactness Theorem to pass to the limit strongly in $L^2_{\text{loc}}([0, T] \times \Omega)$, (5) verify that the strong $L^2$ convergence enables passing to the limit in the non-linear convective term $\lim \int (\mathbf{u}_N \otimes \mathbf{u}_N) : \nabla \mathbf{\phi} = \int (\mathbf{u} \otimes \mathbf{u}) : \nabla \mathbf{\phi}$.
3. **Slide 3 (`quiz`):** Test why 2D Navier-Stokes solutions are unconditionally unique and smooth for all time, whereas 3D uniqueness remains unproven: (In 2D, vorticity is conserved along trajectories, yielding uniform $L^\infty$ vorticity bounds that prevent finite-time singularity formation via Ladyzhenskaya's inequality).
4. **Slide 4 (`proof`):** Interactive derivation showing $\int (\mathbf{u} \cdot \nabla \mathbf{u}) \cdot \mathbf{u} \, dx = 0$ by integration by parts with $\nabla \cdot \mathbf{u} = 0$, causing the convective nonlinearity to vanish from the global kinetic energy balance.
5. **Slide 5 (`one_word`):** Plain-text recall of the surname of the French mathematician who founded the theory of weak solutions to the Navier-Stokes equations in 1934 (Leray).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "leray_hopf_weak_solutions_and_energy_inequality",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Leray-Hopf Weak Solutions (Leray 1934, Hopf 1951)**\nFor any initial data $\\mathbf{u}_0 \\in L^2(\\mathbb{R}^3)$ with $\\nabla \\cdot \\mathbf{u}_0 = 0$, there exists at least one **global weak solution**:\n$$\n\\mathbf{u} \\in L^\\infty(0, \\infty; L^2(\\mathbb{R}^3)) \\cap L^2(0, \\infty; \\dot{H}^1(\\mathbb{R}^3))\n$$\nsatisfying the Navier-Stokes momentum equations distributionally and obeying the **Global Energy Inequality**:\n$$\n\\frac{1}{2} \\|\\mathbf{u}(t)\\|_{L^2}^2 + \\nu \\int_0^t \\|\\nabla \\mathbf{u}(s)\\|_{L^2}^2 \\, ds \\le \\frac{1}{2} \\|\\mathbf{u}_0\\|_{L^2}^2 \\quad \\forall t \\ge 0\n$$\n• **The 3D Millennium Problem:** Whether 3D Leray weak solutions are unique and globally smooth for all smooth $\\mathbf{u}_0$ remains an unsolved Clay Millennium Prize problem."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the logical steps constructing Leray weak solutions via Faedo-Galerkin approximation and compactness.",
      "orderItems": [
        "Apply the Leray orthogonal projector P to project the momentum equation onto solenoidal fields, completely eliminating the pressure term",
        "Construct finite-dimensional Faedo-Galerkin approximations u_N(t) = sum_{j=1}^N c_j(t) w_j on smooth eigenfunctions w_j",
        "Establish uniform energy bounds: ||u_N(t)||_{L^2}^2 + 2 nu int_0^t ||nabla u_N||_{L^2}^2 <= ||u_0||_{L^2}^2, independent of N",
        "Apply the Aubin-Lions-Simon Compactness Theorem to extract a subsequence converging strongly in L^2_loc([0, T] x Omega)",
        "Pass to the limit inside the nonlinear convective term int (u_N otimes u_N) : nabla phi -> int (u otimes u) : nabla phi, proving u is a weak solution"
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is every weak solution to the 2D Incompressible Navier-Stokes equations GUARANTEED to be unique and infinitely smooth for all t > 0 (unlike the open 3D case)?",
      "options": [
        { "text": "In 2D, the vortex stretching term is identically zero, so maximum vorticity ||omega(t)||_infty is uniformly bounded for all time, preventing any energy concentration or finite-time singularity", "isCorrect": true, "explanation": "Correct! In 2D, vorticity is conserved along particle trajectories (omega_t + u . nabla omega = nu Delta omega), which yields uniform L^p bounds on vorticity for all p, completely ruling out blowup." },
        { "text": "Because 2D fluids have zero viscosity", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because pressure does not exist in 2D", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because all 2D solutions are constant in space", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "proof",
      "content": "Derivation: Convective Non-Linear Cancellation in Kinetic Energy",
      "interactiveSteps": [
        {
          "stepText": "To derive the energy equation, take the L^2 inner product of (u . nabla) u with u: int_Omega (u_j partial_j u_i) u_i dx = int_Omega u_j partial_j (|u|^2 / 2) dx."
        },
        {
          "prompt": "Applying integration by parts and using the incompressibility condition nabla . u = partial_j u_j = 0, what is the value of this integral?",
          "options": [
            { "text": "Exactly 0 (the nonlinear convective acceleration redistributes energy among spatial modes but creates zero net kinetic energy)", "isCorrect": true },
            { "text": "int |u|^3 dx", "isCorrect": false },
            { "text": "nu ||nabla u||^2", "isCorrect": false },
            { "text": "Infinity", "isCorrect": false }
          ]
        },
        {
          "stepText": "Thus d/dt (1/2 ||u||_2^2) = -nu ||nabla u||_2^2 <= 0, proving monotonic dissipation of total kinetic energy."
        }
      ]
    },
    {
      "slideIndex": 5,
      "type": "one_word",
      "content": "What is the surname of the French mathematician who pioneered the global weak solution framework for Navier-Stokes in 1934?",
      "blankAnswer": "leray"
    }
  ]
}
```
