import { createHighlighterCoreSync } from '@shikijs/core'
import { createJavaScriptRegexEngine } from '@shikijs/engine-javascript'
import latex from '@shikijs/langs/latex'
import bibtex from '@shikijs/langs/bibtex'
import lightPlus from '@shikijs/themes/light-plus'
import darkPlus from '@shikijs/themes/dark-plus'
const hl = createHighlighterCoreSync({
  themes: [lightPlus, darkPlus],
  langs: [latex, bibtex],
  engine: createJavaScriptRegexEngine({ forgiving: true }),
})
// tokens → HTML spans carrying BOTH themes as CSS variables, so a theme switch is pure CSS
function highlight(code, lang){
  return hl.codeToHtml(code, { lang: lang||'latex',
    themes: { light: 'light-plus', dark: 'dark-plus' }, defaultColor: false })
}
function tokens(code, lang){
  return hl.codeToTokensWithThemes(code, { lang: lang||'latex',
    themes: { light: 'light-plus', dark: 'dark-plus' } })
}
window.LXShiki = { highlight, tokens, ready: true }
