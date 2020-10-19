# Introduction
This document contains specification of **D**omain **S**pecific **L**anguage (DSL),
called **CommsDSL**, for [CommsChampion Ecosystem](https://commschamp.github.io),
used to define custom binary protocols. The defined schema files are intended
to be parsed and used by [commsdsl](https://github.com/commschamp/commsdsl) library and code
generation application(s).

The PDF can be downloaded from [release](https://github.com/commschamp/CommsDSL-Specification/releases)
artifacts of this project. The online HTML documentation is hosted on
[github pages](https://commschamp.github.io/commsdsl_spec).

The specification is written using [asciidoctor](https://asciidoctor.org) and buildable
using [CMake](https://cmake.org/)

# Toolchain setup

For a more detailed version go to https://asciidoctor.org/#installation

## Newest asciidoctor version
For asciidoctor the ruby version 2.7 is necessary.

Head over to the ruby install instructions https://www.ruby-lang.org/de/documentation/installation/. Note for windows: If you already have [chocolatey](https://chocolatey.org/) installed, you simply can run `choco install ruby`



Install asciidoctor, asciidoctor-pdf and the syntax highlighter with:
```
$> gem install asciidoctor
$> gem install asciidoctor-pdf
$> gem install rouge
```


# How to Build
```
$> mkdir build && cd build
$> cmake ..
$> make pdf                # <-- Builds PDF
$> make site               # <-- Builds HTML
```

