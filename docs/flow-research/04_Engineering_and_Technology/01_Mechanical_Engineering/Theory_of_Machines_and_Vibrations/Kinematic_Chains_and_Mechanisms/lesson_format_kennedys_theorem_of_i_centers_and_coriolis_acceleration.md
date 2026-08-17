# Duofy Reusable Lesson Format: Mechanism Kinematics (I-Centers & Coriolis Acceleration)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Theory_of_Machines_and_Vibrations / Kinematic_Chains_and_Mechanisms`  
**Lesson Format Type:** `kennedys_theorem_of_i_centers_and_coriolis_acceleration`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify planar velocity analysis via instantaneous centers, Kennedy-Aronhold collinearity, and Coriolis acceleration vectors in multi-body machine dynamics (Alexander Kennedy 1886; Gaspard-Gustave de Coriolis 1835; Joseph E. Shigley et al. *Theory of Machines and Mechanisms* Chapter 3 & 4; Kenneth J. Waldron & Gary L. Kinzel Chapter 4): calculate total number of **Instantaneous Centers of Velocity ($\mathbf{N = \frac{n(n - 1)}{2}}$)**, master the **Aronhold-Kennedy Three Centers Theorem** (stating that if three rigid bodies $1, 2, 3$ undergo planar relative motion, their three mutual instantaneous centers $\mathbf{I_{12}, I_{23}, I_{13}}$ **MUST lie on a single straight line**); master linear velocity extraction from I-centers ($\mathbf{v_P = \omega_i \cdot r_{P / I_{1i}}}$); derive the **Coriolis Component of Acceleration**:
$$\mathbf{\mathbf{a}_{\text{Coriolis}} = 2 \, \boldsymbol{\omega} \times \mathbf{v}_{\text{rel}} \implies a_c = 2 \, \omega \, v_{\text{rel}}}$$
(analyzing why the factor of 2 arises physically: 1 part due to the rotation of the velocity vector $\mathbf{v}_{\text{rel}}$ at rate $\omega$, and 1 part due to the radial displacement of the particle to a larger radius moving at higher linear speed $\omega r$), apply the **Coriolis Direction Rule** (rotate vector $\mathbf{v}_{\text{rel}}$ by $90^\circ$ in the direction of link angular velocity $\boldsymbol{\omega}$), and interact with live Kutzbach mobility calculator, Grashof 4-bar simulator, Shaper quick-return animator, and Coriolis vector widget.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Kennedy's I-Center Theorem ($N = \frac{n(n-1)}{2}$, Collinear I-Centers) & Coriolis Acceleration ($a_c = 2\omega v$) Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Kinematic Dynamic Parameter / Vector Component & Physical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Coriolis Acceleration Arises When a Slider Moves Along a Rotating Link Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Total Number of Instantaneous Centers of Velocity in an n-Link Mechanism Is Given by n*(n - 1) Divided by ___ (2 / Two) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Kinematic Mechanisms Studio: Kutzbach Mobility, Grashof 4-Bar & Coriolis Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "kennedys_theorem_of_i_centers_and_coriolis_acceleration",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the Aronhold-Kennedy I-Center Theorem, and why does Coriolis Acceleration (2\u03c9v) occur in rotating slider mechanisms?",
      "blankAnswer": "I-Centers & Coriolis Acceleration (Shigley; Waldron): (1) TOTAL I-CENTERS: N = n*(n - 1) / 2 for an n-link mechanism. (2) ARONHOLD-KENNEDY THEOREM: The 3 mutual instantaneous centers of velocity of any 3 bodies in planar relative motion (I_12, I_23, I_13) MUST lie on a single straight line! This enables rapid geometric determination of unknown link velocities. (3) CORIOLIS ACCELERATION: a_c = 2 * \u03c9 * v_rel. Occurs whenever a sliding block moves with relative velocity v_rel along a guide path that is simultaneously rotating with angular velocity \u03c9. (4) THE FACTOR OF 2: One \u03c9*v arises from the rotational change in the direction of v_rel; the second \u03c9*v arises because the slider moves to larger/smaller radius r with different tangential speeds (\u03c9*r). (5) DIRECTION RULE: Rotate the relative velocity vector v_rel by 90\u00b0 in the direction of the rotating link's angular velocity \u03c9!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Kinematic Mechanism Velocity / Acceleration Concept to its exact Mathematical Expression.",
      "matchPairs": [
        { "left": "Total I-Centers Count", "right": "N = n * (n - 1) / 2, representing all instantaneous centers of relative rotation in an n-link mechanism" },
        { "left": "Aronhold-Kennedy Theorem", "right": "The three mutual instantaneous centers I_12, I_23, and I_13 must lie on a single straight line" },
        { "left": "Coriolis Acceleration Magnitude", "right": "a_coriolis = 2 * \u03c9 * v_rel, acting normal to the relative sliding path" },
        { "left": "Centripetal (Normal) Acceleration", "right": "a_n = \u03c9^2 * r = v^2 / r, directed radially inward toward the instantaneous center of rotation" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In dynamic acceleration analysis of a quick-return mechanism (where a slider block moves along a rotating slotted guide arm), why is the Coriolis acceleration magnitude exactly 2*\u03c9*v_rel with a mathematical coefficient of 2 rather than 1?",
      "options": [
        { "text": "The factor of 2 arises from two physically distinct kinematic rate-of-change effects: (1) the relative sliding velocity vector v_rel continuously changes its spatial orientation angle at angular rate \u03c9 (generating \u03c9*v_rel normal to the path), and (2) as the slider moves along the arm with velocity v_rel = dr/dt, it travels to a new radial position with a different tangential frame velocity (\u03c9*r), generating an additional acceleration rate d(\u03c9*r)/dt = \u03c9*(dr/dt) = \u03c9*v_rel; adding both simultaneous effects yields exactly 2*\u03c9*v_rel", "isCorrect": true, "explanation": "Correct! This is Joseph Shigley and Kenneth Waldron's rigorous derivation of Coriolis acceleration (*Theory of Machines and Mechanisms* Chapter 4). 1. **Differentiate Position Vector in Polar Coordinates:** - Position: $\\mathbf{r}(t) = r \\mathbf{e}_r$. - Velocity: $\\mathbf{v}(t) = \\dot{r} \\mathbf{e}_r + r \\dot{\\theta} \\mathbf{e}_\\theta = v_{\\text{rel}} \\mathbf{e}_r + (r \\omega) \\mathbf{e}_\\theta$. 2. **Differentiate Velocity to get Acceleration:** - $$\\mathbf{a}(t) = \\frac{d}{dt}\\left(v_{\\text{rel}} \\mathbf{e}_r + r \\omega \\mathbf{e}_\\theta\\right)$$ - Term A: $\\frac{d}{dt}(v_{\\text{rel}} \\mathbf{e}_r) = \\dot{v}_{\\text{rel}} \\mathbf{e}_r + v_{\\text{rel}} (\\omega \\mathbf{e}_\\theta)$ $\\implies \\mathbf{v_{\\text{rel}} \\omega \\mathbf{e}_\\theta}$ (Rotation of velocity vector!). - Term B: $\\frac{d}{dt}(r \\omega \\mathbf{e}_\\theta) = \\dot{r} \\omega \\mathbf{e}_\\theta + r \\alpha \\mathbf{e}_\\theta - r \\omega^2 \\mathbf{e}_r = \\mathbf{v_{\\text{rel}} \\omega \\mathbf{e}_\\theta} + r \\alpha \\mathbf{e}_\\theta - r \\omega^2 \\mathbf{e}_r$ (Change in tangential frame speed!). 3. **Sum the Tangential Cross-Terms:** - Combined normal acceleration: $v_{\\text{rel}} \\omega + v_{\\text{rel}} \\omega = \\mathbf{2 \\omega v_{\\text{rel}}}$! - **Result:** The coefficient is **exactly 2**, representing the dual contributions of velocity rotation and radial position change!" },
        { "text": "Because the mechanism has two slider blocks", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Newton's second law doubles all rotating forces", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Coriolis acceleration is calculated twice for forward and return strokes", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The total number of instantaneous centers of velocity for an n-link planar mechanism is N = n*(n - 1) divided by ___.",
      "blankAnswer": "2",
      "blankDistractors": ["3", "4", "6"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Kinematics & Mechanisms Studio: Kutzbach, Grashof & Coriolis",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Kinematic Chains & Mechanisms Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Kutzbach Mobility, Grashof Inversions & Coriolis</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnKutz\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Kutzbach DOF (M = 1)</button><button id=\"btnGras\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Grashof 4-Bar Inversion</button><button id=\"btnCor\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Coriolis Acceleration (2\u03c9v)</button></div><div id=\"kcLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate Kutzbach mobility...</div><script>document.getElementById('btnKutz').onclick=()=>{document.getElementById('kcLog').innerHTML='<b>1. KUTZBACH-GR\\u00dcBLER CRITERION:</b><br>• Six-Bar: n=6 links, j1=7 revolute pairs, j2=0<br>• M = 3(n - 1) - 2*j1 - j2 = 3(5) - 14 = <b style=\"color:#10b981;\">1 DOF (Constrained!)</b><br>• Exactly 1 actuator uniquely drives entire machine!';}; document.getElementById('btnGras').onclick=()=>{document.getElementById('kcLog').innerHTML='<b>2. GRASHOF 4-BAR ROTATABILITY:</b><br>• s=30mm, l=110mm, p=70mm, q=90mm &rarr; s+l (140) \\u2264 p+q (160)<br>• Shortest link s fixed &rarr; <b style=\"color:#38bdf8;\">Double-Crank (Drag-Link)!</b><br>• Both input and output make full 360\\u00b0 continuous rotations!';}; document.getElementById('btnCor').onclick=()=>{document.getElementById('kcLog').innerHTML='<b>3. CORIOLIS ACCELERATION VECTOR:</b><br>• \\u03c9 = 10 rad/s (Arm rotation), v_rel = 2.5 m/s (Slider motion)<br>• <b style=\"color:#10b981;\">a_c = 2 * \\u03c9 * v_rel = 50.0 m/s^2 (Perpendicular to path!)</b><br>🏆 <b style=\"color:#10b981;\">Kinematic Chains & Mechanisms 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
