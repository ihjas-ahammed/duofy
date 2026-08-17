# Duofy Reusable Lesson Format: Radial Velocity Method and Doppler Wobble

**Target Topic:** `02_Physical_and_Life_Sciences / 08_Astronomy_and_Space_Science / Planetary_Science_and_Astrobiology / Solar_System_Dynamics_Exoplanets`  
**Lesson Format Type:** `radial_velocity_method_and_doppler_wobble`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the barycentric mechanics, Doppler spectroscopy, and orbital parameter extraction of the Radial Velocity (RV) exoplanet detection method (Michel Mayor & Didier Queloz 1995/2019 Nobel Prize in Physics; Debra Fischer; Paul Butler): analyze the **Two-Body Barycenter Problem** (both star and planet orbit a common center of mass), formulate the **Stellar RV Semi-Amplitude Equation ($K = \left(\frac{2\pi G}{P}\right)^{1/3} \frac{M_p \sin i}{(M_\star + M_p)^{2/3} \sqrt{1 - e^2}}$)**, understand why RV measurements yield only the **Minimum Planet Mass ($M_p \sin i$)** due to unknown orbital inclination ($i$), evaluate the historical discovery of **51 Pegasi b** (the first exoplanet around a main-sequence star, a "Hot Jupiter" orbiting in $4.2\text{ days}$ inducing $K \approx 56\text{ m/s}$), compare with the Sun's reflex wobble induced by Jupiter ($K_{\text{Jup}} \approx 12.5\text{ m/s}$) and Earth ($K_{\text{Earth}} \approx 9\text{ cm/s}$), and evaluate high-precision spectrographs (HARPS, ESPRESSO).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Barycentric Reflex Motion & RV Semi-Amplitude K Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Exoplanet Orbit to Stellar Doppler Spectrum Shift Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Radial Velocity Parameter / Planet Type & Physical Trait Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Unknown Geometric Angle Parameter Determining Minimum Mass in RV Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Astrophysical Reason Hot Jupiters are Vastly Easier to Detect via RV Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State The Radial Velocity Method (Mayor & Queloz 1995; Nobel 2019):
   - **Barycentric Reflex Motion:**
     - A planet of mass $M_p$ and star of mass $M_\star$ orbit their mutual center of mass (barycenter):
       $$a_\star M_\star = a_p M_p \implies v_\star = v_p \left(\frac{M_p}{M_\star}\right)$$
   - **The Stellar RV Semi-Amplitude ($K$):**
     $$\mathbf{K = \left(\frac{2\pi G}{P}\right)^{1/3} \frac{M_p \sin i}{(M_\star + M_p)^{2/3} \sqrt{1 - e^2}} \approx \left(\frac{28.4\text{ m/s}}{\sqrt{1 - e^2}}\right) \left(\frac{M_p \sin i}{M_{\text{Jup}}}\right) \left(\frac{M_\star}{M_\odot}\right)^{-2/3} \left(\frac{P}{1\text{ yr}}\right)^{-1/3}}$$
     - **The $\sin i$ Degeneracy:** RV only measures the line-of-sight velocity component $\implies$ Yields the **Minimum Mass ($M_p \sin i$)**!
   - **Reflex Velocity Benchmarks:**
     - **51 Pegasi b ($P = 4.23\text{ d}, M_p \sin i = 0.47\ M_{\text{Jup}}$):** $\mathbf{K \approx 56\text{ m/s}}$ (Discovered 1995!).
     - **Jupiter on Sun ($P = 11.86\text{ yr}$):** $\mathbf{K \approx 12.5\text{ m/s}}$.
     - **Earth on Sun ($P = 1.0\text{ yr}$):** $\mathbf{K \approx 9\text{ cm/s}}$ (Extreme challenge requiring ultra-stable spectrographs!).
