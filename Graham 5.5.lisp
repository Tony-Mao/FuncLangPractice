(in-package #:cs325-user)

;; iterative
(defun preceders (x v)
  (do* ((vec (coerce v 'simple-vector))
        (i (length vec) (1- i))
        (olst nil (if (eql (svref vec i) x)
                     (adjoin (svref vec (1- i)) olst)
                   olst)))
       ((<= i 1) olst)))

;; recurrsion
(defun preceders (x v &key (start 1) (end (length v)))
  (cond
  ((>= start end) nil)
  (t (let ((olst (preceders x v :start (1+ start) :end end)))
       (if (and (eql (aref v start) x)
                (not (member (aref v (1- start)) olst)))
           (cons (aref v (1- start)) olst)
         olst)))))