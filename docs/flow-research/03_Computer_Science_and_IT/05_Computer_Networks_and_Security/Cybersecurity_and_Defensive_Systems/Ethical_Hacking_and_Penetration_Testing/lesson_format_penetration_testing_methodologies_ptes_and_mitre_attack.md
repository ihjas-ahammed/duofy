# Duofy Reusable Lesson Format: Penetration Testing Methodologies (PTES and MITRE ATT&CK)

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cybersecurity_and_Defensive_Systems / Ethical_Hacking_and_Penetration_Testing`  
**Lesson Format Type:** `penetration_testing_methodologies_ptes_and_mitre_attack`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the professional lifecycle phases, operational frameworks, and adversary behavioral taxonomy of penetration testing (Penetration Testing Execution Standard PTES; MITRE ATT&CK Enterprise Matrix; Georgia Weidman *Penetration Testing* Chapter 1–2; NIST SP 800-115): master the **7 Sequential Phases of the PTES Standard** (**1. Pre-engagement Interactions [Scoping, Rules of Engagement RoE, legal authorization]**, **2. Intelligence Gathering [OSINT / Reconnaissance]**, **3. Threat Modeling**, **4. Vulnerability Analysis**, **5. Exploitation [Weaponization & initial foothold]**, **6. Post-Exploitation [Privilege escalation, credential dumping, persistence, lateral movement]**, and **7. Reporting [Executive summaries, CVSS technical risk scoring, remediation plans]**), map offensive tactics to the **MITRE ATT&CK Matrix TTPs (Tactics, Techniques, and Procedures)**, and distinguish Black-Box, White-Box, and Gray-Box testing methodologies.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | PTES 7-Phase Master Flowchart, MITRE ATT&CK Matrix, & Testing Types Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Chronological Progression of a Professional PTES Penetration Test Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | PTES Phase / Testing Methodology & Core Deliverable Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Legal Document Defining Boundaries, Test Windows, and Authorized IP Targets (Rules of Engagement / RoE) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why Black-Box Penetration Testing Differs from White-Box Testing in Real-World Security Audits Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State PTES & MITRE ATT&CK (PTES Standard; NIST SP 800-115):
   - **The 7 PTES Operational Phases:**
     $$\mathbf{\text{1. Pre-engagement} \to \text{2. Intelligence Gathering} \to \text{3. Threat Modeling} \to \text{4. Vulnerability Analysis} \to \text{5. Exploitation} \to \text{6. Post-Exploitation} \to \text{7. Reporting}}$$
   - **Testing Paradigms:**
     - **Black-Box:** Zero prior knowledge of target (simulates external adversary).
     - **White-Box:** Full access to source code, architecture diagrams, and credentials (comprehensive audit).
     - **Gray-Box:** Partial user-level knowledge/credentials (simulates malicious insider).
   - **MITRE ATT&CK Matrix:** 14 Tactical Columns (Reconnaissance $\to$ Resource Development $\to$ Initial Access $\to$ Execution $\to$ Persistence $\to$ Privilege Escalation $\to$ Defense Evasion $\to$ Credential Access $\to$ Discovery $\to$ Lateral Movement $\to$ Collection $\to$ Command & Control $\to$ Exfiltration $\to$ Impact).
2. **Slide 2 (`ordering`):** Provide 5 steps of the PTES lifecycle: (1) sign formal Rules of Engagement (RoE) and define IP scope boundaries with client, (2) conduct passive OSINT and active port scanning during Intelligence Gathering, (3) identify unpatched CVEs and misconfigurations during Vulnerability Analysis, (4) launch targeted exploit to establish initial access shell during Exploitation, (5) perform privilege escalation, dump credentials, and author comprehensive executive/technical remediation Report!
3. **Slide 3 (`matching`):** Pair 4 PTES terms (Pre-engagement, Intelligence Gathering, Post-Exploitation, Reporting) with their deliverables.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Rules of Engagement (RoE). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Black-Box vs White-Box testing: An enterprise hires a red team to perform a penetration test. The security team provides the testers with complete source code repository access, API documentation, network architecture diagrams, and developer credentials. What type of penetration test is being conducted, and what is its primary advantage over a Black-Box assessment? (This is a **White-Box (Crystal-Box) Penetration Test**; its primary advantage is **maximum depth, speed, and thoroughness** because testers do not waste billable hours guessing hidden API routes or reverse-engineering obfuscated binaries, allowing them to systematically audit all application code paths and uncover deep logic flaws that a surface-level black-box test might overlook).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "penetration_testing_methodologies_ptes_and_mitre_attack",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Penetration Testing Execution Standard (PTES)**\n• **The 7 Chronological PTES Phases (NIST SP 800-115):**\n$$\n\\mathbf{\\text{1. Pre-engagement} \\ \\longrightarrow \\ \\text{2. OSINT Recon} \\ \\longrightarrow \\ \\text{3. Threat Modeling} \\ \\longrightarrow \\ \\text{4. Vulnerability Analysis}}\n$$\n$$\n\\mathbf{\\longrightarrow \\ \\text{5. Exploitation} \\ \\longrightarrow \\ \\text{6. Post-Exploitation (Lateral Movement)} \\ \\longrightarrow \\ \\mathbf{\\text{7. Reporting}}}\n$$\n• **Assessment Methodology Spectrum:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Methodology} & \\textbf{Target Knowledge Given} & \\textbf{Simulation Goal} \\\\\n\\hline\n\\mathbf{\\text{Black-Box}} & \\text{Zero information (Blind external)} & \\text{Simulates external unauthorized hacker} \\\\\n\\mathbf{\\text{White-Box}} & \\mathbf{\\text{Full source code, diagrams, credentials}} & \\mathbf{\\text{Comprehensive, high-assurance code audit}} \\\\\n\\mathbf{\\text{Gray-Box}} & \\text{Standard user credentials / architecture} & \\text{Simulates authenticated insider / contractor} \\\\\n\\hline\n\\end{array}\n$$\n• **MITRE ATT&CK Matrix:** Standard taxonomy mapping adversary Tactics, Techniques, and Procedures (TTPs)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential phases of a penetration test following the Penetration Testing Execution Standard (PTES).",
      "orderItems": [
        "Pre-engagement Interactions: Establish scope boundaries, signed liability disclaimers, and formal Rules of Engagement (RoE)",
        "Intelligence Gathering: Perform passive OSINT (whois, Shodan, DNS) and active network asset discovery",
        "Vulnerability Analysis: Execute port scanning, service enumeration, and identify vulnerable software versions (CVEs)",
        "Exploitation: Execute targeted exploit payloads against verified vulnerabilities to gain an initial foothold shell",
        "Post-Exploitation & Reporting: Perform privilege escalation, dump credentials, demonstrate business impact, and deliver final remediation report"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Penetration Testing Phase / Methodology to its exact Core Deliverable.",
      "matchPairs": [
        { "left": "Rules of Engagement (RoE)", "right": "Formal legal contract establishing authorized target IP ranges, testing time windows, and banned actions" },
        { "left": "White-Box Testing", "right": "High-coverage assessment where auditors are provided full access to source code, network maps, and API specs" },
        { "left": "Post-Exploitation Phase", "right": "Evaluating business impact through privilege escalation, credential harvesting (LSASS), and internal pivoting" },
        { "left": "MITRE ATT&CK Matrix", "right": "Globally accessible knowledge base of real-world adversary behavioral tactics, techniques, and procedures (TTPs)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The formal legal document establishing target IP scope, testing windows, and authorized tools is the Rules of ___ (RoE).",
      "blankAnswer": "Engagement",
      "blankDistractors": ["Execution", "Enforcement", "Evaluation"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An enterprise hires a cybersecurity firm to audit a mission-critical financial core application. The client provides the penetration testing team with full access to Git source code repositories, API Swagger specifications, architectural data-flow diagrams, and low-privileged test user credentials. What type of penetration test is this, and what is its primary advantage over a Black-Box test?",
      "options": [
        { "text": "This is a White-Box (Crystal-Box) Penetration Test; its primary advantage is maximum depth, efficiency, and vulnerability coverage, as testers do not waste billable hours blindly brute-forcing hidden URL paths or guessing backend input validation parameters, allowing them to systematically trace all execution logic paths in source code and uncover deep architectural flaws that a surface-level black-box test would likely miss", "isCorrect": true, "explanation": "Correct! This is the standard comparative analysis between White-Box and Black-Box security testing (PTES Standard; NIST SP 800-115 Section 2.4; Weidman Chapter 1). 1. **The Limitations of Black-Box Testing:** - In a Black-Box test, the red team receives only an IP address (e.g. `203.0.113.50`). - Testers spend $70\\%$ of their allotted time fuzzing URL directories, mapping DNS names, and guessing parameters. - If an obscure endpoint `/api/v2/admin/reconcile_legacy_ledger` is not linked anywhere in the UI, the black-box tester will never find it, leaving critical vulnerabilities undiscovered. 2. **The White-Box Advantage:** - In a White-Box test, testers review the source code directly (SAST + DAST). - They immediately spot the unauthenticated endpoint in `routes.ts`, inspect the SQL query implementation, and find authorization bypasses in minutes. - It provides the highest return on investment (ROI) and maximum assurance for high-risk software applications." },
        { "text": "This is a Black-Box test; its advantage is that it requires zero legal contracts", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "This is a Social Engineering test; its advantage is testing employee gullibility", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "This is an illegal hack; source code must never be shared with security auditors", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
