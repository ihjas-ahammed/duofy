# Duofy Reusable Lesson Format: Curvilinear Kinematics and Coordinate Systems

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Classical_Mechanics / Kinematics_and_Newtonian_Dynamics`  
**Lesson Format Type:** `curvilinear_kinematics_and_coordinate_systems`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Introduce curvilinear vector kinematics in non-Cartesian coordinate frames: derive unit vector time derivatives ($\dot{\hat{\mathbf{r}}} = \dot{\theta}\hat{\boldsymbol{\theta}}$, $\dot{\hat{\boldsymbol{\theta}}} = -\dot{\theta}\hat{\mathbf{r}}$), formulate velocity ($\mathbf{v} = \dot{r}\hat{\mathbf{r}} + r\dot{\theta}\hat{\boldsymbol{\theta}}$) and acceleration ($\mathbf{a} = (\ddot{r} - r\dot{\theta}^2)\hat{\mathbf{r}} + (r\ddot{\theta} + 2\dot{r}\dot{\theta})\hat{\boldsymbol{\theta}}$) in **2D Polar Coordinates**, and extend to **Cylindrical** and **Spherical Polar Coordinates**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Polar Kinematics & Acceleration Components Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Polar Acceleration Vector Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Coordinate System & Velocity Vector Representation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Centripetal Acceleration Negative Term Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Coriolis Kinematic Acceleration Term Origin Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Plane Polar Coordinates $(r, \theta)$ with unit vectors $\hat{\mathbf{r}} = \cos\theta\hat{\mathbf{i}} + \sin\theta\hat{\mathbf{j}}$ and $\hat{\boldsymbol{\theta}} = -\sin\theta\hat{\mathbf{i}} + \cos\theta\hat{\mathbf{j}}$.
   - **Unit Vector Time Derivatives:**
     $$\dot{\hat{\mathbf{r}}} = \dot{\theta}\hat{\boldsymbol{\theta}}, \qquad \dot{\hat{\boldsymbol{\theta}}} = -\dot{\theta}\hat{\mathbf{r}}$$
   - **Position Vector:** $\mathbf{r} = r \hat{\mathbf{r}}$.
   - **Velocity Vector:** $\mathbf{v} \equiv \dot{\mathbf{r}} = \dot{r} \hat{\mathbf{r}} + r \dot{\theta} \hat{\boldsymbol{\theta}}$.
   - **Acceleration Vector:**
     $$\mathbf{a} \equiv \dot{\mathbf{v}} = (\ddot{r} - r\dot{\theta}^2)\hat{\mathbf{r}} + (r\ddot{\theta} + 2\dot{r}\dot{\theta})\hat{\boldsymbol{\theta}}$$
     where $-r\dot{\theta}^2$ is **Centripetal Acceleration**, $r\ddot{\theta}$ is **Angular/Tangential Acceleration**, and $2\dot{r}\dot{\theta}$ is **Coriolis Acceleration**.
2. **Slide 2 (`ordering`):** Provide 5 steps deriving the polar acceleration formula: (1) start with velocity vector $\mathbf{v} = \dot{r}\hat{\mathbf{r}} + r\dot{\theta}\hat{\boldsymbol{\theta}}$, (2) apply product rule to differentiate with respect to time: $\mathbf{a} = \frac{d}{dt}(\dot{r}\hat{\mathbf{r}}) + \frac{d}{dt}(r\dot{\theta}\hat{\boldsymbol{\theta}})$, (3) expand derivatives: $\mathbf{a} = (\ddot{r}\hat{\mathbf{r}} + \dot{r}\dot{\hat{\mathbf{r}}}) + (\dot{r}\dot{\theta}\hat{\boldsymbol{\theta}} + r\ddot{\theta}\hat{\boldsymbol{\theta}} + r\dot{\theta}\dot{\hat{\boldsymbol{\theta}}})$, (4) substitute unit vector derivatives $\dot{\hat{\mathbf{r}}} = \dot{\theta}\hat{\boldsymbol{\theta}}$ and $\dot{\hat{\boldsymbol{\theta}}} = -\dot{\theta}\hat{\mathbf{r}}$, (5) collect terms along radial $\hat{\mathbf{r}}$ and transverse $\hat{\boldsymbol{\theta}}$ directions: $\mathbf{a} = (\ddot{r} - r\dot{\theta}^2)\hat{\mathbf{r}} + (r\ddot{\theta} + 2\dot{r}\dot{\theta})\hat{\boldsymbol{\theta}}$!
3. **Slide 3 (`matching`):** Pair 4 coordinate frames (Cartesian, Plane Polar, Cylindrical $(r, \theta, z)$, Spherical $(r, \theta, \phi)$) with their velocity vector formulas.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that in circular motion ($\dot{r} = 0, \ddot{r} = 0$), the radial acceleration reduces to negative $r \dot{\theta}^2$ representing inward centripetal acceleration. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the kinematic origin of the factor of 2 in the Coriolis acceleration term $2\dot{r}\dot{\theta}\hat{\boldsymbol{\theta}}$: (The factor of 2 arises from TWO distinct physical effects: (1) the time rate of change of the radial velocity vector's direction $(\dot{r}\dot{\hat{\mathbf{r}}} = \dot{r}\dot{\theta}\hat{\boldsymbol{\theta}})$, PLUS (2) the rate of change of the tangential distance as the particle moves radially outward $(\frac{d}{dt}(r)\dot{\theta}\hat{\boldsymbol{\theta}} = \dot{r}\dot{\theta}\hat{\boldsymbol{\theta}})$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "curvilinear_kinematics_and_coordinate_systems",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Curvilinear Kinematics and Polar Coordinates**\n• **Plane Polar Unit Vectors:** $\\hat{\\mathbf{r}} = \\cos\\theta\\hat{\\mathbf{i}} + \\sin\\theta\\hat{\\mathbf{j}}$ and $\\hat{\\boldsymbol{\\theta}} = -\\sin\\theta\\hat{\\mathbf{i}} + \\cos\\theta\\hat{\\mathbf{j}}$.\n• **Unit Vector Derivatives:**\n$$\n\\dot{\\hat{\\mathbf{r}}} = \\dot{\\theta}\\hat{\\boldsymbol{\\theta}}, \\qquad \\dot{\\hat{\\boldsymbol{\\theta}}} = -\\dot{\\theta}\\hat{\\mathbf{r}}\n$$\n• **Position & Velocity Vectors:**\n$$\n\\mathbf{r} = r \\hat{\\mathbf{r}}, \\qquad \\mathbf{v} = \\dot{r} \\hat{\\mathbf{r}} + r \\dot{\\theta} \\hat{\\boldsymbol{\\theta}}\n$$\n• **Acceleration Vector in Polar Coordinates:**\n$$\n\\mathbf{a} = (\\ddot{r} - r\\dot{\\theta}^2)\\hat{\\mathbf{r}} + (r\\ddot{\\theta} + 2\\dot{r}\\dot{\\theta})\\hat{\\boldsymbol{\\theta}}\n$$\n  - $-r\\dot{\\theta}^2$: Inward **Centripetal Acceleration**.\n  - $2\\dot{r}\\dot{\\theta}$: Transverse **Coriolis Kinematic Acceleration**."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the product rule derivation steps establishing the acceleration vector in polar coordinates.",
      "orderItems": [
        "Write velocity vector as v = r_dot r_hat + r theta_dot theta_hat",
        "Apply total time derivative: a = d/dt(r_dot r_hat) + d/dt(r theta_dot theta_hat)",
        "Expand using product rule: a = (r_ddot r_hat + r_dot r_hat_dot) + (r_dot theta_dot theta_hat + r theta_ddot theta_hat + r theta_dot theta_hat_dot)",
        "Substitute unit vector time rates: r_hat_dot = theta_dot theta_hat and theta_hat_dot = -theta_dot r_hat",
        "Group like components to obtain a = (r_ddot - r theta_dot^2) r_hat + (r theta_ddot + 2 r_dot theta_dot) theta_hat"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each coordinate system to its velocity vector formula.",
      "matchPairs": [
        { "left": "Cartesian (x, y, z)", "right": "v = x_dot i_hat + y_dot j_hat + z_dot k_hat" },
        { "left": "Plane Polar (r, theta)", "right": "v = r_dot r_hat + r theta_dot theta_hat" },
        { "left": "Cylindrical (r, theta, z)", "right": "v = r_dot r_hat + r theta_dot theta_hat + z_dot z_hat" },
        { "left": "Spherical (r, theta, phi)", "right": "v = r_dot r_hat + r theta_dot theta_hat + r sin(theta) phi_dot phi_hat" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In pure circular motion with constant radius r, the radial acceleration term -r theta_dot^2 represents inward ___ acceleration.",
      "blankAnswer": "centripetal",
      "blankDistractors": ["coriolis", "tangential", "euler"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the physical origin of the factor of 2 in the Coriolis acceleration term 2 r_dot theta_dot theta_hat?",
      "options": [
        { "text": "It is the sum of TWO equal contributions: (1) the rotating direction of the radial velocity vector (r_dot theta_hat_dot) PLUS (2) the increasing tangential speed as radial distance grows (d/dt(r) * theta_dot)", "isCorrect": true, "explanation": "Correct! One contribution comes from the changing direction of the radial unit vector (r_dot d(r_hat)/dt = r_dot theta_dot theta_hat), and the second from the increasing tangential arm length (d(r)/dt * theta_dot theta_hat), adding up to 2 r_dot theta_dot." },
        { "text": "Because space is 2-dimensional", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because kinetic energy has a factor of 1/2", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It is an arbitrary mathematical constant", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
