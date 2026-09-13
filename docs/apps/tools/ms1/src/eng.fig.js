/* ══════════════════════════════════════════════════════════════════
   figure engine — 2-D canvases (FIGS) and a library-free 3-D renderer
   (MODELS + V3D). Figures are set up lazily when their card opens and
   resized by a ResizeObserver, so collapsed cards cost nothing.
   ══════════════════════════════════════════════════════════════════ */
const FIGS={}, MODELS={}, V3D={};
const liveFigs=[], live3D=[];
const figRO=('ResizeObserver' in window)?new ResizeObserver(es=>es.forEach(e=>{const r=e.target._rec;if(r&&e.contentRect.width>0&&Math.abs(e.contentRect.width-(r.W||0))>.5)r.size();})):null;
const figIO=('IntersectionObserver' in window)?new IntersectionObserver(es=>es.forEach(e=>{const r=e.target._rec;if(r)r.visible=e.isIntersecting;}),{threshold:.08}):null;

/* a chip bar + an optional stepper, shared by 2-D and 3-D figures */
function figBar(wrap,spec,st,onChange,extra){
  const bar=document.createElement('div');bar.className='figbar below';
  const same=(x,y)=>JSON.stringify(x)===JSON.stringify(y);
  const sync=()=>$$('.chipbtn',bar).forEach(x=>{const c=x._ch,k=Object.keys(c.set)[0];
    x.classList.toggle('on',c.toggle?!!st.opt[k]:same(st.opt[k],c.set[k]));
    const off=spec.disabled?!!spec.disabled(c,st.opt):false;x.classList.toggle('off',off);x.disabled=off;});
  (spec.chips||[]).forEach(ch=>{
    if(ch.sep!==undefined){const t=document.createElement('span');t.className='figsep';t.textContent=ch.sep;bar.appendChild(t);return;}
    if(ch.brk){const b=document.createElement('span');b.className='brk';bar.appendChild(b);return;}
    const key=Object.keys(ch.set)[0],b=document.createElement('button');
    b.type='button';
    b.className='chipbtn';b.textContent=ch.label;b._ch=ch;
    b.onclick=e=>{e.stopPropagation();if(ch.toggle)st.opt[key]=!st.opt[key];else Object.assign(st.opt,ch.set);
      if(spec.coerce)spec.coerce(st.opt);if(spec.onChip)spec.onChip(st);sync();if(st._updateCap)st._updateCap();onChange('chip');};
    bar.appendChild(b);});
  sync();
  const mk=(t,title,fn,cls)=>{const b=document.createElement('button');b.type='button';b.textContent=t;b.title=title;if(cls)b.className=cls;
    b.onclick=e=>{e.stopPropagation();fn();};bar.appendChild(b);return b;};
  let go=null;
  if(spec.steps){
    if(spec.chips&&spec.chips.length){const br=document.createElement('span');br.className='brk';bar.appendChild(br);}
    const cap=document.createElement('span');cap.className='stepcap';const nums=[];
    let prevBtn=null, nextBtn=null;
    const updateCap=()=>{
      const s=spec.steps[st.step];cap.innerHTML='<b>step '+(st.step+1)+'/'+spec.steps.length+'</b>'+(typeof s==='function'?s(st):s);
      mj(cap);
    };
    st._updateCap=updateCap;
    go=i=>{st.step=Math.max(0,Math.min(spec.steps.length-1,i));nums.forEach((b,k)=>b.classList.toggle('on',k===st.step));
      if(prevBtn)prevBtn.disabled=(st.step===0);
      if(nextBtn)nextBtn.disabled=(st.step===spec.steps.length-1);
      updateCap();
      onChange('step');};
    prevBtn=mk('◀','Previous step',()=>go(st.step-1));
    prevBtn.disabled=(st.step===0);
    spec.steps.forEach((_,i)=>{const b=mk(String(i+1),'Step '+(i+1),()=>go(i),'step');nums.push(b);});
    nextBtn=mk('▶','Next step',()=>go(st.step+1));
    if(extra)extra(mk,bar);
    bar.appendChild(cap);st._cap=cap;
  }else if(extra)extra(mk,bar);

  // Insert controls directly below canvas (before legend/caption)
  const fc=wrap.querySelector('.leg, figcaption');
  if(fc)wrap.insertBefore(bar,fc);
  else wrap.appendChild(bar);
  return {bar,go,sync};
}

