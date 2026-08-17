# Duofy Reusable Lesson Format: Reaction Dynamics and Potential Energy Surfaces

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Physical_Chemistry / Chemical_Kinetics_and_Reaction_Dynamics`  
**Lesson Format Type:** `reaction_dynamics_and_potential_energy_surfaces`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid conceptual and mathematical mastery of molecular reaction dynamics and multidimensional potential energy surfaces: explore **Crossed Molecular Beams (Dudley Herschbach & Yuan T. Lee, Nobel Prize 1986)**, map **Potential Energy Surfaces (PES)** with saddle points (transition states) and valleys (minimum energy pathways, MEP), differentiate **Early vs Late Transition States (Hammond Postulate & Polanyi Rules: early barriers $\implies$ translational energy accelerates reaction; late barriers $\implies$ vibrational excitation accelerates reaction)**, formulate the **Harpoon Mechanism (Michael Polanyi, 1932)** for alkali-halogen reactions ($\text{K} + \text{Br}_2 \to \text{K}^+ + \text{Br}_2^- \to \text{KBr} + \text{Br}$) with enormous reactive cross-sections ($R_c = \frac{e^2}{4\pi\varepsilon_0(IP - EA)}$), and interact with live molecular trajectory collision simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Reaction Dynamics & Polanyi Rules Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Potential Energy Surface Topology & Dynamic Feature Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Late Barrier Reaction Polanyi Acceleration Mode Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Long-Range Electron Transfer Collision Reaction Model Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Potential Energy Surface & Harpoon Collision Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "reaction_dynamics_and_potential_energy_surfaces",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What are Polanyi's Rules on Potential Energy Surfaces (PES), and how does the Harpoon Mechanism operate in reaction dynamics?",
      "blankAnswer": "Molecular Reaction Dynamics (Nobel Prize 1986 to Herschbach, Lee, and Polanyi) investigates individual state-to-state molecular collisions. Polanyi's Rules govern how energy promotes reactions over Potential Energy Surface (PES) barriers: (1) Early Barrier (Exothermic Reactions): The saddle point resembles reactants; TRANSLATIONAL kinetic energy is most effective at overcoming the barrier, producing vibrationally excited products. (2) Late Barrier (Endothermic Reactions): The saddle point resembles products; VIBRATIONAL excitation of reactant bonds is vastly more effective than translational energy at driving the reaction! The Harpoon Mechanism (Michael Polanyi) occurs in alkali-halogen reactions (e.g. K + Br2): at a large critical crossing distance Rc ≈ e² / (4πε0(IP_K - EA_Br2)) (~5-8 Å), the low-ionization-energy alkali atom 'shoots' a valence electron to the high-electron-affinity halogen ('harpoon'). The resulting electrostatic Coulomb attraction (K+ + Br2⁻) violently reels the ions together to form KBr + Br with huge reaction cross-sections!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each reaction dynamics concept to its physical definition.",
      "matchPairs": [
        { "left": "Early Barrier (Exothermic PES)", "right": "Saddle point in entry valley; accelerated by reactant translational energy" },
        { "left": "Late Barrier (Endothermic PES)", "right": "Saddle point in exit valley; accelerated by reactant vibrational excitation" },
        { "left": "Harpoon Mechanism (K + Br2)", "right": "Long-range electron transfer at critical distance Rc followed by Coulombic attraction" },
        { "left": "Minimum Energy Path (MEP)", "right": "Steepest descent trajectory in mass-weighted coordinates connecting reactants and products" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "According to Polanyi's rules for a reaction with a LATE energy barrier on its Potential Energy Surface (such as an endothermic H + HF -> H2 + F reaction), which form of reactant energy is most effective at promoting the reaction?",
      "options": [
        { "text": "VIBRATIONAL EXCITATION of the reactant bond (HF vibration); because the barrier is located in the exit channel along the bond-stretching coordinate, stretching the bond directly pushes the system across the late saddle point", "isCorrect": true, "explanation": "Correct! In late-barrier reactions (common for endothermic processes), the saddle point is positioned late in the reaction coordinate (in the exit valley where the breaking bond is heavily stretched). Polanyi's rules show that depositing energy into the vibrational mode of the breaking bond directs momentum straight across the barrier, whereas translational kinetic energy merely bounces off the repulsive potential wall in the entrance valley." },
        { "text": "Translational kinetic energy of collision", "isCorrect": false, "explanation": "Incorrect: Translational energy is effective for early barriers, but ineffective for late barriers." },
        { "text": "Rotational energy only", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Nuclear spin energy", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The reaction model in which an alkali metal transfers a valence electron to a halogen at large distances via Coulomb attraction is known as the ___ mechanism.",
      "blankAnswer": "harpoon",
      "blankDistractors": ["tunneling", "lindemann", "arrhenius"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Reaction Dynamics & Harpoon Mechanism Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Molecular Reaction Dynamics Engine</h3><p>Collision: Potassium atom ($\\text{K}$) $+$ Bromine molecule ($\\text{Br}_2$) | Distance: $r = 6.5\\text{ \\AA}$</p><button id=\"rdBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Launch Harpoon Electron Transfer</button><div id=\"rdOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('rdBtn').onclick=()=>{document.getElementById('rdOut').innerText='Harpoon Dynamics: (1) At R_c = 6.2 Å, covalent curve crosses ionic curve. (2) K transfers 4s electron to Br2 LUMO -> forms ion pair [K+ ... Br2⁻]. (3) Intense Coulomb attraction pulls K+ and Br- together. (4) Product KBr is formed with high rotational/vibrational energy + free Br radical! Reaction cross section sigma_R = 150 Å²!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
