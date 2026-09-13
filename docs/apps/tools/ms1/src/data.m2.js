/* ═══════════════════ MODULE II: CRYSTALS, DEFECTS & MICROSTRUCTURE ═══════════════════ */

/* ── 1. m2-poly: Polymorphism, Grains & Anisotropy ── */
STATIONS.push({
  id: 'm2-poly',
  mod: 'Module II', modName: 'Crystals, Defects & Microstructure', modClass: 'm2',
  title: 'Polymorphism, Solidification & Directional Anisotropy',
  short: 'Polymorphism & Grains',
  est: '~18 min',
  body: H`
${gist('Real engineering solids are <b>polycrystalline aggregates</b> whose directional properties (anisotropy) depend on grain orientation and solidification history.')}

${carry(
  ['14 Bravais lattices and 7 crystal systems from solid state physics', 'Miller indices for directions [uvw] and planes (hkl)', 'Simple cubic, BCC, and FCC atomic packing geometries'],
  ['Four stages of solidification: nucleation, crystallite growth, grain impingement, and boundary formation', 'Anisotropic single crystals vs isotropic random polycrystals', 'Directional dependence of Young’s modulus E across [100], [110], [111]']
)}

${tp('Polymorphism and Allotropy')}
<p>Some materials can exist in more than one crystal structure depending on ambient temperature and pressure. When found in elemental solids, this phenomenon is termed <b>allotropy</b>; in compounds, it is termed <b>polymorphism</b>:</p>
<ul>
  <li><b>Carbon Allotropy:</b> At room pressure, graphite (hexagonal layered $sp^2$) is thermodynamically stable. Under extreme pressures ($>1.5\mathrm{~GPa}$), carbon transforms into diamond (cubic $sp^3$).</li>
  <li><b>Iron Allotropy (Crucial for Steel):</b> Pure iron exists as:
    $$\alpha\mathrm{-Fe~(BCC,~Ferrite)} \xrightarrow{912^{\circ}\mathrm{C}} \gamma\mathrm{-Fe~(FCC,~Austenite)} \xrightarrow{1394^{\circ}\mathrm{C}} \delta\mathrm{-Fe~(BCC)} \xrightarrow{1538^{\circ}\mathrm{C}} \mathrm{Liquid}$$
    This polymorphic transformation changes atomic packing from BCC ($0.68$) to close-packed FCC ($0.74$), altering carbon solubility by orders of magnitude and making steel heat treatments possible.</li>
</ul>

${tp('Stages of Polycrystalline Solidification')}
<p>Most metals and ceramics are manufactured by casting from the liquid melt. Solidification proceeds through four sequential stages:</p>
<ol>
  <li><b>Nucleation (a):</b> As the melt cools below the melting point, tiny crystalline nuclei form randomly throughout the liquid, each with its own random spatial crystallographic orientation.</li>
  <li><b>Crystallite Growth (b):</b> Nuclei grow by adding atoms from the melt. Adjacent crystallites grow toward each other with different lattice orientations.</li>
  <li><b>Grain Impingement (c):</b> The growing crystallite boundaries meet. Where crystallites collide, irregular planar interfaces are formed.</li>
  <li><b>Grain Boundaries (d):</b> Solidification completes, producing a polycrystalline aggregate of irregularly shaped <b>grains</b> separated by narrow atomic transition zones called <b>grain boundaries</b>.</li>
</ol>

${fig('solidification', 'The four stages of solidification of a polycrystalline material: (a) nuclei formation, (b) crystallite growth, (c) impingement of adjacent grains, (d) final grain structure with etched grain boundaries.')}

${tp('Directional Anisotropy in Single Crystals')}
<p>In a single crystal, the spacing between atoms varies with crystallographic direction. Consequently, physical and mechanical properties are <b>anisotropic</b>—their magnitude depends on the direction along which measurement is made:</p>
${tbl(
  ['Metal & Structure', 'E along [100] (GPa)', 'E along [110] (GPa)', 'E along [111] (GPa)', 'Anisotropy Ratio E₁₁₁ / E₁₀₀'],
  [
    ['<b>Copper (FCC)</b>', '66.7', '130.3', '191.1', '<b>2.87×</b> (Highly Anisotropic)'],
    ['<b>α-Iron (BCC)</b>', '125.0', '210.5', '272.7', '<b>2.18×</b> (Anisotropic)'],
    ['<b>Aluminum (FCC)</b>', '63.7', '72.6', '76.1', '<b>1.19×</b> (Mildly Anisotropic)'],
    ['<b>Tungsten (BCC)</b>', '384.6', '384.6', '384.6', '<b>1.00×</b> (Perfectly Isotropic)']
  ]
)}

${fig('anisotropy', 'Polar representation of elastic modulus E in the (001) plane for cubic single crystals: Copper and Iron exhibit large lobes toward [110] and [111], while Tungsten is a perfect circle (completely isotropic).')}

${must(`<b>Why are ordinary metals isotropic on the macroscale?</b><br>
Although individual grains are highly anisotropic, an ordinary piece of polycrystalline metal contains millions of tiny grains with random crystallographic orientations. The directional variations cancel out by statistical averaging, making the bulk material <b>quasi-isotropic</b> (isotropic on the macroscale).`)}

${chk('Under what processing condition does a polycrystalline metal become anisotropic on the macroscale?',
  'When a polycrystalline metal undergoes directional deformation (such as cold rolling, wire drawing, or extrusion), the grains are forced into a preferred crystallographic alignment termed a "texture" or "preferred orientation". This texture causes bulk macroscale anisotropy (e.g. anisotropic magnetic permeability in Fe–Si transformer cores).')}
`
});

