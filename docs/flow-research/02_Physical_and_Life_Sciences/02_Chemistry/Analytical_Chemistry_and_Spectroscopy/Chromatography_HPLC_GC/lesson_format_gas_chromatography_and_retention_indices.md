# Duofy Reusable Lesson Format: Gas Chromatography and Retention Indices

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Analytical_Chemistry_and_Spectroscopy / Chromatography_HPLC_GC`  
**Lesson Format Type:** `gas_chromatography_and_retention_indices`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of gas chromatographic separation and compound identification: formulate the principles of **Gas-Liquid Chromatography (GC)** (inert carrier gas mobile phase $\text{He}, \text{H}_2, \text{N}_2$, fused-silica open tubular capillary columns with poly(dimethylsiloxane) liquid stationary phases), analyze sample introduction (**Split vs Splitless Injection**), compare common detectors (**Flame Ionization Detector FID**, **Thermal Conductivity Detector TCD**, **Electron Capture Detector ECD**, and **Mass Spectrometry GC-MS**), calculate the **Kovats Retention Index ($I = 100 \left[ n + \frac{\log t'_R(x) - \log t'_R(n)}{\log t'_R(n+1) - \log t'_R(n)} \right]$)** against $n$-alkane homologous series, and interact with live GC temperature programming simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Gas Chromatography & Kovats Index Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | GC Detector & Specific Detection Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Numerical Kovats Retention Index Logarithmic Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 4** | Flame Ionization Detector Responsive Element Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive GC Oven Temperature Programming Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "gas_chromatography_and_retention_indices",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Gas Chromatography (GC), and what is the Kovats Retention Index I?",
      "blankAnswer": "Gas Chromatography (GC, Archer Martin & Anthony James 1952) separates volatile, thermally stable compounds carried by an inert gas (He, H2, N2) through a capillary column coated with a microscopic liquid stationary phase (e.g. 5% diphenyl / 95% dimethylpolysiloxane). Retention is governed by analyte boiling points and stationary phase interactions. The Kovats Retention Index I (Ervin Kováts 1958) is a standardized, instrument-independent retention parameter anchored to the homologous series of straight-chain n-alkanes (where n-alkanes are defined with I = 100 * carbon_number, e.g. octane C8 has I=800, nonane C9 has I=900): I = 100 * [ n + (log t'_R(x) - log t'_R(n)) / (log t'_R(n+1) - log t'_R(n)) ], where t'_R = t_R - t_0 is the adjusted retention time!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Gas Chromatography detector to its selectivity and operational principle.",
      "matchPairs": [
        { "left": "Flame Ionization Detector (FID)", "right": "Burns organic analytes in H_2/Air flame, producing CHO+ ions collected at cathode (sensitive to all hydrocarbons)" },
        { "left": "Thermal Conductivity Detector (TCD)", "right": "Measures changes in filament heat dissipation by carrier gas; universal, non-destructive detector" },
        { "left": "Electron Capture Detector (ECD)", "right": "Uses radioactive Ni-63 beta source; ultra-sensitive to halogenated pesticides and electrophiles" },
        { "left": "Mass Spectrometer (GC-MS)", "right": "Ionizes eluting molecules (70 eV EI) to provide structural mass-to-charge fragmentation spectra" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "numerical",
      "content": "In an isothermal GC run, an unknown compound has an adjusted retention time t'_R = 6.00 min. The adjacent n-alkanes n-heptane (C7, I=700) and n-octane (C8, I=800) have adjusted retention times of t'_R(7) = 4.00 min and t'_R(8) = 8.00 min. Calculate the Kovats Retention Index I: I = 100 * [ 7 + (log10(6.00) - log10(4.00)) / (log10(8.00) - log10(4.00)) ] (round to nearest whole integer).",
      "numericAnswer": 758,
      "numericTolerance": 2
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Flame Ionization Detector (FID) is blind to inorganic gases like water and CO2, responding exclusively to molecules containing the element ___.",
      "blankAnswer": "carbon",
      "blankDistractors": ["nitrogen", "oxygen", "silicon"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive GC Temperature Programming Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Gas Chromatography Oven Ramp Engine</h3><p>Sample: Alkane Mixture ($C_8$ to $C_{20}$) | Mode: Isothermal ($100^\\circ\\text{C}$)</p><button id=\"gcBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Switch to Temperature Programmed Ramp (50°C → 280°C at 15°C/min)</button><div id=\"gcOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('gcBtn').onclick=()=>{document.getElementById('gcOut').innerText='Temperature Programming Active: General Elution Problem solved! Early volatile peaks (C8-C10) cleanly resolved at low T; heavy high-boiling waxes (C18-C20) elute rapidly with sharp peak widths under thermal ramp. Total run time reduced from 90 min to 16 min!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
