/* ══════════════════════════════════════════════════════════════════
   Module 1 Question Bank & Flashcards: Callister Chapters 1 & 2
   Sections: m1-what, m1-classes, m1-adv, m1-forces, m1-ionic,
             m1-cov, m1-metal, m1-vdw, m1-mixed
   ══════════════════════════════════════════════════════════════════ */

/* ── Section: m1-what ── */
OMR['m1-what'] = [
  {
    q: "How is materials science fundamentally distinguished from materials engineering?",
    o: [
      "Materials science investigates relationships between structure and properties, whereas materials engineering designs structure to achieve predetermined properties.",
      "Materials science deals only with subatomic phenomena, whereas materials engineering focuses strictly on macroscale assembly.",
      "Materials science is concerned with manufacturing economics, whereas materials engineering uncovers the basic laws of physics.",
      "Materials science designs finished commercial products, whereas materials engineering synthesizes brand new elemental species."
    ],
    a: 0,
    why: "Materials science investigates basic structure-property relationships (the 'why'), while materials engineering applies those relationships to create tailored properties (the 'how'). The distractor reverses these fundamental roles."
  },
  {
    q: "In the structural hierarchy of materials, what physical dimension defines the nanostructure boundary?",
    o: [
      "Dimensions from 100 nm to several millimeters",
      "Dimensions strictly less than approximately 100 nm",
      "Dimensions between several millimeters and one meter",
      "Any dimension visible under an ordinary optical microscope"
    ],
    a: 1,
    why: "Nanostructure comprises atomic aggregates or particles whose dimensions are strictly less than approximately 100 nm. Dimensions from 100 nm to several millimeters define microstructure."
  },
  {
    q: "Which sequence correctly represents the central paradigm of materials science and engineering established in the 1990s?",
    o: [
      "Structure $\\longrightarrow$ Processing $\\longrightarrow$ Performance $\\longrightarrow$ Properties",
      "Properties $\\longrightarrow$ Structure $\\longrightarrow$ Processing $\\longrightarrow$ Performance",
      "Processing $\\longrightarrow$ Structure $\\longrightarrow$ Properties $\\longrightarrow$ Performance",
      "Performance $\\longrightarrow$ Processing $\\longrightarrow$ Properties $\\longrightarrow$ Structure"
    ],
    a: 2,
    why: "Processing dictates the resulting structure, structure governs exhibited properties, and properties determine operational in-service performance. Shuffling this linear chain violates the core MSE paradigm."
  },
  {
    q: "Which property category relates a material's physical response to an applied mechanical load or force?",
    o: [
      "Deteriorative characteristics",
      "Thermal properties",
      "Optical properties",
      "Mechanical properties"
    ],
    a: 3,
    why: "Mechanical properties (e.g., elastic modulus, yield strength, fracture toughness) reflect deformation response under load. Thermal properties reflect temperature changes, while deteriorative characteristics describe chemical reactivity."
  },
  {
    q: "Why is a single-crystal disk of aluminum oxide (Al<sub>2</sub>O<sub>3</sub>) optically transparent, while a dense polycrystalline disk is translucent?",
    o: [
      "The single crystal possesses a completely noncrystalline amorphous structure that lets photons pass unimpeded.",
      "The polycrystalline disk absorbs all visible light due to metallic valence electron bands.",
      "The single crystal contains large microscopic void pores that channel light straight through.",
      "The single crystal lacks grain boundaries that scatter incident light, whereas polycrystalline grain boundaries diffuse and scatter light."
    ],
    a: 3,
    why: "A single crystal has continuous lattice periodicity without internal boundaries, allowing light transmission without scattering. Boundaries between randomly oriented crystallites in the polycrystalline disk scatter light, rendering it translucent."
  },
  {
    q: "What causes a sintered polycrystalline aluminum oxide disk containing residual microscopic porosity to appear completely opaque?",
    o: [
      "Total destructive interference of photon waveforms in the alumina lattice",
      "Severe light scattering at internal pore interfaces and void spaces",
      "Chemical conversion of aluminum oxide into dark metallic aluminum",
      "Electronic transition from an electrical insulator to an opaque electrical conductor"
    ],
    a: 1,
    why: "Microscopic void pores have a refractive index very different from alumina (air vs. oxide), causing intense multiple scattering that prevents light from passing through. The chemistry remains pure Al<sub>2</sub>O<sub>3</sub>."
  },
  {
    q: "When selecting materials for an engineering component, which classic mechanical property trade-off is most commonly encountered?",
    o: [
      "Electrical conductivity versus magnetic permeability",
      "Linear thermal expansion versus chemical corrosion rate",
      "Strength versus ductility",
      "Specific heat capacity versus optical reflectivity"
    ],
    a: 2,
    why: "Materials with very high tensile strength almost universally exhibit low ductility, requiring engineers to compromise between load-carrying capacity and deformation tolerance. The other pairs are not standard mechanical trade-offs."
  },
  {
    q: "In engineering material selection, what is considered the overriding criterion that dictates final adoption?",
    o: [
      "Maximum attainable melting point",
      "Absolute chemical inertness",
      "Minimum theoretical atomic mass",
      "Total economics, including raw material and fabrication costs"
    ],
    a: 3,
    why: "Economics is the overriding criterion: an engineering material with ideal technical performance cannot be used commercially if it is cost-prohibitive to procure and manufacture into the finished piece."
  },
  {
    q: "During World War II, what critical metallurgical phenomenon led to the catastrophic cracking of welded Liberty cargo ships in cold Atlantic waters?",
    o: [
      "A ductile-to-brittle transition in the ship steel at low operating temperatures",
      "Rapid galvanic corrosion of steel in contact with bronze propellers",
      "Severe creep deformation of the hull plates under steady wave pressure",
      "Spontaneous recrystallization and grain growth of deck steel induced by sea spray"
    ],
    a: 0,
    why: "The structural steel had a high ductile-to-brittle transition temperature; freezing North Atlantic seawater cooled the steel below this threshold, causing normally ductile steel to fracture in a brittle manner."
  },
  {
    q: "Why were all-welded hulls of Liberty ships far more vulnerable to catastrophic splitting in half than traditionally riveted hulls?",
    o: [
      "Welding consumed carbon from the steel, transforming it into soft ferrite.",
      "A running crack in a continuous welded hull propagates unimpeded across seams, whereas riveted joints arrest cracks at plate edges.",
      "Welded seams were 100 times thinner than the rolled hull plates.",
      "Riveted plates prevent thermal conduction, keeping the hull warmer than ambient seawater."
    ],
    a: 1,
    why: "A monolithic welded hull offers a continuous crack path; once initiated, a brittle crack spreads across the girth without stopping. In riveted hulls, each plate seam acts as a mechanical discontinuity that arrests crack propagation."
  },
  {
    q: "What geometric design flaw at the cargo hatch corners of early Liberty ships acted as primary crack initiation sites?",
    o: [
      "Tapered dovetail joints",
      "Circular porthole geometry",
      "Sharp 90° square corners that acted as severe stress concentrators",
      "Overlapping corrugated plates"
    ],
    a: 2,
    why: "Sharp 90° square hatch corners act as severe geometric stress concentrators, elevating local stress far above the nominal hull stress and initiating brittle cracks. Rounding the corners eliminated this stress peak."
  },
  {
    q: "Which metallurgical remedy was implemented to depress the ductile-to-brittle transition temperature of steel following the Liberty ship failures?",
    o: [
      "Increasing the sulfur and phosphorus concentrations to maximize hardness",
      "Adding high concentrations of lead and bismuth to improve ductility",
      "Lowering the carbon concentration while drastically reducing sulfur and phosphorus impurity levels",
      "Replacing all carbon steel with unalloyed cast gray iron"
    ],
    a: 2,
    why: "Reducing sulfur and phosphorus impurities lowers the ductile-to-brittle transition temperature well below typical sea temperatures, preserving impact toughness. Adding S or P would embrittle the steel further."
  },
  {
    q: "If an engineer examines a material feature spanning a length of 50 $\\mu\\mathrm{m}$, into which structural realm does this feature fall?",
    o: [
      "Microstructure",
      "Subatomic structure",
      "Nanostructure",
      "Macrostructure"
    ],
    a: 0,
    why: "50 $\\mu\\mathrm{m}$ ($5 \\times 10^{-5}$ m) lies well within the microstructure range ($100\\mathrm{~nm}$ to several millimeters). Nanostructure is strictly $\\lt 100\\mathrm{~nm}$, and macrostructure exceeds several millimeters."
  },
  {
    q: "Out of 2,710 mass-produced Liberty cargo ships, how many catastrophically split completely in half before remedial design measures were introduced?",
    o: [
      "48",
      "3",
      "270",
      "12"
    ],
    a: 1,
    why: "According to Callister Section 1.3, out of 2,710 Liberty ships built, precisely 3 catastrophically fractured entirely in two, including the S.S. Schenectady dockside in 1943. The other numbers are incorrect."
  }
];

CARDS['m1-what'] = [
  { f: "Materials science", b: "Investigating the fundamental relationships that exist between the internal structures and properties of materials (answering 'why' materials behave as they do)." },
  { f: "Materials engineering", b: "Designing or manipulating the structure of a material to synthesize a predetermined set of operational properties based on structure-property correlations." },
  { f: "Central paradigm of MSE", b: "The linear four-point framework: Processing $\\longrightarrow$ Structure $\\longrightarrow$ Properties $\\longrightarrow$ Performance (modernly extended to include Reuse/Recyclability)." },
  { f: "Microstructure vs. nanostructure limits", b: "Nanostructure: structural entities with dimensions strictly &lt;100 nm. Microstructure: features from 100 nm up to several millimeters, resolved using microscopes." },
  { f: "Six solid property categories", b: "Mechanical, electrical, thermal, magnetic, optical, and deteriorative characteristics." },
  { f: "Single crystal vs. polycrystalline Al<sub>2</sub>O<sub>3</sub> optics", b: "Single crystal is transparent (no grain boundaries to scatter light). Polycrystalline is translucent (boundary scattering); porous polycrystalline is completely opaque." },
  { f: "Ductile-to-brittle transition", b: "A dramatic drop in impact toughness and fracture energy when a material (like structural steel) cools below a critical transition temperature." },
  { f: "Stress concentration", b: "The amplification of localized stress caused by sharp internal geometric discontinuities, such as square 90° hatch corners or notches." }
];

