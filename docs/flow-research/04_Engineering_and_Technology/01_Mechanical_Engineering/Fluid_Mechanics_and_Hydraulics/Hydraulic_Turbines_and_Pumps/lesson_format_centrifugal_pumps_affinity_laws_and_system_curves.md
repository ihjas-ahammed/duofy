# Duofy Reusable Lesson Format: Centrifugal Pumps (Affinity Laws & Operating Point)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Fluid_Mechanics_and_Hydraulics / Hydraulic_Turbines_and_Pumps`  
**Lesson Format Type:** `centrifugal_pumps_affinity_laws_and_system_curves`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through pump performance curves, system resistance curves, impeller blade geometries, and dynamic affinity scaling laws in hydraulic systems (Frank M. White *Fluid Mechanics* Chapter 11; Bruce R. Munson et al. *Fundamentals of Fluid Mechanics* Chapter 12): analyze **Impeller Blade Geometries** (Forward-Curved $\beta_2 > 90^\circ$, Radial $\beta_2 = 90^\circ$, and Backward-Curved $\mathbf{\beta_2 < 90^\circ}$, proving why backward blades are universally standard due to their stable drooping $H-Q$ curve and self-limiting power curve preventing motor overload), master the **Operating Duty Point** (the unique intersection of the **Pump Characteristic Curve $\mathbf{H_{\text{pump}} = H_0 - a Q^2}$** and the **Piping System Resistance Curve $\mathbf{H_{\text{sys}} = \Delta z_{\text{static}} + K_{\text{system}} Q^2}$**), and master the **Pump Affinity Scaling Laws**:
$$\mathbf{\frac{Q_1}{Q_2} = \left(\frac{N_1}{N_2}\right)\left(\frac{D_1}{D_2}\right)^3 \quad \Big| \quad \mathbf{\frac{H_1}{H_2} = \left(\frac{N_1}{N_2}\right)^2\left(\frac{D_1}{D_2}\right)^2} \quad \Big| \quad \mathbf{\frac{P_1}{P_2} = \left(\frac{N_1}{N_2}\right)^3\left(\frac{D_1}{D_2}\right)^5}}$$
evaluating speed variation with Variable Frequency Drives (VFDs) where doubling rotational speed $N$ produces **$2\times$ Flow ($Q$), $4\times$ Head ($H$), and $8\times$ Power ($P$)**!

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The 3 Pump Affinity Laws ($Q \propto N D^3, H \propto N^2 D^2, P \propto N^3 D^5$) & Operating Curve Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing and Operating Point Determination for a Pump-Piping System Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Pump Curve Parameter / Blade Geometry & Operational Consequence Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | If a Centrifugal Pump's Rotational Speed Is Doubled (N2 = 2*N1), the Power Required by the Motor Increases by a Factor of ___ (8 / Eight) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Hydraulic System Scaling Problem: Calculating New Flow, Head, and Power Under Speed Variation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Centrifugal Pumps & Affinity (White 2016; Munson 2016):
   - **Pump Affinity Scaling Laws (Homologous Impellers):**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Operating Variable} & \textbf{Speed Scaling } (D = C) & \textbf{Diameter Scaling } (N = C) & \textbf{Combined Master Affinity Law} \\
     \hline
     \mathbf{\text{Volumetric Discharge}} & \mathbf{Q \propto N} & \mathbf{Q \propto D^3} & \mathbf{\frac{Q_1}{Q_2} = \left(\frac{N_1}{N_2}\right)\left(\frac{D_1}{D_2}\right)^3} \\
     \mathbf{\text{Total Dynamic Head}} & \mathbf{H \propto N^2} & \mathbf{H \propto D^2} & \mathbf{\frac{H_1}{H_2} = \left(\frac{N_1}{N_2}\right)^2\left(\frac{D_1}{D_2}\right)^2} \\
     \mathbf{\text{Brake Shaft Power}} & \mathbf{P \propto N^3} & \mathbf{P \propto D^5} & \mathbf{\frac{P_1}{P_2} = \left(\frac{N_1}{N_2}\right)^3\left(\frac{D_1}{D_2}\right)^5} \\
     \hline
     \end{array}$$
   - **The Operating Point Invariant:** The actual delivery rate in a real pipeline occurs at the **exact intersection where $H_{\text{pump}}(Q) = H_{\text{system}}(Q) = \Delta z + K Q^2$**!
