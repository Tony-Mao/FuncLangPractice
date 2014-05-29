(in-package #:cs325-user)

(defun show-dots (lst)
  (cond 
   ((atom lst) (format t "~A" lst))
   (t (format t "(") (show-dots (car lst)) (format t " . ") (show-dots (cdr lst)) (format t ")"))))

(defun show-list (lst)
  (cond 
   ((atom lst) (format t "~A" lst))
   (t (format t "[") 
      (show-list (car lst)) 
      (do ((tlst (cdr lst) (cdr tlst)))
          ((atom tlst) (or (null tlst) (format t " . ") (format t "~A" tlst)))
      (format t " ") (show-list (car tlst)))
      (format t "]"))))