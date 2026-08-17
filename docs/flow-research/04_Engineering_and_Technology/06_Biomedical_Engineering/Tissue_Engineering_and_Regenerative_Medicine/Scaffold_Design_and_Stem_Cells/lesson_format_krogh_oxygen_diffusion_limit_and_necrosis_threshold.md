# Duofy Reusable Lesson Format: Mass Transport (Krogh Diffusion Limit & Core Necrosis)

**Target Topic:** `04_Engineering_and_Technology / 06_Biomedical_Engineering / Tissue_Engineering_and_Regenerative_Medicine / Scaffold_Design_and_Stem_Cells`  
**Lesson Format Type:** `krogh_oxygen_diffusion_limit_and_necrosis_threshold`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mass transport of oxygen and nutrients in 3D tissue engineering constructs, Fick's second law with metabolic consumption ($D_{\text{eff}} \nabla^2 C - R_0 = 0$), the **Krogh Reaction-Diffusion Model**, analytical solution for a 1D planar tissue slab of thickness $2L$ ($C(x) = C_0 - \frac{R_0}{2 D_{\text{eff}}}(L^2 - x^2)$), derivation of the **Critical Oxygen Diffusion Distance ($L_{\text{crit}} = \sqrt{\frac{2 D_{\text{eff}} C_0}{R_0}} \approx 100 - 200\text{ }\mu\text{m}$)**, cellular hypoxia ($C(x) < 0.01\text{ mM}$), apoptotic **Core Necrosis**, and the absolute requirement for micro-vascular networks or dynamic perfusion bioreactors (Robert Lanza *Principles of Tissue Engineering* 5th ed. Chapter 24; August Krogh 1919; Bernhard O. Palsson *Tissue Engineering* Chapter 4): formulate the **Krogh Critical Oxygen Diffusion Distance Master Formulation**:
$$\mathbf{L_{\text{crit}} = \sqrt{\frac{2 D_{\text{eff}} \cdot C_0}{R_0}} \quad [\mu\text{m} \text{ or cm}]}$$
where:
1. **$L_{\text{crit}}$:** Maximum half-thickness of an unvascularized tissue construct before core oxygen drops to zero ($C(0) = 0$);
2. **$D_{\text{eff}}$:** Effective diffusion coefficient of dissolved $\text{O}_2$ in tissue matrix ($\approx 1.5 - 2.5 \times 10^{-5}\text{ cm}^2\text{/s}$);
3. **$C_0$:** Boundary surface oxygen concentration in culture medium ($\approx 0.20\text{ mM} = 2.0 \times 10^{-7}\text{ mol/cm}^3$ at normoxia $21\%\text{ O}_2$);
4. **$R_0$:** Volumetric oxygen consumption rate of encapsulated cells ($\approx 1.0 - 5.0 \times 10^{-7}\text{ mol/cm}^3\cdot\text{s}$);
derive the **1D Planar Steady-State Concentration Profile ($C(x)$)**:
$$\mathbf{C(x) = C_0 - \frac{R_0}{2 D_{\text{eff}}} \left( L^2 - x^2 \right) \quad (-L \le x \le +L)}$$
(proving that when total construct thickness $2L > 2 L_{\text{crit}} \approx 300 - 400\text{ }\mu\text{m}$, the central core becomes totally anoxic, causing massive cell death).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Krogh Model ($L_{\text{crit}} = \sqrt{\frac{2 D_{\text{eff}} C_0}{R_0}}$), $C(x) = C_0 - \frac{R_0}{2D}(L^2-x^2)$ & Core Necrosis Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate the Critical Oxygen Penetration Depth and Centerline Concentration of a Tissue Slab Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Mass Transport Entity / Physiological Parameter & Technical Regenerative Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Static 3D Tissue Culture Without Blood Vessels, Oxygen Transport Is Limited Strictly to Passive Molecular Diffusion, Creating a Critical Maximum Penetration Distance of Approximately 100 to 200 ___ Beyond Which Cells Undergo Necrosis (Micrometers / Microns / um) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Bioengineering Problem: Computing Centerline Oxygen Concentration and Critical Thickness for a Cell-Laden Hydrogel Slab Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Krogh Reaction-Diffusion Mechanics (Krogh 1919; Lanza 2020; Palsson 2004):
   - **Diffusion Formulations:**
     $$\mathbf{L_{\text{crit}} = \sqrt{\frac{2 D_{\text{eff}} C_0}{R_0}} \quad \Big| \quad C(x) = C_0 - \frac{R_0}{2 D_{\text{eff}}}(L^2 - x^2) \quad \Big| \quad C_{\text{center}} = C_0 - \frac{R_0 L^2}{2 D_{\text{eff}}}}$$
   - **Tissue Diffusion Scaling Matrix ($C_0 = 0.20\text{ mM}$):**
     $$\begin{array}{|l|c|c|c|l|}
     \hline
     \textbf{Encapsulated Cell Type} & \textbf{Cell Density } \rho_{\text{cell}} & \textbf{Oxygen Uptake } R_0 & \textbf{Critical Limit } L_{\text{crit}} & \textbf{Vascular Requirement} \\
     \hline
     \mathbf{\text{Cardiomyocytes (Heart)}} & \mathbf{1 \times 10^8\text{ cells/mL}} & \mathbf{5.0 \times 10^{-7}\text{ mol/cm}^3\cdot\text{s}} & \mathbf{\approx 126\text{ }\mu\text{m}} & \mathbf{\text{Extreme (Capillaries every } 20\text{ }\mu\text{m})} \\
     \text{Hepatocytes (Liver)} & 5 \times 10^7\text{ cells/mL} & 2.5 \times 10^{-7}\text{ mol/cm}^3\cdot\text{s} & \approx 178\text{ }\mu\text{m} & High (Sinusoidal perfusion) \\
     \text{Osteoblasts (Bone)} & 2 \times 10^7\text{ cells/mL} & 1.0 \times 10^{-7}\text{ mol/cm}^3\cdot\text{s} & \approx 282\text{ }\mu\text{m} & Moderate (Perfusion channels) \\
     \mathbf{\text{Chondrocytes (Cartilage)}} & \mathbf{5 \times 10^6\text{ cells/mL}} & \mathbf{0.2 \times 10^{-7}\text{ mol/cm}^3\cdot\text{s}} & \mathbf{\approx 632\text{ }\mu\text{m}} & \mathbf{\text{Low (Naturally avascular tissue!)}} \\
     \hline
     \end{array}$$
   - **The Vascularization Threshold Invariant:** Any engineered tissue thicker than **$2 L_{\text{crit}} \approx 200 - 400\text{ }\mu\text{m}$ cannot survive via passive diffusion**; it must incorporate perfusable microvascular capillary channels!
