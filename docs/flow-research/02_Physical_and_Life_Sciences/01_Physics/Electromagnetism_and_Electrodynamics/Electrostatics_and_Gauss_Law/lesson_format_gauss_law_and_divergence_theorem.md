# Duofy Reusable Lesson Format: Gauss's Law and the Divergence Theorem

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Electromagnetism_and_Electrodynamics / Electrostatics_and_Gauss_Law`  
**Lesson Format Type:** `gauss_law_and_divergence_theorem`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce the foundational first Maxwell equation of electrostatics: formulate **Gauss's Law** in integral form ($\oint \mathbf{E}\cdot d\mathbf{A} = \frac{Q_{\text{enc}}}{\epsilon_0}$), derive its differential form ($\nabla \cdot \mathbf{E} = \frac{\rho}{\epsilon_0}$) using the **Divergence Theorem**, exploit symmetry to solve electric fields for **Spherical Shells**, **Infinite Cylinders / Line Charges**, and **Infinite Planar Charge Sheets**, and derive the electrostatic boundary condition $\Delta E_\perp = \frac{\sigma}{\epsilon_0}$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Gauss's Law & Differential Form Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Gauss's Law to Differential Form Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Charge Symmetry Type & Gaussian Surface Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Permittivity of Free Space Symbol Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Electric Field Inside Uniform Solid Charged Sphere Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Gauss's Law in Integral Form (Carl Friedrich Gauss, 1835):
   $$\Phi_E \equiv \oint_{\partial V} \mathbf{E} \cdot d\mathbf{A} = \frac{Q_{\text{enc}}}{\epsilon_0} = \frac{1}{\epsilon_0} \iiint_V \rho(\mathbf{r}) \, dV$$
   - **Differential Form (First Maxwell Equation):**
     $$\nabla \cdot \mathbf{E} = \frac{\rho}{\epsilon_0}$$
   - **Symmetry Applications:**
     - **Infinite Line Charge ($\lambda$):** $\mathbf{E}(r) = \frac{\lambda}{2\pi\epsilon_0 r} \hat{\mathbf{r}}$ (Cylindrical pillbox).
     - **Infinite Planar Sheet ($\sigma$):** $\mathbf{E} = \frac{\sigma}{2\epsilon_0} \hat{\mathbf{n}}$ (Gaussian pillbox).
     - **Uniform Spherical Shell (Total charge $Q$, radius $R$):** $\mathbf{E}(r > R) = \frac{Q}{4\pi\epsilon_0 r^2} \hat{\mathbf{r}}$, and $\mathbf{E}(r < R) = \mathbf{0}$.
2. **Slide 2 (`ordering`):** Provide 5 steps deriving differential Gauss's law from integral form: (1) write total electric flux through closed boundary $\partial V$: $\Phi_E = \oint_{\partial V} \mathbf{E} \cdot d\mathbf{A}$, (2) express enclosed charge as volume integral of charge density: $Q_{\text{enc}} = \iiint_V \rho \, dV$, (3) apply the Gauss Divergence Theorem: $\oint_{\partial V} \mathbf{E} \cdot d\mathbf{A} = \iiint_V (\nabla \cdot \mathbf{E}) dV$, (4) equate the two volume integrals: $\iiint_V (\nabla \cdot \mathbf{E}) dV = \iiint_V \left(\frac{\rho}{\epsilon_0}\right) dV \implies \iiint_V \left(\nabla \cdot \mathbf{E} - \frac{\rho}{\epsilon_0}\right) dV = 0$, (5) since the volume $V$ is completely arbitrary, the integrand must vanish identically everywhere: $\nabla \cdot \mathbf{E} = \frac{\rho}{\epsilon_0}$!
3. **Slide 3 (`matching`):** Pair 4 charge geometries (Spherical Ball/Shell, Infinite Line Charge, Infinite Flat Sheet, Isolated Point Charge) with their optimal Gaussian surfaces (Concentric Sphere, Coaxial Cylinder, Cylindrical/Rectangular Pillbox, Concentric Sphere).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that epsilon_0 represents the permittivity of free space. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the electric field inside a uniformly charged solid dielectric sphere of radius $R$ and total charge $Q$: How does $E(r)$ scale with radial distance $r$ inside the sphere ($r < R$)? ($E(r) \propto r$ linearly; inside radius $r$, the enclosed charge is $Q_{\text{enc}} = Q \left(\frac{r}{R}\right)^3$, so by Gauss's Law $E(4\pi r^2) = \frac{Q r^3}{\epsilon_0 R^3} \implies E(r) = \frac{Q r}{4\pi\epsilon_0 R^3} \propto r$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "gauss_law_and_divergence_theorem",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Gauss's Law and the Divergence Theorem**\n• **Gauss's Law in Integral Form:**\n$$\n\\oint_{\\partial V} \\mathbf{E} \\cdot d\\mathbf{A} = \\frac{Q_{\\text{enc}}}{\\epsilon_0} = \\frac{1}{\\epsilon_0} \\iiint_V \\rho(\\mathbf{r}) \\, dV\n$$\n• **Differential Form (First Maxwell Equation):**\n$$\n\\nabla \\cdot \\mathbf{E} = \\frac{\\rho}{\\epsilon_0}\n$$\n• **Symmetry Field Solutions:**\n  - **Line Charge $\\lambda$:** $E(r) = \\frac{\\lambda}{2\\pi\\epsilon_0 r}$.\n  - **Surface Sheet $\\sigma$:** $E = \\frac{\\sigma}{2\\epsilon_0}$.\n  - **Spherical Shell $Q$:** $E(r > R) = \\frac{Q}{4\\pi\\epsilon_0 r^2}$ and $E(r < R) = 0$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the vector calculus steps converting Gauss's Law from integral to differential form.",
      "orderItems": [
        "Write Gauss's Law equating surface flux to enclosed charge: oint E . dA = Q_enc / eps_0",
        "Express the enclosed charge as a volume integral of charge density: Q_enc = int_V rho dV",
        "Apply the Divergence Theorem to convert surface flux to volume integral: oint E . dA = int_V (div E) dV",
        "Equate the two volume integrals: int_V [ div E - rho / eps_0 ] dV = 0",
        "Since the integral must hold for any arbitrary volume V, conclude that div E = rho / eps_0 pointwise"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each charge geometry to its appropriate Gaussian surface for computing E.",
      "matchPairs": [
        { "left": "Uniform Spherical Charge Distribution", "right": "Concentric spherical Gaussian surface of radius r" },
        { "left": "Infinite Straight Line Charge", "right": "Coaxial circular cylindrical Gaussian surface of radius r and length L" },
        { "left": "Infinite Flat Planar Sheet of Charge", "right": "Cylindrical or rectangular pillbox straddling the charged plane" },
        { "left": "Parallel Plate Capacitor", "right": "Pillbox with one face inside the metal conductor and one in the gap" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In SI electrostatics, the physical constant eps_0 is known as the ___ of free space.",
      "blankAnswer": "permittivity",
      "blankDistractors": ["permeability", "conductivity", "resistivity"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How does the electric field E(r) vary with distance r INSIDE a uniformly charged solid non-conducting sphere of radius R and total charge Q (for r < R)?",
      "options": [
        { "text": "E(r) increases LINEARLY with distance: E(r) = (Q / (4 pi eps_0 R^3)) * r, because the enclosed charge scales with volume as Q_enc = Q * (r/R)^3 while surface area scales as 4 pi r^2", "isCorrect": true, "explanation": "Correct! Applying Gauss's Law: E(r) * (4 pi r^2) = Q_enc / eps_0 = (Q r^3 / R^3) / eps_0. Dividing by 4 pi r^2 yields E(r) = (Q / 4 pi eps_0 R^3) r, which grows linearly from 0 at the center to maximum at the surface." },
        { "text": "E(r) = 0 everywhere inside", "isCorrect": false, "explanation": "Incorrect: True only for a hollow shell or conductor, not a solid uniform charge." },
        { "text": "E(r) is inversely proportional to r^2", "isCorrect": false, "explanation": "Incorrect: That is the field outside (r > R)." },
        { "text": "E(r) is constant throughout the sphere", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
