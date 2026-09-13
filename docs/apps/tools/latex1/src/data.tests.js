/* ═══════════════════ MODEL TESTS ═══════════════════ */
STATIONS.push({id:'test-1',title:'Model paper 1',short:'Model paper 1',est:'~75 min',body:H`
${gist('Sit it closed-book against the clock first, writing the code by hand. Only then open the answers — and press ▶ run on any code to check it.')}
${paper('MATHEMATICAL TYPE SETTING SYSTEM — LaTeX · Model Paper I (Modules I–II)','75 minutes','40')}
${secband('A','Answer any 4 questions. Each carries 3 marks. Ceiling: 12 marks.')}

${qa('3 m','1. What is LaTeX? How does it differ from a word processor?',H`
<p><b>LaTeX</b> is a document preparation system: a set of macros, written by Leslie Lamport, on top of Donald Knuth’s typesetting program <b>TeX</b>. The author writes a plain-text source file containing the text together with <i>markup commands</i>, and a TeX engine (<code>pdflatex</code>) compiles it into a finished PDF.</p>
<div class="scroll-x"><table class="ref"><tr><th></th><th>Word processor</th><th>LaTeX</th></tr>
<tr><td>Approach</td><td>WYSIWYG — format as you type</td><td>markup, WYSIWYM — describe structure, then compile</td></tr>
<tr><td>Formatting</td><td>chosen by hand, piece by piece</td><td>decided by the document class and packages</td></tr>
<tr><td>Numbering, contents, references</td><td>largely manual</td><td>automatic (sections, citations, index, contents)</td></tr>
<tr><td>Mathematics</td><td>awkward</td><td>excellent — the reason scientists use it</td></tr>
<tr><td>Source file</td><td>binary, program-specific</td><td>plain text, portable, works with version control</td></tr></table></div>
<p>The trade-off: LaTeX has a learning curve and needs a compile step, but gives consistent, professional typesetting, especially for long or mathematical documents.</p>`)}

${qa('3 m','2. List the special characters of LaTeX and state how each is printed.',H`
<p>These characters have a special meaning, so they cannot be typed directly as text:</p>
<div class="scroll-x"><table class="ref"><tr><th>Char</th><th>Meaning</th><th>Printed with</th></tr>
<tr><td><code>#</code></td><td>macro parameter</td><td><code>\#</code></td></tr>
<tr><td><code>$</code></td><td>math mode</td><td><code>\$</code></td></tr>
<tr><td><code>%</code></td><td>comment</td><td><code>\%</code></td></tr>
<tr><td><code>&amp;</code></td><td>table column separator</td><td><code>\&amp;</code></td></tr>
<tr><td><code>_</code></td><td>subscript</td><td><code>\_</code></td></tr>
<tr><td><code>{ }</code></td><td>grouping</td><td><code>\{ \}</code></td></tr>
<tr><td><code>~</code></td><td>unbreakable space</td><td><code>\textasciitilde</code></td></tr>
<tr><td><code>^</code></td><td>superscript</td><td><code>\textasciicircum</code></td></tr>
<tr><td><code>\</code></td><td>starts a command</td><td><code>\textbackslash</code></td></tr></table></div>
${ex(L`\# \$ \% \& \_ \{ \} \textasciitilde{} \textasciicircum{} \textbackslash`,{title:'all of them'})}
<p>Note that <code>\\</code> is a line break, not a backslash.</p>`)}

${qa('3 m','3. Explain \\documentclass and its options with an example.',H`
<p><code>\documentclass[options]{class}</code> must be the first command of every LaTeX file. The <b>class</b> selects the overall design — <code>article</code>, <code>report</code>, <code>book</code>, <code>letter</code>. The <b>options</b>, in square brackets and separated by commas, adjust it:</p>
<ul><li>font size: <code>10pt</code> (default), <code>11pt</code>, <code>12pt</code></li>
<li>paper: <code>a4paper</code>, <code>letterpaper</code>, <code>a5paper</code></li>
<li>sides and columns: <code>oneside</code>/<code>twoside</code>, <code>onecolumn</code>/<code>twocolumn</code>; <code>landscape</code></li>
<li>title page: <code>titlepage</code>/<code>notitlepage</code>; chapters: <code>openright</code>/<code>openany</code>; <code>draft</code>/<code>final</code></li></ul>
${ex(L`\documentclass[12pt,a4paper,twoside]{report}
\begin{document}
\chapter{Introduction}
A report in 12 pt on A4 paper, set up for two-sided printing.
\end{document}`,{title:'class with options'})}`)}

${qa('3 m','4. Differentiate between the quote, quotation and verse environments.',H`
<p>All three display borrowed text indented from both margins; they differ in what they are for and how paragraphs and lines are treated.</p>
<ul><li><b>quote</b> — short quotations. Paragraphs are not indented; extra space separates them.</li>
<li><b>quotation</b> — long quotations of several paragraphs. The first line of each paragraph is indented, like running text.</li>
<li><b>verse</b> — poetry. Each line ends with <code>\\</code>, stanzas are separated by a blank line, and lines too long for the width hang with an indent.</li></ul>
${ex(L`\begin{quote}Short and to the point.\end{quote}
\begin{quotation}A long passage, first paragraph.

Second paragraph, indented.\end{quotation}
\begin{verse}Line one of the poem,\\ line two.\end{verse}`,{title:'the three side by side'})}`)}

${qa('3 m','5. What is the use of \\kill in the tabbing environment? Illustrate.',H`
<p>In <code>tabbing</code>, tab stops are set with <code>\=</code> at the position where it is typed. It is convenient to set all the stops on a <b>template line</b> containing the widest entries — but that line should not be printed. Ending a line with <code>\kill</code> instead of <code>\\</code> keeps the stops it sets and <b>discards the line itself</b>.</p>
${ex(L`\begin{tabbing}
Name of student\= Marks\= Grade\kill   % sets the stops, not printed
Anu            \> 88   \> A\\
Balu           \> 72   \> B
\end{tabbing}`,{title:'a template line with \\kill'})}`)}

${qa('3 m','6. Write the commands for a hyphen, an en dash and an em dash, and say when each is used.',H`
<ul><li><code>-</code> (one hyphen) — the <b>hyphen</b>, inside compound words: <i>well-known</i>, <i>X-ray</i>.</li>
<li><code>--</code> (two) — the <b>en dash</b>, for ranges: <i>pages 10–20</i>, <i>1978–1985</i>.</li>
<li><code>---</code> (three) — the <b>em dash</b>, for a break in thought — like this.</li></ul>
${ex(L`A well-known result, see pages 10--20 --- it is short.`,{title:'the three dashes'})}
<p>A minus sign is different again: it only exists in math, <code>$-1$</code>.</p>`)}

${secband('B','Answer any 3 questions. Each carries 6 marks. Ceiling: 18 marks.')}

${qa('6 m','7. Explain the sectioning commands in LaTeX with their levels. How do the starred forms and \\appendix behave? Write the skeleton of a report.',H`
<p>Sectioning commands divide a document, number the headings automatically, set them in the right size and send them to the table of contents.</p>
<div class="scroll-x"><table class="ref"><tr><th>Command</th><th>Level</th><th>Note</th></tr>
<tr><td><code>\part</code></td><td>−1</td><td>does not affect chapter numbering</td></tr>
<tr><td><code>\chapter</code></td><td>0</td><td>report and book only</td></tr>
<tr><td><code>\section</code></td><td>1</td><td></td></tr>
<tr><td><code>\subsection</code></td><td>2</td><td></td></tr>
<tr><td><code>\subsubsection</code></td><td>3</td><td></td></tr>
<tr><td><code>\paragraph</code>, <code>\subparagraph</code></td><td>4, 5</td><td>run-in headings, unnumbered by default</td></tr></table></div>
<p><b>Starred forms</b> such as <code>\section*{…}</code> print the heading without a number and leave it out of the table of contents (add it back with <code>\addcontentsline</code> if needed). <b><code>\appendix</code></b> resets the counter and switches numbering to letters: later chapters (report/book) or sections (article) become A, B, C. The depth of numbering is controlled by the counter <code>secnumdepth</code>, and the depth of the contents by <code>tocdepth</code>.</p>
${ex(L`\documentclass{report}
\title{Survey of Student Reading Habits}
\author{A. Nair}
\begin{document}
\maketitle
\tableofcontents
\chapter{Introduction}
\section{Aim}
\section{Scope}
\chapter{Method}
\section{Sampling}
\subsection{Urban colleges}
\chapter*{Acknowledgements}
\appendix
\chapter{Questionnaire}
\end{document}`,{title:'report skeleton'})}`)}

${qa('6 m','8. Explain the thebibliography environment and \\cite with an example. How does this differ from using BibTeX?',H`
<p>The <code>thebibliography</code> environment produces the reference list; its argument is the <i>widest label</i> (e.g. <code>9</code> for up to nine entries) and sets the indentation. Each entry begins with <code>\bibitem{key}</code> — or <code>\bibitem[label]{key}</code> for a custom label. In the text, <code>\cite{key}</code> prints the label; <code>\cite{a,b}</code> cites several; <code>\cite[p.~5]{key}</code> adds a note. The heading is “References” in article and “Bibliography” in report/book.</p>
${ex(L`\TeX{} was designed by Knuth~\cite{knuth}; see also \cite[ch.~2]{lamport}.

\begin{thebibliography}{9}
\bibitem{knuth} D.~E. Knuth, \emph{The \TeX book}, Addison-Wesley, 1984.
\bibitem{lamport} L.~Lamport, \emph{\LaTeX: A Document Preparation System},
  Addison-Wesley, 1994.
\end{thebibliography}`,{title:'manual bibliography'})}
<p>Citations need two compiler runs: the first records them in the <code>.aux</code> file, the second prints the labels.</p>
<p><b>Difference from BibTeX.</b> With <code>thebibliography</code> you type every entry yourself, in the order and format you want, and uncited entries still appear. With <b>BibTeX</b> the references live in a separate <code>.bib</code> database; you write only <code>\bibliographystyle{…}</code> and <code>\bibliography{file}</code>, and BibTeX selects just the cited entries, sorts them, and formats them according to the style. One database serves every document, and changing the style reformats the whole list at once.</p>`)}

${qa('6 m','9. How is an index prepared in LaTeX? Explain the package, the commands, sub-entries, cross-references and the compilation sequence.',H`
<p><b>Setting up.</b> Load the <code>makeidx</code> package and give <code>\makeindex</code> in the preamble — without it, entries are silently discarded. Mark each term in the text with <code>\index{term}</code>, and put <code>\printindex</code> where the index should appear (usually the end).</p>
<p><b>Forms of entry:</b></p>
<ul><li><code>\index{fonts}</code> — a main entry.</li>
<li><code>\index{fonts!serif}</code> — a sub-entry (up to three levels with <code>!</code>).</li>
<li><code>\index{Knuth@\textsc{Knuth}}</code> — sort by the part before <code>@</code>, print the part after.</li>
<li><code>\index{TeX|see{LaTeX}}</code> — a cross-reference instead of a page number; <code>|seealso{…}</code> adds one.</li>
<li><code>\index{tables|textbf}</code> — this page number in bold; <code>|(</code> and <code>|)</code> mark a page range.</li></ul>
${ex(L`\documentclass{article}
\usepackage{makeidx}
\makeindex
\begin{document}
\TeX\index{TeX} uses fonts\index{fonts!serif} and more
fonts\index{fonts!sans serif}. See Knuth\index{Knuth@\textsc{Knuth}}.
\LaTeX\index{LaTeX}\index{TeX|see{LaTeX}}
\printindex
\end{document}`,{title:'an index'})}
<p><b>Compilation.</b> (1) <code>pdflatex</code> writes every entry, with its page, to the <code>.idx</code> file. (2) The <b>MakeIndex</b> program sorts and merges the entries and writes <code>theindex</code> to the <code>.ind</code> file. (3) <code>pdflatex</code> again reads the <code>.ind</code> file and prints the index at <code>\printindex</code>.</p>`)}

${qa('6 m','10. Write LaTeX code for a numbered list whose second level is labelled (a), (b), and explain how the labels of lists are changed.',H`
<p><code>enumerate</code> numbers items automatically; nested lists change style by level — <b>1.</b>, <b>(a)</b>, <b>i.</b>, <b>A.</b> — so the required labels are the defaults:</p>
${ex(L`\begin{enumerate}
  \item Document structure
  \begin{enumerate}
    \item document class
    \item preamble
  \end{enumerate}
  \item Typesetting text
\end{enumerate}`,{title:'1. with (a) (b) nested'})}
<p><b>Changing labels.</b> One item: <code>\item[text]</code>. All bullets of <code>itemize</code>: redefine <code>\labelitemi</code> … <code>\labelitemiv</code>. For <code>enumerate</code>, <code>\theenumi</code> controls how the counter <code>enumi</code> prints (<code>\arabic</code>, <code>\roman</code>, <code>\Roman</code>, <code>\alph</code>, <code>\Alph</code>) and <code>\labelenumi</code> is the complete label built from it.</p>
${ex(L`\renewcommand{\labelitemi}{--}
\renewcommand{\theenumi}{\Roman{enumi}}
\renewcommand{\labelenumi}{\theenumi.}
\begin{itemize}\item a dash bullet\end{itemize}
\begin{enumerate}\item Roman I.\item Roman II.\end{enumerate}`,{title:'redefining labels'})}`)}

${qa('6 m','Given the output below, write the complete LaTeX code to produce it: a ruled mark sheet with proper alignments and horizontal rules.',H`
<p><b>Target Output to produce:</b></p>
<div class="target-card">
  <div style="font-family:var(--f-m);font-size:.65rem;letter-spacing:.12em;text-transform:uppercase;color:var(--faint);margin-bottom:.5rem">Target Output</div>
  <table style="margin:0 auto;border-collapse:collapse;border:1px solid #111;text-align:center;font-family:var(--f-serif,'Newsreader',serif);font-size:.9rem">
    <thead>
      <tr style="border-bottom:2px solid #111;background:#f8f6f2">
        <th style="padding:4px 14px;border-right:1px solid #111">Roll No</th>
        <th style="padding:4px 14px;border-right:1px solid #111;text-align:left">Name</th>
        <th style="padding:4px 14px;border-right:1px solid #111">Marks</th>
        <th style="padding:4px 14px">Grade</th>
      </tr>
    </thead>
    <tbody>
      <tr style="border-bottom:1px solid #111"><td style="padding:4px 14px;border-right:1px solid #111">101</td><td style="padding:4px 14px;border-right:1px solid #111;text-align:left">Arya M.</td><td style="padding:4px 14px;border-right:1px solid #111">92</td><td style="padding:4px 14px">A+</td></tr>
      <tr style="border-bottom:1px solid #111"><td style="padding:4px 14px;border-right:1px solid #111">102</td><td style="padding:4px 14px;border-right:1px solid #111;text-align:left">Deepak K.</td><td style="padding:4px 14px;border-right:1px solid #111">78</td><td style="padding:4px 14px">B</td></tr>
      <tr><td style="padding:4px 14px;border-right:1px solid #111">103</td><td style="padding:4px 14px;border-right:1px solid #111;text-align:left">Fathima S.</td><td style="padding:4px 14px;border-right:1px solid #111">85</td><td style="padding:4px 14px">A</td></tr>
    </tbody>
  </table>
</div>
<p><b>Write the code:</b> Write the LaTeX code in the interactive editor below to match this target table. The live preview renders below as you type, and the checklist ticks itself:</p>
${build('Given output: Student Marks Table',L`\documentclass{article}
\begin{document}
% Write your tabular environment here to reproduce the table:

\end{document}`,{brief:'Create a tabular matching the target output: column specification |c|l|c|c|, \\hline between all rows, header row (Roll No, Name, Marks, Grade), and the three data rows.',
checks:[{re:'\\\\begin\\{tabular\\}\\{\\|c\\|l\\|c\\|c\\|\\}',msg:'tabular with |c|l|c|c| spec'},
{re:'Roll No.*Name.*Marks.*Grade',msg:'header row columns'},
{re:'Arya M\\..*Deepak K\\..*Fathima S\\.',flags:'s',msg:'all three student data rows'},
{re:'\\\\hline',msg:'horizontal rules (\\hline)'}]})}
<p><b>Model Solution:</b></p>
${ex(L`\documentclass{article}
\begin{document}
\begin{center}
\begin{tabular}{|c|l|c|c|}
\hline
\textbf{Roll No} & \textbf{Name} & \textbf{Marks} & \textbf{Grade} \\ \hline\hline
101 & Arya M.    & 92 & A+ \\ \hline
102 & Deepak K.  & 78 & B  \\ \hline
103 & Fathima S. & 85 & A  \\ \hline
\end{tabular}
\end{center}
\end{document}`,{title:'Solution — Marks Table'})}`)}

${secband('C','Answer any 1 question. Each carries 10 marks.')}

${qa('10 m','11. (a) Explain the tabular environment: column specification, rules, \\multicolumn, \\cline and p-columns. (6) (b) Write the code for a ruled mark sheet with a heading spanning all columns. (4)',H`
<p><b>(a)</b> <code>\begin{tabular}{spec} … \end{tabular}</code> sets material in rows and columns. The <b>spec</b> has one entry per column: <code>l</code>, <code>c</code>, <code>r</code> for left, centred and right alignment (these never wrap), and <code>p{width}</code> for a fixed-width column in which text wraps like a paragraph. A <code>|</code> in the spec draws a vertical rule; <code>@{text}</code> replaces the inter-column space with <i>text</i>; <code>*{n}{spec}</code> repeats a spec.</p>
<p>In the body, <code>&amp;</code> separates cells and <code>\\</code> ends a row. <code>\hline</code> draws a horizontal rule across the whole table; <code>\cline{i-j}</code> draws one under columns <i>i</i> to <i>j</i> only. <code>\multicolumn{n}{spec}{text}</code> makes one cell span <i>n</i> columns with its own alignment and rules, and is also used to change the alignment of a single cell. Each row may have no more cells than the spec has columns. Row spacing is scaled with <code>\renewcommand{\arraystretch}{…}</code> and column spacing with <code>\setlength{\tabcolsep}{…}</code>.</p>
${ex(L`\begin{tabular}{|l|p{3cm}|r|}
\hline
Code & Description & Qty \\ \hline
A1 & A long description that wraps inside the p column & 4 \\ \cline{2-3}
A2 & Short & 12 \\ \hline
\end{tabular}`,{title:'rules, \\cline and a p column'})}
<p><b>(b)</b></p>
${ex(L`\begin{table}[h]
\centering
\caption{Semester V marks}
\begin{tabular}{|l|c|c|c|}
\hline
\multicolumn{4}{|c|}{\textbf{Mark Sheet --- B.Sc.\ Mathematics}} \\ \hline
Name & Paper I & Paper II & Total \\ \hline\hline
Anu  & 45      & 42       & 87    \\ \hline
Balu & 38      & 44       & 82    \\ \hline
\end{tabular}
\end{table}`,{title:'the mark sheet'})}`)}

${qa('10 m','12. (a) Explain BibTeX: the structure of a .bib file, common entry types with their required fields, bibliography styles and the compilation sequence. (6) (b) Write .bib entries for a book and a journal article and cite both. (4)',H`
<p><b>(a)</b> BibTeX keeps references in a plain-text database file with the extension <code>.bib</code>. Each entry has the form <code>@type{key, field = {value}, …}</code>: the <i>type</i> says what kind of work it is, the <i>key</i> is the name used in <code>\cite</code>, and the fields hold the data. Fields are separated by commas; several authors are joined with <code>and</code>; capitals to be preserved are protected with braces.</p>
<div class="scroll-x"><table class="ref"><tr><th>Type</th><th>Required fields</th></tr>
<tr><td><code>@article</code></td><td>author, title, journal, year</td></tr>
<tr><td><code>@book</code></td><td>author/editor, title, publisher, year</td></tr>
<tr><td><code>@inproceedings</code></td><td>author, title, booktitle, year</td></tr>
<tr><td><code>@phdthesis</code> / <code>@mastersthesis</code></td><td>author, title, school, year</td></tr>
<tr><td><code>@techreport</code></td><td>author, title, institution, year</td></tr>
<tr><td><code>@misc</code></td><td>none</td></tr></table></div>
<p><b>Styles</b> (<code>\bibliographystyle</code>): <code>plain</code> — numbered, sorted by author; <code>unsrt</code> — numbered in order of citation; <code>alpha</code> — labels such as [Knu84], sorted; <code>abbrv</code> — like plain but with initials. In the document, <code>\bibliography{refs}</code> names the database (without <code>.bib</code>) and marks where the list goes; <code>\nocite{*}</code> includes every entry.</p>
<p><b>Sequence:</b> <code>pdflatex</code> (writes citations to <code>.aux</code>) → <code>bibtex</code> (reads <code>.aux</code> and <code>.bib</code>, writes the list to <code>.bbl</code>) → <code>pdflatex</code> (reads <code>.bbl</code>) → <code>pdflatex</code> (resolves the citation labels).</p>
<p><b>(b)</b></p>
${ex(L`\documentclass{article}
\begin{document}
Knuth designed \TeX~\cite{knuth84}; Lamport described \LaTeX~\cite{lamport86}.
\bibliographystyle{plain}
\bibliography{refs}
\end{document}`,{title:'citing from refs.bib',bib:L`@book{knuth84,
  author    = {Donald E. Knuth},
  title     = {The {\TeX}book},
  publisher = {Addison-Wesley},
  address   = {Reading, Massachusetts},
  year      = {1984}
}
@article{lamport86,
  author  = {Leslie Lamport},
  title   = {{\LaTeX}: A Document Preparation System},
  journal = {TUGboat},
  volume  = {7},
  number  = {1},
  pages   = {10--20},
  year    = {1986}
}`,note:'Run it and open the <b>refs.bib</b> tab — those are the two entries the question asks for.'})}`)}
`});

