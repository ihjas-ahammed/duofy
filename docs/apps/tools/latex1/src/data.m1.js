/* ═══════════════════ MODULE I — Getting started with LaTeX (Text 1, Tutorials I–V) ═══════════════════ */

/* ───────────── Unit 1 · The basics (Tutorial I) ───────────── */
STATIONS.push({id:'m1-basics',title:'The basics',short:'1 · The basics',est:'~40 min',body:H`
${gist('You write plain text with markup; LaTeX decides how it looks. Learn what the markup characters mean and nothing will surprise you.')}

${tp('What TeX and LaTeX are, and where they came from')}
<p><b>TeX</b> is a typesetting program written by <b>Donald E. Knuth</b> of Stanford. In 1977 he was so unhappy with how the second edition of his book <i>The Art of Computer Programming</i> had been typeset that he set out to write his own system; the first version appeared in 1978 and the final design, TeX82, in 1982. TeX is famously stable: its version number converges to π (3.14159265…), and its sister program <b>METAFONT</b>, which draws the fonts, converges to <i>e</i>.</p>
<p>TeX itself is powerful but low-level. <b>LaTeX</b>, written by <b>Leslie Lamport</b> in the early 1980s (LaTeX 2.09, 1985), is a set of <i>macros</i> on top of TeX that lets you describe the <i>structure</i> of a document — this is a section, this is a list, this is a table — and leaves the formatting to a style. The version everyone uses today is <b>LaTeX2ε</b> (1994), maintained by the LaTeX Project team.</p>
<p>The “X” is the Greek letter chi, so TeX is pronounced “tech”, and LaTeX “lah-tech” or “lay-tech”.</p>
<h5>Word processor vs. typesetter</h5>
<p>A word processor is <b>WYSIWYG</b> — “what you see is what you get”: you format as you type. LaTeX is a <b>markup</b> system, sometimes described as <b>WYSIWYM</b> — “what you see is what you <i>mean</i>”: you type the text plus commands that say what each part <i>is</i>, then <b>compile</b> it to get the formatted output.</p>
<div class="scroll-x"><table class="ref"><tr><th>Step</th><th>What happens</th></tr>
<tr><td>1. Edit</td><td>You write a plain-text <code>.tex</code> file in any editor.</td></tr>
<tr><td>2. Compile</td><td>A TeX engine (usually <code>pdflatex</code>) reads it and writes a <code>.pdf</code>, a <code>.log</code> (the messages) and <code>.aux</code> (notes for the next run).</td></tr>
<tr><td>3. View</td><td>Open the PDF. Fix, recompile, repeat.</td></tr></table></div>
<p>LaTeX comes in <b>distributions</b> that bundle the engines, fonts and thousands of packages: <b>TeX Live</b> (Linux, Windows, macOS — and the engine behind this app’s Real PDF tab), <b>MiKTeX</b> (Windows) and <b>MacTeX</b> (macOS). <b>Overleaf</b> runs LaTeX in the browser with nothing to install.</p>
${omr('History and basics',[
 {q:'Who created TeX?',o:['Leslie Lamport','Donald E. Knuth','Tobias Oetiker','Frank Mittelbach'],a:1,why:'Knuth began TeX in 1977; Lamport later built LaTeX on top of it.'},
 {q:'LaTeX is best described as…',o:['a word processor','a font','a set of macros built on TeX','a PDF viewer'],a:2,why:'LaTeX is a macro package: it gives TeX high-level, structural commands.'},
 {q:'The current version of LaTeX used everywhere is',o:['LaTeX 2.09','LaTeX2ε','TeX82','LaTeX 1.0'],a:1,why:'LaTeX2ε was released in 1994 and is still the standard.'},
 {q:'The “X” in TeX is',o:['the letter ex','the Greek letter chi','a multiplication sign','a Roman ten'],a:1,why:'So TeX sounds like “tech”.'},
 {q:'Which is a TeX distribution?',o:['Overleaf','TeX Live','PDFtk','Acrobat'],a:1,why:'TeX Live, MiKTeX and MacTeX are distributions; Overleaf is an online service that runs one.'},
 {q:'WYSIWYM stands for',o:['What you see is what you make','What you see is what you mean','What you set is what you mean','Write your source, it works, you move on'],a:1,why:'You describe what each part means; the style decides how it looks.'},
 {q:'Which file holds the messages and errors of a compile?',o:['.tex','.aux','.log','.pdf'],a:2,why:'.log is the log; .aux holds cross-reference notes for the next run.'},
 {q:'TeX’s version number converges to',o:['e','π','√2','φ'],a:1,why:'Each bug fix adds a digit of π — currently 3.141592653. METAFONT’s converges to e.'}
])}
${cards('TeX in ten cards',[
 {f:'Who wrote TeX, and when?',b:'Donald E. Knuth — begun 1977, first released 1978, final design TeX82.'},
 {f:'Who wrote LaTeX?',b:'Leslie Lamport (LaTeX 2.09, 1985).'},
 {f:'Current LaTeX version',b:'LaTeX2ε (1994), maintained by the LaTeX Project team.'},
 {f:'WYSIWYG vs WYSIWYM',b:'Word processor: format as you type. LaTeX: mark up meaning, then compile.'},
 {f:'The edit–compile cycle',b:'.tex → pdflatex → .pdf (+ .log, .aux)'},
 {f:'Three TeX distributions',b:'TeX Live, MiKTeX, MacTeX'},
 {f:'METAFONT',b:'Knuth’s font-drawing program; version number converges to e.'},
 {f:'How is TeX pronounced?',b:'“tech” — the X is Greek chi.'},
 {f:'What is a macro?',b:'A command defined in terms of other commands. LaTeX is a large collection of TeX macros.'},
 {f:'Overleaf',b:'An online LaTeX editor that compiles in the browser — no installation.'}
])}

${tp('Your first document')}
<p>Every LaTeX file has the same skeleton. The part before <code>\begin{document}</code> is the <b>preamble</b>: settings that apply to the whole document. Everything you want printed goes in the <b>body</b>, between <code>\begin{document}</code> and <code>\end{document}</code>.</p>
${ex(L`\documentclass{article}      % 1. what kind of document
% --- the preamble: settings and packages go here ---
\begin{document}             % 2. the body starts
Hello, world!                % 3. your text
\end{document}               % 4. the body ends`,{title:'the smallest complete document'})}
${must(H`<p><code>\documentclass{…}</code> first, then the preamble, then <code>\begin{document}</code> … <code>\end{document}</code>. Anything after <code>\end{document}</code> is ignored.</p>`)}
${parsons('Assemble the smallest document',[L`\documentclass{article}`,L`\begin{document}`,L`My first \LaTeX{} document.`,L`\end{document}`],{extra:[L`\begin{article}`,L`\end{article}`]})}

${tp('Spaces, lines and paragraphs')}
<p>LaTeX treats your line breaks and spacing as loose suggestions. The rules:</p>
<ul>
  <li>Any number of spaces in a row counts as <b>one</b> space. A single line break also counts as a space.</li>
  <li>A <b>blank line</b> (one or more) ends a paragraph. So does <code>\par</code>.</li>
  <li><code>\\</code> or <code>\newline</code> breaks the line <i>without</i> starting a new paragraph; <code>\\[5mm]</code> adds extra space.</li>
  <li><code>~</code> is an unbreakable space: <code>Dr.~Knuth</code> never splits across lines.</li>
  <li><code>%</code> starts a <b>comment</b>: the rest of that line is ignored.</li>
</ul>
${ex(L`This     sentence   has     many     spaces,
and this line break is only a space.

A blank line started this new paragraph.\\
That was a line break, not a paragraph.
Dr.~Knuth % this comment is not printed`,{title:'spaces and paragraphs'})}
${predict('Three blank lines',L`First paragraph.



Second paragraph.`,[L`First paragraph.\\ \\ \\ Second paragraph.`,L`First paragraph.

Second paragraph.`,L`First paragraph. Second paragraph.`],1,'Several blank lines count as one: exactly one paragraph break, no extra space.')}
<p>To control space yourself:</p>
${reftable([
 [L`\\`,'line break inside a paragraph',L`first line\\ second line`],
 [L`\\[3mm]`,'line break plus 3 mm extra space',L`first line\\[3mm] a little lower`],
 [L`\newline`,'same as \\\\',L`one\newline two`],
 [L`\par`,'end the paragraph (same as a blank line)',L`one\par two`],
 [L`\noindent`,'start this paragraph without indentation',L`Indented paragraph.\par\noindent Not indented.`],
 [L`\hspace{1cm}`,'horizontal space',L`left\hspace{2cm}right`],
 [L`\vspace{1cm}`,'vertical space between paragraphs',L`above\par\vspace{1cm}below`],
 [L`\bigskip \medskip \smallskip`,'standard vertical gaps',L`a\par\bigskip b\par\smallskip c`],
 [L`\hfill`,'stretchy space that pushes things apart',L`Left side\hfill Right side`],
 [L`~`,'unbreakable space',L`Fig.~1 and Mr.~Lamport`],
 [L`%`,'comment to end of line',L`printed % not printed`]
])}

${tp('The ten special characters')}
<p>Ten characters are <b>reserved</b>: they are instructions, not text. Typing one plainly either does something unexpected or stops the compile.</p>
<div class="scroll-x"><table class="ref"><tr><th>Char</th><th>Its job in LaTeX</th><th>To print it</th></tr>
<tr><td><code>\</code></td><td>starts every command</td><td><code>\textbackslash</code></td></tr>
<tr><td><code>{ }</code></td><td>group / argument</td><td><code>\{ \}</code></td></tr>
<tr><td><code>%</code></td><td>comment</td><td><code>\%</code></td></tr>
<tr><td><code>$</code></td><td>enter/leave math</td><td><code>\$</code></td></tr>
<tr><td><code>&amp;</code></td><td>column separator in tables</td><td><code>\&amp;</code></td></tr>
<tr><td><code>#</code></td><td>argument in definitions</td><td><code>\#</code></td></tr>
<tr><td><code>_</code></td><td>subscript (math)</td><td><code>\_</code></td></tr>
<tr><td><code>^</code></td><td>superscript (math)</td><td><code>\textasciicircum</code></td></tr>
<tr><td><code>~</code></td><td>unbreakable space</td><td><code>\textasciitilde</code></td></tr>
</table></div>
${ex(L`Costs \$5 --- a 20\% discount for R\&D.
Use \# for tags, file\_name.txt, \{braces\},
a \textbackslash{} backslash, \textasciitilde{} and \textasciicircum{}.`,{title:'all ten, printed'})}
${trap(H`<p><code>\\</code> is a line break, so a backslash is <code>\textbackslash</code>, not <code>\\</code>. And <code>\^</code> or <code>\~</code> on their own are <i>accents</i> — <code>\^{}</code> gives a lone circumflex, but <code>\textasciicircum</code> is the clear way.</p>`)}
${match('Special character ↔ how to type it',[
 [L`<code>%</code>`,L`<code>\%</code>`],[L`<code>&amp;</code>`,L`<code>\&amp;</code>`],[L`<code>$</code>`,L`<code>\$</code>`],
 [L`<code>#</code>`,L`<code>\#</code>`],[L`<code>_</code>`,L`<code>\_</code>`],[L`<code>\</code>`,L`<code>\textbackslash</code>`],
 [L`<code>~</code>`,L`<code>\textasciitilde</code>`],[L`<code>{</code>`,L`<code>\{</code>`]],{left:'You want',right:'You type'})}
