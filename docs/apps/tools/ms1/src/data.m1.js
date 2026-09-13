/* ═══════════════════ MODULE I: MATERIALS, FORCES & BONDING ═══════════════════ */

/* ── 1. m1-what: What is Materials Science & Engineering? ── */
STATIONS.push({
  id: 'm1-what',
  mod: 'Module I', modName: 'Materials, Forces & Bonding', modClass: 'm1',
  title: 'Materials Science vs Engineering & Structural Scales',
  short: 'What is Materials Science?',
  est: '~15 min',
  body: H`
${gist('Materials Science investigates <b>structure–property relationships</b>; Materials Engineering designs structure to produce <b>predetermined performance</b>.')}

${carry(
  ['Atomic number Z, mass number A, electronic configuration 1s² 2s² 2p⁶', 'Class 12 states of matter: solids, liquids, gases', 'Basic SI units of force (N), energy (J), stress/modulus (Pa)'],
  ['The Processing → Structure → Properties → Performance tetrahedron', 'Length scale hierarchy: subatomic, atomic, nanostructure, microstructure, macrostructure', 'Why identical composition yields different optical transparency (Al₂O₃ disks)']
)}

${tp('Materials Science vs. Materials Engineering')}
<p>Although the terms are often blended, they represent two complementary halves of the discipline:</p>
<ul>
  <li><b>Materials Science:</b> Investigates the relationships that exist between the <em>structures</em> and <em>properties</em> of materials. It asks fundamental scientific questions: <em>"Why does this atomic arrangement give high ductility? Why does this alloy shatter at low temperature?"</em></li>
  <li><b>Materials Engineering:</b> On the basis of these structure–property correlations, designs or engineers the structure of a material to produce a predetermined set of properties that achieve target product performance.</li>
</ul>

${must(`<b>The 4 Interrelated Components (The Materials Tetrahedron):</b><br>
$$\\mathrm{Processing} \\longrightarrow \\mathrm{Structure} \\longrightarrow \\mathrm{Properties} \\longrightarrow \\mathrm{Performance}$$
Processing determines structure; structure dictates properties; properties govern final engineering performance.`)}

${tp('Hierarchy of Structural Scales')}
<p>Structure refers to the arrangement of internal components across multiple orders of magnitude:</p>
${tbl(
  ['Structural Scale', 'Typical Dimension', 'Components / What You Examine', 'Observation Instrument'],
  [
    ['<b>Subatomic structure</b>', '$\\lt 0.2\\mathrm{~nm}$ ($10^{-15}$ to $10^{-10}\\mathrm{~m}$)', 'Electrons inside individual atoms and their interactions with atomic nuclei', 'Spectroscopic techniques, synchrotron'],
    ['<b>Atomic structure</b>', '$\\approx 0.1 - 1\\mathrm{~nm}$ ($10^{-10}$ to $10^{-9}\\mathrm{~m}$)', 'Organization of atoms or molecules relative to one another (crystals, unit cells)', 'X-ray diffraction (XRD), high-resolution TEM'],
    ['<b>Nanostructure</b>', '$\\lt 100\\mathrm{~nm}$ ($10^{-9}$ to $10^{-7}\\mathrm{~m}$)', 'Structural features between 1 and 100 nm (nanoparticles, quantum dots, thin films)', 'Scanning Probe Microscopy (SPM, AFM), TEM'],
    ['<b>Microstructure</b>', '$0.1 - 100\\ \\mu\\mathrm{m}$ ($10^{-7}$ to $10^{-4}\\mathrm{~m}$)', 'Large groups of atoms agglomerated into grains, precipitates, and phases', 'Optical microscope (OM), Scanning Electron Microscope (SEM)'],
    ['<b>Macrostructure</b>', '$\\gt 1\\mathrm{~mm}$ ($10^{-3}$ to $1\\mathrm{~m}$)', 'Structural elements that can be viewed directly with the naked eye', 'Direct visual inspection, radiography']
  ]
)}

${fig('scales', 'Structural levels, typical feature sizes, and useful resolution of characterization instruments across 16 orders of magnitude.')}

${tp('Case Study: Three Disks of Aluminum Oxide (Al₂O₃)')}
<p>To demonstrate that <b>processing dictates structure and structure dictates properties</b>, consider three circular disks of aluminum oxide (alumina, $\\mathrm{Al}_2\\mathrm{O}_3$), all identical in chemical composition and 4 mm thick:</p>
<ol>
  <li><b>Single-crystal sapphire:</b> Processed as one continuous unbroken lattice with zero internal grain boundaries and zero pores. It is <em>optically transparent</em> (newsprint beneath it is read easily).</li>
  <li><b>Dense polycrystalline alumina:</b> Composed of millions of microscopic single-crystal grains packed tightly without pores. It is <em>optically translucent</em> (light passes through, but boundary refractions blur text).</li>
  <li><b>Sintered porous alumina:</b> Contains $\\approx 5\\%$ tiny internal gas pores. It is <em>completely opaque</em> white—the refractive index mismatch between alumina ($n \\approx 1.76$) and air pores ($n = 1.0$) scatters all incident light.</li>
</ol>

${fig('alumina', 'Ray-tracing simulation of light passing through aluminum oxide disks: (1) single crystal allows straight ray passage; (2) polycrystal causes grain boundary refraction; (3) porous polycrystal exhibits severe interfacial scattering, producing complete opacity.')}

${trap(`<b>Where marks get lost in exams:</b> Never say "ceramics are opaque because they are made of alumina." Alumina is naturally transparent! Opacity is an <em>induced microstructure property</em> caused by light scattering at pore interfaces and grain boundaries.`)}

${tp('Why Study Materials Science? (Liberty Ship Case Study)')}
<p>Engineers do not simply pick a material that is strong; they must anticipate environmental degradation, cost, and service conditions.</p>
<div class="note why">
  <div class="nh">Historical Disaster: WWII Liberty Ships</div>
  During World War II, over 2,700 all-welded steel cargo ships were built in the United States. A significant number suffered catastrophic brittle fractures—many literally splitting in half while moored in cold water. Investigations revealed:
  <ul>
    <li>The steel used exhibited a <b>ductile-to-brittle transition temperature (DBTT)</b> near room temperature ($15-20^{\\circ}\\mathrm{C}$). In cold North Atlantic waters ($4^{\\circ}\\mathrm{C}$), the steel behaved like brittle glass.</li>
    <li>Welded construction allowed a running crack initiated at sharp hatch corners to propagate continuously around the entire hull without stopping. Riveted plates halt cracks at the joint.</li>
  </ul>
</div>

${chk('Why did the welded Liberty ships fracture catastrophically in cold water even though they passed tensile tests at room temperature?',
  'The steel possessed a high Ductile-to-Brittle Transition Temperature (DBTT). At room temperature it was ductile and tough, but below the DBTT in cold North Atlantic water, the impact energy absorbed dropped sharply, transforming the steel into a brittle material vulnerable to fast crack propagation.')}
`
});

