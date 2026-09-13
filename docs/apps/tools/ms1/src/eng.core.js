/* ══════════════════════════════════════════════════════════════════
   Materials Science · Modules I–II — study engine
   core: helpers · MathJax queue · theme palette · Plot · geometry
    (the build wraps every eng.*.js file in one IIFE, in this order:
     core → fig → figs.m1 → figs.m2 → widgets → app)
   ══════════════════════════════════════════════════════════════════ */
const $=(s,r=document)=>r.querySelector(s),$$=(s,r=document)=>[...r.querySelectorAll(s)];
const CFG=Object.assign({online:true,onlineURL:'',offlineName:'MATERIAL_SCIENCE_12_OFFLINE.html'},window.MS_CFG||{});
const REG=window.MSREG||{w:{}};
const esc=s=>String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
const debounce=(f,ms)=>{let h;return(...a)=>{clearTimeout(h);h=setTimeout(()=>f(...a),ms);};};
const el=h=>{const d=document.createElement('div');d.innerHTML=h.trim();return d.firstElementChild;};
const hash=s=>{let h=5381;for(let i=0;i<s.length;i++)h=((h<<5)+h+s.charCodeAt(i))|0;return Math.abs(h);};
const shuffle=(a,seed)=>{a=a.slice();let s=seed||Math.random()*1e9|0;const r=()=>{s=(s*1103515245+12345)&0x7fffffff;return s/0x7fffffff;};
  for(let i=a.length-1;i>0;i--){const j=Math.floor(r()*(i+1));[a[i],a[j]]=[a[j],a[i]];}return a;};
const clamp=(v,a,b)=>v<a?a:v>b?b:v;
/* seeded RNG — every "random" microstructure is the same on every visit */
function rng(seed){let a=seed>>>0||1;return()=>{a|=0;a=a+0x6D2B79F5|0;let t=Math.imul(a^a>>>15,1|a);
  t=t+Math.imul(t^t>>>7,61|t)^t;return((t^t>>>14)>>>0)/4294967296;};}

/* ── MathJax: typeset only when it is ready; queue until then ── */
function mj(node,then){
  const run=()=>{try{const M=window.MathJax;const p=node?M.typesetPromise([node]):M.typesetPromise();
      p.then(()=>then&&then()).catch(()=>then&&then());}catch(e){then&&then();}};
  if(window.__mjReady&&window.MathJax&&window.MathJax.typesetPromise)run();
  else (window.__mjQueue=window.__mjQueue||[]).push(run);
}
function mjClear(node){try{if(window.__mjReady)window.MathJax.typesetClear([node]);}catch(e){}}

/* ── palette read from CSS custom properties at draw time (theme-aware) ── */
let C={};
const FD="'Newsreader','Iowan Old Style','Palatino Linotype',Georgia,serif", FB="'Source Sans 3','Segoe UI',system-ui,-apple-system,Roboto,sans-serif", FM="'JetBrains Mono',Consolas,monospace";
function readPalette(){
  const cs=getComputedStyle(document.documentElement);
  const g=n=>cs.getPropertyValue(n).trim();
  const rgb=n=>`rgb(${g(n)})`, rgba=(n,a)=>`rgba(${g(n)},${a})`;
  C={
    pos:rgb('--pos-rgb'),neg:rgb('--neg-rgb'),prob:rgb('--prob-rgb'),wall:rgb('--wall-rgb'),
    posA:a=>rgba('--pos-rgb',a),negA:a=>rgba('--neg-rgb',a),probA:a=>rgba('--prob-rgb',a),wallA:a=>rgba('--wall-rgb',a),
    blue:rgb('--blue-rgb'),blueA:a=>rgba('--blue-rgb',a),amber:rgb('--amber-rgb'),amberA:a=>rgba('--amber-rgb',a),
    green:rgb('--green-rgb'),greenA:a=>rgba('--green-rgb',a),red:rgb('--red-rgb'),
    ink:rgb('--ink-rgb'),inkA:a=>rgba('--ink-rgb',a),
    bg:g('--plot-bg'),grid:g('--plot-grid'),axis:g('--plot-axis'),dark:g('--is-dark')==='1'
  };
}
/* caption block drawn inside a canvas: first line is the title, the rest are data lines */
function capBlock(ctx,lines,x0,y0){
  ctx.save();ctx.textBaseline='top';ctx.textAlign='left';let y=y0==null?8:y0;const x=x0==null?10:x0;
  lines.forEach((L,i)=>{if(!L)return;
    ctx.font=i===0?`600 12px ${FD}`:`10.5px ${FM}`;
    ctx.lineWidth=3;ctx.lineJoin='round';ctx.strokeStyle=C.bg;ctx.strokeText(L[0],x,y);
    ctx.fillStyle=L[1]||C.ink;ctx.fillText(L[0],x,y);y+=i===0?17:14;});
  ctx.restore();return y;
}