${fill('Escape the sentence',L`Profit rose 12[[\%]] at Johnson [[\&]] Johnson; see item [[\#]]4 in file\[[_]]v2 --- it cost [[\$]]30.`,{code:true,strict:true})}
${fix('Every special character, wrong',L`\documentclass{article}
\begin{document}
Use item #1 from dir_old: it saved 30% & more, $5 each.
\end{document}`,{brief:'Escape all five offenders so the line prints exactly as written.',
 checks:[{re:'\\\\#',msg:'\\# for the hash'},{re:'\\\\_',msg:'\\_ for the underscore'},{re:'\\\\%',msg:'\\% for percent'},{re:'\\\\&',msg:'\\& for the ampersand'},{re:'\\\\\\$',msg:'\\$ for the dollar'}]})}

${tp('Quotes, dashes, dots and accents')}
<p>Typewriters had one quote key and one dash key. Typesetting has several of each, and LaTeX makes you say which.</p>
<div class="scroll-x"><table class="ref"><tr><th>Type</th><th>Get</th><th>Use it for</th></tr>
<tr><td><code>｀｀ … ''</code></td><td>“ … ”</td><td>double quotes — two backticks to open, two apostrophes to close</td></tr>
<tr><td><code>｀ … '</code></td><td>‘ … ’</td><td>single quotes</td></tr>
<tr><td><code>-</code></td><td>-</td><td>hyphen: <i>well-known</i></td></tr>
<tr><td><code>--</code></td><td>–</td><td>en dash: ranges, <i>pages 5–9</i></td></tr>
<tr><td><code>---</code></td><td>—</td><td>em dash: a break in a sentence — like this</td></tr>
<tr><td><code>\ldots</code></td><td>…</td><td>ellipsis (three typed dots are spaced badly)</td></tr>
</table></div>
${ex(L`｀｀Proper'' quotes, not "straight" ones; ｀single' too.
A well-known result, pages 12--19 --- read them all\ldots`,{title:'quotes, dashes, dots'})}
${predict('Which dash?',L`Read pages 10--20.`,[L`Read pages 10-20.`,L`Read pages 10--20.`,L`Read pages 10---20.`],1,'Two hyphens give an en dash, the correct dash for a range.')}
<h5>Accents</h5>
${reftable([
 [L`\'e`,'acute — é',L`caf\'e`],[L`\｀a`,'grave — à',L`d\｀a vu`],[L`\^o`,'circumflex — ô',L`h\^otel`],
 [L`\"u`,'umlaut — ü',L`M\"uller`],[L`\~n`,'tilde — ñ',L`Espa\~na`],[L`\c{c}`,'cedilla — ç',L`fa\c{c}ade`],
 [L`\=o`,'macron — ō',L`\=o`],[L`\.o`,'dot — ȯ',L`\.o`],[L`\u{o}`,'breve — ŏ',L`\u{o}`],[L`\v{c}`,'caron — č',L`\v{c}`],
 [L`\H{o}`,'double acute — ő',L`Erd\H{o}s`],[L`\ss \ae \o \aa`,'special letters ß æ ø å',L`Stra\ss e, \ae, \o, \aa`]
],{h1:'Accent',h2:'Gives'})}
${match('Accent command ↔ result',[[L`<code>\'e</code>`,'é'],[L`<code>\｀e</code>`,'è'],[L`<code>\^e</code>`,'ê'],[L`<code>\"e</code>`,'ë'],[L`<code>\~n</code>`,'ñ'],[L`<code>\c{c}</code>`,'ç']])}
${cards('Punctuation you must type correctly',[
 {f:'How do you type “double quotes”?',b:{code:'``like this\'\''}},
 {f:{tex:'pages 5--9'},b:'-- two hyphens: en dash, for ranges'},
 {f:{tex:'wait---what?'},b:'--- three hyphens: em dash, for a break'},
 {f:'An ellipsis …',b:{code:'\\ldots'}},
 {f:'é',b:{code:"\\'e"}},{f:'ü',b:{code:'\\"u'}},{f:'ç',b:{code:'\\c{c}'}}
])}

