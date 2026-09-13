/* ═══════════════════ MODULE II: PANDAS DATAFRAMES & WRANGLING ═══════════════════ */

/* ───────────── DataFrame Creation & Inspection ───────────── */
STATIONS.push({id:'m2-dataframe',title:'DataFrame Creation & Inspection',short:'DataFrame Creation & Inspection',est:'~40 min',body:H`
${gist('Pandas structures experimental data into labeled 1D Series and 2D DataFrames with automated index alignment.')}

${tp('Series vs DataFrame in Experimental Physics')}
<p><b>Pandas</b> is Python’s primary library for tabular and structured experimental data. The two core data structures are:</p>

<div class="scroll-x"><table class="ref">
  <tr><th>Structure</th><th>Dimensions</th><th>Indexing</th><th>Physics Analogy</th></tr>
  <tr><td><b><code>Series</code></b></td><td>1D (single column)</td><td>Labeled index + values</td><td>Single sensor channel over time (e.g. Temperature readings)</td></tr>
  <tr><td><b><code>DataFrame</code></b></td><td>2D (tabular spreadsheet)</td><td>Row labels (index) + Column headers</td><td>Complete lab data table with Time, Voltage, Current, and Notes</td></tr>
</table></div>

${tp('Creating DataFrames from Dictionaries, Arrays, and Files')}
<p>DataFrames can be constructed from Python dictionaries, 2D NumPy arrays, or external files (CSV, Excel, DAT):</p>

${ex(P`import pandas as pd
import numpy as np

# Method 1: Dictionary of lists (keys become column headers)
lab_dict = {
    'Trial': [1, 2, 3, 4],
    'Mass_g': [100.0, 200.0, 300.0, 400.0],
    'Extension_mm': [4.8, 9.7, 14.5, 19.3]
}
df_dict = pd.DataFrame(lab_dict)

# Method 2: 2D NumPy array with custom column labels
raw_matrix = np.array([
    [0.0, 0.00],
    [0.5, 1.82],
    [1.0, 3.16],
    [1.5, 4.02]
])
df_arr = pd.DataFrame(raw_matrix, columns=['Time_s', 'Voltage_V'])

print("DataFrame from Dictionary:\n", df_dict)
print("\nDataFrame from NumPy Array:\n", df_arr)`,
{title:'Constructing DataFrames',
out:`DataFrame from Dictionary:
    Trial  Mass_g  Extension_mm
0      1   100.0           4.8
1      2   200.0           9.7
2      3   300.0          14.5
3      4   400.0          19.3

DataFrame from NumPy Array:
    Time_s  Voltage_V
0     0.0       0.00
1     0.5       1.82
2     1.0       3.16
3     1.5       4.02`})}

${tp('DataFrame Inspection Attributes and Methods')}
<p>Before running numerical analysis, verify the shape and data types of imported data:</p>

<div class="scroll-x"><table class="ref">
  <tr><th>Attribute / Method</th><th>Syntax</th><th>Output / Description</th></tr>
  <tr><td><b><code>shape</code></b></td><td><code>df.shape</code></td><td>Tuple of <code>(rows, columns)</code> (attribute, no parentheses)</td></tr>
  <tr><td><b><code>columns</code></b></td><td><code>df.columns</code></td><td>Index list of column names</td></tr>
  <tr><td><b><code>dtypes</code></b></td><td><code>df.dtypes</code></td><td>Data types of all columns (e.g. <code>float64</code>, <code>int64</code>)</td></tr>
  <tr><td><b><code>head(n)</code></b></td><td><code>df.head(5)</code></td><td>Returns the first $n$ rows (default is 5)</td></tr>
  <tr><td><b><code>tail(n)</code></b></td><td><code>df.tail(3)</code></td><td>Returns the last $n$ rows</td></tr>
  <tr><td><b><code>info()</code></b></td><td><code>df.info()</code></td><td>Summary of column names, non-null counts, and memory usage</td></tr>
</table></div>

${trap(H`<b><code>df.shape</code> is an attribute, not a function!</b> Writing <code>df.shape()</code> will raise a <code>TypeError: 'tuple' object is not callable</code>.`)}

${fill('DataFrame Fundamentals',
P`The 1D labeled array in Pandas is called a [[Series]].
The 2D tabular structure in Pandas is called a [[DataFrame]].
To view the first 5 rows of a DataFrame, call df.[[head() |head()|head]].
The attribute that returns the tuple (rows, columns) is [[shape]].`,{code:true})}

${match('DataFrame Attributes and Creators',[
  ['df.shape','Tuple containing number of rows and columns'],
  ['df.dtypes','Displays data type of every column'],
  ['df.head(5)','Returns top 5 rows of the DataFrame'],
  ['df.columns','Index of column names'],
  ['pd.Series','1D labeled array data structure']
])}

${parsons('Create DataFrame from physics observations',[
  'import pandas as pd',
  'data = {',
  '    "Current_A": [0.1, 0.2, 0.3],',
  '    "Voltage_V": [1.5, 3.0, 4.5]',
  '}',
  'df = pd.DataFrame(data)',
  'print(df.shape)'
])}

${predict('Predict Output: DataFrame Shape and Columns',
P`import pandas as pd
df = pd.DataFrame({
    'Temp_K': [300, 350, 400],
    'Pressure_kPa': [101.3, 118.2, 135.1]
})
print(df.shape[0], df.shape[1])`,
['3 2', '2 3', '6 1', '3 3'],
'3 2',
'The DataFrame has 3 rows and 2 columns, so df.shape is (3, 2). df.shape[0] is 3 and df.shape[1] is 2.',
'3 2')}

${cards('DataFrame Basics Active Recall',[
  {q:'What is the difference between a Pandas Series and a DataFrame?',a:'A Series is a one-dimensional labeled array; a DataFrame is a two-dimensional labeled table comprising one or more Series sharing a common index.'},
  {q:'Why does df.shape not use parentheses?',a:'shape is an instance attribute (a tuple), not a callable method.'},
  {q:'What does pd.read_csv("data.csv") return?',a:'A two-dimensional Pandas DataFrame containing the parsed tabular data.'},
  {q:'How do you inspect the data types of all columns in df?',a:'Using the df.dtypes attribute.'},
  {q:'What does df.head(10) do?',a:'Returns the first 10 rows of the DataFrame.'},
  {q:'Can a DataFrame have custom string index labels for rows?',a:'Yes, by passing index=["r1", "r2", ...] or using df.set_index("col_name").'}
])}

${omr('Unit Test · DataFrame Creation & Inspection',[
  {q:'Which of the following creates a DataFrame from dictionary d?',o:['pd.DataFrame(d)','pd.create_df(d)','pd.Table(d)','pd.to_dataframe(d)'],a:0,why:'pd.DataFrame(d) is the constructor for DataFrames.'},
  {q:'What does df.shape return for a DataFrame with 100 rows and 5 columns?',o:['500','(100, 5)','[5, 100]','(5, 100)'],a:1,why:'shape returns a tuple of (num_rows, num_columns).'},
  {q:'What is the default number of rows returned by df.tail()?',o:['10','1','5','20'],a:2,why:'Both head() and tail() default to 5 rows if unspecified.'},
  {q:'Which attribute lists the data types of columns in a DataFrame?',o:['df.types','df.column_types','df.dtypes','df.types()'],a:2,why:'df.dtypes returns a Series with the data type of each column.'},
  {q:'How does Pandas represent missing numerical data internally?',o:['0.0','None','np.nan','-999'],a:2,why:'Missing numerical values are represented as floating-point np.nan (Not a Number).'}
])}
`});

