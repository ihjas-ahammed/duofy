/* ═══════════════════ MODEL PAPERS & CLOSE ═══════════════════ */

/* ── Model Paper 1 ── */
STATIONS.push({
  id: 'test-1',
  mod: 'Model Tests', modName: 'Sit the paper', modClass: 'm3',
  title: 'Model Examination Paper I (Theory & Concepts)',
  short: 'Model Paper 1',
  est: '~60 min',
  body: H`
${gist('Sit this paper closed-book against the clock. Tap each model answer to grade your script; star (☆) any question you want to review in Bookmarks.')}

${paper('MATERIALS SCIENCE — Model Examination Paper I', '2 Hours', '60 Marks')}

${secband('A', 'Short Answer Questions · Answer all questions · 2 marks each')}

${qa('2 m', '1. Define materials science and materials engineering and distinguish between them.',
  `<p><b>Materials Science</b> investigates the relationships between the internal structures and properties of materials (fundamental cause-and-effect science).</p>
   <p><b>Materials Engineering</b> designs or alters structure to produce a predetermined set of properties that achieve target performance in an engineering component.</p>`)}

${qa('2 m', '2. State Bragg’s law of X-ray diffraction and define each variable.',
  `<p>Bragg’s law for constructive interference from parallel crystal planes is:</p>
   $$n\\lambda = 2d_{hkl} \\sin\\theta$$
   <p>where $n$ is the reflection order ($1, 2, \\dots$), $\\lambda$ is the X-ray wavelength, $d_{hkl}$ is interplanar lattice spacing, and $\\theta$ is the Bragg diffraction angle.</p>`)}

${qa('2 m', '3. Why are covalent solids generally less dense than metallic solids?',
  `<p>Metallic bonding is nondirectional, allowing atoms to pack like hard spheres with high coordination numbers (CN = 12 in FCC/HCP, packing factor $0.74$). Covalent bonds are directional (constrained by hybrid orbital angles like $109.5^{\\circ}$ in $sp^3$), restricting coordination numbers to 4 (e.g. diamond packing factor $0.34$), resulting in an open, hollow crystal framework with low density.</p>`)}

${qa('2 m', '4. State the Hume-Rothery rules for complete substitutional solid solubility.',
  `<ol>
     <li>Atomic size difference $\\Delta r = |r_1 - r_2|/r_1 \\le 15\\%$.</li>
     <li>Same crystal structure for both solute and solvent.</li>
     <li>Similar electronegativities (to prevent intermetallic compound formation).</li>
     <li>Similar valence (a metal dissolves another metal of higher valence more readily).</li>
   </ol>`)}

${qa('2 m', '5. Define Burgers vector and state its geometric orientation relative to edge and screw dislocation lines.',
  `<p>The <b>Burgers vector $\\mathbf{b}$</b> specifies the magnitude and direction of the lattice distortion created by a dislocation:</p>
   <ul>
     <li>For an <b>edge dislocation</b>: $\\mathbf{b} \\perp \\mathrm{dislocation~line}$ (perpendicular).</li>
     <li>For a <b>screw dislocation</b>: $\\mathbf{b} \\parallel \\mathrm{dislocation~line}$ (parallel).</li>
   </ul>`)}

${qa('2 m', '6. Why does liquid water expand by approximately 9% upon freezing into ice?',
  `<p>In liquid water, molecules are disordered with an average coordination of $\\sim 4.5$ neighbors. In ice $I_h$, each oxygen molecule is forced into four rigid tetrahedral hydrogen bonds, forming an open hexagonal cage network with coordination of exactly $4.0$. This open cage creates hollow channels, increasing volume by $\\approx 9\\%$ and lowering density to $0.917\\mathrm{~g/cm}^3$.</p>`)}

${secband('B', 'Descriptive & Problem Questions · Answer any 4 questions · 5 marks each')}

${qa('5 m', '7. Explain the physical origin of melting point, elastic modulus, and thermal expansion from the potential energy well curve.',
  `<p>From the interatomic potential energy curve $E_N(r) = E_A(r) + E_R(r)$:</p>
   <ol>
     <li><b>Melting Point ($T_m$):</b> Governed by the <b>depth of the energy well ($E_0$)</b>. $E_0$ is the energy required to pull atoms apart to infinity. Deep wells require higher thermal energy ($kT_m$) to disrupt the solid state, leading to higher melting points.</li>
     <li><b>Elastic Modulus ($E$):</b> Governed by the <b>curvature of the well at the minimum</b>, which equals the slope of the force curve at $r_0$:
       $$E \\propto \\left(\\frac{dF_N}{dr}\\right)_{r_0} = -\\left(\\frac{d^2E_N}{dr^2}\\right)_{r_0}$$
       A steep, narrow potential well produces a high restoring force per unit displacement, resulting in high stiffness.</li>
     <li><b>Thermal Expansion ($\\alpha_l$):</b> Governed by the <b>asymmetry (anharmonicity)</b> of the energy well. Because repulsion rises much steeper than attraction, thermal vibration midpoints shift outward to larger mean separations $\\bar{r}$ as temperature increases. A hypothetical symmetric well would have $\\alpha_l = 0$.</li>
   </ol>`)}

${qa('5 m', '8. Calculate the percent ionic character (%IC) of Ga–As and Ti–O bonds given Pauling electronegativities: X_Ga = 1.6, X_As = 2.0, X_Ti = 1.5, X_O = 3.5.',
  `<p><b>Pauling formula:</b> $\\%\\mathrm{IC} = \\{1 - \\exp[-0.25 (X_A - X_B)^2]\\} \\times 100\\%$</p>
   <p><b>For Ga–As:</b></p>
   $$\\Delta X = |1.6 - 2.0| = 0.40 \\implies (\\Delta X)^2 = 0.16$$
   $$\\%\\mathrm{IC} = \\{1 - \\exp[-0.25(0.16)]\\} \\times 100\\% = \\{1 - \\exp(-0.04)\\} \\times 100\\% = (1 - 0.9608) \\times 100\\% = 3.92\\% \\approx 3.9\\%$$
   <p>GaAs is <b>$3.9\\%$ ionic</b> and <b>$96.1\\%$ covalent</b> (predominantly covalent semiconductor).</p>
   <p><b>For Ti–O:</b></p>
   $$\\Delta X = |1.5 - 3.5| = 2.0 \\implies (\\Delta X)^2 = 4.0$$
   $$\\%\\mathrm{IC} = \\{1 - \\exp[-0.25(4.0)]\\} \\times 100\\% = \\{1 - \\exp(-1.0)\\} \\times 100\\% = (1 - 0.3679) \\times 100\\% = 63.2\\%$$
   <p>TiO₂ is <b>$63.2\\%$ ionic</b> and <b>$36.8\\%$ covalent</b> (predominantly ionic ceramic).</p>`)}

${qa('5 m', '9. Contrast optical microscopy, SEM, and TEM with respect to illumination source, resolution limit, and specimen preparation.',
  `<div class="scroll-x"><table class="ref">
     <tr><th>Feature</th><th>Optical Microscope (OM)</th><th>Scanning Electron Microscope (SEM)</th><th>Transmission Electron Microscope (TEM)</th></tr>
     <tr><td><b>Source</b></td><td>Visible light beam</td><td>Focused electron beam</td><td>Transmitted electron beam</td></tr>
     <tr><td><b>Resolution</b></td><td>$\\approx 0.2\\ \\mu\\mathrm{m}$ ($200\\mathrm{~nm}$)</td><td>$\\approx 1 - 5\\mathrm{~nm}$</td><td>$\\approx 0.1\\mathrm{~nm}$ ($1\\mathrm{~\\AA}$)</td></tr>
     <tr><td><b>Magnification</b></td><td>Up to $2,000\\times$</td><td>$10\\times$ to $100,000\\times$</td><td>Up to $1,000,000\\times$</td></tr>
     <tr><td><b>Specimen</b></td><td>Polished & etched flat surface</td><td>Conductive surface (carbon/Au coated if non-metal)</td><td>Ultra-thin foil ($\\\\lt 100\\mathrm{~nm}$) transparent to electrons</td></tr>
     <tr><td><b>Features</b></td><td>Grains, phase boundaries</td><td>3D topography, fracture surfaces, depth of field</td><td>Dislocations, stacking faults, atomic columns</td></tr>
   </table></div>`)}

${secband('C', 'Essay Question · Answer 1 question · 10 marks')}

${qa('10 m', '10. Give a comprehensive account of crystal defects. Classify them by dimensionality with diagrams, and explain the thermodynamic origin of vacancies and the role of dislocations in plastic deformation.',
  `<p><b>1. Classification of Imperfections:</b></p>
   <ul>
     <li><b>0-D (Point defects):</b> Vacancy (missing atom), self-interstitial (crowded extra atom), substitutional solute (replaces host atom), interstitial solute (fits in void).</li>
     <li><b>1-D (Linear defects / Dislocations):</b> Edge dislocation (extra half-plane of atoms ending at slip plane, $\\mathbf{b} \\perp$ line); Screw dislocation (helical atomic ramp, $\\mathbf{b} \\parallel$ line); Mixed dislocation.</li>
     <li><b>2-D (Interfacial defects):</b> External surfaces (high energy due to dangling bonds); Grain boundaries (tilt boundary formed by edge dislocation walls $\\theta = b/D$, twist boundary formed by screw grid); Twin boundaries (coherent mirror planes).</li>
     <li><b>3-D (Volume defects):</b> Pores, cracks, inclusions, second-phase precipitates.</li>
   </ul>
   <p><b>2. Thermodynamics of Vacancies:</b></p>
   <p>Creating a vacancy requires enthalpy ($\Delta H_v > 0$) to break interatomic bonds. However, distributing vacancies among $N$ sites creates immense configurational entropy ($\Delta S_v > 0$). In the Gibbs free energy $\Delta G = \Delta H_v - T\Delta S_v$, the $-T\Delta S_v$ term drives $\Delta G$ negative at low concentrations, creating a minimum at:</p>
   $$N_v = N \\exp\\left(-\\frac{Q_v}{kT}\\right)$$
   <p>Because entropy increases, vacancies are thermodynamically stable and present in non-zero equilibrium concentrations in every crystal above $0\\mathrm{~K}$.</p>
   <p><b>3. Role of Dislocations in Plastic Deformation:</b></p>
   <p>Plastic deformation occurs by <b>slip</b>—the movement of dislocations along close-packed planes in close-packed directions. Rather than shearing an entire plane of millions of atomic bonds simultaneously (which would require theoretical stresses $\\approx G/10$), dislocations move one atomic row at a time. The bonds ahead of the dislocation break while those behind reform, lowering the critical resolved shear stress needed for deformation by three orders of magnitude ($10^{-3} G$).</p>`)}
`
});