${tp('Commands, arguments and environments')}
<p>A <b>command</b> starts with a backslash and is either a word (<code>\today</code>) or a single non-letter (<code>\%</code>). Commands can take:</p>
<ul>
  <li><b>mandatory arguments</b> in braces: <code>\textbf{this}</code></li>
  <li><b>optional arguments</b> in square brackets, usually first: <code>\documentclass[12pt]{article}</code></li>
  <li>a <b>star</b> that gives a variant: <code>\section*{…}</code> is an unnumbered section.</li>
</ul>
<p>An <b>environment</b> applies to a whole block: <code>\begin{name}</code> … <code>\end{name}</code>. Environments must close in the reverse order they opened, like nested brackets.</p>
${ex(L`\textbf{bold} and \textit{italic}            % commands with an argument
\section*{An unnumbered heading}                  % starred variant
\begin{center}                                    % an environment
  This line is centred.
\end{center}`,{title:'commands and environments'})}
<h5>Groups and declarations</h5>
<p>Some commands are <b>declarations</b>: they take no argument and stay in force until the end of the current <b>group</b>. Braces make a group. So <code>\textbf{x}</code> (a command) and <code>{\bfseries x}</code> (a declaration in a group) give the same result.</p>
${ex(L`Normal {\bfseries bold only inside the braces} normal again.
{\itshape italic, {\bfseries bold italic} italic} normal.`,{title:'a declaration’s scope ends with its group'})}
${trap(H`<p>A declaration without braces never stops: <code>\bfseries text</code> turns <i>everything</i> after it bold, to the end of the enclosing group or environment.</p>`)}
${fill('Name the parts',L`\[[documentclass]][[[12pt]]]{[[article]]}
\begin{document}
\section[[*]]{Unnumbered}
\[[end]]{document}`,{code:true,strict:true})}

${tp('Fonts: family, shape, series and size')}
<p>A font has four independent properties. You can change each one either with a <b>command</b> that takes the text as an argument, or a <b>declaration</b> that switches until the end of the group.</p>
${reftable([
 [L`\textrm{…}  \rmfamily`,'roman (serif) family — the default',L`\textrm{Roman text}`],
 [L`\textsf{…}  \sffamily`,'sans-serif family',L`\textsf{Sans serif text}`],
 [L`\texttt{…}  \ttfamily`,'typewriter (monospaced) family',L`\texttt{typewriter text}`],
 [L`\textbf{…}  \bfseries`,'bold series',L`\textbf{bold text}`],
 [L`\textmd{…}  \mdseries`,'medium (normal) series',L`\textbf{bold \textmd{medium} bold}`],
 [L`\textit{…}  \itshape`,'italic shape',L`\textit{italic text}`],
 [L`\textsl{…}  \slshape`,'slanted shape',L`\textsl{slanted text}`],
 [L`\textsc{…}  \scshape`,'Small Caps shape',L`\textsc{Small Caps}`],
 [L`\textup{…}  \upshape`,'upright shape',L`\textit{italic \textup{upright} italic}`],
 [L`\emph{…}  \em`,'emphasis — italic, or upright inside italic',L`\emph{Stress} this; \textit{inside \emph{italic} it flips}.`],
 [L`\underline{…}`,'underline',L`\underline{underlined}`],
 [L`\textnormal{…}`,'back to the document’s normal font',L`\textbf{\textit{bold italic \textnormal{normal}}}`]
],{h1:'Command · declaration',h2:'Effect'})}
${must(H`<p>Prefer <code>\emph</code> to <code>\textit</code> for emphasis: it means “stress this”, and it switches back to upright when the surrounding text is already italic.</p>`)}
<h5>Sizes</h5>
<p>Size declarations are relative to the base size set by the class option (10, 11 or 12 pt). From smallest to largest:</p>
${ex(L`{\tiny tiny} {\scriptsize scriptsize} {\footnotesize footnotesize} {\small small}
{\normalsize normalsize} {\large large} {\Large Large} {\LARGE LARGE}
{\huge huge} {\Huge Huge}`,{title:'the ten sizes'})}
${parsons('Put the sizes in order, smallest first',[L`\tiny`,L`\scriptsize`,L`\footnotesize`,L`\small`,L`\normalsize`,L`\large`,L`\Large`,L`\LARGE`,L`\huge`,L`\Huge`])}
${match('Font command ↔ look',[
 [L`<code>\textbf</code>`,{tex:L`\textbf{bold}`}],[L`<code>\textit</code>`,{tex:L`\textit{italic}`}],[L`<code>\textsc</code>`,{tex:L`\textsc{Small Caps}`}],
 [L`<code>\texttt</code>`,{tex:L`\texttt{typewriter}`}],[L`<code>\textsf</code>`,{tex:L`\textsf{sans serif}`}],[L`<code>\textsl</code>`,{tex:L`\textsl{slanted}`}]],{left:'Command',right:'Output'})}
${omr('Fonts',[
 {q:L`Which is a <i>declaration</i>, not a command with an argument?`,o:[L`<code>\textbf{x}</code>`,L`<code>\bfseries</code>`,L`<code>\emph{x}</code>`,L`<code>\underline{x}</code>`],a:1,why:'Declarations take no argument and last until the end of the group.'},
 {q:L`<code>\emph</code> inside italic text produces`,o:['bold','upright','underlined','larger'],a:1,why:'\\emph toggles: in italic surroundings it goes upright.'},
 {q:'Which size is larger?',o:[L`<code>\large</code>`,L`<code>\Large</code>`,L`<code>\small</code>`,L`<code>\normalsize</code>`],a:1,why:'\\large < \\Large < \\LARGE < \\huge < \\Huge.'},
 {q:'The three font families are',o:['bold, italic, slanted','roman, sans serif, typewriter','tiny, small, large','upright, italic, small caps'],a:1,why:'Family: rm/sf/tt. Series: md/bf. Shape: up/it/sl/sc.'}
])}
${build('Style a short notice',L`\documentclass{article}
\begin{document}
Notice
The library closes early today.
Ask at the desk.
\end{document}`,{brief:'Make “Notice” large and bold, put “early” in emphasis, and set “Ask at the desk.” in small caps.',
 checks:[{re:'\\\\(Large|LARGE|large|huge|Huge)',msg:'a size command for the heading'},{re:'\\\\textbf|\\\\bfseries',msg:'bold for the heading'},{re:'\\\\emph\\{early\\}',msg:'\\emph{early}'},{re:'\\\\textsc|\\\\scshape',msg:'small caps for the last line'}]})}
`});

/* ───────────── Unit 2 · The document (Tutorial II) ───────────── */
STATIONS.push({id:'m1-document',title:'The document',short:'2 · The document',est:'~40 min',body:H`
${gist('The document class sets the overall design; options adjust it; the title, abstract and sectioning commands give the document its shape.')}