/* ── plotting helper: world ↔ pixel, curves, fills, labels ── */
function Plot(ctx,W,H,pad){
  pad=Object.assign({l:40,r:16,t:16,b:40},pad||{});
  const x0=pad.l,x1=W-pad.r,y0=H-pad.b,y1=pad.t;
  let dom=[-1,1],ran=[-1,1];
  const P={ctx,W,H,pad,box:{x0,x1,y0,y1},
    dom(a,b){dom=[a,b];return P},ran(a,b){ran=[a,b];return P},
    get D(){return dom},get R(){return ran},
    X(x){return x0+(x-dom[0])/(dom[1]-dom[0])*(x1-x0)},
    Y(y){return y0+(y-ran[0])/(ran[1]-ran[0])*(y1-y0)},
    ix(px){return dom[0]+(px-x0)/(x1-x0)*(dom[1]-dom[0])},
    clear(){ctx.clearRect(0,0,W,H);return P},
    clip(){ctx.save();ctx.beginPath();ctx.rect(x0,y1,x1-x0,y0-y1);ctx.clip();return P},
    unclip(){ctx.restore();return P},
    grid(nx,ny){ctx.save();ctx.strokeStyle=C.grid;ctx.lineWidth=1;ctx.beginPath();
      for(let i=0;i<=nx;i++){const x=x0+(x1-x0)*i/nx;ctx.moveTo(x,y1);ctx.lineTo(x,y0);}
      for(let j=0;j<=ny;j++){const y=y1+(y0-y1)*j/ny;ctx.moveTo(x0,y);ctx.lineTo(x1,y);}
      ctx.stroke();ctx.restore();return P},
    axes(o){o=o||{};ctx.save();ctx.strokeStyle=C.axis;ctx.lineWidth=1.4;
      const yz=o.y0!=null?P.Y(o.y0):(ran[0]<0&&ran[1]>0)?P.Y(0):y0;
      ctx.beginPath();ctx.moveTo(x0,y1);ctx.lineTo(x0,y0);ctx.stroke();
      ctx.beginPath();ctx.moveTo(x0,yz);ctx.lineTo(x1,yz);ctx.stroke();
      /* the x-axis label lives under the tick row, centred — right-aligning it at x1
         put it straight on top of the last tick label on every plot */
      if(o.xl)P.text((x0+x1)/2,o.xlUp?yz-15:Math.min(y0+21,H-13),o.xl,C.inkA(.7),{align:'center',sz:10.5});
      if(o.yl){ctx.save();ctx.translate(12,y1+(y0-y1)/2);ctx.rotate(-Math.PI/2);
        ctx.fillStyle=C.inkA(.7);ctx.font=`10.5px ${FM}`;ctx.textAlign='center';ctx.textBaseline='middle';ctx.fillText(o.yl,0,0);ctx.restore();}
      ctx.restore();return P},
    xticks(vals,fmt,o){o=o||{};ctx.save();ctx.fillStyle=C.inkA(.6);ctx.strokeStyle=C.axis;ctx.font=`9.5px ${FM}`;
      ctx.textAlign='center';ctx.textBaseline='top';const yb=o.at!=null?P.Y(o.at):y0;
      vals.forEach(v=>{const px=P.X(v);ctx.beginPath();ctx.moveTo(px,yb);ctx.lineTo(px,yb+4);ctx.stroke();
        ctx.fillText(fmt?fmt(v):String(v),px,yb+6);});ctx.restore();return P},
    yticks(vals,fmt){ctx.save();ctx.fillStyle=C.inkA(.6);ctx.strokeStyle=C.axis;ctx.font=`9.5px ${FM}`;
      ctx.textAlign='right';ctx.textBaseline='middle';
      vals.forEach(v=>{const py=P.Y(v);ctx.beginPath();ctx.moveTo(x0-4,py);ctx.lineTo(x0,py);ctx.stroke();
        ctx.fillText(fmt?fmt(v):String(v),x0-6,py);});ctx.restore();return P},
    curve(fn,color,w,dash,a,b){ctx.save();ctx.strokeStyle=color;ctx.lineWidth=w||2;
      if(dash)ctx.setLineDash(dash);ctx.lineJoin='round';ctx.beginPath();
      const lo=a==null?dom[0]:a,hi=b==null?dom[1]:b,N=360;let on=false;
      for(let i=0;i<=N;i++){const x=lo+(hi-lo)*i/N;let y=fn(x);
        if(y==null||!isFinite(y)){on=false;continue;}
        y=clamp(y,ran[0]-(ran[1]-ran[0])*3,ran[1]+(ran[1]-ran[0])*3);const px=P.X(x),py=P.Y(y);
        if(!on){ctx.moveTo(px,py);on=true;}else ctx.lineTo(px,py);}
      ctx.stroke();ctx.restore();return P},
    fill(fn,color,a,b,base){ctx.save();ctx.fillStyle=color;ctx.beginPath();
      const lo=a==null?dom[0]:a,hi=b==null?dom[1]:b,N=200,bs=base==null?0:base;
      ctx.moveTo(P.X(lo),P.Y(bs));
      for(let i=0;i<=N;i++){const x=lo+(hi-lo)*i/N;let y=fn(x);if(!isFinite(y))y=bs;
        ctx.lineTo(P.X(x),P.Y(clamp(y,ran[0],ran[1])));}
      ctx.lineTo(P.X(hi),P.Y(bs));ctx.closePath();ctx.fill();ctx.restore();return P},
    vline(x,color,w,dash){ctx.save();ctx.strokeStyle=color;ctx.lineWidth=w||1.5;
      if(dash)ctx.setLineDash(dash);ctx.beginPath();ctx.moveTo(P.X(x),y1);ctx.lineTo(P.X(x),y0);ctx.stroke();ctx.restore();return P},
    hline(y,color,w,dash){ctx.save();ctx.strokeStyle=color;ctx.lineWidth=w||1.5;
      if(dash)ctx.setLineDash(dash);ctx.beginPath();ctx.moveTo(x0,P.Y(y));ctx.lineTo(x1,P.Y(y));ctx.stroke();ctx.restore();return P},
    seg(ax,ay,bx,by,color,w,dash){ctx.save();ctx.strokeStyle=color;ctx.lineWidth=w||1.5;ctx.lineCap='round';
      if(dash)ctx.setLineDash(dash);ctx.beginPath();ctx.moveTo(P.X(ax),P.Y(ay));ctx.lineTo(P.X(bx),P.Y(by));ctx.stroke();ctx.restore();return P},
    line(ax,ay,bx,by,color,w,dash){return P.seg(ax,ay,bx,by,color,w,dash);},
    plot(fn,color,w,dash,a,b){return P.curve(fn,color,w,dash,a,b);},
    arrow(ax,ay,bx,by,color,w,head){const X1=P.X(ax),Y1=P.Y(ay),X2=P.X(bx),Y2=P.Y(by);arrowPx(ctx,X1,Y1,X2,Y2,color,w,head);return P},
    dot(x,y,color,r,stroke){ctx.save();ctx.fillStyle=color;ctx.beginPath();ctx.arc(P.X(x),P.Y(y),r||3,0,7);ctx.fill();
      if(stroke){ctx.strokeStyle=stroke;ctx.lineWidth=1;ctx.stroke();}ctx.restore();return P},
    ring(x,y,color,r,w){ctx.save();ctx.strokeStyle=color;ctx.lineWidth=w||1.5;ctx.beginPath();ctx.arc(P.X(x),P.Y(y),r||4,0,7);ctx.stroke();ctx.restore();return P},
    circle(x,y,r,fillC,strokeC,strokeW,dash){ctx.save();
      if(fillC&&fillC!=='transparent'){ctx.fillStyle=fillC;ctx.beginPath();ctx.arc(P.X(x),P.Y(y),r||4,0,Math.PI*2);ctx.fill();}
      if(strokeC){ctx.strokeStyle=strokeC;ctx.lineWidth=strokeW||1;if(dash)ctx.setLineDash(dash);
        ctx.beginPath();ctx.arc(P.X(x),P.Y(y),r||4,0,Math.PI*2);ctx.stroke();}
      ctx.restore();return P;},
    poly(pts,fillC,strokeC,w){if(!pts.length)return P;ctx.save();ctx.beginPath();
      pts.forEach((q,i)=>i?ctx.lineTo(P.X(q[0]),P.Y(q[1])):ctx.moveTo(P.X(q[0]),P.Y(q[1])));ctx.closePath();
      if(fillC){ctx.fillStyle=fillC;ctx.fill();}if(strokeC){ctx.strokeStyle=strokeC;ctx.lineWidth=w||1.2;ctx.lineJoin='round';ctx.stroke();}
      ctx.restore();return P},
    label(x,y,txt,color,o){o=o||{};return P.text(P.X(x)+(o.dx||0),P.Y(y)+(o.dy||0),txt,color,Object.assign({base:'alphabetic'},o))},
    text(px,py,txt,color,o){o=o||{};ctx.save();ctx.fillStyle=color||C.inkA(.75);
      ctx.font=(o.i?'italic ':'')+(o.b?'600 ':'')+(o.sz||11)+'px '+(o.d?FD:FM);
      ctx.textAlign=o.align||'left';ctx.textBaseline=o.base||'top';
      if(o.halo!==false){ctx.lineWidth=3;ctx.lineJoin='round';ctx.strokeStyle=C.bg;ctx.strokeText(txt,px,py);}
      ctx.fillText(txt,px,py);ctx.restore();return P}
  };
  return P;
}
function arrowPx(ctx,X1,Y1,X2,Y2,color,w,head){
  const a=Math.atan2(Y2-Y1,X2-X1),h=head||8;ctx.save();ctx.strokeStyle=color;ctx.fillStyle=color;ctx.lineWidth=w||1.8;ctx.lineCap='round';
  ctx.beginPath();ctx.moveTo(X1,Y1);ctx.lineTo(X2-Math.cos(a)*h*.6,Y2-Math.sin(a)*h*.6);ctx.stroke();
  ctx.beginPath();ctx.moveTo(X2,Y2);ctx.lineTo(X2-h*Math.cos(a-.42),Y2-h*Math.sin(a-.42));
  ctx.lineTo(X2-h*Math.cos(a+.42),Y2-h*Math.sin(a+.42));ctx.closePath();ctx.fill();ctx.restore();
}
/* shaded sphere (an atom / ion) in pixel space */
function ball(ctx,x,y,r,col,colA,o){o=o||{};
  const g=ctx.createRadialGradient(x-r*.35,y-r*.4,r*.1,x,y,r);
  g.addColorStop(0,colA(.55));g.addColorStop(.6,col);g.addColorStop(1,colA(.75));
  ctx.save();ctx.globalAlpha=o.alpha==null?1:o.alpha;ctx.beginPath();ctx.arc(x,y,r,0,7);ctx.fillStyle=g;ctx.fill();
  ctx.lineWidth=o.lw||1;ctx.strokeStyle=o.stroke||colA(.9);ctx.stroke();
  if(o.txt){ctx.fillStyle=o.txtCol||'#fff';ctx.font=`600 ${o.tsz||Math.max(8,r*.8)}px ${FM}`;ctx.textAlign='center';ctx.textBaseline='middle';ctx.fillText(o.txt,x,y+.5);}
  ctx.restore();
}