/* ── 2. m1-classes: Classification of Materials ── */
STATIONS.push({
  id: 'm1-classes',
  mod: 'Module I', modName: 'Materials, Forces & Bonding', modClass: 'm1',
  title: 'Classification of Materials: Metals, Ceramics, Polymers & Composites',
  short: 'Material Classes',
  est: '~18 min',
  body: H`
${gist('Engineering materials fall into three primary categories based on bonding and chemistry: <b>metals</b>, <b>ceramics</b>, and <b>polymers</b>, plus <b>composites</b> combining them.')}

${tp('The Three Primary Classes & Composites')}
${tbl(
  ['Class', 'Atomic Bonding', 'Defining Characteristics', 'Representative Examples'],
  [
    ['<b>Metals</b>', 'Metallic bonding (delocalized valence electron sea)', 'High electrical & thermal conductivity; high stiffness & strength; ductile and deformable; high fracture toughness; dense.', 'Iron, Copper, Aluminum, Titanium, Gold, Steels, Brass'],
    ['<b>Ceramics</b>', 'Ionic and/or covalent bonding', 'Compounds of metallic and nonmetallic elements (oxides, nitrides, carbides); thermally and electrically insulating; hard, stiff, and wear-resistant; extremely brittle; high melting temperature.', 'Alumina (Al₂O₃), Silica (SiO₂), Silicon carbide (SiC), Silicon nitride (Si₃N₄), table salt (NaCl)'],
    ['<b>Polymers</b>', 'Covalent backbone with secondary van der Waals/hydrogen intermolecular links', 'Organic compounds based on carbon/hydrogen/oxygen chains; very low density; flexible and ductile; low elastic modulus; low melting/decomposition temperatures; chemically inert.', 'Polyethylene (PE), Polypropylene (PP), Polystyrene (PS), Teflon (PTFE), Polyvinyl chloride (PVC), Nylon'],
    ['<b>Composites</b>', 'Combined (two or more distinct materials)', 'Composed of a matrix phase and a dispersed reinforcement phase; engineered to display a combination of properties not possessed by any single material (e.g. high stiffness-to-weight ratio).', 'Fiberglass (glass fibers in polymer), Carbon Fiber Reinforced Polymer (CFRP), Cermets, Wood, Concrete']
  ]
)}

${fig('classbars', 'Comparison of typical property ranges across metals, ceramics, polymers, and composites: density, elastic modulus, yield strength, and electrical conductivity.')}

${tp('Ashby Chart: Elastic Modulus vs. Density')}
<p>In aerospace and automotive design, the governing selection criterion is rarely strength alone—it is <b>specific stiffness</b> ($E/\\rho$) or <b>specific strength</b> ($\\sigma_y/\\rho$). The Ashby chart plots Young’s modulus $E$ against density $\\rho$ on log–log axes:</p>

${fig('ashby', 'Ashby property map: Young’s Modulus E vs. Density ρ showing material family bubbles and diagonal design guide lines for minimum-weight structures.')}

${tp('Case Study: Carbonated Beverage Containers')}
<p>The engineering requirements for a 355 mL carbonated drink container highlight the trade-offs between material classes:</p>
${tbl(
  ['Candidate Material', 'Key Advantages', 'Limiting Disadvantages', 'Current Market Role'],
  [
    ['<b>Aluminum alloy</b> (Metal)', 'Hermetic gas barrier (holds CO₂ indefinitely); opaque (protects flavor from UV light); fast chilling; highly recyclable with 95% energy saving.', 'Opaque (cannot view contents); requires internal organic coating to prevent acid reaction; denting.', 'Leading choice for single-serving cans.'],
    ['<b>Soda-lime glass</b> (Ceramic)', 'Chemically inert (zero taste transfer); completely impermeable to gas; transparent; rigid and reusable.', 'Heavy (high transport fuel cost); brittle (shatters on drop impact); high melting energy.', 'Premium beverages, wines, reusable bottles.'],
    ['<b>Polyethylene terephthalate - PET</b> (Polymer)', 'Extremely light; shatterproof on drop impact; transparent; low production energy; easily molded.', 'Permeable to CO₂ and O₂ (beverage goes flat over 3–6 months); low heat resistance.', 'Dominant choice for bulk, portable, and family-sized bottles.']
  ]
)}

${chk('Why does beer go flat faster in a PET plastic bottle than in an aluminum can or glass bottle?',
  'Polymer chains in PET are held together by weak secondary van der Waals bonds with intermolecular gaps through which small gas molecules like CO₂ and O₂ can slowly diffuse. Metals and ceramics have tightly packed crystalline lattices that are completely impermeable to gas.')}
`
});