${tp('Document classes')}
<p>The first line, <code>\documentclass{…}</code>, picks the <b>class</b>: a complete design for a kind of document.</p>
<div class="scroll-x"><table class="ref"><tr><th>Class</th><th>For</th><th>Notes</th></tr>
<tr><td><code>article</code></td><td>papers, short reports, assignments</td><td>no <code>\chapter</code>; title on the first page</td></tr>
<tr><td><code>report</code></td><td>longer reports, theses</td><td>has <code>\chapter</code>; title on its own page</td></tr>
<tr><td><code>book</code></td><td>books</td><td>chapters, two-sided by default, <code>\frontmatter</code> etc.</td></tr>
<tr><td><code>letter</code></td><td>letters</td><td><code>\opening</code>, <code>\closing</code>, <code>\signature</code></td></tr>
<tr><td><code>slides</code>, <code>beamer</code></td><td>presentations</td><td>beamer is covered in Module IV</td></tr></table></div>
${ex(L`\documentclass{report}
\begin{document}
\chapter{Getting Started}
\section{Why LaTeX}
Reports and books have chapters; articles do not.
\end{document}`,{title:'report: chapters are allowed'})}
${ex(L`\documentclass{letter}
\begin{document}
\begin{letter}{The Principal\\ St.~Thomas College}
\opening{Dear Sir,}
I request leave for two days.
\closing{Yours faithfully,}
\end{letter}
\end{document}`,{title:'letter class'})}
${fix('A chapter in an article',L`\documentclass{article}
\begin{document}
\chapter{Introduction}
Some text.
\end{document}`,{brief:'Real LaTeX stops with “Undefined control sequence \\chapter”. Fix it — either by changing the class or the command.',
 checks:[{re:'\\\\documentclass\\{(report|book)\\}|\\\\section\\{Introduction\\}',msg:'either a class with chapters, or \\section instead'}]})}

${tp('Class options')}
<p>Options go in square brackets, separated by commas: <code>\documentclass[12pt,a4paper,twocolumn]{article}</code>. Unknown options are simply ignored, with a warning.</p>
<div class="scroll-x"><table class="ref"><tr><th>Option</th><th>Effect</th></tr>
<tr><td><code>10pt</code> · <code>11pt</code> · <code>12pt</code></td><td>base font size (default 10pt)</td></tr>
<tr><td><code>a4paper</code> · <code>letterpaper</code> · <code>a5paper</code> · <code>legalpaper</code></td><td>paper size (default letterpaper)</td></tr>
<tr><td><code>oneside</code> · <code>twoside</code></td><td>margins for single- or double-sided printing (book defaults to twoside)</td></tr>
<tr><td><code>onecolumn</code> · <code>twocolumn</code></td><td>one or two columns of text</td></tr>
<tr><td><code>landscape</code></td><td>paper turned sideways</td></tr>
<tr><td><code>titlepage</code> · <code>notitlepage</code></td><td>title and abstract on a separate page, or not</td></tr>
<tr><td><code>openright</code> · <code>openany</code></td><td>chapters start on a right-hand page, or on any page</td></tr>
<tr><td><code>draft</code> · <code>final</code></td><td>draft marks overfull lines with a black box</td></tr>
<tr><td><code>leqno</code> · <code>fleqn</code></td><td>equation numbers on the left · equations flush left</td></tr></table></div>
${ex(L`\documentclass[12pt,a4paper,twocolumn]{article}
\begin{document}
\section{Two columns}
With the twocolumn option the text flows in two columns
--- open the Real PDF tab to see the true page.
\end{document}`,{title:'several options at once'})}
${match('Option ↔ effect',[[L`<code>12pt</code>`,'larger base font'],[L`<code>twoside</code>`,'margins for double-sided printing'],[L`<code>twocolumn</code>`,'text in two columns'],
 [L`<code>landscape</code>`,'paper turned sideways'],[L`<code>titlepage</code>`,'title on its own page'],[L`<code>draft</code>`,'marks overfull lines'],[L`<code>a4paper</code>`,'A4 paper size'],[L`<code>openany</code>`,'chapters may start on any page']],{left:'Option',right:'Effect'})}
${omr('Classes and options',[
 {q:'Which class does NOT provide \\chapter?',o:['book','report','article','—all do'],a:2,why:'Only report and book have chapters.'},
 {q:'Default base font size of the standard classes',o:['10pt','11pt','12pt','9pt'],a:0},
 {q:L`<code>\documentclass[12pt]{article}</code> — the <code>12pt</code> is`,o:['a mandatory argument','an optional argument','a package','an environment'],a:1,why:'Square brackets hold optional arguments.'},
 {q:'Which class is two-sided by default?',o:['article','report','book','letter'],a:2}
])}

${tp('The preamble and packages')}
<p>The preamble is where you load <b>packages</b> — add-ons that give LaTeX new commands — and set document-wide options. The form is <code>\usepackage[options]{name}</code>, and several packages can be loaded at once: <code>\usepackage{amsmath,graphicx}</code>.</p>
${ex(L`\documentclass[12pt]{article}
\usepackage[margin=2cm]{geometry}   % page margins
\usepackage{makeidx}                % an index (Unit 4)
\usepackage{url}                    % typesetting web addresses
\begin{document}
See \url{https://www.ctan.org} for thousands more packages.
\end{document}`,{title:'loading packages'})}
${trap(H`<p><code>\usepackage</code> is only allowed in the preamble. Put it after <code>\begin{document}</code> and LaTeX stops with “Can be used only in preamble”.</p>`)}

${tp('Page styles and page numbering')}
<p>The <b>page style</b> controls the running head and foot of each page.</p>
${reftable([
 [L`\pagestyle{plain}`,'page number centred in the footer (article/report default)',L`\pagestyle{plain}
Text on a plain page.`],
 [L`\pagestyle{empty}`,'no header, no page number',L`\pagestyle{empty}
A page with nothing in the margins.`],
 [L`\pagestyle{headings}`,'running heads from the section titles, number in the header',L`\pagestyle{headings}
\section{Methods}
The header shows “Methods” in the real PDF.`],
 [L`\pagestyle{myheadings}`,'running heads you set with \\markboth / \\markright',L`\pagestyle{myheadings}
\markright{My Assignment}
Header text is “My Assignment”.`],
 [L`\thispagestyle{empty}`,'change the style of the current page only',L`\thispagestyle{empty}
Only this page has no number.`],
 [L`\pagenumbering{roman}`,'page numbers i, ii, iii (also arabic, Roman, alph, Alph)',L`\pagenumbering{roman}
This page is numbered i.`]
],{h1:'Command',h2:'Effect'})}
<p class="mini">Page styles change only real pages, so check them on the <b>Real PDF</b> tab — the live preview has no pages.</p>
${match('Numbering style ↔ looks like',[[L`<code>arabic</code>`,'1, 2, 3'],[L`<code>roman</code>`,'i, ii, iii'],[L`<code>Roman</code>`,'I, II, III'],[L`<code>alph</code>`,'a, b, c'],[L`<code>Alph</code>`,'A, B, C']])}
${fill('Page styles',L`\pagestyle{[[plain]]}      % number centred in the footer
\thispagestyle{[[empty]]} % nothing on this page
\pagenumbering{[[roman]]}  % i, ii, iii`,{code:true,strict:true})}

