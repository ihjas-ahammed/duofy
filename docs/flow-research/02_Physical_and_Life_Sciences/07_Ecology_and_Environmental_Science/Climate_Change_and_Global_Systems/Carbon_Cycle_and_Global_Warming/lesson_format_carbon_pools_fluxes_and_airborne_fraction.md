# Duofy Reusable Lesson Format: Carbon Pools, Fluxes, and Airborne Fraction

**Target Topic:** `02_Physical_and_Life_Sciences / 07_Ecology_and_Environmental_Science / Climate_Change_and_Global_Systems / Carbon_Cycle_and_Global_Warming`  
**Lesson Format Type:** `carbon_pools_fluxes_and_airborne_fraction`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mass balances, natural reservoirs, and anthropogenic perturbations of the Earth's global carbon cycle (Charles David Keeling 1958; Bert Bolin 1986; IPCC AR6): compare the capacities of the 4 major planetary carbon pools (**Atmosphere [$\approx 875\text{ GtC}$]**, **Terrestrial Biosphere and Soils [$\approx 2500\text{ GtC}$]**, **Global Ocean [$\approx 38,000\text{ GtC}$]**, and **Lithosphere/Fossil Fuel Reserves [$>100,000,000\text{ GtC}$]**), track anthropogenic emissions ($\approx 10-11\text{ GtC/year} \approx 38-40\text{ GtCO}_2\text{/year}$ from fossil fuels and deforestation), and formulate the **Airborne Fraction ($AF = \frac{\Delta M_{\text{atm}}}{E_{\text{ant}}} \approx 45-48\%$)** showing that approximately half of human emissions remain in the atmosphere while the remainder is partitioned between the ocean sink ($\approx 25-28\%$) and the terrestrial vegetation sink ($\approx 28-30\%$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Global Carbon Reservoirs & Anthropogenic Partitioning Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Anthropogenic Carbon Emission to Sink Partitioning Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Carbon Reservoir / Sink & Capacity / Kinetic Characteristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Percentage Value of Human CO2 Emissions Remaining in Atmosphere Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Vulnerability of Land and Ocean Carbon Sinks to Climate Warming Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State The Global Carbon Cycle & Reservoirs (IPCC AR6):
   - **Planetary Carbon Pools:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Carbon Pool / Reservoir} & \textbf{Carbon Stock (GtC)} & \textbf{Dynamic Turnaround Time} \\
     \hline
     \textbf{Atmosphere} & \mathbf{\approx 875\text{ GtC } (425\text{ ppm})} & \text{Rapid gas mixing (1--5 years)} \\
     \textbf{Terrestrial Biosphere \& Soils} & \mathbf{\approx 2500\text{ GtC}} & \text{Decades to centuries (vegetation + humus)} \\
     \textbf{Global Ocean (DIC)} & \mathbf{\approx 38,000\text{ GtC}} & \text{Surface (decades) to Abyss (1000 years)} \\
     \textbf{Lithosphere \& Carbonates} & \mathbf{>100,000,000\text{ GtC}} & \text{Geological timescale ($10^6-10^8$ years)} \\
     \hline
     \end{array}$$
   - **Anthropogenic Carbon Budget ($E_{\text{ant}} \approx 10.5\text{ GtC/yr} \approx 38.5\text{ GtCO}_2\text{/yr}$):**
     $$\mathbf{E_{\text{fossil}} + E_{\text{land-use}} = \frac{d M_{\text{atm}}}{dt} + S_{\text{ocean}} + S_{\text{land}}}$$
   - **The Airborne Fraction ($AF$):**
     $$\mathbf{AF = \frac{\Delta M_{\text{atm}}}{E_{\text{ant}}} \approx 45 - 48\% \qquad (\text{Atmosphere Accumulates } \approx 5.0\text{ GtC/year})}$$
     - **Ocean Sink ($S_{\text{ocean}} \approx 26\%$):** Absorbs $\approx 2.8\text{ GtC/yr}$ via solubility and biological pumps.
     - **Land Sink ($S_{\text{land}} \approx 28\%$):** Absorbs $\approx 3.0\text{ GtC/yr}$ via $\text{CO}_2$ fertilization of forests.
