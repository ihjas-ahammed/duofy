# Duofy Reusable Lesson Format: Inventory Sizing (Reorder Points, Safety Stock, & MRP)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Manufacturing_and_Industrial_Engineering / Production_Planning_and_Inventory_Control`  
**Lesson Format Type:** `reorder_point_safety_stock_and_mrp_bill_of_materials`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through stochastic inventory demand, lead-time uncertainty, service levels, safety stock sizing, and Material Requirements Planning (MRP) hierarchical bill of materials (BOM) explosion logic in production control (William J. Stevenson *Operations Management* Chapters 11 & 13; Lee J. Krajewski et al. Chapter 13): master the **Reorder Point (ROP) with Probabilistic Demand**:
$$\mathbf{ROP = \bar{d} \cdot LT + \text{Safety Stock} = \bar{d} \cdot LT + z \cdot \sigma_d \sqrt{LT}}$$
where $\bar{d}$ is average daily demand, $LT$ is lead time (days), $\sigma_d$ is daily standard deviation of demand, and $z = \Phi^{-1}(\text{Cycle Service Level})$; master the **Material Requirements Planning (MRP) Netting Logic**:
$$\mathbf{\text{Net Requirements} = \text{Gross Requirements} - (\text{Projected On-Hand} + \text{Scheduled Receipts}) + \text{Safety Stock}}$$
(analyzing how Master Production Schedule MPS requirements explode through multi-level parent-child Bill of Materials BOM product trees, time-phasing planned order releases by component lead times).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | ROP Formulation ($ROP = \bar{d} LT + z \sigma_d \sqrt{LT}$) & MRP Netting Equation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of Safety Stock, Reorder Point, and Time-Phased MRP Explosion Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Inventory Control Entity / MRP Table Column & Technical Operational Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Buffer Stock Maintained to Protect Against Demand Uncertainty During Replenishment Lead Time Is ___ Stock (Safety / Buffer) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Industrial Operations Problem: Sizing Safety Stock and ROP for a 95% Cycle Service Level Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State ROP, Safety Stock & MRP (Stevenson 2021; Krajewski 2022):
   - **Reorder Point Formulation:**
     $$\mathbf{ROP = \bar{d} \cdot LT + z \cdot \sigma_d \sqrt{LT} \quad \left(SS = z \cdot \sigma_d \sqrt{LT}, \ z = \Phi^{-1}(\text{CSL})\right)}$$
   - **Service Level $z$-Score Reference:**
     $$\begin{array}{|c|c|l|}
     \hline
     \textbf{Cycle Service Level (CSL)} & \textbf{Normal Critical Value } z & \textbf{Stockout Risk} \\
     \hline
     90.0\% & z = 1.28 & 10\% \text{ risk of stockout per cycle} \\
     \mathbf{95.0\%} & \mathbf{z = 1.645} & \mathbf{5\% \text{ stockout probability}} \\
     \mathbf{99.0\%} & \mathbf{z = 2.33} & 1\% \text{ stockout probability} \\
     99.9\% & z = 3.09 & 0.1\% \text{ extreme protection} \\
     \hline
     \end{array}$$
   - **MRP Netting Invariant:** $\mathbf{\text{Net Req} = \text{Gross Req} - (\text{On-Hand} + \text{Scheduled Receipts})}$; Planned Order Releases are offset backward by lead time!
