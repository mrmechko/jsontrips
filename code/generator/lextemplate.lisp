(load "~/quicklisp/setup.lisp")
(ql:quickload :jonathan)

(in-package :lxm)

(defun cell-to-pair (c) (list (car c) (cdr c)))
(defun mctp (m) (map 'list #'cell-to-pair m))

;defstruct vocabulary-entry name particle remaining-words word pos pronunciation wfeats senses boost-word abbrev

;defstruct meta-data origin entry-date mod-date comments

;defstruct basic-sense-definition pos lf sem pref nonhierarchy-lf syntax boost-word meta-data prototypical-word

;defstruct sense-definition pos lf sem pref nonhierarchy-lf syntax boost-word meta-data prototypical-word lf-parent lf-form templ params

;defstruct word-sense-definition pos lf sem pref nonhierarchy-lf syntax boost-word meta-data prototypical-word lf-parent lf-form templ params word roles mappings name remaining-words kr-type specialized transform coercions operator

;defstruct syntax-template name syntax mappings,mctp

;defstruct basic-synsem-map name slot optional maponly

;defstruct synsem-map name slot optional maponly paramname default required

;defstruct word-synsem-map name slot optional maponly paramname default required varname syntcat syntfeat

;defstruct lex-entry id words pref description boost-word

;defstruct lf-description name sem arguments parent children kr-transforms slot-transforms default-kr-transforms coercions role-implementation

;defstruct coercion-operator-description name argument result lf sem


(jonathan::to-json (get-all-values (lexicon-db-synt-table *lexicon-data*)))

(defun write-ont-file (source destination)
  (with-open-file
    (str destination
       :direction :output
       :if-exists :supersede
       :if-does-not-exist :create)
    (format str (JONATHAN::to-json source)))
)

(defun write-all-lexicon (dest)
  (write-ont-file (lexicon-db-synt-table *lexicon-data*) (format nil "~A/~A" dest "syntax_templates.json"))
  (write-ont-file (lexicon-db-word-table *lexicon-data*) (format nil "~A/~A" dest "words.json"))
  (write-ont-file (lexicon-db-lf-table *lexicon-data*) (format nil "~A/~A" dest "lexicon_lf.json"))
)
