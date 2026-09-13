/* ═══════════════════ MODULE II — Styling pages (Text 1, Tutorials VI–VII) ═══════════════════ */

/* ───────────── Unit 5 · Displayed text (Tutorial VI) ───────────── */
STATIONS.push({id:'m2-display',title:'Displayed text',short:'5 · Displayed text',est:'~45 min',body:H`
${gist('Anything set apart from the running text — a quotation, a poem, a list, a block of code — is “displayed”, and each kind has its own environment.')}

${tp('Borrowed words: quote, quotation and verse')}
<p>Three environments set other people’s words apart, indented from both margins.</p>
<div class="scroll-x"><table class="ref"><tr><th>Environment</th><th>Use for</th><th>Layout</th></tr>
<tr><td><code>quote</code></td><td>short quotations, one paragraph or a few lines</td><td>no paragraph indentation; space between paragraphs</td></tr>
<tr><td><code>quotation</code></td><td>longer quotations of several paragraphs</td><td>each paragraph’s first line is indented</td></tr>
<tr><td><code>verse</code></td><td>poetry</td><td>lines end with <code>\\</code>; stanzas are separated by a blank line; long lines hang</td></tr></table></div>
${ex(L`As Knuth put it:
\begin{quote}
Premature optimization is the root of all evil.
\end{quote}
The talk continued for an hour.`,{title:'quote'})}
${ex(L`\begin{quotation}
The first paragraph of a long passage is indented,
just like running text.

So is the second, which is how quotation differs
from quote.
\end{quotation}`,{title:'quotation'})}
${ex(L`\begin{verse}
The woods are lovely, dark and deep,\\
But I have promises to keep,\\
And miles to go before I sleep.

And miles to go before I sleep.
\end{verse}`,{title:'verse: \\\\ ends a line, a blank line ends a stanza'})}
${match('Environment ↔ best for',[[L`<code>quote</code>`,'a short quotation'],[L`<code>quotation</code>`,'a long, multi-paragraph quotation'],[L`<code>verse</code>`,'poetry']],{left:'Environment',right:'Best for'})}
${predict('Line breaks in verse',L`\begin{verse}
Twinkle, twinkle, little star,
How I wonder what you are!
\end{verse}`,[L`\begin{verse}Twinkle, twinkle, little star,\\ How I wonder what you are!\end{verse}`,L`\begin{verse}Twinkle, twinkle, little star, How I wonder what you are!\end{verse}`,L`\begin{center}Twinkle, twinkle, little star,\\ How I wonder what you are!\end{center}`],1,'Without \\\\ at the end of the first line, the two lines run together — a line break in the source is just a space.')}

${tp('Centring and alignment')}
<p>Three environments align whole blocks; three declarations do the same job inside another environment (such as a table float).</p>
${reftable([
 [L`\begin{center} … \end{center}`,'centre each line (adds space above and below)',L`\begin{center}
A centred title\\ on two lines
\end{center}`],
 [L`\begin{flushleft} … \end{flushleft}`,'align left, ragged right edge',L`\begin{flushleft}
Aligned to the left margin, with an uneven right edge.
\end{flushleft}`],
 [L`\begin{flushright} … \end{flushright}`,'align right',L`\begin{flushright}
Kochi, 12 March 2026
\end{flushright}`],
 [L`\centering`,'declaration form of center (no extra space)',L`{\centering Centred by a declaration.\par}`],
 [L`\raggedright`,'declaration form of flushleft',L`{\raggedright Left-aligned by a declaration, ragged on the right side of the text block.\par}`],
 [L`\raggedleft`,'declaration form of flushright',L`{\raggedleft Right-aligned by a declaration.\par}`]
],{h1:'Command',h2:'Effect'})}
${trap(H`<p>The declarations act on whole paragraphs, so the paragraph must end (<code>\par</code> or a blank line) <i>inside</i> the group — <code>{\centering text}</code> without the <code>\par</code> is not centred.</p>`)}
${fill('Align three blocks',L`\begin{[[center]]}
Annual Report
\end{center}
\begin{[[flushright]]}
Date: 1 April 2026
\end{flushright}`,{code:true,strict:true})}

${tp('Bulleted lists: itemize')}
<p>Each <code>\item</code> starts a new entry. Lists nest up to four levels deep, and each level has its own bullet.</p>
${ex(L`\begin{itemize}
  \item Fruits
  \begin{itemize}
    \item Mango
    \item Jackfruit
    \begin{itemize}
      \item Varikka
      \begin{itemize}
        \item fourth level
      \end{itemize}
    \end{itemize}
  \end{itemize}
  \item[$\star$] A custom label for one item
\end{itemize}`,{title:'itemize, four levels deep'})}
${must(H`<p>Default bullets by level: <b>•</b> (bullet), <b>–</b> (en dash), <b>∗</b> (asterisk), <b>·</b> (centred dot). <code>\item[text]</code> replaces the label of one item.</p>`)}

${tp('Numbered lists: enumerate')}
<p><code>enumerate</code> numbers its items automatically. Each level uses its own counter — <code>enumi</code>, <code>enumii</code>, <code>enumiii</code>, <code>enumiv</code> — and its own style.</p>
${ex(L`\begin{enumerate}
  \item Prepare the document
  \begin{enumerate}
    \item Choose a class
    \begin{enumerate}
      \item article or report
      \begin{enumerate}
        \item fourth level
      \end{enumerate}
    \end{enumerate}
  \end{enumerate}
  \item Compile it
\end{enumerate}`,{title:'enumerate: 1. (a) i. A.'})}
${match('Level ↔ default label',[['level 1','1.  2.  3.'],['level 2','(a)  (b)  (c)'],['level 3','i.  ii.  iii.'],['level 4','A.  B.  C.']],{left:'enumerate level',right:'Labels'})}
${ex(L`\begin{enumerate}
  \item Wash the rice.
  \item Soak it for thirty minutes. \label{step:soak}
  \item Cook it.
\end{enumerate}
Do not skip step~\ref{step:soak}.`,{title:'refer to an item with \\label and \\ref'})}

${tp('Description lists')}
<p>A <code>description</code> list is for terms and their meanings: the text in the optional argument of <code>\item[…]</code> is set in bold as the label.</p>
${ex(L`\begin{description}
  \item[article] for short documents and papers.
  \item[report] for longer documents with chapters.
  \item[book] for books, two-sided by default.
\end{description}`,{title:'description'})}
${omr('Lists',[
 {q:'Which environment gives numbered items?',o:['itemize','enumerate','description','numbered'],a:1},
 {q:L`In a <code>description</code> list, the term is written`,o:[L`as <code>\item{term}</code>`,L`as <code>\item[term]</code>`,L`as <code>\term{…}</code>`,L`as <code>\begin{term}</code>`],a:1},
 {q:'How many levels can standard lists nest?',o:['2','3','4','unlimited'],a:2,why:'Four levels; a fifth gives “Too deeply nested”.'},
 {q:'The default second-level label in enumerate is',o:['2.','(b)','ii.','B.'],a:1},
 {q:'The default first-level bullet in itemize is',o:['–','•','∗','·'],a:1}
])}
${parsons('A shopping list',[L`\begin{itemize}`,L`  \item Rice`,L`  \item Coconut oil`,L`\end{itemize}`],{extra:[L`\begin{list}`,L`  \item{Salt}`]})}
${fix('Lonely item',L`\documentclass{article}
\begin{document}
Things to bring:
\item a pen
\item the hall ticket
\end{document}`,{brief:'LaTeX refuses: “Lonely \\item--perhaps a missing list environment.” Make it a proper bulleted list.',
 checks:[{re:'\\\\begin\\{itemize\\}[\\s\\S]*\\\\item[\\s\\S]*\\\\end\\{itemize\\}',msg:'the items are inside itemize'}]})}

${tp('Changing the labels')}
<p>Labels are produced by commands you can redefine with <code>\renewcommand</code>. For <code>itemize</code> they are <code>\labelitemi</code> to <code>\labelitemiv</code>; for <code>enumerate</code>, the counter’s appearance is <code>\theenumi</code> and the label built from it is <code>\labelenumi</code>.</p>
${ex(L`\renewcommand{\labelitemi}{$\star$}
\begin{itemize}
  \item a star instead of a bullet
  \item for every first-level item
\end{itemize}`,{title:'new itemize bullet'})}
${ex(L`\renewcommand{\theenumi}{\Roman{enumi}}
\renewcommand{\labelenumi}{(\theenumi)}
\begin{enumerate}
  \item Introduction
  \item Method
  \item Results
\end{enumerate}`,{title:'enumerate as (I) (II) (III)'})}
${reftable([
 [L`\arabic{enumi}`,'1, 2, 3',L`\renewcommand{\theenumi}{\arabic{enumi}}
\begin{enumerate}\item a\item b\end{enumerate}`],
 [L`\roman{enumi}`,'i, ii, iii',L`\renewcommand{\theenumi}{\roman{enumi}}
\begin{enumerate}\item a\item b\end{enumerate}`],
 [L`\Roman{enumi}`,'I, II, III',L`\renewcommand{\theenumi}{\Roman{enumi}}
\begin{enumerate}\item a\item b\end{enumerate}`],
 [L`\alph{enumi}`,'a, b, c',L`\renewcommand{\theenumi}{\alph{enumi}}
\begin{enumerate}\item a\item b\end{enumerate}`],
 [L`\Alph{enumi}`,'A, B, C',L`\renewcommand{\theenumi}{\Alph{enumi}}
\begin{enumerate}\item a\item b\end{enumerate}`]
],{h1:'Counter style',h2:'Gives'})}
${fill('Make items numbered (a), (b), (c)',L`\renewcommand{\theenumi}{\[[alph]]{enumi}}
\renewcommand{\[[labelenumi]]}{([[\theenumi]])}
\begin{enumerate}
  \item first
  \item second
\end{enumerate}`,{code:true,strict:true})}
${match('Label command ↔ controls',[[L`<code>\labelitemi</code>`,'first-level itemize bullet'],[L`<code>\labelitemii</code>`,'second-level itemize bullet'],[L`<code>\theenumi</code>`,'how the first-level counter prints'],[L`<code>\labelenumi</code>`,'the whole first-level enumerate label']],{left:'Command',right:'Controls'})}
${build('Exam instructions',L`\documentclass{article}
\begin{document}
Instructions

\end{document}`,{brief:'Make a numbered list of three instructions whose labels print as <b>Q1.</b>, <b>Q2.</b>, <b>Q3.</b> — redefine \\labelenumi.',
 checks:[{re:'\\\\renewcommand\\{\\\\labelenumi\\}\\{Q\\\\theenumi\\.?\\}',msg:'\\labelenumi redefined to Q\\theenumi.'},{re:'\\\\begin\\{enumerate\\}([\\s\\S]*?\\\\item){3}',msg:'three items'}]})}

${tp('Displaying code: verbatim')}
<p>Inside <code>verbatim</code>, nothing is a command: backslashes, braces and percent signs are printed exactly as typed, in a typewriter font, line breaks and spaces included. For a short piece inside a sentence, use <code>\verb</code> with any delimiter character that does not appear in the text.</p>
${ex(L`\begin{verbatim}
\section{Introduction}   % printed, not obeyed
Spaces     are    kept.
\end{verbatim}
In text: \verb|\textbf{bold}| or \verb+50% off+.`,{title:'verbatim and \\verb'})}
${ex(L`\begin{verbatim*}
two  spaces  here
\end{verbatim*}
and \verb*|a b|`,{title:'the starred forms show spaces as ␣'})}
${trap(H`<p><code>\verb</code> cannot be used inside the argument of another command — <code>\textbf{\verb|x|}</code> or <code>\section{\verb|x|}</code> fails with “\verb illegal in command argument”. And the delimiter must not occur inside: <code>\verb|a|b|</code> ends at the second <code>|</code>.</p>`)}
${predict('verbatim vs text',L`\begin{verbatim}
\textbf{hello}
\end{verbatim}`,[L`\textbf{hello}`,L`\begin{verbatim}
\textbf{hello}
\end{verbatim}`,L`\texttt{hello}`],1,'Inside verbatim the command is printed, not obeyed.')}
`});

