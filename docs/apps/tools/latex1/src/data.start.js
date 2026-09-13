/* ═══════════════════ ORIENTATION ═══════════════════ */
STATIONS.push({id:'start',title:'Start here',short:'How this app works',est:'~8 min',body:H`
${gist('Read a little, run the example, change one thing, predict what happens, then prove it on a quiz. That loop is the whole method.')}
<p class="mini" style="margin-top:-.2rem">Written from the syllabus (MAT5FS112, Text 1: <i>LaTeX Tutorial — A Primer</i>, Indian TeX Users Group). It will be re-aligned to your class notes when you upload them.</p>

${tp('The IDE, in one minute')}
<p>Every example in this app can be run. <b>▶ run</b> shows its output right under the code; <b>full code</b> opens the whole file in a code window; and <b>Edit in IDE</b> carries it to the <b>IDE</b> tab — in the left rail on a laptop, the bottom bar on a phone — where you can change it and watch the result.</p>
${editor(L`\documentclass{article}
\begin{document}
\section{My first section}
Hello, \LaTeX! This is \textbf{bold}, this is \emph{emphasised},
and this is a dash --- like this.

Change a word in the IDE and watch the output update.
\end{document}`)}
<ul>
  <li><b>Live preview</b> is instant and runs in your browser (latex.js, plus this app’s own imitation of the few things latex.js cannot do — tables, bibliographies, indexes; the strip names them). On a phone the output sits <i>above</i> the code, so cause and effect stay on one screen; <b>Code / Split / Output</b> switches between them.</li>
  <li><b>⎙ PDF</b> sends the whole project to a real TeX Live installation and shows the actual PDF. Use it whenever the page layout matters — page numbers, headers, a real BibTeX run.</li>
  <li>The <b>indicator</b> under the code speaks twice: the line <i>LaTeX itself</i> would print (so you learn to read real logs) and what it actually means, with a fix. Tap it to see every problem; tap a problem to jump to its file and line.</li>
  <li>A project can have <b>many files</b>, as real theses do: chapters in <code>chapters/intro.tex</code>, pulled in with <code>\include</code> or <code>\input</code>, a <code>refs.bib</code>, and one <b>main</b> file that gets compiled. Every example you open becomes its own project; the 📁 menu switches between them, and ⋯ downloads a <code>.zip</code> that opens in Overleaf or TeXstudio.</li>
  <li>On a phone, the key bar gives you <span class="kbd">\</span> <span class="kbd">{ }</span> <span class="kbd">$</span> <span class="kbd">&amp;</span> and friends, which a phone keyboard hides. Everything saves by itself, in this browser.</li>
</ul>
${fix('Break it, then mend it',L`\documentclass{article}
\begin{document}
Save 50% on R&D today!
\end{document}`,{brief:'This innocent sentence does not compile. Read the indicator, then fix it. (Hint: two of LaTeX’s ten special characters are hiding in it.)',
 checks:[{re:'\\\\%',msg:'the percent sign is escaped as \\%'},{re:'\\\\&',msg:'the ampersand is escaped as \\&'}]})}

${tp('How this app teaches — and why')}
<p>Each technique below is here because the research says it works, not because it is fashionable.</p>
<div class="scroll-x"><table class="ref">
<tr><th>What you will do</th><th>Why it works</th></tr>
<tr><td><b>OMR sheets &amp; checkpoints</b> — answer before you look</td><td>Retrieving something from memory strengthens it far more than re-reading it — the <i>testing effect</i> (Roediger &amp; Karpicke, 2006). A large review of study techniques rated practice testing and spaced practice as the two with the highest utility, and highlighting and re-reading as low (Dunlosky et al., 2013). <i>Make It Stick</i> (Brown, Roediger &amp; McDaniel, 2014) is the readable version.</td></tr>
<tr><td><b>3-D flashcards with boxes</b> — cards you know move up, cards you miss go back to box 1</td><td>Spacing reviews out beats massing them (Cepeda et al., 2006). The boxes are the Leitner system, the simplest spaced-repetition schedule. Felienne Hermans’ <i>The Programmer’s Brain</i> (2021) recommends exactly this for syntax: automate the symbols so working memory is free for meaning.</td></tr>
<tr><td><b>Example → fill-the-blanks → build it yourself</b></td><td>Beginners learn more from studying worked examples than from solving problems cold (Sweller &amp; Cooper, 1985), and learning improves further when the example is gradually <i>faded</i> into a problem (Renkl &amp; Atkinson, 2003). Typing the missing piece yourself also helps — the generation effect (Slamecka &amp; Graf, 1978).</td></tr>
<tr><td><b>Parsons problems</b> — put shuffled lines in order</td><td>Reordering given lines teaches structure as well as writing the code from scratch, in markedly less time (Ericson, Margulieux &amp; Rick, 2017). Greg Wilson’s <i>Teaching Tech Together</i> (2019) lists them among the most useful exercises for beginners.</td></tr>
<tr><td><b>Predict, then run</b></td><td>Committing to a prediction before running code — the first step of the PRIMM approach (Sentance, Waite &amp; Kallia, 2019) — exposes wrong mental models while they are still cheap to fix.</td></tr>
<tr><td><b>Output above input, updating as you type</b></td><td>Bret Victor’s <i>Learnable Programming</i> (2012): learners understand a system when they can see its state change immediately. Putting the source and its result next to each other follows Mayer’s spatial-contiguity principle for multimedia learning.</td></tr>
<tr><td><b>Errors in two voices</b></td><td>Raw compiler messages are a well-documented barrier for novices, and enhanced, plain-language messages help (Becker et al., 2019, ITiCSE working-group report). You still see the real LaTeX line, so you learn to read a genuine log.</td></tr>
<tr><td><b>Mixed model papers</b></td><td>Interleaving different kinds of question in one session improves later performance on each kind (Rohrer &amp; Taylor, 2007).</td></tr>
</table></div>
${why(H`<p><b>What the research says about LaTeX in particular.</b> In a controlled comparison, Knauff &amp; Nejasmic (2014, <i>PLOS ONE</i>) found that LaTeX users were slower and made more formatting and typing errors than Word users on ordinary text, did better only on equation-heavy material — and yet rated themselves as more efficient. Two lessons are built into this app: spend your practice on the <i>mapping from markup to output</i> and on <i>reading errors</i>, which is where LaTeX time is actually lost; and trust your quiz scores over your feeling of fluency.</p>`)}

${tp('Your daily loop')}
<ol>
  <li><b>Read the “in one line” box</b> at the top of a section. That is the idea in a sentence.</li>
  <li><b>Run the first example</b>, then change one thing in it — but <i>say what you expect</i> before you look.</li>
  <li><b>Do the practice</b> in that topic (fill, match, Parsons, predict, fix). Mistakes here are the useful kind.</li>
  <li><b>Press ✓ Mark as completed</b> at the end of the topic (or tick its circle). The next unfinished one opens by itself. Opening something closes everything else, so the page never gets crowded.</li>
  <li><b>Star anything shaky</b> — <i>☆ Bookmark for review</i>. The <b>Bookmarks</b> tab gathers every starred topic, section and exam question into one short list: that is your revision the night before.</li>
  <li><b>Next day, flashcards and OMR first.</b> Two minutes of recall before new material is worth more than twenty of re-reading.</li>
</ol>
${omr('Check you’ve got the method',[
 {q:'You have 20 minutes before an exam on LaTeX tables. Which use of the time does the evidence favour?',o:['Re-reading your notes on tabular twice','Highlighting the key commands','Writing three small tables from memory, then checking them','Watching a video of someone else making tables'],a:2,why:'Retrieval practice — producing the answer yourself — beats re-reading, highlighting and passive watching.'},
 {q:'Why does each “Predict, then run” exercise ask you to choose an output before running the code?',o:['To save time','A committed guess exposes a wrong mental model','Because running code is slow','So the app can grade you'],a:1,why:'A prediction you have committed to is what makes the surprise informative.'},
 {q:'You got a flashcard wrong. Under the Leitner system, what happens to it?',o:['It is removed from the deck','It moves up a box','It goes back to box 1 and comes round soon','Nothing'],a:2,why:'Missed cards return to the first box and are reviewed most often.'}
])}
`});
