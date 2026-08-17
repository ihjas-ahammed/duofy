# Duofy Reusable Lesson Format: Sedimentary Petrology and Clastic Diagenesis

**Target Topic:** `02_Physical_and_Life_Sciences / 06_Earth_and_Planetary_Sciences / Geology_and_Geophysics / Mineralogy_and_Petrology`  
**Lesson Format Type:** `sedimentary_petrology_and_clastic_diagenesis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the grain-size dynamics, depositional environments, and post-depositional lithification processes of sedimentary rocks (Chester Wentworth 1922; Francis Pettijohn): classify clastic sediment by the **Udden-Wentworth Grain Size Scale** (**Gravel $[>2\text{ mm}]$ $\to$ Sand $[1/16-2\text{ mm}]$ $\to$ Silt $[1/256-1/16\text{ mm}]$ $\to$ Clay $[<1/256\text{ mm}]$**), analyze the **QFL Ternary Diagram (Quartz-Feldspar-Lithics)** classifying sandstones (**Quartz Arenite, Arkose, Lithic Graywacke**), trace the stages of **Diagenesis and Lithification** (**Compaction $\to$ Mineral Cementation [Calcite $\text{CaCO}_3$, Silica $\text{SiO}_2$, Hematite $\text{Fe}_2\text{O}_3$] $\to$ Recrystallization / Authigenesis**), and contrast clastic rocks with chemical/biochemical rocks (**Micrite/Oolitic Limestone, Dolomite, Bedded Chert, Evaporites [Halite, Anhydrite]**).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Udden-Wentworth Scale & Diagenetic Lithification Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Clastic Sediment to Lithified Sandstone Diagenesis Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Sedimentary Rock Type & Defining Compositional / Textural Trait Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Feldspar-Rich Sandstone (>25% Feldspar) Petrographic Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Quartz Arenite Supermaturity and Prolonged Weathering History Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Sedimentary Petrology & Clastic Diagenesis (Wentworth 1922):
   - **The Udden-Wentworth Grain Size Scale:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Grain Size Class} & \textbf{Diameter Range} & \textbf{Unconsolidated Sediment} & \textbf{Lithified Sedimentary Rock} \\
     \hline
     \textbf{Gravel / Rudite} & > 2\text{ mm} & \text{Gravel, Pebbles, Cobbles, Boulders} & \mathbf{\text{Conglomerate (Rounded) / Breccia (Angular)}} \\
     \textbf{Sand / Arenite} & 1/16\text{ mm to } 2\text{ mm} & \text{Sand (Quartz, Feldspar, Lithics)} & \mathbf{\text{Sandstone (Arenite, Arkose, Graywacke)}} \\
     \textbf{Silt / Lutite} & 1/256\text{ mm to } 1/16\text{ mm} & \text{Silt} & \mathbf{\text{Siltstone}} \\
     \textbf{Clay / Pelite} & < 1/256\text{ mm } (< 4\ \mu\text{m}) & \text{Mud, Clay} & \mathbf{\text{Shale (Fissile) / Mudstone (Massive)}} \\
     \hline
     \end{array}$$
   - **The QFL Sandstone Ternary Classification (Folk / Pettijohn):**
     - **Quartz Arenite ($>95\%$ Quartz):** Compositionally and texturally ultra-mature; prolonged multi-cycle transport (e.g. desert dunes, beach barrier bars).
     - **Arkose ($>25\%$ Feldspar):** Immature; derived from rapid mechanical weathering of granitic plutons in arid or high-relief environments.
     - **Graywacke (Lithic Arenite $+$ $>15\%$ muddy matrix):** Immature; deposited by marine turbidity currents.
   - **Diagenesis & Lithification:**
     - **1. Mechanical & Chemical Compaction:** Overburden pressure reduces porosity from $40-60\%$ to $<10-20\%$.
     - **2. Cementation:** Precipitation of authigenic minerals in pores: **Calcite ($\text{CaCO}_3$)**, **Quartz Overgrowths ($\text{SiO}_2$)**, or **Hematite ($\text{Fe}_2\text{O}_3$, red beds)**.
2. **Slide 2 (`ordering`):** Provide 5 steps of the sedimentary cycle from weathering to lithified sandstone: (1) mechanical and chemical weathering breaks down parent granitic bedrock, liberating quartz grains, feldspars, and clay minerals, (2) fluvial or aeolian transport carries the sediment downstream, progressively abrading and sorting the grains by size, (3) sediment is deposited in a subsiding sedimentary basin (e.g. a shallow delta or beach environment), (4) deep burial exerts intense lithostatic overburden pressure, driving mechanical compaction and expelling pore fluids, (5) silica- and calcite-rich pore waters precipitate authigenic mineral cement between grain contacts, lithifying the loose sand into solid sandstone!
3. **Slide 3 (`matching`):** Pair 4 sedimentary rock types (Quartz Arenite, Arkose, Breccia, Shale) with their petrological characteristics.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that a sandstone containing greater than 25% feldspar grains derived from rapid granitic weathering is called an arkose. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the geological significance of a Quartz Arenite: A petrologist examines a sandstone thin section and discovers that 99% of the framework grains are well-rounded, well-sorted monocrystalline Quartz, with zero feldspar or rock fragments. What does this indicate about the depositional and weathering history of the rock? (It represents a **compositionally and texturally super-mature sediment that underwent extreme, prolonged chemical weathering and multi-cycle transport**, which completely destroyed all chemically unstable feldspars and ferromagnesian minerals, leaving behind only chemically inert quartz).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "sedimentary_petrology_and_clastic_diagenesis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Sedimentary Petrology & Clastic Diagenesis (1922)**\n• **Udden-Wentworth Grain Size Scale:**\n  - **Gravel ($>2\\text{ mm}$):** **Conglomerate** (rounded) vs **Breccia** (angular).\n  - **Sand ($1/16\\text{--}2\\text{ mm}$):** **Sandstone** (Quartz Arenite, Arkose, Graywacke).\n  - **Silt ($1/256\\text{--}1/16\\text{ mm}$):** **Siltstone** | **Clay ($<1/256\\text{ mm}$):** **Shale** (fissile).\n• **QFL Sandstone Provenance Matrix:**\n  - **Quartz Arenite ($>95\\%$ Quartz):** Super-mature; multi-cycle beach/dune transport.\n  - **Arkose ($>25\\%$ Feldspar):** Immature; rapid granitic erosion in arid/active tectonic zones.\n  - **Lithic Graywacke:** Immature turbidites with muddy matrix.\n• **Diagenesis:** **Compaction** (pressure expels water) $\\to$ **Cementation** (Calcite $\\text{CaCO}_3$, Silica $\\text{SiO}_2$, Hematite $\\text{Fe}_2\\text{O}_3$ overgrowths) $\\implies$ **Solid Rock!**"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of clastic sedimentary rock formation from bedrock weathering to lithified sandstone.",
      "orderItems": [
        "Chemical and mechanical weathering breaks down granite bedrock, releasing resistant quartz and feldspar grains",
        "Fluvial and aeolian transport carries sediment downstream, rounding and sorting the grains according to hydrodynamic energy",
        "Sediment settles in a subsiding depositional basin, accumulating in horizontal strata (beds)",
        "Overburden pressure from successive sediment layers drives mechanical compaction, reducing intergranular pore space",
        "Mineral-rich groundwater precipitates authigenic quartz or calcite cement between grain boundaries, lithifying the sandstone"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each sedimentary rock type to its defining petrological characteristic.",
      "matchPairs": [
        { "left": "Quartz Arenite", "right": "Super-mature sandstone consisting of >95% well-rounded, well-sorted quartz grains" },
        { "left": "Arkose Sandstone", "right": "Feldspar-rich sandstone (>25% feldspar) derived from rapid weathering of granitic source terrain" },
        { "left": "Sedimentary Breccia", "right": "Coarse-grained clastic rock composed of large, angular gravel clasts indicating minimal transport" },
        { "left": "Shale", "right": "Fine-grained fissile mudrock composed of compacted clay and silt that splits along thin laminations" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A sandstone containing greater than 25 percent feldspar framework grains is formally classified as an ___.",
      "blankAnswer": "arkose",
      "blankDistractors": ["arenite", "graywacke", "breccia"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A petrologist discovers an ancient sedimentary rock unit consisting of 98% perfectly rounded, uniformly sorted quartz sand grains with complete absence of feldspar, mica, or lithic clasts. What does this signify about the geological history of this deposit?",
      "options": [
        { "text": "The sediment is compositionally and texturally super-mature; it experienced extreme chemical weathering and extensive multi-cycle transport (such as in a high-energy beach or desert dune system) that completely pulverized and dissolved all chemically unstable minerals, leaving only durable quartz", "isCorrect": true, "explanation": "Correct! Sedimentary maturity reflects the degree to which a sediment has evolved from its raw initial weathering product toward a stable thermodynamic equilibrium. Under surface weathering conditions, quartz is chemically inert and mechanically hard (Mohs hardness 7), whereas feldspars rapidly weather to clay, and micas/amphiboles easily abrade and dissolve. A rock composed of >95% well-rounded, well-sorted quartz (a Quartz Arenite) represents the pinnacle of sedimentary maturity. It indicates that the sand was transported over great distances, reworked across multiple sedimentary cycles (e.g. repeated erosion and re-deposition of older sandstones), and subjected to prolonged high-energy wave or wind action in a stable tectonic setting (such as a passive continental margin beach or cratonic desert)." },
        { "text": "The rock was produced by a sudden volcanic eruption 10 minutes ago", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The rock formed in deep ocean trenches with zero oxygen", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The rock formed directly from molten lava cooling in air", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