/* ───────────── Indexing, Sorting & Pivoting ───────────── */
STATIONS.push({id:'m2-attributes',title:'Indexing, Sorting & Pivoting',short:'Indexing, Sorting & Pivoting',est:'~45 min',body:H`
${gist('Slice rows and columns using loc and iloc, filter by Boolean conditions, and reshape tables with sorting and pivot tables.')}

${tp('Column Selection and Boolean Filtering')}
<p>Select individual columns using brackets <code>df['col']</code> (returns a Series) or double brackets <code>df[['c1', 'c2']]</code> (returns a DataFrame):</p>

${ex(P`import pandas as pd

# Physics lab: Hooke's Law spring experiment
df = pd.DataFrame({
    'Trial': [1, 2, 3, 4, 5],
    'Mass_kg': [0.1, 0.2, 0.3, 0.4, 0.5],
    'Extension_cm': [1.9, 4.1, 5.8, 8.2, 9.9]
})

# 1. Column selection
single_col = df['Extension_cm']              # Series
multi_cols = df[['Mass_kg', 'Extension_cm']]  # DataFrame

# 2. Boolean filtering (masks)
heavy_trials = df[df['Mass_kg'] >= 0.3]

print("Heavy Trials (Mass >= 0.3 kg):\n", heavy_trials)`,
{title:'Column Selection & Boolean Filtering',
out:`Heavy Trials (Mass >= 0.3 kg):
    Trial  Mass_kg  Extension_cm
2      3      0.3           5.8
3      4      0.4           8.2
4      5      0.5           9.9`})}

${tp('Label-based loc vs Position-based iloc')}
<p>Pandas provides two distinct indexers for row and column slicing:</p>
<div class="scroll-x"><table class="ref">
  <tr><th>Indexer</th><th>Syntax</th><th>Addressing Mechanism</th><th>Slice Endpoint Rule</th></tr>
  <tr><td><b><code>.loc[]</code></b></td><td><code>df.loc[row_label, col_label]</code></td><td><b>Label-based</b> (by index names and column headers)</td><td><b>Both endpoints included!</b></td></tr>
  <tr><td><b><code>.iloc[]</code></b></td><td><code>df.iloc[row_pos, col_pos]</code></td><td><b>Integer-position-based</b> (0 to $N-1$)</td><td><b>Stop index excluded!</b></td></tr>
</table></div>

${must(H`<b>loc vs iloc Endpoints:</b> In <code>df.loc[1:3]</code>, rows with labels 1, 2, AND 3 are included! In <code>df.iloc[1:3]</code>, only rows at integer positions 1 and 2 are included (3 is excluded, matching Python list slice semantics).`)}

${tp('Sorting Rows: sort_values and sort_index')}
<p>Order rows by values in one or more columns using <code>sort_values()</code>:</p>

${ex(P`import pandas as pd

df = pd.DataFrame({
    'Student': ['Kiran', 'Devi', 'Amal', 'Fathima'],
    'Score': [84, 95, 78, 92]
})

# Sort ascending and descending
sorted_by_score = df.sort_values(by='Score', ascending=False)
print("Ranked by Score (Descending):\n", sorted_by_score)`,
{title:'Sorting Rows with sort_values',
out:`Ranked by Score (Descending):
    Student  Score
1     Devi     95
3  Fathima     92
0    Kiran     84
2     Amal     78`})}

${tp('Pivoting and Pivot Tables')}
<p><b><code>pivot_table()</code></b> reshapes data from long format to wide matrix format, aggregating duplicates:</p>

${ex(P`import pandas as pd

# Experimental runs across two different detectors
data = {
    'Detector': ['DetA', 'DetA', 'DetB', 'DetB', 'DetA', 'DetB'],
    'Energy_keV': [100, 200, 100, 200, 100, 200],
    'Efficiency': [0.92, 0.81, 0.88, 0.79, 0.94, 0.77]
}
df = pd.DataFrame(data)

# Reshape into a 2D matrix comparing Detectors across Energies
pivoted = df.pivot_table(index='Detector', columns='Energy_keV', values='Efficiency', aggfunc='mean')
print("Pivoted Efficiency Matrix:\n", pivoted.round(3))`,
{title:'Pivoting Experimental Measurements',
out:`Pivoted Efficiency Matrix:
 Energy_keV    100    200
Detector                 
DetA        0.930  0.810
DetB        0.880  0.780`})}

${fill('Indexing and Sorting Syntax',
P`To select by integer index position, use [[.iloc |iloc|.iloc]].
To select by explicit index label, use [[.loc |loc|.loc]].
To sort a DataFrame by a column, use df.[[sort_values(by='col') |sort_values|sort_values()]]
In df.iloc[0:2], row index 2 is [[excluded]].`,{code:true})}

${match('Indexing and Reshaping Functions',[
  ['df.loc[\'A\']','Selects row with label \'A\''],
  ['df.iloc[0]','Selects first row by integer position 0'],
  ['df.sort_values()','Sorts DataFrame rows by specified column values'],
  ['df.pivot_table()','Creates spreadsheet-style summary pivot matrix'],
  ['df[df[\'x\'] > 0]','Boolean filtering of rows satisfying condition']
])}

${parsons('Filter high energy rows and sort',[
  'import pandas as pd',
  'df = pd.DataFrame({"Energy": [120, 85, 210, 95], "Counts": [50, 20, 110, 35]})',
  'filtered = df[df["Energy"] > 100]',
  'sorted_df = filtered.sort_values(by="Counts", ascending=False)',
  'print(sorted_df)'
])}

${predict('Predict Output: loc vs iloc Slice Sizing',
P`import pandas as pd
df = pd.DataFrame({'val': [10, 20, 30, 40, 50]})
print(len(df.iloc[0:3]), len(df.loc[0:3]))`,
['3 4', '3 3', '4 4', '2 3'],
'3 4',
'iloc[0:3] uses standard exclusive slicing (indices 0, 1, 2) giving 3 rows. loc[0:3] is label-based and includes labels 0, 1, 2, 3 giving 4 rows.',
'3 4')}

${cards('Indexing & Pivoting Active Recall',[
  {q:'Why does df.loc[0:2] return 3 rows while df.iloc[0:2] returns 2 rows?',a:'loc is label-based and includes the stop boundary; iloc is position-based and follows Python standard exclusive stop rules.'},
  {q:'How do you select two columns "Voltage" and "Current" simultaneously?',a:'Using double brackets: df[["Voltage", "Current"]].'},
  {q:'What does df.sort_values(by="Time", ascending=False) do?',a:'Sorts the rows in descending order based on values in the "Time" column.'},
  {q:'What is the difference between pivot() and pivot_table() in Pandas?',a:'pivot() raises a ValueError if duplicate index-column combinations exist; pivot_table() aggregates duplicates using a summary function like mean.'},
  {q:'Does df.sort_values() modify the original DataFrame in place by default?',a:'No, it returns a new sorted DataFrame unless inplace=True is passed.'},
  {q:'How do you select rows where column "Status" is "Pass"?',a:'Using Boolean masking: df[df["Status"] == "Pass"].'}
])}

${omr('Unit Test · Indexing, Sorting & Pivoting',[
  {q:'Which method selects rows based on integer position?',o:['df.loc[]','df.iloc[]','df.ix[]','df.pos[]'],a:1,why:'iloc stands for integer location.'},
  {q:'How many rows are returned by df.iloc[1:4]?',o:['4','3','2','5'],a:1,why:'Integer positions 1, 2, and 3 are returned: 3 rows.'},
  {q:'What is the output of df[[\'A\']] compared to df[\'A\']?',o:['Both are Series','df[[\'A\']] is DataFrame, df[\'A\'] is Series','df[[\'A\']] is Series, df[\'A\'] is DataFrame','Both are DataFrames'],a:1,why:'Double brackets return a DataFrame, single bracket returns a Series.'},
  {q:'To sort a DataFrame df in descending order of column "g", which code is used?',o:['df.sort("g", reverse=True)','df.sort_values(by="g", ascending=False)','df.order_by("g", desc=True)','df.sort_index("g", up=False)'],a:1,why:'df.sort_values(by="g", ascending=False) orders rows descending.'},
  {q:'Which function handles duplicate entries gracefully when pivoting?',o:['df.pivot()','df.reshape()','df.pivot_table()','df.crosstab_only()'],a:2,why:'pivot_table aggregates duplicates using aggfunc (default is mean).'}
])}
`});

