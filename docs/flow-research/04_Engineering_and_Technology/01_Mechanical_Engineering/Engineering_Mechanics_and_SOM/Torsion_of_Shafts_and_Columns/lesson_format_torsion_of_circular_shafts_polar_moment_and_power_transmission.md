# Duofy Reusable Lesson Format: Shaft Torsion (Polar Moment and Power Transmission)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Engineering_Mechanics_and_SOM / Torsion_of_Shafts_and_Columns`  
**Lesson Format Type:** `torsion_of_circular_shafts_polar_moment_and_power_transmission`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through torsional shear mechanics, polar second moments of area, and rotational power transmission equations in mechanical engineering shafts (Ferdinand P. Beer, E. Russell Johnston Jr. et al. *Mechanics of Materials* Chapter 3; Russell C. Hibbeler *Mechanics of Materials* Chapter 5): master the core **Torsion Formula for Circular Shafts**:
$$\mathbf{\frac{T}{J} = \frac{\tau}{r} = \frac{G \theta}{L} \implies \mathbf{\tau(r) = \frac{T r}{J}} \quad \Big| \quad \mathbf{\tau_{\text{max}} = \frac{T R}{J} = \frac{16 T}{\pi d^3}}}$$
master the **Polar Moment of Inertia ($J = \frac{\pi d^4}{32}$)** and **Torsional Section Modulus ($Z_p = \frac{\pi d^3}{16}$)**, prove why torsional shear stress varies linearly from $0$ at the shaft center to maximum $\tau_{\text{max}}$ at the outer surface, and master **Rotational Power Transmission ($\mathbf{P = T \omega = \frac{2 \pi N T}{60} \implies T = \frac{60 P}{2 \pi N}}$)** to design drive shafts for electric motors and turbines.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Torsion Formula ($\frac{T}{J} = \frac{\tau}{r} = \frac{G\theta}{L}$) & Power Transmission ($P = \frac{2\pi NT}{60}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of a Transmission Shaft Diameter from Motor Power and RPM Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Torsion Parameter / Shaft Geometric Property & Technical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Geometric Quantity Representing a Circular Cross-Section's Resistance to Torsion Is the Polar Moment of ___ (Inertia / J) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Mechanics Problem: Calculating the Torque Transmitted by an Electric Motor Drive Shaft Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Torsion & Power (Beer & Johnston 2020; Hibbeler 2018):
   - **The Torsion Master Equation:**
     $$\mathbf{\frac{T}{J} = \frac{\tau}{r} = \frac{G \theta}{L} \implies \mathbf{\tau_{\text{max}} = \frac{T (d/2)}{J} = \frac{16 T}{\pi d^3}} \quad \Big| \quad \mathbf{\theta = \frac{T L}{G J}}}$$
   - **Power-Torque Relationship Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Power Unit} & \textbf{Rotational Speed } N & \textbf{Torque Formula } T \\
     \hline
     \mathbf{\text{Watts (W or kW)}} & \mathbf{\text{RPM (Revolutions / min)}} & \mathbf{T = \frac{60 P}{2 \pi N} \ [\text{N}\cdot\text{m}]} \\
     \text{Horsepower (hp)} & \text{RPM} & T = \frac{5252 \cdot P_{\text{hp}}}{N} \ [\text{lb}\cdot\text{ft}] \\
     \hline
     \end{array}$$
   - **Linear Stress Invariant:** Shear stress is identically **zero at the geometric center** ($r=0$) and reaches its **absolute peak at the outermost perimeter** ($r=R$)!