/* ── 2. m2-xrd: X-ray Diffraction & Bragg's Law ── */
STATIONS.push({
  id: 'm2-xrd',
  mod: 'Module II', modName: 'Crystals, Defects & Microstructure', modClass: 'm2',
  title: 'X-Ray Diffraction: Bragg’s Law, Diffractometers & Selection Rules',
  short: 'X-Ray Diffraction (XRD)',
  est: '~22 min',
  body: H`
${gist('X-ray diffraction determines crystal structures and interplanar spacings through <b>constructive interference</b> governed by Bragg’s law: $n\\lambda = 2d\\sin\\theta$.')}

${tp('Bragg’s Law & Geometric Derivation')}
<p>X-rays have wavelengths ($\\lambda \\approx 0.05 - 0.3\\mathrm{~nm}$) comparable to interatomic lattice spacings. When a collimated beam strikes parallel atomic planes spaced by $d$ at incident angle $\\theta$:</p>

${lad('Geometric Derivation of Bragg’s Law', [
  { why: 'Consider incident parallel x-ray beams 1 and 2 scattered by atoms in planes A and B:',
    m: '$$\\mathrm{Incident~angle~} = \\theta, \\quad \\mathrm{Reflection~angle~} = \\theta$$' },
  { why: 'Drop perpendiculars SQ and QT from the top scattering center onto ray 2 to find extra path length:',
    m: '$$\\mathrm{Path~difference~} \\Delta = SQ + QT$$' },
  { why: 'From the right triangles, both segments equal d sin θ:',
    m: '$$SQ = d \\sin\\theta, \\quad QT = d \\sin\\theta \\implies \\Delta = 2d \\sin\\theta$$' },
  { why: 'For constructive interference, this path difference must equal an integer number of wavelengths nλ:',
    m: '$$n\\lambda = 2d_{hkl} \\sin\\theta \\qquad (n = 1, 2, 3, \\dots)$$' }
])}

${fig('bragg', 'Interactive Bragg diffraction geometry: incident wavefronts scatter off adjacent atomic planes spaced by d. When path difference 2d sin θ equals integer wavelengths nλ, constructive interference generates a high-intensity diffraction peak.')}

${tp('Cubic Interplanar Spacing & Selection Rules')}
<p>For a cubic unit cell with lattice parameter $a$, the interplanar spacing $d_{hkl}$ between parallel planes $(hkl)$ is:</p>
${eq('d_{hkl} = \\frac{a}{\\sqrt{h^2 + k^2 + l^2}}', 'Cubic Spacing')}
<p>Due to destructive interference from non-corner atoms, certain reflections are systematically absent:</p>
${tbl(
  ['Crystal Structure', 'Diffraction Reflection Condition', 'Allowed Reflecting Planes (First 6 Peaks)'],
  [
    ['<b>Body-Centered Cubic (BCC)</b>', 'Sum of indices $(h + k + l)$ must be <b>EVEN</b>', '(110), (200), (211), (220), (310), (222)'],
    ['<b>Face-Centered Cubic (FCC)</b>', 'Indices $(h, k, l)$ must be <b>ALL ODD or ALL EVEN</b> (unmixed)', '(111), (200), (220), (311), (222), (400)'],
    ['<b>Simple Cubic (SC)</b>', 'All planes reflect (no systematic absences)', '(100), (110), (111), (200), (210), (211)']
  ]
)}

${fig('xrdpeaks', 'Experimental powder XRD diffractograms for FCC Lead (λ = 0.1542 nm) and BCC α-Iron (λ = 0.1790 nm) with labeled Miller indices matching reflection selection rules.')}

${prob('Worked Problem 3', 'Calculation of Interplanar Spacing and Lattice Parameter (Callister Example 3.13)', H`
${pq('For BCC iron, computing the first-order reflection from the (220) planes using monochromatic Co Kα radiation ($\\lambda = 0.1790\\mathrm{~nm}$) yields a diffraction peak at $2\\theta = 124.26^{\\circ}$. Determine: (a) the interplanar spacing $d_{220}$; and (b) the lattice parameter $a$ of iron.')}
${pth('Use Bragg’s law with $n = 1$ and $\\theta = 2\\theta / 2$, then cubic relationship $a = d \\sqrt{h^2 + k^2 + l^2}$.')}
${psol(H`
<p><b>Step 1:</b> Calculate the Bragg angle $\\theta$:</p>
$$\\theta = \\frac{124.26^{\\circ}}{2} = 62.13^{\\circ} \\implies \\sin\\theta = \\sin(62.13^{\\circ}) = 0.8840$$
<p><b>Step 2:</b> Apply Bragg’s Law:</p>
$$d_{220} = \\frac{n\\lambda}{2\\sin\\theta} = \\frac{(1)(0.1790\\mathrm{~nm})}{2(0.8840)} = 0.1013\\mathrm{~nm} = 1.013\\mathrm{~\\AA}$$
<p><b>Step 3:</b> Calculate lattice parameter $a$ for BCC iron:</p>
$$a = d_{220}\\sqrt{h^2 + k^2 + l^2} = (0.1013\\mathrm{~nm})\\sqrt{2^2 + 2^2 + 0^2} = (0.1013)\\sqrt{8} = 0.2866\\mathrm{~nm} = 2.866\\mathrm{~\\AA}$$
<p>Check selection rule: for (220), $h+k+l = 2+2+0 = 4$ (even) $\\implies$ Allowed for BCC.</p>
`)}
`)}

${chk('Why does the (100) plane never produce a diffraction peak in a BCC crystal?',
  'In BCC, the atom located at the center of the unit cell (1/2, 1/2, 1/2) creates an identical plane of atoms midway between the (100) corner planes. X-rays scattered from this intervening plane are exactly half a wavelength out of phase with those from the corner planes, resulting in complete destructive interference. Mathematically, h+k+l = 1+0+0 = 1 (odd, forbidden).')}
`
});

