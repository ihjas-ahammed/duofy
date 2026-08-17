# Duofy Reusable Lesson Format: Cross-Coupling Reactions and Palladium Catalysis

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Inorganic_Chemistry / Organometallic_Chemistry_and_Catalysis`  
**Lesson Format Type:** `cross_coupling_reactions_and_palladium_catalysis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of palladium-catalyzed carbon-carbon cross-coupling reactions (Richard F. Heck, Ei-ichi Negishi, Akira Suzuki, Nobel Prize 2010): map the universal three-step catalytic cycle (**1. Oxidative Addition of $\text{R}-\text{X}$ to $\text{Pd}^0$ forming $\text{Pd}^{\text{II}}$**, **2. Transmetallation with Organometallic Reagent $\text{R}'-\text{M}$**, **3. Reductive Elimination of $\text{R}-\text{R}'$ regenerating $\text{Pd}^0$**), compare the specific main-group organometallic reagents across name reactions (**Suzuki-Miyaura**: organoboronic acids $\text{R}'-\text{B}(\text{OH})_2$ with base activation; **Negishi**: organozinc $\text{R}'-\text{ZnX}$; **Stille**: organotin $\text{R}'-\text{SnR}_3$; **Kumada**: Grignard $\text{R}'-\text{MgX}$; **Heck**: alkene carbopalladation), and interact with live Suzuki cross-coupling reaction builder widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Palladium Cross-Coupling Suite Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Cross-Coupling Name Reaction & Organometallic Partner Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Suzuki-Miyaura Coupling Transmetallation Base Role Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Suzuki-Miyaura Boron Reagent Organometallic Class Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Suzuki-Miyaura Cross-Coupling Reaction Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cross_coupling_reactions_and_palladium_catalysis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the universal catalytic cycle of Palladium-catalyzed cross-coupling reactions (Suzuki, Negishi, Stille)?",
      "blankAnswer": "Palladium-catalyzed cross-coupling (Nobel Prize in Chemistry 2010 to Heck, Negishi, and Suzuki) unites an organic halide/pseudohalide (R-X, where X = I, Br, OTf, Cl) with an organometallic nucleophile (R'-M) to forge new C-C or C-Heteroatom bonds. The universal 3-step catalytic cycle operates via: (1) Oxidative Addition: Low-valent electron-rich Pd(0) (14e⁻) inserts into the R-X bond to form a trans-square planar Pd(II) intermediate [R-Pd(II)(L)2-X] (16e⁻). (2) Transmetallation: The organometallic reagent (R'-M) transfers its organic group R' onto Pd(II), displacing the halide X and forming [R-Pd(II)(L)2-R']. (3) Reductive Elimination: Cis-isomerization allows R and R' to couple and eliminate as the target product R-R', simultaneously regenerating the active Pd(0) catalyst to restart the cycle!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Palladium-catalyzed cross-coupling reaction to its specific organometallic reagent.",
      "matchPairs": [
        { "left": "Suzuki-Miyaura Coupling", "right": "Organoboronic acids / boronates R-B(OH)2 (requires base like K2CO3 or NaOEt)" },
        { "left": "Negishi Coupling", "right": "Organozinc reagents R-ZnX / R2Zn (high functional group tolerance)" },
        { "left": "Stille Coupling", "right": "Organotin reagents R-SnBu3 (toxic organostannanes, neutral conditions)" },
        { "left": "Kumada Coupling", "right": "Grignard reagents R-MgX / organolithiums (highly reactive, moisture sensitive)" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is an inorganic or organic base (e.g. K2CO3, NaOH, or Cs2CO3) OBLIGATORY for the Suzuki-Miyaura cross-coupling reaction to proceed?",
      "options": [
        { "text": "The base attacks the electrophilic trivalent boron atom to form a negatively charged, nucleophilic 4-coordinate boronate 'ate' complex [R-B(OH)3]⁻, which dramatically accelerates transmetallation onto the Pd(II) center", "isCorrect": true, "explanation": "Correct! Neutral trivalent organoboronic acids R-B(OH)2 are poor nucleophiles and undergo extremely slow transmetallation. Base (OH⁻, RO⁻, CO3²⁻) coordinates to boron to form an electron-rich anionic 'ate' complex [R-B(OH)3]⁻, which readily transfers the R group to palladium. Alternatively, base exchanges with halide on Pd to form [L2Pd(R)(OH)], which attacks the boronic acid." },
        { "text": "The base evaporates the solvent", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The base destroys the palladium catalyst", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The base reduces Pd(II) to Pd(-II)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Suzuki-Miyaura cross-coupling reaction utilizes organo-___ compounds (such as boronic acids) as the nucleophilic coupling partner.",
      "blankAnswer": "boron",
      "blankDistractors": ["zinc", "tin", "magnesium"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Suzuki-Miyaura Cross-Coupling Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Suzuki-Miyaura Catalytic Cycle Engine</h3><p>Coupling: 4-Bromoanisole + Phenylboronic Acid | Catalyst: $\\text{Pd}(\\text{PPh}_3)_4$ + $\\text{K}_2\\text{CO}_3$</p><button id=\"ccBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Execute Catalytic Cycle (Ox. Add. → Transmetal. → Red. Elim.)</button><div id=\"ccOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('ccBtn').onclick=()=>{document.getElementById('ccOut').innerText='Catalysis Complete: (1) Oxidative Addition: Pd(0) inserts into Ar-Br bond -> [Ar-Pd(II)(PPh3)2-Br]. (2) Transmetallation: [Ph-B(OH)3]⁻ transfers phenyl ring -> [Ar-Pd(II)(PPh3)2-Ph]. (3) Reductive Elimination: C-C bond formed, releasing 4-Methoxybiphenyl (98% yield) and regenerating Pd(0) catalyst!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
