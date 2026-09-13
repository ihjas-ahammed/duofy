import 'package:flutter/material.dart';
import 'app_models.dart';

/// Represents an educational note callout (pitfall, why/intuition, or key formula).
class TreeNote {
  final String type; // 'pitfall', 'why', 'key'
  final String title;
  final String content;

  const TreeNote({
    required this.type,
    required this.title,
    required this.content,
  });
}

/// A rung in an interactive step ladder derivation.
class TreeRung {
  final String math;
  final String? why;

  const TreeRung({
    required this.math,
    this.why,
  });
}

/// An interactive derivation ladder with peek-and-reveal steps.
class TreeLadder {
  final String title;
  final List<TreeRung> rungs;

  const TreeLadder({
    required this.title,
    required this.rungs,
  });
}

/// An interactive self-check / checkpoint question.
class TreeCheck {
  final String id;
  final String question;
  final List<String>? options;
  final int? correctIndex;
  final String answerExplanation;

  const TreeCheck({
    required this.id,
    required this.question,
    this.options,
    this.correctIndex,
    required this.answerExplanation,
  });
}

/// A leaf topic in the dropdown hierarchy (Level 3).
class TreeTopic {
  final String id;
  final String title;
  final String? gist;
  final String contentMarkdown;
  final List<TreeNote> notes;
  final TreeLadder? ladder;
  final List<TreeCheck> checks;
  final String? codeSnippet;
  final String? codeLanguage;
  final String? diagramType; // 'unit_cell', 'miller_planes'

  const TreeTopic({
    required this.id,
    required this.title,
    this.gist,
    required this.contentMarkdown,
    this.notes = const [],
    this.ladder,
    this.checks = const [],
    this.codeSnippet,
    this.codeLanguage,
    this.diagramType,
  });
}

/// A section / unit in the dropdown hierarchy (Level 2).
class TreeSection {
  final String id;
  final String title;
  final String estimate;
  final List<TreeTopic> topics;

  const TreeSection({
    required this.id,
    required this.title,
    this.estimate = '~30 min',
    required this.topics,
  });
}

/// A module in the dropdown hierarchy (Level 1).
class TreeModule {
  final String id;
  final String title;
  final String subtitle;
  final List<TreeSection> sections;

  const TreeModule({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.sections,
  });
}

/// A complete course structured in the modern dropdown tree method.
class TreeCourse {
  final String id;
  final String title;
  final String subtitle;
  final String category; // 'python', 'latex', 'solid_state', 'course'
  final Color accentColor;
  final String? htmlAppPath;
  final List<TreeModule> modules;

  const TreeCourse({
    required this.id,
    required this.title,
    required this.subtitle,
    this.category = 'course',
    this.accentColor = const Color(0xFF306998),
    this.htmlAppPath,
    required this.modules,
  });

  /// Total leaf topics across all modules and sections.
  List<TreeTopic> get allTopics {
    final list = <TreeTopic>[];
    for (final m in modules) {
      for (final s in m.sections) {
        list.addAll(s.topics);
      }
    }
    return list;
  }

