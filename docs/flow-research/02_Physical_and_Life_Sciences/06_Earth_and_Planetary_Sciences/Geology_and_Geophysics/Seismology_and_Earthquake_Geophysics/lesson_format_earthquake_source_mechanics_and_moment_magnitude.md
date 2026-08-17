# Duofy Reusable Lesson Format: Earthquake Source Mechanics and Moment Magnitude

**Target Topic:** `02_Physical_and_Life_Sciences / 06_Earth_and_Planetary_Sciences / Geology_and_Geophysics / Seismology_and_Earthquake_Geophysics`  
**Lesson Format Type:** `earthquake_source_mechanics_and_moment_magnitude`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the physical quantification of earthquake rupture energy, fault dislocation theory, and modern seismological magnitude scaling (Keiiti Aki 1966; Hiroo Kanamori & Thomas C. Hanks 1979): calculate the **Scalar Seismic Moment ($M_0 = \mu A D$)** from rock rigidity ($\mu \approx 3 \times 10^{10}\text{ Pa}$), fault rupture surface area ($A = L \times W$), and average coseismic slip displacement ($D$), formulate the **Moment Magnitude Scale ($M_w = \frac{2}{3}\log_{10}M_0 - 6.07$)**, analyze why $M_w$ **never saturates** for colossal megathrust earthquakes (unlike legacy Richter local magnitude $M_L$ and surface-wave magnitude $M_s$ which saturate near $M \approx 7.0-8.0$ due to finite instrument period clipping), and calculate radiated seismic energy ($E_s \approx \frac{\Delta \sigma}{2\mu}M_0 \propto 10^{1.5 M_w}$, where a $1.0$ unit increase in $M_w$ represents a $\approx 31.6\text{-fold}$ surge in radiated energy).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Seismic Moment Physics & Moment Magnitude Equation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Tectonic Stress Accumulation to Seismic Moment Release Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Magnitude Scale / Parameter & Geophysical Description Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Energy Scaling Multiplier for a Single Integer Increase in Mw Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Magnitude Saturation of the Richter Scale for Megathrust Earthquakes Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Seismic Moment & The Moment Magnitude Scale (Aki 1966; Kanamori 1979):
   - **The Scalar Seismic Moment ($M_0$):**
     $$\mathbf{M_0 = \mu A D}$$
     - $\mu$: Shear Modulus / Rigidity of crustal rock ($\approx 3.0 \times 10^{10}\text{ N/m}^2$ or $\text{Pa}$).
     - $A$: Surface area of the ruptured fault plane ($A = L \times W$ in $\text{m}^2$).
     - $D$: Average coseismic slip displacement along the fault plane (in $\text{m}$).
     - Units: Newton-meters ($\text{N}\cdot\text{m}$) or Dyne-cm ($1\text{ N}\cdot\text{m} = 10^7\text{ dyn}\cdot\text{cm}$).
   - **The Moment Magnitude Equation ($M_w$ - Hanks & Kanamori 1979):**
     $$\mathbf{M_w = \frac{2}{3}\log_{10}(M_0) - 6.07 \qquad (M_0 \text{ in }\text{N}\cdot\text{m})}$$
     - $\mathbf{M_w = \frac{2}{3}\log_{10}(M_0) - 10.73}$ (if $M_0$ is in $\text{dyn}\cdot\text{cm}$).
   - **Energy Scaling:**
     - Radiated seismic energy scales with magnitude as: $\log_{10} E_s \propto 1.5 M_w$.
     - An increase of $\mathbf{+1.0\text{ unit on } M_w}$ corresponds to a $\mathbf{10^{1.5} \approx 31.6\text{-fold}}$ increase in released seismic energy ($\mathbf{+2.0\text{ units } \implies 1,000\text{-fold}}$ energy surge!).
