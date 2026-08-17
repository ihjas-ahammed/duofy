# Duofy Reusable Lesson Format: Seismic Wave Propagation and Shadow Zones

**Target Topic:** `02_Physical_and_Life_Sciences / 06_Earth_and_Planetary_Sciences / Geology_and_Geophysics / Seismology_and_Earthquake_Geophysics`  
**Lesson Format Type:** `seismic_wave_propagation_and_shadow_zones`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the elastodynamics, elastic moduli, and global ray-tracing discoveries of Earth's internal layered structure (Richard Dixon Oldham 1906; Beno Gutenberg 1914; Inge Lehmann 1936): contrast the mathematical physics of **P-Waves ($v_p = \sqrt{\frac{K + \frac{4}{3}\mu}{\rho}}$, compressional/longitudinal, traveling through solids and fluids)** with **S-Waves ($v_s = \sqrt{\frac{\mu}{\rho}}$, transverse shear, unable to propagate through fluids where shear modulus $\mu = 0$)**, master the global **S-Wave Shadow Zone ($103^\circ-180^\circ$)** proving the existence of the liquid iron outer core at the **Gutenberg Discontinuity (CMB at $2891\text{ km}$)**, analyze the **P-Wave Shadow Zone ($103^\circ-143^\circ$)**, and evaluate **Inge Lehmann's discovery of the solid inner core** via $PKIKP$ seismic phase reflections.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Body Wave Elastodynamics & Core Shadow Zones Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Seismic Ray Path from Earthquake Focus to PKIKP Arrival Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Seismic Wave / Discontinuity & Physical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Angular Starting Epicentral Distance for the S-Wave Shadow Zone Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Reason S-Waves Cannot Travel Through Liquids Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Seismic Wave Propagation & Shadow Zones (Oldham 1906; Gutenberg 1914; Lehmann 1936):
   - **Elastodynamic Velocities:**
     $$\mathbf{v_p = \sqrt{\frac{K + \frac{4}{3}\mu}{\rho}} \qquad v_s = \sqrt{\frac{\mu}{\rho}}}$$
     - $K$: Bulk Modulus (resistance to incompressibility).
     - $\mu$: Shear Modulus / Rigidity (resistance to shape deformation). In liquids, $\mu = 0 \implies \mathbf{v_s = 0}$!
   - **Global Internal Discontinuities & Shadow Zones:**
     - **Mohorovičić (Moho, crust-mantle):** $v_p$ jumps from $6.5 \to 8.1\text{ km/s}$.
     - **Gutenberg Discontinuity (CMB, depth $2891\text{ km}$):** Liquid outer core.
       - **S-Wave Shadow Zone ($103^\circ \text{ to } 180^\circ$):** Total blockage of direct S-waves beyond $103^\circ$ epicentral distance proves a **liquid outer core**!
       - **P-Wave Shadow Zone ($103^\circ \text{ to } 143^\circ$):** Refraction of P-waves as velocity drops from $13.7\text{ km/s}$ (mantle) to $8.1\text{ km/s}$ (liquid core).
     - **Inge Lehmann's Solid Inner Core Discovery (1936):** Faint P-wave arrivals ($PKIKP$ rays) detected inside the $103^\circ-143^\circ$ shadow zone prove a **solid iron inner core ($R \approx 1220\text{ km}$)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of seismic wave propagation from an earthquake hypocenter through Earth's core: (1) an earthquake rupture generates simultaneous P-waves and S-waves that radiate outward in 3D through the solid mantle, (2) seismic waves refract gradually upward as mantle density and elastic moduli increase with depth (Snell's Law), (3) at 2891 km depth, waves strike the core-mantle boundary; S-waves are completely absorbed/converted, while P-waves refract sharply downward into the liquid outer core (PKP phase), (4) deep inside the core, P-waves encounter the solid inner core boundary at 5150 km depth, refracting into the solid iron lattice as high-velocity PKIKP waves, (5) the PKIKP waves exit through the outer core and mantle to arrive at seismometers located directly in the antipodal P-wave shadow zone!
3. **Slide 3 (`matching`):** Pair 4 seismic features (P-Wave, S-Wave, S-Wave Shadow Zone, PKIKP Phase) with their geophysical characteristics.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the epicentral angular distance beyond which direct S-waves cannot be detected globally is 103 degrees. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the mathematical physics of S-wave extinction in fluids: Why is it physically impossible for an S-wave (secondary shear wave) to propagate through Earth's liquid outer core or through liquid magma chambers? (Because **fluids (liquids and gases) possess zero shear modulus / rigidity ($\mu = 0$) and cannot sustain shear stress**; in the elastodynamic shear wave equation $v_s = \sqrt{\mu/\rho}$, setting $\mu = 0$ results in a wave velocity of zero).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "seismic_wave_propagation_and_shadow_zones",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Seismic Wave Propagation & Shadow Zones**\n• **Elastodynamic Velocities:**\n$$\n\\mathbf{v_p = \\sqrt{\\frac{K + \\frac{4}{3}\\mu}{\\rho}}} \\qquad \\mathbf{v_s = \\sqrt{\\frac{\\mu}{\\rho}}}\n$$\n  - In fluids (liquids/gases), **Shear Modulus $\\mu = 0 \\implies v_s = 0$** (S-waves cannot propagate!).\n• **Core-Mantle Boundary (CMB / Gutenberg at $2891\\text{ km}$):**\n  - **S-Wave Shadow Zone ($103^\\circ\\text{--}180^\\circ$):** Complete absence of direct S-waves proves **Liquid Outer Core**!\n  - **P-Wave Shadow Zone ($103^\\circ\\text{--}143^\\circ$):** Refraction as $v_p$ drops from $13.7 \\to 8.1\\text{ km/s}$.\n• **Inge Lehmann's Solid Inner Core (1936):**\n  - Faint **$PKIKP$ P-wave arrivals** inside the $103^\\circ\\text{--}143^\\circ$ zone prove a **Solid Iron Inner Core ($R \\approx 1220\\text{ km}$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential path of an internal PKIKP seismic ray from earthquake focus to antipodal receiver.",
      "orderItems": [
        "Earthquake slip generates high-frequency compressional P-waves that radiate into the solid silicate mantle",
        "P-waves refract along curved ray paths through the lower mantle as density and bulk modulus increase with depth",
        "At 2891 km depth, the P-wave strikes the core-mantle boundary (CMB) and refracts into the liquid outer core (PKP phase)",
        "The wave encounters the inner core boundary at 5150 km depth, refracting into the solid iron inner core as a PKIKP phase",
        "The PKIKP ray emerges from the inner and outer core, transmitting through the opposite mantle to emerge in the shadow zone"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each seismic concept to its defining physical discovery.",
      "matchPairs": [
        { "left": "P-Wave (Primary)", "right": "Longitudinal compressional wave traveling through both solid rocks and liquid fluids" },
        { "left": "S-Wave (Secondary)", "right": "Transverse shear wave that is strictly blocked by fluids where shear modulus mu = 0" },
        { "left": "S-Wave Shadow Zone (103° to 180°)", "right": "Global absence of shear wave arrivals proving that Earth possesses a liquid outer core" },
        { "left": "PKIKP Seismic Phase", "right": "P-wave reflected and refracted through the solid inner core discovered by Inge Lehmann in 1936" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The global shadow zone where direct S-waves disappear completely on seismograms begins at an epicentral angular distance of ___ degrees.",
      "blankAnswer": "103",
      "blankDistractors": ["143", "180", "90"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is it physically impossible for S-waves (secondary shear waves) to propagate through Earth's molten iron outer core?",
      "options": [
        { "text": "Fluids (liquids and gases) have zero resistance to shear strain and cannot support transverse shear stresses, meaning their shear modulus is mathematically zero (mu = 0); therefore, the shear wave velocity v_s = sqrt(mu/rho) drops to identically zero", "isCorrect": true, "explanation": "Correct! Wave propagation in elastic media depends on restoring forces. P-waves are compressional waves whose restoring force is resistance to volume change, governed by the Bulk Modulus (K); because liquids resist volume compression, P-waves travel through liquids (though at reduced speed). In contrast, S-waves are shear waves that require the medium to resist shape deformation (transverse shearing), governed by the Shear Modulus / Rigidity (mu). Liquids have no static shear strength; when subjected to shear stress, a liquid simply flows rather than storing elastic energy. Consequently, the shear modulus of any liquid is exactly zero (mu = 0). Substituting mu = 0 into the elastodynamic wave equation v_s = sqrt(mu/rho) yields v_s = 0, proving that S-waves cannot physically exist or propagate inside liquid media like Earth's outer core." },
        { "text": "Because the outer core is too cold for sound waves to move", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because S-waves are absorbed by Earth's gravitational pull", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because iron atoms destroy transverse waves using magnetic fields", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