  /// Adapts ANY existing Duofy [Book] into the modern dropdown tree structure.
  factory TreeCourse.fromBook(Book book) {
    final titleLower = book.title.toLowerCase();
    if (titleLower.contains('solid state') || book.id.contains('solid_state')) {
      return TreeCourse.solidStateCourse;
    }
    if (titleLower.contains('latex') || book.id.contains('latex')) {
      return TreeCourse.latexCourse;
    }
    if (titleLower.contains('python') || book.id.contains('python')) {
      return TreeCourse.pythonCourse;
    }

    Color pickAccent() {
      // Pick accent based on first section color or default
      if (book.modules.isNotEmpty && book.modules.first.sections.isNotEmpty) {
        final secColor = book.modules.first.sections.first.color.toLowerCase();
        if (secColor.contains('blue') || secColor.contains('sky')) {
          return const Color(0xFF306998);
        }
        if (secColor.contains('green') || secColor.contains('emerald')) {
          return const Color(0xFF237A4A);
        }
        if (secColor.contains('purple') || secColor.contains('indigo')) {
          return const Color(0xFF7C3AED);
        }
        if (secColor.contains('gold') || secColor.contains('amber') || secColor.contains('orange')) {
          return const Color(0xFFCC8800);
        }
        if (secColor.contains('red') || secColor.contains('rose')) {
          return const Color(0xFFCC3333);
        }
      }
      return const Color(0xFF306998);
    }

    final treeModules = <TreeModule>[];

    for (var mIdx = 0; mIdx < book.modules.length; mIdx++) {
      final mod = book.modules[mIdx];
      final treeSections = <TreeSection>[];

      for (var sIdx = 0; sIdx < mod.sections.length; sIdx++) {
        final sec = mod.sections[sIdx];
        final treeTopics = <TreeTopic>[];

        for (var uIdx = 0; uIdx < sec.units.length; uIdx++) {
          final unit = sec.units[uIdx];

          if (unit.lessons.isEmpty) {
            treeTopics.add(
              TreeTopic(
                id: '${unit.id}_top',
                title: unit.title.isNotEmpty ? unit.title : 'Unit ${uIdx + 1}',
                gist: unit.description.isNotEmpty ? unit.description : null,
                contentMarkdown: unit.description.isNotEmpty
                    ? unit.description
                    : 'Study and review materials for ${unit.title}.',
              ),
            );
          } else {
            for (var lIdx = 0; lIdx < unit.lessons.length; lIdx++) {
              final lesson = unit.lessons[lIdx];
              final notes = <TreeNote>[];
              final checks = <TreeCheck>[];
              TreeLadder? ladder;
              String? codeSnippet;
              String? codeLang;
              final markdownBuffer = StringBuffer();
              String? topicGist;

              if (lesson.description.isNotEmpty) {
                topicGist = lesson.description;
              }

              for (final slide in lesson.slides) {
                final type = slide.type.toLowerCase();
                if (type == 'theory' || type == 'concept_pieces' || type == 'descriptive') {
                  if (topicGist == null && slide.content.isNotEmpty) {
                    final firstPeriod = slide.content.indexOf('. ');
                    if (firstPeriod > 0 && firstPeriod < 160) {
                      topicGist = slide.content.substring(0, firstPeriod + 1);
                    }
                  }
                  if (markdownBuffer.isNotEmpty) markdownBuffer.writeln('\n\n');
                  if (slide.title.isNotEmpty && slide.title != lesson.title) {
                    markdownBuffer.writeln('### ${slide.title}\n');
                  }
                  markdownBuffer.writeln(slide.content);
                } else if (type == 'proof' || type == 'step_by_step') {
                  final steps = slide.interactiveSteps;
                  if (steps != null && steps.isNotEmpty) {
                    final rungs = steps.map((step) {
                      return TreeRung(
                        math: step.stepText ?? step.prompt ?? '',
                        why: step.prompt != null && step.prompt != step.stepText
                            ? step.prompt
                            : null,
                      );
                    }).toList();
                    ladder = TreeLadder(
                      title: slide.title.isNotEmpty ? slide.title : 'Step-by-step Derivation',
                      rungs: rungs,
                    );
                  }
                } else if (type == 'quiz') {
                  final opts = slide.options;
                  if (opts != null && opts.isNotEmpty) {
                    checks.add(
                      TreeCheck(
                        id: slide.id,
                        question: slide.content.isNotEmpty ? slide.content : slide.title,
                        options: opts.map((o) => o.text).toList(),
                        correctIndex: opts.indexWhere((o) => o.isCorrect),
                        answerExplanation: opts
                            .firstWhere(
                              (o) => o.isCorrect,
                              orElse: () => opts.first,
                            )
                            .explanation,
                      ),
                    );
                  }
                } else if (type == 'numerical') {
                  checks.add(
                    TreeCheck(
                      id: slide.id,
                      question: slide.content,
                      answerExplanation: 'Numerical Answer: \${slide.numericAnswer ?? "Check question details"}',
                    ),
                  );
                } else if (type == 'fill_in_blank' || type == 'one_word') {
                  checks.add(
                    TreeCheck(
                      id: slide.id,
                      question: slide.content,
                      answerExplanation: 'Correct term: \${slide.blankAnswer ?? "Answer provided"}',
                    ),
                  );
                } else if (type == 'code_runner' || type == 'program') {
                  codeSnippet = slide.content;
                  codeLang = 'python';
                }
              }

              if (markdownBuffer.isEmpty) {
                markdownBuffer.writeln(lesson.description.isNotEmpty
                    ? lesson.description
                    : 'Topic overview for \${lesson.title}.');
              }

              treeTopics.add(
                TreeTopic(
                  id: lesson.id,
                  title: lesson.title,
                  gist: topicGist,
                  contentMarkdown: markdownBuffer.toString(),
                  notes: notes,
                  ladder: ladder,
                  checks: checks,
                  codeSnippet: codeSnippet,
                  codeLanguage: codeLang,
                ),
              );
            }
          }
        }

        if (treeTopics.isEmpty) {
          treeTopics.add(
            TreeTopic(
              id: '\${sec.id}_summary',
              title: sec.title,
              gist: sec.description,
              contentMarkdown: sec.description.isNotEmpty
                  ? sec.description
                  : 'Detailed notes and exercises for ${sec.title}.',
            ),
          );
        }

        treeSections.add(
          TreeSection(
            id: sec.id,
            title: sec.title,
            estimate: '~${treeTopics.length * 8 + 10} min',
            topics: treeTopics,
          ),
        );
      }

      treeModules.add(
        TreeModule(
          id: mod.id,
          title: mod.title,
          subtitle: mod.description.isNotEmpty
              ? mod.description
              : 'Module \${mIdx + 1} curriculum and practice',
          sections: treeSections,
        ),
      );
    }

    return TreeCourse(
      id: book.id,
      title: book.title,
      subtitle: book.description,
      category: 'course',
      accentColor: pickAccent(),
      modules: treeModules,
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // Built-in STEM Reading Materials Uploaded to docs/apps
  // ══════════════════════════════════════════════════════════════════════════

  /// Python for Data Analysis (Modules I & II) from docs/apps/PYTHON_12.html
  static TreeCourse get pythonCourse {
    return const TreeCourse(
      id: 'doc_python_12',
      title: 'Python for Data Analysis',
      subtitle: 'Modules I & II · Core Python, NumPy & Pandas',
      category: 'python',
      accentColor: Color(0xFF306998),
      htmlAppPath: 'docs/apps/PYTHON_12.html',
      modules: [
        TreeModule(
          id: 'py_mod_0',
          title: 'Start Here',
          subtitle: 'Course orientation · How this app works',
          sections: [
            TreeSection(
              id: 'py_start',
              title: 'Orientation & Roadmap',
              estimate: '~10 min',
              topics: [
                TreeTopic(
                  id: 'py_start_t0',
                  title: 'How to Study Python Interactively',
                  gist: 'Read concise theory, inspect executable code examples, and practice instant retrieval before moving to the next block.',
                  contentMarkdown: '''
Welcome to **Python for Data Analysis**! This course is structured around progressive interactive mastery.

### Core Study Workflow
1. **The Gist**: Every section begins with a single-line summary capture.
2. **Code Examples**: Real, syntax-highlighted snippets designed for scientific computing and data wrangling.
3. **Common Traps**: Watch out for Python pitfalls (e.g. mutable default arguments, reference aliasing, slicing boundaries).
4. **Self-Check Questions**: Test your understanding immediately. Select your confidence, then verify the model answer.
''',
                  notes: [
                    TreeNote(
                      type: 'key',
                      title: 'STUDY HABIT',
                      content: 'Type out code snippets in an editor or the integrated IDE instead of passively reading. Physical muscle memory prevents syntax bugs.',
                    ),
                  ],
                  checks: [
                    TreeCheck(
                      id: 'py_chk_0_1',
                      question: 'What is the primary difference between a list assignment `b = a` and `b = a.copy()` in Python?',
                      options: [
                        'No difference, both create copies',
                        'b = a creates an alias referencing the same list; b = a.copy() creates a new independent list',
                        'b = a only copies integers',
                        'b = a.copy() creates a tuple',
                      ],
                      correctIndex: 1,
                      answerExplanation: 'In Python, assignment binds a reference. `b = a` points to the exact same list in memory. `b = a.copy()` produces a shallow copy with separate identity.',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        TreeModule(
          id: 'py_mod_1',
          title: 'Module I: Python Core & NumPy',
          subtitle: 'Variables, collections, functions & multidimensional arrays',
          sections: [
            TreeSection(
              id: 'py_m1_types',
              title: 'Variables, Types & Lists',
              estimate: '~35 min',
              topics: [
                TreeTopic(
                  id: 'py_m1_types_t0',
                  title: 'Variables and Dynamic Typing',
                  gist: 'Python variables are dynamically typed references bound to objects in heap memory.',
                  contentMarkdown: '''
In Python, variables do not require explicit type declarations. A variable is created the moment a value is assigned to it using `=`. Python inspects the value and assigns its type dynamically at runtime.

```python
x = 42          # int
pi = 3.14159    # float
name = "Duofy"  # str
z = 3.0 + 4.0j  # complex
```

Variables are case-sensitive (`Temp` != `temp`) and cannot use reserved keywords like `def`, `class`, `for`, `lambda`.
''',
                  codeSnippet: '''# Dynamic typing inspection
val = 100
print(type(val), id(val))

val = "Now a string"
print(type(val), id(val))''',
                  codeLanguage: 'python',
                  notes: [
                    TreeNote(
                      type: 'pitfall',
                      title: 'BITWISE XOR VS EXPONENTIATION',
                      content: 'Do NOT use `^` for power! `2 ^ 3` is bitwise XOR (result: 1). Use `2 ** 3` for exponentiation (result: 8).',
                    ),
                  ],
                  checks: [
                    TreeCheck(
                      id: 'py_chk_1_1',
                      question: 'What is the type and value of `7 // 2` in Python 3?',
                      options: ['float: 3.5', 'int: 3', 'int: 4', 'float: 3.0'],
                      correctIndex: 1,
                      answerExplanation: '`//` is floor division. It truncates fractional parts and returns `int: 3`. Regular `/` returns float `3.5`.',
                    ),
                  ],
                ),
                TreeTopic(
                  id: 'py_m1_types_t1',
                  title: 'Lists and Sequence Slicing',
                  gist: 'Lists are mutable, zero-indexed sequences supporting slicing [start:stop:step].',
                  contentMarkdown: '''
A **list** is an ordered, mutable sequence defined with square brackets `[ ... ]`.

### Slicing Formula
`sequence[start : stop : step]`
- `start` is included
- `stop` is excluded
- `step` defaults to 1

Reversing a list in-place is `a.reverse()`, while reversing via slicing is `a[::-1]`.
''',
                  codeSnippet: '''readings = [10.5, 20.0, 31.5, 42.0, 55.0]
print("First:", readings[0])
print("Last:", readings[-1])
print("Slice [1:3]:", readings[1:3])
print("Reversed:", readings[::-1])''',
                  codeLanguage: 'python',
                  checks: [
                    TreeCheck(
                      id: 'py_chk_1_2',
                      question: 'Given `data = [10, 20, 30, 40, 50]`, what does `data[1:4:2]` evaluate to?',
                      options: ['[20, 40]', '[10, 30]', '[20, 30, 40]', '[10, 30, 50]'],
                      correctIndex: 0,
                      answerExplanation: 'Indices 1 (`20`) through 4-exclusive with step 2 takes indices 1 and 3, which are `20` and `40`.',
                    ),
                  ],
                ),
              ],
            ),
            TreeSection(
              id: 'py_m1_numpy',
              title: 'NumPy Numerical Arrays',
              estimate: '~50 min',
              topics: [
                TreeTopic(
                  id: 'py_m1_numpy_t0',
                  title: 'NumPy ndarray and Vectorized Operations',
                  gist: 'NumPy ndarrays store homogeneous contiguous memory blocks, enabling orders-of-magnitude faster vectorized math without Python for-loops.',
                  contentMarkdown: '''
NumPy is the cornerstone of scientific computing in Python. Standard Python lists store pointers to heap objects; NumPy's `ndarray` stores dense contiguous memory buffers.

### Vectorization
Instead of writing explicit loops:
```python
import numpy as np

# Python loop: slow
# res = [x * 2 for x in data]

# NumPy vectorized: C-speed
data = np.array([1.0, 2.0, 3.0, 4.0])
res = data * 2.0
```

### Key Array Constructors
- `np.zeros((rows, cols))`
- `np.ones((rows, cols))`
- `np.linspace(start, stop, num_points)`
- `np.arange(start, stop, step)`
''',
                  codeSnippet: '''import numpy as np

# Sine wave generation
t = np.linspace(0, 2 * np.pi, 100)
y = np.sin(t)

print("Shape:", y.shape)
print("Mean amplitude:", np.mean(np.abs(y)))''',
                  codeLanguage: 'python',
                  notes: [
                    TreeNote(
                      type: 'key',
                      title: 'BROADCASTING RULE',
                      content: 'Two dimensions are compatible when they are equal, or when one of them is 1. This allows adding a (1, 3) vector to a (4, 3) matrix without manual copying.',
                    ),
                  ],
                  checks: [
                    TreeCheck(
                      id: 'py_chk_numpy_1',
                      question: 'What is the output shape of adding arrays with shapes `(4, 1)` and `(1, 5)`?',
                      options: ['(4, 1)', '(1, 5)', '(4, 5)', 'ValueError'],
                      correctIndex: 2,
                      answerExplanation: 'By NumPy broadcasting, dimension 1 expands to 5, and dimension 1 in the second expands to 4, resulting in shape `(4, 5)`.',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        TreeModule(
          id: 'py_mod_2',
          title: 'Module II: Pandas DataFrames & Analysis',
          subtitle: 'Tabular data wrangling, missing data, statistics & groupby',
          sections: [
            TreeSection(
              id: 'py_m2_dataframe',
              title: 'DataFrame Creation & Inspection',
              estimate: '~40 min',
              topics: [
                TreeTopic(
                  id: 'py_m2_df_t0',
                  title: 'Series vs DataFrame Architecture',
                  gist: 'A Series is a 1D labeled array; a DataFrame is a 2D labeled tabular structure where each column is a Series.',
                  contentMarkdown: '''
Pandas provides two foundational data structures:
1. **`Series`**: One-dimensional labeled array capable of holding any data type.
2. **`DataFrame`**: Two-dimensional size-mutable, potentially heterogeneous tabular data structure with labeled axes (rows and columns).

```python
import pandas as pd

df = pd.DataFrame({
    'experiment': ['Run1', 'Run2', 'Run3'],
    'voltage': [1.2, 2.4, 3.6],
    'current': [0.12, 0.25, 0.38]
})
```

### Essential Inspection Methods
- `df.head(n)`: First n rows
- `df.info()`: Column names, dtypes, non-null counts, memory usage
- `df.describe()`: Summary statistics (count, mean, std, min, 25%, 50%, 75%, max)
''',
                  codeSnippet: '''import pandas as pd

data = {'temp': [22.4, 25.1, 19.8, 23.0], 'pressure': [1013, 1010, 1015, 1012]}
df = pd.DataFrame(data)
print(df.describe())''',
                  codeLanguage: 'python',
                  checks: [
                    TreeCheck(
                      id: 'py_chk_df_1',
                      question: 'Which method returns the summary statistics (mean, std, percentiles) for numerical columns in a Pandas DataFrame?',
                      options: ['df.info()', 'df.summary()', 'df.describe()', 'df.stats()'],
                      correctIndex: 2,
                      answerExplanation: '`df.describe()` computes count, mean, std, min, IQR, and max for all numeric columns.',
                    ),
                  ],
                ),
              ],
            ),
            TreeSection(
              id: 'py_m2_wrangling',
              title: 'GroupBy & Aggregations',
              estimate: '~45 min',
              topics: [
                TreeTopic(
                  id: 'py_m2_groupby_t0',
                  title: 'The Split-Apply-Combine Strategy',
                  gist: 'df.groupby() splits the data into groups by key, applies aggregation/transform functions, and combines results into a new DataFrame.',
                  contentMarkdown: '''
The `groupby` operation follows the classic **Split-Apply-Combine** pattern:
1. **Split**: Partition the DataFrame into subsets based on distinct values in one or more grouping keys.
2. **Apply**: Compute an aggregation (e.g. `mean()`, `sum()`, `count()`) or transformation on each group independently.
3. **Combine**: Assemble individual group summaries into a single cohesive output.

```python
# Average voltage grouped by material category
df.groupby('material')['voltage'].mean()
```
''',
                  checks: [
                    TreeCheck(
                      id: 'py_chk_gb_1',
                      question: 'What does `df.groupby("category")["sales"].agg(["mean", "sum"])` produce?',
                      options: [
                        'A single scalar number',
                        'A DataFrame with both the mean and sum of sales computed per category',
                        'An error, agg only accepts one function',
                        'A list of tuples',
                      ],
                      correctIndex: 1,
                      answerExplanation: 'Passing a list of function names to `.agg()` produces a multi-column DataFrame with each aggregate statistic per group.',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// LaTeX Document Typesetting (Modules I & II) from docs/apps/LATEX_1.html
  static TreeCourse get latexCourse {
    return const TreeCourse(
      id: 'doc_latex_1',
      title: 'LaTeX & Document Typesetting',
      subtitle: 'Modules I & II · Structure, Math, Bibliographies & Tables',
      category: 'latex',
      accentColor: Color(0xFFB33928),
      htmlAppPath: 'docs/apps/LATEX_1.html',
      modules: [
        TreeModule(
          id: 'lx_mod_0',
          title: 'Start Here',
          subtitle: 'Introduction to document compilation and markup philosophy',
          sections: [
            TreeSection(
              id: 'lx_start',
              title: 'Orientation & Philosophy',
              estimate: '~8 min',
              topics: [
                TreeTopic(
                  id: 'lx_start_t0',
                  title: 'Why LaTeX? Content Separation from Presentation',
                  gist: 'Unlike WYSIWYG processors, LaTeX separates content structure from typographical typesetting, guaranteeing publication-grade mathematical layout.',
                  contentMarkdown: '''
LaTeX is a document preparation system based on Donald Knuth's TeX engine.
In Word or Google Docs, you format text visually as you type. In LaTeX, you describe document structure (`\\section`, `\\emph`, `\\begin{equation}`) and a compiler renders pixel-perfect typography.

### Anatomy of a Minimal LaTeX File
```latex
\\documentclass[12pt,a4paper]{article}
\\usepackage{amsmath}

\\begin{document}
\\title{My First Document}
\\author{Physics Scholar}
\\maketitle

\\section{Introduction}
Euler\'s identity is given by:
\\begin{equation}
e^{i\\pi} + 1 = 0
\\end{equation}
\\end{document}
```
''',
                  notes: [
                    TreeNote(
                      type: 'key',
                      title: 'PREAMBLE VS BODY',
                      content: 'Everything before `\\begin{document}` is the preamble (packages, macros, metadata). Everything between `\\begin{document}` and `\\end{document}` is the printable body.',
                    ),
                  ],
                  checks: [
                    TreeCheck(
                      id: 'lx_chk_0_1',
                      question: 'Where must `\\usepackage{...}` declarations be placed in a LaTeX file?',
                      options: [
                        'Anywhere in the file',
                        'In the preamble, before \\begin{document}',
                        'Inside \\begin{document}',
                        'At the end of the file',
                      ],
                      correctIndex: 1,
                      answerExplanation: 'All package imports and global settings must reside in the preamble before `\\begin{document}`.',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        TreeModule(
          id: 'lx_mod_1',
          title: 'Module I: Document Structures & Bibliographies',
          subtitle: 'Document classes, sectioning, citations & BibTeX',
          sections: [
            TreeSection(
              id: 'lx_m1_basics',
              title: 'Sectioning & Text Formatting',
              estimate: '~35 min',
              topics: [
                TreeTopic(
                  id: 'lx_m1_sec_t0',
                  title: 'Hierarchical Sectioning Commands',
                  gist: 'LaTeX provides built-in sectioning hierarchy that automatically manages numbering, font sizing, and table of contents entries.',
                  contentMarkdown: '''
LaTeX handles numbering and table of contents automatically using clean hierarchical tags:
- `\\section{Title}`
- `\\subsection{Title}`
- `\\subsubsection{Title}`
- `\\paragraph{Title}`

To create an unnumbered section that does not appear in the Table of Contents, append an asterisk: `\\section*{Acknowledgments}`.
''',
                  checks: [
                    TreeCheck(
                      id: 'lx_chk_sec_1',
                      question: 'How do you create an unnumbered section in LaTeX that does not increment the section counter?',
                      options: ['\\section[no]{Title}', '\\section*{Title}', '\\section0{Title}', '\\unsection{Title}'],
                      correctIndex: 1,
                      answerExplanation: 'The starred form `\\section*{...}` suppresses section numbering and TOC registration.',
                    ),
                  ],
                ),
                TreeTopic(
                  id: 'lx_m1_bib_t0',
                  title: 'BibTeX and Reference Management',
                  gist: 'BibTeX decouples citations in text (\\cite{key}) from reference database entries (@article, @book) in a .bib file.',
                  contentMarkdown: '''
In academic writing, reference lists are maintained in a `.bib` file:

```bibtex
@article{einstein1905,
  author  = {Albert Einstein},
  title   = {Zur Elektrodynamik bewegter K{\\"o}rper},
  journal = {Annalen der Physik},
  volume  = {17},
  pages   = {891--921},
  year    = {1905}
}
```

In your `.tex` document:
- Cite via: `According to Einstein~\\cite{einstein1905}...`
- Print references: `\\bibliographystyle{plain}` followed by `\\bibliography{references}`.
''',
                  notes: [
                    TreeNote(
                      type: 'pitfall',
                      title: 'COMPILATION CYCLE',
                      content: 'BibTeX requires multi-pass compilation: `pdflatex -> bibtex -> pdflatex -> pdflatex` to resolve cross-references and citation numbers.',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        TreeModule(
          id: 'lx_mod_2',
          title: 'Module II: Mathematics & Tabular Layouts',
          subtitle: 'Math environments, aligned equations, and formal tables',
          sections: [
            TreeSection(
              id: 'lx_m2_display',
              title: 'Mathematical Display Environments',
              estimate: '~45 min',
              topics: [
                TreeTopic(
                  id: 'lx_m2_math_t0',
                  title: 'amsmath Environments: equation, align & gather',
                  gist: 'Use \$...\$ for inline math, equation for single numbered lines, and align for multi-line derivations with & alignment anchors.',
                  contentMarkdown: '''
The `amsmath` package is the gold standard for scientific typesetting.

### The align Environment
Use `&` to mark the horizontal alignment point, and `\\\\` to break lines:

```latex
\\begin{align}
\\nabla \\cdot \\mathbf{E} &= \\frac{\\rho}{\\varepsilon_0} \\\\
\\nabla \\cdot \\mathbf{B} &= 0 \\\\
\\nabla \\times \\mathbf{E} &= -\\frac{\\partial \\mathbf{B}}{\\partial t} \\\\
\\nabla \\times \\mathbf{B} &= \\mu_0 \\mathbf{J} + \\mu_0 \\varepsilon_0 \\frac{\\partial \\mathbf{E}}{\\partial t}
\\end{align}
```
''',
                  ladder: TreeLadder(
                    title: 'Maxwell Wave Equation Derivation in Free Space',
                    rungs: [
                      TreeRung(
                        math: r'\nabla \times (\nabla \times \mathbf{E}) = -\frac{\partial}{\partial t}(\nabla \times \mathbf{B})',
                        why: 'Take the curl of Faraday\'s Law',
                      ),
                      TreeRung(
                        math: r'\nabla(\nabla \cdot \mathbf{E}) - \nabla^2 \mathbf{E} = -\frac{\partial}{\partial t}\left(\mu_0 \varepsilon_0 \frac{\partial \mathbf{E}}{\partial t}\right)',
                        why: 'Apply vector curl-of-curl identity and substitute Ampère-Maxwell Law in vacuum (J = 0)',
                      ),
                      TreeRung(
                        math: r'\nabla^2 \mathbf{E} - \frac{1}{c^2} \frac{\partial^2 \mathbf{E}}{\partial t^2} = 0',
                        why: 'Since charge density rho = 0 in free space, div(E) = 0, leaving the 3D electromagnetic wave equation with c = 1/sqrt(mu_0 * eps_0)',
                      ),
                    ],
                  ),
                  checks: [
                    TreeCheck(
                      id: 'lx_chk_math_1',
                      question: 'In the `align` environment, which character sets the alignment anchor across multiple equations?',
                      options: ['%', '&', '#', '@'],
                      correctIndex: 1,
                      answerExplanation: '`&` specifies the vertical alignment point on each line.',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// Solid State Physics (Modules I & II) from docs/apps/SOLID_STATE_1.html
  static TreeCourse get solidStateCourse {
    return const TreeCourse(
      id: 'doc_solid_state_1',
      title: 'Solid State Physics',
      subtitle: 'Modules I & II · Crystal Structure, XRD, Drude & Electrons in Solids',
      category: 'solid_state',
      accentColor: Color(0xFF1B6B93),
      htmlAppPath: 'docs/apps/SOLID_STATE_1.html',
      modules: [
        TreeModule(
          id: 'ss_mod_0',
          title: 'Start',
          subtitle: 'Read this first · Exam-night strategy and study journey',
          sections: [
            TreeSection(
              id: 'ss_start',
              title: 'Orientation & Exam Strategy',
              estimate: '~5 min',
              topics: [
                TreeTopic(
                  id: 'ss_start_t0',
                  title: 'Core Philosophy: Words First, Formulas Second',
                  gist: 'A crystal is one group of atoms (the basis) stamped onto every point of an endless regular grid (the lattice).',
                  contentMarkdown: r'''
Everything in Modules I and II, written from zero — no prior solid state assumed.
Target: 4 hours end-to-end.

### Three Mark-Saving Habits
1. **State the structure first** ("FCC $\implies n=4, \sqrt{2}a = 4r$") before substituting numerical values.
2. **Keep units consistent**: Mixing Ångströms with SI metres wrecks every $2/3$ exponent calculation.
3. **Sanity-check answers**: Fermi energy $E_F$ is a few eV, packing fraction $f$ is between $0.3$ and $0.74$, Fermi velocity $v_F \sim 10^6\text{ m/s}$.
''',
                  notes: [
                    TreeNote(
                      type: 'key',
                      title: 'CRYSTAL FORMULA',
                      content: r'$$\text{Crystal Structure} = \text{Lattice} + \text{Basis}$$',
                    ),
                  ],
                  checks: [
                    TreeCheck(
                      id: 'ss_chk_0_1',
                      question: 'What is the mathematical equation relating a crystal, lattice, and basis?',
                      options: [
                        'Crystal = Lattice / Basis',
                        'Crystal = Lattice + Basis',
                        'Crystal = Basis - Lattice',
                        'Crystal = Unit Cell * Number of Atoms',
                      ],
                      correctIndex: 1,
                      answerExplanation: 'A crystal structure is formed by attaching an identical basis (atom or group of atoms) to every lattice point.',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        TreeModule(
          id: 'ss_mod_1',
          title: 'Module I: Crystals & X-Rays',
          subtitle: 'Bravais lattices, Miller indices, packing fractions & Bragg XRD',
          sections: [
            TreeSection(
              id: 'ss_m1_basics',
              title: 'Lattices, Unit Cells & Symmetry',
              estimate: '~25 min',
              topics: [
                TreeTopic(
                  id: 'ss_m1_crys_t0',
                  title: 'Crystalline vs Amorphous Solids',
                  gist: 'Crystalline solids have long-range translational order; amorphous solids only possess short-range nearest-neighbor order.',
                  contentMarkdown: '''
Solids come in two fundamental arrangements depending on how far atomic periodicity extends:

- **Crystalline**: Atomic pattern repeats predictably over millions of unit cells (**long-range order**). Examples: Diamond, Silicon, NaCl, Copper.
  - *Single crystal*: The periodic lattice runs unbroken through the whole specimen.
  - *Polycrystalline*: Composed of many microscopic single-crystal grains meeting at grain boundaries.
- **Amorphous**: Irregular atomic network lacking translational periodicity beyond nearest neighbors (**short-range order**). Examples: Window glass, amorphous silicon.
''',
                  checks: [
                    TreeCheck(
                      id: 'ss_chk_crys_1',
                      question: 'Which of the following materials is amorphous?',
                      options: ['Quartz crystal', 'Table salt (NaCl)', 'Window silica glass', 'Copper wire'],
                      correctIndex: 2,
                      answerExplanation: 'Window glass is an amorphous solid; it lacks long-range translational periodicity.',
                    ),
                  ],
                ),
                TreeTopic(
                  id: 'ss_m1_crys_t1',
                  title: 'Unit Cells & Packing: SC, BCC, FCC, Diamond & NaCl',
                  gist: 'Count corner (1/8), face (1/2), and body (1) atoms to calculate N, determine the touching direction for the a-r relation, and compute atomic packing fraction f.',
                  diagramType: 'unit_cell',
                  contentMarkdown: r'''
### Unit Cell Atom Counting Formula
$$N = N_{\text{interior}} + \frac{N_{\text{face}}}{2} + \frac{N_{\text{corner}}}{8}$$

### Atomic Packing Fraction (APF)
$$f = \frac{N \cdot \frac{4}{3}\pi r^3}{a^3}$$

| Structure | $N$ | Atoms Touch Along | $a - r$ Relation | Coordination ($CN$) | Packing Fraction ($f$) |
|:---:|:---:|:---:|:---:|:---:|:---:|
| **SC** | 1 | Cube edge $\langle 100 \rangle$ | $a = 2r$ | 6 | $\frac{\pi}{6} \approx 52.4\%$ |
| **BCC** | 2 | Body diagonal $\langle 111 \rangle$ | $\sqrt{3}a = 4r$ | 8 | $\frac{\pi\sqrt{3}}{8} \approx 68.0\%$ |
| **FCC** | 4 | Face diagonal $\langle 110 \rangle$ | $\sqrt{2}a = 4r$ | 12 | $\frac{\pi}{3\sqrt{2}} \approx 74.0\%$ |
| **Diamond** | 8 | $1/4$ body diagonal | $\sqrt{3}a = 8r$ | 4 | $\frac{\pi\sqrt{3}}{16} \approx 34.0\%$ |
''',
                  ladder: TreeLadder(
                    title: 'Derivation of FCC Packing Fraction (f = 74%)',
                    rungs: [
                      TreeRung(
                        math: r'N = 8 \times \frac{1}{8} + 6 \times \frac{1}{2} = 1 + 3 = 4\text{ atoms/cell}',
                        why: 'Sum 8 corner eighths and 6 face halves',
                      ),
                      TreeRung(
                        math: r'\text{Face diagonal } \sqrt{2}a = 4r \implies a = \frac{4r}{\sqrt{2}} = 2\sqrt{2}r',
                        why: 'Hard spheres touch continuously along face diagonal <110>',
                      ),
                      TreeRung(
                        math: r'f = \frac{4 \times \frac{4}{3}\pi r^3}{(2\sqrt{2}r)^3} = \frac{\frac{16}{3}\pi r^3}{16\sqrt{2} r^3} = \frac{\pi}{3\sqrt{2}} \approx 0.7405',
                        why: 'Substitute volume of 4 spheres divided by cubic cell volume a^3',
                      ),
                    ],
                  ),
                  notes: [
                    TreeNote(
                      type: 'key',
                      title: 'CLOSE PACKING LIMIT',
                      content: r'FCC and HCP both attain the maximum theoretical close-packing limit of $$f = 0.74$$ ($$CN = 12$$), differing only in stacking sequence (ABCABC for FCC vs ABAB for HCP).',
                    ),
                  ],
                  checks: [
                    TreeCheck(
                      id: 'ss_chk_fcc_1',
                      question: 'Copper has FCC structure with lattice constant a = 3.61 Å. What is the atomic radius r?',
                      options: ['1.80 Å', '1.28 Å', '2.55 Å', '0.90 Å'],
                      correctIndex: 1,
                      answerExplanation: r'$$\sqrt{2}a = 4r \implies r = \frac{\sqrt{2} \times 3.61}{4} \approx 1.276\text{ Å}$$.',
                    ),
                  ],
                ),
                TreeTopic(
                  id: 'ss_m1_miller_t0',
                  title: 'Miller Indices (hkl) and Interplanar Spacing',
                  gist: 'Miller indices are reciprocals of fractional intercepts cleared of fractions, defining parallel sets of lattice planes.',
                  diagramType: 'miller_planes',
                  contentMarkdown: r'''
### Procedure for Finding Miller Indices (h, k, l)
1. Determine intercepts along crystal axes in units of lattice constants $a, b, c$: $(x_0, y_0, z_0)$.
2. Take reciprocals: $(1/x_0, 1/y_0, 1/z_0)$.
3. Clear fractions by multiplying by the lowest common denominator to obtain coprime integers $(h, k, l)$.

### Interplanar Spacing Formula for Cubic Crystals
For a cubic system of lattice constant $a$:
$$d_{hkl} = \frac{a}{\sqrt{h^2 + k^2 + l^2}}$$
''',
                  ladder: TreeLadder(
                    title: 'Derivation of Interplanar Spacing d_hkl in Cubic Crystal',
                    rungs: [
                      TreeRung(
                        math: r'\frac{x}{a/h} + \frac{y}{a/k} + \frac{z}{a/l} = 1 \implies hx + ky + lz = a',
                        why: 'Equation of plane passing through intercepts a/h, a/k, a/l',
                      ),
                      TreeRung(
                        math: r'd = \frac{|\mathbf{n} \cdot \mathbf{r} - a|}{|\mathbf{n}|} = \frac{a}{\sqrt{h^2 + k^2 + l^2}}',
                        why: 'Perpendicular distance from origin to plane with normal vector n = (h, k, l)',
                      ),
                    ],
                  ),
                  notes: [
                    TreeNote(
                      type: 'pitfall',
                      title: 'PARALLEL INTERCEPTS',
                      content: r'When a plane is parallel to a crystal axis, its intercept is at infinity ($$\infty$$), which yields a Miller index of $$1/\infty = 0$$.',
                    ),
                  ],
                  checks: [
                    TreeCheck(
                      id: 'ss_chk_miller_1',
                      question: 'What is the interplanar spacing d for the (200) planes of an FCC crystal with lattice constant a = 4.0 Å?',
                      options: ['4.0 Å', '2.0 Å', '2.83 Å', '1.41 Å'],
                      correctIndex: 1,
                      answerExplanation: r'$$d_{200} = \frac{a}{\sqrt{2^2 + 0^2 + 0^2}} = \frac{4.0}{2} = 2.0\text{ Å}$$.',
                    ),
                  ],
                ),
              ],
            ),
            TreeSection(
              id: 'ss_m1_xrd',
              title: 'X-Ray Diffraction & Bragg\'s Law',
              estimate: '~30 min',
              topics: [
                TreeTopic(
                  id: 'ss_m1_bragg_t0',
                  title: 'Bragg\'s Law of Diffraction',
                  gist: 'Constructive interference occurs when path difference between specular reflections from adjacent atomic planes equals an integral wavelength n*lambda.',
                  contentMarkdown: r'''
X-rays have wavelengths ($\sim 1\text{ Å} = 0.1\text{ nm}$) comparable to interplanar lattice spacings, making them ideal probes for crystal diffraction.

### Bragg Condition
$$2d\sin\theta = n\lambda$$
where:
- $d$ is interplanar spacing
- $\theta$ is the glancing / Bragg angle (angle with the plane, NOT the normal!)
- $n$ is diffraction order (integer $1, 2, 3...$)
- $\lambda$ is X-ray wavelength
''',
                  ladder: TreeLadder(
                    title: 'Derivation of Bragg\'s Law: 2d sin(theta) = n lambda',
                    rungs: [
                      TreeRung(
                        math: r'\Delta = AB + BC',
                        why: 'Total extra path length traversed by ray reflecting from second plane',
                      ),
                      TreeRung(
                        math: r'AB = BC = d \sin\theta \implies \Delta = 2d \sin\theta',
                        why: 'From right-angled triangle where d is opposite to angle theta',
                      ),
                      TreeRung(
                        math: r'2d \sin\theta = n\lambda',
                        why: 'Condition for constructive interference of coherent monochromatic waves',
                      ),
                    ],
                  ),
                  notes: [
                    TreeNote(
                      type: 'pitfall',
                      title: 'THETA VS 2-THETA',
                      content: 'Diffractometer instruments measure the deviation angle 2*theta! In problems, if "detector angle = 40 deg" is given, Bragg theta is 20 deg!',
                    ),
                  ],
                  checks: [
                    TreeCheck(
                      id: 'ss_chk_bragg_1',
                      question: 'In X-ray diffraction, if first-order reflection occurs at theta = 30 deg for lambda = 1.54 Å, what is d?',
                      options: ['1.54 Å', '3.08 Å', '0.77 Å', '2.18 Å'],
                      correctIndex: 0,
                      answerExplanation: r'$$2d\sin(30^\circ) = 1 \cdot \lambda \implies 2d(0.5) = \lambda \implies d = \lambda = 1.54\text{ Å}$$.',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        TreeModule(
          id: 'ss_mod_2',
          title: 'Module II: Electrons in Solids',
          subtitle: 'Free electron theory, Fermi energy, Kronig-Penney & Band Theory',
          sections: [
            TreeSection(
              id: 'ss_m2_drude_fermi',
              title: 'Free Electron Fermi Gas',
              estimate: '~40 min',
              topics: [
                TreeTopic(
                  id: 'ss_m2_fermi_t0',
                  title: 'Fermi Energy and Fermi Surface in 3D',
                  gist: 'At T = 0 K, electrons fill all available single-particle states up to the highest occupied energy level, called the Fermi Energy E_F.',
                  contentMarkdown: r'''
According to Pauli's Exclusion Principle, each spatial state can accommodate at most 2 electrons (spin up, spin down).
In k-space, states occupy a sphere of radius $k_F$ (the **Fermi sphere**).

### Fermi Wavenumber in 3D
$$k_F = \left(3\pi^2 n\right)^{1/3}$$
where $n = N/V$ is electron number density.

### Fermi Energy
$$E_F = \frac{\hbar^2 k_F^2}{2m} = \frac{\hbar^2}{2m}\left(3\pi^2 n\right)^{2/3}$$
''',
                  ladder: TreeLadder(
                    title: 'Derivation of 3D Fermi Energy E_F from Density n',
                    rungs: [
                      TreeRung(
                        math: r'N = 2 \times \frac{V_F}{\text{volume per state}} = 2 \times \frac{\frac{4}{3}\pi k_F^3}{(2\pi/L)^3}',
                        why: 'Total electrons inside Fermi sphere with 2 spin states each',
                      ),
                      TreeRung(
                        math: r'N = \frac{V k_F^3}{3\pi^2} \implies n = \frac{N}{V} = \frac{k_F^3}{3\pi^2}',
                        why: 'Simplify volume L^3 = V and solve for electron density n',
                      ),
                      TreeRung(
                        math: r'k_F = (3\pi^2 n)^{1/3} \implies E_F = \frac{\hbar^2 k_F^2}{2m} = \frac{\hbar^2}{2m}(3\pi^2 n)^{2/3}',
                        why: 'Substitute k_F into free electron parabolic dispersion E = hbar^2 k^2 / 2m',
                      ),
                    ],
                  ),
                  checks: [
                    TreeCheck(
                      id: 'ss_chk_fermi_1',
                      question: 'How does the 3D Fermi energy E_F depend on the conduction electron density n?',
                      options: [
                        'E_F proportional to n',
                        'E_F proportional to n^(1/2)',
                        'E_F proportional to n^(2/3)',
                        'E_F proportional to n^(3/2)',
                      ],
                      correctIndex: 2,
                      answerExplanation: r'In 3D, $$E_F = \frac{\hbar^2}{2m}(3\pi^2 n)^{2/3}$$, so $$E_F \propto n^{2/3}$$.',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
