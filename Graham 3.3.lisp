(in-package #:cs325-user)

(defun occurrences (lst)
  (let ((olst nil))
    (dolist (elt lst)
      (cond 
       ((assoc elt olst) (incf (cdr (assoc elt olst))))
       (t (push (cons elt 1) olst))))
    (sort olst #'> :key #'cdr)))

(defun occurrences (lst)
  (do ((tlst lst (cdr tlst)) (olst nil (let ((ts (assoc (car tlst) olst)))
                                         (cond 
                                          (ts (incf (cdr ts)) olst)
                                          (t (push (cons (car tlst) 1) olst))))))
      ((null tlst) (sort olst #'> :key #'cdr))))