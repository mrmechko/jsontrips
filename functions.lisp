(in-package :om)

(defstruct simplenode name parent children arguments wordnet)
(defstruct simple-argument role restrictions optionality implements)

(defun simplify-arguments (x)
  (map
    'list
    #'(lambda (arg)
	(make-simple-argument
	  :role (sem-argument-role arg)
	  :restrictions (best-lfs-from-sem (sem-argument-restriction arg))
	  :optionality (sem-argument-optionality arg)
	  :implements (sem-argument-implements arg)
	  )
	)
    x)
  )

(defun process-type (x) ; an ontology type
  (make-simplenode 
    :name (lf-description-name x)
    :parent (lf-description-parent x)
    :children (lf-description-children x)
    :arguments (simplify-arguments (lf-description-arguments x))
    :wordnet (lf-description-wordnet-sense-keys x)
   )
)

(defun get-all-onts (ont)
  (map 'list #'(lambda (x) (gethash x (ling-ontology-lf-table ont)))
  (remove-if-not
    (lambda (lf)
      (equal "ONT" (package-name (symbol-package lf)))
      )
    (get-all-keys (ling-ontology-lf-table ont))))
       )

(defun process-all (lf-ontology)
  (map 
    'list
    #'(lambda (val) (process-type val))
    (get-all-onts lf-ontology)
  )
)
  


