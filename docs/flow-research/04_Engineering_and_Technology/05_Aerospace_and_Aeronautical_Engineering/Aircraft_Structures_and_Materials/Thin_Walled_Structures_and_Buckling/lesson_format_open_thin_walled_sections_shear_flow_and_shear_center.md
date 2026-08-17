# Duofy Reusable Lesson Format: Open Beams (Transverse Shear Flow & Shear Center)

**Target Topic:** `04_Engineering_and_Technology / 05_Aerospace_and_Aeronautical_Engineering / Aircraft_Structures_and_Materials / Thin_Walled_Structures_and_Buckling`  
**Lesson Format Type:** `open_thin_walled_sections_shear_flow_and_shear_center`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through shear stress distribution in open thin-walled aerospace structural profiles (C-channels, Z-sections, angle spars, open I-beams), the contour coordinate ($s$), the fundamental **Shear Flow Differential Equation** derived from axial equilibrium ($\frac{\partial q}{\partial s} = -t \frac{\partial \sigma_z}{\partial z}$), transverse shear loads ($S_x, S_y$), the symmetric section shear flow equation ($q(s) = q_0 - \frac{S_y}{I_{xx}} \int_0^s y t \, ds$), zero boundary shear conditions at free edges ($q_0 = 0$), and the analytical determination of the **Shear Center ($x_{\text{sc}}, y_{\text{sc}}$)** (T. H. G. Megson *Aircraft Structures for Engineering Students* 6th ed. Chapter 17; David J. Peery *Aircraft Structures* Chapter 6): formulate the **Open Thin-Walled Transverse Shear Flow Master Formulation**:
$$\mathbf{q(s) = q_0 - \left( \frac{S_y I_{xx} - S_x I_{xy}}{I_{xx} I_{yy} - I_{xy}^2} \right) \int_0^s t \cdot x(s') \, ds' - \left( \frac{S_x I_{yy} - S_y I_{xy}}{I_{xx} I_{yy} - I_{xy}^2} \right) \int_0^s t \cdot y(s') \, ds'}$$
for a cross-section with an axis of horizontal symmetry ($I_{xy} = 0, S_x = 0, S_y = V$):
$$\mathbf{q(s) = -\frac{V}{I_{xx}} \int_0^s y(s') \cdot t \, ds' = -\frac{V \cdot Q(s)}{I_{xx}} \quad \left(q(s=0) = 0 \text{ at Free Edges}\right)}$$
derive the **Shear Center Location Equation ($e = x_{\text{sc}}$)** by moment equivalence about an arbitrary reference origin:
$$\mathbf{V \cdot x_{\text{sc}} = \int_{\text{contour}} q(s) \cdot r_p(s) \, ds \Longleftrightarrow \mathbf{x_{\text{sc}} = \frac{1}{V} \int_{\text{contour}} q(s) \cdot r_p(s) \, ds}}$$
for a thin-walled C-channel with flange width $b$, web height $h$, and uniform thickness $t$:
$$\mathbf{x_{\text{sc}} = \frac{3 b^2}{6 b + h} \quad (\text{Distance from Web Centerline, Located Outside the Section!})}$$
(proving that applying an aerodynamic lift force through the shear center produces pure vertical bending with zero twisting, while applying lift at the centroid twists the spar and alters wing angle of attack).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Open Shear Flow ($q(s) = -\frac{S_y}{I_{xx}}\int y t ds$), Free Edge $q=0$ & Shear Center ($x_{\text{sc}} = \frac{3b^2}{6b+h}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Flange and Web Shear Flows and Locate the Shear Center of a Channel Spar Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Open Thin-Walled Section Construct / Shear Parameter & Technical Mechanics Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Shear Center of a Structural Cross-Section Is Formally Defined as the Unique Point Through Which a Transverse Shear Force Produces Pure Bending with Strictly Zero ___ (Twist / Twisting / Torsion) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Airframe Structural Problem: Computing Flange Shear Force and Shear Center Distance for a C-Channel Wing Spar Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Open Section Shear Flow & Shear Center Mechanics (Megson 2017; Peery 1982):
   - **Shear Flow Formulations:**
     $$\mathbf{q(s) = -\frac{V}{I_{xx}}\int_0^s y t \, ds' \quad \Big| \quad V \cdot x_{\text{sc}} = \sum F_{\text{flange}} \cdot d \quad \Big| \quad x_{\text{sc}} = \frac{3 b^2}{6b + h} \quad \Big| \quad q(0) = 0}$$
   - **Cross-Section Shear Center Locations Matrix:**
     $$\begin{array}{|l|c|l|}
     \hline
     \textbf{Structural Profile Type} & \textbf{Symmetry Axes} & \textbf{Shear Center Location } (x_{\text{sc}}, y_{\text{sc}}) \\
     \hline
     \mathbf{\text{Doubly Symmetric I-Beam}} & \mathbf{2 \text{ Axes}} & \mathbf{\text{Coincides exactly with Centroid }} (0, 0) \\
     \mathbf{\text{Symmetric C-Channel Spar}} & \mathbf{1 \text{ Horizontal Axis}} & \mathbf{\text{Lies outside the web at }} x_{\text{sc}} = \frac{3b^2}{6b+h} \\
     \text{Equal-Leg Angle Profile} & 1 \text{ Diagonal Axis} & \text{Located at the intersection of the two thin legs} \\
     \text{T-Section Profile} & 1 \text{ Vertical Axis} & \text{Located at the intersection of flange and web} \\
     \hline
     \end{array}$$
   - **The Free Edge Invariant:** At any free, unconstrained edge of a thin-walled cross-section, **shear flow is identically zero ($q = 0$)** because no external shear tractions act on the free surface!
2. **Slide 2 (`ordering`):** Provide 5 steps of shear flow and shear center calculation: (1) calculate the second moment of area $I_{xx}$ about the horizontal neutral axis, (2) integrate the first moment of area along the top flange to find linear shear flow: $q_{\text{flange}}(s) = -\frac{V}{I_{xx}} (\frac{h}{2}) t s$, (3) integrate flange shear flow across flange width $b$ to find total horizontal flange force: $F_f = \frac{1}{2} q_{\text{max}} b$, (4) sum moments about the web centerline to equate external moment $V \cdot x_{\text{sc}}$ to internal flange force couple $F_f \cdot h$, (5) solve for shear center offset: $x_{\text{sc}} = \frac{F_f \cdot h}{V} = \frac{3 b^2}{6b+h}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Shear Center $x_{\text{sc}}$, Free Edge Boundary $q=0$, Flange Force Couple $F_f \cdot h$, First Moment of Area $Q(s)$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Twist (or Twisting / Torsion). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating shear center: An aluminum C-channel aircraft wing spar has flange width $b = 50.0\text{ mm}$, web height $h = 100.0\text{ mm}$, and uniform wall thickness $t = 2.0\text{ mm}$.
   - Using the standard thin-walled channel shear center formula:
     $x_{\text{sc}} = \frac{3 b^2}{6 b + h}$;
   - Numerator: $3 \times (50.0\text{ mm})^2 = 3 \times 2500.0 = \mathbf{7500.0\text{ mm}^2}$;
   - Denominator: $6 b + h = (6 \times 50.0) + 100.0 = 300.0 + 100.0 = \mathbf{400.0\text{ mm}}$;
   - Shear center distance from web centerline:
     $x_{\text{sc}} = \frac{7500.0}{400.0} = \mathbf{18.75\text{ mm}}$;
   - What is the shear center distance $x_{\text{sc}}$ from the web centerline? ($x_{\text{sc}} = \mathbf{18.75\text{ mm}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "open_thin_walled_sections_shear_flow_and_shear_center",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Open Section Shear Flow \\& Shear Center (T. H. G. Megson)**\n• **Transverse Shear Flow Master Formulation (Symmetric $I_{xy} = 0$):**\n$$\n\\mathbf{q(s) = q_0 - \\frac{S_y}{I_{xx}} \\int_0^s y(s') \\cdot t \\, ds' \\quad \\left[\\frac{\\text{N}}{\\text{mm}}\\right] \\quad (q_0 = 0 \\text{ at Free Edges})}\n$$\n  - **$q(s)$:** Shear flow along thin wall contour coordinate $s$;\n  - **$S_y$:** Transverse shear force;\n  - **$I_{xx}$:** Second moment of area about centroidal neutral axis;\n• **Shear Center Formulation ($x_{\\text{sc}}$):**\n$$\n\\mathbf{S_y \\cdot x_{\\text{sc}} = \\int_{\\text{contour}} q(s) \\cdot r_p(s) \\, ds \\Longleftrightarrow \\mathbf{x_{\\text{sc}} = \\frac{3 b^2}{6 b + h} \\quad (\\text{for Channel Spar})}}\n$$\n• **The Zero-Twist Invariant:** The Shear Center is the **unique point through which a transverse shear load causes pure bending with zero twisting**; applying aerodynamic lift at any other point produces a torsional moment that alters wing incidence!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the shear flow distribution and shear center location for an open thin-walled C-channel spar.",
      "orderItems": [
        "Calculate the second moment of area Ixx of the channel section about its horizontal centroidal neutral axis",
        "Set boundary condition q = 0 at the free tips of the upper and lower flanges",
        "Integrate the first moment of area along the top flange to determine the linear flange shear flow distribution q_flange(s)",
        "Integrate the flange shear flow across width b to compute the resultant horizontal flange force: F_flange = 0.5 * q_max * b",
        "Take moments about the web centerline: equate external moment Sy * x_sc to the flange couple F_flange * h to solve for x_sc"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Open Thin-Walled Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Shear Center (x_sc)", "right": "Unique cross-sectional point through which a transverse load produces pure bending without torsional twisting" },
        { "left": "Free Edge Boundary", "right": "q(s=0) = 0, mandatory physical condition where shear flow vanishes at unrestrained sheet boundaries" },
        { "left": "Flange Force Couple", "right": "F_f * h, internal horizontal force pair in upper/lower flanges resisting external torque about web" },
        { "left": "First Moment of Area (Q)", "right": "\u222b y*t ds, geometric accumulation of area times centroidal distance dictating shear flow slope" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The shear center of a structural cross-section is formally defined as the unique point through which a transverse shear force produces pure bending with strictly zero ___.",
      "blankAnswer": "twist",
      "blankDistractors": ["shear", "bending", "deflection"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An aluminum C-channel wing spar has flange width b = 50.0 mm, web height h = 100.0 mm, and thickness t = 2.0 mm. Using the standard thin-walled channel shear center formula x_sc = 3*b^2 / (6*b + h), with 3*b^2 = 3 * 2500 = 7500 mm^2 and 6*b + h = 300 + 100 = 400 mm, what is the shear center distance x_sc from the web centerline?",
      "options": [
        { "text": "x_sc = 18.75 mm (x_sc = 7500.0 mm^2 / 400.0 mm = 18.75 mm outside the web centerline)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the open thin-walled shear center formula for a C-channel section (T. H. G. Megson *Aircraft Structures for Engineering Students* Chapter 17; David J. Peery *Aircraft Structures* Chapter 6). 1. **Identify Channel Cross-Section Dimensions:** - Flange width: $b = 50.0\\text{ mm}$. - Web height: $h = 100.0\\text{ mm}$. - Uniform skin thickness: $t = 2.0\\text{ mm}$. 2. **Calculate Second Moment of Area ($I_{xx}$):** - Web contribution: $I_{\\text{web}} = \\frac{1}{12} t h^3 = \\frac{1}{12} (2.0) (100.0)^3 = \\mathbf{166,666.7\\text{ mm}^4}$. - Flanges contribution: $2 \\times [ b t (h/2)^2 ] = 2 \\times [ 50.0 \\times 2.0 \\times (50.0)^2 ] = 2 \\times 250,000 = \\mathbf{500,000.0\\text{ mm}^4}$. - Total: $I_{xx} = 166,666.7 + 500,000.0 = \\mathbf{666,666.7\\text{ mm}^4} = \\frac{1}{12} t h^2 (6b + h)$. 3. **Calculate Flange Resultant Force ($F_f$):** - Flange shear flow: $$q(s) = \\frac{S_y}{I_{xx}} \\left( \\frac{h}{2} \\right) t s$$ - Flange resultant force: $$F_f = \\int_0^b q(s) ds = \\frac{S_y t h}{2 I_{xx}} \\left( \\frac{b^2}{2} \\right) = \\frac{S_y t h b^2}{4 I_{xx}}$$ 4. **Calculate Shear Center Distance ($x_{\\text{sc}}$):** - Taking moments about the center of the vertical web: $$S_y \\cdot x_{\\text{sc}} = F_f \\cdot h = \\left( \\frac{S_y t h b^2}{4 I_{xx}} \\right) h = \\frac{S_y t h^2 b^2}{4 \\left[ \\frac{1}{12} t h^2 (6b + h) \\right]}$$ $$x_{\\text{sc}} = \\frac{3 b^2}{6 b + h}$$ - Substituting numerical values: $$x_{\\text{sc}} = \\frac{3 \\times (50.0\\text{ mm})^2}{(6 \\times 50.0\\text{ mm}) + 100.0\\text{ mm}} = \\frac{3 \\times 2500.0}{300.0 + 100.0} = \\frac{7500.0}{400.0} = \\mathbf{18.75\\text{ mm}}$$ Flawless open section shear flow and shear center derivation!" },
        { "text": "x_sc = 25.00 mm (Assumed centroid location)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "x_sc = 37.50 mm", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "x_sc = 12.50 mm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