/* ── 2-D figures ── */
function setupFig(cv){
  if(cv._rec)return cv._rec;
  const name=cv.dataset.fig,F=FIGS[name];if(!F){console.warn('no figure',name);return null;}
  const wrap=cv.closest('figure')||cv.parentElement;
  const st={t:0,playing:!!F.anim&&F.autoplay!==false,step:0,opt:Object.assign({},F.opt||{}),memo:{}};
  const rec={cv,name,F,st,visible:!figIO,W:0,H:0};cv._rec=rec;
  let warned=false;
  function size(){const cssW=cv.clientWidth||0;if(!cssW)return;
    const dpr=Math.min(2,window.devicePixelRatio||1);
    const ar=(typeof F.ar==='function')?F.ar(cssW,st):(cssW<480&&F.arN?F.arN:F.ar);
    const cssH=Math.round(cssW*ar);
    cv.width=Math.round(cssW*dpr);cv.height=Math.round(cssH*dpr);cv.style.height=cssH+'px';
    cv.getContext('2d').setTransform(dpr,0,0,dpr,0,0);rec.W=cssW;rec.H=cssH;render();}
  function render(){if(!rec.W)return;readPalette();const ctx=cv.getContext('2d');
    ctx.save();try{F.draw(ctx,rec.W,rec.H,st);}catch(e){if(!warned){console.error('figure',name,e);warned=true;}}ctx.restore();}
  rec.size=size;rec.render=render;
  if(F.chips||F.steps||F.anim){
    figBar(wrap,F,st,()=>{if(F.resetOnChange){st.t=0;st.memo={};}if(typeof F.ar==='function')size();else render();},(mk)=>{
      if(!F.anim)return;
      const play=mk(st.playing?'❚❚':'▶',st.playing?'Pause':'Play',()=>{st.playing=!st.playing;play.textContent=st.playing?'❚❚':'▶';play.title=st.playing?'Pause':'Play';});
      mk('↺','Restart',()=>{st.t=0;st.memo={};if(!st.playing){st.playing=true;play.textContent='❚❚';}render();});
    });
    if(F.steps)setTimeout(()=>{const s=F.steps[0];if(st._cap){st._cap.innerHTML='<b>step 1/'+F.steps.length+'</b>'+(typeof s==='function'?s(st):s);mj(st._cap);}
      const n=wrap.querySelector('.figbar button.step');if(n)n.classList.add('on');},0);
  }
  liveFigs.push(rec);if(figIO)figIO.observe(cv);if(figRO)figRO.observe(cv);else window.addEventListener('resize',debounce(size,160));
  size();return rec;
}

