# Duofy Reusable Lesson Format: IPv4 Subnetting, CIDR, and Longest Prefix Match

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Network_Protocols_and_Architectures / IP_Addressing_Subnetting_and_Routing_BGP_OSPF`  
**Lesson Format Type:** `ipv4_subnetting_cidr_and_longest_prefix_match`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the binary arithmetic, subnet mask calculations, and forwarding table lookups of IPv4 Classless Inter-Domain Routing (CIDR) (RFC 791; Vince Fuller et al. 1993 RFC 1519 CIDR; Kurose & Ross *Computer Networking* Chapter 4.3; Tanenbaum & Wetherall Chapter 5.6): master the **CIDR Prefix Subnetting Formulas** (for prefix length $/n$: **Total Addresses $= 2^{32 - n}$**, **Usable Host Addresses $= \mathbf{2^{32 - n} - 2}$**, **Network Address $= \text{IP} \ \& \ \text{Mask}$**, and **Broadcast Address $= \text{Network} \ | \ \sim\text{Mask}$**), evaluate **Variable Length Subnet Masking (VLSM)** to eliminate address waste, master the **Longest Prefix Match (LPM)** forwarding decision invariant in router hardware (Trie/TCAM lookups prioritizing the most specific route), and perform end-to-end subnet partitioning calculations.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CIDR Subnetting Formulas, Usable Host 2^(32-n)-2 Rule, & LPM Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Router Forwarding Decision Using Longest Prefix Match (LPM) Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | CIDR Prefix Length / Subnet Term & Mathematical Capacity Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Tie-Breaking Rule Where Routers Select the Most Specific Route Match (Longest Prefix Match) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Computation of Network Address, Broadcast Address, and Usable Hosts for a /28 Subnet Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State CIDR & LPM (RFC 1519; Kurose & Ross 4.3):
   - **The 32-bit IPv4 Structure:** $\text{Network Prefix (}n\text{ bits)} \ + \ \text{Host ID (}32 - n\text{ bits)}$.
   - **Subnet Formulas for Prefix $/n$:**
     $$\mathbf{\text{Total IPs} = 2^{32 - n} \qquad ; \qquad \mathbf{\text{Usable Hosts} = 2^{32 - n} - 2}}$$
     - Network Address: Host bits are ALL 0s ($\text{IP} \ \& \ \text{Mask}$).
     - Directed Broadcast Address: Host bits are ALL 1s ($\text{Network} \ | \ \sim\text{Mask}$).
   - **Common Prefix Quick Table:**
     $$\begin{array}{|c|c|c|c|}
     \hline
     \textbf{CIDR} & \textbf{Subnet Mask} & \textbf{Total IPs} & \textbf{Usable Hosts} \\
     \hline
     \mathbf{/24} & 255.255.255.0 & 256 & 254 \\
     \mathbf{/26} & 255.255.255.192 & 64 & 62 \\
     \mathbf{/28} & 255.255.255.240 & 16 & \mathbf{14} \\
     \mathbf{/30} & 255.255.255.252 & 4 & \mathbf{2 \text{ (Point-to-Point links)}} \\
     \hline
     \end{array}$$
   - **Longest Prefix Match (LPM):** If destination matches multiple routing entries, **select the one with the largest $n$**!
2. **Slide 2 (`ordering`):** Provide 5 steps of router forwarding packet destined to `192.168.1.130`: (1) router extracts destination IP 192.168.1.130 from IP packet header, (2) router checks FIB routing table: matches default route 0.0.0.0/0 on Interface 0 (prefix length 0), (3) matches route 192.168.0.0/16 on Interface 1 (prefix length 16), (4) matches route 192.168.1.128/25 on Interface 2 (prefix length 25), (5) applies Longest Prefix Match rule: selects /25 route (most specific) and forwards packet out Interface 2!
3. **Slide 3 (`matching`):** Pair 4 CIDR prefixes (/24, /28, /30, /32) with their usable host capacities.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of longest prefix match. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on computing /28 subnet boundaries: Given the IP address `192.0.2.140/28`, what are the Network Address, Directed Broadcast Address, and total number of Usable Host IP addresses for this subnet? (For `/28`, host bits $h = 32 - 28 = 4$, block size is $2^4 = 16$. Subnet boundaries in 4th octet are multiples of 16: $0, 16, 32, \dots, 128, 144$. Since $128 \le 140 < 144$: **Network Address $= 192.0.2.128$**, **Broadcast Address $= 192.0.2.143$**, **Usable Hosts $= 2^4 - 2 = 14$ [range 192.0.2.129 to 192.0.2.142]**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ipv4_subnetting_cidr_and_longest_prefix_match",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: IPv4 CIDR Subnetting & Longest Prefix Match**\n• **Subnet Formulas for Prefix $/n$ (RFC 1519):**\n$$\n\\mathbf{\\text{Host Bits } h = 32 - n \\qquad ; \\qquad \\mathbf{\\text{Usable Hosts} = 2^h - 2}}\n$$\n• **Common CIDR Prefix Table (Kurose & Ross Chapter 4.3):**\n$$\n\\begin{array}{|c|c|c|c|}\n\\hline\n\\textbf{CIDR Prefix} & \\textbf{Dotted Subnet Mask} & \\textbf{Total IP Count} & \\textbf{Usable Hosts } (2^h - 2) \\\\\n\\hline\n\\mathbf{/24} & 255.255.255.0 & 256 & 254 \\\\\n\\mathbf{/26} & 255.255.255.192 & 64 & 62 \\\\\n\\mathbf{/28} & 255.255.255.240 & 16 & \\mathbf{14} \\\\\n\\mathbf{/30} & 255.255.255.252 & 4 & \\mathbf{2 \\text{ (Point-to-Point Links)}} \\\\\n\\hline\n\\end{array}\n$$\n• **Longest Prefix Match (LPM):** When an IP matches multiple routes, the router **ALWAYS forwards via the route with the largest prefix length $n$** (most specific)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed by a router resolving an IP lookup (192.168.1.130) using Longest Prefix Match (LPM).",
      "orderItems": [
        "Router extracts the 32-bit destination IP address (192.168.1.130) from the incoming packet header",
        "Perform bitwise AND comparison against default route entry: matches 0.0.0.0/0 on Interface 0 (Prefix length = 0)",
        "Perform bitwise AND comparison against regional summary route: matches 192.168.0.0/16 on Interface 1 (Prefix length = 16)",
        "Perform bitwise AND comparison against local subnet route: matches 192.168.1.128/25 on Interface 2 (Prefix length = 25)",
        "Apply LPM tie-breaker: select the longest prefix (/25 > /16 > /0) and forward packet out Interface 2"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each CIDR Subnet Prefix to its exact Usable Host Capacity.",
      "matchPairs": [
        { "left": "/24 Subnet Prefix", "right": "254 Usable Hosts (8 host bits: 2^8 - 2 = 254; Mask 255.255.255.0)" },
        { "left": "/28 Subnet Prefix", "right": "14 Usable Hosts (4 host bits: 2^4 - 2 = 14; Mask 255.255.255.240)" },
        { "left": "/30 Subnet Prefix", "right": "2 Usable Hosts (2 host bits: 2^2 - 2 = 2; standard point-to-point router link)" },
        { "left": "/32 Subnet Prefix", "right": "Single Specific Host (0 host bits: represents an exact individual IP / loopback)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The routing algorithm tie-breaker that selects the most specific routing table entry is ___ Prefix Match (LPM).",
      "blankAnswer": "Longest",
      "blankDistractors": ["Shortest", "Equal", "Cost"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An enterprise network administrator assigns the IP address 192.0.2.140/28 to a database server. What are the exact Network Address, Directed Broadcast Address, and total number of Usable Host IP addresses in this subnet?",
      "options": [
        { "text": "Network Address: 192.0.2.128; Broadcast Address: 192.0.2.143; Usable Hosts = 14; with prefix /28, host bits h = 32 - 28 = 4, giving block size 2^4 = 16; subnet intervals in the 4th octet are multiples of 16 (0, 16, ..., 128, 144); since 128 <= 140 < 144, the network address is 192.0.2.128, the broadcast address is 192.0.2.143, and the usable host range spans 192.0.2.129 through 192.0.2.142 (14 usable hosts)", "isCorrect": true, "explanation": "Correct! This is a textbook CIDR subnetting calculation (Kurose & Ross Section 4.3). 1. **Given:** IP `192.0.2.140/28`. 2. **Calculate Host Bits and Block Size:** - Prefix length $n = 28$. - Host bits $h = 32 - 28 = 4\\text{ bits}$. - Block size (Subnet Increment) $= 2^4 = 16$. 3. **Find the Subnet Range:** - The subnets in the 4th octet increment by 16: `0, 16, 32, 48, 64, 80, 96, 112, 128, 144, ...` - The given host octet is `140`. - `140` falls squarely into the block starting at `128` and ending before `144`. 4. **Compute Key Addresses:** - **Network Address (First IP / all host bits 0):** `192.0.2.128`. - **Broadcast Address (Last IP / all host bits 1):** `128 + 16 - 1 = 192.0.2.143`. - **Usable Host IP Range:** `192.0.2.129` to `192.0.2.142`. - **Total Usable Hosts:** $2^4 - 2 = 16 - 2 = \\mathbf{14\\text{ hosts}}$." },
        { "text": "Network Address: 192.0.2.0; Broadcast Address: 192.0.2.255; Usable Hosts = 254", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Network Address: 192.0.2.140; Broadcast Address: 192.0.2.156; Usable Hosts = 16", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Network Address: 192.0.2.128; Broadcast Address: 192.0.2.255; Usable Hosts = 126", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
