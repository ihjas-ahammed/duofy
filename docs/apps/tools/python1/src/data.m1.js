/* ═══════════════════ MODULE I: PYTHON CORE PROGRAMMING ═══════════════════ */

/* ───────────── Variables, Types & Lists ───────────── */
STATIONS.push({id:'m1-types',title:'Variables, Types & Lists',short:'Variables, Types & Lists',est:'~35 min',body:H`
${gist('Python variables are dynamically typed references. Master int, float, complex numbers, and mutable list operations.')}

${tp('Variables and Dynamic Typing')}
<p>In Python, variables do not require explicit type declarations. A variable is created the moment a value is assigned to it using the assignment operator <code>=</code>. Python determines the type automatically at runtime (<b>dynamic typing</b>).</p>
<p>Variable names must begin with a letter or an underscore (<code>_</code>), are case-sensitive (<code>Temp</code> and <code>temp</code> are distinct), and cannot use reserved keywords like <code>for</code>, <code>class</code>, or <code>def</code>.</p>

${tp('Numerical Data Types in Physics')}
<p>Physics simulations and data analysis depend on three core built-in numeric types:</p>

<div class="scroll-x"><table class="ref">
  <tr><th>Type</th><th>Syntax Example</th><th>Internal Precision</th><th>Physics Application</th></tr>
  <tr><td><b><code>int</code></b></td><td><code>n = 3, count = 100</code></td><td>Arbitrary precision integers</td><td>Quantum numbers ($n, l, m$), particle counts, fringe numbers</td></tr>
  <tr><td><b><code>float</code></b></td><td><code>c = 2.998e8, h = 6.626e-34</code></td><td>64-bit IEEE 754 floating point</td><td>Physical constants, coordinates, experimental sensor readings</td></tr>
  <tr><td><b><code>complex</code></b></td><td><code>z = 3.0 + 4.0j</code></td><td>Two 64-bit floats (real + imag)</td><td>AC impedance ($Z = R + j\omega L$), quantum wavefunctions ($\psi = A e^{ikx}$)</td></tr>
</table></div>

${must(H`In Python, the imaginary unit is represented by <b><code>j</code></b> or <b><code>J</code></b> (never <code>i</code>). Python stores complex numbers as a pair of floating-point numbers: <code>z.real</code> and <code>z.imag</code>, both accessible as attributes.`)}

${ex(P`# AC Circuit Impedance Calculation in Python
R = 50.0          # Resistance in Ohms (float)
omega = 314.16    # Angular frequency 2 * pi * f (50 Hz)
L = 0.15          # Inductance in Henrys
C = 47e-6         # Capacitance in Farads

# Impedances as complex numbers
Z_R = complex(R, 0)
Z_L = complex(0, omega * L)
Z_C = complex(0, -1.0 / (omega * C))

# Total series impedance
Z_total = Z_R + Z_L + Z_C

print(f"Resistance Z_R : {Z_R}")
print(f"Inductive  Z_L : {Z_L:.2f}")
print(f"Capacitive Z_C : {Z_C:.2f}")
print(f"Total Series Z : {Z_total:.2f}")
print(f"Impedance Real : {Z_total.real:.2f} Ohms")
print(f"Impedance Imag : {Z_total.imag:.2f} Ohms")
print(f"Magnitude |Z|  : {abs(Z_total):.2f} Ohms")`,
{title:'Complex Numbers in AC Impedance',
out:`Resistance Z_R : (50+0j)
Inductive  Z_L : 0.00+47.12j
Capacitive Z_C : 0.00-67.76j
Total Series Z : 50.00-20.64j
Impedance Real : 50.00 Ohms
Impedance Imag : -20.64 Ohms
Magnitude |Z|  : 54.10 Ohms`})}

${tp('Arithmetic and Comparison Operators')}
<p>Python provides rich operators with standard mathematical precedence:</p>
<div class="scroll-x"><table class="ref">
  <tr><th>Operator</th><th>Name</th><th>Example</th><th>Result</th><th>Physics Note</th></tr>
  <tr><td><code>+</code>, <code>-</code>, <code>*</code></td><td>Add, Sub, Mul</td><td><code>10 * 3.5</code></td><td><code>35.0</code></td><td>Standard arithmetic</td></tr>
  <tr><td><code>/</code></td><td>True Division</td><td><code>7 / 2</code></td><td><code>3.5</code></td><td>Always returns a <code>float</code> in Python 3</td></tr>
  <tr><td><code>//</code></td><td>Floor Division</td><td><code>7 // 2</code></td><td><code>3</code></td><td>Discards fractional part; useful for bins</td></tr>
  <tr><td><code>%</code></td><td>Modulus</td><td><code>7 % 2</code></td><td><code>1</code></td><td>Phase wrapping, periodic boundary conditions</td></tr>
  <tr><td><code>**</code></td><td>Exponentiation</td><td><code>2 ** 8</code></td><td><code>256</code></td><td>Power laws: $E = mc^2 \rightarrow$ <code>m * (c**2)</code></td></tr>
</table></div>

${trap(H`Do not confuse <code>^</code> with exponentiation! In Python, <code>**</code> is power (e.g. <code>x**2</code>). The caret <code>^</code> is the <b>bitwise XOR</b> operator (<code>2 ^ 3</code> is <code>1</code>, not <code>8</code>).`)}

${tp('Lists and Sequence Operations')}
<p>A <b>list</b> is an ordered, mutable sequence defined with square brackets <code>[ ... ]</code>. Lists support heterogeneous data, dynamic sizing, and rich in-place methods:</p>

${ex(P`# Lab measurements list
voltages = [1.2, 2.4, 3.6, 4.8, 6.0]

# List mutations
voltages.append(7.2)         # Appends element to end
voltages.insert(2, 2.9)      # Inserts 2.9 at index 2
removed = voltages.pop()     # Removes and returns last element (7.2)
voltages.remove(2.9)         # Removes first occurrence of 2.9

# Slicing: list[start:stop:step]
subset = voltages[1:4]       # indices 1, 2, 3 (stop=4 is excluded)
rev_copy = voltages[::-1]    # reversed copy without modifying original

print("Voltages:     ", voltages)
print("Subset [1:4]: ", subset)
print("Reversed copy:", rev_copy)
print(f"Length: {len(voltages)}, Min: {min(voltages)}, Max: {max(voltages)}")`,
{title:'List Mutation and Slicing Methods',
out:`Voltages:      [1.2, 2.4, 3.6, 4.8, 6.0]
Subset [1:4]:  [2.4, 3.6, 4.8]
Reversed copy: [6.0, 4.8, 3.6, 2.4, 1.2]
Length: 5, Min: 1.2, Max: 6.0`})}

${trap(H`Assignment does not copy a list! Writing <code>b = a</code> makes <code>b</code> an alias referencing the exact same memory. Modifying <code>b.append(99)</code> also mutates <code>a</code>. To create an independent copy, use <code>b = a.copy()</code> or <code>b = a[:]</code>.`)}

${fill('List Slicing and Indexing Syntax',
P`readings = [10.5, 20.0, 31.5, 42.0, 55.0]
First element is readings[[ [0] |[0] ]]
Last element is readings[[ [-1] |[-1] ]]
Slice readings[1:3] gives [[ [20.0, 31.5] |[20.0, 31.5] ]]
Slice readings[::-1] [[reverses]] the list.`,{code:true})}

${match('Python Operators and Lookups',[
  ['//','Floor division (truncates decimal part)'],
  ['**','Exponentiation (power)'],
  ['%','Modulus (remainder of division)'],
  ['abs(z)','Calculates absolute magnitude of complex number'],
  ['z.imag','Accesses imaginary component as float']
])}

${parsons('Filter and reverse experimental readings',[
  'readings = [12.0, -1.0, 15.5, -2.0, 18.0]',
  'valid = []',
  'for r in readings:',
  '    if r > 0:',
  '        valid.append(r)',
  'reversed_valid = valid[::-1]',
  'print(reversed_valid)'
])}

${predict('Predict Output: List Slicing & Aliasing',
P`a = [1, 2, 3, 4, 5]
b = a
b.append(6)
c = a[1:4]
print(len(a), c)`,
['5 [2, 3, 4]', '6 [2, 3, 4]', '6 [2, 3, 4, 5]', '5 [1, 2, 3]'],
'6 [2, 3, 4]',
'b is an alias to a, so b.append(6) increases len(a) to 6. Slicing a[1:4] takes indices 1, 2, 3: [2, 3, 4].',
'6 [2, 3, 4]')}

${cards('Variables & Lists Active Recall',[
  {q:'What are the three built-in numerical data types in Python?',a:'int (arbitrary precision integer), float (64-bit IEEE floating point), and complex (pair of floats with j).'},
  {q:'How do you access the real and imaginary parts of a complex number z?',a:'Use z.real and z.imag, both of which return standard floats.'},
  {q:'What is the difference between / and // in Python 3?',a:'/ performs true division returning a float; // performs floor division truncating toward negative infinity.'},
  {q:'How do you reverse a list without modifying the original?',a:'Using the slice notation lst[::-1] or list(reversed(lst)).'},
  {q:'What is the difference between lst.append(x) and lst.extend(x)?',a:'append(x) adds x as a single element at the end; extend(x) iterates over collection x and appends each element individually.'},
  {q:'Why does b = a not make a real copy of list a?',a:'In Python, variable assignment binds the name to the existing object in memory. To create a shallow copy, use a.copy() or a[:].'}
])}

${omr('Unit Test · Variables, Types & Lists',[
  {q:'Which of the following is an invalid variable name in Python?',o:['_pressure','temp_2','2nd_trial','lambda_val'],a:2,why:'Variable names cannot begin with a digit.'},
  {q:'In Python, the expression 7 // 2 evaluates to:',o:['3.5','3','4','3.0'],a:1,why:'Floor division // returns integer quotient 3.'},
  {q:'For z = 4 + 3j, what does abs(z) return?',o:['7.0','5.0','25.0','(4+3j)'],a:1,why:'abs(z) calculates sqrt(4^2 + 3^2) = sqrt(25) = 5.0.'},
  {q:'What is the output of [10, 20, 30, 40, 50][1:4]?',o:['[20, 30, 40, 50]','[10, 20, 30]','[20, 30, 40]','[20, 30]'],a:2,why:'Slice start 1 is inclusive, stop 4 is exclusive: items at indices 1, 2, and 3.'},
  {q:'Which operation modifies a list in-place?',o:['lst + [1, 2]','lst.append(5)','lst[::-1]','lst * 2'],a:1,why:'append() mutates the existing list in memory and returns None.'}
])}
`});

