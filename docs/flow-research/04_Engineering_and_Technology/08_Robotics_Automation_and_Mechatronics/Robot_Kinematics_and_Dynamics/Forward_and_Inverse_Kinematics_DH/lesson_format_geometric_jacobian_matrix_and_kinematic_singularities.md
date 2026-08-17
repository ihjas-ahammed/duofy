# Duofy Reusable Lesson Format: Differential Kinematics (Geometric Jacobian & Singularities)

**Target Topic:** `04_Engineering_and_Technology / 08_Robotics_Automation_and_Mechatronics / Robot_Kinematics_and_Dynamics / Forward_and_Inverse_Kinematics_DH`  
**Lesson Format Type:** `geometric_jacobian_matrix_and_kinematic_singularities`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through differential kinematics of robot manipulators, the **Geometric Jacobian Matrix ($J(q)$)** mapping joint velocity vector $\dot{\vec{q}}$ to operational task-space linear and angular velocities ($\vec{v}_e, \vec{\omega}_e$), the column construction for revolute joints ($\vec{J}_{vi} = \vec{z}_{i-1} \times (\vec{p}_e - \vec{p}_{i-1}), \vec{J}_{\omega i} = \vec{z}_{i-1}$) and prismatic joints ($\vec{J}_{vi} = \vec{z}_{i-1}, \vec{J}_{\omega i} = \vec{0}$), calculation of **Kinematic Singularities ($\det(J(q)) = 0$)**, boundary singularities (arm fully outstretched $\theta_2 = 0^\circ$ or folded $\theta_2 = 180^\circ$), interior singularities (wrist axes alignment), infinite joint speeds ($J^{-1} \to \infty$), and the **Yoshikawa Manipulability Measure ($w = \sqrt{\det(J J^T)}$)** (John J. Craig *Introduction to Robotics: Mechanics and Control* 4th ed. Chapter 5; Mark W. Spong, Seth Hutchinson, M. Vidyasagar *Robot Modeling and Control* 2nd ed. Chapter 4; Tsuneo Yoshikawa 1985): formulate the **Geometric Jacobian Velocity Mapping Master Formulation**:
$$\mathbf{\begin{bmatrix} \dot{\vec{p}}_e \\ \vec{\omega}_e \end{bmatrix} = J(q) \cdot \dot{\vec{q}} = \begin{bmatrix} J_{v1} & J_{v2} & \cdots & J_{vn} \\ J_{\omega 1} & J_{\omega 2} & \cdots & J_{\omega n} \end{bmatrix} \begin{bmatrix} \dot{q}_1 \\ \dot{q}_2 \\ \vdots \\ \dot{q}_n \end{bmatrix}}$$
where for a 2-link planar revolute robot arm:
$$\mathbf{J(q) = \begin{bmatrix} -l_1 \sin\theta_1 - l_2 \sin(\theta_1 + \theta_2) & -l_2 \sin(\theta_1 + \theta_2) \\ l_1 \cos\theta_1 + l_2 \cos(\theta_1 + \theta_2) & l_2 \cos(\theta_1 + \theta_2) \end{bmatrix}}$$
derive the **Jacobian Determinant Formulation ($\det(J)$)**:
$$\mathbf{\det(J(q)) = l_1 l_2 \sin\theta_2 \quad \left[\text{m}^2\right]}$$
derive the **Kinematic Singularity Condition**:
$$\mathbf{\det(J(q)) = 0 \Longleftrightarrow \sin\theta_2 = 0 \implies \mathbf{\theta_2 = 0^\circ \ (\text{Fully Outstretched}) \quad \text{or} \quad \theta_2 = 180^\circ \ (\text{Fully Folded})}}$$
derive the **Yoshikawa Manipulability Measure ($w$)**:
$$\mathbf{w = \sqrt{\det\left( J(q) \cdot J^T(q) \right)} = |\det(J(q))| = l_1 l_2 |\sin\theta_2| \quad (w_{\text{max}} \text{ at } \theta_2 = \pm 90^\circ)}$$
(proving that at a singular configuration $\theta_2 = 0^\circ$, the robot loses the ability to generate radial velocity along the arm axis regardless of joint torques applied).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Geometric Jacobian ($J(q)\dot{q} = \vec{v}$), $\det(J) = l_1 l_2 \sin\theta_2$ & Singularities ($\theta_2 = 0^\circ, 180^\circ$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Formulate the Jacobian Matrix, Compute Its Determinant, and Identify Singular Postures Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Differential Kinematics Construct / Velocity Matrix Entity & Technical Robotics Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | A Robotic Manipulator Configuration Where the Determinant of the Jacobian Matrix Equals Zero ($\det(J) = 0$), Causing a Loss of at Least One Degree of Freedom, Is Defined as a Kinematic ___ (Singularity / Singular Configuration) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Robotics Velocity Control Problem: Computing Jacobian Matrix and End-Effector Velocity (vx, vy) for a 2-Link Arm Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Differential Kinematics & Singularities Mechanics (Craig 2018; Spong 2020; Yoshikawa 1985):
   - **Jacobian Formulations:**
     $$\mathbf{J(q) = \begin{bmatrix} -l_1 s_1 - l_2 s_{12} & -l_2 s_{12} \\ l_1 c_1 + l_2 c_{12} & l_2 c_{12} \end{bmatrix} \quad \Big| \quad \det(J) = l_1 l_2 \sin\theta_2 \quad \Big| \quad w = l_1 l_2 |\sin\theta_2|}$$
   - **Kinematic Singularity Classification Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Singularity Category} & \textbf{Physical Mechanism in Manipulator} & \textbf{Operational Consequence} \\
     \hline
     \mathbf{\text{Boundary Singularity}} & \mathbf{\theta_2 = 0^\circ \text{ (Arm outstretched to maximum reach } l_1 + l_2\text{)}} & \mathbf{\text{Cannot move radially outward in task space}} \\
     \text{Boundary Singularity} & \theta_2 = 180^\circ \text{ (Arm folded onto itself at } |l_1 - l_2|\text{)} & Cannot move radially inward in task space \\
     \mathbf{\text{Wrist Singularity}} & \text{Axes } 4, 6 \text{ align in spherical wrist } (\theta_5 = 0^\circ) & \mathbf{\text{Infinite angular speed required for yaw rotation}} \\
     \hline
     \end{array}$$
   - **The Velocity Inversion Invariant:** Inverting the Jacobian $\dot{\vec{q}} = J^{-1} \vec{v}_e$ near a singularity divides by $\det(J) \to 0$, commanding **infinitely large joint speeds that trip actuator torque and velocity limiters**!
