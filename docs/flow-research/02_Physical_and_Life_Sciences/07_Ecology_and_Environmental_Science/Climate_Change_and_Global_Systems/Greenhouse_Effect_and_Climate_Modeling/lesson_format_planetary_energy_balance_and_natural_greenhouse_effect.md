# Duofy Reusable Lesson Format: Planetary Energy Balance and the Natural Greenhouse Effect

**Target Topic:** `02_Physical_and_Life_Sciences / 07_Ecology_and_Environmental_Science / Climate_Change_and_Global_Systems / Greenhouse_Effect_and_Climate_Modeling`  
**Lesson Format Type:** `planetary_energy_balance_and_natural_greenhouse_effect`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the fundamental radiation physics, planetary blackbody balances, and greenhouse gas absorption mechanisms of Earth's climate (Joseph Fourier 1827; John Tyndall 1859; Svante Arrhenius 1896): calculate the zero-dimensional planetary energy balance equation ($F_{\text{in}} = \frac{S_0}{4}(1-\alpha_p) = F_{\text{out}} = \sigma T_e^4$), derive the **Effective Blackbody Radiating Temperature ($T_e \approx 255\text{ K} = -18^\circ\text{C}$)** using the solar constant ($S_0 \approx 1361\text{ W/m}^2$) and planetary albedo ($\alpha_p \approx 0.30$), compare with Earth's measured global mean surface temperature ($T_s \approx 288\text{ K} = +15^\circ\text{C}$), analyze the **Natural Greenhouse Effect ($\Delta T_{\text{GH}} = T_s - T_e = +33^\circ\text{C}$)**, and evaluate the relative absorption contributions of **Water Vapor ($\sim 60\%$)**, **Carbon Dioxide ($\sim 26\%$)**, and the **Atmospheric Infrared Window ($8-12\ \mu\text{m}$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Zero-D Planetary Energy Balance & 33K Greenhouse Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Shortwave Solar Influx to Downward Longwave Re-radiation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Radiation Term / GHG & Radiative Absorption Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Numerical Value of Earth's Natural Greenhouse Warming in Degrees Celsius Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Physical Distinction Between a Real Glass Greenhouse and the Atmospheric Greenhouse Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Planetary Energy Balance & Natural Greenhouse Effect (Fourier 1827; Tyndall 1859):
   - **Zero-Dimensional Energy Balance:**
     $$\mathbf{\frac{S_0}{4}(1 - \alpha_p) = \sigma T_e^4}$$
     - $S_0 = 1361\text{ W/m}^2$ (Solar Constant at 1 AU).
     - $\alpha_p = 0.30$ (Planetary Albedo / shortwave reflection by clouds/ice/surface).
     - $\sigma = 5.67 \times 10^{-8}\text{ W}\cdot\text{m}^{-2}\text{K}^{-4}$ (Stefan-Boltzmann constant).
     - **Effective Radiating Temperature ($T_e$):**
       $$\mathbf{T_e = \left(\frac{1361 \times (1 - 0.30)}{4 \times 5.67 \times 10^{-8}}\right)^{1/4} = \left(\frac{238.175}{5.67 \times 10^{-8}}\right)^{1/4} \approx \mathbf{255\text{ K} \ (-18^\circ\text{C})}}$$
   - **The Natural Greenhouse Magnitude ($\Delta T_{\text{GH}}$):**
     $$\mathbf{\Delta T_{\text{GH}} = T_{\text{actual}} - T_e = 288\text{ K} - 255\text{ K} = \mathbf{+33\text{ K} \ (+33^\circ\text{C})}}$$
   - **Greenhouse Gas Breakdown:** $\text{H}_2\text{O}$ vapor ($\sim 60\%$), $\text{CO}_2$ ($\sim 26\%$), $\text{O}_3$ ($\sim 8\%$), $\text{CH}_4 + \text{N}_2\text{O}$ ($\sim 6\%$).
   - **Atmospheric Window ($8-12\ \mu\text{m}$):** Narrow spectral gap where infrared escapes directly to space.
2. **Slide 2 (`ordering`):** Provide 5 steps of the global planetary energy flow: (1) incoming solar shortwave radiation (1361 W/m^2) strikes the top of Earth's atmosphere, (2) clouds, aerosols, and bright surface ice reflect roughly 30% directly back into space (planetary albedo), (3) the remaining 70% (238 W/m^2) is absorbed by Earth's surface and atmosphere, warming the planet, (4) the warm surface emits longwave thermal infrared radiation upward, (5) atmospheric greenhouse gases (H2O, CO2) absorb the longwave radiation and re-emit infrared in all directions, including downward back to the surface (back-radiation), raising surface temperature to 288 K (+15°C)!
3. **Slide 3 (`matching`):** Pair 4 radiative components (Effective Radiating Temp 255K, Surface Temp 288K, Atmospheric Window 8-12 um, Water Vapor) with their physical properties.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the natural greenhouse effect warms Earth's surface by 33 degrees Celsius above its bare blackbody temperature. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the physical difference between an agricultural glass greenhouse and the atmospheric greenhouse effect: Why is the term 'greenhouse effect' a physical misnomer when comparing Earth's atmosphere to a real gardener's glass greenhouse? (A glass greenhouse stays warm primarily by **physically blocking turbulent convective heat loss and air mixing** with the outside cold air, whereas the atmospheric greenhouse effect operates purely through **radiative transfer—absorbing outgoing terrestrial longwave infrared and re-radiating thermal energy back toward the surface**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "planetary_energy_balance_and_natural_greenhouse_effect",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Planetary Energy Balance & The Natural Greenhouse**\n• **Zero-D Radiative Equilibrium:**\n$$\n\\mathbf{F_{\\text{in}} = \\frac{S_0}{4}(1 - \\alpha_p) = \\sigma T_e^4 \\implies T_e = \\left(\\frac{1361 \\times 0.70}{4 \\times 5.67 \\times 10^{-8}}\\right)^{1/4} \\approx 255\\text{ K} \\ (-18^\\circ\\text{C})}\n$$\n• **The $+33^\\circ\\text{C}$ Natural Greenhouse Blanket:**\n$$\n\\mathbf{\\Delta T_{\\text{GH}} = T_s (288\\text{ K}) - T_e (255\\text{ K}) = \\mathbf{+33\\text{ K} \\ (+33^\\circ\\text{C})}}\n$$\n• **Greenhouse Gas Radiative Contributions:**\n  - **Water Vapor ($\\text{H}_2\\text{O}$):** $\\approx 60\\%$ | **Carbon Dioxide ($\\text{CO}_2$):** $\\approx 26\\%$.\n  - **Ozone ($\\text{O}_3$):** $\\approx 8\\%$ | **Methane ($\\text{CH}_4$) + Nitrous Oxide ($\\text{N}_2\\text{O}$):** $\\approx 6\\%$.\n• **Atmospheric Infrared Window ($8\\text{--}12\\ \\mu\\text{m}$):** Spectral gap where heat radiates directly to space!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of Earth's global radiative energy balance.",
      "orderItems": [
        "Incoming solar shortwave flux (averaging 340 W/m² globally) strikes the top of the atmosphere",
        "Clouds, aerosols, and snow reflect approximately 30% of incident sunlight directly back into space",
        "The remaining 70% (238 W/m²) is absorbed by land, oceans, and air, warming the surface to an average of +15°C",
        "The warm terrestrial surface emits longwave thermal infrared radiation upward according to the Stefan-Boltzmann law",
        "Atmospheric greenhouse gases absorb longwave photons and re-radiate infrared energy downward (back-radiation) to sustain 288 K"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each radiative term to its exact physical property in planetary climatology.",
      "matchPairs": [
        { "left": "Effective Radiating Temp (255 K)", "right": "Theoretical blackbody temperature Earth must maintain to radiate 238 W/m² back into space" },
        { "left": "Actual Surface Temp (288 K)", "right": "Real observed global mean temperature (+15°C) maintained by the atmospheric greenhouse blanket" },
        { "left": "Atmospheric Infrared Window (8-12 um)", "right": "Spectral transmission band where the unclouded atmosphere is transparent to outgoing infrared radiation" },
        { "left": "Water Vapor (H2O)", "right": "Dominant natural greenhouse gas responsible for roughly 60% of natural infrared absorption" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The natural atmospheric greenhouse effect raises Earth's average surface temperature by approximately ___ degrees Celsius above its bare radiating temperature.",
      "blankAnswer": "33",
      "blankDistractors": ["3", "100", "15"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the term 'greenhouse effect' technically a physical misnomer when comparing Earth's atmosphere to an actual glass botanical greenhouse?",
      "options": [
        { "text": "A real glass greenhouse stays warm primarily by physically trapping air and preventing turbulent convective heat loss to the outside environment, whereas Earth's atmospheric greenhouse effect operates purely through radiative transfer—absorbing outgoing terrestrial longwave infrared and re-radiating thermal energy back toward the ground", "isCorrect": true, "explanation": "Correct! In 1909, physicist Robert Wood famously demonstrated that an actual glass greenhouse warms up not because glass is opaque to infrared radiation, but because the physical glass structure acts as a mechanical barrier that prevents warm air from rising and mixing with colder outside air (suppressing turbulent convective sensible and latent heat loss). In contrast, Earth's atmosphere is completely open to space and is not covered by a physical lid. The atmospheric 'greenhouse effect' is an entirely radiative phenomenon: greenhouse gases (H2O, CO2, CH4) absorb outgoing longwave infrared photons emitted by the ground and re-radiate thermal energy isotropically in all directions, including downward toward the surface (atmospheric back-radiation). This downward infrared flux heats the surface to an average of +15°C (288 K), a full 33°C warmer than the 255 K blackbody temperature required to balance incoming solar radiation at the top of the atmosphere." },
        { "text": "Because real greenhouses only work when painted green", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the atmosphere is made of solid glass panels in the thermosphere", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because real greenhouses absorb ultraviolet light instead of infrared", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
