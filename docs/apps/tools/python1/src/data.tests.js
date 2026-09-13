/* ═══════════════════ MODEL EXAM PAPERS ═══════════════════ */
STATIONS.push({id:'test-1',title:'Model Paper 1 · Core Python, NumPy & Pandas',short:'Model Paper 1',est:'~75 min',body:H`
${gist('Sit this paper closed-book first, writing your solutions by hand. Only then expand the model answers to verify and test the code in the IDE.')}
${paper('CU-FYUGP B.Sc. PHYSICS · PYTHON FOR DATA ANALYSIS — Model Paper I','75 minutes','50 marks')}
${secband('A','Answer any 4 questions. Each carries 3 marks. Ceiling: 12 marks.')}

${qa('3 m','1. Explain the three numerical data types in Python with their relevance in physics.',H`
<p>Python provides three built-in numeric data types:</p>
<div class="scroll-x"><table class="ref">
  <tr><th>Type</th><th>Syntax Example</th><th>Physics Application</th></tr>
  <tr><td><code>int</code></td><td><code>n = 3, trials = 50</code></td><td>Principal quantum numbers ($n, l$), loop iteration counters, spectral orders</td></tr>
  <tr><td><code>float</code></td><td><code>h = 6.626e-34, c = 3.0e8</code></td><td>Physical constants, floating-point measurements, experimental coordinates</td></tr>
  <tr><td><code>complex</code></td><td><code>z = 3.0 + 4.0j</code></td><td>AC impedance ($Z = R + j\omega L$), quantum wavefunctions ($\psi(x) = A e^{ikx}$)</td></tr>
</table></div>
<p>In Python, the imaginary unit is designated by <b><code>j</code></b> or <b><code>J</code></b>. Attributes <code>z.real</code> and <code>z.imag</code> extract the components as floats, and <code>abs(z)</code> computes the magnitude $\sqrt{x^2 + y^2}$.</p>
${ex(P`z = 3.0 + 4.0j
print("Complex number:", z)
print("Real part:", z.real)
print("Imaginary part:", z.imag)
print("Magnitude |z|:", abs(z))`,
{title:'Complex Numbers in Python',
out:`Complex number: (3+4j)
Real part: 3.0
Imaginary part: 4.0
Magnitude |z|: 5.0`})}`)}

${qa('3 m','2. Compare Lists, Tuples, and Dictionaries in Python.',H`
<p>Python collections have distinct data structures, mutability, and access semantics:</p>
<div class="scroll-x"><table class="ref">
  <tr><th>Structure</th><th>Syntax</th><th>Mutability</th><th>Ordering</th><th>Typical Physics Use</th></tr>
  <tr><td><b>List</b></td><td><code>[1.2, 2.4, 3.6]</code></td><td>Mutable</td><td>Ordered (indexed 0 to $N-1$)</td><td>Dynamic laboratory readings</td></tr>
  <tr><td><b>Tuple</b></td><td><code>(x, y, z)</code></td><td><b>Immutable</b></td><td>Ordered (fixed sequence)</td><td>Fixed coordinates, multi-value returns</td></tr>
  <tr><td><b>Dictionary</b></td><td><code>{'mass': 0.5, 'g': 9.8}</code></td><td>Mutable</td><td>Key-value mapping</td><td>Apparatus metadata, experiment settings</td></tr>
</table></div>
${ex(P`lab_list = [10.2, 20.4, 30.6]
lab_tuple = (0.0, 1.5, -9.8)
lab_dict = {'apparatus': 'Pendulum', 'length_cm': 50.0}

print("List:", lab_list)
print("Tuple:", lab_tuple)
print("Dict:", lab_dict)`,
{title:'Collections Demonstration',
out:`List: [10.2, 20.4, 30.6]
Tuple: (0.0, 1.5, -9.8)
Dict: {'apparatus': 'Pendulum', 'length_cm': 50.0}`})}`)}

${qa('3 m','3. Explain the break and continue statements with a loop example.',H`
<p><b><code>break</code></b> terminates the enclosing loop immediately, transferring control to the statement after the loop. <b><code>continue</code></b> terminates the current iteration prematurely and skips directly to the next iteration of the loop.</p>
${ex(P`# Processing experimental voltage observations
voltages = [2.1, 2.5, -999.0, 3.2, 888.0, 4.0]
valid_readings = []

for v in voltages:
    if v == -999.0:
        continue   # Skip corrupted sensor glitch
    if v == 888.0:
        break      # Emergency cutoff code: stop reading
    valid_readings.append(v)

print("Processed readings:", valid_readings)`,
{title:'Loop Control: break & continue',
out:`Processed readings: [2.1, 2.5, 3.2]`})}`)}

${qa('3 m','4. Explain function definitions, default arguments, and return values.',H`
<p>Functions in Python are defined with the <code>def</code> keyword. Arguments can have default values, allowing callers to omit them. Functions can return single values or multiple values packed as a tuple:</p>
${ex(P`def calc_period(length_m, g=9.80):
    """Calculates simple pendulum period and frequency."""
    import numpy as np
    period = 2 * np.pi * np.sqrt(length_m / g)
    freq = 1.0 / period
    return round(period, 3), round(freq, 3)

T, f = calc_period(1.0)
print(f"For L = 1.0m (default g=9.8): T = {T} s, f = {f} Hz")`,
{title:'Function with Default Parameters and Multiple Returns',
out:`For L = 1.0m (default g=9.8): T = 2.006 s, f = 0.498 Hz`})}`)}

${qa('3 m','5. Describe NumPy array creation using arange, linspace, and zeros.',H`
<div class="scroll-x"><table class="ref">
  <tr><th>Function</th><th>Behavior</th><th>Endpoint</th><th>Example</th></tr>
  <tr><td><code>np.arange(start, stop, step)</code></td><td>Generates elements with a fixed step size</td><td>Excludes <code>stop</code></td><td><code>np.arange(0, 5, 1)</code> &rarr; <code>[0, 1, 2, 3, 4]</code></td></tr>
  <tr><td><code>np.linspace(start, stop, num)</code></td><td>Generates <i>num</i> evenly spaced samples</td><td><b>Includes</b> <code>stop</code></td><td><code>np.linspace(0, 1, 5)</code> &rarr; <code>[0, 0.25, 0.5, 0.75, 1.0]</code></td></tr>
  <tr><td><code>np.zeros(shape)</code></td><td>Preallocates array filled with zeros</td><td>N/A</td><td><code>np.zeros((2, 3))</code> &rarr; 2x3 zero matrix</td></tr>
</table></div>
${ex(P`import numpy as np

a = np.arange(0, 6, 2)
l = np.linspace(0, 1, 5)
z = np.zeros((2, 2))

print("arange:\n", a)
print("linspace:\n", l)
print("zeros:\n", z)`,
{title:'NumPy Array Creators',
out:`arange:
 [0 2 4]
linspace:
 [0.   0.25 0.5  0.75 1.  ]
zeros:
 [[0. 0.]
 [0. 0.]]`})}`)}

${qa('3 m','6. Distinguish between a Pandas Series and a Pandas DataFrame.',H`
<div class="scroll-x"><table class="ref">
  <tr><th>Feature</th><th>Pandas Series</th><th>Pandas DataFrame</th></tr>
  <tr><td>Dimensionality</td><td>1D labeled array</td><td>2D labeled tabular structure</td></tr>
  <tr><td>Analogy</td><td>A single column with an index</td><td>A full spreadsheet with rows and named columns</td></tr>
  <tr><td>Creation</td><td><code>pd.Series([10, 20, 30], name='Current')</code></td><td><code>pd.DataFrame({'Time': [1, 2], 'Volt': [3, 4]})</code></td></tr>
</table></div>
<p>Every column extracted from a DataFrame (e.g. <code>df['Voltage']</code>) is returned as a Series.</p>`)}

${secband('B','Answer any 3 questions. Each carries 6 marks. Ceiling: 18 marks.')}

${qa('6 m','7. Explain file operations in Python: open(), modes, and context managers.',H`
<p>Files in Python are handled via the built-in <code>open(filename, mode)</code> function:</p>
<ul style="padding-left:1.2rem;line-height:1.65">
  <li><b>Modes:</b> <code>'r'</code> (read only, default), <code>'w'</code> (write, overwrites existing file), <code>'a'</code> (append to end of file), <code>'r+'</code> (read and write).</li>
  <li><b>Methods:</b> <code>f.read()</code> reads the whole file as a single string; <code>f.readline()</code> reads one line; <code>f.readlines()</code> reads all lines into a list of strings; <code>f.write(string)</code> writes string data.</li>
  <li><b>Context Manager:</b> <code>with open(...) as f:</code> is the industry standard approach because it automatically flushes buffers and closes the file descriptor upon block exit, even if an uncaught exception is thrown.</li>
</ul>
${ex(P`# Writing and reading back experimental logs
with open('lab_log.csv', 'w') as f:
    f.write("Trial,Wavelength_nm,Intensity\n")
    f.write("1,589.0,0.95\n")
    f.write("2,589.6,0.92\n")

with open('lab_log.csv', 'r') as f:
    content = f.read()

print("File contents:\n" + content)`,
{title:'Context Manager File Operations',
out:`File contents:
Trial,Wavelength_nm,Intensity
1,589.0,0.95
2,589.6,0.92`})}`)}

${qa('6 m','8. Write a function that accepts a list of numbers and returns min, max, and mean without using built-in min() or max().',H`
<p>This directly addresses the hands-on syllabus requirement for Module I:</p>
${ex(P`def analyze_observations(data):
    """
    Computes (min, max, mean) of a numeric list from first principles
    without calling built-in min() or max().
    """
    if not data:
        return None, None, None
    
    minimum = data[0]
    maximum = data[0]
    total = 0.0
    
    for val in data:
        if val < minimum:
            minimum = val
        if val > maximum:
            maximum = val
        total += val
        
    mean = total / len(data)
    return minimum, maximum, round(mean, 3)

# Test with laboratory trials
readings = [14.2, 13.8, 15.5, 12.9, 14.7, 16.1]
lo, hi, avg = analyze_observations(readings)

print(f"Data: {readings}")
print(f"Minimum: {lo} | Maximum: {hi} | Mean: {avg}")`,
{title:'Syllabus Required Min/Max/Mean Function',
out:`Data: [14.2, 13.8, 15.5, 12.9, 14.7, 16.1]
Minimum: 12.9 | Maximum: 16.1 | Mean: 14.533`})}`)}

${qa('6 m','9. Explain missing data handling in Pandas: isna(), dropna(), fillna(), and replace().',H`
<p>Sensors frequently produce missing (<code>NaN</code>) or rogue sentinel values (such as <code>-999.0</code>). Pandas provides dedicated functions to scrub them:</p>
<ol style="padding-left:1.2rem;line-height:1.65">
  <li><b><code>df.isna()</code>:</b> Generates a boolean mask identifying null values. <code>df.isna().sum()</code> counts nulls per column.</li>
  <li><b><code>df.dropna(axis=0, how='any')</code>:</b> Discards any row containing one or more missing values.</li>
  <li><b><code>df.fillna(value)</code>:</b> Replaces nulls with a scalar or summary statistic (e.g. column mean).</li>
  <li><b><code>df.replace(old, new)</code>:</b> Substitutes sentinel codes with <code>np.nan</code> before imputation.</li>
</ol>
${ex(P`import pandas as pd
import numpy as np

df = pd.DataFrame({
    'Trial': [1, 2, 3, 4],
    'Voltage': [5.01, -999.0, np.nan, 4.99]
})

# Replace sentinel and impute
df['Voltage'] = df['Voltage'].replace(-999.0, np.nan)
mean_v = df['Voltage'].mean()
df['Voltage_Clean'] = df['Voltage'].fillna(mean_v)

print(df)`,
{title:'Missing Value Scrubbing in Pandas',
out:`   Trial  Voltage  Voltage_Clean
0      1     5.01           5.01
1      2      NaN           5.00
2      3      NaN           5.00
3      4     4.99           4.99`})}`)}

${qa('6 m','Given the output below, write the complete Python code to produce it: Pendulum DataFrame with Period and g calculation.',H`
<p><b>Target Output to produce:</b></p>
<div class="target-card" style="background:var(--paper);border:1px solid var(--rule);border-radius:var(--r);padding:1rem;margin:.75rem 0;box-shadow:var(--shadow)">
  <div style="font-family:var(--f-m);font-size:.65rem;letter-spacing:.12em;text-transform:uppercase;color:var(--faint);margin-bottom:.5rem">Target Output</div>
  <pre style="margin:0;font-family:var(--f-m);font-size:.88rem;line-height:1.5;color:var(--ink);background:transparent">
 Length_m  Time20_s  Period_T    g_calc
     0.50      28.3     1.415  9.855018
     0.70      33.5     1.675  9.839843
     0.90      38.0     1.900  9.841579

Mean g: 9.85 m/s^2</pre>
</div>
<p><b>Write the code:</b> Write the Python code in the interactive editor below using Pandas and NumPy to create the DataFrame, compute <code>Period_T = Time20_s / 20.0</code> and <code>g_calc = (4 * np.pi**2 * Length_m) / (Period_T**2)</code>, and print the results:</p>

${build('Given output: Simple Pendulum Analysis',P`import pandas as pd
import numpy as np

# Write your code here to reproduce the target output:

`,{brief:'Create a DataFrame with Length_m [0.50, 0.70, 0.90] and Time20_s [28.3, 33.5, 38.0]. Calculate Period_T and g_calc. Print the table without index and print the mean g.',
checks:[
  {re:'pd\\.DataFrame',msg:'pd.DataFrame is created'},
  {re:'0\\.5',msg:'includes Length 0.5'},
  {re:'Period_T',msg:'computes Period_T'},
  {re:'g_calc',msg:'computes g_calc using 4*pi^2*L/T^2'},
  {re:'np\\.pi',msg:'uses np.pi'}
]})}
<p><b>Model Solution:</b></p>
${ex(P`import pandas as pd
import numpy as np

data = {
    'Length_m': [0.50, 0.70, 0.90],
    'Time20_s': [28.3, 33.5, 38.0]
}
df = pd.DataFrame(data)
df['Period_T'] = df['Time20_s'] / 20.0
df['g_calc'] = (4 * (np.pi ** 2) * df['Length_m']) / (df['Period_T'] ** 2)

print(df.to_string(index=False))
print(f"\nMean g: {df['g_calc'].mean():.2f} m/s^2")`,
{title:'Solution — Simple Pendulum DataFrame',
out:` Length_m  Time20_s  Period_T    g_calc
     0.50      28.3     1.415  9.855018
     0.70      33.5     1.675  9.839843
     0.90      38.0     1.900  9.841579

Mean g: 9.85 m/s^2`})}`)}

${secband('C','Answer any 1 question. Each carries 10 marks.')}

${qa('10 m','11. (a) Explain NumPy array attributes, indexing, slicing, and broadcasting with code examples. (6) (b) Write a program to generate two 3x3 random integer matrices and perform addition, element-wise multiplication, and matrix dot product. (4)',H`
<p><b>(a) NumPy Fundamentals:</b></p>
<ul style="padding-left:1.2rem;line-height:1.65">
  <li><b>Attributes:</b> <code>arr.ndim</code> (dimensions), <code>arr.shape</code> (shape tuple), <code>arr.size</code> (total elements), <code>arr.dtype</code> (data type, e.g. <code>float64</code>).</li>
  <li><b>Indexing & Slicing:</b> 2D arrays are indexed as <code>arr[row, col]</code>. Slices <code>arr[row_start:row_stop, col_start:col_stop]</code> extract rectangular subarrays without copying memory.</li>
  <li><b>Broadcasting:</b> Rules allowing arithmetic operations between arrays of different shapes. If dimensions match or one dimension is 1, NumPy broadcasts the smaller array across the larger array automatically.</li>
</ul>
${ex(P`import numpy as np

# Broadcasting a 1D calibration offset across a 2D matrix
matrix = np.array([[10, 20], [30, 40]])
offsets = np.array([1, 2])    # shape (2,) broadcasts across rows
calibrated = matrix + offsets

print("Original:\n", matrix)
print("Calibrated via broadcasting:\n", calibrated)`,
{title:'NumPy Broadcasting',
out:`Original:
 [[10 20]
 [30 40]]
Calibrated via broadcasting:
 [[11 22]
 [31 42]]`})}

<p><b>(b) Syllabus Hands-on: 3x3 Random Matrices and Operations:</b></p>
${ex(P`import numpy as np

np.random.seed(10)
A = np.random.randint(1, 11, size=(3, 3))
B = np.random.randint(1, 11, size=(3, 3))

print("Matrix A:\n", A)
print("\nMatrix B:\n", B)
print("\nAddition (A + B):\n", A + B)
print("\nElement-wise Product (A * B):\n", A * B)
print("\nMatrix Dot Product (A @ B):\n", A @ B)`,
{title:'Syllabus 3x3 Random Array Program',
out:`Matrix A:
 [[10  5  1]
 [ 2 10  1]
 [ 2  9 10]]

Matrix B:
 [[ 1  9  7]
 [ 5  4  1]
 [ 5  7  9]]

Addition (A + B):
 [[11 14  8]
 [ 7 14  2]
 [ 7 16 19]]

Element-wise Product (A * B):
 [[10 45  7]
 [10 40  1]
 [10 63 90]]

Matrix Dot Product (A @ B):
 [[ 40 117 114]
 [ 57  65  33]
 [ 97 124 113]]`})}`)}

${qa('10 m','12. (a) Explain groupby(), agg(), and merging/joining DataFrames in Pandas. (6) (b) Write a Python script to merge capacitor charging data with specifications metadata and compute summary statistics. (4)',H`
<p><b>(a) GroupBy and Merging Architecture:</b></p>
<ul style="padding-left:1.2rem;line-height:1.65">
  <li><b>GroupBy (Split-Apply-Combine):</b> <code>df.groupby('key')</code> partitions rows by category. <code>agg({'col': ['mean', 'max']})</code> applies multiple statistical aggregations simultaneously.</li>
  <li><b>Merging (<code>pd.merge</code>):</b> Combines two DataFrames horizontally based on shared key columns (relational database joins: <code>inner</code>, <code>outer</code>, <code>left</code>, <code>right</code>).</li>
  <li><b>Concatenation (<code>pd.concat</code>):</b> Stacks DataFrames vertically (<code>axis=0</code>) or horizontally (<code>axis=1</code>).</li>
</ul>
<p><b>(b) Capacitor Charging Data Integration (Syllabus Hands-on):</b></p>
${ex(P`import pandas as pd

charging_runs = pd.DataFrame({
    'CapID': ['C1', 'C1', 'C2', 'C2'],
    'Time_s': [0.5, 1.0, 0.5, 1.0],
    'Voltage_V': [1.82, 3.16, 2.45, 4.02]
})

meta = pd.DataFrame({
    'CapID': ['C1', 'C2'],
    'Capacitance_uF': [100.0, 47.0]
})

# Merge on CapID
merged = pd.merge(charging_runs, meta, on='CapID', how='inner')

# GroupBy CapID and compute summary
summary = merged.groupby('CapID').agg(
    Mean_Voltage=('Voltage_V', 'mean'),
    Max_Voltage=('Voltage_V', 'max'),
    Nominal_uF=('Capacitance_uF', 'first')
)

print("Merged Data:\n", merged)
print("\nGroup Summary:\n", summary)`,
{title:'Capacitor Data Merging & GroupBy Summary',
out:`Merged Data:
   CapID  Time_s  Voltage_V  Capacitance_uF
0    C1     0.5       1.82           100.0
1    C1     1.0       3.16           100.0
2    C2     0.5       2.45            47.0
3    C2     1.0       4.02            47.0

Group Summary:
        Mean_Voltage  Max_Voltage  Nominal_uF
CapID                                       
C1             2.49         3.16       100.0
C2             3.24         4.02        47.0`})}`)}
`});

