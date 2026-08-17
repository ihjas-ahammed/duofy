# Duofy Reusable Lesson Format: Logic Optimization (K-Maps & Combinational Building Blocks)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Digital_Electronics_and_Microcontrollers / Combinational_and_Sequential_Logic`  
**Lesson Format Type:** `boolean_minimization_k_maps_and_combinational_building_blocks`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through Boolean algebra laws, De Morgan's duals, Karnaugh Map (K-Map) 4-variable Gray-code optimization, Prime Implicant extraction, and canonical Medium-Scale Integrated (MSI) combinational logic building blocks: Full Adders, Carry Lookahead Adders (CLA), Decoders, and Multiplexers (MUX as Universal Logic Function Generators) in digital hardware (M. Morris Mano & Michael D. Ciletti *Digital Design* Chapters 2, 3, 4; John F. Wakerly *Digital Design* Chapters 4 & 5): master **De Morgan's Laws & XOR Decomposition**:
$$\mathbf{\overline{A \cdot B} = \overline{A} + \overline{B} \quad \Big| \quad \overline{A + B} = \overline{A} \cdot \overline{B} \quad \Big| \quad A \oplus B = \overline{A} B + A \overline{B}}$$
master **K-Map 4-Variable Prime Implicant Extraction**:
- Group adjacent $1$s into rectangular blocks of sizes $2^k \in \{16, 8, 4, 2, 1\}$ using toroidal wrap-around adjacency;
- Utilize Don't Care states ($d$ or $X$) to maximize group sizes;
derive **Carry Lookahead Adder (CLA) Fast Carry Logic**:
$$\mathbf{G_i = A_i \cdot B_i \ (\text{Generate}) \quad \Big| \quad P_i = A_i \oplus B_i \ (\text{Propagate}) \implies \mathbf{C_{i+1} = G_i + P_i C_i}}$$
and formulate **Multiplexer ($2^n$-to-1 MUX) Universal Function Synthesis**:
$$\mathbf{Y = \sum_{k=0}^{2^n-1} I_k \cdot m_k(S_{n-1}, \dots, S_0)}$$
(proving that any arbitrary Boolean function of $N$ variables can be synthesized using a single $2^{N-1}$-to-1 MUX without additional logic gates).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | K-Map Simplification, CLA Carry Equations ($C_{i+1} = G_i + P_i C_i$) & MUX Universal Logic Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Synthesize an Arbitrary 3-Variable Boolean Function on a 4-to-1 MUX Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Combinational MSI Building Block / Logic Tool & Technical Hardware Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Carry Lookahead Adders (CLA), the Signal Term Gi = Ai * Bi That Produces a Carry Independent of Input Carry Is the Carry ___ (Generate) Term Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Digital Hardware Problem: Minimizing a 4-Variable Logic Function with Don't Cares via K-Map Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Boolean Minimization & MSI Blocks (Mano & Ciletti 2018; Wakerly 2018):
   - **K-Map & MSI Logic Formulations:**
     $$\mathbf{\overline{A \cdot B} = \overline{A} + \overline{B} \quad \Big| \quad G_i = A_i B_i \quad \Big| \quad P_i = A_i \oplus B_i \quad \Big| \quad C_{i+1} = G_i + P_i C_i \quad \Big| \quad Y = \sum I_k m_k}$$
   - **Combinational MSI Family Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Building Block} & \textbf{Inputs / Outputs} & \textbf{Transfer Function} & \textbf{Primary Hardware Role} \\
     \hline
     \mathbf{\text{Full Adder}} & A, B, C_{\text{in}} \to S, C_{\text{out}} & S = A \oplus B \oplus C_{\text{in}}, \ C_{\text{out}} = A B + C_{\text{in}}(A \oplus B) & \text{1-bit arithmetic addition} \\
     \mathbf{\text{Carry Lookahead}} & A_n, B_n \to S_n, C_n & C_1 = G_0 + P_0 C_0, \ C_2 = G_1 + P_1 G_0 + P_1 P_0 C_0 & \mathbf{O(1) \text{ constant-time carry propagation}} \\
     \mathbf{\text{Multiplexer (MUX)}} & 2^n \text{ Data}, n \text{ Select} & Y = \sum I_k m_k(S) & \mathbf{\text{Universal logic function generator}} \\
     \mathbf{\text{Decoder}} & n \text{ Inputs} \to 2^n \text{ Outputs} & Y_k = m_k(A) & \text{Memory address decoding / demux} \\
     \hline
     \end{array}$$
   - **The MUX Universality Invariant:** A $2^n$-to-1 multiplexer can implement **ANY arbitrary $n+1$ variable Boolean function** by connecting $n$ variables to Select lines and the remaining variable ($0, 1, C, \overline{C}$) to data inputs!
