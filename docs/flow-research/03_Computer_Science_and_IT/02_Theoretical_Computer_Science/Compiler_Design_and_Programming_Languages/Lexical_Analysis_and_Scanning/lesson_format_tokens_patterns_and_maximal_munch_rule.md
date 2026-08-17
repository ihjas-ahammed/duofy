# Duofy Reusable Lesson Format: Tokens, Patterns, and Maximal Munch Rule

**Target Topic:** `03_Computer_Science_and_IT / 02_Theoretical_Computer_Science / Compiler_Design_and_Programming_Languages / Lexical_Analysis_and_Scanning`  
**Lesson Format Type:** `tokens_patterns_and_maximal_munch_rule`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the distinction between tokens, patterns, and lexemes, and the ambiguity resolution heuristics of the Maximal Munch (Longest Match) and Rule Priority principles in compiler lexical analysis (Alfred V. Aho et al. *The Dragon Book* Chapter 3; Vern Paxson 1990): define the **Token 3-Tier Hierarchy** (**Token: abstract grammatical category**, **Pattern: formal regular expression description**, and **Lexeme: concrete source text character sequence**), master the **Maximal Munch Invariant** (the lexer always consumes the longest prefix of characters that matches any valid regular expression pattern), master the **Rule Priority Invariant** (if multiple distinct patterns match the exact same character prefix length, the rule defined earliest in the specification file wins), and trace lexer disambiguation on keywords, identifiers, and compound operators (e.g. `if_count`, `++`, `>>`).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Token vs Pattern vs Lexeme Hierarchy, Maximal Munch, & Rule Priority Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Maximal Munch Token Scanning and Rollback Sequence Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Lexical Term / Disambiguation Principle & Compiler Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Lexer Rule That Consumes the Longest Possible Matching Prefix (Maximal Munch) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Resolution of Keyword vs Identifier Conflicts Using Maximal Munch and Priority Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Lexical Concepts & Ambiguity Rules (Dragon Book Chapter 3):
   - **The 3-Tier Lexical Hierarchy:**
     - **Token:** Abstract category passed to parser (e.g. `IF`, `ID`, `ASSIGN`, `NUM`).
     - **Pattern:** The formal regex defining valid sequences (e.g. `[a-zA-Z_][a-zA-Z0-9_]*`).
     - **Lexeme:** The concrete source string matched (e.g. `"total_score"`, `"=="`, `"1042"`).
   - **The 2 Disambiguation Axioms:**
     1. **Maximal Munch (Longest Match):** The scanner continues advancing lookahead as long as the DFA can reach another valid accepting state.
        - Example: In input `if_value`, scanner matches single identifier `if_value` rather than keyword `if` and `_value`.
        - Example: In input `+++`, scanner matches operator `++` followed by `+`.
     2. **Rule Priority (First-Rule-Wins):** When two rules match the *exact same* length (e.g. input `"if"` matches both keyword rule `"if"` and general identifier regex `[a-z]+`), the rule declared **earlier in the lexer file** takes precedence!