/* ── geometry ── */
function clipHalf(poly,nx,ny,d){                       // keep n·x <= d
  const out=[];
  for(let i=0;i<poly.length;i++){const A=poly[i],B=poly[(i+1)%poly.length];
    const da=nx*A[0]+ny*A[1]-d,db=nx*B[0]+ny*B[1]-d;
    if(da<=1e-12)out.push(A);
    if((da<-1e-12&&db>1e-12)||(da>1e-12&&db<-1e-12)){const t=da/(da-db);out.push([A[0]+t*(B[0]-A[0]),A[1]+t*(B[1]-A[1])]);}}
  return out;
}
/* Voronoi cells of seeds inside a box, each cell = box ∩ all bisector half-planes (exact, O(n²)) */
function voronoi(seeds,box){
  const [bx0,by0,bx1,by1]=box;
  return seeds.map((s,i)=>{let poly=[[bx0,by0],[bx1,by0],[bx1,by1],[bx0,by1]];
    for(let j=0;j<seeds.length&&poly.length;j++){if(j===i)continue;const t=seeds[j];
      const nx=t[0]-s[0],ny=t[1]-s[1];const r2=nx*nx+ny*ny;if(r2<1e-18)continue;
      /* cheap reject: a far seed cannot cut a small cell */
      const d=(t[0]*t[0]+t[1]*t[1]-s[0]*s[0]-s[1]*s[1])/2;
      poly=clipHalf(poly,nx,ny,d);}
    return poly;});
}
/* Poisson-disc-ish seeds: dart throwing with a minimum spacing */
function scatter(n,box,minD,R){const [x0,y0,x1,y1]=box,out=[];let tries=0;
  while(out.length<n&&tries<n*400){tries++;const p=[x0+(x1-x0)*R(),y0+(y1-y0)*R()];
    if(out.every(q=>(q[0]-p[0])**2+(q[1]-p[1])**2>=minD*minD))out.push(p);}
  return out;}
