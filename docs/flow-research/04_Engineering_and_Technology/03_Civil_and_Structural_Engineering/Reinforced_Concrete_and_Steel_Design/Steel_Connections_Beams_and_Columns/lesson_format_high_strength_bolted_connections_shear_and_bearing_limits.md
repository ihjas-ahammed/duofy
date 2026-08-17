# Duofy Reusable Lesson Format: Bolted Joints (Shear, Bearing & Tearout Limit States)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Reinforced_Concrete_and_Steel_Design / Steel_Connections_Beams_and_Columns`  
**Lesson Format Type:** `high_strength_bolted_connections_shear_and_bearing_limits`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mechanics of structural steel high-strength bolted connections (ASTM F3125 Grade A325 / Group A and A490 / Group B bolts) per AISC 360-16 Chapter J, analyzing the four competing limit states: (1) **Bolt Shear** (single vs double shear, threads included $N$ vs excluded $X$ from shear planes), (2) **Bolt Bearing on Connecting Plates**, (3) **Plate Hole Tearout** based on clear distance ($l_c$), and (4) **Block Shear Rupture** (William T. Segui *Steel Design* 6th ed. Chapter 7; AISC 360-16 Section J3): formulate the **Nominal Bolt Shear Strength ($R_n$)**:
$$\mathbf{\phi R_n = \phi \cdot F_{nv} \cdot A_b \quad (\phi = 0.75, \ A_b = \frac{\pi d^2}{4})}$$
$$\mathbf{F_{nv} = 54\text{ ksi} \approx 372\text{ MPa} \ (\text{A325 Threads Included}) \quad \Big| \quad F_{nv} = 68\text{ ksi} \approx 469\text{ MPa} \ (\text{A325 Threads Excluded})}$$
derive the **Connecting Plate Bearing & Tearout Capacity ($R_n$)**:
$$\mathbf{\phi R_n = \phi \cdot \min\left( 1.2 \cdot l_c \cdot t \cdot F_u, \ 2.4 \cdot d \cdot t \cdot F_u \right) \quad (\phi = 0.75)}$$
where:
1. **$l_c$:** Clear distance in the direction of force between the edge of the hole and the edge of the adjacent hole or plate edge ($l_c = L_e - 0.5 d_h$ for edge bolts, $l_c = s - d_h$ for interior bolts);
2. **$d, d_h$:** Nominal bolt shank diameter and hole diameter ($d_h = d + \frac{1}{16}\text{ in} \ / \ 2\text{ mm}$ standard);
3. **$t, F_u$:** Thickness and specified minimum tensile strength of the critical connected steel plate;
(proving how joint ductility is ensured by designing the bolts and connection plates to resist service shear without excessive hole ovalization).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Bolt Shear ($F_{nv} A_b$), Hole Tearout ($1.2 l_c t F_u$), Plate Bearing ($2.4 d t F_u$) & $\phi = 0.75$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Check All Limit States and Size a Bolted Lap Joint Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Connection Limit State / Parameter & Technical Structural Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In AISC 360-16 Bolted Connection Design, the Strength Reduction Factor $\phi$ for Bolt Shear and Bearing Is Exactly ___ (0.75 / Three-Fourths) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Industrial Structural Problem: Calculating the Governing Design Capacity of an A325 Bolted Splice Plate Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Bolted Connection Mechanics (Segui 2018; AISC 360-16):
   - **Limit State Formulations:**
     $$\mathbf{\phi R_n = \phi F_{nv} A_b \quad \Big| \quad \phi R_n = \phi \min(1.2 l_c t F_u, \ 2.4 d t F_u) \quad \Big| \quad \phi = 0.75}$$
   - **Limit State Comparison Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Limit State} & \textbf{Nominal Formula } R_n & \textbf{Governing Variable} & \textbf{Failure Description} \\
     \hline
     \mathbf{\text{Bolt Shear}} & \mathbf{F_{nv} A_b \ (\text{or } 2 F_{nv} A_b \text{ double})} & \text{Bolt grade \& thread location} & \text{Direct shearing through bolt shank} \\
     \mathbf{\text{Hole Tearout}} & \mathbf{1.2 l_c t F_u} & \mathbf{\text{Clear distance } l_c} & \text{Shear block blowout behind bolt hole} \\
     \mathbf{\text{Plate Bearing}} & \mathbf{2.4 d t F_u} & \text{Diameter } d \text{ and thickness } t & \text{Excessive crushing/ovalization of hole} \\
     \hline
     \end{array}$$
   - **The Governing Capacity Invariant:** The total design strength of a bolted connection is **the sum of the minimum individual capacities** (shear vs tearout vs bearing) across all bolts in the group!