/* ── 3. m1-adv: Advanced Materials ── */
STATIONS.push({
  id: 'm1-adv',
  mod: 'Module I', modName: 'Materials, Forces & Bonding', modClass: 'm1',
  title: 'Advanced Materials: Semiconductors, Biomaterials, Smart & Nanomaterials',
  short: 'Advanced Materials',
  est: '~15 min',
  body: H`
${gist('Advanced materials are high-tech materials engineered for cutting-edge applications: semiconductors, biomaterials, smart materials, and nanomaterials.')}

${tp('Semiconductors & Biomaterials')}
<ul>
  <li><b>Semiconductors:</b> Possess electrical properties intermediate between electrical conductors (metals) and insulators (ceramics). Their electrical conductivity is exceptionally sensitive to the presence of minute concentrations of impurity atoms (dopants on the order of parts per billion). Silicon (Si), Germanium (Ge), Gallium Arsenide (GaAs), and Indium Phosphide (InP) form the bedrock of integrated circuitry.</li>
  <li><b>Biomaterials:</b> Materials designed for implantation into the human body to replace diseased or damaged body components. The indispensable requirement is <b>biocompatibility</b>—they must not produce toxic reactions, release harmful ions, or trigger biological rejection by host tissues. Examples: Ti-6Al-4V hip implants, cobalt-chromium alloys, hydroxyapatite coatings, silicone breast implants.</li>
</ul>

${tp('Smart (Intelligent) Materials')}
<p>A smart system consists of a <b>sensor</b> (detects environmental change) and an <b>actuator</b> (responds with a corrective action). The four major actuator material families are:</p>
${tbl(
  ['Smart Material Class', 'Stimulus & Actuation Mechanism', 'Key Applications'],
  [
    ['<b>Shape Memory Alloys (SMA)</b>', 'Thermoelastic martensitic phase transformation: deformed at low temperature, returns to original memory shape upon heating.', 'Cardiovascular stents, surgical wires, greenhouse window releases (Nitinol = Ni-Ti).'],
    ['<b>Piezoelectric Ceramics</b>', 'Direct effect: mechanical stress generates voltage. Converse effect: applied electric field induces physical strain.', 'Ultrasound transducers, quartz watches, precision positioning stages, spark igniters (PZT = Lead Zirconate Titanate).'],
    ['<b>Magnetostrictive Materials</b>', 'Change mechanical dimension in response to an applied magnetic field (and vice versa).', 'High-power sonar transducers, ultrasonic cleaning baths (Terfenol-D = Tb-Dy-Fe alloy).'],
    ['<b>Electrorheological (ER) & Magnetorheological (MR) Fluids</b>', 'Suspensions that transform reversibly from free-flowing liquid to semi-solid gel in milliseconds under an electric or magnetic field.', 'Active vehicular suspension dampers, robotic prosthetic knees, seismic vibration dampers in bridges.']
  ]
)}

${tp('Nanomaterials (Dimension < 100 nm)')}
<p>Nanomaterials possess at least one physical dimension smaller than $100\\mathrm{~nm}$ ($10^{-7}\\mathrm{~m}$). At this scale, two physical phenomena fundamentally alter behavior:</p>
<ol>
  <li><b>Huge Surface-to-Volume Ratio:</b> As particle diameter $D$ decreases, the ratio of surface atoms to bulk interior atoms scales as $6/D$. Because surface atoms have unfulfilled dangling bonds, chemical and catalytic reactivity skyrockets.</li>
  <li><b>Quantum Confinement Effects:</b> When dimensions approach the de Broglie wavelength of electrons, continuous energy bands break up into discrete quantum energy levels, changing optical absorption, bandgap, and magnetic properties (e.g. quantum dots change emission color purely by sizing).</li>
</ol>

${fig('nanosurf', 'Surface area and percentage of surface atoms vs particle diameter: a 10 nm gold cluster has over 20% of its atoms on the surface, dramatically altering melting point and catalytic properties.')}

${tp('Modern Materials Needs: Sustainability & Life Cycle')}
<p>Modern materials science must balance technical performance against finite resource constraints:</p>
<ul>
  <li><b>Energy Footprint:</b> Minimizing energy consumption in refining (e.g., recycling aluminum requires only $5\\%$ of the energy needed to extract primary aluminum from bauxite ore).</li>
  <li><b>Toxicity & Environment:</b> Replacing lead in solders (RoHS directive) and eliminating hexavalent chromium coatings.</li>
  <li><b>Cradle-to-Grave Analysis:</b> Life Cycle Assessment (LCA) evaluating raw material extraction, manufacturing, in-service durability, and end-of-life recyclability.</li>
</ul>

${chk('Why does a 5 nm gold nanoparticle appear red and melt at 700 °C, whereas bulk gold is yellow and melts at 1064 °C?',
  'Due to quantum size effects and the enormous surface-to-volume ratio. At 5 nm, surface atoms with high coordination deficit represent a substantial fraction of the total crystal, lowering the cohesive energy needed for melting. Concurrently, localized surface plasmon resonance shifts absorption from the UV into the green, making the transmitted light appear ruby red.')}
`
});

