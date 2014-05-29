(in-package #:cs325-user)

(defun solve (fn min max epsilon)
  (if (< (funcall fn min) 0)
      (solver fn min max epsilon)
    (solver fn max min epsilon)))

(defun solver (fn min max epsilon)
  (let ((i (/ (+ min max) 2)))
    (cond 
     ((< (abs (- max min)) epsilon) max)
     ((< (funcall fn i) 0) (solver fn i max epsilon))
     (t (solver fn min i epsilon)))))