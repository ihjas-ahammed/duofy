# Duofy Reusable Lesson Format: Darcy's Law, Hydraulic Head, and Pore Velocity

**Target Topic:** `02_Physical_and_Life_Sciences / 06_Earth_and_Planetary_Sciences / Oceanography_and_Hydrology / Hydrological_Cycle_and_Groundwater`  
**Lesson Format Type:** `darcys_law_hydraulic_head_and_pore_velocity`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the fluid dynamics of porous media, mechanical energy potentials, and subterranean contaminant transport (Henry Darcy 1856, *Les Fontaines Publiques de la Ville de Dijon*): formulate **Darcy's Law ($Q = -K A \frac{dh}{dl}$)** and specific discharge / Darcy flux ($q = Q/A = -K \frac{dh}{dl}$), deconstruct **Total Hydraulic Head ($h = z + \frac{p}{\rho g}$)** into its **Elevation Head ($z$)** and **Pressure Head ($\psi = p / \rho g$)** components, master the crucial distinction between Darcy flux ($q$) and **Average Linear Pore Seepage Velocity ($v_s = q / n_e$)** incorporating **Effective Porosity ($n_e$)**, calculate **Hydraulic Conductivity ($K = k \frac{\rho g}{\mu}$)**, and track groundwater flow paths down the gradient of total head ($\nabla h$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Darcy's Law, Hydraulic Head, & Seepage Velocity Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Piezometer Head Calculation to Pore Velocity Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Hydrogeological Parameter & Mathematical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Subsurface Porosity Parameter Governing Seepage Velocity Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Groundwater Flow Direction Down Total Head vs Pressure Alone Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Darcy's Law & Hydraulic Head (Henry Darcy 1856):
   - **Darcy's Law of Groundwater Flow:**
     $$\mathbf{Q = -K A \frac{dh}{dl} \qquad q = \frac{Q}{A} = -K \frac{dh}{dl}}$$
     - $Q$: Volumetric flow rate ($\text{m}^3/\text{s}$).
     - $q$: Darcy flux / Specific discharge ($\text{m/s}$ or $\text{m/day}$).
     - $K$: Hydraulic Conductivity ($\text{m/s}$), governed by $K = k \frac{\rho g}{\mu}$ ($k$ is intrinsic permeability in $\text{m}^2$).
     - $\frac{dh}{dl}$: Dimensionless hydraulic gradient.
   - **Total Hydraulic Head ($h$):**
     $$\mathbf{h = z + \frac{p}{\rho g} = z + \psi}$$
     - $z$: Elevation Head (height of measurement point above reference datum).
     - $\psi = \frac{p}{\rho g}$: Pressure Head (height of water column inside a piezometer).
     - **The Iron Rule:** Groundwater **ALWAYS flows from high total head to low total head**, NOT from high pressure to low pressure!
   - **Average Linear Seepage Velocity ($v_s$):**
     $$\mathbf{v_s = \frac{q}{n_e} = -\frac{K}{n_e}\frac{dh}{dl}}$$
     - $n_e$: **Effective Porosity** (interconnected pore volume fraction, typically $0.15-0.35$).
     - Because fluid only occupies interconnected pore spaces, true contaminant advection velocity is **$v_s \gg q$**!
