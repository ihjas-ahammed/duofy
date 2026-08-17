# Duofy Reusable Lesson Format: Boundary Conditions (Dielectric & Conductor Interfaces)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Electromagnetic_Fields_and_Waves / Maxwell_Equations_and_Boundary_Conditions`  
**Lesson Format Type:** `electromagnetic_boundary_conditions_dielectric_and_conductor_interfaces`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through electromagnetic field matching at material interfaces, normal and tangential vector decompositions, surface charge/current discontinuities, and perfect electric conductor (PEC) shielding in wave electromagnetics (Matthew N.O. Sadiku *Elements of Electromagnetics* Chapter 5 & 8; Fawwaz T. Ulaby *Fundamentals of Applied Electromagnetics* Chapter 4 & 5; David K. Cheng *Field and Wave Electromagnetics* Chapter 3 & 6): derive the **Four Fundamental Electromagnetic Boundary Conditions**:
1. **Tangential Electric Field ($\mathbf{E_t}$):**
   $$\mathbf{\hat{n} \times (\mathbf{E}_1 - \mathbf{E}_2) = 0 \Longleftrightarrow \mathbf{E_{1t} = E_{2t} \ (\text{ALWAYS Continuous!})}}$$
2. **Normal Electric Flux Density ($\mathbf{D_n}$):**
   $$\mathbf{\hat{n} \cdot (\mathbf{D}_1 - \mathbf{D}_2) = \rho_s \Longleftrightarrow D_{1n} - D_{2n} = \rho_s \quad \Big| \quad \mathbf{\epsilon_1 E_{1n} = \epsilon_2 E_{2n} \ (\text{Charge-free dielectric: } \rho_s = 0)}}$$
3. **Normal Magnetic Flux Density ($\mathbf{B_n}$):**
   $$\mathbf{\hat{n} \cdot (\mathbf{B}_1 - \mathbf{B}_2) = 0 \Longleftrightarrow \mathbf{B_{1n} = B_{2n} \ (\text{ALWAYS Continuous!})}}$$
4. **Tangential Magnetic Field ($\mathbf{H_t}$):**
   $$\mathbf{\hat{n} \times (\mathbf{H}_1 - \mathbf{H}_2) = \mathbf{K}_s \Longleftrightarrow H_{1t} - H_{2t} = K_s \quad \Big| \quad \mathbf{H_{1t} = H_{2t} \ (\text{Dielectric: } K_s = 0)}}$$
derive the **Law of Refraction for Electric Field Lines across Dielectrics ($\mathbf{\frac{\tan\theta_1}{\tan\theta_2} = \frac{\epsilon_{r1}}{\epsilon_{r2}}}$)**, and prove the **PEC Boundary Invariant** ($\mathbf{E} = 0, \mathbf{H} = 0$ inside a perfect conductor $\implies E_t = 0, D_n = \rho_s, B_n = 0, H_t = K_s$ on the metallic surface).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | 4 Boundary Conditions ($E_{1t}=E_{2t}, D_{1n}-D_{2n}=\rho_s, B_{1n}=B_{2n}, H_{1t}-H_{2t}=K_s$) & Dielectric Refraction Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Match and Refract Vector Fields Across a Media Interface Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Boundary Component / Interface Class & Technical Continuity Condition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Tangential Component of the Electric Field Intensity Vector E Is Strictly ___ Across Any Material Interface (Continuous / Equal) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Electromagnetic Field Problem: Calculating the Refracted Electric Field Vector in Medium 2 Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Boundary Conditions (Sadiku 2021; Ulaby 2020; Cheng 2014):
   - **Boundary Condition Equations Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Vector Component} & \textbf{General Boundary Law} & \textbf{Dielectric Interface } (\rho_s=0, K_s=0) & \textbf{PEC Conductor Surface} \\
     \hline
     \mathbf{\text{Tangential Electric } E_t} & \mathbf{E_{1t} = E_{2t}} & \mathbf{E_{1t} = E_{2t} \ (\text{Continuous!})} & \mathbf{E_t = 0} \\
     \mathbf{\text{Normal Electric } D_n} & D_{1n} - D_{2n} = \rho_s & \mathbf{\epsilon_1 E_{1n} = \epsilon_2 E_{2n}} & \mathbf{D_n = \rho_s} \\
     \mathbf{\text{Normal Magnetic } B_n} & \mathbf{B_{1n} = B_{2n}} & \mathbf{B_{1n} = B_{2n} \ (\text{Continuous!})} & \mathbf{B_n = 0} \\
     \mathbf{\text{Tangential Magnetic } H_t} & H_{1t} - H_{2t} = K_s & \mathbf{H_{1t} = H_{2t}} & \mathbf{H_t = K_s} \\
     \hline
     \end{array}$$
   - **Dielectric Refraction Law:**
     $$\mathbf{\frac{\tan\theta_1}{\tan\theta_2} = \frac{\epsilon_{r1}}{\epsilon_{r2}} \quad \left(\theta = \text{Angle with Interface Normal } \hat{n}\right)}$$
   - **The Tangential Invariant:** $E_t$ and $B_n$ are **unconditionally continuous across EVERY physical boundary in the universe**!