/* ───────────── Unit 6 · Rows and columns: tabbing (Tutorial VII.1) ───────────── */
STATIONS.push({id:'m2-tabbing',title:'Rows and columns — keeping tabs',short:'6 · Tabbing',est:'~20 min',body:H`
${gist('tabbing works like the tab key on a typewriter: set stops with \\=, jump to them with \\>, end each line with \\\\.')}

${tp('Tab stops with tabbing')}
<p>The <code>tabbing</code> environment lines text up in columns without drawing a table. The first line usually just <i>sets</i> the tab stops and is thrown away with <code>\kill</code>.</p>
${ex(L`\begin{tabbing}
Name\hspace{3cm} \= Age\hspace{1cm} \= City \kill
Anu            \> 19             \> Kochi\\
Balu           \> 21             \> Thrissur\\
Chitra         \> 20             \> Kozhikode
\end{tabbing}`,{title:'set stops on a \\kill line, then use them'})}
${reftable([
 [L`\=`,'set a tab stop here',L`\begin{tabbing}
Short \= Longer column \= End\\
a \> b \> c
\end{tabbing}`],
 [L`\>`,'jump to the next tab stop',L`\begin{tabbing}
X\hspace{2cm}\=Y\kill
left \> right
\end{tabbing}`],
 [L`\\`,'end the line',L`\begin{tabbing}
A \= B\\
one \> two\\
three \> four
\end{tabbing}`],
 [L`\kill`,'end a line that only sets stops — it is not printed',L`\begin{tabbing}
Widest item here \= next\kill
short \> text
\end{tabbing}`],
 [L`\+`,'indent all following lines by one stop',L`\begin{tabbing}
if \= condition\\
\> then\+\\
action one\\
action two\-\\
end
\end{tabbing}`],
 [L`\-`,'undo one \\+',L`\begin{tabbing}
a \= b\+\\
indented\-\\
back
\end{tabbing}`]
],{h1:'Command',h2:'Meaning'})}
${must(H`<p>A stop is set at the position where <code>\=</code> is typed, so a <b>template line</b> — the widest entries plus <code>\kill</code> — is the reliable way to set the columns. <code>\\</code> ends every line except the last.</p>`)}
${fill('Complete the tabbing',L`\begin{tabbing}
Subject\hspace{2cm} [[\=]] Marks [[\kill]]
Physics [[\>]] 88\\
Maths   \> 91
\end{tabbing}`,{code:true,strict:true})}
${predict('What does \\kill do?',L`\begin{tabbing}
Item \= Price \kill
Pen \> 10
\end{tabbing}`,[L`\begin{tabbing}Item \= Price\\ Pen \> 10\end{tabbing}`,L`\begin{tabbing}Item \= Price \kill Pen \> 10\end{tabbing}`,L`Item Price Pen 10`],1,'The \\kill line sets the stops and is not printed — only “Pen … 10” appears.')}

${tp('tabbing or tabular?')}
<div class="scroll-x"><table class="ref"><tr><th></th><th><code>tabbing</code></th><th><code>tabular</code> (next unit)</th></tr>
<tr><td>Column widths</td><td>fixed by where you set the stops</td><td>computed from the widest entry</td></tr>
<tr><td>Rules and boxes</td><td>none</td><td><code>|</code>, <code>\hline</code>, <code>\cline</code></td></tr>
<tr><td>Across a page break</td><td>can break across pages</td><td>cannot — it is one unbreakable box</td></tr>
<tr><td>Alignment inside a column</td><td>left only</td><td>l, c, r, p{…}</td></tr>
<tr><td>Can sit inside a sentence</td><td>no — always its own paragraph</td><td>yes</td></tr></table></div>
${omr('tabbing',[
 {q:'Which command sets a tab stop?',o:[L`<code>\></code>`,L`<code>\=</code>`,L`<code>\\</code>`,L`<code>\kill</code>`],a:1},
 {q:L`A line ending in <code>\kill</code> is`,o:['printed in bold','used to set stops, then discarded','the last line','an error'],a:1},
 {q:L`<code>\+</code> in tabbing means`,o:['add a column','indent following lines by one stop','bold the line','end the line'],a:1},
 {q:'An advantage of tabbing over tabular is that it',o:['draws rules','centres columns','can break across pages','computes widths automatically'],a:2}
])}
${build('A small timetable with tabbing',L`\documentclass{article}
\begin{document}

\end{document}`,{brief:'Using tabbing, set a template line with \\kill, then list three periods: Time, Subject and Room for each.',
 checks:[{re:'\\\\begin\\{tabbing\\}',msg:'a tabbing environment'},{re:'\\\\=[\\s\\S]*\\\\kill',msg:'a template line with \\= and \\kill'},{re:'(\\\\>[\\s\\S]*){6}',msg:'at least six \\> jumps (three rows)'}]})}
`});

