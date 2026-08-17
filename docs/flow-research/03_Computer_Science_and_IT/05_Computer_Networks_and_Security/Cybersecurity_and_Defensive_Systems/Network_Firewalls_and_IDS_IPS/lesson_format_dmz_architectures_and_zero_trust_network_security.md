# Duofy Reusable Lesson Format: DMZ Architectures and Zero Trust Network Security

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cybersecurity_and_Defensive_Systems / Network_Firewalls_and_IDS_IPS`  
**Lesson Format Type:** `dmz_architectures_and_zero_trust_network_security`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify perimeter segmentation, multi-homed firewall zoning, and modern microsegmentation architectures across Demilitarized Zones (DMZ) and Zero Trust Architecture (ZTA) (NIST SP 800-41; NIST SP 800-207 *Zero Trust Architecture*; John Kindervag Forrester 2010; William Stallings *Computer Security* Chapter 9.4): master the **Traditional 3-Legged DMZ Perimeter Architecture** (Internet $\to$ Outer Firewall $\to$ **DMZ Subnet [Public Web/Mail/DNS Servers]** $\to$ Inner Firewall $\to$ **Internal Trusted LAN [Active Directory / Databases]**; enforcing the unidirectional invariant that **Internet can initiate traffic to DMZ, DMZ can initiate queries to Internal Database, but DMZ can NEVER initiate connections to the Internal LAN**), contrast perimeter-based "Castle-and-Moat" security with **Zero Trust Architecture (ZTA)** (**"Never trust, always verify"**, assuming breach, identity-centric access, mutual TLS [mTLS], microsegmentation, and Policy Decision Points [PDP] / Policy Enforcement Points [PEP]), and interact with live DMZ firewall traffic flow and lateral movement isolation simulator widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | DMZ 3-Tier Architecture Invariants, Castle-and-Moat vs Zero Trust (NIST SP 800-207) Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Security Architecture / Protocol & Threat Containment Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Tracing Allowed vs Denied Network Traffic Flows in a Standard 3-Legged DMZ Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Core Philosophy of Zero Trust Architecture (NIST SP 800-207) Is 'Never Trust, Always ___' (Verify) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive DMZ Perimeter Firewall & Lateral Movement Isolation Simulator Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "dmz_architectures_and_zero_trust_network_security",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is a DMZ network architecture, what traffic flows are permitted, and how does Zero Trust (NIST SP 800-207) evolve perimeter security?",
      "blankAnswer": "DMZ & Zero Trust Architecture (NIST SP 800-41; NIST SP 800-207): (1) 3-LEGGED DMZ (Demilitarized Zone): A dedicated physical/logical subnet isolated between external and internal firewall interfaces that hosts public-facing servers (Web, Mail, DNS). (2) TRAFFIC FLOW INVARIANTS: (a) Internet -> DMZ: ALLOWED (Ports 80/443 to Web Servers). (b) DMZ -> Internet: ALLOWED (Package updates/DNS lookups). (c) DMZ -> Internal LAN: STRICTLY FORBIDDEN! (If a web server is hacked via RCE, the attacker is trapped inside the DMZ and CANNOT pivot laterally into internal Active Directory/employee workstations). (d) Internal LAN -> DMZ: ALLOWED (Admins managing web servers via SSH). (e) DMZ -> Database Subnet: RESTRICTED to specific database port (e.g. 3306/5432). (3) ZERO TRUST ARCHITECTURE (ZTA - NIST SP 800-207): 'Never trust, always verify'. Replaces the flawed 'Castle-and-Moat' perimeter model. Assumes the internal network is already compromised; enforces microsegmentation, continuous identity authentication, and end-to-end mTLS encryption for every individual transaction!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Network Security Architecture Construct to its exact Security Function.",
      "matchPairs": [
        { "left": "Demilitarized Zone (DMZ)", "right": "Semi-trusted perimeter buffer network hosting public servers to prevent direct internet access to internal LAN" },
        { "left": "Zero Trust Architecture (ZTA)", "right": "Security framework removing implicit trust from internal networks, enforcing continuous authentication per request" },
        { "left": "Microsegmentation", "right": "Granular workload isolation dividing data centers into distinct security zones down to individual container pods" },
        { "left": "Policy Enforcement Point (PEP)", "right": "Gatekeeper component in Zero Trust that intercepts, inspects, and terminates client connection requests" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "In a properly configured enterprise 3-Legged Firewall DMZ topology (Internet, DMZ, Internal LAN), an external attacker successfully executes a remote code execution vulnerability and gains a root shell on a public web server residing in the DMZ. Why does the DMZ architecture prevent the attacker from directly compromising internal employee workstations on the corporate LAN?",
      "options": [
        { "text": "The firewall rules enforce a strict unidirectional containment policy where connections initiated from the DMZ toward the internal LAN are unconditionally dropped by default; even though the attacker has root access on the DMZ web server, the firewall blocks any outbound SYN packets or lateral scanning attempts from the DMZ into the internal corporate subnet, effectively trapping the attacker within the isolated perimeter zone", "isCorrect": true, "explanation": "Correct! This is the primary security objective of a Demilitarized Zone (NIST SP 800-41 Section 3.2; Stallings Chapter 9.4). 1. **The DMZ Firewall Policy Rule:** - `Rule 1: Allow Internet -> DMZ (TCP 443)` (So public users can view the website). - `Rule 2: Allow DMZ -> Database Server (TCP 3306 ONLY)` (So web app can query MySQL). - `Rule 3: DENY ALL DMZ -> Internal LAN`! 2. **When the Web Server is Hacked:** - The attacker runs `nmap 10.0.2.0/24` to scan employee laptops, or tries to connect to Active Directory on port 88/389. - The firewall intercepts these packets, matches `Rule 3 (Deny DMZ -> Internal)`, and drops every packet. 3. The attacker cannot pivot or move laterally into corporate workstations, payroll, or internal source code repos. The blast radius is strictly contained to the single DMZ machine." },
        { "text": "Because hackers do not know how to run Linux commands inside a DMZ", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because web servers automatically self-destruct when hacked", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because internal employee workstations do not have IP addresses", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The foundational principle of Zero Trust Architecture (NIST SP 800-207) is 'Never Trust, Always ___'.",
      "blankAnswer": "verify",
      "blankDistractors": ["encrypt", "block", "permit"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive 3-Legged DMZ Firewall & Lateral Movement Isolation Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>DMZ Lateral Movement Containment Engine</h3><p>Zone: <b style=\"color:#f59e0b;\">DMZ Web Server (192.168.10.5 - COMPROMISED)</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnPivot\" style=\"padding:6px 10px; background:#ef4444; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Attacker: Lateral Scan to LAN (10.0.1.0/24)</button><button id=\"btnSql\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">2. Legit App: Query DB (Port 3306)</button></div><div id=\"dmzLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Test traffic flows through firewall...</div><script>document.getElementById('btnPivot').onclick=()=>{document.getElementById('dmzLog').innerHTML='<b>TRAFFIC FLOW: DMZ &rarr; INTERNAL LAN (Port 445 SMB):</b><br>🚫 <b style=\"color:#ef4444;\">FIREWALL ACTION: DROP!</b><br>• Policy: <i>DENY ALL DMZ &rarr; LAN</i><br>• Result: Attacker lateral movement BLOCKED! Internal workstations safe.';}; document.getElementById('btnSql').onclick=()=>{document.getElementById('dmzLog').innerHTML='<b>TRAFFIC FLOW: DMZ &rarr; DB SUB (Port 3306):</b><br>✅ <b style=\"color:#10b981;\">FIREWALL ACTION: ALLOW</b><br>• Policy: <i>ALLOW DMZ:192.168.10.5 &rarr; DB:10.0.5.2:3306</i><br>• Web application operates normally!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
