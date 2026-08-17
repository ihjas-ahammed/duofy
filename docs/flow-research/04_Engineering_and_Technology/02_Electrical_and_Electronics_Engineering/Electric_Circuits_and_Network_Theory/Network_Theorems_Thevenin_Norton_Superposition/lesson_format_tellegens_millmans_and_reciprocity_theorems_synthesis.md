# Duofy Reusable Lesson Format: Advanced Network Theorems (Tellegen, Millman, & Reciprocity)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Electric_Circuits_and_Network_Theory / Network_Theorems_Thevenin_Norton_Superposition`  
**Lesson Format Type:** `tellegens_millmans_and_reciprocity_theorems_synthesis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify foundational advanced network theorems, universal power conservation, parallel branch reductions, and two-port reciprocity invariants in electrical circuit theory (Bernard D.H. Tellegen 1952; Jacob Millman 1940; Charles K. Alexander & Matthew N.O. Sadiku *Fundamentals of Electric Circuits* Chapter 4; James W. Nilsson Chapter 4): master **Tellegen's Universal Power Conservation Theorem**:
$$\mathbf{\sum_{k=1}^B v_k \cdot i_k = 0 \quad (\text{Sum of Delivered Power } = \text{Sum of Absorbed Power})}$$
(proving that Tellegen's theorem holds for **ANY lumped network graph topology**, whether linear or nonlinear, active or passive, time-invariant or time-varying, because it is an orthogonality consequence of KVL and KCL); master **Millman's Parallel Generator Theorem**:
$$\mathbf{V_m = \frac{\sum_{k=1}^n V_k G_k}{\sum_{k=1}^n G_k} = \frac{\sum \frac{V_k}{R_k}}{\sum \frac{1}{R_k}} \quad \Big| \quad R_m = \frac{1}{\sum_{k=1}^n G_k}}$$
(which collapses $n$ parallel voltage branches with series resistors into a single Thévenin source in one calculation); master the **Reciprocity Theorem** in linear bilateral two-port networks ($\frac{I_2}{V_1} = \frac{I_1}{V_2}$), and interact with live Superposition simulator, Thévenin/Norton converter, MPTT power matching curve, and Millman parallel network calculator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Tellegen's Law ($\sum v_k i_k = 0$) & Millman's Theorem ($V_m = \frac{\sum V_k G_k}{\sum G_k}$) Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Network Theorem Entity / Circuit Conservation Property & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Tellegen's Theorem Holds for Non-Linear and Time-Varying Circuits Unlike Ohm's Law Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Universal Theorem Stating That the Sum of Instantaneous Powers Delivered by All Elements in Any Network Equals Zero Is ___ Theorem (Tellegen's / Tellegen) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Network Theorems Studio: Superposition, Thévenin, MPTT & Millman's Synthesis Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "tellegens_millmans_and_reciprocity_theorems_synthesis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Tellegen's Theorem, Millman's Theorem, and the Reciprocity Theorem?",
      "blankAnswer": "Advanced Theorems (Alexander & Sadiku): (1) TELLEGEN'S THEOREM: For ANY lumped electrical network of B branches, \u2211(vk * ik) = 0. Total power generated equals total power absorbed! Valid for linear, non-linear, active, passive, time-invariant, and time-varying circuits because it depends solely on KCL and KVL graph topology. (2) MILLMAN'S THEOREM: Parallel voltage branches collapse into single source: V_m = (\u2211 Vk*Gk) / (\u2211 Gk) with series R_m = 1 / (\u2211 Gk). (3) RECIPROCITY THEOREM: In any linear bilateral network, exciting port 1 with V1 produces current I2 at port 2; swapping source to port 2 produces identical current I1 = I2 at port 1!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Advanced Network Theorem to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Tellegen's Theorem", "right": "\u2211 vk*ik = 0, universal instantaneous power conservation holding for all network topologies" },
        { "left": "Millman's Theorem", "right": "Vm = \u2211(Vk/Rk) / \u2211(1/Rk), reducing multiple parallel voltage branches into a single Thévenin pair" },
        { "left": "Reciprocity Theorem", "right": "Transfer immittance ratio remaining invariant when excitation source and response detector are swapped" },
        { "left": "Maximum Power Conjugate Matching", "right": "ZL = Zth*, canceling internal source reactance to maximize active power delivery" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why is Tellegen's Theorem (\u2211 vk*ik = 0) universally valid across ANY circuit containing non-linear diodes, transistors, active energy sources, and time-varying elements, whereas theorems like Superposition and Thévenin are strictly limited to linear bilateral networks?",
      "options": [
        { "text": "Tellegen's theorem is a direct geometric orthogonality consequence of Kirchhoff's Current Law (which enforces branch currents to lie in the cutset subspace) and Kirchhoff's Voltage Law (which enforces branch voltages to lie in the orthogonal loop subspace); because it depends exclusively on graph topology and energy/charge conservation rather than the constitutive V-I relationships of the individual components, it holds with mathematical perfection regardless of whether elements are linear, non-linear, passive, active, or time-varying", "isCorrect": true, "explanation": "Correct! This is Charles Alexander and Matthew Sadiku's fundamental graph-theoretic explanation for Tellegen's theorem (*Fundamentals of Electric Circuits* Chapter 4). 1. **Mathematical Foundation:** - Let a network graph have $B$ branches and $N$ nodes. - The branch voltage vector $\\mathbf{v}$ lies entirely in the subspace spanned by the incidence matrix $\\mathbf{A}^T$ (by KVL: $\\mathbf{v} = \\mathbf{A}^T \\mathbf{e}$). - The branch current vector $\\mathbf{i}$ lies entirely in the nullspace of the incidence matrix (by KCL: $\\mathbf{A} \\mathbf{i} = \\mathbf{0}$). 2. **Orthogonality Proof:** - Total power: $$P_{\\text{total}} = \\mathbf{v}^T \\mathbf{i} = (\\mathbf{A}^T \\mathbf{e})^T \\mathbf{i} = \\mathbf{e}^T (\\mathbf{A} \\mathbf{i}) = \\mathbf{e}^T (\\mathbf{0}) = \\mathbf{0}$$ 3. **Constitutive Independence:** Notice that **nowhere in the derivation is Ohm's Law ($v = i R$) or linearity used**! - Diodes, transistors, switched capacitors, and nonlinear memristors all obey KCL and KVL, making Tellegen's theorem the **most powerful universal conservation theorem in electrical network theory**!" },
        { "text": "Because Tellegen discovered a new form of electricity that ignores Ohm's law", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because non-linear circuits do not dissipate any electrical energy", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because all circuits become linear at high frequencies", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The universal network theorem stating that the sum of instantaneous power across all branches is identically zero is ___ theorem.",
      "blankAnswer": "Tellegen's",
      "blankDistractors": ["Thévenin's", "Norton's", "Millman's"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Network Theorems Studio: Superposition, Thévenin & MPTT",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Network Theorems & Power Matching Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Superposition, Thévenin/Norton, MPTT & Millman</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnSup\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Superposition (80W != 50W)</button><button id=\"btnThev\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Thévenin Equivalent (Rth = 6\u03a9)</button><button id=\"btnMptt\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. MPTT & Millman Synthesis</button></div><div id=\"thmLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate Superposition theorem...</div><script>document.getElementById('btnSup').onclick=()=>{document.getElementById('thmLog').innerHTML='<b>1. SUPERPOSITION THEOREM:</b><br>• i1 = 3A (from Vs) + i2 = 1A (from Is) &rarr; <b style=\"color:#10b981;\">i_total = 4.0 A!</b><br>• Actual Power: P = (4A)^2 * 5\\u03a9 = 80 W (P != P1+P2 = 50W)<br>• Superposition holds for V & I, NOT nonlinear power!';}; document.getElementById('btnThev').onclick=()=>{document.getElementById('thmLog').innerHTML='<b>2. THÉVENIN \\& NORTON EQUIVALENTS:</b><br>• Voc = 24.0 V, Isc = 4.0 A &rarr; <b style=\"color:#38bdf8;\">Rth = Voc/Isc = 6.0 \\u03a9!</b><br>• Norton Current: IN = 4.0 A in parallel with 6.0 \\u03a9<br>• Valid for any connected load RL!';}; document.getElementById('btnMptt').onclick=()=>{document.getElementById('thmLog').innerHTML='<b>3. MAXIMUM POWER TRANSFER \\& MILLMAN:</b><br>• MPTT Match: RL = Rth = 8 \\u03a9 &rarr; P_max = Vth^2/(4Rth) = 12.5 W (\\u03b7 = 50%)<br>• Tellegen\\\'s Theorem: \\u2211(vk*ik) = 0 (Universal Power Conservation!)<br>• Millman\\\'s Law: Vm = \\u2211(Vk/Rk) / \\u2211(1/Rk)<br>🏆 <b style=\"color:#10b981;\">Network Theorems 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
