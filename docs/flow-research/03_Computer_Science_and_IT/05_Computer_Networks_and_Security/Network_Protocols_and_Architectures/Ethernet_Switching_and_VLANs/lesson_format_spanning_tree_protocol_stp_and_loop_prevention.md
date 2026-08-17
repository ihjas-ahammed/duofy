# Duofy Reusable Lesson Format: Spanning Tree Protocol (STP) and Loop Prevention

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Network_Protocols_and_Architectures / Ethernet_Switching_and_VLANs`  
**Lesson Format Type:** `spanning_tree_protocol_stp_and_loop_prevention`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the algorithmic loop-breaking proofs, bridge election mechanics, and port role state machines of the Spanning Tree Protocol (STP IEEE 802.1D / RSTP IEEE 802.1w) (Radia Perlman 1985, *An Algorithm for Distributed Computation of a Spanning Tree in an Extended LAN*, ACM SIGCOMM; Kurose & Ross *Computer Networking* Chapter 6.4; Tanenbaum & Wetherall Chapter 4.8): analyze why physical Layer 2 loops cause fatal **Broadcast Storms, Multiple Frame Copies, and CAM Table Instability** (since Layer 2 Ethernet headers lack a TTL field!), master the **4-Step Spanning Tree Algorithm** (**1. Root Bridge Election [Lowest Bridge ID $= \text{Priority (default 32768)} + \text{MAC}$]**, **2. Root Port (RP) Election [Lowest path cost to Root Bridge per non-root switch]**, **3. Designated Port (DP) Election [Lowest path cost to Root Bridge per network link]**, and **4. Alternate / Blocked Port Selection [All remaining ports placed in Blocking/Discarding mode]**), and evaluate RSTP convergence optimizations (Proposal/Agreement handshake).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Layer 2 Loop Disasters (No TTL), Radia Perlman STP Algorithm, & BID Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Port State Transition from Root Election to Converged Tree Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | STP Port Role / Frame Construct & Algorithmic Responsibility Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Special Control Frame Exchanged Between Switches Every 2 Seconds to Compute STP Topology (BPDU) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Selection of Root Bridge, Root Ports, and Blocked Ports on a 3-Switch Triangle Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State STP & Loop Prevention (Perlman 1985; IEEE 802.1D):
   - **The Layer 2 Loop Disaster:**
     - Layer 2 Ethernet frames **HAVE NO TTL (Time-To-Live) FIELD**!
     - In a physical switch loop, a single broadcast frame circulates infinitely in both directions, multiplying exponentially $\implies$ **Broadcast Storm + 100% CPU crash in seconds**!
   - **Radia Perlman's 4-Step STP Algorithm:**
     1. **Root Bridge:** Switch with the **Lowest Bridge ID (BID)**:
        $$\mathbf{\text{Bridge ID (BID)} = \text{Bridge Priority (default 32768)} \ + \ \text{Switch Base MAC Address}}$$
     2. **Root Port (RP):** On each non-root switch, the single port with the lowest Root Path Cost to the Root Bridge.
     3. **Designated Port (DP):** On each LAN link, the single port with the lowest cost to the Root Bridge (Always Forwarding!).
     4. **Blocking Port (AP):** All other redundant ports are set to **BLOCKING / DISCARDING**!
2. **Slide 2 (`ordering`):** Provide 5 steps of STP convergence on 3 switches: (1) switches power on and broadcast Configuration BPDUs claiming themselves as root bridge, (2) switches compare BIDs and elect Switch with lowest BID as the Root Bridge, (3) non-root switches identify their Root Port (RP) with the lowest path cost to the root bridge, (4) switches negotiate Designated Ports (DP) on each interconnecting link segment, (5) the remaining redundant port transitions to the BLOCKING state, breaking the loop and finalizing the active tree!
3. **Slide 3 (`matching`):** Pair 4 STP concepts (Root Bridge, Root Port, Designated Port, Blocking Port) with their roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that switches exchange BPDUs. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on electing Root Bridge and blocked ports on a triangle: Three switches (Switch A [Priority 32768, MAC 0000.AAAA.AAAA], Switch B [Priority 32768, MAC 0000.BBBB.BBBB], Switch C [Priority 4096, MAC 0000.CCCC.CCCC]) are connected in a full mesh triangle with equal 1Gbps link costs (cost = 4). Which switch is elected as the Root Bridge, and why? (Switch C has Priority 4096; because Bridge ID comparison evaluates **Priority first before MAC address**, Switch C has the lowest Bridge ID ($4096 < 32768$) and is **unanimously elected as the Root Bridge**; all ports on Switch C become Designated Ports in Forwarding state).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "spanning_tree_protocol_stp_and_loop_prevention",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Spanning Tree Protocol (Radia Perlman 1985 & IEEE 802.1D)**\n• **The Layer 2 Loop Hazard (Kurose & Ross Chapter 6.4):**\nEthernet frames have **NO TTL (Time-To-Live)**! A physical loop creates an infinite **Broadcast Storm** that crashes all network switches within seconds!\n• **The 4-Step Spanning Tree Algorithm:**\n$$\n\\mathbf{\\text{1. Elect Root Bridge (Lowest BID)}} \\ \\longrightarrow \\ \\mathbf{\\text{2. Elect Root Ports (Lowest Cost)}} \\ \\longrightarrow \\ \\mathbf{\\text{3. Elect Designated Ports}} \\ \\longrightarrow \\ \\mathbf{\\text{4. Block Redundant Ports}}\n$$\n• **Bridge ID (BID) Composition:**\n$$\n\\mathbf{\\text{Bridge ID (BID)} = \\mathbf{\\text{Priority (default 32768)}} \\ + \\ \\mathbf{\\text{Switch MAC Address}}}\n$$\n• **BPDUs (Bridge Protocol Data Units):** Control packets sent every 2 seconds to synchronize the loop-free spanning tree!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of Spanning Tree Protocol (STP) convergence across a network of interconnected switches.",
      "orderItems": [
        "All switches initialize, assume they are the root, and transmit BPDUs containing their Bridge ID (Priority + MAC)",
        "Switches compare BPDUs across the topology and elect the single switch with the lowest Bridge ID as the Root Bridge",
        "Each non-root switch identifies its single Root Port (RP) providing the lowest cumulative path cost to the Root Bridge",
        "Switches elect one Designated Port (DP) per LAN link segment to forward traffic toward the Root Bridge",
        "All remaining non-designated redundant ports transition into the BLOCKING state, eliminating all physical loops"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each STP Role / Protocol Element to its exact Functional Role.",
      "matchPairs": [
        { "left": "Root Bridge", "right": "The central master switch (lowest Bridge ID) serving as the reference point for the entire spanning tree" },
        { "left": "Root Port (RP)", "right": "The single port on a non-root switch with the lowest administrative path cost to reach the Root Bridge" },
        { "left": "Designated Port (DP)", "right": "The port on a physical link segment that advertises the lowest cost path to the Root Bridge (Always Forwarding)" },
        { "left": "Blocking Port (Alternate)", "right": "A disabled port that drops all user data frames to prevent circular switching loops in redundant topologies" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Switches exchange Spanning Tree control frames called Bridge Protocol Data Units, abbreviated as ___.",
      "blankAnswer": "BPDU",
      "blankDistractors": ["LSA", "ARP", "ICMP"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Three switches are connected in a redundant triangular loop: Switch A (Priority = 32768, MAC = 0000.AAAA.AAAA), Switch B (Priority = 32768, MAC = 0000.BBBB.BBBB), and Switch C (Priority = 4096, MAC = 0000.CCCC.CCCC). Which switch is elected as the Root Bridge, and why?",
      "options": [
        { "text": "Switch C is elected as the Root Bridge; STP elects the Root Bridge based on the lowest Bridge ID (BID); because the Bridge ID evaluates Priority before MAC address, Switch C's configured Priority of 4096 is strictly lower than Switch A and B's default Priority of 32768 (4096 < 32768), making Switch C the undisputed Root Bridge regardless of MAC address values", "isCorrect": true, "explanation": "Correct! This is the standard root bridge election rule in Spanning Tree Protocol (IEEE 802.1D / 802.1w; Kurose & Ross Section 6.4.3). 1. **Bridge ID (BID) Definition:** - $\\text{BID} = \\text{Priority (2 bytes)} + \\text{System ID Extension} + \\text{MAC Address (6 bytes)}$. 2. **Comparing the Candidates:** - Switch A: BID = `32768.0000.AAAA.AAAA` - Switch B: BID = `32768.0000.BBBB.BBBB` - Switch C: BID = `4096.0000.CCCC.CCCC` 3. **The Numerical Comparison:** - When switches compare BIDs in received BPDUs, they compare the Priority field first! - Since $4096 < 32768$, Switch C has the lowest numerical BID. - The MAC address is only evaluated as a tie-breaker if two switches have identical Priorities (e.g. between Switch A and B). 4. Therefore, **Switch C wins the election and becomes the Root Bridge** for the entire spanning tree domain!" },
        { "text": "Switch A, because its MAC address has the lowest alphabetical character 'A'", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Switch B, because it is located physically in the middle of the rack", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "None, because all three switches will enter an infinite broadcast storm", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
