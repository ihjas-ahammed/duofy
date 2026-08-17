# Duofy Reusable Lesson Format: Reciprocal Lattice and Laue Diffraction Condition

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Condensed_Matter_and_Solid_State_Physics / Crystal_Lattices_and_X_Ray_Diffraction`  
**Lesson Format Type:** `reciprocal_lattice_and_laue_diffraction_condition`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through reciprocal space mathematics: construct primitive reciprocal vectors $\mathbf{b}_i = 2\pi \frac{\mathbf{a}_j \times \mathbf{a}_k}{V}$ satisfying $\mathbf{a}_i \cdot \mathbf{b}_j = 2\pi \delta_{ij}$, prove that the **Reciprocal Lattice of FCC is BCC** (and vice versa), formulate the **Von Laue Diffraction Condition ($\Delta \mathbf{k} = \mathbf{G}_{hkl}$)**, construct the **Ewald Sphere**, and prove equivalence between Laue's vector condition and Bragg's scalar law ($2d\sin\theta = \lambda$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Reciprocal Lattice & Laue Condition Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Proof of Equivalence Between Laue and Bragg Derivation | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Real-Space Crystal Lattice & Reciprocal Dual Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Reciprocal Lattice of FCC Direct Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Ewald Sphere Construction and Diffraction Spot Condition Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Reciprocal Lattice Definition for real-space primitive vectors $\mathbf{a}_1, \mathbf{a}_2, \mathbf{a}_3$ and volume $V = \mathbf{a}_1 \cdot (\mathbf{a}_2 \times \mathbf{a}_3)$:
   $$\mathbf{b}_1 = 2\pi \frac{\mathbf{a}_2 \times \mathbf{a}_3}{V}, \qquad \mathbf{b}_2 = 2\pi \frac{\mathbf{a}_3 \times \mathbf{a}_1}{V}, \qquad \mathbf{b}_3 = 2\pi \frac{\mathbf{a}_1 \times \mathbf{a}_2}{V}$$
   satisfying orthogonality $\mathbf{a}_i \cdot \mathbf{b}_j = 2\pi \delta_{ij}$.
   - **General Reciprocal Lattice Vector:** $\mathbf{G}_{hkl} = h \mathbf{b}_1 + k \mathbf{b}_2 + l \mathbf{b}_3$.
   - **Theorem:** The vector $\mathbf{G}_{hkl}$ is strictly perpendicular to the $(hkl)$ real-space crystal planes, and $|\mathbf{G}_{hkl}| = \frac{2\pi}{d_{hkl}}$.
   - **Von Laue Diffraction Condition (Max von Laue, 1912):**
     $$\Delta \mathbf{k} \equiv \mathbf{k}' - \mathbf{k} = \mathbf{G}_{hkl}$$
   - **Ewald Sphere Construction:** A sphere of radius $k = 2\pi/\lambda$ centered at the tip of the incoming wavevector $\mathbf{k}$; diffraction occurs whenever a reciprocal lattice point intersects the surface of the Ewald sphere!
2. **Slide 2 (`concept_pieces`):** Deconstruct proof that Laue condition $\Delta \mathbf{k} = \mathbf{G}$ is mathematically identical to Bragg's law $2d\sin\theta = \lambda$: (1) start with elastic scattering where photon energy is conserved: $|\mathbf{k}'| = |\mathbf{k}| = 2\pi/\lambda$, (2) express scattering vector magnitude from isosceles wavevector triangle with scattering angle $2\theta$: $|\Delta \mathbf{k}| = 2 k \sin\theta = 2\left(\frac{2\pi}{\lambda}\right)\sin\theta$, (3) set Laue condition $|\Delta \mathbf{k}| = |\mathbf{G}_{hkl}|$, (4) substitute reciprocal length $|\mathbf{G}_{hkl}| = \frac{2\pi}{d_{hkl}}$, (5) equate both sides: $2\left(\frac{2\pi}{\lambda}\right)\sin\theta = \frac{2\pi}{d_{hkl}} \implies 2 d_{hkl}\sin\theta = \lambda$ (Bragg's Law derived!)!
3. **Slide 3 (`matching`):** Pair 4 real-space lattices (Simple Cubic (side $a$), FCC (side $a$), BCC (side $a$), 1D Chain (spacing $a$)) with their reciprocal lattice duals (Simple Cubic (side $2\pi/a$), BCC (side $4\pi/a$), FCC (side $4\pi/a$), 1D Chain (spacing $2\pi/a$)).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the reciprocal lattice of a Face-Centered Cubic (FCC) real-space lattice is a body-centered cubic (BCC) lattice. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the geometric meaning of the Ewald Sphere: What does the Ewald Sphere prove about X-ray diffraction in a single crystal? (Diffraction only occurs when a reciprocal lattice point lies EXACTLY on the spherical surface of radius $2\pi/\lambda$ centered at $-\mathbf{k}$; rotating the crystal sweeps reciprocal points through the sphere, generating discrete diffraction spots).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "reciprocal_lattice_and_laue_diffraction_condition",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Reciprocal Lattice and Laue Condition**\n• **Primitive Reciprocal Basis Vectors:**\n$$\n\\mathbf{b}_1 = 2\\pi \\frac{\\mathbf{a}_2 \\times \\mathbf{a}_3}{V}, \\qquad \\mathbf{a}_i \\cdot \\mathbf{b}_j = 2\\pi \\delta_{ij}\n$$\n• **Reciprocal Lattice Vector $\\mathbf{G}_{hkl}$:**\n$$\n\\mathbf{G}_{hkl} = h \\mathbf{b}_1 + k \\mathbf{b}_2 + l \\mathbf{b}_3, \\qquad |\\mathbf{G}_{hkl}| = \\frac{2\\pi}{d_{hkl}}\n$$\n• **Von Laue Diffraction Condition (Max von Laue, 1912):**\n$$\n\\Delta \\mathbf{k} \\equiv \\mathbf{k}' - \\mathbf{k} = \\mathbf{G}_{hkl}\n$$\n• **Ewald Sphere:** A sphere in reciprocal space of radius $k = \\frac{2\\pi}{\\lambda}$. Constructive diffraction occurs wherever the sphere intersects a reciprocal lattice point!"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Elastic Scattering):** Photon energy is conserved: $|\\mathbf{k}'| = |\\mathbf{k}| = \\frac{2\\pi}{\\lambda}$.\n• **Step 2 (Wavevector Geometry):** The scattering triangle with Bragg angle $\\theta$ gives $|\\Delta \\mathbf{k}| = 2 k \\sin\\theta = 2\\left(\\frac{2\\pi}{\\lambda}\\right)\\sin\\theta$.\n• **Step 3 (Laue Condition):** Equate wavevector transfer to reciprocal vector: $|\\Delta \\mathbf{k}| = |\\mathbf{G}_{hkl}|$.\n• **Step 4 (Reciprocal Length):** Substitute $|\\mathbf{G}_{hkl}| = \\frac{2\\pi}{d_{hkl}}$.\n• **Step 5 (Equate and Cancel $2\\pi$):**\n  $$2\\left(\\frac{2\\pi}{\\lambda}\\right)\\sin\\theta = \\frac{2\\pi}{d_{hkl}} \\implies 2 d_{hkl}\\sin\\theta = \\lambda!$$\n  *(Laue vector condition and Bragg scalar law are mathematically identical!).*"
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each real-space crystal lattice to its reciprocal lattice dual.",
      "matchPairs": [
        { "left": "Simple Cubic (SC) with lattice constant a", "right": "Simple Cubic (SC) with lattice constant 2pi / a" },
        { "left": "Face-Centered Cubic (FCC) with lattice constant a", "right": "Body-Centered Cubic (BCC) with cube side 4pi / a" },
        { "left": "Body-Centered Cubic (BCC) with lattice constant a", "right": "Face-Centered Cubic (FCC) with cube side 4pi / a" },
        { "left": "Hexagonal Lattice (a, c)", "right": "Hexagonal Lattice rotated by 30° with constants 4pi/(a*sqrt(3)) and 2pi/c" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The reciprocal lattice of a real-space Face-Centered Cubic (FCC) crystal is a ___-centered cubic (BCC) lattice.",
      "blankAnswer": "body",
      "blankDistractors": ["face", "simple", "base"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the physical principle behind the Ewald Sphere construction in X-ray crystallography?",
      "options": [
        { "text": "A sphere of radius k = 2pi / lambda is drawn in reciprocal space from the incoming wavevector; constructive diffraction occurs IF AND ONLY IF a reciprocal lattice point lies EXACTLY on the sphere's surface (satisfying delta k = G)", "isCorrect": true, "explanation": "Correct! The Ewald sphere geometrically enforces both energy conservation (|k'| = |k|) and momentum conservation (delta k = G). Rotating the crystal sweeps reciprocal points through the sphere, producing diffraction peaks." },
        { "text": "It proves that crystals are spherical", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It calculates the mass of the crystal", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It eliminates all reciprocal points", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
