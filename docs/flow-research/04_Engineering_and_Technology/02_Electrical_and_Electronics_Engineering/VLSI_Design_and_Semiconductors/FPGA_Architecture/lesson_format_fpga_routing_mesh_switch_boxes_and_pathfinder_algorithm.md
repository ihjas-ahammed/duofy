# Duofy Reusable Lesson Format: FPGA Interconnect (Routing Mesh & PathFinder Algorithm)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / VLSI_Design_and_Semiconductors / FPGA_Architecture`  
**Lesson Format Type:** `fpga_routing_mesh_switch_boxes_and_pathfinder_algorithm`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the physical programmable interconnect mesh of island-style FPGAs, Connection Blocks (CB) with flexibility $F_c$, Switch Blocks (SB) with flexibility $F_s = 3$ (Wilton, Disjoint/Subset, Universal topologies), segmented routing tracks (Single, Double, Quad, and Long lines), channel width ($W$), and the mathematical mechanics of the industry-standard **PathFinder Negotiated Congestion Routing Algorithm** (Larry McMurchie & Carl Ebeling 1995; Vaughn Betz *Architecture and CAD for Deep-Submicron FPGAs* Chapter 4 & 7): formulate the **Island-Style Interconnect Architecture Parameters**:
1. **Connection Block Flexibility ($F_c$):** Fraction of routing tracks in the adjacent channel that can connect to a logic block input/output pin ($F_{c,\text{in}} \approx 0.15 - 0.20, \ F_{c,\text{out}} \approx 0.25$);
2. **Switch Block Flexibility ($F_s$):** Number of wire segments meeting at a switch block that can connect to a given incoming track ($F_s = 3$ is optimal for area-routability balance);
derive the **PathFinder Negotiated Congestion Cost Function (McMurchie & Ebeling)**:
$$\mathbf{c_n = \left( b_n + h_n \right) \cdot p_n}$$
where:
1. **$b_n$ (Base Cost):** Intrinsic propagation delay or wire length of routing node $n$;
2. **$h_n$ (Historical Congestion Cost):** Tracks accumulated congestion over previous iterations:
   $$\mathbf{h_n^{(i)} = h_n^{(i-1)} + h_{\text{fac}} \cdot \max\left(0, \ \text{occupancy}(n) - \text{capacity}(n)\right)}$$
3. **$p_n$ (Present Over-Use Penalty Factor):** Exponentially penalizes sharing during the current iteration:
   $$\mathbf{p_n = 1 + p_{\text{fac}} \cdot \max\left(0, \ \text{occupancy}(n) - \text{capacity}(n)\right)}$$
(proving how PathFinder initially allows multiple nets to share the same physical wire to discover shortest timing paths, and gradually increases penalty multipliers ($p_{\text{fac}} \uparrow$) until all congestion conflicts are completely resolved into $100\%$ legal, timing-optimal routing).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Island Routing Mesh, Switch Boxes ($F_s = 3$), Connection Boxes ($F_c$) & PathFinder Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution of the PathFinder Negotiated Congestion Iterative Routing Algorithm Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Interconnect Construct / PathFinder Variable & Technical Routing Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the PathFinder Negotiated Congestion Algorithm, Over-Use Penalties Gradually Force Shared Nets onto Alternative Paths to Resolve Routing ___ (Congestion / Conflicts) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | FPGA CAD Problem: Computing PathFinder Node Cost Across Successive Routing Iterations Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State FPGA Interconnect & PathFinder (McMurchie & Ebeling 1995; Betz 1999):
   - **Interconnect Topology & Cost Equation:**
     $$\mathbf{c_n = (b_n + h_n) \cdot p_n \quad \Big| \quad F_s = 3 \quad \Big| \quad F_c \approx 0.20 \quad \Big| \quad h_n^{(i)} = h_n^{(i-1)} + h_{\text{fac}} \cdot \text{overuse}}$$
   - **Switch Block Topology Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Switch Box Style} & \textbf{Internal Switching Pattern} & \textbf{Key Routing Advantage} \\
     \hline
     \mathbf{\text{Wilton Switch Box}} & \text{Diagonal track permutation on turns} & \mathbf{\text{High routability; breaks routing track isolation}} \\
     \mathbf{\text{Subset / Disjoint Box}} & \text{Tracks connect only to same index } (T_i \leftrightarrow T_i) & \text{Simple layout; susceptible to routing track starvation} \\
     \mathbf{\text{Universal Box}} & \text{Maximizes independent simultaneous connections} & \text{High routability across multi-pin nets} \\
     \hline
     \end{array}$$
   - **The Negotiated Congestion Invariant:** In Iteration 1, PathFinder ignores congestion penalties ($p_n = 1$), allowing nets to **illegally share the fastest critical wires**; as iterations proceed, congestion penalties force non-critical nets onto detour paths, preserving the fast paths for timing-critical nets!
