# Duofy Reusable Lesson Format: Bragg's Law and Powder X-Ray Diffraction

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Condensed_Matter_and_Solid_State_Physics / Crystal_Lattices_and_X_Ray_Diffraction`  
**Lesson Format Type:** `bragg_law_and_powder_xray_diffraction`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of experimental crystallography: formulate **Bragg's Law of X-Ray Diffraction ($2 d \sin\theta = n \lambda$)**, analyze the **Debye-Scherrer Powder Method** (randomly oriented crystallites producing concentric diffraction cones), index powder XRD diffraction peak angles $2\theta$, calculate lattice constants $a$, apply the **Scherrer Equation** for crystallite grain size broadening ($\tau = \frac{K \lambda}{\beta \cos\theta}$), and interact with live powder XRD diffractometer simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bragg's Law & Powder Diffraction Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Diffraction Technique & Sample Requirement Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Numerical Lattice Constant a Calculation from Peak Angle 2theta | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 4** | X-Ray Crystal Diffraction Discoverer Father-Son Surname Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Powder XRD Diffractometer Peak Indexing Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "bragg_law_and_powder_xray_diffraction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Bragg's Law of X-Ray Diffraction, and how does Powder XRD identify crystal structures?",
      "blankAnswer": "Bragg's Law (W.H. & W.L. Bragg, 1913) states that constructive interference of X-rays scattered from atomic planes with spacing d occurs when the path difference equals an integer number of wavelengths: 2*d*sin(theta) = n*lambda. In Powder X-Ray Diffraction (PXRD), a polycrystalline sample contains millions of randomly oriented microcrystallites. Every family of (hkl) planes finds grains oriented at the exact Bragg angle theta, forming concentric diffraction cones of opening angle 4*theta. Measuring peak angles 2*theta on a diffractometer determines interplanar spacings d_{hkl} and allows indexing the Bravais lattice and lattice constant a!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each XRD characterization method to its experimental capability.",
      "matchPairs": [
        { "left": "Powder XRD (Debye-Scherrer)", "right": "Phase identification, lattice parameter determination, and crystallite size from 2theta peaks" },
        { "left": "Single-Crystal XRD", "right": "Full 3D atomic coordinates, bond lengths, and complete protein/molecular structure solving" },
        { "left": "Scherrer Grain Size Analysis", "right": "Determines nanoscale crystallite size from peak FWHM broadening: tau = K * lambda / (beta * cos(theta))" },
        { "left": "Laue Transmission Method", "right": "Uses white (polychromatic) X-ray beam on stationary single crystal to determine crystal orientation" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "numerical",
      "content": "In a powder XRD experiment with Cu-Kalpha X-rays (lambda = 1.54 Å), the first (100) peak of a simple cubic crystal is observed at Bragg angle theta = 15.0° (sin(15°) = 0.2588). Calculate the lattice constant a in Angstroms: a = lambda / (2 * sin(theta)).",
      "numericAnswer": 2.98,
      "numericTolerance": 0.05
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the surname of the father-and-son British physicists who shared the 1915 Nobel Prize for establishing the law of X-ray diffraction (Bragg)?",
      "blankAnswer": "bragg"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Powder XRD Diffractometer Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Powder XRD 2θ Diffractometer</h3><p>Radiation: Cu-Kα (λ = 1.5406 Å) | Sample: FCC Copper (a = 3.615 Å)</p><button id=\"xrdBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Collect 2θ Diffraction Scan</button><div id=\"xrdOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('xrdBtn').onclick=()=>{document.getElementById('xrdOut').innerText='Scan Output: Peak 1 at 2θ = 43.3° (111 plane, d = 2.087 Å); Peak 2 at 2θ = 50.4° (200 plane, d = 1.808 Å); Peak 3 at 2θ = 74.1° (220 plane, d = 1.278 Å). Bravais lattice indexed: Face-Centered Cubic (FCC)!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