${tp('The title, author and abstract')}
<p>Declare the title information in the preamble (or at the start of the body), then print it with <code>\maketitle</code>.</p>
${ex(L`\title{A Short Guide to \LaTeX}
\author{Ann Smith\thanks{St.~Thomas College} \and Ben Jose}
\date{\today}
\maketitle
\begin{abstract}
This guide shows how to structure a document.
\end{abstract}
\section{Introduction}
Text begins here.`,{title:'title block and abstract'})}
${reftable([
 [L`\title{…}`,'the title',L`\title{My Title}\author{Me}\maketitle`],
 [L`\author{…}`,'author(s); separate several with \\and, break lines with \\\\',L`\title{T}\author{A. One\\ College \and B. Two}\maketitle`],
 [L`\thanks{…}`,'a footnote to a title or author name',L`\title{T\thanks{Funded by UGC.}}\author{A}\maketitle`],
 [L`\date{…}`,'the date; \\today prints today; \\date{} prints none',L`\title{T}\author{A}\date{12 March 2026}\maketitle`],
 [L`\maketitle`,'prints the title block — without it nothing appears',L`\title{T}\author{A}\maketitle`],
 [L`abstract`,'environment for the summary',L`\begin{abstract}A summary.\end{abstract}`],
 [L`titlepage`,'environment for a hand-made title page',L`\begin{titlepage}
\centering {\Huge My Thesis}\par\vspace{2cm} Ann Smith
\end{titlepage}`]
],{h1:'Command',h2:'Effect'})}
${trap(H`<p>Forgetting <code>\maketitle</code> is the commonest title “bug”: <code>\title</code> and <code>\author</code> only <i>store</i> the information; nothing is printed until <code>\maketitle</code>.</p>`)}
${parsons('Build the title block',[L`\documentclass{article}`,L`\title{Field Report}`,L`\author{R. Nair}`,L`\date{\today}`,L`\begin{document}`,L`\maketitle`,L`\end{document}`],{extra:[L`\printtitle`]})}

${tp('Sectioning a document')}
<p>Sectioning commands number the parts, set the headings in the right size, and feed the table of contents.</p>
<div class="scroll-x"><table class="ref"><tr><th>Command</th><th>Level</th><th>Available in</th></tr>
<tr><td><code>\part{…}</code></td><td>−1 (0 in article)</td><td>all</td></tr>
<tr><td><code>\chapter{…}</code></td><td>0</td><td>report, book only</td></tr>
<tr><td><code>\section{…}</code></td><td>1</td><td>all</td></tr>
<tr><td><code>\subsection{…}</code></td><td>2</td><td>all</td></tr>
<tr><td><code>\subsubsection{…}</code></td><td>3</td><td>all</td></tr>
<tr><td><code>\paragraph{…}</code></td><td>4</td><td>all</td></tr>
<tr><td><code>\subparagraph{…}</code></td><td>5</td><td>all</td></tr></table></div>
${ex(L`\section{Methods}
\subsection{Sampling}
\subsubsection{Selecting the colleges}
\paragraph{Urban colleges.} The paragraph heading runs into the text.
\section*{Acknowledgements}
Starred: no number, and not in the table of contents.`,{title:'the levels'})}
${must(H`<p><b>Starred versions</b> (<code>\section*</code>) are unnumbered and are left out of the table of contents. <code>\appendix</code> switches later sections (article) or chapters (report/book) to letters: A, B, C.</p>`)}
${ex(L`\section{Results}
\section{Discussion}
\appendix
\section{Survey form}
\section{Raw data}`,{title:'\\appendix: A, B, … instead of 3, 4'})}
${ex(L`\documentclass{book}
\begin{document}
\frontmatter      % roman page numbers, unnumbered chapters
\chapter{Preface}
\mainmatter       % arabic numbers, numbered chapters
\chapter{Introduction}
\backmatter       % unnumbered chapters again
\chapter{Index of Terms}
\end{document}`,{title:'book: front, main and back matter'})}
${predict('Which output?',L`\section{Alpha}
\section*{Beta}
\section{Gamma}`,[L`\section{Alpha}\section{Beta}\section{Gamma}`,L`\section{Alpha}\section*{Beta}\section{Gamma}`,L`\section*{Alpha}\section*{Beta}\section{Gamma}`],1,'Beta is unnumbered, and Gamma is numbered 2 — the starred section does not use up a number.')}
${fill('Complete the levels',L`\[[chapter]]{Theory}        % level 0, report/book only
\[[section]]{Background}    % level 1
\[[subsection]]{History}    % level 2
\[[subsubsection]]{Knuth}   % level 3`,{code:true,strict:true})}
${build('Skeleton of a project report',L`\documentclass{article}
\begin{document}

\end{document}`,{brief:'Using the report class, write a title block and chapters Introduction and Method (Method with two sections), then an appendix chapter.',
 checks:[{re:'\\\\documentclass(\\[[^\\]]*\\])?\\{report\\}',msg:'report class'},{re:'\\\\maketitle',msg:'\\maketitle'},{re:'\\\\chapter\\{Introduction\\}',msg:'chapter Introduction'},
 {re:'\\\\chapter\\{Method\\}[\\s\\S]*\\\\section[\\s\\S]*\\\\section',msg:'Method with two sections'},{re:'\\\\appendix[\\s\\S]*\\\\chapter',msg:'an appendix chapter'}]})}
`});

/* ───────────── Unit 3 · Bibliography and BibTeX (Tutorials III & IV) ───────────── */
STATIONS.push({id:'m1-bib',title:'Bibliography and BibTeX',short:'3 · Bibliography & BibTeX',est:'~45 min',body:H`
${gist('Cite with \\cite{key}. List the sources yourself in thebibliography, or keep them in a .bib database and let BibTeX select, sort and format them.')}

${tp('A bibliography by hand: thebibliography')}
<p>The <code>thebibliography</code> environment makes the list. Each entry starts with <code>\bibitem{key}</code>; in the text, <code>\cite{key}</code> prints that entry’s label.</p>
${ex(L`As shown by Knuth~\cite{knuth84}, and later~\cite{lamport94,knuth84}.

\begin{thebibliography}{9}
\bibitem{knuth84} D.~E. Knuth, \emph{The \TeX book},
  Addison-Wesley, 1984.
\bibitem{lamport94} L.~Lamport, \emph{\LaTeX: A Document
  Preparation System}, 2nd ed., Addison-Wesley, 1994.
\end{thebibliography}`,{title:'thebibliography'})}
${reftable([
 [L`\begin{thebibliography}{9}`,'starts the list; the argument is the <i>widest label</i> — 9 for up to 9 entries, 99 for up to 99',L`\begin{thebibliography}{99}
\bibitem{a} First entry.
\end{thebibliography}`],
 [L`\bibitem{key}`,'an entry, numbered automatically',L`See \cite{a}.
\begin{thebibliography}{9}\bibitem{a} Author, Title.\end{thebibliography}`],
 [L`\bibitem[Knu84]{key}`,'an entry with your own label',L`See \cite{k}.
\begin{thebibliography}{Knu84}\bibitem[Knu84]{k} D. Knuth, The TeXbook.\end{thebibliography}`],
 [L`\cite{key}`,'cite one entry',L`as in \cite{a}.
\begin{thebibliography}{9}\bibitem{a} A. Author.\end{thebibliography}`],
 [L`\cite{a,b}`,'cite several at once',L`see \cite{a,b}.
\begin{thebibliography}{9}\bibitem{a} A.\bibitem{b} B.\end{thebibliography}`],
 [L`\cite[p.~5]{key}`,'cite with a note, e.g. a page',L`\cite[p.~5]{a}.
\begin{thebibliography}{9}\bibitem{a} A.\end{thebibliography}`]
],{h1:'Command',h2:'Effect'})}
${must(H`<p>The heading is <b>References</b> in <code>article</code> and <b>Bibliography</b> in <code>report</code> and <code>book</code>. Rename it with <code>\renewcommand{\refname}{Works Cited}</code> (article) or <code>\bibname</code> (report/book).</p>`)}
${trap(H`<p>Citations need <b>two runs</b>. On the first, LaTeX only records keys in the <code>.aux</code> file and prints <b>[?]</b>; the numbers appear on the second run. A key that never resolves gives “Citation ‘key’ undefined” — usually a typo, and keys are case-sensitive.</p>`)}
${fix('Undefined citation',L`\documentclass{article}
\begin{document}
Typesetting is an art \cite{Knuth}.
\begin{thebibliography}{9}
\bibitem{knuth} D. E. Knuth, The Art of Computer Programming.
\end{thebibliography}
\end{document}`,{brief:'The indicator shows a warning, and the PDF would print [?]. Why? Fix it.',checks:[{re:'\\\\cite\\{knuth\\}',msg:'the citation key matches the bibitem key exactly'}]})}

