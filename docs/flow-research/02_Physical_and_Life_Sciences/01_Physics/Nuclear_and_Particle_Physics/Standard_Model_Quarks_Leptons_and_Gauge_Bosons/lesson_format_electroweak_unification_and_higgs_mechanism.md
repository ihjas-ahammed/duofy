# Duofy Reusable Lesson Format: Electroweak Unification and the Higgs Mechanism

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Nuclear_and_Particle_Physics / Standard_Model_Quarks_Leptons_and_Gauge_Bosons`  
**Lesson Format Type:** `electroweak_unification_and_higgs_mechanism`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through Glashow-Weinberg-Salam (GWS) Electroweak Unification: formulate the **Complex Scalar Higgs Doublet $\Phi$** with Mexican-hat potential $V(\Phi) = -\mu^2 \Phi^\dagger\Phi + \lambda(\Phi^\dagger\Phi)^2$, derive **Spontaneous Symmetry Breaking ($SU(2)_L \times U(1)_Y \to U(1)_{\text{EM}}$)** with vacuum expectation value (VEV) $v = \sqrt{\mu^2/\lambda} \approx 246\text{ GeV}$, show how the 3 Goldstone bosons become the longitudinal polarization states of **$W^\pm$ and $Z^0$**, derive the **Weinberg Mixing Angle $\theta_W$ ($M_W = M_Z \cos\theta_W$)**, calculate the physical **Higgs Boson mass ($m_H = \sqrt{2\lambda}v \approx 125\text{ GeV}$)**, and evaluate **Yukawa Couplings ($m_f = y_f \frac{v}{\sqrt{2}}$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Electroweak Unification & Higgs Mechanism Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Gauge Boson Mass Generation Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Electroweak Entity & Physical Mass / Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Higgs Vacuum Expectation Value Symbol Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Massless Photon Origin after Symmetry Breaking Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Electroweak Unification (Sheldon Glashow, Steven Weinberg, Abdus Salam, Nobel Prize 1979) and the Brout-Englert-Higgs Mechanism (1964):
   - **Complex Scalar Higgs Doublet:** $\Phi = \frac{1}{\sqrt{2}}\begin{pmatrix} \phi^+ \\ \phi^0 \end{pmatrix}$.
   - **The Higgs Potential:**
     $$V(\Phi) = -\mu^2 (\Phi^\dagger \Phi) + \lambda (\Phi^\dagger \Phi)^2 \qquad (\mu^2 > 0, \lambda > 0)$$
   - **Vacuum Expectation Value (VEV):**
     $$\langle \Phi \rangle_0 = \frac{1}{\sqrt{2}} \begin{pmatrix} 0 \\ v \end{pmatrix}, \qquad v = \sqrt{\frac{\mu^2}{\lambda}} = \frac{2 M_W}{g} \approx 246.2\text{ GeV}$$
   - **Spontaneous Symmetry Breaking:** $SU(2)_L \times U(1)_Y \longrightarrow U(1)_{\text{EM}}$.
   - **Gauge Boson Masses:**
     $$M_W = \frac{1}{2} g v \approx 80.4\text{ GeV}, \qquad M_Z = \frac{1}{2} \sqrt{g^2 + g'^2} \, v = \frac{M_W}{\cos\theta_W} \approx 91.2\text{ GeV}, \qquad M_\gamma = 0$$
   - **Higgs Boson Mass:** $m_H = \sqrt{2\lambda} v \approx 125.1\text{ GeV}$ (Discovered at CERN LHC, 2012).
2. **Slide 2 (`ordering`):** Provide 5 steps deriving gauge boson masses from the covariant kinetic term $|D_\mu \Phi|^2$: (1) write covariant derivative for $SU(2)_L \times U(1)_Y$: $D_\mu \Phi = (\partial_\mu - i g \frac{\boldsymbol{\tau}\cdot\mathbf{W}_\mu}{2} - i g' \frac{Y}{2} B_\mu)\Phi$, (2) evaluate at the vacuum ground state in unitary gauge $\Phi_0 = \frac{1}{\sqrt{2}}\begin{pmatrix} 0 \\ v \end{pmatrix}$, (3) expand the kinetic term $|D_\mu \Phi_0|^2 = \frac{1}{8} v^2 [g^2 (W_\mu^1)^2 + g^2 (W_\mu^2)^2 + (-g W_\mu^3 + g' B_\mu)^2]$, (4) identify charged $W$-boson mass terms: $\frac{1}{4} g^2 v^2 W_\mu^+ W^{-\mu} \implies M_W = \frac{1}{2} g v$, (5) define orthogonal neutral mixtures $Z_\mu = \cos\theta_W W_\mu^3 - \sin\theta_W B_\mu$ (giving mass $M_Z = \frac{1}{2}\sqrt{g^2+g'^2}v$) and $A_\mu = \sin\theta_W W_\mu^3 + \cos\theta_W B_\mu$ (giving photon mass $M_\gamma = 0$)!
3. **Slide 3 (`matching`):** Pair 4 electroweak parameters ($M_W$, $M_Z$, $M_\gamma$, $v$) with their experimental values and formulas.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the vacuum expectation value (VEV) of the Higgs field equals approximately 246 GeV. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why the Photon remains exactly massless after electroweak symmetry breaking: Why does the photon $\gamma$ have zero mass while $W^\pm$ and $Z^0$ acquire massive values? (Because the electric charge generator $Q = I_3 + \frac{Y}{2}$ annihilates the vacuum ground state: $Q \langle \Phi \rangle_0 = 0$; therefore, the $U(1)_{\text{EM}}$ gauge symmetry remains UNBROKEN, preserving a massless gauge boson).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "electroweak_unification_and_higgs_mechanism",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Electroweak Unification and the Higgs Mechanism**\n• **The Higgs Potential:**\n$$\nV(\\Phi) = -\\mu^2 (\\Phi^\\dagger \\Phi) + \\lambda (\\Phi^\\dagger \\Phi)^2, \\qquad v = \\sqrt{\\frac{\\mu^2}{\\lambda}} \\approx 246.2\\text{ GeV}\n$$\n• **Spontaneous Symmetry Breaking:** $SU(2)_L \\times U(1)_Y \\longrightarrow U(1)_{EM}$.\n• **Gauge Boson Masses from Kinetic Term $|D_\\mu \\Phi|^2$:**\n$$\nM_W = \\frac{1}{2} g v \\approx 80.4\\text{ GeV}, \\qquad M_Z = \\frac{M_W}{\\cos\\theta_W} \\approx 91.2\\text{ GeV}, \\qquad M_\\gamma = 0\n$$\n• **The Physical Higgs Boson:** $m_H = \\sqrt{2\\lambda} v \\approx 125.1\\text{ GeV}$ (Discovered at CERN, 2012).\n• **Fermion Masses via Yukawa Couplings:** $m_f = y_f \\frac{v}{\\sqrt{2}}$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the gauge field steps deriving the W, Z, and photon masses from the Higgs kinetic term |D_mu Phi|^2.",
      "orderItems": [
        "Construct the electroweak covariant derivative: D_mu = d_mu - i*g*(tau . W_mu)/2 - i*g'*(Y/2)*B_mu",
        "Evaluate the kinetic term |D_mu Phi|^2 on the vacuum expectation value Phi_0 = (1 / sqrt(2)) * [0; v]",
        "Expand the matrix product to isolate quadratic gauge boson mass terms: (1/8) v^2 [ g^2 (W_1^2 + W_2^2) + (-g W_3 + g' B)^2 ]",
        "Identify the charged W-boson mass term: M_W = (1/2) * g * v",
        "Diagonalize the neutral gauge sector into a massive linear combination Z_mu with M_Z = (1/2) sqrt(g^2 + g'^2) v and an orthogonal massless photon A_mu with M_gamma = 0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each electroweak parameter to its formula and experimental value.",
      "matchPairs": [
        { "left": "W Boson Mass M_W", "right": "M_W = (1/2) * g * v ≈ 80.38 GeV" },
        { "left": "Z Boson Mass M_Z", "right": "M_Z = M_W / cos(theta_W) ≈ 91.19 GeV" },
        { "left": "Higgs VEV (Vacuum Expectation Value) v", "right": "v = 1 / sqrt(sqrt(2) * G_F) ≈ 246.2 GeV" },
        { "left": "Photon Mass M_gamma", "right": "M_gamma = 0 (preserved by unbroken U(1)_EM gauge symmetry)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The vacuum expectation value (VEV) v of the Higgs field in the Standard Model equals approximately ___ GeV (round to whole number).",
      "blankAnswer": "246",
      "blankDistractors": ["125", "80", "91"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the Photon (gamma) remain STRICTLY MASSLESS after spontaneous electroweak symmetry breaking, while W and Z bosons acquire large masses?",
      "options": [
        { "text": "Because the electric charge generator Q = I_3 + Y/2 annihilates the Higgs vacuum state (Q |Phi_0> = 0); therefore, the U(1)_EM electromagnetic gauge symmetry remains EXACTLY UNBROKEN", "isCorrect": true, "explanation": "Correct! Spontaneous symmetry breaking breaks 3 of the 4 generators of SU(2)_L x U(1)_Y, giving mass to W+, W-, and Z0. The linear combination corresponding to electric charge Q leaves the vacuum invariant (Q Phi_0 = 0), leaving U(1)_EM unbroken and the photon strictly massless." },
        { "text": "Because photons have no energy", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the Higgs boson cannot couple to light", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the speed of light is infinite", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
