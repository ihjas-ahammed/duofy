# Key to Flow: Combinational & Sequential Circuits (Adders, MUXes, Flip-Flops, & FSMs)

**Subject Area:** `03_Computer_Science_and_IT / 08_Computer_Architecture_and_Hardware / Digital_Logic_and_Circuit_Design / Combinational_and_Sequential_Circuits`

---

## 📌 Core Concept & Mental Model
**Stateless Memoryless Combinational Transforms (Full Adders, Carry Lookahead Adders CLA, MUX/DEMUX Multiplexing, Decoders), Clock-Synchronized State Elements (Latches vs Edge-Triggered D/JK/T Flip-Flops, Setup/Hold Timing Windows $t_{\text{setup}}, t_{\text{hold}}$, & Metastability), and Deterministic Sequential Automata (Mealy vs Moore Finite State Machines & Synchronous Counters)** govern digital processor execution units and control unit synthesis (M. Morris Mano & Michael D. Ciletti *Digital Design* 6th ed. Chapters 4 & 5; David Money Harris & Sarah L. Harris *Digital Design and Computer Architecture* 2nd ed. Chapters 2 & 3):
* **1. Combinational Arithmetic Circuits (Memoryless):**
  - **Half Adder:** $S = A \oplus B$, $C = AB$.
  - **Full Adder:** $S = A \oplus B \oplus C_{in}$, $C_{out} = AB + C_{in}(A \oplus B)$.
  - **Ripple Carry Adder (RCA):** Chained full adders where carry ripples sequentially; propagation delay is linearly bounded: $T_{\text{delay}} = O(N)$.
  - **Carry Lookahead Adder (CLA):** Computes carries in parallel using Generate ($G_i = A_i B_i$) and Propagate ($P_i = A_i \oplus B_i$) equations:
    $$C_{i+1} = G_i + P_i C_i \implies C_4 = G_3 + P_3 G_2 + P_3 P_2 G_1 + P_3 P_2 P_1 G_0 + P_3 P_2 P_1 P_0 C_0$$
    Reduces 32/64-bit addition latency to constant/logarithmic time $O(1) / O(\log N)$!
* **2. Routing & Selection Primitives:**
  - **Multiplexer (MUX $2^n \to 1$):** Select lines $S_{n-1}\dots S_0$ route 1 of $2^n$ data inputs to a single output. Universal logic generator (Any $n$-variable Boolean function can be implemented using a $2^{n-1} \to 1$ MUX!).
  - **Decoder ($n \to 2^n$):** Converts $n$-bit binary code into $2^n$ distinct active minterm lines.
  - **Priority Encoder ($2^n \to n$):** Encodes the highest-priority active input line into binary output code with valid bit $V$.
* **3. Sequential Logic & Flip-Flops:**
  - **Latches (Level-Sensitive):** Transparent when Enable is active (prone to race conditions).
  - **Flip-Flops (Edge-Triggered):** Samples input strictly on rising/falling clock transition edge.
  - **Characteristic Equations:**
    $$\mathbf{\text{D-FF: } Q_{n+1} = D} \qquad \mathbf{\text{JK-FF: } Q_{n+1} = J\overline{Q} + \overline{K}Q} \qquad \mathbf{\text{T-FF: } Q_{n+1} = T \oplus Q}$$
  - **Timing & Metastability:**
    - **Setup Time ($t_{\text{setup}}$):** Data input must be stable *before* the active clock edge.
    - **Hold Time ($t_{\text{hold}}$):** Data input must remain stable *after* the active clock edge.
    - *Violation:* Violating setup/hold times causes the flip-flop to enter a **Metastable State** (output oscillates or hovers between $0$ and $1$ for an indeterminate duration).
* **4. Finite State Machines (FSMs):**
  - **Mealy Machine:** Output is a function of **Present State AND Present Inputs** ($Y = \lambda(S, X)$). Reacts immediately in the current clock cycle; susceptible to asynchronous input glitches.
  - **Moore Machine:** Output is a function of **Present State ONLY** ($Y = \lambda(S)$). Glitch-free, synchronous, but updates output one clock cycle later.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Circuit Design Spectrum
* Stateless Transforms $\to$ Full Adder $\to$ Ripple Carry $O(N)$ vs Carry Lookahead $O(1)$.
* Data Routing $\to$ Multiplexers (Universal Generator) $\to$ Decoders $\to$ Priority Encoders.
* Memory Primitives $\to$ SR Latch $\to$ D/JK/T Edge-Triggered Flip-Flops.
* Clock Timing $\to$ $t_{\text{setup}} + t_{\text{hold}}$ window $\to$ Metastability elimination via multi-stage synchronizers.
* Control Units $\to$ Mealy (State + Input) vs Moore (State Only) State Diagrams.

### 2. Top Recommended Resources
* **The Definitive Textbook:** *Digital Design: With an Introduction to the Verilog HDL* (M. Morris Mano & Michael D. Ciletti, Pearson 6th ed.).
* **The Architecture Bridge:** *Digital Design and Computer Architecture* (David Money Harris & Sarah L. Harris, Morgan Kaufmann 2nd ed.).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you derive the Generate ($G_i$) and Propagate ($P_i$) expressions for a 4-bit Carry Lookahead Adder?
- [ ] Can you implement a 3-variable Boolean function using a single 4-to-1 Multiplexer?
- [ ] Can you contrast level-sensitive Latches with edge-triggered Flip-Flops?
- [ ] Can you calculate the maximum clock frequency $f_{\text{max}} = \frac{1}{t_{\text{cq}} + t_{\text{comb}} + t_{\text{setup}}}$?
- [ ] Can you design a sequence detector (e.g. '1011') as both a Mealy and a Moore FSM?
