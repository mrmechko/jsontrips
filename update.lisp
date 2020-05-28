;;;; make-mod-ont-json.lisp
;;;; load into running gloss system, call (send-define-msgs) to read define-type and define-words messages from files, send them into the system, and then call (write-json)
;;;; William de Beaumont
;;;; 2019-12-16

(load "test")
(run)

(dfc:defcomponent :xml :use (:util :common-lisp) :system (:depends-on (:util) :components nil))

(defvar *define-type-and-words-file* #!TRIPS"messages.kqml")

(defun send-define-msgs (msg args)
    (declare (ignore msg args))
  (with-open-file (f *define-type-and-words-file* :direction :input)
    (loop for dm = (read f nil nil)
	  while dm
	  do (send-msg dm))))
(defcomponent-handler '(request &key :content (send-define-msgs . *)) #'send-define-msgs :subscribe t)

(in-package :cl-user)

(defun send-define-msgs ()
  (comm::send 'test '(request :content (send-define-msgs))))

(defvar *out-dir* #!TRIPS"src;jsontrips;dist")
(defun write-json ()
  (format t "Writing ontology\n")
  (load #!TRIPS"src;jsontrips;lisp;genontology.lisp")
  (om::write-all-ontology *out-dir*)
  (format t "Writing lexicon\n")
  (load #!TRIPS"src;jsontrips;lisp;genlexicon.lisp")
  (lxm::write-all-lexicon *out-dir*)
  (format t "done!\n")
  )

(trips:process-run-function :xml #'dfc:run-component :xml)

(write-json)
