# Duofy Reusable Lesson Format: RESTful API Design (Richardson Maturity Model and HTTP Semantics)

**Target Topic:** `03_Computer_Science_and_IT / 09_Web_Mobile_and_Cloud_Computing / Web_Technologies / Backend_APIs_REST_GraphQL`  
**Lesson Format Type:** `restful_api_design_richardson_maturity_model_and_http_semantics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through resource-oriented architectural constraints, HTTP method idempotency invariants, status code semantics, and hypermedia design (Roy Thomas Fielding 2000 *Architectural Styles and the Design of Network-based Software Architectures*; Leonard Richardson & Sam Ruby *RESTful Web Services*; Martin Fowler *Richardson Maturity Model*): master **Roy Fielding's 6 REST Constraints** (Client-Server, Statelessness, Cacheability, Uniform Interface, Layered System, Code-on-Demand), master the **HTTP Verb Idempotency & Safety Matrix** (**`GET`:** Safe & Idempotent, **`POST`:** Non-Safe & Non-Idempotent, **`PUT`:** Non-Safe & Idempotent full replacement, **`DELETE`:** Non-Safe & Idempotent), master the **4 Levels of the Richardson Maturity Model (RMM)** (**Level 0:** The Swamp of POX, **Level 1:** Individual Resource URIs, **Level 2:** Standard HTTP Verbs & Status Codes, **Level 3:** **HATEOAS** [Hypermedia As The Engine Of Application State] with dynamic transition links), and select appropriate HTTP status codes ($200, 201, 204, 400, 401, 403, 404, 409, 429, 500, 503$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | HTTP Verb Matrix (Safety vs Idempotency) & Richardson Maturity Model Levels 0-3 Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Architectural Evolution of an API from RPC (Level 0) to HATEOAS (Level 3) Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | REST Architectural Concept / HTTP Verb & Exact Technical Semantic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In RESTful API Design, an HTTP Method That Yields the Same System State Regardless of How Many Times It Is Repeated Is ___ (Idempotent) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Architectural Contrast: Why PUT Is Idempotent While POST Is Non-Idempotent in REST Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State REST & RMM (Fielding 2000; Fowler 2010):
   - **HTTP Verbs & Idempotency Matrix:**
     $$\begin{array}{|l|c|c|l|c|}
     \hline
     \textbf{HTTP Method} & \textbf{Safe?} & \textbf{Idempotent?} & \textbf{Resource Semantics} & \textbf{Typical Status} \\
     \hline
     \mathbf{\texttt{GET}} & \mathbf{\text{YES}} & \mathbf{\text{YES}} & \text{Retrieves resource representation} & 200\text{ OK} \\
     \mathbf{\texttt{POST}} & \text{NO} & \mathbf{\text{NO}} & \mathbf{\text{Creates new subordinate resource}} & 201\text{ Created} \\
     \mathbf{\texttt{PUT}} & \text{NO} & \mathbf{\text{YES}} & \mathbf{\text{Complete replace / upsert at target URI}} & 200 / 204 \\
     \mathbf{\texttt{PATCH}} & \text{NO} & \text{Conditional} & \text{Partial update / delta modification} & 200\text{ OK} \\
     \mathbf{\texttt{DELETE}} & \text{NO} & \mathbf{\text{YES}} & \text{Removes resource permanently} & 204\text{ No Content} \\
     \hline
     \end{array}$$
   - **The Richardson Maturity Model (RMM):**
     $$\mathbf{\text{Level 0: Swamp of POX (1 URI, 1 POST)}} \to \mathbf{\text{Level 1: Resources (Multiple URIs)}} \to \mathbf{\text{Level 2: Verbs (GET/POST/PUT/DEL)}} \to \mathbf{\text{Level 3: HATEOAS (Hypermedia Links)}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of evolving an API to REST Level 3: (1) Level 0: client sends POST /api with XML body `{action: "getAccount", id: 42}` (RPC tunneling), (2) Level 1: API introduces unique Resource URIs: client requests POST /accounts/42, (3) Level 2: API adopts standard HTTP verbs: client sends GET /accounts/42, receiving HTTP 200 OK, (4) Level 2: client sends DELETE /accounts/42, receiving HTTP 204 No Content, (5) Level 3 (HATEOAS): API response includes hypermedia `_links` allowing client to dynamically discover allowed actions (`deposit`, `transfer`, `close`) without hardcoding URLs!
3. **Slide 3 (`matching`):** Pair 4 concepts (Level 0 POX, Level 2 HTTP Verbs, Level 3 HATEOAS, HTTP Idempotency) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Idempotent. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on PUT vs POST idempotency: In RESTful API architecture, why is the `PUT` method strictly defined as idempotent while the `POST` method is non-idempotent? (A `PUT /users/42` request defines the exact target resource URI and payload; **executing `PUT /users/42` 10 times in a row simply replaces the user record at ID 42 with the exact same data 10 times, leaving the final database state identical to executing it once ($f(f(x)) = f(x)$)**; in contrast, a `POST /users` request asks the server to create a new subordinate resource, so **executing `POST /users` 10 times creates 10 distinct user records in the database with 10 different generated IDs, producing 10 side-effects**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "restful_api_design_richardson_maturity_model_and_http_semantics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: RESTful Architecture \\& Richardson Maturity (Roy Fielding; Martin Fowler)**\n• **HTTP Method Idempotency \\& Safety Taxonomy:**\n$$\n\\begin{array}{|l|c|c|l|c|}\n\\hline\n\\textbf{HTTP Method} & \\textbf{Safe?} & \\textbf{Idempotent?} & \\textbf{Resource Contract Semantics} & \\textbf{Success Status} \\\\\n\\hline\n\\mathbf{\\texttt{GET}} & \\mathbf{\\text{YES}} & \\mathbf{\\text{YES}} & \\text{Retrieves resource representation} & 200\\text{ OK} \\\\\n\\mathbf{\\texttt{POST}} & \\text{NO} & \\mathbf{\\text{NO}} & \\mathbf{\\text{Creates new subordinate resource}} & 201\\text{ Created} \\\\\n\\mathbf{\\texttt{PUT}} & \\text{NO} & \\mathbf{\\text{YES}} & \\mathbf{\\text{Replaces entire entity at exact target URI}} & 200 / 204 \\\\\n\\mathbf{\\texttt{PATCH}} & \\text{NO} & \\text{Context} & \\text{Applies partial delta modifications} & 200\\text{ OK} \\\\\n\\mathbf{\\texttt{DELETE}} & \\text{NO} & \\mathbf{\\text{YES}} & \\text{Destroys targeted resource} & 204\\text{ No Content} \\\\\n\\hline\n\\end{array}\n$$\n• **The Richardson Maturity Model (RMM) Progression:**\n$$\n\\mathbf{\\text{L0: Swamp of POX (1 URI)}} \\longrightarrow \\mathbf{\\text{L1: Resources (URIs)}} \\longrightarrow \\mathbf{\\text{L2: HTTP Verbs}} \\longrightarrow \\mathbf{\\text{L3: HATEOAS (Hypermedia Controls)}}\n$$\n• **Mathematical Idempotency Law:** $\\mathbf{f(f(x)) = f(x)}$ (Retrying an idempotent request causes ZERO extra side-effects)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential architectural evolution of an API from RPC (Level 0) to full RESTful HATEOAS (Level 3).",
      "orderItems": [
        "Level 0 (The Swamp of POX): Client dispatches all commands via POST /api with XML/JSON action payloads (RPC tunneling)",
        "Level 1 (Resources): API exposes distinct individual resource endpoints (e.g. /accounts/42 and /orders/108)",
        "Level 2 (HTTP Verbs): API maps standard HTTP verbs to operations (GET to read, DELETE to remove) and uses standard status codes",
        "Level 3 (HATEOAS): API embeds hypermedia navigation links (_links) in payloads allowing clients to discover valid state transitions",
        "Client dynamically navigates the API by following embedded hypermedia links without hardcoding server route paths"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each RESTful Architecture Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "HATEOAS (RMM Level 3)", "right": "Hypermedia controls embedded in responses guiding clients to next valid state transitions" },
        { "left": "HTTP PUT Semantics", "right": "Idempotent replacement of the entire target resource at the specified URI" },
        { "left": "HTTP POST Semantics", "right": "Non-idempotent operation creating a new subordinate resource with server-generated ID" },
        { "left": "HTTP 401 vs 403", "right": "401 represents missing/invalid authentication; 403 represents authenticated but forbidden access" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "An HTTP method that leaves the system in the exact same state whether executed once or ten times is ___.",
      "blankAnswer": "idempotent",
      "blankDistractors": ["stateless", "cacheable", "atomic"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In RESTful API design, why is the HTTP PUT method strictly defined as idempotent while the HTTP POST method is non-idempotent?",
      "options": [
        { "text": "A PUT request specifies the exact target URI and replaces the resource at that URI entirely (e.g. PUT /users/42 with user data); executing PUT /users/42 ten times in a row overwrites the exact same record with the exact same payload ten times, leaving the final database state identical to executing it once (f(f(x)) = f(x)); in contrast, a POST request submits an entity to a collection resource (e.g. POST /users), instructing the server to create a new subordinate resource each time; executing POST /users ten times creates ten distinct user records in the database with ten different generated IDs, producing multiple side-effects", "isCorrect": true, "explanation": "Correct! This is Roy Fielding and Martin Fowler's fundamental distinction between HTTP verbs (Fielding *REST Dissertation*; RFC 9110 HTTP Semantics). 1. **The Math of PUT (Idempotent: $f(f(x)) = f(x)$):** - Target URI: `PUT /users/42` with `{ name: 'Alice', age: 30 }`. - If network drops the ACK packet and client retries $5\\text{ times}$: - The database replaces record 42 five times with `{ name: 'Alice', age: 30 }`. - Result: Exactly ONE user 42 exists with name Alice! Zero side-effects from retrying! 2. **The Math of POST (Non-Idempotent):** - Target URI: `POST /orders` with `{ item: 'MacBook', price: 2000 }`. - If client retries $5\\text{ times}$ on a network timeout: - The database creates Order #101, Order #102, Order #103, Order #104, Order #105! - **Result:** The user's credit card is charged **5 times ($10,000)!** 3. **The Architectural Lesson:** Use **PUT for idempotent updates/upserts** where the client dictates the URI; use **POST for creating subordinate items** where the server generates the ID!" },
        { "text": "Because POST requests are encrypted with SSL while PUT requests are sent in plain text", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because PUT requests can only be sent from Linux operating systems", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because HTTP PUT was removed from the HTTP/2 specification", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