/* ── Section: m1-classes ── */
OMR['m1-classes'] = [
  {
    q: "Which atomic-scale electronic feature is uniquely characteristic of metallic materials?",
    o: [
      "Localized covalent bonds with rigid 109.5° tetrahedral angles",
      "A nonlocalized 'sea of valence electrons' free to drift throughout the entire lattice",
      "Completely filled valence electron shells preventing electron mobility",
      "Electrostatic transfer of electrons creating rigid cation-anion pairs"
    ],
    a: 1,
    why: "Metals feature delocalized valence electrons that belong to the crystal as a whole, explaining their high electrical and thermal conductivities and ductile plasticity. Rigid localized pairs characterize ceramics and polymers."
  },
  {
    q: "Ceramic materials are chemically defined as compounds composed of which elements?",
    o: [
      "Long macromolecular chains of carbon and hydrogen only",
      "Exclusively transition metals alloyed in solid solutions",
      "Metallic and nonmetallic elements, most frequently oxides, nitrides, and carbides",
      "Inert noble gas elements bonded via fluctuating induced dipoles"
    ],
    a: 2,
    why: "Ceramics are inorganic compounds formed between metallic and nonmetallic elements, predominantly oxides (Al<sub>2</sub>O<sub>3</sub>, SiO<sub>2</sub>), nitrides (Si<sub>3</sub>N<sub>4</sub>), and carbides (SiC)."
  },
  {
    q: "Why do polymeric materials soften and decompose at relatively low temperatures ($100^{\\circ}\\mathrm{C}$ to $300^{\\circ}\\mathrm{C}$) compared to metals and ceramics?",
    o: [
      "Polymer chains are held together in bulk by weak secondary intermolecular bonds that easily dissociate with modest thermal energy.",
      "Carbon-carbon covalent backbone bonds have a lower bonding energy than noble gas induced dipoles.",
      "Polymers undergo immediate nuclear decay upon mild heating.",
      "Valence electrons in polymers form a super-conductive gas that repels atomic nuclei."
    ],
    a: 0,
    why: "While intramolecular chain backbones are strong covalent bonds, the adjacent chains in bulk polymers are bonded by weak secondary forces that easily yield to modest thermal vibrations, causing softening. The C-C backbone itself is quite stable."
  },
  {
    q: "What is the primary design motivation for synthesizing composite materials such as fiberglass (GFRP) or CFRP?",
    o: [
      "To obtain a synergistic combination of engineering properties not possessed by any single monolithic material",
      "To produce completely transparent materials with zero elastic modulus",
      "To eliminate the need for carbon and hydrogen in structural designs",
      "To ensure the resulting material dissolves completely in ambient water"
    ],
    a: 0,
    why: "Composites combine two or more distinct materials (e.g., strong, stiff, brittle fibers in a ductile polymer matrix) to achieve high strength, low density, and high toughness simultaneously. Mitigating component weaknesses is the core goal."
  },
  {
    q: "In Michael Ashby's materials selection property charts, what mathematical scaling is used on both coordinate axes?",
    o: [
      "Linear coordinate axes spanning zero to 100",
      "Reciprocal square-root scales",
      "Sinusoidal axes based on crystalline diffraction angles",
      "Logarithmic coordinate axes spanning multiple orders of magnitude"
    ],
    a: 3,
    why: "Ashby charts plot properties (such as Young's modulus vs. density) on log-log scales across 3 to 6 orders of magnitude, allowing entire material families to cluster into delineated bubbles/envelopes."
  },
  {
    q: "In the carbonated beverage container case study, what critical drawback limits 2-liter polyethylene terephthalate (PET) plastic bottles?",
    o: [
      "PET dissolves instantly upon contact with slightly acidic carbonic acid.",
      "PET is an opaque conductor that prevents inspection of beverage levels.",
      "PET is slightly permeable to carbon dioxide gas, causing pressurized soda to go flat within a few months.",
      "PET fractures into razor-sharp shards when dropped from a height of several feet."
    ],
    a: 2,
    why: "PET bottles slowly allow pressurized CO<sub>2</sub> molecules to diffuse outward through the polymer matrix, limiting shelf life to a few months. Glass and aluminum maintain carbonation for years."
  },
  {
    q: "Why are aluminum beverage cans preferred over glass bottles for rapid chilling and transportation efficiency?",
    o: [
      "Aluminum reacts chemically with carbon dioxide to generate continuous effervescence.",
      "Aluminum is completely transparent to visible light and requires zero energy to manufacture.",
      "Aluminum cans are brittle and shatter cleanly for disposal.",
      "Aluminum has high thermal conductivity to chill quickly and much lower density/weight, reducing freight costs."
    ],
    a: 3,
    why: "Aluminum is a metal with high thermal conductivity (conducts heat away quickly) and light weight compared to heavy, thick-walled glass bottles, drastically lowering shipping freight expenses."
  },
  {
    q: "Which material class exhibits the highest resistance to catastrophic crack propagation (fracture toughness, $K_{Ic}$)?",
    o: [
      "Traditional ceramics such as concrete ($0.2\\mathrm{~to~}0.5\\mathrm{~MPa}\\sqrt{\\mathrm{m}}$)",
      "Polymers such as polyester and polystyrene ($0.5\\mathrm{~to~}1.5\\mathrm{~MPa}\\sqrt{\\mathrm{m}}$)",
      "Silicate glasses ($0.7\\mathrm{~to~}1.0\\mathrm{~MPa}\\sqrt{\\mathrm{m}}$)",
      "Ductile metallic alloys such as steels ($50\\mathrm{~to~}150\\mathrm{~MPa}\\sqrt{\\mathrm{m}}$)"
    ],
    a: 3,
    why: "Metals like structural steels possess fracture toughness values up to $150\\mathrm{~MPa}\\sqrt{\\mathrm{m}}$ due to plastic deformation at crack tips. Ceramics and polymers typically exhibit values below $6\\mathrm{~MPa}\\sqrt{\\mathrm{m}}$."
  },
  {
    q: "According to Callister Figure 1.8, what is the characteristic room-temperature electrical conductivity range of ceramic insulators?",
    o: [
      "$10^{-20}\\mathrm{~to~}10^{-8}\\mathrm{~(}\\Omega\\cdot\\mathrm{m})^{-1}$",
      "$10^6\\mathrm{~to~}10^8\\mathrm{~(}\\Omega\\cdot\\mathrm{m})^{-1}$",
      "$10^{-6}\\mathrm{~to~}10^4\\mathrm{~(}\\Omega\\cdot\\mathrm{m})^{-1}$",
      "$10^{12}\\mathrm{~to~}10^{18}\\mathrm{~(}\\Omega\\cdot\\mathrm{m})^{-1}$"
    ],
    a: 0,
    why: "Ceramics are electrical insulators with conductivity between $10^{-20}$ and $10^{-8}\\mathrm{~(}\\Omega\\cdot\\mathrm{m})^{-1}$. $10^6\\mathrm{~to~}10^8$ corresponds to metallic conductors, and $10^{-6}\\mathrm{~to~}10^4$ to semiconductors."
  },
  {
    q: "Which material family on an Ashby stiffness-versus-density chart is characterized by extremely low elastic modulus ($10^{-3}\\mathrm{~to~}10^{-2}\\mathrm{~GPa}$) and high reversible elastic strain?",
    o: [
      "Technical ceramics",
      "Elastomers",
      "Intermetallics",
      "Refractory metals"
    ],
    a: 1,
    why: "Elastomers (rubbers) possess very low elastic moduli (around $0.001\\mathrm{~to~}0.01\\mathrm{~GPa}$) and sustain massive, completely reversible elastic deformations. Ceramics and metals have moduli of tens to hundreds of GPa."
  },
  {
    q: "Compare the elastic modulus of structural steel ($\\approx 200\\mathrm{~GPa}$) with aluminum alloy ($\\approx 70\\mathrm{~GPa}$). What is the approximate ratio $E_{\\mathrm{steel}}/E_{\\mathrm{Al}}$?",
    o: [
      "0.35",
      "1.4",
      "2.86",
      "10.0"
    ],
    a: 2,
    why: "Ratio $= 200\\mathrm{~GPa} / 70\\mathrm{~GPa} \\approx 2.86$. Steel is nearly three times stiffer than aluminum."
  },
  {
    q: "Using room-temperature density data from Callister Figure 1.4, calculate the ratio of the density of platinum ($\\approx 21.5\\mathrm{~g/cm}^3$) to magnesium ($\\approx 1.7\\mathrm{~g/cm}^3$).",
    o: [
      "4.2",
      "12.6",
      "2.3",
      "36.5"
    ],
    a: 1,
    why: "Ratio $= 21.5 / 1.7 \\approx 12.6$. Platinum is roughly 12.6 times denser than magnesium, spanning the extreme range of engineering metals."
  },
  {
    q: "A structural tie rod requires high specific stiffness (modulus divided by density, $E/\\rho$). If carbon fiber composite (CFRC) has $E \\approx 150\\mathrm{~GPa}$ and $\\rho \\approx 1.5\\mathrm{~g/cm}^3$, while structural steel has $E \\approx 200\\mathrm{~GPa}$ and $\\rho \\approx 7.8\\mathrm{~g/cm}^3$, how do their specific stiffnesses compare?",
    o: [
      "Steel has approximately 4 times higher specific stiffness than CFRC.",
      "CFRC has approximately 3.9 times higher specific stiffness than steel.",
      "Both materials have identical specific stiffness of $50\\mathrm{~GPa}/(\\mathrm{g/cm}^3)$.",
      "Steel has 10 times higher specific stiffness due to its high absolute modulus."
    ],
    a: 1,
    why: "For CFRC: $150 / 1.5 = 100\\mathrm{~GPa}/(\\mathrm{g/cm}^3)$. For steel: $200 / 7.8 \\approx 25.6\\mathrm{~GPa}/(\\mathrm{g/cm}^3)$. Ratio $= 100 / 25.6 \\approx 3.9$. CFRC offers nearly fourfold higher stiffness per unit mass."
  },
  {
    q: "Which naturally occurring composite material consists of stiff cellulose fibers embedded inside an amorphous lignin matrix?",
    o: [
      "Bone",
      "Porcelain",
      "Wood",
      "Granite"
    ],
    a: 2,
    why: "Wood is a natural composite of cellulose fibers reinforcing a lignin matrix. Bone is also a natural composite, but consists of collagen protein reinforced with hydroxyapatite mineral."
  }
];

CARDS['m1-classes'] = [
  { f: "Metals", b: "Inorganic materials of metallic elements with crystalline order and delocalized electron 'sea'; stiff, strong, ductile, and excellent electrical/thermal conductors." },
  { f: "Ceramics", b: "Inorganic compounds of metals and nonmetals (oxides, nitrides, carbides); hard, stiff, highly brittle, heat resistant, and electrical/thermal insulators." },
  { f: "Polymers", b: "Organic compounds of carbon/hydrogen macromolecules with long chain backbones; low density, flexible, pliable, and decompose at modest temperatures." },
  { f: "Composites", b: "Multiphase materials fabricated from combinations of metals, ceramics, or polymers to achieve synergistic properties not found in monolithic components." },
  { f: "Ashby chart (bubble chart)", b: "Log-log coordinate plots of material property pairs across multiple orders of magnitude, where material families cluster within distinct bounded envelopes." },
  { f: "Elastomers", b: "Polymeric materials capable of large, completely reversible elastic deformations at room temperature under low applied stresses." },
  { f: "Foams", b: "High-porosity materials containing large volume fractions of gas-filled pores, widely utilized for cushioning, shock absorption, packaging, and insulation." },
  { f: "PET gas permeability", b: "Polyethylene terephthalate is slightly permeable to carbon dioxide, causing carbonated beverages in 2-liter plastic bottles to go flat within months." }
];

