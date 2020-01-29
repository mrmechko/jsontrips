#!/bin/bash

set -e # exit if anything breaks

rm -rf lisp
rm -rf dist

mkdir lisp
mkdir dist

python code/generator/generator.py -f code/generator/template.lisp > lisp/genontology.lisp
python code/generator/generator.py -f code/generator/lextemplate.lisp > lisp/genlexicon.lisp

sbcl --script lisp/genontology.lisp
sbcl --script lisp/genlexicon.lisp

python code/prettify.py dist/featurelists.json dist/featuretypes.json dist/ontology.json
python code/prettify.py dist/words.json dist/syntax_templates.json dist/lexicon_lf.json

cp ../WordFinder/wordnet/stoplist.txt dist
cp ../WordFinder/wordnet/golist.txt dist

rm -rf jsontrips/data
cp -r dist jsontrips/data

echo "Trips successfully updated.  Run deploy.sh to deploy and push to github"
echo True > .deploy.lock
