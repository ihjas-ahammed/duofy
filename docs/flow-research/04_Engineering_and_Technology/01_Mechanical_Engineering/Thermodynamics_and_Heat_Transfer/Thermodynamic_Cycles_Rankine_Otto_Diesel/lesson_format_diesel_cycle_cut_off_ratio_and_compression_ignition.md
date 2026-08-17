# Duofy Reusable Lesson Format: Diesel Cycle (Compression-Ignition and Cut-Off Ratio)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Thermodynamics_and_Heat_Transfer / Thermodynamic_Cycles_Rankine_Otto_Diesel`  
**Lesson Format Type:** `diesel_cycle_cut_off_ratio_and_compression_ignition`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through compression-ignition thermodynamics, isobaric fuel injection, and cut-off ratio physics in heavy diesel engines (Rudolf Diesel 1893; Yunus A. Çengel, Michael A. Boles, Mehmet Kanoğlu *Thermodynamics: An Engineering Approach* Chapter 9): master the **Four Thermodynamic Processes of the Ideal Diesel Cycle**: (1) Process 1-2: Isentropic Compression ($r = V_1/V_2 \approx 14 - 22$), (2) Process 2-3: Constant-Pressure (Isobaric) Heat Addition ($\mathbf{P = \text{Constant}, \ q_{\text{in}} = c_p(T_3 - T_2)}$), (3) Process 3-4: Isentropic Power Expansion ($s_3 = s_4$), and (4) Process 4-1: Constant-Volume Heat Rejection ($v_4 = v_1, q_{\text{out}} = c_v(T_4 - T_1)$); define the **Cut-Off Ratio ($\mathbf{r_c = \frac{V_3}{V_2} = \frac{T_3}{T_2}}$)** (the ratio of cylinder volumes after and before combustion), derive the **Air-Standard Diesel Thermal Efficiency Formula**:
$$\mathbf{\eta_{\text{th,Diesel}} = 1 - \frac{1}{r^{k - 1}} \left[ \frac{r_c^k - 1}{k(r_c - 1)} \right] \quad \left(r_c > 1, \ k = 1.4\right)}$$
and analyze why, for the same compression ratio $r$, $\eta_{\text{Otto}} > \eta_{\text{Diesel}}$, but real-world Diesel engines achieve **substantially higher actual efficiencies ($40-50\%$ vs $25-35\%$)** because they operate at much higher compression ratios ($r = 16-22$) without risk of autoignition knocking (since only pure air is compressed during stroke 1-2).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Ideal Diesel Cycle ($P-v$ & $T-s$ Coordinates) & Air-Standard Efficiency Formula Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Chronological Progression Through the 4 Diesel Cycle Stages Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Diesel Cycle Parameter / Physical Combustion Mechanism & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the Ideal Diesel Cycle, Heat Addition Occurs at Constant ___ (Pressure / Isobaric) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mechanical Thermodynamics Analysis: Why Real Diesel Engines Outperform Petrol Engines in Thermal Efficiency Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Diesel Cycle (Çengel & Boles 2019; Rudolf Diesel 1893):
   - **Diesel Cycle Efficiency Formulation:**
     $$\mathbf{\eta_{\text{th,Diesel}} = 1 - \frac{1}{r^{k - 1}} \left[ \frac{r_c^k - 1}{k(r_c - 1)} \right] \quad \text{where } r = \frac{V_1}{V_2}, \ r_c = \frac{V_3}{V_2} = \frac{T_3}{T_2}}$$
   - **Process Breakdown Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{State Path} & \textbf{Thermodynamic Process} & \textbf{Combustion Physics} & \textbf{Energy Formulation} \\
     \hline
     \mathbf{1 \to 2} & \mathbf{\text{Isentropic Compression}} & \text{Pure air is compressed to high } T_2 & T_2 = T_1 \cdot r^{k-1} \\
     \mathbf{2 \to 3} & \mathbf{\text{Isobaric Heat Addition}} & \mathbf{\text{Fuel injected into hot air (Autoignition)}} & \mathbf{q_{\text{in}} = c_p (T_3 - T_2) \ (P = C)} \\
     \mathbf{3 \to 4} & \mathbf{\text{Isentropic Expansion}} & \text{Power stroke: Expansion ratio } r/r_c & w_{\text{out}} = c_v(T_3 - T_4) \\
     \mathbf{4 \to 1} & \mathbf{\text{Isochoric Heat Rejection}} & \text{Exhaust blowdown at constant volume} & \mathbf{q_{\text{out}} = c_v (T_4 - T_1) \ (v = C)} \\
     \hline
     \end{array}$$
   - **The Bracket Factor Invariant:** Because $\frac{r_c^k - 1}{k(r_c - 1)} > 1$ for all $r_c > 1$, **$\eta_{\text{Diesel}} < \eta_{\text{Otto}}$ at the SAME compression ratio $r$**; however, Diesel engines operate at $r = 16-22$ (vs Otto $r=8-10$), making real Diesel efficiency vastly superior!