/* ── Section: m1-adv ── */
OMR['m1-adv'] = [
  {
    q: "What defines an 'advanced material' in materials science?",
    o: [
      "Any material utilizing exclusively noble metals like gold and platinum",
      "Materials utilized in high-technology applications that operate via intricate, sophisticated physical principles",
      "Materials that never experience physical or chemical degradation under any service condition",
      "Naturally occurring organic substances used without chemical refinement"
    ],
    a: 1,
    why: "Advanced materials are high-tech materials (semiconductors, biomaterials, smart materials, nanomaterials) engineered for sophisticated devices like computers, fiber optics, and aerospace systems."
  },
  {
    q: "What electronic characteristic makes semiconductors the foundational material for integrated circuits?",
    o: [
      "Their electrical conductivity is intermediate between conductors and insulators and is extraordinarily sensitive to minute dopant concentrations.",
      "They conduct electric current faster than the speed of light in a vacuum.",
      "They have zero electrical resistance at room temperature without cooling.",
      "Their valence electrons are permanently immobilized in rigid covalent bonds that cannot be excited."
    ],
    a: 0,
    why: "Semiconductors have electrical conductivities ($10^{-6}\\mathrm{~to~}10^4\\mathrm{~(}\\Omega\\cdot\\mathrm{m})^{-1}$) precisely controllable over sub-micrometer regions via tiny dopant concentrations. They are neither superconductors nor completely rigid insulators."
  },
  {
    q: "What fundamental criterion must a material satisfy to be classified as a biomaterial?",
    o: [
      "It must be grown from living plant tissue.",
      "It must be biocompatible, functioning reliably without triggering immune rejection, inflammation, or releasing toxins.",
      "It must completely dissolve within the human bloodstream within 24 hours.",
      "It must exhibit piezoelectric properties to generate cardiac power."
    ],
    a: 1,
    why: "Biomaterials are nonviable materials implanted into the body; biocompatibility (tolerated by physiological tissues without toxicity or rejection) is mandatory. Dissolving rapidly is undesirable for permanent implants like hip prostheses."
  },
  {
    q: "What are the two essential components that constitute a smart (or intelligent) materials system?",
    o: [
      "A battery and an incandescent light source",
      "A thermocouple and an analog pressure gauge",
      "A sensor that detects an environmental stimulus and an actuator that performs a responsive, adaptive function",
      "A permanent magnet and an elastomeric damper"
    ],
    a: 2,
    why: "A smart material system mimics living organisms by combining a sensor (which detects stress, temperature, or fields) with an actuator (which alters shape, stiffness, or position in response)."
  },
  {
    q: "Which class of actuator materials recovers its original undeformed shape upon heating through a critical transformation temperature?",
    o: [
      "Electrorheological fluids",
      "Magnetostrictive ceramics",
      "Piezoelectric polymers",
      "Shape-memory alloys (SMAs)"
    ],
    a: 3,
    why: "Shape-memory alloys (SMAs) spontaneously revert to their pre-deformed geometry when heated past a transformation threshold. Magnetostrictive materials respond to magnetic fields, and ER fluids change viscosity in electric fields."
  },
  {
    q: "What functional response defines a piezoelectric ceramic material?",
    o: [
      "It contracts irreversibly when immersed in an acidic solution.",
      "It changes from an opaque solid into a transparent liquid upon magnetic excitation.",
      "It completely demagnetizes in the presence of an ultrasonic sound wave.",
      "It undergoes mechanical strain when an electric field is applied, and conversely produces an electric field when mechanically stressed."
    ],
    a: 3,
    why: "Piezoelectricity is the bidirectional coupling of mechanical strain and electric polarization. Applying voltage strains the crystal; applying stress generates voltage."
  },
  {
    q: "How do electrorheological (ER) and magnetorheological (MR) fluids respond to applied electric or magnetic fields?",
    o: [
      "They permanently vaporize into inert gaseous compounds.",
      "They undergo dramatic, reversible alterations in viscosity, transforming from free-flowing liquids to near-solid gels within milliseconds.",
      "They precipitate insoluble metal powders that sink to the bottom of the container.",
      "They experience spontaneous radioactive beta decay."
    ],
    a: 1,
    why: "ER and MR fluids are colloidal suspensions that reversibly change viscosity by orders of magnitude (liquid to gel) in milliseconds upon field application, used in adaptive dampers and clutches."
  },
  {
    q: "In materials science, what upper dimensional limit strictly defines a nanomaterial?",
    o: [
      "$1\\mathrm{~mm}$",
      "$10~\\mu\\mathrm{m}$",
      "$100\\mathrm{~nm}$",
      "$1~\\mu\\mathrm{m}$"
    ],
    a: 2,
    why: "Nanomaterials have structural entities with dimensions strictly less than approximately $100\\mathrm{~nm}$ ($10^{-7}\\mathrm{~m}$). $1~\\mu\\mathrm{m}$ is already in the microstructural scale."
  },
  {
    q: "What is the distinction between 'top-down' science and the 'bottom-up' approach of nanotechnology?",
    o: [
      "Top-down breaks bulk materials into smaller constituents, while bottom-up synthesizes structures atom-by-atom or molecule-by-molecule.",
      "Top-down applies only to biological materials, while bottom-up applies only to structural steels.",
      "Top-down utilizes electron microscopes, whereas bottom-up uses only the naked human eye.",
      "Top-down is an environmental recycling standard, while bottom-up is an open-pit mining protocol."
    ],
    a: 0,
    why: "Top-down starts from macroscopic bulk matter and carves/breaks it down; bottom-up ('materials by design', as Feynman envisioned) builds nanostructures atom by atom using scanning probe techniques."
  },
  {
    q: "Which physical scaling effect is primarily responsible for the dramatically increased chemical reactivity and catalytic activity of nanoparticles?",
    o: [
      "A massive escalation in the surface area-to-volume ratio",
      "Complete elimination of valence electrons from surface atoms",
      "Drastic reduction of gravitational pull on individual atoms",
      "Spontaneous inversion of the electron charge from negative to positive"
    ],
    a: 0,
    why: "As particle diameter shrinks to the nanoscale, surface area-to-volume ratio scales inversely ($S/V \\propto 1/d$). A large fraction of all atoms reside on the surface, drastically multiplying reactive catalytic sites."
  },
  {
    q: "Who prophetically envisioned nanotechnology and the bottom-up assembly of materials in his 1959 lecture 'There's Plenty of Room at the Bottom'?",
    o: [
      "Earl R. Parker",
      "Michael F. Ashby",
      "William D. Callister",
      "Richard Feynman"
    ],
    a: 3,
    why: "Physicist Richard Feynman delivered the famous 1959 American Physical Society lecture 'There's Plenty of Room at the Bottom', laying the conceptual foundation for nanotechnology."
  },
  {
    q: "If 100 nm corresponds to the diameter of approximately 500 atoms lined up in a row, what is the approximate average atomic diameter?",
    o: [
      "$0.2\\mathrm{~nm}$",
      "$2.0\\mathrm{~nm}$",
      "$0.02\\mathrm{~nm}$",
      "$5.0\\mathrm{~nm}$"
    ],
    a: 0,
    why: "Average diameter $= 100\\mathrm{~nm} / 500 = 0.2\\mathrm{~nm}$ ($2\\mathrm{~\\AA} = 2 \\times 10^{-10}\\mathrm{~m}$), matching typical interatomic dimensions."
  },
  {
    q: "Consider a spherical particle. Its surface area-to-volume ratio is $S/V = 6/d$. By what factor does $S/V$ increase when a microscopic grain of diameter $d_1 = 10~\\mu\\mathrm{m}$ is pulverized into nanoparticles of diameter $d_2 = 10\\mathrm{~nm}$?",
    o: [
      "10",
      "100",
      "1,000",
      "1,000,000"
    ],
    a: 2,
    why: "Ratio of $(S/V)_2 / (S/V)_1 = d_1 / d_2 = (10 \\times 10^{-6}\\mathrm{~m}) / (10 \\times 10^{-9}\\mathrm{~m}) = 1,000$. The specific surface area increases by a factor of 1,000."
  },
  {
    q: "What does a 'cradle-to-grave' life-cycle assessment mandate when evaluating an engineering material?",
    o: [
      "Analyzing the material exclusively during its final disposal phase in a landfill",
      "Measuring only the energy consumed during smelting and refining",
      "Evaluating the total environmental and economic impact from raw material extraction through synthesis, use, and ultimate recycling or disposal",
      "Calculating the financial profits of the manufacturing company over a five-year period"
    ],
    a: 2,
    why: "Cradle-to-grave evaluates comprehensive impacts across the entire life cycle: extraction, processing, service life, and eventual end-of-life disposal or recycling."
  }
];

CARDS['m1-adv'] = [
  { f: "Advanced materials", b: "High-performance materials utilized in high-tech applications, including semiconductors, biomaterials, smart materials, and nanomaterials." },
  { f: "Semiconductors", b: "Materials with electrical conductivities intermediate between conductors and insulators, extremely sensitive to minute concentrations of impurity dopants." },
  { f: "Biocompatible material", b: "A material suitable for implantation into the living body that does not provoke immune rejection, inflammation, or release toxic substances." },
  { f: "Smart materials system", b: "An integrated system composed of a sensor that detects an environmental stimulus and an actuator that executes an adaptive, responsive physical change." },
  { f: "Shape-memory alloy (SMA)", b: "A metallic alloy that recovers its original, undeformed geometry when heated through a critical transformation temperature after plastic deformation." },
  { f: "Piezoelectric ceramics", b: "Ceramic materials that strain mechanically under an applied electric field, and conversely develop electric polarization when mechanically stressed." },
  { f: "ER and MR fluids", b: "Suspensions undergoing dramatic, reversible viscosity increases (liquid to near-solid gel in milliseconds) upon electric or magnetic field exposure." },
  { f: "Cradle-to-grave assessment", b: "Holistic evaluation of total environmental and energetic impact from raw extraction and fabrication through operational use to end-of-life disposal/recycling." }
];

/* ── Section: m1-forces ── */
OMR['m1-forces'] = [
  {
    q: "What two opposing atomic forces govern the interaction between two isolated atoms brought together from infinity?",
    o: [
      "An attractive force $F_A$ from bonding and a repulsive force $F_R$ from electron cloud electrostatic overlap",
      "A gravitational force and a centripetal orbital force",
      "A nuclear strong force and a magnetic dipole force",
      "A frictional drag force and an osmotic pressure force"
    ],
    a: 0,
    why: "At large separation, attractive bonding forces draw atoms together; at very close separation, overlapping negatively charged electron clouds produce sharp electrostatic repulsion."
  },
  {
    q: "At the equilibrium interatomic separation distance $r_0$, what is the value of the net force $F_N$?",
    o: [
      "$F_N = -\\infty$",
      "$F_N = 0$, meaning $F_A + F_R = 0$",
      "$F_N$ attains its maximum attractive value",
      "$F_N$ equals the bonding energy $E_0$"
    ],
    a: 1,
    why: "Equilibrium occurs where attractive and repulsive forces balance exactly ($F_A + F_R = 0$). The net force crosses zero at $r = r_0$."
  },
  {
    q: "What is the typical magnitude of the equilibrium interatomic separation distance $r_0$ for most atomic systems?",
    o: [
      "$0.003\\mathrm{~nm}$",
      "$3.0\\mathrm{~nm}$",
      "$0.3\\mathrm{~nm}$ ($3 \\times 10^{-10}\\mathrm{~m}$)",
      "$30\\mathrm{~nm}$"
    ],
    a: 2,
    why: "As stated in Callister Section 2.5, for many atomic systems the equilibrium separation $r_0$ is approximately $0.3\\mathrm{~nm}$ ($3\\mathrm{~\\AA}$). 3 nm is too large, and 0.003 nm is sub-nuclear."
  },
  {
    q: "How are interatomic force $F$ and potential energy $E$ mathematically related?",
    o: [
      "$F = \\int E^2\\,dr$",
      "$F = \\frac{d^2E}{dr^2}$",
      "$E = F \\times r^2$",
      "$E = \\int F\\,dr \\quad \\Longleftrightarrow \\quad F = \\frac{dE}{dr}$"
    ],
    a: 3,
    why: "Mechanical work relates force and potential energy via $E = \\int F\\,dr$ or conversely $F = dE/dr$. The second derivative relates to stiffness, not force."
  },
  {
    q: "What feature on the net potential energy curve $E_N(r)$ corresponds to the bonding energy $E_0$?",
    o: [
      "The vertical depth of the potential energy well at the minimum position $r = r_0$",
      "The horizontal distance where the potential energy curve crosses zero",
      "The positive asymptotic value of energy at $r = 0$",
      "The slope of the energy curve at infinite separation"
    ],
    a: 0,
    why: "Bonding energy $E_0$ represents the depth of the potential energy well at its minimum ($r = r_0$), representing energy required to dissociate atoms to infinity."
  },
  {
    q: "How does the bonding energy $E_0$ correlate with a material's melting temperature $T_m$?",
    o: [
      "A large $E_0$ implies gaseous behavior at room temperature.",
      "Materials with large $E_0$ melt at cryogenic temperatures because atomic bonds are easily shaken loose.",
      "Melting temperature is completely independent of bonding energy and depends only on atmospheric pressure.",
      "Materials with large $E_0$ possess deep potential wells and exhibit very high melting temperatures."
    ],
    a: 3,
    why: "A large bonding energy requires substantial thermal vibrational energy to disrupt interatomic bonds, resulting in a high melting point. Small $E_0$ produces gases at room temperature."
  },
  {
    q: "How is the mechanical stiffness (elastic modulus $E$) of a material represented on the interatomic force curve?",
    o: [
      "By the maximum depth of the attractive force trough",
      "By the slope of the net force curve at the equilibrium separation, $(dF/dr)_{r=r_0}$",
      "By the total area under the repulsive force curve",
      "By the ratio of $F_A$ to $F_R$ at $r = \\infty$"
    ],
    a: 1,
    why: "Elastic modulus is directly proportional to the slope $(dF/dr)_{r=r_0} = (d^2E/dr^2)_{r=r_0}$. A steep force curve slope at $r_0$ indicates a high resistance to atomic displacement (stiff material)."
  },
  {
    q: "What characteristic of the potential energy well ($E_N$ vs. $r$) governs the linear coefficient of thermal expansion ($\\alpha$)?",
    o: [
      "The absolute electrical conductivity of the valence electrons",
      "The width of the horizontal axis at $r = 10\\mathrm{~nm}$",
      "The degree of asymmetry of the potential energy well as thermal vibrational energy increases",
      "The sign of the nuclear charge"
    ],
    a: 2,
    why: "Thermal expansion arises from potential well asymmetry. With asymmetric wells, increasing vibration shifts the mean interatomic separation outward, producing expansion. A deep, symmetric well produces low $\\alpha$."
  },
  {
    q: "Why do materials with deep, highly symmetric potential energy wells exhibit very low coefficients of thermal expansion?",
    o: [
      "As thermal vibrational energy rises, the mean interatomic separation position remains virtually unchanged.",
      "Thermal vibrations are completely forbidden by quantum mechanics in deep wells.",
      "The atoms undergo spontaneous contraction as temperature increases.",
      "Valence electrons absorb all thermal energy, preventing atomic nucleus vibration."
    ],
    a: 0,
    why: "In a symmetric well, atomic vibrations occur symmetrically about $r_0$, so the average atomic separation does not shift outward with temperature, resulting in minimal thermal expansion."
  },
  {
    q: "Which group of bonds represents primary (chemical) interatomic bonds?",
    o: [
      "Fluctuating dipoles and hydrogen bonds",
      "van der Waals bonds and permanent dipole bonds",
      "Ionic, covalent, and metallic bonds",
      "Hydrophobic interactions and capillary bonds"
    ],
    a: 2,
    why: "Primary bonds involve valence electron transfer, sharing, or delocalization to attain noble gas configurations: ionic, covalent, and metallic. Secondary bonds are physical dipole attractions."
  },
  {
    q: "At an interatomic separation of $r = 0.40\\mathrm{~nm}$, the attractive force between two atoms is $F_A = -1.80 \\times 10^{-10}\\mathrm{~N}$ and the repulsive force is $F_R = +0.60 \\times 10^{-10}\\mathrm{~N}$. What is the net interatomic force $F_N$?",
    o: [
      "$+2.40 \\times 10^{-10}\\mathrm{~N}$ (net repulsive)",
      "$-2.40 \\times 10^{-10}\\mathrm{~N}$ (net attractive)",
      "$-1.20 \\times 10^{-10}\\mathrm{~N}$ (net attractive)",
      "$+1.20 \\times 10^{-10}\\mathrm{~N}$ (net repulsive)"
    ],
    a: 2,
    why: "$F_N = F_A + F_R = -1.80 \\times 10^{-10} + 0.60 \\times 10^{-10} = -1.20 \\times 10^{-10}\\mathrm{~N}$. The negative sign denotes a net attractive force pulling the atoms together."
  },
  {
    q: "At the equilibrium spacing $r_0$, the attractive force in an ionic pair is $F_A = -3.50 \\times 10^{-9}\\mathrm{~N}$. What is the magnitude and direction of the repulsive force $F_R$ at this same spacing?",
    o: [
      "$0\\mathrm{~N}$",
      "$-3.50 \\times 10^{-9}\\mathrm{~N}$ (attractive)",
      "$+1.75 \\times 10^{-9}\\mathrm{~N}$ (repulsive)",
      "$+3.50 \\times 10^{-9}\\mathrm{~N}$ (repulsive)"
    ],
    a: 3,
    why: "At equilibrium, $F_N = F_A + F_R = 0 \\implies F_R = -F_A = -(-3.50 \\times 10^{-9}\\mathrm{~N}) = +3.50 \\times 10^{-9}\\mathrm{~N}$."
  },
  {
    q: "If the attractive and repulsive potential energies at equilibrium spacing $r_0$ are $E_A = -5.80\\mathrm{~eV}$ and $E_R = +0.90\\mathrm{~eV}$, what is the bonding energy $E_0$ of the atomic pair?",
    o: [
      "$4.90\\mathrm{~eV}$",
      "$-6.70\\mathrm{~eV}$",
      "$5.80\\mathrm{~eV}$",
      "$0.90\\mathrm{~eV}$"
    ],
    a: 0,
    why: "$E_N(r_0) = E_A + E_R = -5.80\\mathrm{~eV} + 0.90\\mathrm{~eV} = -4.90\\mathrm{~eV}$. The bonding energy $E_0$ is the well depth magnitude, $|E_N(r_0)| = 4.90\\mathrm{~eV}$."
  },
  {
    q: "Convert a bonding energy of $E_0 = 4.90\\mathrm{~eV}$ into Joules, using $1\\mathrm{~eV} = 1.602 \\times 10^{-19}\\mathrm{~J}$.",
    o: [
      "$3.06 \\times 10^{19}\\mathrm{~J}$",
      "$7.85 \\times 10^{-19}\\mathrm{~J}$",
      "$1.23 \\times 10^{-18}\\mathrm{~J}$",
      "$4.90 \\times 10^{-19}\\mathrm{~J}$"
    ],
    a: 1,
    why: "$E_0 = 4.90 \\times (1.602 \\times 10^{-19}\\mathrm{~J}) = 7.85 \\times 10^{-19}\\mathrm{~J}$."
  }
];