/* ───────────── Handling Missing Data ───────────── */
STATIONS.push({id:'m2-missing',title:'Handling Missing Data',short:'Handling Missing Data',est:'~45 min',body:H`
${gist('Clean noisy physics datasets: detect NaN markers, remove empty rows, impute values, and replace sensor error codes.')}

${tp('Missing Values in Experimental Data')}
<p>Physical instruments occasionally drop packets, lose sync, or report out-of-range sensor readings. Pandas represents missing numerical data as <b><code>np.nan</code></b> (Not a Number) from the IEEE 754 standard, or <code>None</code> for object arrays:</p>

<div class="scroll-x"><table class="ref">
  <tr><th>Method</th><th>Syntax</th><th>Description</th></tr>
  <tr><td><b><code>isna()</code> / <code>isnull()</code></b></td><td><code>df.isna()</code></td><td>Returns boolean mask indicating <code>True</code> for missing values</td></tr>
  <tr><td><b><code>notna()</code></b></td><td><code>df.notna()</code></td><td>Returns boolean mask indicating <code>True</code> for valid, non-null values</td></tr>
  <tr><td><b><code>dropna()</code></b></td><td><code>df.dropna(axis=0)</code></td><td>Drops rows (<code>axis=0</code>) or columns (<code>axis=1</code>) with null values</td></tr>
  <tr><td><b><code>fillna()</code></b></td><td><code>df.fillna(val)</code></td><td>Imputes missing entries with a constant, mean, or median</td></tr>
  <tr><td><b><code>replace()</code></b></td><td><code>df.replace(old, new)</code></td><td>Replaces sentinel codes (e.g. <code>-999.0</code>) with <code>np.nan</code></td></tr>
</table></div>

${trap(H`<b>Never test for NaN using <code>val == np.nan</code>!</b> According to IEEE floating-point standards, <code>NaN == NaN</code> evaluates to <b><code>False</code></b>! Always use <b><code>pd.isna(val)</code></b> or <code>np.isnan(val)</code>.`)}

${tp('Cleaning Pipeline: Replace, Drop, and Impute')}
<p>A standard experimental data cleaning pipeline involves replacing corrupted sensor codes and imputing missing entries:</p>

${ex(P`import pandas as pd
import numpy as np

# Sensor run with missing values and hardware error code -999.0
raw = {
    'Time_s': [0.0, 1.0, 2.0, 3.0, 4.0],
    'Voltage_V': [1.2, np.nan, 3.4, -999.0, 5.0],
    'Current_mA': [10.5, 9.8, np.nan, 8.4, 7.9]
}
df = pd.DataFrame(raw)

# Step 1: Replace sensor error code -999.0 with NaN
df['Voltage_V'] = df['Voltage_V'].replace(-999.0, np.nan)

# Step 2: Check missing count per column
null_counts = df.isna().sum()

# Step 3: Impute missing Voltage using mean of valid observations
v_mean = df['Voltage_V'].mean()
df['Voltage_Clean'] = df['Voltage_V'].fillna(v_mean)

print("Null counts per column:\n", null_counts)
print("\nCleaned DataFrame:\n", df[['Time_s', 'Voltage_Clean', 'Current_mA']])`,
{title:'Data Cleaning Pipeline with replace and fillna',
out:`Null counts per column:
 Time_s        0
Voltage_V     2
Current_mA    1
dtype: int64

Cleaned DataFrame:
    Time_s  Voltage_Clean  Current_mA
0     0.0       1.200000        10.5
1     1.0       3.200000         9.8
2     2.0       3.400000         NaN
3     3.0       3.200000         8.4
4     4.0       5.000000         7.9`})}

${fill('Missing Data Methods',
P`To detect missing values in a DataFrame, call df.[[isna() |isna()|isna]].
To delete rows containing any missing value, call df.[[dropna() |dropna()|dropna]].
To replace NaNs with the column mean, use df.[[fillna() |fillna()|fillna]].
Testing np.nan == np.nan evaluates to [[False]].`,{code:true})}

${match('Missing Data Functions',[
  ['df.isna().sum()','Counts missing values in each column'],
  ['df.dropna(axis=0)','Drops any row containing at least one NaN'],
  ['df.dropna(how=\'all\')','Drops row only if all its values are NaN'],
  ['df.fillna(method=\'ffill\')','Forward fills missing value from previous valid row'],
  ['df.replace(-999, np.nan)','Replaces hardware error code with standard NaN']
])}

${parsons('Build missing data cleanup pipeline',[
  'import pandas as pd',
  'import numpy as np',
  'df = pd.DataFrame({"V": [2.5, -999.0, 3.1, np.nan]})',
  'df["V"] = df["V"].replace(-999.0, np.nan)',
  'df["V"] = df["V"].fillna(df["V"].mean())',
  'print("Cleaned:", df["V"].tolist())'
])}

${predict('Predict Output: dropna Row Count',
P`import pandas as pd
import numpy as np
df = pd.DataFrame({
    'A': [1.0, 2.0, np.nan, 4.0],
    'B': [5.0, np.nan, np.nan, 8.0]
})
clean_df = df.dropna()
print(len(clean_df))`,
['1', '2', '3', '4'],
'2',
'Row 0 (1.0, 5.0) and Row 3 (4.0, 8.0) have no NaNs. Rows 1 and 2 each contain at least one NaN and are dropped, leaving 2 rows.',
'2')}

${cards('Missing Data Active Recall',[
  {q:'Why does x == np.nan fail to test for missing values?',a:'NaN is defined such that it does not compare equal to anything, including itself. Use pd.isna(x).'},
  {q:'What does df.dropna(subset=["Pressure"]) do?',a:'It only drops rows where the "Pressure" column has a missing NaN value.'},
  {q:'What is forward filling (ffill)?',a:'Propagating the last valid observation forward to fill the following missing entry.'},
  {q:'How do you count total missing entries across all columns in df?',a:'df.isna().sum().sum().'},
  {q:'What is the effect of how="all" in df.dropna()?',a:'A row or column is dropped only if every single value in it is NaN.'},
  {q:'What does df.replace(-999.0, np.nan) do?',a:'Finds every occurrence of the sentinel error value -999.0 and replaces it with np.nan.'}
])}

${omr('Unit Test · Handling Missing Data',[
  {q:'Which expression correctly checks if variable x is NaN?',o:['x == np.nan','x is np.nan','pd.isna(x)','x.isnan()'],a:2,why:'pd.isna(x) correctly evaluates NaN conditions.'},
  {q:'What does df.isna().sum() return?',o:['Total number of rows','A Series with missing value count for each column','A single integer of all NaNs','A Boolean True or False'],a:1,why:'It returns a Series mapping each column name to its count of NaNs.'},
  {q:'By default, which axis does df.dropna() operate on?',o:['axis=0 (rows)','axis=1 (columns)','Both rows and columns','Diagonal axis'],a:0,why:'axis=0 is default, dropping rows with missing entries.'},
  {q:'How can you fill missing entries in column "A" with the number 0?',o:['df["A"].replace_null(0)','df["A"].fillna(0)','df["A"].set_nan(0)','df["A"].impute(0)'],a:1,why:'df["A"].fillna(0) imputes missing values with 0.'},
  {q:'What does df.dropna(how="all") do?',o:['Drops all rows','Drops row if all its values are NaN','Drops row if any value is NaN','Never drops any row'],a:1,why:'how="all" requires all values in the row to be NaN for dropping.'}
])}
`});

