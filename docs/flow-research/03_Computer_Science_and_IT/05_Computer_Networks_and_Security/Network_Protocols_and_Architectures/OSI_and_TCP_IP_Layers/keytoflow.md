# Key to Flow: OSI and TCP/IP Layer Models (PDU Encapsulation, Addressing, & Delivery)

**Subject Area:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Network_Protocols_and_Architectures / OSI_and_TCP_IP_Layers`

---

## 📌 Core Concept & Mental Model
**Layered Network Abstraction Hierarchies, Protocol Data Unit (PDU) Nested Encapsulation, Triple-Tier Addressing (MAC $\to$ IP $\to$ Port), and Hop-by-Hop vs End-to-End Transport Delivery** govern computer networking fundamentals (ISO 7498 OSI Model 1984; DARPA / IETF RFC 1122 TCP/IP Model; Jim Kurose & Keith Ross *Computer Networking: A Top-Down Approach*; Andrew Tanenbaum & David Wetherall *Computer Networks*):
* **1. The OSI 7-Layer vs TCP/IP 4/5-Layer Architectural Mapping:**
  $$\begin{array}{|c|l|l|l|l|}
  \hline
  \textbf{OSI Layer} & \textbf{OSI Name} & \textbf{TCP/IP Layer} & \textbf{PDU Name} & \textbf{Scope \& Responsibility} \\
  \hline
  \mathbf{7} & \text{Application} & \text{Application} & \text{Data / Message} & \text{User network APIs (HTTP, DNS, SSH, SMTP)} \\
  \mathbf{6} & \text{Presentation} & \text{Application} & \text{Data} & \text{Formatting, compression, encryption (TLS/SSL)} \\
  \mathbf{5} & \text{Session} & \text{Application} & \text{Data} & \text{Dialog control, session checkpointing (RPC, NetBIOS)} \\
  \mathbf{4} & \mathbf{\text{Transport}} & \mathbf{\text{Transport}} & \mathbf{\text{Segment / Datagram}} & \mathbf{\text{Process-to-Process (Port #s, TCP reliability, UDP)}} \\
  \mathbf{3} & \mathbf{\text{Network}} & \mathbf{\text{Internet / Network}} & \mathbf{\text{Packet}} & \mathbf{\text{Host-to-Host (Logical IP Addressing, routing)}} \\
  \mathbf{2} & \mathbf{\text{Data Link}} & \mathbf{\text{Link / Network Access}} & \mathbf{\text{Frame}} & \mathbf{\text{Node-to-Node (Physical MAC, Ethernet, CRC FCS)}} \\
  \mathbf{1} & \mathbf{\text{Physical}} & \mathbf{\text{Physical}} & \mathbf{\text{Bits}} & \mathbf{\text{Bit transmission (Voltages, optical pulses, RF)}} \\
  \hline
  \end{array}$$
* **2. The Nested Encapsulation & Decapsulation Pipeline:**
  - Sender Stack (Top-Down): **Encapsulation** adds headers/trailers:
    $$\mathbf{\text{Data} \xrightarrow{+L4\_H} \mathbf{\text{Segment}} \xrightarrow{+L3\_H} \mathbf{\text{Packet}} \xrightarrow{+L2\_H + L2\_T} \mathbf{\text{Frame}} \xrightarrow{\text{Modulate}} \mathbf{\text{Bits (0101)}}}$$$$
  - Receiver Stack (Bottom-Up): **Decapsulation** strips headers/trailers layer-by-layer up to application payload.
* **3. The 3 Addressing Tiers & Operational Scopes:**
  1. **Layer 2 (Physical MAC Address, 48-bit):** Identifies physical NIC interfaces on the **same local broadcast domain (Node-to-Node)**.
  2. **Layer 3 (Logical IP Address, 32-bit IPv4 / 128-bit IPv6):** Identifies destination machines across **heterogeneous global routed networks (Host-to-Host)**.
  3. **Layer 4 (Transport Port Number, 16-bit):** Demultiplexes communication to a specific running OS process/socket (**Process-to-Process**).
* **4. Hop-by-Hop vs End-to-End Delivery:**
  - **Hop-by-Hop (Data Link / Physical):** MAC headers and frame trailers change on **every single router hop** across intermediate links!
  - **End-to-End (Network / Transport / Application):** Source IP, Destination IP, Source Port, Destination Port, and Payload remain **constant from origin host to final destination host** (ignoring NAT).

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The PDU & Addressing Russian Doll Metaphor
* Application Data $\in$ Transport Segment (Port) $\in$ Network Packet (IP) $\in$ Data Link Frame (MAC) $\in$ Physical Bits.

### 2. Top Recommended Resources
* **The Definitive Textbook:** *Computer Networking: A Top-Down Approach* (Jim Kurose & Keith Ross 8th Ed.), Chapters 1 & 2.
* **Network Reference Bible:** *Computer Networks* (Andrew S. Tanenbaum & David J. Wetherall 6th Ed.).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you name the PDU at every layer (Data $\to$ Segment $\to$ Packet $\to$ Frame $\to$ Bits)?
- [ ] Can you differentiate Process-to-Process (Port), Host-to-Host (IP), and Node-to-Node (MAC)?
- [ ] Can you trace encapsulation headers added when an HTTP payload travels down the stack?
- [ ] Can you explain why MAC addresses change across router hops while IP addresses remain constant?
