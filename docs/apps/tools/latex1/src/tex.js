/* ══════════════════════════════════════════════════════════════════
   LXTeX — a LaTeX front end for the live preview.

   latex.js renders ordinary LaTeX beautifully but knows nothing of
   tabular, tabbing, verbatim, \cite, BibTeX, \footnote, \index or
   \newcommand — half of Modules I–II. This layer:

     1. lints the source and reports errors in two voices — what real
        LaTeX would print, and what it actually means;
     2. rewrites the unsupported constructs into placeholder tokens,
        keeping every line where it was (so latex.js's own error line
        numbers still point at the user's line);
     3. lets latex.js typeset the rest;
     4. swaps the placeholders for its own renderings: tables, tab
        stops, verbatim, the bibliography (a small BibTeX emulator),
        the index (a small MakeIndex emulator), footnotes and floats.

   Everything emulated is reported back, so the UI can say honestly
   which parts of the preview are an imitation — the Real PDF tab is
   always the authority.
   ══════════════════════════════════════════════════════════════════ */
const LXTeX=(()=>{
'use strict';

/* ─────────────────────────── small utilities ─────────────────────────── */
const esc=s=>String(s).replace(/[&<>"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[c]));
const lineAt=(s,i)=>{let n=1;for(let k=0;k<i&&k<s.length;k++)if(s.charCodeAt(k)===10)n++;return n;};
const colAt=(s,i)=>i-s.lastIndexOf('\n',i-1);
const nl=s=>(s.match(/\n/g)||[]).length;
const pad=s=>'\n'.repeat(nl(s));            // keep the line count of a replaced span

/* read a {…} group starting at s[i]==='{'; returns {text,end} (end = index after '}') */
function group(s,i){
  if(s[i]!=='{')return null;
  let d=0;
  for(let k=i;k<s.length;k++){
    const c=s[k];
    if(c==='\\'){k++;continue;}
    if(c==='{')d++;
    else if(c==='}'){d--;if(d===0)return {text:s.slice(i+1,k),end:k+1};}
  }
  return null;
}
/* optional [..] (balanced for nested braces) */
function optarg(s,i){
  let j=i;while(s[j]===' ')j++;
  if(s[j]!=='[')return null;
  let d=0;
  for(let k=j+1;k<s.length;k++){
    const c=s[k];
    if(c==='\\'){k++;continue;}
    if(c==='{')d++;else if(c==='}')d--;
    else if(c===']'&&d===0)return {text:s.slice(j+1,k),end:k+1};
  }
  return null;
}
/* next {…} after optional spaces; also accepts a single token (\macro or char) like TeX */
function arg(s,i){
  let j=i;while(s[j]===' '||s[j]==='\n'&&s[j+1]!=='\n')j++;
  if(s[j]==='{')return group(s,j);
  if(s[j]==='\\'){const m=/^\\([A-Za-z@]+|.)/.exec(s.slice(j));if(m)return {text:m[0],end:j+m[0].length};}
  if(j<s.length&&!/\s/.test(s[j]))return {text:s[j],end:j+1};
  return null;
}
/* split at top-level separators (not inside braces) */
function splitTop(s,sep){
  const out=[];let d=0,last=0;
  for(let k=0;k<s.length;k++){
    const c=s[k];
    if(c==='\\'){
      if(sep==='\\\\'&&s[k+1]==='\\'&&d===0){out.push(s.slice(last,k));k++;last=k+1;continue;}
      k++;continue;}
    if(c==='{')d++;else if(c==='}')d--;
    else if(d===0&&c===sep){out.push(s.slice(last,k));last=k+1;}
  }
  out.push(s.slice(last));return out;
}
/* find the matching \end{env} for a \begin{env} whose body starts at `from` (handles nesting) */
function findEnd(s,env,from){
  const re=new RegExp('\\\\(begin|end)\\{'+env.replace(/[*]/g,'\\*')+'\\}','g');
  re.lastIndex=from;let d=1,m;
  while((m=re.exec(s))){if(m[1]==='begin')d++;else if(--d===0)return {start:m.index,end:m.index+m[0].length};}
  return null;
}
/* TeX lengths → CSS */
function cssLen(t){
  t=String(t).trim();
  let m=/^(-?[\d.]*)\s*\\(textwidth|linewidth|columnwidth|hsize)$/.exec(t);
  if(m)return ((m[1]===''?1:parseFloat(m[1]))*100).toFixed(1)+'%';
  m=/^(-?[\d.]+)\s*(pt|bp|mm|cm|in|em|ex|pc|sp|dd|cc)$/.exec(t);
  if(!m)return null;
  const v=parseFloat(m[1]),u=m[2];
  const px={pt:1.3333,bp:1.3333,mm:3.7795,cm:37.795,in:96,pc:16,sp:1.3333/65536,dd:1.42,cc:17.1}[u];
  return u==='em'||u==='ex'?v+u:(v*px).toFixed(1)+'px';
}

/* ─────────────────────── what latex.js already knows ─────────────────────── */
/* Commands the linter accepts. Anything else is "Undefined control sequence",
   exactly as TeX would say. The list is deliberately generous for Modules I–II. */
const KNOWN=new Set((`documentclass usepackage begin end item section subsection subsubsection paragraph
subparagraph part chapter title author date maketitle thanks and today tableofcontents listoftables
listoffigures textbf textit emph texttt textsf textsc textsl textup textmd textrm textnormal
bfseries itshape ttfamily sffamily scshape slshape upshape mdseries rmfamily normalfont em bf it tt
sf sc sl rm tiny scriptsize footnotesize small normalsize large Large LARGE huge Huge underline
label ref pageref cite nocite bibitem bibliography bibliographystyle footnote footnotemark footnotetext
index makeindex printindex newcommand renewcommand providecommand newenvironment renewenvironment
hspace vspace noindent indent par bigskip medskip smallskip newline linebreak nolinebreak newpage
clearpage cleardoublepage pagebreak nopagebreak hfill vfill centering raggedright raggedleft
TeX LaTeX LaTeXe ldots dots textbackslash textasciitilde textasciicircum textbar textless textgreater
S P dag ddag copyright pounds textregistered texttrademark textdollar textunderscore
mbox fbox makebox framebox parbox rule url href hline cline vline multicolumn multirow caption
tabularnewline kill pagestyle thispagestyle pagenumbering markboth markright appendix frontmatter
mainmatter backmatter setcounter addtocounter stepcounter arabic roman Roman alph Alph value
setlength addtolength arraystretch tabcolsep parindent parskip textwidth linewidth columnwidth
labelitemi labelitemii labelitemiii labelitemiv labelenumi labelenumii labelenumiii labelenumiv
theenumi theenumii theenumiii theenumiv contentsname refname bibname abstractname indexname
listtablename listfigurename tablename figurename addcontentsline addtocontents verb
textsuperscript textsubscript marginpar includegraphics def let relax protect quad qquad
enspace thinspace negthinspace space nobreakspace slash thispagestyle frac sqrt sum int prod lim
infty alpha beta gamma delta epsilon theta lambda mu pi sigma omega Gamma Delta Theta Lambda Pi
Sigma Omega cdot cdots vdots ddots times div pm mp leq geq neq approx equiv cdot left right
mathrm mathbf mathit mathcal mathbb text tag nonumber notag displaystyle textstyle hat bar vec
dot ddot tilde overline underbrace overbrace pmod bmod sin cos tan log ln exp max min lceil rceil
lfloor rfloor langle rangle ne le ge to rightarrow leftarrow Rightarrow Leftarrow iff implies in
notin subset subseteq supset cup cap emptyset forall exists partial nabla prime ell hbar
selectlanguage textcolor color definecolor emph onecolumn twocolumn footnoterule
secnumdepth tocdepth enumi enumii enumiii enumiv section subsection chapter footnote page
equation table figure hyphenation linespread baselinestretch fill stretch cr crcr
seename see alsoname item null ignorespaces unskip opening closing signature address cc encl ps
location telephone name makelabels c u v H t d b r k ss ae AE oe OE o O aa AA l L i j
star bullet circ diamond ast dagger ddagger checkmark triangleright triangle square blacksquare
ldots textbullet textperiodcentered textendash textemdash textquoteleft textquoteright
textquotedblleft textquotedblright guillemotleft guillemotright textellipsis cdot ast
mathsf mathtt boldsymbol operatorname sqrt overrightarrow`).split(/\s+/));
/* commands that genuinely need a package in real LaTeX */
const NEEDS={printindex:'makeidx',url:'url (or hyperref)',href:'hyperref',multirow:'multirow',
  textcolor:'xcolor',color:'xcolor',definecolor:'xcolor',includegraphics:'graphicx'};
const ENVS=new Set(`document itemize enumerate description quote quotation verse center flushleft
flushright tabular tabular* tabbing table table* figure figure* verbatim verbatim* thebibliography
theindex abstract titlepage minipage equation equation* eqnarray eqnarray* array displaymath math
letter filecontents filecontents* comment`.split(/\s+/));
const LISTS=new Set(['itemize','enumerate','description','thebibliography','theindex']);

/* ═════════════════════════════════ LINT ═════════════════════════════════
   Each finding: {line,col,sev:'error'|'warning'|'info',tex,msg,fix}
   `tex` is the message pdflatex would print; `msg`/`fix` say it plainly. */
function lint(src,files){
  const out=[];
  const add=(i,sev,tex,msg,fix)=>out.push({line:lineAt(src,i),col:colAt(src,i),sev,tex,msg,fix});
  /* mask verbatim + comments so neither is linted (keep offsets) */
  let s=src.replace(/\\begin\{(verbatim\*?|filecontents\*?|comment)\}[\s\S]*?\\end\{\1\}/g,m=>m.replace(/[^\n]/g,' '));
  s=s.replace(/\\verb\*?(.)([^\n]*?)\1/g,m=>' '.repeat(m.length));
  s=s.replace(/(^|[^\\])(%[^\n]*)/g,(m,a,b)=>a+' '.repeat(b.length));
  /* \X with X a non-letter is a single token (\$ \# \& \\ …) — blank them for the body scans,
     but keep \[ \] \( \) that really open and close math */
  const maskEsc=t=>{let o='';for(let i=0;i<t.length;i++){const c=t[i];
    if(c==='\\'&&i+1<t.length&&!/[A-Za-z@]/.test(t[i+1])){const n=t[i+1];
      if('[]()'.includes(n)&&t[i-1]!=='\\'){o+=c+n;}else o+='  ';i++;continue;}
    o+=c;}return o;};

  const dc=/\\documentclass\s*(\[[^\]]*\])?\s*\{([^}]*)\}/.exec(s);
  const bd=s.indexOf('\\begin{document}'), ed=s.indexOf('\\end{document}');
  if(!dc){
    add(0,'error','! LaTeX Error: Missing \\begin{document}.  (no \\documentclass found)',
      'A LaTeX file must start by saying what kind of document it is.',
      'Put \\documentclass{article} on the first line.');
  }else{
    const pre=s.slice(0,dc.index).trim();
    if(pre)add(s.indexOf(pre),'error','! LaTeX Error: \\usepackage before \\documentclass.',
      'Nothing may come before \\documentclass except comments.','Move \\documentclass to the very top.');
    if(!['article','report','book','letter','slides','proc','minimal'].includes(dc[2].trim()))
      add(dc.index,'error',`! LaTeX Error: File \`${dc[2].trim()}.cls' not found.`,
        `“${dc[2].trim()}” is not a document class that exists.`,'Standard classes: article, report, book, letter.');
  }
  if(bd<0)add(s.length,'error','! LaTeX Error: Missing \\begin{document}.',
    'The body of the document has to sit between \\begin{document} and \\end{document}.',
    'Add \\begin{document} after the preamble.');
  if(ed<0)add(s.length,'error','! Emergency stop.  *** (job aborted, no legal \\end found)',
    'LaTeX reached the end of the file without seeing \\end{document}.','Finish with \\end{document}.');
  else if(s.slice(ed+14).replace(/\s/g,''))
    add(ed+14+s.slice(ed+14).search(/\S/),'warning','(text after \\end{document} is ignored)',
      'Anything after \\end{document} is thrown away.','Move it above \\end{document}.');
  if(bd>=0){
    /* text in the preamble */
    const preamble=s.slice(dc?dc.index+dc[0].length:0,bd);
    const stray=preamble.replace(/\\[A-Za-z@]+\*?(?:\s*\[[^\]]*\]|\s*\{(?:[^{}]|\{(?:[^{}]|\{[^{}]*\})*\})*\})*/g,'')
                        .replace(/[\s{}\[\]]/g,'');
    if(stray)add((dc?dc.index+dc[0].length:0)+preamble.search(/[^\s\\{}\[\]]/),'error',
      '! LaTeX Error: Missing \\begin{document}.',
      'There is ordinary text in the preamble. Only commands like \\usepackage and \\title belong there.',
      'Move the text below \\begin{document}.');
  }

  /* braces */
  const st=[];
  for(let i=0;i<s.length;i++){
    const c=s[i];
    if(c==='\\'){i++;continue;}
    if(c==='{')st.push(i);
    else if(c==='}'){if(!st.length)add(i,'error','! Too many }\'s.',
      'There is a closing brace } with no opening { to match it.','Delete the extra } or add the missing {.');
      else st.pop();}
  }
  st.forEach(i=>add(i,'error','! Missing } inserted.  (a { is never closed)',
    'This { opens a group that is never closed, so everything after it is swallowed.','Add the matching }.'));

  /* environments */
  const es=[];const re=/\\(begin|end)\s*\{([^}]*)\}/g;let m;
  while((m=re.exec(s))){
    const env=m[2].trim();
    if(m[1]==='begin'){
      if(!ENVS.has(env))add(m.index,'error',`! LaTeX Error: Environment ${env} undefined.`,
        `There is no environment called “${env}”.`,'Check the spelling — e.g. itemize, enumerate, tabular, center.');
      es.push({env,i:m.index});
    }else{
      const top=es.pop();
      if(!top)add(m.index,'error',`! LaTeX Error: \\begin{document} ended by \\end{${env}}.`,
        `\\end{${env}} has no matching \\begin{${env}}.`,`Delete it, or add \\begin{${env}} above.`);
      else if(top.env!==env){
        add(m.index,'error',`! LaTeX Error: \\begin{${top.env}} on input line ${lineAt(src,top.i)} ended by \\end{${env}}.`,
          `You opened ${top.env} on line ${lineAt(src,top.i)} but closed ${env} here — environments must close in reverse order.`,
          `Close \\end{${top.env}} first.`);
        const k=es.findIndex(e=>e.env===env);if(k>=0)es.splice(k);
      }
    }
  }
  es.forEach(e=>{if(e.env!=='document')add(e.i,'error',
    `! LaTeX Error: \\begin{${e.env}} on input line ${lineAt(src,e.i)} ended by \\end{document}.`,
    `\\begin{${e.env}} is never closed.`,`Add \\end{${e.env}} where it should stop.`);});

  /* body-level checks */
  if(bd>=0){
    const body=maskEsc(s.slice(bd,ed<0?s.length:ed));const off=bd;
    /* environment context at each offset, for &, \item, \hline */
    const ctx=[];const rx=/\\(begin|end)\s*\{([^}]*)\}|\\item\b|\\hline\b|\\cline\b|&|\$\$|\$|\\\[|\\\]|\\\(|\\\)|[_^#]/g;
    let math=null,mathAt=0;
    while((m=rx.exec(body))){
      const t=m[0],i=off+m.index;
      if(m[1]==='begin'){ctx.push(m[2].trim());if(/^(equation|eqnarray|displaymath|math|array)\*?$/.test(m[2].trim()))math=m[2];continue;}
      if(m[1]==='end'){const e=m[2].trim();const k=ctx.lastIndexOf(e);if(k>=0)ctx.splice(k);if(math===m[2])math=null;continue;}
      if(t==='$$'||t==='$'||t==='\\['||t==='\\]'||t==='\\('||t==='\\)'){
        if(t==='$'||t==='$$'){if(math===t)math=null;else if(!math){math=t;mathAt=i;}}
        else if(t==='\\['||t==='\\('){if(!math){math=t;mathAt=i;}}
        else if(math===(t==='\\]'?'\\[':'\\('))math=null;
        continue;}
      const inTab=ctx.some(e=>/^(tabular\*?|array|eqnarray\*?|tabbing)$/.test(e));
      if(t==='&'&&!inTab&&!math)add(i,'error','! Misplaced alignment tab character &.',
        'A bare & is the column separator of a table. In ordinary text it must be written \\&.','Write \\& for an ampersand.');
      if(t==='\\item'&&!ctx.some(e=>LISTS.has(e)))add(i,'error','! LaTeX Error: Lonely \\item--perhaps a missing list environment.',
        '\\item only makes sense inside itemize, enumerate or description.','Wrap the items in \\begin{itemize} … \\end{itemize}.');
      if((t==='\\hline'||t==='\\cline')&&!inTab)add(i,'error','! Misplaced \\noalign.',
        `${t} draws a rule between rows of a tabular — it cannot be used outside one.`,'Use it inside \\begin{tabular}…\\end{tabular}.');
      if((t==='_'||t==='^')&&!math)add(i,'error','! Missing $ inserted.',
        `${t} means sub/superscript, which only exists in math mode.`,`Put it in math ($x${t}2$) or write \\${t==='_'?'_':'textasciicircum{}'} for the character.`);
      if(t==='#'&&!math)add(i,'error','! You can\'t use `macro parameter character #\' in horizontal mode.',
        '# is reserved for command definitions. In text it must be escaped.','Write \\# for a hash sign.');
    }
    if(math)add(mathAt,'error','! Missing $ inserted.  (math is never closed)',
      `Math opened with ${math} is never closed.`,`Close it with the matching ${math==='\\['?'\\]':math==='\\('?'\\)':math}.`);
    /* a paragraph break inside inline math */
    body.replace(/\$([^$]*?)\$/g,(mm,inner,k)=>{if(/\n\s*\n/.test(inner))add(off+k,'error','! Missing $ inserted.',
      'A blank line ends the paragraph, and a paragraph may not end inside math.','Close the $ before the blank line.');return mm;});
  }

  /* commands */
  const pk=new Set();(s.match(/\\usepackage\s*(\[[^\]]*\])?\s*\{([^}]*)\}/g)||[]).forEach(u=>
    u.replace(/\{([^}]*)\}/,(a,b)=>b.split(',').forEach(p=>pk.add(p.trim()))));
  const user=new Set();(s.match(/\\(?:re)?newcommand\*?\s*\{?\\([A-Za-z@]+)/g)||[]).forEach(u=>user.add(u.replace(/.*\\/,'')));
  (s.match(/\\providecommand\*?\s*\{?\\([A-Za-z@]+)/g)||[]).forEach(u=>user.add(u.replace(/.*\\/,'')));
  (s.match(/\\def\s*\\([A-Za-z@]+)/g)||[]).forEach(u=>user.add(u.replace(/.*\\/,'')));
  const cre=/\\([A-Za-z@]+)\*?/g;
  while((m=cre.exec(s))){
    const c=m[1];if(KNOWN.has(c)||user.has(c))continue;
    add(m.index,'error','! Undefined control sequence.  \\'+c,
      `\\${c} is not a command LaTeX knows.`,
      suggest(c)?`Did you mean \\${suggest(c)}?`:'Check the spelling, or \\usepackage the package that defines it.');
  }
  for(const c in NEEDS){
    const i=s.search(new RegExp('\\\\'+c+'(?![A-Za-z])'));
    if(i<0)continue;
    const p=NEEDS[c].split(' ')[0];
    if(!pk.has(p)&&!(c==='url'&&pk.has('hyperref')))add(i,'error','! Undefined control sequence.  \\'+c,
      `\\${c} is not built in — it comes from the ${NEEDS[c]} package.`,`Add \\usepackage{${p}} to the preamble.`);
  }
  if(/\\index\s*\{/.test(s)&&!/\\makeindex/.test(s))add(s.search(/\\index\s*\{/),'warning',
    '(no .idx file written — \\makeindex is missing)','Without \\makeindex in the preamble, \\index entries are silently thrown away.',
    'Add \\usepackage{makeidx} and \\makeindex to the preamble.');
  if(/\\makeindex/.test(s)&&!pk.has('makeidx')&&/\\printindex/.test(s)===false){}
  if(/\\caption\s*\{/.test(s)){
    s.replace(/\\caption\s*\{/g,(mm,k)=>{
      const before=s.slice(0,k),o=(before.match(/\\begin\{(table|figure)\*?\}/g)||[]).length,c=(before.match(/\\end\{(table|figure)\*?\}/g)||[]).length;
      if(o<=c)add(k,'error','! LaTeX Error: \\caption outside float.','\\caption only works inside a table or figure environment.',
        'Wrap the tabular in \\begin{table} … \\end{table} and put \\caption inside.');return mm;});
  }
  /* citations and references resolve? */
  const keys=new Set();
  (s.match(/\\bibitem\s*(\[[^\]]*\])?\s*\{([^}]*)\}/g)||[]).forEach(b=>keys.add(b.replace(/.*\{([^}]*)\}$/,'$1').trim()));
  const bibs=collectBib(src,files);bibs.forEach(b=>Object.keys(b.entries).forEach(k=>keys.add(k)));
  const hasBib=/\\bibliography\s*\{/.test(s)||/\\begin\{thebibliography\}/.test(s);
  s.replace(/\\(no)?cite\s*(\[[^\]]*\])?\s*\{([^}]*)\}/g,(mm,no,o,ks,k)=>{
    ks.split(',').map(x=>x.trim()).filter(Boolean).forEach(key=>{
      if(key==='*')return;
      if(!keys.has(key))add(k,'warning',`LaTeX Warning: Citation \`${key}' on page 1 undefined.`,
        hasBib?`No reference with the key “${key}” exists${bibs.length?' in the .bib file':''}.`:'You cite a source, but there is no bibliography to cite from.',
        hasBib?'Check the key spelling — keys are case-sensitive.':'Add a thebibliography environment, or \\bibliography{file} with a .bib.');});
    return mm;});
  if(/\\bibliography\s*\{/.test(s)&&!/\\bibliographystyle\s*\{/.test(s))
    add(s.search(/\\bibliography\s*\{/),'error','BibTeX: I found no \\bibstyle command---while reading file document.aux',
      'BibTeX needs to be told how to format the list.','Add \\bibliographystyle{plain} just before \\bibliography.');
  if(/\\bibliography\s*\{/.test(s)){
    const nm=/\\bibliography\s*\{([^}]*)\}/.exec(s)[1].split(',')[0].trim();
    if(!bibs.some(b=>b.name===nm||b.name===nm+'.bib'))add(s.search(/\\bibliography\s*\{/),'error',
      `BibTeX: I couldn't open database file ${nm}.bib`,`There is no file called ${nm}.bib.`,
      'Add it in the refs.bib tab, or name it in \\bibliography{} without the .bib extension.');
  }
  const labels=new Set();(s.match(/\\label\s*\{([^}]*)\}/g)||[]).forEach(l=>labels.add(l.replace(/.*\{([^}]*)\}$/,'$1').trim()));
  s.replace(/\\(page)?ref\s*\{([^}]*)\}/g,(mm,p,key,k)=>{if(!labels.has(key.trim()))add(k,'warning',
    `LaTeX Warning: Reference \`${key.trim()}' on page 1 undefined.`,`Nothing has \\label{${key.trim()}}, so this prints “??”.`,
    'Check the label name, or add \\label{…} right after the thing you want to refer to.');return mm;});

  /* tabular column counts */
  lintTables(src,s,add);
  out.sort((a,b)=>a.line-b.line||(a.sev==='error'?-1:1));
  /* one finding per line and kind is plenty */
  const seen=new Set();return out.filter(f=>{const k=f.line+'|'+f.tex;if(seen.has(k))return false;seen.add(k);return true;});
}
function suggest(c){
  const cands=[...KNOWN];let best=null,bd=3;
  for(const k of cands){const d=lev(c,k);if(d<bd){bd=d;best=k;}}
  return bd<=2&&c.length>2?best:null;
}
function lev(a,b){if(Math.abs(a.length-b.length)>2)return 9;
  const d=Array.from({length:a.length+1},(_,i)=>[i]);for(let j=1;j<=b.length;j++)d[0][j]=j;
  for(let i=1;i<=a.length;i++)for(let j=1;j<=b.length;j++)
    d[i][j]=Math.min(d[i-1][j]+1,d[i][j-1]+1,d[i-1][j-1]+(a[i-1]===b[j-1]?0:1));
  return d[a.length][b.length];}
function lintTables(src,s,add){
  const re=/\\begin\{tabular\}/g;let m;
  while((m=re.exec(s))){
    const a=group(s,s.indexOf('{',m.index+15));
    if(!a||/^\s*$/.test(a.text)){add(m.index,'error','! Missing # inserted in alignment preamble.',
      'A tabular needs a column specification, e.g. {|l|c|r|}.','Write \\begin{tabular}{lcr} — one letter per column.');continue;}
    let cols;try{cols=parseSpec(a.text).filter(c=>c.kind==='col').length;}
    catch(e){add(m.index,'error','! LaTeX Error: Illegal character in array arg.',e.message,'Use only l, c, r, p{width} and | in the column spec.');continue;}
    const e=findEnd(s,'tabular',a.end);if(!e)continue;
    const body=s.slice(a.end,e.start);
    let off=a.end;
    splitTop(body,'\\\\').forEach(row=>{
      const clean=row.replace(/\\hline|\\cline\s*\{[^}]*\}/g,'');
      if(clean.trim()){
        let n=0;splitTop(clean,'&').forEach(cell=>{const mc=/\\multicolumn\s*\{(\d+)\}/.exec(cell);n+=mc?+mc[1]:1;});
        if(n>cols){const k=off+row.indexOf('&');
          add(k>off?k:off,'error','! Extra alignment tab has been changed to \\cr.',
            `This row has ${n} cells but the column spec only declares ${cols}.`,`Remove an &, or add a column to the spec.`);}
      }
      off+=row.length+2;
    });
  }
}

/* ═══════════════════════════ BibTeX emulator ═══════════════════════════ */
function parseBib(text,name){
  const entries={},errors=[];const re=/@(\w+)\s*\{/g;let m;
  while((m=re.exec(text))){
    const type=m[1].toLowerCase();if(type==='comment'||type==='preamble'||type==='string')continue;
    const g=group(text,m.index+m[0].length-1);
    if(!g){errors.push({line:lineAt(text,m.index),msg:'I was expecting a `}\' — this entry is never closed'});break;}
    const body=g.text,comma=body.indexOf(',');
    if(comma<0){errors.push({line:lineAt(text,m.index),msg:'I was expecting a `,\' after the entry key'});continue;}
    const key=body.slice(0,comma).trim(),fields={};
    let i=comma+1;
    while(i<body.length){
      const fm=/^\s*([A-Za-z][\w-]*)\s*=\s*/.exec(body.slice(i));if(!fm)break;
      i+=fm[0].length;let val='';
      if(body[i]==='{'){const gg=group(body,i);if(!gg)break;val=gg.text;i=gg.end;}
      else if(body[i]==='"'){let d=0,k=i+1;for(;k<body.length;k++){const c=body[k];if(c==='\\'){k++;continue;}
        if(c==='{')d++;else if(c==='}')d--;else if(c==='"'&&d===0)break;}val=body.slice(i+1,k);i=k+1;}
      else{const vm=/^[^,}\s]+/.exec(body.slice(i));val=vm?vm[0]:'';i+=val.length;}
      fields[fm[1].toLowerCase()]=val.replace(/\s+/g,' ').trim();
      const cm=/^\s*(,?)/.exec(body.slice(i));
      if(!cm[1]&&body.slice(i+cm[0].length).trim()){
        errors.push({line:lineAt(text,m.index+m[0].length+i+cm[0].length),msg:`I was expecting a \`,' or a \`}' — a comma is missing after the ${fm[1]} field`});}
      i+=cm[0].length;
    }
    if(entries[key])errors.push({line:lineAt(text,m.index),msg:`Repeated entry---the key “${key}” is used twice`});
    ['author','editor'].forEach(fk=>{const v=fields[fk];if(!v||/\band\b/.test(v))return;
      const parts=v.split(',');if(parts.length>=2&&parts[0].trim().split(/\s+/).length>=2&&parts[1].trim().split(/\s+/).length>=1)
        errors.push({line:lineAt(text,m.index),warn:true,msg:`“${v}” reads as ONE name to BibTeX — separate people with “and”, not a comma`});});
    entries[key]={type,key,fields};
  }
  return {name,entries,errors};
}
function collectBib(src,files){
  const out=[];
  (files||[]).forEach(f=>{if(/\.bib$/i.test(f.name))out.push(parseBib(f.text,f.name));});
  src.replace(/\\begin\{filecontents\*?\}\s*(\[[^\]]*\])?\s*\{([^}]*)\}([\s\S]*?)\\end\{filecontents\*?\}/g,
    (m,o,n,t)=>{if(/\.bib$/i.test(n.trim()))out.push(parseBib(t,n.trim()));return m;});
  return out;
}
/* names: "Knuth, Donald E." | "Donald E. Knuth" | "Ludwig van Beethoven" */
function splitNames(a){return (a||'').split(/\s+and\s+/i).map(x=>x.trim()).filter(Boolean);}
function nameParts(n){
  if(/^others$/i.test(n))return {first:'',last:'others',von:''};
  n=n.replace(/[{}]/g,'');
  if(n.includes(',')){const [l,f]=n.split(',').map(x=>x.trim());const v=/^((?:[a-z]\S*\s+)*)(.*)$/.exec(l);return {first:f||'',last:v[2],von:v[1].trim()};}
  const w=n.split(/\s+/);if(w.length===1)return {first:'',last:w[0],von:''};
  let k=w.findIndex((x,i)=>i>0&&/^[a-z]/.test(x));if(k<0)k=w.length-1;
  const first=w.slice(0,k).join(' '),rest=w.slice(k);
  const vn=[];while(rest.length>1&&/^[a-z]/.test(rest[0]))vn.push(rest.shift());
  return {first,last:rest.join(' '),von:vn.join(' ')};
}
const initials=f=>f.split(/[\s~]+/).filter(Boolean).map(x=>x.split('-').map(y=>y[0]+'.').join('-')).join('~');
function fmtNames(a,abbrv){
  const ns=splitNames(a).map(nameParts).map(p=>p.last==='others'?'et~al.':
    ((abbrv?initials(p.first):p.first)+(p.first?' ':'')+(p.von?p.von+' ':'')+p.last).trim());
  if(ns.length<=1)return ns.join('');
  if(ns.length===2)return ns[1]==='et~al.'?ns[0]+' et~al.':ns.join(' and ');
  return ns.slice(0,-1).join(', ')+', and '+ns[ns.length-1];
}
function sortKey(e){const f=e.fields;const a=splitNames(f.author||f.editor||'').map(nameParts);
  return ((a.map(p=>p.last+' '+p.first).join(' ')||f.key||e.key)+' '+(f.year||'')+' '+(f.title||'')).toLowerCase().replace(/[{}\\]/g,'');}