/* ── 4. m1-forces: Interatomic Forces & Potential Energy Wells ── */
STATIONS.push({
  id: 'm1-forces',
  mod: 'Module I', modName: 'Materials, Forces & Bonding', modClass: 'm1',
  title: 'Bonding Forces, Energies & Potential Energy Wells',
  short: 'Forces & Energy Wells',
  est: '~20 min',
  body: H`
${gist('The macroscopic properties of solids—melting point, elastic modulus, and thermal expansion—are direct mathematical manifestations of the <b>interatomic potential energy well</b>.')}

${tp('Net Interatomic Force and Equilibrium Spacing')}
<p>When two isolated neutral atoms approach from infinity, two opposing forces act between them:</p>
<ol>
  <li><b>Attractive Force ($F_A$):</b> Arises from electrostatic attraction between electrons and positively charged nuclei (or dipole interactions). Its magnitude dominates at large separation distances.</li>
  <li><b>Repulsive Force ($F_R$):</b> Arises when outer electron clouds overlap and the Pauli exclusion principle forces electrons into higher unoccupied quantum states. Its magnitude rises steeply at very close separation.</li>
</ol>
<p>The net force $F_N$ is the algebraic sum:</p>
${eq('F_N = F_A + F_R')}
<p>At the <b>equilibrium interatomic spacing $r_0$</b> (typically $\\approx 0.3\\mathrm{~nm}$ or $3\\mathrm{~\\AA}$), the attractive and repulsive forces exactly balance:</p>
${eq('F_N(r_0) = F_A(r_0) + F_R(r_0) = 0 \\implies |F_A(r_0)| = |F_R(r_0)|', 'Equilibrium Force')}

${fig('bondcurve', 'Net force F_N and potential energy E_N as a function of atomic separation r: equilibrium spacing r₀ occurs where F_N = 0 and E_N is at its global minimum −E₀.')}

${tp('Potential Energy Well & Derivation Ladder')}
<p>Potential energy $E_N$ is related to force by $F_N = -\\frac{dE_N}{dr}$, or equivalently:</p>
${eq('E_N = \\int_{\\infty}^r F_N\\, dr = \\int_{\\infty}^r F_A\\, dr + \\int_{\\infty}^r F_R\\, dr = E_A + E_R')}

${lad('Mathematical Derivation of Equilibrium State & Well Depth', [
  { why: 'Express net potential energy as the sum of attractive and repulsive contributions:',
    m: '$$E_N(r) = E_A(r) + E_R(r) = -\\frac{A}{r^m} + \\frac{B}{r^n} \\quad (n > m)$$' },
  { why: 'Apply the equilibrium condition: net force is zero, meaning slope of energy is zero:',
    m: '$$\\left(\\frac{dE_N}{dr}\\right)_{r=r_0} = 0 \\implies \\frac{m A}{r_0^{m+1}} - \\frac{n B}{r_0^{n+1}} = 0$$' },
  { why: 'Solve for the repulsive coefficient B in terms of equilibrium spacing r₀:',
    m: '$$B = \\frac{m}{n} A\\, r_0^{n-m}$$' },
  { why: 'Substitute B back into the net energy equation at r = r₀ to find bonding energy E₀:',
    m: '$$E_N(r_0) = -\\frac{A}{r_0^m} + \\frac{m A r_0^{n-m}}{n r_0^n} = -\\frac{A}{r_0^m}\\left(1 - \\frac{m}{n}\\right) = -E_0$$' }
])}

${tp('Macroscopic Properties Derived from the Well Curve')}
${tbl(
  ['Macroscopic Property', 'Microscopic Origin on the Energy Well Curve', 'Physical Explanation'],
  [
    ['<b>Melting Point ($T_m$)</b>', '<b>Well Depth ($E_0$):</b><br>Higher $E_0 \\implies$ Higher $T_m$', 'The bonding energy $E_0$ represents the energy required to pull atoms infinitely apart. Materials with large $E_0$ require much higher thermal vibrational energy ($kT_m$) to disrupt the solid lattice.'],
    ['<b>Elastic Modulus ($E$)</b>', '<b>Well Curvature / Force Slope at $r_0$:</b><br>$\\left(\\frac{dF}{dr}\\right)_{r_0} = -\\left(\\frac{d^2E_N}{dr^2}\\right)_{r_0}$', 'Stiffness is resistance to atomic displacement under stress. A steep, narrow potential well with large curvature produces a high restoring force per unit displacement, yielding a high Young’s modulus.'],
    ['<b>Thermal Expansion ($\\alpha_l$)</b>', '<b>Well Asymmetry (Anharmonicity):</b><br>Asymmetric well $\\implies$ High $\\alpha_l$<br>Deep symmetric well $\\implies$ Low $\\alpha_l$', 'Due to steep Born repulsion at $r \\lt r_0$ and shallower attraction at $r \\gt r_0$, the curve is asymmetric. As thermal energy increases, the midpoint of atomic oscillation shifts outward to larger mean separations $\\bar{r}$. A hypothetical perfectly symmetric well would have zero thermal expansion!']
  ]
)}

${fig('wells', 'Comparison of deep vs shallow potential wells: deep symmetric well (ceramic) gives high Tm, high modulus E, and low thermal expansion; shallow asymmetric well (polymer) gives low Tm, low E, and high thermal expansion.')}

${chk('Why would a solid whose atoms interact via a perfectly parabolic, symmetric potential well have a thermal expansion coefficient of exactly zero?',
  'Because in a symmetric well, as temperature increases and vibrational amplitude expands, the atom spends equal time displaced to the left (−Δr) and right (+Δr). The mean interatomic separation r̄ remains identical to r₀ at all temperatures. Real solids expand only because repulsion is much steeper than attraction, shifting the vibrational mean outward.')}
`
});

