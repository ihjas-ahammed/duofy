/* ══════════════════════════════════════════════════════════════════
   Materials Science · CU-FYUGP B.Sc. Physics (Hons) · Semester V
   Major Elective — Modules I & II  (Callister, Materials Science and
   Engineering: An Introduction — Sections 1.2–1.6, 2.5–2.10, 3.13–3.17, 4.1–4.11)
   Authoring helpers. Content is written in H`…` (String.raw), so LaTeX
   takes SINGLE backslashes. Inside $…$ never put "<" before a letter —
   write \lt (the HTML parser would open a phantom tag and eat the text).
   ══════════════════════════════════════════════════════════════════ */
window.MSREG={w:{}};
const H=(s,...v)=>String.raw(s,...v);
const _h=s=>{let h=5381;for(let i=0;i<s.length;i++)h=((h<<5)+h+s.charCodeAt(i))|0;return Math.abs(h).toString(36);};
function W(type,d){const id=type+_h(JSON.stringify(d));window.MSREG.w[id]=Object.assign({type},d);return `<div data-w="${id}"></div>`;}

/* practice widgets (rendered lazily when their topic opens) */
const omr=(title,qs)=>W('omr',{title,qs});                 // qs: [{q,o:[4],a,why}]
const cards=(title,list)=>W('cards',{title,list});          // list: [{f,b}]
const match=(title,pairs,o)=>W('match',Object.assign({title,pairs},o||{}));
const fill=(title,text,o)=>W('fill',Object.assign({title,text},o||{}));  // [[answer¦alt]]

/* structure */
const tp=t=>`<div class="topic"><h3>${t}</h3></div>`;
const gist=t=>`<div class="gist"><span class="k">in one line</span>${t}</div>`;
const must=h=>`<div class="note key"><div class="nh">learn this by heart</div>${h}</div>`;
const trap=h=>`<div class="note pitfall"><div class="nh">where marks get lost</div>${h}</div>`;
const why=h=>`<div class="note why"><div class="nh">why it works</div>${h}</div>`;
const note=(head,h)=>`<div class="note"><div class="nh">${head}</div>${h}</div>`;
const carry=(have,fresh)=>`<div class="carry"><div><div class="ch">you carry over from +2</div><ul>${have.map(x=>`<li>${x}</li>`).join('')}</ul></div>
  <div><div class="ch">new ground here</div><ul>${fresh.map(x=>`<li>${x}</li>`).join('')}</ul></div></div>`;
const defn=(term,text)=>`<div class="defn"><b>${term}</b> — ${text}</div>`;
const eq=(tex,tag)=>`<div class="eq">$$${tex}${tag?`\\qquad\\mathrm{(${String(tag).replace(/ /g,'~')})}`:''}$$</div>`;
const src=t=>`<p class="src">${t}</p>`;
const tbl=(head,rows,o)=>{o=o||{};const num=o.num||[];
  return `<div class="scroll-x"><table class="ref"><tr>${head.map((h,i)=>`<th${num.includes(i)?' class="num"':''}>${h}</th>`).join('')}</tr>`+
    rows.map(r=>`<tr>${r.map((c,i)=>`<td${num.includes(i)?' class="num"':''}>${c}</td>`).join('')}</tr>`).join('')+'</table></div>';};
const grid=(items)=>`<div class="grid2">${items.map(([t,b])=>`<div><b>${t}</b>${b}</div>`).join('')}</div>`;

/* derivation ladder: reveal one rung at a time */
function lad(title,rungs){
  const body=rungs.map((r,i)=>`<div class="rung${i?' hidden':''}"><span class="peek">tap to reveal ▸</span>
    ${r.why?`<div class="why">${r.why}</div>`:''}<div class="math">${r.m}</div></div>`).join('');
  return `<div class="ladder"><div class="lh">${title}<span class="li">derivation</span></div>${body}
    <div class="lfoot"><button class="btn primary reveal-next">Reveal next step</button><button class="btn reveal-all">Show all</button>
    <span class="mini">Guess the next line before you tap — that guess is what makes it stick.</span></div></div>`;
}
/* live canvas figures — every one is drawn from the real formula */
const fig=(name,cap,leg)=>`<figure class="fig"><div class="cvwrap"><canvas data-fig="${name}"></canvas></div>${leg?`<div class="leg">${leg}</div>`:''}<figcaption>${cap}</figcaption></figure>`;
const fig3d=(name,cap,leg)=>`<figure class="fig is3d"><div class="cvwrap"><canvas data-v3d="${name}"></canvas></div>${leg?`<div class="leg">${leg}</div>`:''}<figcaption><b>Spin it.</b> ${cap}</figcaption></figure>`;
const lg=(col,label,kind)=>`<span><i class="${kind||''}" style="${kind==='fill'?'background':'border-color'}:var(--${col})"></i>${label}</span>`;

/* retrieval checkpoint: rate your confidence BEFORE you see the answer */
const chk=(q,a)=>{
  const id='ck'+_h(q);
  return `<div class="check" id="${id}" data-ck="${id}"><div class="ch">◈ can you answer this?</div><div class="qz">${q}</div>
  <div class="conf"><button type="button" data-c="0">No idea</button><button type="button" data-c="1">Shaky</button><button type="button" data-c="2">Fairly sure</button><button type="button" data-c="3">Solid</button></div>
  <button type="button" class="reveal">Answer honestly, then check ▸</button>
  <div class="ans">${a}
    <div class="ck-fb">
      <span class="fb-prompt">Recall check:</span>
      <button type="button" class="btn sm" data-ck-hit>✓ Got it</button>
      <button type="button" class="btn sm" data-ck-miss>✗ Not yet</button>
      <span class="ck-status"></span>
    </div>
  </div></div>`;
};

/* worked problems */
const prob=(n,title,parts)=>`<details class="prob"><summary><span class="pn">${n}</span><span class="pt">${title}</span><span class="chev">›</span></summary><div class="pbody">${parts}
  <div class="prob-fb">
    <span class="fb-prompt">Did you follow this example?</span>
    <button type="button" class="btn sm" data-pr-hit>✓ Understood</button>
    <button type="button" class="btn sm" data-pr-miss>Need practice</button>
    <span class="pr-status"></span>
  </div>
</div></details>`;
const pq=h=>`<h4 class="qn">the question</h4>${h}`;
const pth=h=>`<h4 class="theory">what you need first</h4>${h}`;
const psol=h=>`<h4 class="sol">how to do it</h4>${h}`;
const prac=h=>`<div class="practice"><div class="pl">now you try — same method</div>${h}</div>`;

/* model papers */
const paper=(name,time,marks)=>`<div class="paperhead"><b>${name}</b><div class="meta"><span>Time: ${time}</span><span>Max marks: ${marks}</span></div></div>`;
const secband=(l,r)=>`<div class="secband"><b>Section ${l}</b><span>${r}</span></div>`;
const qa=(m,q,a)=>{const id='qa'+_h(q+a);
  return `<details class="qa" data-q="${id}"><summary><span class="pn">${m}</span><span class="pt">${q}</span><button class="star" data-bm="${id}" title="Bookmark this question for review" aria-label="Bookmark for review">☆</button><span class="chev">›</span></summary><div class="pbody"><div class="qmeta">model answer</div>${a}</div></details>`;};

window.STATIONS=[];
const STATIONS=window.STATIONS;
window.OMR={}; window.CARDS={};
const OMR=window.OMR, CARDS=window.CARDS;     // question banks, filled by data.bank.js