/* ── Model Paper 2 ── */
STATIONS.push({
  id: 'test-2',
  mod: 'Model Tests', modName: 'Sit the paper', modClass: 'm3',
  title: 'Model Examination Paper II (Numerical & Problem Solving)',
  short: 'Model Paper 2',
  est: '~60 min',
  body: H`
${gist('Quantitative examination paper focusing on numerical problem solving. Test your calculations before revealing model solutions.')}

${paper('MATERIALS SCIENCE — Model Examination Paper II (Numericals)', '2 Hours', '60 Marks')}

${secband('A', 'Short Problems · Answer all questions · 3 marks each')}

${qa('3 m', '1. Calculate the energy of a K⁺–Cl⁻ ion pair at equilibrium separation r₀ = 0.28 nm given A = 2.31 × 10⁻²⁸ N·m² and repulsive exponent n = 8.',
  `<p><b>Formula:</b> $E_0 = -\\frac{A}{r_0}\\left(1 - \\frac{1}{n}\\right)$</p>
   $$E_0 = -\\frac{2.31 \\times 10^{-28}\\mathrm{~N}\\cdot\\mathrm{m}^2}{0.28 \\times 10^{-9}\\mathrm{~m}}\\left(1 - \\frac{1}{8}\\right) = -(8.25 \\times 10^{-19})\\left(\\frac{7}{8}\\right) = -7.22 \\times 10^{-19}\\mathrm{~J}$$
   <p>In electron-volts:</p>
   $$E_0 = \\frac{-7.22 \\times 10^{-19}\\mathrm{~J}}{1.602 \\times 10^{-19}\\mathrm{~J/eV}} = -4.51\\mathrm{~eV/bond}$$`)}

${qa('3 m', '2. A BCC metal diffracts monochromatic X-rays of wavelength 0.1542 nm at a 2θ angle of 44.5° for the (110) planes. Determine the lattice parameter a.',
  `<p><b>Bragg angle:</b> $\\theta = 44.5^{\\circ} / 2 = 22.25^{\\circ} \\implies \\sin(22.25^{\\circ}) = 0.3786$</p>
   $$d_{110} = \\frac{\\lambda}{2\\sin\\theta} = \\frac{0.1542\\mathrm{~nm}}{2(0.3786)} = 0.2036\\mathrm{~nm}$$
   $$a = d_{110} \\sqrt{h^2 + k^2 + l^2} = (0.2036)\\sqrt{1^2 + 1^2 + 0^2} = (0.2036)\\sqrt{2} = 0.2880\\mathrm{~nm} = 2.880\\mathrm{~\\AA}$$`)}

${qa('3 m', '3. Convert a 70 wt% Cu – 30 wt% Zn brass alloy into atom percent (at%). Given: A_Cu = 63.55 g/mol, A_Zn = 65.41 g/mol.',
  `$$C'_{\\mathrm{Cu}} = \\frac{C_{\\mathrm{Cu}} A_{\\mathrm{Zn}}}{C_{\\mathrm{Cu}} A_{\\mathrm{Zn}} + C_{\\mathrm{Zn}} A_{\\mathrm{Cu}}} \\times 100\\%$$
   $$C'_{\\mathrm{Cu}} = \\frac{(70)(65.41)}{(70)(65.41) + (30)(63.55)} \\times 100\\% = \\frac{4578.7}{4578.7 + 1906.5} \\times 100\\% = \\frac{4578.7}{6485.2} \\times 100\\% = 70.6\\mathrm{~at\\%~Cu}$$
   $$C'_{\\mathrm{Zn}} = 100 - 70.6 = 29.4\\mathrm{~at\\%~Zn}$$`)}

${secband('B', 'Descriptive Numericals · Answer any 3 questions · 7 marks each')}

${qa('7 m', '4. In a copper specimen at 1000 °C, the equilibrium vacancy concentration is 2.2 × 10²⁵ m⁻³. Given Q_v = 0.90 eV/atom and k = 8.62 × 10⁻⁵ eV/K, calculate the vacancy concentration in the same copper specimen at room temperature (20 °C).',
  `<p><b>Equation:</b> $N_v(T) = N \\exp(-Q_v / kT)$</p>
   <p>Since total atomic sites $N$ changes negligibly with temperature:</p>
   $$\\frac{N_v(T_2)}{N_v(T_1)} = \\exp\\left[-\\frac{Q_v}{k}\\left(\\frac{1}{T_2} - \\frac{1}{T_1}\\right)\\right]$$
   <p>Here $T_1 = 1000^{\\circ}\\mathrm{C} = 1273\\mathrm{~K}$, $T_2 = 20^{\\circ}\\mathrm{C} = 293\\mathrm{~K}$:</p>
   $$\\frac{1}{T_2} - \\frac{1}{T_1} = \\frac{1}{293} - \\frac{1}{1273} = 0.003413 - 0.000786 = 0.002627\\mathrm{~K}^{-1}$$
   $$-\\frac{Q_v}{k}\\left(\\frac{1}{T_2} - \\frac{1}{T_1}\\right) = -\\frac{0.90\\mathrm{~eV}}{8.62 \\times 10^{-5}\\mathrm{~eV/K}}(0.002627) = -(10441)(0.002627) = -27.43$$
   $$\\exp(-27.43) = 1.22 \\times 10^{-12}$$
   $$N_v(20^{\\circ}\\mathrm{C}) = N_v(1000^{\\circ}\\mathrm{C}) \\times (1.22 \\times 10^{-12}) = (2.2 \\times 10^{25})(1.22 \\times 10^{-12}) = 2.68 \\times 10^{13}\\mathrm{~vacancies/m}^3$$
   <p><b>Conclusion:</b> Cooling from $1000^{\\circ}\\mathrm{C}$ to $20^{\\circ}\\mathrm{C}$ reduces the equilibrium vacancy population by <b>12 orders of magnitude</b>!</p>`)}

${qa('7 m', '5. An ASTM grain size measurement on an alloy at M = 100× yields 64 grains per square inch. (a) Determine the ASTM grain size number G; (b) Compute the number of grains per square inch if observed at 200× magnification; (c) Compute the mean linear intercept length ℓ.',
  `<p><b>Part (a):</b> At $100\\times$, $n = 2^{G-1}$:</p>
   $$64 = 2^{G-1} = 2^6 \\implies G - 1 = 6 \\implies G = 7$$
   <p><b>Part (b):</b> At magnification $M = 200\\times$:</p>
   $$n_M = 2^{G-1}\\left(\\frac{100}{M}\\right)^2 = (64)\\left(\\frac{100}{200}\\right)^2 = (64)\\left(\\frac{1}{4}\\right) = 16\\mathrm{~grains/in}^2$$
   <p><b>Part (c):</b> Using ASTM equation: $G = -6.6457 \\log_{10}(\\ell) - 3.298$:</p>
   $$7 = -6.6457 \\log_{10}(\\ell) - 3.298 \\implies -6.6457 \\log_{10}(\\ell) = 10.298$$
   $$\\log_{10}(\\ell) = -\\frac{10.298}{6.6457} = -1.5495$$
   $$\\ell = 10^{-1.5495} = 0.0282\\mathrm{~mm} = 28.2\\ \\mu\\mathrm{m}$$`)}
`
});

/* ── Closing Checklist Station ── */
STATIONS.push({
  id: 'close',
  title: 'Last Pass Before the Exam · Final Checklist',
  short: 'Final Checklist',
  est: '~10 min',
  body: H`
${gist('Your final 10-minute crunch sheet: key equations, recurring exam traps, and exam-room timing strategy.')}

${tp('Core Equations to Write Cold')}
<div class="scroll-x"><table class="ref">
  <tr><th>Concept</th><th>Mathematical Formula</th><th>Units & Constants</th></tr>
  <tr><td><b>Coulomb Attractive Energy</b></td><td>$E_A = -\\frac{A}{r} = -\\frac{1}{4\\pi\\varepsilon_0}\\frac{|Z_1 Z_2|e^2}{r}$</td><td>$e^2/4\\pi\\varepsilon_0 = 2.31 \\times 10^{-28}\\mathrm{~N}\\cdot\\mathrm{m}^2$</td></tr>
  <tr><td><b>Total Bonding Energy</b></td><td>$E_0 = -\\frac{A}{r_0}\\left(1 - \\frac{1}{n}\\right)$</td><td>$n \\approx 8$; $1\\mathrm{~eV} = 1.602 \\times 10^{-19}\\mathrm{~J}$</td></tr>
  <tr><td><b>Pauling Percent Ionic Character</b></td><td>$\\%\\mathrm{IC} = \\left\\{1 - \\exp\\left[-0.25 (X_A - X_B)^2\\right]\\right\\} \\times 100\\%$</td><td>$X_A, X_B$ are Pauling electronegativities</td></tr>
  <tr><td><b>Bragg’s Law</b></td><td>$n\\lambda = 2d_{hkl} \\sin\\theta$</td><td>$\\theta = (2\\theta)/2$; $\\lambda$ in nm or Å</td></tr>
  <tr><td><b>Cubic Interplanar Spacing</b></td><td>$d_{hkl} = \\frac{a}{\\sqrt{h^2 + k^2 + l^2}}$</td><td>BCC: $h+k+l$ even; FCC: unmixed parity</td></tr>
  <tr><td><b>Equilibrium Vacancies</b></td><td>$N_v = N \\exp\\left(-\\frac{Q_v}{kT}\\right) \\quad \\left(N = \\frac{N_A \\rho}{A}\\right)$</td><td>$k = 8.62 \\times 10^{-5}\\mathrm{~eV/K}$; $T$ in Kelvin!</td></tr>
  <tr><td><b>Composition Conversion (wt% to at%)</b></td><td>$C'_1 = \\frac{C_1 A_2}{C_1 A_2 + C_2 A_1} \\times 100\\%$</td><td>$C_1 + C_2 = 100\\%$</td></tr>
  <tr><td><b>ASTM Grain Size Intercept</b></td><td>$\\ell = \\frac{L_T}{P \\cdot M}, \\quad G = -6.6457 \\log_{10}(\\ell) - 3.298$</td><td>$\\ell$ in mm; $n_{100\\times} = 2^{G-1}$</td></tr>
  <tr><td><b>Tilt Boundary Misorientation</b></td><td>$\\theta = \\frac{b}{D}$</td><td>$b$ = Burgers vector, $D$ = dislocation spacing</td></tr>
</table></div>

${tp('Common Pitfalls Where Marks Get Lost')}
${trap(`
<ol>
  <li><b>Celsius vs. Kelvin in Boltzmann Equation:</b> Always add $273.15$ to temperature before calculating $\\exp(-Q_v/kT)$. Computing with Celsius gives an astronomical error!</li>
  <li><b>Diffraction Angle 2θ vs θ:</b> In XRD diffractograms, the horizontal axis is always <b>$2\\theta$</b>. Before inserting into Bragg’s law ($n\\lambda = 2d\\sin\\theta$), you MUST divide by 2!</li>
  <li><b>Reflection Rules Confusion:</b> For BCC, $h+k+l$ must be even (e.g. 110, 200, 211). For FCC, indices must be all odd or all even (e.g. 111, 200, 220). Never mix them up!</li>
  <li><b>Burgers Vector Orientation:</b> Edge dislocation has $\\mathbf{b} \\perp \\mathrm{line}$; screw dislocation has $\\mathbf{b} \\parallel \\mathrm{line}$.</li>
  <li><b>ASTM Grain Size Trend:</b> A LARGER $G$ number means SMALLER grains! $G = 8$ has finer grains and higher yield strength than $G = 4$.</li>
</ol>
`)}

<p class="dim" style="margin-top:1.5rem;text-align:center">
  <span class="spark">◈</span> You are fully prepared for Modules I & II. Review your bookmarked questions, rest well, and write clearly in the exam!
</p>
`
});

/* ── Module Grouping Hierarchy ── */
const MODULES = [
  {
    id: 'mod-0',
    name: 'Start',
    sub: 'Read this first',
    cls: 'm0',
    stations: ['start']
  },
  {
    id: 'mod-1',
    name: 'Module I',
    sub: 'Materials, Forces & Bonding',
    cls: 'm1',
    stations: [
      'm1-what', 'm1-classes', 'm1-adv',
      'm1-forces', 'm1-ionic', 'm1-cov',
      'm1-metal', 'm1-vdw', 'm1-mixed'
    ]
  },
  {
    id: 'mod-2',
    name: 'Module II',
    sub: 'Crystals, Defects & Microstructure',
    cls: 'm2',
    stations: [
      'm2-poly', 'm2-xrd', 'm2-amorph',
      'm2-point', 'm2-imp', 'm2-comp',
      'm2-disl', 'm2-inter', 'm2-micro'
    ]
  },
  {
    id: 'mod-3',
    name: 'Model Tests',
    sub: 'Sit the paper, then check',
    cls: 'm3',
    stations: ['test-1', 'test-2']
  },
  {
    id: 'mod-4',
    name: 'Final Checklist',
    sub: 'Last pass before the exam',
    cls: 'm4',
    stations: ['close']
  }
];

window.MODULES = MODULES;
