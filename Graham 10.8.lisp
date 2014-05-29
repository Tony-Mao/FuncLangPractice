(in-package #:cs325-user)

(defun doubleit (x) (* x 2))

(define-modify-macro doublef () doubleit)