# Duofy Reusable Lesson Format: Elemental Microanalysis (EDS/EDX & Moseley's Law)

**Target Topic:** `04_Engineering_and_Technology / 07_Materials_Science_and_Engineering / Nanomaterials_and_Characterization / SEM_TEM_XRD_Characterization`  
**Lesson Format Type:** `energy_dispersive_xray_spectroscopy_eds_analysis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the atomic physics and quantitative analytical procedures of **Energy Dispersive X-ray Spectroscopy (EDS/EDX)**, primary beam inner core electron ionization ($K, L, M$ shells), relaxation of outer shell electrons accompanied by the emission of **Characteristic X-Ray Photons ($K_\alpha, K_\beta, L_\alpha$)**, Henry Moseley's 1913 **Moseley's Law ($\sqrt{\nu} = C (Z - \sigma)$)** linking photon energy directly to atomic number $Z$, Silicon Drift Detectors (SDD), the continuous **Bremsstrahlung Background Radiation**, peak identification, matrix correction algorithms (ZAF: Atomic Number $Z$, Absorption $A$, Fluorescence $F$), and elemental spatial mapping (Joseph I. Goldstein et al. *Scanning Electron Microscopy and X-Ray Microanalysis* 4th ed. Chapters 6, 8, 9; Henry G. J. Moseley 1913): formulate the **Moseley's Law Characteristic X-Ray Energy Master Formulation**:
$$\mathbf{E_{\text{photon}} = h \nu = R_{\infty} \cdot h \cdot c \cdot \left( Z - \sigma \right)^2 \left( \frac{1}{n_1^2} - \frac{1}{n_2^2} \right) \Longleftrightarrow \mathbf{\sqrt{E_{K_\alpha}} \approx C \cdot \left( Z - 1 \right)}}$$
where:
1. **$E_{\text{photon}}$:** Emitted characteristic X-ray energy in kiloelectronvolts ($\text{keV}$);
2. **$Z$:** Atomic number of the target element;
3. **$\sigma \approx 1.0$:** Screening/shielding constant for $K$-shell transitions ($L \to K \implies K_\alpha$);
4. **$C \approx 0.088\text{ keV}^{1/2}$:** Characteristic transition constant;
master the **Characteristic X-Ray Transition Hierarchy**:
$$\begin{array}{|l|l|l|l|}
\hline
\textbf{X-Ray Emission Line} & \textbf{Initial Electron State} & \textbf{Final Core Vacancy} & \textbf{Example Photon Energy} \\
\hline
\mathbf{K_\alpha} & \mathbf{L\text{-shell } (n = 2)} & \mathbf{K\text{-shell } (n = 1)} & \mathbf{\text{Al } K_\alpha = 1.487\text{ keV}, \ \text{Fe } K_\alpha = 6.404\text{ keV}, \ \text{Cu } K_\alpha = 8.048\text{ keV}} \\
\mathbf{K_\beta} & \text{M-shell } (n = 3) & K\text{-shell } (n = 1) & \text{Fe } K_\beta = 7.058\text{ keV}, \ \text{Cu } K_\beta = 8.905\text{ keV} \\
\mathbf{L_\alpha} & \mathbf{\text{M-shell } (n = 3)} & \mathbf{\text{L-shell } (n = 2)} & \mathbf{\text{Ti } L_\alpha = 0.452\text{ keV}, \ \text{Au } L_\alpha = 9.713\text{ keV}, \ \text{Pb } L_\alpha = 10.55\text{ keV}} \\
\text{Bremsstrahlung} & \text{Continuous deceleration} & \text{None (Unbound)} & 0 \to E_0\text{ keV continuum background noise} \\
\hline
\end{array}$$
(proving that measuring discrete X-ray photon energy peaks on an EDS spectrum unambiguously identifies the chemical element and its stoichiometric mass percentage), and interact with live Bragg's law/Scherrer XRD calculator, SEM interaction volume & SE/BSE signal solver, TEM SAED camera constant indexer, and EDS elemental spectrum analyzer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Characteristic X-Rays ($K_\alpha, K_\beta, L_\alpha$), Moseley's Law ($\sqrt{E} \propto Z-1$) & ZAF Correction Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Acquire an EDS Spectrum, Identify Characteristic Peaks, and Apply ZAF Quantification Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | EDS Spectral Entity / Emission Construct & Technical Microanalytical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Smooth Continuous Background Radiation Present in Every EDS Spectrum, Caused by the Inelastic Deceleration of Primary Electrons in the Coulomb Field of Target Nuclei, Is Known as ___ (Bremsstrahlung / Braking Radiation) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Materials Characterization Studio: XRD Bragg/Scherrer, SEM SE/BSE, TEM SAED & EDS Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "energy_dispersive_xray_spectroscopy_eds_analysis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How are characteristic X-rays generated in an electron microscope, and how does Moseley's law enable elemental identification in EDS?",
      "blankAnswer": "EDS Microanalysis \\& Moseley's Law (Goldstein 2018; Moseley 1913): (1) X-RAY GENERATION: High-energy primary electrons ionize inner-shell atomic electrons (e.g. K-shell). An outer-shell electron (L or M shell) drops down to fill the vacancy, releasing a photon whose energy equals the exact quantum energy difference: E_photon = E_L - E_K (K\u03b1 line). (2) MOSELEY'S LAW: \u221a(E_K\u03b1) \u2248 C*(Z - 1). Because each element in the periodic table has a unique atomic number Z, its characteristic emission lines (e.g. Al K\u03b1 = 1.49 keV, Ti K\u03b1 = 4.51 keV, Fe K\u03b1 = 6.40 keV) provide an unambiguous chemical fingerprint for quantitative elemental microanalysis!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to perform quantitative elemental analysis of an alloy specimen using Energy Dispersive X-ray Spectroscopy (EDS).",
      "orderItems": [
        "Select primary electron accelerating voltage E0 sufficiently high to excite target core shells (E0 \u2265 1.5 to 2\u00d7 overvoltage)",
        "Collect emitted X-ray photons using a Silicon Drift Detector (SDD) to construct a histogram of counts versus photon energy (keV)",
        "Subtract the continuous background bremsstrahlung radiation curve across the entire energy spectrum",
        "Identify element-specific characteristic peak centroids (K\u03b1, K\u03b2, L\u03b1) using Moseley's Law reference tables",
        "Apply matrix ZAF correction factors (Atomic Number Z, Absorption A, Fluorescence F) to compute accurate elemental weight percentages"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each EDS Spectral Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "K\u03b1 Characteristic Line", "right": "High-intensity X-ray emission generated when an L-shell (n=2) electron drops into a K-shell (n=1) vacancy" },
        { "left": "Bremsstrahlung Continuum", "right": "Broad background radiation produced by deceleration of primary electrons in nuclear Coulomb fields" },
        { "left": "Silicon Drift Detector (SDD)", "right": "Fast solid-state semiconductor sensor converting single X-ray photons into proportional charge pulses" },
        { "left": "ZAF Matrix Correction", "right": "Mathematical algorithm correcting for electron stopping power (Z), X-ray reabsorption (A), and fluorescence (F)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The smooth continuous background radiation present in every EDS spectrum, caused by the inelastic deceleration of primary electrons in the Coulomb field of target nuclei, is known as ___.",
      "blankAnswer": "bremsstrahlung",
      "blankDistractors": ["fluorescence", "diffraction", "polarization"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Materials Characterization & Nanomaterials Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Materials Characterization & Nanomaterials Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">XRD Bragg/Scherrer, SEM SE/BSE, TEM SAED & EDS Microanalysis</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnXrd\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. XRD & Scherrer (d=0.236nm, \u03c4=14.6nm)</button><button id=\"btnSem\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. SEM (SE Topo vs BSE Z-Contrast)</button><button id=\"btnTem\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. TEM (SAED d=0.236nm) & EDS K\u03b1</button></div><div id=\"matLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate XRD Bragg diffraction and Scherrer broadening...</div><script>document.getElementById('btnXrd').onclick=()=>{document.getElementById('matLog').innerHTML='<b>1. XRD BRAGG\\'S LAW \\& SCHERRER CRYSTALLITE SIZE:</b><br>• Bragg: \\u03bb = 2*d*sin\\u03b8 &rarr; Au (111) at 2\\u03b8=38.2\u00b0 &rarr; <b style=\"color:#10b981;\">d111 = 0.236 nm!</b><br>• Scherrer: \\u03c4 = (K*\\u03bb) / (\\u03b2*cos\\u03b8)<br>• <b style=\"color:#38bdf8;\">Nanocrystal Domain Diameter: \\u03c4 = 14.65 nm!</b>';}; document.getElementById('btnSem').onclick=()=>{document.getElementById('matLog').innerHTML='<b>2. SCANNING ELECTRON MICROSCOPY (SEM):</b><br>• Secondary Electrons (SE < 50 eV): Escape depth < 10 nm &rarr; <b style=\"color:#10b981;\">High-res 3D topography!</b><br>• Backscattered Electrons (BSE): \\u03b7 \\u221d Z<br>• <b style=\"color:#38bdf8;\">Lead (Z=82, \\u03b7=0.50) appears bright white vs Aluminum (Z=13, \\u03b7=0.14) dark grey!</b>';}; document.getElementById('btnTem').onclick=()=>{document.getElementById('matLog').innerHTML='<b>3. TEM SAED DIFFRACTION \\& EDS MICROANALYSIS:</b><br>• 200 kV TEM: \\u03bb = 0.00251 nm | Camera Constant: \\u03bbL = 2.51 mm*nm<br>• SAED Ring: d1 = \\u03bbL / R1 = 2.51 / 10.64 mm = <b style=\"color:#10b981;\">0.236 nm!</b><br>• EDS: Moseley\\'s Law identifies element K\\u03b1 peaks (Al=1.49, Fe=6.40 keV)<br>🏆 <b style=\"color:#10b981;\">07_Materials_Science_and_Engineering (ALL 3 SUBDISCIPLINES / ALL 3 LEAF DIRS) 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
