/* ═══════════════════ UNIT TESTS — up to 30 questions per unit ═══════════════════ */
(() => {
  function addUnitTest(sid, testTitle, countLabel, questions) {
    const st = STATIONS.find(x => x.id === sid);
    if (!st) return;
    st.body += H`
${tp('Unit test — ' + countLabel)}
<p>Sit this <b>closed-book</b> when you finish the unit. Instant marking, bubble counts, and a filter to review only the questions you missed.</p>
${omr(testTitle, questions)}
`;
  }
  addUnitTest('m1-basics', 'Unit 1 test · 30 questions', '30 questions', [
  {
    "q": "Who created the TeX typesetting system?",
    "o": [
      "Leslie Lamport",
      "Donald E. Knuth",
      "Brian Kernighan",
      "Frank Mittelbach"
    ],
    "a": 1,
    "why": "Donald E. Knuth began developing TeX in 1977 at Stanford University."
  },
  {
    "q": "In what year did Donald Knuth begin designing TeX?",
    "o": [
      "1970",
      "1977",
      "1982",
      "1985"
    ],
    "a": 1,
    "why": "Knuth began work on TeX in 1977 after seeing poor phototypesetting proofs of his book."
  },
  {
    "q": "Knuth was motivated to build TeX because of the poor typography in which publication?",
    "o": [
      "Concrete Mathematics",
      "The Art of Computer Programming (2nd ed.)",
      "Surreal Numbers",
      "Computers and Typesetting"
    ],
    "a": 1,
    "why": "He was deeply dissatisfied with the galleys of Volume 2 of The Art of Computer Programming."
  },
  {
    "q": "What year marked the completion of the stable TeX82 design?",
    "o": [
      "1978",
      "1982",
      "1989",
      "1994"
    ],
    "a": 1,
    "why": "TeX82 was completed and released in 1982 and remains the core architecture."
  },
  {
    "q": "TeX's version numbering scheme converges towards which mathematical constant?",
    "o": [
      "e",
      "π (pi)",
      "φ (golden ratio)",
      "Euler-Mascheroni constant γ"
    ],
    "a": 1,
    "why": "Knuth decreed that TeX version numbers converge to π (3.14159265...), with each bug fix adding a decimal digit."
  },
  {
    "q": "Donald Knuth designed which companion system for drawing fonts?",
    "o": [
      "PostScript",
      "METAFONT",
      "TrueType",
      "MetaPost"
    ],
    "a": 1,
    "why": "METAFONT was created by Knuth to render fonts, with its version converging to e."
  },
  {
    "q": "How is the word 'TeX' correctly pronounced?",
    "o": [
      "Tecks (like text)",
      "Tech (ch as in German ach or Scottish loch)",
      "Tesh",
      "Tea-ex"
    ],
    "a": 1,
    "why": "The letters are Greek tau, epsilon, chi (ΤΕΧ), giving the 'tech' pronunciation."
  },
  {
    "q": "Who created LaTeX in the early 1980s?",
    "o": [
      "Donald Knuth",
      "Leslie Lamport",
      "Linus Torvalds",
      "Richard Stallman"
    ],
    "a": 1,
    "why": "Leslie Lamport developed LaTeX as a collection of high-level TeX macros."
  },
  {
    "q": "When was the initial popular release, LaTeX 2.09, introduced?",
    "o": [
      "1982",
      "1985",
      "1990",
      "1994"
    ],
    "a": 1,
    "why": "LaTeX 2.09 was first released in 1985."
  },
  {
    "q": "What is the current standard version of LaTeX, maintained since 1994?",
    "o": [
      "LaTeX 2.09",
      "LaTeX3",
      "LaTeX2ε",
      "LaTeX Pro"
    ],
    "a": 2,
    "why": "LaTeX2ε (LaTeX 2-epsilon) was released in 1994 and remains the universal standard."
  },
  {
    "q": "Which best describes what LaTeX actually is?",
    "o": [
      "A standalone binary operating system",
      "A macro package built on top of the TeX engine",
      "A vector graphics editor",
      "A relational database query language"
    ],
    "a": 1,
    "why": "LaTeX is not a separate low-level engine; it is a massive macro package layered over TeX."
  },
  {
    "q": "What acronym describes LaTeX's design philosophy compared to word processors?",
    "o": [
      "WYSIWYG",
      "WYSIWYM (What You See Is What You Mean)",
      "KISS",
      "DRY"
    ],
    "a": 1,
    "why": "LaTeX separates structure and content from presentation (WYSIWYM) rather than direct visual manipulation (WYSIWYG)."
  },
  {
    "q": "What are the three canonical steps in the LaTeX user workflow?",
    "o": [
      "Draw, Export, Print",
      "Edit plain text, Compile, View PDF",
      "Scan, OCR, Format",
      "Select, Right-click, Save As"
    ],
    "a": 1,
    "why": "You write a plain .tex file, compile it with an engine like pdflatex, and view the resulting PDF."
  },
  {
    "q": "Which compiler directly produces PDF output from LaTeX source code?",
    "o": [
      "tex",
      "latex (traditional)",
      "pdflatex",
      "dvi2pdf"
    ],
    "a": 2,
    "why": "pdflatex translates .tex directly into .pdf without needing intermediate .dvi files."
  },
  {
    "q": "Which generated file contains compiler warnings, errors, and informational messages?",
    "o": [
      ".aux",
      ".log",
      ".toc",
      ".tex"
    ],
    "a": 1,
    "why": "The .log file records all diagnostic messages and transcript details of the run."
  },
  {
    "q": "What is the primary function of the auxiliary file (.aux)?",
    "o": [
      "Storing compiled binary font metrics",
      "Saving cross-references, citation keys, and section numbers for subsequent passes",
      "Holding user preferences and UI state",
      "Caching temporary swap memory"
    ],
    "a": 1,
    "why": "The .aux file acts as memory between compilation passes for labels, citations, and numbers."
  },
  {
    "q": "Which of the following is a comprehensive cross-platform TeX distribution?",
    "o": [
      "TeX Live",
      "Notepad++",
      "Adobe Acrobat Reader",
      "Git"
    ],
    "a": 0,
    "why": "TeX Live is the major cross-platform distribution maintained by the TeX Users Group."
  },
  {
    "q": "Which distribution is historically tailored specifically for Microsoft Windows?",
    "o": [
      "MacTeX",
      "MiKTeX",
      "SolarisTeX",
      "Homebrew"
    ],
    "a": 1,
    "why": "MiKTeX was designed for Windows (now with Linux/Mac ports) and features on-the-fly package installation."
  },
  {
    "q": "What is Overleaf?",
    "o": [
      "A hardware typesetting machine",
      "A cloud-based collaborative browser editor running a TeX distribution",
      "A command-line PDF compression tool",
      "A vector font format"
    ],
    "a": 1,
    "why": "Overleaf is a cloud service that provides a browser-based LaTeX environment."
  },
  {
    "q": "What MUST be the very first markup command in any valid LaTeX document?",
    "o": [
      "\\begin{document}",
      "\\documentclass{...}",
      "\\title{...}",
      "\\usepackage{...}"
    ],
    "a": 1,
    "why": "\\documentclass defines the document class and must precede all other content."
  },
  {
    "q": "What is the area of a document called between \\documentclass and \\begin{document}?",
    "o": [
      "The body",
      "The preamble",
      "The header zone",
      "The epilogue"
    ],
    "a": 1,
    "why": "The preamble contains package imports, document-wide settings, and macro definitions."
  },
  {
    "q": "What happens to text placed after \\end{document} in the .tex file?",
    "o": [
      "It produces a fatal compile error",
      "It is printed on an appendix page",
      "It is completely ignored by LaTeX",
      "It is formatted as a footnote"
    ],
    "a": 2,
    "why": "LaTeX stops reading the input file immediately when it encounters \\end{document}."
  },
  {
    "q": "How does LaTeX treat five consecutive space characters in running text?",
    "o": [
      "As five separate spaces",
      "As a tab character",
      "As a single space",
      "As an error"
    ],
    "a": 2,
    "why": "LaTeX collapses any sequence of contiguous whitespace characters into a single inter-word space."
  },
  {
    "q": "What is the effect of a single newline character in LaTeX source text?",
    "o": [
      "It begins a new paragraph",
      "It is treated as a single space character",
      "It creates a vertical gap of 1 line",
      "It draws a horizontal line"
    ],
    "a": 1,
    "why": "A single carriage return / line break behaves identically to a space character."
  },
  {
    "q": "How do you signal the start of a new paragraph in LaTeX?",
    "o": [
      "Insert one or more blank lines (or type \\par)",
      "Press Enter once",
      "Type <p>",
      "Press Tab twice"
    ],
    "a": 0,
    "why": "One or more empty lines (or the explicit command \\par) ends the paragraph."
  },
  {
    "q": "Which command forces a line break without beginning a new paragraph?",
    "o": [
      "\\par",
      "\\\\ (or \\newline)",
      "\\breakpara",
      "\\next"
    ],
    "a": 1,
    "why": "\\\\ breaks the current line and stays within the same paragraph."
  },
  {
    "q": "How do you specify 4 mm of extra vertical space after a line break?",
    "o": [
      "\\\\+4mm",
      "\\\\[4mm]",
      "\\newline{4mm}",
      "\\vspace*4mm"
    ],
    "a": 1,
    "why": "\\\\ takes an optional bracketed argument: \\\\[length]."
  },
  {
    "q": "What symbol creates an unbreakable tie/space (e.g. Dr.~Knuth)?",
    "o": [
      "^",
      "#",
      "~ (tilde)",
      "_"
    ],
    "a": 2,
    "why": "The tilde ~ produces a normal space that will never be split across a line break."
  },
  {
    "q": "Which symbol begins a single-line comment in LaTeX?",
    "o": [
      "//",
      "#",
      "% (percent)",
      "/*"
    ],
    "a": 2,
    "why": "% causes the compiler to ignore everything from the % symbol to the end of the line."
  },
  {
    "q": "How do you print a literal backslash in running LaTeX text?",
    "o": [
      "\\\\",
      "\\backslash",
      "\\textbackslash",
      "\\/"
    ],
    "a": 2,
    "why": "\\\\ is the line break command; \\textbackslash prints a literal backslash character."
  }
]);

  addUnitTest('m1-document', 'Unit 2 test · 30 questions', '30 questions', [
  {
    "q": "Which of the following is NOT one of the standard built-in document classes?",
    "o": [
      "article",
      "report",
      "book",
      "magazine"
    ],
    "a": 3,
    "why": "The four standard base classes are article, report, book, and letter."
  },
  {
    "q": "Which standard document class does NOT support the \\chapter command?",
    "o": [
      "report",
      "book",
      "article",
      "thesis"
    ],
    "a": 2,
    "why": "The article class begins its sectioning hierarchy at \\section; \\chapter is undefined in article."
  },
  {
    "q": "Which of the following base font sizes is supported directly as an option to \\documentclass?",
    "o": [
      "9pt",
      "11pt",
      "14pt",
      "16pt"
    ],
    "a": 1,
    "why": "Standard classes directly accept 10pt (default), 11pt, and 12pt as base sizing options."
  },
  {
    "q": "How do you configure a document to typeset on A4 paper?",
    "o": [
      "\\documentclass[a4paper]{article}",
      "\\paper{a4}",
      "\\usepackage{a4}",
      "\\setpapersize{A4}"
    ],
    "a": 0,
    "why": "a4paper is passed as an optional bracketed argument to \\documentclass."
  },
  {
    "q": "What is the default page layout option in the book class regarding sides?",
    "o": [
      "oneside",
      "twoside",
      "landscape",
      "multiside"
    ],
    "a": 1,
    "why": "The book class defaults to twoside; article and report default to oneside."
  },
  {
    "q": "Which document class option formats the page into two columns?",
    "o": [
      "columns=2",
      "twocolumn",
      "split2",
      "dualpage"
    ],
    "a": 1,
    "why": "The option twocolumn instructs LaTeX to typeset two columns per page."
  },
  {
    "q": "What command generates the formatted title block from preamble metadata?",
    "o": [
      "\\title",
      "\\maketitle",
      "\\printtitle",
      "\\header"
    ],
    "a": 1,
    "why": "\\maketitle renders the title, author, and date previously specified in the preamble."
  },
  {
    "q": "How should multiple co-authors be separated inside the \\author{...} command?",
    "o": [
      "With commas (,)",
      "With \\and",
      "With &",
      "With \\author2"
    ],
    "a": 1,
    "why": "\\and separates author names so LaTeX can format them in balanced columns across the title."
  },
  {
    "q": "Which command inside \\title or \\author produces an affiliation footnote?",
    "o": [
      "\\footnote",
      "\\thanks{...}",
      "\\affiliation{...}",
      "\\email{...}"
    ],
    "a": 1,
    "why": "\\thanks{...} creates a footnote marker in the title block for acknowledgments or institutional info."
  },
  {
    "q": "If \\date{} is left blank (empty braces), what is the result?",
    "o": [
      "Today's date is printed",
      "The date line is omitted completely",
      "A compile error occurs",
      "The text '[No Date]' appears"
    ],
    "a": 1,
    "why": "An empty \\date{} suppresses the automatic printing of \\today."
  },
  {
    "q": "Which standard environment is used to typeset an executive summary or synopsis?",
    "o": [
      "\\begin{summary}",
      "\\begin{abstract}",
      "\\begin{synopsis}",
      "\\begin{intro}"
    ],
    "a": 1,
    "why": "The abstract environment formats a centered, narrower block for the abstract."
  },
  {
    "q": "In which document class is the abstract environment NOT provided by default?",
    "o": [
      "article",
      "report",
      "book",
      "All provide it"
    ],
    "a": 2,
    "why": "Standard book class does not include an abstract environment; books use preface or introduction chapters."
  },
  {
    "q": "Which \\pagestyle setting places the page number centered in the footer with no header?",
    "o": [
      "empty",
      "plain",
      "headings",
      "myheadings"
    ],
    "a": 1,
    "why": "The plain pagestyle has empty headers and centered folio (page number) in the footer."
  },
  {
    "q": "Which \\pagestyle suppresses both header and footer completely?",
    "o": [
      "blank",
      "plain",
      "empty",
      "bare"
    ],
    "a": 2,
    "why": "empty produces completely blank headers and footers."
  },
  {
    "q": "How do you change the page style for the CURRENT page only?",
    "o": [
      "\\pagestyle{empty}",
      "\\thispagestyle{empty}",
      "\\pageonly{empty}",
      "\\curpage{empty}"
    ],
    "a": 1,
    "why": "\\thispagestyle affects only the page on which it is invoked."
  },
  {
    "q": "Which command changes page numbering to lowercase Roman numerals (i, ii, iii)?",
    "o": [
      "\\pagenumbering{roman}",
      "\\pagenumbering{Roman}",
      "\\romanpage",
      "\\numbers{roman}"
    ],
    "a": 0,
    "why": "\\pagenumbering{roman} sets lowercase Roman numerals and resets the page counter to 1."
  },
  {
    "q": "What are the three primary font families in standard LaTeX?",
    "o": [
      "Arial, Times, Courier",
      "Roman (rm), Sans Serif (sf), Typewriter (tt)",
      "Serif, Script, Monospace",
      "Modern, OldStyle, Sans"
    ],
    "a": 1,
    "why": "LaTeX classifies fonts into Roman (\\textrm), Sans-Serif (\\textsf), and Typewriter (\\texttt)."
  },
  {
    "q": "Which command typesets text in boldface as an argument?",
    "o": [
      "\\bf{text}",
      "\\textbf{text}",
      "\\bold{text}",
      "\\textweight{bold}{text}"
    ],
    "a": 1,
    "why": "\\textbf{...} is the modern LaTeX2ε command for bold text."
  },
  {
    "q": "What is the difference between \\textit{...} and \\textsl{...}?",
    "o": [
      "They are identical synonyms",
      "\\textit is true italic with redesigned cursive letterforms; \\textsl is slanted upright glyphs",
      "\\textit is for math; \\textsl is for text",
      "\\textsl is bolder than \\textit"
    ],
    "a": 1,
    "why": "Italics have redesigned cursive letterforms; slanted simply tilts the upright shapes."
  },
  {
    "q": "Which command formats text in Small Capitals?",
    "o": [
      "\\textsc{...}",
      "\\textcap{...}",
      "\\smallcaps{...}",
      "\\textscap{...}"
    ],
    "a": 0,
    "why": "\\textsc{...} produces small capital letters."
  },
  {
    "q": "How does \\emph{...} behave when used INSIDE already italicized text?",
    "o": [
      "Makes it extra slanted",
      "Reverts to upright (roman) text",
      "Underlines the text",
      "Throws an error"
    ],
    "a": 1,
    "why": "Emphasis is contextual: inside upright text it italicizes; inside italic text it reverts to upright."
  },
  {
    "q": "Which of the following is the SMALLEST standard font size command?",
    "o": [
      "\\footnotesize",
      "\\scriptsize",
      "\\tiny",
      "\\small"
    ],
    "a": 2,
    "why": "The size ladder starts at \\tiny, followed by \\scriptsize, \\footnotesize, \\small, \\normalsize..."
  },
  {
    "q": "Which of the following is the LARGEST font size command?",
    "o": [
      "\\Huge",
      "\\huge",
      "\\LARGE",
      "\\Large"
    ],
    "a": 0,
    "why": "\\Huge (capital H) is larger than \\huge (lowercase h)."
  },
  {
    "q": "How do you type proper opening double quotation marks in LaTeX?",
    "o": [
      "\"",
      "`` (two backticks)",
      "'' (two apostrophes)",
      "<<"
    ],
    "a": 1,
    "why": "Two backticks (``) produce opening double quotation marks; two apostrophes ('') produce closing."
  },
  {
    "q": "Which input creates an en-dash for numerical ranges (e.g. pages 15–25)?",
    "o": [
      "- (single hyphen)",
      "-- (double hyphen)",
      "--- (triple hyphen)",
      "\\endash"
    ],
    "a": 1,
    "why": "-- produces an en-dash (15--25)."
  },
  {
    "q": "Which input creates an em-dash for parenthetical punctuation in sentences?",
    "o": [
      "-",
      "--",
      "--- (triple hyphen)",
      "\\dash"
    ],
    "a": 2,
    "why": "--- produces an em-dash (thought---interrupted)."
  },
  {
    "q": "What does the 'draft' option in \\documentclass do?",
    "o": [
      "Prints the document in light grey ink",
      "Marks overfull \\hbox margins with thick black rectangles for proofreading",
      "Disables all package imports",
      "Suppresses all figures and table rendering"
    ],
    "a": 1,
    "why": "draft displays black bars in the right margin wherever text overflows the margin."
  },
  {
    "q": "Which declaration changes the body text font series to bold inside a group?",
    "o": [
      "\\bfseries",
      "\\textbf",
      "\\boldbody",
      "\\setbold"
    ],
    "a": 0,
    "why": "{\\bfseries text} is the declaration form (scoped to the enclosing group)."
  },
  {
    "q": "Which command prints today's date according to the computer clock?",
    "o": [
      "\\date",
      "\\currentdate",
      "\\today",
      "\\now"
    ],
    "a": 2,
    "why": "\\today produces the current date formatted according to language settings."
  },
  {
    "q": "How do you typeset an underlined word in standard LaTeX?",
    "o": [
      "\\ul{word}",
      "\\underline{word}",
      "\\textunder{word}",
      "\\lineunder{word}"
    ],
    "a": 1,
    "why": "\\underline{...} underlines its argument."
  }
]);

  addUnitTest('m1-bib', 'Unit 3 test · 30 questions', '30 questions', [
  {
    "q": "What built-in environment is used for authoring a bibliography manually without BibTeX?",
    "o": [
      "\\begin{references}",
      "\\begin{thebibliography}{...}",
      "\\begin{bibliography}",
      "\\begin{citations}"
    ],
    "a": 1,
    "why": "thebibliography is LaTeX's built-in manual bibliography environment."
  },
  {
    "q": "What does the mandatory parameter in \\begin{thebibliography}{widest-label} control?",
    "o": [
      "The maximum number of references allowed",
      "The indentation width reserved for label numbering",
      "The font size of citations",
      "The spacing between bibliography entries"
    ],
    "a": 1,
    "why": "It tells LaTeX how wide to make the label column (e.g., {9} for 1-9, {99} for up to 99 items)."
  },
  {
    "q": "Inside thebibliography, which command declares each bibliographic reference item?",
    "o": [
      "\\item[label]",
      "\\bibitem[label]{key}",
      "\\refitem{key}",
      "\\bibentry{key}"
    ],
    "a": 1,
    "why": "\\bibitem[optional_label]{key} defines each entry and its citation key."
  },
  {
    "q": "Which command cites a reference by its key in the document text?",
    "o": [
      "\\cite{key}",
      "\\ref{key}",
      "\\reference{key}",
      "\\citation{key}"
    ],
    "a": 0,
    "why": "\\cite{key} produces the in-text citation marker corresponding to the key."
  },
  {
    "q": "How do you cite a reference with a specific page number, such as [4, p. 12]?",
    "o": [
      "\\cite[p.~12]{key}",
      "\\cite{key}{p. 12}",
      "\\cite[key]{p. 12}",
      "\\citepage{key}{12}"
    ],
    "a": 0,
    "why": "\\cite takes an optional prefix argument before the key: \\cite[note]{key}."
  },
  {
    "q": "How can two or more sources be cited together in one pair of brackets?",
    "o": [
      "\\cite{key1}\\cite{key2}",
      "\\cite{key1, key2}",
      "\\multicite{key1}{key2}",
      "\\cites{key1; key2}"
    ],
    "a": 1,
    "why": "\\cite accepts a comma-separated list of keys: \\cite{key1, key2}."
  },
  {
    "q": "What is the primary advantage of BibTeX over manual bibliography authoring?",
    "o": [
      "It uses fewer computer memory resources",
      "It separates reference data (.bib) from citation presentation (.bst), automating sorting and styling",
      "It eliminates the need for compilation",
      "It converts citations into hyperlinks automatically"
    ],
    "a": 1,
    "why": "BibTeX manages reference data independently of any specific journal formatting style."
  },
  {
    "q": "What file extension is used for a BibTeX database file?",
    "o": [
      ".bib",
      ".bst",
      ".bbl",
      ".blg"
    ],
    "a": 0,
    "why": "BibTeX databases are stored as plain text in .bib files."
  },
  {
    "q": "What file extension is used for a BibTeX formatting style file?",
    "o": [
      ".bib",
      ".bst",
      ".bbl",
      ".cls"
    ],
    "a": 1,
    "why": ".bst stands for Bibliography Style."
  },
  {
    "q": "What is the standard BibTeX entry type for an article published in a scientific journal?",
    "o": [
      "@journal",
      "@article",
      "@paper",
      "@periodical"
    ],
    "a": 1,
    "why": "@article is the standard entry type for journal papers."
  },
  {
    "q": "What is the standard BibTeX entry type for a published book with an author or editor?",
    "o": [
      "@book",
      "@monograph",
      "@volume",
      "@textbook"
    ],
    "a": 0,
    "why": "@book represents a published book."
  },
  {
    "q": "Which of the following is a mandatory field for the @article entry type?",
    "o": [
      "publisher",
      "journal",
      "address",
      "isbn"
    ],
    "a": 1,
    "why": "An @article requires author, title, journal, and year."
  },
  {
    "q": "Which of the following is NOT a required field for the standard @book entry type?",
    "o": [
      "title",
      "year",
      "pages",
      "publisher"
    ],
    "a": 2,
    "why": "pages is an optional field for @book; author/editor, title, publisher, and year are required."
  },
  {
    "q": "How must multiple authors be separated in a BibTeX author field?",
    "o": [
      "With commas",
      "With semicolons",
      "With the word 'and'",
      "With ampersands (&)"
    ],
    "a": 2,
    "why": "BibTeX parses author lists separated strictly by the keyword 'and'."
  },
  {
    "q": "How do you protect capitalization of words (like 'Newtonian') in BibTeX titles?",
    "o": [
      "Wrap the word in curly braces {Newtonian}",
      "Capitalize every letter: NEWTONIAN",
      "Use \\uppercase{Newtonian}",
      "Prefix with \\cap"
    ],
    "a": 0,
    "why": "BibTeX styles that downcase titles will preserve letters enclosed in braces { }."
  },
  {
    "q": "How should an institutional author (e.g. Indian TeX Users Group) be written to avoid 'Group, I. T. U.'?",
    "o": [
      "author = {Indian TeX Users Group}",
      "author = {{Indian TeX Users Group}}",
      "author = 'Indian TeX Users Group'",
      "author = \\institution{Indian TeX Users Group}"
    ],
    "a": 1,
    "why": "Double braces {{...}} signal to BibTeX that the entire string is a single corporate entity."
  },
  {
    "q": "Which standard BibTeX style sorts entries alphabetically by author and assigns numeric labels [1], [2]?",
    "o": [
      "unsrt",
      "plain",
      "alpha",
      "abbrv"
    ],
    "a": 1,
    "why": "plain sorts references alphabetically by first author's surname and numbers them."
  },
  {
    "q": "Which BibTeX style numbers references in their order of first citation in text?",
    "o": [
      "plain",
      "unsrt",
      "alpha",
      "order"
    ],
    "a": 1,
    "why": "unsrt (unsorted) assigns numbers chronologically as citations appear in the text."
  },
  {
    "q": "Which BibTeX style uses alphanumeric label codes like [Knu84] based on author name and year?",
    "o": [
      "plain",
      "alpha",
      "abbrv",
      "custom"
    ],
    "a": 1,
    "why": "alpha generates alphanumeric mnemonic labels (e.g. [Lam94])."
  },
  {
    "q": "Which BibTeX style abbreviates author first names, months, and journal titles?",
    "o": [
      "short",
      "abbrv",
      "compact",
      "mini"
    ],
    "a": 1,
    "why": "abbrv is similar to plain but abbreviates months, journal names, and first names."
  },
  {
    "q": "Which LaTeX command specifies which .bst style file should be used?",
    "o": [
      "\\bibliographystyle{style}",
      "\\bibstyle{style}",
      "\\usebibstyle{style}",
      "\\setbib{style}"
    ],
    "a": 0,
    "why": "\\bibliographystyle{name} sets the active bibliography style."
  },
  {
    "q": "Which LaTeX command specifies the database filename and prints the bibliography at that position?",
    "o": [
      "\\printbibliography",
      "\\bibliography{filename}",
      "\\bibdata{filename}",
      "\\inputbib{filename}"
    ],
    "a": 1,
    "why": "\\bibliography{myrefs} loads myrefs.bib and prints the list of references."
  },
  {
    "q": "Which command includes a specific source in the bibliography without generating an in-text citation?",
    "o": [
      "\\cite*{key}",
      "\\nocite{key}",
      "\\silentcite{key}",
      "\\includeentry{key}"
    ],
    "a": 1,
    "why": "\\nocite{key} places the entry into the bibliography without printing a marker in the text."
  },
  {
    "q": "How do you instruct BibTeX to include EVERY entry from your .bib database in the reference list?",
    "o": [
      "\\nocite{*}",
      "\\citeall",
      "\\bibliography*{all}",
      "\\printallreferences"
    ],
    "a": 0,
    "why": "\\nocite{*} adds all items in the database to the bibliography list."
  },
  {
    "q": "What file does BibTeX create from .aux and .bib that is subsequently read by LaTeX?",
    "o": [
      ".bbl",
      ".blg",
      ".idx",
      ".bst"
    ],
    "a": 0,
    "why": "BibTeX writes a .bbl (bibliography) file containing formatted thebibliography markup."
  },
  {
    "q": "What is the complete sequence of commands for a full clean BibTeX compile run?",
    "o": [
      "pdflatex -> pdflatex",
      "pdflatex -> bibtex -> pdflatex -> pdflatex",
      "bibtex -> pdflatex -> bibtex",
      "pdflatex -> makeindex -> pdflatex"
    ],
    "a": 1,
    "why": "Four passes: 1. pdflatex writes .aux, 2. bibtex creates .bbl, 3. pdflatex reads .bbl and writes citation numbers to .aux, 4. pdflatex resolves citations."
  },
  {
    "q": "What happens during the very FIRST pdflatex run before BibTeX is executed?",
    "o": [
      "Citations appear as [?], and \\citation commands are written into the .aux file",
      "The PDF is completely finished",
      "BibTeX runs automatically in background",
      "An error halts compilation"
    ],
    "a": 0,
    "why": "LaTeX notes citation requests in the .aux file and prints [?] as temporary placeholders."
  },
  {
    "q": "What file records the error and warning log of the BibTeX program itself?",
    "o": [
      ".log",
      ".blg",
      ".aux",
      ".bbl"
    ],
    "a": 1,
    "why": ".blg stands for 'bibliography log' and holds BibTeX diagnostics."
  },
  {
    "q": "Which entry type is used for books where different chapters are written by different authors?",
    "o": [
      "@book",
      "@incollection",
      "@article",
      "@manual"
    ],
    "a": 1,
    "why": "@incollection is used for a part/chapter of a book with its own title within a collection."
  },
  {
    "q": "Which field in BibTeX is typically used for URL addresses or notes when no standard field applies?",
    "o": [
      "howpublished (or note)",
      "misc",
      "extra",
      "link"
    ],
    "a": 0,
    "why": "howpublished, note, or url (with hyperref) are standard for web links and special details."
  }
]);

  addUnitTest('m1-toc', 'Unit 4 test · 25 questions', '25 questions', [
  {
    "q": "What is the highest hierarchical sectioning level available in the report and book classes?",
    "o": [
      "\\part",
      "\\chapter",
      "\\section",
      "\\division"
    ],
    "a": 0,
    "why": "\\part is highest (level -1), followed by \\chapter (level 0)."
  },
  {
    "q": "What is the highest hierarchical sectioning level available in the article class?",
    "o": [
      "\\chapter",
      "\\section",
      "\\part",
      "\\subpart"
    ],
    "a": 2,
    "why": "While article supports \\part, \\section is its primary top division; \\chapter does not exist in article."
  },
  {
    "q": "What numerical depth level is assigned to \\section in LaTeX's counter hierarchy?",
    "o": [
      "0",
      "1",
      "2",
      "3"
    ],
    "a": 1,
    "why": "part is -1, chapter is 0, section is 1, subsection is 2, subsubsection is 3..."
  },
  {
    "q": "How do you produce an unnumbered section that is also omitted from the Table of Contents?",
    "o": [
      "\\section[none]{Title}",
      "\\section*{Title}",
      "\\section{Title}[no-number]",
      "\\unsection{Title}"
    ],
    "a": 1,
    "why": "The starred form \\section*{...} suppresses numbering and TOC generation."
  },
  {
    "q": "How can you specify an alternate, shorter title for the Table of Contents and running page headers?",
    "o": [
      "\\section[Short title]{Long title}",
      "\\section{Long title}{Short title}",
      "\\section*{Short title}",
      "\\shortsection{Short}{Long}"
    ],
    "a": 0,
    "why": "The optional bracketed argument \\section[TOC title]{Main title} is used in TOC and page heads."
  },
  {
    "q": "Which command generates and prints the Table of Contents at its position?",
    "o": [
      "\\printcontents",
      "\\tableofcontents",
      "\\maketableofcontents",
      "\\showtoc"
    ],
    "a": 1,
    "why": "\\tableofcontents inserts the document's table of contents."
  },
  {
    "q": "Which file extension is used to cache table of contents data between runs?",
    "o": [
      ".aux",
      ".toc",
      ".lof",
      ".lot"
    ],
    "a": 1,
    "why": ".toc stores table of contents headings and page numbers."
  },
  {
    "q": "Which command generates and prints the List of Figures?",
    "o": [
      "\\listoffigures",
      "\\figlist",
      "\\tableoffigures",
      "\\printfigures"
    ],
    "a": 0,
    "why": "\\listoffigures compiles and displays the list of figure captions."
  },
  {
    "q": "Which command generates and prints the List of Tables?",
    "o": [
      "\\listoftables",
      "\\tablelist",
      "\\tablestoc",
      "\\printtables"
    ],
    "a": 0,
    "why": "\\listoftables displays the list of table captions."
  },
  {
    "q": "Which counter controls the deepest heading level that receives automatic numbering in text?",
    "o": [
      "tocdepth",
      "secnumdepth",
      "numberdepth",
      "maxheadings"
    ],
    "a": 1,
    "why": "secnumdepth defines the threshold level down to which headings are numbered."
  },
  {
    "q": "Which counter controls the deepest heading level that appears in the Table of Contents?",
    "o": [
      "tocdepth",
      "secnumdepth",
      "depthtoc",
      "leveldepth"
    ],
    "a": 0,
    "why": "tocdepth sets the cutoff level for entries included in the Table of Contents."
  },
  {
    "q": "Which command marks an anchor point in text for future cross-referencing?",
    "o": [
      "\\anchor{name}",
      "\\label{marker}",
      "\\ref{marker}",
      "\\point{marker}"
    ],
    "a": 1,
    "why": "\\label{key} records the current section/equation/table number and page in the .aux file."
  },
  {
    "q": "Which command retrieves and prints the number of the labeled target (e.g. 'Section 3')?",
    "o": [
      "\\ref{marker}",
      "\\pageref{marker}",
      "\\label{marker}",
      "\\target{marker}"
    ],
    "a": 0,
    "why": "\\ref{marker} outputs the counter value associated with the label."
  },
  {
    "q": "Which command outputs the page number where the target label is situated?",
    "o": [
      "\\ref{marker}",
      "\\pageref{marker}",
      "\\pageof{marker}",
      "\\whereis{marker}"
    ],
    "a": 1,
    "why": "\\pageref{marker} prints the page number of the given label."
  },
  {
    "q": "How many compilation passes are normally required to settle all newly added cross-references?",
    "o": [
      "1 pass",
      "At least 2 passes",
      "Always 4 passes",
      "3 passes always"
    ],
    "a": 1,
    "why": "First pass writes label targets to .aux; second pass reads .aux to fill in \\ref and \\pageref."
  },
  {
    "q": "Which command incorporates an external .tex file directly without forcing a page break?",
    "o": [
      "\\include{file}",
      "\\input{file}",
      "\\import{file}",
      "\\addfile{file}"
    ],
    "a": 1,
    "why": "\\input{file} literally inserts the file contents in-place as if typed there directly."
  },
  {
    "q": "Which command incorporates an external chapter, forcing a page break and generating its own .aux?",
    "o": [
      "\\include{file}",
      "\\input{file}",
      "\\chapterfile{file}",
      "\\attach{file}"
    ],
    "a": 0,
    "why": "\\include{file} starts a new page and manages separate auxiliary files."
  },
  {
    "q": "Which preamble command allows selectively compiling only certain \\include files while preserving correct page and chapter numbers?",
    "o": [
      "\\only{file1, file2}",
      "\\includeonly{file1, file2}",
      "\\compile{file1}",
      "\\selectfiles{file1}"
    ],
    "a": 1,
    "why": "\\includeonly{...} in the preamble restricts processing to specified files while reading other .aux files for numbering."
  },
  {
    "q": "What happens if you try to use \\include inside a file that was itself brought in with \\include?",
    "o": [
      "It compiles normally",
      "LaTeX issues a fatal error because \\include cannot be nested",
      "It creates an infinite loop",
      "It creates sub-folders"
    ],
    "a": 1,
    "why": "LaTeX explicitly disallows nested \\include commands (use \\input instead)."
  },
  {
    "q": "Which standard package provides tools for building an index in LaTeX?",
    "o": [
      "indexing",
      "makeidx",
      "indexpro",
      "glossaries"
    ],
    "a": 1,
    "why": "\\usepackage{makeidx} is the standard indexing package in LaTeX2ε."
  },
  {
    "q": "What command must be placed in the preamble to activate index generation?",
    "o": [
      "\\makeindex",
      "\\enableindex",
      "\\buildindex",
      "\\startindex"
    ],
    "a": 0,
    "why": "\\makeindex in the preamble opens the .idx file and enables indexing commands."
  },
  {
    "q": "Which command in the text marks a term to be indexed on the current page?",
    "o": [
      "\\index{term}",
      "\\addindex{term}",
      "\\entry{term}",
      "\\markindex{term}"
    ],
    "a": 0,
    "why": "\\index{term} writes an indexing record with the current page number into .idx."
  },
  {
    "q": "How do you create a sub-entry under a main entry (e.g. Mammal -> Whale) in \\index?",
    "o": [
      "\\index{Mammal/Whale}",
      "\\index{Mammal!Whale}",
      "\\index{Mammal:Whale}",
      "\\index{Mammal>Whale}"
    ],
    "a": 1,
    "why": "The exclamation mark (!) separates index levels: \\index{main!sub}."
  },
  {
    "q": "How do you create a 'see also' reference in the index (e.g. Feline, see Cat)?",
    "o": [
      "\\index{Feline|see{Cat}}",
      "\\index{Feline->Cat}",
      "\\index{Feline}(see Cat)",
      "\\see{Feline}{Cat}"
    ],
    "a": 0,
    "why": "|see{target} formats the page number portion as an italicized 'see target' reference."
  },
  {
    "q": "Which command prints the finished index in the document?",
    "o": [
      "\\showindex",
      "\\printindex",
      "\\makeindex",
      "\\theindex"
    ],
    "a": 1,
    "why": "\\printindex prints the compiled index generated from the .ind file."
  }
]);

  addUnitTest('m2-display', 'Unit 5 test · 30 questions', '30 questions', [
  {
    "q": "Which delimiters are the modern LaTeX standard for unnumbered displayed math equations?",
    "o": [
      "$$ ... $$",
      "\\[ ... \\]",
      "<math> ... </math>",
      "\\begin{math} ... \\end{math}"
    ],
    "a": 1,
    "why": "\\[ ... \\] is the official LaTeX standard for unnumbered display math (superior to plain TeX's $$)."
  },
  {
    "q": "Which standard environment is used for a displayed, automatically numbered mathematical formula?",
    "o": [
      "displaymath",
      "equation",
      "formula",
      "numberedmath"
    ],
    "a": 1,
    "why": "The equation environment displays a centered formula with an auto-incremented equation number."
  },
  {
    "q": "Which environment creates a bulleted list in LaTeX?",
    "o": [
      "enumerate",
      "itemize",
      "bullets",
      "list"
    ],
    "a": 1,
    "why": "itemize creates an unordered, bullet-pointed list."
  },
  {
    "q": "Which environment creates an automatically numbered list (1, 2, 3...)?",
    "o": [
      "itemize",
      "enumerate",
      "numbered",
      "ordered"
    ],
    "a": 1,
    "why": "enumerate produces an ordered numbered list."
  },
  {
    "q": "Which environment is designed for term-and-definition style lists?",
    "o": [
      "itemize",
      "description",
      "glossary",
      "terms"
    ],
    "a": 1,
    "why": "description accepts optional item terms: \\item[Term] Definition."
  },
  {
    "q": "What command introduces each individual item inside a list environment?",
    "o": [
      "\\item",
      "\\entry",
      "\\bullet",
      "\\listitem"
    ],
    "a": 0,
    "why": "\\item begins an item in itemize, enumerate, and description."
  },
  {
    "q": "How do you customize the label of a specific item (e.g., changing a bullet to a dash)?",
    "o": [
      "\\item[--]",
      "\\item(--)",
      "\\item{--}",
      "\\label{--}\\item"
    ],
    "a": 0,
    "why": "Passing an optional bracketed argument to \\item[label] overrides the default marker."
  },
  {
    "q": "What is the maximum allowed nesting depth for standard list environments (itemize, enumerate)?",
    "o": [
      "2 levels",
      "3 levels",
      "4 levels",
      "Unlimited"
    ],
    "a": 2,
    "why": "LaTeX restricts standard list nesting to a maximum of 4 levels deep."
  },
  {
    "q": "Which environment is intended for short, single-paragraph quotations?",
    "o": [
      "quotation",
      "quote",
      "verse",
      "citeblock"
    ],
    "a": 1,
    "why": "quote is for short quotes; paragraphs are not indented and are separated by vertical space."
  },
  {
    "q": "Which environment is designed for multi-paragraph quotations, indenting paragraph first lines?",
    "o": [
      "quotation",
      "quote",
      "verse",
      "longquote"
    ],
    "a": 0,
    "why": "quotation indents paragraph first lines just like regular text, suitable for long excerpts."
  },
  {
    "q": "Which environment is specifically designed for poetry, preserving line breaks and stanza spacing?",
    "o": [
      "poem",
      "verse",
      "rhyme",
      "lyrics"
    ],
    "a": 1,
    "why": "verse formats poetry with hanging indents and explicit line breaks."
  },
  {
    "q": "How are individual lines within a stanza terminated inside the verse environment?",
    "o": [
      "With Enter",
      "With \\\\",
      "With \\par",
      "With \\line"
    ],
    "a": 1,
    "why": "Lines in a verse environment end with \\\\; stanzas are separated by an empty blank line."
  },
  {
    "q": "What happens when a long line of poetry in the verse environment wraps to the next row?",
    "o": [
      "It gets truncated",
      "It receives a hanging indentation",
      "It causes a compiler error",
      "It is centered"
    ],
    "a": 1,
    "why": "verse automatically applies hanging indentation to wrapped continuation lines."
  },
  {
    "q": "Which environment prints text exactly as typed, including spaces, tabs, and unparsed commands?",
    "o": [
      "code",
      "verbatim",
      "literal",
      "raw"
    ],
    "a": 1,
    "why": "verbatim prints ASCII characters in monospaced font with no macro expansion."
  },
  {
    "q": "Which inline command typesets a short piece of raw code verbatim inside a sentence?",
    "o": [
      "\\verb|text|",
      "\\code{text}",
      "\\verbatim{text}",
      "\\raw{text}"
    ],
    "a": 0,
    "why": "\\verb<delim>text<delim> produces inline verbatim text using any delimiter."
  },
  {
    "q": "Which characters are NOT permitted as delimiters for the \\verb command?",
    "o": [
      "+ and -",
      "Letters, digits, and space/asterisk",
      "! and |",
      "Square brackets"
    ],
    "a": 1,
    "why": "Delimiters for \\verb cannot be letters, digits, spaces, or an asterisk."
  },
  {
    "q": "What is the difference between verbatim and verbatim* (starred version)?",
    "o": [
      "verbatim* formats text in bold",
      "verbatim* renders spaces as visible open-cup symbols (␣)",
      "verbatim* numbers the lines",
      "verbatim* runs in math mode"
    ],
    "a": 1,
    "why": "Starred verbatim and \\verb* explicitly render spaces with an open-cup glyph."
  },
  {
    "q": "Which environment centers lines of text with added vertical margins above and below?",
    "o": [
      "center",
      "middle",
      "centering",
      "aligncenter"
    ],
    "a": 0,
    "why": "The center environment centers text and introduces vertical paragraph spacing."
  },
  {
    "q": "What is the declaration command equivalent to the center environment?",
    "o": [
      "\\centerline",
      "\\centering",
      "\\makecenter",
      "\\centeron"
    ],
    "a": 1,
    "why": "\\centering is the declaration form (useful inside figure/table floats without adding extra space)."
  },
  {
    "q": "Which environment aligns text flush with the left margin, leaving the right ragged?",
    "o": [
      "raggedright",
      "flushleft",
      "leftalign",
      "leftside"
    ],
    "a": 1,
    "why": "flushleft creates left-aligned paragraphs with ragged right edge."
  },
  {
    "q": "What declaration command turns on ragged-right alignment inside a group?",
    "o": [
      "\\raggedright",
      "\\flushleft",
      "\\alignleft",
      "\\leftrag"
    ],
    "a": 0,
    "why": "\\raggedright sets ragged right formatting until the end of the current group."
  },
  {
    "q": "Which environment aligns text flush with the right margin, leaving the left ragged?",
    "o": [
      "flushright",
      "raggedleft",
      "rightalign",
      "alignright"
    ],
    "a": 0,
    "why": "flushright aligns lines against the right margin."
  },
  {
    "q": "What declaration command turns on ragged-left alignment inside a group?",
    "o": [
      "\\raggedleft",
      "\\flushright",
      "\\alignright",
      "\\rightrag"
    ],
    "a": 0,
    "why": "\\raggedleft sets ragged left formatting within its scope."
  },
  {
    "q": "Why is \\centering preferred over \\begin{center} ... \\end{center} inside table/figure floats?",
    "o": [
      "\\begin{center} does not center properly in floats",
      "\\begin{center} adds unwanted additional vertical spacing; \\centering does not",
      "\\centering allows bold text",
      "\\centering is faster to compile"
    ],
    "a": 1,
    "why": "center is an environment that adds top and bottom padding, which inflates float captions."
  },
  {
    "q": "What font family is used by default inside the verbatim environment?",
    "o": [
      "Roman serif",
      "Typewriter / monospaced (\\ttfamily)",
      "Sans serif",
      "Mathematical cursive"
    ],
    "a": 1,
    "why": "verbatim uses the typewriter monospaced font family."
  },
  {
    "q": "Can LaTeX macros (e.g. \\textbf{hello}) be evaluated and formatted inside a verbatim block?",
    "o": [
      "Yes, always",
      "No, backslashes and commands are printed literally as characters",
      "Only if escaped with \\\\",
      "Only inside \\verb"
    ],
    "a": 1,
    "why": "verbatim disables all macro recognition, printing all backslashes and markup literally."
  },
  {
    "q": "Which delimiters enclose inline math formulas in LaTeX?",
    "o": [
      "$ ... $ (or \\( ... \\))",
      "\\[ ... \\]",
      "# ... #",
      "{math ...}"
    ],
    "a": 0,
    "why": "$ ... $ or \\( ... \\) define inline math within running text."
  },
  {
    "q": "What is the default numbering style for the first level of an enumerate list in article class?",
    "o": [
      "Uppercase letters (A, B, C)",
      "Arabic numerals followed by a period (1., 2., 3.)",
      "Roman numerals (i, ii, iii)",
      "Bullet circles"
    ],
    "a": 1,
    "why": "Level 1 enumerate defaults to 1., 2., 3... in standard article class."
  },
  {
    "q": "What is the default numbering style for the SECOND nested level of an enumerate list?",
    "o": [
      "Arabic numerals (1., 2.)",
      "Lowercase letters in parentheses ((a), (b))",
      "Lowercase Roman numerals (i., ii.)",
      "Dashes"
    ],
    "a": 1,
    "why": "Level 2 enumerate defaults to (a), (b), (c)... in standard article class."
  },
  {
    "q": "Which command forces an extra blank line between items in a list without ending the list?",
    "o": [
      "\\vspace{\\bigskip}",
      "\\item[]",
      "\\item \\vspace{1cm}",
      "A blank line"
    ],
    "a": 0,
    "why": "\\vspace{...} or \\smallskip / \\medskip / \\bigskip injects vertical separation."
  }
]);

  addUnitTest('m2-tabbing', 'Unit 6 test · 20 questions', '20 questions', [
  {
    "q": "What is the primary purpose of the tabbing environment in LaTeX?",
    "o": [
      "Typesetting complex mathematical matrices",
      "Creating typewriter-style columnar alignment using explicit tab stops",
      "Drawing high-resolution vector diagrams",
      "Generating slide presentations"
    ],
    "a": 1,
    "why": "tabbing mimics typewriter tab stops for column alignment without a full grid table."
  },
  {
    "q": "Which command sets a tab stop at the current horizontal position inside tabbing?",
    "o": [
      "\\tab",
      "\\=",
      "\\>",
      "\\settab"
    ],
    "a": 1,
    "why": "\\= marks a tab stop at the cursor's current position."
  },
  {
    "q": "Which command advances the cursor forward to the next defined tab stop?",
    "o": [
      "\\>",
      "\\=",
      "\\tab",
      "\\next"
    ],
    "a": 0,
    "why": "\\> moves the insertion point to the next tab stop."
  },
  {
    "q": "Which command terminates the current line and advances to the next line in tabbing?",
    "o": [
      "\\newline",
      "\\par",
      "\\\\",
      "\\nextline"
    ],
    "a": 2,
    "why": "\\\\ ends the line in tabbing, exactly as in other multi-line environments."
  },
  {
    "q": "What is the function of the \\kill command at the end of a line in tabbing?",
    "o": [
      "It throws a compiler fatal error",
      "It aborts the entire tabbing environment",
      "It discards the sample text of the line from printing while keeping its tab stop positions",
      "It resets all tab stops to zero"
    ],
    "a": 2,
    "why": "\\kill sets tab stops based on text lengths in the line, but suppresses printing that line."
  },
  {
    "q": "Which command advances the left margin by one tab stop for all subsequent lines?",
    "o": [
      "\\+",
      "\\-",
      "\\>",
      "\\indent"
    ],
    "a": 0,
    "why": "\\+ increases the indentation of subsequent lines by one tab stop."
  },
  {
    "q": "Which command un-indents the left margin by one tab stop for all subsequent lines?",
    "o": [
      "\\+",
      "\\-",
      "\\<",
      "\\unindent"
    ],
    "a": 1,
    "why": "\\- moves the effective left margin of subsequent lines one tab stop back."
  },
  {
    "q": "Which command moves text preceding it to 1 em before the current column's right edge?",
    "o": [
      "\\'",
      "\\`",
      "\\+",
      "\\hfill"
    ],
    "a": 0,
    "why": "\\' shifts preceding text to right-align against the upcoming tab stop."
  },
  {
    "q": "Which command pushes all subsequent text flush with the far right margin of the tabbing environment?",
    "o": [
      "\\'",
      "\\`",
      "\\hfill",
      "\\pushright"
    ],
    "a": 1,
    "why": "\\` pushes everything following it flush against the right margin."
  },
  {
    "q": "Which command saves the current set of tab stops onto a stack?",
    "o": [
      "\\savetabs",
      "\\pushtabs",
      "\\storetabs",
      "\\holdtabs"
    ],
    "a": 1,
    "why": "\\pushtabs saves the active tab settings so a new set can be defined temporarily."
  },
  {
    "q": "Which command restores previously saved tab stops from the stack?",
    "o": [
      "\\loadtabs",
      "\\poptabs",
      "\\restoresettings",
      "\\pulltabs"
    ],
    "a": 1,
    "why": "\\poptabs restores the tab stop configuration saved by the matching \\pushtabs."
  },
  {
    "q": "Can lines inside a tabbing environment automatically wrap around the page margins?",
    "o": [
      "Yes, text wraps automatically",
      "No, lines in tabbing must be explicitly terminated with \\\\ or \\kill",
      "Only if wrapped in a box",
      "Only if using monospace font"
    ],
    "a": 1,
    "why": "tabbing does not wrap lines automatically; authors must control line endings with \\\\."
  },
  {
    "q": "What happens if text in a tabbing column is longer than the distance to the next tab stop?",
    "o": [
      "The text automatically truncates",
      "The text overflows and may overprint text at the next tab stop unless skipped with \\>",
      "LaTeX automatically recalculates column widths",
      "A compile-time fatal error is raised"
    ],
    "a": 1,
    "why": "tabbing does not auto-expand columns; overflowing text simply runs over subsequent stops unless managed."
  },
  {
    "q": "Which command resets the current line's cursor back to the starting left margin without starting a new line?",
    "o": [
      "\\<",
      "\\0",
      "\\left",
      "\\reset"
    ],
    "a": 0,
    "why": "\\< shifts the cursor back to the previous tab stop on the current line."
  },
  {
    "q": "What font does the tabbing environment use by default?",
    "o": [
      "Monospaced typewriter font exclusively",
      "The current active document font (proportional roman by default)",
      "Bold sans-serif",
      "Courier New"
    ],
    "a": 1,
    "why": "Unlike verbatim, tabbing uses proportional roman fonts by default unless you declare \\ttfamily."
  },
  {
    "q": "How is a pattern line typically formatted to establish tab widths for a code listing?",
    "o": [
      "\\begin{tabbing} xxxx \\= xxxx \\= \\kill",
      "\\settabs{4, 8, 12}",
      "\\tabwidth{2cm, 4cm}",
      "\\tabs[4]"
    ],
    "a": 0,
    "why": "A pattern line with sample text and \\= stops ending in \\kill is the standard pattern."
  },
  {
    "q": "Can the tabbing environment break across a page boundary?",
    "o": [
      "No, it must fit on a single page",
      "Yes, page breaks can occur naturally between lines in tabbing",
      "Only if \\pagebreak is typed",
      "Only in the report class"
    ],
    "a": 1,
    "why": "Unlike tabular, tabbing allows normal page breaks between rows."
  },
  {
    "q": "What is a key difference between tabbing and tabular?",
    "o": [
      "tabbing supports vertical lines; tabular does not",
      "tabular automatically calculates column widths and supports border rules; tabbing relies on manual tab marks",
      "tabbing is for math; tabular is for text",
      "tabular cannot display text"
    ],
    "a": 1,
    "why": "tabular calculates cell bounds and paints borders; tabbing is a lighter-weight line-oriented system."
  },
  {
    "q": "Can footnotes be placed inside a tabbing environment?",
    "o": [
      "Yes, \\footnote works normally",
      "No, \\footnote does not work properly inside tabbing",
      "Only if using \\thanks",
      "Only in book class"
    ],
    "a": 1,
    "why": "Footnotes inside tabbing are lost unless managed through \\footnotemark and \\footnotetext."
  },
  {
    "q": "Can mathematical formulas ($x+y$) be included within tabbing columns?",
    "o": [
      "Yes, standard inline math ($...$) works normally inside tabbing",
      "No, math mode is forbidden inside tabbing",
      "Only display math is permitted",
      "Only via \\math{...}"
    ],
    "a": 0,
    "why": "Inline math delimited by $...$ works normally inside tabbing fields."
  }
]);

  addUnitTest('m2-tables', 'Unit 7 test · 30 questions', '30 questions', [
  {
    "q": "What is the primary environment used for creating table grids with rows and columns in LaTeX?",
    "o": [
      "\\begin{table}",
      "\\begin{tabular}",
      "\\begin{grid}",
      "\\begin{matrix}"
    ],
    "a": 1,
    "why": "tabular formats cells, columns, and rules; table is merely the outer floating wrapper."
  },
  {
    "q": "What is the fundamental difference between the tabular and table environments?",
    "o": [
      "They are identical synonyms",
      "tabular typesets the cell matrix; table is a float that provides captioning, numbering, and placement",
      "table is for small tables; tabular is for books",
      "tabular cannot use borders"
    ],
    "a": 1,
    "why": "tabular produces the actual grid box; table allows LaTeX to float the table with a \\caption and label."
  },
  {
    "q": "Which column specifier indicates a left-aligned column in tabular?",
    "o": [
      "l",
      "L",
      "left",
      "<"
    ],
    "a": 0,
    "why": "l (lowercase letter L) specifies left alignment."
  },
  {
    "q": "Which column specifier indicates a right-aligned column in tabular?",
    "o": [
      "r",
      "R",
      "right",
      ">"
    ],
    "a": 0,
    "why": "r specifies right alignment."
  },
  {
    "q": "Which column specifier indicates a centered column in tabular?",
    "o": [
      "c",
      "C",
      "center",
      "="
    ],
    "a": 0,
    "why": "c specifies centered alignment."
  },
  {
    "q": "Which column specifier creates a fixed-width column where paragraphs of text wrap automatically?",
    "o": [
      "w{width}",
      "p{width}",
      "m{width}",
      "wrap{width}"
    ],
    "a": 1,
    "why": "p{width} (paragraph column) formats text in a fixed-width mini-column with word wrapping."
  },
  {
    "q": "What character in the column specification inserts a vertical dividing line between columns?",
    "o": [
      "/",
      ":",
      "| (vertical bar)",
      "!"
    ],
    "a": 2,
    "why": "The vertical bar | draws a vertical rule between columns."
  },
  {
    "q": "How do you specify a double vertical border between two columns?",
    "o": [
      "|| (two vertical bars)",
      "\\doublebar",
      "|2|",
      "::"
    ],
    "a": 0,
    "why": "|| draws two adjacent vertical rules."
  },
  {
    "q": "What character separates cells horizontally across columns within a tabular row?",
    "o": [
      ", (comma)",
      "& (ampersand)",
      "\\t",
      "|"
    ],
    "a": 1,
    "why": "& is the column separator in LaTeX tables."
  },
  {
    "q": "What command terminates a row in a tabular environment?",
    "o": [
      "\\par",
      "\\\\ (double backslash)",
      "\\endrow",
      "\\hline"
    ],
    "a": 1,
    "why": "\\\\ terminates each row in tabular."
  },
  {
    "q": "Which command draws a horizontal rule spanning across ALL columns in tabular?",
    "o": [
      "\\hline",
      "\\line",
      "\\hrule",
      "\\bar"
    ],
    "a": 0,
    "why": "\\hline draws a horizontal line across the entire width of the table."
  },
  {
    "q": "Which command draws a horizontal rule spanning from column 2 to column 4 only?",
    "o": [
      "\\hline{2-4}",
      "\\cline{2-4}",
      "\\partline{2}{4}",
      "\\hrule[2-4]"
    ],
    "a": 1,
    "why": "\\cline{i-j} draws a partial horizontal rule spanning from column i to j inclusive."
  },
  {
    "q": "Which command combines multiple columns into a single merged cell?",
    "o": [
      "\\merge{...}",
      "\\multicolumn{num}{alignment}{content}",
      "\\span{...}",
      "\\cellcombine{...}"
    ],
    "a": 1,
    "why": "\\multicolumn{n}{spec}{text} spans n columns and applies a new alignment specifier."
  },
  {
    "q": "How can \\multicolumn be used to override the alignment of just a SINGLE cell (e.g. Center a header over left-aligned data)?",
    "o": [
      "\\multicolumn{1}{c}{Header}",
      "\\singlealign{c}{Header}",
      "\\cellalign{c}{Header}",
      "\\override{c}{Header}"
    ],
    "a": 0,
    "why": "\\multicolumn{1}{c}{...} spans 1 column and replaces its column alignment specification for that cell."
  },
  {
    "q": "What does the construct @{...} in a tabular column specification do?",
    "o": [
      "Formats column text in bold",
      "Replaces the default inter-column spacing with the specified string or empty space",
      "Assigns an email link to the column",
      "Inserts an alternating row background color"
    ],
    "a": 1,
    "why": "@{text} replaces inter-column padding with text; @{} removes padding at margins."
  },
  {
    "q": "How do you remove the default outer whitespace padding at the left and right borders of a table?",
    "o": [
      "\\begin{tabular}{@{} l r c @{}}",
      "\\begin{tabular}[nopad]{l r c}",
      "\\begin{tabular}{trim l r c}",
      "\\begin{tabular}{0 l r c 0}"
    ],
    "a": 0,
    "why": "@{} at the start and end of the column specifiers suppresses margin whitespace."
  },
  {
    "q": "What does the optional vertical alignment argument [t] in \\begin{tabular}[t]{...} specify?",
    "o": [
      "Align the top of the table box with the baseline of surrounding text",
      "Place the table at the top of the page",
      "Draw a rule at the top",
      "Center text at the top of cells"
    ],
    "a": 0,
    "why": "The optional [t] / [b] argument aligns the top or bottom of the tabular box with the baseline."
  },
  {
    "q": "What does the float placement parameter 'h' represent in \\begin{table}[htbp]?",
    "o": [
      "Header placement",
      "Here (approximately at the current point in text)",
      "High priority",
      "Horizontal orientation"
    ],
    "a": 1,
    "why": "h specifies 'here' in float placement preferences."
  },
  {
    "q": "What does the float placement parameter 't' represent?",
    "o": [
      "Top of the page",
      "Tabular float",
      "Temporary buffer",
      "Title position"
    ],
    "a": 0,
    "why": "t directs LaTeX to place the float at the top of a page."
  },
  {
    "q": "What does the float placement parameter 'b' represent?",
    "o": [
      "Bottom of the page",
      "Bordered table",
      "Body text flow",
      "Background float"
    ],
    "a": 0,
    "why": "b directs LaTeX to place the float at the bottom of a page."
  },
  {
    "q": "What does the float placement parameter 'p' represent?",
    "o": [
      "Paragraph flow",
      "Page of floats (a page reserved exclusively for floating objects)",
      "Portrait mode",
      "Primary placement"
    ],
    "a": 1,
    "why": "p allows the float to be placed on a dedicated float page."
  },
  {
    "q": "What does an exclamation mark (!) indicate when added to float placement options (e.g. [!htbp])?",
    "o": [
      "Forces an immediate compile crash if placement fails",
      "Instructs LaTeX to relax its internal sizing and float restriction rules",
      "Makes the table borders bold",
      "Highlights the caption in red"
    ],
    "a": 1,
    "why": "! overrides LaTeX's restrictive float constraints regarding maximum floats per page."
  },
  {
    "q": "Which command assigns a descriptive title and entry in the List of Tables for a table float?",
    "o": [
      "\\title{...}",
      "\\caption{...}",
      "\\tabletitle{...}",
      "\\heading{...}"
    ],
    "a": 1,
    "why": "\\caption{...} creates a numbered caption and records the table in the .lot file."
  },
  {
    "q": "Where must the \\label command be positioned in a floating table for \\ref to record the correct table number?",
    "o": [
      "Before \\begin{table}",
      "Immediately after or inside the \\caption command",
      "Before \\begin{tabular}",
      "At the very end of the file"
    ],
    "a": 1,
    "why": "The counter is incremented by \\caption, so \\label must appear after or inside \\caption."
  },
  {
    "q": "How can you specify four identical centered columns without repeating 'c c c c'?",
    "o": [
      "*{4}{c}",
      "4*c",
      "c[4]",
      "rep(c,4)"
    ],
    "a": 0,
    "why": "*{N}{spec} repeats the column specification N times."
  },
  {
    "q": "Which popular package provides publication-quality horizontal rules (\\toprule, \\midrule, \\bottomrule)?",
    "o": [
      "tabularx",
      "booktabs",
      "array",
      "colortbl"
    ],
    "a": 1,
    "why": "booktabs provides professional rules with optimized spacing and varying line weights."
  },
  {
    "q": "How can extra vertical padding be added beneath a specific row in tabular?",
    "o": [
      "\\\\[6pt]",
      "\\hline[6pt]",
      "\\vspace{6pt}",
      "\\pad[6pt]"
    ],
    "a": 0,
    "why": "\\\\[length] adds optional vertical separation after that specific row break."
  },
  {
    "q": "Can a standard tabular environment automatically split across page breaks?",
    "o": [
      "Yes, it splits between any two rows",
      "No, standard tabular forms an unbreakable box; multi-page tables require longtable",
      "Only if height exceeds 1000pt",
      "Only in book class"
    ],
    "a": 1,
    "why": "tabular creates an unbreakable vertical box; packages like longtable handle multi-page tables."
  },
  {
    "q": "If a tabular environment has 4 columns, how many ampersands (&) must appear on each complete row?",
    "o": [
      "4",
      "3",
      "2",
      "5"
    ],
    "a": 1,
    "why": "N columns require exactly N - 1 separators (3 ampersands for 4 columns)."
  },
  {
    "q": "What error occurs if you include 4 ampersands (&) in a row declared with 4 columns?",
    "o": [
      "Overfull \\hbox",
      "Extra alignment tab has been changed to \\cr",
      "Underfull \\vbox",
      "Undefined control sequence"
    ],
    "a": 1,
    "why": "'Extra alignment tab has been changed to \\cr' is LaTeX's classic error for too many & on a row."
  }
]);

})();