/* ───────────── Tuples, Sets & Dictionaries ───────────── */
STATIONS.push({id:'m1-collections',title:'Tuples, Sets & Dictionaries',short:'Tuples, Sets & Dictionaries',est:'~40 min',body:H`
${gist('Explore immutable tuples for coordinates, unique sets for frequency bands, and high-speed hash dictionaries for metadata.')}

${tp('Tuples and Immutability')}
<p>A <b>tuple</b> is an ordered, <b>immutable</b> sequence defined by parentheses <code>( ... )</code> or comma-separated items. Once created, elements of a tuple cannot be reassigned, added, or deleted.</p>

<p>Tuples are ideal for fixed physical constants, 3D spatial coordinates $(x, y, z)$, RGB colour tuples, and returning multiple values from a function:</p>

${ex(P`# 3D Position vector and immutable properties
position = (1.5, -2.4, 0.8)
x, y, z = position     # Tuple unpacking

print(f"Coordinates: x={x}, y={y}, z={z}")
print(f"Vector magnitude: {(x**2 + y**2 + z**2)**0.5:.2f}")

# Single element tuple must include a trailing comma:
single = (42,)         # tuple
not_tuple = (42)       # int!

print("type(single):   ", type(single))
print("type(not_tuple):", type(not_tuple))`,
{title:'Tuple Unpacking and Trailing Comma Rule',
out:`Coordinates: x=1.5, y=-2.4, z=0.8
Vector magnitude: 2.94
type(single):    <class 'tuple'>
type(not_tuple): <class 'int'>`})}

${trap(H`A common exam trap: writing <code>t = (5)</code> creates an integer, not a tuple! A single-element tuple <b>must</b> have a trailing comma: <code>t = (5,)</code>.`)}

${tp('Sets and Unique Mathematical Collections')}
<p>A <b>set</b> is an unordered collection of <b>unique</b>, immutable elements defined with curly braces <code>{ ... }</code> or the <code>set()</code> constructor. Sets automatically eliminate duplicates and support fast $O(1)$ membership testing and set-theoretic operations:</p>

${ex(P`# Spectral lines observed by two spectrometers (wavelengths in nm)
spec_A = {404.7, 435.8, 546.1, 577.0}
spec_B = {435.8, 546.1, 579.1, 690.7}

# Set mathematical operations
union_lines = spec_A | spec_B            # Union: all detected lines
common_lines = spec_A & spec_B           # Intersection: lines in both
unique_to_A = spec_A - spec_B            # Difference: only in spectrometer A
symm_diff = spec_A ^ spec_B              # Symmetric difference: in either, not both

print("All unique lines (Union):        ", sorted(union_lines))
print("Common lines (Intersection):     ", sorted(common_lines))
print("Lines unique to Spectrometer A:  ", sorted(unique_to_A))
print("Symmetric Difference:            ", sorted(symm_diff))`,
{title:'Set Operations on Spectral Lines',
out:`All unique lines (Union):         [404.7, 435.8, 546.1, 577.0, 579.1, 690.7]
Common lines (Intersection):      [435.8, 546.1]
Lines unique to Spectrometer A:   [404.7, 577.0]
Symmetric Difference:             [404.7, 577.0, 579.1, 690.7]`})}

${must(H`To create an empty set, you <b>must</b> use <code>set()</code>. Writing <code>s = {}</code> creates an empty <b>dictionary</b>, not an empty set!`)}

${tp('Dictionaries: Key-Value Hash Maps')}
<p>A <b>dictionary</b> (<code>dict</code>) stores associative key-value pairs. Keys must be immutable types (e.g. <code>str</code>, <code>int</code>, <code>tuple</code>), while values can be any Python object. Lookup time is nearly instant ($O(1)$ on average):</p>

${ex(P`# Laboratory apparatus specifications dictionary
apparatus = {
    'name': 'Michelson Interferometer',
    'laser': 'He-Ne',
    'wavelength_nm': 632.8,
    'mirrors': 2,
    'calibrated': True
}

# Accessing and modifying
apparatus['beam_splitter'] = '50:50 Cube'     # Add new key-value pair
apparatus['calibrated'] = False               # Update existing key

# Safe retrieval with default fallback
loc = apparatus.get('room', 'General Optics Lab')

print("Apparatus:", apparatus['name'])
print("Laser:    ", apparatus.get('laser'))
print("Location: ", loc)
print("\nIterating through dictionary items:")
for key, val in apparatus.items():
    print(f"  {key:<15} : {val}")`,
{title:'Dictionary Key-Value Operations',
out:`Apparatus: Michelson Interferometer
Laser:     He-Ne
Location:  General Optics Lab

Iterating through dictionary items:
  name            : Michelson Interferometer
  laser           : He-Ne
  wavelength_nm   : 632.8
  mirrors         : 2
  calibrated      : False
  beam_splitter   : 50:50 Cube`})}

${tp('The input() Function and Type Casting')}
<p>The built-in <code>input([prompt])</code> function pauses execution and reads a line of text entered from the console. In Python 3, <b><code>input()</code> always returns a string (<code>str</code>)</b>. To perform mathematical calculations, it must be explicitly type-cast:</p>

${ex(P`# Simulating user input conversion
raw_mass = "2.5"        # as returned by input("Enter mass (kg): ")
raw_trials = "10"       # as returned by input("Enter trials: ")

# Explicit type conversion
mass = float(raw_mass)
trials = int(raw_trials)

weight = mass * 9.81
print(f"Mass: {mass} kg | Weight: {weight:.2f} N | Total trials: {trials}")`,
{title:'Type Casting Console Input',
out:`Mass: 2.5 kg | Weight: 24.52 N | Total trials: 10`})}

${fill('Collections Syntax and Creation',
P`To create an empty set, use [[set()]]
To create an empty dictionary, use [[{}]]
Single item tuple is written as [[ (5,) |(5,) ]]
In Python, dictionary keys must be [[immutable]] objects.`,{code:true})}

${match('Collection Properties Comparison',[
  ['List','Ordered, mutable, allows duplicate items'],
  ['Tuple','Ordered, immutable, allows duplicate items'],
  ['Set','Unordered, mutable, unique elements only'],
  ['Dictionary','Key-value mapping, keys must be hashable'],
  ['set()','Creates empty set (never use empty braces)']
])}

${parsons('Aggregate trials into a dictionary',[
  'trials = [("trial1", 9.81), ("trial2", 9.79), ("trial3", 9.83)]',
  'exp_data = {}',
  'for name, val in trials:',
  '    exp_data[name] = val',
  'print("Recorded:", exp_data)'
])}

${predict('Predict Output: Dictionary Mutation & Sets',
P`d = {'a': 1, 'b': 2}
d['c'] = 3
s = set([1, 2, 2, 3, 3, 3])
print(len(d), len(s))`,
['3 6', '3 3', '2 3', '3 1'],
'3 3',
'Dictionary d has 3 keys (a, b, c). Set eliminates duplicates from [1, 2, 2, 3, 3, 3], leaving {1, 2, 3} with length 3.',
'3 3')}

${cards('Collections Active Recall',[
  {q:'Why can a list not be used as a dictionary key in Python?',a:'Dictionary keys must be hashable (immutable). Because lists are mutable, their hash value can change, which would break the internal hash table.'},
  {q:'What does the set intersection operator & do?',a:'It returns a new set containing only elements that exist in both sets.'},
  {q:'What happens if you look up a missing key with d[key] vs d.get(key)?',a:'d[key] raises a KeyError if the key does not exist; d.get(key) returns None (or a specified default) without raising an error.'},
  {q:'How do you represent a single-element tuple with the number 7?',a:'(7,) with a mandatory trailing comma.'},
  {q:'What is the return type of input("Enter value: ")?',a:'str (string); it must be explicitly cast using float() or int() for arithmetic.'},
  {q:'What is the difference between s.discard(x) and s.remove(x) for a set?',a:'s.remove(x) raises a KeyError if x is not present; s.discard(x) silently does nothing.'}
])}

${omr('Unit Test · Tuples, Sets & Dictionaries',[
  {q:'Which of the following creates a tuple with a single element 5?',o:['t = (5)','t = tuple(5)','t = (5,)','t = [5,]'],a:2,why:'(5,) with a trailing comma denotes a single-element tuple.'},
  {q:'What is the type of variable x = {}?',o:['set','dict','tuple','list'],a:1,why:'Empty curly braces {} create a dictionary. Use set() for an empty set.'},
  {q:'Given s = {1, 2, 3} and t = {3, 4, 5}, what is s & t?',o:['{1, 2, 3, 4, 5}','{3}','{1, 2}','{4, 5}'],a:1,why:'The & operator calculates the set intersection: {3}.'},
  {q:'Which method retrieves a dictionary value without risking a KeyError?',o:['d.popkey()','d.fetch()','d.get()','d.find()'],a:2,why:'d.get(key, default) safely returns the value or default if key is absent.'},
  {q:'Which of the following can be used as a valid dictionary key?',o:['[1, 2, 3]','{1, 2}','(10, 20)','{"a": 1}'],a:2,why:'Tuples are immutable and hashable, making them valid dictionary keys.'}
])}
`});

