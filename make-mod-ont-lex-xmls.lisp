;;;; make-mod-ont-json.lisp
;;;; load into running gloss system, call (send-define-msgs) to read define-type and define-words messages from files, send them into the system, and then call (write-json)
;;;; William de Beaumont
;;;; 2019-12-16

(dfc:defcomponent :xml :use (:util :common-lisp) :system (:depends-on (:util) :components nil))

(defvar *define-type-and-words-file* #!TRIPS"logs;verb-synset-chunks;yan2-result.kqml")

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

(defun write-json ()
  (load "lisp/genontology.lisp")
  (load "lisp/genlexicon.lisp"))

(trips:process-run-function :xml #'dfc:run-component :xml)