/* ───────────── Descriptive Statistics ───────────── */
STATIONS.push({id:'m2-stats',title:'Descriptive Statistics',short:'Descriptive Statistics',est:'~45 min',body:H`
${gist('Summarize experimental distributions: calculate mean, variance, quantiles, and find extremum index locations with idxmin and idxmax.')}

${tp('Summary Statistics with describe()')}
<p>The <b><code>df.describe()</code></b> method generates an instant statistical summary of numerical columns, automatically excluding <code>NaN</code> values:</p>

<div class="scroll-x"><table class="ref">
  <tr><th>Statistic</th><th>Pandas Method</th><th>Formula / Meaning</th></tr>
  <tr><td><b><code>count</code></b></td><td><code>df.count()</code></td><td>Number of valid (non-null) observations</td></tr>
  <tr><td><b><code>mean</code></b></td><td><code>df.mean()</code></td><td>Arithmetic mean: $\bar{x} = \frac{1}{N}\sum x_i$</td></tr>
  <tr><td><b><code>std</code></b></td><td><code>df.std()</code></td><td>Sample standard deviation: $s = \sqrt{\frac{1}{N-1}\sum(x_i - \bar{x})^2}$</td></tr>
  <tr><td><b><code>min / max</code></b></td><td><code>df.min(), df.max()</code></td><td>Lowest and highest observed values</td></tr>
  <tr><td><b><code>25%, 50%, 75%</code></b></td><td><code>df.quantile([0.25, 0.5, 0.75])</code></td><td>First quartile, Median ($Q_2$), and Third quartile</td></tr>
  <tr><td><b><code>idxmin / idxmax</code></b></td><td><code>df.idxmin(), df.idxmax()</code></td><td>Index label of the row where minimum / maximum value occurs</td></tr>
</table></div>

${ex(P`import pandas as pd

# Physics lab: Resistor tolerance batch testing (Ohms)
batch = pd.DataFrame({
    'Batch_ID': [101, 102, 103, 104, 105, 106],
    'Resistance_Ohm': [99.2, 100.8, 101.4, 98.7, 100.1, 99.8]
})

stats = batch['Resistance_Ohm'].describe()
max_idx = batch['Resistance_Ohm'].idxmax()
min_idx = batch['Resistance_Ohm'].idxmin()

print("Statistical Summary:\n", stats.round(2))
print(f"\nHighest resistance observed at index {max_idx}: {batch.loc[max_idx, 'Resistance_Ohm']} Ohm")
print(f"Lowest resistance observed at index {min_idx}: {batch.loc[min_idx, 'Resistance_Ohm']} Ohm")`,
{title:'Descriptive Statistics and idxmax/idxmin',
out:`Statistical Summary:
 count      6.00
mean     100.00
std        0.96
min       98.70
25%       99.35
50%      100.00
75%      100.62
max      101.40
Name: Resistance_Ohm, dtype: float64

Highest resistance observed at index 2: 101.4 Ohm
Lowest resistance observed at index 3: 98.7 Ohm`})}

${tp('Mode and Quantiles')}
<p>The <b><code>mode()</code></b> method returns the most frequently occurring value(s). Unlike <code>mean()</code> which returns a single float scalar, <code>mode()</code> returns a <b>Series</b> because a dataset can be bimodal or multimodal.</p>

${ex(P`import pandas as pd

# Measured quantum spin quantum numbers
spins = pd.Series([1.5, 0.5, 1.5, 1.5, 0.5, 2.5])
mode_val = spins.mode()

print("Spin observations:\n", spins.values)
print("Most frequent spin state (Mode):\n", mode_val.values)`,
{title:'Mode of Experimental Measurements',
out:`Spin observations:
 [1.5 0.5 1.5 1.5 0.5 2.5]
Most frequent spin state (Mode):
 [1.5]`})}

${fill('Descriptive Statistics Functions',
P`To calculate summary statistics in one call, use df.[[describe() |describe()|describe]].
The index of the maximum value is found using df.[[idxmax() |idxmax()|idxmax]].
The middle 50% quantile (median) corresponds to q = [[0.5]].
By default, Pandas std() uses N - 1 in the denominator, computing the [[sample]] standard deviation.`,{code:true})}

${match('Statistical Functions and Formulas',[
  ['df.describe()','Generates 8-number summary including mean, std, and quantiles'],
  ['df.idxmax()','Returns index label of maximum value'],
  ['df.idxmin()','Returns index label of minimum value'],
  ['df.quantile(0.5)','Calculates the 50th percentile (median)'],
  ['df.mode()','Returns the most frequent value(s) as a Series']
])}

${parsons('Calculate mean and identify outlier index',[
  'import pandas as pd',
  'df = pd.DataFrame({"V": [5.01, 5.03, 4.98, 5.25, 4.99]})',
  'mean_v = df["V"].mean()',
  'worst_idx = df["V"].idxmax()',
  'print(f"Mean: {mean_v:.2f}, Max at: {worst_idx}")'
])}

${predict('Predict Output: describe() Count Output',
P`import pandas as pd
import numpy as np
s = pd.Series([10.0, 20.0, np.nan, 40.0])
print(int(s.describe()['count']))`,
['3', '4', '2', '3.0'],
'3',
'describe() ignores NaN entries automatically. Out of 4 entries, 3 are valid numbers, so count is 3.',
'3')}

${cards('Descriptive Statistics Active Recall',[
  {q:'What 8 statistics does describe() output for numeric columns?',a:'count, mean, std, min, 25%, 50% (median), 75%, and max.'},
  {q:'What is the difference between df["A"].max() and df["A"].idxmax()?',a:'max() returns the largest numerical value; idxmax() returns the row index label where that largest value is located.'},
  {q:'Why does df["A"].mode() return a Series rather than a single float?',a:'A dataset can have multiple modes (e.g. bimodal) or no single most frequent value, so Pandas returns a Series of all modes.'},
  {q:'Does describe() include or exclude NaN values?',a:'It automatically excludes NaN values from all calculations.'},
  {q:'What quantile corresponds to the median?',a:'The 0.50 quantile (50th percentile).'},
  {q:'What formula does df.std() use by default?',a:'Sample standard deviation with N - 1 degrees of freedom (ddof=1).'}
])}

${omr('Unit Test · Descriptive Statistics',[
  {q:'Which method produces count, mean, std, and quartiles simultaneously?',o:['df.summary()','df.stats()','df.describe()','df.overview()'],a:2,why:'df.describe() produces the complete summary statistics.'},
  {q:'How do you find the index label of the minimum value in column "T"?',o:['df["T"].min_index()','df["T"].idxmin()','df["T"].argmin()','df["T"].find_min()'],a:1,why:'idxmin() returns the row index of the minimum value.'},
  {q:'What does quantile(0.75) represent?',o:['Mean plus 75%','75th percentile (third quartile Q3)','75% of max value','Mode of upper half'],a:1,why:'0.75 quantile is the third quartile Q3 below which 75% of the data falls.'},
  {q:'If a column contains [10, 20, np.nan, 30], what is count in describe()?',o:['4','3','2','NaN'],a:1,why:'describe() ignores NaNs; 3 valid values exist.'},
  {q:'What type is returned by df["col"].mode()?',o:['float','int','pd.Series','dict'],a:2,why:'mode() returns a Series because multiple modes can exist.'}
])}
`});

