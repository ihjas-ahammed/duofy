# Duofy Reusable Lesson Format: Hydrostatics (Submerged Surfaces & Center of Pressure)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Fluid_Mechanics_and_Hydraulics / Fluid_Statics_and_Bernoulli_Equation`  
**Lesson Format Type:** `hydrostatic_pressure_and_center_of_pressure_on_submerged_surfaces`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through hydrostatic pressure fields, resultant force vectors on submerged plane and curved gates, and center of pressure calculations in fluid statics (Frank M. White *Fluid Mechanics* Chapter 2; Bruce R. Munson et al. *Fundamentals of Fluid Mechanics* Chapter 2): master the **Fundamental Hydrostatic Equation ($\mathbf{\frac{dP}{dz} = -\rho g \implies P = P_0 + \rho g h}$)**, master the **Magnitude of Resultant Hydrostatic Force on a Submerged Plane Gate**:
$$\mathbf{F_R = P_c \cdot A = (\rho g h_c) A = (\gamma h_c) A}$$
where $h_c$ is the vertical depth from the free liquid surface to the geometric **Centroid** of the surface, derive the exact **Center of Pressure ($\mathbf{y_p}$)** location along the inclined plane:
$$\mathbf{y_p = y_c + \frac{I_{xx,c}}{y_c A} \quad \Big| \quad x_p = x_c + \frac{I_{xy,c}}{y_c A}}$$
(proving why the resultant force **ALWAYS acts strictly below the centroid ($y_p > y_c$)** due to increasing hydrostatic pressure with depth), and analyze curved gates by decomposing the resultant force into horizontal ($F_H = P_{c,\text{proj}} A_{\text{vert}}$) and vertical ($F_V = \text{weight of fluid block directly above curved surface}$) components.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hydrostatic Resultant Force ($F_R = \rho g h_c A$) & Center of Pressure ($y_p = y_c + \frac{I_{xx}}{y_c A}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of the Hinge Moment and Reaction Force on a Dam Gate Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Hydrostatic Surface Parameter / Geometric Moment of Inertia & Technical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Single Point on a Submerged Gate Through Which the Resultant Hydrostatic Force Acts Is the Center of ___ (Pressure) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Hydrostatic Mechanics Problem: Calculating the Center of Pressure on a Vertical Rectangular Sluice Gate Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Hydrostatic Pressure & Forces (White 2016; Munson 2016):
   - **Hydrostatic Plane Surface Formulations:**
     $$\mathbf{F_R = P_c A = (\rho g h_c) A \quad \Big| \quad y_p = y_c + \frac{I_{xx,c}}{y_c A}}$$
   - **Cross-Sectional Moments of Inertia ($I_{xx,c}$):**
     - Rectangle ($b \times h$): $A = b h, \ I_{xx,c} = \frac{b h^3}{12} \implies \text{Offset } y_p - y_c = \frac{h^2}{12 y_c}$.
     - Circle (diameter $d$): $A = \frac{\pi d^2}{4}, \ I_{xx,c} = \frac{\pi d^4}{64} \implies \text{Offset } y_p - y_c = \frac{d^2}{16 y_c}$.
   - **The Depth Offset Invariant:** Because pressure increases linearly with depth, $F_R$ **ALWAYS acts below the centroid ($y_p > y_c$)**; as the gate is submerged deeper into the ocean ($y_c \to \infty$), the offset distance $\frac{I_{xx,c}}{y_c A} \to 0$, causing the center of pressure to converge toward the centroid!
2. **Slide 2 (`ordering`):** Provide 5 steps of solving a submerged gate: (1) determine fluid density $\rho$ and identify the geometric centroid $(x_c, y_c)$ and vertical centroid depth $h_c$ of the gate, (2) compute resultant hydrostatic force magnitude using $F_R = \rho g h_c A$, (3) calculate the second moment of area $I_{xx,c}$ of the gate about its centroidal axis, (4) evaluate the center of pressure location $y_p = y_c + \frac{I_{xx,c}}{y_c A}$, (5) formulate moment equilibrium about the hinge ($\sum M_{\text{hinge}} = 0$) using moment arm $(y_p - y_{\text{hinge}})$ to solve the required latch opening force!
3. **Slide 3 (`matching`):** Pair 4 concepts (Resultant Hydrostatic Force $F_R$, Center of Pressure $y_p$, Vertical Component on Curved Surface $F_V$, Centroidal Offset $\frac{I_{xx}}{y_c A}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Pressure. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating center of pressure: A vertical rectangular sluice gate of width $b = 2.0\text{ m}$ and height $h = 3.0\text{ m}$ is submerged in water ($\rho = 1000\text{ kg/m}^3, g = 9.81\text{ m/s}^2$). The top edge of the gate is flush with the water surface ($y_{\text{top}} = 0\text{ m}$). What is the vertical depth $y_p$ to the center of pressure from the free surface? (Centroid is at midpoint: $y_c = h_c = \frac{3.0}{2} = 1.5\text{ m}$; Area $A = b \cdot h = 2.0 \times 3.0 = 6.0\text{ m}^2$; Moment of inertia $I_{xx,c} = \frac{b h^3}{12} = \frac{2.0 \times (3.0)^3}{12} = \frac{54}{12} = 4.5\text{ m}^4$; Center of pressure $y_p = y_c + \frac{I_{xx,c}}{y_c A} = 1.5 + \frac{4.5}{(1.5)(6.0)} = 1.5 + \frac{4.5}{9.0} = 1.5 + 0.5 = \mathbf{2.0\text{ m}}$, which matches $\frac{2}{3} h = \frac{2}{3}(3.0) = \mathbf{2.0\text{ m}}$ from the pressure prism!).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hydrostatic_pressure_and_center_of_pressure_on_submerged_surfaces",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Hydrostatic Forces on Submerged Surfaces (Frank M. White)**\n• **Resultant Force \\& Center of Pressure Formulations:**\n$$\n\\mathbf{F_R = P_c \\cdot A = (\\rho g h_c) A \\quad \\Big| \\quad y_p = y_c + \\frac{I_{xx,c}}{y_c A} \\quad \\Big| \\quad x_p = x_c + \\frac{I_{xy,c}}{y_c A}}\n$$\n• **Common Geometric Centroid \\& Inertia Matrix:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Gate Geometry} & \\textbf{Area } A & \\textbf{Centroidal Inertia } I_{xx,c} & \\textbf{Centroid Offset } y_p - y_c \\\\\n\\hline\n\\mathbf{\\text{Rectangle } (b \\times h)} & A = b h & \\mathbf{I_{xx,c} = \\frac{b h^3}{12}} & \\mathbf{\\Delta y = \\frac{h^2}{12 y_c}} \\\\\n\\mathbf{\\text{Circle } (d)} & A = \\frac{\\pi d^2}{4} & \\mathbf{I_{xx,c} = \\frac{\\pi d^4}{64}} & \\mathbf{\\Delta y = \\frac{d^2}{16 y_c}} \\\\\n\\mathbf{\\text{Triangle (Base } b, \\text{ Height } h)} & A = \\frac{b h}{2} & I_{xx,c} = \\frac{b h^3}{36} & \\Delta y = \\frac{h^2}{18 y_c} \\\\\n\\hline\n\\end{array}\n$$\n• **The Pressure Prism Invariant:** The Center of Pressure $\\mathbf{y_p}$ **ALWAYS acts strictly below the centroid ($y_p > y_c$)** because hydrostatic pressure grows linearly with water depth!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the required latch holding force on a hinged dam sluice gate submerged in water.",
      "orderItems": [
        "Determine the depth to the gate's geometric centroid hc and calculate gate surface area A",
        "Compute the total resultant hydrostatic force magnitude using F_R = rho * g * hc * A",
        "Calculate the area moment of inertia I_xx about the centroidal horizontal axis (e.g. b*h^3 / 12)",
        "Determine the center of pressure location along the gate plane using y_p = y_c + I_xx / (y_c * A)",
        "Formulate moment equilibrium about the hinge axis (sum M_hinge = 0) to solve for the unknown latch holding force"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Hydrostatic Surface Primitive to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Resultant Force (F_R)", "right": "F_R = P_c * A = (rho * g * h_c) * A, the integral of hydrostatic pressure across the submerged area" },
        { "left": "Center of Pressure (y_p)", "right": "y_p = y_c + I_xx / (y_c * A), the physical point of action of the resultant force vector" },
        { "left": "Horizontal Force on Curved Gate (F_H)", "right": "F_H = P_c * A_proj, equal to the hydrostatic force on the vertical projection of the curved gate" },
        { "left": "Vertical Force on Curved Gate (F_V)", "right": "F_V = rho * g * V_fluid, equal to the total weight of fluid contained directly above the curve" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The single physical point of application on a submerged gate through which the total resultant hydrostatic force acts is the center of ___.",
      "blankAnswer": "pressure",
      "blankDistractors": ["gravity", "buoyancy", "mass"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A vertical rectangular gate of width b = 2.0 m and height h = 3.0 m is submerged in water (rho = 1000 kg/m^3). The top edge of the gate is flush with the water surface (y_top = 0 m). What is the vertical depth y_p to the Center of Pressure from the water surface?",
      "options": [
        { "text": "y_p = 2.0 m (exactly 2/3 of the depth from the free surface)", "isCorrect": true, "explanation": "Correct! Let's solve using both the analytical Center of Pressure equation and the Pressure Prism method (Frank M. White *Fluid Mechanics* Chapter 2). 1. **Geometric Centroid ($y_c$):** - Height $h = 3.0\\text{ m}$, top flush with surface ($y=0$). - $y_c = h_c = \\frac{h}{2} = \\frac{3.0\\text{ m}}{2} = \\mathbf{1.5\\text{ m}}$. 2. **Area and Centroidal Moment of Inertia ($I_{xx,c}$):** - Area $A = b \\cdot h = (2.0\\text{ m})(3.0\\text{ m}) = 6.0\\text{ m}^2$. - $I_{xx,c} = \\frac{b h^3}{12} = \\frac{(2.0\\text{ m})(3.0\\text{ m})^3}{12} = \\frac{2 \\times 27}{12} = \\frac{54}{12} = \\mathbf{4.5\\text{ m}^4}$. 3. **Center of Pressure Formula ($y_p$):** $$y_p = y_c + \\frac{I_{xx,c}}{y_c A} = 1.5\\text{ m} + \\frac{4.5\\text{ m}^4}{(1.5\\text{ m})(6.0\\text{ m}^2)} = 1.5 + \\frac{4.5}{9.0} = 1.5 + 0.5 = \\mathbf{2.0\\text{ m}}$$ 4. **Check with Pressure Prism:** For a triangular pressure prism starting at zero at the free surface: The centroid of a triangle is at $\\frac{2}{3}$ of its height from the apex $\\implies y_p = \\frac{2}{3} h = \\frac{2}{3}(3.0\\text{ m}) = \\mathbf{2.0\\text{ m}}$! Exact match!" },
        { "text": "y_p = 1.5 m (at the geometric centroid)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "y_p = 2.5 m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "y_p = 3.0 m (at the bottom edge)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
