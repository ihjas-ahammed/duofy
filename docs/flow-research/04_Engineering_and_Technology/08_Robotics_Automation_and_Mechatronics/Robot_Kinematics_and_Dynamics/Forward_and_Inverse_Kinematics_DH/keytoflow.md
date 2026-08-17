# Key to Flow: Robot Kinematics & Dynamics (DH Matrices, IK, Jacobians, & Torques)

**Subject Area:** `04_Engineering_and_Technology / 08_Robotics_Automation_and_Mechatronics / Robot_Kinematics_and_Dynamics / Forward_and_Inverse_Kinematics_DH`

---

## 📌 Core Concept & Mental Model
**Robotics Manipulator Mechanics & Multibody Dynamics: The Standard Denavit-Hartenberg (DH) 4-Parameter Convention ($\theta_i, d_i, a_i, \alpha_i$), Homogeneous Link Transformation Matrices ($^{i-1}T_i$), Forward Kinematics Chain ($^0T_n = \prod {^{i-1}T_i}$), Analytical & Geometric Inverse Kinematics (Law of Cosines, Elbow-Up vs Elbow-Down Solutions), The Geometric Jacobian Matrix ($J(q) = [\vec{J}_v; \vec{J}_\omega]$ mapping $\dot{\vec{q}} \mapsto \vec{v}_e$), Kinematic Singularities ($\det(J(q)) = 0$ / Loss of Mobility), Yoshikawa Manipulability ($w = \sqrt{\det(J J^T)}$), and Closed-Form Euler-Lagrange Robot Dynamics ($M(q)\ddot{\vec{q}} + C(q, \dot{q})\dot{\vec{q}} + \vec{g}(q) = \vec{\tau}$)** govern industrial articulated robotic arms (KUKA, ABB, Fanuc), collaborative cobots (UR5), surgical da Vinci manipulators, and autonomous mobile manipulators (John J. Craig *Introduction to Robotics: Mechanics and Control* 4th ed. Chapters 3, 4, 5, 6; Mark W. Spong, Seth Hutchinson, M. Vidyasagar *Robot Modeling and Control* 2nd ed. Chapters 2, 3, 4, 7; Bruno Siciliano et al. *Robotics: Modelling, Planning and Control* Chapters 2, 3, 7; Jacques Denavit & Richard S. Hartenberg 1955):
* **1. Standard Denavit-Hartenberg (DH) Transformation Matrix Master Formulation:**
  $$\mathbf{^{i-1}T_i = \text{Rot}(z, \theta_i) \text{Trans}(z, d_i) \text{Trans}(x, a_i) \text{Rot}(x, \alpha_i) = \begin{bmatrix} \cos\theta_i & -\sin\theta_i \cos\alpha_i & \sin\theta_i \sin\alpha_i & a_i \cos\theta_i \\ \sin\theta_i & \cos\theta_i \cos\alpha_i & -\cos\theta_i \sin\alpha_i & a_i \sin\theta_i \\ 0 & \sin\alpha_i & \cos\alpha_i & d_i \\ 0 & 0 & 0 & 1 \end{bmatrix}}$$
* **2. 2-Link Planar Arm Inverse Kinematics Formulation ($x, y \to \theta_1, \theta_2$):**
  $$\mathbf{\cos\theta_2 = \frac{x^2 + y^2 - l_1^2 - l_2^2}{2 l_1 l_2} \quad \Big| \quad \mathbf{\theta_2 = \text{atan2}\left( \pm \sqrt{1 - \cos^2\theta_2}, \cos\theta_2 \right)}}$$
  $$\mathbf{\theta_1 = \text{atan2}(y, x) - \text{atan2}\left( l_2 \sin\theta_2, l_1 + l_2 \cos\theta_2 \right)}$$
