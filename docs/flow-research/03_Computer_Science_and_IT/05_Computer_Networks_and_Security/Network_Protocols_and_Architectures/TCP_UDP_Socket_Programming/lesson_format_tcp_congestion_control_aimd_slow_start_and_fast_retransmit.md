# Duofy Reusable Lesson Format: TCP Congestion Control (AIMD, Slow Start, and Fast Retransmit)

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Network_Protocols_and_Architectures / TCP_UDP_Socket_Programming`  
**Lesson Format Type:** `tcp_congestion_control_aimd_slow_start_and_fast_retransmit`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mathematical dynamics, window size evolutions, and loss recovery algorithms of TCP Congestion Control (Van Jacobson & Michael J. Karels 1988, *Congestion Avoidance and Control*, SIGCOMM; RFC 5681 TCP Reno; Kurose & Ross Chapter 3.6–3.7; Tanenbaum & Wetherall Chapter 6.5): master the **4 Congestion Control Phases** (**Slow Start [exponential growth: $\text{cwnd} \leftarrow \text{cwnd} + 1\text{ MSS}$ per ACK, doubling every RTT]**, **Congestion Avoidance / AIMD [linear growth: $\text{cwnd} \leftarrow \text{cwnd} + 1\text{ MSS}$ per RTT]**, **Fast Retransmit [triggered by 3 Duplicate ACKs to retransmit missing segment without waiting for RTO timer]**, and **Fast Recovery [sets $\text{ssthresh} \leftarrow \frac{\text{cwnd}}{2}$ and maintains $\text{cwnd} \leftarrow \text{ssthresh} + 3\text{ MSS}$]**), decode the **Additive Increase / Multiplicative Decrease (AIMD) Sawtooth Wave**, and compare TCP Tahoe (drops to 1 MSS on all loss) with TCP Reno and TCP CUBIC.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The AIMD Sawtooth Dynamics, Slow Start, cwnd Formula & State Transitions Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Trajectory of cwnd Evolution from Slow Start to Fast Recovery Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Congestion Control Phase / Loss Event & Window Adjustment Rule Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Number of Duplicate ACKs Required to Trigger TCP Fast Retransmit (3) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why AIMD is Mathematically Proven to Converge to Fair and Efficient Bandwidth Sharing Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State TCP Congestion Control (Jacobson 1988; RFC 5681; Kurose & Ross 3.6–3.7):
   - **The 4 Core Control Mechanisms:**
     1. **Slow Start ($\text{cwnd} < \text{ssthresh}$):**
        $$\mathbf{\text{cwnd} \leftarrow \text{cwnd} + 1\text{ MSS (per ACK)} \implies \text{Doubles every RTT! (Exponential Growth)}}$$
     2. **Congestion Avoidance / AIMD ($\text{cwnd} \ge \text{ssthresh}$):**
        $$\mathbf{\text{cwnd} \leftarrow \text{cwnd} + \frac{1}{\text{cwnd}} \text{ MSS (per ACK)} \implies \text{Increases by } 1\text{ MSS per RTT (Additive Increase)}}$$
     3. **Loss Event Handling:**
        - **Timeout (Severe Congestion):** $\text{ssthresh} \leftarrow \frac{\text{cwnd}}{2}, \ \mathbf{\text{cwnd} \leftarrow 1\text{ MSS}}$ (Enter Slow Start).
        - **3 Duplicate ACKs (Mild Congestion / Triple-Dup):**
          - **Fast Retransmit:** Resend missing packet immediately!
          - **Fast Recovery (TCP Reno):** $\text{ssthresh} \leftarrow \frac{\text{cwnd}}{2}, \ \mathbf{\text{cwnd} \leftarrow \text{ssthresh} + 3\text{ MSS}}$ (Skips slow start!).
2. **Slide 2 (`ordering`):** Provide 5 steps of cwnd evolving with ssthresh=16 MSS: (1) connection starts in Slow Start with cwnd=1 MSS, doubling every RTT (1 -> 2 -> 4 -> 8 -> 16), (2) cwnd reaches ssthresh=16 MSS and transitions to Congestion Avoidance, (3) cwnd increases linearly by +1 MSS per RTT (16 -> 17 -> 18 -> ... -> 24 MSS), (4) packet loss occurs at cwnd=24 MSS; receiver generates 3 Duplicate ACKs, (5) TCP Reno triggers Fast Retransmit (resends missing segment) and Fast Recovery setting ssthresh=12 and cwnd=15 MSS (bypassing slow start)!
3. **Slide 3 (`matching`):** Pair 4 mechanisms (Slow Start, Congestion Avoidance, Fast Retransmit, Retransmission Timeout RTO) with their window updates.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that 3 duplicate ACKs trigger fast retransmit. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why AIMD converges to fairness: Why did Chiu and Jain (1989) mathematically prove that Additive Increase / Multiplicative Decrease (AIMD) is the ONLY linear control algorithm that converges to both maximum network efficiency and fair bandwidth sharing among competing flows? (In Chiu & Jain's 2-user phase plot, **Additive Increase (AI) moves the operating point along a $45^\circ$ line toward efficiency without changing the difference between users**, while **Multiplicative Decrease (MD) reduces both flows proportionally, driving the trajectory toward the $y = x$ line of perfect fairness**; alternative combinations like MIMD or AIAD diverge or oscillate unfairly).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "tcp_congestion_control_aimd_slow_start_and_fast_retransmit",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: TCP Congestion Control & AIMD (Van Jacobson 1988)**\n• **The 4 Congestion Control Phases (Kurose & Ross Chapter 3.7):**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Phase} & \\textbf{Trigger Condition} & \\textbf{Window Adjustment Formula} \\\\\n\\hline\n\\mathbf{\\text{Slow Start}} & \\text{cwnd} < \\text{ssthresh} & \\mathbf{\\text{cwnd} \\leftarrow \\text{cwnd} + 1\\text{ MSS per ACK (Doubles each RTT)}} \\\\\n\\mathbf{\\text{AIMD}} & \\text{cwnd} \\ge \\text{ssthresh} & \\mathbf{\\text{cwnd} \\leftarrow \\text{cwnd} + 1\\text{ MSS per RTT (Linear Growth)}} \\\\\n\\mathbf{\\text{3 Duplicate ACKs}} & \\text{Mild Packet Loss} & \\mathbf{\\text{ssthresh} = \\frac{\\text{cwnd}}{2}, \\ \\text{cwnd} = \\text{ssthresh} + 3 \\text{ (Fast Recovery)}} \\\\\n\\mathbf{\\text{RTO Timeout}} & \\text{Severe Congestion} & \\mathbf{\\text{ssthresh} = \\frac{\\text{cwnd}}{2}, \\ \\text{cwnd} = 1\\text{ MSS (Drop to Slow Start)}} \\\\\n\\hline\n\\end{array}\n$$\n• **AIMD Sawtooth Wave:** Additive Increase slowly probes for bandwidth; Multiplicative Decrease cuts rate in half on loss!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential phases of TCP Reno Congestion Window (cwnd) evolution with initial ssthresh = 16 MSS.",
      "orderItems": [
        "Initialize connection in Slow Start: cwnd starts at 1 MSS and doubles exponentially each RTT (1 -> 2 -> 4 -> 8 -> 16)",
        "Reach ssthresh threshold at cwnd = 16 MSS and transition into Congestion Avoidance mode",
        "Perform Additive Increase: grow cwnd linearly by exactly +1 MSS per Round Trip Time (16 -> 17 -> 18 -> ... -> 24 MSS)",
        "Detect packet loss at cwnd = 24 MSS via receipt of 3 Duplicate ACKs from destination receiver",
        "Trigger Fast Retransmit of missing packet and enter Fast Recovery (TCP Reno): set ssthresh = 12 and cwnd = 15 MSS"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each TCP Congestion Control Concept to its exact mathematical behavior.",
      "matchPairs": [
        { "left": "Slow Start Phase", "right": "Exponential window growth doubling cwnd every round-trip time until reaching ssthresh" },
        { "left": "Additive Increase (AI)", "right": "Linear probing adding exactly 1 MSS to the congestion window for each full RTT" },
        { "left": "Multiplicative Decrease (MD)", "right": "Cuts ssthresh and window in half upon detecting packet loss to rapidly relieve buffer queues" },
        { "left": "Fast Retransmit", "right": "Immediately retransmits a lost segment upon receiving 3 duplicate ACKs without waiting for RTO timeout" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In TCP congestion control, receiving exactly ___ duplicate ACKs triggers the Fast Retransmit algorithm.",
      "blankAnswer": "3",
      "blankDistractors": ["1", "2", "5"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why did Dah-Ming Chiu and Raj Jain (1989) mathematically prove that Additive Increase / Multiplicative Decrease (AIMD) is the ONLY linear congestion control algorithm that converges to both maximum network efficiency and fair bandwidth sharing among competing flows?",
      "options": [
        { "text": "In the Chiu-Jain 2-user phase-space vector model, Additive Increase moves the operating point along a 45-degree trajectory parallel to the line of equal allocation (maintaining the absolute difference between flows while probing for bandwidth), whereas Multiplicative Decrease pulls the operating point along a ray directly toward the origin (proportionally reducing the larger flow by a greater absolute amount), iteratively forcing the trajectory to converge toward the y = x line of perfect fairness and the efficiency boundary", "isCorrect": true, "explanation": "Correct! This is the legendary mathematical foundation of internet stability formulated by Chiu & Jain in 1989 and implemented by Van Jacobson in TCP (Kurose & Ross Section 3.7; Dah-Ming Chiu & Raj Jain *Analysis of the Increase and Decrease Algorithms for Congestion Avoidance in Computer Networks*). 1. **The 2-Flow Phase Space:** - Imagine two competing TCP flows $x_1$ and $x_2$ sharing a bottleneck link of capacity $C$. - The goal is to reach the **Optimal Point** where $x_1 + x_2 = C$ (Full Efficiency) AND $x_1 = x_2$ (Equal Fairness). 2. **Evaluating Increase/Decrease Strategies:** - **Additive Increase ($x_i \\leftarrow x_i + a$):** Both flows add identical bandwidth $a$. The trajectory moves at a $45^\\circ$ angle parallel to the fairness line ($x_1 = x_2$). The absolute difference $|x_1 - x_2|$ remains unchanged! - **Multiplicative Decrease ($x_i \\leftarrow x_i \\cdot b$ where $b < 1$):** Both flows multiply their rate by $b$ (e.g. $0.5$). If User 1 had 40Mbps and User 2 had 20Mbps, User 1 drops by 20Mbps while User 2 drops by only 10Mbps! The absolute difference shrinks from 20Mbps down to 10Mbps! 3. **The Convergence Sawtooth:** - AI drives the flows up to the capacity boundary. - MD pulls the flows toward the $y = x$ fairness line. - Repeating this cycle forces competing connections to converge to fair and efficient bandwidth sharing regardless of their starting speeds!" },
        { "text": "Because AIMD was the only algorithm approved by the United States Congress", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Multiplicative Increase Multiplicative Decrease (MIMD) is faster for downloading HTML", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because AIMD eliminates the need for IP routing tables", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
