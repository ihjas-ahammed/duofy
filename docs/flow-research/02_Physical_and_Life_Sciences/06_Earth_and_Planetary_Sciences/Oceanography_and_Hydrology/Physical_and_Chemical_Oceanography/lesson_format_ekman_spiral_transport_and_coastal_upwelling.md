# Duofy Reusable Lesson Format: Ekman Spiral, Transport, and Coastal Upwelling

**Target Topic:** `02_Physical_and_Life_Sciences / 06_Earth_and_Planetary_Sciences / Oceanography_and_Hydrology / Physical_and_Chemical_Oceanography`  
**Lesson Format Type:** `ekman_spiral_transport_and_coastal_upwelling`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the boundary-layer fluid mechanics, rotational Coriolis balances, and coastal biological productivity of the upper ocean (V. Walfrid Ekman 1905; Fridtjof Nansen 1893): analyze the balance between surface wind shear stress ($\mathbf{\tau}$) and the Coriolis force ($f = 2\Omega\sin\phi$), derive the **Ekman Spiral** (surface water deflecting **$45^\circ$ to the right of the wind in the Northern Hemisphere**, decaying exponentially with depth and rotating clockwise down to depth of frictional resistance $D_E$), formulate **Net Vertically Integrated Ekman Transport ($\mathbf{M}_E = \frac{\mathbf{\tau}\times \mathbf{k}}{\rho_0 f}$)** proving net transport is directed **at exactly $90^\circ$ to the right of wind in the Northern Hemisphere** ($90^\circ$ to the left in the Southern Hemisphere), and analyze how alongshore equatorward winds drive **Coastal Upwelling** of cold, nutrient-rich ($\text{NO}_3^-, \text{PO}_4^{3-}$) deep water along eastern ocean boundaries (California, Peru-Humboldt, Benguela, Canary systems).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Ekman Spiral Physics, Net Transport, & Coastal Upwelling Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Wind Forcing to Coastal Upwelling Ecosystem Bloom Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Ekman Flow Parameter / Phenomenon & Geophysical Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Exact Angular Offset of Net Ekman Transport to Wind Direction in NH Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Coastal Upwelling Mechanism along the California/Peru Coast Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State The Ekman Theory of Upper Ocean Currents (V.W. Ekman 1905):
   - **The Governing Boundary Equations:**
     $$A_z \frac{\partial^2 u}{\partial z^2} + f v = 0 \qquad A_z \frac{\partial^2 v}{\partial z^2} - f u = 0$$
   - **The Ekman Spiral:**
     - Surface water is driven by wind stress $\mathbf{\tau}$, but Coriolis deflects it **$45^\circ$ to the right of the wind (Northern Hemisphere)**.
     - Lower water layers are dragged by friction with upper layers; each successive sublayer moves slower and turns further to the right, tracing a 3D descending spiral down to the Ekman depth:
       $$\mathbf{D_E = \pi \sqrt{\frac{2 A_z}{|f|}} \approx 50 - 100\text{ meters}}$$
   - **Net Vertically Integrated Ekman Transport ($\mathbf{M}_E$):**
     $$\mathbf{\mathbf{M}_E = \int_{-D_E}^0 \rho \mathbf{v} dz = \frac{\mathbf{\tau} \times \mathbf{k}}{f} \qquad (\text{Exactly } \mathbf{90^\circ} \text{ to the Right in NH}, \mathbf{90^\circ} \text{ to the Left in SH})}$$
   - **Coastal Upwelling Dynamics:**
     - Along a north-south coast in the NH (e.g. California), a **northerly (equatorward) wind** drives net Ekman transport **offshore (to the west)**.
     - Mass continuity forces cold, sub-thermocline water rich in dissolved nitrates and phosphates to upwell to the euphotic zone, fueling massive diatom blooms and productive fisheries!