/* ───────────── Control Flow & File Operations ───────────── */
STATIONS.push({id:'m1-control',title:'Control Flow & File Operations',short:'Control Flow & File Operations',est:'~45 min',body:H`
${gist('Direct program execution using branches and loops, and stream physics data to disk safely with context managers.')}

${tp('Conditional Statements: if, elif, else')}
<p>Python uses standard conditional branching. Blocks are defined strictly by <b>indentation</b> (4 spaces standard). Conditions evaluate truth values using logical operators <code>and</code>, <code>or</code>, and <code>not</code>:</p>

${ex(P`# Temperature safety monitoring in a cryogenic experiment
temp_kelvin = 72.4

if temp_kelvin < 77.0:
    status = "Superconducting regime: Liquid Nitrogen cold"
elif 77.0 <= temp_kelvin <= 150.0:
    status = "Transition warning: Approaching critical temperature"
else:
    status = "Critical alarm: System quenched!"

print(f"Temperature: {temp_kelvin} K")
print(f"Status: {status}")`,
{title:'Conditional Branching with Indentation',
out:`Temperature: 72.4 K
Status: Superconducting regime: Liquid Nitrogen cold`})}

${tp('Loops: for and while')}
<p>Python provides two loop constructs:</p>
<ul style="padding-left:1.2rem;line-height:1.65">
  <li><b><code>for</code> loop:</b> Iterates over members of any sequence (lists, tuples, strings, ranges).</li>
  <li><b><code>while</code> loop:</b> Repeats code as long as a Boolean condition remains <code>True</code>.</li>
</ul>

<p>The built-in <b><code>range(start, stop, step)</code></b> function generates an arithmetic sequence. <b>Important:</b> The <code>stop</code> boundary is always excluded.</p>

${tp('Jump Statements: break, continue, pass')}
<p>Loop execution can be controlled using jump keywords:</p>
<div class="scroll-x"><table class="ref">
  <tr><th>Keyword</th><th>Action</th><th>Physics Sensor Application</th></tr>
  <tr><td><b><code>break</code></b></td><td>Exits the enclosing loop immediately</td><td>Halt acquisition on emergency cutoff code or safety trip</td></tr>
  <tr><td><b><code>continue</code></b></td><td>Skips remainder of current iteration and moves to next</td><td>Skip corrupted noise packets (e.g. <code>-999.0</code>)</td></tr>
  <tr><td><b><code>pass</code></b></td><td>Null statement; does nothing (placeholder)</td><td>Define empty stub blocks during program architecture</td></tr>
</table></div>

${ex(P`# Lab sensor reading filtering
readings = [12.4, 12.8, -999.0, 13.1, -999.0, 12.9, 9999.0, 13.5]
valid = []

for r in readings:
    if r == -999.0:
        continue     # Corrupted sensor read: skip to next
    if r == 9999.0:
        break        # Over-voltage spike: emergency halt
    valid.append(r)

print("Raw readings:  ", readings)
print("Valid readings:", valid)
print(f"Mean voltage:  {sum(valid) / len(valid):.2f} V")`,
{title:'Sensor Noise Filtering with break and continue',
out:`Raw readings:   [12.4, 12.8, -999.0, 13.1, -999.0, 12.9, 9999.0, 13.5]
Valid readings: [12.4, 12.8, 13.1, 12.9]
Mean voltage:   12.80 V`})}

${tp('File Operations: open(), read(), write() and Context Managers')}
<p>File input/output in Python is initiated with <code>open(filename, mode)</code>:</p>
<div class="scroll-x"><table class="ref">
  <tr><th>Mode</th><th>Description</th><th>Behavior if File Exists</th></tr>
  <tr><td><code>'r'</code></td><td>Read only (default)</td><td>Starts at file beginning; errors if file not found</td></tr>
  <tr><td><code>'w'</code></td><td>Write only</td><td><b>Overwrites / truncates</b> existing file to 0 bytes!</td></tr>
  <tr><td><code>'a'</code></td><td>Append only</td><td>Writes appended to the end; creates file if missing</td></tr>
  <tr><td><code>'r+'</code></td><td>Read and write</td><td>Does not truncate; stream starts at beginning</td></tr>
</table></div>

${must(H`Always handle files using the <b><code>with open(...) as f:</code></b> context manager. It guarantees that the file stream is flushed and closed automatically, even if an unhandled exception or power failure occurs during reading or writing.`)}

${ex(P`# Writing and reading physics experiment data using context manager
filename = 'sensor_data.csv'

# Step 1: Writing data
with open(filename, 'w') as f:
    f.write("Time_s,Current_mA\n")
    f.write("0.0,0.00\n")
    f.write("0.5,1.24\n")
    f.write("1.0,2.48\n")

# Step 2: Reading lines back
lines = []
with open(filename, 'r') as f:
    for line in f:
        lines.append(line.strip())

print(f"Successfully read {len(lines)} lines from {filename}:")
for row in lines:
    print("  ", row)`,
{title:'Safe File I/O with Context Manager',
out:`Successfully read 4 lines from sensor_data.csv:
   Time_s,Current_mA
   0.0,0.00
   0.5,1.24
   1.0,2.48`})}

${fill('Control Flow and File I/O',
P`To terminate a loop early, use [[break]]
To skip to the next iteration of a loop, use [[continue]]
The file mode to append without overwriting is [['a']]
The statement that ensures files are closed automatically is [[with]]`,{code:true})}

${match('File Modes and Loop Statements',[
  ['\'w\'','Open for writing, truncating existing content'],
  ['\'a\'','Open for appending at the end of the file'],
  ['break','Exits the loop immediately'],
  ['continue','Skips remaining statements in current loop iteration'],
  ['range(1, 10, 2)','Generates 1, 3, 5, 7, 9']
])}

${parsons('Read file and compute average of values',[
  'total, count = 0.0, 0',
  'with open("voltages.txt", "r") as f:',
  '    for line in f:',
  '        val = float(line.strip())',
  '        total += val',
  '        count += 1',
  'avg = total / count if count > 0 else 0',
  'print(f"Average: {avg:.2f}")'
])}

${predict('Predict Output: Loop with continue and range',
P`sum_vals = 0
for i in range(1, 8):
    if i % 2 == 0:
        continue
    sum_vals += i
print(sum_vals)`,
['12', '16', '28', '9'],
'16',
'range(1, 8) produces numbers 1 to 7. Even numbers (2, 4, 6) are skipped by continue. Sum of odds is 1 + 3 + 5 + 7 = 16.',
'16')}

${cards('Control Flow & Files Active Recall',[
  {q:'What happens if you open an existing file in "w" mode?',a:'The existing file content is immediately erased (truncated to 0 bytes) and replaced with new writes.'},
  {q:'What is the advantage of with open(...) as f over f = open(...)?',a:'The with context manager automatically calls f.close() upon exiting the block, preventing resource leaks even if errors occur.'},
  {q:'What sequence does range(2, 10, 3) generate?',a:'2, 5, 8 (stop value 10 is excluded).'},
  {q:'What does the strip() string method do when reading lines from a file?',a:'It removes leading and trailing whitespace, including newline characters (\n) and carriage returns (\r).'},
  {q:'Can a loop have an else block in Python?',a:'Yes! The else block executes only if the loop terminates normally without encountering a break statement.'},
  {q:'What does the pass keyword do?',a:'It is a syntactic placeholder that performs no operation (a no-op).'}
])}

${omr('Unit Test · Control Flow & File Operations',[
  {q:'What are the generated values of list(range(2, 9, 2))?',o:['[2, 4, 6, 8, 9]','[2, 4, 6, 8]','[4, 6, 8]','[2, 5, 8]'],a:1,why:'Starts at 2, increments by 2, stops strictly before 9: [2, 4, 6, 8].'},
  {q:'Which file mode allows reading and writing without erasing the file?',o:['\'w\'','\'r+\'','\'w+\'','\'a\''],a:1,why:'\'r+\' opens for reading and writing without truncation.'},
  {q:'Which statement causes a loop to skip the rest of the current iteration?',o:['break','exit','continue','pass'],a:2,why:'continue skips straight to the next loop iteration.'},
  {q:'When does the else clause of a for loop NOT execute?',o:['When the sequence is empty','When a break statement is executed','When continue is executed','It always executes'],a:1,why:'If a loop is terminated via break, the else clause is skipped.'},
  {q:'Which method reads all remaining lines from a file into a Python list?',o:['f.readall()','f.read()','f.readlines()','f.getlines()'],a:2,why:'f.readlines() returns a list of string lines from the file.'}
])}
`});

