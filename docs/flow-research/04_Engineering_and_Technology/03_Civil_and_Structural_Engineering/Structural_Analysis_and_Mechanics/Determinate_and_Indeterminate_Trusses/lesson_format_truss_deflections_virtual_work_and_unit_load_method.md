# Duofy Reusable Lesson Format: Truss Deflections (Virtual Work & Unit Load Method)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Structural_Analysis_and_Mechanics / Determinate_and_Indeterminate_Trusses`  
**Lesson Format Type:** `truss_deflections_virtual_work_and_unit_load_method`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the Method of Virtual Work (Unit Load Method) for calculating linear deflections and joint displacements in 2D planar trusses subjected to external mechanical loads, temperature changes ($\Delta T$), and fabrication tolerance errors ($\Delta L_{\text{fab}}$) (Russell C. Hibbeler *Structural Analysis* 10th ed. Chapter 9; Aslam Kassimali *Structural Analysis* 6th ed. Chapter 8): formulate the **Master Virtual Work Deflection Equation**:
$$\mathbf{1 \cdot \Delta = \sum_{k=1}^M \frac{n_k \cdot N_k \cdot L_k}{A_k E_k} + \sum_{k=1}^M n_k \cdot \left( \alpha \cdot \Delta T_k \cdot L_k \right) + \sum_{k=1}^M n_k \cdot \Delta L_{\text{fab},k}}$$
where:
1. **$1$:** Dimensionless virtual unit load ($1\text{ kN}$ or $1\text{ lb}$) applied at the target joint in the desired direction of displacement;
2. **$N_k$:** Real internal axial force in member $k$ caused by the actual external service loads;
3. **$n_k$:** Virtual internal axial force in member $k$ resulting solely from the applied virtual unit load;
4. **$L_k, A_k, E_k$:** Length, cross-sectional area, and Young's modulus of elasticity of member $k$;
5. **$\alpha$:** Linear coefficient of thermal expansion ($1/^\circ\text{C}$);
6. **$\Delta T_k$:** Temperature change ($+^\circ\text{C}$ heating / elongation, $-^\circ\text{C}$ cooling / contraction);
7. **$\Delta L_{\text{fab},k}$:** Fabrication error ($+ \text{m}$ manufactured too long, $- \text{m}$ manufactured too short);
(proving why virtual work operates on energy conservation principles, converting complex global kinematic truss deformations into an efficient, tabular scalar summation).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Virtual Work Master Formula ($1\cdot\Delta = \sum \frac{nNL}{AE} + \sum n\alpha\Delta T L + \sum n\Delta L_{\text{fab}}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate the Vertical Center Deflection of a Bridge Truss Using Virtual Work Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Virtual Work Term / Variable & Technical Physical Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Method of Virtual Work, the Virtual System Is Created by Applying a Dummy ___ Load at the Target Joint in the Direction of Desired Deflection (Unit / 1) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Bridge Engineering Problem: Calculating Vertical Deflection at Center Joint C for a Steel Truss Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Virtual Work for Trusses (Hibbeler 2018; Kassimali 2020):
   - **Virtual Work Deflection Formulation:**
     $$\mathbf{1 \cdot \Delta = \sum_{k=1}^M \frac{n_k N_k L_k}{A_k E_k} + \sum_{k=1}^M n_k \alpha \Delta T_k L_k + \sum_{k=1}^M n_k \Delta L_{\text{fab},k}}$$
   - **Real vs Virtual System Comparison Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{System} & \textbf{Applied Loading} & \textbf{Internal Forces} & \textbf{Physical Nature} \\
     \hline
     \mathbf{\text{Real System}} & \text{Actual service live/dead loads } P & \mathbf{N_k \ (\text{Real Axial Forces in kN})} & \text{Produces physical bar deformations } \Delta L = \frac{N L}{A E} \\
     \mathbf{\text{Virtual System}} & \mathbf{\text{Dummy Unit Load } (1.0\text{ kN})} & \mathbf{n_k \ (\text{Virtual Axial Forces})} & \text{Acts as mathematical probe extracting target deflection } \Delta \\
     \hline
     \end{array}$$
   - **The Sign Matching Invariant:** If member $k$ carries Tension in both Real ($N_k > 0$) and Virtual ($n_k > 0$) systems, the product $n_k N_k > 0$ **adds to the deflection**; if signs oppose, the product **opposes deflection**; a positive final $\Delta > 0$ confirms displacement in the direction of the unit load!
2. **Slide 2 (`ordering`):** Provide 5 steps of virtual work deflection calculation: (1) analyze the real truss under service loads to find real axial forces $N_k$ for all bars, (2) remove all real external loads and apply a single $1.0\text{ kN}$ dummy unit load at the joint and direction of interest, (3) analyze the virtual truss to determine virtual axial forces $n_k$ in all bars, (4) construct a summation table computing $n_k \cdot N_k \cdot L_k / (A_k E_k)$ and thermal/fabrication terms for each member, (5) sum all member contributions to obtain net joint displacement $\Delta = \sum \frac{n N L}{A E}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Real Force $N_k$, Virtual Force $n_k$, Thermal Elongation $n \alpha \Delta T L$, Fabrication Error $n \Delta L_{\text{fab}}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Unit (or 1). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating truss center deflection: A 3-member symmetric truss with pin supports has bars with $A = 1000\text{ mm}^2 = 1.0 \times 10^{-3}\text{ m}^2$ and $E = 200\text{ GPa} = 200 \times 10^6\text{ kN/m}^2$ ($A E = 200,000\text{ kN}$). The summation of real and virtual forces under a $100\text{ kN}$ downward point load yields $\sum n_k N_k L_k = 1200\text{ kN}^2\cdot\text{m}$. In addition, one bottom bar of length $L = 4.0\text{ m}$ is heated by $\Delta T = +30^\circ\text{C}$ ($\alpha = 1.2 \times 10^{-5}\ /^\circ\text{C}$), where its virtual force is $n = +0.50$. What is the total vertical downward deflection $\Delta_C$ at the center joint? (Mechanical deflection: $\Delta_{\text{mech}} = \frac{\sum n N L}{A E} = \frac{1200\text{ kN}^2\cdot\text{m}}{200,000\text{ kN}} = 0.0060\text{ m} = \mathbf{6.00\text{ mm}}$; Thermal deflection: $\Delta_{\text{temp}} = n \alpha \Delta T L = (0.50) \times (1.2 \times 10^{-5}) \times (30^\circ\text{C}) \times (4.0\text{ m}) = 0.50 \times 0.00144\text{ m} = 0.00072\text{ m} = \mathbf{0.72\text{ mm}}$; Total deflection: $\Delta_{\text{total}} = 6.00\text{ mm} + 0.72\text{ mm} = \mathbf{6.72\text{ mm}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "truss_deflections_virtual_work_and_unit_load_method",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Method of Virtual Work for Trusses (Russell Hibbeler)**\n• **Master Virtual Work Deflection Formulation:**\n$$\n\\mathbf{1 \\cdot \\Delta = \\sum_{k=1}^M \\frac{n_k \\cdot N_k \\cdot L_k}{A_k E_k} + \\sum_{k=1}^M n_k \\cdot \\alpha \\cdot \\Delta T_k \\cdot L_k + \\sum_{k=1}^M n_k \\cdot \\Delta L_{\\text{fab},k}}\n$$\n  - **$N_k$:** Real axial internal force in bar $k$ caused by actual external structural loading (kN);\n  - **$n_k$:** Virtual axial force in bar $k$ produced by a **dummy $1.0\\text{ kN}$ unit load** applied at the deflection joint;\n  - **$\\alpha \\Delta T L$:** Axial elongation/shortening caused by environmental temperature changes;\n  - **$\\Delta L_{\\text{fab}}$:** Physical length deviation caused by fabrication manufacturing error;\n• **The Sign Matching Invariant:** If a bar is in tension in both Real ($N > 0$) and Virtual ($n > 0$) systems, the product $n \\cdot N > 0$ **increases downward displacement**; if $N$ and $n$ have opposing signs, the product opposes displacement!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to compute the joint deflection of a structural truss using the Method of Virtual Work.",
      "orderItems": [
        "Analyze the real truss under actual service loads to compute real axial forces (N) for all members",
        "Remove all external service loads and apply a single dummy 1.0 unit load at the target joint in the desired displacement direction",
        "Analyze the virtual truss to determine virtual axial forces (n) in all members resulting from the unit load",
        "Construct a computation table multiplying (n * N * L) / (A * E) and adding temperature/fabrication terms for each member",
        "Sum all individual member contributions: \u0394 = \u2211 (n*N*L / AE) to obtain the total net joint deflection"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Virtual Work Term to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Real Internal Force (N)", "right": "Actual axial tension or compression force generated by physical service live and dead loads" },
        { "left": "Virtual Internal Force (n)", "right": "Internal force induced solely by placing a 1.0 dummy unit load at the displacement point of interest" },
        { "left": "Thermal Expansion Term", "right": "n * \u03b1 * \u0394T * L, joint displacement contribution caused by thermal temperature expansion or contraction" },
        { "left": "Fabrication Tolerance Term", "right": "n * \u0394L_fab, joint displacement resulting from members manufactured too long or too short" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Method of Virtual Work, the virtual system is created by applying a dummy ___ load at the target joint in the direction of desired deflection.",
      "blankAnswer": "unit",
      "blankDistractors": ["moment", "shear", "maximum"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A steel truss has bars with AE = 200,000 kN. Under service loading, \u2211 (n*N*L) = 1200 kN^2\u00b7m for the center joint. Additionally, one bottom tie bar (L = 4.0 m, n = +0.50) is heated by \u0394T = +30\u00b0C (\u03b1 = 1.2 x 10^-5 /\u00b0C). What is the total vertical deflection \u0394_C at the center joint?",
      "options": [
        { "text": "\u0394_C = 6.72 mm (\u0394_mech = 1200 / 200000 = 0.0060 m = 6.00 mm; \u0394_temp = 0.50 * (1.2*10^-5) * 30 * 4.0 = 0.00072 m = 0.72 mm; \u0394_total = 6.00 mm + 0.72 mm = 6.72 mm)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Method of Virtual Work for trusses (Russell C. Hibbeler *Structural Analysis* Chapter 9). 1. **Calculate Mechanical Elastic Deflection ($\\Delta_{\\text{mech}}$):** $$\\Delta_{\\text{mech}} = \\sum_{k=1}^M \\frac{n_k \\cdot N_k \\cdot L_k}{A_k E_k} = \\frac{1200\\text{ kN}^2\\cdot\\text{m}}{200,000\\text{ kN}} = 0.0060\\text{ m} = \\mathbf{6.00\\text{ mm}}$$ 2. **Calculate Thermal Expansion Deflection Contribution ($\\Delta_{\\text{temp}}$):** - Formula for thermal deformation: $$\\Delta L_{\\text{temp}} = \\alpha \\cdot \\Delta T \\cdot L = (1.2 \\times 10^{-5}\\ /^\circ\\text{C}) \\times (+30^\circ\\text{C}) \\times (4.0\\text{ m}) = 0.00144\\text{ m} = 1.44\\text{ mm}$$ - Multiply by virtual force $n = +0.50$: $$\\Delta_{\\text{temp}} = n \\cdot (\\alpha \\cdot \\Delta T \\cdot L) = 0.50 \\times 0.00144\\text{ m} = 0.00072\\text{ m} = \\mathbf{0.72\\text{ mm}}$$ 3. **Sum Mechanical and Thermal Deflections:** $$\\Delta_{\\text{total}} = \\Delta_{\\text{mech}} + \\Delta_{\\text{temp}} = 6.00\\text{ mm} + 0.72\\text{ mm} = \\mathbf{6.72\\text{ mm}}$$ 4. **Physical Insight:** Virtual work allows mechanical loads and environmental temperature fluctuations to be seamlessly combined via simple superposition! Flawless truss deflection calculation!" },
        { "text": "\u0394_C = 6.00 mm (Ignored thermal expansion)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u0394_C = 5.28 mm (Subtracted thermal expansion)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u0394_C = 12.0 mm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