function alphaLabel(e){
  const a=splitNames(e.fields.author||e.fields.editor||'').map(nameParts);
  const yr=(e.fields.year||'').slice(-2);
  let l=!a.length?e.key.slice(0,3):a.length===1?a[0].last.replace(/[{}\\]/g,'').slice(0,3):
    a.slice(0,3).map(p=>p.last.replace(/[{}\\]/g,'')[0]).join('')+(a.length>3?'+':'');
  return l+yr;
}
function fmtEntry(e,style){
  const f=e.fields,ab=style==='abbrv',B=[],add=x=>{if(x)B.push(x);};
  const au=f.author?fmtNames(f.author,ab):'';
  const ed=f.editor?fmtNames(f.editor,ab)+(splitNames(f.editor).length>1?', editors':', editor'):'';
  const T=f.title||'';
  const pages=f.pages?(/[-–]/.test(f.pages)?'pages ':'page ')+f.pages.replace(/\s*-+\s*/,'--'):'';
  const vol=f.volume?(f.number?`${f.volume}(${f.number})`:f.volume)+(f.pages?':'+f.pages.replace(/\s*-+\s*/,'--'):''):'';
  const date=[f.month,f.year].filter(Boolean).join(' ');
  switch(e.type){
    case 'article':add(au);add(T);add(['\\emph{'+(f.journal||'')+'}',vol||pages,date].filter(Boolean).join(', '));break;
    case 'book':add(au||ed);add('\\emph{'+T+'}');add([f.publisher,f.address,f.edition?f.edition+' edition':'',date].filter(Boolean).join(', '));break;
    case 'inproceedings':case 'conference':case 'incollection':
      add(au);add(T);add(['In '+(ed?ed+', ':'')+'\\emph{'+(f.booktitle||'')+'}',pages,f.address,date].filter(Boolean).join(', '));add(f.publisher);break;
    case 'phdthesis':add(au);add('\\emph{'+T+'}');add(['PhD thesis',f.school,f.address,date].filter(Boolean).join(', '));break;
    case 'mastersthesis':add(au);add(T);add(['Master\'s thesis',f.school,f.address,date].filter(Boolean).join(', '));break;
    case 'techreport':add(au);add(T);add([(f.type||'Technical Report')+(f.number?' '+f.number:''),f.institution,f.address,date].filter(Boolean).join(', '));break;
    case 'manual':add(au||f.organization);add('\\emph{'+T+'}');add([au?f.organization:'',f.address,f.edition?f.edition+' edition':'',date].filter(Boolean).join(', '));break;
    case 'unpublished':add(au);add(T);add([f.note,date].filter(Boolean).join(', '));f.note='';break;
    default:add(au);add(T);add([f.howpublished,f.url?'\\url{'+f.url+'}':'',date].filter(Boolean).join(', '));
  }
  add(f.note);
  return B.map(x=>x.replace(/\s+/g,' ').trim()).filter(Boolean).join('. ').replace(/\.\./g,'.')+'.';
}

