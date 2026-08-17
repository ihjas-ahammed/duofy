# Duofy Reusable Lesson Format: System Reduction (Block Diagrams & Mason's Gain Rule)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Control_Systems / Transfer_Functions_and_Block_Diagrams`  
**Lesson Format Type:** `block_diagram_reduction_and_masons_gain_formula_synthesis`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through interconnected feedback systems, block diagram transformation rules, Signal Flow Graphs ($\text{SFG}$), and the direct synthesis of closed-loop transfer functions via Mason's Gain Formula (Samuel Jefferson Mason 1953; Katsuhiko Ogata *Modern Control Engineering* Chapter 3; Norman S. Nise *Control Systems Engineering* Chapter 5): master the **Canonical Feedback Closed-Loop Formula**:
$$\mathbf{T(s) = \frac{C(s)}{R(s)} = \frac{G(s)}{1 + G(s) H(s)} \quad (\text{Negative Feedback}) \quad \Big| \quad T(s) = \frac{G(s)}{1 - G(s) H(s)} \quad (\text{Positive Feedback})}$$
derive **Mason's Universal Gain Formula for Multiloop Networks**:
$$\mathbf{T(s) = \frac{\sum_{k=1}^N P_k \Delta_k}{\Delta}}$$
where:
1. **$P_k$:** Forward path gain of the $k$-th continuous path from input node to output node;
2. **$\Delta$ (Graph System Determinant):**
   $$\mathbf{\Delta = 1 - \sum L_1 + \sum L_2 - \sum L_3 + \dots}$$
   - $\sum L_1$: Sum of all individual closed feedback loop gains;
   - $\sum L_2$: Sum of gain products of all pairs of **non-touching (mutually isolated) loops**;
   - $\sum L_3$: Sum of gain products of all triplets of non-touching loops;
