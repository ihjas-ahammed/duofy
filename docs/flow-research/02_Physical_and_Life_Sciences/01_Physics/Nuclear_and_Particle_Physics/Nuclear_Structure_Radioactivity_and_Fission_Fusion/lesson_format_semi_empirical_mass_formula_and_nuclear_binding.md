# Duofy Reusable Lesson Format: Semi-Empirical Mass Formula and Nuclear Binding

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Nuclear_and_Particle_Physics / Nuclear_Structure_Radioactivity_and_Fission_Fusion`  
**Lesson Format Type:** `semi_empirical_mass_formula_and_nuclear_binding`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the Liquid Drop Model and binding energy systematics: evaluate nuclear radius $R = R_0 A^{1/3}$ ($R_0 \approx 1.2\text{ fm}$), formulate the **Bethe-Weizsäcker Semi-Empirical Mass Formula (SEMF)** including Volume ($a_v A$), Surface ($-a_s A^{2/3}$), Coulomb ($-a_c \frac{Z(Z-1)}{A^{1/3}}$), Asymmetry ($-a_a \frac{(A-2Z)^2}{A}$), and Pairing ($\pm \delta_0 A^{-3/4}$) terms, derive the Valley of Beta Stability $Z_{\text{stable}}(A)$, and analyze the binding energy per nucleon curve peaking at Iron-56 / Nickel-62.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | SEMF & Liquid Drop Model Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Derivation of Most Stable Isobar Z_stable Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | SEMF Energy Term & Physical Origin Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Nuclear Radius Mass Number Power Law Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Peak of Binding Energy per Nucleon Curve Physics Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Liquid Drop Model and the Bethe-Weizsäcker Semi-Empirical Mass Formula (Carl Friedrich von Weizsäcker 1935, Hans Bethe 1936):
   - **Nuclear Radius:** $R = R_0 A^{1/3}$, where $R_0 \approx 1.2\text{ fm}$ (Nuclear density $\rho_0 \approx 0.17\text{ nucleons/fm}^3 \approx 2.3 \times 10^{17}\text{ kg/m}^3$ is constant!).
   - **Total Nuclear Binding Energy $B(A, Z)$:**
     $$B(A, Z) = a_v A - a_s A^{2/3} - a_c \frac{Z(Z-1)}{A^{1/3}} - a_a \frac{(A - 2Z)^2}{A} + \delta(A, Z)$$
   - **Five Physical Terms:**
     1. **Volume Term ($a_v \approx 15.8\text{ MeV}$):** Strong nuclear attraction between nearest-neighbor nucleons.
     2. **Surface Term ($a_s \approx 18.3\text{ MeV}$):** Reduction for surface nucleons with fewer neighbors ($\propto 4\pi R^2 \propto A^{2/3}$).
     3. **Coulomb Term ($a_c \approx 0.71\text{ MeV}$):** Electrostatic repulsion between $Z$ protons ($\propto \frac{Z^2}{R} \propto \frac{Z^2}{A^{1/3}}$).
     4. **Asymmetry Term ($a_a \approx 23.2\text{ MeV}$):** Pauli exclusion principle penalizes neutron-proton imbalance $(N - Z)^2 = (A - 2Z)^2$.
     5. **Pairing Term ($\delta$):** $+a_p A^{-3/4}$ (even-even, most stable), $0$ (even-odd), $-a_p A^{-3/4}$ (odd-odd, least stable).
2. **Slide 2 (`ordering`):** Provide 5 steps finding the most stable isobar $Z_{\text{stable}}$ for a given mass number $A$: (1) express atomic mass as a function of $Z$ for fixed $A$: $M(A, Z) = Z m_p + (A-Z)m_n - B(A, Z)/c^2$, (2) substitute Coulomb and Asymmetry terms into mass formula: $M(A,Z) = \text{const} + (m_p - m_n)Z + \frac{a_c Z^2}{A^{1/3}} + \frac{a_a (A - 2Z)^2}{A}$, (3) differentiate $M(A, Z)$ with respect to $Z$ and set derivative to zero: $\frac{\partial M}{\partial Z} = 0$, (4) solve linear equation for $Z$: $(m_p - m_n) + \frac{2 a_c Z}{A^{1/3}} - \frac{4 a_a (A - 2Z)}{A} = 0$, (5) simplify to obtain the Valley of Beta Stability: $Z_{\text{stable}} = \frac{A}{2 + \frac{a_c}{2 a_a} A^{2/3}} \approx \frac{A}{2 + 0.015 A^{2/3}}$!
3. **Slide 3 (`matching`):** Pair 4 SEMF energy terms (Volume Term $+a_v A$, Surface Term $-a_s A^{2/3}$, Coulomb Term $-a_c Z^2/A^{1/3}$, Asymmetry Term $-a_a (A-2Z)^2/A$) with their underlying physical mechanisms.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that nuclear radius scales with mass number as A^(1/3). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the peak of the binding energy per nucleon curve: Why does the binding energy per nucleon curve ($B/A$) reach a maximum of $\approx 8.8\text{ MeV/nucleon}$ around Iron-56 / Nickel-62, dropping off for both lighter and heavier nuclei? (Lighter nuclei have a large surface-to-volume ratio which reduces binding via the surface term; heavier nuclei experience growing long-range Coulomb repulsion ($\propto Z^2$) which destabilizes the nucleus; Iron-56 sits at the optimal balance between nuclear attraction and Coulomb repulsion).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "semi_empirical_mass_formula_and_nuclear_binding",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Bethe-Weizsäcker Semi-Empirical Mass Formula (SEMF)**\n• **Nuclear Radius:** $R = R_0 A^{1/3}$ ($R_0 \\approx 1.2\\text{ fm}$, constant nuclear density).\n• **Binding Energy Formula $B(A, Z)$:**\n$$\nB(A, Z) = a_v A - a_s A^{2/3} - a_c \\frac{Z(Z-1)}{A^{1/3}} - a_a \\frac{(A - 2Z)^2}{A} + \\delta(A, Z)\n$$\n• **The 5 Physical Terms:**\n  - **Volume ($+a_v A$):** Bulk short-range strong nuclear attraction ($a_v \\approx 15.8\\text{ MeV}$).\n  - **Surface ($-a_s A^{2/3}$):** Deficit of neighbors for nucleons at the boundary.\n  - **Coulomb ($-a_c Z^2/A^{1/3}$):** Long-range electrostatic proton-proton repulsion.\n  - **Asymmetry ($-a_a (A-2Z)^2/A$):** Pauli exclusion penalty for $N \\ne Z$.\n  - **Pairing ($\\pm \\delta$):** Favors spin-paired proton and neutron pairs."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the calculus steps deriving the valley of beta stability Z_stable(A) from the SEMF.",
      "orderItems": [
        "Write atomic mass as a function of Z for a fixed mass number A: M(A, Z) = Z*m_p + (A-Z)*m_n - B(A, Z)/c^2",
        "Isolate the Z-dependent terms (Coulomb and Asymmetry terms) in the mass parabola equation",
        "Take the partial derivative of nuclear mass with respect to atomic number Z: dM/dZ",
        "Set the derivative to zero: dM/dZ = (m_p - m_n) + 2*a_c*Z / A^{1/3} - 4*a_a*(A - 2Z) / A = 0",
        "Solve the linear equation for Z to obtain the valley of beta stability: Z_stable = A / [ 2 + (a_c / (2 a_a)) * A^{2/3} ]"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each SEMF term to its underlying physical cause.",
      "matchPairs": [
        { "left": "Volume Term (+a_v * A)", "right": "Saturating short-range strong nuclear force among nearest neighbors" },
        { "left": "Surface Term (-a_s * A^{2/3})", "right": "Surface nucleons have fewer binding neighbors, scaling with surface area 4 pi R^2" },
        { "left": "Coulomb Term (-a_c * Z^2 / A^{1/3})", "right": "Long-range electrostatic repulsion between all pairs of Z protons" },
        { "left": "Asymmetry Term (-a_a * (N-Z)^2 / A)", "right": "Pauli exclusion principle forces excess identical nucleons into higher energy levels" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The nuclear radius R scales with nucleon mass number A as R = R_0 * A^(1/___).",
      "blankAnswer": "3",
      "blankDistractors": ["2", "4", "1"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the Binding Energy per Nucleon curve (B/A) peak at around 8.8 MeV/nucleon near Iron-56 (Fe-56) and decrease for heavier nuclei?",
      "options": [
        { "text": "For light nuclei, the large surface-to-volume ratio reduces binding (surface term); for heavy nuclei, the long-range electrostatic Coulomb repulsion between protons (which grows as Z²) overwhelms the short-range strong force, making Fe-56 the most thermodynamically stable nucleus", "isCorrect": true, "explanation": "Correct! Nuclear forces saturate (volume term ~ A), but Coulomb repulsion acts between all proton pairs (~ Z^2). For large A, the Coulomb energy term dominates the deficit, reducing B/A and enabling energy release through nuclear fission." },
        { "text": "Because iron is a magnetic metal", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because heavy nuclei have zero neutrons", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because light nuclei have no protons", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
