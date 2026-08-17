# Duofy Reusable Lesson Format: Inverse Kinematics (2-Link Analytical & Multiple Postures)

**Target Topic:** `04_Engineering_and_Technology / 08_Robotics_Automation_and_Mechatronics / Robot_Kinematics_and_Dynamics / Forward_and_Inverse_Kinematics_DH`  
**Lesson Format Type:** `two_link_planar_arm_analytical_inverse_kinematics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the non-linear algebraic and geometric derivation of robot **Inverse Kinematics (IK)**, calculating required joint angles $q = [\theta_1, \theta_2]^T$ from a target Cartesian end-effector position $(x, y)$, the geometric **Law of Cosines**, reachable workspace boundary conditions ($|l_1 - l_2| \le \sqrt{x^2 + y^2} \le l_1 + l_2$), the physical meaning of multiple inverse kinematic branches (**Elbow-Up vs Elbow-Down** configurations), and robust four-quadrant arctangent formulation ($\text{atan2}$) (John J. Craig *Introduction to Robotics: Mechanics and Control* 4th ed. Chapter 4; Mark W. Spong, Seth Hutchinson, M. Vidyasagar *Robot Modeling and Control* 2nd ed. Chapter 4): formulate the **2-Link Planar Arm Inverse Kinematics Master Formulation**:
$$\mathbf{\cos\theta_2 = \frac{x^2 + y^2 - l_1^2 - l_2^2}{2 l_1 l_2} \quad \left(-1.0 \le \cos\theta_2 \le 1.0\right)}$$
derive the **Dual Joint 2 Angle Solutions ($\theta_2$)**:
$$\mathbf{\theta_2 = \text{atan2}\left( \pm \sqrt{1 - \cos^2\theta_2}, \cos\theta_2 \right) \quad \begin{cases} +\theta_2 & \text{Elbow-Down Posture} \\ -\theta_2 & \text{Elbow-Up Posture} \end{cases}}}$$
derive the **Joint 1 Angle Formulation ($\theta_1$)**:
$$\mathbf{\theta_1 = \text{atan2}(y, x) - \text{atan2}\left( l_2 \sin\theta_2, l_1 + l_2 \cos\theta_2 \right)}$$
master the **Reachable Workspace & Posture Branch Matrix**:
$$\begin{array}{|l|l|l|}
\hline
\textbf{Workspace Condition} & \textbf{Mathematical Test} & \textbf{Kinematic Physical Meaning} \\
\hline
\mathbf{\text{Target Inside Workspace}} & |l_1 - l_2| < \sqrt{x^2 + y^2} < l_1 + l_2 & \mathbf{\text{Exactly 2 distinct valid solutions (Elbow-Up \& Elbow-Down)}} \\
\mathbf{\text{Outer Workspace Boundary}} & \sqrt{x^2 + y^2} = l_1 + l_2 & \mathbf{\text{Exactly 1 solution } (\theta_2 = 0^\circ, \text{ fully outstretched singular arm})} \\
\text{Inner Workspace Boundary} & \sqrt{x^2 + y^2} = |l_1 - l_2| & \text{Exactly 1 solution } (\theta_2 = 180^\circ, \text{ fully folded singular arm}) \\
\mathbf{\text{Target Out of Reach}} & \sqrt{x^2 + y^2} > l_1 + l_2 & \mathbf{\text{No real solution } (\cos\theta_2 > 1.0, \text{ target unreachable})} \\
\hline
\end{array}$$
(proving that analytical inverse kinematics resolves multiple physical joint configurations to navigate around external workspace obstacles).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Analytical IK ($\cos\theta_2 = \frac{x^2+y^2-l_1^2-l_2^2}{2l_1l_2}$), Elbow-Up/Down Dual Solutions & Workspace Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Joint Angles Theta 1 and Theta 2 for an Elbow-Down Planar Arm Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Inverse Kinematics Construct / Trigonometric Function & Technical Robotics Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Inverse Kinematics, the Four-Quadrant Arctangent Function ___ ($y, x$) Is Mandatory Over Standard $\arctan(y/x)$ to Unambiguously Preserve Sign and Avoid Division by Zero (atan2 / atan2(y,x)) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Robotics Control Problem: Computing Joint Angles Theta 1 and Theta 2 for Target Coordinates (0.4 m, 0.4 m) Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Planar Arm Inverse Kinematics Mechanics (Craig 2018; Spong 2020):
   - **IK Formulations:**
     $$\mathbf{\cos\theta_2 = \frac{x^2+y^2-l_1^2-l_2^2}{2 l_1 l_2} \quad \Big| \quad \theta_2 = \pm\arccos(\cos\theta_2) \quad \Big| \quad \theta_1 = \text{atan2}(y,x) - \text{atan2}(l_2 s_2, l_1 + l_2 c_2)}$$
   - **The Multiple Solutions Invariant:** For an anthropomorphic manipulator operating inside its dextrous workspace, inverse kinematics **always yields two distinct postural branches (elbow-up and elbow-down)**; selecting between them enables obstacle avoidance and collision-free trajectory planning!
2. **Slide 2 (`ordering`):** Provide 5 steps of analytical IK calculation: (1) calculate radial distance to target $r = \sqrt{x^2 + y^2}$ and verify reachable workspace condition $r \le l_1 + l_2$, (2) apply Law of Cosines to solve for joint 2 cosine: $\cos\theta_2 = (x^2 + y^2 - l_1^2 - l_2^2) / (2 l_1 l_2)$, (3) compute joint 2 angle for chosen elbow configuration: $\theta_2 = \text{atan2}(\pm\sqrt{1 - \cos^2\theta_2}, \cos\theta_2)$, (4) evaluate base pointing angle $\psi = \text{atan2}(y, x)$ and internal triangle offset angle $\phi = \text{atan2}(l_2 \sin\theta_2, l_1 + l_2 \cos\theta_2)$, (5) subtract angles to obtain joint 1 angle: $\theta_1 = \psi - \phi$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Law of Cosines, Elbow-Up Configuration, Elbow-Down Configuration, atan2 Function) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of atan2 (or atan2(y,x)). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating IK for 2-link planar arm: A 2-link planar manipulator with equal link lengths $l_1 = 0.500\text{ m}$ and $l_2 = 0.500\text{ m}$ must reach target position $(x = 0.500\text{ m}, y = 0.500\text{ m})$.
   - Radial distance squared: $r^2 = x^2 + y^2 = (0.500)^2 + (0.500)^2 = 0.250 + 0.250 = \mathbf{0.500\text{ m}^2}$;
   - Link squared sums: $l_1^2 + l_2^2 = (0.5)^2 + (0.5)^2 = \mathbf{0.500\text{ m}^2}$;
   - Denominator: $2 l_1 l_2 = 2 \times 0.5 \times 0.5 = \mathbf{0.500\text{ m}^2}$;
   - $\cos\theta_2$:
     $\cos\theta_2 = \frac{0.500 - 0.500}{0.500} = \mathbf{0.000} \implies \theta_2 = \text{atan2}(+\sqrt{1 - 0}, 0) = \mathbf{+90.0^\circ}$ (elbow-down);
   - Sines/cosines: $\sin\theta_2 = 1.000, \cos\theta_2 = 0.000$;
   - $\psi = \text{atan2}(0.500, 0.500) = \mathbf{45.0^\circ}$;
   - $\phi = \text{atan2}(l_2 \sin\theta_2, l_1 + l_2 \cos\theta_2) = \text{atan2}(0.500 \times 1.0, 0.500 + 0.500 \times 0) = \text{atan2}(0.500, 0.500) = \mathbf{45.0^\circ}$;
   - $\theta_1 = \psi - \phi = 45.0^\circ - 45.0^\circ = \mathbf{0.0^\circ}$;
   - What are the joint angles $(\theta_1, \theta_2)$ for the elbow-down solution? ($\theta_1 = \mathbf{0.0^\circ}$ and $\theta_2 = \mathbf{+90.0^\circ}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "two_link_planar_arm_analytical_inverse_kinematics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: 2-Link Planar Inverse Kinematics (Craig \\& Spong)**\n• **Joint 2 Angle Master Formulation (Law of Cosines):**\n$$\n\\mathbf{\\cos\\theta_2 = \\frac{x^2 + y^2 - l_1^2 - l_2^2}{2 l_1 l_2} \\implies \\theta_2 = \\text{atan2}\\left( \\pm \\sqrt{1 - \\cos^2\\theta_2}, \\cos\\theta_2 \\right)}\n$$\n  - **$+\\theta_2$:** Elbow-Down configuration;\n  - **$-\\theta_2$:** Elbow-Up configuration;\n• **Joint 1 Angle Master Formulation ($\\theta_1$):**\n$$\n\\mathbf{\\theta_1 = \\text{atan2}(y, x) - \\text{atan2}\\left( l_2 \\sin\\theta_2, l_1 + l_2 \\cos\\theta_2 \\right)}\n$$\n• **Reachable Workspace Boundary Condition:**\n$$\n\\mathbf{|l_1 - l_2| \\le \\sqrt{x^2 + y^2} \\le l_1 + l_2}\n$$\n• **The Postural Duality Invariant:** Inside the reachable workspace, inverse kinematics **strictly yields two geometrically distinct postural branches (Elbow-Up vs Elbow-Down)**, providing redundant trajectory flexibility to navigate around external workspace obstacles!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to solve analytical inverse kinematics for a 2-link planar articulated robot arm.",
      "orderItems": [
        "Check that target Cartesian coordinates (x, y) satisfy the reachable workspace condition: \u221a(x^2 + y^2) \u2264 l1 + l2",
        "Apply the Law of Cosines to calculate the cosine of joint 2: cos\u03b82 = (x^2 + y^2 - l1^2 - l2^2) / (2 * l1 * l2)",
        "Select elbow configuration branch and compute joint 2 angle: \u03b82 = atan2(\u00b1\u221a[1 - cos^2\u03b82], cos\u03b82)",
        "Calculate the target pointing angle \u03c8 = atan2(y, x) and internal offset angle \u03c6 = atan2(l2*sin\u03b82, l1 + l2*cos\u03b82)",
        "Subtract the offset angle from the pointing angle to obtain joint 1 angle: \u03b81 = \u03c8 - \u03c6"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Inverse Kinematics Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Law of Cosines", "right": "Trigonometric theorem solving internal joint 2 angle from target radius r = \u221a(x^2 + y^2)" },
        { "left": "Elbow-Down Solution (+\u03b82)", "right": "Kinematic branch where forearm bends downward with positive joint 2 rotation angle" },
        { "left": "Elbow-Up Solution (-\u03b82)", "right": "Kinematic branch where forearm bends upward with negative joint 2 rotation angle" },
        { "left": "atan2(y, x) Function", "right": "Four-quadrant arctangent avoiding division by zero and preserving unambiguous \u00b1\u03c0 angular sign" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In inverse kinematics, the four-quadrant arctangent function ___ is mandatory over standard arctan(y/x) to unambiguously preserve sign and avoid division by zero.",
      "blankAnswer": "atan2",
      "blankDistractors": ["sin", "cos", "sqrt"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 2-link planar arm has l1 = 0.500 m and l2 = 0.500 m. It must position its end-effector at (x = 0.500 m, y = 0.500 m). x^2 + y^2 = 0.500 m^2, l1^2 + l2^2 = 0.500 m^2, and 2*l1*l2 = 0.500 m^2. cos\u03b82 = (0.500 - 0.500) / 0.500 = 0.000 \u2192 \u03b82 = +90.0\u00b0 (elbow-down). \u03c8 = atan2(0.5, 0.5) = 45.0\u00b0. \u03c6 = atan2(0.5*1, 0.5 + 0.5*0) = atan2(0.5, 0.5) = 45.0\u00b0. \u03b81 = 45.0\u00b0 - 45.0\u00b0 = 0.0\u00b0. What are the joint angles (\u03b81, \u03b82)?",
      "options": [
        { "text": "\u03b81 = 0.0\u00b0 and \u03b82 = +90.0\u00b0 (\u03b82 = +90.0\u00b0; \u03c8 = 45.0\u00b0, \u03c6 = 45.0\u00b0 \u2192 \u03b81 = 45.0\u00b0 - 45.0\u00b0 = 0.0\u00b0)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using analytical inverse kinematics for a 2-link planar arm (John J. Craig *Introduction to Robotics: Mechanics and Control* Chapter 4; Mark W. Spong et al. *Robot Modeling and Control* Chapter 4). 1. **Identify Target Coordinates \\& Link Geometry:** - Link lengths: $l_1 = 0.500\\text{ m}, \\quad l_2 = 0.500\\text{ m}$. - Target position: $x = 0.500\\text{ m}, \\quad y = 0.500\\text{ m}$. - Radial distance squared: $$r^2 = x^2 + y^2 = (0.500)^2 + (0.500)^2 = 0.250 + 0.250 = \\mathbf{0.500\\text{ m}^2}$$ 2. **Calculate Joint 2 Angle ($\\theta_2$ via Law of Cosines):** - Sum of squares: $l_1^2 + l_2^2 = (0.500)^2 + (0.500)^2 = \\mathbf{0.500\\text{ m}^2}$. - Denominator product: $2 l_1 l_2 = 2 \\times 0.500 \\times 0.500 = \\mathbf{0.500\\text{ m}^2}$. $$\\cos\\theta_2 = \\frac{x^2 + y^2 - l_1^2 - l_2^2}{2 l_1 l_2} = \\frac{0.500 - 0.500}{0.500} = \\mathbf{0.000}$$ - For the **elbow-down** solution ($+\\theta_2$): $$\\theta_2 = \\text{atan2}\\left(+\\sqrt{1 - 0.000^2}, 0.000\\right) = \\text{atan2}(1.000, 0.000) = \\mathbf{+90.0^\\circ = +\\frac{\\pi}{2}\\text{ rad}}$$ 3. **Calculate Joint 1 Angle ($\\theta_1$):** - Target heading angle: $$\\psi = \\text{atan2}(y, x) = \\text{atan2}(0.500, 0.500) = \\mathbf{45.0^\\circ}$$ - Internal linkage offset angle: $$\\phi = \\text{atan2}(l_2 \\sin\\theta_2, l_1 + l_2 \\cos\\theta_2) = \\text{atan2}(0.500 \\times 1.000, 0.500 + 0.500 \\times 0.000) = \\text{atan2}(0.500, 0.500) = \\mathbf{45.0^\\circ}$$ - Joint 1 angle: $$\\theta_1 = \\psi - \\phi = 45.0^\\circ - 45.0^\\circ = \\mathbf{0.0^\\circ}$$ - Let's check with forward kinematics: $$p_x = 0.500 \\cos(0^\\circ) + 0.500 \\cos(0^\\circ + 90^\\circ) = 0.500(1) + 0.500(0) = \\mathbf{0.500\\text{ m}}$$ $$p_y = 0.500 \\sin(0^\\circ) + 0.500 \\sin(0^\\circ + 90^\\circ) = 0.500(0) + 0.500(1) = \\mathbf{0.500\\text{ m}}$$ Perfect match! Flawless 2-link analytical inverse kinematics derivation!" },
        { "text": "\u03b81 = 45.0\u00b0 and \u03b82 = 45.0\u00b0 (Directly split target angle without linkage geometry)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03b81 = 90.0\u00b0 and \u03b82 = 0.0\u00b0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03b81 = 30.0\u00b0 and \u03b82 = 60.0\u00b0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