2. **Slide 2 (`ordering`):** Provide 5 steps of designing a drive shaft: (1) determine transmitted mechanical power $P$ (in Watts) and rotational speed $N$ (in RPM), (2) calculate torque $T = \frac{60 P}{2 \pi N}$, (3) obtain allowable shear stress $\tau_{\text{allow}}$ for the shaft alloy, (4) set $\tau_{\text{max}} = \frac{16 T}{\pi d^3} \le \tau_{\text{allow}}$ and solve for minimum diameter $d_{\text{min}} = \sqrt[3]{\frac{16 T}{\pi \tau_{\text{allow}}}}$, (5) select the nearest standard commercial shaft diameter rounding up to ensure structural safety!
3. **Slide 3 (`matching`):** Pair 4 concepts (Polar Moment of Inertia $J$, Torsional Section Modulus $Z_p$, Angle of Twist $\theta$, Torsional Rigidity $GJ$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Inertia. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on torque calculation from power and RPM: An industrial electric motor delivers a mechanical power of $P = 31.416\text{ kW} = 31,416\text{ W}$ at a constant rotational speed of $N = 600\text{ RPM}$. What torque $T$ is transmitted through the motor's output shaft? ($\omega = \frac{2 \pi N}{60} = \frac{2 \pi (600)}{60} = 20 \pi\text{ rad/s} \approx 62.832\text{ rad/s}$; $T = \frac{P}{\omega} = \frac{31,416\text{ W}}{20 \pi\text{ rad/s}} = \frac{31,416}{62.832} = \mathbf{500\text{ N}\cdot\text{m}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "torsion_of_circular_shafts_polar_moment_and_power_transmission",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Torsion of Circular Shafts \\& Power Transmission (Beer \\& Johnston)**\n• **The Torsion Master Formulation:**\n$$\n\\mathbf{\\frac{T}{J} = \\frac{\\tau}{r} = \\frac{G \\theta}{L} \\implies \\mathbf{\\tau_{\\text{max}} = \\frac{T R}{J} = \\frac{16 T}{\\pi d^3}} \\quad \\Big| \\quad \\mathbf{\\theta = \\frac{T L}{G J}} \\ [\\text{radians}]}\n$$\n• **Power \\& Torque Conversion Formulation:**\n$$\n\\mathbf{P = T \\cdot \\omega = \\frac{2 \\pi N T}{60} \\implies \\mathbf{T = \\frac{60 P}{2 \\pi N} \\ [\\text{N}\\cdot\\text{m}]} \\quad (P \\text{ in Watts}, \\ N \\text{ in RPM})}\n$$\n• **The Polar Section Modulus Invariant:**\n$$\n\\mathbf{Z_p = \\frac{J}{R} = \\frac{\\pi d^3}{16} \\implies \\mathbf{\\tau_{\\text{max}} = \\frac{T}{Z_p}}}\n$$\n• **Linear Stress Profile:** Torsional shear stress is **zero at the center axis ($r=0$)** and scales linearly to maximum $\\tau_{\\text{max}}$ at the outer circumference ($r=d/2$)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design the required diameter of a rotating motor drive shaft based on power and allowable shear stress.",
      "orderItems": [
        "Identify the transmitted mechanical power P (Watts) and rotational speed N (RPM) from motor specifications",
        "Compute the applied torque transmitted through the shaft using T = (60 * P) / (2 * pi * N)",
        "Obtain the allowable shear stress (tau_allow) for the specified steel alloy",
        "Equate peak torsional shear stress to allowable limit: tau_max = 16 * T / (pi * d^3) <= tau_allow",
        "Solve for the minimum required shaft diameter: d_min = cuberoot((16 * T) / (pi * tau_allow)) and round up to standard stock size"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Torsional Mechanics Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Polar Moment of Inertia (J)", "right": "J = pi * d^4 / 32, measuring a circular cross-section's geometric resistance to twisting" },
        { "left": "Torsional Rigidity (GJ)", "right": "Product of shear modulus and polar moment of inertia measuring stiffness against torsional rotation" },
        { "left": "Angle of Twist (\u03b8)", "right": "\u03b8 = T * L / (G * J), representing total angular rotation in radians between shaft ends" },
        { "left": "Polar Section Modulus (Z_p)", "right": "Z_p = pi * d^3 / 16, used to calculate maximum surface torsional shear stress (T / Z_p)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The geometric property representing a circular shaft cross-section's resistance to twisting is the polar moment of ___.",
      "blankAnswer": "inertia",
      "blankDistractors": ["rigidity", "elasticity", "gyration"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An electric motor delivers a mechanical power of P = 31.416 kW (31,416 W) at a rotational speed of N = 600 RPM. What is the torque T transmitted through the motor's drive shaft?",
      "options": [
        { "text": "T = 500 N·m (using T = 60*P / (2*pi*N))", "isCorrect": true, "explanation": "Correct! Let's solve systematically using rotational mechanics (Beer & Johnston *Mechanics of Materials* Chapter 3). 1. **Angular Velocity ($\\omega$):** $$\\omega = \\frac{2 \\pi N}{60} = \\frac{2 \\pi (600\\text{ RPM})}{60} = 20 \\pi\\text{ rad/s} \\approx 62.83185\\text{ rad/s}$$ 2. **Torque ($T$):** $$P = T \\cdot \\omega \\implies T = \\frac{P}{\\omega} = \\frac{31,416\\text{ W}}{20 \\pi\\text{ rad/s}} = \\frac{31,416}{62.83185} = \\mathbf{500\\text{ N}\\cdot\\text{m}}$$ 3. **Verification:** $$P = T \\omega = (500\\text{ N}\\cdot\\text{m})(20 \\pi\\text{ rad/s}) = 10,000 \\pi = 31,415.9\\text{ W} = 31.416\\text{ kW}$$ Exact match!" },
        { "text": "T = 250 N·m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "T = 1,000 N·m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "T = 50 N·m", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
