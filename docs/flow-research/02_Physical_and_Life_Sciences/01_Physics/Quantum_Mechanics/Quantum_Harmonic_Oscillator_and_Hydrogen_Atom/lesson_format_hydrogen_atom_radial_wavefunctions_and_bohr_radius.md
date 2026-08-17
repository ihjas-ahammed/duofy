# Duofy Reusable Lesson Format: Hydrogen Atom Radial Wavefunctions and Bohr Radius

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Quantum_Mechanics / Quantum_Harmonic_Oscillator_and_Hydrogen_Atom`  
**Lesson Format Type:** `hydrogen_atom_radial_wavefunctions_and_bohr_radius`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the radial solution of the Coulomb potential $V(r) = -\frac{e^2}{4\pi\epsilon_0 r}$: formulate the **Effective Potential ($V_{\text{eff}}(r) = -\frac{e^2}{4\pi\epsilon_0 r} + \frac{\hbar^2 l(l+1)}{2mr^2}$)** with centrifugal barrier, define the **Bohr Radius ($a_0 \equiv \frac{4\pi\epsilon_0 \hbar^2}{m_e e^2} \approx 0.529\text{ Å}$)**, derive the ground state radial wavefunction $R_{10}(r) = 2 a_0^{-3/2} e^{-r/a_0}$, formulate the **Associated Laguerre Polynomial Solutions ($R_{nl}(r)$)** with $n-l-1$ radial nodes, and calculate the radial probability density $P(r) = r^2 |R_{nl}(r)|^2$ and most probable radius $r_{\text{max}} = a_0$ for the 1s orbital.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hydrogen Radial Wavefunction & Bohr Radius Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step 1s Most Probable Radius Maxima Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Hydrogen State |nlm> & Radial Node Count Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Radial Wavefunction Node Count Formula Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Radial Probability Density r^2 Weighting Volume Element Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Radial Solution of the Hydrogen Atom (Erwin Schrödinger, 1926):
   - **Radial Schrödinger Equation:**
     $$\left[ -\frac{\hbar^2}{2m}\frac{d^2}{dr^2} + V_{\text{eff}}(r) \right] u_{nl}(r) = E_n u_{nl}(r), \qquad u_{nl}(r) \equiv r R_{nl}(r)$$
   - **Effective Potential (Coulomb Attraction + Centrifugal Repulsion):**
     $$V_{\text{eff}}(r) = -\frac{e^2}{4\pi\epsilon_0 r} + \frac{\hbar^2 l(l+1)}{2m r^2}$$
   - **The Bohr Radius (Natural Atomic Length Scale):**
     $$a_0 \equiv \frac{4\pi\epsilon_0 \hbar^2}{m_e e^2} = 0.529177\text{ Å} = 0.0529\text{ nm}$$
   - **Exact Radial Wavefunctions (Associated Laguerre Polynomials):**
     $$R_{nl}(r) = -\sqrt{\left(\frac{2}{n a_0}\right)^3 \frac{(n-l-1)!}{2n [(n+l)!]^3}} e^{-r / (n a_0)} \left( \frac{2r}{n a_0} \right)^l L_{n-l-1}^{2l+1}\left(\frac{2r}{n a_0}\right)$$
     - **Radial Node Count:** Exactly $n - l - 1$ nodes!
     - **1s Ground State:** $R_{10}(r) = 2 a_0^{-3/2} e^{-r / a_0}$.
     - **2s State ($1$ radial node):** $R_{20}(r) = \frac{1}{\sqrt{2}} a_0^{-3/2} \left(1 - \frac{r}{2a_0}\right) e^{-r / (2a_0)}$.
     - **2p State ($0$ radial nodes):** $R_{21}(r) = \frac{1}{\sqrt{24}} a_0^{-3/2} \frac{r}{a_0} e^{-r / (2a_0)}$.
2. **Slide 2 (`ordering`):** Provide 5 steps finding the most probable distance $r_{\text{max}}$ for an electron in the 1s state: (1) write radial probability density: $P(r) = r^2 |R_{10}(r)|^2 = r^2 \left(4 a_0^{-3} e^{-2r/a_0}\right) = \frac{4}{a_0^3} r^2 e^{-2r/a_0}$, (2) take the first derivative with respect to $r$: $\frac{dP}{dr} = \frac{4}{a_0^3} \left[ 2r e^{-2r/a_0} - \frac{2}{a_0} r^2 e^{-2r/a_0} \right]$, (3) set the derivative equal to zero to find the local maximum: $\frac{dP}{dr} = 0$, (4) factor out non-zero terms: $\frac{8r}{a_0^3} e^{-2r/a_0} \left( 1 - \frac{r}{a_0} \right) = 0$, (5) discard trivial boundary roots $r = 0, \infty$ to conclude that the peak occurs at $r_{\text{max}} = a_0$ (The Bohr radius!)!
3. **Slide 3 (`matching`):** Pair 4 hydrogen states ($1s$ ($n=1, l=0$), $2s$ ($n=2, l=0$), $2p$ ($n=2, l=1$), $3d$ ($n=3, l=2$)) with their radial node counts ($0$, $1$, $0$, $0$).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the number of radial nodes in an atomic hydrogen orbital is n - l - 1. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the physical difference between probability density $|\psi(\mathbf{r})|^2$ and radial probability density $P(r) = r^2 |R_{nl}(r)|^2$: Where is the 1s electron most likely to be found per unit volume vs within a thin spherical shell of radius $r$? (Per unit volume ($d^3r$), the probability density $|\psi_{100}|^2 \propto e^{-2r/a_0}$ is MAXIMUM at the nucleus ($r = 0$); however, in a spherical shell of thickness $dr$, the volume element $4\pi r^2 dr$ vanishes at the origin, shifting the radial probability peak to $r_{\text{max}} = a_0$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hydrogen_atom_radial_wavefunctions_and_bohr_radius",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Hydrogen Radial Wavefunctions and the Bohr Radius**\n• **Effective Radial Potential:**\n$$\nV_{\\text{eff}}(r) = -\\frac{e^2}{4\\pi\\epsilon_0 r} + \\frac{\\hbar^2 l(l+1)}{2m r^2}\n$$\n• **The Bohr Radius (Atomic Scale):** $a_0 \\equiv \\frac{4\\pi\\epsilon_0 \\hbar^2}{m_e e^2} \\approx 0.529177\\text{ Å} = 0.0529\\text{ nm}$.\n• **Radial Solutions (Associated Laguerre Polynomials):**\n$$\nR_{nl}(r) \\propto e^{-r / (n a_0)} \\left( \\frac{2r}{n a_0} \\right)^l L_{n-l-1}^{2l+1}\\left( \\frac{2r}{n a_0} \\right)\n$$\n  - **Radial Node Count:** Exactly $N_{\\text{radial}} = n - l - 1$ real nodes!\n• **1s Ground State:** $R_{10}(r) = 2 a_0^{-3/2} e^{-r / a_0}$.\n• **Radial Probability in Spherical Shell:** $P(r) dr = r^2 |R_{nl}(r)|^2 dr$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the calculus steps finding the most probable radius r_max for an electron in the 1s ground state.",
      "orderItems": [
        "Construct the radial probability density function: P(r) = r^2 * |R_10(r)|^2 = (4 / a_0^3) * r^2 * exp(-2r / a_0)",
        "Differentiate P(r) with respect to radius r using the product rule: dP/dr",
        "Compute the derivative: dP/dr = (4 / a_0^3) * [ 2r - (2/a_0) r^2 ] * exp(-2r / a_0)",
        "Set dP/dr = 0 and factor the common polynomial term: (8r / a_0^3) * (1 - r / a_0) * exp(-2r / a_0) = 0",
        "Solve for the non-trivial maximum root to discover the peak probability at r_max = a_0 (the exact Bohr radius!)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each hydrogen orbital state to its radial node count N_rad = n - l - 1.",
      "matchPairs": [
        { "left": "1s State (n=1, l=0)", "right": "0 radial nodes (monotonic exponential decay)" },
        { "left": "2s State (n=2, l=0)", "right": "1 radial node at r = 2 a_0" },
        { "left": "2p State (n=2, l=1)", "right": "0 radial nodes (r * exp(-r/2a_0) profile)" },
        { "left": "3s State (n=3, l=0)", "right": "2 radial nodes" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The number of radial nodes in a hydrogenic atomic orbital characterized by quantum numbers n and l equals n - l - ___.",
      "blankAnswer": "1",
      "blankDistractors": ["2", "0", "1/2"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Where is an electron in the 1s ground state of hydrogen MOST LIKELY to be found per unit volume dV vs within a thin radial shell 4 pi r² dr?",
      "options": [
        { "text": "Per unit volume, probability density |psi_100|² is MAXIMUM at the nucleus (r = 0); but within a spherical shell, the geometric area factor 4 pi r² pushes the radial probability density P(r) = r² |R|² maximum to r = a_0 (the Bohr radius)", "isCorrect": true, "explanation": "Correct! |psi_100(r)|^2 = (1/pi a_0^3) e^{-2r/a_0} has its maximum at r = 0. However, the volume element in spherical coordinates is dV = 4 pi r^2 dr. The product P(r) = 4 pi r^2 |psi|^2 is 0 at the origin and reaches its maximum at exactly r = a_0." },
        { "text": "Both maxima occur at infinity", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Both maxima occur at r = 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Both maxima occur at r = 2 a_0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