2. **Slide 2 (`ordering`):** Provide 5 steps to calculate real groundwater seepage velocity from field piezometer data: (1) measure water levels inside two monitoring piezometers separated by horizontal distance L, (2) determine total hydraulic head h1 and h2 at both wells by adding elevation head z to pressure head psi, (3) calculate the dimensionless hydraulic gradient dh/dl = (h1 - h2) / L, (4) multiply hydraulic gradient by the hydraulic conductivity K to find the Darcy flux q = -K*(dh/dl), (5) divide the Darcy flux by the aquifer's effective porosity n_e to compute the true average linear seepage velocity v_s = q / n_e!
3. **Slide 3 (`matching`):** Pair 4 hydrogeological terms (Hydraulic Conductivity K, Specific Discharge q, Total Hydraulic Head h, Effective Porosity n_e) with their physical roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the average linear pore seepage velocity is calculated by dividing the Darcy flux by the effective porosity. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the direction of groundwater flow: Piezometer A is installed at elevation $z = 100\text{ m}$ with fluid pressure $p = 100\text{ kPa}$ ($\psi = 10\text{ m}$ of water), yielding $h_A = 110\text{ m}$. Piezometer B is installed deep at elevation $z = 20\text{ m}$ with high fluid pressure $p = 700\text{ kPa}$ ($\psi = 70\text{ m}$ of water), yielding $h_B = 90\text{ m}$. In which direction does groundwater flow? (From **Piezometer A to Piezometer B (downward)**; even though Piezometer B has 7 times higher fluid pressure, water flows exclusively down the gradient of **Total Hydraulic Head** from higher energy $h_A = 110\text{ m}$ to lower energy $h_B = 90\text{ m}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "darcys_law_hydraulic_head_and_pore_velocity",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Darcy's Law & Hydraulic Head (1856)**\n• **Darcy's Law for Porous Media:**\n$$\n\\mathbf{Q = -K A \\frac{dh}{dl} \\qquad q = \\frac{Q}{A} = -K \\frac{dh}{dl}}\n$$\n  - $K$: Hydraulic Conductivity ($K = k\\frac{\\rho g}{\\mu}$ in $\\text{m/s}$) | $\\frac{dh}{dl}$: Hydraulic gradient.\n• **Total Hydraulic Head ($h$ - Total Mechanical Energy):**\n$$\n\\mathbf{h = z + \\frac{p}{\\rho g} = z + \\psi} \\qquad (\\text{Elevation Head } z + \\text{Pressure Head } \\psi)\n$$\n  - **The Cardinal Rule:** Water flows from **HIGH TOTAL HEAD to LOW TOTAL HEAD**, not simply high pressure to low pressure!\n• **Average Linear Pore Seepage Velocity ($v_s$):**\n$$\n\\mathbf{v_s = \\frac{q}{n_e} = -\\frac{K}{n_e}\\frac{dh}{dl} \\qquad (n_e \\text{ is Effective Porosity})}\n$$\n  - True pore fluid velocity is **$3\\text{--}5\\times$ faster than Darcy flux $q$** because water only travels through open pore throats!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine actual groundwater contaminant migration velocity in an aquifer.",
      "orderItems": [
        "Measure water table elevations in two monitoring wells separated by distance L along the flow path",
        "Compute total hydraulic head at each well: h = elevation head (z) + pressure head (psi)",
        "Determine the hydraulic gradient dh/dl by dividing head difference (h1 - h2) by distance L",
        "Calculate the specific discharge (Darcy flux) q = -K × (dh/dl) using the measured hydraulic conductivity",
        "Divide the Darcy flux by the effective porosity n_e to obtain the true linear pore seepage velocity v_s = q / n_e"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each hydrogeological parameter to its precise physical definition.",
      "matchPairs": [
        { "left": "Hydraulic Conductivity (K)", "right": "Proportionality constant measuring porous medium's capacity to transmit water (K = k*rho*g/mu)" },
        { "left": "Total Hydraulic Head (h)", "right": "Sum of elevation head and pressure head (z + p/rho*g) defining total mechanical potential energy" },
        { "left": "Specific Discharge (q = Q/A)", "right": "Apparent volumetric flow rate per unit cross-sectional area of combined solids and voids" },
        { "left": "Linear Seepage Velocity (v_s = q/n_e)", "right": "Actual average travel speed of water molecules and dissolved contaminants through pore channels" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "To calculate the true average linear seepage velocity of groundwater through pores, the Darcy flux q must be divided by the effective ___ of the medium.",
      "blankAnswer": "porosity",
      "blankDistractors": ["permeability", "density", "viscosity"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a hydrogeological field study, Well A has an elevation z = 100 m and a pressure head psi = 10 m (Total Head h_A = 110 m). Deep Well B has an elevation z = 20 m and a high pressure head psi = 70 m (Total Head h_B = 90 m). In which direction will groundwater flow between these two points?",
      "options": [
        { "text": "From Well A toward Well B (downward); groundwater flows strictly along the gradient of TOTAL HYDRAULIC HEAD (from h_A = 110 m to h_B = 90 m), even though Well B has a substantially higher fluid pressure (70 m vs 10 m)", "isCorrect": true, "explanation": "Correct! A common misconception in physics and hydrogeology is that fluids always flow from high pressure to low pressure. While this holds for purely horizontal pipes, in three-dimensional gravity fields, groundwater flow is governed by the gradient of Total Mechanical Energy per unit weight, termed Total Hydraulic Head (h = z + p/(rho*g)). At Well A, high elevation provides large gravitational potential energy (z = 100 m), yielding h_A = 100 + 10 = 110 m. At Well B, despite having 7 times higher fluid pressure (psi = 70 m vs 10 m), its low elevation (z = 20 m) results in a lower total mechanical energy state: h_B = 20 + 70 = 90 m. Because h_A (110 m) > h_B (90 m), water flows spontaneously from Well A downward toward Well B, proving that hydraulic head—not pressure alone—dictates subsurface flow direction." },
        { "text": "From Well B to Well A because high pressure always pushes water uphill", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Water cannot flow between wells at different elevations", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Water will oscillate back and forth at the speed of sound", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
