# Duofy Reusable Lesson Format: Membrane Transport ATPases and Secondary Active Symporters

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Cell_and_Molecular_Biology / Organelles_and_Membrane_Transport`  
**Lesson Format Type:** `membrane_transport_atpases_and_secondary_active_symporters`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid quantitative, thermodynamic, and mechanistic mastery of transmembrane transport systems (Jens Christian Skou, Nobel Prize in Chemistry 1997 for $\text{Na}^+/\text{K}^+$-ATPase; Peter Agre & Roderick MacKinnon, Nobel Prize 2003): evaluate electrochemical potential gradients ($\Delta \tilde{\mu}_i = z_i F \Delta \Psi + R T \ln \frac{[C_i]_{\text{in}}}{[C_i]_{\text{out}}}$), formulate the **P-type ATPase Reaction Cycle ($E_1 \leftrightarrow E_1\text{-P} \leftrightarrow E_2\text{-P} \leftrightarrow E_2$)** for the **$\text{Na}^+/\text{K}^+$-ATPase ($3\text{Na}^+\text{ out} / 2\text{K}^+\text{ in}$ per ATP consumed)** and **SERCA $\text{Ca}^{2+}$-ATPase ($2\text{Ca}^{2+}\text{ in} / 2-3\text{H}^+\text{ out}$)**, analyze **Secondary Active Transport** mechanisms (e.g. **SGLT1 $\text{Na}^+/\text{glucose}$ symporter** in intestinal enterocytes and renal proximal tubules), and interact with live epithelial polarized glucose transport simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Primary vs Secondary Active Membrane Transport Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Transporter Class & Biological Transport Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Cardiac Glycoside Ouabain Inhibition of Sodium Pump Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | P-Type ATPase Covalently Phosphorylated Amino Acid Residue Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Epithelial Polarized Glucose Transport Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "membrane_transport_atpases_and_secondary_active_symporters",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do P-type ATPases establish transmembrane ionic gradients, and how do secondary active symporters harness this energy?",
      "blankAnswer": "Membrane transport mechanisms are categorized by their energetic coupling: (1) Primary Active P-type ATPases (Jens Christian Skou, 1997 Nobel Prize): Utilize ATP hydrolysis directly via an obligate covalent aspartyl-phosphate intermediate (E1-P <-> E2-P). The classic Na⁺/K⁺-ATPase pumps 3 Na⁺ out and 2 K⁺ in per ATP molecule hydrolyzed, creating a negative membrane potential (electrogenic pump) and a steep inward Na⁺ electrochemical gradient (high [Na⁺] outside, low inside). SERCA Ca²⁺-ATPase pumps 2 Ca²⁺ ions from cytoplasm into the sarcoplasmic reticulum lumen per ATP. (2) Secondary Active Transport: Does NOT consume ATP directly; instead, it harnesses the downhill thermodynamic potential energy of the Na⁺ gradient (Delta mu_Na) to drive the uphill accumulation of other solutes against their concentration gradients. For example, the SGLT1 Na⁺/glucose symporter couples the downhill entry of 2 Na⁺ ions down their electrochemical gradient to pump 1 glucose molecule uphill into intestinal enterocytes against a steep 1000-fold glucose concentration gradient!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each membrane transport protein to its energetic and transport mechanism.",
      "matchPairs": [
        { "left": "Na⁺/K⁺-ATPase (P-type Pump)", "right": "Primary active transport: hydrolyzes 1 ATP to export 3 Na⁺ and import 2 K⁺ via E1/E2 states" },
        { "left": "SGLT1 Na⁺/Glucose Symporter", "right": "Secondary active cotransport: harnesses inward Na⁺ gradient to accumulate glucose inside enterocytes" },
        { "left": "GLUT2 / GLUT4 Transporters", "right": "Facilitated passive diffusion: uniporter moving glucose down its chemical concentration gradient" },
        { "left": "V-Type H⁺-ATPase Pump", "right": "Rotary ATP-driven proton pump that acidifies lysosomes, endosomes, and plant vacuoles" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Cardiac glycosides like Ouabain and Digoxin specifically bind and inhibit the extracellular E2-P state of the Na⁺/K⁺-ATPase. Why does this increase the force of cardiac muscle contraction (positive inotropic effect)?",
      "options": [
        { "text": "Inhibiting the Na⁺/K⁺ pump causes intracellular Na⁺ to rise, which reduces the driving force for the NCX (Na⁺/Ca²⁺ antiporter), allowing intracellular Ca²⁺ to accumulate in cardiac myocytes and increasing cross-bridge force during systole", "isCorrect": true, "explanation": "Correct! When Digoxin or Ouabain inhibits the Na⁺/K⁺-ATPase, intracellular Na⁺ rises. The Na⁺/Ca²⁺ exchanger (NCX), which normally uses the steep inward Na⁺ gradient to pump Ca²⁺ OUT of the cell (3 Na⁺ in / 1 Ca²⁺ out), slows down or reverses. Consequently, more Ca²⁺ remains in the cytoplasm and is pumped into the sarcoplasmic reticulum by SERCA. Upon the next action potential, a larger surge of Ca²⁺ is released, binding more troponin C and significantly increasing myocardial contractility." },
        { "text": "Because Ouabain turns heart muscle into bone", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Digoxin replaces all blood with potassium", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because it destroys all mitochondria in the heart", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In all P-type ATPases, ATP transfers its terminal phosphate to a highly conserved ___ amino acid residue, forming a covalent phosphoenzyme intermediate.",
      "blankAnswer": "aspartate",
      "blankDistractors": ["serine", "tyrosine", "histidine"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Epithelial Polarized Transport Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Polarized Epithelial Glucose Transport Engine</h3><p>Intestinal Enterocyte: Apical SGLT1 Symport | Basolateral $\\text{Na}^+/\\text{K}^+$-ATPase & GLUT2</p><button id=\"transBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Execute Transepithelial Glucose Transport</button><div id=\"transOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('transBtn').onclick=()=>{document.getElementById('transOut').innerText='Transport Cycle: (1) Basolateral Na⁺/K⁺-ATPase pumps 3 Na⁺ out -> Low intracellular Na⁺ (~12 mM). (2) Apical SGLT1 cotransports 2 Na⁺ down gradient + 1 Glucose uphill into cell (accumulates to 50 mM). (3) Basolateral GLUT2 facilitates downhill exit of Glucose into capillary blood! Transcellular absorption completed!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
