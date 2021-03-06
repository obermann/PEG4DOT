# PEG4DOT

Parsing Expression Grammar (PEG, also [PEG.js](https://pegjs.org/online)) for [GraphViz](http://www.graphviz.org/) DOT file format.

The GraphViz DOT file format as of the year 2020 has some inconsistencies.
Details and the derivation of PEG can be found in [PEG4DOT-Notes.html](https://obermann.github.io/PEG4DOT/PEG4DOT-Notes.html).

dot.pegjs semantics are not exactly the same as dot.peg.
This dot.pegjs has small optimizations.
To make it a validating parser follow the comments inside dot.pegjs.
[GrammKit](https://github.com/dundalek/GrammKit) autogenerated [railroad diagram](https://en.wikipedia.org/wiki/Syntax_diagram) of dot.pegjs
can be found in [dot.pegjs.html](https://obermann.github.io/PEG4DOT/dot.pegjs.html).
An example of using dot.pegjs (compiled as dot.js) can be found in https://github.com/obermann/vismm.

## Resources

[Ford, Bryan. (2004). Parsing Expression Grammars: A Recognition-Based Syntactic Foundation. ACM SIGPLAN Notices. 39. 111-122. 10.1145/964001.964011.](https://pdos.csail.mit.edu/~baford/packrat/popl04/)

[PEG.js Grammar Syntax and Semantics](https://github.com/pegjs/pegjs/tree/master/docs/grammar)

[PEG.js online parser generator for JavaScript](https://pegjs.org/online)

[PEGSH - A Free Online PEG Syntax Highlighter](http://phrogz.net/js/pegsh/)

[GrammKit](https://github.com/dundalek/GrammKit)

[DOT in Wikipedia](https://en.wikipedia.org/wiki/DOT_(graph_description_language))

[Graphviz abstract grammar defining the DOT language](http://www.graphviz.org/doc/info/lang.html)

## Prior Art

https://github.com/siefkenj/dotgraph

https://github.com/anvaka/dotparser

https://github.com/magjac/graphviz-visual-editor

https://github.com/dagrejs/graphlib-dot

https://github.com/gmamaladze/d3-dot-graph

https://github.com/eclipse/gef/tree/master/org.eclipse.gef.dot.ui/src/org/eclipse/gef/dot/internal/ui/conversion
