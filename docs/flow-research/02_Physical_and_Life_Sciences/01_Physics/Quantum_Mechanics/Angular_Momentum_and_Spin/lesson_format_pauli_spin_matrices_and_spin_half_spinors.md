# Duofy Reusable Lesson Format: Pauli Spin Matrices and Spin-1/2 Spinors

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Quantum_Mechanics / Angular_Momentum_and_Spin`  
**Lesson Format Type:** `pauli_spin_matrices_and_spin_half_spinors`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through intrinsic quantum spin and spinor algebra: formulate **Spin-1/2 Operators ($\hat{\mathbf{S}} = \frac{\hbar}{2}\boldsymbol{\sigma}$)**, construct the **Pauli Spin Matrices** ($\sigma_x, \sigma_y, \sigma_z$), prove the algebraic relations ($\sigma_i \sigma_j = \delta_{ij} I + i\epsilon_{ijk}\sigma_k, \operatorname{Tr}(\sigma_i)=0, \det(\sigma_i)=-1$), calculate eigenspinors for measurement along arbitrary unit vectors $\hat{\mathbf{n}} = (\sin\theta\cos\phi, \sin\theta\sin\phi, \cos\theta)$, and evaluate **Stern-Gerlach Sequential Measurements** and spin precession in a magnetic field (Larmor frequency $\omega_L = \gamma B_0$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Spin-1/2 Algebra & Pauli Matrices Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Arbitrary Direction Spin-n Eigenspinor Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Spin Operator / Commutator & Matrix Result Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Pauli Matrix Squared Value Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Sequential Stern-Gerlach Experiment Probability Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Spin-1/2 Quantum Mechanics (Wolfgang Pauli, 1927):
   - **Spin-1/2 Operator:** $\hat{\mathbf{S}} = \frac{\hbar}{2} \boldsymbol{\sigma}$, with $\hat{\mathbf{S}}^2 |\pm\rangle = \frac{3}{4}\hbar^2 |\pm\rangle$.
   - **The 3 Pauli Spin Matrices:**
     $$\sigma_x = \begin{pmatrix} 0 & 1 \\ 1 & 0 \end{pmatrix}, \qquad \sigma_y = \begin{pmatrix} 0 & -i \\ i & 0 \end{pmatrix}, \qquad \sigma_z = \begin{pmatrix} 1 & 0 \\ 0 & -1 \end{pmatrix}$$
   - **Fundamental Product & Commutation Identities:**
     $$\sigma_i \sigma_j = \delta_{ij} I + i \epsilon_{ijk} \sigma_k \implies [\sigma_i, \sigma_j] = 2i\epsilon_{ijk}\sigma_k, \quad \{\sigma_i, \sigma_j\} = 2\delta_{ij} I$$
     $$\sigma_x^2 = \sigma_y^2 = \sigma_z^2 = I, \qquad \operatorname{Tr}(\sigma_i) = 0, \qquad \det(\sigma_i) = -1$$
   - **Arbitrary Direction $\hat{\mathbf{n}} = (\sin\theta\cos\phi, \sin\theta\sin\phi, \cos\theta)$ Eigenspinor:**
     $$|\chi_+^{(\hat{\mathbf{n}})}\rangle = \begin{pmatrix} \cos(\theta/2) \\ e^{i\phi} \sin(\theta/2) \end{pmatrix}, \qquad |\chi_-^{(\hat{\mathbf{n}})}\rangle = \begin{pmatrix} -\sin(\theta/2) \\ e^{i\phi} \cos(\theta/2) \end{pmatrix}$$
2. **Slide 2 (`ordering`):** Provide 5 steps deriving eigenspinors of $\hat{\mathbf{S}}\cdot\hat{\mathbf{n}}$: (1) write $2\times 2$ matrix for $\boldsymbol{\sigma}\cdot\hat{\mathbf{n}} = n_x \sigma_x + n_y \sigma_y + n_z \sigma_z$: $\begin{pmatrix} \cos\theta & \sin\theta e^{-i\phi} \\ \sin\theta e^{i\phi} & -\cos\theta \end{pmatrix}$, (2) set up eigenvalue equation: $(\boldsymbol{\sigma}\cdot\hat{\mathbf{n}})\chi = \lambda \chi$, (3) compute characteristic equation: $\det(\boldsymbol{\sigma}\cdot\hat{\mathbf{n}} - \lambda I) = \lambda^2 - (\cos^2\theta + \sin^2\theta) = \lambda^2 - 1 = 0 \implies \lambda = \pm 1$, (4) solve linear system for $\lambda = +1$: $(\cos\theta - 1)a + (\sin\theta e^{-i\phi})b = 0 \implies \frac{b}{a} = \frac{1 - \cos\theta}{\sin\theta e^{-i\phi}} = \frac{2\sin^2(\theta/2) e^{i\phi}}{2\sin(\theta/2)\cos(\theta/2)} = e^{i\phi}\tan(\theta/2)$, (5) normalize $|a|^2 + |b|^2 = 1$ to find normalized spinor $|\chi_+\rangle = \begin{pmatrix} \cos(\theta/2) \\ e^{i\phi}\sin(\theta/2) \end{pmatrix}$!
3. **Slide 3 (`matching`):** Pair 4 spin states ($|S_x = +\hbar/2\rangle$, $|S_y = +\hbar/2\rangle$, $|S_z = +\hbar/2\rangle$, $|S_z = -\hbar/2\rangle$) with their 2D spinor column vectors ($\frac{1}{\sqrt{2}}\begin{pmatrix} 1 \\ 1 \end{pmatrix}$, $\frac{1}{\sqrt{2}}\begin{pmatrix} 1 \\ i \end{pmatrix}$, $\begin{pmatrix} 1 \\ 0 \end{pmatrix}$, $\begin{pmatrix} 0 \\ 1 \end{pmatrix}$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the square of any Pauli spin matrix equals the 2x2 identity matrix I. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on sequential Stern-Gerlach measurements: An initial beam of silver atoms is prepared in state $|S_z = +\hbar/2\rangle$. It passes through a horizontal Stern-Gerlach device oriented along the $x$-axis ($SG_x$), which transmits only atoms with $|S_x = +\hbar/2\rangle$. Finally, this beam passes through a third device oriented along the $z$-axis ($SG_z$). What fraction of the original atoms emerge with $|S_z = -\hbar/2\rangle$? (25% (1/4); passing $SG_x$ selects $|S_x = +\rangle = \frac{1}{\sqrt{2}}(|z+\rangle + |z-\rangle)$, transmitting 50% of the beam. When these enter the final $SG_z$, the probability of measuring $|z-\rangle$ is $|\langle z- | S_x+ \rangle|^2 = |1/\sqrt{2}|^2 = 1/2$. Total fraction = $(1/2) \times (1/2) = 1/4 = 25\%$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "pauli_spin_matrices_and_spin_half_spinors",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Pauli Spin Matrices and Spin-1/2 Algebra**\n• **Spin-1/2 Operators:** $\\hat{\\mathbf{S}} = \\frac{\\hbar}{2} \\boldsymbol{\\sigma}$.\n• **The 3 Pauli Spin Matrices:**\n$$\n\\sigma_x = \\begin{pmatrix} 0 & 1 \\\\ 1 & 0 \\end{pmatrix}, \\qquad \\sigma_y = \\begin{pmatrix} 0 & -i \\\\ i & 0 \\end{pmatrix}, \\qquad \\sigma_z = \\begin{pmatrix} 1 & 0 \\\\ 0 & -1 \\end{pmatrix}\n$$\n• **Fundamental Algebraic Identities:**\n$$\n\\sigma_i \\sigma_j = \\delta_{ij} I + i \\epsilon_{ijk} \\sigma_k, \\qquad \\sigma_x^2 = \\sigma_y^2 = \\sigma_z^2 = I\n$$\n$$\n[\\sigma_i, \\sigma_j] = 2i\\epsilon_{ijk}\\sigma_k, \\qquad \\{\\sigma_i, \\sigma_j\\} = 2\\delta_{ij} I\n$$\n• **Eigenspinor along Unit Vector $\\hat{\\mathbf{n}} = (\\sin\\theta\\cos\\phi, \\sin\\theta\\sin\\phi, \\cos\\theta)$:**\n$$\n|\\chi_+^{(\\hat{\\mathbf{n}})}\\rangle = \\begin{pmatrix} \\cos(\\theta/2) \\\\ e^{i\\phi} \\sin(\\theta/2) \\end{pmatrix}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the matrix eigenvalue steps deriving the arbitrary-direction eigenspinor |chi_+^(n_hat)>.",
      "orderItems": [
        "Construct the 2x2 projection matrix: sigma . n_hat = [ cos(theta), sin(theta)*exp(-i phi); sin(theta)*exp(i phi), -cos(theta) ]",
        "Set up the secular determinant: det(sigma . n_hat - lambda * I) = lambda^2 - 1 = 0, giving eigenvalues lambda = +-1",
        "Formulate the linear eigenvalue system for lambda = +1: (cos(theta) - 1) a + sin(theta) exp(-i phi) b = 0",
        "Apply half-angle trigonometric identities to solve for ratio b/a = exp(i phi) * tan(theta / 2)",
        "Enforce spinor normalization |a|^2 + |b|^2 = 1 to obtain |chi_+> = [ cos(theta/2); exp(i phi) * sin(theta/2) ]"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each spin state to its 2D column spinor representation in the S_z basis.",
      "matchPairs": [
        { "left": "|S_z = +hbar/2> (Spin Up)", "right": "[1; 0]" },
        { "left": "|S_z = -hbar/2> (Spin Down)", "right": "[0; 1]" },
        { "left": "|S_x = +hbar/2> (Spin Right)", "right": "(1 / sqrt(2)) * [1; 1]" },
        { "left": "|S_y = +hbar/2> (Spin In)", "right": "(1 / sqrt(2)) * [1; i]" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "For every Pauli spin matrix (sigma_x, sigma_y, sigma_z), the matrix square sigma_i^2 equals the 2x2 ___ matrix.",
      "blankAnswer": "identity",
      "blankDistractors": ["zero", "null", "diagonal"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a sequential Stern-Gerlach experiment, atoms in state |S_z = +hbar/2> pass through an SG_x filter (selecting |S_x = +hbar/2>), then through an SG_z filter. What fraction of original atoms emerge with |S_z = -hbar/2>?",
      "options": [
        { "text": "25% (1/4); the intermediate SG_x filter projects the spin into |S_x +> = (1/√2)(|z+> + |z->), destroying previous z-information and giving a (1/2) * (1/2) = 1/4 transmission probability for |z->", "isCorrect": true, "explanation": "Correct! The intermediate measurement collapses the wavefunction into the x-basis |S_x+>. When remeasured along z, the probability is |<S_z- | S_x+>|^2 = |1/sqrt(2)|^2 = 1/2. Combined with the 50% transmission of the first filter, 25% of the original atoms emerge as spin-down." },
        { "text": "0% because the beam started with pure spin-up (|S_z = +hbar/2>)", "isCorrect": false, "explanation": "Incorrect: True only if the intermediate SG_x measurement was NOT performed." },
        { "text": "50% (1/2)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "100%", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