/* ── 3. m2-amorph: Noncrystalline & Amorphous Solids ── */
STATIONS.push({
  id: 'm2-amorph',
  mod: 'Module II', modName: 'Crystals, Defects & Microstructure', modClass: 'm2',
  title: 'Noncrystalline Solids: Amorphous Networks, Fused Silica & Glasses',
  short: 'Amorphous Solids',
  est: '~15 min',
  body: H`
${gist('Amorphous solids lack <b>long-range periodic order</b>; they possess short-range atomic coordination identical to their crystalline counterparts but disordered network topology.')}

${tp('Crystalline vs. Amorphous SiO₂')}
<p>The distinction between crystalline and amorphous states is clearly illustrated by silicon dioxide ($\\mathrm{SiO}_2$):</p>
<ul>
  <li><b>Crystalline Quartz:</b> Composed of silicon–oxygen tetrahedra ($\\mathrm{SiO}_4^{4-}$) sharing corners in an unbroken, highly symmetric periodic lattice with uniform hexagonal rings.</li>
  <li><b>Fused Silica Glass:</b> Composed of the <em>exact same</em> $\\mathrm{SiO}_4^{4-}$ tetrahedra linked at corners, but the $\\mathrm{Si}-\\mathrm{O}-\\mathrm{Si}$ bond angles and torsions vary randomly. This creates a disordered network with irregular rings containing 5, 6, 7, or 8 silicon atoms.</li>
</ul>

${fig('sio2glass', 'Two-dimensional network comparison: (a) crystalline SiO₂ (quartz) showing regular hexagonal repeating rings vs (b) noncrystalline SiO₂ (glass) showing a disordered random network of varying ring sizes.')}

${tp('Factors Favoring the Amorphous State')}
<p>A solid condenses as noncrystalline/amorphous when thermodynamic conditions prevent atoms from migrating to their lowest-energy periodic lattice positions:</p>
<ol>
  <li><b>Rapid Cooling Rate (Quenching):</b> Cooling a melt rapidly past its freezing point deprives atoms of the diffusion time needed to nucleate and organize into periodic lattice sites, trapping a "frozen liquid" structure.</li>
  <li><b>Molecular Complexity:</b> Complex chemical units or long, branched polymer chains have high steric hindrance and sluggish diffusion, readily forming amorphous glasses.</li>
</ol>

${tbl(
  ['Material Family', 'Crystalline / Amorphous Propensity', 'Explanation'],
  [
    ['<b>Metals</b>', 'Almost exclusively crystalline', 'Metallic bonds are nondirectional and atomic radii are small, allowing instantaneous atomic rearrangement during solidification. Amorphous metallic glasses require extreme cooling rates ($>10^6\\mathrm{~K/s}$).'],
    ['<b>Ceramics</b>', 'Both crystalline and amorphous', 'Simple ceramics (NaCl, MgO) are crystalline; complex silicates (soda-lime glass, borosilicate) easily form stable amorphous glasses.'],
    ['<b>Polymers</b>', 'Amorphous or semicrystalline', 'Long entangled macromolecular chains rarely achieve 100% crystallinity; they consist of crystalline lamellae embedded in an amorphous matrix.']
  ]
)}

${chk('Concept Check 3.4: Can an amorphous material exhibit allotropy or polymorphism?',
  'No. Allotropy and polymorphism explicitly describe a material possessing multiple distinct crystalline unit-cell geometries. Because an amorphous material has no periodic unit cell or crystal symmetry to begin with, it cannot exhibit allotropy.')}
`
});

