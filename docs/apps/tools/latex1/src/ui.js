/* ══════════════════════════════════════════════════════════════════
   LaTeX · Modules I–II — study engine
   tree · focus accordion · live editor · practice widgets · sync
   ══════════════════════════════════════════════════════════════════ */
(function(){
'use strict';
const $=(s,r=document)=>r.querySelector(s),$$=(s,r=document)=>[...r.querySelectorAll(s)];
const CFG=Object.assign({online:true,cdn:'https://cdn.jsdelivr.net/npm/latex.js@0.12.6/dist/',
  pdfServer:'https://texlive.net/cgi-bin/latexcgi',onlineURL:''},window.LX_CFG||{});
const REG=window.LXREG||{ex:{},w:{}};
const esc=LXTeX.esc;
const debounce=(f,ms)=>{let h;return(...a)=>{clearTimeout(h);h=setTimeout(()=>f(...a),ms);};};
const el=h=>{const d=document.createElement('div');d.innerHTML=h.trim();return d.firstElementChild;};
const shuffle=(a,seed)=>{a=a.slice();let s=seed||Math.random()*1e9|0;const r=()=>{s=(s*1103515245+12345)&0x7fffffff;return s/0x7fffffff;};
  for(let i=a.length-1;i>0;i--){const j=Math.floor(r()*(i+1));[a[i],a[j]]=[a[j],a[i]];}return a;};
const hash=s=>{let h=5381;for(let i=0;i<s.length;i++)h=((h<<5)+h+s.charCodeAt(i))|0;return Math.abs(h);};

/* ══════════════ syntax highlighting — VS Code’s own grammar and themes ══════════════ */
const hlCache=new Map();
function hl(code,lang){
  const k=(lang||'latex')+'\u0000'+code;if(hlCache.has(k))return hlCache.get(k);
  let h;try{h=LXShiki.highlight(code,lang||'latex');}catch(e){h='<pre class="shiki"><code>'+esc(code)+'</code></pre>';}
  if(hlCache.size>700)hlCache.delete(hlCache.keys().next().value);
  hlCache.set(k,h);return h;
}
function hlInline(code,lang){return '<code class="lx-code">'+hlLines(code,lang).join('\n')+'</code>';}
function hlLines(code,lang){
  let toks;try{toks=LXShiki.tokens(code,lang||'latex');}catch(e){return code.split('\n').map(esc);}
  return toks.map(line=>line.map(t=>{const L=t.variants.light,D=t.variants.dark;
    return `<span style="--shiki-light:${L.color};--shiki-dark:${D.color}${L.fontStyle&1?';font-style:italic':''}">${esc(t.content)}</span>`;}).join(''));
}

/* ══════════════ preview frame: latex.js output in its own document ══════════════ */
const PREVIEW_EXTRA=`
html{background:#fff}body{margin:0;background:#fff;color:#111;overflow:hidden;padding:1.1em 0 1.3em!important;
  grid-template-columns:[margin-left] minmax(.9em,1fr) [body] minmax(0,38em) [margin-right] minmax(.9em,1fr)!important;min-width:0!important}
.titlepage{height:auto!important;min-height:auto!important;max-height:none!important}
.lx-wait{font-family:system-ui,sans-serif;font-size:13px;color:#9a8f80;text-align:center;padding:1.2em 1em}
.page{margin:0 auto}
.lx-note{font-family:system-ui,sans-serif;font-size:11px;color:#8a8175;margin:.4em 0}
.lx-raw{font-family:monospace;background:#fde9e4;color:#9b2c16;padding:0 .2em;border-radius:3px}
.lx-block{margin:.8em 0}
.lx-tabwrap{overflow-x:auto;display:flex;justify-content:center}
table.lx-tab{border-collapse:collapse;--lxrule:#111;margin:0 auto;line-height:calc(1.25*var(--lxstr,1))}
table.lx-tab td{padding:calc(.15em*var(--lxstr,1)) var(--lxpad,6px);vertical-align:top;text-align:left;white-space:nowrap}
table.lx-tab td.al-c{text-align:center}table.lx-tab td.al-r{text-align:right}
table.lx-tab td.al-p{white-space:normal;text-align:justify;hyphens:auto}
.lx-float{margin:1.2em 0}.lx-float.c{text-align:center}.lx-float.c table.lx-tab{margin:0 auto}
.lx-cap{margin:.5em auto;max-width:90%;text-align:center}
.lx-tabbing{display:grid;column-gap:0;margin:.6em 0;justify-content:start}
.lx-tabbing span{padding-right:.6em;white-space:nowrap}.lx-tabbing span.kill{visibility:hidden;height:0;overflow:hidden;line-height:0}
pre.lx-verb{font-family:"Computer Modern Typewriter",monospace;font-size:.95em;margin:.7em 0;white-space:pre;overflow-x:auto;line-height:1.25}
code.lx-verbi{font-family:"Computer Modern Typewriter",monospace}.vsp{color:#999}
h2.lx-bibh{font-size:1.44em;font-weight:bold;margin:1.2em 0 .6em}
dl.lx-bib{display:grid;grid-template-columns:max-content 1fr;gap:.35em .7em;margin:0}
dl.lx-bib dt{text-align:right}dl.lx-bib dd{margin:0}
.lx-index{columns:2;column-gap:2em}.ixg{break-inside:avoid;margin-bottom:.7em}.ixl{font-weight:bold;margin:.4em 0 .2em}
.ix.l1{padding-left:1.2em}.ix.l2{padding-left:2.4em}
.lx-lot div{display:flex;gap:1em}.lx-lot div span:first-child{min-width:2em}
.lx-fns{margin-top:2em;font-size:.85em}.lx-fns hr{width:30%;margin:0 0 .4em;border:0;border-top:.5px solid #111}
.lx-fns sup{font-size:.7em}.lx-fnm{font-size:.7em}
p.lx-hasfill{display:flex;align-items:baseline}.lx-hfill{flex:1}
.lx-rule{display:inline-block;background:#111;vertical-align:baseline}
.lx-url{font-family:"Computer Modern Typewriter",monospace;color:inherit;text-decoration:none}
.lx-img{display:inline-block;border:1px dashed #999;padding:1.5em 2em;color:#777;font-family:sans-serif;font-size:.8em}
.lx-addr{text-align:left;margin-bottom:1em}.lx-close{margin-top:1.5em}
`;
let previewHead=null;
function previewHeadHTML(){
  if(previewHead)return previewHead;
  const P=window.LX_PREVIEW;                         // inlined in the offline build
  if(P)previewHead=`<style>${P.fonts}</style><style>${P.base}</style><style id="cls-article">${P.article}</style>`+
    `<style id="cls-book" media="not all">${P.book}</style>`;
  else previewHead=`<link rel="stylesheet" href="${CFG.cdn}css/katex.css"><link rel="stylesheet" href="${CFG.cdn}css/base.css">`+
    `<link id="cls-article" rel="stylesheet" href="${CFG.cdn}css/article.css"><link id="cls-book" rel="stylesheet" href="${CFG.cdn}css/book.css" media="not all">`;
  previewHead+=`<style>${PREVIEW_EXTRA}</style><script>${window.LX_BASEJS||''}<\/script>`;
  return previewHead;
}
function makePreview(iframe){
  let ready=false,queued=null,lastW=0;
  iframe.srcdoc=`<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width">${previewHeadHTML()}</head><body></body></html>`;
  iframe.addEventListener('load',()=>{ready=true;if(queued){const q=queued;queued=null;show(q);}});
  const fit=()=>{
    const d=iframe.contentDocument;if(!d||!d.body)return;
    const root=d.documentElement;root.style.zoom='';
    const page=d.querySelector('.page')||d.body.firstElementChild;
    const w=iframe.clientWidth||300;
    const natural=Math.max(page?page.scrollWidth:w,d.body.scrollWidth);
    const z=natural>w?Math.max(.45,w/natural):1;
    root.style.zoom=z<1?String(z):'';
    const h=Math.ceil(d.body.getBoundingClientRect().height*(z<1?1:1))+2;
    const targetH=Math.min(Math.max(96,h),2400);
    if(Math.abs((iframe.clientHeight||0)-targetH)>2){
      iframe.style.height=targetH+'px';
    }
  };
  function show(r){
    if(!ready){queued=r;return;}
    const d=iframe.contentDocument;if(!d)return;
    const book=r.isBook;
    const a=d.getElementById('cls-article'),b=d.getElementById('cls-book');
    if(a&&b){a.media=book?'not all':'all';b.media=book?'all':'not all';}
    d.documentElement.setAttribute('style',r.rootStyle||'');
    d.body.innerHTML=r.html;
    try{if(d.defaultView.processTheElements)d.defaultView.processTheElements();
      if(d.defaultView.positionMarginpars)d.defaultView.positionMarginpars();}catch(e){}
    d.querySelectorAll('a[href^="#"]').forEach(x=>x.removeAttribute('href'));
    requestAnimationFrame(fit);setTimeout(fit,250);setTimeout(fit,900);   // fonts settle late
  }
  new ResizeObserver(entries=>{
    for(const entry of entries){
      const w=Math.round(entry.contentRect.width);
      if(w!==lastW){
        lastW=w;
        debounce(fit,120)();
      }
    }
  }).observe(iframe);
  return {show,fit};
}

/* ══════════════ code area — a transparent textarea over VS Code-highlighted lines ══════════════
   the text you type is shown uncoloured at once (so it never lags the caret), then recoloured    */
const KEYS=[['\\','\\'],['{ }','{}',1],['[ ]','[]',1],['$ $','$$',1],['&','&'],['\\\\','\\\\\n'],['%','% '],['#','#'],['_','_'],['^','^'],['~','~'],
  ['\\item','\\item '],['begin','\\begin{}',1],['end','\\end{}',1],['⇥','  ']];
const CODE_HTML=`<div class="code"><div class="codein" style="position:relative"><pre class="hlp" aria-hidden="true"></pre>
  <textarea spellcheck="false" autocapitalize="off" autocomplete="off" autocorrect="off" wrap="soft" aria-label="LaTeX source"></textarea></div></div><div class="keybar"></div>`;
function codeArea(w,o){
  const ta=$('textarea',w),pre=$('pre.hlp',w),box=$('.code',w),kb=$('.keybar',w);
  let text='',lang='latex',lineHTML=[],lineTxt=[],marks={};
  kb.innerHTML=KEYS.map((k,i)=>`<button data-k="${i}" title="${esc(k[1])}">${esc(k[0])}</button>`).join('');
  kb.addEventListener('pointerdown',e=>{const b=e.target.closest('button');if(!b)return;e.preventDefault();const k=KEYS[+b.dataset.k];insert(k[1],k[2]);});
  function insert(txt,inside){
    ta.focus();const s=ta.selectionStart,e=ta.selectionEnd;
    let ok=false;try{ok=document.execCommand('insertText',false,txt);}catch(x){}
    if(!ok)ta.setRangeText(txt,s,e,'end');
    if(inside){const back=txt.endsWith('{}')||txt.endsWith('[]')||txt==='$$'?1:0;ta.selectionStart=ta.selectionEnd=s+txt.length-back;}
    onInput();
  }
  const paint=()=>{pre.innerHTML=lineHTML.map((h,i)=>`<span class="ln${marks[i+1]?' '+marks[i+1]:''}" data-n="${i+1}">${h||'\u200b'}</span>`).join('');};
  function plainUpdate(){
    const t=text.split('\n');let a=0;
    while(a<t.length&&a<lineTxt.length&&t[a]===lineTxt[a])a++;
    let b=0;while(b<t.length-a&&b<lineTxt.length-a&&t[t.length-1-b]===lineTxt[lineTxt.length-1-b])b++;
    lineHTML=lineHTML.slice(0,a).concat(t.slice(a,t.length-b).map(esc),lineHTML.slice(lineHTML.length-b));lineTxt=t;paint();
  }
  const colour=debounce(()=>{lineHTML=hlLines(text,lang);lineTxt=text.split('\n');paint();},70);
  function onInput(){if(ta.value===text)return;text=ta.value;plainUpdate();colour();o.onInput&&o.onInput(text);}
  ta.addEventListener('input',onInput);
  ta.addEventListener('scroll',()=>{
    if(ta.scrollTop!==0||ta.scrollLeft!==0){
      box.scrollTop+=ta.scrollTop;
      box.scrollLeft+=ta.scrollLeft;
      ta.scrollTop=0;
      ta.scrollLeft=0;
    }
  });
  box.addEventListener('scroll',()=>{
    if(ta.scrollTop!==0||ta.scrollLeft!==0){
      ta.scrollTop=0;
      ta.scrollLeft=0;
    }
  });
  ta.addEventListener('keydown',e=>{
    const mod=e.ctrlKey||e.metaKey;
    if(e.key==='Tab'){e.preventDefault();
      const s=ta.selectionStart,v=ta.value;
      if(e.shiftKey){const ls=v.lastIndexOf('\n',s-1)+1;if(v.slice(ls,ls+2)==='  '){ta.setRangeText('',ls,ls+2,'preserve');onInput();}}
      else insert('  ');}
    else if(e.key==='Enter'&&!mod){
      const s=ta.selectionStart,v=ta.value,ls=v.lastIndexOf('\n',s-1)+1,ind=(/^[ \t]*/.exec(v.slice(ls))||[''])[0];
      if(ind){e.preventDefault();insert('\n'+ind);}}
    else if(e.key==='Enter'&&mod){e.preventDefault();o.onRun&&o.onRun();}
    else if(e.key==='/'&&mod){e.preventDefault();toggleComment();}
    else if((e.key==='s'||e.key==='S')&&mod){e.preventDefault();o.onSave&&o.onSave();}
  });
  function toggleComment(){
    const v=ta.value,s=ta.selectionStart,e2=ta.selectionEnd,ls=v.lastIndexOf('\n',s-1)+1,le=v.indexOf('\n',e2);
    const lines=v.slice(ls,le<0?v.length:le).split('\n');
    const all=lines.every(l=>/^\s*%/.test(l)||!l.trim());
    const out=lines.map(l=>all?l.replace(/^(\s*)% ?/,'$1'):(l.trim()?'% '+l:l)).join('\n');
    ta.setSelectionRange(ls,le<0?v.length:le);insert(out);
  }
  function load(t,l){text=t;lang=l||'latex';ta.value=t;lineTxt=t.split('\n');lineHTML=hlLines(t,lang);marks={};paint();}
  function goLine(n){
    const lines=text.split('\n');n=Math.max(1,Math.min(n||1,lines.length));let pos=0;for(let i=0;i<n-1;i++)pos+=lines[i].length+1;
    ta.focus({preventScroll:true});ta.setSelectionRange(pos,pos+lines[n-1].length);
    const ln=pre.querySelector(`.ln[data-n="${n}"]`);if(ln){ln.classList.add('flash');setTimeout(()=>ln.classList.remove('flash'),1000);box.scrollTop=ln.offsetTop-box.clientHeight/3;}
  }
  return {load,insert,goLine,setMarks(m){marks=m||{};paint();},get text(){return text;},ta,box};
}

/* ══════════════ the live error indicator — every finding in two voices ══════════════ */
function paintFindings(status,list,F,cur,go){
  const E=F.filter(f=>f.sev==='error'),Wn=F.filter(f=>f.sev!=='error');
  status.classList.toggle('bad',E.length>0);status.classList.toggle('warn',!E.length&&Wn.length>0);
  const first=E[0]||Wn[0],where=f=>f.file&&f.file!==cur?esc(f.file)+' · ':'';
  $('.txt',status).innerHTML=first?`<b>${where(first)}Line ${first.line||'?'}:</b> ${esc(first.msg)}`:'<b>No errors.</b> This would compile.';
  $('.count',status).textContent=(E.length?E.length+' error'+(E.length>1?'s':''):'')+(E.length&&Wn.length?' · ':'')+(Wn.length?Wn.length+' warning'+(Wn.length>1?'s':''):'')+(F.length?' ▾':'');
  list.innerHTML=F.map((f,i)=>`<div class="e${f.sev==='error'?'':' w'}" data-i="${i}"><span class="ln2">${f.file&&f.file!==cur?esc(f.file)+'<br>':''}L${f.line||'?'}</span>
    <span class="tex">${esc(f.tex)}</span><span class="msg">${esc(f.msg)}</span>${f.fix?`<span class="fix">${esc(f.fix)}</span>`:''}</div>`).join('');
  if(!F.length)list.classList.remove('on');
  $$('.e',list).forEach(x=>x.onclick=()=>{const f=F[+x.dataset.i];go(f.line,f.file);});
}

/* ══════════════ projects: several files, \input / \include, one main file ══════════════
   latex.js sees one long document; a source map sends every finding back to {file, line} */
const TEXTEXT=/\.(tex|ltx|bib|sty|cls|bst|txt|csv|ist|dat|def|cfg|clo)$/i;
const isTeX=p=>/\.(tex|ltx)$/i.test(p);
const langOf=p=>/\.bib$/i.test(p)?'bibtex':'latex';
function commentAt(line){for(let i=0;i<line.length;i++){if(line[i]==='\\'){i++;continue;}if(line[i]==='%')return i;}return -1;}
function findFile(files,name,exts){name=String(name).trim().replace(/^\.\//,'');
  for(const c of [name,...exts.map(e=>name+e)]){const f=files.find(x=>x.path===c);if(f)return f;}return null;}
function expandProject(files,mainPath){
  const main=files.find(f=>f.path===mainPath)||files.find(f=>isTeX(f.path))||{path:mainPath||'main.tex',text:''};
  const out=[],map=[],issues=[];
  const mainCode=main.text.split('\n').map(l=>{const c=commentAt(l);return c<0?l:l.slice(0,c);}).join('\n');
  const om=/\\includeonly\s*\{([^}]*)\}/.exec(mainCode),only=om?om[1].split(',').map(s=>s.trim().replace(/\.tex$/,'')):null;
  (function walk(f,stack,viaInclude){
    f.text.split('\n').forEach((line,i)=>{
      const here={file:f.path,line:i+1},c=commentAt(line),code=c<0?line:line.slice(0,c),tail=c<0?'':line.slice(c);
      const re=/\\(input|include|includeonly)\s*\{([^}]*)\}/g;let m,pos=0,buf='',any=false;
      while((m=re.exec(code))){
        any=true;buf+=code.slice(pos,m.index);pos=m.index+m[0].length;
        if(m[1]==='includeonly')continue;
        const nm=m[2].trim(),child=findFile(files,nm,['.tex']);
        if(!child){issues.push({file:f.path,line:i+1,sev:'error',tex:`! LaTeX Error: File \`${nm}${/\.\w+$/.test(nm)?'':'.tex'}' not found.`,
          msg:`\\${m[1]}{${nm}} names a file that is not in this project.`,
          fix:'Create it with ＋ in the Files panel, or correct the name. Paths start at the project’s top folder; leave off the .tex.'});continue;}
        if(stack.includes(child.path)){issues.push({file:f.path,line:i+1,sev:'error',tex:'! TeX capacity exceeded, sorry [text input levels=15].',
          msg:`${child.path} ends up including itself — the files include each other in a loop.`,fix:'Remove one of the \\input/\\include lines that closes the loop.'});continue;}
        if(m[1]==='include'&&viaInclude)issues.push({file:f.path,line:i+1,sev:'error',tex:'! LaTeX Error: \\include cannot be nested.',
          msg:'A file brought in with \\include cannot itself use \\include.',fix:'Use \\input inside included files.'});
        if(m[1]==='include'&&only&&!only.includes(nm.replace(/\.tex$/,'')))continue;   // \includeonly leaves it out
        if(buf.trim()){out.push(buf);map.push(here);}buf='';
        walk(child,stack.concat(child.path),viaInclude||m[1]==='include');
      }
      if(!any){out.push(line);map.push(here);return;}
      out.push(buf+code.slice(pos)+tail);map.push(here);
    });
  })(main,[main.path],false);
  return {src:out.join('\n'),map,issues,main:main.path};
}
function compileProject(files,mainPath){
  const x=expandProject(files,mainPath);
  const extra=files.filter(f=>!isTeX(f.path)).map(f=>({name:f.path,text:f.text}));
  let r;try{r=LXTeX.compile(x.src,extra);}
  catch(e){r={findings:[{line:1,sev:'error',tex:'internal: '+e.message,msg:'The previewer hit a bug.',fix:''}],html:null,emulated:[],notes:[]};}
  r.findings.forEach(f=>{if(f.file)return;const m=x.map[(f.line||1)-1]||x.map[x.map.length-1]||{file:x.main,line:1};f.file=m.file;f.line=m.line;});
  extra.forEach(f=>{if(/\.bib$/i.test(f.name))LXTeX.parseBib(f.text,f.name).errors.forEach(er=>r.findings.push({line:er.line,sev:er.warn?'warning':'error',file:f.name,
    tex:'BibTeX: '+er.msg,msg:er.warn?'This will print the wrong author names.':'This entry in '+f.name+' is malformed.',
    fix:er.warn?'Write author = {First Person and Second Person}.':'Each entry is @type{key, field = {value}, …} with a comma after every field.'}));});
  r.findings=x.issues.concat(r.findings);r.main=x.main;
  return r;
}
/* Real PDF: texlive.net accepts only flat file names, so chapters/intro.tex travels as
   chapters__intro.tex and every \input / \include / \bibliography that names it is rewritten */
function submitPDF(files,mainPath,target,mode,engine){
  const send=files.filter(f=>TEXTEXT.test(f.path));
  const flat=p=>p===mainPath?'document.tex':p==='document.tex'?'document-1.tex':p.replace(/\//g,'__');
  const moved=send.some(f=>flat(f.path)!==f.path);
  const fix=t=>!moved?t:t.replace(/(\\(?:input|include|includeonly|bibliography|addbibresource|includegraphics|usepackage|bibliographystyle|documentclass)\s*(?:\[[^\]]*\])?\s*\{)([^}]*)\}/g,
    (m,pre,args)=>pre+args.split(',').map(a=>{const n=a.trim();if(!n)return a;
      const f=findFile(send,n,['.tex','.bib','.sty','.cls','.bst']);if(!f||flat(f.path)===f.path)return a;
      const fl=flat(f.path),ext=(/\.\w+$/.exec(f.path)||[''])[0];
      return a.replace(n,n.endsWith(ext)?fl:fl.slice(0,fl.length-ext.length));}).join(',')+'}');
  const main=send.find(f=>f.path===mainPath);if(!main)return false;
  const form=document.createElement('form');form.method='POST';form.action=CFG.pdfServer;form.target=target;
  form.enctype='multipart/form-data';form.style.display='none';form.acceptCharset='UTF-8';
  const add=(n,v,big)=>{const i=document.createElement(big?'textarea':'input');i.name=n;i.value=v;form.appendChild(i);};
  [main].concat(send.filter(f=>f!==main)).forEach(f=>{add('filecontents[]',fix(f.text),true);add('filename[]',flat(f.path));});
  const all=send.map(f=>f.text.replace(/(^|[^\\])%.*$/gm,'$1')).join('\n');
  add('engine',engine||'pdflatex');add('return',mode);
  if(/\\bibliography\s*\{/.test(all))add('bibcmd','bibtex');
  if(/\\makeindex/.test(all))add('makeindex[]',' document');
  document.body.appendChild(form);form.submit();form.remove();
  return true;
}

/* ══════════════ inline output: what an example produces, with the way into the IDE ══════════════ */
function previewBlock(slot,spec,label){
  slot.innerHTML='';
  const r=compileProject(spec.files,spec.main);
  const E=r.findings.filter(f=>f.sev==='error');
  const b=el(`<div class="pvb"><div class="pvh"><span class="k">${label||'output'}</span>
      <span class="st${E.length?' bad':''}">${E.length?'● '+E.length+' error'+(E.length>1?'s':'')+' — line '+(E[0].line||'?')+': '+esc(E[0].msg):'✓ compiles'}</span>
      <span class="grow"></span><button class="minibtn go" data-a="ide">⌨ Open in IDE</button></div><iframe class="live" title="${label||'Output'}"></iframe></div>`);
  slot.appendChild(b);
  const pv=makePreview($('iframe',b));
  pv.show(r.html!==null&&r.html!==undefined?r:{html:'<div class="body"><div class="lx-wait">This code does not compile yet — check syntax or open in IDE.</div></div>',rootStyle:''});
  $('[data-a="ide"]',b).onclick=()=>openInIDE(spec);
  return b;
}
const docSpec=(id,name,code,bib)=>{const files=[{path:'document.tex',text:code}];if(bib!==undefined)files.push({path:'refs.bib',text:bib});return {id,name,files,main:'document.tex'};};
const exSpec=(id,d,code)=>{
  const snippet=code!==undefined?code:d.snippet;
  if(d.lang==='bibtex')return {id:'ex-'+id,name:'Example — '+(d.title||'a .bib file'),main:'document.tex',files:[{path:d.file||'refs.bib',text:snippet+'\n'},
    {path:'document.tex',text:'\\documentclass{article}\n\\begin{document}\n\\nocite{*}   % list every entry, cited or not\n\\bibliographystyle{plain}\n\\bibliography{'+(d.file||'refs.bib').replace(/\.bib$/,'')+'}\n\\end{document}\n'}]};
  let fullDoc=d.full;
  if(code!==undefined){
    if(d.full&&d.full.includes(d.snippet))fullDoc=d.full.replace(d.snippet,code);
    else fullDoc=asDoc(code);
  } else {
    fullDoc=d.full||asDoc(d.snippet);
  }
  const files=[{path:'document.tex',text:fullDoc}];if(d.bib!==undefined)files.push({path:'refs.bib',text:d.bib});
  return {id:'ex-'+id,name:'Example — '+(d.title||(snippet.split('\n').find(l=>l.trim())||'untitled').trim().slice(0,40)),files,main:'document.tex'};};

/* ══════════════ the code window — a proper “alert” for full code ══════════════ */
const CW={spec:null,i:0};
function openCode(spec){
  CW.spec=spec;CW.i=0;const m=$('#codewin');
  $('#cwtitle').textContent=spec.title||'Full code';
  $('.cwtabs',m).innerHTML=spec.files.map((f,i)=>`<button data-cwt="${i}">${esc(f.path)}</button>`).join('');
  $('.cwtabs',m).hidden=spec.files.length<2;
  paintCode();m.classList.add('show');document.body.classList.add('noscroll');
  setTimeout(()=>$('[data-cw="ide"]',m).focus({preventScroll:true}),50);
}
function paintCode(){
  const m=$('#codewin'),f=CW.spec.files[CW.i];
  $$('.cwtabs button',m).forEach((b,i)=>b.classList.toggle('on',i===CW.i));
  $('.cwbody',m).innerHTML='<pre><code class="lx-code">'+hlLines(f.text,langOf(f.path)).map((h,i)=>`<span class="lnum">${i+1}</span>${h}`).join('\n')+'</code></pre>';
  $('.cwbody',m).scrollTop=0;
}
function closeCode(){$('#codewin').classList.remove('show');document.body.classList.remove('noscroll');}
function initCodeWin(){
  const m=$('#codewin');
  m.addEventListener('click',e=>{
    if(e.target===m){closeCode();return;}
    const t=e.target.closest('[data-cwt]');if(t){CW.i=+t.dataset.cwt;paintCode();return;}
    const a=e.target.closest('[data-cw]');if(!a)return;const f=CW.spec.files[CW.i];
    if(a.dataset.cw==='close')closeCode();
    else if(a.dataset.cw==='copy')copyText(f.text,'Copied '+f.path);
    else if(a.dataset.cw==='dl')saveFile(f.path.split('/').pop(),new Blob([f.text],{type:'text/plain'}));
    else if(a.dataset.cw==='ide'){closeCode();openInIDE(CW.spec);}
  });
  document.addEventListener('keydown',e=>{if(e.key==='Escape'&&m.classList.contains('show'))closeCode();});
}
function copyText(t,msg){
  const done=()=>toast(msg||'Copied');
  if(navigator.clipboard&&window.isSecureContext)navigator.clipboard.writeText(t).then(done,()=>fallback());else fallback();
  function fallback(){const a=document.createElement('textarea');a.value=t;a.style.cssText='position:fixed;opacity:0';document.body.appendChild(a);a.select();
    try{document.execCommand('copy');done();}catch(e){toast('Copy failed');}a.remove();}
}
function saveFile(name,blob){const a=document.createElement('a');a.href=URL.createObjectURL(blob);a.download=name;document.body.appendChild(a);a.click();a.remove();
  setTimeout(()=>URL.revokeObjectURL(a.href),4000);}

/* a small dialog that replaces prompt() / confirm() */
function ask(o){
  return new Promise(res=>{
    const m=$('#askwin'),inp=$('#askinput'),opts=$('.askopts',m);
    $('#asktitle').textContent=o.title||'';$('#askmsg').innerHTML=o.msg||'';$('#askmsg').hidden=!o.msg;
    inp.hidden=o.value===undefined;inp.value=o.value||'';inp.placeholder=o.placeholder||'';
    opts.innerHTML=(o.options||[]).map((x,i)=>`<label><input type="radio" name="askopt" value="${i}"${i===0?' checked':''}><span><b>${esc(x.label)}</b>${x.desc?`<small>${esc(x.desc)}</small>`:''}</span></label>`).join('');
    $('#askok').textContent=o.ok||'OK';$('#askok').classList.toggle('danger',!!o.danger);
    m.classList.add('show');
    const finish=v=>{m.classList.remove('show');$('#askok').onclick=$('#askno').onclick=inp.onkeydown=m.onclick=null;res(v);};
    const ok=()=>{const k=$('input[name="askopt"]:checked',m);
      finish(o.options?(o.value!==undefined?{value:inp.value.trim(),option:k?+k.value:0}:(k?+k.value:0)):o.value!==undefined?inp.value.trim():true);};
    $('#askok').onclick=ok;$('#askno').onclick=()=>finish(null);
    inp.onkeydown=e=>{if(e.key==='Enter'){e.preventDefault();ok();}if(e.key==='Escape')finish(null);};
    m.onclick=e=>{if(e.target===m)finish(null);};
    setTimeout(()=>{if(!inp.hidden){inp.focus();const d=inp.value.lastIndexOf('.');inp.setSelectionRange(0,d>0&&!o.selectAll?d:inp.value.length);}else $('#askok').focus();},40);
  });
}

/* a store-only .zip writer — enough to hand a whole project to Overleaf or TeXstudio */
const CRC=(()=>{const t=new Uint32Array(256);for(let n=0;n<256;n++){let c=n;for(let k=0;k<8;k++)c=c&1?0xEDB88320^(c>>>1):c>>>1;t[n]=c>>>0;}return t;})();
function zipBlob(files){
  const enc=new TextEncoder(),parts=[],central=[];let off=0;
  const d=new Date(),dt=((d.getFullYear()-1980)<<9)|((d.getMonth()+1)<<5)|d.getDate(),tm=(d.getHours()<<11)|(d.getMinutes()<<5)|(d.getSeconds()>>1);
  files.forEach(f=>{
    const name=enc.encode(f.path),data=enc.encode(f.text);let c=-1;for(let i=0;i<data.length;i++)c=CRC[(c^data[i])&255]^(c>>>8);c=(c^-1)>>>0;
    const h=new DataView(new ArrayBuffer(30));
    [[0,0x04034b50,4],[4,20,2],[6,0x0800,2],[8,0,2],[10,tm,2],[12,dt,2],[14,c,4],[18,data.length,4],[22,data.length,4],[26,name.length,2],[28,0,2]]
      .forEach(([o,v,n])=>n===4?h.setUint32(o,v,true):h.setUint16(o,v,true));
    const cd=new DataView(new ArrayBuffer(46));
    [[0,0x02014b50,4],[4,20,2],[6,20,2],[8,0x0800,2],[10,0,2],[12,tm,2],[14,dt,2],[16,c,4],[20,data.length,4],[24,data.length,4],[28,name.length,2],
     [30,0,2],[32,0,2],[34,0,2],[36,0,2],[38,0,4],[42,off,4]].forEach(([o,v,n])=>n===4?cd.setUint32(o,v,true):cd.setUint16(o,v,true));
    parts.push(h,name,data);central.push(cd,name);off+=30+name.length+data.length;});
  const size=central.reduce((s,x)=>s+x.byteLength,0),end=new DataView(new ArrayBuffer(22));
  [[0,0x06054b50,4],[4,0,2],[6,0,2],[8,files.length,2],[10,files.length,2],[12,size,4],[16,off,4],[20,0,2]]
    .forEach(([o,v,n])=>n===4?end.setUint32(o,v,true):end.setUint16(o,v,true));
  return new Blob([...parts,...central,end],{type:'application/zip'});
}

/* ══════════════ the IDE tab ══════════════
   [ files ]  [ code: file tabs · editor · error indicator ]  [ output: live preview | real PDF ]
   phones: files slide in from the left; output sits above the code, or either one full-screen */
const LSIDE='lx12_ide_v1';
const TPL={
 notes:{name:'My notes',main:'main.tex',files:[{path:'main.tex',text:L`\documentclass[12pt]{article}
\usepackage{makeidx}
\makeindex
\title{My Notes}
\author{Your Name}
\date{\today}
\begin{document}
\maketitle
\tableofcontents

\section{Introduction}
Write anything here. \LaTeX\index{LaTeX} was written by Leslie Lamport~\cite{lamport}.

\begin{itemize}
  \item a list item
  \item another one
\end{itemize}

\bibliographystyle{plain}
\bibliography{refs}
\printindex
\end{document}
`},{path:'refs.bib',text:L`@book{lamport,
  author    = {Leslie Lamport},
  title     = {{\LaTeX}: A Document Preparation System},
  publisher = {Addison-Wesley},
  edition   = {Second},
  year      = {1994}
}
`}]},
 report:{name:'Report with chapters',main:'main.tex',files:[{path:'main.tex',text:L`\documentclass[a4paper,12pt]{report}
% \includeonly{chapters/method}   % un-comment to typeset just one chapter
\title{A Project Report}
\author{Your Name}
\begin{document}
\maketitle
\tableofcontents

\include{chapters/intro}
\include{chapters/method}

\bibliographystyle{plain}
\bibliography{refs}
\end{document}
`},{path:'chapters/intro.tex',text:L`\chapter{Introduction}
Each chapter lives in its own file and is pulled in with \verb|\include|.
The main file holds only the preamble and the order of the chapters~\cite{primer}.
`},{path:'chapters/method.tex',text:L`\chapter{Method}
\section{Tables}
\input{chapters/table}
`},{path:'chapters/table.tex',text:L`\begin{tabular}{|l|r|}
\hline
Item & Marks \\ \hline
Theory & 60 \\
Practical & 40 \\ \hline
\end{tabular}
`},{path:'refs.bib',text:L`@manual{primer,
  author = {{Indian \TeX{} Users Group}},
  title  = {{\LaTeX} Tutorials: A Primer},
  year   = {2003}
}
`}]},
 blank:{name:'Blank article',main:'main.tex',files:[{path:'main.tex',text:L`\documentclass{article}
\begin{document}

\end{document}
`}]},
 letter:{name:'Letter',main:'main.tex',files:[{path:'main.tex',text:L`\documentclass{letter}
\signature{Your Name}
\address{Department of Mathematics \\ Your College}
\begin{document}
\begin{letter}{The Principal \\ Your College}
\opening{Dear Sir,}
I request two days of leave for the LaTeX workshop.
\closing{Yours faithfully,}
\end{letter}
\end{document}
`}]}
};
let ide=null;
function ideLoad(){
  try{ide=JSON.parse(localStorage.getItem(LSIDE));}catch(e){}
  if(!ide||!ide.projects){ide={projects:{},order:[],cur:null,ui:{}};newProject('notes',{id:'notes'});newProject('report',{id:'report',quiet:true});ide.cur='notes';}
  ide.ui=ide.ui||{};
}
const ideSave=debounce(()=>{try{localStorage.setItem(LSIDE,JSON.stringify(ide));}catch(e){toast('Storage full — download your project');}},350);
const P=()=>ide.projects[ide.cur];
function newProject(tpl,o){
  o=o||{};const t=TPL[tpl];let id=o.id||('p'+Date.now().toString(36));
  const files=(o.files||t.files).map(f=>({path:f.path,text:f.text}));
  const p={id,name:o.name||t.name,main:o.main||t.main,files,open:[o.main||t.main],cur:o.main||t.main,engine:'pdflatex',folders:[],t:Date.now()};
  if(o.orig)p.orig=files.map(f=>({path:f.path,text:f.text}));
  if(o.task)p.task=o.task;
  ide.projects[id]=p;ide.order=[id].concat((ide.order||[]).filter(x=>x!==id));
  return p;
}
/* open something from the Learn tab: an example keeps your edits until you reset it */
function openInIDE(spec){
  ideLoad0();
  const same=(a,b)=>a&&b&&a.length===b.length&&a.every((f,i)=>f.path===b[i].path&&f.text===b[i].text);
  let p=ide.projects[spec.id];
  if(!p||!same(p.orig,spec.files))p=newProject(null,{id:spec.id,name:spec.name,files:spec.files,main:spec.main,orig:spec.files,task:spec.task});
  else{p.name=spec.name;ide.order=[p.id].concat(ide.order.filter(x=>x!==p.id));}
  ide.cur=p.id;ideSave();
  IDE.from={view:curView,y:scrollY};
  showView('ide');IDE.load();
}
function ideLoad0(){if(!ide)ideLoad();}

const IDE={el:null,load:()=>{}};
function mountIDE(){
  if(IDE.el)return;ideLoad0();
  const host=$('#view-ide'),online=CFG.online;
  host.innerHTML=`<div class="ide" data-mode="split">
    <div class="ide-bar">
      <button class="ib" data-i="files" title="Show / hide files">☰</button>
      <button class="ib back" data-i="back" title="Back to where you were" hidden>←</button>
      <button class="projbtn" data-i="proj" title="Projects"><span>📁</span><b></b><span class="car">▾</span></button>
      <span class="grow"></span>
      <div class="seg"><button data-m="code">Code</button><button data-m="split">Split</button><button data-m="out">Output</button></div>
      <button class="ib hide-m" data-i="swap" title="Swap code and output">⇄</button>
      <button class="ib go" data-i="pdf" title="Compile with a real TeX Live (Ctrl+Enter)">⎙<span class="hide-m"> PDF</span></button>
      <button class="ib" data-i="more" title="More">⋯</button>
    </div>
    <aside class="ide-files" aria-label="Files">
      <div class="fh"><span>Files</span><span class="grow"></span>
        <button data-i="newfile" title="New file">＋</button><button data-i="newfolder" title="New folder">＋🗀</button><button data-i="upload" title="Upload .tex / .bib files">⤒</button></div>
      <div class="tree"></div>
      <div class="fmain"></div>
      <input type="file" multiple hidden accept=".tex,.bib,.sty,.cls,.bst,.txt,.csv,.ist,.ltx">
    </aside>
    <div class="scrim"></div>
    <div class="ide-main">
      <div class="ide-out lxed">
        <div class="out-back-bar">
          <button class="btn back-to-code" data-m="code">← Back to Code</button>
          <span class="grow"></span>
          <button class="recompile-btn" data-i="pdf">⎙ Recompile</button>
        </div>
        <div class="outwrap">
          <div class="pane on" data-p="pdf">${online?`
            <div class="pdfgate"><p><b>TeX Live Real PDF</b> — click <b>⎙ Compile</b> to typeset on <a href="https://texlive.net" target="_blank" rel="noopener">texlive.net</a>.</p>
              <p><button class="btn primary" data-i="pdf">⎙ Compile to PDF</button> <button class="btn" data-i="log">📄 View log</button></p></div>
            <iframe class="pdf" name="idepdf" title="Real PDF" hidden></iframe>
            <div class="spin"><span><i></i>TeX Live is compiling…</span></div>`:`
            <div class="pdfgate"><p><b>The IDE uses the online version.</b></p>
              <p>Compiling real PDFs uses the server-side TeX Live engine. Open the online version to compile and edit:</p>
              <p><a class="btn primary" href="${CFG.onlineURL}#ide" target="_blank" rel="noopener">Open IDE in Online Version</a></p>
              <p><button class="btn" data-i="zip">⤓ Download Project .zip</button></p></div>`}
          </div>
        </div>
        <div class="tabs">
          <button class="on" data-i="pdf">⎙ Compile PDF</button>
          <button data-i="log">📄 Log</button>
          <span class="grow"></span>
        </div>
      </div>
      <div class="ide-edit lxed">
        <div class="task" hidden></div>
        <div class="ftabs"></div>
        ${CODE_HTML}
        <div class="status"><span class="dot"></span><span class="txt">Ready</span><span class="count"></span></div>
        <div class="errlist"></div>
      </div>
    </div>
    <div class="drop">Drop .tex / .bib files to add them</div>
  </div>`;
  const w=$('.ide',host);IDE.el=w;
  const status=$('.status',w),list=$('.errlist',w),tree=$('.tree',w),ftabs=$('.ftabs',w);
  const pdfFrame=$('iframe.pdf',w),spin=$('.spin',w);
  if(pdfFrame)pdfFrame.addEventListener('load',()=>{
    if(pdfFrame.dataset.busy){spin.classList.remove('on');delete pdfFrame.dataset.busy;}
    if(!pdfFrame.hidden&&pdfFrame.src!=='about:blank'){const gate=$('.pdfgate',w);if(gate)gate.hidden=true;}
  });
  IDE.resetPDF=()=>{
    if(pdfFrame){pdfFrame.hidden=true;try{pdfFrame.src='about:blank';}catch(e){}delete pdfFrame.dataset.busy;}
    if(spin)spin.classList.remove('on');
    const gate=$('.pdfgate',w);if(gate)gate.hidden=false;
    $$('.tabs button',w).forEach(b=>b.classList.toggle('on',b.dataset.i==='pdf'));
    if(mobile())setMode('code');
  };
  let last=null;const scrolls={};
  const file=path=>P().files.find(f=>f.path===path);
  const ca=codeArea($('.ide-edit',w),{
    onInput:t=>{const f=file(P().cur);if(f){f.text=t;P().t=Date.now();ideSave();}run();},
    onRun:()=>realPDF('pdfjs'),onSave:()=>{ideSave();}});
  /* ui prefs */
  const ui=ide.ui;
  const mobile=()=>matchMedia('(max-width:899px)').matches;
  function setMode(m){if(mobile()&&m==='split')m='code';ui.mode=m;w.dataset.mode=m;$$('.seg button',w).forEach(b=>b.classList.toggle('on',b.dataset.m===m));ideSave();}
  setMode(ui.mode||'split');w.classList.toggle('swap',!!ui.swap);w.classList.toggle('nofiles',!!ui.nofiles);
  /* files */
  function paintTree(){
    const p=P(),errs=new Set((last?last.findings:[]).filter(f=>f.sev==='error').map(f=>f.file));
    const dirs=new Set(p.folders||[]);p.files.forEach(f=>{const parts=f.path.split('/');for(let i=1;i<parts.length;i++)dirs.add(parts.slice(0,i).join('/'));});
    const closed=p.closed||{};
    const items=[...dirs].map(d=>({path:d,dir:true})).concat(p.files.map(f=>({path:f.path})));
    items.sort((a,b)=>{const A=a.path.split('/'),B=b.path.split('/');
      for(let i=0;i<Math.min(A.length,B.length);i++){if(A[i]!==B[i]){const ad=i<A.length-1||a.dir,bd=i<B.length-1||b.dir;
        if(ad!==bd)return ad?-1:1;return A[i].localeCompare(B[i]);}}return A.length-B.length;});
    tree.innerHTML=items.filter(it=>{const parts=it.path.split('/');for(let i=1;i<parts.length;i++)if(closed[parts.slice(0,i).join('/')])return false;return true;})
      .map(it=>{const depth=it.path.split('/').length-1,name=it.path.split('/').pop();
        if(it.dir)return `<div class="row dir" data-dir="${esc(it.path)}" style="padding-left:${.4+depth*.9}rem"><span class="ic">${closed[it.path]?'▸':'▾'}</span><span class="nm">${esc(name)}/</span><button class="dot3" data-menu="${esc(it.path)}" data-isdir="1" title="Folder actions">⋯</button></div>`;
        const ic=/\.bib$/i.test(name)?'📚':isTeX(name)?'📄':'🗎';
        return `<div class="row${it.path===p.cur?' on':''}" data-p="${esc(it.path)}" style="padding-left:${.4+depth*.9}rem"><span class="ic">${ic}</span><span class="nm">${esc(name)}</span>
          ${errs.has(it.path)?'<span class="err" title="has errors"></span>':''}${it.path===p.main?'<span class="mainb" title="main file — compiled">main</span>':''}<button class="dot3" data-menu="${esc(it.path)}" title="File actions">⋯</button></div>`;}).join('')||
      '<div class="mini" style="padding:.6rem">No files. Tap ＋ to make one.</div>';
    $('.fmain',w).innerHTML=`Compiles <b>${esc(p.main)}</b>${p.files.length>1?' · '+p.files.length+' files':''}`;
    $('.projbtn b',w).textContent=p.name;
  }
  function paintTabs(){
    const p=P();p.open=(p.open||[]).filter(x=>file(x));if(p.cur&&!p.open.includes(p.cur))p.open.push(p.cur);
    ftabs.innerHTML=p.open.map(x=>`<div class="ft${x===p.cur?' on':''}" data-p="${esc(x)}" title="${esc(x)}"><span>${esc(x.split('/').pop())}</span><button class="x" data-close="${esc(x)}" aria-label="close">×</button></div>`).join('');
    const on=$('.ft.on',ftabs);if(on)on.scrollIntoView({block:'nearest',inline:'nearest'});
  }
  function openFile(path){
    const p=P();if(p.cur)scrolls[p.id+':'+p.cur]=ca.box.scrollTop;
    if(!file(path)){const t=p.files.find(f=>isTeX(f.path))||p.files[0];path=t?t.path:null;}
    p.cur=path;const f=file(path);
    ca.load(f?f.text:'',f?langOf(f.path):'latex');ca.ta.disabled=!f;
    ca.box.scrollTop=scrolls[p.id+':'+path]||0;
    paintTabs();paintTree();if(last)paintStatus();ideSave();
    if(mobile())w.classList.remove('files-open');
  }
  /* lint the whole project */
  const run=debounce(()=>{
    const p=P();last=compileProject(p.files,p.main);
    paintStatus();paintTree();checkTask();
  },260);
  function paintStatus(){
    const p=P(),F=last.findings;
    const marks={};F.filter(f=>f.file===p.cur).forEach(f=>{if(f.line&&(!marks[f.line]||f.sev==='error'))marks[f.line]=f.sev==='error'?'err':'warn';});
    ca.setMarks(marks);
    paintFindings(status,list,F,p.cur,(n,fl)=>{if(fl&&fl!==P().cur)openFile(fl);if(ui.mode==='out')setMode('split');ca.goLine(n);});
  }
  status.onclick=()=>{if(list.innerHTML)list.classList.toggle('on');};
  /* a challenge from the Learn tab travels with its checklist */
  function checkTask(){
    const p=P(),box=$('.task',w),d=p.task&&REG.w[p.task];
    if(!d){box.hidden=true;return;}
    const main=file(p.main),code=(main?main.text:'').replace(/(^|[^\\])%.*$/gm,'$1'),bib=(p.files.find(f=>/\.bib$/i.test(f.path))||{}).text||'';
    const res=(d.checks||[]).map(c=>({msg:c.msg,ok:new RegExp(c.re,c.flags||'').test(c.file==='bib'?bib:code)===!c.not}));
    if(d.kind==='fix')res.push({msg:'no '+(d.strictWarn?'errors or warnings':'errors')+' in the indicator',
      ok:!last.findings.some(f=>f.sev==='error'||(d.strictWarn&&f.sev==='warning'))});
    const all=res.every(x=>x.ok);
    box.hidden=false;box.classList.toggle('solved',all);
    box.innerHTML=`<div class="tk"><span class="tag">${d.kind==='fix'?'Fix the bug':'Build this'}</span><b>${d.title||''}</b><span class="grow"></span>
      <button class="minibtn" data-i="taskfold">${box.dataset.fold?'show':'hide'}</button></div>
      ${box.dataset.fold?'':`${d.brief?`<p>${d.brief}</p>`:''}<ul>${res.map(x=>`<li class="${x.ok?'ok':''}">${x.msg}</li>`).join('')}</ul>`}
      <div class="tkm">${all?'<b class="good">✓ Every check passes — solved.</b>':'The checklist updates as you type.'}</div>`;
    if(all&&!(state.quiz||{})[p.task]){record(p.task,1);toast('Challenge solved ✓');}
  }
  /* real PDF of the whole project */
  function realPDF(mode){
    if(!CFG.online){toast('Compiling requires the online version');return;}
    const p=P();if(!file(p.main)){toast('Set a main .tex file first');return;}
    if(mobile())setMode('out');else if(ui.mode==='code')setMode('split');
    const gate=$('.pdfgate',w);if(gate)gate.hidden=true;
    pdfFrame.hidden=false;pdfFrame.dataset.busy='1';spin.classList.add('on');
    submitPDF(p.files,p.main,'idepdf',mode,p.engine);
    setTimeout(()=>spin.classList.remove('on'),30000);
  }
  /* menus */
  let menu=null;
  const closeMenu=()=>{if(menu){menu.remove();menu=null;}};
  function openMenu(anchor,items){
    closeMenu();menu=el(`<div class="menu" role="menu">${items.map((it,i)=>it==='-'?'<hr>':it.head?`<div class="mh2">${esc(it.head)}</div>`:
      `<button data-mi="${i}" class="${it.cur?'cur':''}${it.danger?' danger':''}"${it.dis?' disabled':''}>${it.icon?`<span>${it.icon}</span>`:''}<span>${esc(it.label)}</span>${it.hint?`<small>${esc(it.hint)}</small>`:''}</button>`).join('')}</div>`);
    w.appendChild(menu);
    const r=anchor.getBoundingClientRect(),mw=menu.offsetWidth,mh=menu.offsetHeight;
    let x=Math.min(r.left,innerWidth-mw-8),y=r.bottom+4;if(y+mh>innerHeight-8)y=Math.max(8,r.top-mh-4);
    menu.style.left=Math.max(8,x)+'px';menu.style.top=y+'px';
    menu.addEventListener('click',e=>{const b=e.target.closest('[data-mi]');if(!b)return;const it=items[+b.dataset.mi];closeMenu();it.act&&it.act();});
  }
  document.addEventListener('pointerdown',e=>{if(menu&&!menu.contains(e.target)&&!e.target.closest('[data-i="proj"],[data-i="more"],[data-menu]'))closeMenu();});
  const validPath=s=>/^[A-Za-z0-9_.\-]+(\/[A-Za-z0-9_.\-]+)*$/.test(s)&&!/(^|\/)\.\.?(\/|$)/.test(s);
  async function newFile(dir){
    const v=await ask({title:'New file',msg:'Use folders with a slash, e.g. <code>chapters/intro.tex</code>. Only letters, digits, <code>- _ .</code>',value:(dir?dir+'/':'')+'untitled.tex',ok:'Create'});
    if(!v)return;let path=v.replace(/^\/+/,'');if(!/\.\w+$/.test(path))path+='.tex';
    if(!validPath(path)){toast('That name has characters LaTeX dislikes');return;}
    if(file(path)){toast(path+' already exists');openFile(path);return;}
    const stem=path.replace(/\.tex$/,'');
    P().files.push({path,text:isTeX(path)?`% ${path} — bring it into ${P().main} with \\input{${stem}}\n`:/\.bib$/i.test(path)?'@book{key,\n  author    = {},\n  title     = {},\n  publisher = {},\n  year      = {}\n}\n':''});
    P().folders=(P().folders||[]).filter(d=>!path.startsWith(d+'/'));
    openFile(path);run();
  }
  async function newFolder(){
    const v=await ask({title:'New folder',value:'chapters',ok:'Create',selectAll:true});if(!v)return;
    const d=v.replace(/^\/+|\/+$/g,'');if(!validPath(d)){toast('Letters, digits, - _ . only');return;}
    P().folders=[...new Set((P().folders||[]).concat(d))];paintTree();ideSave();
  }
  async function renamePath(path,isDir){
    const v=await ask({title:isDir?'Rename folder':'Rename or move',msg:isDir?'':'Change the folder part to move it, e.g. <code>chapters/'+esc(path.split('/').pop())+'</code>',value:path,ok:'Rename'});
    if(!v||v===path)return;const to=v.replace(/^\/+|\/+$/g,'');if(!validPath(to)){toast('Letters, digits, - _ . and / only');return;}
    const p=P();
    if(isDir){p.files.forEach(f=>{if(f.path.startsWith(path+'/'))f.path=to+f.path.slice(path.length);});
      p.folders=(p.folders||[]).map(d=>d===path||d.startsWith(path+'/')?to+d.slice(path.length):d);
      if(p.main.startsWith(path+'/'))p.main=to+p.main.slice(path.length);
      p.open=p.open.map(x=>x.startsWith(path+'/')?to+x.slice(path.length):x);if(p.cur&&p.cur.startsWith(path+'/'))p.cur=to+p.cur.slice(path.length);}
    else{if(file(to)){toast(to+' already exists');return;}const f=file(path);f.path=to;if(p.main===path)p.main=to;
      p.open=p.open.map(x=>x===path?to:x);if(p.cur===path)p.cur=to;
      if(isTeX(path)){const a=path.replace(/\.tex$/,''),b=to.replace(/\.tex$/,'');
        const refs=p.files.filter(g=>new RegExp('\\\\(input|include)\\s*\\{'+a.replace(/[.*+?^${}()|[\]\\]/g,'\\$&')+'(\\.tex)?\\}').test(g.text));
        if(refs.length){refs.forEach(g=>g.text=g.text.replace(new RegExp('(\\\\(input|include)\\s*\\{)'+a.replace(/[.*+?^${}()|[\]\\]/g,'\\$&')+'(\\.tex)?(\\})','g'),'$1'+b+'$3'));
          toast('Updated \\input in '+refs.length+' file'+(refs.length>1?'s':''));}}}
    paintTree();paintTabs();ideSave();
  }
  function fileMenu(anchor,path,isDir){
    const p=P();
    if(isDir){
      openMenu(anchor,[
        {icon:'＋',label:'New file in '+path,act:()=>newFile(path)},
        {icon:'✎',label:'Rename folder',act:()=>renamePath(path,true)},
        {icon:'✕',label:'Delete folder',danger:true,act:async()=>{
          const inside=p.files.filter(f=>f.path.startsWith(path+'/'));
          if(!await ask({title:'Delete folder “'+path+'”?','msg':inside.length?inside.length+' file'+(inside.length>1?'s':'')+' inside will be deleted.':'',ok:'Delete',danger:true}))return;
          p.files=p.files.filter(f=>!f.path.startsWith(path+'/'));p.folders=(p.folders||[]).filter(d=>d!==path&&!d.startsWith(path+'/'));
          p.open=p.open.filter(x=>!x.startsWith(path+'/'));if(p.cur&&p.cur.startsWith(path+'/'))openFile(p.open[0]||p.main);
          paintTree();ideSave();}}
      ]);
      return;
    }
    openMenu(anchor,[
      isTeX(path)?{icon:'★',label:'Set as main file',dis:p.main===path,hint:p.main===path?'it is':'',act:()=>{p.main=path;paintTree();run();ideSave();toast(path+' is now compiled');}}:null,
      {icon:'✎',label:'Rename or move',act:()=>renamePath(path,false)},
      {icon:'⧉',label:'Duplicate',act:()=>{const f=file(path);const np=path.replace(/(\.\w+)?$/, '-copy$1');
        p.files.push({path:np,text:f.text});openFile(np);paintTree();ideSave();}},
      {icon:'⤓',label:'Download file',act:()=>{const f=file(path);saveFile(f.path.split('/').pop(),new Blob([f.text],{type:'text/plain'}));}},
      p.files.length>1?{icon:'✕',label:'Delete',danger:true,act:async()=>{
        if(!await ask({title:'Delete “'+path+'”?',ok:'Delete',danger:true}))return;
        p.files=p.files.filter(f=>f.path!==path);p.open=p.open.filter(x=>x!==path);
        if(p.main===path)p.main=(p.files.find(f=>isTeX(f.path))||p.files[0]).path;
        if(p.cur===path)openFile(p.open[0]||p.main);else paintTree();run();ideSave();}}:null
    ].filter(Boolean));
  }
  function projMenu(anchor){
    closeMenu();
    openMenu(anchor,[
      {head:'Projects'}
    ].concat(ide.order.map(id=>({
      icon:id===ide.cur?'●':'○',cur:id===ide.cur,
      label:ide.projects[id].name,
      hint:ide.projects[id].files.length+' file'+(ide.projects[id].files.length>1?'s':''),
      act:()=>{ide.cur=id;ideSave();IDE.load();}
    }))).concat([
      '-',
      {icon:'＋',label:'New project…',act:async()=>{
        const keys=Object.keys(TPL);
        const r=await ask({title:'New project',value:'Untitled project',options:keys.map(k=>({label:TPL[k].name,desc:TPL[k].files.map(f=>f.path).join(', ')}))});
        if(!r)return;const np=newProject(keys[r.option],{name:r.value||TPL[keys[r.option]].name});ide.cur=np.id;ideSave();IDE.load();}},
      {icon:'⧉',label:'Duplicate project',act:()=>{const np=newProject(null,{name:p.name+' (copy)',files:p.files,main:p.main});ide.cur=np.id;ideSave();IDE.load();}}
    ]));
  }
  function moreMenu(anchor){
    const p=P(),E=[['pdflatex','pdfLaTeX'],['xelatex','XeLaTeX'],['lualatex','LuaLaTeX']];
    openMenu(anchor,[
      {icon:'⤓',label:'Download project as .zip',hint:'Opens in Overleaf',act:()=>saveFile(p.name.replace(/[^\w\-]+/g,'_')+'.zip',zipBlob(p.files))},
      p.orig?{icon:'↺',label:'Reset to original code',danger:true,act:async()=>{
        if(!await ask({title:'Reset “'+p.name+'”?',msg:'Discards all your edits and restores the original example.',ok:'Reset',danger:true}))return;
        p.files=p.orig.map(f=>({path:f.path,text:f.text}));p.open=[p.main];p.cur=p.main;ideSave();IDE.load();}}:null,
      '-',
      {head:'Real PDF engine'}
    ].concat(E.map(([k,n])=>({icon:(p.engine||'pdflatex')===k?'●':'○',label:n,cur:(p.engine||'pdflatex')===k,act:()=>{p.engine=k;ideSave();toast('Real PDF will use '+n);}}))).concat([
      '-',
      ide.order.length>1?{icon:'✕',label:'Delete project',danger:true,act:async()=>{
        if(!await ask({title:'Delete “'+p.name+'”?',msg:'All its files go. This cannot be undone.',ok:'Delete',danger:true}))return;
        delete ide.projects[p.id];ide.order=ide.order.filter(x=>x!==p.id);ide.cur=ide.order[0];ideSave();IDE.load();}}:null
    ].filter(Boolean)));
  }
  /* upload */
  function addFiles(list){
    const p=P();let n=0,last2=null;
    for(const f of list){
      if(!TEXTEXT.test(f.name)){toast(f.name+': only text files (.tex, .bib, .sty …)');continue;}
      if(f.size>800000){toast(f.name+' is too large');continue;}
      const r=new FileReader();r.onload=()=>{const path=f.name;
        const ex=file(path);if(ex)ex.text=r.result;else p.files.push({path,text:r.result});
        last2=path;n++;if(n===list.length){openFile(last2);run();toast(n+' file'+(n>1?'s':'')+' added');}};
      r.readAsText(f);
    }
  }
  $('input[type=file]',w).addEventListener('change',e=>{addFiles([...e.target.files]);e.target.value='';});
  let dragN=0;
  w.addEventListener('dragenter',e=>{if([...(e.dataTransfer.types||[])].includes('Files')){dragN++;w.classList.add('dragging');}});
  w.addEventListener('dragleave',()=>{if(--dragN<=0){dragN=0;w.classList.remove('dragging');}});
  w.addEventListener('dragover',e=>{if(w.classList.contains('dragging'))e.preventDefault();});
  w.addEventListener('drop',e=>{e.preventDefault();dragN=0;w.classList.remove('dragging');addFiles([...e.dataTransfer.files]);});
  w.addEventListener('click',e=>{
    const mm=e.target.closest('[data-m]');if(mm){setMode(mm.dataset.m);return;}
    const cl=e.target.closest('[data-close]');if(cl){const p=P(),x=cl.dataset.close;const k=p.open.indexOf(x);p.open=p.open.filter(y=>y!==x);
      if(p.cur===x)openFile(p.open[Math.max(0,k-1)]||p.main);else paintTabs();ideSave();return;}
    const me=e.target.closest('[data-menu]');if(me){e.stopPropagation();fileMenu(me,me.dataset.menu,!!me.dataset.isdir);return;}
    const row=e.target.closest('.tree .row[data-p], .ftabs .ft');if(row){openFile(row.dataset.p);return;}
    const dr=e.target.closest('.tree .row[data-dir]');if(dr){const p=P();p.closed=p.closed||{};p.closed[dr.dataset.dir]=!p.closed[dr.dataset.dir];paintTree();ideSave();return;}
    if(e.target.classList.contains('scrim')){w.classList.remove('files-open');return;}
    const b=e.target.closest('[data-i]');if(!b)return;const a=b.dataset.i;
    if(a==='files'){if(mobile())w.classList.toggle('files-open');else{ui.nofiles=!ui.nofiles;w.classList.toggle('nofiles',ui.nofiles);ideSave();}}
    else if(a==='back'&&IDE.from){const f=IDE.from;IDE.from=null;b.hidden=true;showView(f.view);setTimeout(()=>scrollTo(0,f.y),30);}
    else if(a==='proj')projMenu(b);
    else if(a==='more')moreMenu(b);
    else if(a==='swap'){ui.swap=!ui.swap;w.classList.toggle('swap',ui.swap);ideSave();}
    else if(a==='pdf'){$$('.tabs button',w).forEach(b=>b.classList.toggle('on',b.dataset.i==='pdf'));realPDF('pdfjs');}
    else if(a==='log'){$$('.tabs button',w).forEach(b=>b.classList.toggle('on',b.dataset.i==='log'));realPDF('log');}
    else if(a==='zip'){const p=P();saveFile(p.name.replace(/[^\w\-]+/g,'_')+'.zip',zipBlob(p.files));}
    else if(a==='newfile')newFile();
    else if(a==='newfolder')newFolder();
    else if(a==='upload')$('input[type=file]',w).click();
    else if(a==='taskfold'){const box=$('.task',w);if(box.dataset.fold)delete box.dataset.fold;else box.dataset.fold='1';checkTask();}
  });
  /* phones: while typing, the bottom bar steps aside for the keyboard */
  ca.ta.addEventListener('focus',()=>{if(mobile())document.body.classList.add('typing');});
  ca.ta.addEventListener('blur',()=>setTimeout(()=>{if(document.activeElement!==ca.ta)document.body.classList.remove('typing');},150));
  IDE.load=()=>{closeMenu();if(IDE.resetPDF)IDE.resetPDF();const p=P();$('.task',w).hidden=!p.task;delete $('.task',w).dataset.fold;last=null;
    $('[data-i="back"]',w).hidden=!IDE.from;openFile(p.cur||p.main);run();};
  IDE.fit=()=>{};
  IDE.load();
}

/* ══════════════ example blocks: the convenient part; full code in the code window ══════════════ */
function hydrateEx(box){
  if(box.dataset.h)return;box.dataset.h='1';
  const d=REG.ex[box.dataset.ex];if(!d)return;
  exampleBox(box,d,box.dataset.ex,false);
}
function exampleBox(box,d,id,autoRun){
  let curSnippet=d.snippet;
  let curBib=d.bib||'';
  let curTab='tex';
  const hasBib=d.bib!==undefined;
  const getSpec=()=>{
    const spec=exSpec(id,d,curSnippet);
    if(hasBib){
      const bf=spec.files.find(f=>/\.bib$/i.test(f.path));
      if(bf)bf.text=curBib;
      else spec.files.push({path:'refs.bib',text:curBib});
    }
    return spec;
  };
  box.innerHTML=`<div class="exh"><span class="lbl">${d.title?'<b>'+esc(d.title)+'</b>':'example'}${d.file&&!hasBib?' · '+esc(d.file):''}</span>
    ${hasBib?`<div class="ex-tabs"><button class="ex-tab on" data-extab="tex">document.tex</button><button class="ex-tab" data-extab="bib">refs.bib</button></div>`:''}
    <span class="grow"></span>
    <button class="minibtn" data-a="full" title="See the whole file">full code</button>
    <button class="minibtn" data-a="copy">copy</button>
    <button class="minibtn reset-btn" data-a="reset" hidden title="Reset code to original">⟲ reset</button>
    <button class="minibtn go" data-a="run">▶ run</button></div>
    <div class="ex-ed"><pre class="ex-hl" aria-hidden="true"></pre>
      <textarea class="ex-ta" spellcheck="false" autocapitalize="off" autocomplete="off" autocorrect="off" wrap="soft" aria-label="source">${esc(d.snippet)}</textarea></div>
    ${d.note?`<div class="exfoot">${d.note}</div>`:''}<div class="edslot"></div>`;

  const slot=$('.edslot',box),rb=$('[data-a="run"]',box),rst=$('[data-a="reset"]',box);
  const ta=$('.ex-ta',box),pre=$('.ex-hl',box);

  const curContent=()=>curTab==='tex'?curSnippet:curBib;
  const curLang=()=>curTab==='tex'?(d.lang||'latex'):'bibtex';

  const paint=()=>{
    pre.innerHTML=hl(curContent(),curLang());
    rst.hidden=(curSnippet===d.snippet&&curBib===(d.bib||''));
  };
  paint();

  const updatePreview=debounce(()=>{
    if(!slot.hidden&&slot.firstChild)previewBlock(slot,getSpec());
  },300);

  ta.addEventListener('input',()=>{
    const v=ta.value;
    if(curTab==='tex'){if(v===curSnippet)return;curSnippet=v;}
    else{if(v===curBib)return;curBib=v;}
    paint();
    updatePreview();
  });
  ta.addEventListener('scroll',()=>{if(ta.scrollTop!==0||ta.scrollLeft!==0){ta.scrollTop=0;ta.scrollLeft=0;}});

  ta.addEventListener('keydown',e=>{
    if(e.key==='Tab'){
      e.preventDefault();
      const s=ta.selectionStart;ta.setRangeText('  ',s,ta.selectionEnd,'end');
      if(curTab==='tex')curSnippet=ta.value;else curBib=ta.value;
      paint();updatePreview();
    }else if(e.key==='Enter'&&!e.ctrlKey&&!e.metaKey){
      const s=ta.selectionStart,v=ta.value,ls=v.lastIndexOf('\n',s-1)+1,ind=(/^[ \t]*/.exec(v.slice(ls))||[''])[0];
      if(ind){e.preventDefault();ta.setRangeText('\n'+ind,s,ta.selectionEnd,'end');
        if(curTab==='tex')curSnippet=ta.value;else curBib=ta.value;
        paint();updatePreview();}
    }else if(e.key==='Enter'&&(e.ctrlKey||e.metaKey)){
      e.preventDefault();run();
    }
  });

  if(hasBib){
    $$('.ex-tab',box).forEach(tb=>{
      tb.onclick=()=>{
        const t=tb.dataset.extab;if(t===curTab)return;
        curTab=t;
        $$('.ex-tab',box).forEach(x=>x.classList.toggle('on',x===tb));
        ta.value=curContent();
        paint();
      };
    });
  }

  const run=()=>{
    if(slot.firstChild&&!slot.hidden){slot.hidden=true;rb.textContent='▶ run';return;}
    slot.hidden=false;previewBlock(slot,getSpec());rb.textContent='▾ hide';
  };

  const reset=()=>{
    curSnippet=d.snippet;curBib=d.bib||'';
    ta.value=curContent();
    paint();
    if(!slot.hidden&&slot.firstChild)previewBlock(slot,getSpec());
    toast('Reset to original');
  };

  box.addEventListener('click',e=>{
    const b=e.target.closest('[data-a]');if(!b||b.closest('.pvb'))return;
    if(b.dataset.a==='full')openCode(Object.assign({title:d.title||'Full code'},getSpec()));
    else if(b.dataset.a==='copy')copyText(curContent(),'Copied');
    else if(b.dataset.a==='run')run();
    else if(b.dataset.a==='reset')reset();
  });
  if(autoRun)run();
}

/* ══════════════ practice widgets ══════════════ */
const WIDGETS={omr,cards,match,fill,parsons,predict,challenge,
  editor:(box,d,key)=>{box.classList.add('ex');exampleBox(box,{snippet:d.code,full:d.code,bib:d.bib,title:d.title||'Try it — then edit it in the IDE'},key,true);}};
function hydrateW(box){
  if(box.dataset.h)return;box.dataset.h='1';
  const d=REG.w[box.dataset.w];if(!d||!WIDGETS[d.type])return;
  WIDGETS[d.type](box,d,box.dataset.w);
}
function shell(box,tag,title,body,foot){
  box.classList.add('wg');
  box.innerHTML=`<div class="wh"><span class="tag">${tag}</span><span class="ttl">${title||''}</span><span class="sc"></span></div>
    <div class="wb">${body}</div>${foot!==false?`<div class="wf">${foot||''}</div>`:''}`;
  return {b:$('.wb',box),f:$('.wf',box),sc:$('.sc',box)};
}
const asDoc=s=>/^\s*\\documentclass/m.test(s)?s:
  `\\documentclass{${/\\chapter/.test(s)?'report':'article'}}\n${/\\index/.test(s)?'\\usepackage{makeidx}\n\\makeindex\n':''}\\begin{document}\n${s}\n\\end{document}`;
const record=(key,val)=>{state.quiz=state.quiz||{};state.quiz[key]=val;persist();document.dispatchEvent(new CustomEvent('lx:quiz',{detail:key}));};
const content=x=>{if(x&&typeof x==='object'){if(x.code)return hlInline(x.code,x.lang);if(x.tex)return `<span class="texr">${LXTeX.renderInline(x.tex)}</span>`;}
  return String(x);};

/* OMR sheet — retrieval practice, the most robust study technique there is */
function omr(box,d,key){
  const letters='ABCD',N=d.qs.length,long=N>12;
  const body=`<div class="omr"><div class="rollrow">Answer sheet <i></i><i></i><i></i><i></i> fill one bubble per question</div>`+
    d.qs.map((q,i)=>`<div class="q" data-q="${i}"><span class="qn">${String(i+1).padStart(2,'0')}</span><span class="qt">${q.q}</span>
      <div class="opts">${q.o.map((o,j)=>`<div class="opt" data-j="${j}"><span class="bub">${letters[j]}</span><span>${content(o)}</span></div>`).join('')}</div>
      ${q.why?`<div class="why">${q.why}</div>`:''}</div>`).join('')+'</div>';
  const u=shell(box,'OMR · '+N+' questions',d.title,body,
    `<button class="btn primary" data-a="mark">Submit sheet</button><button class="btn" data-a="reset">Clear</button>${long?'<button class="btn" data-a="wrong" hidden>Only my mistakes</button>':''}<span class="msg"></span>`);
  if(long)box.classList.add('long');
  const sheet=$('.omr',u.b),pick={};
  const best=()=>(state.quiz||{})[key];
  const head=()=>{const n=Object.keys(pick).length;u.sc.textContent=(sheet.classList.contains('marked')||!n?'':n+'/'+N+' answered')+(best()!==undefined?(n&&!sheet.classList.contains('marked')?' · ':'')+'best '+best()+'/'+N:'');};
  head();
  u.b.addEventListener('click',e=>{if(sheet.classList.contains('marked'))return;
    const o=e.target.closest('.opt');if(!o)return;const q=o.closest('.q');
    $$('.opt',q).forEach(x=>x.classList.remove('sel'));o.classList.add('sel');pick[q.dataset.q]=+o.dataset.j;head();
    if(!long)return;const msg=$('.msg',u.f);if(Object.keys(pick).length===N)msg.textContent='All answered — submit when ready.';});
  u.f.addEventListener('click',e=>{const a=e.target.closest('[data-a]');if(!a)return;
    const wb=$('[data-a="wrong"]',u.f);
    if(a.dataset.a==='wrong'){sheet.classList.toggle('onlywrong');a.textContent=sheet.classList.contains('onlywrong')?'Show every question':'Only my mistakes';
      box.scrollIntoView({block:'start',behavior:'smooth'});return;}
    if(a.dataset.a==='reset'){sheet.classList.remove('marked','onlywrong');$$('.opt',sheet).forEach(x=>x.className='opt');$$('.q',sheet).forEach(x=>x.classList.remove('bad'));
      for(const k in pick)delete pick[k];$('.msg',u.f).textContent='';if(wb){wb.hidden=true;wb.textContent='Only my mistakes';}head();return;}
    if(sheet.classList.contains('marked'))return;
    const blank=N-Object.keys(pick).length;
    if(long&&blank&&!a.dataset.sure){a.dataset.sure='1';$('.msg',u.f).innerHTML=`<b>${blank} left blank.</b> Tap Submit again to mark anyway.`;return;}
    delete a.dataset.sure;
    let n=0;d.qs.forEach((q,i)=>{const row=$(`.q[data-q="${i}"]`,sheet);
      if(pick[i]!==q.a)row.classList.add('bad');
      $$('.opt',row).forEach((o,j)=>{o.classList.remove('sel');
        if(j===q.a&&pick[i]===j){o.classList.add('right');n++;}
        else if(pick[i]===j)o.classList.add('wrong');
        else if(j===q.a)o.classList.add('miss');});});
    sheet.classList.add('marked');
    const pct=n/N;
    $('.msg',u.f).innerHTML=`<b class="${pct>=.6?'good':'badc'}">${n}/${N}</b> — ${pct===1?'perfect.':pct>=.6?'good; read the notes on the ones you missed.':'re-read the topic, then retry tomorrow — spacing beats cramming.'}`;
    if(wb&&n<N)wb.hidden=false;
    const b0=best()||0;if(n>=b0)record(key,n);head();});
}

/* 3-D flashcards with a Leitner schedule — spaced repetition in the smallest form */
function cards(box,d,key){
  const u=shell(box,'Flashcards · '+d.list.length,d.title,
    `<div class="deck"><div class="card3d"><div class="face front"></div><div class="face back"></div></div></div>
     <div class="deckbar"><button class="btn" data-a="again">✗ Again</button><button class="btn" data-a="flip">Flip</button><button class="btn primary" data-a="got">✓ Got it</button></div>
     <div class="boxes"></div>`,false);
  const L=(state.cards=state.cards||{})[key]||(state.cards[key]={});   // card index → box 0..4
  const c=$('.card3d',u.b);let order=[],i=0,flipped=false;
  const due=()=>{order=d.list.map((_,k)=>k).sort((a,b)=>(L[a]||0)-(L[b]||0)||(hash(key+a)%97)-(hash(key+b)%97));i=0;};
  const face=(x,k)=>`<span class="k">${k}</span>${typeof x==='object'&&(x.code||x.tex)?content(x):`<div class="big">${x}</div>`}`;
  function show(anim){
    const k=order[i%order.length],card=d.list[k];flipped=false;c.classList.remove('flip','out-r','out-l');
    $('.front',c).innerHTML=face(card.f,'front · tap to flip')+'<span class="hint">swipe → got it · ← again</span>';
    $('.back',c).innerHTML=face(card.b,'back');
    if(anim){c.classList.remove('in');void c.offsetWidth;c.classList.add('in');}
    const counts=[0,0,0,0,0];d.list.forEach((_,j)=>counts[Math.min(4,L[j]||0)]++);
    $('.boxes',u.b).innerHTML=counts.map((n,b)=>`<span title="Leitner box ${b+1}">box ${b+1}: <b>${n}</b></span>`).join('');
    const known=d.list.filter((_,j)=>(L[j]||0)>=1).length;
    const mastered=counts[4]+counts[3];
    u.sc.textContent=known+' / '+d.list.length+' known'+(mastered?' ('+mastered+' mastered)':'');
    const b0=(state.quiz||{})[key]||0;if(known>b0)record(key,known);
  }
  const flip=()=>{flipped=!flipped;c.classList.toggle('flip',flipped);};
  const grade=g=>{const k=order[i%order.length];L[k]=g?Math.min(4,(L[k]||0)+1):0;persist();
    c.classList.add(g?'out-r':'out-l');
    setTimeout(()=>{i++;if(i>=order.length)due();show(true);},380);};
  c.addEventListener('click',flip);
  u.b.addEventListener('click',e=>{const a=e.target.closest('[data-a]');if(!a)return;
    if(a.dataset.a==='flip')flip();else grade(a.dataset.a==='got');});
  let sx=null;c.addEventListener('pointerdown',e=>{sx=e.clientX;});
  c.addEventListener('pointerup',e=>{if(sx===null)return;const dx=e.clientX-sx;sx=null;if(Math.abs(dx)>60){e.stopPropagation();grade(dx>0);}});
  box.tabIndex=0;box.addEventListener('keydown',e=>{if(e.key===' '){e.preventDefault();flip();}if(e.key==='ArrowRight')grade(true);if(e.key==='ArrowLeft')grade(false);});
  due();show(false);
}

/* match the following — tap a left item, then its partner */
const PAIRC=['#C4391D','#2B4C91','#237A4A','#8A4FB3','#B07014','#1F7F86','#B0306B','#5B6B2A','#6D4C41','#3F51B5'];
function match(box,d,key){
  const L=d.pairs.map((p,i)=>({i,t:p[0]})),R=shuffle(d.pairs.map((p,i)=>({i,t:p[1]})),hash(key));
  const u=shell(box,'Match the following',d.title,
    `<div class="match"><div class="colh">${d.left||'Column A'}</div><div class="colh">${d.right||'Column B'}</div>`+
    L.map((l,k)=>`<div class="it" data-s="L" data-i="${l.i}" style="grid-column:1;grid-row:${k+2}"><span class="pn">${k+1}</span><span>${content(l.t)}</span></div>`).join('')+
    R.map((r,k)=>`<div class="it" data-s="R" data-i="${r.i}" style="grid-column:2;grid-row:${k+2}"><span class="pn">${String.fromCharCode(97+k)}</span><span>${content(r.t)}</span></div>`).join('')+
    '</div>','<button class="btn primary" data-a="check">Check</button><button class="btn" data-a="show">Show answers</button><button class="btn" data-a="reset">Reset</button><span class="msg"></span>');
  const pair={};let pickL=null,pickR=null;let col=0;const colour={};
  const paint=()=>{$$('.it',u.b).forEach(x=>{x.classList.remove('pick','ok','no','paired');x.style.borderColor='';$('.pn',x).style.background='';});
    Object.keys(pair).forEach(l=>{const r=pair[l],c=colour[l];
      [$(`.it[data-s="L"][data-i="${l}"]`,u.b),$(`.it[data-s="R"][data-i="${r}"]`,u.b)].forEach(x=>{x.classList.add('paired');x.style.borderColor=c;$('.pn',x).style.background=c;});});
    if(pickL!==null)$(`.it[data-s="L"][data-i="${pickL}"]`,u.b).classList.add('pick');
    if(pickR!==null)$(`.it[data-s="R"][data-i="${pickR}"]`,u.b).classList.add('pick');};
  u.b.addEventListener('click',e=>{const it=e.target.closest('.it');if(!it)return;const i=+it.dataset.i;
    if(it.dataset.s==='L'){if(pair[i]!==undefined){delete pair[i];pickL=null;}else pickL=pickL===i?null:i;}
    else{const owner=Object.keys(pair).find(l=>pair[l]===i);if(owner!==undefined){delete pair[owner];pickR=null;}else pickR=pickR===i?null:i;}
    if(pickL!==null&&pickR!==null){pair[pickL]=pickR;colour[pickL]=PAIRC[(col++)%PAIRC.length];pickL=pickR=null;}
    paint();});
  u.f.addEventListener('click',e=>{const a=e.target.closest('[data-a]');if(!a)return;
    if(a.dataset.a==='reset'){for(const k in pair)delete pair[k];pickL=pickR=null;paint();$('.msg',u.f).textContent='';return;}
    if(a.dataset.a==='show'){for(const k in pair)delete pair[k];L.forEach(l=>{pair[l.i]=l.i;colour[l.i]=PAIRC[l.i%PAIRC.length];});paint();}
    let n=0;L.forEach(l=>{const x=$(`.it[data-s="L"][data-i="${l.i}"]`,u.b);
      if(pair[l.i]===undefined)return;const ok=pair[l.i]===l.i;if(ok)n++;
      x.classList.add(ok?'ok':'no');$(`.it[data-s="R"][data-i="${pair[l.i]}"]`,u.b).classList.add(ok?'ok':'no');});
    $('.msg',u.f).innerHTML=`<b class="${n===L.length?'good':''}">${n}/${L.length}</b> correct`;
    if(a.dataset.a==='check'){const b0=(state.quiz||{})[key]||0;if(n>b0)record(key,n);}});
}

/* fill in the blanks — [[answer|alternative]] marks a gap */
function fill(box,d,key){
  const answers=[];let k=0;
  const src=d.code?esc(d.text):d.text;
  const html=src.replace(/\[\[(.+?)\]\]/g,(m,a)=>{const alts=a.split('¦').map(x=>d.code?x.replace(/&amp;/g,'&').replace(/&lt;/g,'<').replace(/&gt;/g,'>'):x);
    answers.push(alts);const w=Math.max(...alts.map(x=>x.length),1);
    return `<input data-k="${k++}" style="width:${w}ch" autocomplete="off" autocapitalize="off" spellcheck="false" aria-label="blank ${k}">`;});
  const u=shell(box,'Fill in the blanks',d.title,`<div class="fillt${d.code?' code':''}">${html}</div>${d.code?'<div class="fillrun"></div>':''}`,
    '<button class="btn primary" data-a="check">Check</button><button class="btn" data-a="show">Reveal</button>'+(d.code?'<button class="btn" data-a="run">▶ run the result</button>':'')+'<span class="msg"></span>');
  const norm=s=>s.trim().replace(/\s+/g,' ');
  const updateW=i=>{const alts=answers[+i.dataset.k],want=Math.max(...alts.map(x=>x.length),1);
    i.style.width=Math.max(i.value.length||want,1)+'ch';};
  u.b.addEventListener('input',e=>{if(e.target.matches('input'))updateW(e.target);});
  const check=()=>{let n=0;$$('input',u.b).forEach(i=>{const ok=answers[+i.dataset.k].some(a=>norm(a)===norm(i.value)||(!d.strict&&norm(a).toLowerCase()===norm(i.value).toLowerCase()));
      i.classList.toggle('ok',ok);i.classList.toggle('no',!ok&&i.value!=='');if(ok)n++;updateW(i);});
    $('.msg',u.f).innerHTML=`<b class="${n===answers.length?'good':''}">${n}/${answers.length}</b>`+(n===answers.length?' — all correct.':'');
    if(n===answers.length){const b0=(state.quiz||{})[key]||0;if(n>b0)record(key,n);}return n;};
  u.b.addEventListener('keydown',e=>{if(e.key==='Enter'){e.preventDefault();check();}});
  u.f.addEventListener('click',e=>{const a=e.target.closest('[data-a]');if(!a)return;
    if(a.dataset.a==='check')check();
    if(a.dataset.a==='show'){$$('input',u.b).forEach(i=>{i.value=answers[+i.dataset.k][0];updateW(i);});check();}
    if(a.dataset.a==='run'){let t=d.text;let j=0;const ins=$$('input',u.b);t=t.replace(/\[\[(.+?)\]\]/g,()=>ins[j++].value);
      previewBlock($('.fillrun',u.b),docSpec('fill-'+key,'Fill-in — '+(d.title||'result'),asDoc(t)));}});
}

/* Parsons problem — assemble a working document from shuffled lines */
function parsons(box,d,key){
  const lines=d.lines.map((t,i)=>({t,i,real:true})).concat((d.extra||[]).map((t,i)=>({t,i:100+i,real:false})));
  let pool=shuffle(lines,hash(key)),built=[];
  const u=shell(box,'Parsons · put the lines in order',d.title,
    `<div class="pz"><div class="zl">Your document — tap a line to send it back, arrows to move</div><div class="zone built"></div>
     <div class="zl">Available lines — tap to add${d.extra?' (some lines are traps)':''}</div><div class="zone pool"></div><div class="pzrun"></div></div>`,
    '<button class="btn primary" data-a="check">Check order</button><button class="btn" data-a="reset">Start again</button><span class="msg"></span>');
  const row=(l,where,k)=>`<div class="line new" data-i="${l.i}" data-z="${where}"><span class="src">${hlInline(l.t)}</span>${where==='b'?
    `<span class="mv"><button data-mv="-1" aria-label="up">▲</button><button data-mv="1" aria-label="down">▼</button></span>`:''}</div>`;
  const paint=()=>{$('.built',u.b).innerHTML=built.map((l,k)=>row(l,'b',k)).join('')||'<span class="mini" style="padding:.3rem">nothing yet</span>';
    $('.pool',u.b).innerHTML=pool.map((l,k)=>row(l,'p',k)).join('')||'<span class="mini" style="padding:.3rem">all used</span>';};
  u.b.addEventListener('click',e=>{
    const mv=e.target.closest('[data-mv]');const ln=e.target.closest('.line');if(!ln)return;
    const i=+ln.dataset.i;
    if(mv){const k=built.findIndex(l=>l.i===i),to=k+ +mv.dataset.mv;if(to<0||to>=built.length)return;[built[k],built[to]]=[built[to],built[k]];paint();return;}
    if(ln.dataset.z==='p'){const k=pool.findIndex(l=>l.i===i);built.push(pool.splice(k,1)[0]);}
    else{const k=built.findIndex(l=>l.i===i);pool.push(built.splice(k,1)[0]);}
    paint();});
  u.f.addEventListener('click',e=>{const a=e.target.closest('[data-a]');if(!a)return;
    if(a.dataset.a==='reset'){pool=shuffle(lines,hash(key)+1);built=[];paint();$('.msg',u.f).textContent='';$('.pzrun',u.b).innerHTML='';return;}
    const want=d.lines.length;let good=0;
    $$('.built .line',u.b).forEach((x,k)=>{const l=built[k];const ok=l.real&&l.i===k;x.classList.remove('new');x.classList.toggle('ok',ok);x.classList.toggle('no',!ok);if(ok)good++;});
    const done=good===want&&built.length===want;
    $('.msg',u.f).innerHTML=done?'<b class="good">Correct order.</b> Here is what it produces:':`<b>${good}/${want}</b> lines in the right place${built.some(l=>!l.real)?' — and a trap line is in there':''}.`;
    if(done){previewBlock($('.pzrun',u.b),docSpec('pz-'+key,'Parsons — '+(d.title||'solution'),asDoc(d.lines.join('\n')),d.bib));
      const b0=(state.quiz||{})[key]||0;if(!b0)record(key,1);}});
  paint();
}

/* predict, then run (PRIMM) — commit to a guess before you see the answer */
function predict(box,d,key){
  const opts=shuffle(d.options.map((o,i)=>({o,i})),hash(key));
  const isSolved=()=>!!(state.quiz||{})[key];
  const u=shell(box,'Predict, then run',d.title,
    `<div class="pred"><div class="mini" style="margin-bottom:.4rem">Read the code. Which output will it produce? Commit to one before running it.</div>
     ${hl(d.code)}<div class="opts">${opts.map((x,k)=>`<div class="po" data-i="${x.i}"><div class="pl">option ${String.fromCharCode(65+k)}</div><iframe tabindex="-1" title="option"></iframe></div>`).join('')}</div>
     <div class="predrun"></div></div>`,
    '<button class="btn primary" data-a="run">▶ Run it and see</button><span class="msg">Pick an option or click run to see live output.</span>');
  let pick=null;
  $$('.po',u.b).forEach(po=>{const o=d.options[+po.dataset.i];
    const r=LXTeX.compile(asDoc(o));
    const pv=makePreview($('iframe',po));if(r.html)pv.show(r);
    po.addEventListener('click',()=>{if(u.b.dataset.done)return;pick=+po.dataset.i;$$('.po',u.b).forEach(x=>x.classList.toggle('sel',x===po));
      $('.msg',u.f).textContent='Locked in? Click “Run it and see”.';});});

  const showResult=(isRunClick)=>{
    u.b.dataset.done='1';
    $$('.po',u.b).forEach(x=>{const i=+x.dataset.i;x.classList.toggle('ok',i===d.answer);x.classList.toggle('no',pick!==null&&i===pick&&i!==d.answer);});
    if(pick!==null){
      $('.msg',u.f).innerHTML=pick===d.answer?'<b class="good">Right.</b> '+(d.why||''):'<b class="badc">Not this time.</b> '+(d.why||'');
    }else{
      $('.msg',u.f).innerHTML='<b class="good">Live output revealed:</b> '+(d.why||'');
    }
    const pr=$('.predrun',u.b);
    previewBlock(pr,docSpec('pr-'+key,'Predict — '+(d.title||'code'),asDoc(d.code)),'live output');
    if(isRunClick)pr.scrollIntoView({behavior:'smooth',block:'nearest'});
    if(pick===d.answer||isSolved()){
      u.sc.textContent='✓ solved';
      box.classList.add('solved');
      if(pick===d.answer)record(key,1);
    }
  };

  u.f.addEventListener('click',e=>{
    if(!e.target.closest('[data-a="run"]'))return;
    showResult(true);
  });

  if(isSolved()){
    showResult(false);
  }
}

/* challenge — fix the bug / build this; supports direct inline editing with live preview right below it */
function challenge(box,d,key){
  let curTex=d.start,curBib=d.bib||'',activeTab='tex';
  const isSolved=()=>!!(state.quiz||{})[key];
  const hasBib=d.bib!==undefined;
  const u=shell(box,d.kind==='fix'?'Fix the bug':'Build this',d.title,
    `${d.brief?`<p style="margin:.1rem 0 .5rem">${d.brief}</p>`:''}<ul class="chk">${(d.checks||[]).map(c=>`<li>${c.msg}</li>`).join('')}
     ${d.kind==='fix'?`<li>no ${d.strictWarn?'errors or warnings':'errors'} in the indicator</li>`:''}</ul>
     <div class="ch-ed">
       <div class="ch-ed-bar">
         <span class="k">${d.kind==='fix'?'code to fix':'code'}</span>
         ${hasBib?`<div class="ch-tabs"><button class="ch-tab on" data-f="tex">document.tex</button><button class="ch-tab" data-f="bib">refs.bib</button></div>`:''}
         <span class="grow"></span>
         <button class="minibtn reset-btn" data-a="reset" hidden title="Reset code to original">⟲ reset</button>
         <button class="minibtn" data-a="ide" title="Open in IDE">⌨ Open in IDE</button>
       </div>
       <div class="ex-ed">
         <pre class="ex-hl" aria-hidden="true"></pre>
         <textarea class="ex-ta" spellcheck="false" autocapitalize="off" autocomplete="off" autocorrect="off" wrap="soft" aria-label="LaTeX source">${esc(d.start)}</textarea>
       </div>
       <div class="ch-pv">
         <div class="pvb">
           <div class="pvh">
             <span class="k">live preview</span>
             <span class="st"></span>
             <span class="grow"></span>
             <button class="minibtn go" data-a="ide">⌨ Open in IDE</button>
           </div>
           <iframe class="live" title="Live Preview"></iframe>
         </div>
       </div>
     </div>`,
    `<button class="btn" data-a="ide">⌨ Open in IDE</button><span class="msg"></span>`);

  const ta=$('.ex-ta',u.b),pre=$('.ex-hl',u.b),rst=$('[data-a="reset"]',u.b);
  const pvFrame=$('.ch-pv iframe.live',u.b),st=$('.ch-pv .pvh .st',u.b);
  const chkLis=$$('.chk li',u.b);
  const pv=makePreview(pvFrame);

  const getSpec=()=>Object.assign(docSpec('ch-'+key,(d.kind==='fix'?'Fix — ':'Build — ')+(d.title||'challenge'),curTex,hasBib?curBib:undefined),{task:key});

  const evaluate=(F)=>{
    const clean=curTex.replace(/(^|[^\\])%.*$/gm,'$1'),bibText=curBib;
    const res=(d.checks||[]).map(c=>({
      msg:c.msg,
      ok:new RegExp(c.re,c.flags||'').test(c.file==='bib'?bibText:clean)===!c.not
    }));
    if(d.kind==='fix'){
      res.push({
        msg:'no '+(d.strictWarn?'errors or warnings':'errors')+' in the indicator',
        ok:!F.some(f=>f.sev==='error'||(d.strictWarn&&f.sev==='warning'))
      });
    }
    res.forEach((r,i)=>{if(chkLis[i])chkLis[i].classList.toggle('ok',r.ok);});
    return res.every(r=>r.ok);
  };

  const recompile=()=>{
    const files=[{path:'document.tex',text:curTex}];
    if(hasBib)files.push({path:'refs.bib',text:curBib});
    const r=compileProject(files,'document.tex');
    const E=r.findings.filter(f=>f.sev==='error');
    if(st){
      st.className='st'+(E.length?' bad':'');
      st.textContent=E.length?('● '+E.length+' error'+(E.length>1?'s':'')+' — line '+(E[0].line||'?')+': '+E[0].msg):'✓ compiles';
    }
    pv.show(r.html!==null&&r.html!==undefined?r:{html:'<div class="body"><div class="lx-wait">This code does not compile yet — fix syntax above.</div></div>',rootStyle:''});
    const all=evaluate(r.findings);
    if(all){
      box.classList.add('solved');
      u.sc.textContent='✓ solved';
      $('.msg',u.f).innerHTML='<b class="good">✓ Solved!</b> All checks pass.';
      if(!isSolved()){record(key,1);toast('Challenge solved ✓');}
    }else{
      if(isSolved()){
        box.classList.add('solved');u.sc.textContent='✓ solved';
        $('.msg',u.f).innerHTML='<b class="good">Solved.</b> Continue editing or practise again.';
      }else{
        box.classList.remove('solved');u.sc.textContent='';
        $('.msg',u.f).textContent='Fix the code above — checklist ticks as you type.';
      }
    }
  };

  const updateDebounced=debounce(recompile,220);

  const paintEditor=()=>{
    const cur=activeTab==='tex'?curTex:curBib;
    pre.innerHTML=hl(cur,activeTab==='tex'?'latex':'bibtex');
    rst.hidden=(curTex===d.start&&curBib===(d.bib||''));
  };

  paintEditor();
  recompile();

  ta.addEventListener('input',()=>{
    const v=ta.value;
    if(activeTab==='tex'){if(v===curTex)return;curTex=v;}
    else{if(v===curBib)return;curBib=v;}
    paintEditor();
    updateDebounced();
  });
  ta.addEventListener('scroll',()=>{if(ta.scrollTop!==0||ta.scrollLeft!==0){ta.scrollTop=0;ta.scrollLeft=0;}});
  ta.addEventListener('keydown',e=>{
    if(e.key==='Tab'){
      e.preventDefault();const s=ta.selectionStart;ta.setRangeText('  ',s,ta.selectionEnd,'end');
      if(activeTab==='tex')curTex=ta.value;else curBib=ta.value;
      paintEditor();updateDebounced();
    }else if(e.key==='Enter'&&!e.ctrlKey&&!e.metaKey){
      const s=ta.selectionStart,v=ta.value,ls=v.lastIndexOf('\n',s-1)+1,ind=(/^[ \t]*/.exec(v.slice(ls))||[''])[0];
      if(ind){e.preventDefault();ta.setRangeText('\n'+ind,s,ta.selectionEnd,'end');
        if(activeTab==='tex')curTex=ta.value;else curBib=ta.value;
        paintEditor();updateDebounced();}
    }
  });

  if(hasBib){
    $$('.ch-tab',u.b).forEach(tb=>{
      tb.onclick=()=>{
        const f=tb.dataset.f;if(f===activeTab)return;
        activeTab=f;
        $$('.ch-tab',u.b).forEach(x=>x.classList.toggle('on',x===tb));
        ta.value=activeTab==='tex'?curTex:curBib;
        paintEditor();
      };
    });
  }

  rst.onclick=()=>{
    curTex=d.start;curBib=d.bib||'';
    ta.value=activeTab==='tex'?curTex:curBib;
    paintEditor();recompile();toast('Reset code to original');
  };

  const launchIDE=()=>openInIDE(getSpec());
  $$('[data-a="ide"]',box).forEach(btn=>{btn.onclick=launchIDE;});

  document.addEventListener('lx:quiz',e=>{
    if(e.detail===key){
      const ok=isSolved();
      box.classList.toggle('solved',ok);
      u.sc.textContent=ok?'✓ solved':'';
      if(ok)$('.msg',u.f).innerHTML='<b class="good">Solved.</b> Open it again any time to practise.';
    }
  });
}

/* ══════════════ progress state + Firebase sync ══════════════ */
const DB='https://task-dominion-default-rtdb.asia-southeast1.firebasedatabase.app';
const APP='ssc_latex_mod12';
const LS='lx12_progress_v1',LSID='lx12_syncid_v1';
let state={done:{},open:{},quiz:{},cards:{},bm:{},updated:0};
let syncId='';try{syncId=localStorage.getItem(LSID)||'';}catch(e){}
function loadLocal(){try{const j=JSON.parse(localStorage.getItem(LS));if(j)state=Object.assign(state,j);}catch(e){}}
function saveLocal(){state.updated=Date.now();try{localStorage.setItem(LS,JSON.stringify(state));}catch(e){}}
let pushT;
function persist(){saveLocal();paintAll();if(syncId&&CFG.online){clearTimeout(pushT);pushT=setTimeout(push,800);}}
function push(){if(!syncId||!CFG.online)return;fetch(`${DB}/${APP}/${encodeURIComponent(syncId)}.json`,{method:'PUT',body:JSON.stringify(state)})
  .catch(()=>{/* background auto-sync stays silent on failure */});}
function pull(cb){fetch(`${DB}/${APP}/${encodeURIComponent(syncId)}.json`).then(r=>r.json())
  .then(d=>{if(d&&(!state.updated||d.updated>state.updated)){state=Object.assign(state,d);saveLocal();}cb&&cb();}).catch(()=>cb&&cb());}
function toast(m){const s=$('#sync');if(!s)return;$('#synctxt').textContent=m;s.classList.add('show');clearTimeout(toast._h);toast._h=setTimeout(()=>s.classList.remove('show'),1600);}

/* ══════════════ the tree ══════════════ */
let TREE=[];const SEC=Object.create(null),RAW=Object.create(null),QAHOME=Object.create(null);
const starBtn=(id,what)=>`<button class="star" data-bm="${id}" title="Bookmark this ${what} for review" aria-label="Bookmark for review">☆</button>`;
const doneBar=id=>`<div class="donebar"><button class="btn primary" data-done="${id}">✓ Mark as completed</button><button class="btn bmbtn" data-bm="${id}">☆ Bookmark for review</button></div>`;
function render(){
  const host=$('#stations');host.innerHTML='';TREE=[];
  MODULES.forEach((m,mi)=>{
    const modEl=el(`<section class="mod ${m.cls||('m'+mi)}" id="${m.id}">
      <div class="mh"><span class="caret">▶</span><button class="tick" data-tick="${m.id}" title="Mark the whole module done" aria-label="done"></button>
        <div class="mt"><b>${m.name}</b><small>${m.sub||''}</small></div><span class="cnt" data-cnt="${m.id}"></span></div>
      <div class="mbody"><div class="in"></div></div></section>`);
    const mbody=$('.mbody>.in',modEl),node={id:m.id,name:m.name,secs:[]};
    m.stations.forEach(sid=>{
      const st=STATIONS.find(x=>x.id===sid);if(!st)return;
      const title=(st.short||st.title).replace(/<[^>]+>/g,'');
      const secEl=el(`<div class="unit" id="${sid}"><div class="uh"><span class="caret">▶</span>
          <button class="tick" data-tick="${sid}" title="Mark section done" aria-label="done"></button><h3>${title}</h3>
          <span class="cnt" data-cnt="${sid}"></span><span class="est">${st.est||''}</span></div>
        <div class="ubody"><div class="in"></div></div></div>`);
      const ubody=$('.ubody>.in',secEl),sec={id:sid,title,topics:[],qas:[]};
      const tmp=document.createElement('div');tmp.innerHTML=st.body;let sink=ubody;
      [...tmp.childNodes].forEach(n=>{
        if(n.nodeType===1&&n.classList&&n.classList.contains('topic')){
          const i=sec.topics.length,tid=sid+'__t'+i,h=n.querySelector('h3');
          const tEl=el(`<div class="tunit" id="${tid}"><div class="th"><span class="caret">▶</span>
            <button class="tick" data-tick="${tid}" title="Mark topic done" aria-label="done"></button><h4>${h?h.innerHTML:'Topic'}</h4>${starBtn(tid,'topic')}</div>
            <div class="tbody"><div class="in"></div></div></div>`);
          ubody.appendChild(tEl);sink=$('.tbody>.in',tEl);sec.topics.push({id:tid,title:(h?h.textContent:'').trim()});
        }else sink.appendChild(n);
      });
      /* only topics (the lowest level) get the completion and review buttons */
      sec.topics.forEach(t=>{const tEl=$('#'+CSS.escape(t.id),secEl);$('.tbody>.in',tEl).insertAdjacentHTML('beforeend',doneBar(t.id));});
      $$('details.qa[data-q]',secEl).forEach(q=>{const t=q.closest('.tunit');QAHOME[q.dataset.q]={sid,tid:t?t.id:null};sec.qas.push(q.dataset.q);RAW[q.dataset.q]=q.outerHTML;});
      sec.topics.forEach(t=>{RAW[t.id]=$('#'+CSS.escape(t.id),secEl).outerHTML;});
      RAW[sid]=secEl.outerHTML;
      mbody.appendChild(secEl);node.secs.push(sec);SEC[sid]=sec;
    });
    host.appendChild(modEl);TREE.push(node);
  });
  restoreFolds();paintAll();bmDirty=true;
}
const leavesOfSec=sec=>sec.topics.length?sec.topics.map(t=>t.id):[sec.id];
const leavesOfMod=mod=>mod.secs.flatMap(leavesOfSec);
const allLeaves=()=>TREE.flatMap(leavesOfMod);
const leavesOf=id=>{const m=TREE.find(x=>x.id===id);if(m)return leavesOfMod(m);if(SEC[id])return leavesOfSec(SEC[id]);return [id];};
const stateOf=ids=>{const n=ids.filter(i=>state.done[i]).length;return {n,total:ids.length,all:ids.length>0&&n===ids.length,some:n>0};};
function setLeaves(ids,on){ids.forEach(i=>{if(on)state.done[i]=true;else delete state.done[i];});}
const rid=c=>c.id.replace(/^bm__/,'');
const cardOf=(src,id)=>{const c=src&&src.closest('.tunit,.unit,.mod');return c&&rid(c)===id?c:document.getElementById(id);};
function toggleNode(id,src){
  const L=leavesOf(id),nowDone=!stateOf(L).all;setLeaves(L,nowDone);persist();
  if(nowDone){
    const c=cardOf(src,id);
    if(c){
      setOpen(c,false);
      saveLocal();
      const h=c.firstElementChild||c;
      setTimeout(()=>h.scrollIntoView({behavior:'smooth',block:'center'}),50);
      setTimeout(()=>h.scrollIntoView({behavior:'smooth',block:'center'}),320);
    }
  }
}
/* “Mark as completed” at the foot of a dropdown: close that dropdown and scroll to that completed section */
function completeNode(id,src){
  const L=leavesOf(id);
  if(stateOf(L).all){setLeaves(L,false);persist();toast('Marked as not done');return;}
  setLeaves(L,true);persist();toast('Completed ✓');
  const c=cardOf(src,id);
  if(c){
    setOpen(c,false);
    saveLocal();
    const h=c.firstElementChild||c;
    setTimeout(()=>h.scrollIntoView({behavior:'smooth',block:'center'}),50);
    setTimeout(()=>h.scrollIntoView({behavior:'smooth',block:'center'}),320);
  }
}
let bmDirty=true;
function toggleBM(id){
  state.bm=state.bm||{};const on=!state.bm[id];
  if(on)state.bm[id]=Date.now();else delete state.bm[id];
  persist();bmDirty=true;
  toast(on?'★ Bookmarked for review':'Removed from bookmarks');
  if(!on&&curView==='bm'){const r=$(`#bmlist>[data-bmroot="${id}"]`);if(r){r.classList.add('bye');setTimeout(()=>{r.remove();tidyBM();},260);}}
}
let wired=false;
function wireTree(){
  if(wired)return;wired=true;
  const syncToast=$('#sync');
  if(syncToast)syncToast.onclick=()=>{clearTimeout(toast._h);syncToast.classList.remove('show');};
  document.addEventListener('click',e=>{
    const t=e.target.closest('[data-tick]');if(t){e.preventDefault();e.stopPropagation();toggleNode(t.dataset.tick,t);return;}
    const d=e.target.closest('[data-done]');if(d){e.preventDefault();e.stopPropagation();completeNode(d.dataset.done,d);return;}
    const b=e.target.closest('[data-bm]');if(b){e.preventDefault();e.stopPropagation();toggleBM(b.dataset.bm);return;}
    const h=e.target.closest('.mh,.uh,.th');
    if(h){const c=h.parentElement;if(c.classList.contains('open')){setOpen(c,false);saveLocal();}else openCard(c);}
  },true);
  document.addEventListener('toggle',e=>{const q=e.target;if(q.matches&&q.matches('details.qa')&&q.open)$$('[data-ex]',q).forEach(hydrateEx);},true);
  /* phones: while typing anywhere, hide bottom bar for keyboard */
  document.addEventListener('focusin',e=>{
    if(matchMedia('(max-width:899px)').matches&&e.target&&e.target.matches&&e.target.matches('textarea, input:not([type="checkbox"]):not([type="radio"])')){
      document.body.classList.add('typing');
    }
  });
  document.addEventListener('focusout',e=>{
    setTimeout(()=>{
      const a=document.activeElement;
      if(!a||!a.matches||!a.matches('textarea, input:not([type="checkbox"]):not([type="radio"])')){
        document.body.classList.remove('typing');
      }
    },150);
  });
}

/* ══════════════ focus accordion ══════════════
   · all dropdowns are closed by default on initial load
   · opening a card closes every other card at that level (within its tab)
   · marking completed simply closes that dropdown                       */
const levelOf=c=>c.classList.contains('mod')?'mod':c.classList.contains('unit')?'unit':'tunit';
function setOpen(card,open){
  card.classList.toggle('open',open);
  if(open)hydrateIn(card);
  markDepth();
}
function openCard(card,opt){
  opt=opt||{};const lv=levelOf(card),root=card.closest('.view')||document;
  $$('.'+lv+'.open',root).forEach(c=>{if(c!==card)setOpen(c,false);});
  if(root.id==='view-bm')$$('#bmlist>.open').forEach(c=>{if(c!==card&&!c.contains(card))setOpen(c,false);});
  let p=card.parentElement&&card.parentElement.closest('.mod,.unit');
  while(p){if(!p.classList.contains('open')){$$('.'+levelOf(p)+'.open',root).forEach(c=>{if(c!==p)setOpen(c,false);});setOpen(p,true);}
    p=p.parentElement&&p.parentElement.closest('.mod,.unit');}
  setOpen(card,true);
  saveLocal();
  if(opt.scroll!==false){const h=card.firstElementChild;setTimeout(()=>{
    const top=h.getBoundingClientRect().top;if(top<60||top>innerHeight*.45)h.scrollIntoView({behavior:'smooth',block:'start'});},340);}
}
const isDone=id=>{if(SEC[id])return stateOf(leavesOfSec(SEC[id])).all;const m=TREE.find(x=>x.id===id);if(m)return stateOf(leavesOfMod(m)).all;return !!state.done[id];};
function restoreFolds(){
  // All dropdowns are closed by default on load
  markDepth();
}
/* depth-aware width: parents with an open child give their padding back */
function markDepth(){
  $$('.mod,.unit').forEach(c=>c.classList.toggle('has-open',c.classList.contains('open')&&!!$(':scope>.mbody>.in>.unit.open, :scope>.ubody>.in>.tunit.open',c)));
  const root=$('.view.on')||document;
  document.body.classList.toggle('wide',!!$('.tunit.open .wg, .tunit.open .ex, .unit.open>.ubody .ex, .unit.open>.ubody .wg',root));
}
function hydrateIn(card){
  $$('[data-ex]',card).forEach(b=>{const t=b.closest('.tunit');if(t&&t!==card&&!t.classList.contains('open'))return;
    if(b.closest('details.qa:not([open])'))return;hydrateEx(b);});
  $$('[data-w]',card).forEach(b=>{const t=b.closest('.tunit');if(t&&!t.classList.contains('open'))return;hydrateW(b);});
}

/* ══════════════ the Bookmarks tab — the same dropdowns, only the ones you starred ══════════════ */
function renderBM(){
  bmDirty=false;const host=$('#bmlist'),bm=state.bm||{},groups=[];
  TREE.forEach(m=>m.secs.forEach(sec=>{
    const items=[];
    if(bm[sec.id])items.push(sec.id);
    else{sec.topics.forEach(t=>{if(bm[t.id])items.push(t.id);});
      sec.qas.forEach(q=>{if(bm[q]&&!(QAHOME[q].tid&&bm[QAHOME[q].tid]))items.push(q);});}
    if(items.length)groups.push({label:m.name+' · '+sec.title,items});
  }));
  const clone=h=>h.replace(/(\s)id="/g,'$1id="bm__');
  host.innerHTML=groups.map(g=>`<div class="bmgroup">${esc(g.label)}</div>`+g.items.map(id=>RAW[id]?(id.startsWith('qa')?
      `<div class="bmqa" data-bmroot="${id}">${clone(RAW[id])}</div>`:clone(RAW[id]).replace(/^<div /,`<div data-bmroot="${id}" `)):'').join('')).join('');
  tidyBM();paintAll();
  const first=$('#bmlist>.unit,#bmlist>.tunit');if(first)openCard(first,{scroll:false});
}
function tidyBM(){
  const host=$('#bmlist');
  $$('.bmgroup',host).forEach(g=>{const n=g.nextElementSibling;if(!n||n.classList.contains('bmgroup'))g.remove();});
  if(!host.querySelector('[data-bmroot]'))host.innerHTML=`<div class="empty"><b>☆</b>Nothing bookmarked yet.<br>
    Tap <b>☆</b> on any section, topic or exam question — or <b>Bookmark for review</b> at the end of a topic — and it collects here.</div>`;
}

/* ══════════════ painting ══════════════ */
function paintTick(b,st){b.classList.toggle('on',st.all);b.classList.toggle('part',!st.all&&st.some);}
function paintAll(){
  const both=id=>[document.getElementById(id),document.getElementById('bm__'+id)].filter(Boolean);
  TREE.forEach(m=>{
    m.secs.forEach(sec=>{
      sec.topics.forEach(t=>{const on=!!state.done[t.id];
        $$(`.tick[data-tick="${t.id}"]`).forEach(b=>{b.classList.toggle('on',on);b.classList.remove('part');});
        both(t.id).forEach(c=>c.classList.toggle('done',on));});
      const ss=stateOf(leavesOfSec(sec));$$(`.tick[data-tick="${sec.id}"]`).forEach(b=>paintTick(b,ss));
      $$(`[data-cnt="${sec.id}"]`).forEach(c=>c.textContent=sec.topics.length?`${ss.n}/${ss.total}`:'');
      both(sec.id).forEach(c=>c.classList.toggle('done',ss.all));});
    const ms=stateOf(leavesOfMod(m));$$(`.tick[data-tick="${m.id}"]`).forEach(b=>paintTick(b,ms));
    $$(`[data-cnt="${m.id}"]`).forEach(c=>c.textContent=`${ms.n}/${ms.total}`);
  });
  const bm=state.bm||{};
  $$('[data-bm]').forEach(b=>{const on=!!bm[b.dataset.bm];b.classList.toggle('on',on);
    if(b.classList.contains('star')){b.textContent=on?'★':'☆';b.title=on?'Bookmarked — tap to remove':'Bookmark for review';}
    else b.textContent=on?'★ Bookmarked':'☆ Bookmark for review';});
  $$('[data-done]').forEach(b=>{const id=b.dataset.done,dn=isDone(id);b.classList.toggle('completed',dn);b.classList.toggle('primary',!dn);
    b.textContent=dn?'✓ Completed · undo':SEC[id]&&SEC[id].topics.length?'✓ Mark whole section as completed':'✓ Mark as completed';});
  const n=Object.keys(bm).length,badge=$('#nav .badge');if(badge){badge.hidden=!n;badge.textContent=n;}
  const ov=stateOf(allLeaves()),pct=ov.total?Math.round(ov.n/ov.total*100):0;
  $('#ringpct').textContent=pct+'%';$('#ringp').style.strokeDashoffset=88*(1-pct/100);$('#pbar').style.width=pct+'%';
}

/* ══════════════ three tabs: Learn · IDE · Bookmarks ══════════════ */
let curView='learn';const vScroll={};
function showView(v){
  if(!['learn','ide','bm'].includes(v))v='learn';
  const was=curView;if(was!==v)vScroll[was]=scrollY;
  if(was==='ide'&&v!=='ide')IDE.from=null;
  curView=v;
  $$('.view').forEach(x=>x.classList.toggle('on',x.id==='view-'+v));
  $$('#nav button').forEach(b=>{b.classList.toggle('on',b.dataset.view===v);b.setAttribute('aria-current',b.dataset.view===v?'page':'false');});
  document.body.classList.remove('v-learn','v-ide','v-bm','typing');document.body.classList.add('v-'+v);
  if(v==='ide'){mountIDE();if(IDE.resetPDF)IDE.resetPDF();setTimeout(()=>IDE.fit&&IDE.fit(),60);}
  if(v==='bm'&&bmDirty)renderBM();
  markDepth();
  if(was!==v)scrollTo(0,v==='ide'?0:(vScroll[v]||0));
  try{localStorage.setItem('lx12_view',v);}catch(e){}
  try{history.replaceState(null,'',v==='learn'?location.pathname+location.search:'#'+(v==='bm'?'bookmarks':'ide'));}catch(e){}
}
function initNav(){
  $$('#nav button').forEach(b=>b.onclick=()=>{if(b.dataset.view===curView&&curView!=='ide')scrollTo({top:0,behavior:'smooth'});else showView(b.dataset.view);});
  const top=$('#top'),setTop=()=>document.documentElement.style.setProperty('--toph',top.offsetHeight+'px');
  setTop();new ResizeObserver(setTop).observe(top);
}

/* ══════════════ chrome ══════════════ */
function initTheme(){
  const KEY='lx12_theme',btn=$('#theme');
  const apply=m=>{if(m==='auto')document.documentElement.removeAttribute('data-theme');else document.documentElement.setAttribute('data-theme',m);
    btn.textContent=m==='dark'?'☾':m==='light'?'☀':'◐';};
  let m='auto';try{m=localStorage.getItem(KEY)||'auto';}catch(e){}apply(m);
  btn.onclick=()=>{m=m==='auto'?'light':m==='light'?'dark':'auto';try{localStorage.setItem(KEY,m);}catch(e){}apply(m);};
}
function initSync(){
  const modal=$('#idmodal'),inp=$('#idinput'),status=$('#idstatus');
  if(!CFG.online){$('#cloud').title='Sync needs the online version';}
  $('#cloud').onclick=()=>{if(!CFG.online){toast('Sync needs the online version');return;}
    inp.value=syncId||'';status.textContent=syncId?'Connected as “'+syncId+'”':'';modal.classList.add('show');inp.focus();};
  $('#idclose').onclick=()=>modal.classList.remove('show');
  modal.onclick=e=>{if(e.target===modal)modal.classList.remove('show');};
  $('#idsave').onclick=()=>{const v=inp.value.trim().toLowerCase().replace(/[^a-z0-9_\-]/g,'-').slice(0,40);
    if(!v){status.textContent='Enter a code first.';return;}
    syncId=v;try{localStorage.setItem(LSID,v);}catch(e){}status.textContent='Connecting…';
    pull(()=>{render();status.textContent='Synced as “'+v+'” ✓';toast('Synced ✓');setTimeout(()=>modal.classList.remove('show'),800);push();});};
  if(syncId)$('#cloud').style.color='var(--green)';
}
/* the online page hands out the self-contained offline copy (≈3.5 MB), which works with no network at all */
function initDownload(){
  const btn=$('#dl');if(location.protocol==='file:'||!CFG.online)return;btn.hidden=false;
  btn.title='Download the offline copy (works without internet)';
  btn.onclick=async()=>{btn.textContent='…';
    try{const r=await fetch(new URL('LATEX_12_OFFLINE.html',location.href),{cache:'no-store'});if(!r.ok)throw 0;
      const b=await r.blob();const a=document.createElement('a');a.href=URL.createObjectURL(b);a.download='LATEX_12_OFFLINE.html';
      document.body.appendChild(a);a.click();a.remove();toast('Downloaded the offline copy');}
    catch(e){toast('Download failed — try again online');}
    btn.textContent='⤓';};
}

function boot(){
  loadLocal();wireTree();render();initTheme();initSync();initDownload();initCodeWin();initNav();
  if(syncId&&CFG.online)pull(()=>{paintAll();bmDirty=true;});
  const h=location.hash.slice(1);let v='learn';try{v=localStorage.getItem('lx12_view')||'learn';}catch(e){}
  if(h==='ide')v='ide';else if(h==='bookmarks')v='bm';
  else if(h){const t=document.getElementById(h);if(t){v='learn';showView(v);openCard(t.closest('.tunit,.unit,.mod')||t);}}
  showView(v);
  window.LXAPP={openCard,openInIDE,openCode,showView,compileProject,submitPDF,state:()=>state,ide:()=>ide};
}
if(document.readyState!=='loading')boot();else document.addEventListener('DOMContentLoaded',boot);
})();
