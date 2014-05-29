(in-package #:cs325-user)

(defun position+ (lst)
  (let ((olst (copy-list lst)))
  (do ((n 0 (1+ n)) (tlst olst (cdr tlst)))
       ((null tlst) olst)
       (incf (car tlst) n))))

(defun position+ (lst)
  (do ((n 0 (1+ n)) (tlst lst (cdr tlst)) (olst nil (cons (+ (car tlst) n) olst)))
      ((null tlst) (nreverse olst))))