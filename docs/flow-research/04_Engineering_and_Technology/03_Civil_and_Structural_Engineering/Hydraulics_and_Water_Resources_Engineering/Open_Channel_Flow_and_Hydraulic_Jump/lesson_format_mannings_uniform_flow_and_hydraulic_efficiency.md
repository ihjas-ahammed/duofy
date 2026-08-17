# Duofy Reusable Lesson Format: Open Channel Flow (Manning's Equation & Optimal Sections)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Hydraulics_and_Water_Resources_Engineering / Open_Channel_Flow_and_Hydraulic_Jump`  
**Lesson Format Type:** `mannings_uniform_flow_and_hydraulic_efficiency`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mechanics of steady uniform free-surface flow in open channels, Robert Manning's empirical equation, hydraulic radius ($R_h = A / P$), channel bed slope ($S_0$), Manning's roughness coefficient ($n$), and the mathematical derivation of **Most Economically / Hydraulically Efficient Cross-Sections** that minimize wetted perimeter ($P$) to maximize conveyance ($Q$) for a given cross-sectional area (Ven Te Chow *Open-Channel Hydraulics* Chapter 6; Terry W. Sturm *Open Channel Hydraulics* Chapter 4): formulate **Manning's Uniform Flow Equation (SI Metric)**:
$$\mathbf{Q = \frac{1}{n} A R_h^{2/3} S_0^{1/2} \quad \left(V = \frac{1}{n} R_h^{2/3} S_0^{1/2}, \quad R_h = \frac{A}{P}\right)}$$
derive the **Most Efficient Cross-Section Geometries**:
1. **Rectangular Channel:**
   $$\mathbf{\text{Condition: } \mathbf{b = 2 y} \quad \Big| \quad \mathbf{R_h = \frac{y}{2}} \quad (A = 2y^2, \ P = 4y)}$$
2. **Trapezoidal Channel (Side Slope $z = 1/\sqrt{3}$ or $60^\circ$ Semi-Hexagon):**
   $$\mathbf{\text{Condition: } \mathbf{R_h = \frac{y}{2}} \quad \Big| \quad \mathbf{T = \frac{4}{\sqrt{3}} y \approx 2.309 y} \quad \Big| \quad \mathbf{b = \frac{2}{\sqrt{3}} y \approx 1.155 y}}$$
3. **Triangular Channel ($90^\circ$ Vertex, $z = 1$):**
   $$\mathbf{\text{Condition: } \mathbf{R_h = \frac{y}{2\sqrt{2}} \approx 0.354 y}}$$