/* ───────────── Unit 7 · Tables (Tutorial VII.2) ───────────── */
STATIONS.push({id:'m2-tables',title:'Tables',short:'7 · Tables',est:'~55 min',body:H`
${gist('A tabular has a column spec (l c r p{…} and | for rules), cells separated by &, rows ended by \\\\, and \\hline for horizontal rules. Wrap it in table to give it a caption and a number.')}

${tp('Columns and rows')}
<p><code>\begin{tabular}{spec}</code> takes one letter per column: <code>l</code> left, <code>c</code> centred, <code>r</code> right. In the body, <code>&amp;</code> separates cells and <code>\\</code> ends each row.</p>
${ex(L`\begin{tabular}{lcr}
Name   & Class & Marks \\
Anu    & II    & 88    \\
Balu   & III   & 9     \\
\end{tabular}`,{title:'l c r'})}
${must(H`<p>Every row must have <b>exactly</b> as many cells as the spec has columns (or fewer). One <code>&amp;</code> too many gives “Extra alignment tab has been changed to \cr”.</p>`)}
${parsons('A two-column table',[L`\begin{tabular}{ll}`,L`Language & Year \\`,L`\TeX & 1978 \\`,L`\LaTeX & 1985 \\`,L`\end{tabular}`],{extra:[L`\begin{table}{ll}`]})}
${fix('Too many cells',L`\documentclass{article}
\begin{document}
\begin{tabular}{ll}
Item & Qty \\
Pens & 10 & boxes \\
\end{tabular}
\end{document}`,{brief:'The second row has three cells but the spec declares two columns. Fix it either way.',checks:[]})}

${tp('Rules: |, \\hline and \\cline')}
${reftable([
 [L`|`,'in the spec: a vertical rule between columns (|| for a double rule)',L`\begin{tabular}{|l|r|}
a & 1\\
b & 2\\
\end{tabular}`],
 [L`\hline`,'a horizontal rule across the whole table (after \\\\ or at the start)',L`\begin{tabular}{lr}
\hline
a & 1\\ \hline
b & 2\\ \hline
\end{tabular}`],
 [L`\hline\hline`,'a double horizontal rule',L`\begin{tabular}{lr}
Head & 1\\ \hline\hline
b & 2
\end{tabular}`],
 [L`\cline{2-3}`,'a rule under columns 2 to 3 only',L`\begin{tabular}{|c|c|c|}
\hline
a & b & c\\ \cline{2-3}
d & e & f\\ \hline
\end{tabular}`],
 [L`||`,'a double vertical rule',L`\begin{tabular}{l||r}
a & 1\\ b & 2
\end{tabular}`]
],{h1:'Syntax',h2:'Draws'})}
${ex(L`\begin{tabular}{|l|c|r|}
\hline
Subject & Credits & Marks \\ \hline\hline
Physics & 4       & 88    \\ \hline
Maths   & 4       & 91    \\ \hline
LaTeX   & 3       & 95    \\ \hline
\end{tabular}`,{title:'a fully ruled table'})}
${predict('Where does the rule go?',L`\begin{tabular}{|c|c|c|}
\hline
1 & 2 & 3 \\ \cline{1-2}
4 & 5 & 6 \\ \hline
\end{tabular}`,[L`\begin{tabular}{|c|c|c|}\hline 1 & 2 & 3 \\ \hline 4 & 5 & 6 \\ \hline\end{tabular}`,L`\begin{tabular}{|c|c|c|}\hline 1 & 2 & 3 \\ \cline{1-2} 4 & 5 & 6 \\ \hline\end{tabular}`,L`\begin{tabular}{|c|c|c|}\hline 1 & 2 & 3 \\ \cline{2-3} 4 & 5 & 6 \\ \hline\end{tabular}`],1,'\\cline{1-2} draws the middle rule under columns 1 and 2 only.')}
${fill('Rule the table',L`\begin{tabular}{[[|l|r|]]}
[[\hline]]
Fruit & Price \\ \hline
Mango & 40 \\ [[\hline]]
\end{tabular}`,{code:true,strict:true})}

${tp('Paragraph columns: p{width}')}
<p><code>l</code>, <code>c</code> and <code>r</code> columns never wrap — a long entry just makes the column wider, even off the page. A <code>p{width}</code> column has a fixed width, and its text wraps inside it like a paragraph (top-aligned).</p>
${ex(L`\begin{tabular}{|l|p{5cm}|}
\hline
Term   & Meaning \\ \hline
Preamble & Everything between \verb|\documentclass| and
           \verb|\begin{document}|: settings and packages. \\ \hline
Body   & The printed content of the document. \\ \hline
\end{tabular}`,{title:'p{5cm} wraps long text'})}
${trap(H`<p>A <code>p</code> column needs a width with a unit: <code>p{4cm}</code>, <code>p{0.3\textwidth}</code>. <code>p{4}</code> is an error.</p>`)}

${tp('Spanning columns: \\multicolumn')}
<p><code>\multicolumn{n}{spec}{text}</code> makes one cell span <i>n</i> columns, with its own alignment (and rules) given by <i>spec</i>. It replaces those <i>n</i> cells in the row.</p>
${ex(L`\begin{tabular}{|l|c|c|}
\hline
\multicolumn{3}{|c|}{\textbf{Semester V results}} \\ \hline
Name & Physics & Maths \\ \hline
Anu  & 88      & 91    \\ \hline
\multicolumn{2}{|r|}{Class average} & 89.5 \\ \hline
\end{tabular}`,{title:'a title row and a label row'})}
${must(H`<p>The spec of a <code>\multicolumn</code> must restate its own rules: in a <code>{|l|c|c|}</code> table a full-width span is <code>\multicolumn{3}{|c|}{…}</code>, not <code>{c}</code>. It is also the standard way to change the alignment of <i>one</i> cell: <code>\multicolumn{1}{c}{…}</code>.</p>`)}
${fill('Span the heading',L`\begin{tabular}{|c|c|c|}
\hline
\[[multicolumn]]{[[3]]}{|c|}{Marks} \\ \hline
I & II & III \\ \hline
\end{tabular}`,{code:true,strict:true})}

${tp('@-expressions and repeated columns')}
<p><code>@{text}</code> in the spec replaces the space between two columns with <i>text</i> — useful for lining up decimal points, and <code>@{}</code> removes the padding at a table’s edge. <code>*{n}{spec}</code> repeats a spec <i>n</i> times.</p>
${ex(L`\begin{tabular}{r@{.}l}
3   & 14159 \\
2   & 718   \\
100 & 5     \\
\end{tabular}`,{title:'r@{.}l lines up the decimal points'})}
${ex(L`\begin{tabular}{|*{5}{c|}}
\hline
1 & 2 & 3 & 4 & 5 \\ \hline
\end{tabular}`,{title:'*{5}{c|} = c|c|c|c|c|'})}
${match('Column spec ↔ meaning',[[L`<code>l</code> <code>c</code> <code>r</code>`,'left, centred, right — no wrapping'],[L`<code>p{3cm}</code>`,'fixed width, text wraps'],[L`<code>|</code>`,'vertical rule'],[L`<code>@{.}</code>`,'a “.” instead of the gap between columns'],[L`<code>*{3}{c}</code>`,'the same as ccc']],{left:'Spec',right:'Means'})}

${tp('Spacing inside a table')}
<p>Two lengths control the look: <code>\arraystretch</code> scales the row height (a command, so it is changed with <code>\renewcommand</code>), and <code>\tabcolsep</code> is half the space between columns (a length, changed with <code>\setlength</code>).</p>
${ex(L`\renewcommand{\arraystretch}{1.6}   % rows 60% taller
\setlength{\tabcolsep}{14pt}         % wider gaps between columns
\begin{tabular}{|c|c|}
\hline
airy & rows \\ \hline
more & space \\ \hline
\end{tabular}`,{title:'\\arraystretch and \\tabcolsep'})}
${trap(H`<p><code>\setlength{\arraystretch}{1.5}</code> is wrong — <code>\arraystretch</code> is a command, not a length. Use <code>\renewcommand{\arraystretch}{1.5}</code>.</p>`)}

${tp('The table float: caption, label, placement')}
<p><code>tabular</code> is only the grid. To give it a number and a caption, and let LaTeX place it sensibly on the page, wrap it in the <code>table</code> <b>float</b>.</p>
${ex(L`Table~\ref{tab:marks} lists the marks.

\begin{table}[htbp]
  \centering
  \caption{Marks in Semester V}
  \label{tab:marks}
  \begin{tabular}{|l|c|}
    \hline
    Name & Marks \\ \hline
    Anu  & 88    \\
    Balu & 91    \\ \hline
  \end{tabular}
\end{table}`,{title:'table + \\caption + \\label + \\ref'})}
<div class="scroll-x"><table class="ref"><tr><th>Placement letter</th><th>Means</th></tr>
<tr><td><code>h</code></td><td><i>here</i> — about where it is written</td></tr>
<tr><td><code>t</code></td><td>at the <i>top</i> of a page</td></tr>
<tr><td><code>b</code></td><td>at the <i>bottom</i> of a page</td></tr>
<tr><td><code>p</code></td><td>on a separate <i>page</i> of floats</td></tr>
<tr><td><code>!</code></td><td>try harder — relax LaTeX’s usual limits</td></tr></table></div>
${must(H`<p>Put <code>\label</code> <b>after</b> <code>\caption</code> — the label records the most recent number, and the caption is what creates it. <code>\caption</code> before the tabular puts the caption above (the usual convention for tables).</p>`)}
${match('tabular or table?',[['draws the grid of rows and columns',L`<code>tabular</code>`],['gives a number and a caption',L`<code>table</code>`],['can float to the top of the page',L`<code>table</code>`],['takes a column spec such as {lcr}',L`<code>tabular</code>`]],{left:'Job',right:'Environment'})}
${omr('Tables',[
 {q:'Which column type wraps long text?',o:['l','c','r','p{…}'],a:3},
 {q:L`<code>\cline{2-4}</code> draws a rule`,o:['under every column','under columns 2 to 4','down columns 2 to 4','nowhere'],a:1},
 {q:L`To give a table a numbered caption you need`,o:[L`<code>\caption</code> inside tabular`,L`the <code>table</code> environment with <code>\caption</code>`,L`<code>\hline</code>`,L`<code>\multicolumn</code>`],a:1},
 {q:L`<code>\label</code> must come`,o:[L`before <code>\caption</code>`,L`after <code>\caption</code>`,'anywhere in the document','in the preamble'],a:1},
 {q:L`The placement option <code>[t]</code> asks for`,o:['here','top of a page','bottom of a page','a page of floats'],a:1},
 {q:L`In <code>{|l|c|c|}</code>, a heading across all columns is`,o:[L`<code>\multicolumn{3}{c}{…}</code>`,L`<code>\multicolumn{3}{|c|}{…}</code>`,L`<code>\multicolumn{2}{|c|}{…}</code>`,L`<code>\span{3}{…}</code>`],a:1},
 {q:'Row height is scaled with',o:[L`<code>\setlength{\arraystretch}{2}</code>`,L`<code>\renewcommand{\arraystretch}{2}</code>`,L`<code>\rowheight{2}</code>`,L`<code>\tabcolsep</code>`],a:1}
])}
${cards('Table commands',[
 {f:'Column separator',b:{code:'&'}},{f:'End a row',b:{code:'\\\\'}},{f:'Full-width horizontal rule',b:{code:'\\hline'}},
 {f:'Rule under columns 2–3 only',b:{code:'\\cline{2-3}'}},{f:'One cell across 3 columns, centred, ruled',b:{code:'\\multicolumn{3}{|c|}{text}'}},
 {f:'A wrapping 4 cm column',b:{code:'p{4cm}'}},{f:'Line up decimal points',b:{code:'r@{.}l'}},{f:'Taller rows',b:{code:'\\renewcommand{\\arraystretch}{1.5}'}},
 {f:'Caption + number for a table',b:{code:'\\begin{table}\n\\caption{…}\\label{…}\n…\n\\end{table}'}}
])}
${build('Build a mark sheet',L`\documentclass{article}
\begin{document}

\end{document}`,{brief:'Make a ruled table in a table float with the caption “Mark sheet”: a title row spanning all columns, a header row (Name, Paper I, Paper II, Total) and two students.',
 checks:[{re:'\\\\begin\\{table\\}',msg:'a table float'},{re:'\\\\caption\\{Mark sheet\\}',msg:'caption “Mark sheet”'},{re:'\\\\begin\\{tabular\\}\\{[^}]*\\|[^}]*\\}',msg:'vertical rules in the spec'},
 {re:'\\\\hline',msg:'horizontal rules'},{re:'\\\\multicolumn\\{4\\}',msg:'a \\multicolumn{4} title row'},{re:'Name\\s*&\\s*Paper I\\s*&\\s*Paper II\\s*&\\s*Total',msg:'the header row'}]})}
`});