/* ───────────── Covariance & Correlation ───────────── */
STATIONS.push({id:'m2-correlation',title:'Covariance & Correlation',short:'Covariance & Correlation',est:'~45 min',body:H`
${gist('Verify physical laws: compute covariance matrices, calculate Pearson correlation coefficient r, and analyze linear sensor trends.')}

${tp('Covariance in Physics Experiments')}
<p><b>Covariance</b> measures how two physical variables change together. For variables $X$ and $Y$ with sample means $\bar{x}$ and $\bar{y}$:</p>

$$\text{Cov}(X, Y) = \frac{1}{N-1} \sum_{i=1}^N (x_i - \bar{x})(y_i - \bar{y})$$

<p>In Pandas, <b><code>df.cov()</code></b> computes the pairwise sample covariance matrix across all numerical columns:</p>
<ul style="padding-left:1.2rem;line-height:1.65">
  <li>$\text{Cov}(X, Y) > 0$: Variables tend to increase together (e.g. Temperature and Volume at constant pressure).</li>
  <li>$\text{Cov}(X, Y) < 0$: One variable increases while the other decreases (e.g. Pressure and Volume at constant temperature).</li>
  <li>$\text{Cov}(X, X)$: The covariance of a variable with itself is simply its sample <b>variance</b> ($\sigma_X^2$).</li>
</ul>

${tp('Pearson Correlation Coefficient (r)')}
<p>Because covariance depends on the units of measurement (e.g. $\text{kg} \cdot \text{m}^2$), it cannot indicate the relative strength of the relationship. The <b>Pearson Correlation Coefficient</b> $r$ normalizes covariance by the product of standard deviations:</p>

$$r = \frac{\text{Cov}(X, Y)}{\sigma_X \sigma_Y} = \frac{\sum (x_i - \bar{x})(y_i - \bar{y})}{\sqrt{\sum(x_i - \bar{x})^2 \sum(y_i - \bar{y})^2}}$$

<div class="scroll-x"><table class="ref">
  <tr><th>Value of $r$</th><th>Physical Interpretation</th><th>Physics Example</th></tr>
  <tr><td><b>$r = +1.0$</b></td><td>Perfect positive linear correlation</td><td>Ohm's law $V \propto I$, Hooke's law $F \propto \Delta x$</td></tr>
  <tr><td><b>$r \approx 0.0$</b></td><td>No linear relationship</td><td>Pendulum period vs amplitude (for small angles)</td></tr>
  <tr><td><b>$r = -1.0$</b></td><td>Perfect negative linear correlation</td><td>Radioactive remaining nuclei vs decay events</td></tr>
</table></div>

${tp('Hands-on Case Study: Sonometer Wire Resonance')}
<p>In a sonometer experiment, the mass $M$ hung on the wire is related to the resonant length $L$ by $M \propto L^2$. Let us verify this linear relationship using <code>corr()</code> and <code>cov()</code>:</p>

${ex(P`import pandas as pd

# Sonometer experiment: Mass hung (kg) vs resonant length squared (m^2)
sonometer = pd.DataFrame({
    'Mass_kg': [0.5, 1.0, 1.5, 2.0, 2.5],
    'L2_m2':   [0.062, 0.125, 0.188, 0.251, 0.314]
})

# Calculate Covariance and Correlation Matrices
cov_matrix = sonometer.cov()
corr_matrix = sonometer.corr()
r_val = sonometer['Mass_kg'].corr(sonometer['L2_m2'])

print("Covariance Matrix:\n", cov_matrix.round(4))
print("\nCorrelation Matrix:\n", corr_matrix.round(4))
print(f"\nPearson r (Mass vs L^2): {r_val:.5f}")`,
{title:'Sonometer Law Verification via Correlation',
out:`Covariance Matrix:
          Mass_kg   L2_m2
Mass_kg    0.6250  0.0790
L2_m2      0.0790  0.0099

Correlation Matrix:
          Mass_kg   L2_m2
Mass_kg    1.0000  0.9999
L2_m2      0.9999  1.0000

Pearson r (Mass vs L^2): 0.99994`})}

${must(H`<b>Properties of the Correlation Matrix:</b>
<ul style="margin:0;padding-left:1.2rem">
  <li>The diagonal entries are always identically <b>1.0000</b> (a variable is perfectly correlated with itself).</li>
  <li>The matrix is strictly <b>symmetric</b>: $r_{XY} = r_{YX}$.</li>
  <li>Values are bounded strictly between $-1.0$ and $+1.0$.</li>
</ul>`)}

${fill('Covariance and Correlation',
P`To calculate the correlation matrix in Pandas, call df.[[corr() |corr()|corr]].
To calculate the covariance matrix, call df.[[cov() |cov()|cov]].
The diagonal of a Pearson correlation matrix is always [[1.0 |1|1.0]].
The range of the Pearson correlation coefficient r is from [[-1]] to [[1 |+1|1.0]].`,{code:true})}

${match('Correlation and Covariance Concepts',[
  ['df.corr()','Computes normalized Pearson correlation matrix (-1 to +1)'],
  ['df.cov()','Computes sample covariance matrix with units'],
  ['r = +1.0','Perfect positive linear relationship'],
  ['r = 0.0','No linear correlation between variables'],
  ['cov(X, X)','Equals the sample variance of variable X']
])}

${parsons('Calculate correlation between voltage and current',[
  'import pandas as pd',
  'exp = pd.DataFrame({"V": [1.0, 2.0, 3.0], "I": [0.2, 0.4, 0.6]})',
  'r = exp["V"].corr(exp["I"])',
  'print(f"Ohm\'s law correlation: {r:.4f}")'
])}

${predict('Predict Output: Diagonal of Correlation Matrix',
P`import pandas as pd
df = pd.DataFrame({'x': [10, 20, 30], 'y': [5, 15, 25]})
cm = df.corr()
print(cm.loc['x', 'x'], cm.loc['y', 'y'])`,
['1.0 1.0', '0.5 0.5', '10.0 5.0', '1.0 0.0'],
'1.0 1.0',
'The correlation of any variable with itself is always identically 1.0.',
'1.0 1.0')}

${cards('Covariance & Correlation Active Recall',[
  {q:'What is the formula for the Pearson correlation coefficient r?',a:'r = Cov(X, Y) / (sigma_X * sigma_Y).'},
  {q:'Why is correlation often preferred over covariance for reporting results?',a:'Covariance has physical units and scales with magnitude, whereas correlation is dimensionless and bounded strictly between -1 and +1.'},
  {q:'What does an r value of -0.98 indicate?',a:'A very strong negative linear relationship (as one variable increases, the other decreases almost proportionally).'},
  {q:'What do the diagonal elements of df.cov() represent?',a:'The variance of each respective column.'},
  {q:'Can Pearson correlation detect non-linear relationships (like y = x^2)?',a:'Pearson r specifically measures linear relationships; a perfect non-linear relationship may still have r close to 0.'},
  {q:'How do you compute correlation between just two columns df["A"] and df["B"]?',a:'df["A"].corr(df["B"]).'}
])}

${omr('Unit Test · Covariance & Correlation',[
  {q:'Which method computes the correlation matrix for a DataFrame?',o:['df.covariance()','df.corr()','df.pearson()','df.correlate()'],a:1,why:'df.corr() computes pairwise correlation of columns.'},
  {q:'What is the maximum possible value of the Pearson correlation coefficient?',o:['0.0','1.0','100.0','Infinity'],a:1,why:'Pearson correlation coefficient is bounded in [-1.0, +1.0].'},
  {q:'What are the diagonal elements of a correlation matrix?',o:['0.0','Variances','1.0','Means'],a:2,why:'Correlation of any variable with itself is 1.0.'},
  {q:'What does df.cov() return along its main diagonal?',o:['1.0','Sample variances of the variables','Standard deviations','Means'],a:1,why:'Cov(X, X) is the variance of X.'},
  {q:'If two physical variables have r = 0, what does it signify?',o:['They are identically equal','There is no linear relationship between them','They are inversely related','They have zero mean'],a:1,why:'r = 0 indicates absence of a linear correlation.'}
])}
`});

