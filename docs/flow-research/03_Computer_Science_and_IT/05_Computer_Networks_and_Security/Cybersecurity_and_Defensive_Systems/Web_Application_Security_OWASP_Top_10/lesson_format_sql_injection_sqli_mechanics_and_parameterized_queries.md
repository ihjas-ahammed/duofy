# Duofy Reusable Lesson Format: SQL Injection (SQLi) Mechanics and Parameterized Queries

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Cybersecurity_and_Defensive_Systems / Web_Application_Security_OWASP_Top_10`  
**Lesson Format Type:** `sql_injection_sqli_mechanics_and_parameterized_queries`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the interpreter parsing flaws, syntax breakout techniques, and parameterized query compiler defenses of SQL Injection (SQLi) (OWASP Top 10 2021 A03: Injection; PortSwigger Web Security Academy; Stuttard & Pinto *The Web Application Hacker's Handbook* Chapter 9): analyze why dynamic string concatenation allows user data to alter SQL Abstract Syntax Tree (AST) grammar, master the **4 Major SQLi Variants** (**Classic/Tautology Bypass [`' OR '1'='1' -- `]**, **Union-Based Extraction [`' UNION SELECT null, username, password FROM users -- `]**, **Error-Based Exploitation**, and **Blind Inference [Boolean `' AND 1=1 --` vs Time-Based `WAITFOR DELAY '0:0:5'` / `pg_sleep(5)`]**), and prove why **Prepared Statements / Parameterized Queries (PDO, PreparedStatement)** provide 100% mathematical immunity by pre-compiling the SQL query structure before binding user input as strict data literals.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | SQL Injection Syntax Breakout, AST Mutation, & Prepared Statements Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Compilation and Data Binding of a Parameterized SQL Query Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | SQLi Technique / Countermeasure & Technical Mechanism Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Programming Construct That Completely Neutralizes SQLi by Pre-Compiling Query Trees (Prepared Statement / Parameterized Query) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why Prepared Statements Prevent SQL Injection Even If User Input Contains Malicious SQL Syntax Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State SQLi & Prepared Statements (OWASP A03; Stuttard & Pinto Chapter 9):
   - **The Root Cause of SQL Injection:**
     $$\mathbf{\text{Query: } \text{"SELECT * FROM users WHERE user = '" } + \text{input} + \text{"' AND pass = '" } + \text{pass} + \text{"'"}}$$
     - Injected input: `' OR '1'='1' -- `
     - Resulting SQL: `SELECT * FROM users WHERE user = '' OR '1'='1' -- ' AND pass = ''` $\implies$ Evaluates to `TRUE`, logs in as admin!
   - **The 4 SQLi Archetypes:**
     1. **In-Band / Union-Based:** Extracted data reflected directly in HTTP response.
     2. **Error-Based:** Forces database runtime errors that leak table names.
     3. **Blind Boolean:** Infers data bit-by-bit via True/False HTTP responses.
     4. **Blind Time-Based:** Infers data bit-by-bit via injected execution delays (`pg_sleep(5)`).
   - **The Defense: Prepared Statements (Parameterized Queries):**
     $$\mathbf{\text{db.prepare("SELECT * FROM users WHERE user = ? AND pass = ?").execute([user\_input, pass\_input])}}$$
     - Database compiles SQL grammar tree **FIRST**; user input is treated as raw data bytes, never code!