/* ───────────── Functions & Scope ───────────── */
STATIONS.push({id:'m1-functions',title:'Functions & Scope',short:'Functions & Scope',est:'~40 min',body:H`
${gist('Write reusable, modular functions with positional arguments, default values, docstrings, and clean variable scopes.')}

${tp('Defining Functions and Passing Arguments')}
<p>Functions are defined using the <code>def</code> keyword. Functions can accept arguments and return values using the <code>return</code> statement. If no return statement is executed, the function returns <code>None</code>.</p>

${ex(P`# Calculate kinetic energy: KE = 0.5 * m * v^2
def kinetic_energy(mass, velocity):
    """
    Computes relativistic-free kinetic energy in Joules.
    mass: Mass in kg (float)
    velocity: Speed in m/s (float)
    """
    if mass < 0:
        raise ValueError("Mass cannot be negative!")
    return 0.5 * mass * (velocity ** 2)

# Calling with positional and keyword arguments
ke1 = kinetic_energy(2.0, 10.0)
ke2 = kinetic_energy(velocity=15.0, mass=1.5)

print(f"KE (m=2kg, v=10m/s)  : {ke1:.1f} J")
print(f"KE (m=1.5kg, v=15m/s): {ke2:.1f} J")`,
{title:'Function Definition with Docstring and Validation',
out:`KE (m=2kg, v=10m/s)  : 100.0 J
KE (m=1.5kg, v=15m/s): 168.8 J`})}

${tp('Default Parameters and Variable-Length Arguments')}
<p>Functions can define default parameter values. Default arguments must always follow positional arguments without defaults:</p>

${ex(P`# Gravitational potential energy with default acceleration g
def potential_energy(mass, height, g=9.81):
    return mass * g * height

print("On Earth (g=9.81 m/s^2):", potential_energy(5.0, 10.0))
print("On Moon  (g=1.62 m/s^2):", potential_energy(5.0, 10.0, g=1.62))`,
{title:'Default Argument Values',
out:`On Earth (g=9.81 m/s^2): 490.5
On Moon  (g=1.62 m/s^2): 81.0`})}

${trap(H`Never use a mutable object (like a list or dict) as a default parameter! For example, <code>def record(val, trials=[])</code> shares the exact same list across all calls. Use <code>trials=None</code> and set <code>if trials is None: trials = []</code> inside the function.`)}

${tp('Variable Scope: Local vs Global')}
<p>Variables declared inside a function have <b>local scope</b> and cannot be accessed outside. Variables defined outside have <b>global scope</b>. To modify a global variable inside a function, the <code>global</code> statement must be used:</p>

${ex(P`counter = 0     # Global variable

def record_trial():
    global counter
    counter += 1
    local_val = 9.81
    return f"Trial #{counter} recorded with val={local_val}"

print(record_trial())
print(record_trial())
print("Final global count:", counter)`,
{title:'Local vs Global Scope and the global Keyword',
out:`Trial #1 recorded with val=9.81
Trial #2 recorded with val=9.81
Final global count: 2`})}

${tp('Syllabus Hands-on Problem: Min & Max Function')}
${must(H`<b>Syllabus Hands-on Task 1:</b> Write a function that accepts a list of numbers and returns both the largest and smallest numbers in the list without using Python’s built-in <code>min()</code> or <code>max()</code> functions.`)}

${ex(P`def find_min_max(numbers):
    """
    Accepts a list of numbers and returns a tuple (smallest, largest).
    Implements manual linear scan satisfying Calicut University syllabus.
    """
    if not numbers:
        return (None, None)
    
    smallest = numbers[0]
    largest = numbers[0]
    
    for num in numbers[1:]:
        if num < smallest:
            smallest = num
        elif num > largest:
            largest = num
            
    return (smallest, largest)

# Test with lab observations
voltages = [15.2, 8.4, 22.1, 19.6, 5.7, 14.3]
lo, hi = find_min_max(voltages)

print("Observed voltages:", voltages)
print(f"Minimum voltage  : {lo} V")
print(f"Maximum voltage  : {hi} V")
print(f"Voltage spread   : {hi - lo:.1f} V")`,
{title:'Syllabus Hands-on: Finding Min and Max Manually',
out:`Observed voltages: [15.2, 8.4, 22.1, 19.6, 5.7, 14.3]
Minimum voltage  : 5.7 V
Maximum voltage  : 22.1 V
Voltage spread   : 16.4 V`})}

${fill('Functions Syntax and Behavior',
P`Functions are defined using the [[def]] keyword.
Documentation strings inside functions are called [[docstrings]].
To return multiple values, Python packages them as a [[tuple]].
To modify a variable from the outer module inside a function, use the [[global]] keyword.`,{code:true})}

${match('Function Terminology and Concepts',[
  ['def','Keyword used to define a new function'],
  ['return','Exits function and sends value back to caller'],
  ['docstring','Triple-quoted explanatory string inside function header'],
  ['global','Declares that a variable inside function refers to module scope'],
  ['*args','Accepts arbitrary number of positional arguments']
])}

${parsons('Assemble the syllabus hands-on min/max function',[
  'def find_min_max(numbers):',
  '    if not numbers: return None, None',
  '    lo, hi = numbers[0], numbers[0]',
  '    for n in numbers[1:]:',
  '        if n < lo: lo = n',
  '        elif n > hi: hi = n',
  '    return lo, hi'
])}

${predict('Predict Output: Function Scope & Default Arguments',
P`x = 10
def modify(val, mult=2):
    x = val * mult
    return x

res = modify(5)
print(x, res)`,
['10 10', '10 5', '20 10', '10 20'],
'10 10',
'The assignment x = val * mult modifies the local variable x, leaving the global x unchanged at 10. modify(5) returns 5 * 2 = 10.',
'10 10')}

${cards('Functions & Scope Active Recall',[
  {q:'What does a Python function return if it contains no return statement?',a:'It returns None implicitly.'},
  {q:'Why should you never use def func(lst=[])?',a:'Default arguments are evaluated once when the function is defined. A mutable default list is shared across all calls, causing unexpected state accumulation.'},
  {q:'How does Python return multiple values from a function?',a:'By packing the values into a single tuple (e.g. return a, b), which can then be unpacked by the caller (x, y = func()).'},
  {q:'What is the LEGB rule for variable resolution in Python?',a:'Local -> Enclosing -> Global -> Built-in.'},
  {q:'What is the difference between *args and **kwargs?',a:'*args collects positional arguments into a tuple; **kwargs collects keyword arguments into a dictionary.'},
  {q:'How do you access a function’s docstring programmatically?',a:'Using the __doc__ attribute (e.g., func.__doc__) or help(func).'}
])}

${omr('Unit Test · Functions & Scope',[
  {q:'Which keyword introduces a function definition in Python?',o:['function','def','fun','lambda'],a:1,why:'def introduces function definitions in Python.'},
  {q:'What will function f(x, y=5) return for call f(3)?',o:['8','15','Error: missing y','None'],a:1,why:'x receives 3 and y takes its default 5.'},
  {q:'What is the scope of a variable created inside a function?',o:['Global','Universal','Local','Module-level'],a:2,why:'Variables assigned inside a function body belong to its local namespace.'},
  {q:'How can a function modify a global variable without passing it as an argument?',o:['Using nonlocal keyword','Using global keyword','Using export keyword','It is impossible'],a:1,why:'The global keyword binds the identifier to the global namespace.'},
  {q:'What data structure does Python use to return multiple comma-separated items?',o:['List','Set','Tuple','Dictionary'],a:2,why:'Writing return a, b returns a tuple (a, b).'}
])}
`});