2. **Slide 2 (`ordering`):** Provide 5 steps of the radial velocity detection cycle over one complete orbital period: (1) an unseen giant exoplanet swings toward the observer along its orbit, tugging the host star away from Earth, (2) the star's light waves are stretched to longer wavelengths, creating a maximum redshift in its absorption lines on the spectrograph, (3) the planet crosses the line of sight (conjunction), where stellar velocity perpendicular to the observer produces zero Doppler shift, (4) the planet travels away from Earth, pulling the host star toward the observer and creating a maximum blueshift, (5) fitting a Keplerian orbital curve to the periodic sinusoidal velocity variations yields the planet's orbital period (P), eccentricity (e), and minimum mass (Mp sin i)!
3. **Slide 3 (`matching`):** Pair 4 RV parameters/targets (Semi-Amplitude K, Inclination Angle i, 51 Pegasi b, Earth Reflex Velocity) with their quantitative/physical roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the unknown orbital angle responsible for the minimum mass degeneracy in radial velocity measurements is inclination. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the physical scaling of radial velocity semi-amplitude $K$: Why were massive, close-in "Hot Jupiters" (like 51 Pegasi b) the very first exoplanets discovered by radial velocity spectrographs in the 1990s, while Earth-like planets remained completely undetectable? (Because the stellar reflex semi-amplitude scales as $K \propto M_p \cdot P^{-1/3}$; a massive planet ($M_p \approx 1\ M_{\text{Jup}}$) in an ultra-short orbit ($P \approx 4\text{ days}$) induces a **huge stellar wobble of $K \approx 50-100\text{ m/s}$ easily detected by early spectrographs**, whereas an Earth-mass planet at $1\text{ AU}$ induces a **microscopic wobble of only $9\text{ cm/s}$, which was hundreds of times below the instrumental noise floor**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "radial_velocity_method_and_doppler_wobble",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Radial Velocity Method (Mayor \\& Queloz 1995)**\n• **Barycentric Reflex Motion:** Both star and planet orbit a mutual center of mass ($a_\\star M_\\star = a_p M_p$).\n• **The Stellar RV Semi-Amplitude ($K$):**\n$$\n\\mathbf{K = \\left(\\frac{2\\pi G}{P}\\right)^{1/3} \\frac{M_p \\sin i}{M_\\star^{2/3} \\sqrt{1 - e^2}} \\approx 28.4\\text{ m/s} \\left(\\frac{M_p \\sin i}{M_{\\text{Jup}}}\\right) \\left(\\frac{M_\\star}{M_\\odot}\\right)^{-2/3} \\left(\\frac{P}{1\\text{ yr}}\\right)^{-1/3}}\n$$\n• **The $\\sin i$ Inclination Ambiguity:** RV yields **Minimum Mass ($M_p \\sin i$)** (true mass $M_p$ if edge-on $i=90^\\circ$).\n• **Reflex Velocity Benchmarks:**\n  - **51 Pegasi b (Hot Jupiter, $P=4.2\\text{ d}$):** $\\mathbf{K = 56\\text{ m/s}}$ (Nobel Prize 2019)!\n  - **Jupiter on Sun ($P=11.8\\text{ yr}$):** $K = 12.5\\text{ m/s}$.\n  - **Earth on Sun ($P=1.0\\text{ yr}$):** $\\mathbf{K = 0.09\\text{ m/s} \\ (9\\text{ cm/s})}$ (Requires ultra-stable HARPS/ESPRESSO)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential observational steps of the Doppler reflex cycle across one exoplanetary orbit.",
      "orderItems": [
        "The exoplanet orbits toward Earth, gravitationally pulling the host star away from our line of sight",
        "The star reaches maximum receding velocity, producing maximum Doppler redshift in stellar absorption lines",
        "The planet passes conjunction, aligning velocity perpendicular to Earth and yielding zero line-of-sight Doppler shift",
        "The exoplanet moves away from Earth, pulling the host star toward us to produce maximum Doppler blueshift",
        "A Keplerian velocity curve is fitted to the periodic shifts, solving for orbital period (P) and minimum mass (Mp sin i)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each radial velocity parameter to its exact astronomical role.",
      "matchPairs": [
        { "left": "Semi-Amplitude (K)", "right": "Peak line-of-sight velocity variation of the host star measured in meters per second" },
        { "left": "Inclination Angle (i)", "right": "Tilt of the orbital plane relative to the sky plane determining the minimum mass projection" },
        { "left": "51 Pegasi b", "right": "First discovered exoplanet around a main-sequence star orbiting in 4.2 days with K = 56 m/s" },
        { "left": "Earth's Reflex Velocity", "right": "Extremely small 9 cm/s velocity wobble induced on the Sun over a 1-year period" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In radial velocity exoplanet spectroscopy, the unknown orbital parameter angle that prevents measuring true mass without transits is ___.",
      "blankAnswer": "inclination",
      "blankDistractors": ["eccentricity", "longitude", "anomaly"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why were massive 'Hot Jupiters' with orbital periods of only 3 to 5 days the very first exoplanets discovered via radial velocity spectroscopy in 1995, while true Earth analogs remained undetected for decades?",
      "options": [
        { "text": "The stellar reflex semi-amplitude scales directly with planet mass and inversely with the cube root of orbital period (K proportional to Mp * P^(-1/3)); a Jupiter-mass planet orbiting in 4 days exerts a huge gravitational torque inducing a massive stellar wobble of K ≈ 50 to 100 m/s easily detected by 1990s spectrographs, whereas an Earth-mass planet at 1 AU produces an ultra-tiny wobble of only 9 cm/s requiring sub-meter precision", "isCorrect": true, "explanation": "Correct! The physics of Doppler reflex motion dictates the observational selection bias of the radial velocity method. The velocity semi-amplitude of the host star is given by K ∝ (M_p * sin(i)) / (M_star^(2/3) * P^(1/3)). Because K is directly proportional to planet mass (M_p) and inversely proportional to the cube root of orbital period (P^(1/3)), massive planets orbiting extremely close to their host stars produce the largest possible stellar wobbles. For 51 Pegasi b (discovered by Mayor and Queloz in 1995), a planet half the mass of Jupiter orbiting at just 0.05 AU with a period of 4.2 days whipped its host star back and forth at 56 meters per second (125 mph)—a large signal that was easily measurable with the ELODIE spectrograph (which had a precision of ~10-15 m/s). In contrast, an Earth-mass planet orbiting a Sun-like star at 1.0 AU (P = 365 days) induces a microscopic stellar wobble of only 0.09 meters per second (9 centimeters per second, or a slow turtle crawl!). Detecting a 9 cm/s signal requires cryogenic, vacuum-stabilized, laser-frequency-comb calibrated spectrographs like ESPRESSO on the VLT, which were only developed decades later." },
        { "text": "Because Hot Jupiters are the only planets that have gravity", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Earth-like planets do not orbit stars", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because spectrographs could only see yellow light in 1995", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