2. **Slide 2 (`ordering`):** Provide 5 steps of the coastal upwelling sequence: (1) atmospheric high pressure drives sustained equatorward alongshore winds parallel to a western continental coastline in the Northern Hemisphere, (2) wind shear friction coupled with the Coriolis effect sets up an Ekman spiral in the upper 50-100 meters of the water column, (3) the net vertically integrated Ekman transport directs surface water mass 90 degrees to the right (offshore into the open ocean), (4) to replace the displaced surface water, cold, dense, nutrient-saturated deep water upwells into the sunlit euphotic zone, (5) dissolved nitrate and phosphate fertilizer ignites massive phytoplankton diatom blooms, fueling hyper-productive marine food webs!
3. **Slide 3 (`matching`):** Pair 4 Ekman circulation features (Surface Current Vector, Net Ekman Transport Vector, Coastal Upwelling, Ekman Suction / Pumping) with their physical directions and roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the net vertically integrated Ekman transport flows at an angle of 90 degrees to the right of the surface wind in the Northern Hemisphere. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on determining the wind direction required for coastal upwelling in the Southern Hemisphere: Off the coast of Peru in the Southern Hemisphere (a north-south coastline with the ocean to the west), which wind direction is required to generate intense coastal upwelling of cold deep water? (A **southerly wind (blowing from south to north)**; in the Southern Hemisphere, net Ekman transport is directed **$90^\circ$ to the left of the wind**, which directs surface water offshore (westward) to pull up cold deep water).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ekman_spiral_transport_and_coastal_upwelling",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Ekman Spiral & Transport (V.W. Ekman 1905)**\n• **The Ekman Spiral:**\n  - Surface current flows at **$45^\\circ$ to the Right of the Wind (NH)**.\n  - Friction and Coriolis cause current to decay exponentially and rotate with depth down to **Ekman Depth ($D_E \\approx 50\\text{--}100\\text{ m}$)**.\n• **Net Vertically Integrated Ekman Transport ($\\mathbf{M}_E$):**\n$$\n\\mathbf{\\mathbf{M}_E = \\frac{\\mathbf{\\tau} \\times \\mathbf{k}}{\\rho_0 f} \\qquad (\\mathbf{90^\\circ \\text{ to the Right in NH}} \\ ; \\ \\mathbf{90^\\circ \\text{ to the Left in SH}})}\n$$\n• **Coastal Upwelling Mechanics (e.g. California & Peru):**\n  - Equatorward alongshore wind $\\implies$ Offshore Ekman transport $\\implies$ **Upwelling of cold, nutrient-rich ($\\text{NO}_3^-, \\text{PO}_4^{3-}$) deep water** into the euphotic zone $\\implies$ Global biological fishery hotspots!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential physical and biological stages of a coastal upwelling event in the California Current.",
      "orderItems": [
        "A persistent atmospheric pressure gradient drives strong northerly (equatorward) winds parallel to the California coast",
        "Wind shear stress transfers momentum into the upper 50-100 meters of the ocean, establishing an Ekman spiral",
        "Coriolis deflection forces the net integrated Ekman transport 90° to the right of the wind, driving surface water offshore",
        "To satisfy mass continuity, cold, dense, sub-thermocline water upwells along the continental shelf into the sunlit surface",
        "High concentrations of upwelled nitrates and phosphates trigger explosive diatom blooms and hyper-productive marine fisheries"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each physical oceanography concept to its exact kinematic definition.",
      "matchPairs": [
        { "left": "Surface Ekman Current Vector", "right": "Initial surface water motion oriented at 45° to the right of the wind in the Northern Hemisphere" },
        { "left": "Net Ekman Transport (M_E)", "right": "Total vertically integrated water mass transport flowing exactly 90° to the right of wind in NH" },
        { "left": "Coastal Upwelling", "right": "Vertical ascent of cold, nutrient-rich deep water replacing offshore-diverging surface waters" },
        { "left": "Ekman Pumping / Suction", "right": "Vertical velocity driven by horizontal wind-stress curl (divergence or convergence) over ocean gyres" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Northern Hemisphere, net vertically integrated Ekman transport is directed at an angle of exactly ___ degrees to the right of the surface wind direction.",
      "blankAnswer": "90",
      "blankDistractors": ["45", "180", "0"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Along the Pacific coast of Peru in the Southern Hemisphere (where the ocean lies to the west of the land), which wind direction is required to drive powerful coastal upwelling?",
      "options": [
        { "text": "A Southerly wind (blowing from South to North, equatorward); because in the Southern Hemisphere, net Ekman transport is directed 90° to the LEFT of the wind vector, blowing north pushes surface water westward away from the coast, forcing cold deep water to upwell", "isCorrect": true, "explanation": "Correct! Along the western coast of South America (Peru), the coastline runs approximately north-south with the ocean to the west and the Andes mountains to the east. In the Southern Hemisphere, the Coriolis parameter f is negative, which means that net vertically integrated Ekman transport is directed 90° to the LEFT of the wind direction. For upwelling to occur, surface water must be pushed westward (offshore) away from the Peruvian coastline. If the wind blows from the South toward the North (a Southerly wind), turning 90° to the left points directly to the West (offshore). This offshore divergence removes surface water, which is continuously replaced by the upward surging of the cold, nutrient-rich Humboldt Current, creating one of the richest anchovy fisheries in the world." },
        { "text": "A Northerly wind blowing from North to South", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "An Easterly wind blowing directly down the mountains", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Upwelling can only occur during complete dead calm with zero wind", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
