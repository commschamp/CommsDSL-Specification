---
permalink: /index.html
---
# Introduction
This document contains specification of **D**omain **S**pecific **L**anguage (DSL),
called **CommsDSL**, for [CommsChampion Ecosystem](https://commschamp.github.io),
used to define custom binary protocols. The defined schema files are intended
to be parsed and used by [commsdsl](https://github.com/commschamp/commsdsl) library and code
generation application(s).

The PDF can be downloaded from [release](https://github.com/commschamp/CommsDSL-Specification/releases)
artifacts of this project. The online HTML documentation is hosted on
[github pages](https://commschamp.github.io/commsdsl_spec).

The specification is written using [asciidoc](http://asciidoc.org/) and buildable
using [CMake](https://cmake.org/)

# How to Build
```
$> mkdir build && cd build
$> cmake ..
$> make pdf                # <-- Builds PDF
$> make site               # <-- Builds HTML
```

