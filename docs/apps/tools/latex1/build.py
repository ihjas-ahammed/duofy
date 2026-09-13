#!/usr/bin/env python3
"""Build LATEX_1.html (online) and LATEX_12_OFFLINE.html (self-contained) from src/ + vendor/.

online : latex.js + its preview CSS/fonts from jsDelivr, Google Fonts, TeX Live PDF tab, Firebase sync
offline: every library, stylesheet and font inlined; no network needed; the PDF tab points online
"""
import io, os, re, json, base64, datetime, urllib.request

HERE = os.path.dirname(os.path.abspath(__file__))
SRC, VEN = os.path.join(HERE, 'src'), os.path.join(HERE, 'vendor')
OUT = os.path.abspath(os.path.join(HERE, '..', '..'))
ONLINE_URL = 'https://ssc-data-science-qm.web.app/LATEX_1.html'
LATEXJS_CDN = 'https://cdn.jsdelivr.net/npm/latex.js@0.12.6/dist/'
GF = ('https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600'
      '&family=Newsreader:ital,opsz,wght@0,6..72,400..600;1,6..72,400..600'
      '&family=Source+Sans+3:ital,wght@0,400..700;1,400..700&display=swap')

rd = lambda p: io.open(p, encoding='utf-8').read()
js = lambda s: s.replace('</script', '<\\/script')          # safe to inline


def ui_fonts_inline():
    """Latin subsets of the UI fonts as base64 woff2, cached in vendor/uifonts.css."""
    cache = os.path.join(VEN, 'uifonts.css')
    if os.path.exists(cache):
        return rd(cache)
    ua = ('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
          '(KHTML, like Gecko) Chrome/126.0 Safari/537.36')
    css = urllib.request.urlopen(urllib.request.Request(GF, headers={'User-Agent': ua})).read().decode()
    blocks = re.findall(r'/\* ([\w-]+) \*/\s*(@font-face\s*\{[^}]*\})', css)
    out = []
    for subset, block in blocks:
        if subset != 'latin':
            continue
        url = re.search(r'url\((https://[^)]+)\)', block).group(1)
        b = urllib.request.urlopen(urllib.request.Request(url, headers={'User-Agent': ua})).read()
        out.append(block.replace(url, 'data:font/woff2;base64,' + base64.b64encode(b).decode()))
    res = '\n'.join(out)
    io.open(cache, 'w', encoding='utf-8').write(res)
    return res


def content():
    order = ['data.head.js', 'data.start.js', 'data.m1.js', 'data.m2.js', 'data.omr.js', 'data.tests.js', 'data.tail.js']
    return '\n'.join(rd(os.path.join(SRC, f)) for f in order if os.path.exists(os.path.join(SRC, f)))


def build(online):
    shell = rd(os.path.join(SRC, 'shell.html'))
    stamp = datetime.date.today().isoformat()
    cfg = {'online': online, 'cdn': LATEXJS_CDN, 'pdfServer': 'https://texlive.net/cgi-bin/latexcgi',
           'onlineURL': ONLINE_URL}
    head_fonts = (f'<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>'
                  f'<link rel="stylesheet" href="{GF}">') if online else f'<style>{ui_fonts_inline()}</style>'
    scripts = [f'<script>window.LX_CFG={json.dumps(cfg)};window.LX_BASEJS={json.dumps(rd(os.path.join(VEN, "latexjs-base.js")))};</script>']
    if online:
        scripts.append(f'<script src="{LATEXJS_CDN}latex.js"></script>')
    else:
        scripts.append('<script>' + js(rd(os.path.join(VEN, 'latex.js'))) + '</script>')
        prev = {k: rd(os.path.join(VEN, f'latexjs-{k}.css')) for k in ('fonts', 'base', 'article', 'book')}
        scripts.append('<script>window.LX_PREVIEW=' + json.dumps(prev).replace('</', '<\\/') + ';</script>')
    scripts.append('<script>' + js(rd(os.path.join(VEN, 'lxshiki.js'))) + '</script>')
    scripts.append('<script>' + js(rd(os.path.join(SRC, 'tex.js'))) + '</script>')
    scripts.append('<script>' + js(content()) + '</script>')
    scripts.append('<script>' + js(rd(os.path.join(SRC, 'ui.js'))) + '</script>')
    foot = (f'Built {stamp} · live preview by latex.js · highlighting by VS Code’s LaTeX grammar via Shiki'
            + (' · real PDFs by TeX Live on texlive.net' if online else
               f' · offline copy — for real PDFs use <a href="{ONLINE_URL}">the online version</a>'))
    html = (shell.replace('<!--LX:FONTS-->', head_fonts)
                 .replace('<!--LX:SCRIPTS-->', '\n'.join(scripts))
                 .replace('<!--LX:FOOT-->', foot))
    name = 'LATEX_1.html' if online else 'LATEX_12_OFFLINE.html'
    io.open(os.path.join(OUT, name), 'w', encoding='utf-8').write(html)
    print(f'built {name}: {len(html.encode()):,} bytes')


if __name__ == '__main__':
    build(True)
    build(False)
