/* ══════════════════════════════════════════════════════════════════
   REVIEW — the night before the exam.
   Not a second copy of the course: only what gets written on a script.
   Every tile is one examinable claim, stated the way you would state it
   to the examiner. Nothing here needs to be unfolded or clicked.
   ══════════════════════════════════════════════════════════════════ */

/* twenty questions, both modules, chosen for what the paper keeps asking */
window.REVQ = [
  { q: 'Three alumina disks differ only in microstructure. Which is opaque?',
    o: ['The single crystal', 'The dense polycrystal', 'The porous polycrystal', 'All three equally'], a: 2,
    why: 'Pores scatter light far more strongly than grain boundaries do, so the porous specimen is opaque. Single crystal = transparent, dense polycrystal = translucent.' },
  { q: 'At the equilibrium separation $r_0$, which statement is true?',
    o: ['$E_N$ is maximum and $F_N=0$', '$E_N$ is minimum and $F_N=0$', 'Both $E_N$ and $F_N$ are minimum', '$F_N$ is maximum and $E_N=0$'], a: 1,
    why: '$F_N = dE_N/dr$, so the net force vanishes exactly where the energy curve is flat — its minimum, the bottom of the well.' },
  { q: 'Which feature of the energy well sets the elastic modulus?',
    o: ['Its depth', 'Its curvature at the minimum', 'Its asymmetry', 'The value of $r_0$'], a: 1,
    why: 'Depth → melting point, curvature → stiffness, asymmetry → thermal expansion. $E \\propto (dF_N/dr)_{r_0}$.' },
  { q: 'Why is diamond much less dense than copper despite carbon being a light, strongly bonded solid?',
    o: ['Its bonds are weak', 'Covalent bonds are directional, forcing an open structure of coordination 4',
        'It contains trapped pores', 'Carbon atoms are unusually large'], a: 1,
    why: 'Directional sp³ bonds fix the angle at 109.5° and limit coordination to 4, giving a packing factor of only 0.34 against 0.74 for close-packed metals.' },
  { q: 'Metals are ductile chiefly because',
    o: ['their bonds are weak', 'metallic bonding is non-directional, so planes can slide without breaking the bond',
        'they contain no defects', 'their atoms are small'], a: 1,
    why: 'The electron sea holds the cores together regardless of how they are arranged, so slipping one plane over another does not destroy the bonding.' },
  { q: 'Order the secondary bonds from weakest to strongest.',
    o: ['hydrogen &lt; permanent dipole &lt; polar-induced &lt; fluctuating induced',
        'fluctuating induced &lt; polar-induced &lt; permanent dipole &lt; hydrogen',
        'polar-induced &lt; fluctuating induced &lt; hydrogen &lt; permanent dipole',
        'they are all of equal strength'], a: 1,
    why: 'Fluctuating induced dipoles are the weakest van der Waals interaction; the hydrogen bond is the strongest secondary bond, reaching about 51 kJ/mol in water.' },
  { q: 'Water expands on freezing because in ice each molecule is',
    o: ['packed more closely, coordination 12', 'held by four rigid hydrogen bonds in an open hexagonal cage, coordination 4',
        'ionically bonded', 'randomly arranged with coordination 4.5'], a: 1,
    why: 'The four directional hydrogen bonds force an open cage with hollow channels. Volume rises about 9 % and the density falls to 0.917 g/cm³, so ice floats.' },
  { q: 'For a bond with $X_A - X_B = 2.0$, the percent ionic character is closest to',
    o: ['3.9 %', '39 %', '63 %', '94 %'], a: 2,
    why: '$\\%IC = \\{1 - \\exp[-0.25(4.0)]\\}\\times100 = (1 - 0.368)\\times100 = 63.2\\%$.' },
  { q: 'A randomly oriented polycrystalline metal is isotropic because',
    o: ['each grain is itself isotropic', 'the grains are very small',
        'the anisotropy of individual grains averages out over many random orientations',
        'grain boundaries have no structure'], a: 2,
    why: 'Each grain is anisotropic, but with no preferred orientation the directional differences cancel in the bulk. A textured material is anisotropic again.' },
  { q: 'Which set of reflections is allowed for a BCC metal?',
    o: ['111, 200, 220, 311', '110, 200, 211, 220', '100, 110, 111, 210', '111, 210, 300, 410'], a: 1,
    why: 'BCC allows only $h+k+l$ even. The set 111, 200, 220, 311 is the FCC rule — all odd or all even.' },
  { q: 'A diffractogram shows a peak at $2\\theta = 44.5°$. What goes into Bragg’s law?',
    o: ['44.5°', '22.25°', '89.0°', '45.5°'], a: 1,
    why: 'The chart axis is $2\\theta$. Halve it: $\\theta = 22.25°$. Using 44.5° directly is the single most common error in this paper.' },
  { q: 'Silica glass and quartz differ in that',
    o: ['glass contains no SiO₄⁴⁻ tetrahedra', 'glass has the same tetrahedra but no long-range order',
        'quartz is amorphous', 'glass has a different chemical formula'], a: 1,
    why: 'Both are networks of the same SiO₄⁴⁻ tetrahedron. Only quartz repeats that unit periodically; rapid cooling freezes the disordered network into glass.' },
  { q: 'Vacancies exist at equilibrium in every crystal above 0 K because',
    o: ['they cost no energy to create', 'the configurational entropy gain outweighs the enthalpy cost, lowering $\\Delta G$',
        'atoms evaporate from the interior', 'they are left over from solidification'], a: 1,
    why: 'Creating a vacancy costs enthalpy, but spreading vacancies over $N$ sites adds large configurational entropy. The $-T\\Delta S$ term drives $\\Delta G$ to a minimum at a non-zero concentration.' },
  { q: 'Raising the temperature of a metal from 20 °C to 1000 °C changes the vacancy concentration by roughly',
    o: ['a factor of 50', 'a factor of 1000', 'about 12 orders of magnitude', 'no change'], a: 2,
    why: 'The exponential is brutal: for $Q_v = 0.9$ eV the ratio is about $10^{12}$. This is exactly the standard numerical in Paper II.' },
  { q: 'Which is NOT one of the Hume-Rothery rules?',
    o: ['Atomic radii within 15 %', 'Same crystal structure', 'Similar electronegativity', 'Identical melting points'], a: 3,
    why: 'The four rules are size within 15 %, same crystal structure, similar electronegativity and similar valence. Melting point does not appear.' },
  { q: 'For an edge dislocation, the Burgers vector is',
    o: ['parallel to the dislocation line', 'perpendicular to the dislocation line', 'at 45° to the line', 'zero'], a: 1,
    why: 'Edge: $\\mathbf{b} \\perp$ line. Screw: $\\mathbf{b} \\parallel$ line. Mixed dislocations lie in between.' },
  { q: 'Plastic deformation by dislocation slip needs far less stress than shearing a whole plane because',
    o: ['dislocations are weaker atoms', 'only one row of bonds breaks at a time, reforming behind the dislocation',
        'slip happens at the surface only', 'the crystal melts locally'], a: 1,
    why: 'Breaking a whole plane at once would need about $G/10$. Moving a dislocation one row at a time lowers the required stress by roughly three orders of magnitude.' },
  { q: 'In a small-angle tilt boundary with Burgers vector $b$ and dislocation spacing $D$, the misorientation is',
    o: ['$\\theta = bD$', '$\\theta = b/D$', '$\\theta = D/b$', '$\\theta = b + D$'], a: 1,
    why: 'The boundary is a vertical wall of edge dislocations; the tilt angle is $\\theta = b/D$. Closer spacing means a larger misorientation.' },
  { q: 'Which instrument would you use to image individual dislocations?',
    o: ['Optical microscope', 'Scanning electron microscope', 'Transmission electron microscope', 'The naked eye'], a: 2,
    why: 'TEM resolves to about 0.1 nm through an ultra-thin foil, which is what dislocation imaging requires. SEM (1–5 nm) shows surface topography; OM stops at about 0.2 μm.' },
  { q: 'A specimen has ASTM grain size number $G = 8$; another has $G = 4$. Which is stronger, and why?',
    o: ['$G=4$, because its grains are smaller', '$G=8$, because its grains are smaller and boundaries obstruct dislocations',
        '$G=4$, because it has fewer boundaries', 'They are identical in strength'], a: 1,
    why: 'Larger $G$ means more grains per unit area, so finer grains. More grain-boundary area obstructs dislocation motion, raising the yield strength.' }
];

