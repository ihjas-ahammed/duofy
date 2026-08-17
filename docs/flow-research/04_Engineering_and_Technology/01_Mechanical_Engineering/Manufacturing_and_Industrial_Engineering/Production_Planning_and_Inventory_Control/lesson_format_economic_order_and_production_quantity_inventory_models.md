# Duofy Reusable Lesson Format: Inventory Control (EOQ & EPQ Optimization Models)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Manufacturing_and_Industrial_Engineering / Production_Planning_and_Inventory_Control`  
**Lesson Format Type:** `economic_order_and_production_quantity_inventory_models`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through deterministic inventory optimization, order-setup vs holding cost trade-offs, and batch run-size modeling in manufacturing supply chains (Ford W. Harris 1913; William J. Stevenson *Operations Management* Chapter 13; Lee J. Krajewski et al. *Operations Management: Processes and Supply Chains* Chapter 12): formulate the **Total Annual Inventory Cost Curve**:
$$\mathbf{TC(Q) = \text{Annual Ordering Cost} + \text{Annual Holding Cost} = \frac{D}{Q} S + \frac{Q}{2} H}$$
derive the **Economic Order Quantity ($\mathbf{Q^*_{\text{EOQ}}}$)**:
$$\mathbf{\frac{d(TC)}{dQ} = -\frac{DS}{Q^2} + \frac{H}{2} = 0 \implies \mathbf{Q^*_{\text{EOQ}} = \sqrt{\frac{2 D S}{H}}}}$$
prove the **Cost-Balance Invariant** (at $Q^*$, **Annual Ordering Cost equals Annual Holding Cost $\frac{D}{Q}S = \frac{Q}{2}H$**, yielding minimum total cost $\mathbf{TC(Q^*) = \sqrt{2 D S H}}$); and derive the **Economic Production Quantity ($\mathbf{Q^*_{\text{EPQ}}}$)** for internal manufacturing where parts are produced at rate $P$ while being consumed at demand rate $D < P$:
$$\mathbf{Q^*_{\text{EPQ}} = \sqrt{\frac{2 D S}{H \left(1 - \frac{D}{P}\right)}} \quad \Big| \quad I_{\text{max}} = Q \left(1 - \frac{D}{P}\right)}$$
(proving why finite production rates lower average inventory holding, permitting larger economic production batches).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | EOQ Equation ($Q^* = \sqrt{\frac{2DS}{H}}$), Cost Balance Invariant & EPQ ($Q^* = \sqrt{\frac{2DS}{H(1-D/P)}}$) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing of Optimal Batch Size, Annual Setup Costs, and Total Inventory Cost Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Inventory Parameter / Cost Model & Technical Financial Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | At the Exact Economic Order Quantity (Q*), the Annual Ordering Cost Is Identically Equal to the Annual ___ Cost (Holding / Carrying) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Supply Chain Operations Problem: Calculating the Economic Order Quantity Q* and Minimum Annual Cost Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State EOQ & EPQ (Stevenson 2021; Harris 1913):
   - **EOQ Formulation & Invariant:**
     $$\mathbf{Q^* = \sqrt{\frac{2 D S}{H}} \quad \Big| \quad TC(Q) = \frac{D}{Q}S + \frac{Q}{2}H \quad \Big| \quad TC(Q^*) = \sqrt{2 D S H}}$$
   - **EPQ Finite Run-Size Formulation ($P > D$):**
     $$\mathbf{Q^*_{\text{EPQ}} = \sqrt{\frac{2 D S}{H \left(1 - \frac{D}{P}\right)}} \quad \Big| \quad I_{\text{max}} = Q \left(1 - \frac{D}{P}\right)}$$
   - **The Cost-Balance Invariant:** At optimal batch size $Q^*$, **Ordering Cost = Holding Cost**; any deviation from $Q^*$ increases total cost!