/* ── 5. m1-ionic: Ionic Bonding ── */
STATIONS.push({
  id: 'm1-ionic',
  mod: 'Module I', modName: 'Materials, Forces & Bonding', modClass: 'm1',
  title: 'Ionic Bonding: Coulomb Forces, Born Repulsion & Lattice Energies',
  short: 'Ionic Bonding',
  est: '~20 min',
  body: H`
${gist('Ionic bonding is the electrostatic attraction between oppositely charged ions formed by <b>complete electron transfer</b> from metallic to nonmetallic atoms.')}

${tp('Mechanism & Coulomb Potential')}
<p>Ionic bonding always occurs between metallic elements (electropositive, low electronegativity) and nonmetallic elements (electronegative, high electron affinity):</p>
${eq('\\mathrm{Na~} (1s^2 2s^2 2p^6 3s^1) + \\mathrm{Cl~} (1s^2 2s^2 2p^6 3s^2 3p^5) \\longrightarrow \\mathrm{Na}^+ + \\mathrm{Cl}^-')}
<p>The attractive energy $E_A$ is pure Coulomb electrostatic potential:</p>
${eq('E_A = -\\frac{A}{r} = -\\frac{1}{4\\pi\\varepsilon_0}\\frac{|Z_1| e \\cdot |Z_2| e}{r}', 'Coulomb Attractive Energy')}
<p>where $\\varepsilon_0 = 8.854 \\times 10^{-12}\\mathrm{~F/m}$, $e = 1.602 \\times 10^{-19}\\mathrm{~C}$, giving the constant:</p>
${eq('\\frac{e^2}{4\\pi\\varepsilon_0} = 2.31 \\times 10^{-28}\\mathrm{~N}\\cdot\\mathrm{m}^2')}
<p>The repulsive energy follows the empirical Born-Mayer power law:</p>
${eq('E_R = \\frac{B}{r^n} \\quad (n \\approx 8 \\mathrm{~for~most~ionic~solids})', 'Born Repulsion')}

${fig('naclform', 'How the bond actually forms, step by step: neutral Na and Cl → the 3s electron transfers → Na⁺ shrinks to a neon core while Cl⁻ swells to an argon core → the Coulombic attraction acts equally in every direction.')}

${fig3d('nacl', 'Rotating 3D unit cell of Sodium Chloride (NaCl): face-centered cubic lattice with alternating Na⁺ (bronze) and Cl⁻ (blue) ions. Every ion has a coordination number of 6.')}

${tp('Properties of Ionic Solids')}
<ul>
  <li><b>Nondirectional Bonding:</b> Electrostatic fields radiate uniformly in all spherical directions. Ions surround themselves with as many oppositely charged neighbors as geometric size ratios ($r_{\\mathrm{cation}}/r_{\\mathrm{anion}}$) allow.</li>
  <li><b>High Bond Energy & Melting Points:</b> Typically $600 - 1500\\mathrm{~kJ/mol}$ ($3 - 8\\mathrm{~eV/atom}$). E.g., NaCl melts at $801^{\\circ}\\mathrm{C}$; MgO (with divalent $\\mathrm{Mg}^{2+}$ and $\\mathrm{O}^{2-}$ charges quadrupling the Coulomb product $|Z_1 Z_2| = 4$) melts at $2800^{\\circ}\\mathrm{C}$.</li>
  <li><b>Hard and Brittle:</b> Under mechanical shear, like-charged planes are forced past each other; like charges align ($++$ and $--$), generating massive electrostatic repulsion that cleaves the crystal catastrophically.</li>
  <li><b>Electrical Insulators in Solid State:</b> Electrons are firmly bound to anions; ions are trapped on lattice sites. When molten or dissolved in water, ions become mobile, creating excellent ionic conductors.</li>
</ul>

${prob('Worked Problem 1', 'Computation of Forces for K⁺ and Br⁻ Pair (Callister Example 2.2)', H`
${pq('For a $\\mathrm{K}^+ - \\mathrm{Br}^-$ ion pair, attractive and repulsive energies are given by $E_A = -1.436/r$ and $E_R = 7.32 \\times 10^{-6}/r^8$ ($E$ in eV, $r$ in nm). The ionic radii are $r_{\\mathrm{K}^+} = 0.138\\mathrm{~nm}$ and $r_{\\mathrm{Br}^-} = 0.196\\mathrm{~nm}$. Compute: (a) the equilibrium separation $r_0$; (b) the attractive force $F_A$; and (c) the repulsive force $F_R$ at $r_0$.')}
${pth('At equilibrium separation $r_0$, the net force is zero: $F_N(r_0) = F_A(r_0) + F_R(r_0) = 0$.')}
${psol(H`
<p><b>Part (a):</b> Equilibrium spacing is the sum of ionic radii:</p>
$$r_0 = r_{\\mathrm{K}^+} + r_{\\mathrm{Br}^-} = 0.138\\mathrm{~nm} + 0.196\\mathrm{~nm} = 0.334\\mathrm{~nm} = 3.34 \\times 10^{-10}\\mathrm{~m}$$
<p><b>Part (b):</b> The attractive force is the derivative of attractive energy:</p>
$$F_A = -\\frac{dE_A}{dr} = \\frac{d}{dr}\\left(\\frac{A}{r}\\right) = -\\frac{A}{r^2} \\quad \\mathrm{(or~with~magnitude~} F_A = +\\frac{A}{r_0^2}\\mathrm{)}$$
$$A = 1.436\\mathrm{~eV}\\cdot\\mathrm{nm} = (1.436)(1.602 \\times 10^{-19}\\mathrm{~J})(10^{-9}\\mathrm{~m}) = 2.30 \\times 10^{-28}\\mathrm{~N}\\cdot\\mathrm{m}^2$$
$$F_A = \\frac{2.30 \\times 10^{-28}\\mathrm{~N}\\cdot\\mathrm{m}^2}{(3.34 \\times 10^{-10}\\mathrm{~m})^2} = +2.07 \\times 10^{-9}\\mathrm{~N} = +2.07\\mathrm{~nN}$$
<p><b>Part (c):</b> At equilibrium, net force is zero:</p>
$$F_N = F_A + F_R = 0 \\implies F_R = -F_A = -2.07 \\times 10^{-9}\\mathrm{~N} = -2.07\\mathrm{~nN}$$
`)}
`)}

${chk('Why is the melting temperature of MgO (2800 °C) so much higher than that of NaCl (801 °C) even though both have the exact same rocksalt crystal structure?',
  'In the Coulomb attractive energy formula, E_A is proportional to the product of ion valences |Z₁ Z₂|. For Na⁺Cl⁻, |Z₁ Z₂| = (1)(1) = 1. For Mg²⁺O²⁻, |Z₁ Z₂| = (2)(2) = 4. The fourfold increase in electrostatic attraction deepens the potential well dramatically, requiring far higher thermal energy to melt.')}
`
});

