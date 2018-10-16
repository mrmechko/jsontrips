(load "~/quicklisp/setup.lisp")
(ql:quickload :jonathan)

(load "../OntologyManager/om.lisp")
(load "functions")

(in-package :om)



(defmethod JONATHAN::%to-json ((s simplenode))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::WRITE-KEY-VALUE "name" (simplenode-name s))
    (JONATHAN::WRITE-KEY-VALUE "parent" (simplenode-parent s))
    (JONATHAN::WRITE-KEY-VALUE "children" (simplenode-children s))
    (JONATHAN::WRITE-KEY-VALUE "wordnet" (simplenode-wordnet s))
    (JONATHAN::WRITE-KEY-VALUE "arguments" (simplenode-arguments s))
  )
)

(defmethod JONATHAN::%to-json ((a simple-argument))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::WRITE-KEY-VALUE "role" (simple-argument-role a))
    (JONATHAN::WRITE-KEY-VALUE "restrictions" (simple-argument-restrictions a))
    (JONATHAN::WRITE-KEY-VALUE "optionality" (simple-argument-optionality a))
    (JONATHAN::WRITE-KEY-VALUE "implements" (simple-argument-implements a))
  )
)

(setf processed (process-all *lf-ontology*))

(with-open-file 
  (str "data.json" 
    :direction :output 
    :if-exists :supersede 
    :if-does-not-exist :create) 
  (format str (JONATHAN::to-json om::processed))
)


