# Duofy Reusable Lesson Format: Powder Regimes (Geldart Particle Classification)

**Target Topic:** `04_Engineering_and_Technology / 04_Chemical_Engineering / Fluid_Flow_and_Particle_Mechanics / Fluidization_and_Packed_Beds`  
**Lesson Format Type:** `geldart_powder_classification_and_fluidization_regimes`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the hydrodynamic behavior of industrial powders fluidized by gas, Derek Geldart's seminal 1973 **Geldart Classification of Powders (Groups A, B, C, and D)** based on mean particle diameter ($d_p$) and solid-gas density difference ($\rho_p - \rho_g$), the physical mechanisms of bubbling versus non-bubbling expansion, minimum bubbling velocity ($u_{\text{mb}}$), minimum fluidization velocity ($u_{\text{mf}}$), slugging, channeling, and spouting flow patterns (Derek Geldart 1973; Daizo Kunii, Octave Levenspiel *Fluidization Engineering* Chapter 3): formulate the **Geldart Powder Classification Master Regimes Matrix**:
$$\begin{array}{|l|c|c|c|l|}
\hline
\textbf{Geldart Group} & \textbf{Particle Size } d_p & \textbf{Solid Density } \rho_p & \textbf{Bubbling Criterion} & \textbf{Hydrodynamic Behavior \& Industrial Examples} \\
\hline
\mathbf{\text{Group A (Aeratable)}} & \mathbf{30 - 100\text{ }\mu\text{m}} & \mathbf{\rho_p < 1400\text{ kg/m}^3} & \mathbf{u_{\text{mb}} > u_{\text{mf}}} & \mathbf{\text{Bed expands smoothly (non-bubbling) before bubbles appear; FCC catalysts}} \\
\mathbf{\text{Group B (Sand-like)}} & \mathbf{100 - 800\text{ }\mu\text{m}} & \mathbf{1400 - 4000\text{ kg/m}^3} & \mathbf{u_{\text{mb}} = u_{\text{mf}}} & \mathbf{\text{Bubbles form immediately at incipient fluidization; glass beads, silica sand}} \\
\mathbf{\text{Group C (Cohesive)}} & \mathbf{d_p < 30\text{ }\mu\text{m}} & \text{Any Density} & \text{Channeling} & \mathbf{\text{Inter-particle Van der Waals forces dominate; gas channels without fluidizing}} \\
\mathbf{\text{Group D (Spoutable)}} & \mathbf{d_p > 1000\text{ }\mu\text{m}} & \text{Dense Particles} & \text{Spouting / Jetting} & \mathbf{\text{Coarse grains, roasted coffee beans; forms central spouting eruptive jet}} \\
\hline
\end{array}$$
master the **Minimum Bubbling Velocity Formulation ($u_{\text{mb}}$ for Group A)**:
$$\mathbf{u_{\text{mb}} = 33 \cdot d_p \left( \frac{\rho_g^{0.06}}{\mu^{0.10}} \right) \Longleftrightarrow \mathbf{u_{\text{mb}} > u_{\text{mf}} \quad (\text{Enforces Stable Particulate Expansion Region})}}$$
(proving why fluid catalytic cracking units exclusively utilize Geldart Group A microspheres ($\approx 60-75\text{ }\mu\text{m}$) to maximize catalyst-gas contact area and suppress gas bubble bypassing).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Geldart Classification (A, B, C, D), Bubbling Thresholds ($u_{\text{mb}} > u_{\text{mf}}$) & Cohesive Forces Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Classify an Industrial Powder into Geldart Groups A-D and Predict Bed Dynamics Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Geldart Powder Group / Fluidization Regime & Technical Flow Characterization Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Geldart's Classification, Powders in Group A Expand Smoothly Without Bubbles in the Velocity Range Between $u_{\text{mf}}$ and the Minimum ___ Velocity $u_{\text{mb}}$ (Bubbling / Bubble) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Powder Technology Problem: Classifying FCC Catalyst, Silica Sand, and Ultrafine Flour into Geldart Groups Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Geldart Powder Classification Mechanics (Geldart 1973; Kunii & Levenspiel 1991):
   - **Classification Formulations:**
     $$\mathbf{\text{Group A: } u_{\text{mb}} > u_{\text{mf}} \quad \Big| \quad \text{Group B: } u_{\text{mb}} = u_{\text{mf}} \quad \Big| \quad \text{Group C: } F_{\text{cohesion}} \gg F_{\text{gravity}} \quad \Big| \quad \text{Group D: } d_p > 1\text{ mm}}$$
   - **Geldart 4-Group Summary Matrix:**
     $$\begin{array}{|l|c|l|}
     \hline
     \textbf{Group Identifier} & \textbf{Key Physical Property} & \textbf{Hydrodynamic State During Gas Injection} \\
     \hline
     \mathbf{\text{Group A (Aeratable)}} & \mathbf{30 - 100\text{ }\mu\text{m}, \text{ Low Density}} & \mathbf{\text{Smooth particulate bed expansion before bubbling }} (u_{\text{mb}} > u_{\text{mf}}) \\
     \mathbf{\text{Group B (Bubbling)}} & \mathbf{100 - 800\text{ }\mu\text{m}, \text{ Sand-like}} & \mathbf{\text{Bubbles appear instantaneously at minimum fluidization }} (u_{\text{mb}} = u_{\text{mf}}) \\
     \mathbf{\text{Group C (Cohesive)}} & \mathbf{< 30\text{ }\mu\text{m}, \text{ Ultrafine}} & \mathbf{\text{Severe gas channeling, rat-holing, non-fluidizable without vibration}} \\
     \mathbf{\text{Group D (Spoutable)}} & \mathbf{> 1000\text{ }\mu\text{m}, \text{ Coarse Grains}} & \mathbf{\text{Spouting eruptive jets, high gas bypassing, deep bed slugging}} \\
     \hline
     \end{array}$$
   - **The Group A Aeration Invariant:** Only Group A powders possess a **stable non-bubbling expansion window ($u_{\text{mf}} < u_0 < u_{\text{mb}}$)**, enabling fluid catalytic cracking reactors to maintain exceptional liquid-like gas-solid contact!
