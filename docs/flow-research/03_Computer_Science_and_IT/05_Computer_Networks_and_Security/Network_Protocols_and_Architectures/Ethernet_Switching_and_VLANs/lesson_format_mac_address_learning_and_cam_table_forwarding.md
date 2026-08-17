# Duofy Reusable Lesson Format: MAC Address Learning and CAM Table Forwarding

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Network_Protocols_and_Architectures / Ethernet_Switching_and_VLANs`  
**Lesson Format Type:** `mac_address_learning_and_cam_table_forwarding`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the frame inspection mechanics, Content Addressable Memory (CAM) table populating rules, and Layer 2 frame forwarding decisions in Ethernet switches (Robert Metcalfe 1973; IEEE 802.3; Kurose & Ross *Computer Networking* Chapter 6.4; Tanenbaum & Wetherall Chapter 4.8): master the **4 Fundamental Switch Forwarding Decisions** (**Learning [inspect Source MAC on ingress port]**, **Forwarding [lookup Destination MAC in CAM table and send out specific egress port]**, **Filtering [drop frame if Destination MAC is on same ingress port]**, and **Flooding [broadcast out all other ports if Destination MAC is unknown unicast or `FF:FF:FF:FF:FF:FF`]**), contrast **Collision Domains (isolated per switch port)** with **Broadcast Domains (shared across entire switch/VLAN)**, evaluate CAM table aging timers and MAC flooding attack mitigations (Port Security).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Switch Ingress Processing Pipeline, CAM Table Structure, & Collision/Broadcast Domains Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Evolution of a Switch CAM Table from Cold Boot to Forwarding Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Switch Action / Domain Type & Operational Behavior Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Switch Action That Forwards an Unknown Unicast Frame Out All Ports Except the Ingress Port (Flooding) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of What Happens When Host A Sends a Frame to Host B on an Empty CAM Table Switch Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State MAC Learning & CAM (IEEE 802.3; Kurose & Ross 6.4):
   - **The 4 Fundamental Switch Actions:**
     1. **Learning:** Inspects **Source MAC** $\to$ Maps `(Source MAC, Ingress Port, Aging Timer)` in CAM table.
     2. **Forwarding:** Inspects **Destination MAC** $\to$ If found in CAM on Port $Y$ ($Y \ne X$), transmit out Port $Y$ only.
     3. **Filtering:** If Destination MAC is on the *same* ingress port $X$, drop frame.
     4. **Flooding:** If Destination MAC is **Unknown Unicast** or **Broadcast (`FF:FF:FF:FF:FF:FF`)**, forward out **ALL ports except ingress port $X$**!
   - **Collision vs Broadcast Domains:**
     - Hub: 1 Collision Domain, 1 Broadcast Domain.
     - Switch: **Separate Collision Domain per physical port**, 1 Broadcast Domain (per VLAN).
     - Router: Separate Collision Domains AND **Separate Broadcast Domains per interface**.
2. **Slide 2 (`ordering`):** Provide 5 steps of a switch processing frame from Host A (Port 1) to Host B (Port 2) with empty CAM table: (1) Host A transmits frame with Src MAC=A and Dst MAC=B into Switch Port 1, (2) Switch learns mapping: writes (MAC=A, Port=1) into CAM table, (3) Switch searches CAM table for Dst MAC=B; finds no entry (Unknown Unicast), (4) Switch floods frame out Port 2, Port 3, and Port 4 (all ports except Port 1), (5) Host B receives frame on Port 2 and transmits reply to A; switch learns (MAC=B, Port=2) and forwards reply directly out Port 1 with zero flooding!
3. **Slide 3 (`matching`):** Pair 4 switching terms (CAM Table, Frame Flooding, Collision Domain, Broadcast Domain) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that unknown unicast frames trigger flooding. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on CAM table learning: When Host A sends an Ethernet frame to Host B through a brand new unpopulated Ethernet switch, which host's MAC address is learned by the switch upon arrival of this initial frame? (The switch **learns Host A's MAC address (the Source MAC) and maps it to Port 1**; the switch does NOT learn Host B's MAC address yet because Host B has not transmitted any frames; the switch then **floods the frame out all other ports** to locate Host B).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "mac_address_learning_and_cam_table_forwarding",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Layer 2 Switch Operations (IEEE 802.3)**\n• **The 4 Cardinal Switch Forwarding Rules (Kurose & Ross Chapter 6.4):**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Action} & \\textbf{Examined Header} & \\textbf{Operational Mechanism} \\\\\n\\hline\n\\mathbf{\\text{Learning}} & \\mathbf{\\text{Source MAC}} & \\mathbf{\\text{Records } (\\text{Source MAC}, \\text{ Ingress Port}) \\text{ into CAM table}} \\\\\n\\mathbf{\\text{Forwarding}} & \\mathbf{\\text{Destination MAC}} & \\text{Sends frame out specific mapped egress port if found in CAM} \\\\\n\\mathbf{\\text{Filtering}} & \\text{Destination MAC} & \\text{Drops frame if destination is located on the same ingress port} \\\\\n\\mathbf{\\text{Flooding}} & \\text{Destination MAC} & \\mathbf{\\text{Broadcasts frame out ALL ports except ingress port if unknown!}} \\\\\n\\hline\n\\end{array}\n$$\n• **Domain Hierarchy:**\n  - **Collision Domain:** Micro-segmented to **1 per switch port** (Full-Duplex eliminates collisions!).\n  - **Broadcast Domain:** Spans all ports on the physical switch (isolated only via VLANs or Routers)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of an Ethernet switch learning MAC addresses and transitioning from flooding to unicast forwarding.",
      "orderItems": [
        "Host A (Port 1) transmits an Ethernet frame destined for Host B (Port 2) into a freshly booted switch with an empty CAM table",
        "Switch inspects Source MAC of incoming frame and records mapping (MAC_A -> Port 1) into its CAM table",
        "Switch checks CAM table for Destination MAC_B; encountering an unknown unicast address, it floods the frame out Ports 2, 3, and 4",
        "Host B receives the frame on Port 2 and transmits an ARP/data reply frame with Source MAC_B and Destination MAC_A",
        "Switch inspects reply: learns (MAC_B -> Port 2), looks up MAC_A in CAM, and forwards directly out Port 1 with zero flooding"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Ethernet Switching Concept to its exact Operational Definition.",
      "matchPairs": [
        { "left": "CAM Table (MAC Table)", "right": "High-speed hardware memory table mapping physical MAC addresses to local switch ports" },
        { "left": "Frame Flooding", "right": "Replication of an unknown unicast or broadcast frame out every active port except the ingress port" },
        { "left": "Collision Domain", "right": "Physical network segment where simultaneously transmitted frames collide (isolated per switch port)" },
        { "left": "Broadcast Domain", "right": "Logical boundary in which a Layer 2 broadcast frame (FF:FF:FF:FF:FF:FF) is forwarded to all devices" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "When a switch receives a frame with an unknown destination MAC address, it performs ___ (sending out all ports except the arrival port).",
      "blankAnswer": "flooding",
      "blankDistractors": ["filtering", "blocking", "dropping"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A freshly powered-on Ethernet switch with an empty CAM table receives an Ethernet frame on Port 1 sent by Host A (MAC: AA:AA:AA:AA:AA:AA) destined for Host B (MAC: BB:BB:BB:BB:BB:BB). Which host's MAC address is learned by the switch upon processing this initial incoming frame?",
      "options": [
        { "text": "The switch learns Host A's MAC address (the Source MAC) and maps AA:AA:AA:AA:AA:AA to Port 1 in its CAM table; it does not learn Host B's MAC address because Host B has not transmitted any frames yet; the switch then floods the frame out all other ports (Ports 2, 3, 4) to locate Host B", "isCorrect": true, "explanation": "Correct! This is the core logic of transparent bridging in Ethernet switches (Kurose & Ross Section 6.4.3). 1. **Rule of Switch Learning:** - Switches learn mappings **EXCLUSIVELY from the SOURCE MAC address** of incoming frames! - A switch NEVER learns a port mapping from a destination MAC address. 2. **Tracing the Initial Frame:** - Ingress Port: Port 1. - Frame Header: `Src MAC = AA:AA:AA:AA:AA:AA`, `Dst MAC = BB:BB:BB:BB:BB:BB`. - Step 1 (Learning): The switch looks at `Src MAC` $\\implies$ inserts entry: `AA:AA:AA:AA:AA:AA -> Port 1`. - Step 2 (Forwarding Lookup): The switch looks up `Dst MAC (BB:BB:BB:BB:BB:BB)` in the CAM table $\implies$ Entry not found! - Step 3 (Action): The switch floods the frame out all other ports (Ports 2, 3, 4). 3. Host B's MAC address will only be learned later when Host B transmits a reply frame back to Host A." },
        { "text": "The switch learns Host B's MAC address and maps it to Port 1", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The switch learns both Host A and Host B's MAC addresses simultaneously", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The switch drops the frame because its CAM table is empty", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
