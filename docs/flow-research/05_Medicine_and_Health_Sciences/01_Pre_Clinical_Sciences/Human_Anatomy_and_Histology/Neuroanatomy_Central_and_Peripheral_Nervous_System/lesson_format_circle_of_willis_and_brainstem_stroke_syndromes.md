# Duofy Reusable Lesson Format: Vascular Neurology (Circle of Willis & Brainstem Strokes)

**Target Topic:** `05_Medicine_and_Health_Sciences / 01_Pre_Clinical_Sciences / Human_Anatomy_and_Histology / Neuroanatomy_Central_and_Peripheral_Nervous_System`  
**Lesson Format Type:** `circle_of_willis_and_brainstem_stroke_syndromes`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the vascular neuroanatomy of cerebral blood supply, the arterial anastomosis of the **Circle of Willis** (Internal Carotid Arteries ICA, Anterior Cerebral Arteries ACA, Anterior Communicating Artery ACoA, Middle Cerebral Arteries MCA, Posterior Communicating Arteries PCoA, Posterior Cerebral Arteries PCA, Basilar Artery formed by Vertebral Arteries), the brainstem blood supply (PICA, AICA, SCA, Basilar paramedian branches, Anterior Spinal Artery ASA), and the clinical neurovascular localization of classic brainstem stroke syndromes: **Lateral Medullary (Wallenberg) Syndrome** due to Posterior Inferior Cerebellar Artery (PICA) / Vertebral artery infarction, **Medial Medullary Syndrome** (ASA infarction), and **Weber Syndrome** (paramedian midbrain PCA infarction) (Hal Blumenfeld *Neuroanatomy through Clinical Cases* 3rd ed. Chapters 10, 11, 14; Eric R. Kandel *Principles of Neural Science* 6th ed. Chapter 61; Dale Purves *Neuroscience* 6th ed. Chapter 14): formulate the **Brainstem Stroke Syndromes Cross-Sectional Localization Matrix**:
$$\begin{array}{|l|l|l|l|}
\hline
\textbf{Brainstem Stroke Syndrome} & \textbf{Occluded Artery} & \textbf{Damaged Neuroanatomical Structures} & \textbf{Clinical Neurological Presentation} \\
\hline
\mathbf{\text{Lateral Medullary (Wallenberg)}} & \mathbf{\text{PICA / Vertebral Artery}} & \mathbf{\begin{cases} \text{1. Spinal Trigeminal Nucleus (V)} \\ \text{2. Spinothalamic Tract} \\ \text{3. Nucleus Ambiguus (IX, X)} \\ \text{4. Inferior Cerebellar Peduncle} \\ \text{5. Descending Sympathetics} \end{cases}} & \mathbf{\begin{cases} \text{Ipsilateral facial pain/temp loss} \\ \text{Contralateral body pain/temp loss} \\ \text{Dysphagia, hoarseness, absent gag} \\ \text{Ipsilateral limb ataxia, vertigo, nystagmus} \\ \text{Ipsilateral Horner's Syndrome (ptosis, miosis, anhidrosis)} \end{cases}} \\
\hline
\mathbf{\text{Medial Medullary Syndrome}} & \mathbf{\text{Anterior Spinal Artery (ASA)}} & \begin{cases} \text{1. Medullary Pyramid (CST)} \\ \text{2. Medial Lemniscus (DCML)} \\ \text{3. Hypoglossal Nucleus (XII)} \end{cases} & \begin{cases} \text{Contralateral UMN spastic hemiparesis} \\ \text{Contralateral loss of proprioception/vibration} \\ \text{Ipsilateral tongue deviation toward lesion} \end{cases} \\
\hline
\mathbf{\text{Weber Syndrome (Midbrain)}} & \mathbf{\text{PCA / Paramedian Branches}} & \begin{cases} \text{1. Oculomotor Nerve (CN III)} \\ \text{2. Cerebral Peduncle (CST)} \end{cases} & \begin{cases} \text{Ipsilateral CN III palsy (blown pupil, ptosis, down-and-out)} \\ \text{Contralateral spastic hemiparesis} \end{cases} \\
\hline
\end{array}$$
(proving the "Crossed Signs" neurological principle: cranial nerve deficits are strictly *ipsilateral* to the lesion, while long sensory and motor tract deficits are *contralateral*), and interact with live Corticospinal UMN/LMN reflex tracer, DCML vs Spinothalamic sensory pathway map, Basal Ganglia D1/D2 circuit solver, and Circle of Willis stroke localization widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Circle of Willis, Brainstem Arterial Perfusion & Wallenberg (PICA) "Crossed Signs" Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Localize a Brainstem Infarction Using Cranial Nerve vs Long Tract Deficits Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Brainstem Nucleus / Stroke Syndrome & Technical Neurological Localization Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Lateral Medullary (Wallenberg) Syndrome, Infarction of the Posterior Inferior Cerebellar Artery (PICA) Causes Dysphagia, Hoarseness, and Loss of the Gag Reflex by Damaging the Nucleus ___ (Ambiguus / Nucleus Ambiguus) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Clinical Neuroanatomy Studio: Long Tracts, UMN/LMN, Basal Ganglia & Circle of Willis Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "circle_of_willis_and_brainstem_stroke_syndromes",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the anatomical basis of 'crossed signs' in Wallenberg Lateral Medullary Syndrome, and which artery is occluded?",
      "blankAnswer": "Brainstem Vascular Localization (Blumenfeld 2021; Kandel 2021): (1) OCCLUDED ARTERY: Posterior Inferior Cerebellar Artery (PICA) or Vertebral Artery. (2) CROSSED SIGNS MECHANISM: Cranial nerve nuclei supply the ipsilateral head without crossing, while long tracts carry crossed body information. (3) WALLENBERG DEFICITS: - Spinal trigeminal tract/nucleus \u2192 Ipsilateral loss of facial pain/temperature; - Spinothalamic tract \u2192 Contralateral loss of body pain/temperature; - Nucleus ambiguus (CN IX, X) \u2192 Dysphagia, hoarseness, diminished gag reflex; - Inferior cerebellar peduncle \u2192 Ipsilateral limb ataxia; - Descending oculosympathetic tract \u2192 Ipsilateral Horner's syndrome (ptosis, miosis, anhidrosis)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential clinical diagnostic steps to localize an acute brainstem ischemic stroke syndrome.",
      "orderItems": [
        "Perform cranial nerve exam to identify ipsilateral cranial nerve palsy (e.g. CN III in midbrain, CN VII in pons, CN IX/X/XII in medulla)",
        "Examine long motor tracts to detect contralateral spastic hemiparesis (indicates medial brainstem corticospinal involvement)",
        "Examine sensory modalities: test DCML vibration (medial lemniscus) and Spinothalamic pain/temp (lateral brainstem)",
        "Evaluate cerebellar coordination (finger-to-nose, heel-to-shin) to assess involvement of cerebellar peduncles",
        "Correlate the 3D anatomical overlap of damaged nuclei and tracts to identify the specific occluded arterial branch (PICA, AICA, or ASA)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Brainstem Stroke Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Wallenberg Syndrome (PICA)", "right": "Lateral medullary infarct causing ipsilateral facial pain loss, contralateral body pain loss, dysphagia, and Horner's" },
        { "left": "Medial Medullary Syndrome (ASA)", "right": "Paramedian medullary infarct causing contralateral hemiparesis, contralateral DCML loss, and ipsilateral tongue deviation" },
        { "left": "Weber Syndrome (PCA)", "right": "Midbrain peduncle infarct causing ipsilateral CN III oculomotor palsy and contralateral spastic hemiparesis" },
        { "left": "Nucleus Ambiguus", "right": "Motor nucleus of CN IX and X in lateral medulla controlling branchial muscles of palate, pharynx, and larynx" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In lateral medullary (Wallenberg) syndrome, infarction of the posterior inferior cerebellar artery (PICA) causes dysphagia, hoarseness, and loss of the gag reflex by damaging the nucleus ___.",
      "blankAnswer": "ambiguus",
      "blankDistractors": ["tractus solitarius", "gracilis", "cuneatus"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Clinical Neuroanatomy Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Clinical Neuroanatomy & Stroke Localization Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Corticospinal UMN/LMN, DCML vs ALS, Basal Ganglia & Wallenberg PICA</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnUmn\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. UMN vs LMN (Babinski + Clonus)</button><button id=\"btnSens\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. DCML vs ALS (Brown-S\u00e9quard)</button><button id=\"btnBg\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Basal Ganglia & Wallenberg PICA</button></div><div id=\"neuLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate motor system UMN vs LMN signs...</div><script>document.getElementById('btnUmn').onclick=()=>{document.getElementById('neuLog').innerHTML='<b>1. CORTICOSPINAL TRACT \\& UMN/LMN SIGNS:</b><br>• Internal Capsule Stroke &rarr; Contralateral <b style=\"color:#10b981;\">Spasticity, Hyperreflexia (3+), Babinski Positive!</b><br>• Anterior Horn LMN &rarr; <b style=\"color:#38bdf8;\">Flaccid paralysis, Areflexia, Fasciculations!</b>';}; document.getElementById('btnSens').onclick=()=>{document.getElementById('neuLog').innerHTML='<b>2. SOMATOSENSORY PATHWAYS \\& BROWN-S\\u00c9QUARD:</b><br>• DCML: Uncrossed in cord &rarr; <b style=\"color:#10b981;\">Ipsilateral vibration/proprioception loss!</b><br>• ALS: Crosses in anterior white commissure &rarr; <b style=\"color:#38bdf8;\">Contralateral pain/temp loss!</b>';}; document.getElementById('btnBg').onclick=()=>{document.getElementById('neuLog').innerHTML='<b>3. BASAL GANGLIA \\& WALLENBERG PICA STROKE:</b><br>• Parkinson\\'s: Loss of SNc dopamine &rarr; <b style=\"color:#10b981;\">Hyperactive GPi &rarr; Deep Thalamic Inhibition!</b><br>• Wallenberg (PICA Infarct): Ipsilateral face pain/Horner + Contralateral body pain + Nucleus Ambiguus Dysphagia!<br>🏆 <b style=\"color:#10b981;\">Neuroanatomy_Central_and_Peripheral_Nervous_System 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