/* ═══════════════════════ inline renderer (via latex.js) ═══════════════════════ */
const inlineCache=new Map();
function renderInline(tex){
  if(!tex||!tex.trim())return '';
  if(inlineCache.has(tex))return inlineCache.get(tex);
  let html;
  try{
    const g=new latexjs.HtmlGenerator({hyphenate:false});
    latexjs.parse('\\documentclass{article}\\begin{document}'+tex+'\\end{document}',{generator:g});
    const d=document.createElement('div');d.appendChild(g.domFragment());
    const ps=d.querySelectorAll('.body p');
    html=ps.length===1?ps[0].innerHTML:(d.querySelector('.body')||d).innerHTML;
  }catch(e){html='<span class="lx-raw">'+esc(tex)+'</span>';}
  if(inlineCache.size>800)inlineCache.clear();
  inlineCache.set(tex,html);return html;
}

/* ═════════════════════════ column specs & tables ═════════════════════════ */
function parseSpec(spec){
  const cols=[];let i=0;const s=spec.replace(/\s+/g,'');
  while(i<s.length){
    const c=s[i];
    if('lcr'.includes(c)){cols.push({kind:'col',al:c});i++;}
    else if('pmb'.includes(c)){const g=group(s,i+1);if(!g)throw new Error(`p, m and b need a width in braces, e.g. p{3cm}.`);
      cols.push({kind:'col',al:'p',w:cssLen(g.text)||'8em',v:c});i=g.end;}
    else if(c==='|'){cols.push({kind:'bar'});i++;}
    else if(c==='@'||c==='!'){const g=group(s,i+1);if(!g)throw new Error(`${c} needs its text in braces, e.g. @{.}.`);
      cols.push({kind:'at',tex:g.text,bang:c==='!'});i=g.end;}
    else if(c==='*'){const n=group(s,i+1),r=n&&group(s,n.end);if(!r)throw new Error('*{n}{spec} needs two groups.');
      const inner=parseSpec(r.text);for(let k=0;k<+n.text;k++)cols.push(...inner.map(x=>Object.assign({},x)));i=r.end;}
    else if(c==='>'||c==='<'){const g=group(s,i+1);if(!g)throw new Error(`${c}{…} needs a group.`);i=g.end;}
    else throw new Error(`“${c}” is not a legal column type — use l, c, r, p{…}, | or @{…}.`);
  }
  return cols;
}
function renderTabular(spec,body,opts,ctx){
  const cols=parseSpec(spec);
  const real=cols.filter(c=>c.kind==='col');
  /* layout: each real column, with |-counts and @-text either side */
  const layout=[];let barsL=0,pend=[];
  cols.forEach(c=>{
    if(c.kind==='bar'){if(layout.length&&!pend.length)layout[layout.length-1].barR++;else barsL++;}
    else if(c.kind==='at'){pend.push(c);if(layout.length)layout[layout.length-1].noPadR=true;}
    else{layout.push(Object.assign({},c,{barL:barsL,barR:0,atL:pend}));barsL=0;pend=[];}
  });
  if(layout.length&&pend.length)layout[layout.length-1].atR=pend;
  if(layout.length&&barsL)layout[layout.length-1].barR+=barsL;
  const stretch=ctx.arraystretch||1,sep=ctx.tabcolsep||'6px';
  const rows=[];let pendingTop=0,pendingCl=[];
  const raw=splitTop(body,'\\\\');
  raw.forEach((row,ri)=>{
    let r=row.replace(/^\s*\[[^\]]*\]/,'');
    let mm;
    while((mm=/^\s*(\\hline|\\cline\s*\{(\d+)-(\d+)\})/.exec(r))){
      if(mm[1]==='\\hline')pendingTop++;else pendingCl.push([+mm[2],+mm[3]]);
      r=r.slice(mm[0].length);}
    if(!r.trim()&&ri===raw.length-1){if(rows.length){rows[rows.length-1].bottom=pendingTop;rows[rows.length-1].clBottom=pendingCl;}return;}
    if(!r.trim()&&!pendingTop&&!pendingCl.length)return;
    rows.push({cells:splitTop(r,'&'),top:pendingTop,cl:pendingCl,bottom:0,clBottom:[]});
    pendingTop=0;pendingCl=[];
  });
  if(pendingTop&&rows.length){rows[rows.length-1].bottom=pendingTop;rows[rows.length-1].clBottom=pendingCl;}
  const bord=n=>n?(n>1?'3px double':'1px solid')+' var(--lxrule)':'';
  let html=`<table class="lx-tab" style="--lxpad:${sep};--lxstr:${stretch}"><tbody>`;
  rows.forEach(r=>{
    html+='<tr>';let ci=0;
    r.cells.forEach(cell=>{
      let span=1,al=null,content=cell,cspec=null;
      const mc=/^\s*\\multicolumn\s*\{(\d+)\}\s*\{([^}]*)\}\s*/.exec(cell);
      if(mc){span=+mc[1];const g=group(cell,cell.indexOf('{',mc.index+mc[0].length-1));
        try{cspec=parseSpec(mc[2]);}catch(e){cspec=[{kind:'col',al:'c'}];}
        content=g?g.text:'';}
      const L=layout[ci]||{al:'l',barL:0,barR:0},Rl=layout[Math.min(ci+span-1,layout.length-1)]||L;
      const colC=cspec?cspec.find(c=>c.kind==='col')||{al:'c'}:L;
      const bl=cspec?cspec.findIndex(c=>c.kind==='col')>0&&cspec[0].kind==='bar'?1:0:L.barL;
      const br=cspec?(cspec[cspec.length-1].kind==='bar'?1:0):Rl.barR;
      al=colC.al==='p'?'p':colC.al;
      const st=[];
      if(bl)st.push('border-left:'+bord(bl));if(br)st.push('border-right:'+bord(br));
      const inCl=(list)=>list.some(([a,b])=>ci+1>=a&&ci+1<=b);
      if(r.top||inCl(r.cl))st.push('border-top:'+bord(r.top||1));
      if(r.bottom||inCl(r.clBottom))st.push('border-bottom:'+bord(r.bottom||1));
      if(al==='p'&&colC.w)st.push('width:'+colC.w+';min-width:'+colC.w);
      const atL=(!cspec&&L.atL&&L.atL.length)?L.atL.map(a=>renderInline(a.tex)).join(''):'';
      const atR=(!cspec&&Rl.atR&&Rl.atR.length)?Rl.atR.map(a=>renderInline(a.tex)).join(''):'';
      const noPadL=!cspec&&L.atL&&L.atL.length,noPadR=!cspec&&Rl.atR&&Rl.atR.length;
      if(noPadL)st.push('padding-left:0');if(noPadR||(!cspec&&Rl.noPadR))st.push('padding-right:0');
      const txt=renderInline(content.trim());
      html+=`<td class="al-${al}"${span>1?` colspan="${span}"`:''} style="${st.join(';')}">${atL}${txt}${atR}</td>`;
      ci+=span;
    });
    html+='</tr>';
  });
  html+='</tbody></table>';
  return html;
}
/* tabbing: \= sets a stop, \> jumps to the next, \kill prints nothing, \+ \- indent */
function renderTabbing(body){
  const lines=[];
  splitTop(body,'\\\\').forEach(l=>{const parts=l.split(/\\kill(?![A-Za-z])/);
    parts.forEach((p,i)=>lines.push(i<parts.length-1?p+'\\kill':p));});
  let stops=0,indent=0;const rows=[];
  lines.forEach(l=>{
    let t=l.trim();if(!t)return;
    const kill=/\\kill\s*$/.test(t);t=t.replace(/\\kill\s*$/,'');
    while(/^\\[+-]/.test(t)){indent+=t[1]==='+'?1:-1;t=t.slice(2).trim();}
    const parts=t.split(/\\[=>]/),nst=(t.match(/\\=/g)||[]).length;
    if(nst)stops=Math.max(stops,nst+1);
    rows.push({parts,kill,indent:Math.max(0,indent)});
  });
  const n=Math.max(stops,...rows.map(r=>r.parts.length+r.indent),1);
  let h=`<div class="lx-tabbing" style="grid-template-columns:repeat(${n},max-content)">`;
  rows.forEach(r=>{
    const cells=[];for(let k=0;k<r.indent;k++)cells.push('');
    r.parts.forEach(p=>cells.push(renderInline(p.trim())));
    while(cells.length<n)cells.push('');
    h+=cells.map(c=>`<span class="${r.kill?'kill':''}">${c||'&nbsp;'}</span>`).join('');
  });
  return h+'</div>';
}