${tp('BibTeX: a database of references')}
<p>Typing every reference by hand gets old fast. <b>BibTeX</b> keeps your references in a separate <code>.bib</code> file — a database — and builds the list for you. The advantages:</p>
<ul>
  <li>Only the works you actually <code>\cite</code> are listed, sorted and numbered automatically.</li>
  <li>The format comes from a <b>style</b>, so changing every entry’s format is a one-word change.</li>
  <li>One <code>.bib</code> file serves every document you ever write.</li>
</ul>
<p>An entry has a <b>type</b>, a <b>key</b> (what you cite), and <b>fields</b>:</p>
${ex(L`@book{knuth84,
  author    = {Donald E. Knuth},
  title     = {The {\TeX}book},
  publisher = {Addison-Wesley},
  address   = {Reading, MA},
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
}`,{title:'two .bib entries',lang:'bibtex',run:false,file:'refs.bib'})}
<div class="scroll-x"><table class="ref"><tr><th>Entry type</th><th>For</th><th>Required fields</th></tr>
<tr><td><code>@article</code></td><td>a journal article</td><td>author, title, journal, year</td></tr>
<tr><td><code>@book</code></td><td>a book</td><td>author or editor, title, publisher, year</td></tr>
<tr><td><code>@inproceedings</code></td><td>a paper in conference proceedings</td><td>author, title, booktitle, year</td></tr>
<tr><td><code>@incollection</code></td><td>a chapter in an edited book</td><td>author, title, booktitle, publisher, year</td></tr>
<tr><td><code>@phdthesis</code></td><td>a PhD thesis</td><td>author, title, school, year</td></tr>
<tr><td><code>@mastersthesis</code></td><td>a master’s thesis</td><td>author, title, school, year</td></tr>
<tr><td><code>@techreport</code></td><td>a report by an institution</td><td>author, title, institution, year</td></tr>
<tr><td><code>@manual</code></td><td>technical documentation</td><td>title</td></tr>
<tr><td><code>@misc</code></td><td>anything else — websites, notes</td><td>none</td></tr>
<tr><td><code>@unpublished</code></td><td>an unpublished work</td><td>author, title, note</td></tr></table></div>
${must(H`<p><b>Names</b>: several authors are joined with <code>and</code> — never commas: <code>author = {Donald E. Knuth and Leslie Lamport}</code>. A name can be written <code>Knuth, Donald E.</code> (last name first). <b>Capitals</b> in titles may be lowercased by the style; protect them with braces: <code>{\TeX}</code>, <code>{India}</code>.</p>`)}
${match('Entry type ↔ what it is for',[[L`<code>@article</code>`,'a paper in a journal'],[L`<code>@book</code>`,'a whole book'],[L`<code>@inproceedings</code>`,'a conference paper'],[L`<code>@phdthesis</code>`,'a doctoral thesis'],[L`<code>@techreport</code>`,'a report from an institution'],[L`<code>@misc</code>`,'a website or anything else']],{left:'Entry type',right:'Used for'})}
${cards('BibTeX fields',[
 {f:'Required fields of @article',b:'author, title, journal, year'},{f:'Required fields of @book',b:'author (or editor), title, publisher, year'},
 {f:'Required fields of @inproceedings',b:'author, title, booktitle, year'},{f:'How are several authors separated?',b:'with the word and — never with commas'},
 {f:'Why write title = {The {\\TeX}book}?',b:'Braces stop the style changing the capitals.'},
 {f:'What is the key in @book{knuth84, …}?',b:'knuth84 — the name you use in \\cite{knuth84}.'}
])}
${fix('A broken .bib file',L`\documentclass{article}
\begin{document}
See \cite{wirth76}.
\bibliographystyle{plain}
\bibliography{refs}
\end{document}`,{brief:'Switch to the refs.bib tab: the entry has two mistakes (a missing comma between fields, and authors joined with a comma instead of “and”). Fix both.',
 bib:L`@book{wirth76,
  author = {Niklaus Wirth, Kathleen Jensen}
  title = {Pascal User Manual and Report},
  publisher = {Springer},
  year = {1976}
}`,strictWarn:true,checks:[{file:'bib',re:'Wirth and Kathleen|Wirth\\s+and\\s+Kathleen',msg:'the two authors are joined with “and”'}]})}

${tp('Using BibTeX in your document')}
<p>Two commands, placed where the list should appear:</p>
${ex(L`\documentclass{article}
\begin{document}
\TeX{} was designed by Knuth~\cite{knuth84}; \LaTeX{}
came later~\cite{lamport86}.
\bibliographystyle{plain}   % how to format the list
\bibliography{refs}          % the database: refs.bib
\end{document}`,{title:'citing from a .bib file',bib:L`@book{knuth84,
  author    = {Donald E. Knuth},
  title     = {The {\TeX}book},
  publisher = {Addison-Wesley},
  year      = {1984}
}
@article{lamport86,
  author  = {Leslie Lamport},
  title   = {{\LaTeX}: A Document Preparation System},
  journal = {TUGboat},
  volume  = {7},
  pages   = {10--20},
  year    = {1986}
}`,note:'Press ▶ run: the editor gets a <b>refs.bib</b> tab. Try the Real PDF tab — TeX Live really runs BibTeX.'})}
${reftable([
 [L`\bibliographystyle{plain}`,'choose the style (plain, unsrt, alpha, abbrv)',L`\cite{a}
\bibliographystyle{plain}
\bibliography{refs}`,{bib:'@book{a, author={A. Author}, title={A Book}, publisher={Pub}, year={2001}}'}],
 [L`\bibliography{refs}`,'print the list from refs.bib — no .bib extension',L`\cite{a}
\bibliographystyle{plain}
\bibliography{refs}`,{bib:'@book{a, author={A. Author}, title={A Book}, publisher={Pub}, year={2001}}'}],
 [L`\nocite{key}`,'list an entry without citing it in the text',L`Nothing cited here.
\nocite{a}
\bibliographystyle{plain}
\bibliography{refs}`,{bib:'@book{a, author={A. Author}, title={A Book}, publisher={Pub}, year={2001}}'}],
 [L`\nocite{*}`,'list every entry in the database',L`\nocite{*}
\bibliographystyle{plain}
\bibliography{refs}`,{bib:'@book{a, author={A. Author}, title={A Book}, publisher={Pub}, year={2001}}\n@misc{b, author={B. Writer}, title={A Website}, year={2020}}'}]
],{h1:'Command',h2:'Effect'})}
<h5>The run order</h5>
<p>BibTeX is a separate program, so building the list takes four steps. This is a classic exam question — know <i>why</i> each run is needed:</p>
<div class="scroll-x"><table class="ref"><tr><th>Run</th><th>What it does</th></tr>
<tr><td>1. <code>pdflatex</code></td><td>writes the cited keys, the style and the database name into the <code>.aux</code> file; citations print as [?]</td></tr>
<tr><td>2. <code>bibtex</code></td><td>reads the <code>.aux</code>, looks the keys up in the <code>.bib</code>, writes the formatted list to a <code>.bbl</code> file</td></tr>
<tr><td>3. <code>pdflatex</code></td><td>reads the <code>.bbl</code> and prints the list; records the labels</td></tr>
<tr><td>4. <code>pdflatex</code></td><td>resolves the citations in the text into the right labels</td></tr></table></div>
${parsons('Order the compile steps',[L`pdflatex document`,L`bibtex document`,L`pdflatex document`,L`pdflatex document`],{extra:[L`makeindex document`]})}
${omr('The BibTeX workflow',[
 {q:'Which file does BibTeX read to find out which keys were cited?',o:['.tex','.aux','.bbl','.log'],a:1,why:'LaTeX writes the citations into the .aux; BibTeX reads it.'},
 {q:'Which file does BibTeX write?',o:['.bib','.aux','.bbl','.pdf'],a:2,why:'The formatted thebibliography goes into the .bbl, which LaTeX then inputs.'},
 {q:L`<code>\bibliography{refs}</code> refers to the file`,o:['refs.tex','refs.bib','refs.bbl','refs.aux'],a:1,why:'Name the database without its .bib extension.'},
 {q:'An entry appears in the list only if…',o:['it is in the .bib file','it is cited (or \\nocite-d)','it has a year','it is an article'],a:1},
 {q:L`<code>\nocite{*}</code> means`,o:['cite nothing','list every entry in the database','cite the first entry','ignore the bibliography'],a:1}
])}