/* ── 4. m2-point: Point Defects & Vacancies ── */
STATIONS.push({
  id: 'm2-point',
  mod: 'Module II', modName: 'Crystals, Defects & Microstructure', modClass: 'm2',
  title: 'Point Defects: Vacancies, Self-Interstitials & Thermodynamics',
  short: 'Point Defects',
  est: '~18 min',
  body: H`
${gist('Vacancies are <b>thermodynamically stable equilibrium defects</b> whose concentration increases exponentially with temperature: $N_v = N\\exp(-Q_v/kT)$.')}

${tp('Classification of Defects in Solids')}
${tbl(
  ['Defect Dimensionality', 'Defect Family', 'Representative Examples'],
  [
    ['<b>Zero-Dimensional (0-D)</b>', 'Point defects', 'Vacancies, self-interstitials, substitutional and interstitial impurity atoms, Schottky and Frenkel pairs'],
    ['<b>One-Dimensional (1-D)</b>', 'Linear defects (Dislocations)', 'Edge dislocations (⊥), screw dislocations, mixed dislocations'],
    ['<b>Two-Dimensional (2-D)</b>', 'Interfacial / Planar defects', 'External surfaces, grain boundaries, tilt and twist boundaries, twin boundaries, stacking faults'],
    ['<b>Three-Dimensional (3-D)</b>', 'Bulk / Volume defects', 'Pores, internal voids, microcracks, foreign second-phase precipitate inclusions']
  ]
)}

${tp('Vacancies vs. Self-Interstitials')}
<ul>
  <li><b>Vacancy:</b> A missing atom from a normal lattice position. Surrounding atoms relax slightly <em>inward</em> toward the void.</li>
  <li><b>Self-Interstitial:</b> A host atom crowded into a tiny interstitial space between normal lattice sites. Because atomic size is comparable to the void, a self-interstitial generates intense <em>outward compressive strain</em>.</li>
</ul>

${fig('vacancies', '2D crystal lattice with a vacancy (missing atom with inward relaxation) and a self-interstitial (crowded atom with severe outward lattice distortion).')}

${tp('Thermodynamic Origin & Boltzmann Relation')}
<p>Why do vacancies exist in thermodynamic equilibrium while all other crystal defects are nonequilibrium?</p>
<div class="note why">
  <div class="nh">Thermodynamic Stability: Why Crystals Must Have Vacancies</div>
  Creating a vacancy requires enthalpy ($\Delta H_v > 0$) to break bonds. However, distributing vacancies randomly among $N$ lattice sites introduces vast <b>configurational entropy</b> ($\Delta S_v > 0$). The change in Gibbs free energy is:
  $$\Delta G = \Delta H_v - T \Delta S_v$$
  At any temperature above absolute zero ($T > 0\mathrm{~K}$), the $-T\Delta S$ term dominates at small vacancy concentrations, creating a true minimum in free energy at an equilibrium vacancy population:
  $$N_v = N \\exp\\left(-\\frac{Q_v}{kT}\\right)$$
</div>

${prob('Worked Problem 4', 'Equilibrium Vacancy Concentration in Copper (Callister Example 4.1)', H`
${pq('Calculate the equilibrium number of vacancies per cubic meter in pure copper at $1000^{\\circ}\\mathrm{C}$. Given: activation energy $Q_v = 0.90\\mathrm{~eV/atom}$, atomic weight $A_{\\mathrm{Cu}} = 63.55\\mathrm{~g/mol}$, density $\\rho = 8.40\\mathrm{~g/cm}^3$ (at $1000^{\\circ}\\mathrm{C}$).')}
${pth('First compute the total lattice site density $N = (N_A \\cdot \\rho) / A$, convert temperature to Kelvin, and evaluate the Boltzmann exponential.')}
${psol(H`
<p><b>Step 1:</b> Convert temperature to Kelvin:</p>
$$T = 1000^{\\circ}\\mathrm{C} + 273.15 = 1273.15\\mathrm{~K} \\approx 1273\\mathrm{~K}$$
<p><b>Step 2:</b> Calculate total atomic sites per cubic meter $N$:</p>
$$\\rho = 8.40\\mathrm{~g/cm}^3 = 8.40 \\times 10^6\\mathrm{~g/m}^3$$
$$N = \\frac{N_A \\cdot \\rho}{A} = \\frac{(6.022 \\times 10^{23}\\mathrm{~atoms/mol})(8.40 \\times 10^6\\mathrm{~g/m}^3)}{63.55\\mathrm{~g/mol}} = 7.96 \\times 10^{28}\\mathrm{~atoms/m}^3$$
<p><b>Step 3:</b> Evaluate the Boltzmann exponential with $k = 8.62 \\times 10^{-5}\\mathrm{~eV/atom}\\cdot\\mathrm{K}$:</p>
$$\\frac{Q_v}{kT} = \\frac{0.90\\mathrm{~eV}}{(8.62 \\times 10^{-5}\\mathrm{~eV/K})(1273\\mathrm{~K})} = \\frac{0.90}{0.1097} = 8.20$$
$$\\exp\\left(-\\frac{Q_v}{kT}\\right) = \\exp(-8.20) = 2.75 \\times 10^{-4}$$
<p><b>Step 4:</b> Compute vacancy density $N_v$:</p>
$$N_v = N \\exp\\left(-\\frac{Q_v}{kT}\\right) = (7.96 \\times 10^{28})(2.75 \\times 10^{-4}) = 2.19 \\times 10^{25}\\mathrm{~vacancies/m}^3$$
<p>The fraction is $N_v/N \\approx 2.75 \\times 10^{-4}$—roughly 1 vacancy per 3,600 atoms near melting!</p>
`)}
`)}

${chk('Why are self-interstitials virtually non-existent in metals compared to vacancies?',
  'A vacancy requires only breaking bonds (Q_v ≈ 0.8–1.2 eV). A self-interstitial forces an atom into an interstitial void much smaller than itself, creating massive local elastic strain energy (Q_i ≈ 3–4 eV). Because Q_i is 3 to 4 times larger, the Boltzmann factor exp(−Q_i / kT) yields interstitial concentrations of order 10⁻¹⁵—negligible compared to vacancies.')}
`
});

