# Duofy Reusable Lesson Format: Machining Energy (MRR, Specific Cutting Energy, & Power)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Manufacturing_and_Industrial_Engineering / CNC_Machining_and_Tool_Life`  
**Lesson Format Type:** `material_removal_rate_specific_cutting_energy_and_power`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through volumetric material removal rate (MRR), specific cutting energy ($u_c$), and electric spindle motor power sizing across turning, milling, and drilling operations in manufacturing engineering (Serope Kalpakjian & Steven R. Schmid *Manufacturing Engineering and Technology* Chapter 21-24; Mikell P. Groover *Fundamentals of Modern Manufacturing* Chapter 21-23): master **Volumetric Material Removal Rate (MRR)**:
$$\mathbf{\text{Turning: } \text{MRR} = v \cdot f \cdot d \ [\text{mm}^3\text{/s}] \quad \Big| \quad \text{Milling: } \text{MRR} = w \cdot d \cdot v_f \quad \Big| \quad \text{Drilling: } \text{MRR} = \frac{\pi D^2}{4} f N}$$
where $v$ is cutting speed, $f$ is feed, $d$ is depth of cut, $w$ is milling width, and $v_f = f_z \cdot Z \cdot N$ is table feed rate; master the **Specific Cutting Energy ($\mathbf{u_c}$)** (representing the energy required to shear away a unit volume of metal):
$$\mathbf{u_c = \frac{P_{\text{cutting}}}{\text{MRR}} = \frac{F_c \cdot v}{v \cdot f \cdot d} = \frac{F_c}{f \cdot d} \ [\text{J/mm}^3 = \text{N/mm}^2 = \text{MPa}]}$$
and size the **Machine Spindle Motor Power**:
$$\mathbf{P_{\text{cutting}} = u_c \cdot \text{MRR} = F_c \cdot v \implies \mathbf{P_{\text{motor}} = \frac{P_{\text{cutting}}}{\eta_{\text{machine}}}}}$$
where $\eta_{\text{machine}} \approx 0.80 - 0.90$ accounts for gearbox and bearing mechanical drive losses.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Material Removal Rate ($\text{MRR} = v f d$), Specific Energy ($u_c = \frac{F_c}{f d}$) & Motor Power ($P_m = \frac{u_c \text{MRR}}{\eta}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of MRR, Cutting Force, and Electric Motor Horsepower Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Machining Power Entity / Specific Energy Property & Technical Physical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Energy Required to Remove a Unit Volume of Material in Machining Is the ___ Cutting Energy (Specific) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Machine Tool Sizing Problem: Calculating the Electric Spindle Motor Power Required for Heavy CNC Turning Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State MRR, Specific Energy & Power (Kalpakjian 2020; Groover 2020):
   - **MRR & Power Formulations:**
     $$\mathbf{\text{MRR} = v \cdot f \cdot d \quad \Big| \quad u_c = \frac{P_c}{\text{MRR}} = \frac{F_c}{f \cdot d} \quad \Big| \quad P_{\text{cutting}} = F_c \cdot v = u_c \cdot \text{MRR} \quad \Big| \quad P_{\text{motor}} = \frac{P_c}{\eta_m}}$$
   - **Specific Cutting Energy ($u_c$) Table by Material:**
     $$\begin{array}{|l|c|l|}
     \hline
     \textbf{Workpiece Alloy} & \textbf{Specific Energy } u_c \ (\text{W}\cdot\text{s/mm}^3 \text{ or J/mm}^3) & \textbf{Machinability Class} \\
     \hline
     \mathbf{\text{Aluminum Alloys}} & \mathbf{0.4 - 1.1\text{ J/mm}^3} & \text{Free-machining, low power} \\
     \mathbf{\text{Cast Irons}} & 1.1 - 2.8\text{ J/mm}^3 & \text{Brittle discontinuous chips} \\
     \mathbf{\text{Carbon \\& Alloy Steels}} & \mathbf{2.0 - 4.5\text{ J/mm}^3} & \text{Standard industrial structural metals} \\
     \mathbf{\text{Titanium \\& Nickel Superalloys}} & \mathbf{3.0 - 6.0\text{ J/mm}^3} & \text{High strength, extreme heat generation} \\
     \hline
     \end{array}$$
   - **The Size Effect Invariant:** At very fine feeds ($f < 0.05\text{ mm}$), $u_c$ **skyrockets** because the tool edge plows and rubs rather than shearing!
2. **Slide 2 (`ordering`):** Provide 5 steps of machine tool power sizing: (1) determine workpiece material and look up specific cutting energy $u_c$, (2) select cutting speed $v$ (m/s), feed $f$ (mm/rev), and depth of cut $d$ (mm), (3) calculate material removal rate $\text{MRR} = v \cdot f \cdot d$ in $\text{mm}^3\text{/s}$, (4) compute net cutting power $P_c = u_c \cdot \text{MRR}$, (5) divide by machine drive mechanical efficiency $\eta_m \approx 0.85$ to specify spindle motor power $P_m = P_c / \eta_m$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Material Removal Rate MRR, Specific Cutting Energy $u_c$, Spindle Motor Power $P_m$, Size Effect) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Specific. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on sizing spindle motor power: A CNC lathe performs a rough turning pass on carbon steel ($u_c = 3.0\text{ J/mm}^3 = 3.0\text{ N/mm}^2$) at cutting speed $v = 180\text{ m/min} = 3.0\text{ m/s} = 3000\text{ mm/s}$, feed $f = 0.25\text{ mm/rev}$, and depth of cut $d = 2.0\text{ mm}$. The lathe has an electrical/mechanical transmission efficiency $\eta_m = 0.80$. What is the minimum spindle motor electrical power $P_{\text{motor}}$ required in kilowatts ($\text{kW}$)? ($\text{MRR} = v \cdot f \cdot d = (3000\text{ mm/s})(0.25\text{ mm})(2.0\text{ mm}) = \mathbf{1500\text{ mm}^3\text{/s}}$; $P_c = u_c \cdot \text{MRR} = (3.0\text{ J/mm}^3)(1500\text{ mm}^3\text{/s}) = 4500\text{ W} = \mathbf{4.5\text{ kW}}$; $P_{\text{motor}} = \frac{P_c}{\eta_m} = \frac{4.5\text{ kW}}{0.80} = \mathbf{5.625\text{ kW}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "material_removal_rate_specific_cutting_energy_and_power",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Machining Power \\& Specific Cutting Energy (Kalpakjian \\& Groover)**\n• **Material Removal Rate (MRR) \\& Cutting Power Formulations:**\n$$\n\\mathbf{\\text{MRR} = v \\cdot f \\cdot d \\ [\\text{mm}^3\\text{/s}] \\quad \\Big| \\quad \\mathbf{u_c = \\frac{P_c}{\\text{MRR}} = \\frac{F_c}{f \\cdot d} \\ [\\text{J/mm}^3 = \\text{N/mm}^2]}}\n$$\n• **Spindle Motor Electric Power Sizing:**\n$$\n\\mathbf{P_{\\text{cutting}} = u_c \\cdot \\text{MRR} = F_c \\cdot v \\implies \\mathbf{P_{\\text{motor}} = \\frac{P_{\\text{cutting}}}{\\eta_{\\text{machine}}}}}\n$$\n• **Workpiece Specific Energy ($u_c$) Reference:**\n  - **Aluminum Alloys:** $\\mathbf{u_c \\approx 0.5 - 1.1\\text{ J/mm}^3}$;\n  - **Plain Carbon Steels:** $\\mathbf{u_c \\approx 2.0 - 4.5\\text{ J/mm}^3}$;\n  - **Titanium \\& Nickel Superalloys:** $\\mathbf{u_c \\approx 3.5 - 6.0\\text{ J/mm}^3}$.\n• **The Size Effect Invariant:** At very low feeds ($f < 0.05\\text{ mm}$), $u_c$ **drastically increases** because material is plowed and rubbed rather than cleanly sheared!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the spindle motor horsepower needed for a CNC milling or turning operation.",
      "orderItems": [
        "Identify the workpiece alloy and determine its characteristic specific cutting energy u_c",
        "Select process parameters: cutting velocity v (converted to mm/s), feed f (mm), and depth of cut d (mm)",
        "Calculate the volumetric Material Removal Rate: MRR = v * f * d in mm^3/s",
        "Compute the net cutting power demanded at the tool tip: P_cutting = u_c * MRR in Watts",
        "Divide by the machine drive mechanical transmission efficiency eta_m to size the electric spindle motor: P_motor = P_cutting / eta_m"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Machining Power Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Material Removal Rate (MRR)", "right": "MRR = v * f * d, volume of solid metal sheared away into chips per unit time" },
        { "left": "Specific Cutting Energy (uc)", "right": "uc = Fc / (f * d), the energy in Joules required to remove exactly 1 mm^3 of material" },
        { "left": "Spindle Motor Power (P_motor)", "right": "P_motor = (uc * MRR) / \u03b7_machine, total electrical input power sizing for the machine tool" },
        { "left": "The Size Effect", "right": "Nonlinear increase in specific cutting energy at microscopic feed depths due to plowing friction" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The mechanical energy required to remove a unit volume of metal during cutting is the ___ cutting energy.",
      "blankAnswer": "specific",
      "blankDistractors": ["thermal", "kinetic", "elastic"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A CNC lathe turns a carbon steel shaft (u_c = 3.0 J/mm^3) at cutting speed v = 180 m/min (3000 mm/s), feed f = 0.25 mm/rev, and depth of cut d = 2.0 mm. The lathe mechanical drive efficiency is \u03b7_m = 0.80. What is the required electric spindle motor power P_motor in kilowatts (kW)?",
      "options": [
        { "text": "P_motor = 5.625 kW (MRR = 3000 * 0.25 * 2.0 = 1500 mm^3/s, P_cutting = 3.0 * 1500 = 4.5 kW, and P_motor = 4.5 / 0.80 = 5.625 kW)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using material removal rate and specific cutting energy principles (Serope Kalpakjian *Manufacturing Engineering and Technology* Chapter 21). 1. **Calculate Material Removal Rate ($\\text{MRR}$):** - Speed $v = 180\\text{ m/min} = \\frac{180,000\\text{ mm}}{60\\text{ s}} = 3000\\text{ mm/s}$. - Feed $f = 0.25\\text{ mm}$. - Depth of cut $d = 2.0\\text{ mm}$. - $$\\text{MRR} = v \\cdot f \\cdot d = (3000\\text{ mm/s})(0.25\\text{ mm})(2.0\\text{ mm}) = \\mathbf{1500\\text{ mm}^3\\text{/s}}$$ 2. **Calculate Net Cutting Power ($P_{\\text{cutting}}$):** $$P_{\\text{cutting}} = u_c \\cdot \\text{MRR} = (3.0\\text{ J/mm}^3)(1500\\text{ mm}^3\\text{/s}) = 4500\\text{ J/s} = 4500\\text{ W} = \\mathbf{4.5\\text{ kW}}$$ 3. **Calculate Required Spindle Motor Power ($P_{\\text{motor}}$):** $$P_{\\text{motor}} = \\frac{P_{\\text{cutting}}}{\\eta_m} = \\frac{4.5\\text{ kW}}{0.80} = \\mathbf{5.625\\text{ kW}}$$ 4. **Industrial Recommendation:** An manufacturing engineer would select a standard commercial **$7.5\\text{ kW}$ ($10\\text{ HP}$)** motor to handle startup inertia and peak transient chip loads!" },
        { "text": "P_motor = 4.500 kW (Net cutting power, ignoring efficiency)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "P_motor = 3.600 kW", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "P_motor = 11.25 kW", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
