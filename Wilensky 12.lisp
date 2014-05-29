(in-package #:cs325-user)

(defun make-balance (ini-balance)
  (lambda (&optional (x 0))
    (incf ini-balance x)))
