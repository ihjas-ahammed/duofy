# Duofy Reusable Lesson Format: Optical Spectroscopy and Stellar Classification

**Target Topic:** `02_Physical_and_Life_Sciences / 08_Astronomy_and_Space_Science / Observational_Astronomy / Radio_XRay_and_Optical_Astronomy`  
**Lesson Format Type:** `optical_spectroscopy_and_stellar_classification`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid stellar-astrophysics, spectral line formation, and distance modulus mastery across the Morgan-Keenan classification system (Annie Jump Cannon; Cecilia Payne-Gaposchkin 1925; William Wilson Morgan & Philip C. Keenan 1943): master the **O B A F G K M Spectral Sequence** from hottest ($T_{\text{eff}} > 30,000\text{ K}$, ionized Helium He II lines) to coolest ($T_{\text{eff}} < 3,500\text{ K}$, molecular Titanium Oxide TiO bands), understand why **Hydrogen Balmer Lines Peak at Class A ($\sim 10,000\text{ K}$)** via Boltzmann excitation and Saha ionization equations (Cecilia Payne's thesis proving stars are predominantly hydrogen/helium), evaluate **MK Luminosity Classes ($\text{I}$ Supergiants to $\text{V}$ Main Sequence Dwarfs)** via collisional pressure broadening of spectral lines, calculate astronomical distances with the **Distance Modulus Formula ($m - M = 5\log_{10}(d / 10\text{ pc}) + A_V$)**, and interact with live stellar spectrum and HR diagram simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | OBAFGKM Spectral Sequence & Distance Modulus Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Stellar Spectral Type / Luminosity Class & Diagnostic Feature Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Physical Reason Hydrogen Balmer Lines Peak Specifically at Class A Stars Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Roman Numeral Designating Main Sequence Dwarf Stars in MK System Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Stellar Spectral Classification & HR Diagram Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "optical_spectroscopy_and_stellar_classification",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Morgan-Keenan (MK) Stellar Spectral Classification sequence and how is the Distance Modulus calculated?",
      "blankAnswer": "Stellar astrophysics and spectroscopy (Annie Jump Cannon; Cecilia Payne-Gaposchkin 1925; Morgan-Keenan 1943): (1) THE OBAFGKM SPECTRAL SEQUENCE (Temperature order from Hottest to Coolest): (a) O-type (>30,000 K, Blue): Ionized Helium (He II) and Nitrogen absorption lines. (b) B-type (10,000-30,000 K, Blue-White): Neutral Helium (He I) lines. (c) A-type (~10,000 K, White): Maximum strength of Hydrogen Balmer absorption lines (H-alpha, H-beta). (d) F-type (6,000-7,500 K, Yellow-White): Ionized Calcium (Ca II H & K lines) strengthen. (e) G-type (5,000-6,000 K, Yellow, e.g. the Sun G2V at 5,780 K): Strong Ca II and neutral metal lines (Fe I). (f) K-type (3,500-5,000 K, Orange): Dominant neutral metal lines. (g) M-type (<3,500 K, Red): Prominent molecular absorption bands of Titanium Oxide (TiO). (2) MK LUMINOSITY CLASSES (Pressure Broadening): Class I (Supergiants, sharp narrow lines), Class II (Bright Giants), Class III (Normal Giants), Class IV (Subgiants), Class V (Main Sequence Dwarfs, broad collisionally broadened lines). (3) DISTANCE MODULUS: m - M = 5*log10(d / 10 pc) + A_V (where m is apparent magnitude, M is absolute magnitude, d is distance in parsecs, and A_V is interstellar dust extinction)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each stellar spectral classification parameter to its diagnostic feature.",
      "matchPairs": [
        { "left": "Class O Stars (>30,000 K)", "right": "Extremely hot blue stars featuring prominent ionized Helium (He II) absorption lines" },
        { "left": "Class A Stars (~10,000 K)", "right": "Stellar spectra with the maximum possible equivalent width of Hydrogen Balmer lines" },
        { "left": "Class M Stars (<3,500 K)", "right": "Cool red dwarf/giant spectra dominated by complex molecular Titanium Oxide (TiO) bands" },
        { "left": "Luminosity Class V (Dwarfs)", "right": "Dense main-sequence atmospheres producing broad, pressure-broadened spectral lines" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why do Hydrogen Balmer absorption lines reach their maximum peak strength specifically in Class A stars (~10,000 K), becoming significantly weaker in both hotter O/B stars and cooler G/K/M stars?",
      "options": [
        { "text": "In Class A stars (~10,000 K), the thermal kinetic energy (governed by the Boltzmann distribution and Saha ionization equation) perfectly populates the n=2 excited state of neutral hydrogen; in hotter O/B stars (>20,000 K) almost all hydrogen is completely ionized into bare protons (no bound electrons to absorb light), while in cooler G/K/M stars (<6,000 K) nearly all hydrogen electrons sit in the n=1 ground state", "isCorrect": true, "explanation": "Correct! This fundamental discovery formed the core of Cecilia Payne-Gaposchkin's 1925 Harvard doctoral dissertation (widely regarded as the most brilliant PhD thesis in astronomy). Prior to Payne, astronomers erroneously believed that stars of different spectral types had completely different chemical compositions. Payne applied quantum statistical mechanics—combining the Boltzmann excitation equation with the Saha ionization equation. Hydrogen Balmer absorption lines occur when an electron absorbs a visible photon to jump from the n=2 excited state to n=3, 4, 5, etc. In cool stars like our Sun (G2V, 5,780 K) or M dwarfs (3,000 K), thermal collisions are too weak to excite electrons out of the n=1 ground state (99.999% of electrons remain in n=1, producing Lyman UV lines rather than visible Balmer lines). In ultra-hot stars like O and B stars (20,000 - 40,000 K), the intense radiation field ionizes virtually all hydrogen atoms into free protons and free electrons, leaving no bound electrons to absorb any spectral lines. Only at the Goldilocks temperature of Class A stars (~9,500 - 10,000 K, like Sirius and Vega) is the gas hot enough to populate the n=2 level in large numbers without being hot enough to ionize the hydrogen away, creating massive, dark Balmer absorption lines in the visible spectrum." },
        { "text": "Because Class A stars are made of pure liquid hydrogen while other stars are made of rock", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because hydrogen atoms only exist at temperatures above 1,000,000 K", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Class A stars have zero gravity allowing photons to escape faster", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Morgan-Keenan (MK) stellar classification system, Main Sequence Dwarf stars (such as our Sun, G2V) are designated by Roman numeral ___.",
      "blankAnswer": "V",
      "blankDistractors": ["I", "III", "IV"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Stellar Spectral Classification & HR Diagram Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Stellar Spectral Classification & HR Diagram Engine</h3><p>Select Spectral Class (Morgan-Keenan Sequence):</p><button id=\"oBtn\" style=\"padding:8px 14px; margin:3px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">Class O (35,000 K)</button><button id=\"aBtn\" style=\"padding:8px 14px; margin:3px; background:#93c5fd; color:#0b0f19; border:none; border-radius:4px; cursor:pointer;\">Class A (10,000 K - Vega)</button><button id=\"gBtn\" style=\"padding:8px 14px; margin:3px; background:#facc15; color:#0b0f19; border:none; border-radius:4px; cursor:pointer;\">Class G (5,780 K - Sun)</button><button id=\"mBtn\" style=\"padding:8px 14px; margin:3px; background:#ef4444; color:white; border:none; border-radius:4px; cursor:pointer;\">Class M (3,000 K - Proxima)</button><div id=\"specOut\" style=\"margin-top:12px; color:#38bdf8; font-weight:bold;\">Select a stellar spectral class above...</div><script>document.getElementById('oBtn').onclick=()=>{document.getElementById('specOut').innerText='Class O: T > 30,000 K | Blue Star | Spectra: Strong Ionized Helium (He II), weak Hydrogen (almost 100% ionized)!';}; document.getElementById('aBtn').onclick=()=>{document.getElementById('specOut').innerText='Class A: T ≈ 10,000 K | White Star | Spectra: MAXIMUM PEAK HYDROGEN BALMER LINES (n=2 level optimally populated)!';}; document.getElementById('gBtn').onclick=()=>{document.getElementById('specOut').innerText='Class G: T ≈ 5,780 K | Yellow Star (Sun G2V) | Spectra: Strong Ionized Calcium (Ca II H&K), neutral Iron lines (Fe I)!';}; document.getElementById('mBtn').onclick=()=>{document.getElementById('specOut').innerText='Class M: T < 3,500 K | Red Dwarf/Giant | Spectra: Deep molecular bands of Titanium Oxide (TiO), atomic lines suppressed!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
