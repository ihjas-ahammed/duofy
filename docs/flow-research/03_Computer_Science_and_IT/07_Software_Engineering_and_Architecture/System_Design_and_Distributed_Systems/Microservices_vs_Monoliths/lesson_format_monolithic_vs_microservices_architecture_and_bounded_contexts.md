# Duofy Reusable Lesson Format: Monolithic vs Microservices Architecture (and Bounded Contexts)

**Target Topic:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / System_Design_and_Distributed_Systems / Microservices_vs_Monoliths`  
**Lesson Format Type:** `monolithic_vs_microservices_architecture_and_bounded_contexts`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through architectural trade-offs, organizational scaling laws (Conway's Law), and domain boundary decomposition in Monolithic vs Microservices architectures (Chris Richardson 2018 *Microservices Patterns* Chapter 1 & 2; Sam Newman *Building Microservices* 2nd ed.; Eric Evans 2003 *Domain-Driven Design*): contrast the **Monolithic Architecture** (single deployable binary with unified ACID in-memory transactions, excellent for initial development speed) with **Microservices Architecture** (loosely coupled, independently deployable services organized around **Domain-Driven Design [DDD] Bounded Contexts**), master the **Database-per-Service Pattern** (each service owns its private database schema, strictly forbidding shared database tables to prevent tight data coupling), analyze inter-service RPC protocols (REST vs gRPC Protobuf), and prove Conway's Law ("Organizations design systems that mirror their own communication structures").

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Monolith vs Microservices Architecture Matrix, Database-per-Service Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Domain Decomposition: Extracting a DDD Bounded Context into an Autonomous Microservice Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Architectural Construct (DDD Bounded Context, Database-per-Service, Monolith) & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Architecture Pattern Where Each Microservice Strictly Encapsulates Its Own Database Is Database-per-___ (Service) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Architectural Analysis: Why Shared Databases Completely Destroy Microservice Autonomy Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Microservices vs Monoliths (Richardson 2018; Newman 2021):
   - **The Architectural Comparison Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Architectural Dimension} & \textbf{Monolithic Architecture} & \textbf{Microservices Architecture} \\
     \hline
     \mathbf{\text{Deployment Unit}} & \text{Single unified artifact (JAR/WAR/Binary)} & \mathbf{\text{Independent containers (Kubernetes Pods)}} \\
     \mathbf{\text{Database Schema}} & \text{Single shared monolithic ACID DB} & \mathbf{\text{Database-per-Service (Isolated Schemas)}} \\
     \mathbf{\text{Transaction Model}} & \text{Local ACID Transactions (In-memory)} & \mathbf{\text{Distributed Sagas (Eventual Consistency)}} \\
     \mathbf{\text{Failure Domain}} & \text{Entire app crashes on 1 memory leak} & \mathbf{\text{Isolated to specific degraded service}} \\
     \mathbf{\text{Domain Modeling}} & \text{Single unified domain model} & \mathbf{\text{DDD Bounded Contexts per service}} \\
     \hline
     \end{array}$$
   - **Conway's Law Invariant:** *"Organizations which design systems are constrained to produce designs which are copies of the communication structures of these organizations."* (Melvin Conway 1968).
2. **Slide 2 (`ordering`):** Provide 5 steps of extracting a microservice: (1) analyze domain logic and identify a cohesive DDD Bounded Context (e.g. Invoicing & Billing), (2) define clean public API contract (OpenAPI / gRPC Protobuf) for the billing domain, (3) split monolithic database tables into an isolated private PostgreSQL database for the new service, (4) implement autonomous billing microservice and deploy to container cluster, (5) refactor callers in monolith to invoke the billing microservice via API rather than direct database queries!
3. **Slide 3 (`matching`):** Pair 4 concepts (DDD Bounded Context, Database-per-Service, Monolith, Conway's Law) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Database-per-Service. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why shared databases destroy microservice benefits: Why is sharing a single central SQL database across multiple microservices considered a catastrophic anti-pattern that negates the primary benefits of microservice architecture? (If multiple microservices directly read and write to the same shared SQL tables, any database schema migration (such as renaming a column or changing a table structure) requires **coordinated lockstep deployments across all service teams simultaneously**, completely destroying deployment independence; **furthermore, services bypass each other's domain encapsulation and business validation logic by mutating rows directly, causing data corruption, database connection pool exhaustion, and single points of failure across the entire organization**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "monolithic_vs_microservices_architecture_and_bounded_contexts",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Microservices Architecture \\& Domain-Driven Design (Richardson 2018; Newman 2021)**\n• **Monolith vs Microservices Trade-Off Matrix:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Architectural Axis} & \\textbf{Monolithic System} & \\textbf{Microservices System} \\\\\n\\hline\n\\mathbf{\\text{Deployment Unit}} & \\text{Single unified artifact (JAR/Binary)} & \\mathbf{\\text{Independently deployable OCI containers}} \\\\\n\\mathbf{\\text{Database Boundary}} & \\text{Single monolithic database schema} & \\mathbf{\\text{Database-per-Service (Strict encapsulation)}} \\\\\n\\mathbf{\\text{Transaction Model}} & \\text{Local in-memory ACID transactions} & \\mathbf{\\text{Distributed Sagas (Eventual consistency)}} \\\\\n\\mathbf{\\text{Blast Radius}} & \\text{Single OutOfMemoryError crashes entire app} & \\mathbf{\\text{Fault-isolated to single degraded Pod}} \\\\\n\\mathbf{\\text{Domain Boundaries}} & \\text{Global domain models with tight coupling} & \\mathbf{\\text{Domain-Driven Design (DDD) Bounded Contexts}} \\\\\n\\hline\n\\end{array}\n$$\n• **Conway's Law Invariant:** Software architecture naturally mirrors the communication structures of the engineering teams building it!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed to extract a new microservice from a monolith using Domain-Driven Design (DDD).",
      "orderItems": [
        "Analyze business capabilities and define a distinct Domain-Driven Design (DDD) Bounded Context (e.g. Payment Processing)",
        "Design a strict public API interface contract (e.g. gRPC Protobuf or OpenAPI specification) encapsulating payment operations",
        "Extract payment-related SQL tables and migrate them into an isolated, independent private database instance",
        "Implement and deploy the Payment Microservice as an independently scalable container in the Kubernetes cluster",
        "Refactor the legacy monolith to invoke the Payment Microservice via network API calls rather than direct internal database queries"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Distributed System Architecture Concept to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "DDD Bounded Context", "right": "Explicit domain boundary within which a specific business domain model applies consistently" },
        { "left": "Database-per-Service Pattern", "right": "Architectural rule where each microservice owns its private datastore inaccessible to other services" },
        { "left": "Monolithic Architecture", "right": "Single deployable executable bundling all UI, business logic, and database access into one runtime" },
        { "left": "Conway's Law", "right": "Socio-technical law stating software system structure reflects organizational communication boundaries" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The microservice architectural pattern where each service strictly owns its private database is Database-per-___.",
      "blankAnswer": "Service",
      "blankDistractors": ["Server", "Cluster", "Table"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is allowing multiple microservices to read and write directly to a single shared SQL database considered a critical architectural anti-pattern that destroys the core benefits of microservices?",
      "options": [
        { "text": "Direct database sharing creates tight coupling at the data layer; any change to a database table schema (such as renaming or dropping a column) requires coordinating, modifying, testing, and deploying all microservice applications simultaneously in a high-risk lockstep release, completely negating independent deployability; furthermore, services bypass domain business rules and validation logic by altering rows directly, creating data corruption and database connection pool exhaustion across the entire cluster", "isCorrect": true, "explanation": "Correct! This is Chris Richardson and Sam Newman's primary rule for microservices (Chris Richardson *Microservices Patterns* Chapter 1; Sam Newman *Building Microservices* Chapter 4). 1. **The Shared Database Illusion:** - A team splits their monolith into 10 services, but keeps 1 shared Oracle/Postgres database. - They think they have microservices. In reality, they built a **'Distributed Monolith'** (the worst of all worlds!). 2. **The Lockstep Deployment Nightmare:** - Service A wants to rename `customer_address` to `address_line_1`. - Because Service B, C, and D also query that table directly: Service A cannot deploy until Teams B, C, and D update and deploy their code at the exact same hour! - You lose independent deployments, independent scaling, and fault isolation. 3. **The Database-per-Service Solution:** - Service A owns `CustomerDB`. Nobody else has database credentials. - If Service B needs customer data: It calls `GET /customers/123` on Service A's API. - Service A is 100% free to refactor its internal SQL schema, switch from Postgres to MongoDB, or optimize queries without asking anyone for permission!" },
        { "text": "Because SQL databases are only capable of serving a single user", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because microservices can only communicate using magnetic tape", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because shared databases cause hard drives to permanently erase themselves", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