/* ── 5. m2-imp: Impurities & Solid Solutions ── */
STATIONS.push({
  id: 'm2-imp',
  mod: 'Module II', modName: 'Crystals, Defects & Microstructure', modClass: 'm2',
  title: 'Impurities in Solids: Solid Solutions & Hume-Rothery Rules',
  short: 'Solid Solutions',
  est: '~18 min',
  body: H`
${gist('Impurities form either <b>substitutional</b> or <b>interstitial</b> solid solutions governed by the Hume-Rothery rules.')}

${tp('Substitutional vs. Interstitial Solid Solutions')}
<ul>
  <li><b>Substitutional:</b> Solute atoms substitute for host solvent atoms on regular lattice sites. E.g., Cu–Ni alloys, brass (Zn in Cu).</li>
  <li><b>Interstitial:</b> Tiny solute atoms occupy empty void positions between host atoms. E.g., Carbon in iron.</li>
</ul>

${tp('Hume-Rothery Rules for Substitutional Solid Solubility')}
<p>William Hume-Rothery established four empirical conditions for extensive or complete substitutional solid solubility:</p>
<ol>
  <li><b>Atomic Size Factor:</b> The atomic radii of solute and solvent must not differ by more than <b>$\\pm 15\\%$</b>:
    $$\\Delta r = \\left|\\frac{r_{\\mathrm{solute}} - r_{\\mathrm{solvent}}}{r_{\\mathrm{solvent}}}\\right| \\times 100\\% \\le 15\\%$$</li>
  <li><b>Crystal Structure Rule:</b> Both elements must have the same crystal structure (e.g. both FCC).</li>
  <li><b>Electronegativity Factor:</b> Electronegativities must be close. Large differences favor brittle intermetallic compounds over solid solutions.</li>
  <li><b>Valency Rule:</b> A metal has a greater propensity to dissolve another metal of higher valence than one of lower valence.</li>
</ol>

${must(`<b>Classic Hume-Rothery Example: Copper–Nickel (Cu–Ni):</b><br>
Copper and Nickel exhibit 100% complete mutual solid solubility across the entire phase diagram because they satisfy all four rules:
1. $r_{\\mathrm{Cu}} = 0.128\\mathrm{~nm}$, $r_{\\mathrm{Ni}} = 0.125\\mathrm{~nm} \\implies \\Delta r = 2.3\\%$ ($\\\\ll 15\\%$)
2. Both are Face-Centered Cubic (FCC)
3. Electronegativities: $X_{\\mathrm{Cu}} = 1.9$, $X_{\\mathrm{Ni}} = 1.8$ (virtually identical)
4. Most common valences: $\\mathrm{Cu} = +1, +2$; $\\mathrm{Ni} = +2$.`)}

${tp('Interstitial Sites in FCC and BCC')}
<p>Interatomic void spaces in crystals host small interstitial impurities (H, B, C, N, O):</p>
<div class="grid2">
  <div>${fig3d('fcc_interstitial', 'Face-Centered Cubic interstitial sites: spin to inspect Octahedral sites (center of unit cell and 12 edge centers, CN = 6, r = 0.414 R) and Tetrahedral sites (CN = 4, r = 0.225 R).')}</div>
  <div>${fig3d('bcc_interstitial', 'Body-Centered Cubic interstitial sites: spin to view Octahedral sites situated at face centers and edge centers (CN = 6, r = 0.155 R).')}</div>
</div>

${chk('Why is the maximum solubility of carbon in FCC austenite (2.14 wt%) so much higher than in BCC ferrite (0.022 wt%)?',
  'Although BCC has a lower atomic packing factor (0.68) than FCC (0.74), its interstitial voids are smaller and distorted. In BCC, the octahedral interstitial radius is only 0.155 R. In FCC, the octahedral site is much larger with radius 0.414 R. A carbon atom fits into FCC austenite with far less strain, allowing a hundredfold higher solubility.')}
`
});

