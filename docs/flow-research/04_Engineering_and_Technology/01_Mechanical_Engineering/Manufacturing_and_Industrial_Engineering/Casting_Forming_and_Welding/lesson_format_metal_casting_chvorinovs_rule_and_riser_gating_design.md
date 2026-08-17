# Duofy Reusable Lesson Format: Metal Casting (Chvorinov's Rule & Riser/Gating Design)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Manufacturing_and_Industrial_Engineering / Casting_Forming_and_Welding`  
**Lesson Format Type:** `metal_casting_chvorinovs_rule_and_riser_gating_design`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through molten metal solidification thermodynamics, Chvorinov's rule, riser sizing via the modulus method, and fluid gating hydraulics in foundry engineering (Nicolas Chvorinov 1940; Serope Kalpakjian & Steven R. Schmid *Manufacturing Engineering and Technology* Chapter 10 & 11; Mikell P. Groover *Fundamentals of Modern Manufacturing* Chapter 10 & 11): master **Chvorinov's Rule of Total Solidification Time**:
$$\mathbf{t_s = C_m \left(\frac{V}{A}\right)^n = C_m M^2 \quad \left(n \approx 2.0, \ M = \frac{V}{A} \text{ is Solidification Modulus}\right)}$$
where $C_m$ is the mold constant (governed by metal latent heat $L_f$, pouring superheat $\Delta T$, and sand mold thermal diffusivity); master **Caine's and Modulus Riser Sizing Rules**:
$$\mathbf{t_{s,\text{riser}} > t_{s,\text{casting}} \implies M_{\text{riser}} \ge 1.2 \cdot M_{\text{casting}}}$$
(proving why an effective feeder riser must have a higher volume-to-surface-area ratio than the main casting to ensure it solidifies **strictly LAST**, pumping molten metal into the casting to eliminate shrinkage voids); master the **Gating System Choke Area Formulation**:
$$\mathbf{A_c = \frac{V_{\text{casting}}}{t_{\text{pour}} \cdot C_d \sqrt{2 g H_{\text{sprue}}}}}$$
and contrast **Pressurized Gating Systems ($1:2:1$, backpressure prevents air aspiration)** vs **Unpressurized Gating Systems ($1:2:4$, laminar non-turbulent dross reduction for aluminum/magnesium)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Chvorinov's Rule ($t_s = C_m (V/A)^2$) & Riser Modulus ($M_{\text{riser}} \ge 1.2 M_{\text{casting}}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of Solidification Time, Feeder Riser, and Sprue Choke Area Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Foundry Casting Element / Gating Component & Hydraulic Metallurgical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Chvorinov's Rule, the Total Solidification Time of a Molten Metal Casting Scales Proportionally with the ___ of the (Volume / Surface Area) Ratio (Square / 2) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Foundry Engineering Problem: Sizing a Cylindrical Top Riser for a Solid Steel Plate Casting Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Chvorinov & Riser Design (Kalpakjian 2020; Groover 2020):
   - **Chvorinov's Formulation:**
     $$\mathbf{t_s = C_m \left(\frac{V}{A}\right)^2 = C_m M^2 \quad \left(M = \frac{V}{A}\right)}$$
   - **Solidification Modulus Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Casting Geometry} & \textbf{Volume } V & \textbf{Surface Area } A & \textbf{Modulus } M = V/A \\
     \hline
     \mathbf{\text{Sphere (Radius } R\text{)}} & \frac{4}{3}\pi R^3 & 4\pi R^2 & \mathbf{M = \frac{R}{3} = \frac{D}{6} \ (\text{Slowest cooling!})} \\
     \mathbf{\text{Cube (Side } a\text{)}} & a^3 & 6 a^2 & \mathbf{M = \frac{a}{6}} \\
     \mathbf{\text{Cylinder } (H = D)} & \frac{\pi D^3}{4} & \frac{3\pi D^2}{2} & \mathbf{M = \frac{D}{6}} \\
     \mathbf{\text{Thin Plate (Thickness } t\text{)}} & L \cdot W \cdot t & 2 L W & \mathbf{M \approx \frac{t}{2} \ (\text{Fastest cooling!})} \\
     \hline
     \end{array}$$
   - **The Riser Invariant:** A feeder riser must have **$\mathbf{M_{\text{riser}} \ge 1.2 M_{\text{casting}} \implies t_{s,\text{riser}} \ge 1.44 t_{s,\text{casting}}}$** so it freezes last!
