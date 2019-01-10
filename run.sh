#!/bin/bash

rm -rf lisp
rm -rf dist

mkdir lisp
mkdir dist

python generator/generator.py -f generator/template.lisp > lisp/genontology.lisp
python generator/generator.py -f generator/lextemplate.lisp > lisp/genlexicon.lisp

sbcl --script lisp/genontology.lisp
#sbcl --script lisp/genlexicon.lisp