2. **Slide 2 (`ordering`):** Provide 5 steps of inventory batch sizing: (1) determine annual demand $D$, ordering/setup cost $S$ per order, and unit holding cost $H$ ($/unit/year), (2) apply the EOQ formula $Q^* = \sqrt{2DS/H}$, (3) compute optimal number of orders per year $N = D/Q^*$, (4) verify that annual ordering cost $\frac{D}{Q^*}S$ equals annual holding cost $\frac{Q^*}{2}H$, (5) calculate minimum total annual inventory cost $TC = \sqrt{2DSH}$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Economic Order Quantity EOQ, Economic Production Quantity EPQ, Annual Holding Cost, Annual Ordering Cost) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Holding (or Carrying). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating EOQ: A factory consumes $D = 10,000\text{ units/year}$ of a precision bearing. The order placement setup cost is $S = \$50\text{ per order}$, and the inventory holding cost is $H = \$4.00\text{ per unit/year}$. What is the optimal Economic Order Quantity $Q^*$ and the resulting minimum total annual inventory cost $TC(Q^*)$? ($Q^* = \sqrt{\frac{2 D S}{H}} = \sqrt{\frac{2(10,000)(\$50)}{\$4.00}} = \sqrt{\frac{1,000,000}{4}} = \sqrt{250,000} = \mathbf{500\text{ units}}$; $TC(Q^*) = \frac{D}{Q^*}S + \frac{Q^*}{2}H = \frac{10,000}{500}(50) + \frac{500}{2}(4) = 20(50) + 250(4) = \$1000 + \$1000 = \mathbf{\$2000\text{/year}}$ (or $\sqrt{2(10,000)(50)(4)} = \sqrt{4,000,000} = \$2000$)).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "economic_order_and_production_quantity_inventory_models",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Economic Order Quantity \\& Production Sizing (Ford W. Harris 1913)**\n• **EOQ Formulation \\& Cost Invariant:**\n$$\n\\mathbf{Q^*_{\\text{EOQ}} = \\sqrt{\\frac{2 D S}{H}} \\quad \\Big| \\quad TC(Q) = \\frac{D}{Q}S + \\frac{Q}{2}H \\quad \\Big| \\quad TC(Q^*) = \\sqrt{2 D S H}}\n$$\n• **EPQ Finite Production Run Formulation ($P > D$):**\n$$\n\\mathbf{Q^*_{\\text{EPQ}} = \\sqrt{\\frac{2 D S}{H \\left(1 - \\frac{D}{P}\\right)}} \\quad \\Big| \\quad I_{\\text{max}} = Q \\left(1 - \\frac{D}{P}\\right)}\n$$\n• **The Cost-Balance Invariant:** At the optimal order size $Q^*$, **Annual Ordering Cost is IDENTICALLY EQUAL to Annual Holding Cost ($\\mathbf{\\frac{D}{Q}S = \\frac{Q}{2}H}$)**!\n• **Diminishing Sensitivity:** Total cost curve $TC(Q)$ is flat near the minimum; a $\\pm 20\\%$ deviation in order quantity increases total cost by less than $2\\%$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to calculate the Economic Order Quantity and total annual inventory management cost.",
      "orderItems": [
        "Record annual demand D, fixed procurement order cost S, and annual unit inventory holding cost H",
        "Calculate the optimal batch order size using the EOQ equation: Q* = sqrt((2 * D * S) / H)",
        "Determine the optimal annual order frequency: N_orders = D / Q*",
        "Compute the annual ordering cost (D/Q* * S) and annual holding cost (Q*/2 * H)",
        "Sum the balanced ordering and holding costs to find minimum total annual inventory cost: TC = sqrt(2 * D * S * H)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Inventory Cost Component to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Economic Order Quantity (EOQ)", "right": "Q* = sqrt(2DS/H), batch size that minimizes the sum of annual ordering and inventory carrying costs" },
        { "left": "Economic Production Quantity (EPQ)", "right": "Q* = sqrt(2DS / (H*(1 - D/P))), batch model for internal production where stock is replenished gradually" },
        { "left": "Annual Holding Cost (Q/2 * H)", "right": "Cost of tied-up working capital, warehouse storage, insurance, and obsolescence scaling linearly with Q" },
        { "left": "Annual Ordering Cost (D/Q * S)", "right": "Fixed administrative and shipping costs per batch, decaying hyperbolically as order size Q increases" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "At the exact Economic Order Quantity (Q*), the annual ordering cost is identically equal to the annual ___ cost.",
      "blankAnswer": "holding",
      "blankDistractors": ["purchase", "shipping", "manufacturing"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A factory has an annual demand D = 10,000 units/year for a component. The order setup cost is S = $50 per order, and the holding cost is H = $4.00 per unit/year. What is the optimal Economic Order Quantity Q* and the minimum total annual inventory cost TC(Q*)?",
      "options": [
        { "text": "Q* = 500 units and TC = $2,000/year (Q* = sqrt(2 * 10,000 * 50 / 4) = 500 units, with Ordering Cost = $1,000 and Holding Cost = $1,000)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the Harris EOQ model (William Stevenson *Operations Management* Chapter 13). 1. **Calculate Economic Order Quantity ($Q^*$):** $$Q^* = \\sqrt{\\frac{2 D S}{H}} = \\sqrt{\\frac{2(10,000\\text{ units})(\\$50)}{\\$4.00/\\text{unit}\\cdot\\text{year}}} = \\sqrt{\\frac{1,000,000}{4}} = \\sqrt{250,000} = \\mathbf{500\\text{ units}}$$ 2. **Calculate Annual Ordering Cost:** $$\\text{Ordering Cost} = \\frac{D}{Q^*} \\cdot S = \\frac{10,000}{500} \\times \\$50 = 20\\text{ orders} \\times \\$50 = \\mathbf{\\$1,000\\text{/year}}$$ 3. **Calculate Annual Holding Cost:** $$\\text{Holding Cost} = \\frac{Q^*}{2} \\cdot H = \\frac{500}{2} \\times \\$4.00 = 250\\text{ units} \\times \\$4.00 = \\mathbf{\\$1,000\\text{/year}}$$ 4. **Total Minimum Annual Cost:** $$TC(Q^*) = \\text{Ordering Cost} + \\text{Holding Cost} = \\$1,000 + \\$1,000 = \\mathbf{\\$2,000\\text{/year}}$$ Notice how Ordering Cost **exactly balances Holding Cost ($1000 = 1000)** at $Q^*$!" },
        { "text": "Q* = 250 units and TC = $4,000/year", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Q* = 1000 units and TC = $2,500/year", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Q* = 500 units and TC = $1,000/year", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
