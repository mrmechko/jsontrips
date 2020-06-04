(load "~/quicklisp/setup.lisp")
(ql:quickload :jonathan)

(in-package :lxm)

(defun cell-to-pair (c) (list (car c) (cdr c)))
(defun mctp (m) (map 'list #'cell-to-pair m))


(defmethod JONATHAN::%to-json ((variable vocabulary-entry))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::WRITE-KEY-VALUE "name" (vocabulary-entry-name variable))
     (JONATHAN::WRITE-KEY-VALUE "particle" (vocabulary-entry-particle variable))
     (JONATHAN::WRITE-KEY-VALUE "remaining_words" (vocabulary-entry-remaining-words variable))
     (JONATHAN::WRITE-KEY-VALUE "word" (vocabulary-entry-word variable))
     (JONATHAN::WRITE-KEY-VALUE "pos" (vocabulary-entry-pos variable))
     (JONATHAN::WRITE-KEY-VALUE "pronunciation" (vocabulary-entry-pronunciation variable))
     (JONATHAN::WRITE-KEY-VALUE "wfeats" (vocabulary-entry-wfeats variable))
     (JONATHAN::WRITE-KEY-VALUE "senses" (vocabulary-entry-senses variable))
     (JONATHAN::WRITE-KEY-VALUE "boost_word" (vocabulary-entry-boost-word variable))
     (JONATHAN::WRITE-KEY-VALUE "abbrev" (vocabulary-entry-abbrev variable))
  )
)


(defmethod JONATHAN::%to-json ((variable meta-data))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::WRITE-KEY-VALUE "origin" (meta-data-origin variable))
     (JONATHAN::WRITE-KEY-VALUE "entry_date" (meta-data-entry-date variable))
     (JONATHAN::WRITE-KEY-VALUE "mod_date" (meta-data-mod-date variable))
     (JONATHAN::WRITE-KEY-VALUE "comments" (meta-data-comments variable))
  )
)


(defmethod JONATHAN::%to-json ((variable basic-sense-definition))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::WRITE-KEY-VALUE "pos" (basic-sense-definition-pos variable))
     (JONATHAN::WRITE-KEY-VALUE "lf" (basic-sense-definition-lf variable))
     (JONATHAN::WRITE-KEY-VALUE "sem" (basic-sense-definition-sem variable))
     (JONATHAN::WRITE-KEY-VALUE "pref" (basic-sense-definition-pref variable))
     (JONATHAN::WRITE-KEY-VALUE "nonhierarchy_lf" (basic-sense-definition-nonhierarchy-lf variable))
     (JONATHAN::WRITE-KEY-VALUE "syntax" (basic-sense-definition-syntax variable))
     (JONATHAN::WRITE-KEY-VALUE "boost_word" (basic-sense-definition-boost-word variable))
     (JONATHAN::WRITE-KEY-VALUE "meta_data" (basic-sense-definition-meta-data variable))
     (JONATHAN::WRITE-KEY-VALUE "prototypical_word" (basic-sense-definition-prototypical-word variable))
  )
)


(defmethod JONATHAN::%to-json ((variable sense-definition))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::WRITE-KEY-VALUE "pos" (sense-definition-pos variable))
     (JONATHAN::WRITE-KEY-VALUE "lf" (sense-definition-lf variable))
     (JONATHAN::WRITE-KEY-VALUE "sem" (sense-definition-sem variable))
     (JONATHAN::WRITE-KEY-VALUE "pref" (sense-definition-pref variable))
     (JONATHAN::WRITE-KEY-VALUE "nonhierarchy_lf" (sense-definition-nonhierarchy-lf variable))
     (JONATHAN::WRITE-KEY-VALUE "syntax" (sense-definition-syntax variable))
     (JONATHAN::WRITE-KEY-VALUE "boost_word" (sense-definition-boost-word variable))
     (JONATHAN::WRITE-KEY-VALUE "meta_data" (sense-definition-meta-data variable))
     (JONATHAN::WRITE-KEY-VALUE "prototypical_word" (sense-definition-prototypical-word variable))
     (JONATHAN::WRITE-KEY-VALUE "lf_parent" (sense-definition-lf-parent variable))
     (JONATHAN::WRITE-KEY-VALUE "lf_form" (sense-definition-lf-form variable))
     (JONATHAN::WRITE-KEY-VALUE "templ" (sense-definition-templ variable))
     (JONATHAN::WRITE-KEY-VALUE "params" (sense-definition-params variable))
  )
)