/* ───────────── NumPy Numerical Arrays ───────────── */
STATIONS.push({id:'m1-numpy',title:'NumPy Numerical Arrays',short:'NumPy Numerical Arrays',est:'~50 min',body:H`
${gist('High-performance scientific computing: homogeneous ndarray structures, vectorized equations, slicing, and matrix algebra.')}

${tp('Introduction to NumPy and ndarray')}
<p><b>NumPy</b> (Numerical Python) is the foundation of scientific and computational physics in Python. Standard Python lists store pointers to objects scattered across memory, causing severe overhead during loops. NumPy introduces the <b><code>ndarray</code></b> (N-dimensional array): a contiguous block of homogeneous memory executed by compiled C libraries:</p>

<div class="scroll-x"><table class="ref">
  <tr><th>Property</th><th>Python List</th><th>NumPy ndarray</th></tr>
  <tr><td><b>Element Types</b></td><td>Heterogeneous (any mixed types)</td><td><b>Homogeneous</b> (all elements share identical <code>dtype</code>)</td></tr>
  <tr><td><b>Memory Layout</b></td><td>Array of pointers (fragmented)</td><td><b>Contiguous memory block</b> (cache-optimized)</td></tr>
  <tr><td><b>Speed on Loops</b></td><td>Slow (interpreted bytecode loop)</td><td><b>Fast vectorization</b> at compiled C-speed</td></tr>
  <tr><td><b>Mathematical Operators</b></td><td>Concatenates (<code>[1] + [2] = [1, 2]</code>)</td><td>Vectorized math (<code>np.array([1]) + 2 = [3]</code>)</td></tr>
</table></div>

${tp('Array Creation Functions')}
<p>NumPy provides multiple dedicated constructors for generating arrays:</p>

<div class="scroll-x"><table class="ref">
  <tr><th>Function</th><th>Example Code</th><th>Physics Application</th></tr>
  <tr><td><code>np.array()</code></td><td><code>np.array([1.0, 2.0, 3.0])</code></td><td>Convert recorded laboratory data to vector</td></tr>
  <tr><td><code>np.zeros()</code></td><td><code>np.zeros((3, 3))</code></td><td>Pre-allocate simulation grid for magnetic/electric potential</td></tr>
  <tr><td><code>np.ones()</code></td><td><code>np.ones(100)</code></td><td>Uniform baseline field</td></tr>
  <tr><td><code>np.arange()</code></td><td><code>np.arange(0, 10, 0.5)</code></td><td>Stepped voltage ranges (excludes stop)</td></tr>
  <tr><td><code>np.linspace()</code></td><td><code>np.linspace(0, 1, 100)</code></td><td>Evenly spaced time grid for waveforms (includes stop)</td></tr>
  <tr><td><code>np.random.randint()</code></td><td><code>np.random.randint(1, 11, size=(3, 3))</code></td><td>Stochastic trials, Monte Carlo simulation</td></tr>
</table></div>

${must(H`<b>linspace vs arange:</b> <code>np.linspace(start, stop, num)</code> takes the total <i>count</i> of points and <b>includes</b> the stop value by default. <code>np.arange(start, stop, step)</code> takes the <i>step size</i> and <b>excludes</b> the stop value.`)}

${tp('Array Indexing, Slicing & Operations')}
<p>NumPy arrays support multi-dimensional indexing with comma-separated slices: <code>arr[row_slice, col_slice]</code>:</p>

${ex(P`import numpy as np

# Create 2D 3x3 matrix
M = np.array([
    [10, 20, 30],
    [40, 50, 60],
    [70, 80, 90]
])

print("Shape:", M.shape, "| Dimensions:", M.ndim, "| Total elements:", M.size)
print("Element at row 1, col 2:", M[1, 2])
print("First row:             ", M[0, :])
print("Second column:         ", M[:, 1])
print("Top-left 2x2 block:\n", M[0:2, 0:2])`,
{title:'2D Array Multi-Dimensional Slicing',
out:`Shape: (3, 3) | Dimensions: 2 | Total elements: 9
Element at row 1, col 2: 60
First row:              [10 20 30]
Second column:          [20 50 80]
Top-left 2x2 block:
 [[10 20]
 [40 50]]`})}

${tp('Vectorized Arithmetic vs Matrix Multiplication')}
<p>Standard arithmetic operators (<code>+</code>, <code>-</code>, <code>*</code>, <code>/</code>, <code>**</code>) operate <b>element-wise</b> on arrays. Linear algebraic matrix multiplication requires the <b><code>@</code></b> operator or <code>np.dot()</code>:</p>

${must(H`<b>Hadamard vs Matrix Product:</b> <code>A * B</code> performs element-wise multiplication ($C_{ij} = A_{ij} B_{ij}$). The matrix product ($C_{ij} = \sum_k A_{ik} B_{kj}$) is performed using <b><code>A @ B</code></b> or <code>np.dot(A, B)</code>.`)}

${tp('Syllabus Hands-on Problem: 3x3 Random Array Arithmetic')}
${must(H`<b>Syllabus Hands-on Task 2:</b> Create a 3x3 NumPy array with random integers between 1 and 10. Perform and print the results of basic arithmetic operations (addition, subtraction, multiplication, division) on this array with another 3x3 array.`)}

${ex(P`import numpy as np

# Set seed for reproducible textbook output
np.random.seed(42)

# 1. Create two 3x3 arrays with random integers from 1 to 10 (inclusive)
A = np.random.randint(1, 11, size=(3, 3))
B = np.random.randint(1, 11, size=(3, 3))

print("Array A:\n", A)
print("\nArray B:\n", B)

# 2. Basic arithmetic operations
print("\nAddition (A + B):\n", A + B)
print("\nSubtraction (A - B):\n", A - B)
print("\nElement-wise Multiplication (A * B):\n", A * B)
print("\nElement-wise Division (A / B rounded):\n", np.round(A / B, 2))

# 3. Matrix dot product
print("\nMatrix Product (A @ B):\n", A @ B)`,
{title:'Syllabus Hands-on: 3x3 Random Integer Matrix Arithmetic',
out:`Array A:
 [[ 7  4 10]
 [ 8  5  7]
 [ 3  7  8]]

Array B:
 [[ 5  4  8]
 [ 8  3  6]
 [ 5  2  8]]

Addition (A + B):
 [[12  8 18]
 [16  8 13]
 [ 8  9 15]]

Subtraction (A - B):
 [[ 2  0  2]
 [ 0  2  1]
 [-2  5  0]]

Element-wise Multiplication (A * B):
 [[35 16 80]
 [64 15 42]
 [15 14 56]]

Element-wise Division (A / B rounded):
 [[1.4  1.   1.25]
 [1.   1.67 1.17]
 [0.6  3.5  1.  ]]

Matrix Product (A @ B):
 [[117  60 160]
 [115  61 150]
 [111  49 130]]`})}

${fill('NumPy Array Fundamentals',
P`The primary array object in NumPy is the [[ndarray]].
Array dimensions are returned as a tuple by the [[shape]] attribute.
Matrix multiplication between arrays A and B is written with the [[@]] operator.
np.linspace(0, 10, 5) generates [[5]] points including 10.`,{code:true})}

${match('NumPy Functions and Attributes',[
  ['np.linspace(0, 1, 100)','Creates 100 evenly spaced points including 1.0'],
  ['np.arange(0, 10, 2)','Creates sequence 0, 2, 4, 6, 8 (excludes 10)'],
  ['A * B','Element-wise multiplication (Hadamard product)'],
  ['A @ B','Matrix dot product (linear algebra)'],
  ['arr.T','Matrix transpose']
])}

${parsons('Calculate kinetic energy array vectorially',[
  'import numpy as np',
  'mass = 0.5',
  'velocities = np.array([2.0, 4.0, 6.0, 8.0])',
  'ke_array = 0.5 * mass * (velocities ** 2)',
  'print("Kinetic energies:", ke_array)'
])}

${predict('Predict Output: NumPy Element-wise Arithmetic',
P`import numpy as np
a = np.array([1, 2, 3])
b = np.array([4, 5, 6])
print(a + b, a * 2)`,
['[5 7 9] [2 4 6]', '[1 2 3 4 5 6] [1 2 3 1 2 3]', '[5 7 9] [1 2 3 1 2 3]', '[5, 7, 9] [2, 4, 6]'],
'[5 7 9] [2 4 6]',
'NumPy operations are vectorized: a + b computes element-wise sum [5, 7, 9], and a * 2 multiplies each element [2, 4, 6].',
'[5 7 9] [2 4 6]')}

${cards('NumPy Active Recall',[
  {q:'Why are NumPy arrays faster than standard Python lists?',a:'They store elements contiguously in memory with uniform data types, avoiding pointer indirection and running vectorized operations in compiled C.'},
  {q:'What is the difference between arr.shape and arr.size?',a:'arr.shape is a tuple giving dimensions along each axis (e.g. (3, 4)); arr.size is the total number of elements (12).'},
  {q:'How do you calculate matrix multiplication between arrays A and B?',a:'Using the @ operator (A @ B) or np.dot(A, B).'},
  {q:'What does np.random.randint(1, 11, size=(3, 3)) produce?',a:'A 3x3 2D array of random integers between 1 and 10 inclusive.'},
  {q:'Does np.arange(0, 10, 2) include 10?',a:'No, the stop boundary in np.arange is strictly exclusive (generates [0, 2, 4, 6, 8]).'},
  {q:'What does the .T attribute of an ndarray compute?',a:'The transpose of the array (swapping rows and columns for a 2D matrix).'}
])}

${omr('Unit Test · NumPy Numerical Arrays',[
  {q:'Which of the following creates a 3x3 array filled with zeros?',o:['np.zeros((3, 3))','np.empty(3, 3)','np.zeros([3])','np.null(3, 3)'],a:0,why:'np.zeros((3, 3)) takes a shape tuple (3, 3).'},
  {q:'What is the operator for matrix multiplication in Python 3.5+ with NumPy?',o:['*','**','@','&'],a:2,why:'The @ operator is designated for matrix multiplication.'},
  {q:'For a 2D array M, what does M[:, 0] extract?',o:['The first row','The first column','The entire matrix','The diagonal elements'],a:1,why:': selects all rows, and 0 specifies the first column.'},
  {q:'Which function creates 50 evenly spaced values between 0.0 and 1.0 (inclusive)?',o:['np.arange(0, 1, 50)','np.linspace(0, 1, 50)','np.space(0, 1, 50)','np.step(0, 1, 50)'],a:1,why:'np.linspace(start, stop, num) includes the stop endpoint.'},
  {q:'What is the output of np.array([1, 2, 3]) * np.array([2, 2, 2])?',o:['[2, 4, 6]','array([2, 4, 6])','12','Error'],a:1,why:'The * operator performs element-wise multiplication.'}
])}
`});
