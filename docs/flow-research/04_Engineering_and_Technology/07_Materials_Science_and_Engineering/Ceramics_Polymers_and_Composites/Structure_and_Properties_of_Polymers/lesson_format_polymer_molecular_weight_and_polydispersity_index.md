# Duofy Reusable Lesson Format: Polymer Chains (Molecular Weights & Polydispersity PDI)

**Target Topic:** `04_Engineering_and_Technology / 07_Materials_Science_and_Engineering / Ceramics_Polymers_and_Composites / Structure_and_Properties_of_Polymers`  
**Lesson Format Type:** `polymer_molecular_weight_and_polydispersity_index`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the macromolecular chain statistics of synthetic and natural polymers, the definitions of number-fraction ($x_i = N_i / \sum N_i$) and weight-fraction ($w_i = N_i M_i / \sum N_i M_i$), analytical derivation of the **Number-Average Molecular Weight ($\bar{M}_n$)**, the **Weight-Average Molecular Weight ($\bar{M}_w$)**, the **Polydispersity Index ($PDI = \bar{M}_w / \bar{M}_n \ge 1.00$)**, the **Number-Average Degree of Polymerization ($DP_n = \bar{M}_n / m_0$)**, and the physical impact of molecular weight distribution breadth on polymer melt processability and tensile strength (William D. Callister Jr., David G. Rethwisch *Materials Science and Engineering: An Introduction* 10th ed. Chapter 14; Robert O. Ebewele *Polymer Science and Technology* Chapter 2): formulate the **Polymer Molecular Weight Master Formulations**:
$$\mathbf{\bar{M}_n = \sum x_i M_i = \frac{\sum N_i M_i}{\sum N_i} \quad \left[\frac{\text{g}}{\text{mol}}\right] \quad \Big| \quad \mathbf{\bar{M}_w = \sum w_i M_i = \frac{\sum N_i M_i^2}{\sum N_i M_i} \quad \left[\frac{\text{g}}{\text{mol}}\right]}}$$
where:
1. **$N_i$:** Number of polymer molecules within molecular weight slice $M_i$;
2. **$x_i = N_i / \sum N_i$:** Number fraction;
3. **$w_i = N_i M_i / \sum N_i M_i$:** Weight fraction;
4. **$M_i$:** Mean molecular weight of the size category;
derive the **Polydispersity Index ($PDI$) & Degree of Polymerization ($DP_n$)**:
$$\mathbf{PDI = \frac{\bar{M}_w}{\bar{M}_n} \ge 1.00 \quad \Big| \quad \mathbf{DP_n = \frac{\bar{M}_n}{m_0}} \quad (m_0 = \text{Monomer Repeat Unit Molecular Weight})}$$
master the **PDI Breadth Matrix**:
$$\begin{array}{|l|c|l|}
\hline
\textbf{Polymer Synthesis Mechanism} & \textbf{Typical PDI Range} & \textbf{Molecular Weight Distribution Nature} \\
\hline
\mathbf{\text{Natural Proteins / DNA}} & \mathbf{PDI = 1.000} & \mathbf{\text{Monodisperse (Every molecule identical length)}} \\
\text{Living Anionic / ATRP Polymerization} & PDI = 1.02 - 1.15 & Narrow monodisperse-like distribution \\
\mathbf{\text{Free-Radical Addition Polymer}} & \mathbf{PDI = 1.80 - 3.50} & \mathbf{\text{Broad Gaussian distribution (e.g. industrial LDPE)}} \\
\text{Step-Growth (Polycondensation)} & PDI \approx 2.00 & Flory-Schulz most probable distribution ($PDI = 1 + p$) \\
\text{Ziegler-Natta Coordination} & PDI = 4.00 - 15.00 & Very broad bimodal distribution for pipe extrusion \\
\hline
\end{array}$$
(proving that $\bar{M}_w \ge \bar{M}_n$ always holds for synthetic polymers, and that $PDI$ quantifies the statistical dispersion of macromolecular chain lengths).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | $\bar{M}_n = \sum x_i M_i$, $\bar{M}_w = \sum w_i M_i$, $PDI = \frac{\bar{M}_w}{\bar{M}_n}$ & Degree of Polymerization ($DP_n = \frac{\bar{M}_n}{m_0}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Mn, Mw, PDI, and Degree of Polymerization from Molecular Weight Fractions Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Polymer Chain Statistics Parameter / Distribution Metric & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Ratio of Weight-Average Molecular Weight to Number-Average Molecular Weight ($\bar{M}_w / \bar{M}_n$) Is Defined as the ___ Index (Polydispersity / PDI) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Polymer Materials Science Problem: Computing Mn, Mw, PDI, and DPn for a Polyethylene (PE) Sample Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Polymer Molecular Weight Statistics (Callister 2020; Ebewele 2000):
   - **Statistical Formulations:**
     $$\mathbf{\bar{M}_n = \sum x_i M_i \quad \Big| \quad \bar{M}_w = \sum w_i M_i \quad \Big| \quad PDI = \frac{\bar{M}_w}{\bar{M}_n} \ge 1.0 \quad \Big| \quad DP_n = \frac{\bar{M}_n}{m_0}}$$
   - **Weighting Mechanism Invariant:**
     - $\bar{M}_n$ represents the arithmetic mean of all chain lengths;
     - $\bar{M}_w$ heavily weights large, heavy macromolecules because long chains dominate **zero-shear melt viscosity ($\eta_0 \propto \bar{M}_w^{3.4}$)** and tensile impact toughness!
2. **Slide 2 (`ordering`):** Provide 5 steps of molecular weight analysis: (1) tabulate molecular weight range brackets $M_i$ and number of chains $N_i$, (2) calculate number fractions $x_i = N_i / \sum N_i$ and sum $x_i M_i$ to find $\bar{M}_n$, (3) calculate total mass in each bracket $N_i M_i$ and evaluate weight fractions $w_i = N_i M_i / \sum N_i M_i$, (4) sum $w_i M_i$ to determine weight-average molecular weight $\bar{M}_w$, (5) compute polydispersity index $PDI = \bar{M}_w / \bar{M}_n$ and divide by repeat unit mass $m_0$ to find degree of polymerization $DP_n = \bar{M}_n / m_0$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Number-Average $\bar{M}_n$, Weight-Average $\bar{M}_w$, Polydispersity Index PDI, Degree of Polymerization $DP_n$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Polydispersity (or PDI). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating $\bar{M}_n, \bar{M}_w, PDI, DP_n$ for polyethylene ($-\text{CH}_2\text{-CH}_2-$, repeat unit $m_0 = 2(12.011) + 4(1.008) = \mathbf{28.05\text{ g/mol}}$): A polyethylene sample consists of two equal-molar fractions:
   - Fraction 1: $N_1 = 100\text{ moles}$, $M_1 = 20,000\text{ g/mol}$ (Mass $M_{\text{tot},1} = 100 \times 20,000 = 2.0 \times 10^6\text{ g}$);
   - Fraction 2: $N_2 = 100\text{ moles}$, $M_2 = 60,000\text{ g/mol}$ (Mass $M_{\text{tot},2} = 100 \times 60,000 = 6.0 \times 10^6\text{ g}$);
   - Total moles: $\sum N_i = 200\text{ moles}$, Number fractions: $x_1 = 0.50, x_2 = 0.50$;
   - Number-average: $\bar{M}_n = (0.50 \times 20,000) + (0.50 \times 60,000) = 10,000 + 30,000 = \mathbf{40,000\text{ g/mol}}$;
   - Total mass: $\sum N_i M_i = 2.0 \times 10^6 + 6.0 \times 10^6 = 8.0 \times 10^6\text{ g}$;
   - Weight fractions: $w_1 = \frac{2.0 \times 10^6}{8.0 \times 10^6} = \mathbf{0.250}$, $w_2 = \frac{6.0 \times 10^6}{8.0 \times 10^6} = \mathbf{0.750}$;
   - Weight-average: $\bar{M}_w = (0.250 \times 20,000) + (0.750 \times 60,000) = 5,000 + 45,000 = \mathbf{50,000\text{ g/mol}}$;
   - Polydispersity index: $PDI = \frac{\bar{M}_w}{\bar{M}_n} = \frac{50,000}{40,000} = \mathbf{1.250}$;
   - Degree of polymerization: $DP_n = \frac{40,000}{28.05} = \mathbf{1426}$;
   - What are $\bar{M}_n, \bar{M}_w$, and the Polydispersity Index $PDI$? ($\bar{M}_n = \mathbf{40,000\text{ g/mol}}, \bar{M}_w = \mathbf{50,000\text{ g/mol}}, PDI = \mathbf{1.25}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "polymer_molecular_weight_and_polydispersity_index",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Polymer Molecular Weights \\& PDI (William D. Callister Jr.)**\n• **Number-Average ($\\bar{M}_n$) \\& Weight-Average ($\\bar{M}_w$) Master Formulations:**\n$$\n\\mathbf{\\bar{M}_n = \\sum x_i M_i = \\frac{\\sum N_i M_i}{\\sum N_i} \\quad \\Big| \\quad \\bar{M}_w = \\sum w_i M_i = \\frac{\\sum N_i M_i^2}{\\sum N_i M_i} \\quad [\\text{g/mol}]}\n$$\n  - **$x_i = \\frac{N_i}{\\sum N_i}$:** Number fraction of polymer chains in size category $M_i$;\n  - **$w_i = \\frac{N_i M_i}{\\sum N_i M_i}$:** Weight fraction of polymer chains in size category $M_i$;\n• **Polydispersity Index ($PDI$) \\& Degree of Polymerization ($DP_n$):**\n$$\n\\mathbf{PDI = \\frac{\\bar{M}_w}{\\bar{M}_n} \\ge 1.00} \\quad \\Big| \\quad \\mathbf{DP_n = \\frac{\\bar{M}_n}{m_0} \\quad (m_0 = \\text{Monomer Repeat Unit Mass})}\n$$\n• **The Weighting Invariant:** $\\bar{M}_w \\ge \\bar{M}_n$ strictly holds for all polydisperse polymers; $\\bar{M}_w$ heavily weights large, entangled macromolecules that dictate **melt viscosity ($\\eta_0 \\propto \\bar{M}_w^{3.4}$)** and tensile impact toughness!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate Mn, Mw, PDI, and the degree of polymerization of a synthetic polymer.",
      "orderItems": [
        "Extract molecular weight intervals Mi and corresponding mole counts Ni (or mass counts) across the distribution",
        "Calculate number fractions: xi = Ni / \u2211Ni and sum products to obtain Number-Average Molecular Weight: Mn = \u2211(xi * Mi)",
        "Calculate weight fractions: wi = (Ni * Mi) / \u2211(Ni * Mi) for each molecular weight bracket",
        "Sum the weighted products to compute the Weight-Average Molecular Weight: Mw = \u2211(wi * Mi)",
        "Calculate the Polydispersity Index: PDI = Mw / Mn and determine the Degree of Polymerization: DPn = Mn / m0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Polymer Chain Parameter to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Number-Average (Mn)", "right": "Arithmetic mean chain molecular weight based on mole fractions (\u2211xi*Mi), governing colligative properties" },
        { "left": "Weight-Average (Mw)", "right": "Mass-weighted molecular weight (\u2211wi*Mi), heavily sensitive to long chains dominating melt rheology" },
        { "left": "Polydispersity Index (PDI)", "right": "Mw / Mn \u2265 1.0, dimensionless statistical metric measuring breadth of molecular weight distribution" },
        { "left": "Degree of Polymerization (DPn)", "right": "Mn / m0, average number of covalent repeating monomer units comprising a single polymer chain" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The ratio of weight-average molecular weight to number-average molecular weight (Mw / Mn) is defined as the ___ index.",
      "blankAnswer": "polydispersity",
      "blankDistractors": ["viscosity", "crystallinity", "elasticity"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A polyethylene sample contains two equal-molar fractions (x1 = 0.50, x2 = 0.50): Fraction 1 has M1 = 20,000 g/mol and Fraction 2 has M2 = 60,000 g/mol. Mn = 0.5*20,000 + 0.5*60,000 = 40,000 g/mol. Weight fractions are w1 = 0.250 and w2 = 0.750. Mw = 0.25*20,000 + 0.75*60,000 = 50,000 g/mol. What are Mn, Mw, and the Polydispersity Index PDI?",
      "options": [
        { "text": "Mn = 40,000 g/mol, Mw = 50,000 g/mol, and PDI = 1.25 (Mn = 40,000 g/mol; Mw = 50,000 g/mol; PDI = 50,000 / 40,000 = 1.250)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using polymer molecular weight statistics (William D. Callister Jr. *Materials Science and Engineering: An Introduction* Chapter 14; Robert O. Ebewele *Polymer Science and Technology* Chapter 2). 1. **Calculate Number-Average Molecular Weight ($\\bar{M}_n$):** - Equal molar distribution $\\implies x_1 = 0.500, \\quad x_2 = 0.500$. - Molecular weights: $M_1 = 20,000\\text{ g/mol}, \\quad M_2 = 60,000\\text{ g/mol}$. $$\\bar{M}_n = \\sum x_i M_i = (0.500 \\times 20,000\\text{ g/mol}) + (0.500 \\times 60,000\\text{ g/mol})$$ $$\\bar{M}_n = 10,000 + 30,000 = \\mathbf{40,000\\text{ g/mol}}$$ 2. **Calculate Weight Fractions ($w_i$):** - Mass of fraction 1: $100\\text{ mol} \\times 20,000\\text{ g/mol} = 2.00 \\times 10^6\\text{ g}$. - Mass of fraction 2: $100\\text{ mol} \\times 60,000\\text{ g/mol} = 6.00 \\times 10^6\\text{ g}$. - Total mass: $2.00 \\times 10^6 + 6.00 \\times 10^6 = 8.00 \\times 10^6\\text{ g}$. - Weight fraction 1: $$w_1 = \\frac{2.00 \\times 10^6}{8.00 \\times 10^6} = \\mathbf{0.250 = 25.0\\%}$$ - Weight fraction 2: $$w_2 = \\frac{6.00 \\times 10^6}{8.00 \\times 10^6} = \\mathbf{0.750 = 75.0\\%}$$ 3. **Calculate Weight-Average Molecular Weight ($\\bar{M}_w$):** $$\\bar{M}_w = \\sum w_i M_i = (0.250 \\times 20,000\\text{ g/mol}) + (0.750 \\times 60,000\\text{ g/mol})$$ $$\\bar{M}_w = 5,000 + 45,000 = \\mathbf{50,000\\text{ g/mol}}$$ 4. **Calculate Polydispersity Index ($PDI$):** $$PDI = \\frac{\\bar{M}_w}{\\bar{M}_n} = \\frac{50,000\\text{ g/mol}}{40,000\\text{ g/mol}} = \\mathbf{1.250}$$ Flawless polymer molecular weight and PDI derivation!" },
        { "text": "Mn = 50,000 g/mol, Mw = 40,000 g/mol, and PDI = 0.80 (Inverted Mn and Mw; PDI cannot be less than 1.0)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Mn = 40,000 g/mol, Mw = 40,000 g/mol, and PDI = 1.00 (Assumed monodisperse)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Mn = 20,000 g/mol, Mw = 60,000 g/mol, and PDI = 3.00", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