2. **Slide 2 (`ordering`):** Provide 5 steps of the Diesel cycle: (1) pure ambient air is drawn in and compressed isentropically as piston rises to TDC, heating air above fuel autoignition temperature, (2) liquid diesel fuel is injected at TDC and autoignites, adding heat $q_{\text{in}}$ at constant pressure ($P=\text{constant}$) as the piston starts moving down, (3) fuel injection cuts off at volume $V_3$, and burning gases expand isentropically down to BDC during the power stroke, (4) exhaust valve opens at BDC, rejecting waste heat $q_{\text{out}}$ at constant volume, (5) piston sweeps upward, expelling exhaust gases and resetting the cylinder for the next intake!
3. **Slide 3 (`matching`):** Pair 4 concepts (Cut-Off Ratio $r_c$, Isobaric Heat Addition, Compression-Ignition CI, Otto vs Diesel Comparison) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Pressure. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why real Diesel engines outperform Otto engines: Although the theoretical air-standard formula proves that the Otto cycle has higher efficiency than the Diesel cycle when evaluated at the *same* compression ratio ($\eta_{\text{Otto}} > \eta_{\text{Diesel}}$ at identical $r$), why do real-world heavy-duty Diesel engines achieve significantly higher fuel economy and thermal efficiency ($45-50\%$) than petrol Otto engines ($25-35\%$)? (In an Otto petrol engine, a pre-mixed air-fuel charge is compressed, so **the compression ratio is strictly capped at $r \approx 8-10$ to prevent explosive premature autoignition (knocking)**; in a Diesel engine, **ONLY pure air is compressed during the compression stroke (so knocking cannot occur), allowing Diesel engines to operate at much higher compression ratios of $r = 16-22$**; this vastly higher compression ratio yields an overall thermal efficiency that substantially exceeds that of petrol engines).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "diesel_cycle_cut_off_ratio_and_compression_ignition",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Air-Standard Diesel Cycle \\& Cut-Off Ratio (Rudolf Diesel 1893)**\n• **Diesel Thermal Efficiency Formulation:**\n$$\n\\mathbf{\\eta_{\\text{th,Diesel}} = 1 - \\frac{1}{r^{k - 1}} \\left[ \\frac{r_c^k - 1}{k(r_c - 1)} \\right] \\quad \\left(r = \\frac{V_1}{V_2}, \\ r_c = \\frac{V_3}{V_2} = \\frac{T_3}{T_2}\\right)}\n$$\n• **Process Breakdown Matrix:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{State Path} & \\textbf{Thermodynamic Process} & \\textbf{Engine Action} & \\textbf{Energy Balance} \\\\\n\\hline\n\\mathbf{1 \\to 2} & \\mathbf{\\text{Isentropic Compression}} & \\text{Compresses PURE AIR to high } T_2 & T_2 = T_1 \\cdot r^{k - 1} \\\\\n\\mathbf{2 \\to 3} & \\mathbf{\\text{Isobaric Heat Addition}} & \\mathbf{\\text{Diesel fuel injected \\& autoignites}} & \\mathbf{q_{\\text{in}} = c_p (T_3 - T_2) \\ (P = C)} \\\\\n\\mathbf{3 \\to 4} & \\mathbf{\\text{Isentropic Expansion}} & \\text{Power stroke (TDC to BDC)} & T_4 = T_3 (r_c / r)^{k - 1} \\\\\n\\mathbf{4 \\to 1} & \\mathbf{\\text{Isochoric Heat Rejection}} & \\text{Exhaust blowdown at BDC} & \\mathbf{q_{\\text{out}} = c_v (T_4 - T_1) \\ (v = C)} \\\\\n\\hline\n\\end{array}\n$$\n• **The Efficiency Invariant:** For the same $r$, $\\mathbf{\\eta_{\\text{Otto}} > \\eta_{\\text{Diesel}}}$; but Diesel engines operate at $\\mathbf{r \\approx 16 - 22}$ (vs Otto $r \\approx 8 - 10$), achieving **higher real-world thermal efficiency**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential thermodynamic processes comprising the four stages of the ideal air-standard Diesel cycle.",
      "orderItems": [
        "Isentropic Compression (1->2): Pure ambient air is compressed to high pressure and temperature (exceeding fuel ignition point)",
        "Isobaric Heat Addition (2->3): Liquid diesel fuel is sprayed into the superheated air and autoignites at constant pressure (P = C)",
        "Fuel Cut-Off: Fuel injection terminates at state 3 (establishing the cut-off volume ratio r_c = V3 / V2)",
        "Isentropic Expansion (3->4): Hot combustion gases expand doing mechanical shaft work during the power stroke",
        "Isochoric Heat Rejection (4->1): Exhaust gases blow down at constant cylinder volume (v = C), resetting to state 1"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Diesel Cycle Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Cut-Off Ratio (r_c)", "right": "r_c = V3 / V2 = T3 / T2, measuring the fraction of the expansion stroke where fuel is actively injected" },
        { "left": "Isobaric Heat Addition", "right": "q_in = c_p * (T3 - T2), representing constant-pressure heat release during diesel combustion" },
        { "left": "Compression-Ignition (CI)", "right": "Ignition method relying solely on the high heat of compressed air rather than an electric spark" },
        { "left": "Dual / Sabathé Cycle", "right": "Realistic compromise cycle modeling heat addition as partly constant volume and partly constant pressure" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the ideal air-standard Diesel cycle, heat addition from fuel injection occurs at constant ___.",
      "blankAnswer": "pressure",
      "blankDistractors": ["volume", "temperature", "entropy"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Although theoretical formulas show that the Otto cycle has a higher efficiency than the Diesel cycle at the SAME compression ratio (eta_Otto > eta_Diesel at equal r), why do real-world heavy-duty Diesel engines achieve significantly higher thermal efficiencies (45-50%) than petrol Otto engines (25-35%)?",
      "options": [
        { "text": "In a petrol Otto engine, a pre-mixed air-fuel mixture is compressed during stroke 1-2, which strictly limits the compression ratio to r = 8-10 to prevent catastrophic premature autoignition (engine knocking); in a Diesel engine, ONLY pure air is compressed during stroke 1-2, completely eliminating any risk of premature detonation and allowing Diesel engines to operate at drastically higher compression ratios of r = 16-22; this substantially higher compression ratio elevates the baseline (1 - 1/r^(k-1)) factor, yielding a net real-world thermal efficiency that significantly outperforms petrol engines", "isCorrect": true, "explanation": "Correct! This is Yunus Çengel and Rudolf Diesel's foundational explanation for why Diesel engines dominate heavy transport and industrial power (*Thermodynamics: An Engineering Approach* Chapter 9). 1. **The Knock Limit in Petrol Engines:** - A petrol engine compresses air + gasoline together. - If $r > 11$: The heat of compression causes the fuel-air mixture to spontaneously explode before the spark plug fires (**Knocking/Detonation**), destroying the piston! - Therefore, petrol engines are permanently constrained to $r \\approx 8 - 10$. 2. **The Diesel Breakthrough:** - A Diesel engine compresses **100% PURE AIR** during stroke 1-2. - Because there is zero fuel in the cylinder, **knocking is physically impossible during compression**! - Engineers can safely push compression ratios up to $\\mathbf{r = 16 - 22}$! - At $r = 20$, air temperature reaches $\\sim 600-700^\\circ\\text{C}$. - When diesel fuel is injected at TDC, it spontaneously ignites on contact (**Compression-Ignition**). 3. **The Efficiency Verdict:** - At $r=8$: $\\eta_{\\text{Otto}} = 56.5\\% > \\eta_{\\text{Diesel}} = 51.5\\%$. - BUT Diesel runs at $r=20$: $\\eta_{\\text{Diesel}} \\approx \\mathbf{65\\% \\text{ theoretical (45-50\\% actual)}}$! - **Result:** Real Diesel engines are $30-40\\%$ more fuel efficient than petrol engines!" },
        { "text": "Because diesel fuel contains more oxygen atoms than gasoline", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because diesel engines do not produce exhaust gases", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because petrol engines violate the First Law of Thermodynamics", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
