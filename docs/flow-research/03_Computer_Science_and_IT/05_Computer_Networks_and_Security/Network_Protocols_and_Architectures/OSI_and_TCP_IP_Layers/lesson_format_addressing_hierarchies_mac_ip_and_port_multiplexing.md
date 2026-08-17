# Duofy Reusable Lesson Format: Addressing Hierarchies (MAC, IP, and Port Multiplexing)

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Network_Protocols_and_Architectures / OSI_and_TCP_IP_Layers`  
**Lesson Format Type:** `addressing_hierarchies_mac_ip_and_port_multiplexing`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the 3 distinct addressing domains, operational scopes, and socket multiplexing primitives in computer networks (IEEE 802.3; IETF RFC 791 / RFC 8200; IANA Port Numbering; Kurose & Ross Chapter 3.2; Tanenbaum & Wetherall Chapter 5.1): master the **Triple-Tier Addressing Hierarchy** (**Layer 2: 48-bit MAC Address [Physical / Local Link / Node-to-Node / OUI + NIC Identifier]**, **Layer 3: 32-bit IPv4 / 128-bit IPv6 Address [Logical / Global Network / Host-to-Host]**, and **Layer 4: 16-bit Port Number [Process-to-Process Socket Demultiplexing]**), decode **Port Number Ranges** (**Well-Known Ports $0-1023$**, **Registered Ports $1024-49151$**, and **Dynamic/Ephemeral Ports $49152-65535$**), formulate the **Socket 5-Tuple Connection Identifier** ($\mathbf{\{\text{Source IP}, \text{Source Port}, \text{Dest IP}, \text{Dest Port}, \text{Protocol}\}}$), and evaluate the mapping between physical and logical layers via ARP/NDP.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Addressing Hierarchy Master Table (MAC vs IP vs Port), 5-Tuple Socket Invariant Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Socket Demultiplexing Sequence on an Inbound Web Server Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Addressing Tier / Port Range & Networking Scope Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the 16-Bit Layer 4 Identifier Used to Demultiplex Packets to a Specific OS Process (Port) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why Both MAC Addresses and IP Addresses Are Necessary Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Addressing Hierarchies (Kurose & Ross 3.2; Tanenbaum 5.1):
   - **The 3 Addressing Tiers:**
     $$\begin{array}{|c|l|l|l|l|}
     \hline
     \textbf{Layer} & \textbf{Address Type} & \textbf{Size / Format} & \textbf{Addressing Scope} & \textbf{Operational Domain} \\
     \hline
     \mathbf{L2} & \mathbf{\text{MAC Address}} & \text{48-bit (6 Hex bytes: 00:1A:2B:3C:4D:5E)} & \mathbf{\text{Node-to-Node}} & \text{Local Broadcast Domain / Switch} \\
     \mathbf{L3} & \mathbf{\text{IP Address}} & \text{32-bit (IPv4) / 128-bit (IPv6)} & \mathbf{\text{Host-to-Host}} & \text{Global Internet Routing / Routers} \\
     \mathbf{L4} & \mathbf{\text{Port Number}} & \text{16-bit integer (0 to 65,535)} & \mathbf{\text{Process-to-Process}} & \text{OS Socket Multiplexing} \\
     \hline
     \end{array}$$
   - **Port Ranges (IANA):**
     - Well-Known ($0 - 1023$): HTTP (80), HTTPS (443), SSH (22), DNS (53).
     - Registered ($1024 - 49151$): MySQL (3306), Redis (6379), Postgres (5432).
     - Ephemeral / Dynamic ($49152 - 65535$): Temporary client-side source ports.
   - **The Socket 5-Tuple:** $(\text{Src IP}, \text{Src Port}, \text{Dst IP}, \text{Dst Port}, \text{Protocol})$.
2. **Slide 2 (`ordering`):** Provide 5 steps of socket demultiplexing on receiving host: (1) NIC receives electrical bits, frames them, and verifies Layer 2 MAC address matches its NIC, (2) NIC strips Ethernet header and passes packet to Layer 3 IPv4 subsystem in OS kernel, (3) IP layer verifies destination IP matches host IP, strips IP header, and passes segment to Layer 4 TCP subsystem, (4) TCP inspects destination port (e.g. port 443) and matches the connection against the active 5-tuple socket table, (5) OS kernel unblocks and delivers the application payload directly to the Nginx web server process queue!
3. **Slide 3 (`matching`):** Pair 4 addressing concepts (48-bit MAC Address, 32-bit IPv4 Address, Well-Known Ports 0-1023, Socket 5-Tuple) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Layer 4 uses a port number. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why both MAC and IP addresses are necessary: Why does the internet require BOTH Layer 2 MAC addresses (physical/hardware) AND Layer 3 IP addresses (logical/hierarchical) instead of routing globally using MAC addresses alone? (Because **MAC addresses are flat (non-hierarchical)** burned into physical NIC hardware by different manufacturers with zero geographic or topological organization; if global routers routed on MAC addresses, **every router on Earth would need a routing table containing billions of individual MAC entries (catastrophic BGP table explosion)**; **IP addresses are hierarchical (network prefix + host ID)**, allowing routers to aggregate millions of individual hosts into a single CIDR prefix route e.g. `198.51.100.0/24`).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "addressing_hierarchies_mac_ip_and_port_multiplexing",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Triple-Tier Addressing & Multiplexing**\n• **The 3 Addressing Tiers (Kurose & Ross Chapter 3.2):**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Layer} & \\textbf{Address Identifier} & \\textbf{Addressing Scope} & \\textbf{System Purpose} \\\\\n\\hline\n\\mathbf{\\text{L2 (Link)}} & \\mathbf{\\text{48-bit MAC Address}} & \\mathbf{\\text{Node-to-Node}} & \\text{Identifies physical NIC on local broadcast segment} \\\\\n\\mathbf{\\text{L3 (Network)}} & \\mathbf{\\text{32-bit / 128-bit IP}} & \\mathbf{\\text{Host-to-Host}} & \\text{Hierarchical global routing across intermediate routers} \\\\\n\\mathbf{\\text{L4 (Transport)}} & \\mathbf{\\text{16-bit Port Number}} & \\mathbf{\\text{Process-to-Process}} & \\text{Demultiplexes payload to specific running OS application} \\\\\n\\hline\n\\end{array}\n$$\n• **Port Categories (0 - 65,535):**\n  - **Well-Known (0 - 1023):** HTTP (80), HTTPS (443), SSH (22), DNS (53).\n  - **Ephemeral (49152 - 65535):** Dynamic client-side source ports allocated by OS.\n• **The Socket 5-Tuple:** $\\mathbf{\\{\\text{Src IP}, \\text{Src Port}, \\text{Dst IP}, \\text{Dst Port}, \\text{Protocol}\\}}$ uniquely identifies every connection!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed by an operating system kernel to demultiplex an incoming network frame to a web server process.",
      "orderItems": [
        "NIC hardware receives bitstream, validates Ethernet CRC checksum, and verifies destination MAC address matches NIC",
        "NIC driver strips Layer 2 Ethernet header and passes the encapsulated packet up to the OS kernel Layer 3 IPv4 stack",
        "IP stack validates destination IP address, checks TTL, strips IPv4 header, and passes segment to Layer 4 TCP protocol handler",
        "TCP handler extracts destination port (e.g. 443) and queries active socket table matching the connection's unique 5-tuple",
        "OS kernel deposits the decrypted application data payload into the web server process socket receive buffer and wakes worker thread"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Addressing Construct to its exact Technical Definition.",
      "matchPairs": [
        { "left": "48-bit MAC Address", "right": "Flat, hardware-burned identifier used exclusively for local link-layer frame delivery between adjacent nodes" },
        { "left": "Logical IP Address", "right": "Hierarchical network identifier enabling global routing across interconnected autonomous systems" },
        { "left": "16-bit Port Number", "right": "Transport layer integer identifying which local OS process/socket should receive network data" },
        { "left": "Socket 5-Tuple", "right": "Combination of Source IP, Source Port, Dest IP, Dest Port, and Protocol defining a unique connection" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The 16-bit transport layer address used by the operating system to deliver segments to a specific running process is a ___ number.",
      "blankAnswer": "port",
      "blankDistractors": ["socket", "packet", "host"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does the global internet architecture require BOTH Layer 2 physical MAC addresses AND Layer 3 logical IP addresses instead of simply routing all global traffic directly using hardware MAC addresses?",
      "options": [
        { "text": "MAC addresses are flat (non-hierarchical) hardware identifiers assigned by hardware manufacturers with zero geographic or network topological structure; if global routers attempted to route using MAC addresses, every core router on the internet would need to store billions of individual flat MAC entries in memory, causing immediate routing table collapse; IP addresses are hierarchical (network prefix + host identifier), allowing routers to aggregate millions of destination hosts into a single compact CIDR prefix route (e.g. 198.51.100.0/24)", "isCorrect": true, "explanation": "Correct! This is one of the most vital architectural design lessons in computer networks (Kurose & Ross Section 5.1; Tanenbaum Section 5.1). 1. **Why MAC Addresses Cannot Route Globally (Flat vs Hierarchical):** - When you buy a laptop in Tokyo with MAC `00:1A:2B:3C:4D:5E` and fly to London, its MAC address remains unchanged. - There is no mathematical relationship between a MAC address and its physical location on the globe. - If routers routed by MAC addresses, every core internet router would need a routing table containing every laptop, phone, IoT bulb, and server on Earth ($> 30\\text{ billion entries}$)! No router could search such a table at 100Gbps line rate. 2. **The Power of Hierarchical IP Addressing:** - IP addresses are organized like postal mailing addresses (Country $\\to$ State $\\to$ City $\\to$ Street $\\to$ House). - A router in Tokyo doesn't need to know individual machine IPs in London; it only needs ONE single routing table entry: `Send all 151.101.0.0/16 packets to the Atlantic fiber cable`. - One entry covers 65,536 hosts! 3. **The Role of MAC:** MAC addresses handle local frame transit on the immediate physical wire/radio link between adjacent switches and routers (via ARP/NDP), while IP handles global end-to-end routing." },
        { "text": "Because MAC addresses only work on wireless Wi-Fi networks", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because IP addresses cannot be parsed by operating systems", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Ethernet cables cannot carry numbers larger than 16 bits", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
