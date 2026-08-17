# Duofy Reusable Lesson Format: Broken Access Control and Insecure Direct Object References (IDOR)

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cybersecurity_and_Defensive_Systems / Web_Application_Security_OWASP_Top_10`  
**Lesson Format Type:** `broken_access_control_and_insecure_direct_object_references_idor`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the authorization failures, privilege escalation vectors, and object-level verification models of Broken Access Control and Insecure Direct Object References (IDOR) (OWASP Top 10 2021 A01: Broken Access Control [#1 Global Web Security Risk]; PortSwigger Web Security Academy; Stuttard & Pinto Chapter 8): master **IDOR Mechanics** (where an application exposes direct database primary keys or filenames in client-accessible parameters e.g. `GET /api/documents/5081` without verifying whether the requesting authenticated session owns that document), distinguish **Vertical Privilege Escalation (Standard User $\to$ Admin via Forced Browsing e.g. `/admin/delete_user`)** from **Horizontal Privilege Escalation (User A $\to$ User B's private account at same privilege tier)**, analyze the vulnerabilities of client-side hidden fields and mass assignment, and master **Defensive Architecture** (Server-Side Authorization Checks: `WHERE id = ? AND tenant_id = session.tenant_id`, Role-Based Access Control [RBAC], Attribute-Based Access Control [ABAC], and Indirect Nonce/UUID Object Mapping).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | OWASP A01 Broken Access Control Taxonomy, IDOR Diagram, & RBAC Defense Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step IDOR Exploit Trajectory from Parameter Tampering to Unauthorized Access Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Access Control Vulnerability / Defense Construct & Security Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The OWASP Acronym for Flaws Where Users Modify Object IDs in URLs to Access Others' Data (IDOR) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why Relying on Client-Side UI Hiding Fails to Prevent Broken Access Control Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Broken Access Control & IDOR (OWASP 2021 A01; PortSwigger Academy):
   - **The #1 Global Vulnerability (OWASP A01):**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Vulnerability Class} & \textbf{Attack Vector} & \textbf{Consequence} \\
     \hline
     \mathbf{\text{Horizontal Escalation (IDOR)}} & \text{Modifying } \text{/api/invoices/101} \to \text{/102} & \mathbf{\text{Accessing peer tenant's private financial data}} \\
     \mathbf{\text{Vertical Escalation}} & \text{Forced browsing to } \text{/admin/users} & \mathbf{\text{Standard user executes administrator commands}} \\
     \mathbf{\text{Mass Assignment}} & \text{Adding } \text{\"role\": \"admin\"} \text{ in JSON POST} & \mathbf{\text{Overwriting protected database model properties}} \\
     \hline
     \end{array}$$
   - **The Root Flaw of IDOR:** The backend trusts the client-provided object ID without validating if `current_user.id == resource.owner_id`!
   - **The Server-Side Defense:**
     $$\mathbf{\text{SELECT * FROM invoices WHERE id = :invoice\_id } \mathbf{\text{AND user\_id = :authenticated\_user\_id}}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of an IDOR exploitation: (1) user logs in legitimately as User A (ID: 104) and views their medical profile at `/api/v1/patients/104/records`, (2) user inspects network tab and notices the URL explicitly references their integer database ID (104), (3) user modifies the URL parameter in Burp Suite or browser address bar to `/api/v1/patients/105/records`, (4) vulnerable backend queries database for patient record #105 without checking if session belongs to patient #105, (5) backend returns patient #105's confidential medical records to User A (Horizontal Privilege Escalation)!
3. **Slide 3 (`matching`):** Pair 4 access control concepts (Horizontal Privilege Escalation, Vertical Privilege Escalation, IDOR, Server-Side Authorization Check) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of the IDOR acronym. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why client-side UI hiding fails: A web application hides the 'Admin Panel' button in the navigation bar using CSS (`display: none;` or React `{user.isAdmin && <AdminButton />}`). Why does this fail to prevent Broken Access Control if a standard user navigates directly to `https://example.com/api/admin/delete_user`? (Because **client-side UI controls are completely untrusted and controllable by the user**; an attacker can easily bypass client-side CSS/React conditions by inspecting source code or using API tools like cURL/Burp Suite to send HTTP POST requests directly to `/api/admin/delete_user`; **access control MUST be enforced on the backend server for every single API endpoint** by verifying the user's cryptographically validated session role before executing administrative operations).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "broken_access_control_and_insecure_direct_object_references_idor",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Broken Access Control & IDOR (OWASP Top 10 A01)**\n• **Access Control Threat Taxonomy (PortSwigger Web Security Academy):**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Vulnerability} & \\textbf{Exploit Mechanism} & \\textbf{Impact} \\\\\n\\hline\n\\mathbf{\\text{Horizontal (IDOR)}} & \\text{Tampering with Object ID (\\texttt{/user/101} $\\to$ \\texttt{/102})} & \\mathbf{\\text{Reads/Modifies peer user's private data}} \\\\\n\\mathbf{\\text{Vertical Escalation}} & \\text{Forced browsing to administrative API routes} & \\mathbf{\\text{Standard user assumes superuser capabilities}} \\\\\n\\mathbf{\\text{Missing Function ACL}} & \\text{Calling unauthenticated management endpoints} & \\mathbf{\\text{Unauthorized system reconfigurations}} \\\\\n\\hline\n\\end{array}\n$$\n• **The IDOR Flaw:** Trusting client-supplied IDs without verifying ownership:\n$$\n\\mathbf{\\text{Vulnerable: } \\text{SELECT * FROM files WHERE id = ?}}\n$$\n$$\n\\mathbf{\\text{Secure: } \\text{SELECT * FROM files WHERE id = ? } \\mathbf{\\text{AND user\\_id = :session\\_user\\_id}}}\n$$\n• **Golden Rule:** Enforce authorization checks on **every single server request**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of an Insecure Direct Object Reference (IDOR) exploit resulting in Horizontal Privilege Escalation.",
      "orderItems": [
        "Authenticated User A logs in and clicks 'View Receipt', generating request: GET /api/v1/receipts/5001",
        "User A observes that the URL directly exposes a predictable sequential database identifier ('5001')",
        "User A intercepts request in an HTTP proxy and modifies the ID parameter to target peer User B: GET /api/v1/receipts/5002",
        "Vulnerable backend server queries database for receipt #5002 without verifying if User A owns receipt #5002",
        "Database returns User B's private billing statement, successfully exfiltrated by User A (Horizontal Privilege Escalation)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Access Control Construct to its exact Technical Definition.",
      "matchPairs": [
        { "left": "Horizontal Privilege Escalation", "right": "Attacker accesses private resources belonging to another user with the exact same permission tier" },
        { "left": "Vertical Privilege Escalation", "right": "Attacker elevates permissions from a standard account to execute administrative functions" },
        { "left": "IDOR (Insecure Direct Object Ref)", "right": "Exposing direct internal database keys in user-modifiable parameters without server-side ownership checks" },
        { "left": "Role-Based Access Control (RBAC)", "right": "System restricting system access to authorized users based on formal organizational roles" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The vulnerability where users alter direct database IDs in URLs to access others' private data is abbreviated as ___.",
      "blankAnswer": "IDOR",
      "blankDistractors": ["XSS", "CSRF", "SSRF"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A software team protects an internal administrative function by hiding the 'Delete Database' button in the React UI using: {currentUser.role === 'admin' && <DeleteButton />}. Why is this application still completely vulnerable to Broken Access Control (OWASP A01)?",
      "options": [
        { "text": "Client-side UI code runs entirely on the user's browser and can be modified or bypassed at will; an attacker can inspect JavaScript bundles, discover the API route '/api/admin/delete_db', and send an HTTP POST request directly using tools like cURL, Postman, or Burp Suite; if the backend server fails to validate the authenticated session's cryptographic role token on the server side, the unauthorized command will execute", "isCorrect": true, "explanation": "Correct! This is the most common misconception in web security: confusing client-side UI visibility with server-side authorization (OWASP Top 10 A01; PortSwigger Web Security Academy). 1. **Client-Side Code is 100% Untrusted:** - React, Vue, HTML, and CSS execute on the user's computer. - An attacker can open Chrome DevTools, edit the React state to `currentUser.role = 'admin'`, and the hidden button immediately appears! - More simply, an attacker doesn't even need the button; they can just run `curl -X POST https://example.com/api/admin/delete_db -H 'Cookie: session=user123'`. 2. **The Server-Side Mandate:** - The backend server must NEVER trust the client. - Every API route must execute a server-side middleware: `if (session.user.role !== 'admin') { return 403 Forbidden; }`. - Without server-side checks, hiding UI elements is pure 'Security through Obscurity' and provides zero actual security." },
        { "text": "Because React does not support administrative permissions", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because CSS display:none can only be parsed by mobile browsers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because SQL databases automatically grant admin rights to all users", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