2. **Slide 2 (`ordering`):** Provide 5 steps of powder classification: (1) measure mean particle diameter $d_p$ and particle solid density $\rho_p$, (2) compute density difference $\Delta\rho = \rho_p - \rho_g$, (3) locate point $(d_p, \Delta\rho)$ on the standard Geldart diagram, (4) evaluate bubbling threshold ($u_{\text{mb}} > u_{\text{mf}}$ for Group A vs $u_{\text{mb}} = u_{\text{mf}}$ for Group B), (5) select appropriate bed operating strategy (e.g. acoustic/mechanical vibration for Group C, spouted bed geometry for Group D)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Group A Aeratable, Group B Bubbling, Group C Cohesive, Group D Spoutable) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Bubbling (or Bubble). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on classifying powders: A fluid catalytic cracking (FCC) zeolite catalyst has mean particle diameter $d_p = 65.0\text{ }\mu\text{m}$ and particle density $\rho_p = 1000.0\text{ kg/m}^3$ fluidized by air ($\rho_g = 1.2\text{ kg/m}^3$).
   - Particle diameter: $65\text{ }\mu\text{m}$ falls in the $30 - 100\text{ }\mu\text{m}$ range;
   - Density: $\rho_p = 1000\text{ kg/m}^3 < 1400\text{ kg/m}^3$;
   - Bubbling behavior: The bed expands smoothly and uniformly above $u_{\text{mf}}$ before bubbles start forming at $u_{\text{mb}} > u_{\text{mf}}$;
   - To which Geldart group does this FCC catalyst belong? (**Geldart Group A (Aeratable)**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "geldart_powder_classification_and_fluidization_regimes",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Powder Classification \\& Fluidization Regimes (Derek Geldart 1973)**\n• **Geldart's Four Fluidization Regimes:**\n  - **Group A (Aeratable):** $d_p \\approx 30 - 100\\text{ }\\mu\\text{m}, \\ \\rho_p < 1400\\text{ kg/m}^3$. $\\mathbf{u_{\\text{mb}} > u_{\\text{mf}}}$; bed exhibits a distinct smooth, non-bubbling expansion zone before bubbles appear (FCC catalysts);\n  - **Group B (Sand-like / Bubbling):** $d_p \\approx 100 - 800\\text{ }\\mu\\text{m}, \\ \\rho_p \\approx 1400 - 4000\\text{ kg/m}^3$. $\\mathbf{u_{\\text{mb}} = u_{\\text{mf}}}$; bubbles form immediately upon fluidization;\n  - **Group C (Cohesive / Ultrafine):** $d_p < 30\\text{ }\\mu\\text{m}$. Van der Waals attractive forces overpower hydrodynamic drag, causing severe **gas channeling and rat-holing**;\n  - **Group D (Spoutable / Coarse):** $d_p > 1000\\text{ }\\mu\\text{m}$. Coarse grains requiring deep spouting eruptive gas jets;\n• **The Group A Aeration Invariant:** Only Group A powders possess a **stable non-bubbling expansion window ($u_{\\text{mf}} < u_0 < u_{\\text{mb}}$)**, providing exceptional catalyst-gas interfacial contact in refinery FCC units!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to classify an industrial particulate material into its proper Geldart powder group.",
      "orderItems": [
        "Measure the volume-surface mean particle diameter dp (in \u03bcm) and particle skeletal density \u03c1p (in kg/m^3)",
        "Determine the solid-gas density difference: \u0394\u03c1 = \u03c1p - \u03c1g",
        "Plot coordinates (dp, \u0394\u03c1) on the empirical Geldart fluidization classification chart",
        "Determine the bubbling threshold: evaluate if umb > umf (Group A) or umb = umf (Group B)",
        "Identify potential operational challenges (e.g. channel formation in Group C or slugging/spouting in Group D)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Geldart Powder Group to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Geldart Group A", "right": "Aeratable fine powders (30-100 \u03bcm) with high bed expansion (umb > umf) and slow deaeration (FCC catalyst)" },
        { "left": "Geldart Group B", "right": "Sand-like bubbling particles (100-800 \u03bcm) where gas bubbles erupt immediately at incipient fluidization" },
        { "left": "Geldart Group C", "right": "Cohesive ultrafine powders (< 30 \u03bcm, e.g. flour, talc) dominated by inter-particle Van der Waals forces" },
        { "left": "Geldart Group D", "right": "Spoutable coarse grains (> 1000 \u03bcm, e.g. coffee beans) forming central high-velocity eruptive gas spouts" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Geldart's classification, powders in Group A expand smoothly without bubbles in the velocity range between umf and the minimum ___ velocity umb.",
      "blankAnswer": "bubbling",
      "blankDistractors": ["settling", "terminal", "elutriation"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A catalyst powder used in petroleum refining has mean diameter dp = 65.0 \u03bcm and density \u03c1p = 1000 kg/m^3. When fluidized with air, the bed expands smoothly by 30% before bubbles form at umb = 0.08 m/s (umf = 0.02 m/s \u2192 umb > umf). To which Geldart group does this material belong?",
      "options": [
        { "text": "Geldart Group A (Aeratable) (Particle size 30-100 \u03bcm, low density \u03c1p < 1400 kg/m^3, and umb > umf defining smooth particulate expansion of Group A)", "isCorrect": true, "explanation": "Correct! Let's systematically classify the material according to Derek Geldart's powder classification chart (Derek Geldart 1973; Kunii & Levenspiel *Fluidization Engineering* Chapter 3). 1. **Check Particle Geometric \\& Physical Parameters:** - Mean particle size: $d_p = 65.0\\text{ }\\mu\\text{m}$, which falls squarely in the $30\\text{ }\\mu\\text{m} < d_p < 100\\text{ }\\mu\\text{m}$ interval. - Particle skeletal density: $\\rho_p = 1000.0\\text{ kg/m}^3$, which satisfies $\\rho_p < 1400\\text{ kg/m}^3$. - Density difference: $\\Delta\\rho = \\rho_p - \\rho_g = 1000.0 - 1.2 = \\mathbf{998.8\\text{ kg/m}^3}$. 2. **Examine Bed Hydrodynamic Bubbling Behavior:** - Incipient fluidization velocity: $u_{\\text{mf}} = 0.02\\text{ m/s}$. - Minimum bubbling velocity: $u_{\\text{mb}} = 0.08\\text{ m/s}$. - Since $u_{\\text{mb}} > u_{\\text{mf}}$, there is a wide velocity window ($0.02\\text{ m/s} \\le u_0 \\le 0.08\\text{ m/s}$) where the bed expands smoothly and uniformly like a dense boiling liquid without any gas bubble formation! 3. **Conclude Powder Classification:** - These exact properties uniquely characterize **Geldart Group A (Aeratable)** powders, which are the premier choice for Fluid Catalytic Cracking (FCC) reactors! Flawless Geldart powder classification derivation!" },
        { "text": "Geldart Group B (Bubbling) (Group B powders bubble immediately at umf with no smooth expansion)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Geldart Group C (Cohesive)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Geldart Group D (Spoutable)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
