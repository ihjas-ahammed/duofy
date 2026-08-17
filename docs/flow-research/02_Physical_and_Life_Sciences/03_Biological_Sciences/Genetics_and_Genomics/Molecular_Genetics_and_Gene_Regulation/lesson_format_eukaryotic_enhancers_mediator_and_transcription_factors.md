# Duofy Reusable Lesson Format: Eukaryotic Enhancers, Mediator, and Transcription Factors

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Genetics_and_Genomics / Molecular_Genetics_and_Gene_Regulation`  
**Lesson Format Type:** `eukaryotic_enhancers_mediator_and_transcription_factors`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid structural, spatial, and biophysical mastery of long-range eukaryotic transcriptional control (Robert Roeder, Roger Kornberg, Nobel Prize in Chemistry 2006): analyze **Enhancers** acting distance- and orientation-independently through **Topologically Associating Domains (TADs)** and chromatin loop extrusion (**CTCF insulator boundaries + Cohesin ring complexes**), examine the multi-subunit **Mediator Complex (30+ subunits)** bridging distal sequence-specific transcription factor activation domains with the **Basal Transcription Pre-Initiation Complex (PIC: TFIID/TBP, TFIIA, TFIIB, TFIIE, TFIIF, TFIIH)** at the core promoter, and interact with live enhancer-promoter chromatin looping simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Enhancers, Mediator & PIC Assembly Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Transcriptional Machinery Component & Biochemical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | General Transcription Factor Kinase/Helicase TFIIH Function Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | 30-Plus Subunit Molecular Bridge Complex Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Enhancer-Promoter Chromatin Looping & Mediator Engine Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "eukaryotic_enhancers_mediator_and_transcription_factors",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do distal Enhancers communicate with core Promoters over megabase genomic distances to activate eukaryotic transcription?",
      "blankAnswer": "Eukaryotic transcription initiation (Kornberg & Roeder, 2006 Nobel Prize) integrates distal spatial chromatin organization: (1) Enhancers: Modular non-coding DNA elements containing clustered binding motifs for sequence-specific transcription factors (activators). Enhancers function regardless of orientation and can reside kilobases or megabases upstream, downstream, or within introns of the target gene. (2) Chromatin Looping: Cohesin ring complexes extrude DNA loops until stalled by convergent boundary factor CTCF proteins, defining Topologically Associating Domains (TADs) that insulate enhancers and restrict them to target promoters. (3) The Mediator Complex: A massive 30-subunit multi-protein molecular bridge that physically links transcription factor activation domains bound at distal enhancers to RNA Polymerase II and the Pre-Initiation Complex (PIC: TFIID/TBP, TFIIA, TFIIB, TFIIE, TFIIF, TFIIH) assembled at the core TATA/Inr promoter. (4) TFIIH Execution: TFIIH uses its XPB/XPD helicase subunits to melt promoter DNA into a transcription bubble, and its CDK7 kinase subunit to phosphorylate Ser5 on the C-Terminal Domain (CTD) of RNA Pol II, releasing the polymerase from the promoter to commence processive elongation!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each transcription initiation factor to its precise molecular function.",
      "matchPairs": [
        { "left": "TFIID Complex (TBP + TAFs)", "right": "Recognizes and binds the core promoter TATA box and Initiator (Inr) elements to nucleate PIC assembly" },
        { "left": "The Mediator Complex", "right": "Massive >30-subunit coactivator bridge linking distal enhancer-bound activators to RNA Polymerase II" },
        { "left": "TFIIH Complex", "right": "Multifunctional factor with ATP-dependent DNA helicase activity and CDK7 kinase that phosphorylates Pol II CTD" },
        { "left": "CTCF / Cohesin Complex", "right": "Loop-extruding factors that organize chromatin into insulated Topologically Associating Domains (TADs)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What are the two vital enzymatic activities contained within the basal transcription factor TFIIH that are strictly required for eukaryotic transcription initiation and promoter clearance?",
      "options": [
        { "text": "ATP-DEPENDENT DNA HELICASE ACTIVITY (XPB/XPD) to unwind the promoter double helix, and CYCLIN-DEPENDENT KINASE ACTIVITY (CDK7) to phosphorylate Serine-5 on the C-terminal domain (CTD) of RNA Polymerase II to license promoter escape", "isCorrect": true, "explanation": "Correct! TFIIH is the most complex general transcription factor. It contains two DNA helicases (XPB and XPD, which are also essential for nucleotide excision repair) that use ATP hydrolysis to unwind the core promoter DNA into an open transcription bubble. Additionally, TFIIH contains the CDK-activating kinase module (CDK7/Cyclin H), which phosphorylates Ser5 on the heptad repeats (YSPTSPS) of RNA Polymerase II's CTD, triggering conformational release of Pol II from the pre-initiation complex into processive elongation." },
        { "text": "Reverse transcriptase and telomerase activities", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Topoisomerase and DNA ligase activities", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Ribonuclease and protease activities", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The massive multi-subunit coactivator complex that acts as a physical molecular bridge between distal enhancer-bound activators and RNA Polymerase II is called ___.",
      "blankAnswer": "mediator",
      "blankDistractors": ["cohesin", "condensin", "ribosome"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Enhancer-Promoter Looping Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Enhancer-Promoter Loop & PIC Assembly Engine</h3><p>Architecture: Enhancer ($-120\\text{ kb}$) | Core Promoter (TATA Box)</p><button id=\"loopBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Extrude Loop & Engage Mediator Complex</button><div id=\"loopOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('loopBtn').onclick=()=>{document.getElementById('loopOut').innerText='Transcriptional Initiation: (1) Cohesin/CTCF loop brings enhancer within 10 nm of promoter. (2) Activator binds 30-subunit Mediator complex. (3) Mediator recruits TFIID + RNA Pol II Pre-Initiation Complex. (4) TFIIH unwinds DNA and CDK7 phosphorylates Pol II CTD (Ser5). Transcription initiated at 100x basal rate!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
