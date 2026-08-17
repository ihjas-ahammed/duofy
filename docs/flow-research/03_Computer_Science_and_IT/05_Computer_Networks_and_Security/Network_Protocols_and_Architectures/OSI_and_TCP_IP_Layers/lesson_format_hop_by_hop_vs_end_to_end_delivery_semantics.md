# Duofy Reusable Lesson Format: Hop-by-Hop vs End-to-End Delivery Semantics

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Network_Protocols_and_Architectures / OSI_and_TCP_IP_Layers`  
**Lesson Format Type:** `hop_by_hop_vs_end_to_end_delivery_semantics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify multi-hop packet forwarding, link-layer header swapping, and end-to-end transport layer invariants across routed internet topologies (Jerome H. Saltzer, David P. Reed, David D. Clark 1984, *End-to-End Arguments in System Design*, ACM TOCS; Kurose & Ross *Computer Networking* Chapters 1.4 & 4.1; Tanenbaum & Wetherall Chapter 1.3): contrast **Hop-by-Hop Delivery (Layers 1 & 2)** with **End-to-End Delivery (Layers 3, 4, & 7)**, prove the **Header Mutation Invariant** (**Layer 2 Source/Destination MAC addresses and CRC trailers are rewritten on EVERY intermediate router hop**; whereas **Layer 3 Source/Destination IP addresses, Layer 4 Source/Destination Ports, and Application Payload remain 100% CONSTANT throughout the entire journey** [excluding NAT/PAT]), decode router Time-To-Live (TTL) decrements, and interact with live multi-hop router packet forwarding simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hop-by-Hop vs End-to-End Invariants, Header Mutation Master Table Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Header Field & End-to-End vs Hop-by-Hop Mutability Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Tracing Exact Source/Destination MAC and IP Addresses Across an Intermediate Router Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The IPv4 Header Field Decremented by 1 at Every Router Hop to Prevent Routing Loops (TTL) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Multi-Hop Router Packet Forwarding & MAC Rewriting Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hop_by_hop_vs_end_to_end_delivery_semantics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do Hop-by-Hop delivery and End-to-End delivery differ, and which headers change at each router hop?",
      "blankAnswer": "Hop-by-Hop vs End-to-End Delivery (Saltzer 1984; Kurose & Ross Chapter 1.4): (1) END-TO-END DELIVERY (Layers 3, 4, 7): Involves only the origin host and final destination host. The Source IP, Destination IP, Source Port, Destination Port, and Application Payload remain CONSTANT and immutable across the entire multi-hop path across the global internet (ignoring NAT). (2) HOP-BY-HOP DELIVERY (Layers 1, 2): Involves moving frames between adjacent nodes across a single physical wire/link. Layer 2 Source MAC and Destination MAC addresses are STRIPPED AND RE-ENCRYPTED/REPLACED AT EVERY SINGLE ROUTER HOP! (3) WHAT CHANGES AT A ROUTER: (a) Layer 2: Old Ethernet header stripped; new Ethernet header added with Router egress MAC as Src MAC and Next-Hop router/host MAC as Dst MAC. (b) Layer 3: TTL (Time-To-Live) decremented by 1, and IP header checksum recomputed. IP addresses remain UNCHANGED!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Network Header Field to its exact Multi-Hop Mutability behavior.",
      "matchPairs": [
        { "left": "Destination MAC Address", "right": "Hop-by-Hop: Rewritten at every router hop to target the MAC of the immediate next-hop device" },
        { "left": "Destination IP Address", "right": "End-to-End: Remains constant across all intermediate hops, identifying final destination host" },
        { "left": "Destination Port Number", "right": "End-to-End: Remains constant across all intermediate routers, parsed only by destination host OS" },
        { "left": "IPv4 TTL (Time To Live)", "right": "Hop-by-Hop: Decremented by 1 at every router hop; packet discarded with ICMP if TTL reaches 0" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Host A (IP_A, MAC_A) sends a packet to Host B (IP_B, MAC_B) through an intermediate Router R (which has interface R1 [IP_R1, MAC_R1] connected to Host A's subnet, and interface R2 [IP_R2, MAC_R2] connected to Host B's subnet). What are the exact Layer 2 and Layer 3 source and destination addresses inside the frame when it is traversing the physical wire between Router R's R2 interface and Host B?",
      "options": [
        { "text": "Src MAC: MAC_R2, Dst MAC: MAC_B, Src IP: IP_A, Dst IP: IP_B; when Router R routes the packet, it decapsulates the Layer 2 frame from Host A, looks up IP_B in its routing table, and encapsulates the IP packet in a new Layer 2 frame with its own egress interface MAC (MAC_R2) as source MAC and Host B's MAC (MAC_B) as destination MAC, while preserving the original end-to-end IP addresses (Src IP = IP_A, Dst IP = IP_B)", "isCorrect": true, "explanation": "Correct! This is one of the most fundamental tracing exercises in computer networking (Kurose & Ross Section 1.4 and Section 5.4). 1. **Journey from Host A to Router R (Hop 1):** - Layer 3: `Src IP = IP_A`, `Dst IP = IP_B` (End-to-End). - Layer 2: `Src MAC = MAC_A`, `Dst MAC = MAC_R1` (Targeting the default gateway's local interface). 2. **At Router R:** - Router R receives the frame, verifies `Dst MAC = MAC_R1`, strips the Layer 2 Ethernet header. - It inspects Layer 3: `Dst IP = IP_B`. Router R decrements TTL by 1 and checks its routing table. - Routing table indicates `IP_B` is reachable directly on interface `R2`. - Router R uses ARP/NDP to find `MAC_B`. 3. **Journey from Router R to Host B (Hop 2):** - Router R creates a BRAND NEW Layer 2 frame! - Layer 2: `Src MAC = MAC_R2`, `Dst MAC = MAC_B`! - Layer 3: `Src IP = IP_A`, `Dst IP = IP_B` (Completely unchanged!). 4. Notice that MAC addresses change on EVERY link, but IP addresses remain identical end-to-end." },
        { "text": "Src MAC: MAC_A, Dst MAC: MAC_B, Src IP: IP_A, Dst IP: IP_B", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Src MAC: MAC_R2, Dst MAC: MAC_B, Src IP: IP_R2, Dst IP: IP_B", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Src MAC: MAC_A, Dst MAC: MAC_R1, Src IP: IP_R1, Dst IP: IP_R2", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The IPv4 header field decremented by 1 at every router hop to prevent infinite routing loops is ___ (Time-To-Live).",
      "blankAnswer": "TTL",
      "blankDistractors": ["TOS", "MTU", "FCS"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Multi-Hop Router & MAC Swapping Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Multi-Hop Header Mutation Engine</h3><p>Packet: <b style=\"color:#38bdf8;\">Host A (IP: 10.0.1.5) &rarr; Router R &rarr; Host B (IP: 10.0.2.9)</b></p><button id=\"hopBtn\" style=\"padding:6px 12px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">Step 1: Forward Across Hop 1 (A &rarr; Router)</button><button id=\"hopBtn2\" style=\"padding:6px 12px; margin-top:4px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">Step 2: Forward Across Hop 2 (Router &rarr; B)</button><div id=\"hopLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to trace packet...</div><script>document.getElementById('hopBtn').onclick=()=>{document.getElementById('hopLog').innerHTML='<b>HOP 1 (Host A &rarr; Router R):</b><br>• L2 Frame: [Src MAC: <b>AA:AA</b> | Dst MAC: <b>R1:R1</b>]<br>• L3 Packet: [Src IP: <b>10.0.1.5</b> | Dst IP: <b>10.0.2.9</b> | TTL: <b>64</b>]<br>• Status: Router R receives frame, strips L2 header.';}; document.getElementById('hopBtn2').onclick=()=>{document.getElementById('hopLog').innerHTML='<b>HOP 2 (Router R &rarr; Host B):</b><br>• L2 Frame: [Src MAC: <b>R2:R2</b> | Dst MAC: <b>BB:BB</b>] ⚡ <i>(MACs REWRITTEN!)</i><br>• L3 Packet: [Src IP: <b>10.0.1.5</b> | Dst IP: <b>10.0.2.9</b> | TTL: <b>63</b>] 🔒 <i>(IPs CONSTANT!)</i><br>• Host B receives original payload!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