2. **Slide 2 (`ordering`):** Provide 5 steps of casting design: (1) calculate the volume $V$ and surface area $A$ of the casting to find modulus $M_{\text{cast}} = V/A$, (2) determine optimal pouring time $t_{\text{pour}}$ to prevent premature freezing and misruns, (3) calculate sprue choke area $A_c = \frac{V}{t_{\text{pour}} C_d \sqrt{2gh}}$ to meter flow without air aspiration, (4) size cylindrical riser dimensions ($H = D \implies M_{\text{riser}} = D/6$) ensuring $M_{\text{riser}} \ge 1.2 M_{\text{cast}}$, (5) verify directional solidification towards the riser using chills and tapered walls!
3. **Slide 3 (`matching`):** Pair 4 concepts (Chvorinov's Rule, Feeder Riser, Sprue Choke Area, Pressurized Gating $1:2:1$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Square (or 2). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating solidification time comparison: A spherical steel casting of diameter $D = 100\text{ mm}$ solidifies in $t_s = 4.0\text{ minutes}$ in a sand mold. Under identical mold and pouring conditions, how long will it take for a cube of side $a = 100\text{ mm}$ to completely solidify? (Modulus of sphere: $M_{\text{sphere}} = \frac{D}{6} = \frac{100}{6} = 16.67\text{ mm}$; Modulus of cube: $M_{\text{cube}} = \frac{a}{6} = \frac{100}{6} = 16.67\text{ mm}$; Because both geometries share the **exact same solidification modulus ($M = 16.67\text{ mm}$)**, by Chvorinov's rule ($t_s = C_m M^2$), the cube will solidify in **exactly $4.0\text{ minutes}$**!).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "metal_casting_chvorinovs_rule_and_riser_gating_design",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Chvorinov's Solidification Rule \\& Foundry Riser Sizing (Nicolas Chvorinov 1940)**\n• **Chvorinov's Solidification Law Formulation:**\n$$\n\\mathbf{t_s = C_m \\left(\\frac{V}{A}\\right)^2 = C_m M^2 \\quad \\left(M = \\frac{V}{A} = \\text{Solidification Modulus}\\right)}\n$$\n• **Solidification Modulus Geometric Comparison:**\n$$\n\\begin{array}{|l|c|c|l|}\n\\hline\n\\textbf{Geometry Profile} & \\textbf{Volume } V & \\textbf{Surface Area } A & \\textbf{Modulus } M = V/A \\\\\n\\hline\n\\mathbf{\\text{Sphere (Diameter } D\\text{)}} & \\frac{\\pi D^3}{6} & \\pi D^2 & \\mathbf{M = D / 6 \\text{ (Slowest Heat Loss!)}}\\\\\n\\mathbf{\\text{Cube (Side } a\\text{)}} & a^3 & 6 a^2 & \\mathbf{M = a / 6} \\\\\n\\mathbf{\\text{Cylinder } (H = D)} & \\frac{\\pi D^3}{4} & \\frac{3\\pi D^2}{2} & \\mathbf{M = D / 6} \\\\\n\\mathbf{\\text{Thin Plate (Thickness } t\\text{)}} & L \\cdot W \\cdot t & 2 L W & \\mathbf{M \\approx t / 2 \\text{ (Fastest Solidification)}}\\\\\n\\hline\n\\end{array}\n$$\n• **The Feeder Riser Invariant:** A riser acts as a liquid reservoir to compensate for volumetric shrinkage; therefore it MUST solidify LAST: $\\mathbf{M_{\\text{riser}} \\ge 1.2 M_{\\text{casting}} \\implies t_{s,\\text{riser}} \\ge 1.44 t_{s,\\text{casting}}}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design an unpressurized gating system and size a feeder riser for a sand mold casting.",
      "orderItems": [
        "Calculate the volume V and cooling surface area A of the casting to determine its solidification modulus M_cast = V / A",
        "Determine the target pouring time t_pour to avoid premature freezing and excessive molten turbulence",
        "Calculate the minimum choke area at the base of the tapered sprue: A_c = V / (t_pour * C_d * sqrt(2*g*H_sprue))",
        "Select gating ratio (e.g. 1:2:4 unpressurized) to size runner and ingate cross-sectional areas",
        "Size a cylindrical top riser (H = D, M_riser = D / 6) ensuring M_riser >= 1.2 * M_cast so the riser solidifies last"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Casting Foundry Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Chvorinov's Rule", "right": "t_s = C_m * (V/A)^2, stating that solidification time is proportional to the square of the modulus" },
        { "left": "Feeder Riser", "right": "Molten metal reservoir designed with M_riser >= 1.2*M_cast to freeze after casting and feed shrinkage" },
        { "left": "Sprue Choke Area (Ac)", "right": "Smallest cross-sectional area in the gating system that meters the volumetric flow rate of molten metal" },
        { "left": "Internal Chills", "right": "Metal inserts placed inside the mold cavity to accelerate local freezing and establish directional cooling" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Chvorinov's rule, total solidification time scales proportionally with the ___ of the volume-to-surface-area ratio.",
      "blankAnswer": "square",
      "blankDistractors": ["cube", "root", "logarithm"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A spherical steel casting of diameter D = 100 mm completely solidifies in t_s = 4.0 minutes in a sand mold. Under identical mold sand and pouring temperature conditions, how long will it take for a cube of side a = 100 mm to solidify?",
      "options": [
        { "text": "t_s = 4.0 minutes (Because both the sphere of diameter 100 mm and cube of side 100 mm have the exact same modulus M = 100/6 = 16.67 mm, Chvorinov's rule dictates identical solidification times)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Chvorinov's Rule (Serope Kalpakjian *Manufacturing Engineering and Technology* Chapter 10). 1. **Calculate Modulus of the Sphere ($M_{\\text{sphere}}$):** $$M_{\\text{sphere}} = \\frac{V}{A} = \\frac{\\frac{\\pi D^3}{6}}{\\pi D^2} = \\frac{D}{6} = \\frac{100\\text{ mm}}{6} = \\mathbf{16.667\\text{ mm}}$$ 2. **Calculate Modulus of the Cube ($M_{\\text{cube}}$):** $$M_{\\text{cube}} = \\frac{V}{A} = \\frac{a^3}{6 a^2} = \\frac{a}{6} = \\frac{100\\text{ mm}}{6} = \\mathbf{16.667\\text{ mm}}$$ 3. **Apply Chvorinov's Rule:** $$t_s = C_m M^2$$ - Because both shapes have the **exact same modulus $M = 16.67\\text{ mm}$** and identical mold constant $C_m$: $$\\frac{t_{s,\\text{cube}}}{t_{s,\\text{sphere}}} = \\left(\\frac{M_{\\text{cube}}}{M_{\\text{sphere}}}\\right)^2 = \\left(\\frac{16.667}{16.667}\\right)^2 = 1.0$$ $$t_{s,\\text{cube}} = 1.0 \\times 4.0\\text{ minutes} = \\mathbf{4.0\\text{ minutes}}$$ Flawless Chvorinov modulus proof!" },
        { "text": "t_s = 2.0 minutes", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "t_s = 8.0 minutes", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "t_s = 1.57 minutes", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