${tp('Choosing a bibliography style')}
<p>The four standard styles:</p>
<div class="scroll-x"><table class="ref"><tr><th>Style</th><th>Labels</th><th>Order</th><th>Names</th></tr>
<tr><td><code>plain</code></td><td>[1], [2], …</td><td>alphabetical by author</td><td>full first names</td></tr>
<tr><td><code>unsrt</code></td><td>[1], [2], …</td><td>order of first citation</td><td>full first names</td></tr>
<tr><td><code>alpha</code></td><td>[Knu84], [Lam94]</td><td>alphabetical</td><td>full first names</td></tr>
<tr><td><code>abbrv</code></td><td>[1], [2], …</td><td>alphabetical</td><td>initials only</td></tr></table></div>
${ex(L`First \cite{zeller}, then \cite{adams}.
\bibliographystyle{unsrt}   % try plain, alpha, abbrv
\bibliography{refs}`,{title:'switch the style and watch',bib:L`@book{adams,
  author = {Douglas Adams}, title = {The Salmon of Doubt},
  publisher = {Macmillan}, year = {2002}
}
@article{zeller,
  author = {Christian Zeller}, title = {Kalender-Formeln},
  journal = {Acta Mathematica}, volume = {9}, pages = {131--136}, year = {1886}
}`,note:'Change <code>unsrt</code> to <code>plain</code>: Adams moves to the top and the numbers swap. <code>alpha</code> gives labels like [Ada02].'})}
${match('Style ↔ what it does',[[L`<code>plain</code>`,'numbered, sorted by author'],[L`<code>unsrt</code>`,'numbered in order of citation'],[L`<code>alpha</code>`,'labels like [Knu84]'],[L`<code>abbrv</code>`,'like plain, with initials for first names']],{left:'Style',right:'Effect'})}
${build('A reference list from a database',L`\documentclass{article}
\begin{document}
The first programmable computer was designed by Babbage.

\end{document}`,{brief:'Cite babbage1864 after “Babbage”, list the database with the alpha style, and also include the Lovelace entry without citing it.',
 bib:L`@book{babbage1864,
  author = {Charles Babbage}, title = {Passages from the Life of a Philosopher},
  publisher = {Longman}, year = {1864}
}
@article{lovelace1843,
  author = {Ada Lovelace}, title = {Notes on the Analytical Engine},
  journal = {Scientific Memoirs}, volume = {3}, year = {1843}
}`,checks:[{re:'\\\\cite\\{babbage1864\\}',msg:'\\cite{babbage1864}'},{re:'\\\\bibliographystyle\\{alpha\\}',msg:'alpha style'},{re:'\\\\bibliography\\{refs\\}',msg:'\\bibliography{refs}'},{re:'\\\\nocite\\{(lovelace1843|\\*)\\}',msg:'Lovelace listed with \\nocite'}]})}
`});

/* ───────────── Unit 4 · Table of contents and index (Tutorial V) ───────────── */
STATIONS.push({id:'m1-toc',title:'Table of contents and index',short:'4 · Contents & index',est:'~35 min',body:H`
${gist('\\tableofcontents is built from your sectioning commands automatically; an index is built from \\index entries by the MakeIndex program.')}

${tp('The table of contents')}
<p>One command, <code>\tableofcontents</code>, prints the contents list wherever you put it. LaTeX builds it from every numbered sectioning command.</p>
<div class="callout warning" style="margin:.7rem 0;padding:.65rem .85rem;border-left:4px solid var(--amber);background:rgba(var(--amber-rgb),.08);border-radius:.45rem">
  <p style="margin:0;font-size:.85rem;color:var(--ink)"><b>Note on live preview:</b> In-browser preview (latex.js) cannot generate multi-pass <code>.toc</code> files. To see the live Table of Contents generated, open the code in the <b>IDE</b> and compile with <b>⎙ Real PDF</b> (TeX Live). Here is a static example of what LaTeX outputs:</p>
</div>
<div class="target-card" style="margin:.8rem 0;max-width:32rem">
  <div style="font-family:var(--f-serif,'Newsreader',serif);font-size:1.2rem;font-weight:700;margin-bottom:.7rem;text-align:center;color:#111">Contents</div>
  <div style="font-family:var(--f-serif,'Newsreader',serif);font-size:.9rem;color:#111;line-height:1.85">
    <div style="display:flex;align-items:baseline"><span style="font-weight:600;width:1.6rem">1</span><span style="font-weight:600">Introduction</span><span style="flex:1;border-bottom:1px dotted #888;margin:0 .5rem 3px"></span><span style="font-weight:600">1</span></div>
    <div style="display:flex;align-items:baseline"><span style="font-weight:600;width:1.6rem">2</span><span style="font-weight:600">Method</span><span style="flex:1;border-bottom:1px dotted #888;margin:0 .5rem 3px"></span><span style="font-weight:600">1</span></div>
    <div style="display:flex;align-items:baseline;padding-left:1.4rem"><span style="width:2rem">2.1</span><span>Survey design</span><span style="flex:1;border-bottom:1px dotted #888;margin:0 .5rem 3px"></span><span>2</span></div>
    <div style="display:flex;align-items:baseline"><span style="font-weight:600;width:1.6rem">3</span><span style="font-weight:600">Results</span><span style="flex:1;border-bottom:1px dotted #888;margin:0 .5rem 3px"></span><span style="font-weight:600">3</span></div>
  </div>
  <div style="margin-top:.6rem;padding-top:.4rem;border-top:1px dashed #ddd;font-size:.7rem;color:#777;text-align:center;font-family:var(--f-m)">Static preview — in IDE use Real PDF to typeset</div>
