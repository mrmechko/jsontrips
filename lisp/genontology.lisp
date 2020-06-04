(load "~/quicklisp/setup.lisp")
(ql:quickload :jonathan)

(in-package :om)

(defun sfeat (x) (list (featval-description-feature-name x) (featval-description-value x)))
(defun mapcdr (x) (map 'list #'cdr x))
(defun fname (x) (if x
                     (if (listp x)
                         (map 'list #'sfeat x)
                         (sfeat x)
                         )
                     '()
                     ))


(defmethod JONATHAN::%to-json ((variable lf-description))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::WRITE-KEY-VALUE "name" (lf-description-name variable))
     (JONATHAN::WRITE-KEY-VALUE "sem" (lf-description-sem variable))
     (JONATHAN::WRITE-KEY-VALUE "arguments" (lf-description-arguments variable))
     (JONATHAN::WRITE-KEY-VALUE "parent" (lf-description-parent variable))
     (JONATHAN::WRITE-KEY-VALUE "children" (lf-description-children variable))
     (JONATHAN::WRITE-KEY-VALUE "wordnet_sense_keys" (lf-description-wordnet-sense-keys variable))
     (JONATHAN::WRITE-KEY-VALUE "comment" (lf-description-comment variable))
     (JONATHAN::WRITE-KEY-VALUE "definitions" (lf-description-definitions variable))
  )
)


(defmethod JONATHAN::%to-json ((variable sem-argument))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::WRITE-KEY-VALUE "role" (sem-argument-role variable))
     (JONATHAN::WRITE-KEY-VALUE "restriction" (sem-argument-restriction variable))
     (JONATHAN::WRITE-KEY-VALUE "optionality" (sem-argument-optionality variable))
     (JONATHAN::WRITE-KEY-VALUE "implements" (sem-argument-implements variable))
  )
)


(defmethod JONATHAN::%to-json ((variable featval-description))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::WRITE-KEY-VALUE "feature_name" (featval-description-feature-name variable))
     (JONATHAN::WRITE-KEY-VALUE "value" (featval-description-value variable))
     (JONATHAN::WRITE-KEY-VALUE "myimplied" (featval-description-myimplied variable))
     (JONATHAN::WRITE-KEY-VALUE "implied" (featval-description-implied variable))
     (JONATHAN::WRITE-KEY-VALUE "required" (featval-description-required variable))
     (JONATHAN::WRITE-KEY-VALUE "parent" (fname (featval-description-parent variable)))
     (JONATHAN::WRITE-KEY-VALUE "consistent_supertypes" (featval-description-consistent-supertypes variable))
  )
)


(defmethod JONATHAN::%to-json ((variable feature-description))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::WRITE-KEY-VALUE "name" (feature-description-name variable))
     (JONATHAN::WRITE-KEY-VALUE "root_value" (feature-description-root-value variable))
     (JONATHAN::WRITE-KEY-VALUE "defaults" (feature-description-defaults variable))
     (JONATHAN::WRITE-KEY-VALUE "values" (mapcdr (feature-description-values variable)))
     (JONATHAN::WRITE-KEY-VALUE "external" (feature-description-external variable))
  )
)


(defmethod JONATHAN::%to-json ((variable feature-list))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::WRITE-KEY-VALUE "type" (feature-list-type variable))
     (JONATHAN::WRITE-KEY-VALUE "features" (feature-list-features variable))
     (JONATHAN::WRITE-KEY-VALUE "defaults" (feature-list-defaults variable))
  )
)


(defmethod JONATHAN::%to-json ((variable feature-type-description))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::WRITE-KEY-VALUE "name" (feature-type-description-name variable))
     (JONATHAN::WRITE-KEY-VALUE "features" (feature-type-description-features variable))
     (JONATHAN::WRITE-KEY-VALUE "defaults" (feature-type-description-defaults variable))
  )
)

(in-package :collie)

(defun write-ont-file (source destination)
  (with-open-file
      (str destination
           :direction :output
           :if-exists :supersede
           :if-does-not-exist :create)
    (format str (JONATHAN::to-json source)))
  )

(defun write-all-ontology (dest)
  (write-ont-file (om::ling-ontology-lf-table om::*lf-ontology*) (format nil "~A/~A" dest "ontology.json"))
  (write-ont-file (om::ling-ontology-feature-table om::*lf-ontology*) (format nil "~A/~A" dest "featuretypes.json"))
  (write-ont-file (om::ling-ontology-feature-type-table om::*lf-ontology*) (format nil "~A/~A" dest "featurelists.json"))
  )
