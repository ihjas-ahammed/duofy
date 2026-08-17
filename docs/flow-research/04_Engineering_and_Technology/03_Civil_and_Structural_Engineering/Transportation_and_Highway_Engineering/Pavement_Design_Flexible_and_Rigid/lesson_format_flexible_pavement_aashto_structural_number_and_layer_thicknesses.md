# Duofy Reusable Lesson Format: Flexible Pavement (AASHTO Structural Number & Layers)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Transportation_and_Highway_Engineering / Pavement_Design_Flexible_and_Rigid`  
**Lesson Format Type:** `flexible_pavement_aashto_structural_number_and_layer_thicknesses`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the AASHTO 1993 empirical design methodology for flexible asphalt pavements, serviceability loss ($\Delta\text{PSI} = p_0 - p_t = 4.2 - 2.5 = 1.7$), subgrade resilient modulus ($M_R \approx 1500 \times \text{CBR}$ in psi), the composite index **Structural Number ($SN$)**, layer structural coefficients ($a_1, a_2, a_3$), drainage coefficients ($m_2, m_3$), and layer-by-layer thickness optimization ($D_1, D_2, D_3$) to protect underlying strata (AASHTO *Guide for Design of Pavement Structures* 1993; Yang H. Huang *Pavement Analysis and Design* Chapter 11): formulate the **AASHTO Structural Number (SN) Master Equation**:
$$\mathbf{SN = a_1 D_1 + a_2 D_2 m_2 + a_3 D_3 m_3}$$
where:
1. **$a_1 \approx 0.44$:** Structural coefficient for Hot-Mix Asphalt (HMA) surface course;
2. **$a_2 \approx 0.14$:** Structural coefficient for crushed stone aggregate base course;
3. **$a_3 \approx 0.11$:** Structural coefficient for granular subbase course;
4. **$m_2, m_3 \approx 1.00$:** Layer drainage modification coefficients;
5. **$D_1, D_2, D_3$:** Layer thicknesses in inches (rounded up to nearest $0.5\text{ in}$);
derive the **Layer-by-Layer Thickness Design Formulations**:
$$\mathbf{D_1^* \ge \frac{SN_1}{a_1} \quad \Big| \quad \mathbf{D_2^* \ge \frac{SN_2 - a_1 D_1^*}{a_2 m_2}} \quad \Big| \quad \mathbf{D_3^* \ge \frac{SN_3 - \left( a_1 D_1^* + a_2 D_2^* m_2 \right)}{a_3 m_3}}}$$
(proving that each layer must provide sufficient stiffness to reduce vertical compressive stresses down to the tolerable resilient modulus of the underlying material).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | AASHTO SN Equation ($SN = a_1 D_1 + a_2 D_2 m_2 + a_3 D_3 m_3$), Layer Sizing ($D_i$) & $M_R = 1500\text{CBR}$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Required Asphalt Surface, Base, and Subbase Thicknesses Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Pavement Layer Entity / AASHTO Design Parameter & Technical Structural Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In AASHTO 1993 Flexible Pavement Design, the Typical Structural Coefficient $a_1$ for Dense-Graded Hot-Mix Asphalt (HMA) Equals Approximately ___ (0.44 / Zero Point Four Four) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Pavement Design Problem: Sizing HMA Surface D_1 and Crushed Stone Base D_2 for a Given SN Budget Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State AASHTO Flexible Pavement Design (AASHTO 1993; Huang 2004):
   - **Structural Number Formulations:**
     $$\mathbf{SN = a_1 D_1 + a_2 D_2 m_2 + a_3 D_3 m_3 \quad \Big| \quad M_R \approx 1500 \times \text{CBR } [\text{psi}] \quad \Big| \quad D_1^* \ge \frac{SN_1}{a_1} \quad \Big| \quad D_2^* \ge \frac{SN_2 - a_1 D_1^*}{a_2 m_2}}$$
   - **AASHTO Typical Layer Material Coefficients Matrix:**
     $$\begin{array}{|l|l|c|c|l|}
     \hline
     \textbf{Pavement Course} & \textbf{Material Type} & \textbf{Modulus } E & \textbf{Coeff } a_i & \textbf{Drainage } m_i \\
     \hline
     \mathbf{\text{Surface Course } (D_1)} & \mathbf{\text{Hot-Mix Asphalt (HMA)}} & 400,000\text{ psi} & \mathbf{a_1 = 0.44} & - \\
     \mathbf{\text{Base Course } (D_2)} & \mathbf{\text{Crushed Aggregate Stone}} & 30,000\text{ psi} & \mathbf{a_2 = 0.14} & \mathbf{m_2 = 1.00} \\
     \mathbf{\text{Subbase Course } (D_3)} & \text{Granular Sand/Gravel} & 15,000\text{ psi} & a_3 = 0.11 & m_3 = 1.00 \\
     \text{Roadbed Subgrade} & Natural Soil & M_R = 1500 \times \text{CBR} & - & - \\
     \hline
     \end{array}$$
   - **The Top-Down Layer Budget Invariant:** Layer thicknesses must be rounded UP to the nearest **half-inch ($0.5\text{ in}$)**; actual provided structural number $SN^* = a_1 D_1^* + a_2 D_2^* m_2 + a_3 D_3^* m_3$ must strictly exceed required $SN$!