/* ── 6. m2-comp: Specification of Composition ── */
STATIONS.push({
  id: 'm2-comp',
  mod: 'Module II', modName: 'Crystals, Defects & Microstructure', modClass: 'm2',
  title: 'Composition Specifications: wt% ↔ at% Conversions',
  short: 'Composition Conversions',
  est: '~15 min',
  body: H`
${gist('Alloy compositions are specified as <b>weight percent (wt%)</b> in engineering practice and <b>atom percent (at%)</b> in scientific calculations.')}

${tp('Definitions & Conversion Equations')}
<p>For a binary alloy composed of elements 1 and 2:</p>
${eq('C_1 = \\frac{m_1}{m_1 + m_2} \\times 100\\% \\qquad (\\mathrm{Weight~Percent})')}
${eq("C'_1 = \\frac{n_{m1}}{n_{m1} + n_{m2}} \\times 100\\% \\qquad (\\mathrm{Atom~Percent})")}
<p>where $n_{m1} = m_1 / A_1$ is the number of moles. The direct conversion relationships are:</p>
${eq("C'_1 = \\frac{C_1 A_2}{C_1 A_2 + C_2 A_1} \\times 100\\%", 'wt% to at%')}
${eq("C_1 = \\frac{C'_1 A_1}{C'_1 A_1 + C'_2 A_2} \\times 100\\%", 'at% to wt%')}
<p>The average density $\\rho_{\\mathrm{ave}}$ and average atomic weight $A_{\\mathrm{ave}}$ are:</p>
${eq("\\rho_{\\mathrm{ave}} = \\frac{100}{\\frac{C_1}{\\rho_1} + \\frac{C_2}{\\rho_2}} \\qquad A_{\\mathrm{ave}} = \\frac{100}{\\frac{C_1}{A_1} + \\frac{C_2}{A_2}} = \\frac{C'_1 A_1 + C'_2 A_2}{100}")}

${prob('Worked Problem 5', 'Conversion from wt% to at% for Al–Cu Alloy (Callister Example 4.4)', H`
${pq('An aluminum alloy contains $97\\mathrm{~wt}\\%\\mathrm{~Al}$ and $3.0\\mathrm{~wt}\\%\\mathrm{~Cu}$. Determine the composition in atom percent (at%). Given: $A_{\\mathrm{Al}} = 26.98\\mathrm{~g/mol}$, $A_{\\mathrm{Cu}} = 63.55\\mathrm{~g/mol}$.')}
${pth("Use the conversion formula: $C'_{\\mathrm{Al}} = \\frac{C_{\\mathrm{Al}} A_{\\mathrm{Cu}}}{C_{\\mathrm{Al}} A_{\\mathrm{Cu}} + C_{\\mathrm{Cu}} A_{\\mathrm{Al}}} \\times 100\\%$.")}
${psol(H`
$$C'_{\mathrm{Al}} = \frac{(97)(63.55)}{(97)(63.55) + (3.0)(26.98)} \times 100\%$$
$$C'_{\mathrm{Al}} = \frac{6164.35}{6164.35 + 80.94} \times 100\% = \frac{6164.35}{6245.29} \times 100\% = 98.7\mathrm{~at}\%\mathrm{~Al}$$
$$C'_{\mathrm{Cu}} = 100 - 98.7 = 1.30\mathrm{~at}\%\mathrm{~Cu}$$
<p>Even though copper accounts for $3.0\%$ of the total mass, it represents only <b>$1.30\%$ of the total atoms</b> because copper atoms are over twice as heavy as aluminum atoms.</p>
`)}
`)}

${chk('Why is average density calculated as 100 / (C1/ρ1 + C2/ρ2) rather than a simple weighted average (C1·ρ1 + C2·ρ2)/100?',
  'Because density is mass divided by volume, and volumes are additive. Dividing mass fraction C_i by density ρ_i converts mass into volume fraction. The harmonic mean correctly weights the individual volumes of the constituents.')}
`
});

/* ── 7. m2-disl: Dislocations & Linear Defects ── */
STATIONS.push({
  id: 'm2-disl',
  mod: 'Module II', modName: 'Crystals, Defects & Microstructure', modClass: 'm2',
  title: 'Dislocations: Edge, Screw, Mixed & The Burgers Vector',
  short: 'Dislocations & Slip',
  est: '~22 min',
  body: H`
${gist('Dislocations are 1D linear defects whose movement produces <b>plastic deformation</b>; their magnitude and direction are defined by the <b>Burgers vector b</b>.')}

${tp('Edge, Screw, and Mixed Dislocations')}
${tbl(
  ['Dislocation Type', 'Geometric Description', 'Burgers Vector Relationship', 'Stress Field in Lattice'],
  [
    ['<b>Edge Dislocation (⊥)</b>', 'Extra vertical half-plane of atoms terminating inside the crystal at the slip plane.', '<b>b ⊥ dislocation line</b> (perpendicular)', 'Compressive stress above the slip plane (crowded atoms); tensile stress below the slip plane (dilated atoms).'],
    ['<b>Screw Dislocation</b>', 'Formed by a shear displacement of one atomic spacing; atomic planes form a continuous helical ramp.', '<b>b ∥ dislocation line</b> (parallel)', 'Pure shear stress field centered on the dislocation line.'],
    ['<b>Mixed Dislocation</b>', 'A curved dislocation line that transitions smoothly between edge and screw character.', '<b>b neither ⊥ nor ∥</b> (arbitrary angle)', 'Complex stress state combining compression, tension, and shear components.']
  ]
)}

${fig('dislocations', 'Comparison of edge dislocation (extra half-plane ending at slip plane, compressive/tensile zones, b ⊥ line) and screw dislocation (helical atomic ramp, b ∥ line).')}

${tp('The Burgers Vector (b)')}
<p>The <b>Burgers vector $\\mathbf{b}$</b> specifies the magnitude and crystallographic direction of lattice distortion produced by a dislocation:</p>
<ol>
  <li><b>Burgers Circuit:</b> In a perfect crystal, tracing an equal number of atomic steps ($m$ up, $n$ right, $m$ down, $n$ left) forms a closed loop. Tracing the exact same steps around a dislocation fails to close; the closure vector from finish to start is $\\mathbf{b}$.</li>
  <li><b>Invariance along the Line:</b> For any dislocation line—even a tortuous, curved mixed line—the Burgers vector $\\mathbf{b}$ has the <em>exact same magnitude and direction at every single point</em> along the line!</li>
  <li><b>Magnitude:</b> $\\|\\mathbf{b}\\|$ is equal to one interatomic spacing in the close-packed slip direction (e.g. in FCC, $\\mathbf{b} = \\frac{a}{2}\\langle 110\\rangle$, with length $b = a/\\sqrt{2}$).</li>
</ol>

${must(`<b>Dislocation Movement = Slip:</b><br>
When a solid deforms plastically, it does not shear all atomic bonds across an entire plane at once (which would require theoretical shear stresses of $\\sim G/10$). Instead, dislocations glide one atomic row at a time—like moving a heavy rug by pushing a small wrinkle across the floor. This explains why real metals yield at stresses $1000\\times$ lower than theoretical lattice strength!`)}

${chk('How do dislocations appear when imaged under Transmission Electron Microscopy (TEM)?',
  'Under TEM (at ~50,000× magnification), dislocations appear as dark, thread-like lines. The localized atomic strain field around the dislocation core scatters incident electrons out of the diffraction condition, casting dark contrast lines onto the fluorescent screen.')}
`
});