CARDS['m1-forces'] = [
  { f: "Net interatomic force ($F_N$)", b: "The algebraic sum of attractive and repulsive forces: $F_N = F_A + F_R$." },
  { f: "Equilibrium spacing ($r_0$)", b: "The interatomic separation where net force is zero ($F_A + F_R = 0$) and potential energy is minimized, typically $\\approx 0.3\\mathrm{~nm}$." },
  { f: "Bonding energy ($E_0$)", b: "The well depth magnitude at minimum net potential energy $E_N(r_0)$, representing the work required to separate bonded atoms to infinity." },
  { f: "Force-energy relation", b: "Potential energy and force are related by $E = \\int F\\,dr$ and $F = dE/dr$." },
  { f: "Melting point vs. bonding energy", b: "Large bonding energy ($E_0$) creates a deep potential energy well, requiring high thermal energy to melt (high melting temperature $T_m$)." },
  { f: "Stiffness on force-separation curve", b: "Mechanical stiffness (elastic modulus) is proportional to the slope of net force at equilibrium: $(dF/dr)_{r=r_0} = (d^2E/dr^2)_{r=r_0}$." },
  { f: "Thermal expansion origin", b: "Asymmetry of the potential energy well causes the average interatomic separation distance to increase as atomic vibrational amplitude increases with temperature." },
  { f: "Primary vs. secondary bonds", b: "Primary bonds (ionic, covalent, metallic) involve valence electrons; secondary bonds (van der Waals, hydrogen) arise from dipole electrostatic attraction." }
];

/* ── Section: m1-ionic ── */
OMR['m1-ionic'] = [
  {
    q: "Between which types of elements does ionic bonding predominantly occur?",
    o: [
      "Between nonmetallic elements located close together in the periodic table",
      "Exclusively between transition metals of identical electronegativity",
      "Between metallic elements with low electronegativity and nonmetallic elements with high electronegativity",
      "Between noble gases with completely filled outer shells"
    ],
    a: 2,
    why: "Ionic bonding occurs between metallic elements (which readily surrender valence electrons) and nonmetallic elements (which readily accept electrons), situated at horizontal extremities of the periodic table."
  },
  {
    q: "When a neutral sodium atom ($1s^2 2s^2 2p^6 3s^1$) transfers its valence electron to chlorine ($1s^2 2s^2 2p^6 3s^2 3p^5$), what electronic configurations do the resulting ions assume?",
    o: [
      "Na<sup>+</sup> assumes neon configuration ($1s^2 2s^2 2p^6$); Cl<sup>−</sup> assumes argon configuration ($1s^2 2s^2 2p^6 3s^2 3p^6$).",
      "Both Na<sup>+</sup> and Cl<sup>−</sup> assume helium configurations.",
      "Na<sup>+</sup> retains its $3s^1$ electron; Cl<sup>−</sup> loses two $3p$ electrons.",
      "Na<sup>+</sup> assumes argon configuration; Cl<sup>−</sup> assumes neon configuration."
    ],
    a: 0,
    why: "Na loses its $3s^1$ electron to acquire the closed-shell configuration of neon; Cl gains that electron to fill its $3p$ shell, acquiring the argon configuration."
  },
  {
    q: "Why is ionic bonding inherently nondirectional in nature?",
    o: [
      "Because covalent orbitals overlap strictly along the internuclear axis",
      "Because ions continuously swap positive and negative charges at gigahertz frequencies",
      "Because valence electrons drift in a unidirectional current through the crystal",
      "Because coulombic electrostatic fields radiate uniformly in all spatial directions around a charged ion"
    ],
    a: 3,
    why: "Coulombic electrostatic forces are radially symmetric, exerting equal attraction in all directions. Thus, each cation attracts all neighboring anions equally regardless of spatial angle."
  },
  {
    q: "In the expression for attractive electrostatic energy $E_A = -A/r$, how is the constant $A$ defined?",
    o: [
      "$A = \\frac{B}{r^n}$",
      "$A = 4\\pi\\varepsilon_0 e^2$",
      "$A = \\frac{1}{4\\pi\\varepsilon_0}(|Z_1|e)(|Z_2|e)$",
      "$A = \\frac{1}{2} k_B T$"
    ],
    a: 2,
    why: "Coulomb's law gives potential energy $E_A = -\\frac{1}{4\\pi\\varepsilon_0}\\frac{|Z_1|e|Z_2|e}{r}$, meaning $A = \\frac{1}{4\\pi\\varepsilon_0}(|Z_1|e)(|Z_2|e)$."
  },
  {
    q: "What is the numerical value of the constant factor $\\frac{e^2}{4\\pi\\varepsilon_0}$ used in ionic force calculations?",
    o: [
      "$1.602 \\times 10^{-19}\\mathrm{~N}\\cdot\\mathrm{m}^2$",
      "$8.85 \\times 10^{-12}\\mathrm{~N}\\cdot\\mathrm{m}^2$",
      "$9.11 \\times 10^{-31}\\mathrm{~N}\\cdot\\mathrm{m}^2$",
      "$2.31 \\times 10^{-28}\\mathrm{~N}\\cdot\\mathrm{m}^2$"
    ],
    a: 3,
    why: "$\\frac{e^2}{4\\pi\\varepsilon_0} = \\frac{(1.602 \\times 10^{-19})^2}{4\\pi(8.85 \\times 10^{-12})} \\approx 2.31 \\times 10^{-28}\\mathrm{~N}\\cdot\\mathrm{m}^2$."
  },
  {
    q: "What mathematical form describes the repulsive potential energy $E_R$ between two overlapping ions?",
    o: [
      "$E_R = -A/r$",
      "$E_R = \\frac{B}{r^n} \\quad (\\mathrm{with~} n \\approx 8)$",
      "$E_R = B \\ln(r)$",
      "$E_R = \\frac{1}{2} C r^2$"
    ],
    a: 1,
    why: "Repulsive potential energy follows Born's power law $E_R = B/r^n$, where $B$ is an empirical constant and $n \\approx 8$ reflects steep electron-shell overlap resistance."
  },
  {
    q: "According to Table 2.3, why does magnesium oxide (MgO) have a far higher melting temperature ($2800^{\\circ}\\mathrm{C}$) than sodium chloride (NaCl, $801^{\\circ}\\mathrm{C}$)?",
    o: [
      "Mg<sup>2+</sup> and O<sup>2−</sup> are divalent ions ($|Z_1||Z_2| = 4$), producing much stronger coulombic attraction and bonding energy ($1000\\mathrm{~kJ/mol}$) than monovalent Na<sup>+</sup> and Cl<sup>−</sup> ($|Z_1||Z_2| = 1$, $640\\mathrm{~kJ/mol}$).",
      "NaCl forms covalent molecular crystals while MgO forms metallic bonds.",
      "MgO contains delocalized electron clouds that conduct heat away.",
      "Sodium has a higher atomic number than magnesium, causing lattice instability."
    ],
    a: 0,
    why: "Coulombic attractive energy is proportional to the valence product $|Z_1||Z_2|$. Divalent Mg<sup>2+</sup> and O<sup>2−</sup> give $|Z_1||Z_2| = 4$, yielding substantially greater bonding energy ($1000\\mathrm{~kJ/mol}$) and higher $T_m$ ($2800^{\\circ}\\mathrm{C}$) than monovalent NaCl."
  },
  {
    q: "What mechanical properties typically characterize ionically bonded crystalline solids?",
    o: [
      "Extremely soft, highly pliable, and ductile at room temperature",
      "Hard and brittle, with very low electrical conductivity in the solid state",
      "High ductility with electrical conductivity comparable to copper",
      "Viscoelastic liquid behavior at room temperature"
    ],
    a: 1,
    why: "Strong, nondirectional ionic bonds produce high hardness, but shifting like-charge ions into contact causes catastrophic cleavage, making them brittle. Tightly bound electrons make them electrical insulators."
  },
  {
    q: "In Callister Example Problem 2.2, the ionic radii of K<sup>+</sup> and Br<sup>−</sup> are $0.138\\mathrm{~nm}$ and $0.196\\mathrm{~nm}$. What is the equilibrium separation distance $r_0$ when the ions touch?",
    o: [
      "$0.058\\mathrm{~nm}$",
      "$0.334\\mathrm{~nm}$",
      "$0.668\\mathrm{~nm}$",
      "$0.167\\mathrm{~nm}$"
    ],
    a: 1,
    why: "$r_0 = r_{K^+} + r_{Br^-} = 0.138\\mathrm{~nm} + 0.196\\mathrm{~nm} = 0.334\\mathrm{~nm} = 0.334 \\times 10^{-9}\\mathrm{~m}$."
  },
  {
    q: "Using $F_A = \\frac{(2.31 \\times 10^{-28}\\mathrm{~N}\\cdot\\mathrm{m}^2)(|Z_1|)(|Z_2|)}{r^2}$, what is the attractive force between K<sup>+</sup> ($Z_1 = +1$) and Br<sup>−</sup> ($Z_2 = -1$) at $r_0 = 0.334\\mathrm{~nm}$?",
    o: [
      "$2.07 \\times 10^{-9}\\mathrm{~N}$",
      "$6.92 \\times 10^{-19}\\mathrm{~N}$",
      "$2.31 \\times 10^{-28}\\mathrm{~N}$",
      "$4.14 \\times 10^{-9}\\mathrm{~N}$"
    ],
    a: 0,
    why: "$F_A = \\frac{2.31 \\times 10^{-28} \\times 1 \\times 1}{(0.334 \\times 10^{-9})^2} = \\frac{2.31 \\times 10^{-28}}{1.1156 \\times 10^{-19}} \\approx 2.07 \\times 10^{-9}\\mathrm{~N}$."
  },
  {
    q: "In Example 2.2, what is the repulsive force $F_R$ acting between the K<sup>+</sup> and Br<sup>−</sup> ions at this same equilibrium spacing $r_0 = 0.334\\mathrm{~nm}$?",
    o: [
      "$+2.07 \\times 10^{-9}\\mathrm{~N}$",
      "$0\\mathrm{~N}$",
      "$-4.14 \\times 10^{-9}\\mathrm{~N}$",
      "$-2.07 \\times 10^{-9}\\mathrm{~N}$"
    ],
    a: 3,
    why: "At equilibrium, $F_A + F_R = 0$. Since attraction draws ions together, Callister's solution sets $F_R = -F_A = -(2.07 \\times 10^{-9}\\mathrm{~N}) = -2.07 \\times 10^{-9}\\mathrm{~N}$ to balance it."
  },
  {
    q: "Compute the attractive force $F_A$ between Na<sup>+</sup> ($Z_1 = +1$) and Cl<sup>−</sup> ($Z_2 = -1$) if their equilibrium contact spacing is $r_0 = 0.283\\mathrm{~nm}$.",
    o: [
      "$1.44 \\times 10^{-9}\\mathrm{~N}$",
      "$2.88 \\times 10^{-9}\\mathrm{~N}$",
      "$5.76 \\times 10^{-9}\\mathrm{~N}$",
      "$8.16 \\times 10^{-10}\\mathrm{~N}$"
    ],
    a: 1,
    why: "$F_A = \\frac{2.31 \\times 10^{-28} \\times 1 \\times 1}{(0.283 \\times 10^{-9})^2} = \\frac{2.31 \\times 10^{-28}}{8.0089 \\times 10^{-20}} \\approx 2.88 \\times 10^{-9}\\mathrm{~N}$."
  },
  {
    q: "Consider a divalent pair Mg<sup>2+</sup> ($Z_1 = +2$) and O<sup>2−</sup> ($Z_2 = -2$) at an interionic spacing of $r_0 = 0.210\\mathrm{~nm}$. Compute the attractive coulombic force $F_A$.",
    o: [
      "$5.24 \\times 10^{-9}\\mathrm{~N}$",
      "$1.05 \\times 10^{-8}\\mathrm{~N}$",
      "$2.10 \\times 10^{-8}\\mathrm{~N}$",
      "$4.20 \\times 10^{-8}\\mathrm{~N}$"
    ],
    a: 2,
    why: "$F_A = \\frac{2.31 \\times 10^{-28} \\times 2 \\times 2}{(0.210 \\times 10^{-9})^2} = \\frac{9.24 \\times 10^{-28}}{4.41 \\times 10^{-20}} \\approx 2.10 \\times 10^{-8}\\mathrm{~N}$."
  },
  {
    q: "What is the attractive potential energy $E_A = -A/r$ in electron volts (eV) for the K<sup>+</sup>–Br<sup>−</sup> pair at $r_0 = 0.334\\mathrm{~nm}$, using $A = 2.31 \\times 10^{-28}\\mathrm{~N}\\cdot\\mathrm{m}^2$ and $1\\mathrm{~eV} = 1.602 \\times 10^{-19}\\mathrm{~J}$?",
    o: [
      "$-1.85\\mathrm{~eV}$",
      "$-2.88\\mathrm{~eV}$",
      "$-4.32\\mathrm{~eV}$",
      "$-8.64\\mathrm{~eV}$"
    ],
    a: 2,
    why: "$E_A = -\\frac{2.31 \\times 10^{-28}\\mathrm{~J}\\cdot\\mathrm{m}}{0.334 \\times 10^{-9}\\mathrm{~m}} = -6.916 \\times 10^{-19}\\mathrm{~J}$. In eV: $-6.916 \\times 10^{-19} / (1.602 \\times 10^{-19}) \\approx -4.32\\mathrm{~eV}$."
  }
];