/* ───────────── GroupBy, Aggregation & Merging ───────────── */
STATIONS.push({id:'m2-wrangling',title:'GroupBy, Aggregation & Merging',short:'GroupBy, Aggregation & Merging',est:'~50 min',body:H`
${gist('Execute the Split-Apply-Combine pattern, concatenate experimental runs, and perform relational merges on sensor datasets.')}

${tp('The GroupBy Mechanism: Split-Apply-Combine')}
<p>Experimental datasets frequently bundle runs across multiple categories (e.g. different materials, different temperatures). <b><code>groupby()</code></b> implements the three-stage <b>Split-Apply-Combine</b> pattern:</p>

<ol style="padding-left:1.2rem;line-height:1.65">
  <li><b>Split:</b> Partition the original DataFrame into groups based on key values.</li>
  <li><b>Apply:</b> Compute an aggregation function (e.g. <code>mean()</code>, <code>std()</code>, <code>max()</code>) on each group independently.</li>
  <li><b>Combine:</b> Merge the individual group summaries into a clean output DataFrame.</li>
</ol>

${ex(P`import pandas as pd

# Laboratory data: Measuring Young's Modulus across wire materials
wires = pd.DataFrame({
    'Material': ['Copper', 'Steel', 'Copper', 'Brass', 'Steel', 'Brass'],
    'Load_N':   [10, 10, 20, 10, 20, 20],
    'Elongation_mm': [0.45, 0.22, 0.91, 0.52, 0.43, 1.05]
})

# Group by Material and calculate mean elongation
grouped = wires.groupby('Material')['Elongation_mm'].mean()
print("Mean Elongation per Material:\n", grouped.round(3))`,
{title:'GroupBy and Mean Aggregation',
out:`Mean Elongation per Material:
 Material
Brass     0.785
Copper    0.680
Steel     0.325
Name: Elongation_mm, dtype: float64`})}

${tp('Multiple Aggregations with agg()')}
<p>Pass a list or dictionary of functions to <b><code>.agg()</code></b> to calculate multiple statistics simultaneously:</p>

${ex(P`import pandas as pd

df = pd.DataFrame({
    'Sensor': ['S1', 'S1', 'S2', 'S2', 'S1'],
    'Voltage': [3.2, 3.4, 4.8, 5.0, 3.3]
})

summary = df.groupby('Sensor').agg(['count', 'mean', 'std', 'max'])
print("Multi-metric Sensor Summary:\n", summary.round(2))`,
{title:'Multiple Aggregations with agg()',
out:`Multi-metric Sensor Summary:
        Voltage                
         count  mean   std  max
Sensor                         
S1           3  3.30  0.10  3.4
S2           2  4.90  0.14  5.0`})}

${tp('Concatenation: pd.concat()')}
<p><b><code>pd.concat()</code></b> stacks multiple DataFrames along a specified axis:</p>
<ul style="padding-left:1.2rem;line-height:1.65">
  <li><b><code>axis=0</code> (default):</b> Vertical stacking (appending rows from run 2 below run 1).</li>
  <li><b><code>axis=1</code>:</b> Horizontal stacking (joining columns side-by-side).</li>
</ul>

${tp('Merging DataFrames: pd.merge()')}
<p><b><code>pd.merge()</code></b> performs relational database joins based on one or more shared common keys:</p>

<div class="scroll-x"><table class="ref">
  <tr><th>Join Type (<code>how</code>)</th><th>Description</th><th>SQL Equivalent</th></tr>
  <tr><td><b><code>'inner'</code> (default)</b></td><td>Retains only rows where key exists in <b>both</b> DataFrames</td><td><code>INNER JOIN</code></td></tr>
  <tr><td><b><code>'left'</code></b></td><td>Retains all rows from left DataFrame; fills missing right values with <code>NaN</code></td><td><code>LEFT OUTER JOIN</code></td></tr>
  <tr><td><b><code>'right'</code></b></td><td>Retains all rows from right DataFrame</td><td><code>RIGHT OUTER JOIN</code></td></tr>
  <tr><td><b><code>'outer'</code></b></td><td>Retains all rows from both DataFrames; fills missing with <code>NaN</code></td><td><code>FULL OUTER JOIN</code></td></tr>
</table></div>

${tp('Syllabus Hands-on Task: ExpEYES Capacitor Charging')}
${must(H`<b>Syllabus Hands-on Task 3:</b> Illustrate table read, merge, and <code>groupby()</code> in Pandas using data generated by charging three different capacitors (e.g. ExpEYES sensor data).`)}

${ex(P`import pandas as pd

# 1. Experimental charging measurements table
charging_df = pd.DataFrame({
    'TrialID': [1, 2, 3, 4, 5, 6],
    'CapacitorID': ['C1', 'C1', 'C2', 'C2', 'C3', 'C3'],
    'Time_s': [0.5, 1.0, 0.5, 1.0, 0.5, 1.0],
    'Voltage_V': [1.82, 3.16, 2.45, 4.02, 0.95, 1.78]
})

# 2. Capacitor apparatus specifications metadata table
specs_df = pd.DataFrame({
    'CapacitorID': ['C1', 'C2', 'C3'],
    'Nominal_uF': [100.0, 47.0, 220.0],
    'Dielectric': ['Electrolytic', 'Polyester', 'Electrolytic']
})

# 3. MERGE: Relational join on common key 'CapacitorID'
merged = pd.merge(charging_df, specs_df, on='CapacitorID', how='inner')

# 4. GROUPBY: Aggregate mean and max charging voltage per capacitor
summary = merged.groupby('CapacitorID').agg({
    'Voltage_V': ['mean', 'max'],
    'Nominal_uF': 'first'
})

print("Merged Sensor Data:\n", merged[['TrialID', 'CapacitorID', 'Nominal_uF', 'Time_s', 'Voltage_V']])
print("\nGrouped Summary per Capacitor:\n", summary.round(2))`,
{title:'Syllabus Hands-on: ExpEYES Capacitor Charging Merge & Groupby',
out:`Merged Sensor Data:
    TrialID CapacitorID  Nominal_uF  Time_s  Voltage_V
0        1          C1       100.0     0.5       1.82
1        2          C1       100.0     1.0       3.16
2        3          C2        47.0     0.5       2.45
3        4          C2        47.0     1.0       4.02
4        5          C3       220.0     0.5       0.95
5        6          C3       220.0     1.0       1.78

Grouped Summary per Capacitor:
             Voltage_V      Nominal_uF
                  mean   max      first
CapacitorID                            
C1                2.49  3.16      100.0
C2                3.24  4.02       47.0
C3                1.36  1.78      220.0`})}

${fill('GroupBy and Merging Syntax',
P`The pattern of groupby is [[Split-Apply-Combine |split-apply-combine|Split Apply Combine]].
The default join type in pd.merge() is [['inner']].
To concatenate DataFrames along rows (vertically), set axis=[[0]].
To join on different column names, use left_on and [[right_on]].`,{code:true})}

${match('Join Types and Merging Parameters',[
  ['how=\'inner\'','Keeps only rows with keys matching in both tables'],
  ['how=\'outer\'','Keeps all rows from both tables, filling missing with NaN'],
  ['how=\'left\'','Keeps all rows from left table and matching from right'],
  ['axis=0','Vertical concatenation (stacking rows)'],
  ['axis=1','Horizontal concatenation (attaching columns side-by-side)']
])}

${parsons('Merge tables and compute group mean',[
  'import pandas as pd',
  'df1 = pd.DataFrame({"ID": [1, 2], "Val": [10, 20]})',
  'df2 = pd.DataFrame({"ID": [1, 2], "Group": ["A", "B"]})',
  'merged = pd.merge(df1, df2, on="ID")',
  'res = merged.groupby("Group")["Val"].mean()',
  'print(res)'
])}

${predict('Predict Output: Inner Merge Row Count',
P`import pandas as pd
df1 = pd.DataFrame({'id': [1, 2, 3], 'val': [10, 20, 30]})
df2 = pd.DataFrame({'id': [2, 3, 4], 'cat': ['X', 'Y', 'Z']})
m = pd.merge(df1, df2, on='id', how='inner')
print(len(m))`,
['2', '3', '4', '1'],
'2',
'An inner join retains only keys present in both DataFrames. The intersection of IDs {1, 2, 3} and {2, 3, 4} is {2, 3}, resulting in 2 rows.',
'2')}

${cards('Wrangling Active Recall',[
  {q:'What are the three stages of the GroupBy operation?',a:'Split the data into groups based on keys, Apply a function to each group, and Combine the results into a data structure.'},
  {q:'What is the default join type in pd.merge()?',a:'"inner" join (keeps only rows with matching keys in both DataFrames).'},
  {q:'What is the difference between pd.concat() and pd.merge()?',a:'concat simply glues DataFrames together along an axis by index alignment; merge performs relational SQL-like database joins based on column keys.'},
  {q:'How do you join two DataFrames if their join columns have different names?',a:'Use pd.merge(df1, df2, left_on="col_a", right_on="col_b").'},
  {q:'How do you apply different aggregation functions to different columns in groupby?',a:'Pass a dictionary to .agg(), e.g. df.groupby("grp").agg({"V": "mean", "I": "max"}).'},
  {q:'What happens to unmatched rows in an outer merge?',a:'They are retained, and missing columns from the opposing table are filled with NaN.'}
])}

${omr('Unit Test · GroupBy, Aggregation & Merging',[
  {q:'What is the default value of the how parameter in pd.merge()?',o:['\'left\'','\'outer\'','\'inner\'','\'right\''],a:2,why:'pd.merge defaults to an inner join.'},
  {q:'Which method applies multiple summary aggregations to grouped data?',o:['.apply_all()','.summary()','.agg()','.calc()'],a:2,why:'.agg() accepts lists and dictionaries of aggregation functions.'},
  {q:'To concatenate two DataFrames side-by-side (matching columns), what parameter is set?',o:['axis=0','axis=1','how=\'side\'','direction=\'col\''],a:1,why:'axis=1 performs column-wise horizontal concatenation.'},
  {q:'What join type keeps all rows from both tables, filling missing fields with NaN?',o:['Inner join','Left join','Outer join','Cross join'],a:2,why:'Outer join retains all records from both left and right DataFrames.'},
  {q:'In the Split-Apply-Combine pattern, what does "Combine" do?',o:['Joins code files together','Combines group calculation results into a single table','Cleans duplicate values','Deletes rows with NaN'],a:1,why:'Combine gathers all group-level results into an aggregated DataFrame.'}
])}
`});
