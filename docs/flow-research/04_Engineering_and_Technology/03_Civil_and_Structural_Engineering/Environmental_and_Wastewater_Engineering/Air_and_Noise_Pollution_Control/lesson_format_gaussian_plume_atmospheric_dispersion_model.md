# Duofy Reusable Lesson Format: Atmospheric Dispersion (Gaussian Plume Ground Concentration)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Environmental_and_Wastewater_Engineering / Air_and_Noise_Pollution_Control`  
**Lesson Format Type:** `gaussian_plume_atmospheric_dispersion_model`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through atmospheric pollutant dispersion modeling from industrial smokestacks, the 3D Cartesian coordinate system ($x$ downwind, $y$ crosswind, $z$ vertical), Pasquill-Gifford atmospheric stability classes (A extremely unstable through F moderately stable), horizontal and vertical dispersion coefficients ($\sigma_y, \sigma_z$), physical stack height ($h_s$) plus plume rise ($\Delta h$) establishing **Effective Stack Height ($H = h_s + \Delta h$)**, total ground reflection of pollutants, and the calculation of **Ground-Level Centerline Concentration ($C(x, 0, 0)$)** (Mackenzie L. Davis *Introduction to Environmental Engineering* 5th ed. Chapter 9; C. David Cooper *Air Pollution Control* Chapter 20): formulate the **Gaussian Plume Ground-Level Centerline Master Equation ($y = 0, z = 0$)**:
$$\mathbf{C(x, 0, 0; H) = \frac{Q}{\pi \cdot u \cdot \sigma_y \cdot \sigma_z} \exp\left( -\frac{H^2}{2 \sigma_z^2} \right) \quad \left[\frac{\mu\text{g}}{\text{m}^3} \text{ or } \frac{\text{g}}{\text{m}^3}\right]}$$
where:
1. **$Q$:** Pollutant emission rate from smokestack ($\text{g/s}$ or $\mu\text{g/s}$);
2. **$u$:** Mean wind speed at effective stack height ($\text{m/s}$);
3. **$\sigma_y, \sigma_z$:** Standard deviations of plume concentration distribution in crosswind ($y$) and vertical ($z$) directions (in meters, growing with downwind distance $x$);
4. **$H = h_s + \Delta h$:** Effective stack height in meters;
master the **Maximum Ground-Level Concentration Invariant**:
- The absolute peak ground concentration $C_{\text{max}}$ occurs at the downwind distance $x_{\text{max}}$ where the vertical dispersion coefficient satisfies:
  $$\mathbf{\sigma_z = \frac{H}{\sqrt{2}} \approx 0.707 H \implies \mathbf{C_{\text{max}} = \frac{Q}{\pi \cdot u \cdot \sigma_y \cdot \sigma_z \cdot e} = \frac{2 Q}{\pi \cdot u \cdot e \cdot H^2 \left( \frac{\sigma_y}{\sigma_z} \right)}}}$$
(proving that doubling effective stack height $H$ reduces maximum ground-level pollutant concentrations by a factor of four ($C_{\text{max}} \propto 1/H^2$)).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Gaussian Plume Equation ($C = \frac{Q}{\pi u \sigma_y \sigma_z} \exp(-\frac{H^2}{2\sigma_z^2})$), $H = h_s + \Delta h$ & $\sigma_z = H/\sqrt{2}$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Ground-Level Centerline Pollutant Concentration 2 km Downwind Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Atmospheric Dispersion Parameter / Plume Entity & Technical Environmental Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Under the Gaussian Plume Model with Ground Reflection, the Maximum Ground-Level Centerline Concentration Occurs at the Downwind Location Where $\sigma_z$ Equals $H$ Divided by $\sqrt{\text{___}}$ (2 / Two) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Air Quality Permitting Problem: Computing SO_2 Ground Concentration 1.5 km Downwind of an Industrial Stack Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Gaussian Plume Dispersion Mechanics (Pasquill 1961; Gifford 1961; Davis 2020):
   - **Plume Concentration Formulations:**
     $$\mathbf{C(x, 0, 0) = \frac{Q}{\pi u \sigma_y \sigma_z}\exp\left(-\frac{H^2}{2\sigma_z^2}\right) \quad \Big| \quad H = h_s + \Delta h \quad \Big| \quad \text{Peak: } \sigma_z = \frac{H}{\sqrt{2}} \quad \Big| \quad C_{\text{max}} \propto \frac{1}{H^2}}$$
   - **Pasquill-Gifford Stability Classes Matrix:**
     $$\begin{array}{|l|l|c|l|}
     \hline
     \textbf{Stability Class} & \textbf{Atmospheric Condition} & \textbf{Solar Radiation / Wind} & \textbf{Dispersion Behavior} \\
     \hline
     \mathbf{\text{Class A}} & \mathbf{\text{Extremely Unstable}} & \text{Strong daytime sun, low wind} & \text{Rapid vertical looping plume} \\
     \mathbf{\text{Class B}} & \text{Moderately Unstable} & \text{Moderate daytime sun} & \text{Strong mixing and dilution} \\
     \mathbf{\text{Class C}} & \text{Slightly Unstable} & \text{Slight sun / high wind} & \text{Coning plume} \\
     \mathbf{\text{Class D}} & \mathbf{\text{Neutral Condition}} & \mathbf{\text{Overcast day or night}} & \mathbf{\text{Standard baseline dispersion}} \\
     \mathbf{\text{Class E}} & \text{Slightly Stable} & \text{Nighttime with cloud cover} & \text{Fanning plume; slow vertical spread} \\
     \mathbf{\text{Class F}} & \mathbf{\text{Moderately Stable}} & \mathbf{\text{Clear night, low wind (Inversion)}} & \mathbf{\text{Minimal dispersion; high downwind hazard}} \\
     \hline
     \end{array}$$
   - **The Inverse Wind Dilution Invariant:** Ground concentration is **strictly inversely proportional to wind speed ($C \propto 1/u$)**; cutting wind speed in half doubles the downwind pollutant concentration!
