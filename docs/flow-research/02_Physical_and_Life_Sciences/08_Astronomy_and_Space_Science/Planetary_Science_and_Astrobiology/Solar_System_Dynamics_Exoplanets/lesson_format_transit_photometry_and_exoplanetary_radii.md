# Duofy Reusable Lesson Format: Transit Photometry and Exoplanetary Radii

**Target Topic:** `02_Physical_and_Life_Sciences / 08_Astronomy_and_Space_Science / Planetary_Science_and_Astrobiology / Solar_System_Dynamics_Exoplanets`  
**Lesson Format Type:** `transit_photometry_and_exoplanetary_radii`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the geometric probability, light-curve morphology, and physical parameter extraction of the Transit Photometry exoplanet discovery technique (David Charbonneau 2000; William Borucki / NASA Kepler Mission; George Ricker / NASA TESS): master the fundamental **Transit Depth Equation ($\delta = \frac{\Delta F}{F} = \left(\frac{R_p}{R_\star}\right)^2$)** establishing that transit depth measures planetary physical cross-sectional area and radius ($R_p$), calculate **Geometric Transit Probability ($P_{\text{transit}} \approx \frac{R_\star + R_p}{a} \approx \frac{R_\star}{a}$)**, analyze **Transit Duration ($T_{\text{dur}} \approx \frac{P}{\pi} \frac{R_\star}{a} \sqrt{1 - b^2}$)** and the **Impact Parameter ($b = \frac{a \cos i}{R_\star}$)**, evaluate the role of **Stellar Limb Darkening** in rounding the bottom of light curves, and demonstrate how combining Transit ($R_p$) + Radial Velocity ($M_p$) yields true **Mean Planetary Density ($\bar{\rho} = \frac{M_p}{\frac{4}{3}\pi R_p^3}$)** to differentiate dense rocky Super-Earths from puffy volatile Sub-Neptunes across the **Fulton Radius Gap ($\sim 1.7-1.8\ R_\oplus$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Transit Depth Equation, Light Curve Geometry, & Fulton Gap Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Exoplanet Transit Light Curve Phases (Ingress to Egress) Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Transit Light Curve Parameter / Phase & Physical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Transit Depth Percentage Dip Produced by an Earth-Sized Planet Transiting the Sun Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Calculation of Exoplanet Radius Rp from a Measured 1% Transit Depth Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Transit Photometry & Exoplanet Radii (Charbonneau 2000; Borucki / Kepler 2009):
   - **The Transit Depth Equation ($\delta$):**
     $$\mathbf{\delta = \frac{\Delta F}{F} = \left(\frac{R_p}{R_\star}\right)^2 \iff R_p = R_\star \sqrt{\delta}}$$
     - **Jupiter on Sun ($R_p \approx 0.1\ R_\odot$):** $\delta \approx (0.1)^2 = 1\% = 0.01 \ (10,000\text{ ppm})$.
     - **Earth on Sun ($R_p \approx 0.00915\ R_\odot$):** $\delta \approx (0.00915)^2 \approx 8.4 \times 10^{-5} \approx \mathbf{0.0084\% \ (84\text{ ppm})}$.
   - **Geometric Transit Probability & Duration:**
     $$\mathbf{P_{\text{transit}} \approx \frac{R_\star}{a} \qquad T_{\text{dur}} \approx \frac{P}{\pi} \frac{R_\star}{a} \sqrt{1 - b^2} \qquad \left(b = \frac{a \cos i}{R_\star} \le 1\right)}$$
   - **The Fulton Radius Gap (Benjamin Fulton 2017):**
     - Bimodal radius distribution of close-in small exoplanets:
       - **Super-Earths ($R_p < 1.5\ R_\oplus$):** Stripped bare rocky cores (density $\rho \approx 5-8\text{ g/cm}^3$).
       - **Sub-Neptunes ($R_p > 2.0\ R_\oplus$):** Retain $\text{H}_2/\text{He}$ volatile gas envelopes.
       - The valley at **$1.7-1.8\ R_\oplus$** is created by stellar photoevaporation / core-powered mass loss!
2. **Slide 2 (`ordering`):** Provide 5 steps of an exoplanetary transit light curve: (1) first contact (t1) where the leading edge of the planet disk touches the outer limb of the star, beginning ingress, (2) second contact (t2) where the planet is fully silhouetted inside the stellar disk, completing ingress, (3) mid-transit (t_mid) where the planet reaches the center of the stellar chord, displaying flat or limb-darkened maximum flux reduction, (4) third contact (t3) where the leading edge of the planet touches the opposite limb of the star, initiating egress, (5) fourth contact (t4) where the trailing edge of the planet clears the stellar disk, restoring normalized baseline starlight!
3. **Slide 3 (`matching`):** Pair 4 transit concepts (Transit Depth (Rp/R*)^2, Impact Parameter b, Limb Darkening, Fulton Radius Gap) with their physical meanings.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that an Earth-sized planet transiting a Sun-like star produces a tiny flux drop of approximately 84 parts per million (0.01 percent). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating planetary radius from transit depth: A space telescope monitors a Sun-like star ($R_\star = 700,000\text{ km} \approx 1.0\ R_\odot$) and records a periodic flat-bottomed transit dip with a fractional depth of $\frac{\Delta F}{F} = 0.01$ (or $1\%$). What is the physical radius of the orbiting exoplanet ($R_p$) in kilometers and in Jupiter radii ($R_{\text{Jup}} \approx 70,000\text{ km}$)? ($R_p = R_\star \sqrt{\Delta F / F} = 700,000\text{ km} \times \sqrt{0.01} = 700,000 \times 0.1 = \mathbf{70,000\text{ km} = 1.0\ R_{\text{Jup}}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "transit_photometry_and_exoplanetary_radii",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Transit Photometry & Exoplanet Radii**\n• **The Master Transit Depth Formula:**\n$$\n\\mathbf{\\delta = \\frac{\\Delta F}{F} = \\left(\\frac{R_p}{R_\\star}\\right)^2 \\iff R_p = R_\\star \\sqrt{\\delta}}\n$$\n  - **Jupiter on Sun ($R_p = 0.1 R_\\odot$):** $\\delta = 1\\% \\ (0.01 = 10,000\\text{ ppm})$.\n  - **Earth on Sun ($R_p = 0.01 R_\\odot$):** $\\mathbf{\\delta \\approx 0.01\\% \\ (84\\text{ ppm})}$ (Kepler precision!).\n• **Geometric Transit Probability:** $\\mathbf{P_{\\text{transit}} \\approx \\frac{R_\\star}{a}}$ ($0.5\\%$ for Earth at $1\\text{ AU}$; $10\\%$ for Hot Jupiters at $0.05\\text{ AU}$).\n• **The Fulton Radius Valley ($1.7\\text{--}1.8 R_\\oplus$):** Photoevaporation strips atmospheres, dividing small planets into **Rocky Super-Earths** ($<1.5 R_\\oplus$) and **Puffy Sub-Neptunes** ($>2.0 R_\\oplus$)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential contact points and geometric phases of an exoplanet transit light curve.",
      "orderItems": [
        "First Contact (t1): The planet's leading limb touches the stellar disk, initiating the ingress brightness decline",
        "Second Contact (t2): The planet disk is completely enclosed within the stellar silhouette, completing ingress",
        "Mid-Transit (t_mid): The planet crosses the stellar meridian, reaching maximum flux absorption (limb-darkened trough)",
        "Third Contact (t3): The planet's leading limb reaches the opposite stellar edge, beginning egress brightness recovery",
        "Fourth Contact (t4): The trailing limb of the planet completely clears the stellar disk, restoring baseline flux"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each transit photometric parameter to its physical definition.",
      "matchPairs": [
        { "left": "Transit Depth (delta = (Rp/R*)^2)", "right": "Fractional drop in stellar flux directly measuring the ratio of planet to star surface areas" },
        { "left": "Impact Parameter (b = a*cos(i) / R*)", "right": "Projected minimum sky distance between planet center and stellar disk center in stellar radii" },
        { "left": "Stellar Limb Darkening", "right": "Temperature gradient in stellar photospheres that creates a rounded, curved transit floor" },
        { "left": "Fulton Radius Gap (1.75 R_Earth)", "right": "Empirical depletion of exoplanets caused by atmospheric photoevaporation stripping gaseous envelopes" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "An Earth-sized planet transiting across a Sun-like star produces a tiny fractional drop in starlight brightness of approximately ___ parts per million (ppm).",
      "blankAnswer": "84",
      "blankDistractors": ["10000", "500", "50000"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A high-precision space telescope observing a Sun-like star (R_star = 700,000 km) measures a periodic transit light curve with a fractional flux depth of delta = 0.01 (exactly 1.0%). What is the physical radius of the orbiting exoplanet?",
      "options": [
        { "text": "Rp = 70,000 km (approximately 1.0 Jupiter radius); calculated as Rp = R_star * sqrt(delta) = 700,000 km * sqrt(0.01) = 700,000 * 0.1 = 70,000 km, revealing the discovery of a gas giant planet comparable in size to Jupiter", "isCorrect": true, "explanation": "Correct! The fundamental relationship in transit photometry states that the fractional dip in stellar brightness (delta = Delta F / F) equals the ratio of the cross-sectional area of the planet's circular disk to the cross-sectional area of the star's circular disk: delta = (pi * R_p^2) / (pi * R_star^2) = (R_p / R_star)^2. Solving for the radius of the planet R_p: R_p = R_star * sqrt(delta). Substituting the given values: R_p = 700,000 km * sqrt(0.01) = 700,000 km * 0.1 = 70,000 km. Because Jupiter's volumetric radius is approximately 69,911 km (~70,000 km), this 1% transit depth proves that the transiting object is a Jupiter-sized gas giant planet." },
        { "text": "Rp = 7,000 km because 700,000 multiplied by 0.01 is 7,000", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Rp = 700,000 km because the planet must be the exact same size as the star", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Rp = 49,000 km because you square 700", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
