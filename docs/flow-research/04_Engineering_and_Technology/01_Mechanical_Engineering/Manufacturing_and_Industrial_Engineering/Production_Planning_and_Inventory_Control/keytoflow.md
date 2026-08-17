# Key to Flow: Production Planning & Inventory Control (Operations Optimization)

**Subject Area:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Manufacturing_and_Industrial_Engineering / Production_Planning_and_Inventory_Control`

---

## 📌 Core Concept & Mental Model
**Economic Order Quantity (EOQ $Q^* = \sqrt{\frac{2DS}{H}}$), Economic Production Quantity for Finite Run Rates (EPQ $Q^* = \sqrt{\frac{2DS}{H(1-D/P)}}$), Stochastic Demand Reorder Points & Safety Stock ($ROP = \bar{d} \cdot LT + z \sigma_{dLT}$), Material Requirements Planning (MRP) BOM Explosion & Netting Logic, Assembly Line Balancing (Takt / Cycle Time $C = \frac{T_{\text{avail}}}{D}$, Minimum Stations $N_{\text{min}} = \lceil \frac{\sum t_i}{C} \rceil$, Balance Efficiency $\eta = \frac{\sum t_i}{N \cdot C}$), and Project Scheduling Network Analysis (Critical Path Method CPM, PERT Expected Time $t_e = \frac{a + 4m + b}{6}$, Total Float $S = LS - ES$)** govern industrial production systems and supply chain logistics (William J. Stevenson *Operations Management* 14th ed.; Lee J. Krajewski et al. *Operations Management: Processes and Supply Chains* 13th ed.; Mikell P. Groover *Automation, Production Systems, and Computer-Integrated Manufacturing* 5th ed.; Hamdy A. Taha *Operations Research: An Introduction* 10th ed.):
* **1. Deterministic Inventory Control (EOQ & EPQ):**
  $$\mathbf{Q^*_{\text{EOQ}} = \sqrt{\frac{2 D S}{H}} \quad \Big| \quad \mathbf{Q^*_{\text{EPQ}} = \sqrt{\frac{2 D S}{H \left(1 - \frac{D}{P}\right)}} \quad (P > D)}$$
  - **The Economic Balance Invariant:** At the optimal batch size $Q^*$, **Annual Ordering Cost is IDENTICALLY EQUAL to Annual Holding Cost ($\frac{D}{Q} S = \frac{Q}{2} H$)**!
  - Total Annual Inventory Cost:
    $$\mathbf{TC(Q^*) = \sqrt{2 D S H}}$$
* **2. Stochastic Inventory & Reorder Point (ROP):**
  $$\mathbf{ROP = \bar{d} \cdot LT + z \cdot \sigma_{dLT} \quad \left(SS = z \cdot \sigma_d \sqrt{LT}, \ z = \Phi^{-1}(\text{Service Level})\right)}$$
  - Buffer stock prevents stockouts caused by random demand spikes during supplier replenishment lead time $LT$.
* **3. Assembly Line Balancing & Station Utilization:**
  $$\mathbf{C_{\text{cycle}} = \frac{\text{Available Operating Time } T_a}{\text{Demand Rate } D} \quad \Big| \quad \mathbf{N_{\text{min}} = \left\lceil \frac{\sum t_i}{C_{\text{cycle}}} \right\rceil}}$$
  $$\mathbf{\text{Line Efficiency } \eta = \frac{\sum t_i}{N_{\text{actual}} \cdot C_{\text{cycle}}} \times 100\% \quad \Big| \quad \text{Balance Delay } BD = 100\% - \eta}$$
* **4. Project Management & Network Scheduling (CPM / PERT):**
  - **PERT Beta Distribution 3-Point Estimate:**
    $$\mathbf{t_e = \frac{a + 4 m + b}{6} \quad \Big| \quad \sigma^2 = \left(\frac{b - a}{6}\right)^2}$$
  - **Critical Path Invariant:** Activities with **Zero Total Float ($\mathbf{S = LS - ES = LF - EF = 0}$)** form the Critical Path; any delay on this path directly delays overall project completion!

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Industrial Engineering Problem-Solving Spectrum
* Batch Sizing $\to$ Determine annual demand $D$, setup cost $S$, holding rate $H \to$ Solve EOQ $Q^* = \sqrt{2DS/H} \to$ Check total cost $TC = \sqrt{2DSH}$.
* Inventory Reorder $\to$ Given lead time $LT$ and service level $Z \to$ Compute safety stock $SS = z \sigma \sqrt{LT} \to$ ROP $= d LT + SS$.
* Assembly Line Design $\to$ Given required output units $\to$ Compute cycle time $C = T/D \to$ Group tasks to meet precedence $\to$ Compute balance efficiency $\eta$.
* Project Scheduling $\to$ Calculate expected times $t_e = (a+4m+b)/6 \to$ Perform forward pass (ES, EF) and backward pass (LS, LF) $\to$ Trace zero-slack critical path.

### 2. Top Recommended Resources
* **The Operations Management Standard:** *Operations Management* (William J. Stevenson, McGraw-Hill 14th ed.).
* **The Quantitative Industrial Classic:** *Operations Management: Processes and Supply Chains* (Lee J. Krajewski, Manoj K. Malhotra, Pearson 13th ed.).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you calculate the optimal Economic Order Quantity ($Q^*$) and total minimum annual inventory cost?
- [ ] Can you determine the Reorder Point ($ROP$) with safety stock for a $95\%$ or $99\%$ service level?
- [ ] Can you calculate the required cycle time $C$ and line efficiency $\eta$ for an assembly line?
- [ ] Can you evaluate the expected duration $t_e$ and variance $\sigma^2$ of a PERT project activity?
- [ ] Can you identify critical path activities using Early Start (ES) and Late Start (LS) network passes?