(proving that setting hydraulic radius $R_h = y/2$ minimizes construction excavation volume and friction drag for rectangular and trapezoidal conduits).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Manning's Equation ($Q = \frac{1}{n} A R_h^{2/3} S_0^{1/2}$), Efficient Geometry ($b = 2y, R_h = y/2$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Size a Hydraulically Optimal Rectangular Canal for a Target Discharge Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Open Channel Hydraulic Parameter / Geometry & Technical Physical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Most Hydraulically Efficient Rectangular Channel, the Optimal Base Width $b$ Is Exactly Equal to ___ Times the Water Depth $y$ (2 / Two) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Civil Hydraulic Problem: Calculating Flow Velocity and Discharge for an Optimal Rectangular Concrete Channel Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Manning's Flow & Optimal Sections (Chow 1959; Sturm 2021):
   - **Manning & Geometry Formulations:**
     $$\mathbf{Q = \frac{1}{n} A R_h^{2/3} S_0^{1/2} \quad \Big| \quad R_h = \frac{A}{P} \quad \Big| \quad \text{Optimal Rectangular: } b = 2y, \ R_h = y/2 \quad \Big| \quad \text{Optimal Trapezoid: } R_h = y/2, \ z = 1/\sqrt{3}}$$
   - **Optimal Channel Geometry Comparison Matrix:**
     $$\begin{array}{|l|c|c|c|l|}
     \hline
     \textbf{Channel Cross-Section} & \textbf{Optimum Width } b & \textbf{Hydraulic Radius } R_h & \textbf{Area } A & \textbf{Optimal Geometric Shape} \\
     \hline
     \mathbf{\text{Rectangular Canal}} & \mathbf{b = 2 y} & \mathbf{R_h = y / 2} & \mathbf{A = 2 y^2} & \mathbf{\text{Half-Square Proportion}} \\
     \mathbf{\text{Trapezoidal Canal}} & \mathbf{b = \frac{2}{\sqrt{3}} y \approx 1.155 y} & \mathbf{R_h = y / 2} & A = \sqrt{3} y^2 & \mathbf{\text{Semi-Hexagonal Inscribed Circle}} \\
     \mathbf{\text{Triangular V-Notch}} & \text{Vertex Angle } 90^\circ & R_h = y / (2\sqrt{2}) & A = y^2 & \text{Symmetric } z = 1 \text{ Side Slopes} \\
     \hline
     \end{array}$$
   - **The Hydraulic Radius Invariant:** For both the best rectangular and best trapezoidal channels, the hydraulic radius is **strictly equal to half the flow depth ($R_h = y/2$)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of Manning channel design: (1) determine design discharge $Q$, channel bed slope $S_0$, and lining roughness $n$, (2) apply optimal hydraulic condition $b = 2y$ and $R_h = y/2$, (3) substitute area $A = 2y^2$ and $R_h = y/2$ into Manning's equation: $Q = \frac{1}{n} (2y^2) (y/2)^{2/3} S_0^{1/2}$, (4) simplify to solve for normal water depth: $y = \left( \frac{Q \cdot n \cdot 2^{2/3}}{2 \cdot S_0^{1/2}} \right)^{3/8}$, (5) compute channel bottom width $b = 2y$ and add freeboard ($0.3 - 0.6\text{ m}$)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Hydraulic Radius $R_h = A/P$, Manning Roughness $n$, Optimal Rectangular $b=2y$, Bed Slope $S_0$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 2 (or Two). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating optimal channel flow: A finished concrete rectangular channel ($n = 0.015$, bed slope $S_0 = 0.0016 = 1.6 \times 10^{-3} \implies \sqrt{S_0} = 0.040$) is designed with the most efficient hydraulic cross-section. The normal flow depth is $y = 2.0\text{ m}$.
   - Optimal width: $b = 2y = 4.0\text{ m}$;
   - Cross-sectional area: $A = b \times y = 4.0 \times 2.0 = \mathbf{8.00\text{ m}^2}$;
   - Hydraulic radius: $R_h = \frac{y}{2} = \frac{2.0}{2} = \mathbf{1.00\text{ m}} \implies R_h^{2/3} = 1.00$;
   - Mean flow velocity: $V = \frac{1}{n} R_h^{2/3} S_0^{1/2} = \frac{1}{0.015} \times (1.00) \times (0.040) = \frac{0.040}{0.015} = \mathbf{2.667\text{ m/s}}$;
   - Total discharge: $Q = A \times V = 8.00\text{ m}^2 \times 2.6667\text{ m/s} = \mathbf{21.33\text{ m}^3\text{/s} \approx 21.3\text{ m}^3\text{/s}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "mannings_uniform_flow_and_hydraulic_efficiency",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Manning's Uniform Flow \\& Optimal Hydraulics (Robert Manning)**\n• **Manning's Uniform Flow Equation (SI Units):**\n$$\n\\mathbf{Q = \\frac{1}{n} A R_h^{2/3} S_0^{1/2} \\quad \\left(V = \\frac{1}{n} R_h^{2/3} S_0^{1/2}, \\quad R_h = \\frac{A}{P}\\right)}\n$$\n  - **$n$:** Manning roughness coefficient (e.g. $n = 0.015$ for concrete);\n  - **$R_h$:** Hydraulic radius ($A / P$);\n  - **$S_0$:** Longitudinal channel bottom slope ($\\text{m/m}$);\n• **Most Hydraulically Efficient Cross-Section Geometries:**\n  - **Rectangular Channel:**\n$$\n\\mathbf{b = 2 y \\quad \\Big| \\quad \\mathbf{R_h = \\frac{y}{2}} \\quad (A = 2y^2, \\ P = 4y)}\n$$\n  - **Trapezoidal Channel ($60^\\circ$ Semi-Hexagon):**\n$$\n\\mathbf{R_h = \\frac{y}{2} \\quad \\Big| \\quad b = \\frac{2}{\\sqrt{3}} y \\approx 1.155 y \\quad \\Big| \\quad z = \\frac{1}{\\sqrt{3}}}\n$$\n• **The Wetted Perimeter Minimization Invariant:** Sizing a rectangular channel with aspect ratio **$b = 2y$ minimizes the wetted perimeter $P$ for a given area $A$**, maximizing conveyance velocity $V$ and minimizing required land excavation!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design a hydraulically optimal rectangular open channel for a specified flood discharge.",
      "orderItems": [
        "Identify the target design discharge Q, bed slope S0, and Manning roughness n based on channel lining material",
        "Enforce the optimal hydraulic efficiency constraints: bottom width b = 2y, area A = 2y^2, and hydraulic radius Rh = y/2",
        "Substitute optimal geometric relations into Manning's equation: Q = (1/n) * (2y^2) * (y/2)^(2/3) * S0^(1/2)",
        "Solve algebraically for the required normal water depth: y = [ (Q * n * 2^(2/3)) / (2 * S0^(1/2)) ]^(3/8)",
        "Compute the optimal bottom width b = 2*y, check flow velocity V = Q/A, and add standard freeboard (0.3 to 0.6 m)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Open Channel Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Hydraulic Radius (Rh = A/P)", "right": "Ratio of cross-sectional flow area to wetted perimeter measuring frictional drag efficiency" },
        { "left": "Optimal Rectangular (b = 2y)", "right": "Proportion where channel width equals twice the flow depth, achieving maximum discharge per unit area" },
        { "left": "Semi-Hexagonal Trapezoid", "right": "Optimal trapezoidal canal with 60\u00b0 side slopes and Rh = y/2 forming a circumscribed half-circle" },
        { "left": "Manning Roughness (n)", "right": "Empirical friction coefficient characterizing channel boundary boundary shear resistance" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the most hydraulically efficient rectangular open channel, the optimal bottom width b equals exactly ___ times the water depth y.",
      "blankAnswer": "2",
      "blankDistractors": ["1", "3", "0.5"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A finished concrete rectangular channel (n = 0.015, S0 = 0.0016 \u2192 \u221aS0 = 0.040) is designed with the most efficient hydraulic proportions. Flow depth is y = 2.0 m (width b = 4.0 m, area A = 8.0 m^2, Rh = y/2 = 1.0 m). What is the mean flow velocity V and total discharge Q?",
      "options": [
        { "text": "V = 2.67 m/s and Q = 21.33 m^3/s (V = (1 / 0.015) * (1.0)^(2/3) * (0.040) = 0.040 / 0.015 = 2.667 m/s; Q = A * V = 8.00 * 2.6667 = 21.333 m^3/s)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Manning's equation for optimal open channels (Ven Te Chow *Open-Channel Hydraulics* Chapter 6). 1. **Calculate Geometric Flow Properties for Optimal Rectangle:** - Flow depth: $y = 2.0\\text{ m}$. - Optimal width: $b = 2 y = 2 \\times 2.0\\text{ m} = \\mathbf{4.0\\text{ m}}$. - Cross-sectional flow area: $$A = b \\times y = 4.0\\text{ m} \\times 2.0\\text{ m} = \\mathbf{8.00\\text{ m}^2}$$ - Wetted perimeter: $$P = b + 2 y = 4.0\\text{ m} + 2(2.0\\text{ m}) = 4.0 + 4.0 = \\mathbf{8.00\\text{ m}}$$ - Hydraulic radius: $$R_h = \\frac{A}{P} = \\frac{8.00\\text{ m}^2}{8.00\\text{ m}} = \\mathbf{1.00\\text{ m} \\quad \\left(\\text{Matching } \\frac{y}{2} = \\frac{2.0}{2} = 1.00\\text{ m}\\right)}$$ 2. **Calculate Mean Uniform Flow Velocity ($V$):** - Bed slope square root: $S_0^{1/2} = \\sqrt{0.0016} = \\mathbf{0.040}$. - Manning's velocity equation: $$V = \\frac{1}{n} R_h^{2/3} S_0^{1/2} = \\frac{1}{0.015} \\times (1.00\\text{ m})^{2/3} \\times 0.040 = \\frac{0.040}{0.015} = \\mathbf{2.6667\\text{ m/s} \\approx 2.67\\text{ m/s}}$$ 3. **Calculate Total Volumetric Discharge ($Q$):** $$Q = A \\times V = 8.00\\text{ m}^2 \\times 2.6667\\text{ m/s} = \\mathbf{21.333\\text{ m}^3\\text{/s} \\approx 21.33\\text{ m}^3\\text{/s}}$$ Flawless open channel Manning uniform flow derivation!" },
        { "text": "V = 1.50 m/s and Q = 12.00 m^3/s", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "V = 2.67 m/s and Q = 10.67 m^3/s (Used A = 4.0 m^2)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "V = 4.00 m/s and Q = 32.00 m^3/s", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
