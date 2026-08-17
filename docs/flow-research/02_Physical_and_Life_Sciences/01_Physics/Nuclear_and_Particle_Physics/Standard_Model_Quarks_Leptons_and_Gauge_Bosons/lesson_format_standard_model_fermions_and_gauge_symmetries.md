# Duofy Reusable Lesson Format: Standard Model Fermions and Gauge Symmetries

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Nuclear_and_Particle_Physics / Standard_Model_Quarks_Leptons_and_Gauge_Bosons`  
**Lesson Format Type:** `standard_model_fermions_and_gauge_symmetries`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the particle zoo and gauge structure of the Standard Model: classify the **3 Generations of Fermions (6 Quarks and 6 Leptons)**, identify electric charges ($+2/3, -1/3, -1, 0$), analyze the **12 Vector Gauge Bosons** ($8\text{ Gluons}, 1\text{ Photon}, W^+, W^-, Z^0$), formulate the **Gauge Group $SU(3)_C \times SU(2)_L \times U(1)_Y$**, evaluate the **Weak Hypercharge Formula ($Q = I_3 + \frac{Y}{2}$)**, and verify conservation laws (Baryon number $B$, Lepton flavor numbers $L_e, L_\mu, L_\tau$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Standard Model Particle Content & Gauge Group Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Weak Hypercharge Y Calculation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Fundamental Particle & Quantum Number / Interaction Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Up-Type Quark Electric Charge Fraction Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Lepton Flavor Conservation in Muon Decay Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Structure of the Standard Model:
   - **Local Gauge Group:** $SU(3)_C \times SU(2)_L \times U(1)_Y$.
   - **Fermions (3 Generations of Spin-1/2 Matter):**
     - **Quarks (Carry Color & Fractional Charge):**
       $$\text{Gen 1: } \begin{pmatrix} u \\ d \end{pmatrix} \quad \text{Gen 2: } \begin{pmatrix} c \\ s \end{pmatrix} \quad \text{Gen 3: } \begin{pmatrix} t \\ b \end{pmatrix} \qquad (Q_u, Q_c, Q_t = +2/3 e, \quad Q_d, Q_s, Q_b = -1/3 e)$$
     - **Leptons (Colorless):**
       $$\text{Gen 1: } \begin{pmatrix} \nu_e \\ e^- \end{pmatrix} \quad \text{Gen 2: } \begin{pmatrix} \nu_\mu \\ \mu^- \end{pmatrix} \quad \text{Gen 3: } \begin{pmatrix} \nu_\tau \\ \tau^- \end{pmatrix} \qquad (Q = 0, -1 e)$$
   - **Gauge Bosons (Spin-1 Force Carriers):**
     - $SU(3)_C \implies 8$ Gluons (Strong Force).
     - $SU(2)_L \implies W^1, W^2, W^3 \to W^\pm, Z^0$ (Weak Force).
     - $U(1)_Y \implies B^0 \to \gamma, Z^0$ (Electromagnetism & Neutral Weak).
   - **Weak Hypercharge Formula:** $Q = I_3 + \frac{Y}{2} \implies Y = 2(Q - I_3)$.
2. **Slide 2 (`ordering`):** Provide 5 steps finding the weak hypercharge $Y$ for left-handed and right-handed quarks: (1) write Gell-Mann-Nishijima relation for electroweak: $Q = I_3 + \frac{Y}{2}$, (2) isolate weak hypercharge: $Y = 2(Q - I_3)$, (3) for left-handed up-quark $u_L$, weak isospin is $I_3 = +1/2$ and $Q = +2/3$: $Y(u_L) = 2(2/3 - 1/2) = 2(1/6) = +1/3$, (4) for left-handed down-quark $d_L$, $I_3 = -1/2$ and $Q = -1/3$: $Y(d_L) = 2(-1/3 - (-1/2)) = 2(1/6) = +1/3$ (same $Y$ for doublet!), (5) for right-handed singlet $u_R$, weak isospin is $I_3 = 0 \implies Y(u_R) = 2(2/3 - 0) = +4/3$!
3. **Slide 3 (`matching`):** Pair 4 fundamental particles (Top Quark $t$, Gluon $g$, $W^+$ Boson, Neutrino $\nu$) with their physical properties.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that up-type quarks (u, c, t) carry an electric charge of +2/3 e. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on lepton family number conservation: In the decay of a muon $\mu^- \to e^- + \bar{\nu}_e + \nu_\mu$, why are TWO neutrinos emitted instead of one? (Because both electron lepton number $L_e$ and muon lepton number $L_\mu$ must be separately conserved; initially $L_\mu = +1, L_e = 0$; after decay, electron ($L_e = +1$) requires an electron antineutrino ($L_e = -1$) to give net $L_e = 0$, while a muon neutrino ($L_\mu = +1$) preserves $L_\mu = +1$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "standard_model_fermions_and_gauge_symmetries",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Standard Model Particle Content and Symmetries**\n• **Gauge Symmetry Group:** $SU(3)_C \\times SU(2)_L \\times U(1)_Y$.\n• **12 Fundamental Fermions (Spin-1/2 Matter):**\n  - **6 Quarks:** $(u, c, t)$ with $Q = +2/3e$; $(d, s, b)$ with $Q = -1/3e$ (carry color $R, G, B$).\n  - **6 Leptons:** $(e^-, \\mu^-, \\tau^-)$ with $Q = -1e$; $(\\nu_e, \\nu_\\mu, \\nu_\\tau)$ with $Q = 0$.\n• **12 Gauge Bosons (Spin-1 Force Carriers):**\n  - **8 Gluons ($g$):** $SU(3)_C$ Strong force (Color charge).\n  - **$\\mathbf{W^\\pm, Z^0}$ Bosons:** $SU(2)_L \\times U(1)_Y$ Weak force ($M_W \\approx 80.4\\text{ GeV}, M_Z \\approx 91.2\\text{ GeV}$).\n  - **1 Photon ($\\gamma$):** $U(1)_{EM}$ Electromagnetism ($m = 0$).\n• **Weak Hypercharge Formula:** $Q = I_3 + \\frac{Y}{2}$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the electroweak algebra steps calculating weak hypercharge Y = 2(Q - I_3) for quarks.",
      "orderItems": [
        "Recall the electroweak Gell-Mann-Nishijima relation: Q = I_3 + Y / 2",
        "Rearrange to solve for weak hypercharge: Y = 2 * (Q - I_3)",
        "Identify left-handed doublet (u_L, d_L) with weak isospin I = 1/2 and I_3 = +1/2 for u_L",
        "Evaluate hypercharge for left-handed up quark: Y(u_L) = 2 * (+2/3 - 1/2) = 2 * (1/6) = +1/3",
        "Evaluate right-handed singlet u_R with I_3 = 0: Y(u_R) = 2 * (+2/3 - 0) = +4/3"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each particle to its defining Standard Model properties.",
      "matchPairs": [
        { "left": "Top Quark (t)", "right": "Heaviest known elementary particle (mass ≈ 173 GeV), decays before hadronizing" },
        { "left": "Gluon (g)", "right": "Massless spin-1 mediator carrying simultaneous color and anticolor charges" },
        { "left": "W+ / W- Bosons", "right": "Charged weak force mediators (mass ≈ 80.4 GeV) coupling only to left-handed fermions" },
        { "left": "Neutrino (nu)", "right": "Color-neutral, electrically neutral lepton experiencing only the weak interaction and gravity" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Standard Model, up-type quarks (up, charm, top) possess a fractional electric charge of +___ / 3 e.",
      "blankAnswer": "2",
      "blankDistractors": ["1", "4", "3"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the decay of a negative muon (mu- -> e- + anti-nu_e + nu_mu) produce TWO neutrinos instead of just one?",
      "options": [
        { "text": "To simultaneously conserve both ELECTRON LEPTON NUMBER (L_e = 0 initially -> +1 for e- and -1 for anti-nu_e) and MUON LEPTON NUMBER (L_mu = +1 initially -> +1 for nu_mu)", "isCorrect": true, "explanation": "Correct! In the Standard Model, lepton family numbers L_e, L_mu, L_tau are conserved in weak decays. The initial state has L_mu = 1, L_e = 0. The final state has e- (L_e = +1), anti-nu_e (L_e = -1), and nu_mu (L_mu = +1), conserving all lepton flavor numbers." },
        { "text": "Because neutrinos must always travel in pairs", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because muons have twice the electric charge of electrons", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "To conserve baryon number", "isCorrect": false, "explanation": "Incorrect: Muons and electrons are leptons, not baryons." }
      ]
    }
  ]
}
```