/* ═════════════════════════════ COMPILE ═════════════════════════════ */
/* src + extra files → {html, cls, errors, emulated:[…], stats} */
function compile(src,files){
  const findings=lint(src,files);
  const errors=findings.filter(f=>f.sev==='error');
  const emulated=new Set(),notes=[];
  const PH=[];                                // placeholder payloads
  const ph=(html,block)=>{PH.push({html,block});const id='LXQZ'+(PH.length-1)+'Q';return block?'\\par '+id+'\\par ':id;};
  let s=src;
  const cls=((/\\documentclass\s*(?:\[[^\]]*\])?\s*\{([^}]*)\}/.exec(s)||[])[1]||'article').trim();
  const isBook=cls==='book'||cls==='report';

  /* 1 ─ verbatim first: nothing inside is TeX */
  s=s.replace(/\\begin\{verbatim(\*?)\}\n?([\s\S]*?)\\end\{verbatim\*?\}/g,(m,star,body)=>{
    emulated.add('verbatim');
    const t=star?esc(body).replace(/ /g,'<span class="vsp">␣</span>'):esc(body);
    return ph(`<pre class="lx-verb">${t.replace(/\n$/,'')}</pre>`,true)+pad(m);});
  s=s.replace(/\\verb(\*?)([^A-Za-z\s*])([^\n]*?)\2/g,(m,star,d,body)=>{
    emulated.add('\\verb');
    return ph(`<code class="lx-verbi">${star?esc(body).replace(/ /g,'␣'):esc(body)}</code>`);});
  /* 2 ─ filecontents (a .bib written from inside the document) */
  s=s.replace(/\\begin\{filecontents\*?\}[\s\S]*?\\end\{filecontents\*?\}/g,m=>pad(m));
  /* 3 ─ comments (keep line breaks) */
  s=s.replace(/(^|[^\\])%[^\n]*/g,'$1');
  if(cls==='letter'){emulated.add('letter class');s=s.replace(/\\documentclass(\s*\[[^\]]*\])?\s*\{letter\}/,'\\documentclass$1{article}');}

  /* 4 ─ user macros: record, delete, then expand everywhere */
  const macros={},settings={};
  const defRe=/\\(newcommand|renewcommand|providecommand)\*?\s*(\{\\([A-Za-z@]+)\}|\\([A-Za-z@]+))\s*(\[(\d)\])?\s*(\[([^\]]*)\])?\s*/g;
  let m,guard=0;
  while((m=defRe.exec(s))&&guard++<400){
    const name=m[3]||m[4],body=group(s,m.index+m[0].length);if(!body)continue;
    const whole=s.slice(m.index,body.end);
    const setting=/^(labelitem[iv]+|labelenum[iv]+|theenum[iv]+|contentsname|refname|bibname|abstractname|indexname|listtablename|listfigurename|tablename|figurename|arraystretch)$/.test(name);
    if(setting)settings[name]=body.text;
    else if(!(m[1]==='providecommand'&&macros[name]))macros[name]={n:+(m[6]||0),def:m[8],body:body.text};
    s=s.slice(0,m.index)+pad(whole)+s.slice(body.end);defRe.lastIndex=m.index;
  }
  s=s.replace(/\\def\s*\\([A-Za-z@]+)\s*\{/g,(mm,name,k)=>{const b=group(s,k+mm.length-1);
    if(b){macros[name]={n:0,body:b.text};}return mm;});
  if(Object.keys(macros).length){emulated.add('\\newcommand');s=expand(s,macros);}
  /* old two-letter font switches → their modern declarations */
  s=s.replace(/\\(bf|it|tt|sf|sc|sl|rm)(?![A-Za-z])/g,(mm,k)=>'\\'+{bf:'bfseries',it:'itshape',tt:'ttfamily',sf:'sffamily',sc:'scshape',sl:'slshape',rm:'rmfamily'}[k]);

  /* 5 ─ preamble: things latex.js would choke on */
  const pkgs=[];(s.match(/\\usepackage\s*(\[[^\]]*\])?\s*\{([^}]*)\}/g)||[]).forEach(u=>u.replace(/\{([^}]*)\}/,(a,b)=>b.split(',').forEach(p=>pkgs.push(p.trim()))));
  const hasIndex=/\\makeindex/.test(s);
  s=s.replace(/\\(makeindex|nofiles)(?![A-Za-z])/g,'');
  s=s.replace(/\\(pagenumbering|pagestyle|thispagestyle|markright|bibliographystyle|hyphenation|linespread)\s*\{[^}]*\}/g,(mm,c)=>{
    if(c==='bibliographystyle')settings.bibstyle=/\{([^}]*)\}/.exec(mm)[1].trim();
    else if(c!=='hyphenation')notes.push('\\'+c+' only affects real pages — see the Real PDF tab');
    return '';});
  s=s.replace(/\\markboth\s*\{[^}]*\}\s*\{[^}]*\}/g,'');
  s=s.replace(/\\(setlength|addtolength)\s*\{?\\(parindent|parskip|tabcolsep|textwidth|oddsidemargin|evensidemargin|topmargin|textheight|baselineskip|headheight|headsep|footskip|marginparwidth)\}?\s*\{([^}]*)\}/g,
    (mm,c,v,len)=>{settings[v]=len;return '';});
  s=s.replace(/\\(addcontentsline)\s*\{[^}]*\}\s*\{[^}]*\}\s*\{[^}]*\}/g,()=>{notes.push('\\addcontentsline is not shown in the live table of contents');return '';});
  s=s.replace(/\\addtocontents\s*\{[^}]*\}\s*\{[^}]*\}/g,'');
  s=s.replace(/\\usepackage\s*(\[[^\]]*\])?\s*\{[^}]*\}/g,'');   // latex.js ignores unknown ones anyway
  s=s.replace(/\\(clearpage|cleardoublepage)(?![A-Za-z])/g,'\\newpage');

  /* 6 ─ counters for floats/equations and a section walk for \index */
  let tabN=0,figN=0,eqN=0,fnN=0;const floatLabels={};const fns=[];
  const secNum=mkSectionCounter(isBook);

  /* 7 ─ bibliography sources */
  const bibFiles=collectBib(src,files);
  const allEntries={};bibFiles.forEach(b=>Object.assign(allEntries,b.entries));
  const citeOrder=[];s.replace(/\\(?:no)?cite\s*(?:\[[^\]]*\])?\s*\{([^}]*)\}/g,(mm,ks)=>{ks.split(',').forEach(k=>{k=k.trim();if(k&&!citeOrder.includes(k))citeOrder.push(k);});return mm;});
  const manual={};                             // thebibliography keys → labels
  const tb=/\\begin\{thebibliography\}/.exec(s);
  if(tb){let n=0;s.slice(tb.index).replace(/\\bibitem\s*(\[([^\]]*)\])?\s*\{([^}]*)\}/g,(mm,o,lab,k)=>{n++;manual[k.trim()]=lab||String(n);return mm;});}
  const bibStyle=settings.bibstyle||'plain';
  let bibList=[];                              // for \bibliography{…}
  if(/\\bibliography\s*\{/.test(s)){
    emulated.add('BibTeX');
    const all=citeOrder.includes('*');
    let keys=all?Object.keys(allEntries):citeOrder.filter(k=>allEntries[k]);
    if(all)keys=Object.keys(allEntries);
    let list=keys.map(k=>allEntries[k]);
    if(bibStyle!=='unsrt')list.sort((a,b)=>sortKey(a)<sortKey(b)?-1:1);
    bibList=list.map((e,i)=>({key:e.key,label:bibStyle==='alpha'?alphaLabel(e):String(i+1),text:fmtEntry(e,bibStyle)}));
  }
  const bibLabel=k=>manual[k]||(bibList.find(b=>b.key===k)||{}).label;

  /* 8 ─ floats (table/figure) with caption and label */
  s=s.replace(/\\begin\{(table|figure)(\*?)\}\s*(\[[^\]]*\])?([\s\S]*?)\\end\{\1\2\}/g,(mm,kind,star,place,inner)=>{
    emulated.add(kind+' float');
    const n=kind==='table'?++tabN:++figN;
    const cap=/\\caption\s*(\[[^\]]*\])?\s*\{/.exec(inner);
    let capText='',capFirst=false;
    if(cap){const g=group(inner,cap.index+cap[0].length-1);capText=g?g.text:'';
      capFirst=inner.slice(0,cap.index).replace(/\\centering|\\label\s*\{[^}]*\}|\s/g,'')==='';}
    (inner.match(/\\label\s*\{([^}]*)\}/g)||[]).forEach(l=>floatLabels[l.replace(/.*\{([^}]*)\}$/,'$1').trim()]=String(n));
    let body=inner.replace(/\\caption\s*(\[[^\]]*\])?\s*\{/,'\\LXCAP{').replace(/\\label\s*\{[^}]*\}/g,'');
    if(cap){const k=body.indexOf('\\LXCAP{'),g=group(body,k+6);body=body.slice(0,k)+body.slice(g.end);}
    const center=/\\centering|\\begin\{center\}/.test(body);
    body=body.replace(/\\centering/g,'').replace(/\\begin\{center\}|\\end\{center\}/g,'');
    const inside=renderFloatBody(body,settings,emulated);
    const name=kind==='table'?(settings.tablename||'Table'):(settings.figurename||'Figure');
    const capHTML=cap?`<div class="lx-cap"><b>${esc(name)} ${n}:</b> ${renderInline(capText)}</div>`:'';
    return ph(`<div class="lx-float${center?' c':''}" data-kind="${kind}">${capFirst?capHTML:''}${inside}${capFirst?'':capHTML}</div>`,true)+pad(mm);
  });
  /* standalone tabular / tabbing */
  s=replaceEnv(s,'tabular',(spec,body,whole)=>{emulated.add('tabular');
    let html;try{html=renderTabular(spec,body,{},settingsCtx(settings));}catch(e){html=`<span class="lx-raw">${esc(e.message)}</span>`;}
    return ph(`<div class="lx-tabwrap">${html}</div>`,true)+pad(whole);},true);
  s=s.replace(/\\begin\{tabbing\}([\s\S]*?)\\end\{tabbing\}/g,(mm,body)=>{emulated.add('tabbing');
    return ph(renderTabbing(body),true)+pad(mm);});
  /* equations (Module III comes later — just enough to not break) */
  s=s.replace(/\\begin\{equation(\*?)\}([\s\S]*?)\\end\{equation\*?\}/g,(mm,star,body)=>{
    emulated.add('equation');const t=star?'':'\\tag{'+(++eqN)+'}';
    return '\\['+body.replace(/\\label\s*\{[^}]*\}/g,'')+t+'\\]'+pad(mm).slice(0,Math.max(0,nl(mm)-nl(body)));});
  s=s.replace(/\\begin\{(eqnarray|displaymath)(\*?)\}([\s\S]*?)\\end\{\1\*?\}/g,(mm,e,star,body)=>{
    emulated.add(e);return '\\[\\begin{array}{rcl}'+body+'\\end{array}\\]';});

  /* 9 ─ bibliography blocks */
  s=s.replace(/\\begin\{thebibliography\}\s*\{[^}]*\}([\s\S]*?)\\end\{thebibliography\}/g,(mm,body)=>{
    emulated.add('thebibliography');
    const items=[];body.replace(/\\bibitem\s*(\[([^\]]*)\])?\s*\{([^}]*)\}([\s\S]*?)(?=\\bibitem|$)/g,(x,o,lab,k,t)=>{items.push({label:manual[k.trim()],text:t.trim()});return x;});
    return ph(bibHTML(items,isBook?(settings.bibname||'Bibliography'):(settings.refname||'References')),true)+pad(mm);});
  s=s.replace(/\\bibliography\s*\{[^}]*\}/g,()=>ph(bibHTML(bibList,isBook?(settings.bibname||'Bibliography'):(settings.refname||'References')),true));
  /* \cite[note]{a,b} → [1, 2] */
  s=s.replace(/\\cite\s*(\[([^\]]*)\])?\s*\{([^}]*)\}/g,(mm,o,note,ks)=>{
    emulated.add('\\cite');
    const labs=ks.split(',').map(k=>bibLabel(k.trim())||'<b>?</b>');
    return ph('['+labs.join(', ')+(note?', '+renderInline(note):'')+']');});
  s=s.replace(/\\nocite\s*\{[^}]*\}/g,'');

  /* 10 ─ index: record entries against the section they occur in */
  const idx=[];
  {
    const re2=/\\(part|chapter|section|subsection|subsubsection|appendix)(\*?)(?![A-Za-z])|\\index\s*\{/g;let mm2;const rebuilt=[];let last=0;
    while((mm2=re2.exec(s))){
      if(mm2[1]){if(!mm2[2])secNum.step(mm2[1]);continue;}
      const g=group(s,mm2.index+mm2[0].length-1);if(!g)continue;
      if(hasIndex)idx.push({raw:g.text,loc:secNum.here()});
      rebuilt.push(s.slice(last,mm2.index));last=g.end;re2.lastIndex=g.end;
    }
    rebuilt.push(s.slice(last));s=rebuilt.join('');
  }
  s=s.replace(/\\printindex(?![A-Za-z])/g,()=>{emulated.add('MakeIndex');
    return ph(indexHTML(idx,settings.indexname||'Index',hasIndex),true);});
  s=s.replace(/\\listoftables(?![A-Za-z])/g,()=>{emulated.add('\\listoftables');return ph('%%LOT%%',true);});
  s=s.replace(/\\listoffigures(?![A-Za-z])/g,()=>{emulated.add('\\listoffigures');return ph('%%LOF%%',true);});

  /* 11 ─ inline odds and ends */
  s=s.replace(/\\(page)?ref\s*\{([^}]*)\}/g,(mm,p,k)=>{k=k.trim();
    if(p)return ph('1');
    if(floatLabels[k])return floatLabels[k];
    return mm;});
  s=s.replace(/\\thanks\s*\{/g,(mm,k)=>'\\LXTHANKS{');
  s=repArg(s,'LXTHANKS',t=>{fns.push({mark:'*',text:t});return ph('<sup>*</sup>');});
  s=repArg(s,'footnote',t=>{emulated.add('\\footnote');const n=++fnN;fns.push({mark:String(n),text:t});
    return ph(`<sup class="lx-fnm">${n}</sup>`);},true);
  s=repArg(s,'footnotemark',()=>{const n=++fnN;return ph(`<sup class="lx-fnm">${n}</sup>`);},false,true);
  s=repArg(s,'footnotetext',t=>{fns.push({mark:String(fnN),text:t});return '';});
  s=repArg(s,'url',t=>{emulated.add('\\url');return ph(`<a class="lx-url" href="${esc(t)}" target="_blank" rel="noopener">${esc(t)}</a>`);});
  s=s.replace(/\\href\s*\{([^}]*)\}\s*\{([^}]*)\}/g,(mm,u,t)=>ph(`<a class="lx-url" href="${esc(u)}" target="_blank" rel="noopener">${renderInline(t)}</a>`));
  s=repArg(s,'textsuperscript',t=>ph('<sup>'+renderInline(t)+'</sup>'));
  s=repArg(s,'textsubscript',t=>ph('<sub>'+renderInline(t)+'</sub>'));
  s=s.replace(/\\rule\s*(\[[^\]]*\])?\s*\{([^}]*)\}\s*\{([^}]*)\}/g,(mm,o,w,h)=>
    ph(`<span class="lx-rule" style="width:${cssLen(w)||'2em'};height:${cssLen(h)||'1px'}"></span>`));
  s=s.replace(/\\hfill(?![A-Za-z])/g,()=>ph('<span class="lx-hfill"></span>'));
  s=s.replace(/\\includegraphics\s*(\[[^\]]*\])?\s*\{([^}]*)\}/g,(mm,o,f)=>ph(`<span class="lx-img">🖼 ${esc(f)}</span>`));
  if(cls==='letter'){
    s=s.replace(/\\begin\{letter\}\s*\{([^}]*)\}/,(mm,a)=>ph('<div class="lx-addr">'+renderInline(a)+'</div>',true));
    s=s.replace(/\\end\{letter\}/,'');
    s=s.replace(/\\(opening|closing|signature|address)\s*\{([^}]*)\}/g,(mm,c,t)=>c==='opening'?ph('<p>'+renderInline(t)+'</p>',true):
      c==='closing'?ph('<p class="lx-close">'+renderInline(t)+'</p>',true):'');
  }
  if(settings.labelitemi||settings.labelitemii||settings.labelenumi||settings.theenumi)emulated.add('list labels');

  /* 12 ─ typeset with latex.js */
  let html='',fatal=null;
  try{
    const g=new latexjs.HtmlGenerator({hyphenate:false});
    latexjs.parse(s,{generator:g});
    const d=document.createElement('div');d.appendChild(g.domFragment());
    /* lengths/geometry latex.js computes as CSS custom properties */
    const probe=document.createElement('div');g.applyLengthsAndGeometryToDom(probe);
    html=postProcess(d,PH,{fns,settings,tabN,figN,isBook});
    return {html,rootStyle:probe.getAttribute('style')||'',cls,isBook,
      findings,errors,emulated:[...emulated],notes:[...new Set(notes)],ok:!errors.length};
  }catch(e){
    fatal={line:e.location?e.location.start.line:null,col:e.location?e.location.start.column:null,
      sev:'error',tex:'! '+String(e.message).replace(/\s+/g,' '),msg:friendly(e.message),fix:''};
    if(!findings.some(f=>f.sev==='error'))findings.push(fatal);
    return {html:null,cls,isBook,findings,errors:findings.filter(f=>f.sev==='error'),
      emulated:[...emulated],notes,ok:false};
  }
}
/* the few latex.js messages worth translating */
function friendly(m){
  m=String(m);
  if(/unknown macro: \\(\w+)/.test(m))return `The live preview does not know \\${RegExp.$1}. The Real PDF tab will — or it may be a typo.`;
  if(/unknown environment: (\S+)/.test(m))return `The live preview does not know the ${RegExp.$1} environment.`;
  if(/missing its end/.test(m))return 'An environment is opened but never closed.';
  if(/group argument expected/.test(m))return 'A command that needs an argument in {braces} did not get one.';
  if(/only allowed in preamble/.test(m))return 'This command must go in the preamble, before \\begin{document}.';
  if(/KaTeX/.test(m))return 'Something inside math could not be typeset.';
  return 'The live previewer could not typeset this.';
}
function settingsCtx(st){return {arraystretch:parseFloat(st.arraystretch)||1,tabcolsep:st.tabcolsep?cssLen(st.tabcolsep):null};}
function renderFloatBody(body,settings,emulated){
  const parts=[];let rest=body;
  rest=replaceEnv(rest,'tabular',(spec,b)=>{emulated.add('tabular');
    let h;try{h=renderTabular(spec,b,{},settingsCtx(settings));}catch(e){h=`<span class="lx-raw">${esc(e.message)}</span>`;}
    parts.push(h);return '\u0001'+(parts.length-1)+'\u0001';},true);
  rest=rest.replace(/\\begin\{tabbing\}([\s\S]*?)\\end\{tabbing\}/g,(m,b)=>{parts.push(renderTabbing(b));return '\u0001'+(parts.length-1)+'\u0001';});
  rest=rest.replace(/\\includegraphics\s*(\[[^\]]*\])?\s*\{([^}]*)\}/g,(m,o,f)=>{parts.push(`<span class="lx-img">🖼 ${esc(f)}</span>`);return '\u0001'+(parts.length-1)+'\u0001';});
  return rest.split('\u0001').map((x,i)=>i%2?parts[+x]:(x.trim()?'<div>'+renderInline(x.trim())+'</div>':'')).join('');
}
function replaceEnv(s,env,fn,withSpec){
  const re=new RegExp('\\\\begin\\{'+env+'\\}','g');let out='',last=0,m;
  while((m=re.exec(s))){
    let i=m.index+m[0].length,spec=null;
    if(withSpec){const o=optarg(s,i);if(o)i=o.end;while(s[i]===' ')i++;const g=group(s,i);if(!g)continue;spec=g.text;i=g.end;}
    const e=findEnd(s,env,i);if(!e)continue;
    out+=s.slice(last,m.index)+fn(spec,s.slice(i,e.start),s.slice(m.index,e.end));
    last=e.end;re.lastIndex=e.end;
  }
  return out+s.slice(last);
}
/* replace \name{arg} (nested-safe). opt=true skips an optional [..] first */
function repArg(s,name,fn,opt,noArg){
  const re=new RegExp('\\\\'+name+'(?![A-Za-z])','g');let out='',last=0,m;
  while((m=re.exec(s))){
    let i=m.index+m[0].length;
    if(opt){const o=optarg(s,i);if(o)i=o.end;}
    if(noArg){out+=s.slice(last,m.index)+fn('');last=i;continue;}
    while(s[i]===' ')i++;
    const g=group(s,i);if(!g)continue;
    out+=s.slice(last,m.index)+fn(g.text);last=g.end;re.lastIndex=g.end;
  }
  return out+s.slice(last);
}
function expand(s,macros){
  const names=Object.keys(macros).sort((a,b)=>b.length-a.length);
  const re=new RegExp('\\\\('+names.map(n=>n.replace(/[@]/g,'\\$&')).join('|')+')(?![A-Za-z@])','g');
  for(let pass=0;pass<12;pass++){
    let changed=false;
    s=s.replace(re,(mm,name,k,full)=>mm);   // placeholder to test presence
    let out='',last=0,m;re.lastIndex=0;
    while((m=re.exec(s))){
      const mac=macros[m[1]];let i=m.index+m[0].length;const args=[];
      if(mac.def!==undefined){const o=optarg(s,i);if(o){args.push(o.text);i=o.end;}else args.push(mac.def);}
      for(let k=args.length;k<mac.n;k++){const a=arg(s,i);if(!a)break;args.push(a.text);i=a.end;}
      let body=mac.body.replace(/#(\d)/g,(x,d)=>args[+d-1]!==undefined?args[+d-1]:'');
      out+=s.slice(last,m.index)+body+(mac.n===0&&/^[A-Za-z]/.test(s[i]||'')?' ':'');last=i;changed=true;
    }
    s=out+s.slice(last);
    if(!changed)break;
  }
  return s;
}
function mkSectionCounter(isBook){
  const c={part:0,chapter:0,section:0,subsection:0,subsubsection:0};let app=false;
  const order=['chapter','section','subsection','subsubsection'];
  return {
    step(k){if(k==='appendix'){app=true;if(isBook)c.chapter=0;else c.section=0;return;}
      if(k==='part'){c.part++;return;}
      c[k]++;order.slice(order.indexOf(k)+1).forEach(x=>c[x]=0);},
    here(){const L=n=>app?String.fromCharCode(64+n):n;
      if(isBook)return [c.chapter&&L(c.chapter),c.section,c.subsection].filter(Boolean).join('.')||'1';
      return [c.section&&L(c.section),c.subsection,c.subsubsection].filter(Boolean).join('.')||'1';}
  };
}
function bibHTML(items,title){
  if(!items.length)return `<h2 class="lx-bibh">${esc(title)}</h2><p class="lx-note">(empty — nothing was cited. \\nocite{*} lists every entry.)</p>`;
  return `<h2 class="lx-bibh">${esc(title)}</h2><dl class="lx-bib">`+
    items.map(it=>`<dt>[${esc(it.label)}]</dt><dd>${renderInline(it.text)}</dd>`).join('')+'</dl>';
}
function indexHTML(idx,title,has){
  if(!has)return `<h2 class="lx-bibh">${esc(title)}</h2><p class="lx-note">(empty — \\makeindex is missing from the preamble, so no entries were recorded.)</p>`;
  const tree={};
  idx.forEach(({raw,loc})=>{
    let [path,enc='']=raw.split('|');
    const levels=path.split('!').map(x=>{const [k,d]=x.split('@');return {key:k.trim(),disp:(d!==undefined?d:k).trim()};});
    let node=tree;levels.forEach((lv,i)=>{node[lv.key]=node[lv.key]||{disp:lv.disp,locs:[],sub:{}};
      if(i===levels.length-1){
        if(/^see\s*\{/.test(enc))node[lv.key].see=enc.replace(/^see\s*\{|\}$/g,'');
        else if(/^seealso\s*\{/.test(enc))node[lv.key].also=enc.replace(/^seealso\s*\{|\}$/g,'');
        else node[lv.key].locs.push({loc,fmt:enc.replace(/[()]/g,''),range:enc[0]==='('?'(':enc[0]===')'?')':''});
      }
      node=node[lv.key].sub;});
  });
  const letters={};
  const fmtLocs=n=>{const out=[];let open=null;
    n.locs.forEach(l=>{const t=l.fmt&&l.fmt!=='('&&l.fmt!==')'?`\\${l.fmt}{${l.loc}}`:l.loc;
      if(l.range==='(')open=l.loc;else if(l.range===')'&&open){out.pop();out.push(open+'–'+l.loc);open=null;}
      else if(!out.includes(t))out.push(t);});
    return out.map(x=>/^\\/.test(x)?renderInline(x):esc(x)).join(', ');};
  const item=(k,n,lvl)=>{
    let h=`<div class="ix l${lvl}">${renderInline(n.disp)}`+(n.locs.length?', '+fmtLocs(n):'')+
      (n.see?`, <i>see</i> ${renderInline(n.see)}`:'')+(n.also?`, <i>see also</i> ${renderInline(n.also)}`:'')+'</div>';
    Object.keys(n.sub).sort((a,b)=>a.localeCompare(b)).forEach(s=>h+=item(s,n.sub[s],lvl+1));
    return h;};
  Object.keys(tree).sort((a,b)=>a.localeCompare(b,undefined,{sensitivity:'base'})).forEach(k=>{
    const L=/[a-z]/i.test(k[0])?k[0].toUpperCase():'#';(letters[L]=letters[L]||[]).push(item(k,tree[k],0));});
  return `<h2 class="lx-bibh">${esc(title)}</h2><div class="lx-index">`+
    Object.keys(letters).map(L=>`<div class="ixg"><div class="ixl">${L}</div>${letters[L].join('')}</div>`).join('')+
    `</div><p class="lx-note">Locations are section numbers here — in the PDF they are page numbers.</p>`;
}
function postProcess(root,PH,o){
  /* placeholders */
  const walker=document.createTreeWalker(root,NodeFilter.SHOW_TEXT);const hits=[];
  while(walker.nextNode()){if(/LXQZ\d+Q/.test(walker.currentNode.nodeValue))hits.push(walker.currentNode);}
  hits.forEach(t=>{
    const parts=t.nodeValue.split(/(LXQZ\d+Q)/);const frag=document.createDocumentFragment();
    let blockHTML=null;
    parts.forEach(p=>{const mm=/^LXQZ(\d+)Q$/.exec(p);
      if(mm){const it=PH[+mm[1]];
        if(it.block&&parts.filter(x=>x.trim()).length===1){blockHTML=it.html;return;}
        const span=document.createElement('span');span.innerHTML=it.html;
        while(span.firstChild)frag.appendChild(span.firstChild);}
      else if(p)frag.appendChild(document.createTextNode(p));});
    const par=t.parentNode;
    if(blockHTML!==null&&par&&par.tagName==='P'&&par.textContent.trim()===t.nodeValue.trim()){
      const div=document.createElement('div');div.className='lx-block';div.innerHTML=blockHTML;par.replaceWith(div);}
    else if(blockHTML!==null){const div=document.createElement('div');div.className='lx-block';div.innerHTML=blockHTML;t.replaceWith(div);}
    else t.replaceWith(frag);
  });
  /* \hfill paragraphs become flex rows */
  root.querySelectorAll('.lx-hfill').forEach(h=>{const p=h.closest('p');if(p)p.classList.add('lx-hasfill');});
  /* lists of tables/figures */
  root.querySelectorAll('.lx-block').forEach(b=>{
    if(b.innerHTML==='%%LOT%%'||b.innerHTML==='%%LOF%%'){
      const kind=b.innerHTML==='%%LOT%%'?'table':'figure';
      const caps=[...root.querySelectorAll(`.lx-float[data-kind="${kind}"] .lx-cap`)];
      const t=kind==='table'?(o.settings.listtablename||'List of Tables'):(o.settings.listfigurename||'List of Figures');
      b.innerHTML=`<h2 class="lx-bibh">${esc(t)}</h2>`+(caps.length?'<div class="lx-lot">'+caps.map(c=>{
        const x=c.cloneNode(true);const b2=x.querySelector('b');const num=b2?b2.textContent.replace(/\D+/g,''):'';if(b2)b2.remove();
        return `<div><span>${num}</span><span>${x.innerHTML.trim()}</span></div>`;}).join('')+'</div>':'<p class="lx-note">(empty)</p>');
    }});
  /* renamed headings */
  const rn=(sel,txt)=>{if(txt)root.querySelectorAll(sel).forEach(h=>h.textContent=txt.replace(/[{}\\]/g,''));};
  rn('.list-of-contents>h2, .toc h2, h2.toc',o.settings.contentsname);
  rn('.abstract .title, .abstract>div>b, .abstract h3',o.settings.abstractname);
  /* custom list labels */
  const LB=o.settings;
  const lbl=(sel,val)=>{if(!val)return;root.querySelectorAll(sel).forEach(x=>x.innerHTML=renderInline(val));};
  lbl('ul.list:not(ul.list ul.list)>li>.itemlabel>.hbox',LB.labelitemi);
  lbl('ul.list ul.list:not(ul.list ul.list ul.list)>li>.itemlabel>.hbox',LB.labelitemii);
  if(LB.labelenumi||LB.theenumi){
    const t=(LB.labelenumi||'\\theenumi.').replace(/\\theenumi/g,'@');
    root.querySelectorAll('ol.list:not(ol.list ol.list)').forEach(ol=>{let i=0;
      ol.querySelectorAll(':scope>li>.itemlabel>.hbox').forEach(h=>{i++;
        const num=/\\(roman|Roman|alph|Alph|arabic)\{enumi\}/.exec(LB.theenumi||'');
        const v=num?fmtCounter(i,num[1]):String(i);
        h.innerHTML=renderInline(t.replace(/@/g,v));});});
  }
  /* footnotes at the foot of the "page" */
  if(o.fns.length){const d=document.createElement('div');d.className='lx-fns';
    d.innerHTML='<hr>'+o.fns.map(f=>`<div><sup>${esc(f.mark)}</sup> ${renderInline(f.text)}</div>`).join('');
    (root.querySelector('.body')||root).appendChild(d);}
  return root.innerHTML;
}
function fmtCounter(n,k){
  if(k==='arabic')return String(n);
  if(k==='alph')return String.fromCharCode(96+n);if(k==='Alph')return String.fromCharCode(64+n);
  const r=[[10,'x'],[9,'ix'],[5,'v'],[4,'iv'],[1,'i']];let s='';for(const [v,t] of r)while(n>=v){s+=t;n-=v;}
  return k==='Roman'?s.toUpperCase():s;
}
return {lint,compile,parseBib,collectBib,renderInline,esc};
})();
