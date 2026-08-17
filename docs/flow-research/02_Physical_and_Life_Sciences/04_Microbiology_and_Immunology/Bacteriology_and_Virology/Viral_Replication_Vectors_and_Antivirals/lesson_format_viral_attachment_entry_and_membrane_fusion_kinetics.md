# Duofy Reusable Lesson Format: Viral Attachment, Entry, and Membrane Fusion Kinetics

**Target Topic:** `02_Physical_and_Life_Sciences / 04_Microbiology_and_Immunology / Bacteriology_and_Virology / Viral_Replication_Vectors_and_Antivirals`  
**Lesson Format Type:** `viral_attachment_entry_and_membrane_fusion_kinetics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid structural, biophysical, and virological mastery of viral entry machines and membrane fusion kinetics (Don Wiley & Stephen Harrison; James Rothman): compare **Class I Viral Fusion Glycoproteins (e.g. Influenza Hemagglutinin HA2, HIV gp41, SARS-CoV-2 Spike S2, Ebola GP2)** characterized by $\alpha$-helical trimer-of-hairpins / coiled-coils and spring-loaded conformational transitions with **Class II (Flaviviruses e.g. Dengue E protein)** $\beta$-sheet architectures, contrast **pH-Dependent Endosomal Acidification Entry (Influenza, VSV)** with **pH-Independent Neutral Plasma Membrane Fusion (HIV, Herpesviruses)**, analyze entry inhibitors (**Maraviroc CCR5 antagonist, Enfuvirtide T-20 biomimetic peptide, Monoclonal antibodies**), and interact with live viral fusion conformational trigger simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Viral Membrane Fusion Machines Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Virus / Glycoprotein & Host Entry Receptor Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Class I Fusion Peptide Spring-Loaded Hairpin Transition Mechanism Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | HIV Co-Receptor Targeted by Antiviral Maraviroc Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Class I Viral Membrane Fusion Engine Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "viral_attachment_entry_and_membrane_fusion_kinetics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do enveloped viruses (like Influenza, HIV, and Coronaviruses) use Class I fusion glycoproteins to breach host cell lipid bilayers?",
      "blankAnswer": "Viral entry is driven by specialized fusion machinery: (1) RECEPTOR ENGAGEMENT & PRIMING: Viral surface glycoproteins bind host receptors (e.g. Influenza HA binds Sialic Acid; HIV gp120 binds CD4; SARS-CoV-2 Spike binds ACE2). Host proteases (TMPRSS2, Furin) prime the fusion protein by cleavage. (2) THE CLASS I FUSION TRIGGER: (a) pH-Dependent (Influenza, Ebola): Virion is endocytosed; endosomal acidification (pH < 5.5) triggers a massive 'spring-loaded' conformational shift in HA2. (b) pH-Independent (HIV): Binding to a chemokine co-receptor (CCR5 or CXCR4) triggers gp41 at neutral pH. (3) THE 6-HELIX BUNDLE ENGINE: The hydrophobic N-terminal 'Fusion Peptide' shoots forward and anchors directly into the host cell membrane. The glycoprotein then folds back on itself into an ultra-stable Six-Helix Bundle (6HB / trimer-of-hairpins). This jackknifing motion exerts tremendous mechanical pulling force that forces the viral and host lipid bilayers together through a hemifusion stalk into a complete fusion pore, discharging the viral capsid directly into the host cytoplasm!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each virus to its primary host cell attachment receptor and coreceptor.",
      "matchPairs": [
        { "left": "Human Immunodeficiency Virus (HIV-1)", "right": "Primary receptor: CD4 | Coreceptor: Chemokine receptor CCR5 or CXCR4" },
        { "left": "SARS-CoV-2 (Coronavirus)", "right": "Primary receptor: Angiotensin-Converting Enzyme 2 (ACE2) | Primed by TMPRSS2 protease" },
        { "left": "Influenza A Virus", "right": "Primary receptor: Terminal alpha-2,6 (human) or alpha-2,3 (avian) Sialic Acid residues" },
        { "left": "Rabies Virus (Rhabdoviridae)", "right": "Primary receptor: Nicotinic Acetylcholine Receptor (nAChR) and NCAM on neurons" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What is the biophysical driving force that overcomes the high hydration repulsion barrier between viral and host cell lipid bilayers during Class I membrane fusion?",
      "options": [
        { "text": "The highly exergonic, irreversible folding of the fusion glycoprotein (e.g. HIV gp41 or Influenza HA2) into an ultra-stable SIX-HELIX BUNDLE (trimer-of-hairpins), which pulls the two opposing membranes into close mechanical proximity (<1 nm) to force hemifusion and pore opening", "isCorrect": true, "explanation": "Correct! Lipid bilayers carry strong negative surface charges and hydration shells that naturally repel each other. Enveloped viruses overcome this barrier using mechanical energy stored in a metastable pre-fusion state. When triggered (by receptor binding or low pH), the protein undergoes a dramatic conformational change: the hydrophobic fusion peptide inserts into the host membrane, forming an extended intermediate. The protein then collapses into an energetically favorable six-helix bundle (hairpin), bringing the viral transmembrane anchor and the host fusion peptide together. The released free energy physically forces the outer leaflets to merge (hemifusion) and open a fusion pore." },
        { "text": "Hydrolysis of 10,000 ATP molecules in the extracellular space", "isCorrect": false, "explanation": "Incorrect: Membrane fusion is driven by protein conformational free energy, not extracellular ATP." },
        { "text": "Magnetic attraction between viral DNA and host RNA", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Viral proteins melt the entire host cell membrane into gas", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The clinical HIV entry inhibitor Maraviroc prevents viral fusion by acting as a negative allosteric antagonist of the human chemokine co-receptor ___.",
      "blankAnswer": "ccr5",
      "blankDistractors": ["cxcr4", "cd4", "cd8"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Class I Viral Membrane Fusion Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Viral Class I Membrane Fusion Machine</h3><p>Model: Influenza Hemagglutinin (HA) | Endosomal Acidification Trigger</p><button id=\"fusBtn\" style=\"padding:8px 20px; background:#ef4444; color:white; border:none; border-radius:6px; cursor:pointer;\">Acidify Endosome (pH 5.0) & Trigger Fusion</button><div id=\"fusOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('fusBtn').onclick=()=>{document.getElementById('fusOut').innerText='Conformational Cascade: (1) pH < 5.2 protonates HA2 loop. (2) Metastable HA springs open -> Fusion peptide inserts into host endosomal membrane! (3) HA2 folds back into 6-Helix Bundle -> Pulls membranes together (Delta G = -45 kcal/mol). (4) Hemifusion stalk -> Complete fusion pore opens! Viral RNPs discharged into cytoplasm!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
