(in-package #:cs325-user)

(defmacro nth-expr (n &rest lst)
  (let ((i 0))
    `(case ,n ,@(mapcar #'(lambda (x) (list (incf i) x)) lst))))

(defmacro n-of (n &rest lst)
  (let  ((i (gensym))
         (olst (gensym))
         (end (gensym)))
    `(do ((,i 0 (1+ ,i))
          (,olst nil (cons ((lambda () ,@lst)) ,olst))
          (,end ,n))
         ((>= ,i ,end) (reverse ,olst)))))