STATIONS.push({id:'test-2',title:'Model paper 2',short:'Model paper 2',est:'~75 min',body:H`
${gist('Same pattern, different questions — together the two papers cover every unit of Modules I and II.')}
${paper('MATHEMATICAL TYPE SETTING SYSTEM — LaTeX · Model Paper II (Modules I–II)','75 minutes','40')}
${secband('A','Answer any 4 questions. Each carries 3 marks. Ceiling: 12 marks.')}

${qa('3 m','1. What is the preamble of a LaTeX document? What does it contain?',H`
<p>The <b>preamble</b> is everything between <code>\documentclass</code> and <code>\begin{document}</code>. Nothing in it is printed; it holds settings for the whole document:</p>
<ul><li>packages: <code>\usepackage[options]{name}</code></li>
<li>title information: <code>\title</code>, <code>\author</code>, <code>\date</code></li>
<li>definitions: <code>\newcommand</code>, <code>\renewcommand</code></li>
<li>global settings: <code>\pagestyle</code>, <code>\makeindex</code>, lengths.</li></ul>
${ex(L`\documentclass[12pt]{article}
\usepackage{makeidx}          % a package
\makeindex                    % a setting
\newcommand{\college}{St.~Thomas College}   % a definition
\title{Report} \author{A. Nair}
\begin{document}
\maketitle
Submitted to \college.
\end{document}`,{title:'a typical preamble'})}
<p>Text placed in the preamble is an error: “Missing \begin{document}”.</p>`)}

${qa('3 m','2. Explain \\pagestyle and \\pagenumbering with their options.',H`
<p><code>\pagestyle{style}</code> sets the running head and foot of every page from that point:</p>
<ul><li><code>plain</code> — page number centred in the footer (default in article and report)</li>
<li><code>empty</code> — no header or footer at all</li>
<li><code>headings</code> — the header shows the current chapter/section title and the page number</li>
<li><code>myheadings</code> — like headings, but the header text is set by the author with <code>\markboth{left}{right}</code> or <code>\markright{right}</code>.</li></ul>
<p><code>\thispagestyle{style}</code> changes only the current page. <code>\pagenumbering{style}</code> sets the numerals and restarts at 1: <code>arabic</code> (1, 2), <code>roman</code> (i, ii), <code>Roman</code> (I, II), <code>alph</code> (a, b), <code>Alph</code> (A, B).</p>
${ex(L`\pagestyle{headings}
\pagenumbering{roman}
\section{Preface}
Front matter numbered i, ii, …`,{title:'page style and numbering',note:'Only real pages show this — use the Real PDF tab.'})}`)}

${qa('3 m','3. List the font-size commands of LaTeX in increasing order.',H`
<p>The size declarations are relative to the base size chosen by the class option (10, 11 or 12 pt):</p>
<p><code>\tiny</code> &lt; <code>\scriptsize</code> &lt; <code>\footnotesize</code> &lt; <code>\small</code> &lt; <code>\normalsize</code> &lt; <code>\large</code> &lt; <code>\Large</code> &lt; <code>\LARGE</code> &lt; <code>\huge</code> &lt; <code>\Huge</code></p>
${ex(L`{\tiny tiny} {\small small} {\normalsize normal} {\large large}
{\Large Large} {\LARGE LARGE} {\huge huge} {\Huge Huge}`,{title:'sizes'})}
<p>They are declarations, so they are used inside a group: <code>{\Large text}</code>.</p>`)}

${qa('3 m','4. How is a table of contents produced? Why must the file be compiled twice?',H`
<p>The command <code>\tableofcontents</code> prints the contents where it is placed. LaTeX builds it automatically from the numbered sectioning commands (<code>\chapter</code>, <code>\section</code>, …) up to the depth set by <code>tocdepth</code>; starred sections are excluded unless added with <code>\addcontentsline</code>.</p>
<p><b>Two runs:</b> during the first compilation LaTeX writes each heading and its page number into an auxiliary <code>.toc</code> file; the contents cannot be printed yet because the headings come later in the document. On the second compilation LaTeX reads the <code>.toc</code> file and prints the list. <code>\listoftables</code> and <code>\listoffigures</code> work the same way with <code>.lot</code> and <code>.lof</code> files.</p>
<div class="callout warning" style="margin:.6rem 0;padding:.6rem .8rem;border-left:4px solid var(--amber);background:rgba(var(--amber-rgb),.08);border-radius:.4rem;font-size:.84rem">
  <b>In-browser preview note:</b> <code>\tableofcontents</code> needs multi-pass <code>.toc</code> generation. Open in the <b>IDE</b> and compile with <b>⎙ Real PDF</b> to see the live table of contents.
</div>
<div class="target-card" style="margin:.7rem 0;max-width:30rem">
  <div style="font-family:var(--f-serif,'Newsreader',serif);font-size:1.15rem;font-weight:700;margin-bottom:.6rem;text-align:center;color:#111">Contents</div>
  <div style="font-family:var(--f-serif,'Newsreader',serif);font-size:.88rem;color:#111;line-height:1.8">
    <div style="display:flex;align-items:baseline"><span style="font-weight:600;width:1.5rem">1</span><span style="font-weight:600">Introduction</span><span style="flex:1;border-bottom:1px dotted #888;margin:0 .4rem 3px"></span><span style="font-weight:600">1</span></div>
    <div style="display:flex;align-items:baseline"><span style="font-weight:600;width:1.5rem">2</span><span style="font-weight:600">Theory</span><span style="flex:1;border-bottom:1px dotted #888;margin:0 .4rem 3px"></span><span style="font-weight:600">1</span></div>
    <div style="display:flex;align-items:baseline;padding-left:1.3rem"><span style="width:2rem">2.1</span><span>History</span><span style="flex:1;border-bottom:1px dotted #888;margin:0 .4rem 3px"></span><span>2</span></div>
  </div>
</div>
${ex(L`\tableofcontents
\section{Introduction}
\section{Theory}
\subsection{History}`,{title:'\\tableofcontents',note:'Open in the <b>IDE</b> and compile with <b>⎙ PDF</b> for the genuine multi-pass table of contents.'})}`)}

${qa('3 m','5. Write the code for a description list of three document classes.',H`
${ex(L`\begin{description}
  \item[article] Short documents: papers, assignments; no chapters.
  \item[report] Longer documents such as project reports; has chapters.
  \item[book] Books; chapters, two-sided printing by default.
\end{description}`,{title:'description list'})}
<p>In a <code>description</code> list the optional argument of <code>\item[…]</code> is the term, printed in bold, followed by its description.</p>`)}

${qa('3 m','6. How is text typeset verbatim? Mention \\verb and its restriction.',H`
<p>The <code>verbatim</code> environment prints its contents exactly as typed, in a typewriter font: commands, special characters, spaces and line breaks are all reproduced. <code>verbatim*</code> shows spaces as ␣. For short pieces within a line, <code>\verb</code> is followed by any delimiter character, the text, and the same delimiter: <code>\verb|\section{x}|</code>.</p>
${ex(L`\begin{verbatim}
\section{Intro}   % shown, not obeyed
\end{verbatim}
Inline: \verb|\textbf{x}| and \verb+100%+.`,{title:'verbatim and \\verb'})}
<p><b>Restriction:</b> <code>\verb</code> may not appear in the argument of another command (e.g. inside <code>\section{…}</code> or <code>\textbf{…}</code>) — it gives “\verb illegal in command argument” — and the delimiter must not occur in the text.</p>`)}

${secband('B','Answer any 3 questions. Each carries 6 marks. Ceiling: 18 marks.')}

${qa('6 m','7. Describe how the title of a document is produced: \\title, \\author, \\and, \\thanks, \\date, \\maketitle and the abstract. Give an example.',H`
<ul><li><code>\title{…}</code> — the title; <code>\\</code> breaks it into lines.</li>
<li><code>\author{…}</code> — the author(s); several are separated by <code>\and</code>, and <code>\\</code> adds lines such as an affiliation.</li>
<li><code>\thanks{…}</code> — inside <code>\title</code> or <code>\author</code>, a footnote marked with a symbol, for acknowledgements or addresses.</li>
<li><code>\date{…}</code> — the date; the default is <code>\today</code>; <code>\date{}</code> prints none.</li>
<li><code>\maketitle</code> — actually prints the title block. The previous commands only store information; without <code>\maketitle</code> nothing appears.</li>
<li><code>abstract</code> environment — a short summary, set in smaller type with the heading “Abstract”. In article it follows the title on the first page; with the <code>titlepage</code> option (or in report) the title goes on a separate page.</li></ul>
${ex(L`\title{Reading Habits of College Students\thanks{Funded by the college research cell.}}
\author{Anu Mathew\\ Dept.\ of Mathematics \and Balu Das\\ Dept.\ of Physics}
\date{\today}
\maketitle
\begin{abstract}
We surveyed 200 students on their reading habits.
\end{abstract}
\section{Introduction}`,{title:'a complete title block'})}
<p>For complete control a <code>titlepage</code> environment can be used to design the title page by hand.</p>`)}

${qa('6 m','8. Explain the tabbing environment and its commands. Compare it with tabular.',H`
<p><code>tabbing</code> aligns text in columns the way the tab key of a typewriter does. Tab stops are set where <code>\=</code> is typed; <code>\></code> moves to the next stop; <code>\\</code> ends a line; <code>\kill</code> ends a line that only sets stops and is not printed. <code>\+</code> indents all following lines by one tab stop and <code>\-</code> undoes it; <code>\&lt;</code> moves back to the previous stop at the start of a line.</p>
${ex(L`\begin{tabbing}
Programme\hspace{1cm}\= Semester\hspace{.5cm}\= Credits\kill
B.Sc.   \> V       \> 3\\
M.Sc.   \> III     \> 4
\end{tabbing}`,{title:'tabbing'})}
<div class="scroll-x"><table class="ref"><tr><th></th><th>tabbing</th><th>tabular</th></tr>
<tr><td>Column width</td><td>fixed by the stops</td><td>automatic, from the widest entry</td></tr>
<tr><td>Alignment</td><td>left only</td><td>l, c, r, p{…}</td></tr>
<tr><td>Rules</td><td>none</td><td>| , \hline, \cline</td></tr>
<tr><td>Page breaks</td><td>may break across pages</td><td>one unbreakable box</td></tr>
<tr><td>Nesting</td><td>cannot be nested</td><td>can be nested, used inside text</td></tr></table></div>`)}

${qa('6 m','9. Explain the font commands of LaTeX — families, series and shapes — distinguishing commands from declarations, and the use of \\emph.',H`
<p>A font is described by independent attributes, each changed by a <b>command</b> that takes the text as argument or by a <b>declaration</b> that acts until the end of the current group:</p>
<div class="scroll-x"><table class="ref"><tr><th>Attribute</th><th>Command</th><th>Declaration</th></tr>
<tr><td>Family: roman, sans serif, typewriter</td><td><code>\textrm \textsf \texttt</code></td><td><code>\rmfamily \sffamily \ttfamily</code></td></tr>
<tr><td>Series: medium, bold</td><td><code>\textmd \textbf</code></td><td><code>\mdseries \bfseries</code></td></tr>
<tr><td>Shape: upright, italic, slanted, small caps</td><td><code>\textup \textit \textsl \textsc</code></td><td><code>\upshape \itshape \slshape \scshape</code></td></tr></table></div>
<p>Attributes combine: <code>\textbf{\textit{…}}</code> is bold italic. Commands suit short pieces; declarations suit longer passages or definitions: <code>{\sffamily …}</code>. <b><code>\emph</code></b> marks emphasis logically: it italicises in upright text and switches back to upright inside italic text, so emphasis is always visible. Sizes are set separately with <code>\small</code>, <code>\large</code>, etc.</p>
${ex(L`\textsf{Sans} \texttt{Typewriter} \textbf{Bold} \textit{Italic} \textsc{Small Caps}
{\sffamily\bfseries a declaration in a group}
\textit{Italic with \emph{emphasis} inside.}`,{title:'fonts'})}`)}

${qa('6 m','10. Explain the standard bibliography styles plain, unsrt, alpha and abbrv, with the kind of output each gives.',H`
<p>The style, chosen with <code>\bibliographystyle{…}</code> before <code>\bibliography{…}</code>, decides the labels, the order and the format of the list. For the same two references by Knuth (1984) and Lamport (1994), cited Lamport first:</p>
<div class="scroll-x"><table class="ref"><tr><th>Style</th><th>Order</th><th>Labels and names</th></tr>
<tr><td><code>plain</code></td><td>alphabetical by author</td><td>[1] Donald E. Knuth…, [2] Leslie Lamport…</td></tr>
<tr><td><code>unsrt</code></td><td>order of first citation</td><td>[1] Leslie Lamport…, [2] Donald E. Knuth…</td></tr>
<tr><td><code>alpha</code></td><td>alphabetical</td><td>[Knu84] Donald E. Knuth…, [Lam94] Leslie Lamport…</td></tr>
<tr><td><code>abbrv</code></td><td>alphabetical</td><td>[1] D. E. Knuth…, [2] L. Lamport… (initials, shortened months and journal names)</td></tr></table></div>
${ex(L`Cited first: \cite{lamport}, then \cite{knuth}.
\bibliographystyle{alpha}   % change to plain, unsrt, abbrv
\bibliography{refs}`,{title:'compare the styles yourself',bib:L`@book{knuth, author={Donald E. Knuth}, title={The {\TeX}book}, publisher={Addison-Wesley}, year={1984}}
@book{lamport, author={Leslie Lamport}, title={{\LaTeX}: A Document Preparation System}, publisher={Addison-Wesley}, year={1994}}`})}`)}

${qa('6 m','Given the output below, write the complete LaTeX code to produce it: a nested outline structure using enumerate and itemize.',H`
<p><b>Target Output to produce:</b></p>
<div class="target-card">
  <div style="font-family:var(--f-m);font-size:.65rem;letter-spacing:.12em;text-transform:uppercase;color:var(--faint);margin-bottom:.5rem">Target Output</div>
  <div style="font-family:var(--f-serif,'Newsreader',serif);font-size:.95rem;line-height:1.6;padding:0 .5rem">
    <div style="font-weight:700;font-size:1.15rem;margin-bottom:.5rem">Course Syllabus</div>
    <ol style="margin:0;padding-left:1.4rem">
      <li><b>Core Modules</b>
        <ul style="list-style-type:disc;margin:.25rem 0;padding-left:1.2rem">
          <li>Mechanics &amp; Relativity</li>
          <li>Electromagnetism</li>
        </ul>
      </li>
      <li><b>Lab Practicals</b>
        <ul style="list-style-type:disc;margin:.25rem 0;padding-left:1.2rem">
          <li>Optics Experiment</li>
          <li>Spectroscopy</li>
        </ul>
      </li>
    </ol>
  </div>
</div>
<p><b>Write the code:</b> Write the LaTeX code in the interactive editor below using <code>enumerate</code> and <code>itemize</code> environments to match this target output. Live preview updates as you type, and verification ticks in real time:</p>
${build('Given output: Course Syllabus Hierarchy',L`\documentclass{article}
\begin{document}
% Write your nested enumerate and itemize code here:

\end{document}`,{brief:'Create a nested list structure: outer enumerate with 2 numbered items ("Core Modules" and "Lab Practicals" in bold), and nested itemize lists under each containing the corresponding subtopics.',
checks:[{re:'\\\\begin\\{enumerate\\}',msg:'outer \\begin{enumerate}'},
{re:'\\\\begin\\{itemize\\}',msg:'nested \\begin{itemize}'},
{re:'Mechanics.*Electromagnetism',flags:'s',msg:'Core Modules subitems'},
{re:'Optics.*Spectroscopy',flags:'s',msg:'Lab Practicals subitems'},
{re:'\\\\end\\{enumerate\\}',msg:'outer \\end{enumerate}'}]})}
<p><b>Model Solution:</b></p>
${ex(L`\documentclass{article}
\begin{document}
\section*{Course Syllabus}
\begin{enumerate}
  \item \textbf{Core Modules}
    \begin{itemize}
      \item Mechanics \& Relativity
      \item Electromagnetism
    \end{itemize}
  \item \textbf{Lab Practicals}
    \begin{itemize}
      \item Optics Experiment
      \item Spectroscopy
    \end{itemize}
\end{enumerate}
\end{document}`,{title:'Solution — Course Syllabus Hierarchy'})}`)}

${secband('C','Answer any 1 question. Each carries 10 marks.')}

${qa('10 m','11. (a) Explain the table float: placement specifiers, \\caption, \\label and cross-referencing, and the list of tables. (6) (b) Write the code for a timetable with a title row spanning all columns and a partial rule made with \\cline. (4)',H`
<p><b>(a)</b> A <code>tabular</code> is only the grid of rows and columns. The <code>table</code> environment is a <b>float</b>: a box that LaTeX may move to a good position on the page, and which can have a numbered caption. The optional <b>placement specifier</b> lists the allowed positions: <code>h</code> — here, near the source position; <code>t</code> — top of a page; <code>b</code> — bottom of a page; <code>p</code> — a separate page of floats; <code>!</code> — override LaTeX’s usual restrictions. <code>[htbp]</code> allows all four.</p>
<p><code>\caption{…}</code> prints “Table <i>n</i>: …”, numbering the tables automatically; by convention the caption of a table is placed above it. <code>\label{key}</code> placed <i>after</i> the caption records the number, and <code>\ref{key}</code> anywhere in the document prints it (<code>\pageref{key}</code> the page). Captions also feed <code>\listoftables</code>, which prints the list of tables — built, like the table of contents, over two runs. <code>\centering</code> inside the float centres the tabular.</p>
${ex(L`As Table~\ref{tab:fees} shows, fees are low.
\begin{table}[htbp]
\centering
\caption{Fee structure}\label{tab:fees}
\begin{tabular}{|l|r|}
\hline Course & Fee \\ \hline
B.Sc. & 12000 \\ \hline
\end{tabular}
\end{table}
\listoftables`,{title:'caption, label, ref, list of tables'})}
<p><b>(b)</b></p>
${ex(L`\begin{table}[h]
\centering
\caption{Monday timetable}
\begin{tabular}{|c|c|c|c|}
\hline
\multicolumn{4}{|c|}{\textbf{B.Sc.\ Mathematics --- Semester V}} \\ \hline
Time & 9--10 & 10--11 & 11--12 \\ \hline
Mon  & LaTeX & Algebra & Analysis \\ \cline{2-4}
     & Lab   & Lab     & Tutorial \\ \hline
\end{tabular}
\end{table}`,{title:'the timetable'})}`)}

${qa('10 m','12. (a) Explain commands, environments, arguments, groups and declarations in LaTeX with examples. (6) (b) Explain why special characters must be escaped, and write a line that prints “50% of R&D costs $5 — item #1” correctly. (4)',H`
<p><b>(a)</b> A <b>command</b> begins with a backslash followed either by letters (<code>\today</code>, <code>\section</code>) or by a single non-letter (<code>\%</code>, <code>\\</code>); a command made of letters ends at the first non-letter, and spaces after it are ignored. Commands may take <b>mandatory arguments</b> in braces, <code>\textbf{text}</code>, and <b>optional arguments</b> in square brackets, <code>\documentclass[12pt]{article}</code>. Many have a <b>starred</b> variant: <code>\section*</code>.</p>
<p>An <b>environment</b> applies to a block of text between <code>\begin{name}</code> and <code>\end{name}</code> — <code>center</code>, <code>itemize</code>, <code>tabular</code>. Environments may be nested, but must be closed in reverse order.</p>
<p>A <b>group</b> is text within braces <code>{ }</code> (an environment is also a group). A <b>declaration</b> is a command with no argument that changes a setting until the end of the current group: <code>{\bfseries bold}</code> or <code>{\large larger}</code>. Commands with arguments such as <code>\textbf{…}</code> are the argument-form of the same changes.</p>
${ex(L`\section*{Commands}                        % starred command
\textbf{argument form} and {\bfseries declaration in a group} again normal.
\begin{center}                               % environment
  \begin{itemize} \item nested environments \end{itemize}
\end{center}`,{title:'the pieces'})}
<p><b>(b)</b> Ten characters — <code>#</code> <code>$</code> <code>%</code> <code>&amp;</code> <code>_</code> <code>{</code> <code>}</code> <code>~</code> <code>^</code> <code>\</code> — are instructions to LaTeX (comment, math, table column, subscript, grouping…). Typed plainly they are obeyed rather than printed: <code>%</code> would hide the rest of the line, <code>&amp;</code> outside a table and <code>#</code> in text are errors, and <code>$</code> would start math. They are printed by escaping them:</p>
${ex(L`50\% of R\&D costs \$5 --- item \#1`,{title:'the escaped line'})}`)}
`});

