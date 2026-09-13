/* ══════════════════════════════════════════════════════════════════
   LaTeX · Modules I–II — content helpers
   Content is authored with String.raw templates, so LaTeX is written
   with single backslashes exactly as you would type it. LaTeX's
   opening quote is a backtick, which would end a template literal,
   so the fullwidth ｀ stands in for it and is converted on the way in.
   ══════════════════════════════════════════════════════════════════ */
window.LXREG={ex:{},w:{}};
const LXR=window.LXREG;
const L=(s,...v)=>String.raw(s,...v).replace(/｀/g,'`');
const H=L;                                   /* prose: same raw rules */
const hsh=s=>{let h=5381;for(let i=0;i<s.length;i++)h=((h<<5)+h+s.charCodeAt(i))|0;return Math.abs(h).toString(36);};
const escH=s=>String(s).replace(/[&<>"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[c]));

/* a snippet becomes a full document unless it already is one */
function wrapDoc(snip,o){
  if(/^\s*\\documentclass/m.test(snip))return snip.trim()+'\n';
  return `\\documentclass${o.opt?'['+o.opt+']':''}{${o.cls||'article'}}\n${o.pre?o.pre.trim()+'\n':''}\\begin{document}\n${snip.trim()}\n\\end{document}\n`;
}
/* example: shows the convenient part; ▶ run shows its output, “full code” opens the code window, both lead into the IDE */
function ex(snip,o){
  o=o||{};const id='x'+hsh(snip+(o.title||''));
  LXR.ex[id]={snippet:snip.trim(),full:o.full||wrapDoc(snip,o),title:o.title,note:o.note,bib:o.bib,lang:o.lang,run:o.run,file:o.file};
  return `<div class="ex" data-ex="${id}"></div>`;
}
function W(type,d){const id=type+hsh(JSON.stringify(d));LXR.w[id]=Object.assign({type},d);return `<div data-w="${id}"></div>`;}
const omr=(title,qs)=>W('omr',{title,qs});
const cards=(title,list)=>W('cards',{title,list});
const match=(title,pairs,o)=>W('match',Object.assign({title,pairs},o||{}));
const fill=(title,text,o)=>W('fill',Object.assign({title,text},o||{}));
const parsons=(title,lines,o)=>W('parsons',Object.assign({title,lines},o||{}));
const predict=(title,code,options,answer,why)=>W('predict',{title,code,options,answer,why});
const fix=(title,start,o)=>W('challenge',Object.assign({kind:'fix',title,start},o||{}));
const build=(title,start,o)=>W('challenge',Object.assign({kind:'build',title,start},o||{}));
const editor=(code,o)=>W('editor',Object.assign({code},o||{}));
const tp=t=>`<div class="topic"><h3>${t}</h3></div>`;
const gist=t=>`<div class="gist"><span class="k">in one line</span>${t}</div>`;
const must=h=>`<div class="note"><div class="nh">learn this by heart</div>${h}</div>`;
const trap=h=>`<div class="note pitfall"><div class="nh">where marks get lost</div>${h}</div>`;
const why=h=>`<div class="note why"><div class="nh">why it is taught this way</div>${h}</div>`;
const k=x=>`<code>${escH(x)}</code>`;
const paper=(name,time,marks)=>`<div class="paperhead"><b>${name}</b><div class="meta"><span>Time: ${time}</span><span>Max marks: ${marks}</span></div></div>`;
const secband=(l,r)=>`<div class="secband"><b>Section ${l}</b><span>${r}</span></div>`;
const qa=(m,q,a)=>{const id='qa'+hsh(q+a);return `<details class="qa" data-q="${id}"><summary><span class="pn">${m}</span><span class="pt">${q}</span><button class="star" data-bm="${id}" title="Bookmark this question for review" aria-label="Bookmark for review">☆</button><span class="chev">›</span></summary><div class="pbody"><div class="qmeta">model answer</div>${a}</div></details>`;};
/* a reference list where every command gets a clean vertical design with its runnable example */
function reftable(rows,o){
  o=o||{};
  const h1=o.h1||'Command',h2=o.h2||'Effect';
  return `<div class="reflist"><div class="reflist-head"><span>${escH(h1)}</span><span>${escH(h2)}</span></div>`+
    rows.map(r=>{
      const cmds=String(r[0]).split(/\s{2,}/).map(c=>`<code>${escH(c)}</code>`).join(' ');
      return `<div class="refitem">
        <div class="refitem-meta">
          <div class="refitem-cmd">${cmds}</div>
          <div class="refitem-desc">${r[1]}</div>
        </div>
        ${r[2]?`<div class="refitem-ex">${ex(r[2],Object.assign({title:r[0]},r[3]||{}))}</div>`:''}
      </div>`;
    }).join('')+'</div>';
}
const STATIONS=[];