CARDS['m1-ionic'] = [
  { f: "Ionic bond definition", b: "A primary chemical bond formed between electropositive and electronegative atoms via valence electron transfer, held by nondirectional coulombic electrostatic attraction." },
  { f: "Ionic attractive energy formula", b: "$E_A = -A/r$, where $A = \\frac{1}{4\\pi\\varepsilon_0}(|Z_1|e)(|Z_2|e)$. With fundamental constants, $\\frac{e^2}{4\\pi\\varepsilon_0} = 2.31 \\times 10^{-28}\\mathrm{~N}\\cdot\\mathrm{m}^2$." },
  { f: "Ionic repulsive energy formula", b: "$E_R = B/r^n$, where $B$ and $n$ are empirical constants ($n \\approx 8$), describing steep resistance to electron cloud interpenetration." },
  { f: "Nondirectional ionic nature", b: "Coulombic electrostatic fields radiate uniformly in all directions, requiring every cation to be surrounded 3D by anions and vice versa." },
  { f: "Ionic bonding energy range", b: "Typically $600\\mathrm{~to~}1500\\mathrm{~kJ/mol}$, resulting in high melting points (NaCl $801^{\\circ}\\mathrm{C}$, MgO $2800^{\\circ}\\mathrm{C}$)." },
  { f: "Example 2.2 force balance", b: "For K<sup>+</sup> ($0.138\\mathrm{~nm}$) and Br<sup>−</sup> ($0.196\\mathrm{~nm}$), $r_0 = 0.334\\mathrm{~nm}$; $F_A = 2.07 \\times 10^{-9}\\mathrm{~N}$ and $F_R = -2.07 \\times 10^{-9}\\mathrm{~N}$." },
  { f: "Ionic mechanical behavior", b: "Hard and brittle; applied shear displaces identically charged ions adjacent to one another, causing massive electrostatic repulsion and cleavage." },
  { f: "Ionic radius shift upon ionization", b: "Metallic cations shrink relative to neutral atoms ($r_{\\mathrm{Na}^+} &lt; r_{\\mathrm{Na}}$); nonmetallic anions expand ($r_{\\mathrm{Cl}^-} > r_{\\mathrm{Cl}}$)." }
];

/* ── Section: m1-cov ── */
OMR['m1-cov'] = [
  {
    q: "What fundamental mechanism characterizes covalent bonding between adjacent atoms?",
    o: [
      "Valence electron transfer from an electropositive atom to an electronegative atom",
      "Sharing of valence electrons between atoms with small differences in electronegativity",
      "Delocalization of valence electrons into an unconstrained, nonlocalized electron sea",
      "Electrostatic coulombic attraction between fluctuating atomic dipoles"
    ],
    a: 1,
    why: "Covalent bonds form when atoms share pairs of valence electrons to achieve stable noble gas electron configurations. Transfer describes ionic bonds, and delocalization describes metallic bonds."
  },
  {
    q: "Why is covalent bonding directional, whereas ionic and metallic bonding are nondirectional?",
    o: [
      "Covalent bonds exist strictly along localized spatial directions connecting participating atoms where specific atomic orbitals overlap.",
      "Covalent electrons orbit exclusively in the north-south magnetic direction.",
      "Covalent bonds are influenced by the Earth's gravitational field.",
      "Covalent bonds change orientation at the speed of light."
    ],
    a: 0,
    why: "Covalent bonds require physical overlap of localized atomic orbitals ($s, p, sp^3$), restricting bonding to specific angles and directions between bonded atoms."
  },
  {
    q: "Which element forms a 3D crystalline network of pure covalent bonds exhibiting a bonding energy of $713\\mathrm{~kJ/mol}$ and melting point $>3550^{\\circ}\\mathrm{C}$?",
    o: [
      "Bismuth",
      "Mercury",
      "Diamond (carbon)",
      "Silicon carbide"
    ],
    a: 2,
    why: "Diamond consists of carbon atoms covalently bonded in a 3D network via $sp^3$ hybrid orbitals, giving it extreme hardness, high bonding energy ($713\\mathrm{~kJ/mol}$), and melting point $>3550^{\\circ}\\mathrm{C}$."
  },
  {
    q: "In the quantum-mechanical hybridization of carbon, what initial step precedes the formation of hybrid orbitals?",
    o: [
      "Promotion of an electron from the filled $2s$ orbital to a vacant $2p$ orbital",
      "Complete ejection of two $1s$ core electrons into the conduction band",
      "Capture of an extra valence electron from the surrounding vacuum",
      "Pairing of all electrons into a single $2p_z$ state"
    ],
    a: 0,
    why: "Ground-state carbon ($1s^2 2s^2 2p^2$) promotes one $2s$ electron to the empty $2p$ orbital, yielding an excited $1s^2 2s^1 2p^3$ state with four unpaired electrons capable of hybridizing."
  },
  {
    q: "What spatial geometry and bond angle characterize the four $sp^3$ hybrid orbitals in carbon?",
    o: [
      "Coplanar equilateral triangle with $120^{\\circ}$ angles",
      "Linear arrangement with $180^{\\circ}$ angles",
      "Regular octahedron with $90^{\\circ}$ angles",
      "Regular tetrahedron pointing to four vertices with bond angles of $109.5^{\\circ}$"
    ],
    a: 3,
    why: "Mixing one $2s$ and three $2p$ orbitals generates four equivalent $sp^3$ hybrid orbitals directed toward the vertices of a regular tetrahedron with bond angles of $109.5^{\\circ}$."
  },
  {
    q: "Why do polymeric chains consisting of carbon-carbon backbones exhibit a characteristic zigzag structure?",
    o: [
      "Due to the rigid $109.5^{\\circ}$ tetrahedral bond angle between adjacent $sp^3$ hybridized carbon bonds",
      "Because polymers alternate between metallic and ionic bonding at every monomer",
      "Due to electrostatic repulsion between hydrogen nuclei forcing $180^{\\circ}$ bends",
      "Because polymeric chains are crystallized under mechanical twisting tensions"
    ],
    a: 0,
    why: "Each carbon atom in the polymer backbone is $sp^3$ hybridized with a tetrahedral angle of $109.5^{\\circ}$, naturally producing a continuous zigzag conformation along the chain."
  },
  {
    q: "What orbital configuration and geometry describe $sp^2$ hybridization in graphite?",
    o: [
      "Four tetrahedral orbitals at $109.5^{\\circ}$ with zero unhybridized orbitals",
      "Two linear orbitals at $180^{\\circ}$ with two unhybridized $p$ orbitals",
      "Three coplanar hybrid orbitals directed toward triangle corners at $120^{\\circ}$, plus one unhybridized $2p_z$ orbital perpendicular to the plane",
      "Six coplanar orbitals directed toward hexagon corners at $60^{\\circ}$"
    ],
    a: 2,
    why: "Mixing one $2s$ and two $2p$ orbitals produces three coplanar $sp^2$ hybrids at $120^{\\circ}$, leaving one unhybridized $2p_z$ orbital perpendicular to the sheet."
  },
  {
    q: "Why does graphite exhibit excellent lubricity (easy cleavage parallel to basal planes) despite strong internal covalent bonds?",
    o: [
      "In-plane bonds are weak van der Waals forces, while interplanar bonds are covalent.",
      "The hexagonal rings spontaneously rotate in liquid film layers.",
      "In-plane bonds are strong covalent $sp^2$ bonds, but adjacent planes are held together only by weak van der Waals forces from delocalized $2p_z$ electrons.",
      "Graphite sheets contain liquid water trapped between layers."
    ],
    a: 2,
    why: "Graphite has strong covalent in-plane $sp^2$ bonding within each sheet, but weak secondary van der Waals bonding between sheets, allowing easy shearing and lubricating action."
  },
  {
    q: "According to Callister Concept Check 2.3, why are covalently bonded materials generally less dense than ionically or metallically bonded solids?",
    o: [
      "Covalent atoms have significantly lower atomic masses than all metals.",
      "Strict directional bond angles ($109.5^{\\circ}, 120^{\\circ}$) prevent close packing of atoms, producing relatively open crystal structures with low coordination numbers.",
      "Covalent bonds contain hollow channels through which electrons escape.",
      "Covalent solids contain trapped air bubbles within their unit cells."
    ],
    a: 1,
    why: "Directional covalent bonding imposes strict angular constraints, preventing dense packing. Nondirectional metallic and ionic bonds allow atoms to pack closely with high coordination numbers, yielding denser structures."
  },
  {
    q: "Which nonmetallic solid elemental material exhibits covalent bonding with a relatively low melting temperature of $\\approx 270^{\\circ}\\mathrm{C}$?",
    o: [
      "Silicon",
      "Tungsten",
      "Diamond",
      "Bismuth"
    ],
    a: 3,
    why: "As noted in Callister Section 2.6, elemental bismuth exhibits covalent bonding but has a low melting temperature of $\\approx 270^{\\circ}\\mathrm{C}$, illustrating that covalent bonds can span a wide range of strengths."
  },
  {
    q: "What is the geometric angular difference between the trigonal planar $sp^2$ bond angle ($120.0^{\\circ}$) and the tetrahedral $sp^3$ bond angle ($109.5^{\\circ}$)?",
    o: [
      "$5.5^{\\circ}$",
      "$10.5^{\\circ}$",
      "$15.0^{\\circ}$",
      "$20.5^{\\circ}$"
    ],
    a: 1,
    why: "Difference $= 120.0^{\\circ} - 109.5^{\\circ} = 10.5^{\\circ}$."
  },
  {
    q: "Compare the bonding energy of diamond ($713\\mathrm{~kJ/mol}$) with that of solid silicon ($450\\mathrm{~kJ/mol}$) from Table 2.3. By what percentage is diamond's bonding energy greater than that of silicon?",
    o: [
      "$26.3\\%$",
      "$36.9\\%$",
      "$58.4\\%$",
      "$75.1\\%$"
    ],
    a: 2,
    why: "Percentage increase $= \\frac{713 - 450}{450} \\times 100 = \\frac{263}{450} \\times 100 \\approx 58.4\\%$."
  },
  {
    q: "How many planar triangular $sp^2$ carbon units bond together at their vertices to form the closed regular hexagon of the graphite basal plane?",
    o: [
      "3",
      "4",
      "8",
      "6"
    ],
    a: 3,
    why: "As illustrated in Callister Figure 2.18, six $sp^2$ triangular units bond together at their vertices to form a regular planar hexagon with a carbon atom at each of the 6 vertices."
  },
  {
    q: "Which compound semiconductor from Callister Table 2.3 exhibits covalent bonding with a bonding energy of $523\\mathrm{~kJ/mol}$ and melting point of $942^{\\circ}\\mathrm{C}$?",
    o: [
      "Indium antimonide (InSb)",
      "Silicon carbide (SiC)",
      "Lithium fluoride (LiF)",
      "Calcium fluoride (CaF<sub>2</sub>)"
    ],
    a: 0,
    why: "Table 2.3 lists InSb under covalent substances with $E_0 = 523\\mathrm{~kJ/mol}$ and $T_m = 942^{\\circ}\\mathrm{C}$. SiC has $1230\\mathrm{~kJ/mol}$ ($2830^{\\circ}\\mathrm{C}$), and LiF/CaF<sub>2</sub> are ionic."
  }
];

