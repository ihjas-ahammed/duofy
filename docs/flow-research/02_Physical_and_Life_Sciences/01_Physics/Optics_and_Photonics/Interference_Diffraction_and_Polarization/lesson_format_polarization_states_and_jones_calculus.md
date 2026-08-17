# Duofy Reusable Lesson Format: Polarization States and Jones Calculus

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Optics_and_Photonics / Interference_Diffraction_and_Polarization`  
**Lesson Format Type:** `polarization_states_and_jones_calculus`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of polarized light and matrix optics: formulate **Malus's Law ($I = I_0 \cos^2\theta$)**, classify **Linear, Circular, and Elliptical Polarization States**, formulate the **Jones Vector Formalism (R. Clark Jones, 1941)** ($\mathbf{J} = \begin{pmatrix} E_x \\ E_y \end{pmatrix}$), construct **Jones Matrices** for Linear Polarizers, **Quarter-Wave Plates ($\Delta\phi = \pi/2$)**, and **Half-Wave Plates ($\Delta\phi = \pi$)**, and interact with live Jones matrix optical polarization simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Polarization States & Jones Calculus Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Optical Element & 2x2 Jones Matrix Representation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Numerical Intensity through Crossed Polarizers with 45° Middle Filter | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 4** | Polarized Light Intensity Law Discoverer Name Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Waveplate & Polarizer Jones Calculus Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "polarization_states_and_jones_calculus",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Malus's Law, and how does Jones Calculus represent polarization states and birefringent waveplates?",
      "blankAnswer": "Malus's Law (1809) states that when linearly polarized light passes through a linear analyzer at angle theta, transmitted intensity is: I = I_0 * cos^2(theta). Jones Calculus (1941) describes polarized light as a 2x1 complex vector J = [E_{0x} exp(i phi_x); E_{0y} exp(i phi_y)] (e.g., Horizontal [1; 0], Vertical [0; 1], Right-Circular (1/sqrt(2))[1; -i], Left-Circular (1/sqrt(2))[1; +i]). Optical components are 2x2 Jones matrices: (1) QUARTER-WAVE PLATE (QWP, Delta phi = pi/2): converts linear polarization at 45° into circular polarization. (2) HALF-WAVE PLATE (HWP, Delta phi = pi): mirrors/rotates linear polarization by 2*theta!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each optical element to its 2x2 Jones matrix representation.",
      "matchPairs": [
        { "left": "Linear Horizontal Polarizer", "right": "[1, 0; 0, 0]" },
        { "left": "Linear Vertical Polarizer", "right": "[0, 0; 0, 1]" },
        { "left": "Quarter-Wave Plate (fast axis horizontal)", "right": "[1, 0; 0, -i] or exp(i pi/4) * [1, 0; 0, -i] (introduces 90° relative phase)" },
        { "left": "Half-Wave Plate (fast axis horizontal)", "right": "[1, 0; 0, -1] (introduces 180° phase flip to vertical component)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "numerical",
      "content": "Unpolarized light of intensity I_0 = 100 W/m² passes through a vertical polarizer (P1 at 0°), then a diagonal polarizer (P2 at 45°), and finally a horizontal polarizer (P3 at 90°). Using Malus's Law, calculate the final transmitted intensity in W/m² (round to 1 decimal place).",
      "numericAnswer": 12.5,
      "numericTolerance": 0.5
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the surname of the French engineer who discovered that transmitted light intensity varies as the cosine-squared of polarizer angle (Malus)?",
      "blankAnswer": "malus"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Jones Calculus Polarization Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Jones Matrix Polarization Engine</h3><p>Input: Linearly Polarized Light at 45°: J = (1/√2)[1; 1]</p><button id=\"polBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Pass Through Quarter-Wave Plate (QWP)</button><div id=\"polOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('polBtn').onclick=()=>{document.getElementById('polOut').innerText='Jones Multiplication: [1, 0; 0, -i] * (1/√2)[1; 1] = (1/√2)[1; -i]. Output State: Right Circularly Polarized Light (RCP)! Electric field vector rotates clockwise at frequency ω.'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