/* ── 6. m1-cov: Covalent Bonding ── */
STATIONS.push({
  id: 'm1-cov',
  mod: 'Module I', modName: 'Materials, Forces & Bonding', modClass: 'm1',
  title: 'Covalent Bonding: Directionality, Hybridization & Allotropes',
  short: 'Covalent Bonding',
  est: '~20 min',
  body: H`
${gist('Covalent bonding arises from the <b>sharing of valence electrons</b> between adjacent atoms with overlapping quantum mechanical atomic orbitals.')}

${tp('Mechanism & Strict Directionality')}
<p>Covalent bonding occurs predominantly between nonmetallic atoms of similar electronegativity. By sharing electrons, each atom achieves a stable octet (noble gas configuration):</p>
<p>Unlike ionic and metallic bonds, covalent bonds are <b>strictly directional</b>: they exist only along specific crystallographic angles defined by the geometry of overlapping electron orbitals.</p>

${tp('sp³ and sp² Orbital Hybridization')}
<p>In carbon, the ground-state valence configuration $2s^2 2p_x^1 2p_y^1 2p_z^0$ has only two unpaired electrons. By promoting one $2s$ electron to the empty $2p_z$ orbital and hybridizing:</p>
<ul>
  <li><b>$sp^3$ Hybridization (Diamond & Methane):</b> One $2s$ and three $2p$ orbitals mix to form four equivalent $sp^3$ hybrid orbitals pointing toward the vertices of a regular tetrahedron with bond angle <b>$109.5^{\\circ}$</b>.</li>
  <li><b>$sp^2$ Hybridization (Graphite):</b> One $2s$ and two $2p$ orbitals mix to form three planar orbitals separated by <b>$120^{\\circ}$</b>, leaving one unhybridized $p_z$ orbital perpendicular to the sheet containing delocalized $\\pi$ electrons.</li>
</ul>

${fig('hybrid', 'Why carbon forms four bonds and not two: ground state → promotion of a 2s electron → hybridisation into four sp³ (or three sp² plus an unmixed p_z) orbitals. Step through it before looking at the models below.')}

<div class="grid2">
  <div>${fig3d('ch4', 'Methane (CH₄) molecule demonstrating tetrahedral sp³ orbital orientation with 109.5° H–C–H bond angles.')}</div>
  <div>${fig3d('diamond', 'Diamond crystal structure: 3D network of carbon atoms where every atom is covalently bonded to four neighbors via sp³ bonds.')}</div>
</div>

${fig3d('graphite', 'Graphite crystal structure: planar 2D hexagonal sheets held by strong sp² covalent bonds (120°), separated by weak van der Waals forces. Spin the model to observe the layered sheets.')}

${tp('Diamond vs. Graphite: Same Element, Contrasting Properties')}
${tbl(
  ['Property', 'Diamond (Allotrope of Carbon)', 'Graphite (Allotrope of Carbon)'],
  [
    ['<b>Hybridization & Geometry</b>', '$sp^3$ tetrahedral network ($109.5^{\\circ}$)', '$sp^2$ planar hexagonal sheets ($120^{\\circ}$) + van der Waals inter-sheet gap'],
    ['<b>Hardness</b>', 'Hardest known natural material (Mohs 10)', 'Very soft along shear planes (Mohs 1–2); dry solid lubricant'],
    ['<b>Electrical Conductivity</b>', 'Electrical insulator ($E_g = 5.5\\mathrm{~eV}$)', 'Semimetal / electrical conductor along basal planes due to delocalized $\\pi$ electrons'],
    ['<b>Thermal Conductivity</b>', 'Extremely high ($>2000\\mathrm{~W/m}\\cdot\\mathrm{K}$ at 300 K) via acoustic phonons', 'Very high along in-plane sheets, low across sheets'],
    ['<b>Bonding Energy & $T_m$</b>', '$713\\mathrm{~kJ/mol}$; $T_m > 3550^{\\circ}\\mathrm{C}$', 'In-plane covalent bond energy is even higher than diamond; sublimes $\\approx 3700^{\\circ}\\mathrm{C}$']
  ]
)}

${must(`<b>Concept Check 2.3: Why are covalent solids less dense than metals?</b><br>
Metals have nondirectional bonds where atoms pack like hard spheres to achieve maximum coordination numbers (CN = 12 for FCC/HCP). Covalent solids are constrained by directional hybrid bond angles, restricting coordination numbers to 4 (e.g. diamond CN = 4). This produces an open, hollow crystal framework with a low atomic packing factor (0.34 in diamond vs 0.74 in FCC).`)}

${chk('Why does graphite conduct electricity while diamond is an excellent electrical insulator?',
  'In diamond, all 4 valence electrons per carbon atom are locked in localized sp³ sigma bonds with a large bandgap of 5.5 eV. In graphite, only 3 valence electrons form sp² in-plane sigma bonds; the fourth electron resides in an unhybridized p_z orbital that delocalizes into an electron sea across the sheet, enabling rapid electrical conduction along basal planes.')}
`
});