2. **Slide 2 (`ordering`):** Provide 5 steps of air quality impact analysis: (1) determine source emission rate $Q$ in $\text{g/s}$ and calculate effective stack height $H = h_s + \Delta h$, (2) determine atmospheric stability class (A through F) and mean wind speed $u$ at stack height, (3) look up or compute dispersion coefficients $\sigma_y$ and $\sigma_z$ at target downwind distance $x$, (4) calculate the centerline exponential reflection term: $\exp(-H^2 / 2\sigma_z^2)$, (5) evaluate ground-level concentration $C(x, 0, 0) = \frac{Q}{\pi u \sigma_y \sigma_z} \exp(-H^2 / 2\sigma_z^2)$ and convert to $\mu\text{g/m}^3$ to check National Ambient Air Quality Standards (NAAQS)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Effective Stack Height $H$, Dispersion Coefficient $\sigma_y$, Class D Neutral Stability, Stack Height Scaling $1/H^2$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 2 (or Two). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating Gaussian ground-level concentration: A coal power plant emits $\text{SO}_2$ at rate $Q = 100.0\text{ g/s} = 1.0 \times 10^8\text{ }\mu\text{g/s}$ from an effective stack height $H = 80.0\text{ m}$. Wind speed at stack top is $u = 5.0\text{ m/s}$. At downwind distance $x = 1.50\text{ km}$ under Class C stability, dispersion coefficients are $\sigma_y = 150.0\text{ m}$ and $\sigma_z = 80.0\text{ m}$.
   - Note that $\sigma_z = 80.0\text{ m} = H \implies \frac{H^2}{2\sigma_z^2} = \frac{80.0^2}{2(80.0^2)} = \frac{1}{2} = 0.50$;
   - Exponential factor: $\exp(-0.50) = e^{-0.50} = \mathbf{0.60653}$;
   - Denominator: $\pi \cdot u \cdot \sigma_y \cdot \sigma_z = \pi \times 5.0 \times 150.0 \times 80.0 = \pi \times 60,000 = \mathbf{188,495.56\text{ m}^3\text{/s}}$;
   - Ground-level concentration: $C = \frac{100.0\text{ g/s}}{188,495.56\text{ m}^3\text{/s}} \times 0.60653 = 5.30517 \times 10^{-4} \times 0.60653 = \mathbf{3.218 \times 10^{-4}\text{ g/m}^3 = 321.8\text{ }\mu\text{g/m}^3}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "gaussian_plume_atmospheric_dispersion_model",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Gaussian Plume Atmospheric Dispersion (Pasquill \\& Gifford)**\n• **Ground-Level Centerline Concentration Master Formulation ($y=0, z=0$):**\n$$\n\\mathbf{C(x, 0, 0; H) = \\frac{Q}{\\pi \\cdot u \\cdot \\sigma_y \\cdot \\sigma_z} \\exp\\left( -\\frac{H^2}{2 \\sigma_z^2} \\right) \\quad \\left[\\frac{\\mu\\text{g}}{\\text{m}^3} \\text{ or } \\frac{\\text{g}}{\\text{m}^3}\\right]}\n$$\n  - **$Q$:** Pollutant emission mass release rate ($\\text{g/s}$ or $\\mu\\text{g/s}$);\n  - **$u$:** Mean horizontal wind speed at stack height ($\\text{m/s}$);\n  - **$\\sigma_y, \\sigma_z$:** Crosswind and vertical dispersion standard deviations ($\\text{m}$);\n  - **$H = h_s + \\Delta h$:** Effective stack height (Physical height $h_s$ + Plume rise $\\Delta h$);\n• **Peak Ground Concentration Location ($\\frac{dC}{dx} = 0$):**\n$$\n\\mathbf{\\sigma_z = \\frac{H}{\\sqrt{2}} \\approx 0.707 H \\implies \\mathbf{C_{\\text{max}} \\propto \\frac{Q}{u \\cdot H^2}}}\n$$\n• **The Stack Height Quadratic Invariant:** Doubling the effective stack height $H$ reduces the maximum ground-level pollutant concentration by **a factor of four ($C_{\\text{max}} \\propto 1/H^2$)**, protecting adjacent residential communities!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the ground-level centerline air pollutant concentration downwind of an industrial stack.",
      "orderItems": [
        "Determine the source pollutant mass emission rate Q and calculate effective stack height H = hs + \u0394h",
        "Identify atmospheric stability class (A through F) and mean wind speed u at effective release height",
        "Look up or compute the lateral and vertical dispersion coefficients (\u03c3y and \u03c3z) at the target downwind distance x",
        "Calculate the vertical ground reflection exponential term: exp[ -H^2 / (2*\u03c3z^2) ]",
        "Compute ground concentration: C(x,0,0) = [ Q / (\u03c0 * u * \u03c3y * \u03c3z) ] * exp[ -H^2 / (2*\u03c3z^2) ] and compare with air quality standards"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Atmospheric Dispersion Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Effective Stack Height (H)", "right": "H = hs + \u0394h, virtual release height combining physical chimney height with thermal/momentum plume rise" },
        { "left": "Dispersion Width (\u03c3y)", "right": "Standard deviation of crosswind Gaussian spread that expands continuously with downwind travel distance" },
        { "left": "Ground Reflection Factor", "right": "Doubles ground-level concentration due to impermeable terrain preventing downward pollutant penetration" },
        { "left": "Stability Class F", "right": "Moderately stable nighttime inversion condition with suppressed vertical mixing causing narrow hazardous plumes" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Under the Gaussian plume model with ground reflection, the maximum ground-level concentration occurs at the downwind location where \u03c3z equals H divided by \u221a___.",
      "blankAnswer": "2",
      "blankDistractors": ["3", "4", "\u03c0"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A stack emits SO2 at Q = 100.0 g/s with effective height H = 80.0 m in wind u = 5.0 m/s. At x = 1.5 km, \u03c3y = 150.0 m and \u03c3z = 80.0 m (\u03c3z = H \u2192 exp(-H^2 / 2\u03c3z^2) = e^-0.50 = 0.6065). Denominator \u03c0*u*\u03c3y*\u03c3z = \u03c0*5*150*80 = 188,496 m^3/s. What is the ground-level centerline SO2 concentration C in \u03bcg/m^3?",
      "options": [
        { "text": "C = 321.8 \u03bcg/m^3 (C = (100.0 g/s / 188,496 m^3/s) * 0.60653 = 5.305 \u00d7 10^-4 * 0.60653 = 3.218 \u00d7 10^-4 g/m^3 = 321.8 \u03bcg/m^3)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Gaussian Plume atmospheric dispersion equation (Mackenzie L. Davis *Introduction to Environmental Engineering* Chapter 9). 1. **Identify Source \\& Meteorological Parameters:** - Pollutant release rate: $Q = 100.0\\text{ g/s} = 1.0 \\times 10^8\\text{ }\\mu\\text{g/s}$. - Effective stack height: $H = 80.0\\text{ m}$. - Wind speed: $u = 5.0\\text{ m/s}$. - Dispersion coefficients at $x = 1.5\\text{ km}$: $\\sigma_y = 150.0\\text{ m}, \\quad \\sigma_z = 80.0\\text{ m}$. 2. **Calculate Vertical Exponential Ground Reflection Term:** - Exponent argument: $$-\\frac{H^2}{2 \\sigma_z^2} = -\\frac{(80.0\\text{ m})^2}{2 \\times (80.0\\text{ m})^2} = -\\frac{1}{2} = -0.50$$ - Exponential value: $$\\exp(-0.50) = e^{-0.50} = \\mathbf{0.606531}$$ 3. **Calculate Plume Dilution Denominator:** $$\\text{Denominator} = \\pi \\cdot u \\cdot \\sigma_y \\cdot \\sigma_z = \\pi \\times (5.0\\text{ m/s}) \\times (150.0\\text{ m}) \\times (80.0\\text{ m})$$ $$\\text{Denominator} = \\pi \\times 60,000 = \\mathbf{188,495.56\\text{ m}^3\\text{/s}}$$ 4. **Calculate Ground-Level Centerline Concentration ($C$):** $$C(1.5\\text{ km}, 0, 0) = \\frac{Q}{\\pi \\cdot u \\cdot \\sigma_y \\cdot \\sigma_z} \\exp\\left( -\\frac{H^2}{2 \\sigma_z^2} \\right)$$ $$C = \\frac{100.0\\text{ g/s}}{188,495.56\\text{ m}^3\\text{/s}} \\times 0.606531 = (5.305165 \\times 10^{-4}\\text{ g/m}^3) \\times 0.606531$$ $$C = \\mathbf{3.21775 \\times 10^{-4}\\text{ g/m}^3 = 321.78\\text{ }\\mu\\text{g/m}^3 \\approx 321.8\\text{ }\\mu\\text{g/m}^3}$$ Flawless Gaussian plume atmospheric dispersion derivation!" },
        { "text": "C = 530.5 \u03bcg/m^3 (Forgot the exponential ground reflection factor)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "C = 160.9 \u03bcg/m^3", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "C = 643.6 \u03bcg/m^3", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
