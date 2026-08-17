# Duofy Reusable Lesson Format: Pneumocystis jirovecii and Mucormycosis Pathogenesis

**Target Topic:** `02_Physical_and_Life_Sciences / 04_Microbiology_and_Immunology / Mycology_and_Parasitology / Fungal_Pathogens`  
**Lesson Format Type:** `pneumocystis_jirovecii_and_mucormycosis_pathogenesis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid histological, pathophysiological, and pharmacological mastery of aggressive opportunistic mycoses: contrast **1. *Pneumocystis jirovecii*** (atypical unicellular ascomycete fungus lacking ergosterol, utilizing cholesterol, causing bilateral diffuse interstitial plasma cell pneumonia [PCP] with "crushed ping-pong ball" or cup-shaped cysts on **Gomori Methenamine Silver [GMS] stain** in AIDS patients with $\text{CD4} < 200/\mu\text{L}$; treated with **Trimethoprim-Sulfamethoxazole [TMP-SMX]**, *not* standard antifungals) with **2. Mucormycosis (*Rhizopus, Mucor, Rhizomucor*)** (angioinvasive mold with **broad, ribbon-like, non-septate hyphae branching at wide right [$90^\circ$] angles**, utilizing high host iron/glucose to aggressively invade vascular elastic lamina, causing rapid rhinocerebral tissue necrosis with black eschars in diabetic ketoacidosis [DKA] and neutropenic patients; treated with surgical debridement and high-dose Liposomal Amphotericin B or Isavuconazole), and interact with live Gomori methenamine silver vs KOH microscopic simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Pneumocystis vs Mucorales Pathologies Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Atypical / Angioinvasive Fungus & Clinical Pathology Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Pneumocystis jirovecii First-Line Pharmacotherapy Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Branching Angle of Mucorales Non-Septate Hyphae Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive GMS vs KOH Microscopic Diagnostic Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "pneumocystis_jirovecii_and_mucormycosis_pathogenesis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are the unique cellular features and clinical presentations of Pneumocystis jirovecii and Mucorales fungi?",
      "blankAnswer": "Atypical and angioinvasive mycoses present distinct clinical profiles: (1) PNEUMOCYSTIS JIROVECII (PCP): An atypical ascomycete fungus whose plasma membrane contains mammalian-like cholesterol rather than ergosterol (rendering polyenes and azoles ineffective!). In immunocompromised patients (especially HIV/AIDS with CD4 < 200/uL), it causes diffuse interstitial plasma cell pneumonia with foamy alveolar exudates and severe hypoxemia. Diagnosed on Gomori Methenamine Silver (GMS) stain showing cup-shaped, disc-like cysts resembling crushed ping-pong balls. First-line therapy and prophylaxis is Trimethoprim-Sulfamethoxazole (TMP-SMX), targeting folate synthesis! (2) MUCORMYCOSIS (Rhizopus, Mucor, Lichtheimia): Saprophytic molds featuring broad, ribbon-like, non-septate hyphae branching at wide 90-degree right angles. In patients with Diabetic Ketoacidosis (DKA, where free iron and acidosis accelerate fungal growth) or severe neutropenia, the hyphae directly penetrate blood vessel walls (angioinvasion), causing thrombosis, infarction, and rapid tissue necrosis (black eschars on the palate and face in rhinocerebral mucormycosis). Requires emergent surgical debridement and IV Liposomal Amphotericin B!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each opportunistic fungal pathogen to its defining clinical feature.",
      "matchPairs": [
        { "left": "Pneumocystis jirovecii", "right": "Atypical fungus with cholesterol in membrane; causes diffuse PCP pneumonia when CD4 < 200/uL; treated with TMP-SMX" },
        { "left": "Mucor / Rhizopus species", "right": "Broad non-septate hyphae branching at 90-degree angles; angioinvasive black eschar in diabetic ketoacidosis" },
        { "left": "Gomori Methenamine Silver (GMS)", "right": "Special histological silver stain visualizing cup-shaped, disc-like Pneumocystis cysts in bronchoalveolar lavage" },
        { "left": "Rhinocerebral Mucormycosis", "right": "Rapidly fatal facial and orbital fungal necrosis thriving in acidic environments with high free iron" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is Trimethoprim-Sulfamethoxazole (TMP-SMX), an antibacterial folate antagonist, the first-line drug of choice for treating Pneumocystis jirovecii pneumonia, while standard antifungal azoles and polyenes are ineffective?",
      "options": [
        { "text": "Pneumocystis jirovecii has an atypical plasma membrane that contains cholesterol instead of ergosterol (depriving azoles and polyenes of their target), while possessing active dihydropteroate synthase and dihydrofolate reductase enzymes that are potently inhibited by TMP-SMX", "isCorrect": true, "explanation": "Correct! Pneumocystis jirovecii is genetically classified as a fungus, but it possesses unique biochemical peculiarities. Unlike almost all other fungi, Pneumocystis lacks ergosterol in its plasma membrane, incorporating host cholesterol instead. Consequently, polyenes (Amphotericin B) and azoles (Fluconazole), which work by binding or blocking ergosterol, are completely ineffective. However, Pneumocystis is obligately reliant on de novo folate synthesis via dihydropteroate synthase and dihydrofolate reductase. The synergistic antibacterial combination Trimethoprim-Sulfamethoxazole (TMP-SMX) completely shuts down folate synthesis in Pneumocystis, making it the premier life-saving therapeutic and prophylactic regimen." },
        { "text": "Because Pneumocystis is actually a Gram-positive bacterium", "isCorrect": false, "explanation": "Incorrect: It is an ascomycete fungus." },
        { "text": "Because TMP-SMX destroys fungal RNA polymerase directly", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because azoles cannot enter the human lung under any conditions", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Under microscopic examination, Mucorales hyphae are broad, ribbon-like, non-septate, and branch at wide ___-degree right angles.",
      "blankAnswer": "90",
      "blankDistractors": ["45", "180", "15"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Opportunistic Fungal Microscopic Diagnostic Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Opportunistic Mycology Microscopic Engine</h3><p>Patient: Diabetic with Acute Facial Necrosis & Black Palatal Eschar</p><button id=\"mycBtn\" style=\"padding:8px 20px; background:#dc2626; color:white; border:none; border-radius:6px; cursor:pointer;\">Perform KOH / Calcofluor White Biopsy Stain</button><div id=\"mycOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('mycBtn').onclick=()=>{document.getElementById('mycOut').innerText='Microscopic Findings: Broad, ribbon-like, NON-SEPTATE hyphae branching at wide 90-DEGREE RIGHT ANGLES with extensive angioinvasion into blood vessel elastic lamina -> Diagnosis: MUCORMYCOSIS (Rhizopus/Mucor)! Action: Urgent surgical debridement + IV Liposomal Amphotericin B!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
