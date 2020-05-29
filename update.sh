#!/bin/bash

set -e # exit if anything breaks

echo prettifying jsons

python code/prettify.py dist/featurelists.json dist/featuretypes.json dist/ontology.json
python code/prettify.py dist/words.json dist/syntax_templates.json dist/lexicon_lf.json

echo inserting stoplist and golist

cp ../WordFinder/wordnet/stoplist.txt dist
cp ../WordFinder/wordnet/golist.txt dist

echo replacing data with dist

rm -rf jsontrips/data
cp -r dist jsontrips/data

echo "Trips successfully updated.  Run deploy.sh to deploy and push to github"
echo True > .deploy.lock
