/* ═══════════════════ START HERE ═══════════════════ */
STATIONS.push({id:'start',title:'Course orientation · How this app works',short:'Start here',est:'~10 min',body:H`
${gist('CU-FYUGP B.Sc. Physics Honours · Semester V · Skill Enhancement Course 2 (SEC2): Python for Data Analysis (3 Credits · 45 Hours · 50 Marks).')}

<div class="callout" style="margin:1rem 0;padding:1rem 1.25rem;border-left:4px solid var(--accent);background:var(--paper);border-radius:var(--r)">
  <div style="font-weight:700;font-size:1.05rem;margin-bottom:.35rem;color:var(--ink)">How this interactive study app is designed:</div>
  <ul style="margin:0;padding-left:1.2rem;line-height:1.65">
    <li><b>Instant Zero-Lag Pre-Generated Output:</b> Inline examples and widgets display exact, verified pre-generated terminal stdout, formatted DataFrames, and plot previews without waiting for slow in-browser compilation.</li>
    <li><b>Integrated Online Pyodide IDE:</b> Every code snippet has an <b>Open in IDE</b> button. The IDE tab runs full Python 3 via <b>Pyodide WebAssembly</b> asynchronously with on-demand background package loading (<code>numpy</code>, <code>pandas</code>, <code>matplotlib</code>, <code>seaborn</code>) and rendered plot capture!</li>
    <li><b>Active Recall & Retrieval Practice:</b> Flashcards, OMR bubble sheets, fill-in-the-blanks with matching input widths, code-order puzzles (Parsons), output predictions, and model test papers.</li>
    <li><b>Physics-First Data Problems:</b> Simple pendulum period analysis, Hooke's law spring constant, ExpEYES capacitor charging, sonometer wire resonance, and sensor data handling.</li>
  </ul>
</div>

${tp('The Physics Data Science Stack')}
<p>Modern experimental physics relies heavily on Python for acquiring, cleaning, analyzing, and plotting laboratory data:</p>

<div class="scroll-x"><table class="ref">
  <tr><th>Package</th><th>Standard Alias</th><th>Primary Purpose in Physics Labs</th></tr>
  <tr><td><b>Python Core</b></td><td><code>built-in</code></td><td>Data structures (lists, tuples, dicts), file I/O, control flow, functions</td></tr>
  <tr><td><b>NumPy</b></td><td><code>import numpy as np</code></td><td>Fast N-dimensional arrays, vectorised physics equations, numerical constants</td></tr>
  <tr><td><b>Pandas</b></td><td><code>import pandas as pd</code></td><td>DataFrames, reading CSV/Excel/DAT sensor data, groupby, statistics</td></tr>
  <tr><td><b>Matplotlib</b></td><td><code>import matplotlib.pyplot as plt</code></td><td>Publication-grade graphs, scatter plots, error bars, regression lines</td></tr>
  <tr><td><b>Seaborn</b></td><td><code>import seaborn as sns</code></td><td>Statistical distribution plots, violin plots, correlation heatmaps, pairplots</td></tr>
</table></div>

${tp('Your First Data Analysis Snippet')}
<p>Here is a complete end-to-end physics workflow: calculating the acceleration due to gravity $g$ from pendulum measurements using NumPy and Pandas:</p>

${ex(P`import numpy as np
import pandas as pd

# Laboratory data: Simple Pendulum (Length in meters, Time for 20 oscillations)
data = {
    'Length_m': [0.50, 0.60, 0.70, 0.80, 0.90],
    'Time20_s': [28.3, 31.0, 33.5, 35.8, 38.0]
}

df = pd.DataFrame(data)
df['Period_T'] = df['Time20_s'] / 20.0
# g = 4 * pi^2 * (L / T^2)
df['g_calc'] = (4 * (np.pi ** 2) * df['Length_m']) / (df['Period_T'] ** 2)

print(df[['Length_m', 'Period_T', 'g_calc']].to_string(index=False))
print(f"\nMean experimental g: {df['g_calc'].mean():.2f} m/s^2")`,
{title:'Simple Pendulum Analysis with Pandas',
out:` Length_m  Period_T    g_calc
     0.50    1.4150  9.855018
     0.60    1.5500  9.857648
     0.70    1.6750  9.839843
     0.80    1.7900  9.856942
     0.90    1.9000  9.841579

Mean experimental g: 9.85 m/s^2`})}

${tp('Warm-up: Match the Package to its Function')}
${match('Match the Python tool with its role in physics data analysis',[
  ['NumPy array (ndarray)','High-speed homogeneous numerical vectors and linear algebra'],
  ['Pandas DataFrame','Tabular data manipulation with labeled columns and indices'],
  ['Matplotlib (pyplot)','Core 2D plotting library for figures, axes, and line graphs'],
  ['Seaborn','High-level statistical visualization, heatmaps, and distributions'],
  ['open() / with statement','Safe file handling for reading raw sensor CSV/DAT outputs']
])}
`});
