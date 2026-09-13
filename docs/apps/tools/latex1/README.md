# LATEX_1 — build sources

`python3 build.py` writes two files into `apps/`:

| file | what it is |
|---|---|
| `LATEX_1.html` | online app: latex.js + preview fonts from jsDelivr, Google Fonts, **Real PDF** tab (texlive.net), Firebase progress sync, ⤓ downloads the offline copy |
| `LATEX_12_OFFLINE.html` | self-contained (~3.5 MB): every library, stylesheet and font inlined; no network requests at all; the PDF tab points to the online app |

Deploy both with `bash ../deploy.sh` (site `ssc-data-science-qm`).

## Layout

```
src/shell.html     page skeleton + all CSS (placeholders <!--LX:FONTS-->, <!--LX:SCRIPTS-->, <!--LX:FOOT-->)
src/tex.js         LXTeX — lint (errors in two voices) + the emulation layer around latex.js:
                   tabular/table/tabbing, verbatim/\verb, thebibliography, a BibTeX emulator
                   (plain/unsrt/alpha/abbrv), a MakeIndex emulator, \footnote/\thanks, \newcommand,
                   \listoftables. Keeps line numbers stable so errors point at the user's line.
src/ui.js          engine: tree + focus accordion + width melting, live editor, widgets
                   (omr, cards, match, fill, parsons, predict, challenge), sync, theme
src/data.head.js   authoring helpers (ex, editor, omr, cards, match, fill, parsons, predict, fix, build, qa …)
src/data.start.js  orientation + playground
src/data.m1.js     Module I  — Tutorials I–V
src/data.m2.js     Module II — Tutorials VI–VII
src/data.tests.js  two model papers + last pass
src/data.tail.js   MODULES (the module → section map)
vendor/            lxshiki.js (Shiki core + VS Code LaTeX/BibTeX grammars + Light+/Dark+, JS regex engine),
                   latex.js 0.12.6, its base.js, preview CSS, subset Computer Modern + KaTeX fonts,
                   uifonts.css (cached latin woff2 of Newsreader / Source Sans 3 / JetBrains Mono)
```

## Authoring rules

* Content is written in `H`…`` / `L`…`` (String.raw): type LaTeX with **single** backslashes.
* LaTeX's opening quote is a backtick, which would end the template — write the fullwidth `｀` instead.
* Inside `${…}` you are in ordinary JS: strings there need doubled backslashes, or use `L`…``.
* `ex(snippet,{title, pre, cls, bib, note})` — the snippet is auto-wrapped into a full document;
  "full code" shows it in an alert, "▶ run" opens a live editor on it.
* `fill` blanks are `[[answer]]`; alternatives are separated by `¦` (a `|` is legal in table specs).
* Before shipping, run the example QA (compiles every example / Parsons solution / filled blank /
  predict option through LXTeX and flags any error or warning) — it must report `flagged=0`.

## Rebuilding the Shiki bundle

```
npm i @shikijs/core @shikijs/engine-javascript @shikijs/langs @shikijs/themes esbuild
npx esbuild vendor/lxshiki.src.mjs --bundle --minify --format=iife --outfile=vendor/lxshiki.js
```
