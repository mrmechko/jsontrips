(load "~/quicklisp/setup.lisp")
(ql:quickload :jonathan)

(load "../OntologyManager/om.lisp")

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

;defstruct lf-description name sem arguments parent children wordnet-sense-keys comment

;defstruct sem-argument role restriction optionality implements

;defstruct featval-description feature-name value myimplied implied required parent,fname consistent-supertypes

;defstruct feature-description name root-value defaults values,mapcdr external

;defstruct feature-list type features defaults

;defstruct feature-type-description name features defaults


(defparameter onttypes (ling-ontology-lf-table *lf-ontology*))
(defparameter featuretypes (ling-ontology-feature-table *lf-ontology*))
(defparameter featurelists (ling-ontology-feature-type-table *lf-ontology*))

(defun write-ont-file (source destination)
  (with-open-file
    (str destination
       :direction :output
       :if-exists :supersede
       :if-does-not-exist :create)
    (format str (JONATHAN::to-json source)))
)

(write-ont-file onttypes "ontology.json")
(write-ont-file featuretypes "featuretypes.json")
(write-ont-file featurelists "featurelists.json")