2. **Slide 2 (`ordering`):** Provide 5 steps of pump operating point analysis: (1) plot the pump manufacturer's head-capacity curve $H_{\text{pump}}$ versus discharge $Q$, (2) formulate the piping system curve equation $H_{\text{sys}} = \Delta z_{\text{static}} + \left(f \frac{L}{D} + \sum K_L\right)\frac{Q^2}{2g A^2}$, (3) plot the parabolic system curve on the same coordinate axes, (4) find the intersection point ($H_{\text{pump}} = H_{\text{sys}}$) to determine operating flow rate $Q_{\text{op}}$ and operating head $H_{\text{op}}$, (5) verify that $Q_{\text{op}}$ aligns near the Best Efficiency Point (BEP) to maximize electrical efficiency and pump lifespan!
3. **Slide 3 (`matching`):** Pair 4 concepts (Backward-Curved Blades $\beta_2 < 90^\circ$, Best Efficiency Point BEP, Power Affinity $P \propto N^3$, System Curve $H_{\text{sys}} = \Delta z + K Q^2$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 8 (or Eight). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on applying pump affinity laws: A centrifugal water pump delivers a discharge of $Q_1 = 0.05\text{ m}^3\text{/s}$ against a head of $H_1 = 20\text{ m}$ while consuming $P_1 = 12\text{ kW}$ of electrical power when operating at $N_1 = 1200\text{ RPM}$. If a Variable Frequency Drive (VFD) increases the motor speed to $N_2 = 1800\text{ RPM}$ ($1.5\times$ speed), what will be the new discharge $Q_2$, head $H_2$, and shaft power $P_2$? ($\frac{N_2}{N_1} = \frac{1800}{1200} = 1.5$; $Q_2 = Q_1 (1.5) = (0.05)(1.5) = \mathbf{0.075\text{ m}^3\text{/s}}$; $H_2 = H_1 (1.5)^2 = 20 \times 2.25 = \mathbf{45.0\text{ m}}$; $P_2 = P_1 (1.5)^3 = 12 \times 3.375 = \mathbf{40.5\text{ kW}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "centrifugal_pumps_affinity_laws_and_system_curves",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Pump Affinity Scaling Laws \\& Operating Duty Points (Frank M. White)**\n• **The 3 Master Affinity Laws (Constant Impeller Diameter D):**\n$$\n\\mathbf{\\frac{Q_1}{Q_2} = \\frac{N_1}{N_2} \\quad \\Big| \\quad \\frac{H_1}{H_2} = \\left(\\frac{N_1}{N_2}\\right)^2 \\quad \\Big| \\quad \\frac{P_1}{P_2} = \\left(\\frac{N_1}{N_2}\\right)^3}\n$$\n• **Combined Affinity Laws (Speed N \\& Impeller Diameter D Scaling):**\n$$\n\\mathbf{\\frac{Q_1}{Q_2} = \\left(\\frac{N_1}{N_2}\\right)\\left(\\frac{D_1}{D_2}\\right)^3 \\quad \\Big| \\quad \\frac{H_1}{H_2} = \\left(\\frac{N_1}{N_2}\\right)^2\\left(\\frac{D_1}{D_2}\\right)^2 \\quad \\Big| \\quad \\frac{P_1}{P_2} = \\left(\\frac{N_1}{N_2}\\right)^3\\left(\\frac{D_1}{D_2}\\right)^5}\n$$\n• **The System Operating Point Invariant:**\n$$\n\\mathbf{H_{\\text{pump}}(Q) = H_{\\text{system}}(Q) = \\Delta z_{\\text{static}} + K_{\\text{pipe}} Q^2 \\implies \\mathbf{\\text{Unique Operating Flow } Q_{\\text{duty}}}}\n$$\n• **The Backward-Blade Rule:** Centrifugal pumps utilize backward-curved blades ($\\mathbf{\\beta_2 < 90^\\circ}$) to guarantee a stable drooping $H-Q$ curve and a self-limiting power profile!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the true operating discharge and required motor power for a pump-pipeline installation.",
      "orderItems": [
        "Obtain the pump manufacturer's characteristic head curve: H_pump = H_0 - a * Q^2",
        "Formulate the piping system resistance curve: H_sys = delta z_static + (f*L/D + sum K_L) * (Q^2 / (2*g*A^2))",
        "Equate pump head to system head (H_pump = H_sys) to solve for the unique operating flow rate Q_duty",
        "Read the operating head H_duty and hydraulic efficiency \u03b7 at the intersection point on the performance chart",
        "Calculate required brake electrical motor power using Power = (rho * g * Q_duty * H_duty) / \u03b7"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Centrifugal Pump Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Backward-Curved Blades (\u03b22 < 90°)", "right": "Standard impeller geometry producing stable drooping head curves and self-limiting power" },
        { "left": "Best Efficiency Point (BEP)", "right": "Design flow rate Q where hydraulic, mechanical, and volumetric losses are minimized" },
        { "left": "Power Affinity Law (P \u221d N^3)", "right": "Shaft power requirement scales with the cube of motor rotational speed" },
        { "left": "Shutoff Head (H_0)", "right": "Maximum static pressure head developed when the discharge valve is completely closed (Q = 0)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "If a centrifugal pump motor speed is doubled (N2 = 2*N1) at constant impeller diameter, the required shaft power increases by a factor of ___.",
      "blankAnswer": "8",
      "blankDistractors": ["2", "4", "16"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A centrifugal water pump delivers discharge Q1 = 0.05 m^3/s against a head H1 = 20 m while drawing power P1 = 12 kW at N1 = 1200 RPM. If a Variable Frequency Drive (VFD) increases the pump speed to N2 = 1800 RPM (a 1.5x speed increase) on the same impeller, what will be the new discharge Q2, head H2, and power P2?",
      "options": [
        { "text": "Q2 = 0.075 m^3/s, H2 = 45.0 m, and P2 = 40.5 kW", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Pump Affinity Laws for constant impeller diameter (Frank M. White *Fluid Mechanics* Chapter 11). 1. **Speed Ratio:** $$\\frac{N_2}{N_1} = \\frac{1800\\text{ RPM}}{1200\\text{ RPM}} = \\mathbf{1.5}$$ 2. **Flow Rate Scaling ($Q \\propto N$):** $$Q_2 = Q_1 \\left(\\frac{N_2}{N_1}\\right) = (0.05\\text{ m}^3\\text{/s})(1.5) = \\mathbf{0.075\\text{ m}^3\\text{/s}}$$ 3. **Head Scaling ($H \\propto N^2$):** $$H_2 = H_1 \\left(\\frac{N_2}{N_1}\\right)^2 = (20\\text{ m})(1.5)^2 = 20 \\times 2.25 = \\mathbf{45.0\\text{ m}}$$ 4. **Power Scaling ($P \\propto N^3$):** $$P_2 = P_1 \\left(\\frac{N_2}{N_1}\\right)^3 = (12\\text{ kW})(1.5)^3 = 12 \\times 3.375 = \\mathbf{40.5\\text{ kW}}$$ 5. **Engineering Takeaway:** Increasing speed by only $50\\%$ more than doubles the head ($20\\text{ m} \\to 45\\text{ m}$) but causes motor power demand to explode by more than triple ($12\\text{ kW} \\to 40.5\\text{ kW}$)! This is why VFD throttling saves massive electrical energy!" },
        { "text": "Q2 = 0.075 m^3/s, H2 = 30.0 m, and P2 = 18.0 kW", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Q2 = 0.100 m^3/s, H2 = 40.0 m, and P2 = 24.0 kW", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Q2 = 0.050 m^3/s, H2 = 20.0 m, and P2 = 12.0 kW", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