/* ═══════════════════ LAST PASS ═══════════════════ */
STATIONS.push({id:'lastpass',title:'Last pass before the exam',short:'Last pass',est:'~15 min',body:H`
${gist('One mixed quiz across every unit — mixing topics is itself the practice — then the must-know list.')}
${omr('Mixed: Modules I and II',[
 {q:'LaTeX was built on top of',o:['PostScript','TeX','HTML','troff'],a:1},
 {q:'Which prints a percent sign?',o:['%','\\%','%%','\\percent'],a:1},
 {q:L`<code>--</code> produces`,o:['a hyphen','an en dash','an em dash','a minus sign'],a:1},
 {q:'Which class has no \\chapter?',o:['book','report','article','—'],a:2},
 {q:L`<code>\section*{X}</code> is`,o:['numbered','unnumbered and not in the contents','bold','a chapter'],a:1},
 {q:'The contents list appears after',o:['one run','two runs','BibTeX','MakeIndex'],a:1},
 {q:'BibTeX writes the formatted list to',o:['.aux','.bib','.bbl','.idx'],a:2},
 {q:'Which style labels entries like [Knu84]?',o:['plain','unsrt','alpha','abbrv'],a:2},
 {q:'An index needs which package?',o:['index','makeidx','idx','glossaries'],a:1},
 {q:L`<code>\index{a!b}</code> makes b`,o:['bold','a sub-entry of a','a cross-reference','sorted first'],a:1},
 {q:'Poetry is set in',o:['quote','quotation','verse','poem'],a:2},
 {q:'The second-level enumerate label is',o:['2.','(b)','ii.','B.'],a:1},
 {q:L`In tabbing, <code>\kill</code>`,o:['deletes a column','ends a line without printing it','kills the table','starts a new stop'],a:1},
 {q:'Which column type wraps text?',o:['l','c','r','p{…}'],a:3},
 {q:L`<code>\label</code> in a table float goes`,o:['before \\caption','after \\caption','in the preamble','inside tabular'],a:1}
])}
${cards('Every syntax you must be able to write',[
 {f:'Smallest document',b:{code:'\\documentclass{article}\n\\begin{document}\nText\n\\end{document}'}},
 {f:'Print # $ % & _',b:{code:'\\# \\$ \\% \\& \\_'}},
 {f:'Title block',b:{code:'\\title{…}\\author{…}\\date{\\today}\n\\maketitle'}},
 {f:'Unnumbered section',b:{code:'\\section*{…}'}},
 {f:'Cite and list, by hand',b:{code:'\\cite{k}\n\\begin{thebibliography}{9}\n\\bibitem{k} …\n\\end{thebibliography}'}},
 {f:'Cite from a .bib',b:{code:'\\bibliographystyle{plain}\n\\bibliography{refs}'}},
 {f:'Index set-up',b:{code:'\\usepackage{makeidx}\n\\makeindex\n… \\index{term} …\n\\printindex'}},
 {f:'Roman-numbered list',b:{code:'\\renewcommand{\\theenumi}{\\roman{enumi}}'}},
 {f:'Tab stops',b:{code:'\\begin{tabbing}\nA \\= B \\kill\nx \\> y\n\\end{tabbing}'}},
 {f:'A ruled 2-column table',b:{code:'\\begin{tabular}{|l|r|}\\hline\na & 1\\\\ \\hline\n\\end{tabular}'}},
 {f:'Heading across 3 columns',b:{code:'\\multicolumn{3}{|c|}{…}'}},
 {f:'Numbered table with caption',b:{code:'\\begin{table}[h]\\centering\n\\caption{…}\\label{t}\n…\n\\end{table}'}}
])}
${must(H`<ol>
<li>Structure: <code>\documentclass</code> → preamble → <code>\begin{document}</code> … <code>\end{document}</code>.</li>
<li>The ten special characters and how to print them.</li>
<li>Quotes <code>｀｀ ''</code>, dashes <code>- -- ---</code>, <code>\ldots</code>, accents.</li>
<li>Classes and options; <code>\pagestyle</code>, <code>\pagenumbering</code>.</li>
<li>Title block and abstract; sectioning levels, starred forms, <code>\appendix</code>.</li>
<li><code>thebibliography</code> vs BibTeX; entry types and required fields; the four styles; the four-step run.</li>
<li><code>\tableofcontents</code> (two runs), <code>\addcontentsline</code>; index: makeidx, <code>\makeindex</code>, <code>\index</code> forms, MakeIndex run.</li>
<li>quote / quotation / verse; center, flushleft, flushright.</li>
<li>itemize / enumerate / description; nesting; changing labels.</li>
<li>verbatim and <code>\verb</code>; tabbing commands; tabular spec, rules, <code>\multicolumn</code>, <code>\cline</code>, <code>p{}</code>, table float.</li>
</ol>`)}
`});