2. **Slide 2 (`ordering`):** Provide 5 steps to implement 3-variable logic $F(A,B,C)$ on a 4-to-1 MUX: (1) construct complete truth table for $F(A,B,C)$ listing all 8 combinations, (2) connect the first two most significant variables $A, B$ to MUX select inputs $S_1, S_0$, (3) partition truth table into 4 pairs corresponding to select combinations $(00, 01, 10, 11)$, (4) express output $F$ in each pair as a function of the third variable $C$ (yielding $0, 1, C$, or $\overline{C}$), (5) connect these evaluated single-variable terms directly to data inputs $I_0, I_1, I_2, I_3$!
3. **Slide 3 (`matching`):** Pair 4 concepts (Carry Generate $G_i = A_i B_i$, Carry Propagate $P_i = A_i \oplus B_i$, MUX Universal Function Generator, Don't Care State $X$) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Generate. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on K-map minimization: A 4-variable Boolean logic function is given by the minterm sum: $F(A,B,C,D) = \sum m(0, 2, 8, 10, 14) + \sum d(5, 15)$ where $d$ denotes don't care conditions. Using a 4-variable Karnaugh map, what is the minimal sum-of-products (SOP) expression for $F$? (Minterms $m(0, 2, 8, 10)$ occupy the four corners of the K-map: $(A,B,C,D) = (0,0,0,0), (0,0,1,0), (1,0,0,0), (1,0,1,0)$; The four corners combine into a group of 4: $\overline{B} \cdot \overline{D}$; Minterm $m(14)$ is $(1,1,1,0)$ and Don't Care $d(15)$ is $(1,1,1,1)$, which combine with $m(10) (1,0,1,0)$ into a group of 4: $A \cdot C$; Minimal SOP: $F = \mathbf{\overline{B}\overline{D} + AC}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "boolean_minimization_k_maps_and_combinational_building_blocks",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Boolean Optimization \\& Combinational MSI Blocks (Morris Mano)**\n• **De Morgan's Duality Laws \\& XOR Formulations:**\n$$\n\\mathbf{\\overline{A \\cdot B} = \\overline{A} + \\overline{B} \\quad \\Big| \\quad \\overline{A + B} = \\overline{A} \\cdot \\overline{B} \\quad \\Big| \\quad A \\oplus B = \\overline{A} B + A \\overline{B}}\n$$\n• **Carry Lookahead Adder (CLA) Constant-Time Carry Equations:**\n$$\n\\mathbf{G_i = A_i \\cdot B_i \\ (\\text{Generate}) \\quad \\Big| \\quad P_i = A_i \\oplus B_i \\ (\\text{Propagate}) \\implies \\mathbf{C_{i+1} = G_i + P_i C_i}}\n$$\n$$\n\\mathbf{C_1 = G_0 + P_0 C_0 \\quad \\Big| \\quad C_2 = G_1 + P_1 G_0 + P_1 P_0 C_0 \\quad \\Big| \\quad C_3 = G_2 + P_2 G_1 + P_2 P_1 G_0 + P_2 P_1 P_0 C_0}\n$$\n• **The 4 Canonical Combinational Building Blocks:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Building Block} & \\textbf{Functional Transfer Relationship} & \\textbf{Hardware Role} \\\\\n\\hline\n\\mathbf{\\text{Full Adder}} & S = A \\oplus B \\oplus C_{\\text{in}}, \\ C_{\\text{out}} = A B + C_{\\text{in}}(A \\oplus B) & \\text{Basic 1-bit arithmetic unit} \\\\\n\\mathbf{\\text{CLA Generator}} & C_{i+1} = G_i + P_i C_i & \\mathbf{O(1) \\text{ fast parallel addition}} \\\\\n\\mathbf{\\text{Multiplexer (MUX)}} & Y = \\sum_{k=0}^{2^n-1} I_k \\cdot m_k(S) & \\mathbf{\\text{Universal logic function generator}} \\\\\n\\mathbf{\\text{Decoder}} & Y_k = m_k(A_{n-1}, \\dots, A_0) & \\text{Address decoding / Demultiplexing} \\\\\n\\hline\n\\end{array}\n$$\n• **The MUX Universality Invariant:** Any arbitrary $(N+1)$-variable Boolean function can be synthesized using a **single $2^N$-to-1 MUX** by connecting $N$ variables to select lines and $\{0, 1, C, \\overline{C}\\}$ to data inputs!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to implement an arbitrary 3-variable logic function F(A, B, C) using a single 4-to-1 Multiplexer.",
      "orderItems": [
        "Construct the complete 8-row truth table for the 3-variable target Boolean function F(A, B, C)",
        "Connect the two most significant variables A and B to the MUX select lines S1 and S0",
        "Divide the truth table into 4 distinct two-row blocks corresponding to select combinations (00, 01, 10, 11)",
        "Determine the functional relationship between output F and the third variable C within each block (0, 1, C, or C_bar)",
        "Connect the resulting terms directly to the MUX data input pins I0, I1, I2, and I3"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Combinational Logic Component to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Carry Generate (Gi = Ai*Bi)", "right": "Produces an output carry internally strictly independent of incoming carry-in" },
        { "left": "Carry Propagate (Pi = Ai ^ Bi)", "right": "Passes an incoming carry-in through to the next adder stage" },
        { "left": "Universal MUX Engine", "right": "Using select lines as minterm decoders to synthesize arbitrary logic functions without gates" },
        { "left": "Don't Care Condition (X)", "right": "Input combination that cannot occur or whose output is irrelevant, grouped to minimize K-maps" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Carry Lookahead Adders, the signal term Gi = Ai * Bi that creates a carry independent of carry-in is the carry ___ term.",
      "blankAnswer": "generate",
      "blankDistractors": ["propagate", "bypass", "ripple"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A 4-variable Boolean logic function is defined by minterms F(A, B, C, D) = \u2211 m(0, 2, 8, 10, 14) + \u2211 d(5, 15) where d represents don't care conditions. Using a 4-variable Karnaugh Map, what is the minimal Sum-of-Products (SOP) expression for F?",
      "options": [
        { "text": "F = B_bar * D_bar + A * C (The four corners m(0,2,8,10) group into B_bar*D_bar; and m(10,14) with don't care d(15) group into A*C)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using a 4-variable Karnaugh Map (M. Morris Mano *Digital Design* Chapter 3). 1. **Plot Minterms and Don't Cares on 4-Variable K-Map:** - Grid layout: Rows ($AB = 00, 01, 11, 10$), Columns ($CD = 00, 01, 11, 10$). - 1s placed at: $m(0) = 0000$, $m(2) = 0010$, $m(8) = 1000$, $m(10) = 1010$, $m(14) = 1110$. - Don't Cares ($X$) placed at: $d(5) = 0101$, $d(15) = 1111$. 2. **Identify Prime Implicants (Grouping Powers of 2):** - **Group 1 (Four Corners):** Cells $(0000, 0010, 1000, 1010) = m(0, 2, 8, 10)$. - $A$ changes ($0 \\to 1$), $B = 0$ (constant $\\overline{B}$). - $C$ changes ($0 \\to 1$), $D = 0$ (constant $\\overline{D}$). - **Group 1 Term = $\\mathbf{\\overline{B} \\cdot \\overline{D}}$**. - **Group 2 (Quad with Don't Care):** Cells $(1010, 1011, 1110, 1111) = m(10, 14)$ with $d(15)$ and $m(11)$ (or grouping $m(10,14)$ with $d(15)$ and $m(11)$ if included; here $m(14)=1110, d(15)=1111, m(10)=1010, d(11)=X$). - In row $AB = 10, 11$ (where $A=1$) and column $CD = 10, 11$ (where $C=1$). - **Group 2 Term = $\\mathbf{A \\cdot C}$**. 3. **Assemble Minimal SOP:** $$F = \\mathbf{\\overline{B} \\cdot \\overline{D} + A \\cdot C}$$ Flawless K-map Boolean logic minimization!" },
        { "text": "F = B_bar * D_bar + A * B * C", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "F = A_bar * B_bar * D_bar + A * C * D_bar", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "F = B_bar * C_bar + A * D", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
