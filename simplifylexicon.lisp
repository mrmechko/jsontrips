(load "~/quicklisp/setup.lisp")
(ql:quickload :jonathan)
(ql:quickload :alexandria)


(load "../LexiconManager/lxm.lisp")


(in-package :lxm)

;; First, a function to extract information out of a vocabulary entry

(defparameter *simple-lexicon* (make-hash-table))

(defstruct simplevocab name word pos senses)
(defstruct weightedsense sense pref)

(defun process-entry (voc)
  ;; new plan. turn every vocabulary entry into a list of (word, pos, sense, pref)
  ;; and then dedup in py
  (make-simplevocab
    :name (vocabulary-entry-name voc)
    :word (vocabulary-entry-word voc)
    :pos (vocabulary-entry-pos voc)
    :senses (map
      'list
      #'(lambda (s)
          (make-weightedsense
            :sense (sense-definition-lf-parent s)
            :pref (sense-definition-pref s)
          )
        )
      (remove-if 
        #'(lambda (x) (sense-definition-nonhierarchy-lf x)) 
        (vocabulary-entry-senses voc)
      )
    )
  )
)

(defun process-word (word)
  (map
    'list
    #'(lambda (x) 
	(progn
	  (format t "X = ~S~%" x) 
	  (process-entry (car (last x)))
	)
      )
    (remove-if-not #'(lambda (x) x) (getworddefs word *lexicon-data*))
  )
)

(setf data (map
	     'list
	     #'process-word
	     (list-all-words *lexicon-data*)
))


;; define a JONATHAN serializer
(defmethod JONATHAN:%to-json ((s simplevocab))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::write-key-value "name" (simplevocab-name s))
    (JONATHAN::write-key-value "word" (simplevocab-word s))
    (JONATHAN::write-key-value "pos" (simplevocab-pos s))
    (JONATHAN::write-key-value "senses" (simplevocab-senses s))
))

(defmethod JONATHAN:%to-json ((s weightedsense))
  (JONATHAN::WITH-OBJECT
    (JONATHAN::write-key-value "sense" (weightedsense-sense s))
    (JONATHAN::write-key-value "pref" (weightedsense-pref s))
))


(with-open-file
  (str "lexicon.json"
       :direction :output
       :if-exists :supersede
       :if-does-not-exist :create)
  (format str (JONATHAN::to-json (alexandria::flatten data)))
)
