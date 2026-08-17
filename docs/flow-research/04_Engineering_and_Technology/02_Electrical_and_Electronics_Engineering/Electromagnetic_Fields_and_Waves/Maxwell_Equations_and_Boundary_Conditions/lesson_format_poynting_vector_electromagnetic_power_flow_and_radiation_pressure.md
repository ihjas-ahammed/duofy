# Duofy Reusable Lesson Format: Poynting Vector (EM Power Flow & Radiation Pressure)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Electromagnetic_Fields_and_Waves / Maxwell_Equations_and_Boundary_Conditions`  
**Lesson Format Type:** `poynting_vector_electromagnetic_power_flow_and_radiation_pressure`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify energy conservation in electrodynamics, the Poynting Theorem, time-average power flux density, and electromagnetic radiation pressure on reflective/absorptive targets (John Henry Poynting 1884; Matthew N.O. Sadiku *Elements of Electromagnetics* Chapter 10; David K. Cheng *Field and Wave Electromagnetics* Chapter 7): derive **Poynting's Theorem Formulation**:
$$\mathbf{-\int_V \nabla \cdot \mathbf{S} \, dV = \frac{\partial}{\partial t} \int_V \left( \frac{1}{2}\epsilon |\mathbf{E}|^2 + \frac{1}{2}\mu |\mathbf{H}|^2 \right) dV + \int_V \sigma |\mathbf{E}|^2 \, dV}$$
(proving that the net power entering a closed volume equals the rate of increase of stored electric and magnetic energy plus Ohmic heat dissipation); master the **Instantaneous and Time-Average Poynting Vectors**:
$$\mathbf{\mathbf{S} = \mathbf{E} \times \mathbf{H} \ [\text{W/m}^2] \quad \Big| \quad \mathbf{\mathbf{S}_{\text{avg}} = \frac{1}{2} \text{Re}\left( \mathbf{E} \times \mathbf{H}^* \right) = \frac{|\mathbf{E}|^2}{2\eta} \hat{a}_k = \frac{1}{2}\eta |\mathbf{H}|^2 \hat{a}_k \ [\text{W/m}^2]}}$$
master **Radiation Pressure ($P_{\text{rad}}$)** on surfaces:
$$\mathbf{\text{Total Absorption: } P_{\text{rad}} = \frac{S_{\text{avg}}}{c} \quad \Big| \quad \text{Total Reflection (PEC Mirror): } P_{\text{rad}} = \frac{2 S_{\text{avg}}}{c} \ [\text{N/m}^2]}$$
and interact with live Maxwell equations differential solver, Interface boundary vector refractor, Plane wave impedance animator, and Poynting power density simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Poynting Vector ($\mathbf{S} = \mathbf{E}\times\mathbf{H}$), Average Power Flux ($S_{\text{avg}} = \frac{E^2}{2\eta}$) & Radiation Pressure Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Poynting Theorem Term / Energy Flow Quantity & Technical Physical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Poynting's Vector Flows Inward Radially into a DC Resistor Carrying Current Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Directional Electromagnetic Power Flux Density Vector Defined by E x H Is the ___ Vector (Poynting / Poynting's) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Electromagnetics Studio: Maxwell Solvers, Boundary Refraction & Poynting Power Flow Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "poynting_vector_electromagnetic_power_flow_and_radiation_pressure",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Poynting Vector, how is Time-Average EM Power Density calculated, and what is Radiation Pressure?",
      "blankAnswer": "Poynting Theorem & Power Flow (John H. Poynting 1884): (1) POYNTING VECTOR: S = E x H [W/m^2], representing instantaneous directional power flux density of an EM field. (2) TIME-AVERAGE POWER: S_avg = (1/2)*Re(E x H*) = (|E|^2 / (2*\u03b7)) * a_k [W/m^2] where \u03b7 is intrinsic medium impedance and a_k is the propagation unit vector. (3) POYNTING'S THEOREM: - \u222e S\u00b7dS = d/dt \u222b (we + wm) dV + \u222b \u03c3|E|^2 dV (Power entering volume = Energy storage rate + Ohmic heat loss). (4) RADIATION PRESSURE: Momentum transferred by photons: Absorbing surface P_rad = S_avg / c; Perfectly reflecting mirror P_rad = 2*S_avg / c [N/m^2]!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Electromagnetics Power Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Poynting Vector (S = E x H)", "right": "Vector product representing instantaneous rate of energy flow per unit surface area" },
        { "left": "Time-Average Power (Savg)", "right": "Savg = |E|^2 / (2*\u03b7), continuous average power density delivered by a time-harmonic wave" },
        { "left": "Ohmic Dissipation (\u222b \u03c3|E|^2 dV)", "right": "Joule heating loss within conductive media accounted for in Poynting's energy theorem" },
        { "left": "Mirror Radiation Pressure", "right": "Prad = 2*Savg / c, double momentum transfer resulting from perfect wave reflection" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Consider a cylindrical resistor carrying steady DC current I with voltage drop V. In classical electrodynamics, what direction does the Poynting vector S = E x H point at the outer surface of the resistor wire, and what is the physical meaning of this direction?",
      "options": [
        { "text": "The Poynting vector points radially INWARD toward the cylinder axis; because the electric field E is directed parallel to the wire axis (driving current) and the magnetic field H circulates azimuthally around the wire perimeter (by Ampère's law), their vector cross-product E x H points directly into the resistor surface from surrounding space, proving that electrical energy enters the wire radially from the electromagnetic fields and is dissipated as Joule heat inside the resistor volume", "isCorrect": true, "explanation": "Correct! This is Richard Feynman and Matthew Sadiku's classic electromagnetic energy flow demonstration (*The Feynman Lectures on Physics* Vol II; *Elements of Electromagnetics* Chapter 10). 1. **Field Geometry on Cylindrical Wire (Radius $a$, Length $L$):** - Axial Electric Field (driving current): $\\mathbf{E} = \\frac{V}{L} \\hat{a}_z$. - Azimuthal Magnetic Field (from Ampère's Law at $r = a$): $\\mathbf{H} = \\frac{I}{2\\pi a} \\hat{a}_\\phi$. 2. **Calculate Poynting Vector:** $$\\mathbf{S} = \\mathbf{E} \\times \\mathbf{H} = \\left(\\frac{V}{L} \\hat{a}_z\\right) \\times \\left(\\frac{I}{2\\pi a} \\hat{a}_\\phi\\right) = \\frac{V I}{2\\pi a L} (\\hat{a}_z \\times \\hat{a}_\\phi) = -\\frac{V I}{2\\pi a L} \\hat{a}_r$$ 3. **Integrate Inward Power Across Total Cylindrical Surface Area ($A = 2\\pi a L$):** $$P_{\\text{entering}} = \\oint |\\mathbf{S}| \\, dA = \\left(\\frac{V I}{2\\pi a L}\\right) \\times (2\\pi a L) = \\mathbf{V \\cdot I = I^2 R}$$ 4. **Physical Revelation:** Energy does not flow 'inside the wire along with the electrons'; energy travels **through the surrounding space via the electromagnetic field and dives radially inward into the resistor** to become heat!" },
        { "text": "The Poynting vector points along the wire in the direction of electron flow", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The Poynting vector points radially outward away from the wire", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The Poynting vector is zero everywhere for DC circuits", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The directional electromagnetic power flux density vector defined by E x H is the ___ vector.",
      "blankAnswer": "Poynting",
      "blankDistractors": ["Lorentz", "Laplace", "Coulomb"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Electromagnetics & Poynting Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Electromagnetic Fields & Waves Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Maxwell Equations, Boundary Refraction & Poynting Power</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnMax\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Displacement Current (ID = 139 mA)</button><button id=\"btnBnd\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Boundary Refraction (E2 Vector)</button><button id=\"btnPoy\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Plane Wave & Poynting Power</button></div><div id=\"emLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate displacement current...</div><script>document.getElementById('btnMax').onclick=()=>{document.getElementById('emLog').innerHTML='<b>1. MAXWELL DISPLACEMENT CURRENT:</b><br>• C = \\u03b50*A/d = 221.35 pF @ 1 MHz (100V)<br>• <b style=\"color:#10b981;\">ID = C * dv/dt = 139.1 mA!</b><br>• Closes circuit loop through empty space!';}; document.getElementById('btnBnd').onclick=()=>{document.getElementById('emLog').innerHTML='<b>2. ELECTROMAGNETIC BOUNDARY MATCHING:</b><br>• Interface z=0: \\u03b5r1=2, \\u03b5r2=8<br>• E1 = 5ax - 2ay + 12az &rarr; <b style=\"color:#38bdf8;\">E2 = 5ax - 2ay + 3az V/m!</b><br>• Et is continuous, Dn is continuous (\\u03c1s=0)!';}; document.getElementById('btnPoy').onclick=()=>{document.getElementById('emLog').innerHTML='<b>3. PLANE WAVE \\& POYNTING POWER FLOW:</b><br>• Glass (\\u03b5r=4): up = c/2 = 1.5*10^8 m/s, \\u03b7 = 188.5 \\u03a9<br>• Poynting Power Flux: Savg = |E|^2 / (2*\\u03b7) [W/m^2]<br>• Cylindrical Resistor: S dives radially INWARD (P = I^2*R)!<br>🏆 <b style=\"color:#10b981;\">Maxwell_Equations_and_Boundary_Conditions 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
