# Duofy Reusable Lesson Format: Traffic Flow (Greenshields Model & Highway Capacity)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Transportation_and_Highway_Engineering / Traffic_Engineering_and_Signals`  
**Lesson Format Type:** `greenshields_macroscopic_traffic_flow_model`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through macroscopic traffic flow theory, the fundamental relationship of traffic streams ($q = k \cdot v$), Bruce D. Greenshields' 1935 linear speed-density hypothesis, free-flow speed ($v_f$), jam density ($k_j$), the resulting parabolic flow-density relationship ($q - k$), critical density ($k_{\text{cap}} = k_j / 2$), critical speed ($v_{\text{cap}} = v_f / 2$), and maximum theoretical highway capacity ($q_{\text{max}} = \frac{v_f k_j}{4}$) (TRB *Highway Capacity Manual* Chapter 4; Roger P. Roess *Traffic Engineering* 5th ed. Chapter 5; Bruce D. Greenshields 1935): formulate the **Greenshields Linear Speed-Density Equation**:
$$\mathbf{v = v_f \left( 1 - \frac{k}{k_j} \right)}$$
substitute into the **Fundamental Traffic Equation ($q = k \cdot v$)** to derive the **Parabolic Flow-Density Formulation**:
$$\mathbf{q = v_f \cdot k - \left( \frac{v_f}{k_j} \right) k^2}$$
derive the **Maximum Highway Capacity ($q_{\text{max}}$) & Critical Parameters**:
$$\mathbf{\frac{dq}{dk} = v_f - 2 \left( \frac{v_f}{k_j} \right) k = 0 \implies \mathbf{k_{\text{cap}} = \frac{k_j}{2}} \quad \Big| \quad \mathbf{v_{\text{cap}} = \frac{v_f}{2}}}$$
$$\mathbf{q_{\text{max}} = k_{\text{cap}} \cdot v_{\text{cap}} = \left(\frac{k_j}{2}\right)\left(\frac{v_f}{2}\right) = \mathbf{\frac{v_f \cdot k_j}{4}}}$$
(proving that when highway density exceeds $k_j / 2$, traffic enters the congested forced-flow regime where speeds collapse and throughput degrades).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Greenshields Model ($v = v_f(1-k/k_j)$), Parabolic Flow ($q = v_f k - \frac{v_f}{k_j} k^2$) & $q_{\text{max}} = \frac{v_f k_j}{4}$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Derive Critical Density, Speed, and Maximum Highway Capacity Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Traffic Stream Parameter / Flow State & Technical Operational Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Greenshields' Model, Maximum Highway Capacity $q_{\text{max}}$ Occurs at Exactly Half the Jam Density: $k = k_j / \text{___}$ (2 / Two) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Traffic Engineering Problem: Calculating Capacity q_max and Flow at Given Density for vf = 80 km/h and kj = 120 veh/km Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Greenshields Traffic Stream Model (Greenshields 1935; Roess 2018):
   - **Stream Formulations:**
     $$\mathbf{q = k \cdot v \quad \Big| \quad v = v_f \left(1 - \frac{k}{k_j}\right) \quad \Big| \quad q = v_f k - \frac{v_f}{k_j} k^2 \quad \Big| \quad q_{\text{max}} = \frac{v_f \cdot k_j}{4}}$$
   - **Traffic Flow States Comparison Matrix:**
     $$\begin{array}{|l|c|c|c|l|}
     \hline
     \textbf{Operational State} & \textbf{Density } k & \textbf{Speed } v & \textbf{Flow Rate } q & \textbf{Flow Description} \\
     \hline
     \mathbf{\text{Zero Flow (Empty Road)}} & \mathbf{k = 0} & \mathbf{v = v_f} & \mathbf{q = 0} & \text{Unconstrained free-flow conditions} \\
     \mathbf{\text{Uncongested State}} & 0 < k < k_j/2 & v_f/2 < v < v_f & 0 < q < q_{\text{max}} & \text{Stable flow; drivers choose speeds} \\
     \mathbf{\text{Maximum Capacity}} & \mathbf{k = k_j / 2} & \mathbf{v = v_f / 2} & \mathbf{q_{\text{max}} = \frac{v_f k_j}{4}} & \mathbf{\text{Optimal highway throughput state}} \\
     \mathbf{\text{Congested Forced Flow}} & k_j/2 < k < k_j & 0 < v < v_f/2 & q < q_{\text{max}} & \text{Unstable queueing and shockwaves} \\
     \mathbf{\text{Jam Gridlock}} & \mathbf{k = k_j} & \mathbf{v = 0} & \mathbf{q = 0} & \mathbf{\text{Complete standstill bumper-to-bumper}} \\
     \hline
     \end{array}$$
   - **The Symmetry Invariant:** Under Greenshields' model, the flow-density curve is a **symmetric parabola** centered at $k = k_j / 2$; every flow rate below $q_{\text{max}}$ corresponds to two states: a fast uncongested state and a slow congested state!
