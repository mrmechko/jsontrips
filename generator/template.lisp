(load "~/quicklisp/setup.lisp")
(ql:quickload :jonathan)

(load "../OntologyManager/om.lisp")
(load "functions")

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
