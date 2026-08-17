# Duofy Reusable Lesson Format: Inter-VLAN Routing (Router-on-a-Stick and Layer 3 Switches)

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Network_Protocols_and_Architectures / Ethernet_Switching_and_VLANs`  
**Lesson Format Type:** `inter_vlan_routing_router_on_a_stick_and_l3_switches`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify cross-VLAN communication pipelines, subinterface encapsulation bindings, and hardware ASIC routing across Inter-VLAN Routing architectures (IEEE 802.1Q; Kurose & Ross Chapter 6.4.4; Tanenbaum & Wetherall Chapter 4.8.4; Cisco Multilayer Switching Architecture): master the fundamental Layer 2 isolation rule (**devices in different VLANs cannot communicate without a Layer 3 routing boundary**), decode the **Router-on-a-Stick (ROAS)** design pattern (single physical 802.1Q trunk link connected to a router with logical **subinterfaces** e.g. `interface GigabitEthernet0/0.10` with `encapsulation dot1Q 10`), contrast Router-on-a-Stick with **Layer 3 Multilayer Switches** using **Switch Virtual Interfaces (SVIs)** (`interface Vlan 10` executing line-rate ASIC routing without external cable bottlenecks), and interact with live Inter-VLAN packet routing and subinterface simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Inter-VLAN Routing Invariant, Router-on-a-Stick vs L3 SVI Architecture Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Inter-VLAN Routing Component / Configuration Command & Architectural Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Layer 3 Multilayer Switches Outperform Router-on-a-Stick in Enterprise LANs Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Name of the Logical Sub-Ports Created on a Router's Physical Interface to Support Router-on-a-Stick (Subinterfaces) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Inter-VLAN Router-on-a-Stick vs Layer 3 SVI Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "inter_vlan_routing_router_on_a_stick_and_l3_switches",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "Why is a Layer 3 router required to connect different VLANs, and how do Router-on-a-Stick and Layer 3 SVIs differ?",
      "blankAnswer": "Inter-VLAN Routing Architectures (Kurose & Ross Chapter 6.4.4): (1) THE LAYER 2 ISOLATION INVARIANT: VLANs represent separate, completely isolated broadcast domains and IP subnets. A Layer 2 switch CANNOT forward traffic between VLAN 10 and VLAN 20! A Layer 3 routing engine is strictly required. (2) ROUTER-ON-A-STICK (ROAS): A single physical Ethernet cable connects the switch to an external router configured as an 802.1Q trunk. The router creates virtual 'subinterfaces' (e.g. Gig0/0.10, Gig0/0.20) bound to specific VLAN IDs (encapsulation dot1Q 10), acting as the default gateway. Bottleneck: All inter-VLAN traffic travels up and down the single physical cable twice (hairpinning). (3) LAYER 3 MULTILAYER SWITCH (SVI): Performs routing directly inside the switch chassis using dedicated hardware ASICs! Each VLAN has an internal logical routed interface called a Switch Virtual Interface (SVI, e.g. interface Vlan 10 with IP 10.0.1.1). Delivers line-rate wire-speed routing (terabits/sec) with zero external cable bottlenecks!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Inter-VLAN Routing Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Router-on-a-Stick (ROAS)", "right": "Routes between multiple VLANs over a single physical trunk link using logical subinterfaces" },
        { "left": "Switch Virtual Interface (SVI)", "right": "Logical Layer 3 routed interface inside a multilayer switch acting as default gateway for a local VLAN" },
        { "left": "encapsulation dot1Q 10", "right": "Router command that binds a specific subinterface to process and tag frames for VLAN 10" },
        { "left": "Hairpinning Bottleneck", "right": "Traffic congestion caused when packets must travel up and down the exact same physical link to reach a router" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why do modern enterprise campus and data center networks utilize Layer 3 Multilayer Switches with Switch Virtual Interfaces (SVIs) for Inter-VLAN routing rather than traditional Router-on-a-Stick designs?",
      "options": [
        { "text": "Router-on-a-Stick routes traffic over an external physical router link, causing traffic 'hairpinning' where bandwidth is halved and limited by the router's interface capacity (e.g. 1Gbps); Layer 3 Multilayer Switches perform packet routing directly in dedicated hardware ASICs across the internal high-speed backplane (Switch Virtual Interfaces), achieving full line-rate multi-terabit inter-VLAN routing with sub-microsecond latency", "isCorrect": true, "explanation": "Correct! This is the core architectural justification for Layer 3 Multilayer Switching in enterprise network design (Kurose & Ross Section 6.4.4). 1. **The Router-on-a-Stick Bottleneck (Hairpinning / One-Armed Router):** - Suppose Host A in VLAN 10 sends a 1Gbps file transfer to Host B in VLAN 20. - Frame travels from Switch $\\to$ Router over the 1Gbps physical trunk link. - Router strips the VLAN 10 tag, looks up the route in its FIB, attaches a VLAN 20 tag, and sends the frame BACK DOWN the EXACT SAME physical 1Gbps cable to the Switch! - The single cable is saturated in both directions simultaneously, halving effective throughput and creating high latency. 2. **The Layer 3 Switch Solution (SVIs):** - A Multilayer Switch integrates Layer 2 switching and Layer 3 routing into the **same physical chassis**. - Each VLAN has a virtual gateway: `interface Vlan 10 (IP: 10.0.1.1)` and `interface Vlan 20 (IP: 10.0.2.1)`. - When Host A sends a packet to Host B, the switch's internal **Hardware ASICs (Application-Specific Integrated Circuits)** route the packet across the multi-terabit internal backplane in hardware. - Zero external cables, zero hairpinning, and true line-rate switching at wire speed!" },
        { "text": "Because Router-on-a-Stick cannot support TCP packets", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Layer 3 switches disable all VLAN security features", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Router-on-a-Stick requires wireless antennas", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Router-on-a-Stick configuration, multiple logical virtual interfaces created on a single physical router port are called ___.",
      "blankAnswer": "subinterfaces",
      "blankDistractors": ["trunks", "gateways", "svis"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Inter-VLAN Routing Engine (ROAS vs L3 SVI)",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Inter-VLAN Routing Simulator</h3><p>Traffic: <b style=\"color:#38bdf8;\">PC1 (VLAN 10: 10.0.1.5) &rarr; PC2 (VLAN 20: 10.0.2.8)</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnRoas\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Route via Router-on-a-Stick</button><button id=\"btnSvi\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">2. Route via Layer 3 SVI (ASIC)</button></div><div id=\"vlanLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Select routing architecture above...</div><script>document.getElementById('btnRoas').onclick=()=>{document.getElementById('vlanLog').innerHTML='<b>ROUTER-ON-A-STICK (ROAS):</b><br>1. PC1 &rarr; Switch (Tagged 802.1Q VID=10).<br>2. Switch &rarr; Router over physical trunk (Gig0/0.10).<br>3. Router decapsulates, routes L3, tags VID=20.<br>4. Router &rarr; Switch over SAME trunk (Hairpinning!).<br>5. Switch &rarr; PC2. Latency: <b>High</b> | Cable Saturated!';}; document.getElementById('btnSvi').onclick=()=>{document.getElementById('vlanLog').innerHTML='<b>LAYER 3 SWITCH (SVI ASIC):</b><br>1. PC1 &rarr; Switch.<br>2. Switch internal SVI (Vlan 10 &rarr; Vlan 20) routes packet directly inside hardware ASIC backplane at 40Gbps line rate!<br>3. Switch &rarr; PC2.<br>⚡ Zero external cable delay. Sub-microsecond wire-speed!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