2. **Slide 2 (`ordering`):** Provide 5 steps of bolted joint design: (1) determine nominal bolt diameter $d$ and compute standard hole diameter $d_h = d + 2\text{ mm}$ ($1/16\text{ in}$), (2) calculate design bolt shear capacity $\phi R_n = \phi F_{nv} A_b$, (3) calculate clear distances $l_c$ for edge and interior bolts, (4) calculate tearout $\phi 1.2 l_c t F_u$ and bearing $\phi 2.4 d t F_u$ on the thinnest connected plate, (5) identify the governing per-bolt capacity and multiply by number of bolts $n$ to verify $n \phi R_{\text{bolt}} \ge P_u$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Bolt Shear Strength, Hole Tearout Strength, Plate Bearing Limit, Clear Distance $l_c$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of 0.75 (or Three-Fourths). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on bolted lap joint capacity: A tension splice connects two $10\text{ mm}$ thick plates ($F_u = 400\text{ MPa}$) using a single $20\text{ mm}$ diameter A325 bolt ($d = 20\text{ mm}, A_b = 314.2\text{ mm}^2$) in single shear with threads included ($F_{nv} = 372\text{ MPa}$). Clear distance to the plate edge is $l_c = 35.0\text{ mm}$ ($\phi = 0.75$).
   - Bolt shear: $\phi R_n = 0.75 \times (372\text{ MPa}) \times (314.2\text{ mm}^2) = 0.75 \times 116,882\text{ N} = \mathbf{87.66\text{ kN}}$;
   - Hole tearout: $\phi R_n = 0.75 \times 1.2 \times (35.0\text{ mm}) \times (10\text{ mm}) \times (400\text{ MPa}) = 0.75 \times 168,000\text{ N} = \mathbf{126.00\text{ kN}}$;
   - Plate bearing: $\phi R_n = 0.75 \times 2.4 \times (20.0\text{ mm}) \times (10\text{ mm}) \times (400\text{ MPa}) = 0.75 \times 192,000\text{ N} = \mathbf{144.00\text{ kN}}$;
   What is the governing design capacity of this connection? (Governing limit state is **Bolt Shear** with $\mathbf{\phi R_n = 87.66\text{ kN} \approx 87.7\text{ kN}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "high_strength_bolted_connections_shear_and_bearing_limits",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Bolted Connection Limit States (AISC 360-16 Section J3)**\n• **Bolt Shear Strength Formulation:**\n$$\n\\mathbf{\\phi R_n = \\phi \\cdot F_{nv} \\cdot A_b \\quad (\\phi = 0.75, \\ A_b = \\pi d^2 / 4)}\n$$\n  - $F_{nv} = 372\\text{ MPa} \\ (54\\text{ ksi})$ for A325 with threads in shear plane;\n  - $F_{nv} = 469\\text{ MPa} \\ (68\\text{ ksi})$ for A325 with threads excluded;\n• **Plate Hole Tearout \\& Bearing Formulations:**\n$$\n\\mathbf{\\phi R_n = \\phi \\cdot \\min\\left( 1.2 \\cdot l_c \\cdot t \\cdot F_u, \\ 2.4 \\cdot d \\cdot t \\cdot F_u \\right) \\quad (\\phi = 0.75)}\n$$\n  - **$l_c$:** Clear distance between edge of hole and edge of plate or adjacent hole;\n  - **$t, F_u$:** Thickness and ultimate tensile strength of the connected steel plate;\n• **The Governing Strength Invariant:** The connection design capacity equals the **minimum strength among Bolt Shear, Tearout, and Bearing** evaluated for every fastener in the pattern!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to evaluate all limit states and determine the design capacity of a bolted structural steel connection.",
      "orderItems": [
        "Identify bolt diameter (d), grade (A325/A490), shear planes (single/double), and thread exclusion condition",
        "Calculate the design bolt shear strength: \u03c6Rn = \u03c6 * Fnv * Ab (\u03c6 = 0.75)",
        "Compute the physical clear edge distance (lc) between the hole perimeter and plate boundary in the line of force",
        "Calculate the plate hole tearout capacity (\u03c6 * 1.2*lc*t*Fu) and plate bearing capacity (\u03c6 * 2.4*d*t*Fu)",
        "Select the minimum governing capacity per bolt and multiply by total number of bolts in the connection"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Bolted Connection Limit State to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Bolt Shear Capacity", "right": "\u03c6 * Fnv * Ab, direct mechanical shearing across the transverse cylindrical shank of the bolt" },
        { "left": "Plate Hole Tearout", "right": "\u03c6 * 1.2 * lc * t * Fu, shear blowout of the thin steel strip between the bolt hole and plate edge" },
        { "left": "Plate Bearing Limit", "right": "\u03c6 * 2.4 * d * t * Fu, local compressive yielding preventing excessive ovalization of the bolt hole" },
        { "left": "Clear Distance (lc)", "right": "lc = Le - 0.5*dh, actual physical distance of solid metal between hole boundary and edge" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In AISC 360-16 bolted connection design, the strength reduction factor \u03c6 for bolt shear and bearing limit states is exactly ___.",
      "blankAnswer": "0.75",
      "blankDistractors": ["0.90", "0.65", "0.85"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A lap joint connects two 10 mm plates (Fu = 400 MPa) using one 20 mm A325 bolt (Ab = 314.2 mm^2, Fnv = 372 MPa) in single shear (\u03c6 = 0.75). Clear edge distance is lc = 35.0 mm. Bolt shear capacity is 87.7 kN, hole tearout is 126.0 kN, and bearing limit is 144.0 kN. What is the governing design capacity of this connection?",
      "options": [
        { "text": "\u03c6Rn = 87.7 kN governed by Bolt Shear (\u03c6Rn_shear = 0.75 * 372 * 314.2 = 87.66 kN; \u03c6Rn_tearout = 0.75 * 1.2 * 35 * 10 * 400 = 126.0 kN; \u03c6Rn_bearing = 0.75 * 2.4 * 20 * 10 * 400 = 144.0 kN; minimum = 87.66 kN)", "isCorrect": true, "explanation": "Correct! Let's solve systematically by evaluating all three competing AISC 360-16 bolted connection limit states (William T. Segui *Steel Design* Chapter 7). 1. **Check Limit State 1: Bolt Shear ($\phi R_{nv}$):** - Bolt nominal cross-sectional area: $$A_b = \\frac{\\pi d^2}{4} = \\frac{\\pi \\times (20\\text{ mm})^2}{4} = 314.159\\text{ mm}^2$$ - Nominal shear strength ($F_{nv} = 372\\text{ MPa}$): $$R_{n,\\text{shear}} = F_{nv} A_b = 372\\text{ MPa} \\times 314.159\\text{ mm}^2 = 116,867\\text{ N} = 116.87\\text{ kN}$$ - Design bolt shear capacity: $$\\phi R_{n,\\text{shear}} = 0.75 \\times 116.867\\text{ kN} = \\mathbf{87.65\\text{ kN} \\approx 87.7\\text{ kN}}$$ 2. **Check Limit State 2: Plate Hole Tearout ($\phi R_{n,\\text{tearout}}$):** $$R_{n,\\text{tearout}} = 1.2 \\cdot l_c \\cdot t \\cdot F_u = 1.2 \\times (35.0\\text{ mm}) \\times (10.0\\text{ mm}) \\times (400\\text{ MPa}) = 168,000\\text{ N} = 168.0\\text{ kN}$$ - Design tearout capacity: $$\\phi R_{n,\\text{tearout}} = 0.75 \\times 168.0\\text{ kN} = \\mathbf{126.00\\text{ kN}}$$ 3. **Check Limit State 3: Plate Bearing ($\phi R_{n,\\text{bearing}}$):** $$R_{n,\\text{bearing}} = 2.4 \\cdot d \\cdot t \\cdot F_u = 2.4 \\times (20.0\\text{ mm}) \\times (10.0\\text{ mm}) \\times (400\\text{ MPa}) = 192,000\\text{ N} = 192.0\\text{ kN}$$ - Design bearing capacity: $$\\phi R_{n,\\text{bearing}} = 0.75 \\times 192.0\\text{ kN} = \\mathbf{144.00\\text{ kN}}$$ 4. **Identify the Governing Design Strength:** $$\\phi R_n = \\min(87.65\\text{ kN}, \\ 126.00\\text{ kN}, \\ 144.00\\text{ kN}) = \\mathbf{87.65\\text{ kN} \\approx 87.7\\text{ kN}}$$ - **Governing Limit State:** **Bolt Shear**! Flawless bolted connection limit state evaluation!" },
        { "text": "\u03c6Rn = 126.0 kN governed by Plate Tearout", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c6Rn = 144.0 kN governed by Plate Bearing", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "\u03c6Rn = 116.9 kN (Forgot \u03c6 factor on bolt shear)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