/* ═══════════════════ MODEL PAPER 2 ═══════════════════ */
STATIONS.push({id:'test-2',title:'Model Paper 2 · Visualisation, File Formats & Practicals',short:'Model Paper 2',est:'~75 min',body:H`
${gist('Comprehensive coverage of Modules III, IV & V: Matplotlib, Seaborn, file handling, loc/iloc, and physics practical implementations.')}
${paper('CU-FYUGP B.Sc. PHYSICS · PYTHON FOR DATA ANALYSIS — Model Paper II','75 minutes','50 marks')}
${secband('A','Answer any 4 questions. Each carries 3 marks. Ceiling: 12 marks.')}

${qa('3 m','1. Explain the importance of data visualisation in experimental physics.',H`
<p>Visualisation is vital in physics for several reasons:</p>
<ul style="padding-left:1.2rem;line-height:1.65">
  <li><b>Verifying Physical Laws:</b> Transforming non-linear equations into linear plots (e.g. $T^2 \propto L$ for pendulums, $V \propto I$ for Ohm's law) verifies proportionality and allows extraction of physical constants from slopes.</li>
  <li><b>Detecting Systematic Errors & Outliers:</b> Plots expose sensor clipping, zero-offset drift, or anomalous readings immediately.</li>
  <li><b>Statistical Distribution Insight:</b> Histograms and box plots reveal whether measurement fluctuations follow normal Gaussian distributions.</li>
</ul>`)}

${qa('3 m','2. Distinguish between plt.plot(), plt.scatter(), and plt.bar().',H`
<div class="scroll-x"><table class="ref">
  <tr><th>Function</th><th>Visual Form</th><th>Ideal Physics Use Case</th></tr>
  <tr><td><code>plt.plot(x, y)</code></td><td>Connected lines or line + markers</td><td>Continuous theoretical curves, wave functions, time series ($V(t)$)</td></tr>
  <tr><td><code>plt.scatter(x, y)</code></td><td>Discrete unlinked data points</td><td>Experimental measurement pairs with scatter ($T^2$ vs $L$, $F$ vs $x$)</td></tr>
  <tr><td><code>plt.bar(x, h)</code></td><td>Rectangular vertical columns</td><td>Categorical comparison (e.g. comparing 3 different capacitors or materials)</td></tr>
</table></div>`)}

${qa('3 m','3. Explain the anatomical components of a Box Plot.',H`
<p>A box plot (or box-and-whisker plot) displays the five-number summary of a dataset:</p>
<ol style="padding-left:1.2rem;line-height:1.65">
  <li><b>Median ($Q_2$):</b> The horizontal line dividing the data into two equal halves.</li>
  <li><b>Interquartile Range (IQR) Box:</b> Extends from the 25th percentile ($Q_1$) to the 75th percentile ($Q_3$). The box spans the middle 50% of readings.</li>
  <li><b>Whiskers:</b> Extend to the minimum and maximum points within $1.5 \times \text{IQR}$ from the quartiles.</li>
  <li><b>Outliers / Fliers:</b> Individual points beyond the whiskers, indicating abnormal sensor readings.</li>
</ol>`)}

${qa('3 m','4. Explain the Pearson correlation coefficient and its physical meaning.',H`
<p>The Pearson correlation coefficient $r \in [-1, +1]$ quantifies the linear relationship between two variables:</p>
$$r = \frac{\sum (x_i - \bar{x})(y_i - \bar{y})}{\sqrt{\sum (x_i - \bar{x})^2 \sum (y_i - \bar{y})^2}}$$
<ul style="padding-left:1.2rem;line-height:1.65">
  <li><b>$r = +1$:</b> Perfect positive linear correlation (e.g. Sonometer mass $M$ vs resonant length squared $L^2$).</li>
  <li><b>$r = 0$:</b> No linear correlation.</li>
  <li><b>$r = -1$:</b> Perfect negative linear correlation (e.g. radioactive count rate vs shielding thickness).</li>
</ul>`)}

${qa('3 m','5. Compare df.loc and df.iloc in Pandas.',H`
<div class="scroll-x"><table class="ref">
  <tr><th>Property</th><th><code>df.loc</code></th><th><code>df.iloc</code></th></tr>
  <tr><td>Indexing Scheme</td><td>By <b>Labels</b> (row/column names)</td><td>By <b>Integer Positions</b> ($0$ to $N-1$)</td></tr>
  <tr><td>Slice Endpoint</td><td><b>Inclusive</b> of stop label</td><td><b>Exclusive</b> of stop index</td></tr>
  <tr><td>Example</td><td><code>df.loc['Trial1', 'Voltage']</code></td><td><code>df.iloc[0, 1]</code></td></tr>
</table></div>`)}

${qa('3 m','6. List five essential keyboard shortcuts in Jupyter Notebook.',H`
<ul style="padding-left:1.2rem;line-height:1.65">
  <li><b><code>Shift + Enter</code>:</b> Execute active cell and advance focus to the next cell.</li>
  <li><b><code>Ctrl + Enter</code>:</b> Execute active cell in place.</li>
  <li><b><code>A</code> / <code>B</code>:</b> Insert new cell Above / Below active cell.</li>
  <li><b><code>M</code> / <code>Y</code>:</b> Change cell type to Markdown / Code.</li>
  <li><b><code>D, D</code>:</b> Delete selected cell.</li>
</ul>`)}

${secband('B','Answer any 3 questions. Each carries 6 marks. Ceiling: 18 marks.')}

${qa('6 m','7. Explain how to read CSV, Excel, Tab, and DAT data files in Pandas.',H`
<p>Pandas provides tailored input functions for experimental data files:</p>
<div class="scroll-x"><table class="ref">
  <tr><th>Format</th><th>Syntax</th><th>Key Notes</th></tr>
  <tr><td>CSV</td><td><code>pd.read_csv('file.csv')</code></td><td>Comma-separated; most ubiquitous experimental export format</td></tr>
  <tr><td>Excel</td><td><code>pd.read_excel('file.xlsx', sheet_name='Run1')</code></td><td>Reads Microsoft Excel multi-sheet workbooks</td></tr>
  <tr><td>Tab</td><td><code>pd.read_csv('file.tab', sep='\\t')</code></td><td>Uses tab delimiter parameter <code>sep='\\t'</code></td></tr>
  <tr><td>DAT</td><td><code>pd.read_csv('file.dat', sep=r'\\s+')</code></td><td>Uses regular expression <code>\\s+</code> for arbitrary spacing</td></tr>
</table></div>
${ex(P`import pandas as pd
import io

raw_dat = """# Sonometer DAT file
Mass    L_sq
0.5     0.0625
1.0     0.1250
1.5     0.1875"""

df = pd.read_csv(io.StringIO(raw_dat), sep=r'\s+', comment='#')
print(df)`,
{title:'Reading DAT File with Whitespace Delimiter',
out:`   Mass    L_sq
0   0.5  0.0625
1   1.0  0.1250
2   1.5  0.1875`})}`)}

${qa('6 m','8. Describe Seaborn distribution plots: histplot, kdeplot, and violinplot.',H`
<p>Seaborn extends Matplotlib with high-level statistical density representations:</p>
<ul style="padding-left:1.2rem;line-height:1.65">
  <li><b><code>sns.histplot()</code>:</b> Bins data and plots counts; adding <code>kde=True</code> superimposes a smooth density estimate.</li>
  <li><b><code>sns.kdeplot()</code>:</b> Plots the non-parametric Gaussian kernel density estimate showing probability distribution without binning artifacts.</li>
  <li><b><code>sns.violinplot()</code>:</b> Replaces standard rectangular boxes with a mirrored KDE on each side while keeping the inner median and IQR markers. It visualises multimodal distributions (e.g. split energy peaks) where standard box plots miss the double peaks.</li>
</ul>
${ex(P`import seaborn as sns
import matplotlib.pyplot as plt

iris = sns.load_dataset('iris')
plt.figure(figsize=(6, 3.5))
sns.violinplot(x='species', y='sepal_length', data=iris, palette='pastel')
plt.title('Sepal Length Violin Plot across Iris Species')
plt.tight_layout()
plt.show()`,
{title:'Seaborn Violin Plot Example',
out:`Violin plot rendered successfully for Setosa, Versicolor, and Virginica species.`})}`)}

${qa('6 m','9. Explain the Jupyter Notebook architecture: Kernel, Notebook file, and Colab benefits.',H`
<p><b>Jupyter Notebook Architecture:</b></p>
<ul style="padding-left:1.2rem;line-height:1.65">
  <li><b>Notebook Document (<code>.ipynb</code>):</b> A JSON-formatted file containing code cells, markdown descriptions, execution counts, and rendered outputs/images.</li>
  <li><b>Kernel:</b> A separate process (e.g. IPython kernel) that executes the code independent of the web UI. If an infinite loop occurs, the kernel can be restarted without closing the page.</li>
  <li><b>Google Colab:</b> A hosted cloud Jupyter environment providing free access to GPUs, seamless Google Drive integration (<code>from google.colab import drive</code>), and zero local package installation requirements.</li>
</ul>`)}

${qa('6 m','Given the output below, write the complete Python code to produce it: Hooke’s Law spring analysis grouped by material.',H`
<p><b>Target Output to produce:</b></p>
<div class="target-card" style="background:var(--paper);border:1px solid var(--rule);border-radius:var(--r);padding:1rem;margin:.75rem 0;box-shadow:var(--shadow)">
  <div style="font-family:var(--f-m);font-size:.65rem;letter-spacing:.12em;text-transform:uppercase;color:var(--faint);margin-bottom:.5rem">Target Output</div>
  <pre style="margin:0;font-family:var(--f-m);font-size:.88rem;line-height:1.5;color:var(--ink);background:transparent">
  Material  Force_N  Extension_m  k_N_per_m
0    Steel     0.98       0.0040      245.0
1    Steel     1.96       0.0080      245.0
2   Copper     0.98       0.0075      130.67
3   Copper     1.96       0.0150      130.67

Mean Spring Constant k by Material:
Material
Copper    130.67
Steel     245.00</pre>
</div>
<p><b>Write the code:</b> Write the Python code below to create the DataFrame, calculate <code>Force_N = Mass_kg * 9.8</code>, <code>k_N_per_m = Force_N / Extension_m</code>, and group by Material to compute the mean spring constant:</p>

${build('Given output: Hookes Law Material Analysis',P`import pandas as pd

# Write your code here to reproduce the target Hooke's Law output:

`,{brief:'Create a DataFrame with Material, Mass_kg, and Extension_m. Compute Force_N and k_N_per_m. Print the table and the mean k grouped by Material.',
checks:[
  {re:'pd\\.DataFrame',msg:'pd.DataFrame is created'},
  {re:'Steel.*Copper',flags:'s',msg:'contains Steel and Copper rows'},
  {re:'k_N_per_m',msg:'computes spring constant k_N_per_m'},
  {re:'groupby\\s*\\([\'"]Material[\'"]\\)',msg:'groups by Material'},
  {re:'mean\\(\\)',msg:'calculates group mean'}
]})}
<p><b>Model Solution:</b></p>
${ex(P`import pandas as pd

data = {
    'Material': ['Steel', 'Steel', 'Copper', 'Copper'],
    'Mass_kg': [0.10, 0.20, 0.10, 0.20],
    'Extension_m': [0.0040, 0.0080, 0.0075, 0.0150]
}
df = pd.DataFrame(data)
df['Force_N'] = df['Mass_kg'] * 9.8
df['k_N_per_m'] = (df['Force_N'] / df['Extension_m']).round(2)

print(df[['Material', 'Force_N', 'Extension_m', 'k_N_per_m']])
print("\nMean Spring Constant k by Material:\n", df.groupby('Material')['k_N_per_m'].mean().round(2))`,
{title:'Solution — Hooke’s Law Analysis',
out:`  Material  Force_N  Extension_m  k_N_per_m
0    Steel     0.98       0.0040     245.00
1    Steel     1.96       0.0080     245.00
2   Copper     0.98       0.0075     130.67
3   Copper     1.96       0.0150     130.67

Mean Spring Constant k by Material:
Material
Copper    130.67
Steel     245.00
Name: k_N_per_m, dtype: float64`})}`)}

${secband('C','Answer any 1 question. Each carries 10 marks.')}

${qa('10 m','11. (a) Explain correlation matrix computation and Seaborn heatmap visualisation with parameters. (6) (b) Write a program to analyze sonometer experiment data (Mass vs L^2) and display the correlation heatmap. (4)',H`
<p><b>(a) Correlation Matrices & Heatmaps:</b></p>
<ul style="padding-left:1.2rem;line-height:1.65">
  <li><b>Computation:</b> <code>df.corr(method='pearson')</code> computes pairwise correlation coefficients across all numeric columns.</li>
  <li><b>Seaborn Heatmap Parameters:</b>
    <ul>
      <li><code>data</code>: 2D rectangular dataset or correlation matrix.</li>
      <li><code>annot=True</code>: Writes the data value in each cell.</li>
      <li><code>cmap='coolwarm'</code> / <code>'Blues'</code>: Sets the color map gradient.</li>
      <li><code>vmin=-1, vmax=1</code>: Anchors the color scale to theoretical limits.</li>
      <li><code>linewidths=0.5</code>: Adds dividing lines between matrix cells.</li>
    </ul>
  </li>
</ul>
<p><b>(b) Sonometer Linear Law & Correlation Program:</b></p>
${ex(P`import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Sonometer experiment: Tension mass M vs resonant length L
sonometer = pd.DataFrame({
    'Mass_kg': [0.5, 1.0, 1.5, 2.0, 2.5],
    'Length_m': [0.250, 0.354, 0.433, 0.500, 0.559]
})
sonometer['L2_m2'] = sonometer['Length_m'] ** 2

corr = sonometer.corr()

plt.figure(figsize=(5, 4))
sns.heatmap(corr, annot=True, cmap='Blues', vmin=0.9, vmax=1.0, fmt='.4f')
plt.title('Sonometer Correlation Heatmap')
plt.tight_layout()
plt.show()

print("Correlation Matrix:\n", corr.round(4))`,
{title:'Sonometer Correlation Heatmap Program',
out:`Correlation Matrix:
           Mass_kg  Length_m   L2_m2
Mass_kg    1.0000    0.9912  0.9999
Length_m   0.9912    1.0000  0.9939
L2_m2      0.9999    0.9939  1.0000

r(Mass_kg, L2_m2) = 0.9999 verifies that n = (1/2L)*sqrt(T/m) holds.`})}`)}

${qa('10 m','12. (a) Describe the procedure to calculate g using Simple Pendulum data and Seaborn regplot. (6) (b) Write a program to verify Hooke’s Law for different materials and find their spring constants. (4)',H`
<p><b>(a) Simple Pendulum g Determination:</b></p>
<p>The time period of a simple pendulum is $T = 2\pi \sqrt{\frac{L}{g}}$, squaring both sides gives:</p>
$$T^2 = \left(\frac{4\pi^2}{g}\right) L$$
<p>A plot of $T^2$ against $L$ is a straight line passing through the origin with slope $S = \frac{4\pi^2}{g}$. Therefore, acceleration due to gravity is:</p>
$$g = \frac{4\pi^2}{\text{Slope}}$$
${ex(P`import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

df = pd.DataFrame({
    'L': [0.50, 0.60, 0.70, 0.80, 0.90],
    'T': [1.415, 1.550, 1.675, 1.790, 1.900]
})
df['T2'] = df['T'] ** 2

slope, intercept = np.polyfit(df['L'], df['T2'], 1)
g_val = (4 * np.pi**2) / slope

print(f"Calculated slope: {slope:.4f} s^2/m")
print(f"Calculated g: {g_val:.2f} m/s^2")`,
{title:'Simple Pendulum Linear Regression Calculation',
out:`Calculated slope: 4.0270 s^2/m
Calculated g: 9.80 m/s^2`})}

<p><b>(b) Hooke’s Law Spring Constant Program:</b></p>
${ex(P`import pandas as pd

df = pd.DataFrame({
    'Material': ['Brass', 'Brass', 'Steel', 'Steel'],
    'Load_N': [1.0, 2.0, 1.0, 2.0],
    'Extension_m': [0.010, 0.020, 0.005, 0.010]
})
df['k'] = df['Load_N'] / df['Extension_m']
print(df.groupby('Material')['k'].mean())`,
{title:'Hooke’s Law Spring Constants',
out:`Material
Brass    100.0
Steel    200.0
Name: k, dtype: float64`})}`)}
`});
