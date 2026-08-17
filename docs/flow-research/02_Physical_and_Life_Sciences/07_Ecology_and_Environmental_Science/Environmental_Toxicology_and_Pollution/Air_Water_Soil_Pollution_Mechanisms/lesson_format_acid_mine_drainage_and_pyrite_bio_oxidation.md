# Duofy Reusable Lesson Format: Acid Mine Drainage and Pyrite Bio-Oxidation

**Target Topic:** `02_Physical_and_Life_Sciences / 07_Ecology_and_Environmental_Science / Environmental_Toxicology_and_Pollution / Air_Water_Soil_Pollution_Mechanisms`  
**Lesson Format Type:** `acid_mine_drainage_and_pyrite_bio_oxidation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the geochemical thermodynamics, microbial catalysis, and environmental degradation mechanisms of Acid Mine Drainage (AMD) (Kenneth J. Edwards; D. Barrie Johnson; Stanley Manahan): master the oxidative dissolution of **Pyrite ($\text{FeS}_2$)** exposed by coal and hard-rock mining ($4\text{FeS}_2 + 15\text{O}_2 + 14\text{H}_2\text{O} \to 4\text{Fe(OH)}_3\downarrow + 8\text{H}_2\text{SO}_4$), analyze the rate-limiting oxidation of ferrous iron ($\text{Fe}^{2+}$) to ferric iron ($\text{Fe}^{3+}$) and its $>10^5\text{-fold}$ acceleration by extreme acidophilic chemolithotrophs (***Acidithiobacillus ferrooxidans*** and *Leptospirillum ferrooxidans* at $\text{pH} < 3.0$), demonstrate how $\text{Fe}^{3+}$ acts as an aggressive **autocatalytic chemical oxidant** attacking pyrite in anoxic underground mine tunnels, identify the characteristic bright orange precipitate **"Yellow Boy" ($\text{Fe(OH)}_3 / \text{Schwertmannite}$)**, and evaluate remediation strategies (limestone neutralization beds, passive anoxic limestone drains).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Pyrite Oxidation Chemistry & Acidophilic Microbial Catalysis Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Mine Tailings Exposure to Autocatalytic AMD Runaway Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | AMD Chemical Species / Microbe & Geochemical Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Primary Acidophilic Bacterium Accelerating Fe2+ Oxidation Genus Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Autocatalytic Role of Ferric Iron (Fe3+) in Anoxic Subsurface Tunnels Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Pyrite Oxidation Chemistry & AMD Kinetics (Edwards; Johnson):
   - **The Complete Overall Acid Mine Drainage Reaction:**
     $$\mathbf{4\text{FeS}_2\text{(s)} + 15\text{O}_2 + 14\text{H}_2\text{O} \to 4\text{Fe(OH)}_3\text{(s)}\downarrow + 8\mathbf{\text{H}_2\text{SO}_4\text{(aq)}}}$$
   - **The 4-Step Reaction Mechanism:**
     - **Step 1 (Abiotic Initiation):** Oxidation of disulfide sulfur to sulfate:
       $$\text{FeS}_2 + \frac{7}{2}\text{O}_2 + \text{H}_2\text{O} \to \text{Fe}^{2+} + 2\text{SO}_4^{2-} + 2\text{H}^+$$
     - **Step 2 (The Rate-Limiting Microbial Bottle-Neck):**
       $$\text{Fe}^{2+} + \frac{1}{4}\text{O}_2 + \text{H}^+ \xrightarrow{\textit{Acidithiobacillus ferrooxidans}} \mathbf{\text{Fe}^{3+}} + \frac{1}{2}\text{H}_2\text{O}$$
       *(At $\text{pH} < 3.0$, abiotic oxidation is extremely slow; acidophilic bacteria accelerate this step by **$>100,000\text{-fold}$**!)*.
     - **Step 3 (Autocatalytic Propagation by $\text{Fe}^{3+}$):**
       $$\mathbf{\text{FeS}_2 + 14\text{Fe}^{3+} + 8\text{H}_2\text{O} \to 15\text{Fe}^{2+} + 2\text{SO}_4^{2-} + 16\text{H}^+} \qquad (\text{Occurs even with ZERO O}_2!)$$
     - **Step 4 (Precipitation):** $\text{Fe}^{3+} + 3\text{H}_2\text{O} \to \mathbf{\text{Fe(OH)}_3\downarrow \text{ ("Yellow Boy")}} + 3\text{H}^+$.
   - **Environmental Toxicity:** Generates hyper-acidic streams ($\text{pH} \approx 1.5 - 3.0$) that mobilize toxic heavy metals ($\text{Al}^{3+}, \text{Cd}^{2+}, \text{Pb}^{2+}, \text{As}$).
2. **Slide 2 (`ordering`):** Provide 5 steps of the progressive development of acid mine drainage in an abandoned mine: (1) underground mining unearths deeply buried pyrite (FeS2) deposits, exposing mineral surfaces to atmospheric oxygen and water, (2) slow abiotic oxidation generates initial sulfuric acid and ferrous iron, lowering the water pH below 3.5, (3) acidophilic chemolithoautotrophic bacteria (Acidithiobacillus ferrooxidans) colonize the acidic drainage and exponentially oxidize Fe2+ into Fe3+, (4) generated ferric iron (Fe3+) acts as a fierce chemical oxidant, directly attacking remaining pyrite mineral faces in a runaway autocatalytic loop, (5) the acidic water spills into surface streams, precipitating thick blankets of orange ferric hydroxide ('Yellow Boy') that smother river ecosystems!
3. **Slide 3 (`matching`):** Pair 4 AMD components (Pyrite FeS2, Acidithiobacillus ferrooxidans, Ferric Iron Fe3+, Yellow Boy Fe(OH)3) with their geochemical roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the key acidophilic bacterial genus responsible for catalyzing acid mine drainage is Acidithiobacillus. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the self-propagating mechanism of ferric iron in anoxic underground mine shafts: Why does flooding an abandoned underground mine shaft with water fail to stop acid mine drainage once the pH has dropped below 3.0? (Because once formed, **ferric iron ($\text{Fe}^{3+}$) acts as a powerful direct chemical oxidant that can dissolve pyrite without requiring any molecular oxygen** ($\text{FeS}_2 + 14\text{Fe}^{3+} + 8\text{H}_2\text{O} \to 15\text{Fe}^{2+} + 2\text{SO}_4^{2-} + 16\text{H}^+$), creating an **autocatalytic, self-sustaining subsurface reaction that continues in total darkness and complete anoxia**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "acid_mine_drainage_and_pyrite_bio_oxidation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Acid Mine Drainage & Pyrite Bio-Oxidation**\n• **The Global AMD Stoichiometry:**\n$$\n\\mathbf{4\\text{FeS}_2 + 15\\text{O}_2 + 14\\text{H}_2\\text{O} \\to 4\\text{Fe(OH)}_3\\downarrow + 8\\mathbf{\\text{H}_2\\text{SO}_4}}\n$$\n• **The Microbial Catalyst ($\\text{pH} < 3.0$):**\n$$\n\\text{Fe}^{2+} + \\frac{1}{4}\\text{O}_2 + \\text{H}^+ \\xrightarrow{\\mathbf{\\textit{Acidithiobacillus ferrooxidans}}} \\mathbf{\\text{Fe}^{3+}} + \\frac{1}{2}\\text{H}_2\\text{O} \\quad (\\mathbf{>10^5\\text{-fold Rate Surge!}})\n$$\n• **The Autocatalytic $\\text{Fe}^{3+}$ Loop (Operates with ZERO Oxygen):**\n$$\n\\mathbf{\\text{FeS}_2 + 14\\text{Fe}^{3+} + 8\\text{H}_2\\text{O} \\to 15\\text{Fe}^{2+} + 2\\text{SO}_4^{2-} + 16\\text{H}^+}\n$$\n• **'Yellow Boy' Precipitation:** $\\text{Fe(OH)}_3$ forms an orange sludge coating stream beds and suffocating aquatic gills!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential geochemical and biological steps of runaway Acid Mine Drainage generation.",
      "orderItems": [
        "Mining excavation exposes previously buried subsurface Pyrite (FeS2) minerals to atmospheric oxygen and water",
        "Slow abiotic weathering produces initial sulfuric acid and dissolved ferrous iron (Fe2+), lowering the pH below 3.5",
        "Acidophilic Acidithiobacillus ferrooxidans bacteria colonize the runoff and accelerate Fe2+ to Fe3+ oxidation by >100,000x",
        "Abundant ferric iron (Fe3+) acts as an aggressive cyclic oxidant, attacking deeper pyrite in a runaway autocatalytic loop",
        "Hyper-acidic runoff (pH 1.5-2.5) enters surface rivers, precipitating blankets of orange ferric hydroxide ('Yellow Boy')"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Acid Mine Drainage term to its exact geochemical function.",
      "matchPairs": [
        { "left": "Pyrite (FeS2)", "right": "Primary iron disulfide mineral responsible for sulfuric acid and dissolved heavy metal generation" },
        { "left": "Acidithiobacillus ferrooxidans", "right": "Extreme acidophilic chemolithoautotroph accelerating the rate-limiting oxidation of Fe2+ to Fe3+" },
        { "left": "Ferric Iron (Fe3+)", "right": "Potent secondary chemical oxidant that rapidly dissolves pyrite even in completely anoxic conditions" },
        { "left": "Yellow Boy (Fe(OH)3)", "right": "Insoluble bright orange ferric hydroxide precipitate that coats stream substrates and smothers benthic life" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The primary genus of acidophilic chemolithotrophic bacteria that bio-oxidizes ferrous iron to accelerate acid mine drainage is ___.",
      "blankAnswer": "acidithiobacillus",
      "blankDistractors": ["pseudomonas", "rhizobium", "clostridium"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does sealing and completely submerging an abandoned underground coal mine with anoxic groundwater often fail to stop the production of severe Acid Mine Drainage once the internal pH has fallen below 2.5?",
      "options": [
        { "text": "Under acidic conditions, dissolved ferric iron (Fe3+) acts as a fierce chemical oxidant that directly attacks and dissolves pyrite without needing any molecular oxygen (FeS2 + 14Fe3+ + 8H2O -> 15Fe2+ + 2SO4(2-) + 16H+), sustaining a continuous autocatalytic acid-generating cycle in deep anoxic tunnels", "isCorrect": true, "explanation": "Correct! While oxygen is required to initiate the very first step of pyrite oxidation, once the pH of the mine pool drops below 2.5 to 3.0, the primary oxidant of pyrite changes from dissolved O2 to aqueous ferric iron (Fe3+). Ferric iron oxidizes pyrite according to the reaction: FeS2 + 14Fe3+ + 8H2O -> 15Fe2+ + 2SO4(2-) + 16H+. This reaction requires ZERO molecular oxygen. As long as dissolved ferric iron is present in the acidic water, it will aggressively strip electrons from the pyrite crystal lattice, generating 16 moles of H+ acid and 15 moles of Fe2+ for every single mole of FeS2 oxidized. Acidophilic bacteria on the tunnel walls and near the water table rapidly regenerate Fe3+ from Fe2+, creating an unstoppable autocatalytic biochemical engine that can pollute downstream watersheds for decades or centuries even after underground tunnels are sealed." },
        { "text": "Because submerged coal turns into radioactive plutonium", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because water creates pure hydrochloric acid when mixed with darkness", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because fish swimming into the mine carry oxygen in their scales", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
