#!/bin/bash

set -e # exit if anything breaks

echo False > .deploy.lock

# TODO: lisp files are temporarily not autogenerated until generator is updated
#rm -rf lisp
rm -rf dist

#mkdir lisp
mkdir dist


# TODO: generator needs to be updated for collie-ready version
#python code/generator/generator.py -f code/generator/template.lisp > lisp/genontology.lisp
#python code/generator/generator.py -f code/generator/lextemplate.lisp > lisp/genlexicon.lisp
