(in-package #:cs325-user)

;; iterative
(defun intersperse (insert lst)
  (if (null lst) nil
    (do ((l (reverse (cdr lst)) (cdr l))
         (olst nil (list* insert (car l) olst)))
         ((null l) (cons (car lst) olst)))))
   
;; recurrsion 
(defun intersperse (insert lst)
  (cond
   ((null lst) lst)
   ((null (cdr lst)) (list (car lst)))
   (t (list* (car lst) insert (intersperse insert (cdr lst))))))