CARDS['m1-cov'] = [
  { f: "Covalent bond definition", b: "A primary chemical bond characterized by the sharing of valence electrons between adjacent atoms with small electronegativity differences, producing directional bonds." },
  { f: "Directional bonding nature", b: "Covalent bonds exist strictly along the spatial orientation where participating atomic orbitals overlap, fixing rigid interatomic bond angles." },
  { f: "Electron promotion in carbon", b: "An electron from the filled $2s$ orbital is promoted to a vacant $2p$ orbital, producing an excited $1s^2 2s^1 2p^3$ state with 4 unpaired electrons." },
  { f: "$sp^3$ hybridization", b: "Mixing one $2s$ and three $2p$ orbitals yields four equivalent tetrahedral hybrid orbitals with bond angles of $109.5^{\\circ}$ (diamond, methane, polymer backbones)." },
  { f: "$sp^2$ hybridization", b: "Mixing one $2s$ and two $2p$ orbitals yields three coplanar hybrid orbitals at $120^{\\circ}$ and one unhybridized perpendicular $2p_z$ orbital (graphite sheets)." },
  { f: "Graphite sheet lubricity", b: "Strong covalent $sp^2$ bonds lie within hexagonal basal planes, while weak secondary van der Waals bonds between planes allow effortless interplanar shear." },
  { f: "Concept Check 2.3 (covalent density)", b: "Covalent solids are less dense because strict directional bond angles prevent close spatial packing, creating open crystal structures with low coordination numbers." },
  { f: "Diamond bonding energy & $T_m$", b: "Bonding energy is $713\\mathrm{~kJ/mol}$ and melting point exceeds $3550^{\\circ}\\mathrm{C}$, reflecting the extreme rigidity of the 3D tetrahedral network." }
];

/* ── Section: m1-metal ── */
OMR['m1-metal'] = [
  {
    q: "What atomic model correctly depicts metallic bonding in solid metals?",
    o: [
      "Localized electron pairs shared rigidly between adjacent pairs of atoms",
      "Positively charged ion cores held together by a nonlocalized, delocalized sea of valence electrons",
      "Alternating positive and negative ions held by rigid directional coulombic bonds",
      "Individual neutral atoms bound strictly by fluctuating induced dipoles"
    ],
    a: 1,
    why: "Metallic bonding consists of an orderly array of positive ion cores (nuclei plus nonvalence core electrons) immersed in a pervasive, delocalized sea of free valence electrons."
  },
  {
    q: "What constitutes an 'ion core' in the electron-cloud model of a metallic solid?",
    o: [
      "The atomic nucleus plus all nonvalence core electrons, possessing a net positive charge equal to the valence electron count",
      "A completely stripped atomic nucleus with zero bound electrons",
      "A neutral atom surrounded by an isolated shell of valence electrons",
      "A negative anion that has accepted extra electrons from adjacent atoms"
    ],
    a: 0,
    why: "An ion core comprises the nucleus and bound inner nonvalence electrons; its net positive charge equals the total negative charge of the valence electrons contributed to the sea."
  },
  {
    q: "Why is metallic bonding completely nondirectional?",
    o: [
      "Because valence electrons are confined to strictly linear $p$ orbitals",
      "Because metallic atoms have zero electronegativity",
      "Because metallic bonds break and reform in a single crystalline plane",
      "Because the delocalized sea of valence electrons shields ion cores uniformly in all spatial directions"
    ],
    a: 3,
    why: "The valence electron sea is distributed continuously throughout the lattice, providing an isotropic electrostatic 'glue' that does not favor any specific spatial direction."
  },
  {
    q: "Why are metals typically ductile and capable of plastic deformation at room temperature, unlike brittle ceramics?",
    o: [
      "Because metallic bonds are directional and snap instantly under shear stress",
      "Because ion cores melt into a liquid film during deformation",
      "Because nondirectional metallic bonds allow planes of ion cores to slide past one another without catastrophic rupture or like-charge electrostatic repulsion",
      "Because metals contain zero crystalline defects"
    ],
    a: 2,
    why: "In metals, nondirectional bonding allows planes of ion cores to slip past each other while the flexible electron sea maintains cohesion. In ceramics, shear brings like-charge ions into contact, causing brittle cleavage."
  },
  {
    q: "Which metal from Table 2.3 possesses the lowest bonding energy ($62\\mathrm{~kJ/mol}$) and a melting temperature of $-39^{\\circ}\\mathrm{C}$ (liquid at room temperature)?",
    o: [
      "Aluminum",
      "Silver",
      "Mercury (Hg)",
      "Tungsten (W)"
    ],
    a: 2,
    why: "Mercury has a weak metallic bonding energy of only $62\\mathrm{~kJ/mol}$, causing it to melt at $-39^{\\circ}\\mathrm{C}$ and remain liquid at room temperature."
  },
  {
    q: "Which refractory metal from Table 2.3 exhibits the highest metallic bonding energy ($850\\mathrm{~kJ/mol}$) and a melting point of $3414^{\\circ}\\mathrm{C}$?",
    o: [
      "Tungsten (W)",
      "Iron (Fe)",
      "Titanium (Ti)",
      "Platinum (Pt)"
    ],
    a: 0,
    why: "Tungsten has an exceptionally high bonding energy ($850\\mathrm{~kJ/mol}$) and the highest melting temperature among metals ($3414^{\\circ}\\mathrm{C}$)."
  },
  {
    q: "Comparing aluminum and silver in Table 2.3, aluminum has a higher bonding energy ($330\\mathrm{~kJ/mol}$) than silver ($285\\mathrm{~kJ/mol}$). What are their respective melting temperatures?",
    o: [
      "Aluminum melts at $962^{\\circ}\\mathrm{C}$; silver melts at $660^{\\circ}\\mathrm{C}$.",
      "Aluminum melts at $660^{\\circ}\\mathrm{C}$; silver melts at $962^{\\circ}\\mathrm{C}$.",
      "Both metals melt at exactly $801^{\\circ}\\mathrm{C}$.",
      "Aluminum melts at $3414^{\\circ}\\mathrm{C}$; silver melts at $-39^{\\circ}\\mathrm{C}$."
    ],
    a: 1,
    why: "Table 2.3 lists Al: $330\\mathrm{~kJ/mol}$, $T_m = 660^{\\circ}\\mathrm{C}$; Ag: $285\\mathrm{~kJ/mol}$, $T_m = 962^{\\circ}\\mathrm{C}$. Note that crystal structure and vibrational entropy also influence melting points."
  },
  {
    q: "What electronic mechanism accounts for the exceptionally high electrical and thermal conductivities of solid metals?",
    o: [
      "Rapid diffusion of heavy ion cores across lattice sites",
      "Fluctuating polarization of closed inner electron shells",
      "Continuous hopping of protons between adjacent atomic nuclei",
      "High mobility of nonlocalized valence electrons that drift freely under electric or thermal gradients"
    ],
    a: 3,
    why: "Delocalized valence electrons are not bound to individual atoms and can drift rapidly in response to electric fields or temperature gradients, producing high conductivity."
  },
  {
    q: "What visual property of metals results from the interaction of incident visible light with the sea of free valence electrons?",
    o: [
      "Complete optical transparency",
      "Total optical absorption with zero reflection",
      "Diffuse internal scattering that creates optical translucency",
      "High opacity and high metallic luster due to efficient light absorption and re-radiation at polished surfaces"
    ],
    a: 3,
    why: "Free electrons absorb incident photons at surface layers and re-emit them rapidly, preventing light transmission (making metals opaque) and creating high metallic reflectivity/luster."
  },
  {
    q: "How does the room-temperature electrical conductivity of metals ($10^6\\mathrm{~to~}10^8\\mathrm{~(}\\Omega\\cdot\\mathrm{m})^{-1}$) compare with typical polymeric insulators ($10^{-18}\\mathrm{~to~}10^{-14}\\mathrm{~(}\\Omega\\cdot\\mathrm{m})^{-1}$)?",
    o: [
      "Metals are roughly 2 to 4 times more conductive.",
      "Metals are approximately 20 to 24 orders of magnitude more conductive.",
      "Polymers are more conductive at room temperature.",
      "Both classes have identical conductivity when dry."
    ],
    a: 1,
    why: "Ratio spans from $10^7 / 10^{-16} \\approx 10^{23}$, representing an enormous difference of 20 to 24 orders of magnitude between metallic conductors and polymeric insulators."
  },
  {
    q: "Calculate the ratio of the bonding energy of tungsten ($850\\mathrm{~kJ/mol}$) to that of mercury ($62\\mathrm{~kJ/mol}$).",
    o: [
      "13.7",
      "3.4",
      "27.1",
      "0.073"
    ],
    a: 0,
    why: "Ratio $= 850 / 62 \\approx 13.7$. Tungsten's metallic bonding is nearly 14 times stronger than mercury's."
  },
  {
    q: "What is the temperature difference between the melting points of tungsten ($3414^{\\circ}\\mathrm{C}$) and mercury ($-39^{\\circ}\\mathrm{C}$)?",
    o: [
      "$3375^{\\circ}\\mathrm{C}$",
      "$3453^{\\circ}\\mathrm{C}$",
      "$3400^{\\circ}\\mathrm{C}$",
      "$3514^{\\circ}\\mathrm{C}$"
    ],
    a: 1,
    why: "$\\Delta T = 3414 - (-39) = 3414 + 39 = 3453^{\\circ}\\mathrm{C}$."
  },
  {
    q: "If a silver bar melts at $962^{\\circ}\\mathrm{C}$ and an aluminum bar melts at $660^{\\circ}\\mathrm{C}$, by how many degrees does silver's melting point exceed aluminum's?",
    o: [
      "$150^{\\circ}\\mathrm{C}$",
      "$250^{\\circ}\\mathrm{C}$",
      "$302^{\\circ}\\mathrm{C}$",
      "$412^{\\circ}\\mathrm{C}$"
    ],
    a: 2,
    why: "$962^{\\circ}\\mathrm{C} - 660^{\\circ}\\mathrm{C} = 302^{\\circ}\\mathrm{C}$."
  },
  {
    q: "Which group of elements in the periodic table exhibits purely metallic bonding in the elemental solid state?",
    o: [
      "Group VIIA halogens (fluorine, chlorine, bromine)",
      "Group VIIIA noble gases (helium, argon, krypton)",
      "Groups IA, IIA, and transition metals",
      "Group IVA nonmetals (carbon, silicon)"
    ],
    a: 2,
    why: "Groups IA (alkali metals), IIA (alkaline earth metals), and transition metals have electropositive character and few valence electrons, readily forming metallic bonding."
  }
];

