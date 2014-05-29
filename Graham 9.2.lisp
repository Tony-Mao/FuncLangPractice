(in-package #:cs325-user)

(defun make-change (money &optional (coins-lst '(25 10 5 1)))
  (values-list (make-change-lst money coins-lst)))

(defun make-change-lst (money coins-lst)
  (if (null coins-lst) 
      nil
    (multiple-value-bind (add remain) (floor money (car coins-lst))
      (cons add (make-change-lst remain (cdr coins-lst))))))