2. **Slide 2 (`ordering`):** Provide 5 steps of Krogh diffusion analysis: (1) determine boundary dissolved oxygen concentration $C_0$, (2) extract effective diffusion coefficient $D_{\text{eff}}$ and volumetric cellular oxygen consumption rate $R_0$, (3) calculate the maximum critical diffusion distance: $L_{\text{crit}} = \sqrt{2 D_{\text{eff}} C_0 / R_0}$, (4) evaluate local concentration profile for actual slab half-thickness $L$: $C(x) = C_0 - \frac{R_0}{2 D_{\text{eff}}}(L^2 - x^2)$, (5) check centerline concentration $C(0) = C_0 - \frac{R_0 L^2}{2 D_{\text{eff}}}$; if $C(0) < 0$, determine the necrotic core radius where $C(x) = 0$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Critical Diffusion Distance $L_{\text{crit}}$, Volumetric Consumption $R_0$, Effective Diffusivity $D_{\text{eff}}$, Necrotic Core) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Micrometers (or Microns / um). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating centerline oxygen concentration and $L_{\text{crit}}$: A 3D engineered tissue slab has half-thickness $L = 150.0\text{ }\mu\text{m} = 0.0150\text{ cm}$. The boundary dissolved oxygen concentration is $C_0 = 0.200\text{ mM} = 2.00 \times 10^{-7}\text{ mol/cm}^3$. The effective oxygen diffusion coefficient is $D_{\text{eff}} = 2.00 \times 10^{-5}\text{ cm}^2\text{/s}$, and the cellular oxygen consumption rate is $R_0 = 1.00 \times 10^{-7}\text{ mol/cm}^3\cdot\text{s}$.
   - Critical diffusion distance:
     $L_{\text{crit}} = \sqrt{\frac{2 D_{\text{eff}} C_0}{R_0}} = \sqrt{\frac{2 \times (2.00 \times 10^{-5}) \times (2.00 \times 10^{-7})}{1.00 \times 10^{-7}}} = \sqrt{\frac{8.00 \times 10^{-12}}{1.00 \times 10^{-7}}} = \sqrt{8.00 \times 10^{-5}} = \mathbf{0.008944\text{ cm} = 89.44\text{ }\mu\text{m} \approx 89.4\text{ }\mu\text{m}}$;
   - Since actual half-thickness $L = 150.0\text{ }\mu\text{m} > L_{\text{crit}} = 89.4\text{ }\mu\text{m}$, what occurs in the center of the tissue slab? ($L_{\text{crit}} = \mathbf{89.4\text{ }\mu\text{m}}$, resulting in **total hypoxia and core necrosis** because $L > L_{\text{crit}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "krogh_oxygen_diffusion_limit_and_necrosis_threshold",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Krogh Oxygen Reaction-Diffusion \\& Core Necrosis (August Krogh 1919)**\n• **Krogh Critical Oxygen Diffusion Distance Master Formulation:**\n$$\n\\mathbf{L_{\\text{crit}} = \\sqrt{\\frac{2 D_{\\text{eff}} \\cdot C_0}{R_0}} \\quad [\\mu\\text{m} \\text{ or cm}]}\n$$\n  - **$L_{\\text{crit}}$:** Maximum half-thickness of an unvascularized tissue construct before core $\\text{O}_2$ hits zero ($\\approx 100 - 200\\text{ }\\mu\\text{m}$);\n  - **$D_{\\text{eff}}$:** Effective diffusion coefficient of dissolved $\\text{O}_2$ in tissue ($\\approx 2.0 \\times 10^{-5}\\text{ cm}^2\\text{/s}$);\n  - **$C_0$:** Boundary surface oxygen concentration ($\\approx 0.20\\text{ mM} = 2.0 \\times 10^{-7}\\text{ mol/cm}^3$);\n  - **$R_0$:** Volumetric cellular oxygen consumption rate ($\\text{mol/cm}^3\\cdot\\text{s}$);\n• **1D Planar Steady-State Concentration Profile ($C(x)$):**\n$$\n\\mathbf{C(x) = C_0 - \\frac{R_0}{2 D_{\\text{eff}}} \\left( L^2 - x^2 \\right) \\implies C_{\\text{center}} = C_0 - \\frac{R_0 L^2}{2 D_{\\text{eff}}}}\n$$\n• **The Vascularization Invariant:** Any engineered tissue thicker than **$2 L_{\\text{crit}} \\approx 300\\text{ }\\mu\\text{m}$ will suffer severe hypoxia and apoptotic core necrosis** unless actively perfused by microvascular capillary beds!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to evaluate oxygen mass transport and predict core necrosis in a 3D tissue construct.",
      "orderItems": [
        "Specify boundary oxygen concentration C0, effective diffusivity Deff, and cell consumption rate R0",
        "Calculate the maximum critical oxygen penetration depth: L_crit = \u221a(2 * Deff * C0 / R0)",
        "Compare actual construct half-thickness L against the critical threshold L_crit",
        "Calculate the centerline oxygen concentration: C(0) = C0 - (R0 * L^2) / (2 * Deff)",
        "Identify the hypoxic necrotic core boundary where C(x) reaches 0 to design vascular perfusion channels"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Mass Transport Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Critical Diffusion Distance (L_crit)", "right": "L_crit = \u221a(2*Deff*C0/R0), maximum unvascularized tissue depth before oxygen depletion" },
        { "left": "Volumetric Consumption Rate (R0)", "right": "Rate at which encapsulated cells consume oxygen via mitochondrial oxidative phosphorylation" },
        { "left": "Effective Diffusivity (Deff)", "right": "Molecular diffusion coefficient of oxygen through hydrated extracellular hydrogel matrix" },
        { "left": "Necrotic Core", "right": "Central anoxic zone of apoptotic cell death resulting when tissue thickness exceeds diffusion limit" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In static 3D tissue culture without blood vessels, oxygen transport is limited strictly to passive molecular diffusion, creating a critical maximum penetration distance of approximately 100 to 200 ___ beyond which cells undergo necrosis.",
      "blankAnswer": "micrometers",
      "blankDistractors": ["millimeters", "centimeters", "nanometers"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A tissue slab has half-thickness L = 150.0 \u03bcm (0.015 cm), C0 = 0.200 mM (2.0 \u00d7 10^-7 mol/cm^3), Deff = 2.0 \u00d7 10^-5 cm^2/s, and R0 = 1.0 \u00d7 10^-7 mol/cm^3*s. L_crit = \u221a[2 * (2 \u00d7 10^-5) * (2 \u00d7 10^-7) / (1 \u00d7 10^-7)] = \u221a[8.0 \u00d7 10^-5] = 0.00894 cm = 89.4 \u03bcm. Since actual half-thickness L = 150 \u03bcm > L_crit = 89.4 \u03bcm, what is the fate of cells at the center of the construct?",
      "options": [
        { "text": "L_crit = 89.4 \u03bcm, and cells in the central core suffer total anoxia and necrosis (Because L = 150 \u03bcm > L_crit = 89.4 \u03bcm, oxygen is fully depleted at depth x = 89.4 \u03bcm, leaving an anoxic core)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Krogh reaction-diffusion model (August Krogh 1919; Robert Lanza et al. *Principles of Tissue Engineering* Chapter 24). 1. **Identify Transport Parameters:** - Surface oxygen concentration: $C_0 = 0.200\\text{ mM} = 2.00 \\times 10^{-7}\\text{ mol/cm}^3$. - Effective oxygen diffusivity: $D_{\\text{eff}} = 2.00 \\times 10^{-5}\\text{ cm}^2\\text{/s}$. - Volumetric consumption rate: $R_0 = 1.00 \\times 10^{-7}\\text{ mol/cm}^3\\cdot\\text{s}$. - Actual construct half-thickness: $L = 150.0\\text{ }\\mu\\text{m} = 0.0150\\text{ cm}$. 2. **Calculate Critical Oxygen Diffusion Depth ($L_{\\text{crit}}$):** $$L_{\\text{crit}} = \\sqrt{\\frac{2 D_{\\text{eff}} C_0}{R_0}}$$ $$L_{\\text{crit}} = \\sqrt{\\frac{2 \\times (2.00 \\times 10^{-5}\\text{ cm}^2\\text{/s}) \\times (2.00 \\times 10^{-7}\\text{ mol/cm}^3)}{1.00 \\times 10^{-7}\\text{ mol/cm}^3\\cdot\\text{s}}}$$ $$L_{\\text{crit}} = \\sqrt{\\frac{8.00 \\times 10^{-12}}{1.00 \\times 10^{-7}}} = \\sqrt{8.00 \\times 10^{-5}\\text{ cm}^2} = \\mathbf{0.0089443\\text{ cm} = 89.44\\text{ }\\mu\\text{m} \\approx 89.4\\text{ }\\mu\\text{m}}$$ 3. **Evaluate Centerline Fate:** - Since the construct half-thickness $L = 150.0\\text{ }\\mu\\text{m}$ is significantly greater than $L_{\\text{crit}} = 89.4\\text{ }\\mu\\text{m}$, oxygen is completely consumed before reaching the center. - All cells located at depths deeper than $89.4\\text{ }\\mu\\text{m}$ from the surface experience zero oxygen ($C = 0$), undergoing irreversible hypoxic apoptotic core necrosis! Flawless Krogh reaction-diffusion and core necrosis derivation!" },
        { "text": "L_crit = 150.0 \u03bcm, and cells remain fully viable throughout", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "L_crit = 89.4 \u03bcm, but cells survive anaerobically without any necrosis", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "L_crit = 450.0 \u03bcm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