/* ── 8. m2-inter: Interfacial Defects & Boundaries ── */
STATIONS.push({
  id: 'm2-inter',
  mod: 'Module II', modName: 'Crystals, Defects & Microstructure', modClass: 'm2',
  title: 'Interfacial Defects: Surfaces, Grain, Tilt & Twin Boundaries',
  short: 'Interfacial Defects',
  est: '~18 min',
  body: H`
${gist('Interfacial defects are 2D boundaries separating regions of different orientation or phase; they carry <b>excess interfacial energy</b>.')}

${tp('External Surfaces & Surface Energy')}
<p>At an external boundary, surface atoms are not bonded to the maximum number of nearest neighbors—they have unfulfilled dangling bonds. Consequently, surface atoms reside in a higher energy state than interior bulk atoms, quantified as <b>surface energy $\\gamma$</b> ($\mathrm{J/m}^2$ or $\mathrm{erg/cm}^2$):</p>
<ul>
  <li>To minimize total free energy, liquids minimize surface area by assuming spherical shapes.</li>
  <li>In crystals, planes with the highest planar packing density (e.g. {111} in FCC) have the lowest surface energy because their atoms satisfy the most bonds in-plane.</li>
</ul>

${tp('Grain Boundaries: Tilt, Twist, and High-Angle')}
<p>Grain boundaries separate two adjacent grains with different crystallographic orientations:</p>
${tbl(
  ['Boundary Type', 'Misorientation Angle θ', 'Internal Structure', 'Interfacial Energy'],
  [
    ['<b>Small-Angle Tilt Boundary</b>', '$\\theta \\lt 10 - 15^{\\circ}$', 'A vertical wall of parallel edge dislocations aligned one above another. Misorientation angle: $\\theta = b / D$ (where $D$ is dislocation vertical spacing).', 'Low energy ($0.1 - 0.3\\mathrm{~J/m}^2$)'],
    ['<b>Small-Angle Twist Boundary</b>', '$\\theta \\lt 10 - 15^{\\circ}$', 'A crossed grid of screw dislocations in the boundary plane.', 'Low energy'],
    ['<b>High-Angle Grain Boundary</b>', '$\\theta \\gt 15^{\\circ}$', 'Large atomic mismatch; open disordered transition zone several atom diameters wide.', 'High energy ($0.5 - 1.2\\mathrm{~J/m}^2$). Highly chemically reactive; site of corrosion and solute segregation.'],
    ['<b>Twin Boundary</b>', 'Special coherent boundary', 'Lattice on one side is a mirror reflection of the other across a specific twin plane. Stacking sequence mirrors: $ABCAB\\,|\\,BACBA$.', 'Extremely low energy ($\\approx 10\\%$ of a high-angle grain boundary)']
  ]
)}

${fig('boundaries', 'Interfacial defects: (a) small-angle tilt boundary modeled as a vertical dislocation wall with spacing D = b/θ; (b) twin boundary showing atomic mirror symmetry across the twin plane.')}

${chk('Rank the following planar defects in order of increasing interfacial energy: High-angle grain boundary, External surface, Twin boundary, Small-angle tilt boundary.',
  'Order of increasing energy: Twin boundary (lowest, coherent mirror) < Small-angle tilt boundary (isolated dislocations) < High-angle grain boundary (disordered atomic mismatch) < External surface (highest, complete loss of nearest-neighbor bonds on one side).')}
`
});