2. **Slide 2 (`ordering`):** Provide 5 steps of executing a Prepared Statement: (1) application sends SQL template containing parameter placeholders (?) to database engine, (2) database engine parses SQL syntax and compiles an immutable execution plan / query tree, (3) application sends raw user input strings separately across binary protocol wire, (4) database binds user input values directly into pre-compiled parameter slots, (5) database executes query plan treating malicious characters (quotes, semicolons, comments) as literal data string bytes with zero syntax mutation!
3. **Slide 3 (`matching`):** Pair 4 SQL concepts (Union-Based SQLi, Blind Time-Based SQLi, Prepared Statement, Input Sanitization) with their descriptions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that prepared statements neutralize SQLi. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why prepared statements are immune: Why is a Prepared Statement (Parameterized Query) completely impervious to SQL Injection attacks even if an attacker submits malicious SQL code such as `admin' OR 1=1; DROP TABLE users; -- ` as their username? (Because in a prepared statement, the database engine **parses, analyzes, and compiles the SQL syntax tree BEFORE user input is ever received**; the structure and grammar of the query are fixed in memory, and the database subsequently treats the entire attacker payload as a single, harmless **literal string scalar value** bound to the parameter placeholder, making it mathematically impossible for user input to modify the compiled query logic).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "sql_injection_sqli_mechanics_and_parameterized_queries",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: SQL Injection & Parameterized Defense (OWASP A03)**\n• **Vulnerable Dynamic Concatenation (PortSwigger Web Security Academy):**\n$$\n\\mathbf{\\text{SQL} = \\text{\"SELECT * FROM accounts WHERE id = '\"} + \\text{user\\_input} + \\text{\"'\"}}\n$$\n• **The Syntax Breakout:** Injecting `' OR '1'='1' -- ` rewrites the Abstract Syntax Tree (AST) grammar:\n$$\n\\mathbf{\\text{SELECT * FROM accounts WHERE id = '' } \\mathbf{\\text{OR '1'='1'}} \\ \\text{-- ' (Always TRUE!)}}\n$$\n• **The Mathematical Defense: Prepared Statements (Parameterized Queries):**\n$$\n\\mathbf{\\text{stmt} = \\text{db.prepare(\"SELECT * FROM accounts WHERE id = ?\") ; stmt.execute([user\\_input])}}\n$$\n• **The Invariant:** Query structure is compiled **BEFORE** user input is bound. User data **CANNOT alter execution logic**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential execution steps of a Prepared Statement (Parameterized Query) defeating an SQL Injection attack.",
      "orderItems": [
        "Application transmits SQL template string with parameter placeholders: 'SELECT * FROM users WHERE user = ? AND pass = ?'",
        "Database SQL compiler parses grammar, builds Abstract Syntax Tree (AST), and compiles an immutable execution plan",
        "Application transmits raw attacker input ('admin\\' OR 1=1 --') separately across the database binary connection",
        "Database binds the raw input string directly into the designated parameter memory slot without re-parsing query syntax",
        "Database engine executes pre-compiled query, searching for literal username matching 'admin\\' OR 1=1 --' with zero code execution"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each SQL Injection Technique / Defense to its exact Operational Mechanism.",
      "matchPairs": [
        { "left": "Union-Based SQLi", "right": "Appends malicious queries using UNION operator to extract sensitive table columns into HTTP responses" },
        { "left": "Blind Time-Based SQLi", "right": "Infers database schema and character data by measuring conditional server response delays (pg_sleep)" },
        { "left": "Prepared Statement", "right": "Pre-compiles SQL grammar tree so user input is treated strictly as literal data variables" },
        { "left": "Tautology Injection", "right": "Injects boolean TRUE conditions (e.g. ' OR 1=1 --) to bypass authentication login forms" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The programming technique that pre-compiles query structure to eliminate SQL injection is a ___ statement.",
      "blankAnswer": "prepared",
      "blankDistractors": ["dynamic", "concatenated", "filtered"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is a Prepared Statement (Parameterized Query) completely immune to SQL Injection attacks even if an attacker submits complex malicious SQL syntax such as 'admin' OR 1=1; DROP TABLE users; -- as their input?",
      "options": [
        { "text": "The database engine parses, analyzes, and compiles the SQL query's Abstract Syntax Tree (AST) execution plan BEFORE user input is ever supplied; the structure and grammar of the query are fixed permanently in database memory, and when user input is subsequently supplied, the database treats the entire malicious string as a single, literal text scalar value bound to the parameter placeholder, making it mathematically impossible for user data to break out of its data container and alter the compiled query logic", "isCorrect": true, "explanation": "Correct! This is the definitive mathematical reason why prepared statements eliminate SQL injection (OWASP SQL Injection Prevention Cheat Sheet; PortSwigger Web Security Academy). 1. **How String Concatenation Fails:** - When code does `query = 'SELECT * FROM users WHERE name = ' + input`, the database receives one monolithic text string. - The database SQL parser runs on the ENTIRE string, parsing the attacker's `' OR 1=1; DROP TABLE users;` as executable SQL control grammar. 2. **How Prepared Statements Work:** - **Step 1 (Compile Phase):** `prepare('SELECT * FROM users WHERE name = ?')`. The database parses `SELECT`, `FROM`, `WHERE`, and creates a compiled binary execution tree with a blank parameter slot `?`. - **Step 2 (Data Binding Phase):** The app sends the payload `admin' OR 1=1; DROP TABLE users; --`. - The database DOES NOT re-parse the query. It simply assigns that string as the literal search value. - The database queries: *Find user whose exact legal username on their passport is literally `admin' OR 1=1; DROP TABLE users; --`*. - Since no user has that exact name, it safely returns 0 rows. 3. Zero injection is possible." },
        { "text": "Because prepared statements automatically delete all single quote characters", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because prepared statements encrypt all database tables with AES-256", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because prepared statements only work with numerical user input", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