(defmethod JONATHAN::%to-json ((variable word-sense-definition))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::WRITE-KEY-VALUE "pos" (word-sense-definition-pos variable))
     (JONATHAN::WRITE-KEY-VALUE "lf" (word-sense-definition-lf variable))
     (JONATHAN::WRITE-KEY-VALUE "sem" (word-sense-definition-sem variable))
     (JONATHAN::WRITE-KEY-VALUE "pref" (word-sense-definition-pref variable))
     (JONATHAN::WRITE-KEY-VALUE "nonhierarchy_lf" (word-sense-definition-nonhierarchy-lf variable))
     (JONATHAN::WRITE-KEY-VALUE "syntax" (word-sense-definition-syntax variable))
     (JONATHAN::WRITE-KEY-VALUE "boost_word" (word-sense-definition-boost-word variable))
     (JONATHAN::WRITE-KEY-VALUE "meta_data" (word-sense-definition-meta-data variable))
     (JONATHAN::WRITE-KEY-VALUE "prototypical_word" (word-sense-definition-prototypical-word variable))
     (JONATHAN::WRITE-KEY-VALUE "lf_parent" (word-sense-definition-lf-parent variable))
     (JONATHAN::WRITE-KEY-VALUE "lf_form" (word-sense-definition-lf-form variable))
     (JONATHAN::WRITE-KEY-VALUE "templ" (word-sense-definition-templ variable))
     (JONATHAN::WRITE-KEY-VALUE "params" (word-sense-definition-params variable))
     (JONATHAN::WRITE-KEY-VALUE "word" (word-sense-definition-word variable))
     (JONATHAN::WRITE-KEY-VALUE "roles" (word-sense-definition-roles variable))
     (JONATHAN::WRITE-KEY-VALUE "mappings" (word-sense-definition-mappings variable))
     (JONATHAN::WRITE-KEY-VALUE "name" (word-sense-definition-name variable))
     (JONATHAN::WRITE-KEY-VALUE "remaining_words" (word-sense-definition-remaining-words variable))
     (JONATHAN::WRITE-KEY-VALUE "kr_type" (word-sense-definition-kr-type variable))
     (JONATHAN::WRITE-KEY-VALUE "specialized" (word-sense-definition-specialized variable))
     (JONATHAN::WRITE-KEY-VALUE "transform" (word-sense-definition-transform variable))
     (JONATHAN::WRITE-KEY-VALUE "coercions" (word-sense-definition-coercions variable))
     (JONATHAN::WRITE-KEY-VALUE "operator" (word-sense-definition-operator variable))
  )
)


(defmethod JONATHAN::%to-json ((variable syntax-template))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::WRITE-KEY-VALUE "name" (syntax-template-name variable))
     (JONATHAN::WRITE-KEY-VALUE "syntax" (syntax-template-syntax variable))
     (JONATHAN::WRITE-KEY-VALUE "mappings" (mctp (syntax-template-mappings variable)))
  )
)


(defmethod JONATHAN::%to-json ((variable basic-synsem-map))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::WRITE-KEY-VALUE "name" (basic-synsem-map-name variable))
     (JONATHAN::WRITE-KEY-VALUE "slot" (basic-synsem-map-slot variable))
     (JONATHAN::WRITE-KEY-VALUE "optional" (basic-synsem-map-optional variable))
     (JONATHAN::WRITE-KEY-VALUE "maponly" (basic-synsem-map-maponly variable))
  )
)


(defmethod JONATHAN::%to-json ((variable synsem-map))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::WRITE-KEY-VALUE "name" (synsem-map-name variable))
     (JONATHAN::WRITE-KEY-VALUE "slot" (synsem-map-slot variable))
     (JONATHAN::WRITE-KEY-VALUE "optional" (synsem-map-optional variable))
     (JONATHAN::WRITE-KEY-VALUE "maponly" (synsem-map-maponly variable))
     (JONATHAN::WRITE-KEY-VALUE "paramname" (synsem-map-paramname variable))
     (JONATHAN::WRITE-KEY-VALUE "default" (synsem-map-default variable))
     (JONATHAN::WRITE-KEY-VALUE "required" (synsem-map-required variable))
  )
)


