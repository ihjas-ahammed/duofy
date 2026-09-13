/* ═══════════════════ START HERE ═══════════════════ */
STATIONS.push({
  id: 'start',
  title: 'Course Orientation & 4-Hour Study Plan',
  short: 'Start here',
  est: '~10 min',
  body: H`
${gist('Calicut University CU-FYUGP B.Sc. Physics (Honours) · Semester V · Major Elective Specialization I: Materials Science (4 Credits · 60 Lecture Hours · Modules I & II).')}

<div class="note key" style="margin:1rem 0">
  <div class="nh">How to use this revision app tonight</div>
  <p>This app covers every syllabus requirement from <b>William D. Callister, Jr., Materials Science and Engineering: An Introduction</b> (Chapters 1.2–1.6, 2.5–2.10, 3.13–3.17, 4.1–4.11). It is built for deliberate, high-retrieval practice:</p>
  <ul>
    <li><b>Real Formula Figures:</b> Every diagram is drawn live on HTML5 canvas using the real physical functions (bonding-energy curve, %IC Pauling equation, XRD diffractogram, Bragg wave interference, 3D rotating unit cells).</li>
    <li><b>Reveal-One-Step Ladders:</b> Derivation rungs let you guess the next mathematical step before revealing it—the secret to making derivations stick under exam conditions.</li>
    <li><b>Calibrated Checkpoints:</b> Rate your confidence (0 to 3) <em>before</em> clicking reveal. Calibrating what you actually know versus what you think you know prevents illusory mastery.</li>
    <li><b>Full 252-Question OMR Bank & Flashcards:</b> Every single section ends with exam-style multiple-choice questions with full explanations and Leitner 3D flashcards.</li>
  </ul>
</div>

${tp('Your 4-Hour Study Schedule')}
<div class="plan">
  <div class="slot"><span class="when">2 h</span><div class="what"><b>Module I — Materials, Forces & Bonding</b>
    <span>Read through the 9 sections (Chapters 1.2 to 2.10). Interact with the bonding potential well, rotate the 3D crystal models (CH₄, diamond, graphite, NaCl, ice, tetrahedron), and complete each checkpoint before revealing the answer.</span></div></div>
  <div class="slot"><span class="when">1½ h</span><div class="what"><b>Module II — Crystals, Defects & Microstructure</b>
    <span>Cover polymorphism, Bragg diffraction, powder XRD peaks, vacancies, impurities, dislocations, and grain boundaries. Work through the worked numerical problems and checkpoints.</span></div></div>
  <div class="slot"><span class="when">½ h</span><div class="what"><b>Model Test & Sleep</b>
    <span>Sit the timed model paper in the exam section. Then sleep—sleep is when your brain encodes and consolidates synaptic pathways.</span></div></div>
</div>

${tp('Syllabus Breakdown: Modules I & II')}
${tbl(
  ['Module', 'Callister Sections', 'Key Topics & Core Concepts', 'Exam Mark Weighting'],
  [
    ['<b>Module I</b>', 'Sections 1.2–1.6<br>Sections 2.5–2.10', 'Materials Science vs Engineering, structural scales, processing-structure-properties tetrahedron, metals/ceramics/polymers/composites/advanced, atomic bonding (ionic, covalent, metallic, secondary van der Waals, hydrogen bonding, mixed bonding tetrahedron, %IC).', '<b>25–30 Marks</b>'],
    ['<b>Module II</b>', 'Sections 3.13–3.17<br>Sections 4.1–4.11', 'Single crystals vs polycrystals, solidification stages, anisotropy of E, X-ray diffraction (Bragg’s law, diffractometer, reflection rules), noncrystalline/amorphous SiO₂, point defects (vacancies, self-interstitials, Boltzmann equation), solid solutions & Hume-Rothery rules, wt% ↔ at% conversions, dislocations (edge, screw, mixed, Burgers vector), interfacial defects (surfaces, grain/twin boundaries), optical/electron/probe microscopy, ASTM grain size.', '<b>35–40 Marks</b>']
  ]
)}

${tp('Warm-up: Match the Material Class to its Bonding & Properties')}
${match('Match the material category to its defining atomic bonding and typical properties', [
  ['Metals (e.g. Cu, Fe, Al)', 'Nondirectional metallic electron sea · high electrical & thermal conductivity, ductile'],
  ['Ceramics (e.g. Al₂O₃, SiC, NaCl)', 'Ionic & covalent bonds · high melting temperature, hard, stiff, brittle, insulating'],
  ['Polymers (e.g. Polyethylene, Teflon)', 'Covalent backbone with secondary van der Waals intermolecular links · low density, flexible'],
  ['Semiconductors (e.g. Si, Ge, GaAs)', 'Covalent bonds with intermediate conductivity highly sensitive to dopants'],
  ['Biomaterials (e.g. Ti alloys, Hydroxyapatite)', 'Engineered for biocompatibility without triggering toxic rejection by human host tissue']
])}
`
});
