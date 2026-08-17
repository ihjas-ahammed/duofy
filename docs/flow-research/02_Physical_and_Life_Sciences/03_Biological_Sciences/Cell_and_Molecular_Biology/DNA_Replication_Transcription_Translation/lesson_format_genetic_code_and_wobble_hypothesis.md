# Duofy Reusable Lesson Format: Genetic Code and the Wobble Hypothesis

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Cell_and_Molecular_Biology / DNA_Replication_Transcription_Translation`  
**Lesson Format Type:** `genetic_code_and_wobble_hypothesis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid genetic, structural, and codon-anticodon decoding mastery of the universal genetic code (Marshall Nirenberg & Gobind Khorana, Nobel Prize 1968; Francis Crick 1966): formulate the 4 fundamental properties of the genetic code (**Triplet, Degenerate / Redundant [64 codons encoding 20 amino acids + 3 stop signals], Non-Overlapping, and Nearly Universal**), master **Crick's Wobble Hypothesis** at the $3'$ position of mRNA codons / $5'$ position of tRNA anticodons, evaluate non-Watson-Crick base pairing rules (especially **Inosine [I]** pairing with $\text{A, C, and U}$; $\text{G}$ pairing with $\text{C and U}$; $\text{U}$ pairing with $\text{A and G}$), and interact with live mRNA translation & codon-reading simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Genetic Code & Wobble Hypothesis Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Codon Position 3 Wobble Base & Anticodon Base 1 Pairing Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Genetic Code Degeneracy and Silent Mutation Protection Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Universal Translation Initiation Start Codon Triplet Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Genetic Code Codon Table & Inosine Wobble Engine Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "genetic_code_and_wobble_hypothesis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Crick's Wobble Hypothesis, and how does it explain why cells need fewer than 61 distinct tRNAs to decode 61 sense codons?",
      "blankAnswer": "The Genetic Code has 64 triplet codons (61 sense codons encoding 20 amino acids + 3 stop codons: UAA, UAG, UGA). Crick's Wobble Hypothesis (1966) explains that while the first two bases of an mRNA codon form strict, rigid Watson-Crick base pairs with bases 2 and 3 of the tRNA anticodon, spatial conformational flexibility ('wobble') exists at the 3' base of the codon and the 5' base of the anticodon. Non-standard base pairing rules at the 5' anticodon wobble position: (1) Inosine (I, deaminated adenosine): pairs promiscuously with A, C, or U (a single tRNA with 5'-I can decode 3 different codons!). (2) Guanine (G): pairs with C or U. (3) Uracil (U): pairs with A or G. (4) Cytosine (C): pairs strictly with G. (5) Adenine (A): pairs strictly with U. Because of wobble pairing, a typical cell requires only ~31-45 distinct tRNA species rather than 61 to translate the entire proteome accurately!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each 5'-anticodon base (tRNA base 34) to its permitted 3'-codon base partners (mRNA base 3) under Crick's wobble rules.",
      "matchPairs": [
        { "left": "5'-Inosine (I) on tRNA Anticodon", "right": "Pairs with 3'-U, 3'-C, or 3'-A on mRNA (maximum 3-codon flexibility)" },
        { "left": "5'-Guanine (G) on tRNA Anticodon", "right": "Pairs with 3'-C or 3'-U on mRNA" },
        { "left": "5'-Uracil (U) on tRNA Anticodon", "right": "Pairs with 3'-A or 3'-G on mRNA" },
        { "left": "5'-Cytosine (C) on tRNA Anticodon", "right": "Pairs strictly with 3'-G only (strict Watson-Crick pairing; zero wobble)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is the degeneracy (redundancy) of the genetic code and third-base wobble pairing considered a powerful evolutionary buffer against harmful mutations?",
      "options": [
        { "text": "Because single-base substitutions (point mutations) occurring at the third nucleotide position of a codon frequently code for the EXACT SAME AMINO ACID (silent/synonymous mutations), protecting proteins from structural defects and phenotypic disruption", "isCorrect": true, "explanation": "Correct! Most amino acids are specified by multiple codons that share the first two bases but differ at the third base (e.g. Glycine is encoded by GGU, GGC, GGA, and GGG). A transition or transversion at the third wobble position usually results in a silent (synonymous) mutation that produces an identical amino acid sequence, conferring substantial evolutionary robustness against deleterious DNA replication errors." },
        { "text": "Because third-base mutations turn RNA directly into diamond", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because wobble bases eliminate all stop codons completely", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because ribosomes destroy mutated mRNA immediately", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In virtually all living organisms, canonical translation initiation begins at the start codon triplet ___ (encoding methionine).",
      "blankAnswer": "aug",
      "blankDistractors": ["uaa", "uag", "uga"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Codon & Wobble Decoding Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Codon-Anticodon Wobble Simulator</h3><p>tRNA Anticodon: $5'\\text{-IAU-}3'$ | Target Codons for Isoleucine</p><button id=\"wobBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Decode mRNA Codons via Inosine Wobble</button><div id=\"wobOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('wobBtn').onclick=()=>{document.getElementById('wobOut').innerText='Wobble Pairing Analysis: (1) 5\\'-Inosine (I) pairs with 3\\'-U -> Decodes 5\\'-AUU-3\\' (Isoleucine). (2) 5\\'-Inosine (I) pairs with 3\\'-C -> Decodes 5\\'-AUC-3\\' (Isoleucine). (3) 5\\'-Inosine (I) pairs with 3\\'-A -> Decodes 5\\'-AUA-3\\' (Isoleucine). Conclusion: Single tRNA(IAU) flawlessly decodes all 3 isoleucine codons!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