CARDS['m1-metal'] = [
  { f: "Metallic bond definition", b: "A primary chemical bond found in metals where an array of positive ion cores is held together by a nonlocalized, delocalized 'sea of valence electrons'." },
  { f: "Ion core", b: "The net positively charged assembly of atomic nucleus and nonvalence core electrons remaining after valence electrons enter the delocalized conduction sea." },
  { f: "Nondirectional metallic bonding", b: "The electron sea shields ion cores uniformly in all directions, allowing planes of atoms to slide without electrostatic cleavage (high ductility)." },
  { f: "Metallic electrical/thermal conductivity", b: "Nonlocalized valence electrons drift freely and rapidly through the lattice under applied electric fields or thermal gradients." },
  { f: "Mercury vs. tungsten bonding extremes", b: "Mercury has $E_0 = 62\\mathrm{~kJ/mol}$ and melts at $-39^{\\circ}\\mathrm{C}$ (liquid); tungsten has $E_0 = 850\\mathrm{~kJ/mol}$ and melts at $3414^{\\circ}\\mathrm{C}$." },
  { f: "Metallic luster origin", b: "Free valence electrons absorb incident visible light photons and re-radiate them rapidly at the surface, giving metals high opacity and specular reflectivity." },
  { f: "Ductile slip mechanism", b: "Under mechanical shear, ion core planes slide past one another while the flexible electron sea preserves cohesion, preventing brittle fracture." },
  { f: "Table 2.3 Al vs. Ag comparison", b: "Aluminum has $E_0 = 330\\mathrm{~kJ/mol}$ ($T_m = 660^{\\circ}\\mathrm{C}$); silver has $E_0 = 285\\mathrm{~kJ/mol}$ ($T_m = 962^{\\circ}\\mathrm{C}$)." }
];

/* ── Section: m1-vdw ── */
OMR['m1-vdw'] = [
  {
    q: "What physical mechanism generates secondary (van der Waals) bonds between atoms or molecules?",
    o: [
      "Coulombic electrostatic attraction between the positive and negative ends of electric dipoles",
      "Permanent transfer of valence electrons between metallic and nonmetallic ions",
      "Quantum mechanical orbital hybridization yielding directional electron sharing",
      "Nuclear magnetic resonance alignment of atomic nuclei"
    ],
    a: 0,
    why: "Secondary bonding arises from electrostatic coulombic attraction between electric dipoles (either fluctuating or permanent), without electron transfer or sharing."
  },
  {
    q: "What is the typical energy range for secondary van der Waals bonds compared to primary chemical bonds?",
    o: [
      "$600\\mathrm{~to~}1500\\mathrm{~kJ/mol}$",
      "$4\\mathrm{~to~}30\\mathrm{~kJ/mol}$ (with hydrogen bonds reaching up to $\\approx 51\\mathrm{~kJ/mol}$)",
      "$0.01\\mathrm{~to~}0.1\\mathrm{~kJ/mol}$",
      "$5000\\mathrm{~to~}10000\\mathrm{~kJ/mol}$"
    ],
    a: 1,
    why: "Secondary bonds are comparatively weak, typically $4\\mathrm{~to~}30\\mathrm{~kJ/mol}$ (hydrogen bonding up to $51\\mathrm{~kJ/mol}$), whereas primary bonds range from $600\\mathrm{~to~}1500\\mathrm{~kJ/mol}$."
  },
  {
    q: "How does a fluctuating induced dipole bond arise in an electrically symmetric atom like argon?",
    o: [
      "Nuclear fission splits the atom into asymmetric fragments.",
      "Constant thermal vibrational motion creates fleeting, instantaneous distortions in electron cloud symmetry, inducing dipoles in neighboring atoms.",
      "Argon permanently transfers an electron to adjacent argon atoms.",
      "An external high-voltage electrical arc permanently polarizes the nucleus."
    ],
    a: 1,
    why: "Even in symmetric atoms, instantaneous thermal fluctuations temporarily displace the electron cloud center from the nucleus, creating a momentary dipole that induces a matching dipole in an adjacent atom."
  },
  {
    q: "Why do noble gases like argon and krypton have extremely low melting temperatures ($-189^{\\circ}\\mathrm{C}$ and $-158^{\\circ}\\mathrm{C}$)?",
    o: [
      "Their nuclei repel each other via strong coulombic forces.",
      "They have zero mass and sublime into light rays.",
      "They are held together in the solid state only by weak fluctuating induced dipole forces.",
      "They form directional covalent networks that break at room temperature."
    ],
    a: 2,
    why: "Noble gas atoms have closed outer electron shells; only weak fluctuating induced dipoles ($7.7\\mathrm{~kJ/mol}$ for Ar, $11.7\\mathrm{~kJ/mol}$ for Kr) hold them in solid form, requiring little thermal energy to melt."
  },
  {
    q: "What structural condition is strictly required for hydrogen bonding to occur?",
    o: [
      "Hydrogen must be bonded to electropositive alkali metals like sodium or potassium.",
      "Hydrogen must be dissolved as interstitial ions in a metallic iron lattice.",
      "Hydrogen must be covalently bonded to small, highly electronegative nonmetallic elements: fluorine, oxygen, or nitrogen.",
      "Hydrogen must be in a plasma state at temperatures exceeding $10000^{\\circ}\\mathrm{C}$."
    ],
    a: 2,
    why: "Hydrogen bonding occurs only when H is bonded to F (in HF), O (in H<sub>2</sub>O), or N (in NH<sub>3</sub>). The extreme electronegativity difference strips the H electron, creating an unscreened proton."
  },
  {
    q: "Why does the hydrogen bond represent the strongest class of secondary bonding (energies up to $51\\mathrm{~kJ/mol}$)?",
    o: [
      "The shared electron pair forms a triple covalent bond.",
      "The hydrogen atom becomes a negatively charged hydride ion.",
      "Hydrogen bonds involve nuclear fusion between adjacent atoms.",
      "Because hydrogen has no inner shielding electrons, its single valence electron is drawn away, leaving a virtually bare proton that exerts intense coulombic attraction."
    ],
    a: 3,
    why: "When hydrogen's single electron is drawn toward F, O, or N, the remaining positive charge is an unscreened, bare proton of tiny radius, creating an unusually strong electrostatic bridge."
  },
  {
    q: "Which practical application relies on materials containing hydrophilic surface sites that form hydrogen bonds with ambient water molecules?",
    o: [
      "Aerospace turbine blades",
      "High-speed cutting tool inserts",
      "Structural steel rebar in reinforced concrete",
      "Desiccants used in moisture-barrier packaging"
    ],
    a: 3,
    why: "Desiccants (like silica gel) possess hydrophilic surface sites that bind water molecules via hydrogen bonds, scavenging moisture from sealed containers."
  },
  {
    q: "How do surfactants and emulsifiers utilize secondary bonding in practical consumer products?",
    o: [
      "Surfactants lower the surface tension of water, and emulsifiers stabilize immiscible liquid droplets via amphiphilic dipole interactions.",
      "They form covalent diamond cubic bonds that solidify liquid mixtures.",
      "They induce nuclear magnetic resonance that repels water molecules.",
      "They convert liquid water into metallic hydrogen at room temperature."
    ],
    a: 0,
    why: "Surfactants reduce water surface tension in soaps, while emulsifiers stabilize suspensions of immiscible liquids (like oil and water in lotions and mayonnaise) through dipole interactions."
  },
  {
    q: "According to Material of Importance 2.1, what anomalous volume change occurs when liquid water freezes into solid ice?",
    o: [
      "Water contracts by approximately 9 volume percent.",
      "Water expands by approximately 9 volume percent.",
      "Water volume remains completely unchanged.",
      "Water expands by exactly 50 volume percent."
    ],
    a: 1,
    why: "Virtually all liquids contract on freezing, but water anomalously expands by approximately 9 volume percent upon freezing into ice."
  },
  {
    q: "What structural change at the molecular level causes ice to be less dense than liquid water?",
    o: [
      "Water molecules in ice form an open, rigid 3D tetrahedral network with 4 nearest neighbors; upon melting, this lattice collapses into void spaces, increasing nearest neighbors to $\\approx 4.5$.",
      "Water molecules dissociate into hydrogen and oxygen gas bubbles inside ice.",
      "Ice forms a close-packed metallic lattice where hydrogen atoms are ejected.",
      "The covalent O-H bond length doubles when ice freezes."
    ],
    a: 0,
    why: "In ice, each H<sub>2</sub>O forms 4 hydrogen bonds in an open tetrahedral lattice with large voids. Upon melting, the open framework collapses, increasing packing density (nearest neighbors rise to ~4.5)."
  },
  {
    q: "If $200\\mathrm{~cm}^3$ of liquid water freezes completely into ice, what is the resulting volume of ice, given a 9 volume percent expansion?",
    o: [
      "$182\\mathrm{~cm}^3$",
      "$209\\mathrm{~cm}^3$",
      "$218\\mathrm{~cm}^3$",
      "$236\\mathrm{~cm}^3$"
    ],
    a: 2,
    why: "$V_{\\mathrm{ice}} = 200 \\times (1 + 0.09) = 200 \\times 1.09 = 218\\mathrm{~cm}^3$."
  },
  {
    q: "Compare the coordination number of water molecules in solid ice (4 nearest neighbors) with liquid water at room temperature ($\\approx 4.5$ nearest neighbors). What is the percentage increase in nearest neighbors upon melting?",
    o: [
      "$5.0\\%$",
      "$12.5\\%$",
      "$25.0\\%$",
      "$50.0\\%$"
    ],
    a: 1,
    why: "Percentage increase $= \\frac{4.5 - 4.0}{4.0} \\times 100 = \\frac{0.5}{4.0} \\times 100 = 12.5\\%$."
  },
  {
    q: "Using bonding energies from Table 2.3, calculate the ratio of the hydrogen bonding energy in water ($51\\mathrm{~kJ/mol}$) to the fluctuating induced dipole bonding energy in argon ($7.7\\mathrm{~kJ/mol}$).",
    o: [
      "1.47",
      "3.25",
      "6.62",
      "14.1"
    ],
    a: 2,
    why: "Ratio $= 51 / 7.7 \\approx 6.62$. Hydrogen bonding in water is more than 6.6 times stronger than van der Waals bonding in argon."
  },
  {
    q: "Which everyday engineering consequence directly results from the anomalous volume expansion of water upon freezing?",
    o: [
      "Rapid galvanic corrosion of copper pipes in warm basements",
      "Loss of carbonation fizz in PET soda bottles",
      "Melting of plastic beverage containers on hot summer days",
      "Cracking of concrete pavements and potholes during seasonal freeze-thaw cycles"
    ],
    a: 3,
    why: "Water trapped in pavement microcracks expands by 9% upon freezing, exerting immense hydraulic pressure that breaks asphalt and concrete into potholes."
  }
];

