#!/bin/bash

python generator/generator.py -f generator/template.lisp > genontology.lisp
python generator/generator.py -f generator/lextemplate.lisp > genlexicon.lisp