(defmethod JONATHAN::%to-json ((variable word-synsem-map))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::WRITE-KEY-VALUE "name" (word-synsem-map-name variable))
     (JONATHAN::WRITE-KEY-VALUE "slot" (word-synsem-map-slot variable))
     (JONATHAN::WRITE-KEY-VALUE "optional" (word-synsem-map-optional variable))
     (JONATHAN::WRITE-KEY-VALUE "maponly" (word-synsem-map-maponly variable))
     (JONATHAN::WRITE-KEY-VALUE "paramname" (word-synsem-map-paramname variable))
     (JONATHAN::WRITE-KEY-VALUE "default" (word-synsem-map-default variable))
     (JONATHAN::WRITE-KEY-VALUE "required" (word-synsem-map-required variable))
     (JONATHAN::WRITE-KEY-VALUE "varname" (word-synsem-map-varname variable))
     (JONATHAN::WRITE-KEY-VALUE "syntcat" (word-synsem-map-syntcat variable))
     (JONATHAN::WRITE-KEY-VALUE "syntfeat" (word-synsem-map-syntfeat variable))
  )
)


(defmethod JONATHAN::%to-json ((variable lex-entry))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::WRITE-KEY-VALUE "id" (lex-entry-id variable))
     (JONATHAN::WRITE-KEY-VALUE "words" (lex-entry-words variable))
     (JONATHAN::WRITE-KEY-VALUE "pref" (lex-entry-pref variable))
     (JONATHAN::WRITE-KEY-VALUE "description" (lex-entry-description variable))
     (JONATHAN::WRITE-KEY-VALUE "boost_word" (lex-entry-boost-word variable))
  )
)


(defmethod JONATHAN::%to-json ((variable lf-description))
  (JONATHAN::WITH-OBJECT
      (JONATHAN::WRITE-KEY-VALUE "name" (lf-description-name variable))
    (JONATHAN::WRITE-KEY-VALUE "sem" (lf-description-sem variable))
    (JONATHAN::WRITE-KEY-VALUE "arguments" (lf-description-arguments variable))
    (JONATHAN::WRITE-KEY-VALUE "parent" (lf-description-parent variable))
    (JONATHAN::WRITE-KEY-VALUE "children" (lf-description-children variable))
    (JONATHAN::WRITE-KEY-VALUE "kr_transforms" (lf-description-kr-transforms variable))
    (JONATHAN::WRITE-KEY-VALUE "slot_transforms" (lf-description-slot-transforms variable))
    (JONATHAN::WRITE-KEY-VALUE "default_kr_transforms" (lf-description-default-kr-transforms variable))
    (JONATHAN::WRITE-KEY-VALUE "coercions" (lf-description-coercions variable))
    (JONATHAN::WRITE-KEY-VALUE "role_implementation" (lf-description-role-implementation variable))))




(defmethod JONATHAN::%to-json ((variable coercion-operator-description))
  (JONATHAN::WITH-OBJECT
      (JONATHAN::WRITE-KEY-VALUE "name" (coercion-operator-description-name variable))
    (JONATHAN::WRITE-KEY-VALUE "argument" (coercion-operator-description-argument variable))
    (JONATHAN::WRITE-KEY-VALUE "result" (coercion-operator-description-result variable))
    (JONATHAN::WRITE-KEY-VALUE "lf" (coercion-operator-description-lf variable))
    (JONATHAN::WRITE-KEY-VALUE "sem" (coercion-operator-description-sem variable))))




                                        ; (jonathan::to-json (get-all-values (lexicon-db-synt-table *lexicon-data*)))

(in-package :collie)
(defun write-ont-file (source destination)
  (with-open-file
      (str destination
           :direction :output
           :if-exists :supersede
           :if-does-not-exist :create)
    (format str (JONATHAN::to-json source)))
  )

(defun write-all-lexicon (dest)
  (write-ont-file (lxm::lexicon-db-synt-table lxm::*lexicon-data*) (format nil "~A/~A" dest "syntax_templates.json"))
  (write-ont-file (lxm::lexicon-db-word-table lxm::*lexicon-data*) (format nil "~A/~A" dest "words.json"))
  (write-ont-file (lxm::lexicon-db-lf-table lxm::*lexicon-data*) (format nil "~A/~A" dest "lexicon_lf.json"))
  )
