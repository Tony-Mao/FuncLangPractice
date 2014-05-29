(in-package #:cs325-user)

(defun horner (&rest lst)
  (reduce #'(lambda (x y) (+ (* (car lst) x) y)) (cdr lst)))