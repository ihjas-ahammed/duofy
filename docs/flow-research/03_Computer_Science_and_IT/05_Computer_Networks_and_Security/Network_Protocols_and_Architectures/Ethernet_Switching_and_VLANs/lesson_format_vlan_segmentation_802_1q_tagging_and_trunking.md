# Duofy Reusable Lesson Format: VLAN Segmentation, 802.1Q Tagging, and Trunking

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Network_Protocols_and_Architectures / Ethernet_Switching_and_VLANs`  
**Lesson Format Type:** `vlan_segmentation_802_1q_tagging_and_trunking`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the logical broadcast isolation, trunk link multiplexing, and 4-byte header tagging mechanisms of Virtual Local Area Networks (VLANs) (IEEE 802.1Q Standard; Kurose & Ross *Computer Networking* Chapter 6.4.4; Tanenbaum & Wetherall Chapter 4.8.4): master **VLAN Segmentation** (partitioning a single physical switch into independent Layer 2 broadcast domains), distinguish **Access Ports (untagged single-VLAN connections to end-hosts)** from **Trunk Ports (tagged multi-VLAN links between switches)**, decode the **4-Byte IEEE 802.1Q Header Tag Format** (**TPID `0x8100` [2 bytes]**, **Priority Code Point PCP [3 bits]**, **Drop Eligible Indicator DEI [1 bit]**, and **12-bit VLAN Identifier VID [1 to 4094]**), evaluate the **Native VLAN** (untagged traffic on trunk links), and analyze VLAN hopping attack mitigations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | VLAN Architecture, Access vs Trunk Ports, & 4-Byte 802.1Q Tag Format Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Tagging and Forwarding Trajectory of a Frame Across a Trunk Link Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | 802.1Q Header Field / Port Type & Technical Specification Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Port Configuration Mode Used to Carry Traffic for Multiple VLANs Across a Single Physical Switch-to-Switch Link (Trunk) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why IEEE 802.1Q Uses a 12-Bit Field for VLAN Identifiers (Max 4094) Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State VLANs & 802.1Q (IEEE 802.1Q; Kurose & Ross 6.4.4):
   - **VLAN Concept:** Subdivides a physical switch into multiple isolated broadcast domains (VLAN 10 Sales, VLAN 20 Eng).
   - **Access Port vs Trunk Port:**
     - **Access Port:** Connects to end devices (PCs, printers); carries traffic for **1 VLAN only**; frames are **UNTAGGED**.
     - **Trunk Port:** Connects Switch to Switch; carries traffic for **multiple VLANs** simultaneously; inserts **802.1Q Tag**!
   - **The 4-Byte IEEE 802.1Q Tag Header Format:**
     $$\mathbf{\text{TPID (16 bits) } = \mathbf{\text{0x8100}} \quad | \quad \text{PCP (3 bits QoS)} \quad | \quad \text{DEI (1 bit)} \quad | \quad \mathbf{\text{VLAN ID (12 bits: } 1-4094)}}$$
   - **Native VLAN:** Untagged frames traversing a trunk port are automatically placed into the **Native VLAN (default VLAN 1)**.
2. **Slide 2 (`ordering`):** Provide 5 steps of PC1 in VLAN 10 sending frame to PC2 in VLAN 10 on a remote switch via trunk: (1) PC1 transmits untagged Ethernet frame into Switch 1 Access Port (configured for VLAN 10), (2) Switch 1 recognizes frame belongs to VLAN 10 and forwards toward remote switch via Trunk Port, (3) Switch 1 inserts 4-byte 802.1Q tag with VID=10 into the Ethernet header, (4) frame traverses physical trunk cable; Switch 2 receives tagged frame on its Trunk Port, (5) Switch 2 reads tag VID=10, strips the 4-byte 802.1Q tag, and delivers untagged frame out Access Port to PC2!
3. **Slide 3 (`matching`):** Pair 4 VLAN terms (Access Port, Trunk Port, 12-bit VLAN ID VID, Native VLAN) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of the trunk port term. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on 12-bit VID capacity: Why does the standard IEEE 802.1Q specification support a maximum of 4094 usable VLANs rather than millions of VLANs? (Because the 802.1Q tag allocates exactly **12 bits for the VLAN Identifier (VID) field**, yielding $2^{12} = 4096$ total values; values `0x000` (VID 0, priority tagging only) and `0xFFF` (VID 4095, reserved) are reserved, leaving **exactly 4094 usable VLAN IDs ($1 - 4094$)**; modern cloud data centers requiring millions of virtual networks adopt **VXLAN (Virtual Extensible LAN) which expands the VNI to 24 bits for 16 million network IDs**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "vlan_segmentation_802_1q_tagging_and_trunking",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: VLANs & IEEE 802.1Q Frame Tagging**\n• **VLAN Architecture (Kurose & Ross Chapter 6.4.4):**\nLogically partitions a physical switch into independent Layer 2 broadcast domains (e.g. VLAN 10 vs VLAN 20).\n• **Access vs Trunk Ports:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Port Mode} & \\textbf{Target Device} & \\textbf{Frame Tagging State} \\\\\n\\hline\n\\mathbf{\\text{Access Port}} & \\text{End-user host (PC, Server, Printer)} & \\mathbf{\\text{UNTAGGED (Standard Ethernet)}} \\\\\n\\mathbf{\\text{Trunk Port}} & \\mathbf{\\text{Switch-to-Switch / Switch-to-Router}} & \\mathbf{\\text{TAGGED with 4-Byte IEEE 802.1Q Header}} \\\\\n\\hline\n\\end{array}\n$$\n• **The 4-Byte IEEE 802.1Q Tag Anatomy:**\n$$\n\\mathbf{\\text{TPID (16 bits, 0x8100)} \\quad | \\quad \\text{PCP (3b QoS)} \\quad | \\quad \\text{DEI (1b)} \\quad | \\quad \\mathbf{\\text{VLAN ID (12 bits: } 1-4094)}}\n$$\n• **Native VLAN (Default 1):** Traffic sent untagged across an 802.1Q trunk link is mapped directly to the Native VLAN!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of an Ethernet frame traversing an 802.1Q Trunk link between two switches within VLAN 10.",
      "orderItems": [
        "Host 1 transmits a standard untagged Ethernet frame into Switch A on an Access Port assigned to VLAN 10",
        "Switch A inspects CAM table for VLAN 10, identifies destination MAC resides on remote Switch B across a Trunk Port",
        "Switch A inserts a 4-byte IEEE 802.1Q tag header containing TPID 0x8100 and VLAN ID = 10 into the frame",
        "The tagged Ethernet frame traverses the physical trunk cable and arrives at Switch B's Trunk Port",
        "Switch B reads VID = 10, strips the 4-byte 802.1Q tag header, and forwards the untagged frame out the destination Access Port"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each VLAN / 802.1Q Concept to its exact Technical Definition.",
      "matchPairs": [
        { "left": "Access Port", "right": "Port carrying traffic for a single dedicated VLAN, stripping all tags before delivering to end devices" },
        { "left": "Trunk Port", "right": "Multiplexed port interconnecting switches that encapsulates frames with 802.1Q tags for multiple VLANs" },
        { "left": "12-bit VLAN Identifier (VID)", "right": "Field in 802.1Q tag supporting up to 4094 unique virtual local area network broadcast domains" },
        { "left": "Native VLAN", "right": "Designated VLAN on a trunk link that transmits and receives frames without any 802.1Q tag attached" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A switch-to-switch link configured to carry traffic for multiple VLANs using 802.1Q encapsulation is a ___ port.",
      "blankAnswer": "trunk",
      "blankDistractors": ["access", "routed", "native"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the IEEE 802.1Q standard support a theoretical maximum of 4094 usable VLAN IDs (VID 1 to 4094), and how did modern cloud data centers overcome this scaling limit?",
      "options": [
        { "text": "The 802.1Q tag header allocates exactly 12 bits for the VLAN Identifier (VID) field, which yields 2^12 = 4096 total numeric values; because VID 0 (priority tagging only) and VID 4095 (reserved) are reserved by the standard, exactly 4094 usable VLAN IDs remain; modern multitenant cloud data centers (e.g. AWS, Azure) requiring millions of isolated virtual networks overcome this limit using VXLAN (Virtual Extensible LAN), which encapsulates Layer 2 frames in UDP with a 24-bit VNI supporting over 16 million virtual network segments", "isCorrect": true, "explanation": "Correct! This is a foundational constraint and evolution in local area network virtualization (IEEE 802.1Q Standard; RFC 7348 VXLAN; Kurose & Ross Chapter 6.4.4). 1. **The 802.1Q 12-Bit Boundary:** - In the 802.1Q tag header, the `VLAN ID (VID)` field is mathematically bounded to **12 bits**. - $2^{12} = 4096$ total numerical representations ($0$ to $4095$). - `VID = 0`: Reserved (indicates frame carries 802.1p priority but no VLAN ID). - `VID = 4095 (0xFFF)`: Reserved for system implementation. - Usable range: **VID 1 through VID 4094 (exactly 4094 VLANs)**. 2. **The Cloud Scale Challenge:** - In modern cloud hyperscalers, hosting tens of thousands of tenants (each requiring dozens of isolated virtual private clouds) quickly exhausts 4094 VLAN IDs. 3. **The VXLAN Solution (RFC 7348):** - Data centers adopted **VXLAN (Virtual Extensible LAN)**, which encapsulates Layer 2 Ethernet frames inside Layer 4 UDP packets across an IP underlay fabric. - VXLAN expands the 12-bit VID to a **24-bit VXLAN Network Identifier (VNI)**! - $2^{24} = \\mathbf{16,777,216\\text{ isolated virtual networks}}$, completely eliminating the 4094 VLAN scaling bottleneck." },
        { "text": "Because computer CPUs cannot count higher than 4094 in binary", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Ethernet cables melt if more than 4094 VLANs are configured", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because 802.1Q tags are only 1 byte long", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