2. **Slide 2 (`ordering`):** Provide 5 steps of Greenshields capacity analysis: (1) extract free-flow speed $v_f$ and jam density $k_j$ from regression of field data, (2) formulate the speed-density linear relationship: $v = v_f (1 - k / k_j)$, (3) formulate the parabolic flow equation: $q = k \cdot v = v_f k - (v_f / k_j) k^2$, (4) evaluate critical capacity parameters: $k_{\text{cap}} = k_j / 2$ and $v_{\text{cap}} = v_f / 2$, (5) calculate maximum theoretical highway capacity: $q_{\text{max}} = (v_f \cdot k_j) / 4$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Free-Flow Speed $v_f$, Jam Density $k_j$, Capacity Density $k_j/2$, Flow Rate $q = k \cdot v$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 2 (or Two). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating traffic stream capacity: A multi-lane highway has a calibrated Greenshields model with free-flow speed $v_f = 80.0\text{ km/h}$ and jam density $k_j = 120.0\text{ veh/km/lane}$.
   - Critical density at capacity: $k_{\text{cap}} = \frac{120.0}{2} = \mathbf{60.0\text{ veh/km/lane}}$;
   - Critical speed at capacity: $v_{\text{cap}} = \frac{80.0}{2} = \mathbf{40.0\text{ km/h}}$;
   - Maximum capacity: $q_{\text{max}} = \frac{v_f \cdot k_j}{4} = \frac{80.0 \times 120.0}{4} = \frac{9600}{4} = \mathbf{2400\text{ veh/h/lane}}$;
   - What is the flow rate $q$ when the measured density is $k = 30.0\text{ veh/km/lane}$?
     - Speed at $k = 30$: $v = 80.0(1 - 30.0/120.0) = 80.0(1 - 0.25) = 80.0(0.75) = \mathbf{60.0\text{ km/h}}$;
     - Flow: $q = k \cdot v = 30.0 \times 60.0 = \mathbf{1800\text{ veh/h/lane}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "greenshields_macroscopic_traffic_flow_model",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Greenshields Traffic Flow Model (Bruce Greenshields 1935)**\n• **Fundamental Traffic Stream Continuity Equation:**\n$$\n\\mathbf{q = k \\cdot v \\quad \\left(q = \\text{Flow [veh/h]}, \\ k = \\text{Density [veh/km]}, \\ v = \\text{Speed [km/h]}\\right)}\n$$\n• **Greenshields Linear Speed-Density Model:**\n$$\n\\mathbf{v = v_f \\left( 1 - \\frac{k}{k_j} \\right) \\quad \\left(v_f = \\text{Free-flow speed}, \\ k_j = \\text{Jam density}\\right)}\n$$\n• **Parabolic Flow-Density Formulation:**\n$$\n\\mathbf{q = v_f \\cdot k - \\left( \\frac{v_f}{k_j} \\right) k^2}\n$$\n• **Maximum Theoretical Capacity ($q_{\\text{max}}$) \\& Critical States:**\n$$\n\\mathbf{k_{\\text{cap}} = \\frac{k_j}{2} \\quad \\Big| \\quad v_{\\text{cap}} = \\frac{v_f}{2} \\implies \\mathbf{q_{\\text{max}} = \\frac{v_f \\cdot k_j}{4}}}\n$$\n• **The Congestion Threshold Invariant:** Operating beyond critical density $k_j/2$ drops flow into the **forced-flow regime**, where adding more vehicles paradoxically reduces total throughput!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine the maximum capacity and flow parameters from a Greenshields traffic model.",
      "orderItems": [
        "Identify the macroscopic stream boundary parameters: free-flow speed vf and jam density kj",
        "Formulate the linear speed-density relationship: v = vf * (1 - k/kj)",
        "Substitute into fundamental equation to establish the parabolic flow equation: q = vf*k - (vf/kj)*k^2",
        "Calculate the critical capacity parameters: k_cap = kj / 2 and v_cap = vf / 2",
        "Calculate maximum theoretical highway capacity: q_max = (vf * kj) / 4"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Traffic Stream Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Free-Flow Speed (vf)", "right": "Theoretical average speed when traffic density approaches zero and vehicles travel unconstrained" },
        { "left": "Jam Density (kj)", "right": "Maximum physical packing density of vehicles at a complete bumper-to-bumper standstill (v = 0)" },
        { "left": "Maximum Capacity (q_max)", "right": "q_max = (vf*kj) / 4, peak vehicle throughput achieved at density kj/2 and speed vf/2" },
        { "left": "Forced Flow Regime", "right": "Unstable congested condition occurring when density k > kj/2, causing speed collapse and queueing" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Greenshields' traffic model, maximum highway capacity q_max occurs at exactly half the jam density: k = kj / ___.",
      "blankAnswer": "2",
      "blankDistractors": ["4", "3", "1"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A highway lane has free-flow speed vf = 80.0 km/h and jam density kj = 120.0 veh/km. What is the maximum lane capacity q_max, and what is the flow rate q when density is k = 30.0 veh/km?",
      "options": [
        { "text": "q_max = 2400 veh/h and q = 1800 veh/h (q_max = (80 * 120) / 4 = 2400 veh/h; at k = 30: v = 80*(1 - 30/120) = 80*0.75 = 60 km/h \u2192 q = 30 * 60 = 1800 veh/h)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Greenshields' macroscopic traffic flow model (Roger P. Roess *Traffic Engineering* Chapter 5). 1. **Identify Model Parameters:** - Free-flow speed: $v_f = 80.0\\text{ km/h}$. - Jam density: $k_j = 120.0\\text{ veh/km/lane}$. 2. **Calculate Maximum Highway Capacity ($q_{\\text{max}}$):** - Critical density at capacity: $$k_{\\text{cap}} = \\frac{k_j}{2} = \\frac{120.0\\text{ veh/km}}{2} = \\mathbf{60.0\\text{ veh/km}}$$ - Critical speed at capacity: $$v_{\\text{cap}} = \\frac{v_f}{2} = \\frac{80.0\\text{ km/h}}{2} = \\mathbf{40.0\\text{ km/h}}$$ - Maximum capacity: $$q_{\\text{max}} = k_{\\text{cap}} \\cdot v_{\\text{cap}} = 60.0\\text{ veh/km} \\times 40.0\\text{ km/h} = \\mathbf{2400\\text{ veh/h/lane}}$$ - Direct formula check: $$q_{\\text{max}} = \\frac{v_f \\cdot k_j}{4} = \\frac{80.0 \\times 120.0}{4} = \\frac{9600}{4} = \\mathbf{2400\\text{ veh/h/lane}}$$ 3. **Calculate Speed \\& Flow at Density $k = 30.0\\text{ veh/km}$:** - Speed from Greenshields formula: $$v = v_f \\left( 1 - \\frac{k}{k_j} \\right) = 80.0\\text{ km/h} \\times \\left( 1 - \\frac{30.0}{120.0} \\right) = 80.0 \\times (1 - 0.25) = 80.0 \\times 0.75 = \\mathbf{60.0\\text{ km/h}}$$ - Volumetric flow rate: $$q = k \\cdot v = 30.0\\text{ veh/km} \\times 60.0\\text{ km/h} = \\mathbf{1800\\text{ veh/h/lane}}$$ Flawless Greenshields traffic flow and capacity derivation!" },
        { "text": "q_max = 9600 veh/h and q = 2400 veh/h", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "q_max = 2400 veh/h and q = 2400 veh/h", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "q_max = 1200 veh/h and q = 900 veh/h", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
