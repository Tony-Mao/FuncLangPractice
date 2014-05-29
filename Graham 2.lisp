(in-package #:cs325-user)

(defun greater (x y)
  (if (> x y) x y))

(defun has-list-p (lst)
  (and (not (null lst)) (or (listp (car lst)) (has-list-p (cdr lst)))))


;; iterative method approved, except for changing variable from x to n
;; (defun print-dots (n)       
;;   (do ((i 0 (1+ i)))
;;       ((>= i n))
;;       (format t ".")))

(defun print-dots (n)
  (cond 
    ((<= n 0) t)
    (t (print-dots (1- n)) (format t "."))))

;; recursive approved, except for changing variable from x to lst
;; (defun get-a-count (lst)
;;   (cond 
;;     ((null lst) 0)
;;     ((eql 'a (car lst)) (1+ (get-a-count (cdr lst))))
;;     (t (get-a-count (cdr lst)))))

(defun get-a-count (lst)
  (do ((n 0 (cond 
              ((eql 'a (car nlst)) (incf n))
              (t n)))
       (nlst lst (cdr nlst)))
      ((null nlst) n)))

;; (remove nil lst) was not passed to apply. (remove ... is for returning
;; a list that with nil elements removed, this function will leave original
;; list untouched. (apply #'+ ... is for summing up number elements. The
;; original code did not pass nil elements removed list to sum-up function.

(defun summit (lst)
  (apply #'+ (remove nil lst))) 

;; No termination. There was no end-point for the recursion, the program
;; will keep truncating the list with function (cdr... Since there is no
;; sign telling program to stop, one will end up with (cdr '()), which 
;; will give an error. One can pass basic case (summi '()) as a test.

;; (defun summit (lst)
;;   (cond
;;     ((null lst) 0)
;;     (T (+ (or (car lst) 0) (summit (cdr lst))))))