2. **Slide 2 (`ordering`):** Provide 5 steps of ROP & MRP scheduling: (1) calculate average lead time demand $\bar{d} \cdot LT$ and standard deviation during lead time $\sigma_{LT} = \sigma_d \sqrt{LT}$, (2) determine required $z$-value for target service level (e.g. $z = 1.645$ for $95\%$), (3) compute safety stock $SS = z \sigma_d \sqrt{LT}$ and set reorder point $ROP = \bar{d} LT + SS$, (4) explode Bill of Materials (BOM) to determine gross component requirements from master schedule, (5) time-phase planned order releases backward by lead time to ensure parts arrive exactly when net requirements arise!
3. **Slide 3 (`matching`):** Pair 4 concepts (Reorder Point ROP, Safety Stock SS, Bill of Materials BOM, Planned Order Release) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Safety (or Buffer). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating safety stock and ROP: A manufacturing plant consumes a fastener with average daily demand $\bar{d} = 100\text{ units/day}$ and standard deviation $\sigma_d = 10\text{ units/day}$. Supplier replenishment lead time is fixed at $LT = 9\text{ days}$. Management mandates a $95\%$ cycle service level ($z = 1.645$). What is the required Safety Stock ($SS$) and Reorder Point ($ROP$)? (Expected lead time demand: $\bar{d} \cdot LT = 100 \times 9 = \mathbf{900\text{ units}}$; Lead time standard deviation: $\sigma_{LT} = \sigma_d \sqrt{LT} = 10 \sqrt{9} = 10(3) = \mathbf{30\text{ units}}$; Safety Stock: $SS = z \cdot \sigma_{LT} = 1.645 \times 30 = \mathbf{49.35 \approx 50\text{ units}}$; Reorder Point: $ROP = 900 + 49.35 = \mathbf{949.35 \approx 950\text{ units}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "reorder_point_safety_stock_and_mrp_bill_of_materials",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Reorder Point \\& MRP Material Planning (Stevenson \\& Krajewski)**\n• **Stochastic Reorder Point (ROP) \\& Safety Stock Formulation:**\n$$\n\\mathbf{ROP = \\bar{d} \\cdot LT + z \\cdot \\sigma_d \\sqrt{LT} \\quad \\left(SS = z \\cdot \\sigma_d \\sqrt{LT}, \\ z = \\Phi^{-1}(\\text{CSL})\\right)}\n$$\n• **Service Level ($z$-Score) Matrix:**\n$$\n\\begin{array}{|c|c|l|}\n\\hline\n\\textbf{Cycle Service Level (CSL)} & \\textbf{Normal Score } z & \\textbf{Stockout Protection Level} \\\\\n\\hline\n90.0\\% & z = 1.28 & 10\\% \\text{ probability of stockout during lead time} \\\\\n\\mathbf{95.0\\%} & \\mathbf{z = 1.645} & \\mathbf{5\\% \\text{ stockout risk per replenishment cycle}} \\\\\n\\mathbf{99.0\\%} & \\mathbf{z = 2.33} & 1\\% \\text{ high-reliability aerospace threshold} \\\\\n\\hline\n\\end{array}\n$$\n• **Material Requirements Planning (MRP) Netting Formulation:**\n$$\n\\mathbf{\\text{Net Requirements} = \\text{Gross Requirements} - (\\text{Projected On-Hand} + \\text{Scheduled Receipts}) + \\text{Safety Stock}}\n$$\n• **The MRP Time-Phasing Invariant:** Planned Order Releases are offset backward in time by **exact component lead time ($t_{\\text{release}} = t_{\\text{need}} - LT$)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to establish a safety stock reorder point and execute an MRP time-phased component release.",
      "orderItems": [
        "Calculate the mean lead time demand (d_avg * LT) and standard deviation during lead time: sigma_LT = sigma_d * sqrt(LT)",
        "Select the normal distribution z-value corresponding to the target customer cycle service level",
        "Compute required safety stock SS = z * sigma_LT and establish the Reorder Point: ROP = d_avg*LT + SS",
        "Explode the Bill of Materials (BOM) to determine parent-to-child component gross requirements",
        "Calculate time-phased net requirements and offset planned order releases backward by component lead time"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Inventory Planning Term to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Reorder Point (ROP)", "right": "Inventory level threshold that automatically triggers the placement of a new purchase or production order" },
        { "left": "Safety Stock (SS)", "right": "SS = z * \u03c3_d * sqrt(LT), extra inventory held to protect against random demand surges during lead time" },
        { "left": "Bill of Materials (BOM)", "right": "Hierarchical engineering tree listing all assemblies, subcomponents, and raw materials needed for a product" },
        { "left": "Planned Order Release", "right": "Quantity and timing of orders scheduled for issuance after lead time backward offset" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The buffer inventory maintained to protect against demand volatility during supplier replenishment lead time is ___ stock.",
      "blankAnswer": "safety",
      "blankDistractors": ["cycle", "dead", "speculative"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A plant consumes an industrial fastener with average daily demand d_avg = 100 units/day and standard deviation \u03c3_d = 10 units/day. Lead time is fixed at LT = 9 days. For a 95% cycle service level (z = 1.645), what is the required Safety Stock (SS) and Reorder Point (ROP)?",
      "options": [
        { "text": "SS = 49.35 units (~50 units) and ROP = 949.35 units (~950 units, with mean lead time demand = 900 units and \u03c3_LT = 10 * sqrt(9) = 30 units)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using stochastic inventory theory (William Stevenson *Operations Management* Chapter 13). 1. **Calculate Mean Demand During Lead Time:** $$\\mu_{LT} = \\bar{d} \\times LT = 100\\text{ units/day} \\times 9\\text{ days} = \\mathbf{900\\text{ units}}$$ 2. **Calculate Standard Deviation of Demand During Lead Time:** $$\\sigma_{LT} = \\sigma_d \\sqrt{LT} = 10\\text{ units} \\times \\sqrt{9} = 10 \\times 3 = \\mathbf{30\\text{ units}}$$ 3. **Calculate Safety Stock ($SS$):** $$SS = z \\times \\sigma_{LT} = 1.645 \\times 30\\text{ units} = \\mathbf{49.35\\text{ units} \\approx 50\\text{ units}}$$ 4. **Calculate Reorder Point ($ROP$):** $$ROP = \\mu_{LT} + SS = 900 + 49.35 = \\mathbf{949.35\\text{ units} \\approx 950\\text{ units}}$$ 5. **Operational Action:** When warehouse stock drops to $950\\text{ units}$, a purchase order for $Q^*$ is immediately released, ensuring $95\\%$ probability that stock will not run out before shipment arrives!" },
        { "text": "SS = 16.45 units and ROP = 916.45 units", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "SS = 148.05 units and ROP = 1048.05 units", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "SS = 50 units and ROP = 100 units", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