CARDS['m1-vdw'] = [
  { f: "Secondary bonding definition", b: "Weak physical bonds ($4\\mathrm{~to~}30\\mathrm{~kJ/mol}$) arising from electrostatic coulombic attraction between electric dipoles without electron transfer or sharing." },
  { f: "Fluctuating induced dipole", b: "Temporary dipoles generated in electrically symmetric atoms (Ar, Kr) by fleeting thermal vibrations of electron clouds, inducing dipoles in neighbors." },
  { f: "Polar molecule", b: "A molecule possessing a permanent electric dipole moment due to an asymmetrical spatial distribution of positive and negative electrical charges (e.g., HCl)." },
  { f: "Hydrogen bond definition", b: "A strong secondary bond ($29\\mathrm{~to~}51\\mathrm{~kJ/mol}$) formed when hydrogen is covalently bonded to F, O, or N, leaving an unscreened proton bridging molecules." },
  { f: "Anomalous water expansion", b: "Water expands by approximately 9 volume percent upon freezing into solid ice because it forms an open, rigid tetrahedral crystalline lattice." },
  { f: "Water coordination numbers", b: "Solid ice water molecules have exactly 4 nearest neighbors; liquid water at room temperature collapses into void channels, averaging $\\approx 4.5$ neighbors." },
  { f: "Ice volume consequences", b: "Ice floats on water, protects aquatic ecosystems, fractures engine blocks without antifreeze, and creates roadway potholes during freeze-thaw cycles." },
  { f: "Surfactants and desiccants", b: "Surfactants reduce liquid surface tension via dipole ends; desiccants form hydrogen bonds with ambient moisture to dry sealed environments." }
];

/* ── Section: m1-mixed ── */
OMR['m1-mixed'] = [
  {
    q: "What do the four vertices of the 3D bonding tetrahedron represent?",
    o: [
      "Subatomic, atomic, micro, and macro structures",
      "Processing, Structure, Properties, and Performance",
      "Metals, ceramics, polymers, and composites",
      "The four pure, extreme bonding types: Ionic, Covalent, Metallic, and van der Waals"
    ],
    a: 3,
    why: "The bonding tetrahedron displays the four fundamental pure bonding mechanisms at its vertices (Ionic, Covalent, Metallic, van der Waals). Real materials with mixed bonds lie along edges and faces."
  },
  {
    q: "Which mathematical expression quantifies the percent ionic character (%IC) of an interatomic bond between elements with electronegativities $X_A$ and $X_B$?",
    o: [
      "$\\%IC = \\frac{X_A - X_B}{X_A + X_B} \\times 100$",
      "$\\%IC = \\left\\{ 1 - \\exp\\left[ -0.25(X_A - X_B)^2 \\right] \\right\\} \\times 100$",
      "$\\%IC = (X_A - X_B)^2 \\times 100$",
      "$\\%IC = \\left[ 1 - \\ln(X_A - X_B) \\right] \\times 100$"
    ],
    a: 1,
    why: "The Pauling equation is $\\%IC = \\{1 - \\exp[-0.25(X_A - X_B)^2]\\} \\times 100$. It smoothly scales from $0\\%$ for $\\Delta X = 0$ toward $100\\%$ as electronegativity difference grows."
  },
  {
    q: "In Callister Example Problem 2.3, the electronegativity of carbon is $X_C = 2.5$ and hydrogen is $X_H = 2.1$. What is the percent ionic character of the C–H bond?",
    o: [
      "$3.9\\%$",
      "$16.0\\%$",
      "$50.0\\%$",
      "$96.1\\%$"
    ],
    a: 0,
    why: "$\\Delta X = 2.5 - 2.1 = 0.4$. $\\%IC = \\{1 - \\exp[-0.25(0.16)]\\} \\times 100 = (1 - \\exp[-0.04]) \\times 100 \\approx 3.9\\%$. The bond is $96.1\\%$ covalent."
  },
  {
    q: "Which group of elements, termed metalloids or semi-metals, exhibits mixed covalent-metallic bonding along the covalent-metallic edge of the bonding tetrahedron?",
    o: [
      "Lithium, sodium, potassium, and rubidium",
      "Helium, neon, argon, and krypton",
      "Boron, silicon, germanium, arsenic, antimony, tellurium, polonium, and astatine",
      "Fluorine, chlorine, bromine, and iodine"
    ],
    a: 2,
    why: "The metalloids (B, Si, Ge, As, Sb, Te, Po, At) lie along the diagonal boundary between metals and nonmetals, exhibiting intermediate covalent-metallic bonding."
  },
  {
    q: "How does the bonding character change as one moves vertically down Group IVA from carbon (top) to lead (bottom)?",
    o: [
      "It transitions from pure ionic to pure van der Waals.",
      "It changes from metallic at the top to ionic at the bottom.",
      "It remains 100% covalent at every element in the column.",
      "It shifts continuously from purely covalent (diamond) through semi-metallic (Si, Ge) to predominantly metallic bonding (tin, lead)."
    ],
    a: 3,
    why: "Diamond (C) is 100% covalent. Moving down Group IVA, silicon and germanium are semi-metals, and tin and lead exhibit predominantly metallic bonding."
  },
  {
    q: "What type of mixed bonding occurs in intermetallic compounds formed between metallic elements with a significant electronegativity difference?",
    o: [
      "Mixed covalent-van der Waals bonding",
      "Pure hydrogen bonding",
      "Mixed metallic-ionic bonding",
      "Nuclear magnetic bonding"
    ],
    a: 2,
    why: "Intermetallics (compounds formed between different metals like Au and Cu or Ti and Al) lie along the metallic-ionic edge. If electronegativities differ, partial electron transfer adds an ionic component."
  },
  {
    q: "In titanium aluminide (TiAl<sub>3</sub>), the electronegativities are $X_{\\mathrm{Ti}} = 1.5$ and $X_{\\mathrm{Al}} = 1.5$. What is the ionic character of this bond?",
    o: [
      "$100\\%$ ionic character",
      "$25\\%$ ionic character",
      "$50\\%$ ionic character",
      "Zero ionic character (the bond is almost purely metallic)"
    ],
    a: 3,
    why: "Since $\\Delta X = 1.5 - 1.5 = 0$, $\\%IC = \\{1 - \\exp[0]\\} \\times 100 = 0\\%$. The bond has no ionic component and is almost purely metallic."
  },
  {
    q: "For the intermetallic compound AuCu<sub>3</sub>, the electronegativity difference is $\\Delta X = X_{\\mathrm{Au}} - X_{\\mathrm{Cu}} = 2.4 - 1.9 = 0.5$. Calculate its percent ionic character using Pauling's formula.",
    o: [
      "$1.2\\%$",
      "$6.1\\%$",
      "$18.5\\%$",
      "$35.0\\%$"
    ],
    a: 1,
    why: "$\\Delta X = 0.5 \\implies (\\Delta X)^2 = 0.25$. Exponent $= -0.25 \\times 0.25 = -0.0625$. $\\%IC = \\{1 - \\exp[-0.0625]\\} \\times 100 = (1 - 0.9394) \\times 100 \\approx 6.1\\%$."
  },
  {
    q: "What defines a molecule in materials science?",
    o: [
      "Any collection of atoms with metallic bonding",
      "A discrete group of atoms bound together internally by strong, directional covalent bonds (intramolecular bonds)",
      "An open crystalline lattice of ions held by nondirectional coulombic forces",
      "A macroscopic chunk of metal containing billions of ion cores"
    ],
    a: 1,
    why: "A molecule is a discrete entity whose constituent atoms are held together by strong intramolecular covalent bonds (e.g., H<sub>2</sub>, O<sub>2</sub>, H<sub>2</sub>O, CH<sub>4</sub>)."
  },
  {
    q: "In condensed states (liquids and solids) of molecular substances, what type of bonding acts between adjacent separate molecules?",
    o: [
      "Weak secondary intermolecular bonds (van der Waals or hydrogen bonds)",
      "Continuous metallic electron seas",
      "Direct ionic coulombic electron transfers",
      "High-energy covalent triple bonds"
    ],
    a: 0,
    why: "Molecules are held to adjacent molecules in condensed phases only by weak secondary intermolecular forces, explaining their characteristically low melting and boiling points."
  },
  {
    q: "Why do polymeric materials exist as solid plastics at room temperature despite being composed of molecular chains?",
    o: [
      "Polymer chains are joined to one another by metallic bonding.",
      "Their enormous macromolecular chain lengths create thousands of cumulative intermolecular secondary bonds between adjacent chains.",
      "Polymer molecules undergo spontaneous cold fusion into ceramic crystals.",
      "Polymers contain interstitial iron atoms that weld chains together."
    ],
    a: 1,
    why: "Although individual secondary bonds are weak, the vast length of polymer macromolecules creates thousands of cumulative secondary bonds along each chain, providing sufficient cohesion for solid behavior at room temperature."
  },
  {
    q: "On the material-type tetrahedron (Figure 2.25b), which material classification is positioned along the covalent-ionic edge?",
    o: [
      "Ceramics",
      "Metals",
      "Molecular solids",
      "Intermetallics"
    ],
    a: 0,
    why: "Ceramics occupy the ionic vertex and extend along the covalent-ionic mixed edge, reflecting their mixed ionic and covalent bonding."
  },
  {
    q: "On the material-type tetrahedron, where are semiconductors positioned?",
    o: [
      "At the metallic vertex",
      "At the van der Waals vertex",
      "Near the covalent vertex, extending slightly along the covalent-ionic edge",
      "Directly along the metallic-ionic edge"
    ],
    a: 2,
    why: "Semiconductors (like Si, Ge, GaAs, InSb) are primarily covalent, situated near the covalent vertex with variable ionic contributions in compound semiconductors."
  },
  {
    q: "Compute the percent ionic character (%IC) for a hypothetical compound with electronegativity difference $\\Delta X = 1.0$, using Pauling's equation.",
    o: [
      "$5.8\\%$",
      "$11.5\\%$",
      "$22.1\\%$",
      "$39.3\\%$"
    ],
    a: 2,
    why: "$\\Delta X = 1.0 \\implies -0.25(1.0)^2 = -0.25$. $\\%IC = \\{1 - \\exp[-0.25]\\} \\times 100 = (1 - 0.7788) \\times 100 \\approx 22.1\\%$."
  }
];

CARDS['m1-mixed'] = [
  { f: "Bonding tetrahedron", b: "A 3D tetrahedron showing pure bonding extremes (ionic, covalent, metallic, van der Waals) at vertices, with mixed bonds represented along edges and faces." },
  { f: "Pauling %IC formula", b: "$\\mathrm{\\%IC} = \\{1 - \\exp[-0.25(X_A - X_B)^2]\\} \\times 100$, quantifying ionic character based on the difference in electronegativity $\\Delta X$." },
  { f: "Example 2.3 (C–H bond %IC)", b: "With $X_C = 2.5$ and $X_H = 2.1$, $\\Delta X = 0.4$; $\\mathrm{\\%IC} = 3.9\\%$, meaning the C–H bond is $96.1\\%$ covalent." },
  { f: "Metalloids (semi-metals)", b: "Elements (B, Si, Ge, As, Sb, Te, Po, At) exhibiting mixed covalent-metallic bonding, with properties intermediate between metals and nonmetals." },
  { f: "Group IVA bonding transition", b: "Moving down Group IVA: carbon (diamond, pure covalent) $\\longrightarrow$ silicon/germanium (semi-metals) $\\longrightarrow$ tin/lead (predominantly metallic)." },
  { f: "Intermetallic compounds", b: "Stoichiometric compounds between metallic elements displaying mixed metallic-ionic bonding due to electronegativity differences (e.g., AuCu<sub>3</sub>)." },
  { f: "Intra- vs. intermolecular bonds", b: "Intramolecular bonds are strong covalent bonds holding atoms inside a molecule; intermolecular bonds are weak secondary forces acting between separate molecules." },
  { f: "Material-type tetrahedron mapping", b: "Correlates materials with bonding: metals (metallic), polymers (covalent), ceramics (ionic/covalent-ionic), molecular solids (van der Waals)." }
];