/* ── 3-D figures: spheres, bonds, faces and labels, painter-sorted ── */
function setup3D(cv){
  if(cv._rec)return cv._rec;
  const name=cv.dataset.v3d,spec=V3D[name];if(!spec||!MODELS[spec.model]){console.warn('no 3-D view',name);return null;}
  const wrap=cv.closest('figure')||cv.parentElement;
  const Y0=spec.yaw!=null?spec.yaw:.62,P0=spec.pitch!=null?spec.pitch:.42;
  const st={yaw:Y0,pitch:P0,zoom:spec.zoom0||1,auto:spec.spin!==false,step:0,opt:Object.assign({},spec.opt||{})};
  const rec={cv,st,visible:!figIO,is3d:true,W:0,H:0};cv._rec=rec;
  let scene=null;
  const withStep=i=>Object.assign({},st.opt,{step:i});
  const reach=sc=>{let m=0;const hit=p=>{const d=Math.hypot(p[0],p[1],p[2]);if(d>m)m=d;};
    (sc.balls||[]).forEach(b=>{m=Math.max(m,Math.hypot(b.c[0],b.c[1],b.c[2])+b.r);});
    (sc.bonds||[]).forEach(l=>{hit(l.a);hit(l.b);});(sc.faces||[]).forEach(f=>f.pts.forEach(hit));
    (sc.labels||[]).forEach(t=>hit(t.p));return m;};
  const build=()=>{scene=MODELS[spec.model](withStep(st.step));let m=reach(scene);
    if(spec.steps)for(let i=0;i<spec.steps.length;i++)m=Math.max(m,reach(MODELS[spec.model](withStep(i))));
    scene.fit=m||1;};
  build();
  function size(){const cssW=cv.clientWidth||0;if(!cssW)return;
    const dpr=Math.min(2,window.devicePixelRatio||1);const ar=cssW<480?(spec.arN||.95):(spec.ar||.68);
    const cssH=Math.round(cssW*ar);cv.width=Math.round(cssW*dpr);cv.height=Math.round(cssH*dpr);cv.style.height=cssH+'px';
    cv.getContext('2d').setTransform(dpr,0,0,dpr,0,0);rec.W=cssW;rec.H=cssH;draw();}
  const COL=n=>({pos:C.pos,neg:C.neg,accent:C.prob,wall:C.wall,blue:C.blue,amber:C.amber,green:C.green,
                 rule:C.inkA(.34),rule2:C.inkA(.18),ink:C.ink}[n]||C.ink);
  const COLA=(n,a)=>({pos:C.posA(a),neg:C.negA(a),accent:C.probA(a),wall:C.wallA(a),blue:C.blueA(a),amber:C.amberA(a),green:C.greenA(a),
                      rule:C.inkA(a*.5),rule2:C.inkA(a*.35),ink:C.inkA(a)}[n]||C.inkA(a));
  const L=V.norm([-.45,.62,.64]);
  function draw(){
    if(!rec.W)return;readPalette();
    const ctx=cv.getContext('2d'),W=rec.W,H=rec.H;ctx.clearRect(0,0,W,H);
    const cy=Math.cos(st.yaw),sy=Math.sin(st.yaw),cp=Math.cos(st.pitch),sp=Math.sin(st.pitch);
    const rot=p=>{const x=p[0]*cy+p[2]*sy,z=-p[0]*sy+p[2]*cy;return [x,p[1]*cp-z*sp,p[1]*sp+z*cp];};
    const base=Math.min(W,H)*.42/scene.fit*st.zoom,d=6,cy0=H/2+(spec.shiftY||0);
    const proj=q=>{const k=d/(d-q[2]*.55);return [W/2+q[0]*base*k,cy0-q[1]*base*k,q[2],k];};
    const items=[];
    (scene.balls||[]).forEach(b=>{const q=rot(b.c);items.push({z:q[2],kind:'b',q,o:b});});
    (scene.bonds||[]).forEach(l=>{const a=rot(l.a),b=rot(l.b);items.push({z:(a[2]+b[2])/2+(l.zb||0),kind:'l',a,b,o:l});});
    (scene.faces||[]).forEach(f=>{const pts=f.pts.map(rot);const z=pts.reduce((s,p)=>s+p[2],0)/pts.length;items.push({z:z+(f.zb||0),kind:'f',pts,o:f});});
    (scene.labels||[]).forEach(t=>{const q=rot(t.p);items.push({z:q[2]+9,kind:'t',q,o:t});});
    items.sort((a,b)=>a.z-b.z);
    for(const it of items){
      if(it.kind==='l'){const A=proj(it.a),B=proj(it.b);
        ctx.save();ctx.strokeStyle=COL(it.o.col);ctx.lineWidth=it.o.w||1.2;ctx.lineCap='round';
        if(it.o.dash)ctx.setLineDash(it.o.dash);ctx.globalAlpha=it.o.alpha!=null?it.o.alpha:(.55+.45*clamp((it.z+1.6)/3.2,0,1));
        ctx.beginPath();ctx.moveTo(A[0],A[1]);ctx.lineTo(B[0],B[1]);ctx.stroke();
        if(it.o.arrow){const a=Math.atan2(B[1]-A[1],B[0]-A[0]),h=9;ctx.setLineDash([]);ctx.fillStyle=COL(it.o.col);ctx.beginPath();
          ctx.moveTo(B[0],B[1]);ctx.lineTo(B[0]-h*Math.cos(a-.42),B[1]-h*Math.sin(a-.42));ctx.lineTo(B[0]-h*Math.cos(a+.42),B[1]-h*Math.sin(a+.42));ctx.closePath();ctx.fill();}
        ctx.restore();
      }else if(it.kind==='f'){const P2=it.pts.map(proj);
        let shade=0;if(it.o.lit){const n=V.norm(V.cross(V.sub(it.pts[1],it.pts[0]),V.sub(it.pts[2],it.pts[0])));
          if(n[2]<0&&it.o.cull!==false)continue;shade=1-clamp(Math.abs(V.dot(n,L)),0,1);}
        ctx.save();ctx.beginPath();P2.forEach((p,i)=>i?ctx.lineTo(p[0],p[1]):ctx.moveTo(p[0],p[1]));ctx.closePath();
        ctx.fillStyle=COLA(it.o.col,it.o.alpha==null?.3:it.o.alpha);ctx.fill();
        if(it.o.lit){ctx.fillStyle=`rgba(0,0,0,${(shade*.42).toFixed(3)})`;ctx.fill();}
        if(it.o.edge){ctx.strokeStyle=COLA(it.o.edge,.8);ctx.lineWidth=.8;ctx.stroke();}
        ctx.restore();
      }else if(it.kind==='t'){const P2=proj(it.q);
        ctx.save();ctx.textAlign='center';ctx.textBaseline='middle';ctx.font=(it.o.sz?`600 ${it.o.sz}px `:'600 12.5px ')+(it.o.mono?FM:FD);
        ctx.lineWidth=3.4;ctx.lineJoin='round';ctx.strokeStyle=C.bg;ctx.strokeText(it.o.t,P2[0],P2[1]);
        ctx.fillStyle=COL(it.o.col);ctx.fillText(it.o.t,P2[0],P2[1]);ctx.restore();
      }else{const P2=proj(it.q),r=Math.max(1.5,it.o.r*base*P2[3]);
        const g=ctx.createRadialGradient(P2[0]-r*.35,P2[1]-r*.4,r*.1,P2[0],P2[1],r);
        g.addColorStop(0,COLA(it.o.col,.55));g.addColorStop(.62,COL(it.o.col));g.addColorStop(1,COLA(it.o.col,.7));
        ctx.save();ctx.globalAlpha=it.o.alpha==null?1:it.o.alpha;ctx.beginPath();ctx.arc(P2[0],P2[1],r,0,7);ctx.fillStyle=g;ctx.fill();
        ctx.lineWidth=.8;ctx.strokeStyle=COLA(it.o.col,.95);ctx.stroke();
        if(it.o.ring){ctx.setLineDash([3,3]);ctx.strokeStyle=COL(it.o.ring);ctx.lineWidth=1.4;ctx.beginPath();ctx.arc(P2[0],P2[1],r+3,0,7);ctx.stroke();}
        ctx.restore();}
    }
    if(spec.overlay)spec.overlay(ctx,W,H,st);
    ctx.save();ctx.fillStyle=C.inkA(.42);ctx.font=`10px ${FM}`;ctx.textBaseline='bottom';
    ctx.fillText(st.auto?'drag sideways to rotate · pinch or +/− to zoom':'⟳ resets the view',10,H-8);ctx.restore();
  }
  rec.size=size;rec.render=draw;rec.rebuild=()=>{build();draw();};
  figBar(wrap,spec,st,()=>rec.rebuild(),(mk,bar)=>{
    if(spec.steps||(spec.chips&&spec.chips.length)){const br=document.createElement('span');br.className='brk';bar.appendChild(br);}
    const g=document.createElement('span');g.className='grow';bar.appendChild(g);
    mk('−','Zoom out',()=>{st.auto=false;st.zoom=Math.max(.5,st.zoom/1.18);draw();});
    mk('+','Zoom in',()=>{st.auto=false;st.zoom=Math.min(2.8,st.zoom*1.18);draw();});
    mk('⟳','Reset view',()=>{st.yaw=Y0;st.pitch=P0;st.zoom=spec.zoom0||1;st.auto=spec.spin!==false;draw();});
  });
  if(spec.steps)setTimeout(()=>{const s=spec.steps[0];if(st._cap)st._cap.innerHTML='<b>step 1/'+spec.steps.length+'</b>'+(typeof s==='function'?s(st):s);
    const n=wrap.querySelector('.figbar button.step');if(n)n.classList.add('on');},0);
  /* pointer + touch: smooth 360° orbit with pointer capture */
  let drag=false,lx=0,ly=0,pid=null,pinch=0;
  cv.style.touchAction='none';

  cv.addEventListener('pointerdown',e=>{
    if(e.pointerType==='touch'&&e.isPrimary===false)return;
    drag=true;pid=e.pointerId;lx=e.clientX;ly=e.clientY;
    st.auto=false;
    try{cv.setPointerCapture(e.pointerId);}catch(_){}
  });

  cv.addEventListener('pointermove',e=>{
    if(!drag||e.pointerId!==pid)return;
    e.preventDefault();
    const dx=e.clientX-lx,dy=e.clientY-ly;
    st.yaw+=dx*0.011;
    st.pitch=clamp(st.pitch+dy*0.011,-1.45,1.45);
    lx=e.clientX;ly=e.clientY;
    draw();
  });

  const end=e=>{
    if(e&&e.pointerId&&e.pointerId!==pid)return;
    drag=false;
    if(pid!==null){
      try{cv.releasePointerCapture(pid);}catch(_){}
      pid=null;
    }
  };
  cv.addEventListener('pointerup',end);
  cv.addEventListener('pointercancel',end);
  cv.addEventListener('lostpointercapture',end);

  /* the wheel scrolls the page; ctrl/⌘ + wheel (and a trackpad pinch) zooms */
  cv.addEventListener('wheel',e=>{if(!e.ctrlKey&&!e.metaKey)return;e.preventDefault();st.auto=false;
    st.zoom=clamp(st.zoom*(e.deltaY>0?.92:1.08),.5,2.8);draw();},{passive:false});
  cv.addEventListener('touchstart',e=>{if(e.touches.length===2){drag=false;st.auto=false;
    pinch=Math.hypot(e.touches[0].clientX-e.touches[1].clientX,e.touches[0].clientY-e.touches[1].clientY);}},{passive:true});
  cv.addEventListener('touchmove',e=>{if(e.touches.length===2&&pinch){e.preventDefault();
    const d2=Math.hypot(e.touches[0].clientX-e.touches[1].clientX,e.touches[0].clientY-e.touches[1].clientY);
    st.zoom=clamp(st.zoom*(d2/pinch),.5,2.8);pinch=d2;draw();}},{passive:false});
  cv.addEventListener('touchend',()=>{pinch=0;});
  live3D.push(rec);if(figIO)figIO.observe(cv);if(figRO)figRO.observe(cv);else window.addEventListener('resize',debounce(size,160));
  size();return rec;
}
let lastT=performance.now();
function loop(now){const dt=Math.min(.05,(now-lastT)/1000);lastT=now;
  for(const r of liveFigs)if(r.F.anim&&r.st.playing&&r.visible){r.st.t+=dt;r.render();}
  for(const r of live3D)if(r.st.auto&&r.visible){r.st.yaw+=dt*.3;r.render();}
  requestAnimationFrame(loop);}