3. **$\Delta_k$ (Cofactor / Path Factor):** Value of $\Delta$ calculated for that portion of the graph that has **no nodes or branches touching the $k$-th forward path $P_k$** (if all loops touch $P_k$, $\Delta_k = 1.0$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Mason's Formula ($T = \frac{\sum P_k \Delta_k}{\Delta}$), Determinant ($\Delta = 1 - \sum L_1 + \sum L_2$) & Non-Touching Loops Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Calculate Closed-Loop Gain of a Multi-Loop SFG Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Signal Flow Graph Entity / Topological Feature & Technical Role in Mason's Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Two Feedback Loops in a Signal Flow Graph That Share Zero Common Nodes Are Classified as ___-Touching Loops (Non / Non-Touching) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Control Systems Problem: Applying Mason's Gain Formula to Find T(s) for a System with 2 Loops and 1 Non-Touching Path Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Mason's Gain Formula & Block Reduction (Ogata 2010; Mason 1953):
   - **Mason's Formula & Determinant Formulations:**
     $$\mathbf{T = \frac{\sum_{k=1}^N P_k \Delta_k}{\Delta} \quad \Big| \quad \mathbf{\Delta = 1 - \sum L_1 + \sum L_2 - \sum L_3 + \dots} \quad \Big| \quad \Delta_k = 1 - \sum L_{1,\text{non-touching } P_k}}$$
   - **Block Diagram vs SFG Equivalence Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Block Diagram Construct} & \textbf{Signal Flow Graph Equivalent} & \textbf{Mathematical Gain} \\
     \hline
     \mathbf{\text{Cascaded Series Blocks}} & \text{Serial directed branches} & G_{\text{eq}} = G_1 \cdot G_2 \\
     \mathbf{\text{Parallel Summed Blocks}} & \text{Parallel branches from same node} & G_{\text{eq}} = G_1 + G_2 \\
     \mathbf{\text{Negative Feedback Loop}} & \text{Closed loop with negative gain branch} & T = \frac{G}{1 + GH} \\
     \mathbf{\text{Multiloop Interconnection}} & \text{Complex SFG with overlapping loops} & \mathbf{T = \frac{\sum P_k \Delta_k}{\Delta} \ (\text{Mason's Rule})} \\
     \hline
     \end{array}$$
   - **The Non-Touching Loop Invariant:** Two feedback loops $L_1$ and $L_2$ are non-touching **if and only if they share NO common nodes and NO common branches** ($\sum L_2 = L_1 \cdot L_2$)!
2. **Slide 2 (`ordering`):** Provide 5 steps of Mason's Gain Formula execution: (1) trace all forward paths from input node $R$ to output node $C$ and calculate their gains $P_k$, (2) identify all individual closed feedback loops and calculate their gains $L_i$, (3) determine all combinations of two non-touching loops and calculate product sums $\sum L_2$, (4) compute graph determinant $\Delta = 1 - \sum L_1 + \sum L_2$ and path cofactors $\Delta_k$, (5) substitute into Mason's formula $T = \frac{\sum P_k \Delta_k}{\Delta}$ to obtain the exact closed-loop transfer function!
3. **Slide 3 (`matching`):** Pair 4 concepts (Forward Path $P_k$, Graph Determinant $\Delta$, Non-Touching Loops Product $\sum L_2$, Path Cofactor $\Delta_k$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Non (or Non-Touching). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Mason's Gain Formula: A control system has one forward path with gain $P_1 = G_1 G_2 G_3$. It has two feedback loops: $L_1 = -G_1 H_1$ and $L_2 = -G_3 H_2$. Loops $L_1$ and $L_2$ share **no common nodes** (non-touching). All loops touch the forward path $P_1$. What is the overall closed-loop transfer function $T(s) = C(s)/R(s)$? ($\sum L_1 = L_1 + L_2 = -G_1 H_1 - G_3 H_2$; Because $L_1$ and $L_2$ are non-touching: $\sum L_2 = L_1 L_2 = (-G_1 H_1)(-G_3 H_2) = G_1 G_3 H_1 H_2$; The graph determinant is $\Delta = 1 - \sum L_1 + \sum L_2 = 1 - (-G_1 H_1 - G_3 H_2) + G_1 G_3 H_1 H_2 = \mathbf{1 + G_1 H_1 + G_3 H_2 + G_1 G_3 H_1 H_2}$; Since $P_1$ touches both loops, $\Delta_1 = 1$; Therefore: $T(s) = \mathbf{\frac{G_1 G_2 G_3}{1 + G_1 H_1 + G_3 H_2 + G_1 G_3 H_1 H_2}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "block_diagram_reduction_and_masons_gain_formula_synthesis",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Mason's Gain Formula \\& Signal Flow Graphs (Samuel Mason 1953)**\n• **Universal Closed-Loop Transfer Function Formulation:**\n$$\n\\mathbf{T(s) = \\frac{C(s)}{R(s)} = \\frac{\\sum_{k=1}^N P_k \\Delta_k}{\\Delta}}\n$$\n• **The System Graph Determinant ($\\Delta$):**\n$$\n\\mathbf{\\Delta = 1 - \\sum L_1 + \\sum L_2 - \\sum L_3 + \\dots}\n$$\n  - **$\\sum L_1$:** Sum of all individual closed feedback loop gains;\n  - **$\\sum L_2$:** Sum of gain products of all pairs of **non-touching loops** (sharing zero common nodes);\n  - **$\\Delta_k$:** Path cofactor evaluating $\\Delta$ with all loops touching forward path $P_k$ eliminated!\n• **The Non-Touching Invariant:** If two feedback loops share even a single common node, their product $\\mathbf{L_1 L_2 = 0}$ in the non-touching summation term $\\sum L_2$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to solve for the overall closed-loop transfer function of a complex multiloop system using Mason's Gain Formula.",
      "orderItems": [
        "Identify and trace all distinct forward paths P_k connecting the input node R to the output node C and calculate their gains",
        "Identify all individual closed feedback loops in the system and calculate their individual loop gains L_i",
        "Identify all pairs of non-touching loops (loops that share zero common nodes) and compute their product sum \u2211 L2",
        "Evaluate the overall graph determinant: \u0394 = 1 - \u2211 L1 + \u2211 L2 - \u2211 L3 + ... and calculate path cofactors \u0394_k",
        "Substitute all path gains, cofactors, and \u0394 into Mason's formula: T(s) = (\u2211 P_k * \u0394_k) / \u0394"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Signal Flow Graph Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Forward Path Gain (Pk)", "right": "Product of continuous branch gains traversed from input node to output node without crossing any node twice" },
        { "left": "Graph Determinant (\u0394)", "right": "\u0394 = 1 - \u2211 L1 + \u2211 L2 - ..., mathematical characteristic polynomial capturing all internal feedback loops" },
        { "left": "Path Cofactor (\u0394k)", "right": "Evaluating the graph determinant \u0394 for the remaining subgraph that does not touch forward path Pk" },
        { "left": "Non-Touching Loops Product", "right": "\u2211 L2 = L1*L2, additive product term formed strictly by loops sharing zero common nodes" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Two feedback loops in a signal flow graph that share zero common nodes are classified as ___-touching loops.",
      "blankAnswer": "non",
      "blankDistractors": ["self", "cross", "dual"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A system has one forward path P1 = G1*G2*G3 and two feedback loops: L1 = -G1*H1 and L2 = -G3*H2. Loops L1 and L2 share NO common nodes (non-touching). All loops touch forward path P1. What is the closed-loop transfer function T(s) = C(s)/R(s)?",
      "options": [
        { "text": "T(s) = (G1*G2*G3) / (1 + G1*H1 + G3*H2 + G1*G3*H1*H2) (\u2211L1 = -G1*H1 - G3*H2; \u2211L2 = (-G1*H1)*(-G3*H2) = G1*G3*H1*H2; \u0394 = 1 - \u2211L1 + \u2211L2 = 1 + G1*H1 + G3*H2 + G1*G3*H1*H2; and \u03941 = 1)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Mason's Gain Formula (Katsuhiko Ogata *Modern Control Engineering* Chapter 3). 1. **Forward Path Identification:** - $P_1 = G_1 G_2 G_3$. 2. **Individual Loop Gains ($\sum L_1$):** - Loop 1: $L_1 = -G_1 H_1$. - Loop 2: $L_2 = -G_3 H_2$. - $$\\sum L_1 = L_1 + L_2 = -G_1 H_1 - G_3 H_2$$ 3. **Non-Touching Loop Pairs ($\sum L_2$):** - Since loops $L_1$ and $L_2$ share **zero common nodes**, they are non-touching: $$\\sum L_2 = L_1 \cdot L_2 = (-G_1 H_1) \cdot (-G_3 H_2) = \\mathbf{+G_1 G_3 H_1 H_2}$$ 4. **Calculate System Determinant ($\Delta$):** $$\\Delta = 1 - \\sum L_1 + \\sum L_2 = 1 - (-G_1 H_1 - G_3 H_2) + (G_1 G_3 H_1 H_2) = \\mathbf{1 + G_1 H_1 + G_3 H_2 + G_1 G_3 H_1 H_2}$$ 5. **Calculate Path Factor ($\Delta_1$):** - Since path $P_1$ touches both loops $L_1$ and $L_2$, removing touched loops leaves no remaining loops: $\\Delta_1 = 1.0$. 6. **Assemble Final Transfer Function:** $$T(s) = \\frac{P_1 \\Delta_1}{\\Delta} = \\mathbf{\\frac{G_1 G_2 G_3}{1 + G_1 H_1 + G_3 H_2 + G_1 G_3 H_1 H_2}}$$ Flawless Mason's Gain Formula synthesis!" },
        { "text": "T(s) = (G1*G2*G3) / (1 + G1*H1 + G3*H2) (Forgetting non-touching term \u2211L2)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "T(s) = (G1*G2*G3) / (1 - G1*H1 - G3*H2 + G1*G3*H1*H2)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "T(s) = (G1*G2*G3) / (1 + G1*G3*H1*H2)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
