# Duofy Reusable Lesson Format: Robot Kinematics (Denavit-Hartenberg & Forward Kinematics)

**Target Topic:** `04_Engineering_and_Technology / 08_Robotics_Automation_and_Mechatronics / Robot_Kinematics_and_Dynamics / Forward_and_Inverse_Kinematics_DH`  
**Lesson Format Type:** `denavit_hartenberg_dh_parameters_and_forward_kinematics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the systematic kinematic modeling of serial articulated robot manipulators, Jacques Denavit and Richard S. Hartenberg's 1955 **Standard Denavit-Hartenberg (DH) 4-Parameter Convention**, frame attachment rules ($z_i$ along joint axis, $x_i$ along common normal), the four geometric link parameters ($\theta_i$: joint angle, $d_i$: link offset, $a_i$: link length, $\alpha_i$: link twist), individual link homogeneous transformation matrices ($^{i-1}T_i$), and the **Forward Kinematics Chain ($^0T_n = \prod_{i=1}^n {^{i-1}T_i}$)** computing end-effector position and orientation from joint coordinates (John J. Craig *Introduction to Robotics: Mechanics and Control* 4th ed. Chapter 3; Mark W. Spong, Seth Hutchinson, M. Vidyasagar *Robot Modeling and Control* 2nd ed. Chapter 3; Jacques Denavit & Richard S. Hartenberg 1955): formulate the **Standard DH Single-Link Homogeneous Transformation Matrix Master Formulation**:
$$\mathbf{^{i-1}T_i = \text{Rot}(z, \theta_i) \text{Trans}(z, d_i) \text{Trans}(x, a_i) \text{Rot}(x, \alpha_i) = \begin{bmatrix} \cos\theta_i & -\sin\theta_i \cos\alpha_i & \sin\theta_i \sin\alpha_i & a_i \cos\theta_i \\ \sin\theta_i & \cos\theta_i \cos\alpha_i & -\cos\theta_i \sin\alpha_i & a_i \sin\theta_i \\ 0 & \sin\alpha_i & \cos\alpha_i & d_i \\ 0 & 0 & 0 & 1 \end{bmatrix}}$$
where for an $n$-DOF serial manipulator:
$$\mathbf{^0T_n = {^0T_1} \cdot {^1T_2} \cdot {^2T_3} \cdots {^{n-1}T_n} = \begin{bmatrix} r_{11} & r_{12} & r_{13} & p_x \\ r_{21} & r_{22} & r_{23} & p_y \\ r_{31} & r_{32} & r_{33} & p_z \\ 0 & 0 & 0 & 1 \end{bmatrix}}$$
where:
1. **$\vec{p} = [p_x, p_y, p_z]^T$:** Cartesian position vector of the end-effector tip;
2. **$R = [r_{ij}]_{3\times 3}$:** $3\times 3$ orthonormal rotation matrix defining end-effector orientation;
for a 2-link planar revolute robot arm ($a_1 = l_1, a_2 = l_2, \alpha_1 = 0, \alpha_2 = 0, d_1 = 0, d_2 = 0$):
$$\mathbf{p_x = l_1 \cos\theta_1 + l_2 \cos(\theta_1 + \theta_2) \quad \Big| \quad \mathbf{p_y = l_1 \sin\theta_1 + l_2 \sin(\theta_1 + \theta_2)} \quad \Big| \quad \phi = \theta_1 + \theta_2}$$
(proving that multiplying $4\times 4$ DH transformation matrices systematically maps all joint angles $q = [\theta_1, \dots, \theta_n]^T$ into Cartesian end-effector workspace coordinates).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Standard DH Parameters ($\theta_i, d_i, a_i, \alpha_i$), Link Matrix $^{i-1}T_i$ & Forward Kinematics Chain ($^0T_n = \prod {^{i-1}T_i}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Assign DH Frames, Construct the DH Parameter Table, and Calculate End-Effector Position Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Denavit-Hartenberg Parameter / Kinematic Construct & Technical Robotics Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Standard Denavit-Hartenberg Convention, the Link Length Parameter $a_i$ Is Formally Defined as the Distance from Axis $z_{i-1}$ to Axis $z_i$ Measured Along the Axis ___ (x_i / xi / Common Normal) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Robotics Kinematics Problem: Computing Forward Kinematics End-Effector Coordinates (px, py) for a 2-Link Planar Arm Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Denavit-Hartenberg Forward Kinematics Mechanics (Craig 2018; Spong 2020; Denavit & Hartenberg 1955):
   - **DH Transformation Formulations:**
     $$\mathbf{^{i-1}T_i = \begin{bmatrix} c_{\theta_i} & -s_{\theta_i} c_{\alpha_i} & s_{\theta_i} s_{\alpha_i} & a_i c_{\theta_i} \\ s_{\theta_i} & c_{\theta_i} c_{\alpha_i} & -c_{\theta_i} s_{\alpha_i} & a_i s_{\theta_i} \\ 0 & s_{\alpha_i} & c_{\alpha_i} & d_i \\ 0 & 0 & 0 & 1 \end{bmatrix} \quad \Big| \quad ^0T_n = \prod_{i=1}^n {^{i-1}T_i}}$$
   - **The 4 DH Parameters Definition Matrix:**
     $$\begin{array}{|c|l|l|l|}
     \hline
     \textbf{DH Parameter} & \textbf{Physical Meaning} & \textbf{Geometric Axis of Measurement} & \textbf{Joint Type Variable} \\
     \hline
     \mathbf{\theta_i} & \mathbf{\text{Joint Angle}} & \mathbf{\text{Rotation about } z_{i-1} \text{ from } x_{i-1} \text{ to } x_i} & \mathbf{\text{Variable for Revolute Joint}} \\
     \mathbf{d_i} & \mathbf{\text{Link Offset}} & \mathbf{\text{Translation along } z_{i-1} \text{ from } O_{i-1} \text{ to } x_i} & \mathbf{\text{Variable for Prismatic Joint}} \\
     \mathbf{a_i} & \mathbf{\text{Link Length}} & \mathbf{\text{Translation along } x_i \text{ from } z_{i-1} \text{ to } z_i \text{ (Common Normal)}} & \text{Fixed geometric constant} \\
     \mathbf{\alpha_i} & \mathbf{\text{Link Twist}} & \mathbf{\text{Rotation about } x_i \text{ from } z_{i-1} \text{ to } z_i} & \text{Fixed geometric constant} \\
     \hline
     \end{array}$$
   - **The Common Normal Invariant:** Axis $x_i$ is **strictly orthogonal to both $z_{i-1}$ and $z_i$**, lying along their unique mutual perpendicular (common normal)!
2. **Slide 2 (`ordering`):** Provide 5 steps of DH forward kinematics derivation: (1) assign $z_i$ axes along each joint's axis of rotation/translation, (2) establish $x_i$ axes along the common normal between $z_{i-1}$ and $z_i$, (3) extract the 4 DH parameters ($\theta_i, d_i, a_i, \alpha_i$) into the DH parameter table, (4) evaluate the individual homogeneous transformation matrix $^{i-1}T_i$ for each link, (5) multiply link matrices consecutively: $^0T_n = {^0T_1} {^1T_2} \cdots {^{n-1}T_n}$ to extract end-effector Cartesian coordinates $\vec{p}$ and orientation matrix $R$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Joint Angle $\theta_i$, Link Offset $d_i$, Link Length $a_i$, Link Twist $\alpha_i$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of x_i (or xi / Common Normal). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating 2-link planar arm forward kinematics: A 2-link planar robot arm has link lengths $l_1 = 0.500\text{ m}$ and $l_2 = 0.400\text{ m}$. The joints are positioned at $\theta_1 = 30.0^\circ$ ($\cos 30^\circ = 0.86603, \sin 30^\circ = 0.50000$) and $\theta_2 = 45.0^\circ$ ($\theta_1 + \theta_2 = 75.0^\circ \implies \cos 75^\circ = 0.25882, \sin 75^\circ = 0.96593$).
   - End-effector X-coordinate:
     $p_x = l_1 \cos\theta_1 + l_2 \cos(\theta_1 + \theta_2) = (0.500 \times 0.86603) + (0.400 \times 0.25882) = 0.43301 + 0.10353 = \mathbf{0.53654\text{ m} \approx 0.537\text{ m}}$;
   - End-effector Y-coordinate:
     $p_y = l_1 \sin\theta_1 + l_2 \sin(\theta_1 + \theta_2) = (0.500 \times 0.50000) + (0.400 \times 0.96593) = 0.25000 + 0.38637 = \mathbf{0.63637\text{ m} \approx 0.636\text{ m}}$;
   - Total orientation angle: $\phi = 30^\circ + 45^\circ = \mathbf{75.0^\circ}$;
   - What are the Cartesian end-effector coordinates $(p_x, p_y)$ of the robot arm? ($p_x = \mathbf{0.537\text{ m}}$ and $p_y = \mathbf{0.636\text{ m}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "denavit_hartenberg_dh_parameters_and_forward_kinematics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Denavit-Hartenberg (DH) Forward Kinematics (Craig \\& Spong)**\n• **Standard DH Single-Link Homogeneous Transformation Matrix Formulation:**\n$$\n\\mathbf{^{i-1}T_i = \\begin{bmatrix} \\cos\\theta_i & -\\sin\\theta_i \\cos\\alpha_i & \\sin\\theta_i \\sin\\alpha_i & a_i \\cos\\theta_i \\\\ \\sin\\theta_i & \\cos\\theta_i \\cos\\alpha_i & -\\cos\\theta_i \\sin\\alpha_i & a_i \\sin\\theta_i \\\\ 0 & \\sin\\alpha_i & \\cos\\alpha_i & d_i \\\\ 0 & 0 & 0 & 1 \\end{bmatrix}}\n$$\n• **The 4 Fundamental DH Parameters:**\n  - **$\\theta_i$ (Joint Angle):** Rotation about $z_{i-1}$ from $x_{i-1}$ to $x_i$ (variable for revolute joints);\n  - **$d_i$ (Link Offset):** Translation along $z_{i-1}$ from $O_{i-1}$ to $x_i$ (variable for prismatic joints);\n  - **$a_i$ (Link Length):** Translation along $x_i$ from $z_{i-1}$ to $z_i$ along the common normal;\n  - **$\\alpha_i$ (Link Twist):** Rotation about $x_i$ from $z_{i-1}$ to $z_i$;\n• **Forward Kinematics Chain Formulation:**\n$$\n\\mathbf{^0T_n = {^0T_1} \\cdot {^1T_2} \\cdots {^{n-1}T_n} = \\begin{bmatrix} R_{3\\times 3} & \\vec{p} \\\\ \\vec{0} & 1 \\end{bmatrix}}\n$$\n• **The Common Normal Invariant:** Coordinate axis $x_i$ is **strictly perpendicular to both joint axes $z_{i-1}$ and $z_i$**, ensuring a unique 4-parameter representation between arbitrary spatial linkages!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to establish Denavit-Hartenberg coordinate frames and solve forward kinematics for a serial robot arm.",
      "orderItems": [
        "Align coordinate axis z_i along the actuation axis of motion (rotation or translation) for every joint i",
        "Establish axis x_i along the common normal perpendicular to both z_{i-1} and z_i, pointing from z_{i-1} toward z_i",
        "Extract the 4 DH parameters (\u03b8i, di, ai, \u03b1i) for each link and populate the master DH parameter table",
        "Substitute link parameters into the standard 4\u00d74 DH transformation matrix to construct ^{i-1}T_i for every link",
        "Multiply link matrices consecutively: ^0T_n = ^0T_1 * ^1T_2 * ... * ^{n-1}T_n to obtain end-effector pose [R | p]"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Denavit-Hartenberg Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Joint Angle (\u03b8i)", "right": "Rotation about z_{i-1} from x_{i-1} to x_i acting as the generalized joint coordinate for revolute joints" },
        { "left": "Link Offset (di)", "right": "Distance along z_{i-1} from origin O_{i-1} to intersection with x_i (variable for prismatic joints)" },
        { "left": "Link Length (ai)", "right": "Perpendicular distance along common normal x_i connecting axis z_{i-1} to axis z_i" },
        { "left": "Link Twist (\u03b1i)", "right": "Angle of rotation about common normal x_i from axis z_{i-1} to axis z_i" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the standard Denavit-Hartenberg convention, the link length parameter ai is formally defined as the distance from axis z_{i-1} to axis zi measured along the axis ___.",
      "blankAnswer": "x_i",
      "blankDistractors": ["z_i", "y_i", "z_{i-1}"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 2-link planar arm has l1 = 0.500 m and l2 = 0.400 m. Joints are set at \u03b81 = 30.0\u00b0 (cos 30\u00b0 = 0.8660, sin 30\u00b0 = 0.5000) and \u03b82 = 45.0\u00b0 (\u03b81+\u03b82 = 75.0\u00b0 \u2192 cos 75\u00b0 = 0.2588, sin 75\u00b0 = 0.9659). px = 0.500*0.8660 + 0.400*0.2588 = 0.4330 + 0.1035 = 0.5365 m. py = 0.500*0.5000 + 0.400*0.9659 = 0.2500 + 0.3864 = 0.6364 m. What are the end-effector Cartesian coordinates (px, py)?",
      "options": [
        { "text": "px = 0.537 m and py = 0.636 m (px = 0.4330 + 0.1035 = 0.5365 m \u2248 0.537 m; py = 0.2500 + 0.3864 = 0.6364 m \u2248 0.636 m)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the 2-link planar forward kinematics equations (John J. Craig *Introduction to Robotics: Mechanics and Control* Chapter 3; Mark W. Spong et al. *Robot Modeling and Control* Chapter 3). 1. **Identify Link Geometric Parameters \\& Joint Angles:** - Link 1 length: $l_1 = 0.500\\text{ m}$. - Link 2 length: $l_2 = 0.400\\text{ m}$. - Joint 1 angle: $\\theta_1 = 30.0^\\circ \\implies \\cos(30^\\circ) = 0.866025, \\quad \\sin(30^\\circ) = 0.500000$. - Joint 2 angle: $\\theta_2 = 45.0^\\circ$. - Compound angle: $\\theta_{12} = \\theta_1 + \\theta_2 = 30^\\circ + 45^\\circ = 75.0^\\circ$. $$\\cos(75^\\circ) = 0.258819 \\quad \\Big| \\quad \\sin(75^\\circ) = 0.965926$$ 2. **Calculate End-Effector $X$-Coordinate ($p_x$):** $$p_x = l_1 \\cos\\theta_1 + l_2 \\cos(\\theta_1 + \\theta_2)$$ $$p_x = (0.500\\text{ m} \\times 0.866025) + (0.400\\text{ m} \\times 0.258819)$$ $$p_x = 0.433013\\text{ m} + 0.103528\\text{ m} = \\mathbf{0.536541\\text{ m} \\approx 0.537\\text{ m}}$$ 3. **Calculate End-Effector $Y$-Coordinate ($p_y$):** $$p_y = l_1 \\sin\\theta_1 + l_2 \\sin(\\theta_1 + \\theta_2)$$ $$p_y = (0.500\\text{ m} \\times 0.500000) + (0.400\\text{ m} \\times 0.965926)$$ $$p_y = 0.250000\\text{ m} + 0.386370\\text{ m} = \\mathbf{0.636370\\text{ m} \\approx 0.636\\text{ m}}$$ Flawless 2-link planar forward kinematics position derivation!" },
        { "text": "px = 0.636 m and py = 0.537 m (Swapped X and Y axes)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "px = 0.900 m and py = 0.000 m (Assumed fully extended arm along X axis)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "px = 0.433 m and py = 0.250 m (Calculated joint 1 position only without link 2)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
