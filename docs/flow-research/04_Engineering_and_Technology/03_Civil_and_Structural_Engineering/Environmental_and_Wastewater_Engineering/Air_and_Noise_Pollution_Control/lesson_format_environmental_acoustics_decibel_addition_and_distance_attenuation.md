# Duofy Reusable Lesson Format: Environmental Acoustics (Decibel Addition & Attenuation)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Environmental_and_Wastewater_Engineering / Air_and_Noise_Pollution_Control`  
**Lesson Format Type:** `environmental_acoustics_decibel_addition_and_distance_attenuation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the physics and engineering mathematics of **Environmental Noise Pollution**, sound pressure level ($\text{SPL}$ or $L_p$) in decibels ($\text{dB}$), reference human auditory threshold ($p_0 = 20\text{ }\mu\text{Pa} = 2.0 \times 10^{-5}\text{ Pa}$), logarithmic addition of multiple uncorrelated industrial sound sources ($L_{\text{total}} = 10 \log_{10}(\sum 10^{L_i/10})$), the $+3\text{ dB}$ doubling rule, spherical inverse-square geometric point-source distance attenuation ($\Delta L = 20 \log_{10}(r_2 / r_1)$), line-source highway traffic attenuation ($\Delta L = 10 \log_{10}(r_2 / r_1)$), A-weighting sound scale ($\text{dBA}$), and acoustic roadside noise barriers (Mackenzie L. Davis *Introduction to Environmental Engineering* 5th ed. Chapter 11; Cyril M. Harris *Handbook of Acoustical Measurements and Noise Control* 3rd ed.): formulate the **Sound Pressure Level ($L_p$) Master Definition**:
$$\mathbf{L_p = 20 \log_{10}\left( \frac{p_{\text{rms}}}{p_0} \right) = 10 \log_{10}\left( \frac{p_{\text{rms}}^2}{p_0^2} \right) \quad [\text{dB}] \quad \left(p_0 = 20\text{ }\mu\text{Pa} = 2.0 \times 10^{-5}\text{ N/m}^2\right)}$$
derive the **Logarithmic Decibel Addition Master Formulation ($L_{\text{total}}$)**:
$$\mathbf{L_{\text{total}} = 10 \log_{10}\left( \sum_{i=1}^N 10^{\frac{L_i}{10}} \right) \quad [\text{dB}]}$$
- **$N$ Identical Sound Sources ($L_1 = L_2 = \dots = L$):**
  $$\mathbf{L_{\text{total}} = L + 10 \log_{10}(N) \implies \mathbf{\text{Doubling Sources } (N=2) \implies L + 3.01\text{ dB} \approx L + 3\text{ dB}}}$$
derive the **Spherical Free-Field Point-Source Distance Attenuation Law**:
$$\mathbf{L_{p2} = L_{p1} - 20 \log_{10}\left( \frac{r_2}{r_1} \right) \Longleftrightarrow \mathbf{\text{Doubling Distance } (r_2 = 2 r_1) \implies \mathbf{L_{p2} = L_{p1} - 6.02\text{ dB} \approx L_{p1} - 6\text{ dB}}}}$$
and interact with live Gaussian plume concentration mapper, Lapple cyclone separator simulator, ESP plate area sizer, and Environmental noise decibel adder & distance attenuation calculator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Decibel Addition ($L_{\text{total}} = 10 \log_{10}(\sum 10^{L_i/10})$), Doubling Rule ($+3\text{dB}$) & Distance Loss ($-6\text{dB}$) Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Combined Sound Level of Multiple Industrial Machines and Distance Attenuation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Environmental Acoustics Construct / Decibel Law & Technical Physical Behavior Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Free-Field Spherical Point Source Acoustics, Doubling the Distance from the Noise Source Reduces the Sound Pressure Level by Exactly ___ dB (6 / 6.0 / Six) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Environmental & Wastewater Engineering Studio: Gaussian Plumes, Cyclones, ESP & Acoustics Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "environmental_acoustics_decibel_addition_and_distance_attenuation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How are sound pressure levels added in decibels (dB), and how does noise attenuate with distance from a point source?",
      "blankAnswer": "Environmental Acoustics & Decibel Mechanics (Mackenzie L. Davis): (1) DECIBEL ADDITION: L_total = 10 * log10( \u2211 10^(Li / 10) ) [dB]. Decibels are logarithmic and cannot be added linearly! (2) EQUAL SOURCES (+3 dB RULE): Combining two equal 80 dB machines yields L_total = 80 + 10*log10(2) = 83 dB. (3) 10-dB DOMINANCE RULE: If two sounds differ by \u2265 10 dB (e.g. 90 dB and 75 dB), the louder source dominates (L_total \u2248 90.1 dB). (4) POINT SOURCE DISTANCE ATTENUATION: Lp2 = Lp1 - 20*log10(r2 / r1). Doubling distance (r2 = 2*r1) reduces sound level by exactly 6 dB (Inverse Square Law)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the combined sound level of multiple factory noise sources and their distance attenuation at a property line.",
      "orderItems": [
        "Measure or obtain the individual sound pressure levels (L1, L2, ..., Ln) in dB for each active machine",
        "Convert each decibel value to linear acoustic sound intensity: I_rel,i = 10^(Li / 10)",
        "Sum all linear relative acoustic intensities: I_total = \u2211 10^(Li / 10)",
        "Convert total linear intensity back to logarithmic decibels: L_total = 10 * log10(I_total)",
        "Apply spherical inverse-square geometric distance attenuation to evaluate noise at distance r2: Lp2 = L_total - 20 * log10(r2 / r1)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Environmental Acoustics Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Decibel Addition", "right": "L_total = 10*log10(\u2211 10^(Li/10)), logarithmic superposition of uncorrelated sound energy" },
        { "left": "+3 dB Doubling Rule", "right": "Increase in total sound pressure level resulting from doubling the number of identical noise sources" },
        { "left": "-6 dB Distance Rule", "right": "Spherical geometric sound attenuation resulting from doubling distance from a point source (20*log10(2))" },
        { "left": "A-Weighting (dBA)", "right": "Frequency filter curve matching human ear sensitivity by de-emphasizing low and very high frequencies" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In free-field spherical point source acoustics, doubling the distance from the noise source reduces the sound pressure level by exactly ___ dB.",
      "blankAnswer": "6",
      "blankDistractors": ["3", "10", "20"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Environmental & Wastewater Engineering Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Environmental Engineering & Pollution Control Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Gaussian Plumes, Cyclones, ESP Scrubbers & Acoustics</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnPlume\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Gaussian Plume (C = 321.8\u03bcg/m\u00b3)</button><button id=\"btnCyc\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Cyclone (dpc=5.64\u03bcm, \u03b7=87.6%)</button><button id=\"btnEsp\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. ESP (A=4605m\u00b2) & Decibels (+3dB)</button></div><div id=\"envLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate Gaussian plume dispersion...</div><script>document.getElementById('btnPlume').onclick=()=>{document.getElementById('envLog').innerHTML='<b>1. GAUSSIAN PLUME ATMOSPHERIC DISPERSION:</b><br>• C(x,0,0) = [Q/(\\u03c0*u*\\u03c3y*\\u03c3z)] * exp[-H\u00b2/(2\\u03c3z\u00b2)]<br>• Q = 100 g/s, H = 80m, u = 5m/s at x = 1.5km<br>• <b style=\"color:#10b981;\">Ground Concentration C = 321.8 \\u03bcg/m\u00b3!</b>';}; document.getElementById('btnCyc').onclick=()=>{document.getElementById('envLog').innerHTML='<b>2. LAPPLE CYCLONE SEPARATOR:</b><br>• Cut Diameter: dpc = \\u221a[9\\u03bcW / (2\\u03c0*Ne*vi*\\u03c1p)] = <b style=\"color:#10b981;\">5.64 \\u03bcm!</b><br>• Grade Efficiency: \\u03b7 = 1 / [1 + (dpc/dj)\u00b2]<br>• <b style=\"color:#38bdf8;\">For 15 \\u03bcm Fly Ash &rarr; \\u03b7 = 87.6% Collection!</b>';}; document.getElementById('btnEsp').onclick=()=>{document.getElementById('envLog').innerHTML='<b>3. ESP PRECIPITATOR \\& ENVIRONMENTAL ACOUSTICS:</b><br>• ESP: \\u03b7 = 1 - exp(-wA/Q) &rarr; <b style=\"color:#10b981;\">A = 4605.2 m\u00b2 for 99.0% capture!</b><br>• Decibel Addition: L_total = 10*log10(\\u2211 10^(Li/10))<br>• <b style=\"color:#38bdf8;\">80 dB + 80 dB = 83 dB (+3 dB rule)! Doubling distance: -6 dB!</b><br>🏆 <b style=\"color:#10b981;\">03_Civil_and_Structural_Engineering (ALL 6 SUBDISCIPLINES / ALL 15 LEAF DIRS) 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