function polyArea(p){let a=0;for(let i=0;i<p.length;i++){const A=p[i],B=p[(i+1)%p.length];a+=A[0]*B[1]-B[0]*A[1];}return a/2;}
function centroid(p){let x=0,y=0;p.forEach(q=>{x+=q[0];y+=q[1];});return [x/p.length,y/p.length];}
/* segment–segment intersection parameter along the first segment, or null */
function segHit(ax,ay,bx,by,cx,cy,dx,dy){
  const r1=bx-ax,r2=by-ay,s1=dx-cx,s2=dy-cy,den=r1*s2-r2*s1;if(Math.abs(den)<1e-12)return null;
  const t=((cx-ax)*s2-(cy-ay)*s1)/den,u=((cx-ax)*r2-(cy-ay)*r1)/den;
  return(t>=0&&t<=1&&u>=0&&u<=1)?t:null;}
/* isotropic world window that fits a set of points inside the plot box */
function fitFrame(P,pts,pad){
  let x0=1e9,x1=-1e9,y0=1e9,y1=-1e9;
  pts.forEach(q=>{x0=Math.min(x0,q[0]);x1=Math.max(x1,q[0]);y0=Math.min(y0,q[1]);y1=Math.max(y1,q[1]);});
  const m=pad==null?.25:pad;x0-=m;x1+=m;y0-=m;y1+=m;
  const pw=P.box.x1-P.box.x0,ph=P.box.y0-P.box.y1;let w=x1-x0,h=y1-y0;const ap=pw/ph;
  if(w/h<ap){const nw=h*ap,c=(x0+x1)/2;x0=c-nw/2;x1=c+nw/2;}else{const nh=w/ap,c=(y0+y1)/2;y0=c-nh/2;y1=c+nh/2;}
  return P.dom(x0,x1).ran(y0,y1);
}
const V={
  sub:(a,b)=>[a[0]-b[0],a[1]-b[1],a[2]-b[2]],add:(a,b)=>[a[0]+b[0],a[1]+b[1],a[2]+b[2]],
  mul:(a,s)=>[a[0]*s,a[1]*s,a[2]*s],dot:(a,b)=>a[0]*b[0]+a[1]*b[1]+a[2]*b[2],
  cross:(a,b)=>[a[1]*b[2]-a[2]*b[1],a[2]*b[0]-a[0]*b[2],a[0]*b[1]-a[1]*b[0]],
  len:a=>Math.hypot(a[0],a[1],a[2]),norm:a=>{const l=Math.hypot(a[0],a[1],a[2])||1;return [a[0]/l,a[1]/l,a[2]/l];}
};
/* number formatting: 2.2×10²⁵ style, for canvases and formulas */
const SUP={'-':'⁻','0':'⁰','1':'¹','2':'²','3':'³','4':'⁴','5':'⁵','6':'⁶','7':'⁷','8':'⁸','9':'⁹'};
function sci(x,d){if(!isFinite(x))return '—';if(x===0)return '0';const e=Math.floor(Math.log10(Math.abs(x)));
  if(e>=-2&&e<=4)return (+x.toFixed(Math.max(0,(d==null?3:d)-1-Math.max(0,e)))).toString();
  const m=x/Math.pow(10,e);return m.toFixed(d==null?2:d-1)+'×10'+String(e).split('').map(c=>SUP[c]).join('');}
function texSci(x,d){if(!isFinite(x))return '\\mathrm{—}';if(x===0)return '0';const e=Math.floor(Math.log10(Math.abs(x)));
  if(e>=-3&&e<=4){const dp=Math.max(0,(d==null?4:d)-1-e);return (+x.toFixed(Math.min(8,dp))).toString();}
  let m=x/Math.pow(10,e);let ms=m.toFixed(d==null?2:d-1);if(Math.abs(+ms)>=10){ms=(m/10).toFixed(d==null?2:d-1);return ms+'\\times10^{'+(e+1)+'}';}
  return ms+'\\times10^{'+e+'}';}
