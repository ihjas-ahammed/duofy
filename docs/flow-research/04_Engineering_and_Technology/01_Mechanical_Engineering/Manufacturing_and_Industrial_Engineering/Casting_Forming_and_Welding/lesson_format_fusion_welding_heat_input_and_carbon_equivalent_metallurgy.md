# Duofy Reusable Lesson Format: Welding Metallurgy (Heat Input & Carbon Equivalent)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Manufacturing_and_Industrial_Engineering / Casting_Forming_and_Welding`  
**Lesson Format Type:** `fusion_welding_heat_input_and_carbon_equivalent_metallurgy`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through arc welding power delivery, net thermal energy input, the Heat-Affected Zone (HAZ) microstructural evolution, and carbon equivalent weldability criteria in manufacturing joining processes (Serope Kalpakjian & Steven R. Schmid *Manufacturing Engineering and Technology* Chapter 30 & 31; Mikell P. Groover *Fundamentals of Modern Manufacturing* Chapter 30 & 31; AWS D1.1 Structural Welding Code; IIW International Institute of Welding): master the **Net Arc Welding Heat Input Formula**:
$$\mathbf{H_{\text{net}} = \eta_{\text{arc}} \cdot \frac{V \cdot I}{v} \ [\text{J/mm or kJ/mm}]}$$
where $V$ is arc voltage (Volts), $I$ is welding current (Amperes), $v$ is torch travel speed ($\text{mm/s}$), and $\eta_{\text{arc}}$ is arc thermal efficiency ($\eta \approx 0.80$ for SMAW, $\eta \approx 0.85$ for GMAW/MIG, $\eta \approx 0.65$ for GTAW/TIG, $\eta \approx 0.95$ for SAW); master the **Heat Affected Zone (HAZ)** microstructural transformation (fusion zone $\to$ coarse-grained austenite $\to$ fine-grained recrystalized $\to$ intercritical zone); and evaluate steel weldability using the **IIW Carbon Equivalent Index ($\mathbf{CE}$)**:
$$\mathbf{CE = \%C + \frac{\%Mn + \%Si}{6} + \frac{\%Cr + \%Mo + \%V}{5} + \frac{\%Ni + \%Cu}{15} \le 0.40\%}$$
(proving why steels with $CE > 0.40\%$ form hard, brittle untempered martensite during rapid weld cooling, making preheating ($150-250^\circ\text{C}$) and low-hydrogen electrodes mandatory to prevent catastrophic hydrogen-induced cold cracking).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Net Heat Input Formulation ($H_{\text{net}} = \eta \frac{V I}{v}$) & Carbon Equivalent ($CE \le 0.40\%$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of Welding Heat Input, Cooling Rate, and Preheating Determination Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Welding Process / Metallurgy Entity & Technical Physical Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Region of Base Metal Whose Microstructure and Mechanical Properties Are Altered by Welding Heat Is the Heat-___ Zone (Affected) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Welding Engineering Problem: Calculating the Net Heat Input H_net for a Submerged Arc Welding Joint Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Welding Heat Input & Metallurgy (Kalpakjian 2020; IIW; AWS):
   - **Net Heat Input Formulation:**
     $$\mathbf{H_{\text{net}} = \eta \frac{V \cdot I}{v} \ [\text{J/mm}] \quad (V = \text{Voltage}, \ I = \text{Current}, \ v = \text{Travel Speed})}$$
   - **Process Arc Efficiency Matrix:**
     $$\begin{array}{|l|c|l|}
     \hline
     \textbf{Welding Process} & \textbf{Thermal Efficiency } \eta & \textbf{Dominant Application} \\
     \hline
     \mathbf{\text{Submerged Arc (SAW)}} & \mathbf{\eta \approx 0.90 - 0.99} & \text{Thick pressure vessels, highest deposition} \\
     \mathbf{\text{Gas Metal Arc (GMAW/MIG)}} & \mathbf{\eta \approx 0.80 - 0.85} & \text{Automated manufacturing, high productivity} \\
     \mathbf{\text{Shielded Metal Arc (SMAW/Stick)}} & \mathbf{\eta \approx 0.70 - 0.80} & \text{Field construction, pipe welding} \\
     \mathbf{\text{Gas Tungsten Arc (GTAW/TIG)}} & \mathbf{\eta \approx 0.60 - 0.70} & \text{Aerospace, clean root passes} \\
     \hline
     \end{array}$$
   - **IIW Carbon Equivalent Weldability Invariant:**
     $$\mathbf{CE = \%C + \frac{\%Mn + \%Si}{6} + \frac{\%Cr + \%Mo + \%V}{5} + \frac{\%Ni + \%Cu}{15} \le 0.40\%}$$
     - Steels with $\mathbf{CE \le 0.40\%}$ are readily weldable without preheating; if $\mathbf{CE > 0.40\%}$, preheating is required to prevent hydrogen-induced martensitic underbead cracking!
2. **Slide 2 (`ordering`):** Provide 5 steps of welding analysis: (1) calculate chemical carbon equivalent $CE$ of base alloy to check weldability, (2) select welding process and determine arc thermal efficiency $\eta$, (3) set voltage $V$, current $I$, and travel speed $v$ to compute net heat input $H = \eta \frac{V I}{v}$, (4) evaluate cooling rate $\Delta t_{8/5}$ across $800^\circ\text{C} \to 500^\circ\text{C}$ transformation zone, (5) specify preheat temperature ($150-250^\circ\text{C}$) if $CE > 0.40\%$ or if fast cooling risks hard martensite formation!
3. **Slide 3 (`matching`):** Pair 4 concepts (Net Heat Input $H_{\text{net}}$, Heat Affected Zone HAZ, Carbon Equivalent $CE$, Submerged Arc Welding SAW) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Affected. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating net heat input: A Submerged Arc Welding (SAW) operation operates with arc voltage $V = 30\text{ Volts}$, welding current $I = 400\text{ Amperes}$, and welding travel speed $v = 8.0\text{ mm/s}$. The process thermal efficiency is $\eta = 0.90$. What is the net heat input $H_{\text{net}}$ delivered to the weld joint in $\text{kJ/mm}$? ($H_{\text{net}} = \eta \frac{V \cdot I}{v} = 0.90 \frac{(30\text{ V})(400\text{ A})}{8.0\text{ mm/s}} = 0.90 \frac{12,000\text{ J/s}}{8.0\text{ mm/s}} = 0.90 (1500\text{ J/mm}) = \mathbf{1350\text{ J/mm} = 1.35\text{ kJ/mm}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "fusion_welding_heat_input_and_carbon_equivalent_metallurgy",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Welding Heat Input \\& Carbon Equivalent Metallurgy (Kalpakjian \\& IIW)**\n• **Net Arc Welding Heat Input Formulation:**\n$$\n\\mathbf{H_{\\text{net}} = \\eta_{\\text{arc}} \\cdot \\frac{V \\cdot I}{v} \\ [\\text{J/mm}] \\quad (V = \\text{Voltage}, \\ I = \\text{Current}, \\ v = \\text{Travel Speed})}\n$$\n• **Arc Process Thermal Efficiencies:**\n  - **SAW (Submerged Arc):** $\\mathbf{\\eta \\approx 0.90 - 0.95}$ (Buried under granular flux, lowest heat loss);\n  - **GMAW (MIG):** $\\mathbf{\\eta \\approx 0.80 - 0.85}$; **SMAW (Stick):** $\\mathbf{\\eta \\approx 0.70 - 0.80}$; **GTAW (TIG):** $\\mathbf{\\eta \\approx 0.60 - 0.70}$.\n• **IIW Carbon Equivalent (CE) Weldability Criterion:**\n$$\n\\mathbf{CE = \\%C + \\frac{\\%Mn + \\%Si}{6} + \\frac{\\%Cr + \\%Mo + \\%V}{5} + \\frac{\\%Ni + \\%Cu}{15} \\le 0.40\\%}\n$$\n• **The HAZ Cracking Invariant:** If $\\mathbf{CE > 0.40\\%}$, rapid cooling of the Heat-Affected Zone (HAZ) forms hard, brittle **Martensite**, leading to catastrophic hydrogen-induced cold cracking unless base metal is preheated!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to evaluate welding process energy delivery and specify preheat requirements for structural steel.",
      "orderItems": [
        "Calculate the Carbon Equivalent (CE) from the mill test chemical composition report of the steel",
        "Select the arc welding process and identify its associated thermal arc efficiency eta",
        "Set welding electrical parameters (Voltage V, Current I) and torch travel velocity v",
        "Calculate the net heat input per unit length: H_net = eta * (V * I) / v",
        "Compare CE against the 0.40% threshold to determine whether mandatory preheating (150°C-250°C) is required"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Welding Metallurgy Entity to its exact Technical Definition.",
      "matchPairs": [
        { "left": "Net Heat Input (H_net)", "right": "H_net = \u03b7 * (V * I) / v, the actual thermal energy delivered per millimeter of weld bead" },
        { "left": "Heat-Affected Zone (HAZ)", "right": "Base metal region adjacent to the fusion zone whose grain structure is altered by weld thermal cycles" },
        { "left": "Carbon Equivalent (CE <= 0.40%)", "right": "Empirical index quantifying alloy hardenability and resistance to cold hydrogen cracking" },
        { "left": "Submerged Arc Welding (\u03b7 ~ 0.95)", "right": "High-deposition automated process where the arc is completely shielded by a bed of granular flux" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The region of base metal adjacent to the weld pool whose microstructure is altered by thermal heat is the heat-___ zone.",
      "blankAnswer": "affected",
      "blankDistractors": ["shielded", "quenched", "treated"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A Submerged Arc Welding (SAW) process runs at arc voltage V = 30 Volts, current I = 400 Amperes, and travel speed v = 8.0 mm/s. The process thermal efficiency is \u03b7 = 0.90. What is the net heat input H_net delivered to the weld in kJ/mm?",
      "options": [
        { "text": "H_net = 1.35 kJ/mm (1350 J/mm, calculated from H_net = 0.90 * (30 * 400) / 8.0 = 1350 J/mm = 1.35 kJ/mm)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the arc welding heat input formula (Serope Kalpakjian *Manufacturing Engineering and Technology* Chapter 30; AWS D1.1). 1. **Apply the Net Heat Input Equation:** $$H_{\\text{net}} = \\eta_{\\text{arc}} \\cdot \\frac{V \\cdot I}{v}$$ 2. **Substitute Numerical Parameters:** - Voltage $V = 30\\text{ Volts}$. - Current $I = 400\\text{ Amperes}$. - Arc Power $P_{\\text{arc}} = V \\times I = 30 \\times 400 = 12,000\\text{ Watts (J/s)}$. - Travel speed $v = 8.0\\text{ mm/s}$. - Arc efficiency $\\eta = 0.90$. 3. **Calculation:** $$H_{\\text{net}} = 0.90 \\cdot \\frac{12,000\\text{ J/s}}{8.0\\text{ mm/s}} = 0.90 \\cdot 1500\\text{ J/mm} = \\mathbf{1350\\text{ J/mm} = 1.35\\text{ kJ/mm}}$$ 4. **Metallurgical Significance:** A moderate heat input of $1.35\\text{ kJ/mm}$ provides full joint penetration in thick steel plates while avoiding excessive grain coarsening in the HAZ!" },
        { "text": "H_net = 1.50 kJ/mm (Ignoring arc efficiency)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "H_net = 0.90 kJ/mm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "H_net = 2.70 kJ/mm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
