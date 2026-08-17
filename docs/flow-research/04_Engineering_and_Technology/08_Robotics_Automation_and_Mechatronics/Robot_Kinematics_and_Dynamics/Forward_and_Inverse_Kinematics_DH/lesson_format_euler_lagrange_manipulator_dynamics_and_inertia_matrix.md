# Duofy Reusable Lesson Format: Robot Dynamics (Euler-Lagrange & Joint Torques)

**Target Topic:** `04_Engineering_and_Technology / 08_Robotics_Automation_and_Mechatronics / Robot_Kinematics_and_Dynamics / Forward_and_Inverse_Kinematics_DH`  
**Lesson Format Type:** `euler_lagrange_manipulator_dynamics_and_inertia_matrix`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the multibody non-linear dynamics of articulated robot manipulators, energy-based modeling via the Lagrangian ($\mathcal{L} = \mathcal{K} - \mathcal{P}$), derivation of the classical **Euler-Lagrange Equations of Motion ($\frac{d}{dt}\frac{\partial \mathcal{L}}{\partial \dot{q}} - \frac{\partial \mathcal{L}}{\partial q} = \vec{\tau}$)**, structure of the symmetric positive-definite **Mass/Inertia Matrix ($M(q)$)**, the **Coriolis and Centrifugal Matrix ($C(q, \dot{q})$)** via Christoffel symbols of the first kind ($c_{ijk} = \frac{1}{2}[\frac{\partial M_{ij}}{\partial q_k} + \frac{\partial M_{ik}}{\partial q_j} - \frac{\partial M_{jk}}{\partial q_i}]$), the **Gravity Vector ($\vec{g}(q)$)**, and the fundamental skew-symmetric property ($\dot{M}(q) - 2C(q,\dot{q})$) ensuring passivity for Lyapunov-based robot control (John J. Craig *Introduction to Robotics: Mechanics and Control* 4th ed. Chapter 6; Mark W. Spong, Seth Hutchinson, M. Vidyasagar *Robot Modeling and Control* 2nd ed. Chapter 7; Bruno Siciliano et al. *Robotics: Modelling, Planning and Control* Chapter 7): formulate the **Robot Manipulator Equations of Motion Master Formulation**:
$$\mathbf{M(q) \ddot{\vec{q}} + C(q, \dot{\vec{q}}) \dot{\vec{q}} + \vec{g}(q) = \vec{\tau} \quad [\text{Joint Torques in N}\cdot\text{m}]}$$
where for a 2-link planar revolute robot arm with point masses $m_1, m_2$ at the distal link ends ($l_1, l_2$):
$$\mathbf{M(q) = \begin{bmatrix} (m_1 + m_2) l_1^2 + m_2 l_2^2 + 2 m_2 l_1 l_2 \cos\theta_2 & m_2 l_2^2 + m_2 l_1 l_2 \cos\theta_2 \\ m_2 l_2^2 + m_2 l_1 l_2 \cos\theta_2 & m_2 l_2^2 \end{bmatrix}}$$
derive the **Coriolis & Centrifugal Matrix ($C(q, \dot{q})$)**:
$$\mathbf{C(q, \dot{q}) = \begin{bmatrix} -m_2 l_1 l_2 \sin\theta_2 \cdot \dot{\theta}_2 & -m_2 l_1 l_2 \sin\theta_2 \cdot (\dot{\theta}_1 + \dot{\theta}_2) \\ m_2 l_1 l_2 \sin\theta_2 \cdot \dot{\theta}_1 & 0 \end{bmatrix}}$$
derive the **Gravity Vector ($\vec{g}(q)$)**:
$$\mathbf{\vec{g}(q) = \begin{bmatrix} (m_1 + m_2) g l_1 \cos\theta_1 + m_2 g l_2 \cos(\theta_1 + \theta_2) \\ m_2 g l_2 \cos(\theta_1 + \theta_2) \end{bmatrix}}$$
and interact with live DH forward kinematics solver, 2-link analytical inverse kinematics calculator, Geometric Jacobian & singularity evaluator, and Euler-Lagrange joint torque simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Euler-Lagrange ($M(q)\ddot{q} + C(q,\dot{q})\dot{q} + g(q) = \vec{\tau}$), Inertia Matrix $M(q)$ & Gravity Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Required Actuator Torques Tau 1 and Tau 2 for a Dynamic Arm Motion Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Robot Dynamics Term / Physical Force & Technical Robotics Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Robot Manipulator Dynamics, the Quadratic Velocity Term $C(q, \dot{q})\dot{q}$ Captures Coupled Non-Linear Forces Arising from Centrifugal and ___ Accelerations (Coriolis / Coriolis Forces) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Robotics & Manipulator Studio: DH Forward Kinematics, Analytical IK, Jacobian & Dynamics Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "euler_lagrange_manipulator_dynamics_and_inertia_matrix",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the closed-form structure of the Euler-Lagrange equations of motion for an n-DOF robot manipulator?",
      "blankAnswer": "Robot Dynamics Mechanics (Craig 2018; Spong 2020): (1) EQUATION OF MOTION: M(q)*q_ddot + C(q, q_dot)*q_dot + g(q) = \u03c4, where \u03c4 is the vector of joint actuator torques. (2) INERTIA MATRIX M(q): Symmetric positive-definite matrix representing instantaneous generalized mass and moment of inertia. (3) CORIOLIS \\& CENTRIFUGAL C(q, q_dot)*q_dot: Non-linear velocity-squared interaction torques coupling rotating links. (4) GRAVITY VECTOR g(q): Static gravitational holding torques (\u2202P/\u2202q). (5) SKEW-SYMMETRY: M_dot(q) - 2*C(q, q_dot) is strictly skew-symmetric, guaranteeing kinetic energy passivity in feedback control!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the required joint actuator torques \u03c4 to drive a robot arm along a specified dynamic trajectory.",
      "orderItems": [
        "Specify target trajectory profiles: joint positions q(t), velocities q\u0307(t), and accelerations q\u0308(t)",
        "Evaluate the posture-dependent mass/inertia matrix M(q) and multiply by joint accelerations: \u03c4_inertia = M(q) * q\u0308",
        "Compute the Coriolis and centrifugal matrix C(q, q\u0307) and multiply by joint velocities: \u03c4_coriolis = C(q, q\u0307) * q\u0307",
        "Calculate the static gravitational counter-balance vector: \u03c4_gravity = g(q)",
        "Sum all dynamic components to obtain total required motor torques: \u03c4 = \u03c4_inertia + \u03c4_coriolis + \u03c4_gravity"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Robot Dynamics Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Mass Matrix M(q)", "right": "Symmetric positive-definite configuration-dependent matrix defining kinetic energy \u039a = 0.5*q\u0307^T*M(q)*q\u0307" },
        { "left": "Coriolis Matrix C(q, q\u0307)", "right": "Non-linear velocity-product matrix capturing dynamic cross-coupling between multiple moving links" },
        { "left": "Gravity Vector g(q)", "right": "Static torque vector compensating for gravitational potential energy (\u2202P/\u2202q) to prevent sagging" },
        { "left": "Passivity Invariant", "right": "M\u0307(q) - 2*C(q, q\u0307) is skew-symmetric, proving total mechanical energy conservation during unactuated motion" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In robot manipulator dynamics, the quadratic velocity term C(q, q\u0307)q\u0307 captures coupled non-linear forces arising from centrifugal and ___ accelerations.",
      "blankAnswer": "coriolis",
      "blankDistractors": ["frictional", "magnetic", "elastic"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Robotics & Manipulator Dynamics Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Robotics Kinematics & Dynamics Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">DH Parameters, Analytical IK, Jacobian Singularities & Euler-Lagrange</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnDh\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Forward (px=0.537m, py=0.636m)</button><button id=\"btnIk\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Inverse IK (\u03b81=0\u00b0, \u03b82=+90\u00b0)</button><button id=\"btnJac\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Jacobian (det=0.25) & Dynamics \u03c4</button></div><div id=\"robLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate DH forward kinematics...</div><script>document.getElementById('btnDh').onclick=()=>{document.getElementById('robLog').innerHTML='<b>1. DENAVIT-HARTENBERG FORWARD KINEMATICS:</b><br>• Link lengths: l1 = 0.50 m, l2 = 0.40 m | Angles: \\u03b81 = 30\u00b0, \\u03b82 = 45\u00b0<br>• End-Effector: px = 0.537 m, py = 0.636 m | Orientation: <b style=\"color:#10b981;\">\\u03c6 = 75.0\u00b0!</b>';}; document.getElementById('btnIk').onclick=()=>{document.getElementById('robLog').innerHTML='<b>2. 2-LINK ANALYTICAL INVERSE KINEMATICS:</b><br>• Target: (x = 0.50 m, y = 0.50 m) with l1 = l2 = 0.50 m<br>• Cosine: cos\\u03b82 = 0.0 &rarr; <b style=\"color:#10b981;\">\\u03b82 = +90.0\u00b0 (Elbow-Down)</b><br>• Base Angle: \\u03c8 = 45\u00b0, \\u03c6 = 45\u00b0 &rarr; <b style=\"color:#38bdf8;\">\\u03b81 = 0.0\u00b0!</b>';}; document.getElementById('btnJac').onclick=()=>{document.getElementById('robLog').innerHTML='<b>3. DIFFERENTIAL JACOBIAN \\& ROBOT DYNAMICS:</b><br>• Jacobian: det(J) = l1*l2*sin\\u03b82 = 0.5*0.5*sin(90\u00b0) = <b style=\"color:#10b981;\">0.250 m\u00b2 (No singularity!)</b><br>• End-Effector Speed: vx = -1.50 m/s, vy = +0.50 m/s<br>• <b style=\"color:#38bdf8;\">Euler-Lagrange Dynamics: M(q)*q_ddot + C(q,q_dot)*q_dot + g(q) = \\u03c4!</b><br>🏆 <b style=\"color:#10b981;\">Robot_Kinematics_and_Dynamics 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