2. **Slide 2 (`ordering`):** Provide 5 steps of the fate of an anthropogenic fossil fuel carbon emission: (1) combustion of fossil hydrocarbons releases 100% of carbon as carbon dioxide gas into the atmospheric boundary layer, (2) atmospheric winds and jet streams rapidly mix the CO2 globally across both hemispheres within 1 to 2 years, (3) approximately 48% of the emitted carbon remains permanently trapped in the atmosphere, driving global radiative forcing, (4) surface ocean waters dissolve roughly 26% of the carbon via Henry's Law, forming carbonic acid and acidifying seawater, (5) enhanced photosynthesis and forest regrowth sequester the remaining 26% into terrestrial biomass and forest soil organic carbon!
3. **Slide 3 (`matching`):** Pair 4 carbon cycle components (Atmospheric Pool, Ocean Carbon Pool, Terrestrial Soil Carbon, Airborne Fraction AF) with their reservoir sizes and roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that approximately 48 percent of annual human anthropogenic carbon emissions remain in the atmosphere as the airborne fraction. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the climate feedback vulnerability of natural carbon sinks: Why do climate scientists warn that the fraction of human $\text{CO}_2$ emissions absorbed by the oceans and land biosphere ($\sim 52\%$) will decline under high-warming scenarios? (Because **warmer ocean waters have reduced physical $\text{CO}_2$ solubility (Henry's Law)** and slowing overturning circulation, while **warmer land soils experience exponential increases in microbial respiration** and climate extremes (droughts, wildfires) that turn forests from carbon sinks into net carbon sources).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "carbon_pools_fluxes_and_airborne_fraction",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Global Carbon Budget & Airborne Fraction**\n• **Planetary Carbon Pools:**\n$$\n\\begin{array}{|l|l|}\n\\hline\n\\textbf{Carbon Reservoir} & \\textbf{Total Size (GtC)} \\\\\n\\hline\n\\textbf{Atmosphere} & \\mathbf{\\approx 875\\text{ GtC } (425\\text{ ppm})} \\\\\n\\textbf{Terrestrial Biosphere \\& Soils} & \\mathbf{\\approx 2500\\text{ GtC}} \\\\\n\\textbf{Global Ocean} & \\mathbf{\\approx 38,000\\text{ GtC } (\\text{Largest Dynamic Pool!})} \\\\\n\\textbf{Lithosphere / Carbonate Rocks} & >100,000,000\\text{ GtC} \\\\\n\\hline\n\\end{array}\n$$\n• **Anthropogenic Emission Partitioning ($\\approx 10.5\\text{ GtC/yr}$):**\n$$\n\\mathbf{E_{\\text{ant}} (100\\%) \\to \\text{Airborne Fraction } (48\\%) + \\text{Ocean Sink } (26\\%) + \\text{Land Sink } (26\\%)}\n$$\n• **The Airborne Fraction ($AF \\approx 48\\%$):** Roughly **half** of all human $\\text{CO}_2$ stays in the air; the other half is buffered by forests and oceans!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential pathway of an anthropogenic fossil fuel carbon emission across Earth's carbon reservoirs.",
      "orderItems": [
        "Combustion of fossil hydrocarbons releases 100% of carbon as carbon dioxide gas into the lower atmosphere",
        "Atmospheric turbulence and global circulation mix the emitted CO2 homogeneously across the globe within 1-2 years",
        "Approximately 48% of the emission remains airborne in the atmosphere, driving the steady upward climb of the Keeling Curve",
        "Surface ocean waters absorb roughly 26% of the emissions via air-sea gas exchange, driving ocean acidification",
        "Terrestrial plant photosynthesis and forest biomass assimilate the remaining 26% into wood and soil humus"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each planetary carbon cycle component to its precise reservoir characteristic.",
      "matchPairs": [
        { "left": "Atmospheric Carbon Pool (~875 GtC)", "right": "Direct driver of radiative greenhouse forcing currently increasing at ~5 GtC (2.5 ppm) per year" },
        { "left": "Oceanic Carbon Pool (~38,000 GtC)", "right": "Largest active dynamic carbon reservoir on Earth storing dissolved inorganic carbon (DIC)" },
        { "left": "Terrestrial Soil & Biosphere (~2500 GtC)", "right": "Organic carbon stored in living plant biomass and decomposing soil humic layers" },
        { "left": "Airborne Fraction (AF ~ 48%)", "right": "Ratio of annual atmospheric CO2 mass accumulation to total anthropogenic emissions" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The fraction of total anthropogenic carbon dioxide emissions that remains suspended in the atmosphere is approximately ___ percent.",
      "blankAnswer": "48",
      "blankDistractors": ["10", "95", "5"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why do Earth System Models project that the natural 'ecosystem service' provided by land and ocean carbon sinks (which currently absorb ~52% of all human CO2 emissions) will significantly weaken as global temperatures rise?",
      "options": [
        { "text": "Warmer ocean water has lower physical solubility for CO2 gas (Henry's Law) and increased stratification slows overturning, while warming soils suffer exponential increases in microbial respiration and severe droughts/wildfires that transform forests into net carbon emitters", "isCorrect": true, "explanation": "Correct! Currently, the terrestrial biosphere and the global ocean act as immense natural carbon sponges, buffering human climate impact by absorbing roughly 52% of all our annual CO2 emissions (land absorbs ~26%, ocean absorbs ~26%). However, Earth system physics and biogeochemistry indicate that these sinks will saturate and weaken in a hotter world. In the oceans, warmer water has lower thermodynamic solubility for dissolved gases according to Henry's Law, meaning warm oceans can hold less dissolved CO2; furthermore, enhanced thermal stratification prevents deep water from reaching the surface to absorb more carbon. On land, higher temperatures accelerate soil microbial metabolic rates exponentially (increasing heterotrophic respiration and releasing soil carbon back to the atmosphere), while heat waves, megadroughts, and wildfires turn massive biomes like the Amazon and boreal forests from net carbon sinks into net carbon sources. Consequently, the airborne fraction (AF) will rise, accelerating future warming." },
        { "text": "Because plants stop doing photosynthesis when the sun is too bright", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because fish consume all the carbon dioxide to make bones", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because atmospheric nitrogen converts all carbon into diamond", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