</div>
${ex(L`\tableofcontents
\section{Introduction}
\section{Method}
\subsection{Survey design}
\section*{Acknowledgements}   % starred: not listed
\section{Results}`,{title:'\\tableofcontents',note:'Open in the <b>IDE</b> and compile with <b>⎙ PDF</b> to generate the real table of contents via TeX Live.'})}
${must(H`<p><b>It takes two runs.</b> On the first run LaTeX writes the headings into a <code>.toc</code> file; on the second it reads that file back and prints the list. A new section therefore appears in the contents only after compiling twice.</p>`)}
${reftable([
 [L`\tableofcontents`,'print the contents list',L`\tableofcontents
\section{One}\section{Two}`],
 [L`\listoftables`,'list of all \\caption-ed tables',L`\listoftables
\begin{table}[h]\centering\caption{Marks}\begin{tabular}{cc}a&b\end{tabular}\end{table}`],
 [L`\listoffigures`,'list of all \\caption-ed figures',L`\listoffigures
\begin{figure}[h]\centering\caption{A diagram}\end{figure}`],
 [L`\addcontentsline{toc}{section}{Preface}`,'add an entry by hand — e.g. for a starred section',L`\tableofcontents
\section*{Preface}
\addcontentsline{toc}{section}{Preface}
\section{Main}`],
 [L`\setcounter{tocdepth}{1}`,'how deep the list goes: 1 = sections only, 2 adds subsections',L`\setcounter{tocdepth}{1}
\tableofcontents
\section{A}\subsection{A.1}`],
 [L`\renewcommand{\contentsname}{Index of Topics}`,'rename the heading',L`\renewcommand{\contentsname}{What is Inside}
\tableofcontents
\section{A}`]
],{h1:'Command',h2:'Effect'})}
<p class="mini"><code>\addcontentsline</code> and <code>tocdepth</code> are only honoured in the <b>Real PDF</b> tab.</p>
${omr('Contents',[
 {q:'Why does a new section appear in the contents only after the second compile?',o:['LaTeX is slow','The first run writes the .toc file, the second reads it','The PDF viewer caches','It needs BibTeX'],a:1},
 {q:L`A <code>\section*</code> heading is`,o:['numbered and listed','unnumbered and not listed','numbered but not listed','listed but unnumbered'],a:1},
 {q:'Which command lists captioned tables?',o:[L`<code>\tableofcontents</code>`,L`<code>\listoftables</code>`,L`<code>\tablelist</code>`,L`<code>\printtables</code>`],a:1},
 {q:L`<code>\addcontentsline{toc}{section}{Preface}</code> is used to`,o:['delete an entry','put an unnumbered section in the contents','rename the contents','number a section'],a:1}
])}

${tp('Making an index')}
<p>An index needs the <code>makeidx</code> package and three things in your document:</p>
${ex(L`\documentclass{article}
\usepackage{makeidx}   % 1. the package
\makeindex             % 2. start collecting entries
\begin{document}
\section{Typesetting}
\TeX\index{TeX} was written by Knuth\index{Knuth, Donald}.
Fonts\index{fonts} come in families\index{fonts!families}.
\section{Macros}
\LaTeX\index{LaTeX} is built on \TeX\index{TeX}.
\printindex            % 3. print the index here
\end{document}`,{title:'the three parts of an index'})}
<p>Then compile in three steps: <code>pdflatex</code> writes every <code>\index</code> entry into a <code>.idx</code> file; the <b>MakeIndex</b> program sorts and merges them into a <code>.ind</code> file; a final <code>pdflatex</code> prints it where <code>\printindex</code> stands. The Real PDF tab runs all three for you.</p>
${reftable([
 [L`\index{word}`,'a plain entry',L`Knuth\index{Knuth}
\printindex`,{pre:'\\usepackage{makeidx}\n\\makeindex'}],
 [L`\index{fonts!serif}`,'a sub-entry under “fonts” (up to three levels: a!b!c)',L`Serif\index{fonts!serif} and sans\index{fonts!sans serif}.
\printindex`,{pre:'\\usepackage{makeidx}\n\\makeindex'}],
 [L`\index{Knuth@\textsc{Knuth}}`,'sort as “Knuth”, print as small caps',L`Knuth\index{Knuth@\textsc{Knuth}}
\printindex`,{pre:'\\usepackage{makeidx}\n\\makeindex'}],
 [L`\index{TeX|see{LaTeX}}`,'a cross-reference instead of a page number',L`TeX\index{TeX|see{LaTeX}}
\printindex`,{pre:'\\usepackage{makeidx}\n\\makeindex'}],
 [L`\index{fonts|seealso{sizes}}`,'“see also” — page numbers plus a pointer',L`Fonts\index{fonts}\index{fonts|seealso{sizes}}
\printindex`,{pre:'\\usepackage{makeidx}\n\\makeindex'}],
 [L`\index{tables|textbf}`,'this page number in bold (the main discussion)',L`Tables\index{tables|textbf}
\printindex`,{pre:'\\usepackage{makeidx}\n\\makeindex'}],
 [L`\index{lists|(} … \index{lists|)}`,'a page range: from here to there',L`\section{A}Lists begin\index{lists|(}
\section{B}and end\index{lists|)}.
\printindex`,{pre:'\\usepackage{makeidx}\n\\makeindex'}]
],{h1:'Form',h2:'Meaning'})}
${match('Index syntax ↔ meaning',[[L`<code>a!b</code>`,'b is a sub-entry of a'],[L`<code>a@b</code>`,'sort by a, print b'],[L`<code>|see{x}</code>`,'refer the reader to x'],[L`<code>|textbf</code>`,'bold page number'],[L`<code>|(</code> … <code>|)</code>`,'a page range']],{left:'Syntax',right:'Means'})}
${fill('Complete the index set-up',L`\documentclass{article}
\usepackage{[[makeidx]]}
\[[makeindex]]
\begin{document}
Paris\index{cities[[!]]Paris} is a city.
\[[printindex]]
\end{document}`,{code:true,strict:true})}
${parsons('The index compile sequence',[L`pdflatex document   % writes document.idx`,L`makeindex document  % sorts it into document.ind`,L`pdflatex document   % prints the index`],{extra:[L`bibtex document`]})}
${fix('Why is the index empty?',L`\documentclass{article}
\usepackage{makeidx}
\begin{document}
Knuth\index{Knuth} invented \TeX\index{TeX}.
\printindex
\end{document}`,{brief:'Everything looks right, yet the index comes out empty. The indicator gives a warning — act on it.',checks:[{re:'\\\\makeindex',msg:'\\makeindex in the preamble'}]})}
${cards('Contents & index in six cards',[
 {f:'Files involved in a table of contents',b:'.toc — written on run 1, read on run 2'},
 {f:'Three things an index needs in the .tex',b:'\\usepackage{makeidx}, \\makeindex, \\printindex (plus \\index entries)'},
 {f:'The program that sorts index entries',b:'MakeIndex: .idx → .ind'},
 {f:'Sub-entry syntax',b:{code:'\\index{fonts!serif}'}},
 {f:'Cross-reference in the index',b:{code:'\\index{TeX|see{LaTeX}}'}},
 {f:'Put an unnumbered section in the contents',b:{code:'\\addcontentsline{toc}{section}{Preface}'}}
])}
${build('Contents, index and references together',L`\documentclass{article}
\begin{document}

\section{Origins}
Knuth wrote TeX.
\section{Today}
LaTeX is everywhere.

\end{document}`,{brief:'Add a table of contents, index “Knuth” and “LaTeX”, and print the index at the end.',
 checks:[{re:'\\\\usepackage\\{makeidx\\}',msg:'makeidx loaded'},{re:'\\\\makeindex',msg:'\\makeindex'},{re:'\\\\tableofcontents',msg:'\\tableofcontents'},{re:'\\\\index\\{Knuth',msg:'Knuth indexed'},{re:'\\\\index\\{LaTeX',msg:'LaTeX indexed'},{re:'\\\\printindex',msg:'\\printindex'}]})}
`});
