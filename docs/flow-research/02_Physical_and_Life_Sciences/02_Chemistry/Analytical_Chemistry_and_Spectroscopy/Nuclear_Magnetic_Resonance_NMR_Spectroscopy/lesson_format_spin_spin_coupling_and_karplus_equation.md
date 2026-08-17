# Duofy Reusable Lesson Format: Spin-Spin Coupling and the Karplus Equation

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Analytical_Chemistry_and_Spectroscopy / Nuclear_Magnetic_Resonance_NMR_Spectroscopy`  
**Lesson Format Type:** `spin_spin_coupling_and_karplus_equation`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the quantum mechanics and stereochemical applications of scalar spin-spin coupling: formulate the **$n+1$ Multiplicity Rule** with **Pascal's Triangle Binomial Intensities**, construct splitting trees for non-equivalent neighbors (doublet of doublets $dd$, doublet of triplets $dt$), define the **Coupling Constant ($J$ in Hertz, field-independent)**, analyze the **Karplus Equation (Martin Karplus, 1959)** relating vicinal three-bond coupling ($^3J_{\text{HH}}$) to dihedral torsion angle $\phi$ ($^3J = A + B\cos\phi + C\cos(2\phi)$), and distinguish between trans-alkenes ($^3J_{\text{trans}} \approx 12-18\text{ Hz}$), cis-alkenes ($^3J_{\text{cis}} \approx 6-12\text{ Hz}$), and cyclohexyl axial-axial vs axial-equatorial couplings.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Spin-Spin Coupling & Karplus Equation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Splitting Tree Construction for Doublet of Doublets Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Geometric Proton Relationship & Coupling Constant J Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Trans-Alkene Coupling Constant Dominance over Cis Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Karplus Dihedral Angle Minimization Coupling Constant Value Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Scalar Spin-Spin Coupling & The Karplus Equation:
   - **First-Order Coupling ($n+1$ Multiplicity Rule):**
     $$\text{Number of Peaks} = n + 1 \qquad (\text{with intensities from Pascal's Triangle: } 1, 1:1, 1:2:1, 1:3:3:1)$$
     - Independent of Spectrometer Magnetic Field $B_0$ ($J$ measured in $\text{Hz}$, NOT $\text{ppm}$!).
   - **Complex Multiplets (Non-Equivalent Coupling):**
     $$\text{Multiplicity} = (n_a + 1)(n_b + 1) \implies \text{Doublet of Doublets } (dd) \text{ with } J_a \ne J_b$$
   - **The Karplus Equation for Vicinal Coupling ($^3J_{\text{HH}}$ across $\text{H}-\text{C}-\text{C}-\text{H}$):**
     $$^3J(\phi) = A + B \cos\phi + C \cos(2\phi) \approx 7 - \cos\phi + 5 \cos(2\phi)$$
     - **Anti-Periplanar ($\phi = 180^\circ$):** Maximum coupling ($^3J \approx 10 - 18\text{ Hz}$).
     - **Syn-Periplanar ($\phi = 0^\circ$):** Strong coupling ($^3J \approx 8 - 10\text{ Hz}$).
     - **Perpendicular ($\phi \approx 90^\circ$):** Minimal/Zero coupling ($^3J \approx 0 - 2\text{ Hz}$).
   - **Alkene Stereochemistry:** $^3J_{\text{trans}} \approx 12 - 18\text{ Hz}$ vs $^3J_{\text{cis}} \approx 6 - 12\text{ Hz}$ (unambiguous E/Z isomer assignment!).
2. **Slide 2 (`ordering`):** Provide 5 steps constructing a splitting tree for a proton coupled to two non-equivalent neighbors $H_a$ and $H_b$ ($J_a = 12\text{ Hz}, J_b = 4\text{ Hz}$): (1) start with the uncoupled single singlet resonance at chemical shift $\delta$, (2) apply the larger coupling $J_a = 12\text{ Hz}$ to split the resonance into a doublet with separation $12\text{ Hz}$, (3) apply the smaller coupling $J_b = 4\text{ Hz}$ to split each arm of the doublet into twin sub-peaks, (4) verify that all 4 resulting lines have equal $1:1:1:1$ intensity, (5) measure the peak separations to confirm the doublet of doublets ($dd$) pattern with outer separation $J_a + J_b = 16\text{ Hz}$!
3. **Slide 3 (`matching`):** Pair 4 proton coupling configurations (trans-Alkene protons, cis-Alkene protons, Geminal alkene protons $^2J_{\text{gem}}$, Cyclohexane axial-axial protons) with their typical coupling constants ($12 - 18\text{ Hz}$, $6 - 12\text{ Hz}$, $0 - 3\text{ Hz}$, $8 - 14\text{ Hz}$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that trans-alkene protons exhibit a significantly larger vicinal coupling constant than cis-alkene protons. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the Karplus curve minimum: According to the Karplus equation, at what vicinal dihedral torsion angle $\phi$ is the three-bond $^3J_{\text{HH}}$ spin-spin coupling constant MINIMIZED (approaching near-zero, $0-2\text{ Hz}$)? (At $\phi \approx 90^\circ$ (perpendicular orthogonal dihedral angle), because when the two $\text{C}-\text{H}$ bonds are perpendicular to each other, orbital overlap between the intervening $\text{C}-\text{C}$ $\sigma$-bonds and the $\text{C}-\text{H}$ $\sigma$-bonds vanishes, preventing electron-mediated spin polarization transfer).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "spin_spin_coupling_and_karplus_equation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Spin-Spin Coupling and the Karplus Equation**\n• **First-Order $n+1$ Multiplicity Rule:**\n$$\n\\text{Multiplicity} = n + 1 \\qquad (\\text{Pascal intensities: } 1:1, \\ 1:2:1, \\ 1:3:3:1)\n$$\n• **Coupling Constant ($J$ in Hz):** True physical energy of magnetic interaction (independent of spectrometer field $B_0$).\n• **The Karplus Equation ($^3J_{\\text{HH}}$ vs Dihedral Angle $\\phi$):**\n$$\n^3J(\\phi) = A + B \\cos\\phi + C \\cos(2\\phi)\n$$\n  - **Anti-periplanar ($\\phi = 180^\\circ$):** Maximum coupling ($^3J \\approx 12 - 18\\text{ Hz}$).\n  - **Syn-periplanar ($\\phi = 0^\\circ$):** Intermediate coupling ($^3J \\approx 8 - 10\\text{ Hz}$).\n  - **Orthogonal ($\\phi \\approx 90^\\circ$):** Near-zero coupling ($^3J \\approx 0 - 2\\text{ Hz}$).\n• **Alkene Diagnosis:** $^3J_{\\text{trans}} (12 - 18\\text{ Hz}) > ^3J_{\\text{cis}} (6 - 12\\text{ Hz})$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the splitting tree steps constructing a doublet of doublets (dd) with J_1 = 12 Hz and J_2 = 4 Hz.",
      "orderItems": [
        "Position the central uncoupled chemical shift resonance line at delta ppm",
        "Apply the larger scalar coupling J_1 = 12 Hz to split the central peak into a symmetric 1:1 doublet",
        "Apply the smaller scalar coupling J_2 = 4 Hz to each doublet line to split both into twin sub-peaks",
        "Verify that all four resulting spectral transitions possess equal 1:1:1:1 peak intensities",
        "Confirm the resulting multiplet is a clean doublet of doublets (dd) with total span J_1 + J_2 = 16 Hz"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each proton geometric coupling arrangement to its typical J-value in Hz.",
      "matchPairs": [
        { "left": "Trans-Alkene Protons (phi = 180°)", "right": "J = 12 - 18 Hz (large vicinal coupling constant)" },
        { "left": "Cis-Alkene Protons (phi = 0°)", "right": "J = 6 - 12 Hz (medium vicinal coupling constant)" },
        { "left": "Cyclohexane Axial-Axial Protons (anti-periplanar)", "right": "J = 8 - 14 Hz (large diaxial coupling confirming chair conformation)" },
        { "left": "Orthogonal Protons (phi ≈ 90°)", "right": "J = 0 - 2 Hz (minimum of the Karplus curve)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In alkene stereochemistry, trans vicinal protons exhibit a significantly ___ 3J coupling constant than cis vicinal protons.",
      "blankAnswer": "larger",
      "blankDistractors": ["smaller", "negative", "zero"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "According to the Karplus equation, at what dihedral torsion angle phi between vicinal protons does the 3J_HH coupling constant drop to its MINIMUM (near 0 Hz)?",
      "options": [
        { "text": "phi ≈ 90° (perpendicular orthogonal geometry); because the C-H sigma bonds are orthogonal, there is zero orbital overlap with the central C-C bond, preventing electron-mediated spin communication between the two protons", "isCorrect": true, "explanation": "Correct! Spin-spin scalar coupling is mediated through the bonding electrons (Fermi contact interaction). At 90° dihedral angle, the orbital overlap between the C-H bonds and the intervening C-C sigma framework vanishes by symmetry, suppressing J to near zero (0-2 Hz)." },
        { "text": "phi = 180° (anti-periplanar)", "isCorrect": false, "explanation": "Incorrect: That is the MAXIMUM of the Karplus curve (12-18 Hz)." },
        { "text": "phi = 0° (syn-periplanar)", "isCorrect": false, "explanation": "Incorrect: That gives strong coupling (8-10 Hz)." },
        { "text": "phi = 360°", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
