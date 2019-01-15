#!/bin/bash

rm -rf lisp
rm -rf dist

mkdir lisp
mkdir dist

python generator/generator.py -f generator/template.lisp > lisp/genontology.lisp
python generator/generator.py -f generator/lextemplate.lisp > lisp/genlexicon.lisp

sbcl --script lisp/genontology.lisp
sbcl --script lisp/genlexicon.lisp

python prettify.py dist/featurelists.json dist/featuretypes.json dist/ontology.json
python prettify.py dist/words.json dist/syntax_templates.json dist/lexicon_lf.json

rm jsontrips/jsontrips/data
cp -r dist jsontrips/jsontrips/data