/* ── 9. m2-micro: Microscopy & ASTM Grain Size ── */
STATIONS.push({
  id: 'm2-micro',
  mod: 'Module II', modName: 'Crystals, Defects & Microstructure', modClass: 'm2',
  title: 'Microscopy Techniques & ASTM Grain Size Determination',
  short: 'Microscopy & Grain Size',
  est: '~20 min',
  body: H`
${gist('Microstructural features (0.1–100 μm) govern mechanical properties; grain size is standardized via the <b>ASTM intercept method</b>: $G = -6.6457\\log\\ell - 3.298$.')}

${tp('Comparison of Microscopy Techniques')}
${tbl(
  ['Microscope Technique', 'Illumination Source & Mechanism', 'Resolution Limit', 'Max Useful Magnification', 'Key Uses & Specimen Prep'],
  [
    ['<b>Optical Microscopy (OM)</b>', 'Visible light reflected from polished specimen', '$\\approx 0.2\\ \\mu\\mathrm{m}$ ($200\\mathrm{~nm}$)', '$\\approx 2,000\\times$', 'Grains, phases, inclusions. Requires mechanical grinding, polishing, and chemical etching.'],
    ['<b>Scanning Electron Microscope (SEM)</b>', 'High-energy electron beam; detects secondary electrons', '$\\approx 1 - 5\\mathrm{~nm}$', '$\\approx 50,000 - 100,000\\times$', 'Fracture surfaces, 3D topography, deep depth of field. Nonconductors require thin conductive carbon/Au coating.'],
    ['<b>Transmission Electron Microscope (TEM)</b>', 'High-energy electrons transmitted through specimen', '$\\approx 0.1\\mathrm{~nm}$ ($1\\mathrm{~\\AA}$)', '$\\approx 1,000,000\\times$', 'Individual dislocations, atomic lattice fringes, precipitate structures. Requires ultra-thin foils ($\\\\lt 100\\mathrm{~nm}$).'],
    ['<b>Scanning Probe Microscope (SPM / AFM)</b>', 'Nanometer-sharp tip scanned across surface', '$\\approx 0.1\\mathrm{~nm}$ (atomic resolution)', '$\\gt 10^8\\times$', '3D nanometer topography, surface roughness. Operates in air, vacuum, or liquid without vacuum coating.']
  ]
)}

${tp('ASTM Grain Size Determination (Linear Intercept Method)')}
<p>Grain size profoundly influences yield strength via the <b>Hall-Petch relationship</b> ($\\sigma_y = \\sigma_0 + k_y d^{-1/2}$). Fine-grained metals are both stronger and tougher.</p>
<p>In the ASTM E112 linear intercept method, straight test lines of known total length $L_T$ are drawn across a micrograph at magnification $M$:</p>
<ol>
  <li>Count the total number of boundary intercepts $P$.</li>
  <li>Calculate the mean linear intercept length $\ell$:
    $$\\ell = \\frac{L_T}{P \\cdot M}$$</li>
  <li>Calculate the ASTM grain size number $G$ ($\ell$ in mm):
    $$G = -6.6457 \\log_{10}(\\ell) - 3.298$$</li>
  <li>The relationship to number of grains per square inch at $100\\times$ magnification ($n$) is:
    $$n = 2^{G-1} \\iff n_M = 2^{G-1} \\left(\\frac{100}{M}\\right)^2$$</li>
</ol>

${fig('grainsize', 'Microstructure simulation with superimposed test lines demonstrating the ASTM linear intercept method: counting boundary intercepts P along length LT to calculate mean grain size ℓ and ASTM number G.')}

${prob('Worked Problem 6', 'Determination of ASTM Grain Size Number (Callister Example 4.5)', H`
${pq('A photomicrograph taken at $M = 160\\times$ has a scale bar of $16\\mathrm{~mm}$ corresponding to $100\\ \\mu\\mathrm{m}$. Seven straight test lines with total length $L_T = 350\\mathrm{~mm}$ are drawn across the micrograph, yielding $P = 58$ boundary intercepts. Determine: (a) the mean intercept length $\\ell$; and (b) the ASTM grain size number $G$.')}
${pth('Use $\\ell = L_T / (P \\cdot M)$ in millimeters, then compute $G = -6.6457 \\log_{10}\\ell - 3.298$.')}
${psol(H`
<p><b>Step 1:</b> Calculate mean intercept length $\\ell$ in millimeters:</p>
$$\\ell = \\frac{L_T}{P \\cdot M} = \\frac{350\\mathrm{~mm}}{(58)(160)} = \\frac{350}{9280} = 0.0377\\mathrm{~mm} = 37.7\\ \\mu\\mathrm{m}$$
<p><b>Step 2:</b> Calculate $\\log_{10}(\\ell)$:</p>
$$\\log_{10}(0.0377) = -1.4237$$
<p><b>Step 3:</b> Calculate ASTM grain size number $G$:</p>
$$G = -6.6457 \\log_{10}(\\ell) - 3.298 = -6.6457(-1.4237) - 3.298 = 9.462 - 3.298 = 6.164 \\approx 6.2$$
<p>The specimen has an <b>ASTM grain size number $G \\approx 6$</b>.</p>
`)}
`)}

${chk('If Metal A has an ASTM grain size number G = 8 and Metal B has G = 4, which metal has smaller grains and higher yield strength?',
  'Metal A (G = 8). Higher ASTM grain size numbers indicate smaller grain diameters (n = 2^(G−1), so G=8 has 128 grains/in² at 100× vs G=4 which has only 8 grains/in²). By the Hall-Petch equation (σ_y ∝ d^(−1/2)), smaller grains provide more boundary barriers to dislocation motion, giving Metal A higher yield strength.')}
`
});