* **3. Geometric Jacobian Matrix & Velocity Mapping:**
  $$\mathbf{\begin{bmatrix} \dot{\vec{p}}_e \\ \vec{\omega}_e \end{bmatrix} = J(q) \cdot \dot{\vec{q}} \quad \Big| \quad \mathbf{\det(J(q)) = 0 \iff \text{Kinematic Singularity (DOF Lost)}}}$$
  - Revolute Joint Column: $\vec{J}_{vi} = \vec{z}_{i-1} \times (\vec{p}_e - \vec{p}_{i-1})$, $\vec{J}_{\omega i} = \vec{z}_{i-1}$;
* **4. Euler-Lagrange Robot Manipulator Equations of Motion:**
  $$\mathbf{M(q) \ddot{\vec{q}} + C(q, \dot{q}) \dot{\vec{q}} + \vec{g}(q) = \vec{\tau} \quad [\text{Joint Motor Torques in N}\cdot\text{m}]}$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Robotics Kinematics & Dynamics Problem-Solving Spectrum
* The 4 DH Parameters Rule of Thumb $\to$
  1. $a_i$ (Link length): Distance along $x_i$ from $z_{i-1}$ to $z_i$;
  2. $\alpha_i$ (Link twist): Angle about $x_i$ from $z_{i-1}$ to $z_i$;
  3. $d_i$ (Link offset): Distance along $z_{i-1}$ from $x_{i-1}$ to $x_i$ (variable in prismatic joints);
  4. $\theta_i$ (Joint angle): Angle about $z_{i-1}$ from $x_{i-1}$ to $x_i$ (variable in revolute joints).
* Forward vs Inverse Kinematics $\to$
  - **Forward Kinematics (FK):** Unambiguous, unique linear matrix multiplications yielding end-effector pose $^0T_n = {^0T_1} {^1T_2} \cdots {^{n-1}T_n}$.
  - **Inverse Kinematics (IK):** Non-linear trigonometric equations that often yield **multiple geometric branches** (e.g. elbow-up vs elbow-down) or zero solutions if the target $(x,y,z)$ lies outside the robot's reachable workspace radius ($r > l_1 + l_2$).
* The Jacobian Singularity Hazard $\to$ When $\det(J(q)) = 0$, the manipulator reaches a boundary (e.g. arm fully outstretched $\theta_2 = 0$) or interior singularity (axes alignment). Moving in the singular Cartesian direction requires **infinite joint speeds ($\dot{\vec{q}} = J^{-1} \vec{v}_e \to \infty$)**, triggering motor over-current trip faults!
* Robot Dynamics Triad ($M, C, g$) $\to$
  - $M(q)\ddot{q}$: Symmetric positive-definite mass/inertia matrix (instantaneous kinetic resistance);
  - $C(q,\dot{q})\dot{q}$: Non-linear Coriolis and centrifugal interaction forces coupling multiple rotating links;
  - $g(q)$: Static gravity vector requiring active counter-balance torque holding current posture.

### 2. Top Recommended Resources
* **The Global Robotics Standard:** *Introduction to Robotics: Mechanics and Control* (John J. Craig, Pearson 4th ed. Chapters 3, 4, 5, 6).
* **The Modeling & Control Classic:** *Robot Modeling and Control* (Mark W. Spong, Seth Hutchinson, M. Vidyasagar, Wiley 2nd ed.).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you assign DH coordinate frames and tabulate the 4 DH parameters ($\theta, d, a, \alpha$) for an $n$-DOF robot?
- [ ] Can you solve forward kinematics by multiplying homogeneous transformation matrices $^{i-1}T_i$?
- [ ] Can you compute analytical inverse kinematics for a 2-link planar arm (elbow-up and elbow-down)?
- [ ] Can you derive the geometric Jacobian matrix $J(q)$ and identify singular joint configurations where $\det(J) = 0$?
- [ ] Can you formulate the Euler-Lagrange equations of motion $M(q)\ddot{q} + C(q,\dot{q})\dot{q} + g(q) = \tau$?