/* ── 7. m1-metal: Metallic Bonding ── */
STATIONS.push({
  id: 'm1-metal',
  mod: 'Module I', modName: 'Materials, Forces & Bonding', modClass: 'm1',
  title: 'Metallic Bonding: The Electron Sea Model & Conduction',
  short: 'Metallic Bonding',
  est: '~15 min',
  body: H`
${gist('Metallic bonding is the electrostatic attraction between a regular lattice of <b>positive ion cores</b> and a surrounding <b>delocalized sea of valence electrons</b>.')}

${tp('The Electron Sea Model')}
<p>Metallic elements have few valence electrons that are loosely held by their nuclei. When solid metals condense:</p>
<ul>
  <li>Valence electrons detach from individual parent atoms and become delocalized, forming a pervasive <b>"electron sea"</b> or electron gas throughout the crystal.</li>
  <li>The remaining atoms become positively charged <b>ion cores</b> sitting on periodic lattice positions.</li>
  <li>The bond is completely <b>nondirectional</b>—the electron sea acts as a uniform electrostatic glue holding positive cores together regardless of spatial orientation.</li>
</ul>

${fig('esea', 'Dynamic electron sea simulation: positively charged metal ion cores (bronze spheres) enveloped by a continuously moving swarm of delocalized valence electrons (blue dots).')}

${tp('Physical Properties Explained by Metallic Bonding')}
<ol>
  <li><b>High Electrical Conductivity:</b> The valence electrons are not trapped in covalent bonds or localized on anions; an applied electric field accelerates them through the lattice with minimal resistance.</li>
  <li><b>High Thermal Conductivity:</b> Heat is transferred primarily by the rapid kinetic motion of the free electron gas ($K_e \\gg K_{\\mathrm{phonon}}$).</li>
  <li><b>Ductility & Malleability:</b> When shear stress displaces a row of ion cores past another row, the electron sea instantly flows to shield the like-charged cores from one another. No electrostatic cleavage occurs, allowing extensive plastic deformation without fracture.</li>
  <li><b>Wide Range of Melting Points:</b> Bond strength depends on the number of valence electrons contributed per atom and core charge:
    <ul>
      <li>Mercury (Hg): 1 valence electron active, melts at <b>$-39^{\\circ}\\mathrm{C}$</b> ($E_0 = 62\\mathrm{~kJ/mol}$).</li>
      <li>Aluminum (Al): 3 valence electrons, melts at <b>$660^{\\circ}\\mathrm{C}$</b> ($E_0 = 330\\mathrm{~kJ/mol}$).</li>
      <li>Tungsten (W): transition metal with participating $d$-electrons, melts at <b>$3414^{\\circ}\\mathrm{C}$</b> ($E_0 = 850\\mathrm{~kJ/mol}$).</li>
    </ul>
  </li>
</ol>

${chk('Why are metals malleable and ductile, whereas ionic ceramics with comparable bond energies shatter upon impact?',
  'Metallic bonding is nondirectional and mediated by a flexible electron sea: moving one plane of atoms past another maintains the bond without repulsion. In ionic ceramics, shear forces like-charged ions (+ against + and − against −) into adjacent alignment, causing instantaneous Coulomb repulsion that cleaves the crystal.')}
`
});

/* ── 8. m1-vdw: Secondary & Hydrogen Bonding ── */
STATIONS.push({
  id: 'm1-vdw',
  mod: 'Module I', modName: 'Materials, Forces & Bonding', modClass: 'm1',
  title: 'Secondary Bonding: Van der Waals, Hydrogen Bonds & Water Anomaly',
  short: 'Secondary & H-Bonds',
  est: '~18 min',
  body: H`
${gist('Secondary bonds are physical bonds (4–30 kJ/mol) arising from <b>electric dipoles</b>; hydrogen bonding is an exceptionally strong special case (up to 51 kJ/mol).')}

${tp('Three Classes of Van der Waals Dipoles')}
${tbl(
  ['Bond Type', 'Dipole Origin', 'Mechanism & Examples', 'Typical Energy'],
  [
    ['<b>Fluctuating Induced Dipole</b> (London Dispersion)', 'Instantaneous fluctuations in electron cloud symmetry', 'Electrons moving around a neutral nucleus temporarily unbalance the charge center, inducing an opposite dipole in adjacent atoms. Present in all matter; solely responsible for liquid Argon ($-189^{\\circ}\\mathrm{C}$), Krypton, and liquid Nitrogen.', '$\\approx 4 - 10\\mathrm{~kJ/mol}$<br>($\\mathrm{Ar}: 7.7\\mathrm{~kJ/mol}$)'],
    ['<b>Polar Molecule–Induced Dipole</b>', 'Permanent dipole polarizing a nonpolar neighbor', 'A permanent dipole (e.g. HCl) distorts the symmetric electron cloud of an adjacent nonpolar molecule, inducing attractive alignment.', '$\\approx 5 - 15\\mathrm{~kJ/mol}$'],
    ['<b>Permanent Dipole Bonds</b> (Keesom Interactions)', 'Molecules with permanent dipole moments', 'Molecules with asymmetric charge distribution (polar molecules, e.g. HCl, SO₂) align opposite poles ($+\\delta$ attracts $-\\delta$).', '$\\approx 10 - 30\\mathrm{~kJ/mol}$']
  ]
)}

${fig('dipoles', 'Comparison of fluctuating instantaneous dipole vs permanent polar dipole alignment.')}

${tp('Hydrogen Bonding')}
<p>Hydrogen bonding is a special, exceptionally strong class of secondary bonding that occurs when a hydrogen atom is covalently linked to one of the three smallest, most electronegative nonmetallic elements: <b>Fluorine (F)</b>, <b>Oxygen (O)</b>, or <b>Nitrogen (N)</b>:</p>
<ul>
  <li>The electronegative atom draws the single electron pair almost completely away from hydrogen.</li>
  <li>Hydrogen has no inner shielding electrons—it is left as a virtually bare, unshielded proton ($+\\delta$).</li>
  <li>This tiny positive pole can approach extremely close to the lone pair ($-\\delta$) of an adjacent electronegative atom, generating an intense bond of up to <b>$51\\mathrm{~kJ/mol}$</b>.</li>
</ul>

${tp('Water: Anomalous Expansion upon Freezing')}
<p>In most materials, the solid crystalline phase is denser than the liquid phase. Water exhibits a vital anomalous behavior:</p>
<ul>
  <li><b>Liquid Water:</b> Molecules are crowded dynamically with average coordination number of <b>$\\approx 4.5$</b> neighbors. Maximum density occurs at <b>$3.98^{\\circ}\\mathrm{C}$</b> ($1.000\\mathrm{~g/cm}^3$).</li>
  <li><b>Solid Ice ($I_h$):</b> As water freezes at $0^{\\circ}\\mathrm{C}$, every oxygen atom is forced to satisfy four directional hydrogen bonds in a rigid tetrahedral framework with coordination number of exactly <b>$4.0$</b>.</li>
  <li>This creates an open, cage-like hexagonal structure with hollow channels. As a result, ice expands by <b>$\\approx 9\\%$ in volume</b> upon freezing, with density $\\rho = 0.917\\mathrm{~g/cm}^3$.</li>
</ul>

${fig3d('ice', '3D crystal lattice of Ice Ih: open hexagonal rings formed by four hydrogen bonds per water molecule. Toggle the button to inspect the proton positions.')}

${fig('waterdens', 'Density of water as a function of temperature from −10 °C to +20 °C, highlighting the density maximum at 3.98 °C and the dramatic 9% volume expansion upon freezing at 0 °C.')}

${chk('What ecological catastrophe would occur if water behaved like almost all other liquids upon freezing?',
  'If solid ice were denser than liquid water, ice formed at the surface during winter would immediately sink to the bottom. Lakes, rivers, and polar seas would freeze progressively from the bottom up, turning into solid blocks of ice that summer heat could never thaw, wiping out aquatic life.')}
`
});

