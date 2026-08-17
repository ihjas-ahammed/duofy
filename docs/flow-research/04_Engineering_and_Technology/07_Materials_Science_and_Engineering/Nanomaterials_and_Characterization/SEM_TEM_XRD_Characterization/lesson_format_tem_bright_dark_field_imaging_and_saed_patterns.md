# Duofy Reusable Lesson Format: Transmission Electron Microscopy (TEM & SAED Patterns)

**Target Topic:** `04_Engineering_and_Technology / 07_Materials_Science_and_Engineering / Nanomaterials_and_Characterization / SEM_TEM_XRD_Characterization`  
**Lesson Format Type:** `tem_bright_dark_field_imaging_and_saed_patterns`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the quantum mechanics and electron crystallography of Transmission Electron Microscopy (TEM), relativistic de Broglie electron wavelength calculation ($\lambda \approx 0.00251\text{ nm}$ at $200\text{ kV}$), the requirement for ultra-thin electron-transparent foils ($t < 100\text{ nm}$), the formation of **Bright-Field (BF)** images (direct unscattered beam selection via objective aperture, mass-thickness and diffraction contrast), **Dark-Field (DF)** images (selection of a specific diffracted Bragg beam $(hkl)$), and **Selected Area Electron Diffraction (SAED)** ring and spot pattern indexing using the **Camera Constant Equation ($R \cdot d_{hkl} = \lambda L$)** (David B. Williams, C. Barry Carter *Transmission Electron Microscopy: A Textbook for Materials Science* 2nd ed. Chapters 9, 18, 22; William D. Callister Jr. *Materials Science and Engineering* Chapter 4): formulate the **Relativistic de Broglie Electron Wavelength Formulation**:
$$\mathbf{\lambda = \frac{h}{\sqrt{2 m_0 e V \left( 1 + \frac{e V}{2 m_0 c^2} \right)}} \approx \frac{1.226}{\sqrt{V \left( 1 + 0.978 \times 10^{-6} V \right)}} \quad [\text{nm}]}$$
at $V = 200\text{ kV} \implies \lambda = \mathbf{0.002508\text{ nm} = 0.02508\text{ Å}}$ (enabling sub-angstrom atomic lattice resolution in HRTEM);
derive the **Selected Area Electron Diffraction (SAED) Camera Constant Master Formulation**:
$$\mathbf{R \cdot d_{hkl} = \lambda \cdot L \Longleftrightarrow \mathbf{d_{hkl} = \frac{\lambda L}{R} \quad [\text{nm} \text{ or } \text{Å}]}}$$
where:
1. **$R$:** Measured ring or spot radius on the diffraction pattern ($\text{mm}$ or $\text{cm}$);
2. **$d_{hkl}$:** Interplanar atomic crystal spacing ($\text{nm}$ or $\text{Å}$);
3. **$\lambda L$:** Effective instrument camera constant ($\text{mm}\cdot\text{nm}$ or $\text{mm}\cdot\text{Å}$, where $L$ is the camera length);
master the **TEM Imaging Contrast Modes Matrix**:
$$\begin{array}{|l|l|l|l|}
\hline
\textbf{TEM Imaging Mode} & \textbf{Objective Aperture Position} & \textbf{Contrast Mechanism} & \textbf{Visual Appearance} \\
\hline
\mathbf{\text{Bright-Field (BF)}} & \mathbf{\text{Centered on Direct Beam } (000)} & \mathbf{\text{Mass-thickness \& Diffraction contrast}} & \mathbf{\text{Heavy / crystalline regions appear dark}} \\
\mathbf{\text{Dark-Field (DF)}} & \mathbf{\text{Shifted to Diffracted Beam } (\vec{g})} & \mathbf{\text{Specific Bragg reflection selection}} & \mathbf{\text{Only grains matching } \vec{g} \text{ shine bright}} \\
\mathbf{\text{High-Resolution (HRTEM)}} & \text{Large aperture enclosing multiple beams} & Phase contrast (interference of beams) & Atomic column lattice fringes \\
\mathbf{\text{SAED Diffraction Mode}} & \text{Projected onto back focal plane} & Fourier transform of crystal lattice & Spot grid (single crystal) / Rings (polycrystalline) \\
\hline
\end{array}$$
(proving that switching between Bright-Field, Dark-Field, and SAED modes allows materials scientists to correlate single-nanoparticle atomic orientation with spatial morphology).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Relativistic Wavelength ($\lambda = 0.00251\text{ nm}$), Bright vs Dark Field & SAED ($R \cdot d = \lambda L$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Index an SAED Ring Pattern and Calculate Interplanar Spacings Using the Camera Constant Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | TEM Optical Element / Diffraction Pattern Construct & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Transmission Electron Microscopy, an Image Formed by Inserting the Objective Aperture to Transmit Only a Specific Diffracted Bragg Beam Is Termed a ___-Field Image (Dark / Dark-Field) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Nanocrystal Diffraction Problem: Calculating Interplanar d-Spacing from a 200 kV TEM SAED Ring Pattern Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State TEM Optics & Diffraction Mechanics (Williams & Carter 2009; Callister 2020):
   - **Diffraction Formulations:**
     $$\mathbf{R \cdot d_{hkl} = \lambda L \quad \Big| \quad \lambda_{\text{200kV}} = 0.002508\text{ nm} \quad \Big| \quad \lambda_{\text{300kV}} = 0.001969\text{ nm} \quad \Big| \quad d_{hkl} = \frac{\lambda L}{R}}$$
   - **Electron Diffraction vs X-Ray Diffraction Invariant:**
     - Electrons have wavelengths $\sim 100\times$ shorter than X-rays ($\lambda_{\text{electron}} \approx 0.0025\text{ nm}$ vs $\lambda_{\text{Cu K}\alpha} \approx 0.154\text{ nm}$), making the **Ewald sphere radius ($1/\lambda$) nearly flat**, allowing many Bragg reflections $(hkl)$ to diffract simultaneously in a single zone-axis orientation!
2. **Slide 2 (`ordering`):** Provide 5 steps of SAED ring indexing: (1) insert selected area aperture around region of interest and switch microscope to diffraction mode, (2) record diffraction ring pattern on high-resolution CCD/CMOS camera, (3) measure ring radii $R_1, R_2, R_3$ in millimeters from the central unscattered spot, (4) apply camera constant equation: $d_i = (\lambda L) / R_i$, (5) match calculated $d$-spacings against standard crystallographic database to identify phase and index Miller indices $(hkl)$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Bright-Field BF, Dark-Field DF, SAED Camera Constant $\lambda L$, HRTEM Lattice Fringes) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Dark (or Dark-Field). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating $d$-spacing from SAED: A $200\text{ kV}$ TEM ($\lambda = 0.00251\text{ nm}$) operates at effective camera length $L = 1000.0\text{ mm}$, giving camera constant $\lambda L = 0.00251\text{ nm} \times 1000.0\text{ mm} = \mathbf{2.510\text{ mm}\cdot\text{nm}} = 25.10\text{ mm}\cdot\text{Å}$. On a polycrystalline nanoparticle SAED ring pattern, the inner first ring has measured radius $R_1 = 10.64\text{ mm}$.
   - Interplanar spacing $d_1$:
     $d_1 = \frac{\lambda L}{R_1} = \frac{2.510\text{ mm}\cdot\text{nm}}{10.64\text{ mm}} = \mathbf{0.23590\text{ nm} \approx 0.236\text{ nm} = 2.36\text{ Å}}$ (corresponds to Au $(111)$ planes);
   - What is the interplanar crystal spacing $d_1$ corresponding to this diffraction ring? ($d_1 = \mathbf{0.236\text{ nm} \ (2.36\text{ Å})}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "tem_bright_dark_field_imaging_and_saed_patterns",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: TEM Electron Optics \\& SAED Diffraction (Williams \\& Carter)**\n• **Relativistic de Broglie Wavelength Formulation:**\n$$\n\\mathbf{\\lambda = \\frac{1.226}{\\sqrt{V \\left( 1 + 0.978 \\times 10^{-6} V \\right)}} \\quad [\\text{nm}] \\implies \\lambda_{\\text{200 kV}} = \\mathbf{0.00251\\text{ nm} = 0.0251\\text{ Å}}}\n$$\n• **Selected Area Electron Diffraction (SAED) Camera Constant Formulation:**\n$$\n\\mathbf{R \\cdot d_{hkl} = \\lambda \\cdot L \\Longleftrightarrow d_{hkl} = \\frac{\\lambda L}{R} \\quad [\\text{nm} \\text{ or } \\text{Å}]}\n$$\n  - **$R$:** Radius of diffracted ring or spot from the central beam ($\\text{mm}$);\n  - **$\\lambda L$:** Instrument effective camera constant ($\\text{mm}\\cdot\\text{nm}$);\n• **TEM Imaging Contrast Modes:**\n  - **Bright-Field (BF):** Transmits only the unscattered direct beam; dense or crystalline areas that scatter electrons appear dark;\n  - **Dark-Field (DF):** Selects a specific diffracted Bragg reflection ($\\vec{g}$); only grains oriented at that specific Bragg angle shine bright;\n• **The Flat Ewald Sphere Invariant:** Because 200 kV electron wavelengths are ultra-short ($\\lambda \\approx 0.0025\\text{ nm}$), the **Ewald sphere radius ($1/\\lambda$) is virtually flat**, illuminating an entire planar slice of the reciprocal lattice simultaneously!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to index a Selected Area Electron Diffraction (SAED) ring pattern of a polycrystalline nanomaterial.",
      "orderItems": [
        "Position the selected area aperture over the region of interest in image mode and switch microscope to diffraction mode",
        "Record the concentric circular SAED ring pattern centered on the direct unscattered transmitted beam spot",
        "Measure the radius R of each concentric diffraction ring from the pattern center in millimeters",
        "Apply the camera constant formula to calculate interplanar d-spacings: d_hkl = (\u03bb * L) / R",
        "Compare calculated d-spacings against crystallographic reference database to identify the crystal structure and index (hkl) planes"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each TEM Operation Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Bright-Field Imaging (BF)", "right": "Objective aperture centered on unscattered direct beam where heavy or diffractive regions appear dark" },
        { "left": "Dark-Field Imaging (DF)", "right": "Objective aperture shifted to isolate a specific diffracted beam (\u2192g), illuminating only diffracting crystallites" },
        { "left": "Camera Constant (\u03bbL)", "right": "Product of electron wavelength and camera length converting real-space pattern radii to reciprocal d-spacings" },
        { "left": "HRTEM Lattice Fringes", "right": "Phase contrast interference formed by combining transmitted and multiple diffracted beams at sub-angstrom resolution" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Transmission Electron Microscopy, an image formed by inserting the objective aperture to transmit only a specific diffracted Bragg beam is termed a ___-field image.",
      "blankAnswer": "dark",
      "blankDistractors": ["bright", "wide", "phase"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 200 kV TEM (\u03bb = 0.00251 nm) with camera length L = 1000.0 mm has camera constant \u03bbL = 2.510 mm*nm (25.10 mm*\u00c5). On an SAED ring pattern of gold nanoparticles, the innermost ring has radius R1 = 10.64 mm. What is the interplanar d-spacing d1 corresponding to this diffraction ring?",
      "options": [
        { "text": "d1 = 0.236 nm (2.36 \u00c5) (d1 = \u03bbL / R1 = 2.510 mm*nm / 10.64 mm = 0.2359 nm \u2248 0.236 nm, corresponding to Au (111) planes)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the TEM camera constant equation for Selected Area Electron Diffraction (David B. Williams & C. Barry Carter *Transmission Electron Microscopy: A Textbook for Materials Science* Chapter 18). 1. **Identify Instrument Parameters \\& Camera Constant:** - Electron accelerating voltage: $V = 200\\text{ kV} \\implies \\lambda = 0.00251\\text{ nm}$. - Camera length: $L = 1000.0\\text{ mm}$. - Instrument camera constant: $$\\lambda L = 0.00251\\text{ nm} \\times 1000.0\\text{ mm} = \\mathbf{2.510\\text{ mm}\\cdot\\text{nm} = 25.10\\text{ mm}\\cdot\\text{Å}}$$ 2. **Calculate Interplanar Spacing ($d_1$):** - Measured ring radius: $R_1 = 10.64\\text{ mm}$. - Applying the camera constant formula: $$R_1 \\cdot d_1 = \\lambda L \\implies d_1 = \\frac{\\lambda L}{R_1}$$ $$d_1 = \\frac{2.510\\text{ mm}\\cdot\\text{nm}}{10.64\\text{ mm}} = \\mathbf{0.235902\\text{ nm} = 2.3590\\text{ Å} \\approx 0.236\\text{ nm} \\ (2.36\\text{ Å})}$$ - Notice that this $d$-spacing matches the $(111)$ interplanar spacing of FCC Gold ($d_{111} = 0.2356\\text{ nm}$) perfectly! Flawless TEM SAED camera constant derivation!" },
        { "text": "d1 = 0.472 nm (Multiplied by 2 erroneously)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "d1 = 26.7 nm (Multiplied \u03bbL * R1 instead of dividing)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "d1 = 0.025 nm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
