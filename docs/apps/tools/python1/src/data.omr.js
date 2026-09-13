/* ═══════════════════ RETRIEVAL PRACTICE OMR SHEET ═══════════════════ */
STATIONS.push({id:'omr-practice',title:'Retrieval Practice · Full Syllabus OMR Sheet',short:'OMR Exam Sheet',est:'~25 min',body:H`
${gist('Retrieval practice is the most robust technique for long-term retention. Fill the bubbles against the clock, submit, and review your mistakes.')}

${omr('Physics Python Comprehensive Retrieval Test (20 Questions)',[
  {q:'Which of the following represents a valid complex number in Python?',
   opts:['3 + 4i','3 + 4j','complex(3, 4, 0)','3 + 4*sqrt(-1)'],a:1,
   why:'Python uses j or J to represent the imaginary unit sqrt(-1). complex(3, 4) is also valid.'},

  {q:'Given z = 5.0 - 2.0j, what does z.imag evaluate to?',
   opts:['-2.0j','-2.0','2.0','-2'],a:1,
   why:'z.imag returns a float representing the imaginary component (-2.0), without the j suffix.'},

  {q:'Which operation modifies an existing list in place without creating a new list?',
   opts:['lst + [10]','lst[1:3]','lst.append(10)','sorted(lst)'],a:2,
   why:'append() mutates the list in place and returns None. lst + [...] and sorted() create new objects.'},

  {q:'What is the primary architectural difference between a tuple and a list?',
   opts:['Lists cannot store numbers','Tuples are immutable; lists are mutable','Tuples use curly braces {}','Lists are faster for lookup'],a:1,
   why:'Tuples cannot be altered after creation (immutable), making them hashable and safe for fixed data.'},

  {q:'Why is "with open(fname, \'r\') as f:" the recommended way to open files?',
   opts:['It makes reading 10x faster','It automatically flushes and closes the file even if exceptions occur','It prevents writing to the disk','It deletes temporary files'],a:1,
   why:'The context manager guarantees that the exit method closes the file descriptor under all exit scenarios.'},

  {q:'What does the "continue" statement do inside a Python loop?',
   opts:['Terminates the entire loop immediately','Skips the rest of the current iteration and advances to the next iteration','Restarts the loop from index 0','Exits the current function'],a:1,
   why:'continue jumps to the evaluation of the loop condition for the next iteration, skipping subsequent code in the body.'},

  {q:'In NumPy, which function creates an array of 50 evenly spaced numbers between 0 and 1 inclusive?',
   opts:['np.arange(0, 1, 50)','np.linspace(0, 1, 50)','np.zeros(50)','np.random.rand(50)'],a:1,
   why:'np.linspace(start, stop, num) generates num evenly spaced samples over the closed interval [start, stop].'},

  {q:'If A and B are two 3x3 NumPy arrays, what does "A @ B" compute?',
   opts:['Element-wise multiplication','Matrix dot product (linear algebraic multiplication)','Array concatenation','Outer Kronecker product'],a:1,
   why:'The @ operator (or np.dot) performs true linear algebraic matrix multiplication, whereas * is element-wise.'},

  {q:'What are the fundamental dimensions of a Pandas Series vs a Pandas DataFrame?',
   opts:['Series is 1D; DataFrame is 2D','Series is 2D; DataFrame is 3D','Both are 1D arrays','Series is unordered; DataFrame is ordered'],a:0,
   why:'A Series is a one-dimensional labeled array; a DataFrame is a two-dimensional labeled tabular data structure.'},

  {q:'Which DataFrame attribute returns a tuple of (number of rows, number of columns)?',
   opts:['df.size','df.ndim','df.shape','df.len'],a:2,
   why:'df.shape returns (nrows, ncols). df.size returns total elements (nrows * ncols).'},

  {q:'Which method replaces all NaN values in a DataFrame with a specified constant or mean?',
   opts:['df.dropna()','df.fillna()','df.replace_nan()','df.isna()'],a:1,
   why:'df.fillna(value) replaces null entries with value. df.dropna() discards the entire row or column.'},

  {q:'What does df.describe() provide?',
   opts:['A printout of the first 5 rows','A statistical summary (count, mean, std, min, quartiles, max) for numeric columns','A list of column names and memory usage','The correlation matrix of the DataFrame'],a:1,
   why:'describe() computes standard summary statistics for all numeric columns in the DataFrame.'},

  {q:'In the sonometer experiment, what does a Pearson correlation coefficient r = 0.9999 between M and L^2 indicate?',
   opts:['No relationship exists','Strong negative correlation','Nearly perfect positive linear relationship','A measurement error in the laboratory'],a:2,
   why:'r close to +1 confirms that resonant length squared is directly proportional to applied tension mass M.'},

  {q:'Which method groups rows by a category and applies aggregation functions like mean and sum?',
   opts:['df.pivot()','df.groupby()','df.sort_values()','df.melt()'],a:1,
   why:'df.groupby(\'col\').agg(...) implements the split-apply-combine strategy for data analysis.'},

  {q:'What plot type is best suited to display median, interquartile range, and outliers of refractive indices?',
   opts:['Scatter plot','Box plot (plt.boxplot / sns.boxplot)','Pie chart','Line plot'],a:1,
   why:'A box plot explicitly demarcates the median line, the IQR box (Q1 to Q3), whiskers, and flier points.'},

  {q:'What does the "annot=True" parameter do in sns.heatmap()?',
   opts:['Draws annotation arrows on the chart','Displays the exact numeric correlation values inside each cell','Inverts the color map','Hides the colorbar axis'],a:1,
   why:'annot=True prints the numerical value of each matrix cell directly over the colored squares.'},

  {q:'How does Seaborn’s violinplot differ from a standard boxplot?',
   opts:['It displays 3D surfaces','It combines the boxplot with a rotated kernel density estimate (KDE) on each side','It only works on time series data','It does not show the median'],a:1,
   why:'A violin plot shows the probability density of the data at different values, smoothed by a kernel estimator.'},

  {q:'Which Pandas command reads a whitespace-delimited experimental DAT file?',
   opts:['pd.read_csv(\'data.dat\', sep=r\'\\s+\')','pd.read_dat(\'data.dat\')','pd.read_excel(\'data.dat\')','pd.load(\'data.dat\')'],a:0,
   why:'sep=r\'\\s+\' uses regular expression matching to split on one or more spaces or tabs.'},

  {q:'What is the primary difference between df.loc[0:3] and df.iloc[0:3]?',
   opts:['loc is 0-indexed while iloc is 1-indexed','loc is label-based and includes the endpoint 3; iloc is position-based and excludes 3','loc only works on columns','There is no difference'],a:1,
   why:'loc uses label matching and includes the slice stop label; iloc uses Python index slicing and excludes stop.'},

  {q:'In Jupyter Notebook command mode, which key converts the active cell into a Markdown cell?',
   opts:['Y','M','B','Ctrl + M'],a:1,
   why:'Pressing M in command mode switches the cell to Markdown. Pressing Y switches it back to Code.'}
])}
`});