/* ── 9. m1-mixed: Mixed Bonding & The Bonding Tetrahedron ── */
STATIONS.push({
  id: 'm1-mixed',
  mod: 'Module I', modName: 'Materials, Forces & Bonding', modClass: 'm1',
  title: 'Mixed Bonding, The Bonding Tetrahedron & Pauling %IC',
  short: 'Mixed Bonding & Tetrahedron',
  est: '~18 min',
  body: H`
${gist('Few materials have pure single-type bonds; most exhibit <b>mixed bonding</b> characterized by the Pauling percent ionic character and the <b>Bonding Tetrahedron</b>.')}

${tp('Pauling Equation for Percent Ionic Character (%IC)')}
<p>When two atoms with electronegativities $X_A$ and $X_B$ form a bond, the degree of ionic vs covalent character is given by Linus Pauling’s empirical formula:</p>
${eq('\\%\\mathrm{IC} = \\left\\{1 - \\exp\\left[-0.25 (X_A - X_B)^2\\right]\\right\\} \\times 100\\%', 'Pauling %IC Formula')}

${fig('ionicchar', 'Pauling percent ionic character (%IC) curve plotted against electronegativity difference |XA − XB|, highlighting classic materials from pure covalent (0%) to predominantly ionic (>80%).')}

${prob('Worked Problem 2', 'Computation of %IC for C–H Bond (Callister Example 2.3)', H`
${pq('Compute the percent ionic character (%IC) of the carbon–hydrogen (C–H) bond in methane, given electronegativities $X_C = 2.5$ and $X_H = 2.1$.')}
${pth('Substitute electronegativity values into Pauling’s formula: $\\%\\mathrm{IC} = \\{1 - \\exp[-0.25(X_C - X_H)^2]\\} \\times 100\\%$.')}
${psol(H`
$$\\Delta X = |X_C - X_H| = |2.5 - 2.1| = 0.40$$
$$(\\Delta X)^2 = (0.40)^2 = 0.16$$
$$-0.25 (\\Delta X)^2 = -0.25(0.16) = -0.040$$
$$\\exp(-0.040) = 0.9608$$
$$\\%\\mathrm{IC} = (1 - 0.9608) \\times 100\\% = 3.92\\% \\approx 3.9\\%$$
<p>The C–H bond is <b>$3.9\\%$ ionic</b> and <b>$96.1\\%$ covalent</b> (virtually pure covalent).</p>
`)}
`)}

${tp('The Bonding Tetrahedron')}
<p>The four extreme bonding types—<b>Ionic</b>, <b>Covalent</b>, <b>Metallic</b>, and <b>Van der Waals</b>—occupy the four vertices of a three-dimensional tetrahedron. Real materials lie on the edges or faces connecting vertices:</p>
<ul>
  <li><b>Covalent–Ionic edge:</b> Semiconductors and ceramics (e.g. GaAs $\\Delta X = 0.4 \\implies 3.9\\%\\mathrm{~IC}$; $\\mathrm{SiO}_2 \\Delta X = 1.7 \\implies 51\\%\\mathrm{~IC}$; NaCl $\\Delta X = 2.1 \\implies 67\\%\\mathrm{~IC}$).</li>
  <li><b>Covalent–Metallic edge:</b> Metalloids and semimetals (B, Si, Ge, As, Sb, Te, Po). Moving down Group IVA (C $\\rightarrow$ Si $\\rightarrow$ Ge $\\rightarrow$ Sn $\\rightarrow$ Pb) shifts bonding from pure covalent diamond to pure metallic lead.</li>
  <li><b>Metallic–Ionic edge:</b> Intermetallic compounds with electronegativity difference (e.g. $\\mathrm{TiAl}_3$, $\\mathrm{Mg}_2\\mathrm{Pb}$).</li>
</ul>

${fig3d('tetra', 'The Bonding Tetrahedron and Material-Type Tetrahedron: spin the 3D model to observe how ceramics, polymers, metals, and semiconductors map onto the four primary bonding vertices.')}

${chk('Why does the electrical conductivity of Group IVA elements increase dramatically as you move down the periodic table from carbon to lead?',
  'Carbon (diamond) forms localized, purely covalent sp³ bonds with an empty conduction band separated by a 5.5 eV bandgap. Moving down Group IVA (Si → Ge → Sn → Pb), valence electrons are located in higher shells farther from the nucleus, weakening covalent localization. The bandgap shrinks (Si: 1.1 eV, Ge: 0.67 eV, Gray Sn: 0.08 eV) until lead becomes a true metal with overlapping bands.')}
`
});