2. **Slide 2 (`ordering`):** Provide 5 steps of flexible pavement design: (1) determine design traffic ESALs and subgrade resilient modulus $M_R \approx 1500 \times \text{CBR}$, (2) calculate overall required $SN_3$ over subgrade, $SN_2$ over subbase, and $SN_1$ over base course, (3) calculate minimum asphalt surface thickness: $D_1 = SN_1 / a_1$ and round up to $D_1^*$, (4) compute required crushed base thickness: $D_2 = (SN_2 - a_1 D_1^*) / (a_2 m_2)$ and round up to $D_2^*$, (5) compute required subbase thickness: $D_3 = [SN_3 - (a_1 D_1^* + a_2 D_2^* m_2)] / (a_3 m_3)$ and verify total $SN^* \ge SN_3$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Structural Number $SN$, Asphalt Coefficient $a_1 = 0.44$, Base Coefficient $a_2 = 0.14$, Subgrade Modulus $M_R = 1500\text{CBR}$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 0.44 (or Zero Point Four Four). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on sizing layer thicknesses: A two-layer flexible pavement on crushed stone base ($a_2 = 0.14, m_2 = 1.0$) with asphalt surface ($a_1 = 0.44$) requires $SN_1 = 1.76$ over the base and total $SN_2 = 3.50$ over the subgrade.
   - Sizing surface course: $D_1 = \frac{SN_1}{a_1} = \frac{1.76}{0.44} = \mathbf{4.00\text{ in}}$ (Choose $D_1^* = 4.0\text{ in}$);
   - Provided by surface: $a_1 D_1^* = 0.44 \times 4.0 = \mathbf{1.76}$;
   - Remaining $SN$ required for base: $SN_2 - 1.76 = 3.50 - 1.76 = \mathbf{1.74}$;
   - Sizing base course: $D_2 = \frac{1.74}{a_2 m_2} = \frac{1.74}{0.14 \times 1.0} = \mathbf{12.43\text{ in}} \implies \text{Round up to } \mathbf{12.5\text{ in}}$;
   - Total provided structural number: $SN^* = 0.44(4.0) + 0.14(12.5)(1.0) = 1.76 + 1.75 = \mathbf{3.51} \ge 3.50$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "flexible_pavement_aashto_structural_number_and_layer_thicknesses",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: AASHTO Flexible Pavement Design (AASHTO 1993)**\n• **Structural Number (SN) Master Formulation:**\n$$\n\\mathbf{SN = a_1 D_1 + a_2 D_2 m_2 + a_3 D_3 m_3}\n$$\n  - **$a_1 \\approx 0.44$:** Hot-Mix Asphalt (HMA) surface layer coefficient;\n  - **$a_2 \\approx 0.14$:** Crushed stone base layer coefficient;\n  - **$a_3 \\approx 0.11$:** Granular subbase layer coefficient;\n  - **$m_2, m_3 \\approx 1.00$:** Drainage quality modification factors;\n  - **$D_1, D_2, D_3$:** Layer thicknesses in inches (rounded up to $0.5\\text{ in}$);\n• **Subgrade Resilient Modulus Correlation:** $\\mathbf{M_R \\approx 1500 \\times \\text{CBR } [\\text{psi}]}$\n• **Layer Sizing Formulations (Top-Down Budgeting):**\n$$\n\\mathbf{D_1^* \\ge \\frac{SN_1}{a_1} \\quad \\Big| \\quad D_2^* \\ge \\frac{SN_2 - a_1 D_1^*}{a_2 m_2} \\quad \\Big| \\quad D_3^* \\ge \\frac{SN_3 - (a_1 D_1^* + a_2 D_2^* m_2)}{a_3 m_3}}\n$$\n• **The Structural Protection Invariant:** The surface layer must provide sufficient strength ($SN_1$) to prevent shear failure in the untreated base, while the entire pavement ($SN_3$) prevents permanent rutting in the soft subgrade!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design layer thicknesses for a flexible asphalt pavement using the AASHTO 1993 method.",
      "orderItems": [
        "Determine the design traffic ESALs and resilient modulus MR for the subgrade (MR \u2248 1500*CBR), subbase, and base materials",
        "Calculate the required Structural Numbers: SN1 (above base), SN2 (above subbase), and SN3 (above roadbed subgrade)",
        "Size the asphalt surface course: D1 = SN1 / a1 and round up to the nearest half-inch (D1*)",
        "Calculate the required base course thickness: D2 = (SN2 - a1*D1*) / (a2*m2) and round up to the nearest half-inch (D2*)",
        "Calculate the subbase thickness: D3 = [SN3 - (a1*D1* + a2*D2**m2)] / (a3*m3) and verify that total provided SN* \u2265 SN3"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Flexible Pavement Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Structural Number (SN)", "right": "Abstract dimensionless index measuring the total load-carrying capacity of a multilayer flexible pavement" },
        { "left": "Asphalt Coefficient (a1 \u2248 0.44)", "right": "High structural rating of dense-graded bituminous hot mix resisting flexural tensile fatigue" },
        { "left": "Crushed Base Coefficient (a2 \u2248 0.14)", "right": "Structural contribution of compacted crushed stone aggregate distributing vertical shear" },
        { "left": "Resilient Modulus (MR \u2248 1500*CBR)", "right": "Empirical subgrade stiffness parameter governing total required structural thickness" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In AASHTO 1993 flexible pavement design, the typical structural layer coefficient a1 for dense-graded hot-mix asphalt equals approximately ___.",
      "blankAnswer": "0.44",
      "blankDistractors": ["0.14", "0.11", "1.00"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A two-layer flexible pavement on crushed stone base (a2 = 0.14, m2 = 1.0) with asphalt surface (a1 = 0.44) requires SN1 = 1.76 over the base and total SN2 = 3.50 over the subgrade. What are the minimum rounded layer thicknesses D1* and D2* (to nearest 0.5 inch)?",
      "options": [
        { "text": "D1* = 4.0 in and D2* = 12.5 in (D1 = 1.76 / 0.44 = 4.00 in; a1*D1* = 0.44*4.0 = 1.76; D2 = (3.50 - 1.76) / (0.14*1.0) = 1.74 / 0.14 = 12.43 in \u2192 round up to 12.5 in; SN* = 1.76 + 0.14*12.5 = 3.51 \u2265 3.50)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the AASHTO 1993 flexible pavement layer budgeting method (Yang H. Huang *Pavement Analysis and Design* Chapter 11). 1. **Size Asphalt Surface Course ($D_1$):** - Required $SN_1$ over base course $= 1.76$. - Asphalt structural coefficient: $a_1 = 0.44$. $$D_1 \\ge \\frac{SN_1}{a_1} = \\frac{1.76}{0.44} = \\mathbf{4.00\\text{ in}}$$ - Select rounded thickness: $$D_1^* = \\mathbf{4.0\\text{ in}}$$ - Actual structural number provided by surface: $$SN_1^* = a_1 \\cdot D_1^* = 0.44 \\times 4.0\\text{ in} = \\mathbf{1.76}$$ 2. **Size Crushed Stone Base Course ($D_2$):** - Total required $SN_2$ over subgrade $= 3.50$. - Base structural coefficient: $a_2 = 0.14$, drainage factor: $m_2 = 1.0$. - Remaining structural deficiency to be covered by base: $$\\Delta SN_2 = SN_2 - SN_1^* = 3.50 - 1.76 = \\mathbf{1.74}$$ $$D_2 \\ge \\frac{\\Delta SN_2}{a_2 \\cdot m_2} = \\frac{1.74}{0.14 \\times 1.0} = \\mathbf{12.4286\\text{ in}}$$ 3. **AASHTO Practical Construction Rounding:** - Standard engineering specifications require layer thicknesses rounded up to the nearest **half-inch ($0.5\\text{ in}$)**. $$D_2^* = \\mathbf{12.5\\text{ in}}$$ 4. **Verify Total Provided Structural Number ($SN^*$):** $$SN^* = a_1 D_1^* + a_2 D_2^* m_2 = (0.44 \\times 4.0\\text{ in}) + (0.14 \\times 12.5\\text{ in} \\times 1.0)$$ $$SN^* = 1.76 + 1.75 = \\mathbf{3.51} \\ge 3.50 \\quad (\\text{Design Verified \\& Safe!})$$ Flawless AASHTO flexible pavement layer thickness derivation!" },
        { "text": "D1* = 4.0 in and D2* = 12.0 in (SN* = 3.44 < 3.50 Unsafe)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "D1* = 3.5 in and D2* = 14.0 in", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "D1* = 5.0 in and D2* = 10.0 in", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
