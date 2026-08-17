# Duofy Reusable Lesson Format: Purnell Resolution Equation and Theoretical Plates

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Analytical_Chemistry_and_Spectroscopy / Chromatography_HPLC_GC`  
**Lesson Format Type:** `purnell_resolution_equation_and_theoretical_plates`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the quantitative evaluation and optimization of chromatographic separation: calculate the **Number of Theoretical Plates ($N = 16 (t_R/W)^2 = 5.545 (t_R/W_{1/2})^2$)**, define the **Retention Factor ($k = \frac{t_R - t_0}{t_0}$)** and **Selectivity Factor ($\alpha = k_2/k_1$)**, formulate the **Purnell Master Resolution Equation ($R_s = \frac{\sqrt{N}}{4}\left(\frac{\alpha-1}{\alpha}\right)\left(\frac{k_2}{1+k_2}\right)$)**, evaluate the criterion for **Baseline Resolution ($R_s \ge 1.5$)**, and analyze the comparative impact of adjusting $N$, $\alpha$, and $k$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Theoretical Plates & Purnell Master Equation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Theoretical Plate Number Calculation from Peak Width Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Chromatographic Metric & Mathematical Definition Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Complete Baseline Separation Peak Resolution Minimum Value Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Optimization Strategy for Doubling Chromatographic Resolution Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Quantitative Chromatographic Separation Parameters:
   - **Theoretical Plates (Column Efficiency):**
     $$N = 16 \left( \frac{t_R}{W_{\text{base}}} \right)^2 = 5.545 \left( \frac{t_R}{W_{1/2}} \right)^2, \qquad H = \frac{L}{N}$$
   - **Retention Factor ($k$):** $k \equiv \frac{t_R - t_0}{t_0}$ (Ideal range: $1 \le k \le 10$).
   - **Selectivity Factor ($\alpha$):** $\alpha \equiv \frac{k_2}{k_1} = \frac{t_{R2} - t_0}{t_{R1} - t_0} > 1$.
   - **Chromatographic Resolution ($R_s$):**
     $$R_s \equiv \frac{2(t_{R2} - t_{R1})}{W_1 + W_2} = \frac{t_{R2} - t_{R1}}{1.699(W_{1/2,1} + W_{1/2,2})}$$
   - **The Purnell Resolution Equation (The Master Equation):**
     $$R_s = \frac{\sqrt{N}}{4} \left( \frac{\alpha - 1}{\alpha} \right) \left( \frac{k_2}{1 + k_2} \right)$$
     *(Baseline separation of Gaussian peaks requires $R_s \ge 1.5$!).*
2. **Slide 2 (`ordering`):** Provide 5 steps calculating column plate count $N$ and resolution $R_s$ from a chromatogram: (1) measure dead time $t_0$ (unretained peak) and analyte retention times $t_{R1}, t_{R2}$, (2) measure peak base widths $W_1, W_2$ (or full width at half maximum $W_{1/2}$), (3) calculate plate count using $N = 16(t_R/W)^2$ or $5.545(t_R/W_{1/2})^2$, (4) compute retention factors $k_1 = (t_{R1}-t_0)/t_0, k_2 = (t_{R2}-t_0)/t_0$ and selectivity $\alpha = k_2/k_1$, (5) substitute values into Purnell's equation to verify $R_s = \frac{\sqrt{N}}{4}\left(\frac{\alpha-1}{\alpha}\right)\left(\frac{k_2}{1+k_2}\right) \ge 1.5$!
3. **Slide 3 (`matching`):** Pair 4 chromatographic parameters ($N$, $k$, $\alpha$, $R_s$) with their experimental roles (Efficiency / peak sharpness, Retention / time in stationary phase, Selectivity / chemical difference between peaks, Separation quality / peak overlap index).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that standard complete baseline resolution of two adjacent chromatographic peaks requires an R_s value of at least 1.5. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the effect of column length on resolution: If a chromatographer wants to DOUBLE the resolution ($R_s \to 2 R_s$) by only increasing column length $L$ (keeping particle size and mobile phase identical), by what factor must column length $L$ be increased? (By a factor of **4**; because resolution scales with the SQUARE ROOT of plate count ($R_s \propto \sqrt{N} \propto \sqrt{L}$), doubling resolution requires a $2^2 = 4$-fold increase in column length, which also quadruples retention time and backpressure).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "purnell_resolution_equation_and_theoretical_plates",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Theoretical Plates and the Purnell Master Resolution Equation**\n• **Theoretical Plate Count (Efficiency):**\n$$\nN = 16 \\left( \\frac{t_R}{W_{\\text{base}}} \\right)^2 = 5.545 \\left( \\frac{t_R}{W_{1/2}} \\right)^2, \\qquad H = \\frac{L}{N}\n$$\n• **Retention Factor ($k$) & Selectivity Factor ($\\alpha$):**\n$$\nk = \\frac{t_R - t_0}{t_0}, \\qquad \\alpha = \\frac{k_2}{k_1} = \\frac{t_{R2} - t_0}{t_{R1} - t_0} \\ge 1\n$$\n• **The Purnell Master Resolution Equation:**\n$$\nR_s = \\frac{\\sqrt{N}}{4} \\left( \\frac{\\alpha - 1}{\\alpha} \\right) \\left( \\frac{k_2}{1 + k_2} \\right)\n$$\n  - **Efficiency Term:** $\\sqrt{N}$ (Hardware/packing quality).\n  - **Selectivity Term:** $\\frac{\\alpha - 1}{\\alpha}$ (Mobile/stationary chemistry).\n  - **Retention Term:** $\\frac{k_2}{1 + k_2}$ (Solvent strength).\n• **Baseline Separation Standard:** $R_s \\ge 1.5$ ($\\le 0.1\\%$ peak overlap)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the chromatographic analysis steps calculating column plate count N and peak resolution R_s.",
      "orderItems": [
        "Record the void time t_0 (unretained solvent peak) and retention times t_R1 and t_R2 on the chromatogram",
        "Measure the peak width at base W or full width at half maximum W_1/2 for both analyte peaks",
        "Calculate the column theoretical plate number: N = 5.545 * (t_R / W_1/2)^2",
        "Compute retention factors k_1 = (t_R1 - t_0)/t_0, k_2 = (t_R2 - t_0)/t_0 and separation factor alpha = k_2 / k_1",
        "Evaluate the Purnell Master Equation: R_s = (sqrt(N) / 4) * ((alpha - 1) / alpha) * (k_2 / [1 + k_2]) to verify R_s >= 1.5"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each chromatographic parameter to its physical function.",
      "matchPairs": [
        { "left": "Plate Count N", "right": "Efficiency / peak sharpness metric (scales with column length L and inverse particle size 1/d_p)" },
        { "left": "Selectivity Factor Alpha", "right": "Relative retention ratio alpha = k_2/k_1 (governed by chemical thermodynamics between analytes and phases)" },
        { "left": "Retention Factor k", "right": "Capacity factor k = (t_R - t_0)/t_0 (time spent in stationary phase relative to mobile phase)" },
        { "left": "Baseline Resolution (R_s = 1.5)", "right": "Gaussian peaks separated by 6 sigma, yielding less than 0.1% overlap between adjacent components" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In quantitative chemical analysis, complete baseline separation of two adjacent chromatographic peaks requires a resolution R_s of at least 1.___.",
      "blankAnswer": "5",
      "blankDistractors": ["0", "2", "8"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "To double the chromatographic resolution (R_s -> 2 * R_s) by ONLY increasing column length L, by what factor must the column length be increased?",
      "options": [
        { "text": "4 times longer; because resolution scales with the SQUARE ROOT of efficiency (R_s ∝ √N ∝ √L), doubling resolution requires a 2² = 4-fold increase in column length (which also quadruples analysis time and pressure)", "isCorrect": true, "explanation": "Correct! Since N = L/H and R_s ∝ sqrt(N) = sqrt(L/H), doubling R_s requires multiplying N by 4 (hence L by 4). This illustrates why optimizing chemistry (selectivity alpha) is far more efficient than brute-force column lengthening." },
        { "text": "2 times longer", "isCorrect": false, "explanation": "Incorrect: 2x length only increases resolution by sqrt(2) ≈ 1.41." },
        { "text": "8 times longer", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "16 times longer", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
