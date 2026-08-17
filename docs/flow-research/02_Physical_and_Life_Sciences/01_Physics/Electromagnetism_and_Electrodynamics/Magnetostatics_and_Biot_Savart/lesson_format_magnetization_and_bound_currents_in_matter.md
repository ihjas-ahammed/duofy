# Duofy Reusable Lesson Format: Magnetization and Bound Currents in Matter

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Electromagnetism_and_Electrodynamics / Magnetostatics_and_Biot_Savart`  
**Lesson Format Type:** `magnetization_and_bound_currents_in_matter`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of magnetostatics in material media: formulate **Magnetization $\mathbf{M}(\mathbf{r})$** (magnetic dipole moment per unit volume), derive the microscopic **Volume Bound Current ($\mathbf{J}_b = \nabla \times \mathbf{M}$)** and **Surface Bound Current ($\mathbf{K}_b = \mathbf{M} \times \hat{\mathbf{n}}$)**, define the **Auxiliary Magnetic Field $\mathbf{H} \equiv \frac{1}{\mu_0}\mathbf{B} - \mathbf{M}$**, formulate Ampère's Law in matter ($\nabla \times \mathbf{H} = \mathbf{J}_{\text{free}}$), and interact with live uniformly magnetized cylinder field simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Magnetization & Bound Currents Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Magnetic Field Vector & Governing Differential Equation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Uniformly Magnetized Rod Equivalent Solenoid Field Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Auxiliary Magnetic Field H Ampère Source Current Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Uniform Magnetized Cylinder & Bound Current Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "magnetization_and_bound_currents_in_matter",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are Magnetization M, Bound Currents (J_b, K_b), and the Auxiliary Magnetic Field H in magnetic materials?",
      "blankAnswer": "Magnetization M(r) is the magnetic dipole moment per unit volume. The microscopic alignment of atomic current loops produces macroscopic: (1) Volume Bound Current J_b = curl(M), and (2) Surface Bound Current K_b = M x n_hat. The total current is J_{tot} = J_{free} + J_b. Ampère's Law curl(B) = mu_0 * (J_{free} + curl(M)) is rewritten by defining the Auxiliary Field H = (1 / mu_0) * B - M, which obeys curl(H) = J_{free} (governed ONLY by free conduction currents!). For linear media, M = chi_m * H and B = mu * H, where mu = mu_0 * (1 + chi_m)."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each magnetic vector field/current to its differential relation.",
      "matchPairs": [
        { "left": "Volume Bound Current J_b", "right": "J_b = curl(M) (arises from non-uniform spatial magnetization)" },
        { "left": "Surface Bound Current K_b", "right": "K_b = M x n_hat (surface current sheet caused by uncompensated edge loops)" },
        { "left": "Auxiliary Field Curl: curl(H)", "right": "curl(H) = J_free (depends strictly on free conduction currents)" },
        { "left": "Magnetic B-Field Divergence: div(B)", "right": "div(B) = 0 always (solenoidal field lines, no magnetic charges)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "A long cylindrical bar of radius R has uniform magnetization M = M_0 z_hat along its axis. What are the resulting bound currents and the internal B-field?",
      "options": [
        { "text": "Volume current J_b = curl(M) = 0 inside; Surface current K_b = M x r_hat = M_0 phi_hat forms a surface sheet identical to a solenoid, producing uniform internal field B = mu_0 * M_0 z_hat", "isCorrect": true, "explanation": "Correct! Because M is uniform, curl(M) = 0 so J_b = 0. On the cylindrical surface, K_b = (M_0 z_hat) x r_hat = M_0 phi_hat. This surface current sheet is identical to a tightly wound solenoid with n*I = M_0, producing B = mu_0 * M_0 inside and B = 0 outside." },
        { "text": "J_b = M_0 everywhere and B = 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "K_b = 0 and B = infinity", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The cylinder demagnetizes immediately", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Ampère's Law in matter curl(H) = J_free, the curl of the auxiliary field H is determined solely by ___ currents.",
      "blankAnswer": "free",
      "blankDistractors": ["bound", "displacement", "eddy"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Magnetized Cylinder Bound Current Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Magnetized Cylinder Field Engine</h3><p>Uniform Magnetization: M₀ = 1.0 × 10⁵ A/m z_hat</p><button id=\"magBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Calculate Bound Currents & B-Field</button><div id=\"magOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('magBtn').onclick=()=>{document.getElementById('magOut').innerText='Results: Volume bound current J_b = ∇×M = 0; Surface bound current K_b = M₀ φ̂ = 100 kA/m. Internal B-field: B = μ₀ M₀ = (4π×10⁻⁷)(10⁵) = 0.126 Tesla (1,257 Gauss). Solenoid equivalence confirmed!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
