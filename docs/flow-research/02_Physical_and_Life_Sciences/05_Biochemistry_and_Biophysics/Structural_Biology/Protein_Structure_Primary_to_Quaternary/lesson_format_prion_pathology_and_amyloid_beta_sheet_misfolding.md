# Duofy Reusable Lesson Format: Prion Pathology and Amyloid Beta-Sheet Misfolding

**Target Topic:** `02_Physical_and_Life_Sciences / 05_Biochemistry_and_Biophysics / Structural_Biology / Protein_Structure_Primary_to_Quaternary`  
**Lesson Format Type:** `prion_pathology_and_amyloid_beta_sheet_misfolding`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid structural, biophysical, and neuropathological mastery of prion conversions and amyloid fibrillogenesis (Stanley Prusiner, Nobel Prize in Physiology or Medicine 1997): contrast normal cellular prion protein **$\text{PrP}^C$** (monomeric, membrane-anchored via GPI, rich in **$\alpha$-helices [$42\%$]**, soluble, sensitive to Proteinase K) with the pathogenic scrapie isoform **$\text{PrP}^{Sc}$** (oligomeric, enriched in **$\beta$-sheets [$43\%$]**, insoluble, highly resistant to Proteinase K, detergent-resistant), analyze the **template-directed nucleation-dependent polymerization model** of prion propagation, master the **Cross-$\beta$ Architecture of Amyloid Fibrils** (continuous $\beta$-sheets running parallel to the fibril axis with $\beta$-strands perpendicular at $4.7\text{ \AA}$ spacing), recognize the histological hallmark of **Congo Red birefringence (apple-green under polarized light)**, and interact with live prion conversion and amyloid nucleation simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | PrPC vs PrPSc Structural Transformation Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Prion / Amyloid Feature & Biophysical / Clinical Property Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | PrPSc Resistance to Proteinase K and Cross-Beta Amyloid Fibrils Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Polarized Light Birefringence Color of Congo Red Stained Amyloid Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Prion Conformational Cascade & Amyloid Fibril Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "prion_pathology_and_amyloid_beta_sheet_misfolding",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the structural basis of prion infectivity and how does PrPC transform into pathogenic PrPSc?",
      "blankAnswer": "Prion diseases (Creutzfeldt-Jakob disease, Kuru, BSE) represent a paradigm shift: infectious transmission via protein conformation alone without nucleic acids (Stanley Prusiner, 1997 Nobel): (1) NORMAL CELLULAR PRION (PrPC): A normal GPI-anchored cell-surface glycoprotein predominantly composed of ALPHA-HELICES (~42% alpha-helix, ~3% beta-sheet). It is monomeric, water-soluble, and rapidly degraded by Proteinase K. (2) INFECTIOUS SCRAPIE PRION (PrPSc): An identical primary amino acid sequence that undergoes a profound conformational transition into an ultra-stable, BETA-SHEET-RICH architecture (~43% beta-sheet, ~30% alpha-helix). It forms insoluble, highly ordered oligomers and cross-beta amyloid fibrils. (3) TEMPLATE-DIRECTED SEEDING: PrPSc acts as an autocatalytic template; when it physically encounters normal PrPC, it forces PrPC to refold into the beta-sheet-rich PrPSc conformation. (4) AMYLOID CROSS-BETA CORE: The beta-strands run perpendicular to the fibril long axis with 4.7 Angstrom inter-strand spacing. This hyper-stable crystalline lattice resists heat, formalin, ultraviolet radiation, and Proteinase K digestion, forming neurotoxic amyloid plaques that produce spongiform encephalopathy with diagnostic apple-green birefringence under polarized Congo Red microscopy!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each prion/amyloid property to its defining structural or diagnostic hallmark.",
      "matchPairs": [
        { "left": "Cellular Prion Protein (PrPC)", "right": "Soluble monomer rich in alpha-helices (42%) that is fully sensitive to Proteinase K digestion" },
        { "left": "Pathogenic Prion Protein (PrPSc)", "right": "Insoluble aggregate enriched in beta-sheets (43%) displaying marked resistance to Proteinase K" },
        { "left": "Cross-Beta Amyloid Fibril", "right": "Supramolecular fibril whose beta-strands run perpendicular to the main longitudinal fibril axis" },
        { "left": "Congo Red Staining", "right": "Diagnostic histological dye exhibiting pathognomonic apple-green birefringence under polarized light" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What happens when brain tissue containing the infectious scrapie prion protein (PrPSc) is treated with the aggressive broad-spectrum endopeptidase Proteinase K?",
      "options": [
        { "text": "The flexible N-terminal 67 amino acids are digested, leaving behind a highly resistant 27-30 kDa protease-resistant core (PrP 27-30) composed of densely packed, impenetrable beta-sheets that retains full infectious capacity", "isCorrect": true, "explanation": "Correct! When normal PrPC is exposed to Proteinase K, it is completely and rapidly hydrolyzed into small, non-infectious peptides within minutes because its loose alpha-helical structure is accessible to the protease active site. In contrast, when the pathogenic scrapie isoform PrPSc is incubated with Proteinase K, only its unstructured flexible N-terminus (residues 23-89) is cleaved. The remaining C-terminal core (residues 90-231, designated PrP 27-30) is completely resistant to digestion because its continuous, tightly interdigitated cross-beta amyloid sheets physically exclude the protease. This protease-resistant core maintains full autocatalytic seeding and lethal transmissible infectivity." },
        { "text": "Proteinase K completely dissolves PrPSc into harmless water within 1 second", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "PrPSc turns into a bacterial spore", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Proteinase K converts PrPSc into healthy alpha-helices", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "When viewed under cross-polarized light microscopy, tissue sections with amyloid deposits stained with Congo Red demonstrate pathognomonic apple-___ birefringence.",
      "blankAnswer": "green",
      "blankDistractors": ["red", "blue", "yellow"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Prion Conformational Cascade & Amyloid Fibril Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Prion Conformational Seeding Engine</h3><p>Baseline: Soluble Monomeric $\\text{PrP}^C$ (42% $\\alpha$-Helix, Sensitive to Protease K)</p><button id=\"prionBtn\" style=\"padding:8px 20px; background:#dc2626; color:white; border:none; border-radius:6px; cursor:pointer;\">Introduce Infectious PrPSc Seed</button><div id=\"prionOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('prionBtn').onclick=()=>{document.getElementById('prionOut').innerText='Conformational Cascade Triggered: (1) PrPSc binds PrPC -> Forces alpha-helices to refold into 43% beta-sheets! (2) Nucleation-dependent polymerization -> Insoluble Cross-Beta Amyloid Fibrils form. (3) Proteinase K resistance acquired (PrP 27-30 core). (4) Polarized light exam: Pathognomonic APPLE-GREEN BIREFRINGENCE with Congo Red!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
