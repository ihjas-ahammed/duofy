# Duofy Reusable Lesson Format: Hydraulic Turbines (Pelton, Francis, & Kaplan Selection)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Fluid_Mechanics_and_Hydraulics / Hydraulic_Turbines_and_Pumps`  
**Lesson Format Type:** `hydraulic_turbines_pelton_francis_and_kaplan_selection`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through hydroelectric energy extraction, impulse vs reaction mechanics, turbine specific speed classification, and site selection criteria (Lester Allan Pelton 1880; James B. Francis 1848; Viktor Kaplan 1913; Frank M. White *Fluid Mechanics* Chapter 11; S.M. Yahya): master the fundamental difference between **Impulse Turbines (Pelton Wheel)** (converting entire pressure head into a high-speed atmospheric kinetic water jet $\mathbf{V_1 = C_v \sqrt{2gH}}$ directed onto double-cup splitter buckets, operating at atmospheric pressure; optimal speed ratio $\mathbf{\phi = \frac{u_1}{V_1} \approx 0.46 - 0.48}$) vs **Reaction Turbines (Francis & Kaplan)** (operating fully submerged in an enclosed pressurized casing, extracting energy from both pressure drop and kinetic deceleration, utilizing a **Draft Tube** to recover exit kinetic energy $\frac{V_{\text{exit}}^2}{2g}$ into pressure head); master the **Turbine Specific Speed ($\mathbf{N_{st} = \frac{N \sqrt{P}}{H^{5/4}}}$)**, and apply the **Universal Site Selection Spectrum**: (1) **Pelton Wheel:** $\mathbf{H > 300\text{ m}}$, Low Flow ($N_{st} \approx 10-50$), (2) **Francis Turbine:** $\mathbf{30\text{ m} \le H \le 300\text{ m}}$, Medium Flow ($N_{st} \approx 60-300$), and (3) **Kaplan Propeller:** $\mathbf{H < 30\text{ m}}$, High River Discharge ($N_{st} \approx 300-1000$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hydraulic Turbine Classification Matrix (Pelton vs Francis vs Kaplan) & Specific Speed ($N_{st} = \frac{N\sqrt{P}}{H^{5/4}}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing and Turbine Type Selection for a Hydroelectric Dam Project Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Hydraulic Turbine Type / Component & Working Physical Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | An Impulse Turbine Operating Under Very High Heads (> 300 m) with Double-Cup Splitter Buckets Is a ___ Wheel (Pelton) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Hydroelectric Engineering Problem: Selecting the Optimal Turbine Type for a Low-Head High-Flow River Dam Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Hydraulic Turbines (White 2016; Yahya 2010):
   - **Turbine Specific Speed Formulation:**
     $$\mathbf{N_{st} = \frac{N \sqrt{P}}{H^{5/4}} \quad \left(N \text{ in RPM}, \ P \text{ in kW or hp}, \ H \text{ in meters}\right)}$$
   - **The Hydroelectric Turbine Selection Matrix:**
     $$\begin{array}{|l|l|l|l|l|}
     \hline
     \textbf{Turbine Class} & \textbf{Working Mode} & \textbf{Net Head } H & \textbf{Specific Speed } N_{st} & \textbf{Ideal Geological Terrain} \\
     \hline
     \mathbf{\text{Pelton Wheel}} & \mathbf{\text{Impulse (Free atmospheric jet)}} & \mathbf{H > 300\text{ m}} & N_{st} \approx 10 - 50 & \text{High mountainous alpine drops} \\
     \mathbf{\text{Francis Turbine}} & \mathbf{\text{Mixed Inward Reaction}} & \mathbf{30 - 300\text{ m}} & N_{st} \approx 60 - 300 & \text{Medium-head reservoirs (Most common!)} \\
     \mathbf{\text{Kaplan / Propeller}} & \mathbf{\text{Axial Reaction (Adjustable blades)}} & \mathbf{H < 30\text{ m}} & \mathbf{N_{st} \approx 300 - 1000} & \mathbf{\text{Low-head flat river run-of-the-river dams}} \\
     \hline
     \end{array}$$
   - **The Draft Tube Invariant:** In reaction turbines (Francis/Kaplan), the **Draft Tube** converts high-speed turbine discharge kinetic energy back into static pressure: $\Delta P_{\text{rec}} = \eta_d \frac{\rho(V_{\text{in}}^2 - V_{\text{out}}^2)}{2}$, preventing massive tailrace energy wastage!
2. **Slide 2 (`ordering`):** Provide 5 steps of turbine selection: (1) measure net available head $H$ (in meters) and design volumetric discharge $Q$ (in $\text{m}^3\text{/s}$), (2) calculate total theoretical hydroelectric power $P = \rho g Q H \eta_{\text{overall}}$, (3) select generator synchronous rotational speed $N = \frac{120 f}{p}$ (RPM), (4) calculate turbine specific speed $N_{st} = \frac{N \sqrt{P}}{H^{5/4}}$, (5) match $N_{st}$ to selection chart: Pelton ($N_{st} < 50$), Francis ($50 \le N_{st} \le 300$), or Kaplan ($N_{st} > 300$)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Pelton Wheel, Francis Turbine, Kaplan Turbine, Draft Tube) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Pelton. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on turbine selection: A run-of-the-river hydroelectric power station has a low net head of $H = 15\text{ m}$ and a massive flow rate of $Q = 200\text{ m}^3\text{/s}$. The generator rotates at $N = 150\text{ RPM}$ with an overall plant efficiency of $\eta = 90\%$. What turbine type is the only thermodynamically and mechanically appropriate choice for this installation? (Power $P = \eta \rho g Q H = (0.90)(1000)(9.81)(200)(15) = 26,487\text{ kW} \approx 26.5\text{ MW}$; $H^{5/4} = 15^{1.25} \approx 29.54$; $N_{st} = \frac{N \sqrt{P}}{H^{5/4}} = \frac{150 \sqrt{26487}}{29.54} = \frac{150 \times 162.75}{29.54} \approx \frac{24412}{29.54} \approx \mathbf{826.4}$; because $N_{st} \approx 826 \gg 300$ and $H = 15\text{ m} < 30\text{ m}$, a **Kaplan axial-flow propeller turbine with adjustable pitch blades** is the only correct choice).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hydraulic_turbines_pelton_francis_and_kaplan_selection",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Hydraulic Turbine Classification \\& Specific Speed (Frank M. White)**\n• **Turbine Specific Speed Formulation:**\n$$\n\\mathbf{N_{st} = \\frac{N \\sqrt{P}}{H^{5/4}} \\quad \\left(N \\text{ in RPM}, \\ P \\text{ in kW}, \\ H \\text{ in meters}\\right)}\n$$\n• **Hydroelectric Turbine Selection Spectrum:**\n$$\n\\begin{array}{|l|l|l|l|l|}\n\\hline\n\\textbf{Turbine Geometry} & \\textbf{Working Principle} & \\textbf{Net Head } H & \\textbf{Specific Speed } N_{st} & \\textbf{Flow Direction} \\\\\n\\hline\n\\mathbf{\\text{Pelton Wheel}} & \\mathbf{\\text{Impulse (High-speed free jet)}} & \\mathbf{H > 300\\text{ m (High)}} & N_{st} \\approx 10 - 50 & \\text{Tangential jet onto buckets} \\\\\n\\mathbf{\\text{Francis Turbine}} & \\mathbf{\\text{Mixed Inward Reaction}} & \\mathbf{30 - 300\\text{ m (Medium)}} & N_{st} \\approx 60 - 300 & \\text{Radial inward to axial exit} \\\\\n\\mathbf{\\text{Kaplan / Propeller}} & \\mathbf{\\text{Axial Reaction (Adjustable pitch)}} & \\mathbf{H < 30\\text{ m (Low)}} & \\mathbf{N_{st} \\approx 300 - 1000} & \\mathbf{\\text{Pure axial propeller flow}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Draft Tube Invariant:** Reaction turbines (Francis \\& Kaplan) require a diverging **Draft Tube** below the runner to recover discharge kinetic energy ($\\mathbf{\\Delta P_{\\text{rec}} = \\eta_d \\frac{\\rho(V_1^2 - V_2^2)}{2}}$) and maintain sub-atmospheric runner suction!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to size and select the optimal hydraulic turbine for a newly planned hydroelectric power plant site.",
      "orderItems": [
        "Measure the available net hydraulic head H (meters) and design river discharge rate Q (m^3/s)",
        "Compute the total expected electrical power output: Power = eta_plant * rho * g * Q * H",
        "Select the synchronous electrical grid generator rotational speed: N = 120 * f / poles (e.g. 150 RPM)",
        "Calculate the dimensionless-equivalent Turbine Specific Speed using N_st = (N * sqrt(P)) / H^(1.25)",
        "Select the turbine from the classification spectrum: Pelton (N_st < 50), Francis (50 <= N_st <= 300), or Kaplan (N_st > 300)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Hydraulic Turbine Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Pelton Wheel", "right": "High-head impulse turbine utilizing high-velocity water jets striking double-hemispherical buckets" },
        { "left": "Francis Turbine", "right": "Medium-head mixed-flow reaction turbine with radial inflow guide vanes and axial runner discharge" },
        { "left": "Kaplan Turbine", "right": "Low-head axial-flow reaction turbine featuring adjustable propeller blades and guide vanes" },
        { "left": "Draft Tube", "right": "Diverging tailrace diffuser pipe converting exit kinetic energy into usable pressure head" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "An impulse turbine operating under very high heads (> 300 m) using atmospheric high-velocity water jets is a ___ wheel.",
      "blankAnswer": "Pelton",
      "blankDistractors": ["Francis", "Kaplan", "Tesla"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A run-of-the-river hydro plant has net head H = 15 m and discharge Q = 200 m^3/s. The generator rotates at N = 150 RPM with plant efficiency eta = 90% (P = 26.5 MW, H^1.25 = 29.54). What is the specific speed N_st, and which turbine is optimal?",
      "options": [
        { "text": "N_st = 826.4; a Kaplan axial-flow propeller turbine is the optimal selection (because N_st > 300 and net head H < 30 m)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Turbine Specific Speed formula (Frank M. White *Fluid Mechanics* Chapter 11). 1. **Calculate Power Output ($P$ in kW):** $$P = \\eta \\rho g Q H = (0.90)(1000\\text{ kg/m}^3)(9.81\\text{ m/s}^2)(200\\text{ m}^3\\text{/s})(15\\text{ m}) = 26,487\\text{ kW} = \\mathbf{26.49\\text{ MW}}$$ 2. **Calculate $H^{5/4}$:** $$H^{1.25} = 15^{1.25} \\approx \\mathbf{29.54}$$ 3. **Calculate Turbine Specific Speed ($N_{st}$):** $$N_{st} = \\frac{N \\sqrt{P}}{H^{5/4}} = \\frac{(150\\text{ RPM}) \\sqrt{26,487\\text{ kW}}}{29.54} = \\frac{150 \\times 162.748}{29.54} = \\frac{24,412.2}{29.54} \\approx \\mathbf{826.4}$$ 4. **Turbine Selection Rule:** - Pelton Wheel: $N_{st} \\approx 10 - 50$ (Requires $H > 300\\text{ m}$). - Francis Turbine: $N_{st} \\approx 60 - 300$ (Requires $H = 30-300\\text{ m}$). - **Kaplan Turbine:** $\\mathbf{N_{st} \\approx 300 - 1000}$ (Designed specifically for $\\mathbf{H < 30\\text{ m}}$ and massive river discharge!). - **Verdict:** A **Kaplan axial-flow turbine** with adjustable pitch blades is the only viable engineering choice!" },
        { "text": "N_st = 42.1; a Pelton impulse wheel is the optimal selection", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "N_st = 185.0; a Francis mixed-flow turbine is the optimal selection", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "N_st = 2.4; a positive displacement pump is the optimal selection", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
