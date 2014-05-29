(in-package #:cs325-user)

(defun diff-by-one-p (lst)
  (or (null (cdr lst))
    (and (= 1 (abs (- (car lst) (cadr lst)))) 
         (diff-by-one-p (cdr lst)))))

(defun diff-by-one-p (lst)
  (do ((tlst lst (cdr tlst)))
      ((or (null (cdr tlst))
           (not (= 1 (abs (- (car tlst) (cadr tlst))))))
       (null (cdr tlst)))))
    
(defun diff-by-one-p (lst) 
  (mapc #'(lambda (x y) 
            (or (= 1 (abs (- x y))) 
                (return-from diff-by-one-p nil))) 
                   lst (cdr lst))
  t)

(defun diff-by-one-p (lst)
  (every #'(lambda (x y) (= 1 (abs (- x y)))) lst (cdr lst)))