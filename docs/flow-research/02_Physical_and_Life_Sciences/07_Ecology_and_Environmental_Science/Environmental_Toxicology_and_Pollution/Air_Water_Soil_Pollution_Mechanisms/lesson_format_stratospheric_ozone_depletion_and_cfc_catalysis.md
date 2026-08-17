# Duofy Reusable Lesson Format: Stratospheric Ozone Depletion and CFC Catalysis

**Target Topic:** `02_Physical_and_Life_Sciences / 07_Ecology_and_Environmental_Science / Environmental_Toxicology_and_Pollution / Air_Water_Soil_Pollution_Mechanisms`  
**Lesson Format Type:** `stratospheric_ozone_depletion_and_cfc_catalysis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the free-radical halogen catalysis, heterogeneous ice-surface chemistry, and polar vortex dynamics of stratospheric ozone depletion (F. Sherwood Rowland & Mario J. Molina 1974; Paul Crutzen; Susan Solomon 1986; 1995 Nobel Prize in Chemistry): trace the transport of unreactive **Chlorofluorocarbons (CFCs, e.g. $\text{CF}_2\text{Cl}_2$)** to the stratosphere, formulate the **Catalytic Chlorine Cycle ($\text{Cl}^\bullet + \text{O}_3 \to \text{ClO}^\bullet + \text{O}_2$; $\text{ClO}^\bullet + \text{O}^\bullet \to \text{Cl}^\bullet + \text{O}_2$)** where a single chlorine radical catalytically destroys $>100,000\text{ ozone molecules}$, analyze why chlorine is normally tied up in inactive **Reservoir Species ($\text{HCl}$ and $\text{ClONO}_2$)**, deconstruct **Polar Stratospheric Clouds (PSCs, Type I NAT and Type II water ice)** that convert inactive reservoirs into active photolabile $\text{Cl}_2$ on ice crystals during the frigid Antarctic polar winter ($T < 195\text{ K}$), and evaluate the success of the **1987 Montreal Protocol**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Catalytic Halogen Cycle & Heterogeneous PSC Activation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step CFC Release to Antarctic Spring Ozone Hole Formation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Ozone Chemistry Chemical Species & Atmospheric Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Approximate Number of Ozone Molecules Destroyed by a Single Chlorine Atom Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Critical Role of Polar Stratospheric Clouds in Antarctic Ozone Depletion Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Stratospheric Ozone Depletion (Rowland & Molina 1974; Solomon 1986; 1995 Nobel Prize):
   - **CFC Photolysis in the Stratosphere ($20-30\text{ km}$):**
     $$\text{CF}_2\text{Cl}_2 + h\nu (\lambda < 220\text{ nm}) \to \text{CF}_2\text{Cl}^\bullet + \mathbf{\text{Cl}^\bullet}$$
   - **The Catalytic Destruction Chain Reaction:**
     $$\mathbf{\text{Cl}^\bullet + \text{O}_3 \to \text{ClO}^\bullet + \text{O}_2 \qquad \text{ClO}^\bullet + \text{O}^\bullet \to \text{Cl}^\bullet + \text{O}_2 \qquad (\text{Net: } \text{O}_3 + \text{O}^\bullet \to 2\text{O}_2)}$$
     - A single $\text{Cl}^\bullet$ radical destroys **$>100,000\text{ molecules of } \text{O}_3$** before terminating into temporary reservoir species:
       $$\text{Cl}^\bullet + \text{CH}_4 \to \mathbf{\text{HCl}} + \text{CH}_3^\bullet \qquad \text{ClO}^\bullet + \text{NO}_2 + M \to \mathbf{\text{ClONO}_2} + M$$
   - **The Antarctic Ozone Hole Mechanism (Susan Solomon 1986):**
     - Polar Vortex isolates frigid Antarctic stratosphere ($T < 195\text{ K}$).
     - **Polar Stratospheric Clouds (PSCs - Nitric Acid Trihydrate NAT & Ice):**
       $$\mathbf{\text{HCl(s)} + \text{ClONO}_2\text{(g)} \xrightarrow{\text{PSC Ice Surfaces}} \text{Cl}_2\text{(g)} + \text{HNO}_3\text{(s)} \ (\text{Denitrification})}$$
     - In **Austral Spring (September/October)**, returning sunlight rapidly photolyzes accumulated $\text{Cl}_2 \xrightarrow{h\nu} 2\mathbf{\text{Cl}^\bullet}$, unleashing explosive, runaway ozone destruction ($>60-70\%$ total column ozone loss down to $<100\text{ Dobson Units}$)!
2. **Slide 2 (`ordering`):** Provide 5 steps of the Antarctic spring ozone hole cycle: (1) anthropogenic chlorofluorocarbons (CFCs) drift into the mid-stratosphere and are photolyzed by UV-C light, releasing reactive chlorine atoms, (2) chlorine is temporarily sequestered into stable, inactive reservoir species (HCl and ClONO2), (3) the harsh Antarctic polar winter isolates the stratosphere in a vortex, cooling below 195 K to form solid Polar Stratospheric Clouds (PSCs), (4) heterogeneous reactions on PSC ice crystals rapidly convert inactive HCl and ClONO2 into active, photolabile molecular chlorine (Cl2) gas while freezing out reactive nitrogen (denitrification), (5) the return of spring sunlight in September violently photolyzes Cl2 into a flood of chlorine radicals, catalytically destroying over 50% of the ozone layer in weeks!
3. **Slide 3 (`matching`):** Pair 4 ozone chemistry species (Chlorine Radical Cl, Chlorine Monoxide ClO, Chlorine Reservoirs HCl/ClONO2, Polar Stratospheric Clouds PSCs) with their chemical functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that a single catalytic chlorine atom can destroy approximately 100,000 ozone molecules before being deactivated. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why the massive seasonal ozone hole forms almost exclusively over Antarctica rather than over the Arctic: Why is the catastrophic springtime ozone hole so much deeper and more severe over the South Pole (Antarctica) compared to the North Pole (Arctic)? (Antarctica is a massive, cold, elevated continent surrounded by ocean, which generates a **strong, symmetric, unbroken polar vortex that stays exceptionally cold ($T < 195\text{ K}$) for months**, allowing massive formation of **Polar Stratospheric Clouds (PSCs)** and total denitrification; whereas the Arctic's land-ocean geography generates strong planetary waves that disrupt the Arctic vortex, keeping it too warm for extensive PSC formation).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "stratospheric_ozone_depletion_and_cfc_catalysis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Stratospheric Ozone Depletion (Rowland \\& Molina 1974)**\n• **The Catalytic Halogen Cycle:**\n$$\n\\mathbf{\\text{Cl}^\\bullet + \\text{O}_3 \\to \\text{ClO}^\\bullet + \\text{O}_2} \\ ; \\ \\mathbf{\\text{ClO}^\\bullet + \\text{O}^\\bullet \\to \\text{Cl}^\\bullet + \\text{O}_2} \\implies \\mathbf{\\text{O}_3 + \\text{O}^\\bullet \\to 2\\text{O}_2}\n$$\n  - A **single chlorine radical destroys $>100,000\\text{ ozone molecules}$** before deactivation!\n• **Inactive Reservoir Species:** $\\text{HCl}$ and $\\text{ClONO}_2$ safely lock up chlorine in mid-latitudes.\n• **The Antarctic Ozone Hole Engine (Solomon 1986):**\n$$\n\\mathbf{\\text{HCl} + \\text{ClONO}_2 \\xrightarrow{\\text{PSC Ice Surfaces}} \\text{Cl}_2\\text{(g)} + \\text{HNO}_3\\text{(s)} \\xrightarrow[\\text{Spring } h\\nu]{\\text{Sunlight}} 2\\text{Cl}^\\bullet!}\n$$\n  - Polar Stratospheric Clouds (PSCs) at $T < 195\\text{ K}$ activate chlorine $\\implies$ **Antarctic Ozone Hole ($<100\\text{ DU}$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of Antarctic springtime stratospheric ozone hole formation.",
      "orderItems": [
        "CFC molecules reach the stratosphere and undergo UV-C photolysis, liberating reactive chlorine radicals",
        "Chlorine radicals are temporarily sequestered into stable, non-reactive reservoir species (HCl and ClONO2)",
        "The frigid Antarctic winter polar vortex cools below 195 K, precipitating solid Polar Stratospheric Clouds (PSCs)",
        "Heterogeneous ice-crystal catalysis converts reservoir HCl and ClONO2 into photolabile Cl2 gas (denitrification)",
        "Spring sunlight in September photolyzes Cl2 into reactive chlorine atoms, triggering runaway catalytic ozone destruction"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each chemical species in stratospheric chemistry to its exact role.",
      "matchPairs": [
        { "left": "Chlorine Radical (Cl•)", "right": "Catalytic free radical capable of destroying over 100,000 ozone molecules through cyclical oxidation" },
        { "left": "Chlorine Monoxide (ClO•)", "right": "Key intermediate radical in the catalytic ozone destruction cycle that dimerizes into ClOOCl" },
        { "left": "Chlorine Nitrate (ClONO2)", "right": "Stable reservoir compound that temporarily sequesters chlorine in unreactive form in warm air" },
        { "left": "Polar Stratospheric Clouds (PSCs)", "right": "Solid nitric acid trihydrate and ice clouds that catalyze heterogeneous chlorine activation at < 195 K" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A single free chlorine radical released by CFC photolysis can catalytically destroy approximately ___ ozone molecules before being neutralized.",
      "blankAnswer": "100000",
      "blankDistractors": ["10", "1", "500"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does a catastrophic springtime ozone hole (>60% total column ozone depletion down to <100 Dobson Units) form reliably over Antarctica every September, but rarely develops to such severe extremes over the Arctic North Pole?",
      "options": [
        { "text": "Antarctica is a massive, elevated, isolated continent surrounded by continuous ocean, generating an exceptionally stable, unbroken, freezing polar vortex that drops stratospheric temperatures below 195 K for months; this facilitates massive formation of Polar Stratospheric Clouds (PSCs) that activate chlorine and permanently remove nitrogen oxides (denitrification), whereas the Arctic's irregular land-sea geography generates large Rossby waves that disrupt and warm the northern vortex", "isCorrect": true, "explanation": "Correct! The geography of the two poles drives their vastly different atmospheric dynamics. Antarctica is a high-altitude ice-covered continent centered directly on the South Pole, encircled by the vast, unobstructed Southern Ocean. This geographic symmetry creates a fiercely strong, stable, and completely isolated cyclonic wind system known as the Antarctic Polar Vortex. Because the vortex prevents warm mid-latitude air from mixing in, stratospheric temperatures drop below 195 K (-78°C) every winter. These ultra-cold temperatures allow dense Polar Stratospheric Clouds (PSCs, composed of nitric acid trihydrate and water ice) to form across millions of square kilometers. Heterogeneous chemical reactions on the surfaces of these ice crystals convert benign chlorine reservoirs (HCl and ClONO2) into active Cl2 gas while freezing out and sinking reactive nitrogen oxides (denitrification), leaving the stratosphere primed for catastrophic destruction the moment spring sunlight returns. In contrast, the Arctic is a semi-enclosed ocean surrounded by mountainous continents. These land-sea contrasts generate massive planetary Rossby waves that continually buffet, distort, and warm the Arctic polar vortex, keeping stratospheric temperatures mostly above the 195 K threshold required for widespread PSC formation." },
        { "text": "Because people spray 1,000 times more aerosol cans directly at the South Pole", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the magnetic field of the Earth pushes all chlorine atoms strictly south", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because penguins absorb all the ozone from the atmosphere", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