2. **Slide 2 (`ordering`):** Provide 5 steps of the Maximal Munch scanning algorithm: (1) set lexemeBegin pointer to the current input character and initialize the DFA to its start state, (2) advance the forward lookahead pointer character by character, tracking the most recent accepting DFA state and character position, (3) continue reading until the DFA transitions into a dead/error state with no valid outgoing transitions, (4) roll back the forward lookahead pointer to the position of the most recent accepting state, (5) return the token associated with the highest priority matching rule and reset lexemeBegin!
3. **Slide 3 (`matching`):** Pair 4 lexical concepts (Token, Lexeme, Maximal Munch, Rule Priority) with their descriptions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the longest-match rule is known as Maximal Munch. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on how a compiler lexer correctly classifies the source code string `"while_loop"`: When a lexical analyzer encounters the source code string `"while_loop"`, why does it emit a single `IDENTIFIER` token rather than the keyword `WHILE` followed by `_loop`? (Because under the **Maximal Munch (Longest Match) rule**, the lexer reads ahead until it hits a non-identifier character (such as space or `;`); the entire 10-character string `"while_loop"` matches the identifier pattern `[a-zA-Z_][a-zA-Z0-9_]*`, which is strictly longer than the 5-character match of keyword `"while"`, forcing the lexer to select the 10-character identifier match).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "tokens_patterns_and_maximal_munch_rule",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Lexical Formalisms & Disambiguation (Dragon Book 3)**\n• **The 3-Tier Lexical Hierarchy:**\n$$\n\\mathbf{\\text{Token: Abstract Symbol}} \\longleftrightarrow \\mathbf{\\text{Pattern: Regular Expression}} \\longleftrightarrow \\mathbf{\\text{Lexeme: Concrete Text}}\n$$\n• **Axiom 1 - Maximal Munch (Longest Match):**\n$$\n\\mathbf{\\text{The scanner ALWAYS consumes the longest possible character prefix matching any valid pattern!}}\n$$\n• **Axiom 2 - Rule Priority (First-Declared Wins):**\n$$\n\\mathbf{\\text{If } |\\text{match}_1| == |\\text{match}_2| \\implies \\text{Rule listed earliest in specification file takes precedence!}}\n$$\n• **Keywords:** Defining `\"while\"` before `[a-zA-Z_]+` guarantees keywords are recognized correctly!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of a lexical analyzer executing Maximal Munch with DFA backtracking rollback.",
      "orderItems": [
        "Initialize the DFA in start state q0 and set both lexemeBegin and forward pointers to the current character",
        "Advance the forward lookahead pointer through input, recording the latest accepting state and position",
        "Continue scanning until the DFA encounters an input character that transitions into a dead/error state",
        "Roll back the forward pointer to the exact character position of the most recent accepting state",
        "Execute the action for the highest-priority matching rule and update lexemeBegin for the next token"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Lexical Analysis concept to its exact functional role.",
      "matchPairs": [
        { "left": "Token", "right": "Abstract grammar symbol (e.g. IF, ID, NUM) returned to the parser for syntax analysis" },
        { "left": "Lexeme", "right": "Concrete sequence of characters in the source text that matched a specific token pattern" },
        { "left": "Maximal Munch", "right": "Greedy scanning rule that consumes the longest possible prefix of matching input characters" },
        { "left": "Rule Priority", "right": "Tie-breaking convention assigning precedence to patterns declared earlier in the lexer file" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The principle requiring a lexical analyzer to match the longest valid character prefix is called Maximal ___.",
      "blankAnswer": "Munch",
      "blankDistractors": ["Match", "Span", "Parse"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "When a lexical analyzer processes the source code string 'while_count', why does it generate a single IDENTIFIER token rather than a WHILE keyword token followed by an identifier '_count'?",
      "options": [
        { "text": "Under the Maximal Munch (Longest Match) rule, the scanner extends its lookahead as long as valid transitions exist; the entire 11-character string 'while_count' matches the identifier regular expression [a-zA-Z_][a-zA-Z0-9_]*, which is strictly longer than the 5-character match of the 'while' keyword; because 11 characters is greater than 5 characters, the lexer selects the longer identifier token", "isCorrect": true, "explanation": "Correct! This is the primary operation of Maximal Munch in compiler lexical analysis (Dragon Book Chapter 3). When the scanner encounters `while_count`: 1. As it reads `w-h-i-l-e`, the DFA reaches an accepting state for the keyword `WHILE` (length 5) as well as the identifier pattern (length 5). 2. However, the scanner does NOT stop there. It peeks at the next character `_`. Because `_` is a valid identifier continuation character, the DFA transitions to another accepting state for identifiers. 3. The scanner continues consuming `c-o-u-n-t` until it reaches a non-identifier delimiter (like a space or `;`), producing a match of length 11 for `IDENTIFIER`. 4. Comparing the candidate matches: `WHILE` matches 5 characters, while `IDENTIFIER` matches 11 characters. 5. Maximal Munch dictates that the longest match ALWAYS wins. Because 11 > 5, the entire string `while_count` is emitted as a single `IDENTIFIER` token. Rule priority (keywords before identifiers) is only consulted as a tie-breaker when two matches have the EXACT SAME length (such as the bare word `while`)." },
        { "text": "Because underscores are forbidden in keywords by ISO C standards", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because the while keyword can only appear at the beginning of a source file", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because lexical analyzers cannot recognize more than one token per line", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
