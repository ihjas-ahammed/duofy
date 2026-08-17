# Duofy Reusable Lesson Format: Consumer-Driven Contract Testing (CDCT with Pact)

**Target Topic:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Software_Testing_and_Quality_Assurance / Integration_and_End_to_End_Testing`  
**Lesson Format Type:** `consumer_driven_contract_testing_with_pact`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through contract-based microservice verification, decoupled CI pipelines, and breaking change prevention using Consumer-Driven Contract Testing (Beth Skurrie et al. 2014, *Pact Specification*; Ian Robinson *Consumer-Driven Contracts: A Service Evolution Pattern*; Chris Richardson *Microservices Patterns* Chapter 9): analyze why traditional end-to-end integration environments fail at microservice scale ($N \times M$ version combinatorial explosion, environment contention, and multi-service deployment deadlocks), master the **Consumer-Driven Contract Testing (CDCT) Lifecycle** (**Phase 1: Consumer** writes unit tests mocking the provider, defining exact request/response expectations which serialize into a **Pact File [JSON]**; **Phase 2: Pact Broker** stores and versions contract matrices; **Phase 3: Provider** replays the Pact contract in isolation against its local endpoint in CI to verify compatibility), and evaluate why CDCT enables true independent deployments with zero full-stack integration environments.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | CDCT 3-Phase Lifecycle Diagram (Consumer $\to$ Pact Broker $\to$ Provider Verification) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Chronological Execution of a Pact Contract Creation and Verification Pipeline Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Contract Testing Construct / Pact Entity & Operational Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Contract Testing, the Central Server Storing and Versioning Pact Contracts Is the Pact ___ (Broker) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why Consumer-Driven Contracts Enable Independent Deployments in Microservices Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State CDCT & Pact (Skurrie 2014; Richardson Ch 9):
   - **The CDCT 3-Phase Architectural Flow:**
     $$\mathbf{\text{Consumer (Service A)}} \xrightarrow{\text{Runs Unit Test}} \mathbf{\text{Generates Pact File (JSON)}} \xrightarrow{\text{Publishes}} \mathbf{\text{Pact Broker}} \xleftarrow{\text{Replays \\& Verifies}} \mathbf{\text{Provider (Service B)}}$$
   - **Why Consumer-Driven?**
     - Provider exposes 50 fields, but Consumer uses only 2 fields (`id`, `total`).
     - If Provider renames an unused field (`customer_notes` $\to$ `notes`), Consumer contract **DOES NOT BREAK**!
     - Provider knows *exactly* which consumers depend on which fields!
   - **The can-i-deploy Invariant:** Querying `pact-broker can-i-deploy` guarantees zero breaking API changes in production.
2. **Slide 2 (`ordering`):** Provide 5 steps of Pact contract testing: (1) consumer writes unit test defining mock HTTP interaction (request path, headers, expected response body), (2) consumer test executes against local Pact mock server and generates a verified Pact JSON file, (3) consumer CI publishes the Pact contract to the central Pact Broker, (4) provider CI pipeline downloads the Pact contract from the broker, (5) provider test runner replays recorded requests against real provider controller endpoints and publishes verification results back to broker!
3. **Slide 3 (`matching`):** Pair 4 concepts (Consumer, Provider, Pact Contract File, can-i-deploy Tool) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Pact Broker. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on how CDCT enables independent deployments: How does Consumer-Driven Contract Testing (Pact) allow 50 different microservice teams to deploy independently dozens of times per day without running a shared staging environment containing all 50 services? (In a shared staging environment, testing requires all 50 services to be online simultaneously, creating constant blocking bottlenecks whenever one service is broken or deploying; **with Pact, every service is tested independently in isolation: Consumers verify against a fast local Pact mock in unit tests, and Providers verify against recorded Pact contracts in local CI; the Pact Broker's `can-i-deploy` tool verifies that the exact versions of Consumer and Provider have passed mutual contract verification before deployment**, guaranteeing compatibility without full-stack integration environments).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "consumer_driven_contract_testing_with_pact",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Consumer-Driven Contract Testing — CDCT (Pact Specification 2014)**\n• **The 3-Tier Distributed Verification Architecture:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Contract Testing Phase} & \\textbf{System Execution Location} & \\textbf{Core Technical Action} \\\\\n\\hline\n\\mathbf{\\text{1. Consumer Testing}} & \\text{Consumer Local Unit Test} & \\mathbf{\\text{Mocks Provider; Generates Pact JSON Contract}} \\\\\n\\mathbf{\\text{2. Contract Storage}} & \\mathbf{\\text{Central Pact Broker}} & \\text{Versions contracts \\& manages verification matrix} \\\\\n\\mathbf{\\text{3. Provider Verification}} & \\text{Provider Local CI Pipeline} & \\mathbf{\\text{Replays Pact requests against live endpoints}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Consumer-Driven Invariant (Ian Robinson):**\n  - Contracts specify **ONLY the fields the consumer actually uses**!\n  - Providers can safely refactor/delete unused fields without breaking consumers!\n• **The `can-i-deploy` Invariant:** CLI queries the compatibility matrix before production release to **guarantee 100% API compatibility with ZERO runtime staging environments**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed across a complete Consumer-Driven Contract Testing lifecycle using Pact.",
      "orderItems": [
        "The Consumer team writes a unit test defining exact expected HTTP request headers, paths, and response payloads",
        "The consumer test runs against the local Pact mock server, passing successfully and serializing the contract into a Pact JSON file",
        "The Consumer CI pipeline publishes the generated Pact contract artifact to the centralized Pact Broker",
        "The Provider CI pipeline triggers, downloads the relevant consumer Pact contracts from the broker, and replays recorded requests against real endpoints",
        "The Provider test runner asserts actual responses against the contract and publishes verification success results back to the Pact Broker"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Contract Testing Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Pact Contract (JSON)", "right": "Standardized schema capturing exact HTTP interactions, request headers, query parameters, and response bodies" },
        { "left": "Pact Broker", "right": "Central service repository storing, versioning, and visualizing compatibility matrices between microservices" },
        { "left": "can-i-deploy CLI Tool", "right": "Pre-deployment gate checking if target consumer and provider versions have mutually verified contracts" },
        { "left": "Provider State Callback", "right": "Hook setting up database fixtures on the provider side before Pact replays a specific test scenario" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Pact contract testing, the central repository storing and versioning contract matrices is the Pact ___.",
      "blankAnswer": "Broker",
      "blankDistractors": ["Server", "Gateway", "Runner"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How does Consumer-Driven Contract Testing (Pact) eliminate the need for shared staging integration environments across dozens of distributed microservices while guaranteeing zero breaking API changes in production?",
      "options": [
        { "text": "In shared staging environments, testing requires all 50 microservices to be deployed, healthy, and configured simultaneously, creating continuous deployment blockades whenever any single service crashes or is being upgraded; with Pact, each microservice tests its integrations completely in isolation: the Consumer verifies against a local in-memory Pact mock during fast unit tests, and the Provider verifies against the recorded Pact contract in its own isolated CI pipeline; the Pact Broker's can-i-deploy tool algebraically verifies that the two versions have mutually satisfied the contract before deployment, guaranteeing runtime compatibility with zero full-stack staging overhead", "isCorrect": true, "explanation": "Correct! This is Beth Skurrie and Chris Richardson's primary architectural justification for Contract Testing (Pact Documentation; Chris Richardson *Microservices Patterns* Chapter 9). 1. **The Shared Staging Nightmare (The Integration Trap):** - Company has 40 microservices. - To test a single 5-line change in Service A: You must deploy all 40 services to a staging Kubernetes cluster. - Service 12 is currently broken by Team B $\\implies$ Your test fails! - Service 27 database ran out of disk $\\implies$ Your test fails! - Staging environments are perpetually broken, expensive, and slow down release velocity by weeks. 2. **The Pact Mathematical Invariant:** - Service A (Consumer) says: *\"When I send `GET /users/1`, I expect `{'id': 1, 'name': 'Alice'}`.\"* - This expectation is saved into a JSON file (`ServiceA-ServiceB.pact.json`). - When Team B opens a PR on Service B: Service B's local CI starts Service B in isolation, loads the JSON file, fires `GET /users/1`, and verifies that the output has `id` and `name`! 3. **The Deployment Independence:** - Both services test **in parallel in under 10 seconds** without ever talking over a real staging network! - The `can-i-deploy` tool checks the matrix: Service A v2.1 $\\leftrightarrow$ Service B v1.4 = **VERIFIED PASS** $\\implies$ Deploy directly to production with $100\\%$ confidence!" },
        { "text": "Because Pact automatically rewrites microservice code in assembly language", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because contract testing deletes all HTTP request headers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because microservices are legally prohibited from using REST APIs", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