const rvt = (head, body) => `<div class="rvt"><b>${head}</b><span>${body}</span></div>`;
const rvtiles = items => `<div class="rvtiles">${items.map(([h, b]) => rvt(h, b)).join('')}</div>`;
const rvsec = (id, kicker, title, sub) =>
  `<section class="rvsec" id="${id}"><div class="rvk">${kicker}</div><h2>${title}</h2>${sub ? `<p class="rvsub">${sub}</p>` : ''}`;
const rvend = '</section>';
const rvstrip = items =>
  `<div class="rvstrip">${items.map(([a, b]) => `<div><b>${a}</b><span>${b}</span></div>`).join('')}</div>`;

window.REVIEW = `
<div class="rvhero">
  <div class="rvk">last pass</div>
  <h1>Everything that actually <em>gets asked</em></h1>
  <p>Modules I &amp; II compressed to what fits on one night. Read top to bottom once,
     look at the four diagrams until each one is obvious, then take the quiz at the end.
     If a question there catches you, the answer is in the tile above it.</p>
  <div class="rvjump">
    <a href="#rv-bond">Bonding</a>
    <a href="#rv-cryst">Crystals &amp; defects</a>
    <a href="#rv-eq">Formulas</a>
    <a href="#rv-num">Numbers</a>
    <a href="#rv-trap">Traps</a>
    <a href="#rv-quiz">Quiz</a>
  </div>
</div>

${rvsec('rv-open', 'the one idea', 'Structure decides properties',
  'If you remember one sentence from this paper, make it this one.')}
${rvtiles([
  ['Materials <em>science</em>', 'Investigates <b>why</b> a structure gives a property. Cause and effect.'],
  ['Materials <em>engineering</em>', 'Designs or alters the structure to <b>get</b> a wanted property. Means to an end.'],
  ['The four-link chain', '<b>processing → structure → properties → performance.</b> Change any link, the next one moves.'],
  ['The proof', 'Three alumina disks, identical chemistry: single crystal is <b>transparent</b>, dense polycrystal <b>translucent</b>, porous polycrystal <b>opaque</b>. Only the structure differed.'],
  ['Structure, by scale', 'subatomic → atomic → <b>nano</b> (&lt; 100 nm) → <b>micro</b> (needs a microscope) → macro (naked eye).'],
  ['Why it earns marks', 'Almost every "explain why material X is Y" answer is: name the structural feature, then link it to the property.']
])}
${rvend}

${rvsec('rv-bond', 'module I', 'Atomic bonding',
  'Four bonds, one energy curve. Get the strip below into your head and half of Module I is done.')}

${fig('rv_bonds', 'The four bonds in the order you should recall them. Bond energy is the column that matters — it sets melting point, stiffness and hardness together.')}

${rvtiles([
  ['Force and energy', '$F_N = dE_N/dr$. At $r_0$ the forces cancel: $F_N = 0$ <b>and</b> $E_N$ is at its minimum. That is the equilibrium spacing, ≈ 0.3 nm.'],
  ['Ionic', 'Metal <b>gives</b>, non-metal <b>takes</b>. Coulombic, <b>non-directional</b>, both ions reach noble-gas shells. Hard, brittle, insulating, high $T_m$.'],
  ['Covalent', 'Electrons <b>shared</b>. <b>Directional</b> — fixed bond angles (sp³ at 109.5°, sp² at 120°). Open, low-density structures: diamond packs at only 0.34.'],
  ['Metallic', 'Ion cores in a <b>sea of delocalised valence electrons</b>. Non-directional, so planes slide → <b>ductile</b>; free electrons → conducts heat and charge.'],
  ['Secondary (van der Waals)', 'Weak dipole attraction, 4–40 kJ/mol. Order of strength: fluctuating induced &lt; polar-induced &lt; permanent dipole &lt; <b>hydrogen bond</b>.'],
  ['Why polymers are soft', 'Strong covalent bonds <b>along</b> the chain, feeble van der Waals <b>between</b> chains. Heating only has to break the weak ones.']
])}

${fig('rv_well', 'Three separate exam questions are answered by one curve — depth, curvature and asymmetry. Point to the feature, then name the property.')}

${rvtiles([
  ['Depth → melting point', 'The well depth is the bonding energy $E_0$: the energy needed to pull the pair to infinity. Deep well → more thermal energy to break it → high $T_m$.'],
  ['Curvature → stiffness', '$E \\propto (dF_N/dr)_{r_0}$. A narrow, sharply curved well resists stretching hard → large elastic modulus.'],
  ['Asymmetry → expansion', 'Repulsion rises far more steeply than attraction falls. Heat the solid and the <b>midpoint</b> of each vibration shifts outward → thermal expansion. A symmetric well would give $\\alpha_l = 0$.'],
  ['Water’s 9 %', 'In ice each O is locked into <b>four</b> rigid hydrogen bonds — an open hexagonal cage (CN exactly 4.0 vs ≈ 4.5 in the liquid). Volume rises ≈ 9 %, $\\rho = 0.917$ g/cm³, so ice floats. Liquid water is densest at <b>3.98 °C</b>.'],
  ['Mixed bonding', 'Real bonds are blends. Pauling: $\\%\\mathrm{IC} = \\{1 - \\exp[-0.25(X_A - X_B)^2]\\}\\times 100$. Large electronegativity gap → ionic; small gap → covalent.'],
  ['Bonding tetrahedron', 'Four vertices — ionic, covalent, metallic, van der Waals. Ceramics sit on the ionic–covalent edge, semiconductors near covalent, polymers between covalent and van der Waals.']
])}
${rvend}

${rvsec('rv-cryst', 'module II', 'Crystals, defects, microstructure',
  'Module II is one story: a real crystal is never perfect, and every imperfection buys you a property.')}

${rvtiles([
  ['Single crystal', 'Periodicity unbroken across the whole specimen. Grows flat natural faces. <b>Anisotropic</b> — the modulus depends on direction.'],
  ['Polycrystal', 'Many grains, each a small crystal at a random orientation, meeting at <b>grain boundaries</b>. Randomly oriented grains average out → the bulk behaves <b>isotropically</b>.'],
  ['How grains are born', 'Solidification in four stages: <b>nuclei</b> form → <b>crystallites grow</b> → grains <b>impinge</b> → grain structure is frozen in. Grain shape records where growth stopped.'],
  ['Anisotropy, concretely', 'In cubic metals $E$ is largest along $[111]$ and smallest along $[100]$ — except tungsten, which is very nearly isotropic.'],
  ['Noncrystalline solids', 'Same building block, no long-range order. Silica <b>glass</b> and <b>quartz</b> are both networks of SiO₄⁴⁻ tetrahedra; only quartz repeats. Fast cooling freezes in the disorder.'],
  ['Why we care about defects', 'Vacancies drive diffusion, dislocations allow slip, grain boundaries block it. Strength is engineered by controlling defects, not by removing them.']
])}

${fig('rv_defects', 'Sort every imperfection by dimension. An essay on "crystal defects" is this diagram, expanded one panel at a time.')}

${rvtiles([
  ['Vacancies are unavoidable', '$N_v = N\\exp(-Q_v/kT)$ with $N = N_A\\rho/A$. Creating one costs enthalpy but the configurational <b>entropy</b> gain makes $\\Delta G$ negative, so every crystal above 0 K has some. Near $T_m$, about <b>1 site in 10 000</b> is empty.'],
  ['Self-interstitial', 'A host atom squeezed into a void. It distorts the lattice severely, so it is far rarer than a vacancy.'],
  ['Solid solutions', 'Solute keeps the solvent structure. <b>Substitutional</b> — solute replaces a host atom. <b>Interstitial</b> — small solute (H, C, N, O) fits into the holes.'],
  ['Hume-Rothery rules', 'Complete substitutional solubility needs: size difference <b>≤ 15 %</b>, the <b>same crystal structure</b>, similar <b>electronegativity</b>, and similar <b>valence</b> — a metal dissolves a higher-valence metal more readily.'],
  ['Edge vs screw', '<b>Edge</b>: an extra half-plane ends at the slip plane, $\\mathbf{b} \\perp$ line, compression above and tension below. <b>Screw</b>: a helical ramp, $\\mathbf{b} \\parallel$ line. Real dislocations are <b>mixed</b>.'],
  ['Why slip is easy', 'Shearing a whole plane at once would need ≈ $G/10$. A dislocation breaks one row of bonds at a time and reforms them behind — three orders of magnitude cheaper.'],
  ['Grain boundaries', 'Mismatched atoms, so higher energy. A <b>small-angle tilt</b> boundary is literally a stack of edge dislocations, spacing $D$, with $\\theta = b/D$. A <b>twin</b> boundary is a mirror plane — the lowest-energy boundary of all.'],
  ['Finer grains, stronger metal', 'Boundaries obstruct dislocations. More boundary area → higher yield strength. Remember: a <b>larger</b> ASTM number $G$ means <b>smaller</b> grains.']
])}

${fig('rv_xrd', 'Left: where Bragg’s law comes from. Right: which reflections a cubic metal is allowed to give — and the mistake that costs the most marks in this paper.')}

${rvtiles([
  ['Bragg’s law', '$n\\lambda = 2d_{hkl}\\sin\\theta$. Constructive interference when the extra path travelled by the lower ray is a whole number of wavelengths.'],
  ['Cubic spacing', '$d_{hkl} = a/\\sqrt{h^2+k^2+l^2}$. Combine the two and one measured peak gives you the lattice parameter.'],
  ['The diffractometer', 'X-ray source, rotating specimen, and a counter that moves at <b>twice</b> the specimen’s angular speed — which is why the chart records $2\\theta$.'],
  ['Microscopy, ranked', '<b>OM</b> ≈ 0.2 μm, up to 2000×, polished and etched surface. <b>SEM</b> 1–5 nm, 3-D topography, needs a conducting surface. <b>TEM</b> ≈ 0.1 nm, shows dislocations, needs an ultra-thin foil. <b>SPM</b> resolves single atoms and returns a true 3-D surface map.'],
  ['Why etching shows grains', 'Grain boundaries dissolve faster than grain interiors, so they become grooves that scatter light away from the lens — dark lines on a bright field.'],
  ['ASTM grain size', 'At 100×: $n = 2^{G-1}$ grains per square inch. At any other $M$: $n_M = 2^{G-1}(100/M)^2$. Intercept route: $\\ell = L_T/(P\\!\\cdot\\!M)$ then $G = -6.6457\\log_{10}\\ell - 3.298$.']
])}
${rvend}

${rvsec('rv-eq', 'write these cold', 'The formula sheet',
  'Nine equations carry every numerical mark in both modules.')}
<div class="scroll-x"><table class="ref rveq">
  <tr><th>What it gives you</th><th>Equation</th><th>Watch</th></tr>
  <tr><td>Coulomb attraction</td><td>$E_A = -\\dfrac{A}{r},\\quad A = \\dfrac{1}{4\\pi\\varepsilon_0}|Z_1Z_2|e^2$</td><td>$e^2/4\\pi\\varepsilon_0 = 2.31\\times10^{-28}$ N·m²</td></tr>
  <tr><td>Net bonding energy at $r_0$</td><td>$E_0 = -\\dfrac{A}{r_0}\\left(1-\\dfrac{1}{n}\\right)$</td><td>$n\\approx 8$. Answer is negative; report eV as well as J</td></tr>
  <tr><td>Percent ionic character</td><td>$\\%\\mathrm{IC} = \\left\\{1-e^{-0.25(X_A-X_B)^2}\\right\\}\\times100$</td><td>Square the difference <em>before</em> the 0.25</td></tr>
  <tr><td>Bragg’s law</td><td>$n\\lambda = 2d_{hkl}\\sin\\theta$</td><td>$\\theta = (2\\theta)/2$ — halve the chart angle</td></tr>
  <tr><td>Interplanar spacing, cubic</td><td>$d_{hkl} = \\dfrac{a}{\\sqrt{h^2+k^2+l^2}}$</td><td>BCC: $h{+}k{+}l$ even · FCC: all odd or all even</td></tr>
  <tr><td>Equilibrium vacancies</td><td>$N_v = N e^{-Q_v/kT},\\quad N = \\dfrac{N_A\\rho}{A}$</td><td>$T$ in <b>kelvin</b>. $k = 8.62\\times10^{-5}$ eV/K</td></tr>
  <tr><td>Two temperatures, one ratio</td><td>$\\dfrac{N_v(T_2)}{N_v(T_1)} = \\exp\\!\\left[-\\dfrac{Q_v}{k}\\!\\left(\\dfrac{1}{T_2}-\\dfrac{1}{T_1}\\right)\\right]$</td><td>Saves you from ever computing $N$</td></tr>
  <tr><td>wt% → at%</td><td>$C_1' = \\dfrac{C_1A_2}{C_1A_2+C_2A_1}\\times100$</td><td>The <em>other</em> element’s mass sits on top</td></tr>
  <tr><td>ASTM grain size</td><td>$n = 2^{G-1}$ at 100× ·  $G = -6.6457\\log_{10}\\ell - 3.298$</td><td>$\\ell$ in <b>mm</b>. Bigger $G$ = smaller grains</td></tr>
  <tr><td>Tilt boundary</td><td>$\\theta = b/D$</td><td>Small-angle boundaries only</td></tr>
</table></div>
${rvend}

${rvsec('rv-num', 'no derivation will save you', 'Numbers worth memorising')}
${rvstrip([
  ['k', '8.62×10⁻⁵ eV/K'],
  ['1 eV', '1.602×10⁻¹⁹ J'],
  ['N<sub>A</sub>', '6.022×10²³ /mol'],
  ['e²/4πε₀', '2.31×10⁻²⁸ N·m²'],
  ['r₀', '≈ 0.3 nm'],
  ['Cu Kα', 'λ = 0.1542 nm'],
  ['ρ ice', '0.917 g/cm³, +9 %'],
  ['water densest', '3.98 °C'],
  ['sp³ / sp²', '109.5° / 120°'],
  ['FCC / BCC packing', '0.74 · diamond 0.34'],
  ['OM · SEM · TEM', '0.2 μm · 1–5 nm · 0.1 nm'],
  ['vacancies at T<sub>m</sub>', '≈ 1 in 10⁴']
])}
${rvend}

${rvsec('rv-trap', 'where marks get lost', 'The five traps',
  'Every one of these has cost somebody a whole question.')}
<ol class="rvtrap">
  <li><b>Celsius into the exponential.</b> $\\exp(-Q_v/kT)$ needs <b>kelvin</b>. Add 273 first — in Celsius the answer is wrong by orders of magnitude, and 20 °C is not "roughly 20 K".</li>
  <li><b>2θ used as θ.</b> The horizontal axis of every diffractogram is $2\\theta$. Halve it before it goes into $n\\lambda = 2d\\sin\\theta$.</li>
  <li><b>Swapping the reflection rules.</b> BCC needs $h{+}k{+}l$ <b>even</b> (110, 200, 211). FCC needs the indices <b>all odd or all even</b> (111, 200, 220). Writing 110 for an FCC metal loses the mark.</li>
  <li><b>Burgers vector orientation.</b> Edge: $\\mathbf{b} \\perp$ the dislocation line. Screw: $\\mathbf{b} \\parallel$ the line. Say which you mean and say it the right way round.</li>
  <li><b>ASTM direction.</b> A <b>larger</b> $G$ means <b>smaller</b> grains and a <b>stronger</b> metal. $G=8$ is finer and stronger than $G=4$.</li>
</ol>
${rvend}

${rvsec('rv-quiz', 'twenty questions', 'Check yourself',
  'Rapid-fire, both modules, no working required. Anything you miss, reread the tile it came from.')}
${omr('Exam-night rapid check', window.REVQ)}
${rvend}

<p class="rvclose">That is the whole paper’s worth of recall. Sleep — it consolidates better than one more pass.</p>
`;