2. **Slide 2 (`ordering`):** Provide 5 steps of boundary field matching: (1) define the interface plane (e.g. $z = 0$) and identify unit normal vector $\hat{n} = \hat{a}_z$, (2) decompose the incident electric field $\mathbf{E}_1$ into normal component $E_{1n} \hat{a}_z$ and tangential component $\mathbf{E}_{1t}$, (3) apply tangential continuity $E_{2t} = E_{1t}$ to find tangential field in Medium 2, (4) apply normal boundary condition $D_{2n} = D_{1n} \implies \epsilon_2 E_{2n} = \epsilon_1 E_{1n} \implies E_{2n} = \frac{\epsilon_1}{\epsilon_2} E_{1n}$, (5) reconstruct the total refracted vector $\mathbf{E}_2 = \mathbf{E}_{2t} + E_{2n} \hat{a}_z$ and calculate field refraction angle $\theta_2$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Tangential Electric $E_{1t} = E_{2t}$, Normal Electric Flux $D_{1n}-D_{2n}=\rho_s$, Normal Magnetic $B_{1n}=B_{2n}$, PEC Surface $E_t = 0$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Continuous (or Equal). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on finding refracted field vector: The plane $z = 0$ marks the boundary between Medium 1 ($z > 0$, relative permittivity $\epsilon_{r1} = 2.0$) and Medium 2 ($z < 0$, relative permittivity $\epsilon_{r2} = 8.0$). There is no surface charge on the interface ($\rho_s = 0$). In Medium 1, the electric field is $\mathbf{E}_1 = 5 \hat{a}_x - 2 \hat{a}_y + 12 \hat{a}_z\text{ V/m}$. What is the electric field vector $\mathbf{E}_2$ in Medium 2? (Tangential components lie in the $xy$-plane $\implies \mathbf{E}_{2t} = \mathbf{E}_{1t} = 5 \hat{a}_x - 2 \hat{a}_y$; Normal component is in the $z$-direction: $D_{2n} = D_{1n} \implies \epsilon_2 E_{2z} = \epsilon_1 E_{1z} \implies E_{2z} = \frac{\epsilon_{r1}}{\epsilon_{r2}} E_{1z} = \frac{2.0}{8.0} (12\text{ V/m}) = \frac{1}{4}(12) = \mathbf{3 \hat{a}_z\text{ V/m}}$; Total field: $\mathbf{E}_2 = \mathbf{5 \hat{a}_x - 2 \hat{a}_y + 3 \hat{a}_z\text{ V/m}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "electromagnetic_boundary_conditions_dielectric_and_conductor_interfaces",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Electromagnetic Boundary Conditions (Sadiku \\& Ulaby)**\n• **The 4 Master Vector Boundary Formulations:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Field Vector Component} & \\textbf{General Interface Law} & \\textbf{Charge-Free Dielectric } (\\rho_s=0, K_s=0) \\\\\n\\hline\n\\mathbf{\\text{Tangential Electric } E_t} & \\mathbf{\\hat{n} \\times (\\mathbf{E}_1 - \\mathbf{E}_2) = 0} & \\mathbf{E_{1t} = E_{2t} \\text{ (ALWAYS Continuous!)}} \\\\\n\\mathbf{\\text{Normal Electric } D_n} & \\mathbf{\\hat{n} \\cdot (\\mathbf{D}_1 - \\mathbf{D}_2) = \\rho_s} & \\mathbf{\\epsilon_1 E_{1n} = \\epsilon_2 E_{2n}} \\\\\n\\mathbf{\\text{Normal Magnetic } B_n} & \\mathbf{\\hat{n} \\cdot (\\mathbf{B}_1 - \\mathbf{B}_2) = 0} & \\mathbf{B_{1n} = B_{2n} \\text{ (ALWAYS Continuous!)}} \\\\\n\\mathbf{\\text{Tangential Magnetic } H_t} & \\mathbf{\\hat{n} \\times (\\mathbf{H}_1 - \\mathbf{H}_2) = \\mathbf{K}_s} & \\mathbf{H_{1t} = H_{2t}} \\\\\n\\hline\n\\end{array}\n$$\n• **Law of Refraction for Field Lines (Angle $\\mathbf{\\theta}$ from Normal):**\n$$\n\\mathbf{\\frac{\\tan\\theta_1}{\\tan\\theta_2} = \\frac{\\epsilon_{r1}}{\\epsilon_{r2}} \\quad \\Big| \\quad \\frac{\\tan\\theta_1}{\\tan\\theta_2} = \\frac{\\mu_{r1}}{\\mu_{r2}}}\n$$\n• **The Perfect Conductor (PEC) Invariant:** Inside a perfect conductor, all fields are identically zero ($\\mathbf{E}=0, \\mathbf{H}=0$). At the surface: $\\mathbf{E_t = 0, \\ D_n = \\rho_s, \\ B_n = 0, \\ H_t = K_s}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the refracted electric field vector across a planar dielectric interface.",
      "orderItems": [
        "Identify the interface boundary plane equation and determine the unit normal vector n_hat pointing from medium 2 to medium 1",
        "Decompose the incident electric field E1 into normal component E1n*n_hat and tangential vector component E1t",
        "Apply tangential boundary continuity to establish the tangential component in medium 2: E2t = E1t",
        "Apply normal displacement flux continuity D2n = D1n to evaluate normal field: E2n = (eps_1 / eps_2) * E1n",
        "Combine tangential and normal vectors to construct total refracted electric field: E2 = E2t + E2n*n_hat"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Electromagnetic Boundary Condition to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Tangential Electric (E1t = E2t)", "right": "Derived from Faraday's loop law (\u2207\u00d7E = 0 in static limit), enforcing zero tangential voltage jump" },
        { "left": "Normal Electric (D1n - D2n = \u03c1s)", "right": "Derived from Gauss's pillbox, where surface charge creates a step discontinuity in normal D" },
        { "left": "Normal Magnetic (B1n = B2n)", "right": "Derived from \u2207\u00b7B = 0, guaranteeing continuous normal magnetic flux density without sources" },
        { "left": "PEC Surface (Et = 0)", "right": "Electrostatic shielding condition where free electrons short out any parallel electric field component" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The tangential component of the electric field intensity vector E is strictly ___ across any physical material interface.",
      "blankAnswer": "continuous",
      "blankDistractors": ["discontinuous", "zero", "infinite"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "The plane z = 0 separates Medium 1 (z > 0, \u03b5r1 = 2.0) from Medium 2 (z < 0, \u03b5r2 = 8.0) with zero surface charge (\u03c1s = 0). The electric field in Medium 1 is E1 = 5 ax - 2 ay + 12 az V/m. What is the electric field vector E2 in Medium 2?",
      "options": [
        { "text": "E2 = 5 ax - 2 ay + 3 az V/m (Tangential components E2x = 5, E2y = -2 are continuous; normal component E2z = (\u03b5r1 / \u03b5r2) * E1z = (2/8) * 12 = 3 V/m)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using electromagnetic boundary conditions (Matthew Sadiku *Elements of Electromagnetics* Chapter 5). 1. **Identify Tangential and Normal Components:** - The boundary is the $xy$-plane at $z = 0$. - Normal unit vector: $\\hat{n} = \\hat{a}_z$. - Normal component in Medium 1: $E_{1n} = 12\\text{ V/m}$. - Tangential component in Medium 1: $\\mathbf{E}_{1t} = 5 \\hat{a}_x - 2 \\hat{a}_y\\text{ V/m}$. 2. **Apply Tangential Continuity:** - By Faraday's Law, tangential electric field is **unconditionally continuous**: $$\\mathbf{E}_{2t} = \\mathbf{E}_{1t} = \\mathbf{5 \\hat{a}_x - 2 \\hat{a}_y\\text{ V/m}}$$ 3. **Apply Normal Boundary Condition ($\\rho_s = 0$):** - By Gauss's Law: $$D_{2n} = D_{1n} \\implies \\epsilon_2 E_{2z} = \\epsilon_1 E_{1z}$$ $$E_{2z} = \\frac{\\epsilon_1}{\\epsilon_2} E_{1z} = \\frac{\\epsilon_{r1}}{\\epsilon_{r2}} E_{1z} = \\frac{2.0}{8.0} (12\\text{ V/m}) = \\frac{1}{4} \\times 12 = \\mathbf{3\\text{ V/m}}$$ 4. **Assemble Total Field in Medium 2:** $$\\mathbf{E}_2 = \\mathbf{E}_{2t} + E_{2z} \\hat{a}_z = \\mathbf{5 \\hat{a}_x - 2 \\hat{a}_y + 3 \\hat{a}_z\\text{ V/m}}$$ Flawless boundary vector reconstruction!" },
        { "text": "E2 = 20 ax - 8 ay + 48 az V/m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "E2 = 1.25 ax - 0.5 ay + 3 az V/m", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "E2 = 5 ax - 2 ay + 48 az V/m", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
