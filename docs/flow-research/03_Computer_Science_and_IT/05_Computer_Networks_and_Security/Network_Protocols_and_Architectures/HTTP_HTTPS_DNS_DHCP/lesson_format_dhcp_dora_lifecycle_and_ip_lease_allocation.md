# Duofy Reusable Lesson Format: DHCP DORA Lifecycle and IP Lease Allocation

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Network_Protocols_and_Architectures / HTTP_HTTPS_DNS_DHCP`  
**Lesson Format Type:** `dhcp_dora_lifecycle_and_ip_lease_allocation`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify automated network configuration, client-server bootstrap handshakes, and address lease management across the Dynamic Host Configuration Protocol (DHCP) (Ralph Droms 1997 RFC 2131; Kurose & Ross *Computer Networking* Chapter 4.3.3; Tanenbaum & Wetherall Chapter 5.6.3): master the **4-Step DORA Handshake** (**1. Discover [Client $\xrightarrow{\text{Broadcast}}$ `DHCPDISCOVER` on UDP 67]**, **2. Offer [Server $\xrightarrow{\text{Unicast/Broadcast}}$ `DHCPOFFER` with IP lease parameters]**, **3. Request [Client $\xrightarrow{\text{Broadcast}}$ `DHCPREQUEST` accepting selected lease]**, and **4. Acknowledge [Server $\xrightarrow{\text{Unicast/Broadcast}}$ `DHCPACK` finalizing binding]**), evaluate the **4 Network Parameters Provisioned via DHCP** (**Client IP Address**, **Subnet Mask**, **Default Gateway IP Router**, and **DNS Server IP Addresses**), master **Lease Timers ($T_1 = 50\%$ renewal unicast**, **$T_2 = 87.5\%$ rebind broadcast**, and **$T_{\text{expire}} = 100\%$**), evaluate **DHCP Relay Agents (RFC 3046 / IP Helper-Address)** crossing router boundaries, and interact with live DHCP DORA state-machine simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | DHCP DORA 4-Step Architecture, UDP Ports 67/68, & Lease Timers Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | DHCP Handshake Step / Lease Timer & Protocol Operational Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why the DHCPREQUEST Message is Sent as a Broadcast Rather Than Unicast Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Acronym for the 4-Stage DHCP Address Allocation Process is ___ (DORA) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive DHCP DORA 4-Step Handshake & Lease Allocation Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "dhcp_dora_lifecycle_and_ip_lease_allocation",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the DHCP DORA process, which UDP ports are used, and how do DHCP Lease Timers work?",
      "blankAnswer": "DHCP DORA Lifecycle (RFC 2131; Kurose & Ross Chapter 4.3.3): (1) UDP PORTS: Server listens on UDP Port 67; Client listens on UDP Port 68. (2) THE 4-STEP DORA HANDSHAKE: (a) D - Discover: Client broadcasts DHCPDISCOVER (Src IP 0.0.0.0, Dst IP 255.255.255.255, Src MAC Client, Dst MAC FF:FF:FF:FF:FF:FF). (b) O - Offer: DHCP server(s) reserve IP and send DHCPOFFER (offering Client IP, Subnet Mask, Default Gateway, DNS Servers). (c) R - Request: Client broadcasts DHCPREQUEST announcing which server offer it accepted (notifying other servers to release their reserved offers!). (d) A - Acknowledge: Winning server sends DHCPACK committing the lease! (3) LEASE TIMERS: (i) T1 Renewal (50% of lease): Client sends unicast DHCPREQUEST to original server to extend lease. (ii) T2 Rebinding (87.5% of lease): If original server didn't respond, client broadcasts DHCPREQUEST to ANY available server. (iii) Expiration (100%): IP released; client drops back to INIT and restarts DORA! (4) DHCP RELAY AGENT (IP Helper-Address): Forwards broadcast DISCOVER packets across routers to centralized remote DHCP servers via unicast."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each DHCP Message / Timer to its exact Protocol Definition.",
      "matchPairs": [
        { "left": "DHCPDISCOVER Message", "right": "Initial Layer 2 and Layer 3 broadcast sent by unconfigured client searching for available DHCP servers" },
        { "left": "DHCPOFFER Message", "right": "Server response proposing a specific candidate IP address, subnet mask, gateway, and DNS configuration" },
        { "left": "T1 Lease Timer (50%)", "right": "First renewal milestone where the client sends a unicast request to the issuing server to extend lease" },
        { "left": "DHCP Relay Agent", "right": "Router feature that intercepts client broadcast requests and forwards them as unicast to a remote DHCP server" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "During Step 3 of the DHCP handshake, why is the DHCPREQUEST packet transmitted as a Layer 2/Layer 3 BROADCAST across the local network rather than sent as a unicast message directly to the specific server whose offer was accepted?",
      "options": [
        { "text": "Because multiple DHCP servers on the local network segment may have sent competing DHCPOFFER messages reserving candidate IP addresses for the client; broadcasting the DHCPREQUEST publicly announces which server's offer was accepted (using the 'Server Identifier' option), implicitly informing all other DHCP servers that their offers were rejected so they can immediately unreserve and return their candidate IP addresses back to their available address pools", "isCorrect": true, "explanation": "Correct! This is one of the most elegant multi-server coordination designs in network protocols (Ralph Droms RFC 2131; Kurose & Ross Section 4.3.3). 1. **The Multi-Server Environment:** - In enterprise networks, two redundant DHCP servers ($S_1$ and $S_2$) often sit on the same subnet for high availability. - When a new client broadcasts `DHCPDISCOVER`, BOTH $S_1$ and $S_2$ respond with `DHCPOFFER`, each temporarily holding an IP address in reserve. 2. **Why Unicast Fails:** - If the client chose $S_1$ and sent a private unicast `DHCPREQUEST` to $S_1$, server $S_2$ would have NO IDEA the client chose $S_1$. - $S_2$ would keep its offered IP address locked in reserve for minutes, wasting address space. 3. **The Broadcast Solution:** - The client broadcasts `DHCPREQUEST` with option `Server Identifier = S1`. - Server $S_1$ sees it and responds with `DHCPACK`, confirming the lease. - Server $S_2$ ALSO sees the broadcast, notes that $S_1$ was chosen, and immediately frees its reserved candidate IP back to its pool for other machines! 4. Furthermore, the client has not received official confirmation (`DHCPACK`) yet, so its own IP address is not officially bound until Step 4." },
        { "text": "Because client computers do not have network cards that support unicast", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because DHCP servers only read broadcast packets on port 80", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the internet forbids unicast before an operating system reboot", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The 4-stage DHCP IP address allocation handshake (Discover, Offer, Request, Acknowledge) is known by the acronym ___.",
      "blankAnswer": "DORA",
      "blankDistractors": ["ARPA", "ICMP", "IGMP"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive DHCP DORA Handshake & Lease Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>DHCP DORA Bootstrap Engine</h3><p>Client IP State: <b id=\"dhcpIp\" style=\"color:#ef4444;\">0.0.0.0 (Unconfigured)</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnD\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. DISCOVER</button><button id=\"btnO\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer;\">2. OFFER</button><button id=\"btnR\" style=\"padding:6px 10px; background:#8b5cf6; color:white; border:none; border-radius:4px; cursor:pointer;\">3. REQUEST</button><button id=\"btnA\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">4. ACKNOWLEDGE</button></div><div id=\"doraLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to broadcast discover...</div><script>document.getElementById('btnD').onclick=()=>{document.getElementById('doraLog').innerHTML='<b>1. DHCPDISCOVER (Broadcast):</b><br>• Src: 0.0.0.0:68 | Dst: 255.255.255.255:67<br>• Client shouts: \"Looking for a DHCP server!\"';}; document.getElementById('btnO').onclick=()=>{document.getElementById('doraLog').innerHTML='<b>2. DHCPOFFER (Server &rarr; Client):</b><br>• Offered IP: 192.168.1.100<br>• Gateway: 192.168.1.1 | DNS: 8.8.8.8 | Mask: /24';}; document.getElementById('btnR').onclick=()=>{document.getElementById('doraLog').innerHTML='<b>3. DHCPREQUEST (Broadcast):</b><br>• Client announces: \"I accept offer from Server 192.168.1.1!\"<br>• Other servers release candidate reserves.';}; document.getElementById('btnA').onclick=()=>{document.getElementById('dhcpIp').innerText='192.168.1.100 (Bound /24)'; document.getElementById('dhcpIp').style.color='#10b981'; document.getElementById('doraLog').innerHTML='<b>4. DHCPACK (Finalized):</b><br>🎉 Lease committed! Lease duration: 86400s (24h).<br>• T1 Renewal scheduled at 12 hours.<br>• Client online with full network access!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