2. **Slide 2 (`ordering`):** Provide 5 steps of the seismic cycle generating seismic moment release: (1) tectonic plate motion drives steady inter-seismic elastic strain accumulation across a locked fault zone, (2) shear stress on the fault plane increases until it overcomes static frictional resistance (Coulomb failure threshold), (3) dynamic frictional instability initiates rupture nucleation at the hypocenter (focus), (4) the rupture front propagates across the fault plane at shear-wave speeds (~3 km/s), offsetting rock by average displacement D over rupture area A, (5) the sudden release of accumulated strain energy emits seismic waves quantified by scalar moment M0 = mu A D, generating ground shaking across the planet!
3. **Slide 3 (`matching`):** Pair 4 magnitude metrics (Seismic Moment M0, Moment Magnitude Mw, Richter Local Magnitude ML, Stress Drop) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that every 1.0 unit increase on the moment magnitude scale represents a 31.6-fold increase in radiated seismic energy. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the phenomenon of "magnitude saturation" in legacy earthquake scales: Why did seismologists replace Charles Richter's original Local Magnitude ($M_L$) and the Surface-Wave Magnitude ($M_s$) with the Moment Magnitude ($M_w$) scale for measuring major global earthquakes? (Because legacy scales measure wave amplitudes at a **fixed single frequency (e.g. 1-second or 20-second periods)**, which **"saturate" (hit a ceiling) near magnitude 7.0 to 8.0** because gigantic fault ruptures release their energy at much lower frequencies; whereas $M_w$ is calculated directly from physical fault rupture area and slip, **never saturating even for magnitude 9.5 megathrust earthquakes**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "earthquake_source_mechanics_and_moment_magnitude",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Seismic Moment & Moment Magnitude Scale (1979)**\n• **The Scalar Seismic Moment ($M_0$ - Aki 1966):**\n$$\n\\mathbf{M_0 = \\mu A D}\n$$\n  - $\\mu$: Rock shear modulus ($\\approx 3 \\times 10^{10}\\text{ Pa}$) | $A$: Rupture area ($L \\times W$) | $D$: Average slip displacement.\n• **The Moment Magnitude Equation ($M_w$ - Kanamori 1979):**\n$$\n\\mathbf{M_w = \\frac{2}{3}\\log_{10}(M_0) - 6.07 \\qquad (M_0 \\text{ in }\\text{N}\\cdot\\text{m})}\n$$\n• **Energy Scaling Law:**\n$$\n\\mathbf{\\Delta M_w = +1.0 \\implies 10^{1.5} \\approx 31.6\\text{-fold increase in radiated energy!}}\n$$\n  - A $+2.0$ increase in $M_w$ corresponds to a **$1,000\\text{-fold}$** surge in energy!\n• **Why $M_w$ is Superior:** Unlike legacy Richter $M_L$, **$M_w$ never saturates** on giant megathrusts (e.g. 1960 Chile $M_w 9.5$)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential physical stages of an earthquake seismic moment release cycle.",
      "orderItems": [
        "Continuous tectonic plate motion drives elastic strain accumulation across a locked fault contact",
        "Shear stress increases until it exceeds the static frictional strength (Coulomb threshold) along the fault asperities",
        "Dynamic rupture nucleates at the earthquake hypocenter (focus) and expands outward at 2.5 to 3.5 km/s",
        "The rupture expands across total fault surface area A, displacing opposite sides by average slip D",
        "Stored elastic strain energy is released as radiated seismic wave energy quantified by M0 = mu × A × D"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each seismological magnitude term to its precise physical definition.",
      "matchPairs": [
        { "left": "Seismic Moment (M0)", "right": "Fundamental mechanical work released by a fault rupture equal to rigidity × area × slip (mu * A * D)" },
        { "left": "Moment Magnitude (Mw)", "right": "Standard non-saturating magnitude scale calculated directly from the logarithm of seismic moment" },
        { "left": "Richter Magnitude (ML)", "right": "Legacy local magnitude based on peak Wood-Anderson seismograph amplitude that saturates near M 7.0" },
        { "left": "Stress Drop (Delta sigma)", "right": "Difference between initial shear stress on a fault before rupture and residual shear stress after slip" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "An increase of exactly 1.0 unit on the moment magnitude scale (Mw) corresponds to a ___-fold increase in total radiated seismic energy.",
      "blankAnswer": "31.6",
      "blankDistractors": ["10", "2", "100"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why did seismologists replace Charles Richter's local magnitude (ML) and surface-wave magnitude (Ms) with the Moment Magnitude (Mw) scale for assessing large global earthquakes?",
      "options": [
        { "text": "Legacy magnitude scales measure wave amplitudes at a single fixed frequency (e.g. 1-second or 20-second waves), causing them to 'saturate' (hit an artificial ceiling near magnitude 7.5 to 8.0) because gigantic fault ruptures emit their immense energy at much lower frequencies; whereas Mw is tied directly to physical fault rupture area and slip, never saturating even on magnitude 9+ megathrust events", "isCorrect": true, "explanation": "Correct! Charles Richter designed the original Local Magnitude (ML) in 1935 for small, shallow earthquakes in Southern California using Wood-Anderson torsion seismographs sensitive to 1-second period waves. As earthquakes grow larger than magnitude 7.0, the length of the fault rupture increases from tens of kilometers to hundreds of kilometers (e.g. the 2004 Sumatra rupture was 1300 km long). Because the rupture takes several minutes to complete, the bulk of its energy is radiated at very long periods (>100 to 500 seconds). High-frequency 1-second and 20-second waves reach a maximum peak amplitude and 'saturate'—a magnitude 8.0 and a magnitude 9.5 earthquake look almost identical on high-frequency instruments. Hiroo Kanamori and Thomas Hanks developed the Moment Magnitude (Mw) scale based directly on the scalar seismic moment M0 = mu*A*D. Because M0 integrates the total physical area of the fault plane (A) and average slip (D), Mw never saturates and accurately measures the true astronomical energy of colossal megathrust earthquakes like the 1960 Chile (Mw 9.5) and 2011 Tohoku (Mw 9.1) events." },
        { "text": "Because Richter magnitude was written in Latin and could not be translated", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Mw is the only scale that uses Fahrenheit", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the Richter scale was found to violate the law of gravity", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
