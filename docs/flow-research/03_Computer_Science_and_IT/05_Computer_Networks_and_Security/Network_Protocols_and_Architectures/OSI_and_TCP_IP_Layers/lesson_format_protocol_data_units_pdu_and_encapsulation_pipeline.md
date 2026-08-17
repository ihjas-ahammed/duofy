# Duofy Reusable Lesson Format: Protocol Data Units (PDU) and Encapsulation Pipeline

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Network_Protocols_and_Architectures / OSI_and_TCP_IP_Layers`  
**Lesson Format Type:** `protocol_data_units_pdu_and_encapsulation_pipeline`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the Russian-doll nested encapsulation hierarchies, protocol header structures, and decapsulation pipelines across the networking stack (Kurose & Ross *Computer Networking* Chapter 1.5; Tanenbaum & Wetherall Chapter 1.4): master the **4 Standard Protocol Data Unit (PDU) Designations** (**Layer 4: Segment [TCP] / Datagram [UDP]**, **Layer 3: Packet [IPv4/IPv6]**, **Layer 2: Frame [Ethernet]**, and **Layer 1: Bits**), trace the **Encapsulation Trajectory (Top-Down at Sender)** where each lower layer attaches its specific protocol header (and Data Link trailer with **CRC Frame Check Sequence [FCS]**), trace the **Decapsulation Trajectory (Bottom-Up at Receiver)**, and evaluate header overhead calculations and Maximum Transmission Unit (MTU) fragmentation boundaries.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | PDU Taxonomy Master Table, Encapsulation Headers/Trailers, & MTU Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Top-Down Encapsulation of an HTTP Web Request Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Networking Layer & Exact Protocol Data Unit (PDU) Name Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Protocol Data Unit (PDU) at Layer 2 (Data Link) is a ___ Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Computation of Protocol Header Overhead in an Ethernet/IP/TCP Frame Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State PDU & Encapsulation (Kurose & Ross 1.5):
   - **The PDU Taxonomy:**
     $$\begin{array}{|c|l|l|l|}
     \hline
     \textbf{Layer \#} & \textbf{Network Layer} & \textbf{PDU Official Name} & \textbf{Added Protocol Header / Trailer} \\
     \hline
     \mathbf{4} & \mathbf{\text{Transport}} & \mathbf{\text{Segment (TCP) / Datagram (UDP)}} & \text{TCP Header (20B min) / UDP Header (8B)} \\
     \mathbf{3} & \mathbf{\text{Network}} & \mathbf{\text{Packet}} & \text{IPv4 Header (20B min) / IPv6 Header (40B)} \\
     \mathbf{2} & \mathbf{\text{Data Link}} & \mathbf{\text{Frame}} & \mathbf{\text{Ethernet Header (14B) + FCS Trailer (4B CRC)}} \\
     \mathbf{1} & \mathbf{\text{Physical}} & \mathbf{\text{Bits}} & \text{Preamble, Start of Frame Delimiter (SFD)} \\
     \hline
     \end{array}$$
   - **The Encapsulation Pipeline:**
     $$\mathbf{\text{Payload Data} \xrightarrow{+\text{TCP\_H}} \text{Segment} \xrightarrow{+\text{IP\_H}} \text{Packet} \xrightarrow{+\text{Eth\_H} + \text{FCS\_T}} \text{Frame} \xrightarrow{\text{Physical}} \text{Raw Bits}}$$
   - **Decapsulation:** Reverses the process at destination, stripping and inspecting headers bottom-up!
2. **Slide 2 (`ordering`):** Provide 5 steps of encapsulating an HTTP GET request on the sender: (1) web browser generates HTTP GET application payload string, (2) Transport Layer encapsulates data with a 20-byte TCP header containing source/dest ports to form a Segment, (3) Network Layer encapsulates segment with a 20-byte IPv4 header containing source/dest IP addresses to form a Packet, (4) Data Link Layer encapsulates packet with 14-byte Ethernet MAC header and 4-byte CRC FCS trailer to form a Frame, (5) Physical Layer NIC converts frame into digital voltage signals/optical pulses to transmit raw bits across the physical cable!
3. **Slide 3 (`matching`):** Pair 4 networking layers (Transport, Network, Data Link, Physical) with their exact PDU names (Segment, Packet, Frame, Bits).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Layer 2 PDU is a frame. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating total header overhead: A client sends a 100-byte HTTP request over a standard IPv4 Ethernet network. The stack uses minimum standard headers: TCP header (20 bytes), IPv4 header (20 bytes), and Ethernet Frame Header + FCS Trailer (14 bytes header + 4 bytes CRC trailer = 18 bytes total). What is the total size of the resulting Ethernet frame on the wire, and what is the total protocol header overhead? (Total Frame Size $= 100 \text{ bytes (payload)} + 20 \text{ (TCP)} + 20 \text{ (IP)} + 18 \text{ (Ethernet)} = \mathbf{158 \text{ bytes}}$; Header Overhead $= 20 + 20 + 18 = \mathbf{58 \text{ bytes}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "protocol_data_units_pdu_and_encapsulation_pipeline",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Protocol Data Units & Encapsulation Pipeline**\n• **PDU Taxonomy Across Layers (Kurose & Ross Chapter 1.5):**\n$$\n\\begin{array}{|c|l|l|l|}\n\\hline\n\\textbf{Layer} & \\textbf{Layer Name} & \\textbf{PDU Designator} & \\textbf{Attached Headers / Trailers} \\\\\n\\hline\n\\mathbf{L4} & \\mathbf{\\text{Transport}} & \\mathbf{\\text{Segment / Datagram}} & \\text{TCP Header (20B min) / UDP Header (8B)} \\\\\n\\mathbf{L3} & \\mathbf{\\text{Network}} & \\mathbf{\\text{Packet}} & \\text{IPv4 Header (20B min) / IPv6 Header (40B)} \\\\\n\\mathbf{L2} & \\mathbf{\\text{Data Link}} & \\mathbf{\\text{Frame}} & \\mathbf{\\text{Ethernet Header (14B) + FCS Trailer (4B CRC)}} \\\\\n\\mathbf{L1} & \\mathbf{\\text{Physical}} & \\mathbf{\\text{Bits}} & \\text{Physical line modulation / voltages} \\\\\n\\hline\n\\end{array}\n$$\n• **The Top-Down Encapsulation Pipeline:**\n$$\n\\mathbf{\\text{App Data} \\ \\xrightarrow{+\\text{L4\\_H}} \\ \\mathbf{\\text{Segment}} \\ \\xrightarrow{+\\text{L3\\_H}} \\ \\mathbf{\\text{Packet}} \\ \\xrightarrow{+\\text{L2\\_H} + \\text{L2\\_T}} \\ \\mathbf{\\text{Frame}} \\ \\xrightarrow{\\text{NIC}} \\ \\mathbf{\\text{Bits (010101)}}}\n$$\n• **Decapsulation:** Receiver inspects and strips headers bottom-up ($L2 \\to L3 \\to L4 \\to L7$)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the Top-Down Encapsulation pipeline for an outgoing HTTP web request.",
      "orderItems": [
        "Application Layer (L7): Web browser constructs the raw HTTP GET request text string payload in memory",
        "Transport Layer (L4): Attaches a 20-byte TCP header with source and destination port numbers to form a Segment",
        "Network Layer (L3): Attaches a 20-byte IPv4 header containing logical source and destination IP addresses to form a Packet",
        "Data Link Layer (L2): Attaches a 14-byte Ethernet MAC header and appends a 4-byte CRC Frame Check Sequence trailer to form a Frame",
        "Physical Layer (L1): Network Interface Card (NIC) encodes the frame into physical electromagnetic voltages to transmit raw Bits"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Network Layer to its exact Protocol Data Unit (PDU) Name.",
      "matchPairs": [
        { "left": "Layer 4 (Transport Layer)", "right": "Segment (under TCP) or Datagram (under UDP)" },
        { "left": "Layer 3 (Network Layer)", "right": "Packet (encapsulated with IP header)" },
        { "left": "Layer 2 (Data Link Layer)", "right": "Frame (encapsulated with MAC header and CRC checksum trailer)" },
        { "left": "Layer 1 (Physical Layer)", "right": "Bits (raw sequence of 1s and 0s modulated on the transmission medium)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In computer networking terminology, the Protocol Data Unit (PDU) managed at Layer 2 (Data Link) is a ___.",
      "blankAnswer": "frame",
      "blankDistractors": ["packet", "segment", "datagram"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A client sends an application payload of 100 bytes of HTTP data across a standard Ethernet network using TCP and IPv4. The packet uses standard minimum headers: TCP Header = 20 bytes, IPv4 Header = 20 bytes, and Ethernet Header + Trailer = 14 bytes header + 4 bytes CRC trailer (18 bytes total). What is the total size of the resulting Layer 2 Ethernet frame transmitted on the wire, and what is the total protocol overhead?",
      "options": [
        { "text": "Total Frame Size = 158 bytes; Total Protocol Header/Trailer Overhead = 58 bytes; calculated by summing: 100 bytes (Application Data) + 20 bytes (TCP Header) + 20 bytes (IPv4 Header) + 14 bytes (Ethernet Header) + 4 bytes (CRC FCS Trailer) = 158 bytes total, of which 58 bytes (36.7%) represent encapsulation overhead", "isCorrect": true, "explanation": "Correct! This is the standard mathematical calculation of network encapsulation overhead (Kurose & Ross Chapter 1.5). 1. **Component Breakdown:** - Application Payload (Data): $100\\text{ bytes}$. - Layer 4 Transport (TCP Header): $20\\text{ bytes}$. - Layer 3 Network (IPv4 Header): $20\\text{ bytes}$. - Layer 2 Data Link (Ethernet Header + CRC FCS Trailer): $14 + 4 = 18\\text{ bytes}$. 2. **Total Transmitted Frame Size:** - $\\text{Total Size} = 100 + 20 + 20 + 14 + 4 = \\mathbf{158\\text{ bytes}}$. 3. **Total Header/Trailer Overhead:** - $\\text{Overhead} = 20 + 20 + 18 = \\mathbf{58\\text{ bytes}}$. 4. **Efficiency:** - $\\text{Payload Efficiency} = \\frac{100}{158} \\approx 63.3\\%$. 5. This illustrates why transferring very small payloads over TCP/IP incurs substantial relative protocol encapsulation overhead compared to transmitting large 1500-byte MTU frames." },
        { "text": "Total Frame Size = 100 bytes; Overhead = 0 bytes", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Total Frame Size = 120 bytes; Overhead = 20 bytes", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Total Frame Size = 500 bytes; Overhead = 400 bytes", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
