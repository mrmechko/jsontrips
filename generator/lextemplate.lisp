(load "~/quicklisp/setup.lisp")
(ql:quickload :jonathan)

(load "../LexiconManager/lxm.lisp")
(in-package :lxm)

(defun cell-to-pair (c) (list (car c) (cdr c)))

;defstruct vocabulary-entry name particle remaining-words word pos pronounciation wfeats senses boost-word abbrev

;defstruct meta-data origin entry-date mod-date comments

;defstruct basic-sense-definition pos lf sem pref nonhierarchy-lf syntax boost-word meta-data prototypical-word

;defstruct sense-definition pos lf sem pref nonhierarchy-lf syntax boost-word meta-data prototypical-word lf-parent lf-form templ params

;defstruct word-sense-definition pos lf sem pref nonhierarchy-lf syntax boost-word meta-data prototypical-word lf-parent lf-form templ params word roles mappings name remaining-words kr-type specialized transform coercions operator

;defstruct syntax-template name syntax mappings,cdr

;defstruct basic-synsem-map name slot optional maponly

;defstruct synsem-map name slot optional map-only paramname default required

;defstruct word-synsem-map name slot optional map-only paramname default required varname syntcat syntfeat

;defstruct lex-entry id words pref description boost-word

;defstruct lf-description name sem arguments parent children kr-transforms slot-transforms default-kr-transforms coercions role-implementation

;defstruct coercion-operator-description name argument result lf sem


; test templates
(defparameter a-template (caadr (get-all-values (lexicon-db-synt-table *lexicon-data*))))

(jonathan::to-json a-template)
