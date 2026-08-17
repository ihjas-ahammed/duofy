# Duofy Reusable Lesson Format: Method of Images and Boundary Value Problems

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Electromagnetism_and_Electrodynamics / Electrostatics_and_Gauss_Law`  
**Lesson Format Type:** `method_of_images_and_boundary_value_problems`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the **Method of Images (William Thomson / Lord Kelvin, 1848)**: solve potential and field configurations for a point charge $+q$ near an **Infinite Grounded Conducting Plane** ($V = 0$ at $z = 0$), compute the induced surface charge density $\sigma(x, y) = -\frac{q d}{2\pi (x^2+y^2+d^2)^{3/2}}$, determine total induced charge $Q_{\text{ind}} = -q$, calculate the attractive force $F = -\frac{1}{4\pi\epsilon_0}\frac{q^2}{4d^2}$, and solve the point charge outside a **Grounded Conducting Sphere** ($q' = -q\frac{R}{d}, r' = \frac{R^2}{d}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Method of Images & Conducting Boundary Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Induced Surface Charge Calculation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Boundary Geometry & Image Charge Configuration Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Total Induced Surface Charge Sign on Grounded Plane Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Point Charge Near Grounded Sphere Image Location Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Method of Images principle (Lord Kelvin, 1848): By the First Uniqueness Theorem, if an arrangement of fictitious "image charges" placed in the unphysical region satisfies Poisson's equation in the physical domain and reproduces the exact boundary condition $V = 0$ on conducting surfaces, the resulting potential $V(\mathbf{r})$ is the UNIQUE exact physical solution!
   - **Point Charge $+q$ at $(0,0,d)$ above Grounded Plane $z = 0$:**
     - Image Charge: $-q$ placed at $(0, 0, -d)$.
     - Potential for $z > 0$: $V(x, y, z) = \frac{q}{4\pi\epsilon_0} \left[ \frac{1}{\sqrt{x^2+y^2+(z-d)^2}} - \frac{1}{\sqrt{x^2+y^2+(z+d)^2}} \right]$.
     - **Induced Surface Charge Density:** $\sigma(x, y) = -\epsilon_0 \left.\frac{\partial V}{\partial z}\right|_{z=0} = -\frac{q d}{2\pi (x^2+y^2+d^2)^{3/2}}$.
     - **Attractive Force on Real Charge:** $F = -\frac{1}{4\pi\epsilon_0} \frac{q^2}{(2d)^2} \hat{\mathbf{z}} = -\frac{1}{4\pi\epsilon_0} \frac{q^2}{4d^2} \hat{\mathbf{z}}$.
2. **Slide 2 (`ordering`):** Provide 5 steps finding the total induced charge $Q_{\text{ind}}$ on the grounded plane: (1) express surface charge density: $\sigma(r) = -\frac{q d}{2\pi (r^2 + d^2)^{3/2}}$ in polar coordinates where $r^2 = x^2 + y^2$, (2) write the total induced charge surface integral: $Q_{\text{ind}} = \int_0^\infty \sigma(r) (2\pi r dr)$, (3) set up integral: $Q_{\text{ind}} = -q d \int_0^\infty \frac{r dr}{(r^2 + d^2)^{3/2}}$, (4) substitute variable $u = r^2 + d^2, du = 2r dr$: $Q_{\text{ind}} = -\frac{q d}{2} \int_{d^2}^\infty u^{-3/2} du$, (5) evaluate antiderivative: $-\frac{qd}{2} [-2 u^{-1/2}]_{d^2}^\infty = qd [0 - (-1/d)] = -q$ (exact mirror charge conservation!)!
3. **Slide 3 (`matching`):** Pair 4 conducting boundary geometries (Single Grounded Infinite Plane, 90° Right-Angle Conducting Corner, Grounded Conducting Sphere (radius $R$), Isolated Neutral Conducting Sphere) with their required image charge configurations.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the total induced surface charge on a grounded infinite conducting plane near charge +q equals negative q (-q). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the image charge for a grounded conducting sphere: For a point charge $+q$ located at distance $d$ from the center of a grounded conducting sphere of radius $R$ ($d > R$), what is the magnitude and position $r'$ of the required image charge? ($q' = -q \frac{R}{d}$ placed at distance $r' = \frac{R^2}{d}$ from the center along the radial line).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "method_of_images_and_boundary_value_problems",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Method of Images and Grounded Conductors**\n• **Method of Images Principle (Lord Kelvin, 1848):**\n  Replace conducting equipotential boundaries ($V = 0$) with fictitious image charges in the unphysical region satisfying boundary conditions.\n• **Point Charge $+q$ at $(0, 0, d)$ above Grounded Plane $z = 0$:**\n  - **Image Charge:** $-q$ located at $(0, 0, -d)$.\n  - **Potential ($z > 0$):**\n$$\nV(x, y, z) = \\frac{q}{4\\pi\\epsilon_0} \\left[ \\frac{1}{\\sqrt{x^2+y^2+(z-d)^2}} - \\frac{1}{\\sqrt{x^2+y^2+(z+d)^2}} \\right]\n$$\n  - **Induced Surface Charge Density:** $\\sigma(x, y) = -\\epsilon_0 \\left.\\frac{\\partial V}{\\partial z}\\right|_{z=0} = -\\frac{q d}{2\\pi (x^2+y^2+d^2)^{3/2}}$.\n  - **Attractive Force:** $\\mathbf{F} = -\\frac{1}{4\\pi\\epsilon_0} \\frac{q^2}{4d^2} \\hat{\\mathbf{z}}$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the integral calculus steps proving the total induced charge on the infinite grounded plane equals -q.",
      "orderItems": [
        "Express induced charge density in polar coordinates: sigma(r) = -q * d / [ 2 pi (r^2 + d^2)^{3/2} ]",
        "Set up total charge surface integral in polar rings: Q_ind = int_0^infinity sigma(r) * (2 pi r dr)",
        "Substitute sigma(r) to cancel 2 pi: Q_ind = -q * d * int_0^infinity r dr / (r^2 + d^2)^{3/2}",
        "Make substitution u = r^2 + d^2 with du = 2r dr: Q_ind = -(q d / 2) * int_{d^2}^infinity u^{-3/2} du",
        "Evaluate the definite integral [ -2 u^{-1/2} ] from d^2 to infinity to conclude Q_ind = -q"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each conducting geometry to its required image charge configuration.",
      "matchPairs": [
        { "left": "Infinite Flat Grounded Plane", "right": "Single image charge -q located at mirror position z = -d" },
        { "left": "90° Conducting Corner (two perpendicular planes)", "right": "Three image charges: -q at (-x, y), -q at (x, -y), and +q at (-x, -y)" },
        { "left": "Grounded Conducting Sphere (radius R)", "right": "Single image charge q' = -q*(R/d) located at distance r' = R^2 / d" },
        { "left": "Isolated Neutral Conducting Sphere (radius R)", "right": "Image charge q' at r' PLUS second image charge q'' = -q' = +q*(R/d) at center" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "When a point charge +q is placed above an infinite grounded conducting plane, the total integrated induced charge Q_ind on the plane equals ___.",
      "blankAnswer": "-q",
      "blankDistractors": ["+q", "0", "-2q"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "For a point charge +q placed at distance d from the center of a grounded conducting sphere of radius R (where d > R), what are the magnitude and position of the image charge?",
      "options": [
        { "text": "Magnitude q' = -q * (R / d) placed at radial distance r' = R² / d from the sphere center on the line connecting the center and charge +q", "isCorrect": true, "explanation": "Correct! Using geometry of similar triangles, placing an image charge of value q' = -q(R/d) at position r' = R^2/d forces the potential to be identically V = 0 at every point on the spherical surface r = R." },
        { "text": "q' = -q placed at r' = R", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "q' = +q placed at the center r' = 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "q' = -q placed at r' = d", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