2. **Slide 2 (`ordering`):** Provide 5 steps of Jacobian velocity analysis: (1) determine link lengths $l_1, l_2$ and current joint positions $\theta_1, \theta_2$, (2) formulate partial derivatives $\partial p / \partial q$ to construct the $2\times 2$ planar Jacobian matrix $J(q)$, (3) evaluate the determinant: $\det(J(q)) = l_1 l_2 \sin\theta_2$, (4) verify non-singularity condition $\det(J) \neq 0$ and calculate Yoshikawa manipulability $w = |\det(J)|$, (5) multiply Jacobian by joint velocity vector $\dot{q} = [\dot{\theta}_1, \dot{\theta}_2]^T$ to compute end-effector Cartesian velocities: $[v_x, v_y]^T = J(q) \cdot \dot{q}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Geometric Jacobian $J(q)$, Kinematic Singularity $\det(J)=0$, Yoshikawa Manipulability $w$, Wrist Singularity) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Singularity (or Singular Configuration). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on computing Jacobian and end-effector velocities: A 2-link planar arm ($l_1 = 0.500\text{ m}, l_2 = 0.500\text{ m}$) operates at configuration $\theta_1 = 0.0^\circ$ ($\cos 0^\circ = 1.0, \sin 0^\circ = 0.0$) and $\theta_2 = 90.0^\circ$ ($\theta_{12} = 90^\circ \implies \cos 90^\circ = 0.0, \sin 90^\circ = 1.0$).
   - Jacobian elements:
     $J_{11} = -l_1 \sin\theta_1 - l_2 \sin\theta_{12} = -0.5(0) - 0.5(1.0) = \mathbf{-0.500\text{ m}}$;
     $J_{12} = -l_2 \sin\theta_{12} = -0.5(1.0) = \mathbf{-0.500\text{ m}}$;
     $J_{21} = l_1 \cos\theta_1 + l_2 \cos\theta_{12} = 0.5(1.0) + 0.5(0) = \mathbf{+0.500\text{ m}}$;
     $J_{22} = l_2 \cos\theta_{12} = 0.5(0) = \mathbf{0.000\text{ m}}$;
     $$J(q) = \begin{bmatrix} -0.500 & -0.500 \\ 0.500 & 0.000 \end{bmatrix}$$
   - Determinant: $\det(J) = (-0.5)(0) - (-0.5)(0.5) = \mathbf{+0.250\text{ m}^2} = l_1 l_2 \sin(90^\circ) = 0.5 \times 0.5 \times 1 = \mathbf{0.250\text{ m}^2}$ (Maximum manipulability!);
   - When joint motors rotate at $\dot{\theta}_1 = 1.00\text{ rad/s}$ and $\dot{\theta}_2 = 2.00\text{ rad/s}$:
     $v_x = (-0.500 \times 1.00) + (-0.500 \times 2.00) = -0.500 - 1.000 = \mathbf{-1.500\text{ m/s}}$;
     $v_y = (0.500 \times 1.00) + (0.000 \times 2.00) = \mathbf{+0.500\text{ m/s}}$;
   - What are the end-effector Cartesian velocities $(v_x, v_y)$? ($v_x = \mathbf{-1.50\text{ m/s}}$ and $v_y = \mathbf{+0.50\text{ m/s}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "geometric_jacobian_matrix_and_kinematic_singularities",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Differential Kinematics \\& Jacobian Singularities (Craig)**\n• **Planar 2-Link Geometric Jacobian Matrix Formulation:**\n$$\n\\mathbf{J(q) = \\begin{bmatrix} -l_1 \\sin\\theta_1 - l_2 \\sin(\\theta_1 + \\theta_2) & -l_2 \\sin(\\theta_1 + \\theta_2) \\\\ l_1 \\cos\\theta_1 + l_2 \\cos(\\theta_1 + \\theta_2) & l_2 \\cos(\\theta_1 + \\theta_2) \\end{bmatrix} \\quad \\Big| \\quad \\begin{bmatrix} v_x \\\\ v_y \\end{bmatrix} = J(q) \\begin{bmatrix} \\dot{\\theta}_1 \\\\ \\dot{\\theta}_2 \\end{bmatrix}}\n$$\n• **Jacobian Determinant \\& Singularity Condition:**\n$$\n\\mathbf{\\det(J(q)) = l_1 l_2 \\sin\\theta_2 \\implies \\det(J) = 0 \\iff \\theta_2 = 0^\\circ \\quad \\text{or} \\quad \\theta_2 = 180^\\circ}\n$$\n• **Yoshikawa Manipulability Measure Formulation ($w$):**\n$$\n\\mathbf{w = \\sqrt{\\det\\left( J \\cdot J^T \\right)} = |\\det(J)| = l_1 l_2 |\\sin\\theta_2| \\quad (w_{\\text{max}} \\text{ at } \\theta_2 = \\pm 90^\\circ)}\n$$\n• **The Singularity Inversion Invariant:** At a singular posture ($\\det(J) = 0$), the manipulator **loses at least one Cartesian degree of freedom**; inverting $\\dot{\\vec{q}} = J^{-1} \\vec{v}_e$ demands infinite joint speeds, causing controller instability and motor torque trips!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to evaluate the Jacobian velocity mapping and check for kinematic singularities in a robot arm.",
      "orderItems": [
        "Extract current joint angles (\u03b81, \u03b82) and link lengths (l1, l2) of the manipulator",
        "Formulate the 2\u00d72 geometric Jacobian matrix J(q) by taking partial derivatives of forward kinematics equations",
        "Calculate the Jacobian determinant: det(J) = l1 * l2 * sin\u03b82",
        "Verify that det(J) \u2260 0 to ensure the robot is operating away from boundary singularities (\u03b82 = 0\u00b0 or 180\u00b0)",
        "Multiply the Jacobian matrix by the joint velocity vector: [vx, vy]^T = J(q) * [\u03b8\u03071, \u03b8\u03072]^T to obtain task-space speed"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Differential Kinematics Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Geometric Jacobian J(q)", "right": "Linear transformation matrix mapping joint space velocities to Cartesian end-effector translational and angular speeds" },
        { "left": "Kinematic Singularity", "right": "Manipulator configuration where det(J) = 0, causing loss of instantaneous mobility along specific Cartesian directions" },
        { "left": "Boundary Singularity (\u03b82 = 0\u00b0)", "right": "Fully outstretched arm configuration at outer workspace envelope where radial velocity cannot be generated" },
        { "left": "Yoshikawa Manipulability (w)", "right": "w = |\u221a[det(J*J^T)]| = l1*l2*|sin\u03b82|, scalar measure of dexterity quantifying distance from singularity" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A robotic manipulator configuration where the determinant of the Jacobian matrix equals zero (det(J) = 0), causing a loss of at least one degree of freedom, is defined as a kinematic ___.",
      "blankAnswer": "singularity",
      "blankDistractors": ["redundancy", "homogeneity", "continuity"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 2-link planar arm (l1 = 0.500 m, l2 = 0.500 m) is at \u03b81 = 0.0\u00b0 and \u03b82 = 90.0\u00b0 (\u03b812 = 90.0\u00b0). J11 = -0.500, J12 = -0.500, J21 = 0.500, and J22 = 0.000. det(J) = 0.5*0.5*sin 90\u00b0 = 0.250 m^2. Joint velocities are \u03b8\u03071 = 1.00 rad/s and \u03b8\u03072 = 2.00 rad/s. vx = -0.500*1 - 0.500*2 = -1.500 m/s. vy = 0.500*1 + 0*2 = 0.500 m/s. What are the end-effector Cartesian velocities (vx, vy)?",
      "options": [
        { "text": "vx = -1.50 m/s and vy = +0.50 m/s (vx = -0.500 - 1.000 = -1.500 m/s; vy = 0.500 + 0 = +0.500 m/s)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the 2-link planar Jacobian differential velocity equations (John J. Craig *Introduction to Robotics: Mechanics and Control* Chapter 5; Mark W. Spong et al. *Robot Modeling and Control* Chapter 4). 1. **Identify Joint Posture \\& Kinematic Quantities:** - Link lengths: $l_1 = 0.500\\text{ m}, \\quad l_2 = 0.500\\text{ m}$. - Joint angles: $\\theta_1 = 0.0^\\circ \\implies \\cos(0^\\circ) = 1.000, \\quad \\sin(0^\\circ) = 0.000$. - Compound angle: $\\theta_{12} = 0.0^\\circ + 90.0^\\circ = 90.0^\\circ \\implies \\cos(90^\\circ) = 0.000, \\quad \\sin(90^\\circ) = 1.000$. 2. **Construct the $2\\times 2$ Jacobian Matrix ($J(q)$):** $$J_{11} = -l_1 \\sin\\theta_1 - l_2 \\sin\\theta_{12} = -0.500(0.000) - 0.500(1.000) = \\mathbf{-0.500\\text{ m}}$$ $$J_{12} = -l_2 \\sin\\theta_{12} = -0.500(1.000) = \\mathbf{-0.500\\text{ m}}$$ $$J_{21} = l_1 \\cos\\theta_1 + l_2 \\cos\\theta_{12} = 0.500(1.000) + 0.500(0.000) = \\mathbf{+0.500\\text{ m}}$$ $$J_{22} = l_2 \\cos\\theta_{12} = 0.500(0.000) = \\mathbf{0.000\\text{ m}}$$ $$J(q) = \\begin{bmatrix} -0.500 & -0.500 \\\\ 0.500 & 0.000 \\end{bmatrix}$$ - Determinant check: $\\det(J) = l_1 l_2 \\sin(90^\\circ) = 0.500 \\times 0.500 \\times 1.000 = \\mathbf{0.250\\text{ m}^2}$ (Maximum manipulability, far from singularity). 3. **Calculate Cartesian End-Effector Velocities ($v_x, v_y$):** - Joint rates: $\\dot{\\theta}_1 = 1.00\\text{ rad/s}, \\quad \\dot{\\theta}_2 = 2.00\\text{ rad/s}$. $$v_x = J_{11} \\dot{\\theta}_1 + J_{12} \\dot{\\theta}_2 = (-0.500\\text{ m} \\times 1.00\\text{ rad/s}) + (-0.500\\text{ m} \\times 2.00\\text{ rad/s})$$ $$v_x = -0.500 - 1.000 = \\mathbf{-1.500\\text{ m/s} = -1.50\\text{ m/s}}$$ $$v_y = J_{21} \\dot{\\theta}_1 + J_{22} \\dot{\\theta}_2 = (+0.500\\text{ m} \\times 1.00\\text{ rad/s}) + (0.000\\text{ m} \\times 2.00\\text{ rad/s})$$ $$v_y = +0.500 + 0.000 = \\mathbf{+0.500\\text{ m/s} = +0.50\\text{ m/s}}$$ Flawless robot Jacobian differential velocity derivation!" },
        { "text": "vx = -0.50 m/s and vy = +1.50 m/s (Swapped vx and vy)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "vx = 0.00 m/s and vy = 0.00 m/s (Assumed singular stop)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "vx = -1.00 m/s and vy = +1.00 m/s", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