2. **Slide 2 (`ordering`):** Provide 5 steps of PathFinder routing: (1) route all nets using Dijkstra/A* maze expansion based purely on base wire delay $b_n$, (2) identify overloaded routing nodes where $\text{occupancy} > \text{capacity}$, (3) update historical congestion costs $h_n$ and increase present congestion multiplier $p_{\text{fac}}$, (4) rip up and reroute every net using updated cost function $c_n = (b_n + h_n) p_n$, (5) repeat until every routing node has $\text{occupancy} \le \text{capacity}$ (zero congestion violations)!
3. **Slide 3 (`matching`):** Pair 4 concepts (Base Cost $b_n$, Historical Cost $h_n$, Switch Block Flexibility $F_s=3$, Connection Block Flexibility $F_c$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Congestion (or Conflicts). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating PathFinder node cost: A wire segment node $n$ has base delay cost $b_n = 1.50\text{ ns}$ and capacity $= 1$. On iteration 2, historical congestion is $h_n = 0.50\text{ ns}$. Two nets share this wire ($\text{occupancy} = 2 \implies \text{overuse} = 1$). The present penalty parameter is $p_{\text{fac}} = 0.50$ (so $p_n = 1 + 0.50(1) = 1.50$). What is the total routing cost $c_n$ of this node on iteration 2? ($c_n = (b_n + h_n) \cdot p_n = (1.50 + 0.50) \times 1.50 = 2.00 \times 1.50 = \mathbf{3.00\text{ ns}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "fpga_routing_mesh_switch_boxes_and_pathfinder_algorithm",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: FPGA Programmable Interconnect \\& PathFinder (McMurchie \\& Ebeling)**\n• **Island-Style Interconnect Architecture:**\n  - **Connection Block ($F_c$):** Connects CLB pins to channel routing tracks ($F_{c,\\text{in}} \\approx 0.15 - 0.20, \\ F_{c,\\text{out}} \\approx 0.25$);\n  - **Switch Block ($F_s = 3$):** 4-way intersection switch box connecting horizontal and vertical channels (e.g. Wilton box);\n• **PathFinder Negotiated Congestion Cost Formula:**\n$$\n\\mathbf{c_n = \\left( b_n + h_n \\right) \\cdot p_n}\n$$\n  - **$b_n$ (Base Cost):** Intrinsic RC propagation delay of wire segment $n$;\n  - **$h_n$ (Historical Congestion):** Accumulated penalty for nodes that were congested in previous iterations: $h_n^{(i)} = h_n^{(i-1)} + h_{\\text{fac}} \\cdot \\text{overuse}$;\n  - **$p_n$ (Present Over-Use Factor):** $p_n = 1 + p_{\\text{fac}} \\cdot \\max(0, \\text{occupancy} - \\text{capacity})$;\n• **The Negotiation Invariant:** PathFinder allows temporary wire sharing in early iterations so timing-critical signals can negotiate ownership of the fastest paths, while non-critical signals are gradually priced out onto detours!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the PathFinder Negotiated Congestion Routing Algorithm in FPGA CAD tools.",
      "orderItems": [
        "Initialize all historical congestion costs to zero (h_n = 0) and present penalty factor to minimum (p_n = 1)",
        "Route every electrical net independently using shortest-path A*/Dijkstra search based solely on base delay b_n",
        "Analyze the entire FPGA routing graph to detect congested nodes where wire occupancy exceeds capacity",
        "Increment historical congestion h_n on congested wires and increase the present over-use multiplier p_fac",
        "Rip up and reroute all nets iteratively with cost c_n = (b_n + h_n)*p_n until all congestion is completely eliminated"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each FPGA Interconnect Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Switch Block (Fs = 3)", "right": "4-way intersection matrix connecting orthogonal routing channels with 3 programmable switches per wire" },
        { "left": "Connection Block (Fc)", "right": "Multiplexer matrix connecting CLB logic pins to a specific fraction Fc of passing routing tracks" },
        { "left": "Historical Cost (hn)", "right": "Memory term in PathFinder accumulating congestion penalties from prior routing iterations" },
        { "left": "Base Cost (bn)", "right": "Intrinsic physical RC propagation delay of a routing segment in the absence of congestion" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the PathFinder negotiated congestion algorithm, over-use penalties gradually force non-critical nets onto alternative paths to resolve routing ___.",
      "blankAnswer": "congestion",
      "blankDistractors": ["capacitance", "leakage", "latency"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A high-speed FPGA routing segment node n has base delay bn = 1.50 ns and capacity = 1 wire. On routing iteration 2, its historical congestion cost has reached hn = 0.50 ns. Two nets are currently routed through this node (occupancy = 2 \u2192 overuse = 1). If the present penalty factor is p_fac = 0.50 (pn = 1 + 0.50*(1) = 1.50), what is the total effective cost cn of routing through this node?",
      "options": [
        { "text": "cn = 3.00 ns (cn = (bn + hn) * pn = (1.50 ns + 0.50 ns) * 1.50 = 2.00 ns * 1.50 = 3.00 ns, increasing its perceived cost to encourage non-critical signals to take detours)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the PathFinder negotiated congestion cost formula (Larry McMurchie & Carl Ebeling *PathFinder: A Negotiation-Based Performance-Driven Router for FPGAs*). 1. **Recall the PathFinder Node Cost Formula:** $$c_n = (b_n + h_n) \\cdot p_n$$ 2. **Calculate the Historical Base Sum ($b_n + h_n$):** - Base delay cost: $b_n = 1.50\\text{ ns}$. - Accumulated historical congestion cost: $h_n = 0.50\\text{ ns}$. $$b_n + h_n = 1.50\\text{ ns} + 0.50\\text{ ns} = \\mathbf{2.00\\text{ ns}}$$ 3. **Calculate the Present Over-Use Multiplier ($p_n$):** - Wire capacity: $1$. - Current wire occupancy: $2$. - Over-use: $\\max(0, 2 - 1) = 1$. - Multiplier parameter: $p_{\\text{fac}} = 0.50$. $$p_n = 1 + p_{\\text{fac}} \\cdot (\\text{overuse}) = 1 + 0.50 \\times 1 = \\mathbf{1.50}$$ 4. **Calculate Total Perceived Routing Cost ($c_n$):** $$c_n = 2.00\\text{ ns} \\times 1.50 = \\mathbf{3.00\\text{ ns}}$$ 5. **CAD Optimization Outcome:** The routing router now sees this wire as having a cost of $3.00\\text{ ns}$ instead of its physical $1.50\\text{ ns}$. On the next rip-up pass, non-critical nets with loose timing slack will actively avoid this expensive wire, leaving it free for the critical timing path! Flawless PathFinder routing analysis!" },
        { "text": "cn = 2.00 ns (Forgot present penalty factor)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "cn = 1.50 ns (Ignored all congestion terms)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "cn = 4.50 ns", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