requestAnimationFrame(loop);
function setupFigsIn(root){
  $$('canvas[data-fig]',root).forEach(cv=>{const r=cv._rec||setupFig(cv);if(r&&!r.W&&cv.clientWidth>0)r.size();});
  $$('canvas[data-v3d]',root).forEach(cv=>{const r=cv._rec||setup3D(cv);if(r&&!r.W&&cv.clientWidth>0)r.size();});
}
function redrawAll(){liveFigs.concat(live3D).forEach(r=>{if(r.W)r.render();});}

/* ── shared 3-D builders ── */
/* crystal (a,b,c) → engine (x, y-up, z), so c stands upright */
const T3=(p,o)=>{o=o||[.5,.5,.5];return [p[0]-o[0],p[2]-o[2],p[1]-o[1]];};
function boxEdges3(lo,hi){const c=[];for(let i=0;i<2;i++)for(let j=0;j<2;j++)for(let k=0;k<2;k++)c.push([i?hi[0]:lo[0],j?hi[1]:lo[1],k?hi[2]:lo[2]]);
  const e=[];for(let x=0;x<8;x++)for(let y=x+1;y<8;y++){let n=0;for(let d=0;d<3;d++)if(Math.abs(c[x][d]-c[y][d])>1e-9)n++;if(n===1)e.push([c[x],c[y]]);}return e;}
function cubeFaces(c,s,col,alpha){ // an axis-aligned cube (engine coords) as 6 lit faces
  const h=s/2,[x,y,z]=c,v=(a,b,d)=>[x+a*h,y+b*h,z+d*h];
  return [[v(-1,-1,1),v(1,-1,1),v(1,1,1),v(-1,1,1)],[v(1,-1,-1),v(-1,-1,-1),v(-1,1,-1),v(1,1,-1)],
          [v(1,-1,1),v(1,-1,-1),v(1,1,-1),v(1,1,1)],[v(-1,-1,-1),v(-1,-1,1),v(-1,1,1),v(-1,1,-1)],
          [v(-1,1,1),v(1,1,1),v(1,1,-1),v(-1,1,-1)],[v(-1,-1,-1),v(1,-1,-1),v(1,-1,1),v(-1,-1,1)]]
    .map(pts=>({pts,col,alpha:alpha==null?.92:alpha,lit:true,edge:'ink'}));
}
